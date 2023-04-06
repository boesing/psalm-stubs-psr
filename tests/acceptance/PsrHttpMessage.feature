Feature: PSR-7 stub verification

  Background:
    Given I have the following config
    """
    <?xml version="1.0"?>
    <psalm errorLevel="1" findUnusedPsalmSuppress="true" findUnusedBaselineEntry="true" findUnusedCode="false">
      <projectFiles>
        <directory name="."/>
      </projectFiles>
      <plugins>
        <pluginClass class="Boesing\PsalmStubsPsr\Plugin"/>
      </plugins>
    </psalm>
    """
    And I have the following code preamble
    """
    <?php declare(strict_types=1);

    """

  Scenario: UriInterface methods are called from within immutable scope
    Given I have the following code
    """
      use Psr\Http\Message\UriInterface;

      /** @var UriInterface $uri */
      $uri = null;

      /** @psalm-immutable */
      final class Foo
      {
        public function bar(): void
        {
            /** @var UriInterface $uri */
            $uri = null;
            $uri = $uri->withHost('example.org');
        }
      }
    """
    When I run Psalm
    Then I see no errors

<?php

declare(strict_types=1);

namespace Boesing\PsalmStubsPsr;

use Composer\InstalledVersions;
use Psalm\Plugin\PluginEntryPointInterface;
use Psalm\Plugin\RegistrationInterface;
use SimpleXMLElement;

final class Plugin implements PluginEntryPointInterface
{
    public function __invoke(RegistrationInterface $registration, SimpleXMLElement|null $config = null): void
    {
        $this->registerPsrHttpMessageStubs($registration);
    }

    private function registerPsrHttpMessageStubs(RegistrationInterface $registration): void
    {
        if (! InstalledVersions::isInstalled('psr/http-message')) {
            return;
        }

        $registration->addStubFile(__DIR__ . '/../stubs/http-message/UriInterface.phpstub');
    }
}

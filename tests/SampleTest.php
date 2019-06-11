<?php

namespace Tests;

use MilesChou\Skeleton\Sample;
use PHPUnit\Framework\TestCase;

class SampleTest extends TestCase
{
    public function testSample()
    {
        $this->assertInstanceOf(Sample::class, new Sample());
    }
}

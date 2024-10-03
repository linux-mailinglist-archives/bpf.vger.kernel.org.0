Return-Path: <bpf+bounces-40811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00B598E948
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 07:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44726B24E0E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAB23D551;
	Thu,  3 Oct 2024 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srdEkmst"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0A3AC2B
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932200; cv=none; b=b6ba0ZQXiL4LNKEkTY94vgfOhXotDIQ/RZEhDCXRLNUp+xvGQWeiPolbq2SSUJ4yd/R/XinVDv8r5j0T2Uz2LYp9opRMMKli/UhrEib0g/NT4P87Fb92KIeV05FgudoRlr2SrTf2wNDGW24bc5YusL9TYriVapM4kWzE+JLj1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932200; c=relaxed/simple;
	bh=qrbLRk/FSxnCiu6axn74hXEdJnOeoT94Cx/ecRppH2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ueu5BC07RXT+lGyvKQ6WlMgW57HmO+el4EAJKDXreYdpsSfDUqumKlpUvy/7v6StwYCgipAAUGIrCf8aui7u0BYpTPQ/X3q3lFE96PtBVJlWhVy9M1wsDWpyAAJF5JvFN7h1cVTqlueHsPBHrOShke0aDOyld8beB8P3h8CO35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srdEkmst; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84e9893c457so192783241.2
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727932198; x=1728536998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywgtKyqh0N3Dye97MVd0kIqtuLbIpst9nSCmWrn174Q=;
        b=srdEkmst7swwBdms08hYXlb+laEPRhwbNdaFf7sR9baZTAPoGKHlkCL7SbUu0RORx7
         QeCd7HahCBHsuTr4h3bsSTxJCts16nSCQraL721HB65Xj01hnf3MSahjd/WjPKF3shRx
         9r7WUzj6c4d8qLZ8ERjnm3+PzWUrIu8R0D2A2F++cyf47SSYSbE9/Th7bFgEOPMN7r3S
         4KxQ7HrEAvHRP4ZoULO8iBje7zTzFiJ0K/SeMPBCQlsiMdj8KLWgKLs+maPUywJyYujK
         +Q3Ard52Bq3E/uKDObmDkUNNZyiVK6QFjaa4fee1GjsvbXQSGLrF4LdHwwkfsPzmJqHc
         u+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932198; x=1728536998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywgtKyqh0N3Dye97MVd0kIqtuLbIpst9nSCmWrn174Q=;
        b=rMeJ5xdVKWojw49UEynxbiGKUG6S+nrRtB5kNzzNQEzorUUQh6Sk1ROzh2K9yHRL+K
         SHUsO9Do64LcM8mYVWGk+LB7j9S8gA0jHI7LAU4TPCKgKl38/wro1N4K89IHc88dGhuS
         kKojQsgq/zdzDwDqDCJ5MuLoy+6+/6ZgI5ji9Es2pTNWE77n7M128pj4KXvB5/W5fVjb
         SpnKzCr1ulI7Xe/90WBbuxVtnGLbd3LuWXkb9XrvKLqsF8Uwdnp7xlzUU2sXx1Qdf3UT
         Gw/OxTLP+QRCzCiTA3z5DefKVStyHr0zNyJjoUxux0s0BnfUy6Fk3yAEIZoJDxNuuG/z
         SUfg==
X-Forwarded-Encrypted: i=1; AJvYcCWobPSF6fU4vf1ooooOsxBi5dcaQkvKCmCN6XwispJlXiTR9exrMRt9gNkhc3IcBf7GKCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+K5qrqO/fSyNsZdClNxyVsKpQtrHFjcK+FkQ4SCxQ4xBCNL4b
	jnFAN+axsPLetUmI9o4vBDQKN3sCjdZ7W2DY8YHAsNjTKKrjVU6uk5HsZQSCgQiYrTigBwHpu1q
	/CvZ8jmvuTFjeB8P0IYY2JniqzYY393iFCxWlGA==
X-Google-Smtp-Source: AGHT+IE9u2+/8nC7XjQNdK9e4FXcoT1LUX+A/NRgmnjoZdPr9xDcH7NfQFwxfX9f507kLSYP5FbG/rzvoA7a+mzNSY0=
X-Received: by 2002:a05:6122:794:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-50c582122a0mr4539080e0c.10.1727932197603; Wed, 02 Oct 2024
 22:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125751.964700919@linuxfoundation.org>
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Oct 2024 10:39:45 +0530
Message-ID: <CA+G9fYtcs_bFp_N+Q59Nn_bM2AT0Xm4utdh6vT+Cdvj6D=VP+w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/538] 6.6.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 19:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 538 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


As other reported selftests bpf build failed,

libbpf.c: In function 'bpf_object__create_map':
libbpf.c:5215:50: error: 'BPF_F_VTYPE_BTF_OBJ_FD' undeclared (first
use in this function)
 5215 |                         create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
      |                                                  ^~~~~~~~~~~~~~~~~~~~~~
libbpf.c:5215:50: note: each undeclared identifier is reported only
once for each function it appears in

due to commit,
  9e926acda0c2e libbpf: Find correct module BTFs for struct_ops maps and progs.

Build log:
-------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2msz2dGbiCYZjR2hPFlN5xFUOhX/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.54-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 1bbd78667e8e467cac0a2bc31d183b9d9983f448
* git describe: v6.6.53-539-g1bbd78667e8e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.53-539-g1bbd78667e8e

## Test Regressions (compared to v6.6.51-145-g3ecfbb62e37a)

## Metric Regressions (compared to v6.6.51-145-g3ecfbb62e37a)

## Test Fixes (compared to v6.6.51-145-g3ecfbb62e37a)

## Metric Fixes (compared to v6.6.51-145-g3ecfbb62e37a)

## Test result summary
total: 170988, pass: 150287, fail: 1587, skip: 18917, xfail: 197

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


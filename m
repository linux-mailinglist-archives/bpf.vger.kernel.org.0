Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976352770AE
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgIXMGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgIXMGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:06:51 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0AC0613CE;
        Thu, 24 Sep 2020 05:06:51 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so2958533iol.10;
        Thu, 24 Sep 2020 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czjx6uCVHJbE30rsl5ybjWpjkXo3ycs6ILmTpqDQhks=;
        b=legzRaCyxrXo9JYiAUGZBSyAUE1HC4S2PLFUGZxKLkddVqDzJB+dMyo+zTphVOx0rf
         jrAf64kSObVsUl3zfZiDNf0TdaTGhLV/Lm7rOnNk3EUWebxVV1zK8gIGA1ToCHkCyHpT
         9hIbY27tazc8peXV5PsXo2AmbqOucZ1Cn5a1AQ2uWDpifoQ5KwaEDbfFAwSNMxuS+P+A
         xoB6jjac+jsnD0Xied9pxgn3znzaqDo3MIl6SQWemCdoL/Fm+VD0vMTmCEGmSCYRWkHA
         QUb12sA1/NuJwQi+Z+w+ZnPUZL+n6WjmkCSSk77LgDXMOBosDRNvgFREweFrkOsaD3aR
         vtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czjx6uCVHJbE30rsl5ybjWpjkXo3ycs6ILmTpqDQhks=;
        b=TjWB11crm5exqRfEMECfu/UO0kOB0+cbLR70gZZrisHfX2Bf4BYyDrgLkkBP4LWeUn
         KcABzPFH35bfWyhCElwJMej587CNuAFaUzrqUXFFTsUbspTg+LU4coPNoUpHlKvxAdfn
         WqQDXQ4vV281533E2SP14tzE5/PrJL6ibJb8a8i1FLYVGN5UfnsyfXKnl34KB7hn0bpx
         rjfM0itpxrmaNUtAWmZy95Vb52qdq5UMVGr9YVJ5mi2k73hQMiIqrejAZ7uiBi+Xc7YR
         vVxo47Gg/DB08uBEpUA23IoDbQQ+J8IfKempYUhDRj96w0YEd9PNYzScBp2zaWaLQz4P
         kRPQ==
X-Gm-Message-State: AOAM531rR5ye0DYXWeyIuw6ZDhmwD0E82xPRnndyU/6s7YsRsSuZhB1K
        74gW9pMLqLArJh63D3SjXAM=
X-Google-Smtp-Source: ABdhPJzGbZE46AmsMLsslmC7CgBzYpWTSbOnbBVZM2z6uTF28dj4+C/7zyymAueopV6rMS5KD/+WsQ==
X-Received: by 2002:a05:6602:27d2:: with SMTP id l18mr3088110ios.34.1600949210300;
        Thu, 24 Sep 2020 05:06:50 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id a23sm1259435ioc.54.2020.09.24.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:06:49 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH seccomp 0/6] seccomp: Add bitmap cache of arg-independent filter results that allow syscalls
Date:   Thu, 24 Sep 2020 07:06:40 -0500
Message-Id: <cover.1600946701.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600661418.git.yifeifz2@illinois.edu>
References: <cover.1600661418.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

Alternative: https://lore.kernel.org/lkml/20200923232923.3142503-1-keescook@chromium.org/T/

Major differences from the linked alternative by Kees:
* No x32 special-case handling -- not worth the complexity
* No caching of denylist -- not worth the complexity
* No seccomp arch pinning -- I think this is an independent feature
* The bitmaps are part of the filters rather than the task.
* Architectures supported by default through arch number array,
  except for MIPS with its sparse syscall numbers.
* Configurable per-build for future different cache modes.

This series adds a bitmap to cache seccomp filter results if the
result permits a syscall and is indepenent of syscall arguments.
This visibly decreases seccomp overhead for most common seccomp
filters with very little memory footprint.

The overhead of running Seccomp filters has been part of some past
discussions [1][2][3]. Oftentimes, the filters have a large number
of instructions that check syscall numbers one by one and jump based
on that. Some users chain BPF filters which further enlarge the
overhead. A recent work [6] comprehensively measures the Seccomp
overhead and shows that the overhead is non-negligible and has a
non-trivial impact on application performance.

We observed some common filters, such as docker's [4] or
systemd's [5], will make most decisions based only on the syscall
numbers, and as past discussions considered, a bitmap where each bit
represents a syscall makes most sense for these filters.

In order to build this bitmap at filter attach time, each filter is
emulated for every syscall (under each possible architecture), and
checked for any accesses of struct seccomp_data that are not the "arch"
nor "nr" (syscall) members. If only "arch" and "nr" are examined, and
the program returns allow, then we can be sure that the filter must
return allow independent from syscall arguments.

When it is concluded that an allow must occur for the given
architecture and syscall pair, seccomp will immediately allow
the syscall, bypassing further BPF execution.

Ongoing work is to further support arguments with fast hash table
lookups. We are investigating the performance of doing so [6], and how
to best integrate with the existing seccomp infrastructure.

Some benchmarks are performed with results in patch 5, copied below:
  Current BPF sysctl settings:
  net.core.bpf_jit_enable = 1
  net.core.bpf_jit_harden = 0
  Benchmarking 100000000 syscalls...
  63.896255358 - 0.008504529 = 63887750829 (63.9s)
  getpid native: 638 ns
  130.383312423 - 63.897315189 = 66485997234 (66.5s)
  getpid RET_ALLOW 1 filter (bitmap): 664 ns
  196.789080421 - 130.384414983 = 66404665438 (66.4s)
  getpid RET_ALLOW 2 filters (bitmap): 664 ns
  268.844643304 - 196.790234168 = 72054409136 (72.1s)
  getpid RET_ALLOW 3 filters (full): 720 ns
  342.627472515 - 268.845799103 = 73781673412 (73.8s)
  getpid RET_ALLOW 4 filters (full): 737 ns
  Estimated total seccomp overhead for 1 bitmapped filter: 26 ns
  Estimated total seccomp overhead for 2 bitmapped filters: 26 ns
  Estimated total seccomp overhead for 3 full filters: 82 ns
  Estimated total seccomp overhead for 4 full filters: 99 ns
  Estimated seccomp entry overhead: 26 ns
  Estimated seccomp per-filter overhead (last 2 diff): 17 ns
  Estimated seccomp per-filter overhead (filters / 4): 18 ns
  Expectations:
  	native ≤ 1 bitmap (638 ≤ 664): ✔️
  	native ≤ 1 filter (638 ≤ 720): ✔️
  	per-filter (last 2 diff) ≈ per-filter (filters / 4) (17 ≈ 18): ✔️
  	1 bitmapped ≈ 2 bitmapped (26 ≈ 26): ✔️
  	entry ≈ 1 bitmapped (26 ≈ 26): ✔️
  	entry ≈ 2 bitmapped (26 ≈ 26): ✔️
  	native + entry + (per filter * 4) ≈ 4 filters total (732 ≈ 737): ✔️

RFC -> v1:
* Config made on by default across all arches that could support it.
* Added arch numbers array and emulate filter for each arch number, and
  have a per-arch bitmap.
* Massively simplified the emulator so it would only support the common
  instructions in Kees's list.
* Fixed inheriting bitmap across filters (filter->prev is always NULL
  during prepare).
* Stole the selftest from Kees.
* Added a /proc/pid/seccomp_cache by Jann's suggestion.

Patch 1 moves the SECCOMP Kcomfig option to arch/Kconfig.

Patch 2 adds a syscall_arches array so the emulator can enumerate it.

Patch 3 implements the emulator that finds if a filter must return allow,

Patch 4 implements the test_bit against the bitmaps.

Patch 5 updates the selftest to better show the new semantics.

Patch 6 implements /proc/pid/seccomp_cache.

[1] https://lore.kernel.org/linux-security-module/c22a6c3cefc2412cad00ae14c1371711@huawei.com/T/
[2] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/T/
[3] https://github.com/seccomp/libseccomp/issues/116
[4] https://github.com/moby/moby/blob/ae0ef82b90356ac613f329a8ef5ee42ca923417d/profiles/seccomp/default.json
[5] https://github.com/systemd/systemd/blob/6743a1caf4037f03dc51a1277855018e4ab61957/src/shared/seccomp-util.c#L270
[6] Draco: Architectural and Operating System Support for System Call Security
    https://tianyin.github.io/pub/draco.pdf, MICRO-53, Oct. 2020

Kees Cook (1):
  selftests/seccomp: Compare bitmap vs filter overhead

YiFei Zhu (5):
  seccomp: Move config option SECCOMP to arch/Kconfig
  asm/syscall.h: Add syscall_arches[] array
  seccomp/cache: Add "emulator" to check if filter is arg-dependent
  seccomp/cache: Lookup syscall allowlist for fast path
  seccomp/cache: Report cache data through /proc/pid/seccomp_cache

 arch/Kconfig                                  |  56 ++++
 arch/alpha/include/asm/syscall.h              |   4 +
 arch/arc/include/asm/syscall.h                |  24 +-
 arch/arm/Kconfig                              |  15 +-
 arch/arm/include/asm/syscall.h                |   4 +
 arch/arm64/Kconfig                            |  13 -
 arch/arm64/include/asm/syscall.h              |   4 +
 arch/c6x/include/asm/syscall.h                |  13 +-
 arch/csky/Kconfig                             |  13 -
 arch/csky/include/asm/syscall.h               |   4 +
 arch/h8300/include/asm/syscall.h              |   4 +
 arch/hexagon/include/asm/syscall.h            |   4 +
 arch/ia64/include/asm/syscall.h               |   4 +
 arch/m68k/include/asm/syscall.h               |   4 +
 arch/microblaze/Kconfig                       |  18 +-
 arch/microblaze/include/asm/syscall.h         |   4 +
 arch/mips/Kconfig                             |  17 --
 arch/mips/include/asm/syscall.h               |  16 ++
 arch/nds32/include/asm/syscall.h              |  13 +-
 arch/nios2/include/asm/syscall.h              |   4 +
 arch/openrisc/include/asm/syscall.h           |   4 +
 arch/parisc/Kconfig                           |  16 --
 arch/parisc/include/asm/syscall.h             |   7 +
 arch/powerpc/Kconfig                          |  17 --
 arch/powerpc/include/asm/syscall.h            |  14 +
 arch/riscv/Kconfig                            |  13 -
 arch/riscv/include/asm/syscall.h              |  14 +-
 arch/s390/Kconfig                             |  17 --
 arch/s390/include/asm/syscall.h               |   7 +
 arch/sh/Kconfig                               |  16 --
 arch/sh/include/asm/syscall_32.h              |  17 +-
 arch/sparc/Kconfig                            |  18 +-
 arch/sparc/include/asm/syscall.h              |   9 +
 arch/um/Kconfig                               |  16 --
 arch/x86/Kconfig                              |  16 --
 arch/x86/include/asm/syscall.h                |  11 +
 arch/x86/um/asm/syscall.h                     |  14 +-
 arch/xtensa/Kconfig                           |  14 -
 arch/xtensa/include/asm/syscall.h             |   4 +
 fs/proc/base.c                                |   7 +-
 include/linux/seccomp.h                       |   5 +
 kernel/seccomp.c                              | 259 +++++++++++++++++-
 .../selftests/seccomp/seccomp_benchmark.c     | 151 ++++++++--
 tools/testing/selftests/seccomp/settings      |   2 +-
 44 files changed, 641 insertions(+), 265 deletions(-)

--
2.28.0

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F0288FDE
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgJIRPe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIRPd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:15:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD0C0613D2;
        Fri,  9 Oct 2020 10:15:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l8so10773864ioh.11;
        Fri, 09 Oct 2020 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DSzKFQyIGkLRDNtQRU/+XGhb6HlrkIFTlbsT43gE+E=;
        b=n9EpXLYh51REqYG2eHxFT+6kB8V9Ffe0Aj9y4HVk27tY1D1ryMcTjheKu2+izADH5k
         rBCccrc1RsKFeRfK9Ap0ptYWCj1mdsMs0o0S81AqyDZ54ktwVXvtFmxptT7WreJHT1LX
         KSwAegVzp6UGdhGYMOvmMFn6hG6/p/sYMEH7i2bmFiX1XM/rH9V8OVcysL7MmeNV4EMG
         UM0b10motNn8QaDjlZJtiPlTlsunLrGEqdKVvp0Nx2WRtubc5rdZ0KhOy3dPkR9ZOmC6
         iA7im0zrUgfk1EdQUkU6UnBNncixYKm9V43YNm+NaK610PC8B2QD1AZEUtzcBgh1OaJv
         PoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DSzKFQyIGkLRDNtQRU/+XGhb6HlrkIFTlbsT43gE+E=;
        b=mxPd4esZic6tQtiIeTopET2riL44cc722PXRuoGG0dTw9C+gtFF+JqxqWTufKZc125
         csO3H5hUntZOEB1tn+2zESvV2y1verQPP7gziwzGezKLRN7YOw5olIY+T0iIysBnmk8w
         dFICap2hX/l+vavurcBtZ+wy2CPaHdH3mOMCzaxWzOFiaslurtpIR6UXmHCKBCJQUPTX
         uENRxdM2NiG0QhDIsebQnuab1dLbPfXgHss4hwiGnWxcpULUttOyU6qNgpIr6hnfsO3h
         azDgsB5vrtED00/Hs5HPiwPtrq4g8xTYQ2gf5QKwlDwTxT3XJQdlI7YIQT8qrPCIjUfH
         GXig==
X-Gm-Message-State: AOAM533xF24nMN1CYGp9krhAEkOzcnbBBkJ0hWe0q2kG1U9xCqicNyzV
        HZm/rSBujSS6LGsEA94c+bw=
X-Google-Smtp-Source: ABdhPJzLmYodyi85uA+fGW6zhiayvIc8oLVOb1o2swapJL3PCuXUcgm9ZleslA61yoft/YbR/+vWHg==
X-Received: by 2002:a5d:8752:: with SMTP id k18mr10187955iol.27.1602263732894;
        Fri, 09 Oct 2020 10:15:32 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id c2sm3762830iot.52.2020.10.09.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:15:32 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
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
Subject: [PATCH v4 seccomp 0/5] seccomp: Add bitmap cache of constant allow filter results
Date:   Fri,  9 Oct 2020 12:14:28 -0500
Message-Id: <cover.1602263422.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601478774.git.yifeifz2@illinois.edu>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
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
  Benchmarking 200000000 syscalls...
  129.359381409 - 0.008724424 = 129350656985 (129.4s)
  getpid native: 646 ns
  264.385890006 - 129.360453229 = 135025436777 (135.0s)
  getpid RET_ALLOW 1 filter (bitmap): 675 ns
  399.400511893 - 264.387045901 = 135013465992 (135.0s)
  getpid RET_ALLOW 2 filters (bitmap): 675 ns
  545.872866260 - 399.401718327 = 146471147933 (146.5s)
  getpid RET_ALLOW 3 filters (full): 732 ns
  696.337101319 - 545.874097681 = 150463003638 (150.5s)
  getpid RET_ALLOW 4 filters (full): 752 ns
  Estimated total seccomp overhead for 1 bitmapped filter: 29 ns
  Estimated total seccomp overhead for 2 bitmapped filters: 29 ns
  Estimated total seccomp overhead for 3 full filters: 86 ns
  Estimated total seccomp overhead for 4 full filters: 106 ns
  Estimated seccomp entry overhead: 29 ns
  Estimated seccomp per-filter overhead (last 2 diff): 20 ns
  Estimated seccomp per-filter overhead (filters / 4): 19 ns
  Expectations:
  	native ≤ 1 bitmap (646 ≤ 675): ✔️
  	native ≤ 1 filter (646 ≤ 732): ✔️
  	per-filter (last 2 diff) ≈ per-filter (filters / 4) (20 ≈ 19): ✔️
  	1 bitmapped ≈ 2 bitmapped (29 ≈ 29): ✔️
  	entry ≈ 1 bitmapped (29 ≈ 29): ✔️
  	entry ≈ 2 bitmapped (29 ≈ 29): ✔️
  	native + entry + (per filter * 4) ≈ 4 filters total (755 ≈ 752): ✔️

v3 -> v4:
* Reordered patches
* Naming changes
* Fixed racing in /proc/pid/seccomp_cache against filter being released
  from task, using Jann's suggestion of sighand spinlock.
* Cache no longer configurable.
* Copied some description from cover letter to commit messages.
* Used Kees's logic to set clear bits from bitmap, rather than set bits.

v2 -> v3:
* Added array_index_nospec guards
* No more syscall_arches[] array and expecting on loop unrolling. Arches
  are configured with per-arch seccomp.h.
* Moved filter emulation to attach time (from prepare time).
* Further simplified emulator, basing on Kees's code.
* Guard /proc/pid/seccomp_cache with CAP_SYS_ADMIN.

v1 -> v2:
* Corrected one outdated function documentation.

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

Patch 1 implements the test_bit against the bitmaps.

Patch 2 implements the emulator that finds if a filter must return allow,

Patch 3 adds the arch macros for x86.

Patch 4 updates the selftest to better show the new semantics.

Patch 5 implements /proc/pid/seccomp_cache.

[1] https://lore.kernel.org/linux-security-module/c22a6c3cefc2412cad00ae14c1371711@huawei.com/T/
[2] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/T/
[3] https://github.com/seccomp/libseccomp/issues/116
[4] https://github.com/moby/moby/blob/ae0ef82b90356ac613f329a8ef5ee42ca923417d/profiles/seccomp/default.json
[5] https://github.com/systemd/systemd/blob/6743a1caf4037f03dc51a1277855018e4ab61957/src/shared/seccomp-util.c#L270
[6] Draco: Architectural and Operating System Support for System Call Security
    https://tianyin.github.io/pub/draco.pdf, MICRO-53, Oct. 2020

Kees Cook (2):
  x86: Enable seccomp architecture tracking
  selftests/seccomp: Compare bitmap vs filter overhead

YiFei Zhu (3):
  seccomp/cache: Lookup syscall allowlist bitmap for fast path
  seccomp/cache: Add "emulator" to check if filter is constant allow
  seccomp/cache: Report cache data through /proc/pid/seccomp_cache

 arch/Kconfig                                  |  24 ++
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/seccomp.h                |  15 +
 fs/proc/base.c                                |   6 +
 include/linux/seccomp.h                       |   5 +
 kernel/seccomp.c                              | 289 +++++++++++++++++-
 .../selftests/seccomp/seccomp_benchmark.c     | 151 +++++++--
 tools/testing/selftests/seccomp/settings      |   2 +-
 8 files changed, 469 insertions(+), 24 deletions(-)

--
2.28.0

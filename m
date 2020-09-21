Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49CE271A82
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIUFtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 01:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUFtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 01:49:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFDC0613CE
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2020 22:49:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so15915246ejo.9
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2020 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCFBIBp+UzGhh0P06FwKYlU4wIlXEgMAjBgKj46lnPc=;
        b=aLYpWU6AwkxUpGq5qTNkzgdguWMKeg5GHDh1DUDyjD4iIi7Ay3LBnP47kDcPPW95iO
         GW/Sr00+7toNzz+QvuZ+XqXW9ABVOXdTCaPt0UODUU9l56kM+UoRE8irGKnZOBls04DA
         5AoETtUcmeViNwKc0+SWOAGq0nfn5uC8w/4bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCFBIBp+UzGhh0P06FwKYlU4wIlXEgMAjBgKj46lnPc=;
        b=fKBtEcE5VgGlxC7soVOob9Py2wOYnM4yIdoHJ3UYiyC01rFSB7Ymvpyc2USfUGWhWm
         amRSEYqwpU4qoe+sSJ6OtA/AiAJECkc06LyUXD8/3aN97phxedOYEiyYybLwvdzPEaq7
         2XGKokRI/uuqpx8wJY3GW2u4o94OVbK7lql9vyMPpW/7434Qr1ULgIrv7eiM5mBWWm6k
         njGXiu+gZpf7GQL4vAozXMqvY2jZ4wNkZOxy715861T+VNhNKVSTvtCrADnGAxQZpI75
         6nRFO5uZj/AMyA9n4m0VeC3T5HaDrTpZZMuCmTapSXnk274NxQRvwlVWwIeMdYA8ytRs
         ka6w==
X-Gm-Message-State: AOAM530LtSv2+X5jVEz6ENXjnI/oc6C0pZOuUMHECLPF9IDBPJrqH4c5
        AipERVjRgb/Ug5EuEXtu8WZ3vv7U5V+zMrzf3wwzdQ==
X-Google-Smtp-Source: ABdhPJxYE+P0qxAZFG6TBU0cMcNSHP/jo99wnMcRj5JaPg3xchZPIp4HrRW6A3LyBnWk1h8UIP2Ia/2QeQX9WUFP6Mo=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr47593670ejq.138.1600667352652;
 Sun, 20 Sep 2020 22:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu>
In-Reply-To: <cover.1600661418.git.yifeifz2@illinois.edu>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 20 Sep 2020 22:48:36 -0700
Message-ID: <CAMp4zn8FPAdDubD=LGmydQvv2PJCeRB-TAeaU92ab4fJAjLnfQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>, bpf@vger.kernel.org,
        Tianyin Xu <tyxu@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 20, 2020 at 10:35 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> This series adds a bitmap to cache seccomp filter results if the
> result permits a syscall and is indepenent of syscall arguments.
> This visibly decreases seccomp overhead for most common seccomp
> filters with very little memory footprint.
>
> The overhead of running Seccomp filters has been part of some past
> discussions [1][2][3]. Oftentimes, the filters have a large number
> of instructions that check syscall numbers one by one and jump based
> on that. Some users chain BPF filters which further enlarge the
> overhead. A recent work [6] comprehensively measures the Seccomp
> overhead and shows that the overhead is non-negligible and has a
> non-trivial impact on application performance.
>
> We propose SECCOMP_CACHE, a cache-based solution to minimize the
> Seccomp overhead. The basic idea is to cache the result of each
> syscall check to save the subsequent overhead of executing the
> filters. This is feasible, because the check in Seccomp is stateless.
> The checking results of the same syscall ID and argument remains
> the same.
>
> We observed some common filters, such as docker's [4] or
> systemd's [5], will make most decisions based only on the syscall
> numbers, and as past discussions considered, a bitmap where each bit
> represents a syscall makes most sense for these filters.
>
> In the past Kees proposed [2] to have an "add this syscall to the
> reject bitmask". It is indeed much easier to securely make a reject
> accelerator to pre-filter syscalls before passing to the BPF
> filters, considering it could only strengthen the security provided
> by the filter. However, ultimately, filter rejections are an
> exceptional / rare case. Here, instead of accelerating what is
> rejected, we accelerate what is allowed. In order not to compromise
> the security rules the BPF filters defined, any accept-side
> accelerator must complement the BPF filters rather than replacing them.
>
> Statically analyzing BPF bytecode to see if each syscall is going to
> always land in allow or reject is more of a rabbit hole, especially
> there is no current in-kernel infrastructure to enumerate all the
> possible architecture numbers for a given machine. So rather than
> doing that, we propose to cache the results after the BPF filters are
> run. And since there are filters like docker's who will check
> arguments of some syscalls, but not all or none of the syscalls, when
> a filter is loaded we analyze it to find whether each syscall is
> cacheable (does not access syscall argument or instruction pointer) by
> following its control flow graph, and store the result for each filter
> in a bitmap. Changes to architecture number or the filter are expected
> to be rare and simply cause the cache to be cleared. This solution
> shall be fully transparent to userspace.
Long-term, do you believe static analysis will be viable? I think that it is
the "ideal" solution here, but I agree in that it is more complex.

Is there a way to "prime" filters, by giving them a syscall #, and if it has
a terminal condition without inspecting args, it turns into a bitmask entry
viable?

>
> Ongoing work is to further support arguments with fast hash table
> lookups. We are investigating the performance of doing so [6], and how
> to best integrate with the existing seccomp infrastructure.
>
> We have done some benchmarks with patch applied against bpf-next
> commit 2e80be60c465 ("libbpf: Fix compilation warnings for 64-bit printf args").
>
> Me, in qemu-kvm x86_64 VM, on Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz,
> average results:
>
> Without cache, seccomp_benchmark:
>   Current BPF sysctl settings:
>   net.core.bpf_jit_enable = 1
>   net.core.bpf_jit_harden = 0
>   Calibrating sample size for 15 seconds worth of syscalls ...
>   Benchmarking 23486415 syscalls...
>   16.079642020 - 1.013345439 = 15066296581 (15.1s)
>   getpid native: 641 ns
>   32.080237410 - 16.080763500 = 15999473910 (16.0s)
>   getpid RET_ALLOW 1 filter: 681 ns
>   48.609461618 - 32.081296173 = 16528165445 (16.5s)
>   getpid RET_ALLOW 2 filters: 703 ns
>   Estimated total seccomp overhead for 1 filter: 40 ns
>   Estimated total seccomp overhead for 2 filters: 62 ns
>   Estimated seccomp per-filter overhead: 22 ns
>   Estimated seccomp entry overhead: 18 ns
>
> With cache:
>   Current BPF sysctl settings:
>   net.core.bpf_jit_enable = 1
>   net.core.bpf_jit_harden = 0
>   Calibrating sample size for 15 seconds worth of syscalls ...
>   Benchmarking 23486415 syscalls...
>   16.059512499 - 1.014108434 = 15045404065 (15.0s)
>   getpid native: 640 ns
>   31.651075934 - 16.060637323 = 15590438611 (15.6s)
>   getpid RET_ALLOW 1 filter: 663 ns
>   47.367316169 - 31.652302661 = 15715013508 (15.7s)
>   getpid RET_ALLOW 2 filters: 669 ns
>   Estimated total seccomp overhead for 1 filter: 23 ns
>   Estimated total seccomp overhead for 2 filters: 29 ns
>   Estimated seccomp per-filter overhead: 6 ns
>   Estimated seccomp entry overhead: 17 ns
>
> Depending on the run estimated seccomp overhead for 2 filters can be
> less than seccomp overhead for 1 filter, resulting in underflow to
> estimated seccomp per-filter overhead:
>   Estimated total seccomp overhead for 1 filter: 27 ns
>   Estimated total seccomp overhead for 2 filters: 21 ns
>   Estimated seccomp per-filter overhead: 18446744073709551610 ns
>   Estimated seccomp entry overhead: 33 ns
>
> Jack Chen has also run some benchmarks on a bare metal
> Intel(R) Xeon(R) CPU E3-1240 v3 @ 3.40GHz, with side channel
> mitigations off (spec_store_bypass_disable=off spectre_v2=off mds=off
> pti=off l1tf=off), with BPF JIT on and docker default profile,
> and reported:
>
>   unixbench syscall mix (https://github.com/kdlucas/byte-unixbench)
>   unconfined:      33295685
>   docker default:         20661056  60%
>   docker default + cache: 25719937  30%
>
> Patch 1 introduces the static analyzer to check for a given filter,
> whether the CFG loads the syscall arguments for each syscall number.
>
> Patch 2 implements the bitmap cache.
>
> [1] https://lore.kernel.org/linux-security-module/c22a6c3cefc2412cad00ae14c1371711@huawei.com/T/
> [2] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/T/
> [3] https://github.com/seccomp/libseccomp/issues/116
> [4] https://github.com/moby/moby/blob/ae0ef82b90356ac613f329a8ef5ee42ca923417d/profiles/seccomp/default.json
> [5] https://github.com/systemd/systemd/blob/6743a1caf4037f03dc51a1277855018e4ab61957/src/shared/seccomp-util.c#L270
> [6] Draco: Architectural and Operating System Support for System Call Security
>     https://tianyin.github.io/pub/draco.pdf, MICRO-53, Oct. 2020
>
> YiFei Zhu (2):
>   seccomp/cache: Add "emulator" to check if filter is arg-dependent
>   seccomp/cache: Cache filter results that allow syscalls
>
>  arch/x86/Kconfig        |  27 +++
>  include/linux/seccomp.h |  22 +++
>  kernel/seccomp.c        | 400 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 446 insertions(+), 3 deletions(-)
>
> --
> 2.28.0
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers

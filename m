Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21127329D
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIUTQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgIUTQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 15:16:33 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705FFC0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 12:16:33 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g16so4698433uan.5
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCDaY+bkm/0dH12hWKBLXs8sFNuKqvKh9NzTaSkJTSw=;
        b=tewFT15AsEzpuKyvlpTu5R3peD/3EkklLECjakR0tkxwO97yjiKdU4IH4tHN3hhyD3
         8El1/BBXDcgFynjD5Kh8iAEB+581gGhRIWK6+0fU9rr/PSBeEehjECcdkFZ+PIDmLLYl
         rEsk22wPgoyg7d/rLBTu5OZbJ+83zzMdRdOkhV5mdx6yiZ6RDpgvtKkDbn27HzYH4KX6
         WHeM7BWTRstoznGogcI9Q3044Bc3qApw7s01eS9aSlWrxMQbYQvx7kZA3i3rBQVc7Gzd
         Mb9X9iaZrpufnlQbS5KEFq1UjzhfD9zw9kXXRe9/6Pl6JUGHl0QpX6fnPrFE3jRHwtNl
         0cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCDaY+bkm/0dH12hWKBLXs8sFNuKqvKh9NzTaSkJTSw=;
        b=U9ElzXSGdu3tAhEOxSMD18FQXpVLXhO5ySgy3kKgPTQv5AJpUOhpB4OtpacHuZkbG4
         NClcGlNYXBaWKbNROXUIjMe9aDAjgL4z70Q9JGgEIezKUr3vEMJ+/0zFLwg47iJgdNf9
         FBBt97G6UvBLbEOfPvMirIx/l6gRUlZyNey1WOlUf2Cmu7ZtyEtMsbblLG/e7KzPRp3s
         hS1bl8QNt1LsWL24bp4AvcFAm4FtkRiSjPVOag37jtP/FBbe7vrihqEmYSZb2y8MD4Ih
         8JS4pLUw8MVQUZwH2gD1ZlYZWaWJTEPgsu6LpCIF6j+AbS8XnJVPTGzdBT7Aet7Z1x9M
         J7sA==
X-Gm-Message-State: AOAM533FX2wXbbBM+5Jn9juqvagH/MGV3tgd8sXs9APeCJmMVM7aod7O
        NvvCdEfT4V8WyryvY5iXDYkw8mRN95w3MoQf+UbOqg==
X-Google-Smtp-Source: ABdhPJwRXYKVMGaY5ggPVk6CztjQIvkE7mOrDoQPqHVdweEFScrXaPDOm3pNYCPRx6yJ5PkBeUlVbM6Ka8GeQRpYGt0=
X-Received: by 2002:ab0:1e84:: with SMTP id o4mr1209850uak.74.1600715792227;
 Mon, 21 Sep 2020 12:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu>
In-Reply-To: <cover.1600661418.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 21:16:06 +0200
Message-ID: <CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> This series adds a bitmap to cache seccomp filter results if the
> result permits a syscall and is indepenent of syscall arguments.
> This visibly decreases seccomp overhead for most common seccomp
> filters with very little memory footprint.

It would be really nice if, based on this, we could have a new entry
in procfs that has one line per entry in each syscall table. Maybe
something that looks vaguely like:

X86_64 0 (read): ALLOW
X86_64 1 (write): ALLOW
X86_64 2 (open): ERRNO -1
X86_64 3 (close): ALLOW
X86_64 4 (stat): <argument-dependent>
[...]
I386 0 (restart_syscall): ALLOW
I386 1 (exit): ALLOW
I386 2 (fork): KILL
[...]

This would be useful both for inspectability (at the moment it's
pretty hard to figure out what seccomp rules really apply to a given
task) and for testing (so that we could easily write unit tests to
verify that the bitmap calculation works as expected).

But if you don't want to implement that right now, we can do that at a
later point - while it would be nice for making it easier to write
tests for this functionality, I don't see it as a blocker.


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
[...]
> Statically analyzing BPF bytecode to see if each syscall is going to
> always land in allow or reject is more of a rabbit hole, especially
> there is no current in-kernel infrastructure to enumerate all the
> possible architecture numbers for a given machine.

You could add that though. Or if you think that that's too much work,
you could just do it for x86 and arm64 and then use a Kconfig
dependency to limit this to those architectures for now.

> So rather than
> doing that, we propose to cache the results after the BPF filters are
> run.

Please don't add extra complexity just to work around a limitation in
existing code if you could instead remove that limitation in existing
code. Otherwise, code will become unnecessarily hard to understand and
inefficient.

You could let struct seccomp_filter contain three bitmasks - one for
the "native" architecture and up to two for "compat" architectures
(gated on some Kconfig flag).

alpha has 1 architecture numbers, arc has 1 (per build config), arm
has 1, arm64 has 2, c6x has 1 (per build config), csky has 1, h8300
has 1, hexagon has 1, ia64 has 1, m68k has 1, microblaze has 1, mips
has 3 (per build config), nds32 has 1 (per build config), nios2 has 1,
openrisc has 1, parisc has 2, powerpc has 2 (per build config), riscv
has 1 (per build config), s390 has 2, sh has 1 (per build config),
sparc has 2, x86 has 2, xtensa has 1.

> And since there are filters like docker's who will check
> arguments of some syscalls, but not all or none of the syscalls, when
> a filter is loaded we analyze it to find whether each syscall is
> cacheable (does not access syscall argument or instruction pointer) by
> following its control flow graph, and store the result for each filter
> in a bitmap. Changes to architecture number or the filter are expected
> to be rare and simply cause the cache to be cleared. This solution
> shall be fully transparent to userspace.

Caching whether a given syscall number has fixed per-architecture
results across all architectures is a pretty gross hack, please don't.



> Ongoing work is to further support arguments with fast hash table
> lookups. We are investigating the performance of doing so [6], and how
> to best integrate with the existing seccomp infrastructure.

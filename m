Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E90944741A
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhKGQxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 11:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhKGQxP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 11:53:15 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519AC061570
        for <bpf@vger.kernel.org>; Sun,  7 Nov 2021 08:50:32 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e136so33987764ybc.4
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjzGtqUz2+lcDCX5sdfCWK1A6yjWANqinTnkJi/dZGY=;
        b=iW4lELOK1yZ2x6RyY+Tp44KmYaYWZvmPb2dR9VfxtReNIhaEKnY3QBhKZGT0hwGe3B
         6tnSDiX8gn+IlKJXYxOtc11n9PznMLZdP5y6wRPlxYroQwBN5kgsQnwodddWWFMJBXz1
         AB707cl9zkaiPISTwSe/KKQ6C+/bVmr21rnfOKqciCZSyoZCMHvn76ftpuD6u4DIppKQ
         u8iwQXrDiNX73a2zoTZNQGPz+Rftn3d4n1Onv7LqY1jQy1LPpA9yeWXIjkM2LfjVGkhd
         erZftBd3k+VMjgvaD0oMihtrSkL3jH463VwwNzEdv6PHAS16ALLLQ/O280MfOPrpkD+f
         juYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjzGtqUz2+lcDCX5sdfCWK1A6yjWANqinTnkJi/dZGY=;
        b=sbP/ZSXCRDqhBJ6VW6RJMGoS0khwPfLGi4EJshlaJxAIsm2epQUTuovXb59b2PzgI8
         epOlQ0v5M+cqt5xSYC0Ywa25TsadeSvvvne4qof52hYt9ZzQiCzY9DOqKqc6XX6HzO92
         3ropC5Muhspfu6JVAhs524JZevR85tYSlzyCFKanbI6gDSjwLmrC6+AvaenK2+zrmQwS
         ucAb9Mwrj5NzwzbXm45zGGOlOW1IjQg00mTkMx05T07NP/FK7HJbiYYi6Og6BL8a/bxJ
         PRK3U+kR3BzD+j7vqZgZ4xa8F2/TAVoopbAVf03kXSCB+myMra/2JDuLo/JTwZtDFVUk
         7qQQ==
X-Gm-Message-State: AOAM533Az7lwcaNC62eJ12yKYuxKeTTAfmsL3HmWPpFFmmScMS5uZRIw
        3cSTIqD9i6Vf4pHzvLBm/nv6+A+Te86yhoMDL6ss4LI5
X-Google-Smtp-Source: ABdhPJxOH8Gbumeuk2sdXvj8si/umx7LlNoMlxP7TYi1yBXLy3x+Um3WzdcPSsGiNQnyLiCD1EzAqHQwvHcJtYQgRQg=
X-Received: by 2002:a25:d187:: with SMTP id i129mr65697874ybg.2.1636303831331;
 Sun, 07 Nov 2021 08:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20211107164624.4137512-1-andrii@kernel.org>
In-Reply-To: <20211107164624.4137512-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 7 Nov 2021 08:50:20 -0800
Message-ID: <CAEf4BzZWua3QHdEa1ni7A8qRC1WScFZRhZu8ptukedmAse5yqg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/9] Fix leaks in libbpf and selftests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 7, 2021 at 8:46 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix all the memory leaks reported by ASAN. All but one are just improper
> resource clean up in selftests. But one memory leak was discovered in libbpf,
> leaving inner map's name leaked.
>
> First patch fixes selftests' Makefile by passing through SAN_CFLAGS to linker.
> Without that compiling with SAN_CFLAGS=-fsanitize=address kept failing.
>
> Running selftests under ASAN in BPF CI is the next step, we just need to make
> sure all the necessary libraries (libasan and liblsan) are installed on the
> host and inside the VM. Would be great to get some help with that, but for now
> make sure that test_progs run is clean from leak sanitizer errors.
>
> v2->v3:
>   - fix per-cpu array memory leaks in btf_iter.c selftests (Hengqi);
> v1->v2:
>   - call bpf_map__destroy() conditionally if map->inner_map is present.
>

Oh, I didn't notice that the bpf_prog_load() patch set went in. This
one seems to have a small Makefile conflict, I'll rebase. Sorry for
the spam.

> Andrii Nakryiko (9):
>   selftests/bpf: pass sanitizer flags to linker through LDFLAGS
>   libbpf: free up resources used by inner map definition
>   selftests/bpf: fix memory leaks in btf_type_c_dump() helper
>   selftests/bpf: free per-cpu values array in bpf_iter selftest
>   selftests/bpf: free inner strings index in btf selftest
>   selftests/bpf: clean up btf and btf_dump in dump_datasec test
>   selftests/bpf: avoid duplicate btf__parse() call
>   selftests/bpf: destroy XDP link correctly
>   selftests/bpf: fix bpf_object leak in skb_ctx selftest
>
>  tools/lib/bpf/libbpf.c                                   | 5 ++++-
>  tools/testing/selftests/bpf/Makefile                     | 1 +
>  tools/testing/selftests/bpf/btf_helpers.c                | 9 +++++++--
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c        | 8 ++++----
>  tools/testing/selftests/bpf/prog_tests/btf.c             | 6 ++----
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c        | 8 ++++++--
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 2 +-
>  .../testing/selftests/bpf/prog_tests/migrate_reuseport.c | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/skb_ctx.c         | 2 ++
>  9 files changed, 29 insertions(+), 16 deletions(-)
>
> --
> 2.30.2
>

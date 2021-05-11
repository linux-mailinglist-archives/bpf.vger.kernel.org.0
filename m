Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA90037B26D
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 01:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEKXYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 19:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKXYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 19:24:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F7FC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:23:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 82so28510240yby.7
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfupVTQU99tILyYY73Walxheu37Lg/E+pDOr+dx1pYQ=;
        b=uavk7FUuSCflz4vZH5F8y6yBTY2js6gmbjFVnbhxVjxAdOM3hb1tl3DNKSVAL/E2w4
         ZpdOWSIJ9iiYAK6HBBOkOBJcT/BoFSQVBUvsHolLT4V7XdDddVyBGfkJv3Q5jI4O9ZWz
         xierN5RoAV5RPerLIuGJJ0frArTCkcrAv4yoipCQk3lFS+c6suNA7zxMrJ73dycJ1fnR
         UnlIOWYiRLFEPmklf5jEFNSqw7mSbtZxSS1FEOoU6pQvnNbY7sn2WRKfq+nERvElH/oW
         dECWEKV+3Yda4nKRsPRZYa/O/LiFrtxCOilYWJng6GyK/kDGXXwG0j7bq67LI611NBTc
         z13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfupVTQU99tILyYY73Walxheu37Lg/E+pDOr+dx1pYQ=;
        b=MWjLujXqRNj2xKGP1fA4dMvGxoACLvXfrBjv3k2JhVc686Ha/Uy3f3/asi2fP2fbTB
         nSmXNq9Co3I9YV3XuGtRgG768lPzzkNTnaxhAdt7yLQZ/2dgVHuf+tptuaUBRSMmQXSa
         C7eI6ikQAgltPib5B8wjLqJ9VQskckCx8v0kSADt54B3Rj1yPcvnrcBsPjbIKAaOrnBL
         3JkQhNIiG6hDQNqVaWr6Qo0K6fXAQd4YRkbEkvNFrV9cGWN3TPkb+BbYDazp+uJq2WzY
         Y6HvLNZEoKKg0ZD/RjiXX3stGQ8rFvCLkC8qI/vuOyZI5nVVitjSjVqjQGjN8Mr/ftUx
         XfAw==
X-Gm-Message-State: AOAM532jydZq7pmhWlvffoJmh3yS5LY1U9Cff/4nFatuflZi8Jkj34BR
        V5oXGPeu7twV41nY7PNEFj57VdM65venEjecV/4=
X-Google-Smtp-Source: ABdhPJwvMo2oSqHFP/l59qFhsHapZ6q7iFJA3ygmepOcJmdjz6e5o9fmQT6gBL9sLrd/Kz7gvGJowQqMLXL7JiFMBzA=
X-Received: by 2002:a25:1455:: with SMTP id 82mr43613334ybu.403.1620775384191;
 Tue, 11 May 2021 16:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-15-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-15-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 16:22:52 -0700
Message-ID: <CAEf4BzZzOP6ai0Yf_PbF+At4-UXu0E_8bKyXL4Qj9T6ohxvofQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 14/22] libbpf: Generate loader program out of
 BPF ELF file.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The BPF program loading process performed by libbpf is quite complex
> and consists of the following steps:
> "open" phase:
> - parse elf file and remember relocations, sections
> - collect externs and ksyms including their btf_ids in prog's BTF
> - patch BTF datasec (since llvm couldn't do it)
> - init maps (old style map_def, BTF based, global data map, kconfig map)
> - collect relocations against progs and maps
> "load" phase:
> - probe kernel features
> - load vmlinux BTF
> - resolve externs (kconfig and ksym)
> - load program BTF
> - init struct_ops
> - create maps
> - apply CO-RE relocations
> - patch ld_imm64 insns with src_reg=PSEUDO_MAP, PSEUDO_MAP_VALUE, PSEUDO_BTF_ID
> - reposition subprograms and adjust call insns
> - sanitize and load progs
>
> During this process libbpf does sys_bpf() calls to load BTF, create maps,
> populate maps and finally load programs.
> Instead of actually doing the syscalls generate a trace of what libbpf
> would have done and represent it as the "loader program".
> The "loader program" consists of single map with:
> - union bpf_attr(s)
> - BTF bytes
> - map value bytes
> - insns bytes
> and single bpf program that passes bpf_attr(s) and data into bpf_sys_bpf() helper.
> Executing such "loader program" via bpf_prog_test_run() command will
> replay the sequence of syscalls that libbpf would have done which will result
> the same maps created and programs loaded as specified in the elf file.
> The "loader program" removes libelf and majority of libbpf dependency from
> program loading process.
>
> kconfig, typeless ksym, struct_ops and CO-RE are not supported yet.
>
> The order of relocate_data and relocate_calls had to change, so that
> bpf_gen__prog_load() can see all relocations for a given program with
> correct insn_idx-es.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/Build              |   2 +-
>  tools/lib/bpf/bpf_gen_internal.h |  40 ++
>  tools/lib/bpf/gen_loader.c       | 657 +++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c           | 224 +++++++++--
>  tools/lib/bpf/libbpf.h           |  12 +
>  tools/lib/bpf/libbpf.map         |   1 +
>  tools/lib/bpf/libbpf_internal.h  |   2 +
>  tools/lib/bpf/skel_internal.h    | 116 ++++++
>  8 files changed, 1022 insertions(+), 32 deletions(-)
>  create mode 100644 tools/lib/bpf/bpf_gen_internal.h
>  create mode 100644 tools/lib/bpf/gen_loader.c
>  create mode 100644 tools/lib/bpf/skel_internal.h
>

[...]

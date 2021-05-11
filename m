Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDD37B2A1
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEKXf0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 19:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKXfY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 19:35:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3923FC06174A
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:34:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y2so28481762ybq.13
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsXVvyWVcTliqHYVVLc+UKG6tcVtsZpjdubfjZ8XAUU=;
        b=FL7iq2KLOcL4gXyRnPyhv32J+E/LQ5ltIIr9+xrchJPSXQRLfva5PDF4Ue3lQDDwjn
         Y467TH+Vo4tVrLHprA7c1O7T4briZhfgCO3wthdV8Slk4UjSk9avrk+ohw2nlyKDPoNY
         9Y0dOylVu92j+Mk0AmJcNUctaZJkqtDQtFAKB3AAiyQZSb8VZ1ulh0cszP+T13TNnv0K
         he23jtZwTQSlohFo7a0yTsdsI3J40KCCbp7IiWhPOCwhXZaqiIdrinvNzD5c4gl2iqfn
         9KNJO6CIVDFym7AVtIdCJbqi5BBMCYiKPz5ZCLZrb0Kzp1KvFeRC+IqbwK0eBoSVPaT4
         FD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsXVvyWVcTliqHYVVLc+UKG6tcVtsZpjdubfjZ8XAUU=;
        b=SBamSA0woxmT6qrpOn3Rl3na/oKQa5BJI3tmv6H61R5Ipfaz8cJmHEkFhv5VvA/2UO
         irevxssmN8oeI8pIkFan9rp8XdpaRedEP19YKgL/daOFjxPKYT9kdWMZTr6VEERYp6QH
         hmBZBkOA5/DUFhDdRVwexyiJPn0/L0zRbL+Sp44gk+jWjJXnl4bF1NWhjSjVrAoQOEOD
         OqfOG2Ob3yms+wb7PjGpQnm0uJQjiF3s9mx0XzTjPFRdNOj3Z3YwMKNahyf581uWQMFj
         D4vZr/u53r77ezg1uH+crhn3BOo5JZDMtmUBD4lBUyOsZYBAkGWrgxmeI8umewNt2Iwf
         VZBg==
X-Gm-Message-State: AOAM531fkbqSTPfKyiLrrL6DsUsMvJLmMRQjUCBfP01EaDsyFaXXCThD
        ppl+pkwwIMDj242jLJ5J93RtOEkVhGGIgf3/NNU=
X-Google-Smtp-Source: ABdhPJxy0IJ6kfP66R6PPSSKMq+cEV0PpaPfSDqS5+PGiolzUaO52GWHBUBX0cVcWQNJfdZWaM5K9OqQ63O6RkhA0Vo=
X-Received: by 2002:a25:3357:: with SMTP id z84mr43482966ybz.260.1620776056585;
 Tue, 11 May 2021 16:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-17-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-17-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 16:34:05 -0700
Message-ID: <CAEf4BzYPHBeK3vfwFm7oUru5Qb2MFq+sfnFV+=J-duevxXeryA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 16/22] libbpf: Cleanup temp FDs when
 intermediate sys_bpf fails.
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
> Fix loader program to close temporary FDs when intermediate
> sys_bpf command fails.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Looks good, but curious about 2 jumps vs 1 jump for cleanup

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/bpf_gen_internal.h |  1 +
>  tools/lib/bpf/gen_loader.c       | 38 ++++++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> index f42a55efd559..da2c026a3f31 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h
> @@ -15,6 +15,7 @@ struct bpf_gen {
>         void *data_cur;
>         void *insn_start;
>         void *insn_cur;
> +       size_t cleanup_label;
>         __u32 nr_progs;
>         __u32 nr_maps;
>         int log_level;
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 585c672cc53e..b1709421ba90 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -97,8 +97,36 @@ static void bpf_gen__emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bp
>
>  void bpf_gen__init(struct bpf_gen *gen, int log_level)
>  {
> +       size_t stack_sz = sizeof(struct loader_stack);
> +       int i;
> +
>         gen->log_level = log_level;
> +       /* save ctx pointer into R6 */
>         bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
> +
> +       /* bzero stack */
> +       bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_1, BPF_REG_10));
> +       bpf_gen__emit(gen, BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -stack_sz));
> +       bpf_gen__emit(gen, BPF_MOV64_IMM(BPF_REG_2, stack_sz));
> +       bpf_gen__emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
> +       bpf_gen__emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
> +
> +       /* jump over cleanup code */
> +       bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> +                                      /* size of cleanup code below */
> +                                      (stack_sz / 4) * 3 + 2));
> +
> +       /* remember the label where all error branches will jump to */
> +       gen->cleanup_label = gen->insn_cur - gen->insn_start;
> +       /* emit cleanup code: close all temp FDs */
> +       for (i = 0; i < stack_sz; i+= 4) {

nit: checkpatch complains about missing space before +=

> +               bpf_gen__emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
> +               bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
> +               bpf_gen__emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
> +       }
> +       /* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
> +       bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
> +       bpf_gen__emit(gen, BPF_EXIT_INSN());
>  }
>
>  static int bpf_gen__add_data(struct bpf_gen *gen, const void *data, __u32 size)
> @@ -179,10 +207,12 @@ static void bpf_gen__emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int at
>
>  static void bpf_gen__emit_check_err(struct bpf_gen *gen)
>  {
> -       bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 2));
> -       bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
> -       /* TODO: close intermediate FDs in case of error */
> -       bpf_gen__emit(gen, BPF_EXIT_INSN());
> +       /* R7 contains result of last sys_bpf command.
> +        * if (R7 < 0) goto cleanup;
> +        */
> +       bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 1));
> +       bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> +                                      -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1));

Just curious, why not a single BPF_JSLT straight to the cleanup label?

>  }
>
>  /* reg1 and reg2 should not be R1 - R5. They can be R0, R6 - R10 */
> --
> 2.30.2
>

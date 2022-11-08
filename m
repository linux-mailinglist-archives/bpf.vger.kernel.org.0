Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7462202F
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiKHXOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 18:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKHXOb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 18:14:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549D193D7
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 15:14:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m22so5248288eji.10
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 15:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ngxWsfinQfa+ORX9gEHr2shO2HBJuvfQTSXbKHYlopM=;
        b=QpG8tFECIGu5IrjZun1oVYP39dXL89RuuPZwlmaQZmSNR+Kb6VlFkaOJxgHI4ROmXk
         LGdi0ZaBTsXHa/4MNR19u9+k6d5h+VS6yVL7ocjGrVmDyevpHwVLUy78y/GqaJkzwtaY
         1caqaWgdisA541U809KmCTq4/SF09NV83BOhEKHHPHrkTaRNiEUiF+0mQr0dJ8lH3zNA
         syXuTFUhz24tdHkOUa53yBZJak6BjFFvp6fzn0B2ki5yOD2TOohukdkrOONROu6PGNfy
         B3aftdtlEX7zmO7IP2gyWAKRb+YnPHWmJ2R5vpRz0xvCTXsC66gv6LUgVsEqJW0Tk2Qm
         2yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngxWsfinQfa+ORX9gEHr2shO2HBJuvfQTSXbKHYlopM=;
        b=uwSEaYKKWuBIFrfBHUnmjAwgrBjCRFLyS9zm24rDiryD/KYNA0vzhz0sjQVO2HnSux
         X8fwCP6NEYQh267jF22DSXJDS2+SyQVlfIyLcv72yBvH/cThUBwov4TVJxz2n7veqSaQ
         1ENI82GPfDJnwgevlNDq8zHXdD7k062alsPFqEPkRKKgQ4fLUeThpnxgrZkoUX/HJFBi
         aKVQ8DbwDLRkk6JTvUxFnxoplaC4ao/KKrgFqtEtvbHKze6HIqIxwlbj/pf/nL28ze3R
         evMKyOfMTTpX6J9xXOSphuvU4FQ9xnRmR0AXbM1+7q2iK+oSDjr4vCQmxjcbfzsmde+Y
         wZtw==
X-Gm-Message-State: ACrzQf3RT+Je3urBLzJr4NuoZoy7TKs89+4OqGESzTJJG95hch8oITj2
        hBpojEH9NWMPTuB6fpbkfk3vx/aVNNV8sf4aT7I=
X-Google-Smtp-Source: AMsMyM6zNY+PXw/tFngSUJrWCM2/IbfZVdV7vShqBxZd/GXwp1M0mXrzcN7LgQ8Wy33WL62o0HNgZ5Bzy2V2W9AvTB8=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr35591229eja.545.1667949268979; Tue, 08
 Nov 2022 15:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-6-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-6-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 15:14:16 -0800
Message-ID: <CAEf4BzZ180YJ+fbynJSR2fXXMVuKZTyginHyRdxydvOm-po7TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/25] bpf: Rename MEM_ALLOC to MEM_RINGBUF
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Currently, verifier uses MEM_ALLOC type tag to specially tag memory
> returned from bpf_ringbuf_reserve helper. However, this is currently
> only used for this purpose and there is an implicit assumption that it
> only refers to ringbuf memory (e.g. the check for ARG_PTR_TO_ALLOC_MEM
> in check_func_arg_reg_off).
>
> Hence, rename MEM_ALLOC to MEM_RINGBUF to indicate this special
> relationship and instead open the use of MEM_ALLOC for more generic
> allocations made for user types.
>
> Also, since ARG_PTR_TO_ALLOC_MEM_OR_NULL is unused, simply drop it.
>
> Finally, update selftests using 'alloc_' verifier string to 'ringbuf_'.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Ok, so you are doing what I asked in the previous patch, nice :)

>  include/linux/bpf.h                               | 11 ++++-------
>  kernel/bpf/ringbuf.c                              |  6 +++---
>  kernel/bpf/verifier.c                             | 14 +++++++-------
>  tools/testing/selftests/bpf/prog_tests/dynptr.c   |  2 +-
>  tools/testing/selftests/bpf/verifier/ringbuf.c    |  2 +-
>  tools/testing/selftests/bpf/verifier/spill_fill.c |  2 +-
>  6 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2fe3ec620d54..afc1c51b59ff 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -488,10 +488,8 @@ enum bpf_type_flag {
>          */
>         MEM_RDONLY              = BIT(1 + BPF_BASE_TYPE_BITS),
>
> -       /* MEM was "allocated" from a different helper, and cannot be mixed
> -        * with regular non-MEM_ALLOC'ed MEM types.
> -        */
> -       MEM_ALLOC               = BIT(2 + BPF_BASE_TYPE_BITS),
> +       /* MEM points to BPF ring buffer reservation. */
> +       MEM_RINGBUF             = BIT(2 + BPF_BASE_TYPE_BITS),

What do we gain by having ringbuf memory as additional modified flag
instead of its own type like PTR_TO_MAP_VALUE or PTR_TO_PACKET? It
feels like here separate register type is more justified and is less
error prone overall.

>
>         /* MEM is in user address space. */
>         MEM_USER                = BIT(3 + BPF_BASE_TYPE_BITS),
> @@ -565,7 +563,7 @@ enum bpf_arg_type {
>         ARG_PTR_TO_LONG,        /* pointer to long */
>         ARG_PTR_TO_SOCKET,      /* pointer to bpf_sock (fullsock) */
>         ARG_PTR_TO_BTF_ID,      /* pointer to in-kernel struct */
> -       ARG_PTR_TO_ALLOC_MEM,   /* pointer to dynamically allocated memory */
> +       ARG_PTR_TO_RINGBUF_MEM, /* pointer to dynamically reserved ringbuf memory */
>         ARG_CONST_ALLOC_SIZE_OR_ZERO,   /* number of allocated bytes requested */
>         ARG_PTR_TO_BTF_ID_SOCK_COMMON,  /* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
>         ARG_PTR_TO_PERCPU_BTF_ID,       /* pointer to in-kernel percpu type */

[...]

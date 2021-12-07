Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C846B2CA
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 07:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhLGGWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 01:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhLGGV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 01:21:59 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A864C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 22:18:30 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g17so37866327ybe.13
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 22:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYmkMbI/81MsJiKCzbygW4wITSaX+zHmfUxFpekjRhc=;
        b=dYnbT+IB/ZoZ2pnoNrApccd7t2i4Ou+UT5iXQ5VQZRkXzdja68xSj0EXZW3A5b9e6T
         zKDEWTzGori3sxt+AZ6MOK0+/tt3zlH/C8il9gP/E/5OaIWOQiRhfkYExcR37qOS8B3u
         QhiYOTUfYcZMQKFh6946QPnSoEXjFFbKH+06uO/G3k6DPPR7rDRtt9tUcxFnMmIfp3T3
         2EcIEoLL0+JsohrIw6GEhoIA14HZxHf3qqEh9p6baTqKtQw5GlJ5Ts7fxsVVPH5nhl/L
         CPBn6SPyjO/GK03mvTu0rAbb8KPKtMfdKeeaXbJQOs5A7pZp6VxpHJKn0oPB39ihz3Q+
         6nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYmkMbI/81MsJiKCzbygW4wITSaX+zHmfUxFpekjRhc=;
        b=LoTqxVUkX+WMDPPNX3f+UGZAVU2LoZvlsRLsVSMGN5dA6bHXIsYSIVMb0C1LPG5IlE
         e/Cjdn2mJ+qirQfImTA/ApgrAXDO03w1CMk+/qGwf30bZBmsZ8BmYaJsJYkDch+U4SHX
         UpBtp4WDPh56ayk9vbZfdy/1hAD0uJIpfifwjR0dBZ/kK6IJFfN82pL7NnPtl0+dfxCO
         /NjBO+LroogjAEoRq/eweS7zSIkDPlcoJiWNcbu2ZEcxdyfnsUILlo9krPufp8CyNST0
         QML3Q3290q866q4Atu7NSjCAQ0oWL4Mfi+ADRDDs2Egl8LxTlpWYPv68oxlEhwufZZLv
         qLlQ==
X-Gm-Message-State: AOAM532/tMcSZhdJcjNyyGjchHfa/rXfysWht4a/VRdtzh31whJ3Oinm
        Ne81b6/Y+Hm5peswURwpoyZrNRaTwXlB3AVKRzo=
X-Google-Smtp-Source: ABdhPJyOGSzZiJ+U84kj5kPsvblXCwfC2B1OEKYY08JWC2Km1h5T3J+mmjo6HKbCZ8UBgffLysnyEA/uZDyC4W4XRDA=
X-Received: by 2002:a25:84c1:: with SMTP id x1mr48881789ybm.690.1638857909385;
 Mon, 06 Dec 2021 22:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-8-haoluo@google.com>
In-Reply-To: <20211206232227.3286237-8-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Dec 2021 22:18:18 -0800
Message-ID: <CAEf4BzbSA1+vE4vA6FSbJfUZDyYvyHJbiK1j5yD=vGbGA5EEhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
>
> Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
> returned value of this pair of helpers is kernel object, which
> can not be updated by bpf programs. Previously these two helpers
> return PTR_OT_MEM for kernel objects of scalar type, which allows
> one to directly modify the memory. Now with RDONLY_MEM tagging,
> the verifier will reject programs that writes into RDONLY_MEM.
>
> Fixes: 63d9b80dcf2c ("bpf: Introduce bpf_this_cpu_ptr()")
> Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
> Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  kernel/bpf/helpers.c  |  4 ++--
>  kernel/bpf/verifier.c | 33 ++++++++++++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 293d9314ec7f..a5e349c9d3e3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
>  const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
>         .func           = bpf_per_cpu_ptr,
>         .gpl_only       = false,
> -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
> +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
>         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
>         .arg2_type      = ARG_ANYTHING,
>  };
> @@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
>  const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
>         .func           = bpf_this_cpu_ptr,
>         .gpl_only       = false,
> -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID,
> +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
>         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
>  };
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f8b804918c35..44af65f07a82 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4296,16 +4296,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>                                 mark_reg_unknown(env, regs, value_regno);
>                         }
>                 }
> -       } else if (reg->type == PTR_TO_MEM) {
> +       } else if (base_type(reg->type) == PTR_TO_MEM) {
> +               bool rdonly_mem = type_is_rdonly_mem(reg->type);
> +
> +               if (type_may_be_null(reg->type)) {
> +                       verbose(env, "R%d invalid mem access '%s'\n", regno,
> +                               reg_type_str(reg->type));

see, here you'll get "invalid mem access 'ptr_to_mem'" while it's
actually ptr_to_mem_or_null. Like verifier logs are not hard enough to
follow, now they will be also misleading.

> +                       return -EACCES;
> +               }
> +
> +               if (t == BPF_WRITE && rdonly_mem) {
> +                       verbose(env, "R%d cannot write into rdonly %s\n",
> +                               regno, reg_type_str(reg->type));
> +                       return -EACCES;
> +               }
> +
>                 if (t == BPF_WRITE && value_regno >= 0 &&
>                     is_pointer_value(env, value_regno)) {
>                         verbose(env, "R%d leaks addr into mem\n", value_regno);
>                         return -EACCES;
>                 }
> +
>                 err = check_mem_region_access(env, regno, off, size,
>                                               reg->mem_size, false);
> -               if (!err && t == BPF_READ && value_regno >= 0)
> -                       mark_reg_unknown(env, regs, value_regno);
> +               if (!err && value_regno >= 0)
> +                       if (t == BPF_READ || rdonly_mem)

why two nested ifs for one condition?

> +                               mark_reg_unknown(env, regs, value_regno);
>         } else if (reg->type == PTR_TO_CTX) {
>                 enum bpf_reg_type reg_type = SCALAR_VALUE;
>                 struct btf *btf = NULL;

[...]

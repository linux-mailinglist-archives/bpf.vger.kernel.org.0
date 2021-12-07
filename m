Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FC46B2DB
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 07:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhLGG1i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 01:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhLGG1h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 01:27:37 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23927C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 22:24:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v138so38032732ybb.8
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 22:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCZSDfADJnwnYwXg3EHDG8a1CYtCScin8QCqwPv8cEo=;
        b=Jv+NXxb8HoPiNfuyjeXWBTX8jFulGGnvRS70ovgKuniW2BBkMGpi1yWO5t1bp2I9mc
         h7SjFHTwTHOM4SsbCJ4epjjbJqmtXr5UCf04Dxizjce+tjzrhzfgPzAQR2W1s8ejJWx8
         IFXEfLklVdqD+2pJ6N/19DG4Tea8jwRlg0dkQczebcAxoP3KJyOWLffV8uY/zpmQz4cq
         TU61OgiUr8rFM73fXcWbkCKGlEgI/650ipo7uI/ZC1FmOxqF78FSj7yUWTqaSjvGCxJR
         Whr4p7XVvF6x0kYRJ31oX9I+bcha6YBhRI2IIep2VZvROt4N2Q4FjYvebbu+4+1t/3zb
         Avwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCZSDfADJnwnYwXg3EHDG8a1CYtCScin8QCqwPv8cEo=;
        b=I85+EpXnojqqjGJT2d8kU51Zm0u8PLrAP2P8S+yA54b7jE+vybmvFPUckhakPZ3pB7
         EwsVys+UndyC8Yx2AqND5BpCVUFFd9tiVWbQIDV+8bVfIqP4i2oIZHsigYsRA2gDhCyp
         LXEjLHfnroR5o2Xn4LmxKSeeDbcUH08pTdIRxD1cuma1ckJCBuRGJdrMncjXlZ5kZvTm
         2EJpNgOk+NxkXohady9qcDmRJAP2eBGBTMfdqrYqMLmDUJWPU+/KjommXcue3qSPG0rY
         TkJQnYwMSH3GCeaZTm6ev7enKeesOmRuiRxA14E6GgBKUqOGfUMHHQQSi2pcJ+q+W0Ym
         NLCg==
X-Gm-Message-State: AOAM530qWcS5fMKnqxJrPIN85lPzFhcMZVumSU9gPkVTc4uixT5e9E/U
        x1nDdm4M1mT0Qk6+a8iaWzJjg6fQ9DHrQNA0wOE=
X-Google-Smtp-Source: ABdhPJygBKCGHmB9z9uG2oU7s3vrSsdr2LOLolFq83teNXT1xNJjpfbKKV2tPKXvcP5HbkTWKG5Mr0FPXbZUTL1mqqU=
X-Received: by 2002:a25:e617:: with SMTP id d23mr46958645ybh.555.1638858247300;
 Mon, 06 Dec 2021 22:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-9-haoluo@google.com>
In-Reply-To: <20211206232227.3286237-9-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Dec 2021 22:23:56 -0800
Message-ID: <CAEf4Bzb3nyWbS4=e7M8Am5BvMSPbMhMzXPKvd3spk+D9vZg99g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Add MEM_RDONLY for helper args that
 are pointers to rdonly mem.
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
> Some helper functions may modify its arguments, for example,
> bpf_d_path, bpf_get_stack etc. Previously, their argument types
> were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> to modify a read-only memory by passing it into one of such helper
> functions.
>
> This patch tags the bpf_args compatible with immutable memory with
> MEM_RDONLY flag. The arguments that don't have this flag will be
> only compatible with mutable memory types, preventing the helper
> from modifying a read-only memory. The bpf_args that have
> MEM_RDONLY are compatible with both mutable memory and immutable
> memory.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h      |  4 ++-
>  kernel/bpf/btf.c         |  2 +-
>  kernel/bpf/cgroup.c      |  2 +-
>  kernel/bpf/helpers.c     |  8 ++---
>  kernel/bpf/ringbuf.c     |  2 +-
>  kernel/bpf/syscall.c     |  2 +-
>  kernel/bpf/verifier.c    | 14 +++++++--
>  kernel/trace/bpf_trace.c | 26 ++++++++--------
>  net/core/filter.c        | 64 ++++++++++++++++++++--------------------
>  9 files changed, 67 insertions(+), 57 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 03418ab3f416..5151d6b1f392 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -311,7 +311,9 @@ enum bpf_type_flag {
>         /* PTR may be NULL. */
>         PTR_MAYBE_NULL          = BIT(0 + BPF_BASE_TYPE_BITS),
>
> -       /* MEM is read-only. */
> +       /* MEM is read-only. When applied on bpf_arg, it indicates the arg is
> +        * compatible with both mutable and immutable memory.
> +        */
>         MEM_RDONLY              = BIT(1 + BPF_BASE_TYPE_BITS),
>
>         __BPF_TYPE_LAST_FLAG    = MEM_RDONLY,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7adc099bb24b..e09b5a7bfdc3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6350,7 +6350,7 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
>         .func           = bpf_btf_find_by_name_kind,
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
> -       .arg1_type      = ARG_PTR_TO_MEM,
> +       .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      = ARG_CONST_SIZE,
>         .arg3_type      = ARG_ANYTHING,
>         .arg4_type      = ARG_ANYTHING,
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 2ca643af9a54..b8fe671af13c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1789,7 +1789,7 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg3_type      = ARG_CONST_SIZE,
>  };
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a5e349c9d3e3..66b466903a4e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -530,7 +530,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
>         .func           = bpf_strtol,
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
> -       .arg1_type      = ARG_PTR_TO_MEM,
> +       .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      = ARG_CONST_SIZE,
>         .arg3_type      = ARG_ANYTHING,
>         .arg4_type      = ARG_PTR_TO_LONG,
> @@ -558,7 +558,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
>         .func           = bpf_strtoul,
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
> -       .arg1_type      = ARG_PTR_TO_MEM,
> +       .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      = ARG_CONST_SIZE,
>         .arg3_type      = ARG_ANYTHING,
>         .arg4_type      = ARG_PTR_TO_LONG,
> @@ -630,7 +630,7 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
>         .arg1_type      = ARG_PTR_TO_CTX,
>         .arg2_type      = ARG_CONST_MAP_PTR,
>         .arg3_type      = ARG_ANYTHING,
> -       .arg4_type      = ARG_PTR_TO_MEM,
> +       .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg5_type      = ARG_CONST_SIZE_OR_ZERO,
>  };
>
> @@ -1011,7 +1011,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
>         .arg1_type      = ARG_PTR_TO_MEM_OR_NULL,
>         .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
>         .arg3_type      = ARG_PTR_TO_CONST_STR,
> -       .arg4_type      = ARG_PTR_TO_MEM_OR_NULL,
> +       .arg4_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
>         .arg5_type      = ARG_CONST_SIZE_OR_ZERO,
>  };
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 9e0c10c6892a..638d7fd7b375 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -444,7 +444,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
>         .func           = bpf_ringbuf_output,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_CONST_MAP_PTR,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>         .arg4_type      = ARG_ANYTHING,
>  };
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 50f96ea4452a..301afb44e47f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4757,7 +4757,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_ANYTHING,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg3_type      = ARG_CONST_SIZE,
>  };
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 44af65f07a82..a7c015a7b52d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4966,6 +4966,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> +

nit: unnecessary extra empty line?

>  struct bpf_reg_types {
>         const enum bpf_reg_type types[10];
>         u32 *btf_id;
> @@ -5012,7 +5013,6 @@ static const struct bpf_reg_types mem_types = {
>                 PTR_TO_MAP_VALUE,
>                 PTR_TO_MEM,
>                 PTR_TO_BUF,
> -               PTR_TO_BUF | MEM_RDONLY,
>         },
>  };
>
> @@ -5074,6 +5074,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>         enum bpf_reg_type expected, type = reg->type;
>         const struct bpf_reg_types *compatible;
> +       u32 compatible_flags;
>         int i, j;
>
>         compatible = compatible_reg_types[base_type(arg_type)];
> @@ -5082,6 +5083,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>                 return -EFAULT;
>         }
>
> +       /* If arg_type is tagged with MEM_RDONLY, it's compatible with both
> +        * RDONLY and non-RDONLY reg values. Therefore fold this flag before
> +        * comparison. PTR_MAYBE_NULL is similar.
> +        */
> +       compatible_flags = arg_type & (MEM_RDONLY | PTR_MAYBE_NULL);
> +       type &= ~compatible_flags;
> +

wouldn't

type &= ~MEM_RDONLY; /* clear read-only flag, if any */
type &= ~PTR_MAYBE_NULL; /* clear nullable flag, if any */

be cleaner and more straightforward?


>         for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
>                 expected = compatible->types[i];
>                 if (expected == NOT_INIT)

[...]

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA01443AB88
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhJZFI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 01:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhJZFIz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 01:08:55 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D25C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 22:06:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a6so20784641ybq.9
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 22:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwHqXxzZndKkWC4sUYpXMDeQr59tLCOaBQcxvQepxao=;
        b=UZO+C/A9Saadsv3LeYiFmuXam6tzjPfDJ7eHIl4U7Fh9Cry8vYZdnJHy6WPDWRT1Z2
         kY2M1MmCm4U5piHkuxMV2PJPgwzGI792Qiq49EQg6A+M/EBECMAFL/hKMxz3luP5cSFe
         WuDJ4JdumNRE2F/EIWAAb1y3pdIM9DDmyMHGTGhRBJ9US5ZfQmirBTAtQWegogxEAniQ
         kUFLDd+zqEmup/SOYtk4/6NScKqeSZaeLR6ixmbV0hifznZoNRg1nRxNKcdVppZQOmCC
         Uy0qxqYuCAIR3Po76KKyIqF4nQeW0KT2uIHR2nk19JLSi56gN5eWz5ISP46toyxmVSNc
         YYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwHqXxzZndKkWC4sUYpXMDeQr59tLCOaBQcxvQepxao=;
        b=BqsHj6CRGKtxQA8NliQy89TIEGk6IwWqntgL8LpQqEWzvb7XvswaJyfYElA1WLySoa
         e5RJUUmfglJ537uRZY1V65+SNdjrF4H17y3vRkRflEo4B1uLG+O2qGE5mnZXrTaATqOU
         a9Ex2L77vp711rFxRY6LOY8xx2B2/04aHkyG5IEnSEIE93Puv5Q/yiAjGBuStC9xKmQr
         GEYN3UO+TGEleGFMB99izln8s8xDEcLsaK0AjbubHOPY1ZeoLmXpwDwSdXADPtWvDBYo
         Tr2Z7n5AT5h7GkP5Qx8LkRPh+EQS4UCyDQLqa1vX1qyT2tLxUbwTIbRZ1s0Ub8kHOWZ+
         1NDA==
X-Gm-Message-State: AOAM532hBvqxRtAytCD3Tzq8mG05PhkcZc+UiyA98/7KTnXOJywnvP/i
        YPX87cnjJFrYCeYpsJP420up8IjyQNuAl0R7sU0=
X-Google-Smtp-Source: ABdhPJzhiWwDfqznYFQ4RCSpES+QK9W4atUyuD6bCM3ONJ8WFv5MCJYHWPKUN5cANgNRoyps+ZqUxG+OqOyDnRtyCFw=
X-Received: by 2002:a25:cf50:: with SMTP id f77mr8488680ybg.114.1635224791096;
 Mon, 25 Oct 2021 22:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
In-Reply-To: <20211025231256.4030142-3-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 22:06:20 -0700
Message-ID: <CAEf4Bzb_nUqXtJ0FhKJVjxJjt8vjTPxuTzrEzDFN_kqGw3wuCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 4:13 PM Hao Luo <haoluo@google.com> wrote:
>
> Some helper functions may modify its arguments, for example,
> bpf_d_path, bpf_get_stack etc. Previously, their argument types
> were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> to modify a read-only memory by passing it into one of such helper
> functions.
>
> This patch introduces a new arg type ARG_PTR_TO_WRITABLE_MEM to
> annotate the arguments that may be modified by the helpers. For
> arguments that are of ARG_PTR_TO_MEM, it's ok to take any mem type,
> while for ARG_PTR_TO_WRITABLE_MEM, readonly mem reg types are not
> acceptable.
>
> In short, when a helper may modify its input parameter, use
> ARG_PTR_TO_WRITABLE_MEM instead of ARG_PTR_TO_MEM.

This is inconsistent with the other uses where we have something
that's writable by default and mark it as RDONLY if it's read-only.
Same here, why not keep ARG_PTR_TO_MEM to mean "writable memory", and
add ARG_PTR_TO_RDONLY_MEM for helpers that are not writing into the
memory? It will also be safer default: if helper defines
ARG_PTR_TO_MEM but never writes to it, worst thing that can happen
would be that you won't be able to pass REG_PTR_TO_RDONLY_MEM into it
without fixing helper definition. The other way is more dangerous. If
ARG_PTR_TO_MEM means read-only mem and helper forgot this distinction
and actually writes into the memory, then we are in much bigger
trouble.

>
> So far the difference between ARG_PTR_TO_MEM and ARG_PTR_TO_WRITABLE_MEM
> is PTR_TO_RDONLY_BUF and PTR_TO_RDONLY_MEM. PTR_TO_RDONLY_BUF is
> only used in bpf_iter prog as the type of key, which hasn't been
> used in the affected helper functions. PTR_TO_RDONLY_MEM currently
> has no consumers.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  Changes since v1:
>   - new patch, introduced ARG_PTR_TO_WRITABLE_MEM to differentiate
>     read-only and read-write mem arg types.
>
>  include/linux/bpf.h      |  9 +++++++++
>  kernel/bpf/cgroup.c      |  2 +-
>  kernel/bpf/helpers.c     |  2 +-
>  kernel/bpf/verifier.c    | 18 ++++++++++++++++++
>  kernel/trace/bpf_trace.c |  6 +++---
>  net/core/filter.c        |  6 +++---
>  6 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7b47e8f344cb..586ce67d63a9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -341,6 +341,15 @@ enum bpf_arg_type {
>         ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
>         ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
>         ARG_PTR_TO_TIMER,       /* pointer to bpf_timer */
> +       ARG_PTR_TO_WRITABLE_MEM,        /* pointer to valid memory. Compared to
> +                                        * ARG_PTR_TO_MEM, this arg_type is not
> +                                        * compatible with RDONLY memory. If the
> +                                        * argument may be updated by the helper,
> +                                        * use this type.
> +                                        */
> +       ARG_PTR_TO_WRITABLE_MEM_OR_NULL,   /* pointer to memory or null, similar to
> +                                           * ARG_PTR_TO_WRITABLE_MEM.
> +                                           */
>         __BPF_ARG_TYPE_MAX,
>  };
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 03145d45e3d5..683269b7cd92 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1666,7 +1666,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
>         .arg3_type      = ARG_CONST_SIZE,
>         .arg4_type      = ARG_ANYTHING,
>  };
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 14531757087f..db98385ee7af 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1008,7 +1008,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
>         .func           = bpf_snprintf,
>         .gpl_only       = true,
>         .ret_type       = RET_INTEGER,
> -       .arg1_type      = ARG_PTR_TO_MEM_OR_NULL,
> +       .arg1_type      = ARG_PTR_TO_WRITABLE_MEM_OR_NULL,
>         .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
>         .arg3_type      = ARG_PTR_TO_CONST_STR,
>         .arg4_type      = ARG_PTR_TO_MEM_OR_NULL,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ae3ff297240e..d8817c3d990e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -486,6 +486,7 @@ static bool arg_type_may_be_null(enum bpf_arg_type type)
>                type == ARG_PTR_TO_CTX_OR_NULL ||
>                type == ARG_PTR_TO_SOCKET_OR_NULL ||
>                type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
> +              type == ARG_PTR_TO_WRITABLE_MEM_OR_NULL ||
>                type == ARG_PTR_TO_STACK_OR_NULL;
>  }
>
> @@ -4971,6 +4972,8 @@ static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
>  {
>         return type == ARG_PTR_TO_MEM ||
>                type == ARG_PTR_TO_MEM_OR_NULL ||
> +              type == ARG_PTR_TO_WRITABLE_MEM ||
> +              type == ARG_PTR_TO_WRITABLE_MEM_OR_NULL ||
>                type == ARG_PTR_TO_UNINIT_MEM;
>  }
>
> @@ -5075,6 +5078,19 @@ static const struct bpf_reg_types mem_types = {
>                 PTR_TO_MEM,
>                 PTR_TO_RDONLY_BUF,
>                 PTR_TO_RDWR_BUF,
> +               PTR_TO_RDONLY_MEM,
> +       },
> +};
> +
> +static const struct bpf_reg_types writable_mem_types = {
> +       .types = {
> +               PTR_TO_STACK,
> +               PTR_TO_PACKET,
> +               PTR_TO_PACKET_META,
> +               PTR_TO_MAP_KEY,
> +               PTR_TO_MAP_VALUE,
> +               PTR_TO_MEM,
> +               PTR_TO_RDWR_BUF,
>         },
>  };
>
> @@ -5125,6 +5141,8 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_UNINIT_MEM]         = &mem_types,
>         [ARG_PTR_TO_ALLOC_MEM]          = &alloc_mem_types,
>         [ARG_PTR_TO_ALLOC_MEM_OR_NULL]  = &alloc_mem_types,
> +       [ARG_PTR_TO_WRITABLE_MEM]       = &writable_mem_types,
> +       [ARG_PTR_TO_WRITABLE_MEM_OR_NULL] = &writable_mem_types,
>         [ARG_PTR_TO_INT]                = &int_ptr_types,
>         [ARG_PTR_TO_LONG]               = &int_ptr_types,
>         [ARG_PTR_TO_PERCPU_BTF_ID]      = &percpu_btf_ptr_types,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cbcd0d6fca7c..5815845222de 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -945,7 +945,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_BTF_ID,
>         .arg1_btf_id    = &bpf_d_path_btf_ids[0],
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
>         .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>         .allowed        = bpf_d_path_allowed,
>  };
> @@ -1002,7 +1002,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
>         .func           = bpf_snprintf_btf,
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
> -       .arg1_type      = ARG_PTR_TO_MEM,
> +       .arg1_type      = ARG_PTR_TO_WRITABLE_MEM,
>         .arg2_type      = ARG_CONST_SIZE,
>         .arg3_type      = ARG_PTR_TO_MEM,
>         .arg4_type      = ARG_CONST_SIZE,
> @@ -1433,7 +1433,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
>         .gpl_only       = true,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
> +       .arg2_type      = ARG_PTR_TO_WRITABLE_MEM_OR_NULL,
>         .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>         .arg4_type      = ARG_ANYTHING,
>  };
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8e8d3b49c297..7dadabe12ceb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5639,7 +5639,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
>         .gpl_only       = true,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
>         .arg3_type      = ARG_CONST_SIZE,
>         .arg4_type      = ARG_ANYTHING,
>  };
> @@ -5694,7 +5694,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
>         .gpl_only       = true,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
>         .arg3_type      = ARG_CONST_SIZE,
>         .arg4_type      = ARG_ANYTHING,
>  };
> @@ -6977,7 +6977,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
>         .arg3_type      = ARG_CONST_SIZE,
>         .arg4_type      = ARG_ANYTHING,
>  };
> --
> 2.33.0.1079.g6e70778dc9-goog
>

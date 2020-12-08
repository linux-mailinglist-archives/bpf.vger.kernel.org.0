Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA72D35F0
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 23:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgLHWI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 17:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731364AbgLHWI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 17:08:56 -0500
X-Gm-Message-State: AOAM530snzbmXi7scmEv/Rxst6FPlMy46CI6gxGVbRRZHmj46wlZVMKR
        H6ju/LWIKyV47rsNRozBvSyUEglImX8GNtL57vtjFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607465296;
        bh=J7br4+6VmGx77/7VBZgfseCUz95g64+31jTTDT3s5to=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ws8SSGdIyOUV/LoJdT9eDm8+sWO8kPtQTNGqfqQAN6Y1+gfRBsgC34eewSks3x7al
         jPDK4GwFHpOrPQuU0uxRlbpkw4SpxPPmtp5foqhAxG+yu1RqSwZGvNuERuFQvNDcXq
         US7ZO7EvN6qbsOr8deIw/u/hYWoFueY4mBtyvMvODFxVJgpgKGKk+td5A+tlkrm+6B
         MiETpht8PRvBieXgg3J6D2vTG3mD6aA3SvaWn4VrkIarrqLvwhMb22PwwI+BBlM3tB
         e/6BI52VUf4TwJIclWkk4RpBoaY2lhSjwRf5rpDraWUNlU2+CBrJ8GsENSB8USab+t
         50DJBlyCZRB+g==
X-Google-Smtp-Source: ABdhPJyiGQxFUq1siCws5D38GZ8eqcIJXn0RCbawbKZhP9JzdmJqu6p2p6oA78QUs+fK+JStXf4q29VjM+q31m+NSPQ=
X-Received: by 2002:a05:6512:11e2:: with SMTP id p2mr790473lfs.153.1607465294452;
 Tue, 08 Dec 2020 14:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20201208201533.1312057-1-revest@chromium.org> <20201208201533.1312057-2-revest@chromium.org>
In-Reply-To: <20201208201533.1312057-2-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 8 Dec 2020 23:08:03 +0100
X-Gmail-Original-Message-ID: <CANA3-0c5NtYVGa_TQqY36ZWhmFztrgmKgA9Karo-HpW0MBTkPw@mail.gmail.com>
Message-ID: <CANA3-0c5NtYVGa_TQqY36ZWhmFztrgmKgA9Karo-HpW0MBTkPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 8, 2020 at 9:20 PM Florent Revest <revest@chromium.org> wrote:
>
> This needs two new helpers, one that works in a sleepable context (using
> sock_gen_cookie which disables/enables preemption) and one that does not
> (for performance reasons). Both take a struct sock pointer and need to
> check it for NULLness.
>
> This helper could also be useful to other BPF program types such as LSM.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       |  7 +++++++
>  kernel/trace/bpf_trace.c       |  4 ++++
>  net/core/filter.c              | 24 ++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  5 files changed, 44 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d05e75ed8c1b..2ecda549b773 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1859,6 +1859,8 @@ extern const struct bpf_func_proto bpf_snprintf_btf_proto;
>  extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
>  extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
>  extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_sleepable_proto;
> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>
>  const struct bpf_func_proto *bpf_tracing_func_proto(
>         enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ba59309f4d18..9ac66cf25959 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1667,6 +1667,13 @@ union bpf_attr {
>   *     Return
>   *             A 8-byte long unique number.
>   *
> + * u64 bpf_get_socket_cookie(void *sk)
> + *     Description
> + *             Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + *             *sk*, but gets socket from a BTF **struct sock**.
> + *     Return
> + *             A 8-byte long unique number.
> + *
>   * u32 bpf_get_socket_uid(struct sk_buff *skb)
>   *     Return
>   *             The owner UID of the socket associated to *skb*. If the socket
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0cf0a6331482..99accc2146bc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1778,6 +1778,10 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_sk_storage_get_tracing_proto;
>         case BPF_FUNC_sk_storage_delete:
>                 return &bpf_sk_storage_delete_tracing_proto;
> +       case BPF_FUNC_get_socket_cookie:
> +               return prog->aux->sleepable ?
> +                      &bpf_get_socket_ptr_cookie_sleepable_proto :
> +                      &bpf_get_socket_ptr_cookie_proto;
>  #endif
>         case BPF_FUNC_seq_printf:
>                 return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 77001a35768f..34877796ab5b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4631,6 +4631,30 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
>         .arg1_type      = ARG_PTR_TO_CTX,
>  };
>
> +BPF_CALL_1(bpf_get_socket_ptr_cookie_sleepable, struct sock *, sk)
> +{
> +       return sk ? sock_gen_cookie(sk) : 0;

My understanding is you can simply always call sock_gen_cookie and not
have two protos.

This will disable preemption in sleepable programs and not have any effect
in non-sleepable programs since preemption will already be disabled.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231573170A7
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBJTwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 14:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhBJTwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 14:52:43 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE8C061786;
        Wed, 10 Feb 2021 11:52:03 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l8so3198500ybe.12;
        Wed, 10 Feb 2021 11:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4RdDmXskdI19A4WAwFntV8dNBLK9hF7TdOLyP5FEbc=;
        b=a2QbyP+xPg/eXRgAepxs4yYO+n7tR5Gc6rLZOQeXxIXU0zNdnJCz//6bCvewiCejso
         Hvfx66Mbfu5Cwy1Og8EpFX9uOlnIdHwkO8aa4JYgWzhfs2TBHfqfNMW2BYRdj//+V88b
         gKYKhDJMoSrzaXuMCK4qusugPvtIbskOC6TSjjbcwz6QgN6DxXehKIrP0lyeR6Om0KQb
         eBAXuClRVHkLEo5g6y30e2/1bVkkP0nyHDDDtk4MdlZ2TGB65qOorF2vBr92V8yYQ81a
         0HrJcGGT/kYIaonFe5HquC906gb/ZQqImygDZw/VdNWtjhIq2izPRZ7XGpFd5DeeBc2y
         c1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4RdDmXskdI19A4WAwFntV8dNBLK9hF7TdOLyP5FEbc=;
        b=Ys2GeopME5APUaMVkXP/UJA5k+EMtkDlINSHLG4iS6lqk8cYx/LbfcJWD1NwJNSiiy
         YoFb0YN2KeAUCCtLeLGz8wzbqGtqeKFe6yxnJNU9VPQz6Frlr4IQlWEn8PMb7YHO2RgS
         cq32UOk8BFcXdhbm0xWyYMnR7ON3vKKUC2aJKNp+gv1ODDgrRQK7TX47vn//WFiVOALA
         c9PbgYSBn1PnhSggTwPsWWncnxI5SlrCqisKu/0yi9RIekPpICa1mQI9MZCVRp3PiMja
         wYlSKy7mMyj7Lnlpg/Dcj9VcPtPJW7RuVM4cGrKo9ZZNCB/Wgrk+rFzRDBizv4fueiRV
         ywWw==
X-Gm-Message-State: AOAM530rz6aygxNlvEv4WDJ2ecPNmJtqXmTLub+bpzJaQ1tOMQd41dJK
        phkSf/rKmu+nxDftC53l32dL7Mmb3o76rj94zhCO01D3k/VhzQ==
X-Google-Smtp-Source: ABdhPJzB4GF38WGeL7ViEwoSyVscZQSOKbwhji7E4LMTroZ4hP1XkpNjcw95caYH6e8G5Ey0tkvROGXrWFGIiCd6jl0=
X-Received: by 2002:a25:a183:: with SMTP id a3mr6592411ybi.459.1612986722643;
 Wed, 10 Feb 2021 11:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20210210111406.785541-1-revest@chromium.org> <20210210111406.785541-2-revest@chromium.org>
In-Reply-To: <20210210111406.785541-2-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 11:51:51 -0800
Message-ID: <CAEf4BzZ9yPYicLi5j6Xp8-Mco0yy5qWetSEsYpbzf14=CTa0_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@google.com>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 3:14 AM Florent Revest <revest@chromium.org> wrote:
>
> This needs a new helper that:
> - can work in a sleepable context (using sock_gen_cookie)
> - takes a struct sock pointer and checks that it's not NULL
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: KP Singh <kpsingh@kernel.org>
> ---

It's customary to send cover letter with patch sets of 2 or more
related patches. It's a good place to explain the motivation of a
patch set. And a good place to ack all patches in one go ;)

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  net/core/filter.c              | 12 ++++++++++++
>  tools/include/uapi/linux/bpf.h |  8 ++++++++
>  5 files changed, 31 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 321966fc35db..d212ae7d9731 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1888,6 +1888,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
>  extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
>  extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
>  extern const struct bpf_func_proto bpf_sock_from_file_proto;
> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>
>  const struct bpf_func_proto *bpf_tracing_func_proto(
>         enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0b735c2729b2..a8d9ad543300 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1673,6 +1673,14 @@ union bpf_attr {
>   *     Return
>   *             A 8-byte long unique number.
>   *
> + * u64 bpf_get_socket_cookie(struct sock *sk)
> + *     Description
> + *             Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + *             *sk*, but gets socket from a BTF **struct sock**. This helper
> + *             also works for sleepable programs.
> + *     Return
> + *             A 8-byte long unique number or 0 if *sk* is NULL.
> + *
>   * u32 bpf_get_socket_uid(struct sk_buff *skb)
>   *     Return
>   *             The owner UID of the socket associated to *skb*. If the socket
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6c0018abe68a..845b2168e006 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1760,6 +1760,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_sk_storage_delete_tracing_proto;
>         case BPF_FUNC_sock_from_file:
>                 return &bpf_sock_from_file_proto;
> +       case BPF_FUNC_get_socket_cookie:
> +               return &bpf_get_socket_ptr_cookie_proto;
>  #endif
>         case BPF_FUNC_seq_printf:
>                 return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e15d4741719a..57aaed478362 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4631,6 +4631,18 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
>         .arg1_type      = ARG_PTR_TO_CTX,
>  };
>
> +BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
> +{
> +       return sk ? sock_gen_cookie(sk) : 0;
> +}
> +
> +const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
> +       .func           = bpf_get_socket_ptr_cookie,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +};
> +
>  BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
>  {
>         return __sock_gen_cookie(ctx->sk);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 0b735c2729b2..a8d9ad543300 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1673,6 +1673,14 @@ union bpf_attr {
>   *     Return
>   *             A 8-byte long unique number.
>   *
> + * u64 bpf_get_socket_cookie(struct sock *sk)
> + *     Description
> + *             Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + *             *sk*, but gets socket from a BTF **struct sock**. This helper
> + *             also works for sleepable programs.
> + *     Return
> + *             A 8-byte long unique number or 0 if *sk* is NULL.
> + *
>   * u32 bpf_get_socket_uid(struct sk_buff *skb)
>   *     Return
>   *             The owner UID of the socket associated to *skb*. If the socket
> --
> 2.30.0.478.g8a0d178c01-goog
>

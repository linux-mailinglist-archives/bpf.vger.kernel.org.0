Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1DD306595
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhA0VCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 16:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhA0VCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 16:02:11 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E43C06174A;
        Wed, 27 Jan 2021 13:01:30 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v200so3403057ybe.1;
        Wed, 27 Jan 2021 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy1qnWr8G9KewqKj/7L8TJt0Bxkal0QntRDdb/XRuX4=;
        b=mCCtnG6sIGTyRrUdohq/badjauCI4GzRWMTnqI/nRxLnRZSPu16lRLIXMlRPghDEfX
         U1Wc348KQZqVka4gXKYo5Awx80GK7UJnTk9g7KEoTJtgDYxXvD+g3PH7jaxo0dbXbNfF
         WmSUge2zQbr+Mx0iiR3tyf994wCyAKr0RqDBFrgB7TX9MwB0bQ+LrYJkl+Cl7IWTa/4E
         FhXeijJk621vpcUxxNTu/Lw/I4hc0axXTGaUHcNgZudnrWYG8OVFA37c9V3LkNDMqz5Q
         1IWeBnJBUmSt7dphg3SmqpA98rJgOOxR7GRf6KLW9TVpjAeS9QzTmtI2TdKKc/McxcCe
         W5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy1qnWr8G9KewqKj/7L8TJt0Bxkal0QntRDdb/XRuX4=;
        b=W9y6LASnNL6frO+JvJStxRDoIzJ9MIXsPinMzBveVVUXY/evUBTxGOEHwBT8cO5wCt
         AL2hGhfFhKY6kKbh7lNcsYwQNTF+U2YybxCVTkw+Wp5DzID+XhvX+jmc+yLdEBPOov/s
         ARcBFHycVbs769x4/Pi9Bh2nRsmghwxiencVQ+FTezbcOou3kVXcZ6/TYpTMl/0z/147
         DrmRgVpawPpdTI6Y8z//ahoQnly0ZAQ2IGQ8xKRlYqbqrBu3MX9pLeZbH7319rXTFHVa
         B7aG4roMZJG4ag5qXnT4DmbWmsf1LPjC3IjHf11B0goD5YbuvBa+6m8+vPxC0bLThMEh
         vh1A==
X-Gm-Message-State: AOAM5314TTPhOSIyYt854doMhtqccbrUGJnXo9GxLo1w23YIyzFm+KNT
        2iIv8XNYTYNaf9VIAM7wOmGHzWD4Ut36ys+xayNrp8R8dVGA5g==
X-Google-Smtp-Source: ABdhPJydAK0+KtirHmXenJRJ+RO3ZwDEx3AW3yiIFPd+X1h+yXpGR6dynhP+hQkVj3tsKwRmjbjeY0U3lMvFPdVmwhQ=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr18507027yba.403.1611781290223;
 Wed, 27 Jan 2021 13:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20210126183559.1302406-1-revest@chromium.org> <20210126183559.1302406-2-revest@chromium.org>
In-Reply-To: <20210126183559.1302406-2-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jan 2021 13:01:18 -0800
Message-ID: <CAEf4BzZ9MmdeR9P7bybXEM77MV6C-T=yZPugLOHSFC1ES2e4=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 10:36 AM Florent Revest <revest@chromium.org> wrote:
>
> This needs a new helper that:
> - can work in a sleepable context (using sock_gen_cookie)
> - takes a struct sock pointer and checks that it's not NULL
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  net/core/filter.c              | 12 ++++++++++++
>  tools/include/uapi/linux/bpf.h |  8 ++++++++
>  5 files changed, 31 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1aac2af12fed..26219465e1f7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1874,6 +1874,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
>  extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
>  extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
>  extern const struct bpf_func_proto bpf_sock_from_file_proto;
> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>
>  const struct bpf_func_proto *bpf_tracing_func_proto(
>         enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0b735c2729b2..5855c398d685 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1673,6 +1673,14 @@ union bpf_attr {
>   *     Return
>   *             A 8-byte long unique number.
>   *
> + * u64 bpf_get_socket_cookie(void *sk)

should the type be `struct sock *` then?

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
> index 9ab94e90d660..606e2b6115ed 100644
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
> index 0b735c2729b2..5855c398d685 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1673,6 +1673,14 @@ union bpf_attr {
>   *     Return
>   *             A 8-byte long unique number.
>   *
> + * u64 bpf_get_socket_cookie(void *sk)
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
> 2.30.0.280.ga3ce27912f-goog
>

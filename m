Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108F730634F
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 19:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhA0S3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 13:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhA0S3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 13:29:09 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7BEC061573
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 10:28:28 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id o18so2120602qtp.10
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CByxNOen19Ah/fWze4y/yfnlj1YLYzVNQo3bQZg2XA=;
        b=gO0ExQHkYRA9VsMxloMyZflDtmDfxt8XVdmA4zKJ4M630Raugn4OZwKqeMK1PqjZk9
         cie05fH512rhJxXzLIAAJjggJftFLwznQnt6zU3YbYnWb6GBIqR464tUHwNoA6l1no2p
         YrjeCGN7hw80htGjsLxdAAAbp1AiEcptAZIzigadT4xOj7dMQbOcuyA4ymE55kc5T6TY
         T6KuMqhz5fga6Grh/1TqlPZHbvMOTMnKzoexnoKcfDIgEqgDmhbxaeoAYZimz5XbQ6Ic
         lHYtaJ1GpPCT44lWbhER71nqaQ/Ssjj4ob6YA7UVN10mzuXnJ0x8MPlfzdTXGmkuNeO2
         b+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CByxNOen19Ah/fWze4y/yfnlj1YLYzVNQo3bQZg2XA=;
        b=dmq+Cgys/h8tSfnmOvTXRKEFtWudKSIHzFv46Umr8OvCvwRVdWVhpbbx/hFC7a068N
         Sqp36nPQlqd5+2ZKOt7UpixtTc3o0SncKR1LjXObvLjTNtjIGXXL/3EKoXfWPHV0Gm/H
         WXL4SMZWnRrv9l/9BPa/MDyBgELKS/yX1Bg2ANY4yQ1Qct/Vp3DKmYfhBbGkW1LLu1L3
         ZlXZTSQsZI3/iDbnF+iEhKKD/Jj3h7t58s48S5OGm86dTTPqh1gGv4WfIk5s3RFyGgGE
         0aLjWxr7kM7roTW760WFlGjyJDkl7Fjy2OyNbFJVW2t+Nas9KzuxE++hA2PeRai51InI
         r35g==
X-Gm-Message-State: AOAM532jECTnMkzME9zF8H1s29YuBxNRbC0I7cbRkN1q4iryX1pZ1Trn
        bUEaR5Ya1aIGFUCbLmeeU6INcWUylG+rx0V4QT1gbA==
X-Google-Smtp-Source: ABdhPJzAYpMqkE0EF+0+8UpXduj53G64S1GhDxo+WS3xWSjcd11qWJn4AQjRerAf4I9NguND6JImMGO6UfNsIEJLtjs=
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr10971600qtb.98.1611772107889;
 Wed, 27 Jan 2021 10:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20210126193544.1548503-1-sdf@google.com> <YBGv3eYgNQrYBuEl@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <YBGv3eYgNQrYBuEl@rdna-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 27 Jan 2021 10:28:16 -0800
Message-ID: <CAKH8qBtaeddXMj6NENgvsDOzKcrNWH9RD-jhcqDBxSF8YB0oUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: allow rewriting to ports under ip_unprivileged_port_start
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 27, 2021 at 10:24 AM Andrey Ignatov <rdna@fb.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> [Tue, 2021-01-26 11:36 -0800]:
> > At the moment, BPF_CGROUP_INET{4,6}_BIND hooks can rewrite user_port
> > to the privileged ones (< ip_unprivileged_port_start), but it will
> > be rejected later on in the __inet_bind or __inet6_bind.
> >
> > Let's add another return value to indicate that CAP_NET_BIND_SERVICE
> > check should be ignored. Use the same idea as we currently use
> > in cgroup/egress where bit #1 indicates CN. Instead, for
> > cgroup/bind{4,6}, bit #1 indicates that CAP_NET_BIND_SERVICE should
> > be bypassed.
> >
> > v4:
> > - Add missing IPv6 support (Martin KaFai Lau)
> >
> > v3:
> > - Update description (Martin KaFai Lau)
> > - Fix capability restore in selftest (Martin KaFai Lau)
> >
> > v2:
> > - Switch to explicit return code (Martin KaFai Lau)
> >
> > Cc: Andrey Ignatov <rdna@fb.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> Explicit return code looks much cleaner than both what v1 did and what I
> proposed earlier (compare port before/after).
>
> Just one nit from me but otherwide looks good.
>
> Acked-by: Andrey Ignatov <rdna@fb.com>
>
> ...
> > @@ -231,30 +232,48 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> >
> >  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, type)                                     \
> >  ({                                                                          \
> > +     u32 __unused_flags;                                                    \
> >       int __ret = 0;                                                         \
> >       if (cgroup_bpf_enabled(type))                                          \
> >               __ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
> > -                                                       NULL);               \
> > +                                                       NULL,                \
> > +                                                       &__unused_flags);    \
> >       __ret;                                                                 \
> >  })
> >
> >  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, type, t_ctx)                 \
> >  ({                                                                          \
> > +     u32 __unused_flags;                                                    \
> >       int __ret = 0;                                                         \
> >       if (cgroup_bpf_enabled(type))   {                                      \
> >               lock_sock(sk);                                                 \
> >               __ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
> > -                                                       t_ctx);              \
> > +                                                       t_ctx,               \
> > +                                                       &__unused_flags);    \
> >               release_sock(sk);                                              \
> >       }                                                                      \
> >       __ret;                                                                 \
> >  })
> >
> > -#define BPF_CGROUP_RUN_PROG_INET4_BIND_LOCK(sk, uaddr)                              \
> > -     BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_INET4_BIND, NULL)
> > -
> > -#define BPF_CGROUP_RUN_PROG_INET6_BIND_LOCK(sk, uaddr)                              \
> > -     BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_INET6_BIND, NULL)
> > +/* BPF_CGROUP_INET4_BIND and BPF_CGROUP_INET6_BIND can return extra flags
> > + * via upper bits of return code. The only flag that is supported
> > + * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
> > + * should be bypassed.
> > + */
> > +#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, type, flags)          \
> > +({                                                                          \
> > +     u32 __flags = 0;                                                       \
> > +     int __ret = 0;                                                         \
> > +     if (cgroup_bpf_enabled(type))   {                                      \
> > +             lock_sock(sk);                                                 \
> > +             __ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
> > +                                                       NULL, &__flags);     \
> > +             release_sock(sk);                                              \
> > +             if (__flags & 1)                                               \
> > +                     *flags |= BIND_NO_CAP_NET_BIND_SERVICE;                \
>
> Nit: It took me some time to realize that there are two different
> "flags": one to pass to __cgroup_bpf_run_filter_sock_addr() and another
> to pass to __inet{,6}_bind/BPF_CGROUP_RUN_PROG_INET_BIND_LOCK that both carry
> "BIND_NO_CAP_NET_BIND_SERVICE" flag but do it differently:
> * hard-coded 0x1 in the former case;
> * and BIND_NO_CAP_NET_BIND_SERVICE == (1 << 3) in the latter.
>
> I'm not sure how to make it more readable: maybe name `flags` and
> `__flags` differently to highlight the difference (`bind_flags` and
> `__flags`?) and add a #define for the "1" here?
>
> In anycase IMO it's not worth a respin and can be addressed by a
> follow-up if you agree.
Yeah, I agree, I didn't stress too much about it because we also
have ret and _ret in BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY
(and now BPF_PROG_RUN_ARRAY_FLAGS), but it looks confusing.
Let me respin with bind_flags, shouldn't be too much work and
can help with the readability in the future. Thanks for the review!

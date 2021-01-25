Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4330303A
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 00:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbhAYXdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 18:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732724AbhAYXdp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 18:33:45 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBD6C061574
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 15:33:05 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l27so3885480qki.9
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffujdJW+gNhXJKaPHar54gAtdwQyA5xDLj9UsevBGj8=;
        b=rJwh9QdrSbjo08xID1IF/jShfyQsLX7VG1xAPh+I2oYPsmQmnXrRUI9EVxRTqrux0P
         EtZVIBiBFpI5WEub7OMf/V2ROo1IRzGwqM2yaWixpuDW4I/3RR7Sd6bGz8qI5cOF90f5
         ww2KGWFpQYAE0DRzucP95RuksA2XrzzjwdHNQ+8Qt3+HgcbADHhnqpWokpiz00+0XYl+
         s9cmZkIzA5s8DXDLBa0vvJtguQFTki93JpD7227CHo0F2GMm15r9R2+u2UEHZJIdklZ0
         jazotqCgamnOPc4DpLy7y7F1jQiq7t/kQRdh6/OboudjCK/gqZjIaFEO0ZsthZgVznmA
         C+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffujdJW+gNhXJKaPHar54gAtdwQyA5xDLj9UsevBGj8=;
        b=TsnKfBsc//PBXsKsx2W3LP7st4YN/a+T4UGLoHp2N7J4qbMFyxzbCNkSy2e/YyjDww
         4LQBt/luDyyNXpW8F/VnGLMOk3VOKk2aXTJcMz18r4kxIn5loiuNc34mpUUHbaL8yd65
         cHdb4wGmVokFI61+x3+GzCHiACF7m4RPNkRNmOhUKA5NjpZMuXT1dPYcL2QnttPmKt7k
         pdQrd3zaew8lFHUXd7BcHRVw4KjtCfvW6sc2uJzOFzM1+Q2Rz2wH4j1cAYGZ+Zwd/kE4
         6b6TrFFBuli+9UROQWH6C8CxHmNCh03zv5dn0gZC7Mo976R/7Dx7BWPE1F95w+U9FH21
         vUpQ==
X-Gm-Message-State: AOAM532nc1qtKde2HVb9j/uU8k9+hHWZZcIAo44noJvgE6qpJZBvl7OU
        PuYx3SM1xjo972kfhwIOQJj0hKs3MajJoKc0De4duQ==
X-Google-Smtp-Source: ABdhPJx7X6KHlOawIJCTzYuFuKF2vPTMMPrfNTXntEOrNaXxw4O8T+c5WmyyPh/liGx82u9lTWyYIxnm0Ktg4ns5/XM=
X-Received: by 2002:a37:6c81:: with SMTP id h123mr3339689qkc.448.1611617584563;
 Mon, 25 Jan 2021 15:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20210125172641.3008234-1-sdf@google.com> <20210125232500.fmb4trbady6jfdfp@kafai-mbp>
In-Reply-To: <20210125232500.fmb4trbady6jfdfp@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 25 Jan 2021 15:32:53 -0800
Message-ID: <CAKH8qBuz2uVO2oB3rDMqcw41FOWbx5HS0vUPT2KLv_6rhZuyrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: allow rewriting to ports under ip_unprivileged_port_start
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 3:25 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Jan 25, 2021 at 09:26:40AM -0800, Stanislav Fomichev wrote:
> > At the moment, BPF_CGROUP_INET{4,6}_BIND hooks can rewrite user_port
> > to the privileged ones (< ip_unprivileged_port_start), but it will
> > be rejected later on in the __inet_bind or __inet6_bind.
> >
> > Let's export 'port_changed' event from the BPF program and bypass
> > ip_unprivileged_port_start range check when we've seen that
> > the program explicitly overrode the port. This is accomplished
> > by generating instructions to set ctx->port_changed along with
> > updating ctx->user_port.
> The description requires an update.
Ah, sure, will update it.

> [ ... ]
>
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index da649f20d6b2..cdf3c7e611d9 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1055,6 +1055,8 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
> >   * @uaddr: sockaddr struct provided by user
> >   * @type: The type of program to be exectuted
> >   * @t_ctx: Pointer to attach type specific context
> > + * @flags: Pointer to u32 which contains higher bits of BPF program
> > + *         return value (OR'ed together).
> >   *
> >   * socket is expected to be of type INET or INET6.
> >   *
> > @@ -1064,7 +1066,8 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
> >  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >                                     struct sockaddr *uaddr,
> >                                     enum bpf_attach_type type,
> > -                                   void *t_ctx)
> > +                                   void *t_ctx,
> > +                                   u32 *flags)
> >  {
> >       struct bpf_sock_addr_kern ctx = {
> >               .sk = sk,
> > @@ -1087,7 +1090,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> >       }
> >
> >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > -     ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RUN);
> > +     ret = BPF_PROG_RUN_ARRAY_FLAGS(cgrp->bpf.effective[type], &ctx,
> > +                                    BPF_PROG_RUN, flags);
> >
> >       return ret == 1 ? 0 : -EPERM;
> >  }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d0eae51b31e4..ef7c3ca53214 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7986,6 +7986,11 @@ static int check_return_code(struct bpf_verifier_env *env)
> >                   env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
> >                   env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME)
> >                       range = tnum_range(1, 1);
> > +             if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
> > +                 env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND) {
> > +                     range = tnum_range(0, 3);
> > +                     enforce_attach_type_range = tnum_range(0, 3);
> It should be:
>                         enforce_attach_type_range = tnum_range(2, 3);
Hm, weren't we enforcing attach_type for bind progs from the beginning?
Also, looking at bpf_prog_attach_check_attach_type, it seems that we
care only about BPF_PROG_TYPE_CGROUP_SKB for
prog->enforce_expected_attach_type.
Am I missing something?

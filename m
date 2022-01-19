Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D644941AA
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 21:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbiASUWR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 15:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiASUWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 15:22:16 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ECAC061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 12:22:16 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id f24so6721050uab.11
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QDttiEv5twtAfYPlNXTQif9E8Zlclz38TyVgv46XG4=;
        b=fw/Etc2K8ET60s5qVWV1uQty8ucdXrKwzTXTpHqkp553lJW15eUaRMQ9z2iwbKt/R7
         dG91LSmdYp44w1ZABOn0PyFkwzhu4HlXLGL4TfkMgu/ZnAaGwXimyXNvB1PIufX3vV9c
         2L26viX02Lr92nzk0I/EcMMmYX7wDYnsmzm6xV6FPhBTdEAxrvUX01tcxDvHEJnCZp4F
         +GbOO0VxCMQaKdkvCuwgYNRlr9FwNB8KkQzz1fmbR9vxU1bj4HwzyR4Tx5GRJ/Q0rL4z
         VRjOFx48m5or4k0cwAQm+01Qa5srdPkSe2wnmzoFv3BckJx6V/gHChsOQuI6huBoEjnb
         WJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QDttiEv5twtAfYPlNXTQif9E8Zlclz38TyVgv46XG4=;
        b=Kyx1mEaeFkVHV6qAOyTU7vHqvYcNnwSct+l8NmUT79xqkExUMdRluHRAQQTSUx7G+T
         WvOJMBmhvh36v0+DFzlOwPoE1M5cD09cmOwZ9IethX+qfxZ88TdkY9D1LeDR8mYSa1Pq
         erZAR/Eq068Sfl7E9f1qywdnKFnHu26pCUZ+tEl7ixZ3NswjPtEyhBRYr/QxtRqmXBlF
         sxTVA3J3EL92blFn2rPMN1fHu1b4kZc16FkeMmmetATPXiCNX+YkcywyLt7QVkQvu6iI
         valwicETWZoo89E4zYhh+LVQQYnhvKj+3qqeNxAtGGoFyqNGDDtfOdriLL6+3iVKoW4s
         gVqw==
X-Gm-Message-State: AOAM532MMegQ2Ks8byEAtMn6I/sEd1hfq/cL8Ybl+Y7Wi29H0GFQmzkr
        nvwg+1ZhE0E9STQ8ahIQ8f0AQ0UrZghNJmX2rBMm+yDhx/d7aQ==
X-Google-Smtp-Source: ABdhPJwEFA9693tFxjhSCO2QRG2uKE9h+nGiKoMaxWDPyyUcJUOOeO+nr9EGQpGy5eR1hrEtCJzOgBDBTVJwf2N4Swg=
X-Received: by 2002:ab0:45ae:: with SMTP id u43mr3952040uau.91.1642623735475;
 Wed, 19 Jan 2022 12:22:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641316155.git.zhuyifei@google.com> <833b122afaeaba4485942c563ef16a64fa997fe6.1641316155.git.zhuyifei@google.com>
 <CAADnVQLCw+zyC6q=-HSURO4SpkAmSR1bwz8YLwL3nonUkeJ9Xg@mail.gmail.com>
In-Reply-To: <CAADnVQLCw+zyC6q=-HSURO4SpkAmSR1bwz8YLwL3nonUkeJ9Xg@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Wed, 19 Jan 2022 12:22:04 -0800
Message-ID: <CAA-VZPkmO7Po2U4N_=eoj_iwiEimAGdRF7RvXD6pAOc08a8Dig@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Add cgroup helpers
 bpf_{get,set}_retval to get/set syscall return value
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 11:50 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 4, 2022 at 9:15 AM YiFei Zhu <zhuyifei@google.com> wrote:
> >
> > The helpers continue to use int for retval because all the hooks
> > are int-returning rather than long-returning. The return value of
> > bpf_set_retval is int for future-proofing, in case in the future
> > there may be errors trying to set the retval.
> >
> > After the previous patch, if a program rejects a syscall by
> > returning 0, an -EPERM will be generated no matter if the retval
> > is already set to -err. This patch change it being forced only if
> > retval is not -err. This is because we want to support, for
> > example, invoking bpf_set_retval(-EINVAL) and return 0, and have
> > the syscall return value be -EINVAL not -EPERM.
> >
> > This change is reflected in the sockopt_sk test which has been
> > updated to assert the errno is EINVAL instead of the EPERM.
> > The eBPF prog has to explicitly bpf_set_retval(-EPERM) if EPERM
> > is wanted. I also removed the explicit mentions of EPERM in the
> > comments in the prog.
> >
> > For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> > that, if the return value is NET_XMIT_DROP, the packet is silently
> > dropped. We preserve this behavior for backward compatibility
> > reasons, so even if an errno is set, the errno does not return to
> > caller. However, setting a non-err to retval cannot propagate so
> > this is not allowed and we return a -EFAULT in that case.
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/bpf.h                           | 10 +++--
> >  include/uapi/linux/bpf.h                      | 18 +++++++++
> >  kernel/bpf/cgroup.c                           | 38 ++++++++++++++++++-
> >  tools/include/uapi/linux/bpf.h                | 18 +++++++++
> >  .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
> >  .../testing/selftests/bpf/progs/sockopt_sk.c  | 32 ++++++++--------
> >  6 files changed, 96 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 88f6891e2b53..300df48fa0e0 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1300,7 +1300,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
> >         while ((prog = READ_ONCE(item->prog))) {
> >                 run_ctx.prog_item = item;
> >                 func_ret = run_prog(prog, ctx);
> > -               if (!(func_ret & 1))
> > +               if (!(func_ret & 1) && !IS_ERR_VALUE((long)run_ctx.retval))
> >                         run_ctx.retval = -EPERM;
> >                 *(ret_flags) |= (func_ret >> 1);
> >                 item++;
> > @@ -1330,7 +1330,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
> >         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> >         while ((prog = READ_ONCE(item->prog))) {
> >                 run_ctx.prog_item = item;
> > -               if (!run_prog(prog, ctx))
> > +               if (!run_prog(prog, ctx) && !IS_ERR_VALUE((long)run_ctx.retval))
> >                         run_ctx.retval = -EPERM;
> >                 item++;
> >         }
> > @@ -1390,7 +1390,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> >   *   0: NET_XMIT_SUCCESS  skb should be transmitted
> >   *   1: NET_XMIT_DROP     skb should be dropped and cn
> >   *   2: NET_XMIT_CN       skb should be transmitted and cn
> > - *   3: -EPERM            skb should be dropped
> > + *   3: -err              skb should be dropped
> >   */
> >  #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)                \
> >         ({                                              \
> > @@ -1399,10 +1399,12 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> >                 u32 _ret;                               \
> >                 _ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, 0, &_flags); \
> >                 _cn = _flags & BPF_RET_SET_CN;          \
> > +               if (_ret && !IS_ERR_VALUE((long)_ret))  \
> > +                       _ret = -EFAULT;                 \
> >                 if (!_ret)                              \
> >                         _ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);  \
> >                 else                                    \
> > -                       _ret = (_cn ? NET_XMIT_DROP : -EPERM);          \
> > +                       _ret = (_cn ? NET_XMIT_DROP : _ret);            \
>
> Sorry for the long delay in reviewing.
> Overall it looks very good.
> Few questions:
>
> Why change this behavior for BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY ?
> It's for an inet_egress hook only. In other words ip_output.
> What kind of different error codes do you want to pass to
> the stack from there?

I don't really have a use case in mind for a different error code for
an egress hook (my use cases are for sockopt hooks) at the moment, but
it sounds to me that it would a surprising behavior if bpf_set_retval
is provided yet it would still be -EPERM.

> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > index 4b937e5dbaca..164aa5020bf1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > @@ -177,7 +177,7 @@ static int getsetsockopt(void)
> >         optlen = sizeof(buf.zc);
> >         errno = 0;
> >         err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
> > -       if (errno != EPERM) {
> > +       if (errno != EINVAL) {
>
> Could you explain which part of this patch caused this change
> in user visible behavior?
> I understand the desire to do bpf_set_retval(-EINVAL) and return 0,
> but progs/sockopt_sk.c is not doing it.
> Where does EINVAL come from?

This comes from the kernel. In for an anvalid address to the
getsockopt handler in tcp_zerocopy_receive [1]. The original behavior
prior to this series is that the eBPF getsockopt hook generating an
-EPERM overrides that of the kernel's -EINVAL, but now when the eBPF
hook returns 0, it sees that an -EINVAL is already set by the kernel
and does not modify the error code.

[1] https://elixir.bootlin.com/linux/v5.16.1/source/net/ipv4/tcp.c#L2060

YiFei Zhu

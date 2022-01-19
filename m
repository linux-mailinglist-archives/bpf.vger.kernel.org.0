Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4349427A
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiASV32 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 16:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiASV32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 16:29:28 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85291C06161C
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 13:29:26 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v74so219798pfc.1
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AGlKU0FUbIK6neH1CDESK3Rg2GfyXYormcbQTVeZLA=;
        b=IBTFvXD9kiaphP4IyLpStz4Aabx9KjEabxN0CZHGxOQax2AYNTYEZekPU3FaUdsQMV
         IpZK60tkcC1UQUKsaY71PYXXFGfneN0zeCx38ABo/VJ2v7gRGslUZX+Pd+4HKcUVGTwE
         8jv5NcQ1OycOGOjj6lI7FIQFPUYQ43v+hQf4WMJyoLa5k4DzdrN+Alg14twIDsHVaMNd
         xxUymwbIOupjnexHdeVcPCERIwoR10LIp5+khVUp8Cd/VuzymZWsprYWhVjW98mZonCL
         FlL2DJtdLxN4QjkeGJrb01a2RuG14IG+B8++ZP7pBA7a8O31pUhoxdAeesjHCvjCwqmY
         b6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AGlKU0FUbIK6neH1CDESK3Rg2GfyXYormcbQTVeZLA=;
        b=IlSL71KpfTGuZDYdGzBGg07aSwVIUUGY6potxuazdDOKl6EcbPuLtwR59/GuZSxh0g
         YY5H4C1Rmqxu8ehpEtuFzGs5nFqN8FQsLsM3O3rtzIr9ZBJB7EDb8G3pzmMbmqORVK4j
         i9qfLtEtx/tPc5EobWR1YvoLm9bfjZyQ2d+paCLJ65jNP+QruQf6+N+Bw8USpvAy49dp
         sKg2bLNCrSaslUxEubvA9825UBLBG65IPhBEdSQBQqgaseuGyMmI22ellQhYSPMbccfW
         wuiUC2vrqJrXolga+WHUzsyKiYvr+DIArmrA/r2+WNhXgwZ4aX31hL0T0NUxlsaM6K72
         3wJw==
X-Gm-Message-State: AOAM5332nIBAy61uLlAl1zgzmehTJQi6MLmdxvqsQqHrIacLFm+fscLT
        0D5U8w+JdNT5cymSsWJq9USaizfBY+VzLbNPow4=
X-Google-Smtp-Source: ABdhPJxbHGfyETjLh5imD8+0tKdsQ6BAvKB49R8peMa6ouPQb924w93b20EHtFMmDkRlS41oMXVpepSqbywMOESRwHY=
X-Received: by 2002:a62:6342:0:b0:4bc:c4f1:2abf with SMTP id
 x63-20020a626342000000b004bcc4f12abfmr32584324pfb.77.1642627750670; Wed, 19
 Jan 2022 13:29:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641316155.git.zhuyifei@google.com> <833b122afaeaba4485942c563ef16a64fa997fe6.1641316155.git.zhuyifei@google.com>
 <CAADnVQLCw+zyC6q=-HSURO4SpkAmSR1bwz8YLwL3nonUkeJ9Xg@mail.gmail.com> <CAA-VZPkmO7Po2U4N_=eoj_iwiEimAGdRF7RvXD6pAOc08a8Dig@mail.gmail.com>
In-Reply-To: <CAA-VZPkmO7Po2U4N_=eoj_iwiEimAGdRF7RvXD6pAOc08a8Dig@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Jan 2022 13:28:59 -0800
Message-ID: <CAADnVQ+RcqvEwh3DmdfzfETkNcAJHM9_xn9a6kFUD9uKpLQenQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Add cgroup helpers
 bpf_{get,set}_retval to get/set syscall return value
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 12:22 PM YiFei Zhu <zhuyifei@google.com> wrote:
>
> On Wed, Jan 19, 2022 at 11:50 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jan 4, 2022 at 9:15 AM YiFei Zhu <zhuyifei@google.com> wrote:
> > >
> > > The helpers continue to use int for retval because all the hooks
> > > are int-returning rather than long-returning. The return value of
> > > bpf_set_retval is int for future-proofing, in case in the future
> > > there may be errors trying to set the retval.
> > >
> > > After the previous patch, if a program rejects a syscall by
> > > returning 0, an -EPERM will be generated no matter if the retval
> > > is already set to -err. This patch change it being forced only if
> > > retval is not -err. This is because we want to support, for
> > > example, invoking bpf_set_retval(-EINVAL) and return 0, and have
> > > the syscall return value be -EINVAL not -EPERM.
> > >
> > > This change is reflected in the sockopt_sk test which has been
> > > updated to assert the errno is EINVAL instead of the EPERM.
> > > The eBPF prog has to explicitly bpf_set_retval(-EPERM) if EPERM
> > > is wanted. I also removed the explicit mentions of EPERM in the
> > > comments in the prog.
> > >
> > > For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> > > that, if the return value is NET_XMIT_DROP, the packet is silently
> > > dropped. We preserve this behavior for backward compatibility
> > > reasons, so even if an errno is set, the errno does not return to
> > > caller. However, setting a non-err to retval cannot propagate so
> > > this is not allowed and we return a -EFAULT in that case.
> > >
> > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  include/linux/bpf.h                           | 10 +++--
> > >  include/uapi/linux/bpf.h                      | 18 +++++++++
> > >  kernel/bpf/cgroup.c                           | 38 ++++++++++++++++++-
> > >  tools/include/uapi/linux/bpf.h                | 18 +++++++++
> > >  .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
> > >  .../testing/selftests/bpf/progs/sockopt_sk.c  | 32 ++++++++--------
> > >  6 files changed, 96 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 88f6891e2b53..300df48fa0e0 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1300,7 +1300,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
> > >         while ((prog = READ_ONCE(item->prog))) {
> > >                 run_ctx.prog_item = item;
> > >                 func_ret = run_prog(prog, ctx);
> > > -               if (!(func_ret & 1))
> > > +               if (!(func_ret & 1) && !IS_ERR_VALUE((long)run_ctx.retval))
> > >                         run_ctx.retval = -EPERM;
> > >                 *(ret_flags) |= (func_ret >> 1);
> > >                 item++;
> > > @@ -1330,7 +1330,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
> > >         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > >         while ((prog = READ_ONCE(item->prog))) {
> > >                 run_ctx.prog_item = item;
> > > -               if (!run_prog(prog, ctx))
> > > +               if (!run_prog(prog, ctx) && !IS_ERR_VALUE((long)run_ctx.retval))
> > >                         run_ctx.retval = -EPERM;
> > >                 item++;
> > >         }
> > > @@ -1390,7 +1390,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> > >   *   0: NET_XMIT_SUCCESS  skb should be transmitted
> > >   *   1: NET_XMIT_DROP     skb should be dropped and cn
> > >   *   2: NET_XMIT_CN       skb should be transmitted and cn
> > > - *   3: -EPERM            skb should be dropped
> > > + *   3: -err              skb should be dropped
> > >   */
> > >  #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)                \
> > >         ({                                              \
> > > @@ -1399,10 +1399,12 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> > >                 u32 _ret;                               \
> > >                 _ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, 0, &_flags); \
> > >                 _cn = _flags & BPF_RET_SET_CN;          \
> > > +               if (_ret && !IS_ERR_VALUE((long)_ret))  \
> > > +                       _ret = -EFAULT;                 \
> > >                 if (!_ret)                              \
> > >                         _ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);  \
> > >                 else                                    \
> > > -                       _ret = (_cn ? NET_XMIT_DROP : -EPERM);          \
> > > +                       _ret = (_cn ? NET_XMIT_DROP : _ret);            \
> >
> > Sorry for the long delay in reviewing.
> > Overall it looks very good.
> > Few questions:
> >
> > Why change this behavior for BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY ?
> > It's for an inet_egress hook only. In other words ip_output.
> > What kind of different error codes do you want to pass to
> > the stack from there?
>
> I don't really have a use case in mind for a different error code for
> an egress hook (my use cases are for sockopt hooks) at the moment, but
> it sounds to me that it would a surprising behavior if bpf_set_retval
> is provided yet it would still be -EPERM.

Good point.

> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > > index 4b937e5dbaca..164aa5020bf1 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > > @@ -177,7 +177,7 @@ static int getsetsockopt(void)
> > >         optlen = sizeof(buf.zc);
> > >         errno = 0;
> > >         err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
> > > -       if (errno != EPERM) {
> > > +       if (errno != EINVAL) {
> >
> > Could you explain which part of this patch caused this change
> > in user visible behavior?
> > I understand the desire to do bpf_set_retval(-EINVAL) and return 0,
> > but progs/sockopt_sk.c is not doing it.
> > Where does EINVAL come from?
>
> This comes from the kernel. In for an anvalid address to the
> getsockopt handler in tcp_zerocopy_receive [1]. The original behavior
> prior to this series is that the eBPF getsockopt hook generating an
> -EPERM overrides that of the kernel's -EINVAL, but now when the eBPF
> hook returns 0, it sees that an -EINVAL is already set by the kernel
> and does not modify the error code.

Got it.
I've added the following to the last patch to clarify it:
-       buf.zc.address = 12345; /* rejected by BPF */
+       buf.zc.address = 12345; /* Not page aligned. Rejected by
tcp_zerocopy_receive() */

and applied the set to bpf-next. Thanks!

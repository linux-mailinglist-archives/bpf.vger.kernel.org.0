Return-Path: <bpf+bounces-44-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBB6F7935
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D27280F72
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC79C12D;
	Thu,  4 May 2023 22:40:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C1156C1
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:40:05 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33CC86AD
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:40:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so1828709a12.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240002; x=1685832002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2HtMEBtZbFf4X3PuETo2EeeHrEVQPh+mdvRmyA197s=;
        b=L6FCaMvn5OgmbLYwMSiCUdl/V1j0msAMksswrcki8NG04qsUfh+zkWadK+0jaTpUyN
         ozP8gn4GBov/ODLTH+/6PIX1Brd+DCdYlVsyZGH1FwbD8/v9vCg26+GvR1gPnpETnNL9
         922aVsW4zdpXrZ4jwg+TbagcmMEFk96lwoereSgJ97auT9um1zPN/RilIDnARVJPibEf
         83Y0OT2wHOLecObUYkpii1byy7qtcpB/rcVrTIVzHZvr1QreX39WZVSx7bMmZMgxG2It
         1FTAvJ3F/SKM4ke8q/PcapFCQsyh/pKyxx25zF01lqTeRXuzaH0teO1liP47nCTUPL3f
         c5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240002; x=1685832002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2HtMEBtZbFf4X3PuETo2EeeHrEVQPh+mdvRmyA197s=;
        b=WGCPtqDR/EVfPHzB+kIcmykmQZzAcd5KkIar38CDkuBi3TYBtKMEau7J/Zjt95BhTA
         fgvh1RLS+YJoct0LBUC6lCmV0ZCiN1iJNS1GYKUa1NAg92q557xxzId8OaV6jnwuKbc3
         UZnA2BZSHX4OEfa+v2Fz0te9t7TIJPadARHW8x2mJgNsA684w1oQSmD1TvrwJtL2ijzH
         Ww8Mxo/8Ml4KJmG7/ZdsbNeOUD2ofSiWxwfWwCH+f/EeJfdugEKrULLuHyj/VhCNqdgZ
         Ialo9LkHsaTBGDTiBgqas46to8xaCLADF72iLJ258LpIGFN/cvNbL8qFM/DY0vnD1Lym
         vBdg==
X-Gm-Message-State: AC+VfDzuFqWts0rCHj5aTeF7b72bYiXzlUytZQuvxT3MzwINGQz13p0T
	BpDyAGJkpU77JFY51vs88iXzSZniHlUW1PnoTMo=
X-Google-Smtp-Source: ACHHUZ4X4llyaD87JfEkgJbg+xEzDrExuHdBjY/MsswwO7wDAVnzTRy0v4dkMVNbqUEb0U5y7HxC1qNMklhnNWVM+3k=
X-Received: by 2002:a17:907:7f90:b0:94f:64c7:d7e2 with SMTP id
 qk16-20020a1709077f9000b0094f64c7d7e2mr428823ejc.9.1683240002301; Thu, 04 May
 2023 15:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-8-andrii@kernel.org>
 <20230504163659.cgtfsruavrjlwame@MacBook-Pro-6.local> <CAEf4Bza=vToq1+xkFBT8b+K6Ak9sLGwZ8EkCf+hdEMyXrk4q3Q@mail.gmail.com>
 <20230504223203.h3zcbfrsmvqw5d7n@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504223203.h3zcbfrsmvqw5d7n@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:39:50 -0700
Message-ID: <CAEf4BzYgsD7=ifBd2TXN6wFuBHtf9bxD=N1UX1CGsRkC9kYU9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpf: fix mark_all_scalars_precise use in mark_chain_precision
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 3:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 04, 2023 at 03:00:06PM -0700, Andrii Nakryiko wrote:
> > On Thu, May 4, 2023 at 9:37=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Apr 25, 2023 at 04:49:08PM -0700, Andrii Nakryiko wrote:
> > > > When precision backtracking bails out due to some unsupported seque=
nce
> > > > of instructions (e.g., stack access through register other than r10=
), we
> > > > need to mark all SCALAR registers as precise to be safe. Currently,
> > > > though, we mark SCALARs precise only starting from the state we det=
ected
> > > > unsupported condition, which could be one of the parent states of t=
he
> > > > actual current state. This will leave some registers potentially no=
t
> > > > marked as precise, even though they should. So make sure we start
> > > > marking scalars as precise from current state (env->cur_state).
> > > >
> > > > Further, we don't currently detect a situation when we end up with =
some
> > > > stack slots marked as needing precision, but we ran out of availabl=
e
> > > > states to find the instructions that populate those stack slots. Th=
is is
> > > > akin the `i >=3D func->allocated_stack / BPF_REG_SIZE` check and sh=
ould be
> > > > handled similarly by falling back to marking all SCALARs precise. A=
dd
> > > > this check when we run out of states.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/bpf/verifier.c                          | 16 +++++++++++++-=
--
> > > >  tools/testing/selftests/bpf/verifier/precise.c |  9 +++++----
> > > >  2 files changed, 18 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 66d64ac10fb1..35f34c977819 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -3781,7 +3781,7 @@ static int __mark_chain_precision(struct bpf_=
verifier_env *env, int frame, int r
> > > >                               err =3D backtrack_insn(env, i, bt);
> > > >                       }
> > > >                       if (err =3D=3D -ENOTSUPP) {
> > > > -                             mark_all_scalars_precise(env, st);
> > > > +                             mark_all_scalars_precise(env, env->cu=
r_state);
> > > >                               bt_reset(bt);
> > > >                               return 0;
> > > >                       } else if (err) {
> > > > @@ -3843,7 +3843,7 @@ static int __mark_chain_precision(struct bpf_=
verifier_env *env, int frame, int r
> > > >                                        * fp-8 and it's "unallocated=
" stack space.
> > > >                                        * In such case fallback to c=
onservative.
> > > >                                        */
> > > > -                                     mark_all_scalars_precise(env,=
 st);
> > > > +                                     mark_all_scalars_precise(env,=
 env->cur_state);
> > > >                                       bt_reset(bt);
> > > >                                       return 0;
> > > >                               }
> > > > @@ -3872,11 +3872,21 @@ static int __mark_chain_precision(struct bp=
f_verifier_env *env, int frame, int r
> > > >               }
> > > >
> > > >               if (bt_bitcnt(bt) =3D=3D 0)
> > > > -                     break;
> > > > +                     return 0;
> > > >
> > > >               last_idx =3D st->last_insn_idx;
> > > >               first_idx =3D st->first_insn_idx;
> > > >       }
> > > > +
> > > > +     /* if we still have requested precise regs or slots, we misse=
d
> > > > +      * something (e.g., stack access through non-r10 register), s=
o
> > > > +      * fallback to marking all precise
> > > > +      */
> > > > +     if (bt_bitcnt(bt) !=3D 0) {
> > > > +             mark_all_scalars_precise(env, env->cur_state);
> > > > +             bt_reset(bt);
> > > > +     }
> > >
> > > We get here only after:
> > >   st =3D st->parent;
> > >   if (!st)
> > >           break;
> > >
> > > which is the case when we reach the very beginning of the program (pa=
rent =3D=3D NULL) and
> > > there are still regs or stack with marks.
> > > That's a situation when backtracking encountered something we didn't =
foresee. Some new
> > > condition. Currently we don't have selftest that trigger this.
> > > So as a defensive mechanism it makes sense to do mark_all_scalars_pre=
cise(env, env->cur_state);
> > > Probably needs verbose("verifier backtracking bug") as well.
> >
> > I hesitated to add a bug message because of a known case where this
> > could happen: stack access through non-r10 register. So it's not a
> > bug, it's similar to -ENOTSUPP cases above, kind of expected, if rare.
>
> fair enough. I'm ok to skip verbose().
>
> > >
> > > But for the other two cases mark_all_scalars_precise(env, st); is saf=
e.
> > > What's the reason to mark everything precise from the very beginning =
of backtracking (last seen state =3D=3D current state).
> > > Since unsupported condition was in the middle it's safe to mark from =
that condition till start of prog.
> >
> > So I don't have a constructed example and it's more of a hunch. But
> > let's use the same stack slot precision when some instructions use
> > non-r10 registers. We can't always reliably and immediately detect
> > this situation, so the point at which we realize that something is off
> > could be in parent state, but that same slot might be used in children
> > state and if we don't mark everything precise from the current state,
> > then we are running a risk of leaving some of the slots as imprecise.
> >
> > Before patch #8 similar situation could be also with r0 returned from
> > static subprog. Something like this:
> >
> >
> > P2: call subprog
> > <<- checkpoint ->>
> > P1: r1 =3D r0;
> > <<- checkpoint ->>
> > CUR: r2 =3D <map value pointer>
> >      r2 +=3D r1   <--- need to mark r0 precise and propagate all the wa=
y
> > to P2 and beyond
> >
> >
> > Precision propagation will be triggered in CUR state. Will go through
> > P1, come back to P2 and (before patch #8 changes) will realize this is
> > unsupported case. Currently we'll mark R0 precise only in P2 and its
> > parents (could be also r6-r9 registers situation).
>
> Correct. I'm with you so far...
>
> > But really we
> > should make sure that P1 also has r1 marked as precise.
>
> and here I'm a bit lost.
> Precision marking will do r1->precise=3Dtrue while walking P1 in that sta=
te.
>
> The change:
> mark_all_scalars_precise(env, env->cur_state);
> will mark both r0 and r1 in P1, but that's unnecessary.
>
> > So as a general rule, I think the only safe default is to mark
> > everything precise from current state.
> >
> > Is the above convincing or should I revert back to old behavior?
>
> I'm not seeing the issue yet.

you are right, second example is not relevant because we'll be
properly propagating register precision along the way. So I think
stack access is the only one that might be problematic.

I assume you are worried about regressing due to marking more stuff
precise, right? My thinking (besides the subtle correctness issues
with stack access through non-r10 registers) was that all the other
patterns should be now handled properly, so we shouldn't be even
seeing mark_all_precise() use in practice.

But I'm fine reverting those two existing mark_all_precise() calls, if
you insist.


Return-Path: <bpf+bounces-36-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D876F78B1
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D031C214E4
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80054C154;
	Thu,  4 May 2023 22:00:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49315156F9
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:00:22 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6001249F
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:00:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-95678d891d6so190280466b.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237619; x=1685829619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mpGTKpHwl9O6u8ckvVmQCzz8ouasO0seKpMHTH/t6Y=;
        b=exXRPdKVRLRmNRA9+GLwi4tf3rWbB1hexkC1RshHlXUXTU4A3CXOUmi0nIHbqON5tO
         S5PqZq9QqPHpf6dnTOgwGRR6563QnPbvo69OFPNk8IWFvrsBJ46qxjkE2MyOhTOChkDK
         F5Fak6JzeeSCJltKSLcpzM1e7aka8KIJ6oLv03ny7KOuJEc1pGP7ysXC0v0B1swjoqwh
         9tonHY6kivihLH80BidAEuEwBiPZEDIktusqzDlgq5bmNAXVjzUYeRxjllQd268Gp8Bj
         sv5BbiNsm0fsqHUGU5eHiGc3ZyQquQ9gVoOC8ZQI7hq1eSvu7KrO67F93iah5rkoo4+s
         jySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237619; x=1685829619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mpGTKpHwl9O6u8ckvVmQCzz8ouasO0seKpMHTH/t6Y=;
        b=iTQTlXJJBApLTCNxR+uMzmyXJnLYobqgFzl42UDxZSMxvj5jFeZMmV6TcLN1SOEsiy
         dkdCjEcstT4e7P23PHAzVX3cxE580IUIrjeO7/dRbeqfIgeW8I7r3xTlN4MgfN6xYjKd
         S3/PskTm51ZVYPAEkFDtwPWzdLSRn3uhIfe2hv0Da1NVNt3wnP9NJ7g74TSI9sqFU/I7
         0B03f2oM4kRnJNsIIsTy3u3hMYAE7IXXKcO2Gh8/C29GfaCRtGSMkvQE0XpS3F8ElyL6
         DEPUgpJznaHH3HCiN+1L7RDLW6EGJD335vdu4sIZXaGGbWE7qMaiFSu75kl97LGncBXL
         2zEA==
X-Gm-Message-State: AC+VfDxM9NGz+4Px4GGr5+/Mh130PnkbyNwwpf6NPduPvCsGJUFo7u//
	lU+/4ehymvqBRMCAwgIUkBuUE25T2yl0JyFZKIK0bYUjYOY=
X-Google-Smtp-Source: ACHHUZ7UFveMaVdwol3V/0M+UsQarIhyeZHv2EDrzLw9r6d8mQ6JlviGq79aVJYO2KMYYuOQqOFz40eaA7+aUIA4usY=
X-Received: by 2002:a17:907:a0c:b0:94e:cf98:32f2 with SMTP id
 bb12-20020a1709070a0c00b0094ecf9832f2mr227687ejc.33.1683237618639; Thu, 04
 May 2023 15:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-8-andrii@kernel.org>
 <20230504163659.cgtfsruavrjlwame@MacBook-Pro-6.local>
In-Reply-To: <20230504163659.cgtfsruavrjlwame@MacBook-Pro-6.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:00:06 -0700
Message-ID: <CAEf4Bza=vToq1+xkFBT8b+K6Ak9sLGwZ8EkCf+hdEMyXrk4q3Q@mail.gmail.com>
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

On Thu, May 4, 2023 at 9:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:08PM -0700, Andrii Nakryiko wrote:
> > When precision backtracking bails out due to some unsupported sequence
> > of instructions (e.g., stack access through register other than r10), w=
e
> > need to mark all SCALAR registers as precise to be safe. Currently,
> > though, we mark SCALARs precise only starting from the state we detecte=
d
> > unsupported condition, which could be one of the parent states of the
> > actual current state. This will leave some registers potentially not
> > marked as precise, even though they should. So make sure we start
> > marking scalars as precise from current state (env->cur_state).
> >
> > Further, we don't currently detect a situation when we end up with some
> > stack slots marked as needing precision, but we ran out of available
> > states to find the instructions that populate those stack slots. This i=
s
> > akin the `i >=3D func->allocated_stack / BPF_REG_SIZE` check and should=
 be
> > handled similarly by falling back to marking all SCALARs precise. Add
> > this check when we run out of states.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c                          | 16 +++++++++++++---
> >  tools/testing/selftests/bpf/verifier/precise.c |  9 +++++----
> >  2 files changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 66d64ac10fb1..35f34c977819 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3781,7 +3781,7 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
> >                               err =3D backtrack_insn(env, i, bt);
> >                       }
> >                       if (err =3D=3D -ENOTSUPP) {
> > -                             mark_all_scalars_precise(env, st);
> > +                             mark_all_scalars_precise(env, env->cur_st=
ate);
> >                               bt_reset(bt);
> >                               return 0;
> >                       } else if (err) {
> > @@ -3843,7 +3843,7 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
> >                                        * fp-8 and it's "unallocated" st=
ack space.
> >                                        * In such case fallback to conse=
rvative.
> >                                        */
> > -                                     mark_all_scalars_precise(env, st)=
;
> > +                                     mark_all_scalars_precise(env, env=
->cur_state);
> >                                       bt_reset(bt);
> >                                       return 0;
> >                               }
> > @@ -3872,11 +3872,21 @@ static int __mark_chain_precision(struct bpf_ve=
rifier_env *env, int frame, int r
> >               }
> >
> >               if (bt_bitcnt(bt) =3D=3D 0)
> > -                     break;
> > +                     return 0;
> >
> >               last_idx =3D st->last_insn_idx;
> >               first_idx =3D st->first_insn_idx;
> >       }
> > +
> > +     /* if we still have requested precise regs or slots, we missed
> > +      * something (e.g., stack access through non-r10 register), so
> > +      * fallback to marking all precise
> > +      */
> > +     if (bt_bitcnt(bt) !=3D 0) {
> > +             mark_all_scalars_precise(env, env->cur_state);
> > +             bt_reset(bt);
> > +     }
>
> We get here only after:
>   st =3D st->parent;
>   if (!st)
>           break;
>
> which is the case when we reach the very beginning of the program (parent=
 =3D=3D NULL) and
> there are still regs or stack with marks.
> That's a situation when backtracking encountered something we didn't fore=
see. Some new
> condition. Currently we don't have selftest that trigger this.
> So as a defensive mechanism it makes sense to do mark_all_scalars_precise=
(env, env->cur_state);
> Probably needs verbose("verifier backtracking bug") as well.

I hesitated to add a bug message because of a known case where this
could happen: stack access through non-r10 register. So it's not a
bug, it's similar to -ENOTSUPP cases above, kind of expected, if rare.

>
> But for the other two cases mark_all_scalars_precise(env, st); is safe.
> What's the reason to mark everything precise from the very beginning of b=
acktracking (last seen state =3D=3D current state).
> Since unsupported condition was in the middle it's safe to mark from that=
 condition till start of prog.

So I don't have a constructed example and it's more of a hunch. But
let's use the same stack slot precision when some instructions use
non-r10 registers. We can't always reliably and immediately detect
this situation, so the point at which we realize that something is off
could be in parent state, but that same slot might be used in children
state and if we don't mark everything precise from the current state,
then we are running a risk of leaving some of the slots as imprecise.

Before patch #8 similar situation could be also with r0 returned from
static subprog. Something like this:


P2: call subprog
<<- checkpoint ->>
P1: r1 =3D r0;
<<- checkpoint ->>
CUR: r2 =3D <map value pointer>
     r2 +=3D r1   <--- need to mark r0 precise and propagate all the way
to P2 and beyond


Precision propagation will be triggered in CUR state. Will go through
P1, come back to P2 and (before patch #8 changes) will realize this is
unsupported case. Currently we'll mark R0 precise only in P2 and its
parents (could be also r6-r9 registers situation). But really we
should make sure that P1 also has r1 marked as precise.

So as a general rule, I think the only safe default is to mark
everything precise from current state.

Is the above convincing or should I revert back to old behavior?


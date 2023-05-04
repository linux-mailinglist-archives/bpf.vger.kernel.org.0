Return-Path: <bpf+bounces-43-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B276F792C
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6151C2164F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B68C12B;
	Thu,  4 May 2023 22:32:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE780156C1
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:32:08 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1027DA3
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:32:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-250252e4113so143425a91.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683239526; x=1685831526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eawrxTVXOJw9uAd0RgvXxt8UQYQsal6Q46+ZQwJiWW0=;
        b=VZ5Szr5Vyw1KoQC40yC8iNxNvKKf50Bt35qUCXMT6DPkIi9obEOgxoCtenOmENvZnJ
         sq+vOS+NDCq54jVtWCOMtwSZqNbWpMsqSUJtVuC8epx4xfBo5j7EeVhHoOsG0+FZZ/qb
         gfcvN9k+rvOkfhCod7QnbtClnGVJg4sfR9Vi4tkn3kB88vAyKerlGwzM6dp1IQAz6lR4
         M6+yaAsncnbU7tWL1WY75/pxS8+Lx4nZ98JXGyQdwlZT+VJ8RU9ZnqTu7/O2p3ymX2DU
         kclWqXoBJSFbeOqRWIwtXCX7BH7iuiSlfQBLDKvLVTYZYwgUABwqQKF56qx/A6+ITt+k
         Ij+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683239526; x=1685831526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eawrxTVXOJw9uAd0RgvXxt8UQYQsal6Q46+ZQwJiWW0=;
        b=awAv02sSGj2g2eL9LvR3jpRQ7VRJ3Vt4GZMq23SZKaiV0NJcgP2Dxm7+wIpmit9F5x
         BJN6Y0fzjgpdx4TwlJQmqb+o83uH9OXT/UCcpIkV01RGJRXKyRt0qUUPGVncaPrOLNhJ
         RBHilD64dX3W6HVRsH/U+yeZeekROf1xjSn9sLLC7JvGeXsEG8h/812rxyr44mZXVDzp
         iF71xeOt0iEScqsr+ILQo30BPcWxrd/sv5UPdgOXZMe0nt9RZHmp6JsyRcpkWlMZRgXl
         tL0NP9qq+hMI1tofo2QFw2Sh9hcUZw2Be/kHd5zyzt1JnLiE8wC6cJ004oav9HUR1uan
         8lLA==
X-Gm-Message-State: AC+VfDynmE5fVqwNF53hrJhWX6acy8owEvOugUxHY4Bewke9E81sA8ZL
	8FqJrmUdh2O99flT0VA/mCI=
X-Google-Smtp-Source: ACHHUZ7uxWeVBouPo8WrpUCMAV+B/rvMyEGQy3QQBfOtBuiKMRzqNGz5z9UXe/TBF/T+2sTI3iiJEg==
X-Received: by 2002:a17:902:eac5:b0:1aa:fec9:5219 with SMTP id p5-20020a170902eac500b001aafec95219mr5609895pld.61.1683239526466;
        Thu, 04 May 2023 15:32:06 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001a4fe00a8d4sm43646plq.90.2023.05.04.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:32:06 -0700 (PDT)
Date: Thu, 4 May 2023 15:32:03 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 07/10] bpf: fix mark_all_scalars_precise use in
 mark_chain_precision
Message-ID: <20230504223203.h3zcbfrsmvqw5d7n@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-8-andrii@kernel.org>
 <20230504163659.cgtfsruavrjlwame@MacBook-Pro-6.local>
 <CAEf4Bza=vToq1+xkFBT8b+K6Ak9sLGwZ8EkCf+hdEMyXrk4q3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza=vToq1+xkFBT8b+K6Ak9sLGwZ8EkCf+hdEMyXrk4q3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 03:00:06PM -0700, Andrii Nakryiko wrote:
> On Thu, May 4, 2023 at 9:37 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 25, 2023 at 04:49:08PM -0700, Andrii Nakryiko wrote:
> > > When precision backtracking bails out due to some unsupported sequence
> > > of instructions (e.g., stack access through register other than r10), we
> > > need to mark all SCALAR registers as precise to be safe. Currently,
> > > though, we mark SCALARs precise only starting from the state we detected
> > > unsupported condition, which could be one of the parent states of the
> > > actual current state. This will leave some registers potentially not
> > > marked as precise, even though they should. So make sure we start
> > > marking scalars as precise from current state (env->cur_state).
> > >
> > > Further, we don't currently detect a situation when we end up with some
> > > stack slots marked as needing precision, but we ran out of available
> > > states to find the instructions that populate those stack slots. This is
> > > akin the `i >= func->allocated_stack / BPF_REG_SIZE` check and should be
> > > handled similarly by falling back to marking all SCALARs precise. Add
> > > this check when we run out of states.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c                          | 16 +++++++++++++---
> > >  tools/testing/selftests/bpf/verifier/precise.c |  9 +++++----
> > >  2 files changed, 18 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 66d64ac10fb1..35f34c977819 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3781,7 +3781,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
> > >                               err = backtrack_insn(env, i, bt);
> > >                       }
> > >                       if (err == -ENOTSUPP) {
> > > -                             mark_all_scalars_precise(env, st);
> > > +                             mark_all_scalars_precise(env, env->cur_state);
> > >                               bt_reset(bt);
> > >                               return 0;
> > >                       } else if (err) {
> > > @@ -3843,7 +3843,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
> > >                                        * fp-8 and it's "unallocated" stack space.
> > >                                        * In such case fallback to conservative.
> > >                                        */
> > > -                                     mark_all_scalars_precise(env, st);
> > > +                                     mark_all_scalars_precise(env, env->cur_state);
> > >                                       bt_reset(bt);
> > >                                       return 0;
> > >                               }
> > > @@ -3872,11 +3872,21 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
> > >               }
> > >
> > >               if (bt_bitcnt(bt) == 0)
> > > -                     break;
> > > +                     return 0;
> > >
> > >               last_idx = st->last_insn_idx;
> > >               first_idx = st->first_insn_idx;
> > >       }
> > > +
> > > +     /* if we still have requested precise regs or slots, we missed
> > > +      * something (e.g., stack access through non-r10 register), so
> > > +      * fallback to marking all precise
> > > +      */
> > > +     if (bt_bitcnt(bt) != 0) {
> > > +             mark_all_scalars_precise(env, env->cur_state);
> > > +             bt_reset(bt);
> > > +     }
> >
> > We get here only after:
> >   st = st->parent;
> >   if (!st)
> >           break;
> >
> > which is the case when we reach the very beginning of the program (parent == NULL) and
> > there are still regs or stack with marks.
> > That's a situation when backtracking encountered something we didn't foresee. Some new
> > condition. Currently we don't have selftest that trigger this.
> > So as a defensive mechanism it makes sense to do mark_all_scalars_precise(env, env->cur_state);
> > Probably needs verbose("verifier backtracking bug") as well.
> 
> I hesitated to add a bug message because of a known case where this
> could happen: stack access through non-r10 register. So it's not a
> bug, it's similar to -ENOTSUPP cases above, kind of expected, if rare.

fair enough. I'm ok to skip verbose().

> >
> > But for the other two cases mark_all_scalars_precise(env, st); is safe.
> > What's the reason to mark everything precise from the very beginning of backtracking (last seen state == current state).
> > Since unsupported condition was in the middle it's safe to mark from that condition till start of prog.
> 
> So I don't have a constructed example and it's more of a hunch. But
> let's use the same stack slot precision when some instructions use
> non-r10 registers. We can't always reliably and immediately detect
> this situation, so the point at which we realize that something is off
> could be in parent state, but that same slot might be used in children
> state and if we don't mark everything precise from the current state,
> then we are running a risk of leaving some of the slots as imprecise.
> 
> Before patch #8 similar situation could be also with r0 returned from
> static subprog. Something like this:
> 
> 
> P2: call subprog
> <<- checkpoint ->>
> P1: r1 = r0;
> <<- checkpoint ->>
> CUR: r2 = <map value pointer>
>      r2 += r1   <--- need to mark r0 precise and propagate all the way
> to P2 and beyond
> 
> 
> Precision propagation will be triggered in CUR state. Will go through
> P1, come back to P2 and (before patch #8 changes) will realize this is
> unsupported case. Currently we'll mark R0 precise only in P2 and its
> parents (could be also r6-r9 registers situation). 

Correct. I'm with you so far...

> But really we
> should make sure that P1 also has r1 marked as precise.

and here I'm a bit lost.
Precision marking will do r1->precise=true while walking P1 in that state.

The change:
mark_all_scalars_precise(env, env->cur_state);
will mark both r0 and r1 in P1, but that's unnecessary.

> So as a general rule, I think the only safe default is to mark
> everything precise from current state.
> 
> Is the above convincing or should I revert back to old behavior?

I'm not seeing the issue yet.


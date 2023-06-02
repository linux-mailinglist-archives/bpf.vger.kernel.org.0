Return-Path: <bpf+bounces-1748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E94A720BBE
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 00:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4BE1C2126C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3AC146;
	Fri,  2 Jun 2023 22:07:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECDBE7A
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 22:07:35 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D01B7
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:07:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5148f299105so5524120a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685743651; x=1688335651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCCNHHkgLn2NHdOBeXlKxJ8jqaytZhSoEz8oVgjTSls=;
        b=a/TQvJD9fZkVNAMfa9kRkPLC7LGLCyLrpe46DZmd5EzC2WAssQGbrjk5CZP2H6JBdF
         zJFEPDbChLaibItV3sHanN6OD+cUpOFlcJ/maSvTaZt8wcK8IytFLoUZlXLP4YO59xvj
         YO01YI4dT2usqLL7dHRTFi0dxEXr8X6ytc4TE0H2NURHfXlXoqDhkM0AaMfnzS2m1mM6
         MSFcG/qk07Jqm3/5nZ0qGc8fxHNK/eS7pUCsFb3z7JNIZkpFdqe36R/0QHMFXRxWjsHb
         eXj6qLI3GsYDjMtBiCtt+KAQlK/GjCJRP+Sgj5Bjqo61W0KMRsMhiYt/zGbXSfiflxPI
         HETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685743651; x=1688335651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCCNHHkgLn2NHdOBeXlKxJ8jqaytZhSoEz8oVgjTSls=;
        b=i7tiQC/zVaqqxzvkrvF32mooolpzjwOXMnC869OyMPMgE+rv/g3Q3Ja27nrJGHIkgi
         ElEfCwekztiE0ZBpVfJNJXSSg4hA6OzTDCcq/jDact/36wQLO4KaQM62g9k75yq0PWnt
         q/ALbaEqg6EwDnzYUd2p8vdxhqpIGkdprieop/2eaW9uk5rVlPWLEYvUHg7y42vz7fC3
         H0Gt5to6RScoTGqHCsa18Mi6XgRGBcWCPrijZabgZd6X9XjTv2KtqwDE/gfVStzEiwDD
         t6XHM76H2k4VJ4f0MppXfxokGftoJqdq8Zezo8rRmno+1/UI9e5bFtv9TlDIZsKOsPHd
         T3FA==
X-Gm-Message-State: AC+VfDzkt5CLqQ/MacEbKam1q4Tgk9BLp+cwWe2NOY3BqGVz5rlXV/f5
	aPyR3oO9FOmL+PiZG4PKrRfxypM0qr5m7ph/sH0=
X-Google-Smtp-Source: ACHHUZ6uKwYze3IdPd4JQaXCUgX+NUDb/ILVpsGSlCZG8XwtLiriYVBop//aunlHEwQiz8F60/rAt3ZURL5Vx2QsZoU=
X-Received: by 2002:aa7:ce07:0:b0:50b:c456:a72a with SMTP id
 d7-20020aa7ce07000000b0050bc456a72amr3483462edv.19.1685743651369; Fri, 02 Jun
 2023 15:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local> <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
 <CAEf4BzY8u_JbwBi=wYLFopj79MOfKGnyWo9O19esBqoT2zsABA@mail.gmail.com> <6cbfe3170e72fb981823cb7680a204c62ab36ede.camel@gmail.com>
In-Reply-To: <6cbfe3170e72fb981823cb7680a204c62ab36ede.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 15:07:19 -0700
Message-ID: <CAEf4BzZvBDuSdKTW+PzB9RPvi=yMNHixdDWh+6dbJcBz6nO5hQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 2:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2023-06-02 at 13:17 -0700, Andrii Nakryiko wrote:
> > On Fri, Jun 2, 2023 at 12:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2023-06-02 at 11:50 -0700, Andrii Nakryiko wrote:
> > > [...]
> > > > > > The thread is long. Could you please describe it again in pseud=
o code?
> > > > >
> > > > > - Add a function mark_precise_scalar_ids(struct bpf_verifier_env =
*env,
> > > > >                                         struct bpf_verifier_state=
 *st)
> > > > >   such that it:
> > > > >   - collect PRECISE_IDS: a set of IDs of all registers marked in =
env->bt
> > > > >   - visit all registers with ids from PRECISE_IDS and make sure
> > > > >     that these registers are marked in env->bt
> > > > > - Call mark_precise_scalar_ids() from __mark_chain_precision()
> > > > >   for each state 'st' visited by states chain processing loop,
> > > > >   so that:
> > > > >   - mark_precise_scalar_ids() is called for current state when
> > > > >     __mark_chain_precision() is entered, reusing id assignments i=
n
> > > > >     current state;
> > > > >   - mark_precise_scalar_ids() is called for each parent state, re=
using
> > > > >     id assignments valid at 'last_idx' instruction of that state.
> > > > >
> > > > > The idea is that in situations like below:
> > > > >
> > > > >    4: if (r6 > r7) goto +1
> > > > >    5: r7 =3D r6
> > > > >    --- checkpoint #1 ---
> > > > >    6: <something>
> > > > >    7: if (r7 > X) goto ...
> > > > >    8: r7 =3D 0
> > > > >    9: r9 +=3D r6
> > > > >
> > > > > The mark_precise_scalar_ids() would be called at:
> > > > > - (9) and current id assignments would be used.
> > > > > - (6) and id assignments saved in checkpoint #1 would be used.
> > > > >
> > > > > If <something> is the code that modifies r6/r7 the link would be
> > > > > broken and we would overestimate the set of precise registers.
> > > > >
> > > >
> > > > To avoid this we need to recalculate these IDs on each new parent
> > > > state, based on requested precision marks. If we keep a simple and
> > > > small array of IDs and do a quick linear search over them for each
> > > > SCALAR register, I suspect it should be very fast. I don't think in
> > > > practice we'll have more than 1-2 IDs in that array, right?
> > >
> > > I'm not sure I understand, could you please describe how it should
> > > work for e.g.?:
> > >
> > >     3: r6 &=3D 0xf            // assume safe bound
> > >     4: if (r6 > r7) goto +1
> > >     5: r7 =3D r6
> > >     --- checkpoint #1 ---
> > >     6: r7 =3D 0
> > >     7: if (r7 > 10) goto exit;
> > >     8: r7 =3D 0
> > >     9: r9 +=3D r6
> > >
> > > __mark_chain_precision() would get to checkpoint #1 with only r6 as
> > > precise, what should happen next?
> >
> > it should mark all SCALARs that have r6's ID in env->bt, and then
> > proceed with precision propagation until next parent state? This is
> > where you'll mark r7, because in parent state (checkpoint #1) r6.id =3D=
=3D
> > r7.id.
>
> That's what I do now.

Ok, cool...

> Sorry, I thought you had a suggestion on how to avoid the precise set
> overestimation (e.g. how to detect that "6: r7 =3D 0" breaks the link).

..but "overestimation" confuses me. There is no overestimation. After
checkpoint #1 (let's say we have checkpoint #2 after instruction 9),
r6 and r7 are not linked, and if we had to mark r6 as precise, we'd
mark only r7. But as of checkpoint #1, r7.id =3D=3D r6.id and they are
linked. So there is no overestimation. They are linked together as of
checkpoint #1.

But anyways, I think we are on the same page, even if we don't use the
same words :)

>
> > It might be easier to just discuss latest code you have, there are
> > lots of intricacies, and code wins over words :)
>
> Here is what I have now:
> https://github.com/kernel-patches/bpf/compare/bpf-next_base...eddyz87:bpf=
:verify-ids-for-scalars-in-regsafe-v3

feels a bit heavyweight to do sorting and stuff. I think in practice
you'll have only very small amount of linked SCALAR IDs, so a simple
linear search would be faster than all that sort+bsearch.

Look at check_ids(). It's called all the time and is a linear search.
I think it's fine to keep thing simple here as well.

> The interesting part is mark_precise_scalar_ids().
>
> But a few tests are not passing because expected messages have to be adju=
sted.
> And a lot of tests have to be added.
> We can delay discussion until I submit v3 (worst case tomorrow).
>
> > > As a side note: I added several optimizations:
> > > - avoid allocation of scalar ids for constants;
> > > - remove sole scalar ids from cached states;
> >
> > so that's what I was proposing earlier,
>
> Yes, it turned out beneficial when I inspected logs for bpf_xdp.o.
>
> > but not just from cached
> > states, but from any state. As soon as we get SCALAR with some ID that
> > is not shared by any other SCALAR, we should try to drop that ID. The
> > question is only in how to implement this efficiently.
>
> No, we don't want to do it for non-cached state, not until we generate
> scalar ids on stack spills and fills. Otherwise we would break
> find_equal_scalars() for the following case:
>
>   r1 =3D r2         // r1 gains ID
>   fp[-8] =3D r1     //
>   r2 =3D 0          //
>   r1 =3D 0          // fp[-8] has a unique ID now

exactly, as of right now there is no linked registers anymore, so we
can clear ID


>   --- checkpoint ---
>   r1 =3D fp[-8]

and this is where we should generate a new ID and assign it to r1.id
and fp[-8].id.

How is this fundamentally different from just `r1 =3D r2`?

>   r2 =3D fp[-8]

and now r2.id =3D r1.id =3D fp[-8].id (but it's different ID than as
before checkpoint)

>   if r1 > 10 goto exit; // range propagates to r2 now,
>                         // but won't propagate if fp[-8] ID
>                         // is cleared at checkpoint
>
> (A bit contrived, but conveys the idea)
>
> And we don't really need to bother about unique IDs in non-cached state
> when rold->id check discussed in a sibling thread is used:
>
>                 if (rold->precise && rold->id && !check_ids(rold->id, rcu=
r->id, idmap))
>                         return false;

It makes me worry that we are mixing no ID and ID-ed SCALARs and
making them equivalent. I need to think some more about implications
(and re-read what you and Alexei discussed). I don't feel good about
this and suspect we'll miss some non-obvious corner case if we do
this.

>
> Here, if rcur->id is unique there are two cases:
> - rold->id =3D=3D 0: then rcur->id is just ignored
> - rold->id !=3D 0: then rold->id/rcur->id pair would be added to idmap,
>                  there is some other precise old register with the
>                  same id as rold->id, so eventually check_ids()
>                  would make regsafe() return false.
>
> > > - do a check as follows:
> > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> > >     return false;
> >
> > Hm.. do we need extra special case here? With precision changes we are
> > discussion, and this removing singular SCALAR IDs you are proposing,
> > just extending existing logic to:
> >
> >                 if (regs_exact(rold, rcur, idmap))
> >                         return true;
> >                 if (env->explore_alu_limits)
> >                         return false;
> >                 if (!rold->precise)
> >                         return true;
> >                 /* new val must satisfy old val knowledge */
> >                 return range_within(rold, rcur) &&
> >                        check_ids(rold->id, rcur->id, idmap) &&
> >                        check_ids(rold->ref_obj_id, rcur->ref_obj_id, id=
map) &&
> >                        tnum_in(rold->var_off, rcur->var_off);
> >
> > wouldn't be enough?
>
> Yes, it could be shortened as below:
>
>                  return range_within(rold, rcur) &&
>                         (rold->id =3D=3D 0 || check_ids(rold->id, rcur->i=
d, idmap)) &&
>                         check_ids(rold->ref_obj_id, rcur->ref_obj_id, idm=
ap) &&
>                         tnum_in(rold->var_off, rcur->var_off);
>
> but I wanted a separate place to put a long comment at.

you can still put a big comment right here? At the very least I'd move
this new condition to after `if (!rold->precise)`. Where you put it
right now seems a bit out of place.

>
> > >
> > > And I'm seeing almost zero performance overhead now.
> > > So, maybe what we figured so far is good enough.
> > > Need to add more tests, though.
>


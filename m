Return-Path: <bpf+bounces-1751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F9720C48
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C131C21261
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61BC2EE;
	Fri,  2 Jun 2023 23:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD733301
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 23:20:25 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42850123
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:20:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3b9755961so3586892e87.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685748021; x=1688340021;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P/XtQ5UHAkrnoh+2mO9Em8fJONtily69Uc0ujt20ISg=;
        b=RbFTSTvAJ3krdmvo0o80dRWsDuh1kSUNwI/CnT9XlqdH3Pm2pq9ZF0Ykvw+JRY5fan
         5rANsnQXXIVIQ4b4k//vCONxM28kwsrX6lR4XkQtyu2uHfICHi6od/VO3dK9MyHBRTvR
         oEbJytqEoJHS4xT/zU5o+HFN4tAvaMsSvKoQUehVYxazLohs8azw9BbwpgMDtxai/PE8
         +a3rwVbx7iVZkxcu/AcK7hEXl6QTIQvxm37FuphtjNL7HeMmyhpN/YyG+04ArQ+9VdyH
         k8Gowap8gvjdJcZLIUGFum+OYKusCFv44+y0uxJ5D4ohD/SBdorAMUKAM6r5JYgHYOlz
         UdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685748021; x=1688340021;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/XtQ5UHAkrnoh+2mO9Em8fJONtily69Uc0ujt20ISg=;
        b=X+qOwHwe7Dxq7AXWsbXpwM2DpyqSG0R77C6ROhxiEvLcxJnXYFGBwzQ3yExH2y/4kR
         yXSkP6LRXZCpuMQgQ9k16Qd3UfhbFz5vNwGcnL5DGFMLepsyqYHnZ9O+JJmzGmDU1+P+
         W4iHC+aSpTOr11Q+b8BkmtKJuHBJdMO6tTnNMu9ibTLSJtcGTYfWShSk+H7Yubvqddto
         lbpy8yg/rWqPvt9iHAuiZycSHNybogIfW6f91VmjJ0CWHYPwk8mI9DziIfJAG53G9MKW
         4X0W3jpBR50dtUaaWgw64bPadVhr0q/lrModVJU8EfZWFiGdoLRqcBzJiDYsHgMTT/il
         dXoQ==
X-Gm-Message-State: AC+VfDxqN5OT5ZFweLLFKfmHu+JdK5X6Xi5QghIv5gIoU+CQJFYVY6VF
	9d09USBg5mHt0MPj0Y3slis=
X-Google-Smtp-Source: ACHHUZ7UFyQzG9f5EClHY44KTcEN0orD4DKWZ9YpVu+r+8xEduZPli61+L5iW9182ymJVk0tkc3nTQ==
X-Received: by 2002:a19:c20d:0:b0:4ef:efb5:bfea with SMTP id l13-20020a19c20d000000b004efefb5bfeamr2458686lfc.37.1685748021123;
        Fri, 02 Jun 2023 16:20:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y26-20020a19751a000000b004eff10511besm302163lfe.146.2023.06.02.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:20:20 -0700 (PDT)
Message-ID: <db0ce896af65b729e09cb1fb0fee6aa5b5d44ce0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yhs@fb.com>
Date: Sat, 03 Jun 2023 02:20:19 +0300
In-Reply-To: <CAEf4BzZvBDuSdKTW+PzB9RPvi=yMNHixdDWh+6dbJcBz6nO5hQ@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
	 <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
	 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
	 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
	 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
	 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
	 <CAEf4BzY8u_JbwBi=wYLFopj79MOfKGnyWo9O19esBqoT2zsABA@mail.gmail.com>
	 <6cbfe3170e72fb981823cb7680a204c62ab36ede.camel@gmail.com>
	 <CAEf4BzZvBDuSdKTW+PzB9RPvi=yMNHixdDWh+6dbJcBz6nO5hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-02 at 15:07 -0700, Andrii Nakryiko wrote:
[...]
> > > > I'm not sure I understand, could you please describe how it should
> > > > work for e.g.?:
> > > >=20
> > > >     3: r6 &=3D 0xf            // assume safe bound
> > > >     4: if (r6 > r7) goto +1
> > > >     5: r7 =3D r6
> > > >     --- checkpoint #1 ---
> > > >     6: r7 =3D 0
> > > >     7: if (r7 > 10) goto exit;
> > > >     8: r7 =3D 0
> > > >     9: r9 +=3D r6
> > > >=20
> > > > __mark_chain_precision() would get to checkpoint #1 with only r6 as
> > > > precise, what should happen next?
> > >=20
> > > it should mark all SCALARs that have r6's ID in env->bt, and then
> > > proceed with precision propagation until next parent state? This is
> > > where you'll mark r7, because in parent state (checkpoint #1) r6.id =
=3D=3D
> > > r7.id.
> >=20
> > That's what I do now.
>=20
> Ok, cool...
>=20
> > Sorry, I thought you had a suggestion on how to avoid the precise set
> > overestimation (e.g. how to detect that "6: r7 =3D 0" breaks the link).
>=20
> ..but "overestimation" confuses me. There is no overestimation. After
> checkpoint #1 (let's say we have checkpoint #2 after instruction 9),
> r6 and r7 are not linked, and if we had to mark r6 as precise, we'd
> mark only r7. But as of checkpoint #1, r7.id =3D=3D r6.id and they are
> linked. So there is no overestimation. They are linked together as of
> checkpoint #1.

Sorry, I should have adjusted the example a bit more, consider:

                                   precise registers
     1: r6 =3D scalar of range X
     2: r7 =3D unbound scalar
     3: r8 =3D unbound scalar
     4: r9 =3D stack of size X
     5: if (r6 > r7) goto +1
     6: r7 =3D r6
    --- checkpoint #1 ---          r6, r7 (because r6.id =3D=3D r7.id in ch=
eckpoint #1)
     7: r7 =3D 0                     r6
     8: if (r7 > r8) goto exit     r6     (unpredictable jump =3D> r{7,8} n=
ot precise)
     9: r7 =3D 0                     r6
    10: r9 +=3D r6                   r6
    --- checkpoint #2 ---

Here there is no real need to mark r7 as precise, but current
algorithm would. Thus, we overestimate the set of precise registers.
(But it might be fine if workaround is complicated).

> But anyways, I think we are on the same page, even if we don't use the
> same words :)
>=20
> >=20
> > > It might be easier to just discuss latest code you have, there are
> > > lots of intricacies, and code wins over words :)
> >=20
> > Here is what I have now:
> > https://github.com/kernel-patches/bpf/compare/bpf-next_base...eddyz87:b=
pf:verify-ids-for-scalars-in-regsafe-v3
>=20
> feels a bit heavyweight to do sorting and stuff. I think in practice
> you'll have only very small amount of linked SCALAR IDs, so a simple
> linear search would be faster than all that sort+bsearch.
>=20
> Look at check_ids(). It's called all the time and is a linear search.
> I think it's fine to keep thing simple here as well.

:(
Ok, I can keep it linear.
In ideal world `sort` / `bsearch` would be inlined and have a special
case for count < 16 (or whatever is the magic number on modern CPUs).

> > The interesting part is mark_precise_scalar_ids().
> >=20
> > But a few tests are not passing because expected messages have to be ad=
justed.
> > And a lot of tests have to be added.
> > We can delay discussion until I submit v3 (worst case tomorrow).
> >=20
> > > > As a side note: I added several optimizations:
> > > > - avoid allocation of scalar ids for constants;
> > > > - remove sole scalar ids from cached states;
> > >=20
> > > so that's what I was proposing earlier,
> >=20
> > Yes, it turned out beneficial when I inspected logs for bpf_xdp.o.
> >=20
> > > but not just from cached
> > > states, but from any state. As soon as we get SCALAR with some ID tha=
t
> > > is not shared by any other SCALAR, we should try to drop that ID. The
> > > question is only in how to implement this efficiently.
> >=20
> > No, we don't want to do it for non-cached state, not until we generate
> > scalar ids on stack spills and fills. Otherwise we would break
> > find_equal_scalars() for the following case:
> >=20
> >   r1 =3D r2         // r1 gains ID
> >   fp[-8] =3D r1     //
> >   r2 =3D 0          //
> >   r1 =3D 0          // fp[-8] has a unique ID now
>=20
> exactly, as of right now there is no linked registers anymore, so we
> can clear ID
>=20
>=20
> >   --- checkpoint ---
> >   r1 =3D fp[-8]
>=20
> and this is where we should generate a new ID and assign it to r1.id
> and fp[-8].id.
>=20
> How is this fundamentally different from just `r1 =3D r2`?

I agree that IDs should be issued on spills and fills.
However, this is not happening right now.
I have an experimental patch-set with id generation at spill,
and see some verification performance issues.
If possible, I'd prefer to complete these two tasks separately.

> >   r2 =3D fp[-8]
>=20
> and now r2.id =3D r1.id =3D fp[-8].id (but it's different ID than as
> before checkpoint)
>=20
> >   if r1 > 10 goto exit; // range propagates to r2 now,
> >                         // but won't propagate if fp[-8] ID
> >                         // is cleared at checkpoint
> >=20
> > (A bit contrived, but conveys the idea)
> >=20
> > And we don't really need to bother about unique IDs in non-cached state
> > when rold->id check discussed in a sibling thread is used:
> >=20
> >                 if (rold->precise && rold->id && !check_ids(rold->id, r=
cur->id, idmap))
> >                         return false;
>=20
> It makes me worry that we are mixing no ID and ID-ed SCALARs and
> making them equivalent. I need to think some more about implications
> (and re-read what you and Alexei discussed). I don't feel good about
> this and suspect we'll miss some non-obvious corner case if we do
> this.

Here is the complete argument in a single piece:

  Suppose:
    - There is a checkpoint state 'Old' with two registers marked as:
      - rA=3Dprecise scalar with range A, id=3D0;
      - rB=3Dprecise scalar with range B, id=3D0.
    - 'Old' is proven to be safe.
    - There is a new state 'Cur' with two registers marked as:
      - rA=3Dscalar with range C, id=3DU;
      - rB=3Dscalar with range C, id=3DU;
        (Note: if rA.id =3D=3D rB.id the registers have identical range).

  Proposition:
    As long as range C is a subset of both range A and range B
    the state 'Cur' is safe.

  Proof:
    State 'Cur' represents a special case of state 'Old',
    a variant of 'Old' where rA and rB happen to have same value.
    Thus 'Cur' is safe because 'Old' is safe.

> >=20
> > Here, if rcur->id is unique there are two cases:
> > - rold->id =3D=3D 0: then rcur->id is just ignored
> > - rold->id !=3D 0: then rold->id/rcur->id pair would be added to idmap,
> >                  there is some other precise old register with the
> >                  same id as rold->id, so eventually check_ids()
> >                  would make regsafe() return false.
> >=20
> > > > - do a check as follows:
> > > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> > > >     return false;
> > >=20
> > > Hm.. do we need extra special case here? With precision changes we ar=
e
> > > discussion, and this removing singular SCALAR IDs you are proposing,
> > > just extending existing logic to:
> > >=20
> > >                 if (regs_exact(rold, rcur, idmap))
> > >                         return true;
> > >                 if (env->explore_alu_limits)
> > >                         return false;
> > >                 if (!rold->precise)
> > >                         return true;
> > >                 /* new val must satisfy old val knowledge */
> > >                 return range_within(rold, rcur) &&
> > >                        check_ids(rold->id, rcur->id, idmap) &&
> > >                        check_ids(rold->ref_obj_id, rcur->ref_obj_id, =
idmap) &&
> > >                        tnum_in(rold->var_off, rcur->var_off);
> > >=20
> > > wouldn't be enough?
> >=20
> > Yes, it could be shortened as below:
> >=20
> >                  return range_within(rold, rcur) &&
> >                         (rold->id =3D=3D 0 || check_ids(rold->id, rcur-=
>id, idmap)) &&
> >                         check_ids(rold->ref_obj_id, rcur->ref_obj_id, i=
dmap) &&
> >                         tnum_in(rold->var_off, rcur->var_off);
> >=20
> > but I wanted a separate place to put a long comment at.
>=20
> you can still put a big comment right here? At the very least I'd move
> this new condition to after `if (!rold->precise)`. Where you put it
> right now seems a bit out of place.

I'll move the condition after `if (!rold->precise)`.

> > > > And I'm seeing almost zero performance overhead now.
> > > > So, maybe what we figured so far is good enough.
> > > > Need to add more tests, though.
> >=20



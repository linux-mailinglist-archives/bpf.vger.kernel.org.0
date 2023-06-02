Return-Path: <bpf+bounces-1747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF478720AE2
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAD71C211E3
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3A8833;
	Fri,  2 Jun 2023 21:13:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996A8493
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 21:13:12 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43FC9D
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 14:13:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso3390672e87.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685740389; x=1688332389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pW8Xfrbtu8FqnEdbAsuMKC0MKMVOE1C/Z/r5IdKKEoE=;
        b=hur3l0xmR1x99pRii1ypxITdecvMy2rHvJLn4sjj0MyWmV0sZI0K/mRZafIqzb1X9P
         M5vKlMeT+SLIsCQNDYH6sPlNXMmKfCfcpoE246ly1p96akWa0T24qzmZx+L00ytngl33
         EE5cG0UXH2CwAxmWhrziJMnL9gdZyUiIn+SLWhL0m1hwV6Fjrphtq2RaxpBEqpAl+wDo
         BnTL7hBtsECT8gdlZfkNBXP15+dqU1zA6gNxCVJGh412Hojd7ma3bYAbN94+O+be/JoQ
         KaZxDTWJHDKjdo+q9/cozAFUt46kpMfCe1KdWPDGJv8pjwSc8LhueP2Dpfq1E0iF/Bbg
         Vo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685740389; x=1688332389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW8Xfrbtu8FqnEdbAsuMKC0MKMVOE1C/Z/r5IdKKEoE=;
        b=QUZZnnOZS+MVhTH0ALK/1MGlxYWyI12AB1Xxl1nsxt8GH80xCw0WkYUUWN3Nhm0x2X
         ZpttMs9vWITm8H6ERysDdqYLzu3D83UAbZSrho7kFv6lHajjcDrqiyQ5aAZyqTOes1+v
         xzV1bSpxd6lDrntK70XZLkHpQpXxQ4GLsrhEzd+rDNfSYn5K1nWFyzWwHO1mb+pV5cpF
         tXq4/Q45UBcVHPKSlBA2t2jGmNyY5Mya2q4C7X7oa8zW/EV8LqfJSRBAfLyOH0FDa5+x
         XlA78J0bqgJ3ieJCxkWgGYvE+CsV4FvJNGJuL3PzAYnfwP8ky7MGtv7/Lw1gu0KkLL3L
         2WUw==
X-Gm-Message-State: AC+VfDzx8I0G1xkECv9SzzNbt0I1rUrsqZoVhcMPDE1w0qGDA5XGHSVC
	a2x2JOe3qMgDK7iCOu7tmG8=
X-Google-Smtp-Source: ACHHUZ7lNaMP8KHhAhnCsEqRl0qtDlPyohgDnd3BfS/QM5eAimJHOOdpV+om0vROoDy7RoZOhJbUMQ==
X-Received: by 2002:a19:f00a:0:b0:4f6:60:ee0f with SMTP id p10-20020a19f00a000000b004f60060ee0fmr2249630lfc.40.1685740388609;
        Fri, 02 Jun 2023 14:13:08 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x26-20020ac25dda000000b004f260f33ed0sm275656lfq.148.2023.06.02.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:13:08 -0700 (PDT)
Message-ID: <6cbfe3170e72fb981823cb7680a204c62ab36ede.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yhs@fb.com>
Date: Sat, 03 Jun 2023 00:13:06 +0300
In-Reply-To: <CAEf4BzY8u_JbwBi=wYLFopj79MOfKGnyWo9O19esBqoT2zsABA@mail.gmail.com>
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

On Fri, 2023-06-02 at 13:17 -0700, Andrii Nakryiko wrote:
> On Fri, Jun 2, 2023 at 12:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2023-06-02 at 11:50 -0700, Andrii Nakryiko wrote:
> > [...]
> > > > > The thread is long. Could you please describe it again in pseudo =
code?
> > > >=20
> > > > - Add a function mark_precise_scalar_ids(struct bpf_verifier_env *e=
nv,
> > > >                                         struct bpf_verifier_state *=
st)
> > > >   such that it:
> > > >   - collect PRECISE_IDS: a set of IDs of all registers marked in en=
v->bt
> > > >   - visit all registers with ids from PRECISE_IDS and make sure
> > > >     that these registers are marked in env->bt
> > > > - Call mark_precise_scalar_ids() from __mark_chain_precision()
> > > >   for each state 'st' visited by states chain processing loop,
> > > >   so that:
> > > >   - mark_precise_scalar_ids() is called for current state when
> > > >     __mark_chain_precision() is entered, reusing id assignments in
> > > >     current state;
> > > >   - mark_precise_scalar_ids() is called for each parent state, reus=
ing
> > > >     id assignments valid at 'last_idx' instruction of that state.
> > > >=20
> > > > The idea is that in situations like below:
> > > >=20
> > > >    4: if (r6 > r7) goto +1
> > > >    5: r7 =3D r6
> > > >    --- checkpoint #1 ---
> > > >    6: <something>
> > > >    7: if (r7 > X) goto ...
> > > >    8: r7 =3D 0
> > > >    9: r9 +=3D r6
> > > >=20
> > > > The mark_precise_scalar_ids() would be called at:
> > > > - (9) and current id assignments would be used.
> > > > - (6) and id assignments saved in checkpoint #1 would be used.
> > > >=20
> > > > If <something> is the code that modifies r6/r7 the link would be
> > > > broken and we would overestimate the set of precise registers.
> > > >=20
> > >=20
> > > To avoid this we need to recalculate these IDs on each new parent
> > > state, based on requested precision marks. If we keep a simple and
> > > small array of IDs and do a quick linear search over them for each
> > > SCALAR register, I suspect it should be very fast. I don't think in
> > > practice we'll have more than 1-2 IDs in that array, right?
> >=20
> > I'm not sure I understand, could you please describe how it should
> > work for e.g.?:
> >=20
> >     3: r6 &=3D 0xf            // assume safe bound
> >     4: if (r6 > r7) goto +1
> >     5: r7 =3D r6
> >     --- checkpoint #1 ---
> >     6: r7 =3D 0
> >     7: if (r7 > 10) goto exit;
> >     8: r7 =3D 0
> >     9: r9 +=3D r6
> >=20
> > __mark_chain_precision() would get to checkpoint #1 with only r6 as
> > precise, what should happen next?
>=20
> it should mark all SCALARs that have r6's ID in env->bt, and then
> proceed with precision propagation until next parent state? This is
> where you'll mark r7, because in parent state (checkpoint #1) r6.id =3D=
=3D
> r7.id.

That's what I do now.
Sorry, I thought you had a suggestion on how to avoid the precise set
overestimation (e.g. how to detect that "6: r7 =3D 0" breaks the link).

> It might be easier to just discuss latest code you have, there are
> lots of intricacies, and code wins over words :)

Here is what I have now:
https://github.com/kernel-patches/bpf/compare/bpf-next_base...eddyz87:bpf:v=
erify-ids-for-scalars-in-regsafe-v3
The interesting part is mark_precise_scalar_ids().

But a few tests are not passing because expected messages have to be adjust=
ed.
And a lot of tests have to be added.
We can delay discussion until I submit v3 (worst case tomorrow).

> > As a side note: I added several optimizations:
> > - avoid allocation of scalar ids for constants;
> > - remove sole scalar ids from cached states;
>=20
> so that's what I was proposing earlier,

Yes, it turned out beneficial when I inspected logs for bpf_xdp.o.

> but not just from cached
> states, but from any state. As soon as we get SCALAR with some ID that
> is not shared by any other SCALAR, we should try to drop that ID. The
> question is only in how to implement this efficiently.

No, we don't want to do it for non-cached state, not until we generate
scalar ids on stack spills and fills. Otherwise we would break
find_equal_scalars() for the following case:

  r1 =3D r2         // r1 gains ID
  fp[-8] =3D r1     //
  r2 =3D 0          //=20
  r1 =3D 0          // fp[-8] has a unique ID now
  --- checkpoint ---
  r1 =3D fp[-8]
  r2 =3D fp[-8]
  if r1 > 10 goto exit; // range propagates to r2 now,
                        // but won't propagate if fp[-8] ID
                        // is cleared at checkpoint

(A bit contrived, but conveys the idea)

And we don't really need to bother about unique IDs in non-cached state
when rold->id check discussed in a sibling thread is used:

		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id, idmap))
			return false;

Here, if rcur->id is unique there are two cases:
- rold->id =3D=3D 0: then rcur->id is just ignored
- rold->id !=3D 0: then rold->id/rcur->id pair would be added to idmap,
                 there is some other precise old register with the
                 same id as rold->id, so eventually check_ids()
                 would make regsafe() return false.

> > - do a check as follows:
> >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> >     return false;
>=20
> Hm.. do we need extra special case here? With precision changes we are
> discussion, and this removing singular SCALAR IDs you are proposing,
> just extending existing logic to:
>=20
>                 if (regs_exact(rold, rcur, idmap))
>                         return true;
>                 if (env->explore_alu_limits)
>                         return false;
>                 if (!rold->precise)
>                         return true;
>                 /* new val must satisfy old val knowledge */
>                 return range_within(rold, rcur) &&
>                        check_ids(rold->id, rcur->id, idmap) &&
>                        check_ids(rold->ref_obj_id, rcur->ref_obj_id, idma=
p) &&
>                        tnum_in(rold->var_off, rcur->var_off);
>=20
> wouldn't be enough?

Yes, it could be shortened as below:

                 return range_within(rold, rcur) &&
                        (rold->id =3D=3D 0 || check_ids(rold->id, rcur->id,=
 idmap)) &&
                        check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap=
) &&
                        tnum_in(rold->var_off, rcur->var_off);

but I wanted a separate place to put a long comment at.

> >=20
> > And I'm seeing almost zero performance overhead now.
> > So, maybe what we figured so far is good enough.
> > Need to add more tests, though.



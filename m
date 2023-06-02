Return-Path: <bpf+bounces-1741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8680720A2C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B41C2121F
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15B1F188;
	Fri,  2 Jun 2023 20:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647611F17E
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:18:13 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE7D1B5
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:18:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-969f90d71d4so354052366b.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685737090; x=1688329090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btERih1uFiBsUKRzvk9flvWiRItslWH2YKuCYeDuBjo=;
        b=o4ZTMbQ6g/uf+7VE8KImeiDabE86HYBcuEh5IL3ETC3/+b8BfAPcxfw2csuyHVxooF
         7pFHTBqrHRVyiVul593Uouw/BbmIH8qLNnHrQatdUHWN0XrVy+ZnsFBzMCUHeD2aq4wl
         qmdazKsPRF+NmcgpHgSHp05uWKdSoxcQ0ifkLxXUkIUE1ITRujj/ekavxuymV6JBI0to
         Q8fE2DNCqdPcdwnTB3urYthhJ97f1oJ7L16rlbaF4Xek/rNvZGnt34m2NtRdzqU+fgBB
         CrQXNDIH8WP/Y8Hzl1h6/TOEAEHUGpZzrNN6KLFxh1UYLajx/kFE0OA6EqIs+wFjGykO
         epFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685737090; x=1688329090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btERih1uFiBsUKRzvk9flvWiRItslWH2YKuCYeDuBjo=;
        b=gwLJnRCEiilxc9RaWdIYqBPgkxRv30KRJr1hk5pWuHwDmfTs1hkpH4HekRtgw+K8An
         8xqSXChqhamq/3iWd0fugti2XV7yO0tuc9n8uATybpxaSbkbgVri0Ktn6QAW7tCICju7
         Smm+xR0hmh6UpByIk5kSePlTG2W6XN/AQyYJoF1mY2MF/6SnvXPhnSU+FlNXKAfDq6x4
         LAdqStoSaCb9dBes0E6yY5aDQBzccafTxRFYrOCigcAR4/B7CY47cD/rHMzA7f+Cl3L2
         NXfVt8N/nZ5qCLlJjoL767vR/gB9j7fEHebHdJU8V1lW0xYXwlZlroCfkDLSXUFEyq1Q
         NxGw==
X-Gm-Message-State: AC+VfDwCijkD7z2KQKrp7zKPQ8OX03xTfhXooBTqBb32pzyWBGFKE8lN
	QnSOL54yfDXbUHQwXoqzrrQI5atYJtbJJcnsa2A=
X-Google-Smtp-Source: ACHHUZ6L2p+gwTy7aO08gozAGHynMUWnIN95/UDWQn/cfwlSufdgmnZpNcO3LgNkkfLhfS9oYJgX+N8jiJYqtFTbDZE=
X-Received: by 2002:a17:907:1624:b0:973:dd5b:4072 with SMTP id
 hb36-20020a170907162400b00973dd5b4072mr1978826ejc.53.1685737089764; Fri, 02
 Jun 2023 13:18:09 -0700 (PDT)
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
 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com> <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
In-Reply-To: <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 13:17:57 -0700
Message-ID: <CAEf4BzY8u_JbwBi=wYLFopj79MOfKGnyWo9O19esBqoT2zsABA@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 12:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-06-02 at 11:50 -0700, Andrii Nakryiko wrote:
> [...]
> > > > The thread is long. Could you please describe it again in pseudo co=
de?
> > >
> > > - Add a function mark_precise_scalar_ids(struct bpf_verifier_env *env=
,
> > >                                         struct bpf_verifier_state *st=
)
> > >   such that it:
> > >   - collect PRECISE_IDS: a set of IDs of all registers marked in env-=
>bt
> > >   - visit all registers with ids from PRECISE_IDS and make sure
> > >     that these registers are marked in env->bt
> > > - Call mark_precise_scalar_ids() from __mark_chain_precision()
> > >   for each state 'st' visited by states chain processing loop,
> > >   so that:
> > >   - mark_precise_scalar_ids() is called for current state when
> > >     __mark_chain_precision() is entered, reusing id assignments in
> > >     current state;
> > >   - mark_precise_scalar_ids() is called for each parent state, reusin=
g
> > >     id assignments valid at 'last_idx' instruction of that state.
> > >
> > > The idea is that in situations like below:
> > >
> > >    4: if (r6 > r7) goto +1
> > >    5: r7 =3D r6
> > >    --- checkpoint #1 ---
> > >    6: <something>
> > >    7: if (r7 > X) goto ...
> > >    8: r7 =3D 0
> > >    9: r9 +=3D r6
> > >
> > > The mark_precise_scalar_ids() would be called at:
> > > - (9) and current id assignments would be used.
> > > - (6) and id assignments saved in checkpoint #1 would be used.
> > >
> > > If <something> is the code that modifies r6/r7 the link would be
> > > broken and we would overestimate the set of precise registers.
> > >
> >
> > To avoid this we need to recalculate these IDs on each new parent
> > state, based on requested precision marks. If we keep a simple and
> > small array of IDs and do a quick linear search over them for each
> > SCALAR register, I suspect it should be very fast. I don't think in
> > practice we'll have more than 1-2 IDs in that array, right?
>
> I'm not sure I understand, could you please describe how it should
> work for e.g.?:
>
>     3: r6 &=3D 0xf            // assume safe bound
>     4: if (r6 > r7) goto +1
>     5: r7 =3D r6
>     --- checkpoint #1 ---
>     6: r7 =3D 0
>     7: if (r7 > 10) goto exit;
>     8: r7 =3D 0
>     9: r9 +=3D r6
>
> __mark_chain_precision() would get to checkpoint #1 with only r6 as
> precise, what should happen next?

it should mark all SCALARs that have r6's ID in env->bt, and then
proceed with precision propagation until next parent state? This is
where you'll mark r7, because in parent state (checkpoint #1) r6.id =3D=3D
r7.id.

It might be easier to just discuss latest code you have, there are
lots of intricacies, and code wins over words :)

>
> As a side note: I added several optimizations:
> - avoid allocation of scalar ids for constants;
> - remove sole scalar ids from cached states;

so that's what I was proposing earlier, but not just from cached
states, but from any state. As soon as we get SCALAR with some ID that
is not shared by any other SCALAR, we should try to drop that ID. The
question is only in how to implement this efficiently.

> - do a check as follows:
>   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
>     return false;

Hm.. do we need extra special case here? With precision changes we are
discussion, and this removing singular SCALAR IDs you are proposing,
just extending existing logic to:

                if (regs_exact(rold, rcur, idmap))
                        return true;
                if (env->explore_alu_limits)
                        return false;
                if (!rold->precise)
                        return true;
                /* new val must satisfy old val knowledge */
                return range_within(rold, rcur) &&
                       check_ids(rold->id, rcur->id, idmap) &&
                       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap)=
 &&
                       tnum_in(rold->var_off, rcur->var_off);

wouldn't be enough?


>
> And I'm seeing almost zero performance overhead now.
> So, maybe what we figured so far is good enough.
> Need to add more tests, though.


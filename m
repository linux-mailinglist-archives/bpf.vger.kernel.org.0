Return-Path: <bpf+bounces-1730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07159720967
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7BB1C211FB
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614F1DDE2;
	Fri,  2 Jun 2023 18:50:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAC17759
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:50:43 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10441BB
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 11:50:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-97392066d04so345068266b.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685731837; x=1688323837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvzwwfOXDP/mlvJMsW6NWyy8/S4RNHp0cOCAPbbVGJ8=;
        b=CV3KVKZe8UDOmbUq4qWT/zCMxLSMJx4KsrjMgxEoDKT+ZiYPz/v1l6ij7U8ATSbpkF
         eD3g+qFtbKqhbmFt3pX28fFbyv1J7FQRcifFjhZRJqj52I/eDhffw2fSsy+PiGZKG6Dx
         jfbMZuu4AArnc7pyvX0KKRTy4JpfJWOIs7FclZ5RwXroIyc3UaLCnZwumliBHZhq2T44
         f+xug/v1tlkfGaYbAFTsLX+wyvITbxK3B5dV5/WWyryb6ayQ9WJ7K646l8gdvbrjiKKg
         95BJlRwtFmSNZLoGqo9YTRz7A4Jmj1M+pamainCP0kQVeXj5dLYO6w5eq/nxVxmU0R2v
         K0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685731837; x=1688323837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvzwwfOXDP/mlvJMsW6NWyy8/S4RNHp0cOCAPbbVGJ8=;
        b=EFgeJT7Gpmiu9uHLfdu0InMGfa6jJpYnb7uPAsbeVcVr8F+pRsShi0s7YI76eMMH+7
         zlQtRn4nyunVWs7YmussfR+4OcuUehmZqD3lSoXwkmssymn4Z5oXA/dQyUAuFPi2xsch
         23orLc77B8ucUyV077ZkFaxZszlCdxpuoe4Ej9gU1j6rzyDm1JvXoIxjPjfnVGdwf8YQ
         uVmReNLNA2jayLcgNqHobkOpcxRjs+ymkkvYgu+LcKHJB9AoqW3BjHOa58peBDTc93W2
         M1ywpwmEc1aOYiI8FGTgoaFiF6IOyq/UTEspywnJum+SLWNQjv9SOejOZNkpJde72LFJ
         lfAg==
X-Gm-Message-State: AC+VfDxw8WLQ9nk00AiC0oGw+lD+/+MqriAka4PbaWqxrgcfBP6BQcKK
	g6TfcqAJhNATi4Z+7AbCdzfRs5NNVP9JKzLwhHaEqUNLOC8=
X-Google-Smtp-Source: ACHHUZ6N0JwDuhr5igQHKHsc98ZAW0b6P/Esb8pEFnPALYwN/W8MF9boRhauChPyat6tRfooFGISr5CuMpU8cyfsF24=
X-Received: by 2002:a17:907:7b99:b0:96f:9962:be19 with SMTP id
 ne25-20020a1709077b9900b0096f9962be19mr10607833ejc.31.1685731836762; Fri, 02
 Jun 2023 11:50:36 -0700 (PDT)
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
 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com> <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
In-Reply-To: <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 11:50:24 -0700
Message-ID: <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 11:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-06-01 at 10:13 -0700, Alexei Starovoitov wrote:
> > On Thu, Jun 1, 2023 at 9:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2023-05-31 at 19:05 -0700, Alexei Starovoitov wrote:
> > > > [...]
> > > > > Suppose that current verification path is 1-7:
> > > > > - On a way down 1-6 r7 will not be marked as precise, because
> > > > >   condition (r7 > X) is not predictable (see check_cond_jmp_op())=
;
> > > > > - When (7) is reached mark_chain_precision() will start moving up
> > > > >   marking the following registers as precise:
> > > > >
> > > > >   4: if (r6 > r7) goto +1 ; r6, r7
> > > > >   5: r7 =3D r6              ; r6
> > > > >   6: if (r7 > X) goto ... ; r6
> > > > >   7: r9 +=3D r6             ; r6
> > > > >
> > > > > - Thus, if checkpoint is created for (6) r7 would be marked as re=
ad,
> > > > >   but will not be marked as precise.
> > > > >
> > > > > Next, suppose that jump from 4 to 6 is verified and checkpoint fo=
r (6)
> > > > > is considered:
> > > > > - r6 is not precise, so check_ids() is not called for it and it i=
s not
> > > > >   added to idmap;
> > > > > - r7 is precise, so check_ids() is called for it, but it is a sol=
e
> > > > >   register in the idmap;
> > > >
> > > > typos in above?
> > > > r6 is precise and r7 is not precise.
> > >
> > > Yes, it should be the other way around in the description:
> > > r6 precise, r7 not precise. Sorry for confusion.
> > >
> > > > > - States are considered equal.
> > > > >
> > > > > Here is the log (I added a few prints for states cache comparison=
):
> > > > >
> > > > >   from 10 to 13: safe
> > > > >     steq hit 10, cur:
> > > > >       R0=3Dscalar(id=3D2) R6=3Dscalar(id=3D2) R7=3Dscalar(id=3D1)=
 R9=3Dfp-8 R10=3Dfp0 fp-8=3D00000000
> > > > >     steq hit 10, old:
> > > > >       R6_rD=3DPscalar(id=3D2) R7_rwD=3Dscalar(id=3D2) R9_rD=3Dfp-=
8 R10=3Dfp0 fp-8_rD=3D00000000
> > > >
> > > > the log is correct, thouhg.
> > > > r6_old =3D Pscalar which will go through check_ids() successfully a=
nd both are unbounded.
> > > > r7_old is not precise. different id-s don't matter and different ra=
nges don't matter.
> > > >
> > > > As another potential fix...
> > > > can we mark_chain_precision() right at the time of R1 =3D R2 when w=
e do
> > > > src_reg->id =3D ++env->id_gen
> > > > and copy_register_state();
> > > > for both regs?
> > >
> > > This won't help, e.g. for the original example precise markings would=
 be:
> > >
> > >   4: if (r6 > r7) goto +1 ; r6, r7
> > >   5: r7 =3D r6              ; r6, r7
> > >   6: if (r7 > X) goto ... ; r6     <-- mark for r7 is still missing
> > >   7: r9 +=3D r6             ; r6
> >
> > Because 6 is a new state and we do mark_all_scalars_imprecise() after 5=
 ?
>
> Yes, precision marks are not inherited by child states.
>
> >
> > > What might help is to call mark_chain_precision() from
> > > find_equal_scalars(), but I expect this to be very expensive.
> >
> > maybe worth giving it a shot?
>
> Sure, will report a bit later today.
>
> > > > I think
> > > > if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
> > > > would be good property to have.
> > > > I don't like u32_hashset either.
> > > > It's more or less saying that scalar id-s are incompatible with pre=
cision.
> > > >
> > > > I hope we don't need to do:
> > > > +       u32 reg_ids[MAX_CALL_FRAMES];
> > > > for backtracking either.
> > > > Hacking id-s into jmp history is equally bad.
> > > >
> > > > Let's figure out a minimal fix.
> > >
> > > Solution discussed with Andrii yesterday seems to work.
> >
> > The thread is long. Could you please describe it again in pseudo code?
>
> - Add a function mark_precise_scalar_ids(struct bpf_verifier_env *env,
>                                         struct bpf_verifier_state *st)
>   such that it:
>   - collect PRECISE_IDS: a set of IDs of all registers marked in env->bt
>   - visit all registers with ids from PRECISE_IDS and make sure
>     that these registers are marked in env->bt
> - Call mark_precise_scalar_ids() from __mark_chain_precision()
>   for each state 'st' visited by states chain processing loop,
>   so that:
>   - mark_precise_scalar_ids() is called for current state when
>     __mark_chain_precision() is entered, reusing id assignments in
>     current state;
>   - mark_precise_scalar_ids() is called for each parent state, reusing
>     id assignments valid at 'last_idx' instruction of that state.
>
> The idea is that in situations like below:
>
>    4: if (r6 > r7) goto +1
>    5: r7 =3D r6
>    --- checkpoint #1 ---
>    6: <something>
>    7: if (r7 > X) goto ...
>    8: r7 =3D 0
>    9: r9 +=3D r6
>
> The mark_precise_scalar_ids() would be called at:
> - (9) and current id assignments would be used.
> - (6) and id assignments saved in checkpoint #1 would be used.
>
> If <something> is the code that modifies r6/r7 the link would be
> broken and we would overestimate the set of precise registers.
>

To avoid this we need to recalculate these IDs on each new parent
state, based on requested precision marks. If we keep a simple and
small array of IDs and do a quick linear search over them for each
SCALAR register, I suspect it should be very fast. I don't think in
practice we'll have more than 1-2 IDs in that array, right?


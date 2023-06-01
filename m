Return-Path: <bpf+bounces-1624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CD71F269
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5114E28190C
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9F1DDC3;
	Thu,  1 Jun 2023 18:52:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF54168A4
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 18:52:25 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2C137
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 11:52:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so1677201e87.3
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685645542; x=1688237542;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtvFZ8jQEyKHYhIn7jOl+ty0P9ScKrIQGrsmP/iSV9w=;
        b=rt7K3iXSXMKU7pE0i2tzUsfth8lRl8drE4p+FONH6iFC68ZCaUofcHd0Y7Fh8IzwNS
         1jGAQB6ESnnHMA1DQiNcjXpomHf/a0HHod2Xw+FOg6Q4TVLAIBjR3uWG+Sx5hUYCtn9l
         Nqd3sp2dy84HYXjcQ2+cI+VpnZbvBEfevHQvzyTWQWCXIiF9YPLR+p1q7t4uAjwIXAnH
         mvSqaWCnAY9HItpexsDVq2CM5sGJbqSp5vwXU2ZqOnRQjjGNedOTkp9kdKbL4dFEDfsg
         EraojiEO14BO+qKOcfaJsHPpiRzJIRikf7ctyMLz+2TXHoXMcnZ3XzJgcx5gTvrP4/3N
         eTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685645542; x=1688237542;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtvFZ8jQEyKHYhIn7jOl+ty0P9ScKrIQGrsmP/iSV9w=;
        b=ZWkrg8i/g3Xe1zXZMQBXS5C84iWrEso2ac8gIpz33+kKQYihLpuemg7f2Ox8qSmZOj
         nAV615GZV8OGUHS5A5GvUelq0IBO35/Ks3tMOB3984qt2u3ATEY7jEoyiNaw1dyLpur4
         hWOX3mGMugCm/Z2FR8pw13D+acsEF5ElU+nhnFXluoviKW2lXbTpIP0gD2FBsHNel9fm
         pg/EYkzzfsAJxcTj9b8r1QT19atGjCmhKXBMDfhAQ3NMlYoBM8qQpX2AhwVy9dPP527R
         ySZAUUgy3bsRuXsx7Rs5EhoCScUaaSahOGIhjXH+IuPT+ZPy1opU1mnDgaTxGGr5G4Tk
         BIKA==
X-Gm-Message-State: AC+VfDxF5pSnACS4HFZIavzHM7q4pLOKq18Moaibi99qWtWS+8w5OhTB
	kui1jqh8hCTSOU4uO8M9xco=
X-Google-Smtp-Source: ACHHUZ7SBZXbHXxe7XiEHlU9PXhoqYMLaMHC2yPxDx1NfyHEeh5o0+DgB7aP9HpjHtVNOWypyCDD2Q==
X-Received: by 2002:ac2:4e71:0:b0:4f2:5c4b:e699 with SMTP id y17-20020ac24e71000000b004f25c4be699mr548618lfs.24.1685645541389;
        Thu, 01 Jun 2023 11:52:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l2-20020ac24a82000000b004eb44c2ab6bsm1162967lfp.294.2023.06.01.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:52:20 -0700 (PDT)
Message-ID: <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yhs@fb.com>
Date: Thu, 01 Jun 2023 21:52:19 +0300
In-Reply-To: <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
	 <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
	 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-01 at 10:13 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 1, 2023 at 9:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2023-05-31 at 19:05 -0700, Alexei Starovoitov wrote:
> > > [...]
> > > > Suppose that current verification path is 1-7:
> > > > - On a way down 1-6 r7 will not be marked as precise, because
> > > >   condition (r7 > X) is not predictable (see check_cond_jmp_op());
> > > > - When (7) is reached mark_chain_precision() will start moving up
> > > >   marking the following registers as precise:
> > > >=20
> > > >   4: if (r6 > r7) goto +1 ; r6, r7
> > > >   5: r7 =3D r6              ; r6
> > > >   6: if (r7 > X) goto ... ; r6
> > > >   7: r9 +=3D r6             ; r6
> > > >=20
> > > > - Thus, if checkpoint is created for (6) r7 would be marked as read=
,
> > > >   but will not be marked as precise.
> > > >=20
> > > > Next, suppose that jump from 4 to 6 is verified and checkpoint for =
(6)
> > > > is considered:
> > > > - r6 is not precise, so check_ids() is not called for it and it is =
not
> > > >   added to idmap;
> > > > - r7 is precise, so check_ids() is called for it, but it is a sole
> > > >   register in the idmap;
> > >=20
> > > typos in above?
> > > r6 is precise and r7 is not precise.
> >=20
> > Yes, it should be the other way around in the description:
> > r6 precise, r7 not precise. Sorry for confusion.
> >=20
> > > > - States are considered equal.
> > > >=20
> > > > Here is the log (I added a few prints for states cache comparison):
> > > >=20
> > > >   from 10 to 13: safe
> > > >     steq hit 10, cur:
> > > >       R0=3Dscalar(id=3D2) R6=3Dscalar(id=3D2) R7=3Dscalar(id=3D1) R=
9=3Dfp-8 R10=3Dfp0 fp-8=3D00000000
> > > >     steq hit 10, old:
> > > >       R6_rD=3DPscalar(id=3D2) R7_rwD=3Dscalar(id=3D2) R9_rD=3Dfp-8 =
R10=3Dfp0 fp-8_rD=3D00000000
> > >=20
> > > the log is correct, thouhg.
> > > r6_old =3D Pscalar which will go through check_ids() successfully and=
 both are unbounded.
> > > r7_old is not precise. different id-s don't matter and different rang=
es don't matter.
> > >=20
> > > As another potential fix...
> > > can we mark_chain_precision() right at the time of R1 =3D R2 when we =
do
> > > src_reg->id =3D ++env->id_gen
> > > and copy_register_state();
> > > for both regs?
> >=20
> > This won't help, e.g. for the original example precise markings would b=
e:
> >=20
> >   4: if (r6 > r7) goto +1 ; r6, r7
> >   5: r7 =3D r6              ; r6, r7
> >   6: if (r7 > X) goto ... ; r6     <-- mark for r7 is still missing
> >   7: r9 +=3D r6             ; r6
>=20
> Because 6 is a new state and we do mark_all_scalars_imprecise() after 5 ?

Yes, precision marks are not inherited by child states.

>=20
> > What might help is to call mark_chain_precision() from
> > find_equal_scalars(), but I expect this to be very expensive.
>=20
> maybe worth giving it a shot?

Sure, will report a bit later today.
=20
> > > I think
> > > if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
> > > would be good property to have.
> > > I don't like u32_hashset either.
> > > It's more or less saying that scalar id-s are incompatible with preci=
sion.
> > >=20
> > > I hope we don't need to do:
> > > +       u32 reg_ids[MAX_CALL_FRAMES];
> > > for backtracking either.
> > > Hacking id-s into jmp history is equally bad.
> > >=20
> > > Let's figure out a minimal fix.
> >=20
> > Solution discussed with Andrii yesterday seems to work.
>=20
> The thread is long. Could you please describe it again in pseudo code?

- Add a function mark_precise_scalar_ids(struct bpf_verifier_env *env,
                                        struct bpf_verifier_state *st)
  such that it:
  - collect PRECISE_IDS: a set of IDs of all registers marked in env->bt
  - visit all registers with ids from PRECISE_IDS and make sure
    that these registers are marked in env->bt
- Call mark_precise_scalar_ids() from __mark_chain_precision()
  for each state 'st' visited by states chain processing loop,
  so that:
  - mark_precise_scalar_ids() is called for current state when
    __mark_chain_precision() is entered, reusing id assignments in
    current state;
  - mark_precise_scalar_ids() is called for each parent state, reusing
    id assignments valid at 'last_idx' instruction of that state.

The idea is that in situations like below:

   4: if (r6 > r7) goto +1=20
   5: r7 =3D r6
   --- checkpoint #1 ---
   6: <something>
   7: if (r7 > X) goto ...=20
   8: r7 =3D 0
   9: r9 +=3D r6

The mark_precise_scalar_ids() would be called at:
- (9) and current id assignments would be used.
- (6) and id assignments saved in checkpoint #1 would be used.

If <something> is the code that modifies r6/r7 the link would be
broken and we would overestimate the set of precise registers.



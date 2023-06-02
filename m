Return-Path: <bpf+bounces-1736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BAD7209EA
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB701C211C4
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7821E530;
	Fri,  2 Jun 2023 19:37:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6617759
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:37:11 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B91A4
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 12:37:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so1406358e87.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685734623; x=1688326623;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0E+RXgD2ijdt97dVSUt6Zm8QlBPOjI5m0m7mBwlxvqo=;
        b=Wx6M7edbU1YwwkreFQ4DKw+Ryr27l/JFPKPaKY9CV5MKF6ZY+Kaey2gIh2AGwi0nXa
         aVoOL8kxH1g0HWxLWOgm2BLlsWY6wuH+SXKIV5BhfC98mZ5azo8STX4oAXIa12Erm7bK
         G66SU9jbG7uETwRhNmn5WJo2c0Bar/gmX4dIsAflV6b+Kwt/BT7PPrmCuCmFygf/3cmA
         jRVAafCsYlPkFhLe9lqgkA2CBnVbKafRLJvtdgDxaNR6p+18ES7/3x7FoqDGbCK79Eyn
         9ieIcKmmtuqxbYRFv7Pf9DRVvBY2KlCYCDT26CFUt5TXawB03hMqgHOYagt5z8yBgV1f
         WDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685734623; x=1688326623;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0E+RXgD2ijdt97dVSUt6Zm8QlBPOjI5m0m7mBwlxvqo=;
        b=XEU+G2X5nT9nhj1SHPRlUOOTn6UdOjMB+e33B7WXM0uUNvKgNZTtCxl7snse6XC20t
         33eZHDyyX29edoVj3upd96fUGRE7x10XRhDR2BiIG1fn1EBcFVtMIyS0W0Aila2QDt0u
         xd79QTxrlbzYJuqzA79DUZb+KWJuQuhaz3Mze0mLBDF3PBrQZn0D76DxcV/0bfgM/kl/
         p1rsP3bjPAhSJjI7k5g3OYfi78D9p6oDagTSqgJL7+uf65UYm+DTfj+kxAx/rvf7vjBE
         DpZlyGsrqB+x0JljvWYTuoln62/zfDy1Q1iyf186f9tykh9b1h0JNTNiJ7RJ4e/D7GW8
         eSQQ==
X-Gm-Message-State: AC+VfDxO/V/TMWCRgfJhejO2JtJiFEjUW2I2Vbk8X4K7QYmCZ9j6emF1
	N/90RnMIeAAZ0MFsP4uM/M0=
X-Google-Smtp-Source: ACHHUZ7X2sdS+hMllFEBkHv0aTCoD97AJjhWsMjysaMVNp2eGzNCRqTdVrGNHA+u8Th09JnF1Zg2LQ==
X-Received: by 2002:a05:651c:20e:b0:2af:160d:8897 with SMTP id y14-20020a05651c020e00b002af160d8897mr527667ljn.26.1685734622910;
        Fri, 02 Jun 2023 12:37:02 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p24-20020a2ea418000000b002a9ec7c0b4csm326442ljn.10.2023.06.02.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:37:02 -0700 (PDT)
Message-ID: <e5f82ece5f54067bf6c0514fdeb095f03636dd99.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yhs@fb.com>
Date: Fri, 02 Jun 2023 22:37:01 +0300
In-Reply-To: <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com>
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
	 <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com>
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

On Fri, 2023-06-02 at 12:27 -0700, Alexei Starovoitov wrote:
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
> >=20
> > As a side note: I added several optimizations:
> > - avoid allocation of scalar ids for constants;
>=20
> +1
>=20
> > - remove sole scalar ids from cached states;
> > - do a check as follows:
> >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
>=20
> Ignoring rcur->id > 0 ? Is it safe?

Well, I thought about it a bit and arrived to the following reasoning:
- suppose checkpoint C exists, is proven safe and has
  registers r6=3DPscalar(range1),id=3D0 and r7=3DPscalar(range2),id=3D0
- this means that C is proven safe for any value of
  r6 in range1 and any value of r7 in range2
- having same id on r6 and r7 means that r6 and r7 share same value
- so this is just a special case of what's already proven.

But having written this down, it looks like I also need to verify
that range1 and range2 overlap :(

>=20
> >     return false;
> >=20
> > And I'm seeing almost zero performance overhead now.
> > So, maybe what we figured so far is good enough.
> > Need to add more tests, though.



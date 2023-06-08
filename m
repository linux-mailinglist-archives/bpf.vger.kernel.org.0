Return-Path: <bpf+bounces-2135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002672866C
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652811C21037
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC71DCC5;
	Thu,  8 Jun 2023 17:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203F18011
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:35:27 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E02115
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so8757981fa.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686245721; x=1688837721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7u/A54PjFl1kidIsdZzgf/Ko57trAGd5rvftUG0Jn78=;
        b=B+559Bzz6wFLlHjdmqzMOqHpsCxkV3q0fmUFDy+O5ecN/D2lLcIT72HtecLBjnhgpB
         Nht+RFu6KoiumBZ8ZOCZeg+fh19EmAhYzkd7aWUDRpqf8p7rjhLJL/va06F0XK/W3maw
         H1GYA96KUAqCwJCjspvja0Ulxv7Ml65bjjLdJGOyYZT9R0fyYqhOUOl0nrwMvIvgKNHe
         EoClm5EWMbUnWeqEhcxNwtpYPNgpivwrMLqLwhvKdt5M11KrWQYuuLhsCiYc2O/QzKo2
         kktm+ZnbdGHNeQRusBZ7In61+a0IJClxhT3d/+gaW79KaOY+w9oYp2nP1EWeIjZx2Xa9
         5OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245721; x=1688837721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7u/A54PjFl1kidIsdZzgf/Ko57trAGd5rvftUG0Jn78=;
        b=P5U7rWzKXogdzHULM9UcnRkEX2AfeIfUF+GnvFN0VRr1KpJEAn/XvyC62KhXo88WtI
         xZLfbkziecuVWzL3nQfiGrVsBffaeZdQzhJ0E24ENshr0PTYo5g4cWUVS8vL9Cekp+hk
         bY/Z0nsv9ME9/vaMoC9Q1/M4bGSpe5NQaeIs2grdUxKKeep9UrJODqDZ4S4P5dBEC6cB
         0QkcohCZIpq29eQbqSxq/bTbUcnLd4jDYz+Fvd9sNaUcmhz1hMK5lbeDmcsPMNSlVgxU
         666jZPasFve3ybyaptcBwhx2L5OdJI4RwRqqSSMPSGXCcVvQfFOB5D60DzGcdTiYIBuN
         T8Ag==
X-Gm-Message-State: AC+VfDxBdHNhQyhxdqjQHBM10+nROHTdpBlqvakyTesAT2nyvUwojWlQ
	n1ZcR9PRfssvyIVHTvCTPG0=
X-Google-Smtp-Source: ACHHUZ5ZiGxGXEtrDhnwUx4vFjMzG3EqaBuCATEp4MMpieNqg+6sEZaNduJgjc3hHnYHJ2vPRUnH8g==
X-Received: by 2002:a05:651c:1025:b0:2b1:daca:676f with SMTP id w5-20020a05651c102500b002b1daca676fmr3598142ljm.36.1686245720881;
        Thu, 08 Jun 2023 10:35:20 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n18-20020a2e86d2000000b002ada919a09asm12471ljj.73.2023.06.08.10.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:35:20 -0700 (PDT)
Message-ID: <d7ef2af4648947abe8c5d8cec1c0d5235805f889.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: check if
 mark_chain_precision() follows scalar ids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 08 Jun 2023 20:35:19 +0300
In-Reply-To: <CAEf4BzaZ79t=dv0Kje-i5ngDFuE=LWbA4M=BOJF3bUfWSeVZrQ@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-3-eddyz87@gmail.com>
	 <CAEf4BzbLSe8H+ER6UTMgORH--bXKkn4popUsU2W0hHadSQuv1A@mail.gmail.com>
	 <8faef9d6a31616d71b798e0d3f94c6c1946e5cad.camel@gmail.com>
	 <CAEf4BzaZ79t=dv0Kje-i5ngDFuE=LWbA4M=BOJF3bUfWSeVZrQ@mail.gmail.com>
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

On Thu, 2023-06-08 at 10:33 -0700, Andrii Nakryiko wrote:
> On Thu, Jun 8, 2023 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> > > On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > Check __mark_chain_precision() log to verify that scalars with same
> > > > IDs are marked as precise. Use several scenarios to test that
> > > > precision marks are propagated through:
> > > > - registers of scalar type with the same ID within one state;
> > > > - registers of scalar type with the same ID cross several states;
> > > > - registers of scalar type  with the same ID cross several stack fr=
ames;
> > > > - stack slot of scalar type with the same ID;
> > > > - multiple scalar IDs are tracked independently.
> > > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > >  .../selftests/bpf/progs/verifier_scalar_ids.c | 324 ++++++++++++++=
++++
> > > >  2 files changed, 326 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_scal=
ar_ids.c
> > > >=20
> > >=20
> > > Great set of tests! I asked for yet another one, but this could be
> > > easily a follow up. Looks great.
> >=20
> > Thanks.
> >=20
> > >=20
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >=20
> > > [...]
> > >=20
> > > > +
> > > > +/* Same as precision_same_state_broken_link, but with state /
> > > > + * parent state boundary.
> > > > + */
> > > > +SEC("socket")
> > > > +__success __log_level(2)
> > > > +__msg("frame0: regs=3Dr0,r2 stack=3D before 6: (bf) r3 =3D r10")
> > > > +__msg("frame0: regs=3Dr0,r2 stack=3D before 5: (b7) r1 =3D 0")
> > > > +__msg("frame0: parent state regs=3Dr0,r2 stack=3D:")
> > > > +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 4: (05) goto pc+0")
> > > > +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 3: (bf) r2 =3D r0")
> > > > +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> > > > +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
> > > > +__msg("frame0: parent state regs=3Dr0 stack=3D:")
> > > > +__msg("frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_ktime_ge=
t_ns")
> > > > +__flag(BPF_F_TEST_STATE_FREQ)
> > > > +__naked void precision_cross_state_broken_link(void)
> > > > +{
> > > > +       asm volatile (
> > > > +       /* r0 =3D random number up to 0xff */
> > > > +       "call %[bpf_ktime_get_ns];"
> > > > +       "r0 &=3D 0xff;"
> > > > +       /* tie r0.id =3D=3D r1.id =3D=3D r2.id */
> > > > +       "r1 =3D r0;"
> > > > +       "r2 =3D r0;"
> > > > +       /* force checkpoint, although link between r1 and r{0,2} is
> > > > +        * broken by the next statement current precision tracking
> > > > +        * algorithm can't react to it and propagates mark for r1 t=
o
> > > > +        * the parent state.
> > > > +        */
> > > > +       "goto +0;"
> > > > +       /* break link for r1, this is the only line that differs
> > > > +        * compared to the previous test
> > > > +        */
> > >=20
> > > not really the only line, goto +0 is that different line ;)
> >=20
> > My bad, the comment should be "... this is the only line that differs
> > compared to precision_cross_state_broken()".
> >=20
> > >=20
> > > > +       "r1 =3D 0;"
> > > > +       /* force r0 to be precise, this immediately marks r1 and r2=
 as
> > > > +        * precise as well because of shared IDs
> > > > +        */
> > > > +       "r3 =3D r10;"
> > > > +       "r3 +=3D r0;"
> > > > +       "r0 =3D 0;"
> > > > +       "exit;"
> > > > +       :
> > > > +       : __imm(bpf_ktime_get_ns)
> > > > +       : __clobber_all);
> > > > +}
> > > > +
> > > > +/* Check that precision marks propagate through scalar IDs.
> > > > + * Use the same scalar ID in multiple stack frames, check that
> > > > + * precision information is propagated up the call stack.
> > > > + */
> > > > +SEC("socket")
> > > > +__success __log_level(2)
> > > > +/* bar frame */
> > > > +__msg("frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10")
> > > > +__msg("frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1")
> > > > +/* foo frame */
> > > > +__msg("frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1")
> > > > +__msg("frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1")
> > > > +__msg("frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1")
> > > > +/* main frame */
> > > > +__msg("frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0")
> > > > +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> > > > +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
> > >=20
> > > nice test! in this case we discover r6 and r7 during instruction
> > > backtracking. Let's add another variant of this multi-frame test with
> > > a forced checkpoint to make sure that all this works correctly betwee=
n
> > > child/parent states with multiple active frames?
> >=20
> > Because of BPF_F_TEST_STATE_FREQ new state is created at each prune
> > point. Prune points are marked for each conditional target and
> > sub-program entry. I skipped a lot of log lines for brevity, here is a
> > bigger portion of the log:
> >=20
> >   8: (85) call pc+1
> >   caller:
> >      frame1: R6=3Dscalar(id=3D1,...) R7=3Dscalar(id=3D1,...) R10=3Dfp0
> >   callee:
> >      frame2: R1=3Dscalar(id=3D1,...) R10=3Dfp0
> >   10: (bf) r2 =3D r10                     ; frame2: R2_w=3Dfp0 R10=3Dfp=
0
> >   11: (0f) r2 +=3D r1
> >   frame2: last_idx 11 first_idx 10 subseq_idx -1        <- current stat=
e
> >   frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10
> >   frame2: parent state regs=3Dr1 stack=3D
> >   frame1: parent state regs=3Dr6,r7 stack=3D                <- (I)
> >   frame0: parent state regs=3Dr6 stack=3D
> >=20
> >   frame2: last_idx 8 first_idx 8 subseq_idx 10          <- parent state
> >   frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1
> >   frame1: parent state regs=3Dr1,r6,r7 stack=3D             <- (II)
> >   frame0: parent state regs=3Dr6 stack=3D
> >=20
> >   frame1: last_idx 7 first_idx 6 subseq_idx 8           <- parent state
> >   frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1
> >   frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1
> >   frame1: parent state regs=3Dr1 stack=3D
> >   frame0: parent state regs=3Dr6 stack=3D
> >=20
> >   frame1: last_idx 4 first_idx 4 subseq_idx 6           <- parent state
> >   frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1
> >   frame0: parent state regs=3Dr1,r6 stack=3D
> >=20
> >   frame0: last_idx 3 first_idx 1 subseq_idx 4           <- parent state
> >   frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0
> >   frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0
> >   frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255
> >=20
> > At (I) frame1.r{6,7} are marked because mark_precise_scalar_ids()
> > looks for all registers with frame2.r1.id in the current state.
> > At (II) frame1.r1 is marked because of backtracking of call instruction=
.
> > It looks like both ba=D1=81ktracking and cross-state propagation are te=
sted.
> > Maybe I miss-understand your comment.
> >=20
>=20
> From the set of __msg() tests it's not obvious that (I) is happening.
> So just maybe let's messages like below:
>=20
> __msg("frame1: parent state regs=3Dr6,r7 stack=3D")
>=20
> to make it more explicit?

Yes good point,
I'll add a few __msg lines and a comment to make this thing clear.

>=20
> Either way, it's minor. You are right about checkpoint after each
> helper call and subprog call.
>=20
>=20
> > >=20
> > > > +__flag(BPF_F_TEST_STATE_FREQ)
> > > > +__naked void precision_many_frames(void)
> > > > +{
> > > > +       asm volatile (
> > > > +       /* r0 =3D random number up to 0xff */
> > > > +       "call %[bpf_ktime_get_ns];"
> > > > +       "r0 &=3D 0xff;"
> > > > +       /* tie r0.id =3D=3D r1.id =3D=3D r6.id */
> > > > +       "r1 =3D r0;"
> > > > +       "r6 =3D r0;"
> > > > +       "call precision_many_frames__foo;"
> > > > +       "exit;"
> > > > +       :
> > > > +       : __imm(bpf_ktime_get_ns)
> > > > +       : __clobber_all);
> > > > +}
> > > > +
> > > > +static __naked __noinline __attribute__((used))
> > >=20
> > > nit: bpf_misc.h has __used macro defined, we can use that everywhere
> > >=20
> > > > +void precision_many_frames__foo(void)
> > > > +{
> > > > +       asm volatile (
> > > > +       /* conflate one of the register numbers (r6) with outer fra=
me,
> > > > +        * to verify that those are tracked independently
> > > > +        */
> > > > +       "r6 =3D r1;"
> > > > +       "r7 =3D r1;"
> > > > +       "call precision_many_frames__bar;"
> > > > +       "exit"
> > > > +       ::: __clobber_all);
> > > > +}
> > > > +
> > >=20
> > > [...]
> >=20



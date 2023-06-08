Return-Path: <bpf+bounces-2125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9047284B4
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F81C20FEB
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E0174C0;
	Thu,  8 Jun 2023 16:17:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59581641A
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:17:18 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D8193
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 09:17:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f65779894eso132525e87.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241034; x=1688833034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CbkoO2d0MeTirIrP+AZ61BomtFpCIXFlMHDtcaYGc94=;
        b=l5PXfxHEfVK2FNq9cM2MovjlLMxuUANIY/PZCc4qGHhvtNRU+ViHJZ3IGFEx6+uuQa
         pubxQ+AVMQ3ut/PFyP1wzESmy8A5GiYZJDteFbMrBArzqjB2PO0eFhDBgSAJDpIgufZs
         gnvyf1WONvku5tbazcvRUpnYIiOtswWg9G2KKvo1FKd7k73ALtN4bG2rdDB6+DxyxlyV
         BvUuWFHvAHfCvfgCD9zjP4qrJEmPsXt85YP0wXTSeHBMSzDEj7gUYNE1YYWBufdfTuQn
         2enpSXv/aNFYV8J8A0ikC48j5eOpzobjV2lJH7Ry0d41GUF7QGdxcDi7H3nMoiP38l3D
         VOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241034; x=1688833034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbkoO2d0MeTirIrP+AZ61BomtFpCIXFlMHDtcaYGc94=;
        b=QzrDjhTHqiGy6K6eA74ORLrpHTJ52Ir0LHMaZbqFWA1USZn19gAClx1yILkubTl1Uh
         uHLCgesHcLKJko56e8E2yDw8O6JH9Uj7x35HOnhcm1n+EXCNxYfF8TIb0qHaLrUO+LQF
         p689J3SoYduyviIo4QYxkoKWaWc2Po8xQQqBQnDuVhjlL+deWRfKDdi7b7uN8rD4tjiK
         Ea149BO8kVm9Sl5HvXxwmtXY2RfFuvxfMoKZ6GMUjEdtbTWlophVgGhfIH5LhcbA3wi4
         d822JD/PTlgRBjZ0EOMTDH5Sb1DJ3PtnM2W8jeLTOL5wa+cbQGn4N1rUJGCMrqbcRIGU
         26qw==
X-Gm-Message-State: AC+VfDwKi8lbr5WmmT9h1LPnABdnqYrFI3Jjcl2xtMi5n9Vprv3Aso7H
	4pDtoHEZB0J9hNU9gQQm5Og=
X-Google-Smtp-Source: ACHHUZ6pu4L5FzsAeddesTe/vUey6jL353+8KPw36+1S018IM+AOg5DuGA4Uzi4t2647lGE1T0YDHg==
X-Received: by 2002:a19:ca06:0:b0:4f6:55:7d73 with SMTP id a6-20020a19ca06000000b004f600557d73mr890404lfg.25.1686241033876;
        Thu, 08 Jun 2023 09:17:13 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2562b000000b004f59c182f7bsm229212lff.249.2023.06.08.09.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:17:13 -0700 (PDT)
Message-ID: <8faef9d6a31616d71b798e0d3f94c6c1946e5cad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: check if
 mark_chain_precision() follows scalar ids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 08 Jun 2023 19:17:12 +0300
In-Reply-To: <CAEf4BzbLSe8H+ER6UTMgORH--bXKkn4popUsU2W0hHadSQuv1A@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-3-eddyz87@gmail.com>
	 <CAEf4BzbLSe8H+ER6UTMgORH--bXKkn4popUsU2W0hHadSQuv1A@mail.gmail.com>
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

On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Check __mark_chain_precision() log to verify that scalars with same
> > IDs are marked as precise. Use several scenarios to test that
> > precision marks are propagated through:
> > - registers of scalar type with the same ID within one state;
> > - registers of scalar type with the same ID cross several states;
> > - registers of scalar type  with the same ID cross several stack frames=
;
> > - stack slot of scalar type with the same ID;
> > - multiple scalar IDs are tracked independently.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  .../selftests/bpf/progs/verifier_scalar_ids.c | 324 ++++++++++++++++++
> >  2 files changed, 326 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_i=
ds.c
> >=20
>=20
> Great set of tests! I asked for yet another one, but this could be
> easily a follow up. Looks great.

Thanks.

>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> [...]
>=20
> > +
> > +/* Same as precision_same_state_broken_link, but with state /
> > + * parent state boundary.
> > + */
> > +SEC("socket")
> > +__success __log_level(2)
> > +__msg("frame0: regs=3Dr0,r2 stack=3D before 6: (bf) r3 =3D r10")
> > +__msg("frame0: regs=3Dr0,r2 stack=3D before 5: (b7) r1 =3D 0")
> > +__msg("frame0: parent state regs=3Dr0,r2 stack=3D:")
> > +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 4: (05) goto pc+0")
> > +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 3: (bf) r2 =3D r0")
> > +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> > +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
> > +__msg("frame0: parent state regs=3Dr0 stack=3D:")
> > +__msg("frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_ktime_get_ns=
")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void precision_cross_state_broken_link(void)
> > +{
> > +       asm volatile (
> > +       /* r0 =3D random number up to 0xff */
> > +       "call %[bpf_ktime_get_ns];"
> > +       "r0 &=3D 0xff;"
> > +       /* tie r0.id =3D=3D r1.id =3D=3D r2.id */
> > +       "r1 =3D r0;"
> > +       "r2 =3D r0;"
> > +       /* force checkpoint, although link between r1 and r{0,2} is
> > +        * broken by the next statement current precision tracking
> > +        * algorithm can't react to it and propagates mark for r1 to
> > +        * the parent state.
> > +        */
> > +       "goto +0;"
> > +       /* break link for r1, this is the only line that differs
> > +        * compared to the previous test
> > +        */
>=20
> not really the only line, goto +0 is that different line ;)

My bad, the comment should be "... this is the only line that differs
compared to precision_cross_state_broken()".

>=20
> > +       "r1 =3D 0;"
> > +       /* force r0 to be precise, this immediately marks r1 and r2 as
> > +        * precise as well because of shared IDs
> > +        */
> > +       "r3 =3D r10;"
> > +       "r3 +=3D r0;"
> > +       "r0 =3D 0;"
> > +       "exit;"
> > +       :
> > +       : __imm(bpf_ktime_get_ns)
> > +       : __clobber_all);
> > +}
> > +
> > +/* Check that precision marks propagate through scalar IDs.
> > + * Use the same scalar ID in multiple stack frames, check that
> > + * precision information is propagated up the call stack.
> > + */
> > +SEC("socket")
> > +__success __log_level(2)
> > +/* bar frame */
> > +__msg("frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10")
> > +__msg("frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1")
> > +/* foo frame */
> > +__msg("frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1")
> > +__msg("frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1")
> > +__msg("frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1")
> > +/* main frame */
> > +__msg("frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0")
> > +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> > +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
>=20
> nice test! in this case we discover r6 and r7 during instruction
> backtracking. Let's add another variant of this multi-frame test with
> a forced checkpoint to make sure that all this works correctly between
> child/parent states with multiple active frames?

Because of BPF_F_TEST_STATE_FREQ new state is created at each prune
point. Prune points are marked for each conditional target and
sub-program entry. I skipped a lot of log lines for brevity, here is a
bigger portion of the log:

  8: (85) call pc+1
  caller:
     frame1: R6=3Dscalar(id=3D1,...) R7=3Dscalar(id=3D1,...) R10=3Dfp0
  callee:
     frame2: R1=3Dscalar(id=3D1,...) R10=3Dfp0
  10: (bf) r2 =3D r10                     ; frame2: R2_w=3Dfp0 R10=3Dfp0
  11: (0f) r2 +=3D r1
  frame2: last_idx 11 first_idx 10 subseq_idx -1        <- current state
  frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10
  frame2: parent state regs=3Dr1 stack=3D
  frame1: parent state regs=3Dr6,r7 stack=3D                <- (I)
  frame0: parent state regs=3Dr6 stack=3D
 =20
  frame2: last_idx 8 first_idx 8 subseq_idx 10          <- parent state
  frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1
  frame1: parent state regs=3Dr1,r6,r7 stack=3D             <- (II)
  frame0: parent state regs=3Dr6 stack=3D
 =20
  frame1: last_idx 7 first_idx 6 subseq_idx 8           <- parent state
  frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1
  frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1
  frame1: parent state regs=3Dr1 stack=3D
  frame0: parent state regs=3Dr6 stack=3D
 =20
  frame1: last_idx 4 first_idx 4 subseq_idx 6           <- parent state
  frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1
  frame0: parent state regs=3Dr1,r6 stack=3D
 =20
  frame0: last_idx 3 first_idx 1 subseq_idx 4           <- parent state
  frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0
  frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0
  frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255

At (I) frame1.r{6,7} are marked because mark_precise_scalar_ids()
looks for all registers with frame2.r1.id in the current state.
At (II) frame1.r1 is marked because of backtracking of call instruction.
It looks like both ba=D1=81ktracking and cross-state propagation are tested=
.
Maybe I miss-understand your comment.

>=20
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void precision_many_frames(void)
> > +{
> > +       asm volatile (
> > +       /* r0 =3D random number up to 0xff */
> > +       "call %[bpf_ktime_get_ns];"
> > +       "r0 &=3D 0xff;"
> > +       /* tie r0.id =3D=3D r1.id =3D=3D r6.id */
> > +       "r1 =3D r0;"
> > +       "r6 =3D r0;"
> > +       "call precision_many_frames__foo;"
> > +       "exit;"
> > +       :
> > +       : __imm(bpf_ktime_get_ns)
> > +       : __clobber_all);
> > +}
> > +
> > +static __naked __noinline __attribute__((used))
>=20
> nit: bpf_misc.h has __used macro defined, we can use that everywhere
>=20
> > +void precision_many_frames__foo(void)
> > +{
> > +       asm volatile (
> > +       /* conflate one of the register numbers (r6) with outer frame,
> > +        * to verify that those are tracked independently
> > +        */
> > +       "r6 =3D r1;"
> > +       "r7 =3D r1;"
> > +       "call precision_many_frames__bar;"
> > +       "exit"
> > +       ::: __clobber_all);
> > +}
> > +
>=20
> [...]



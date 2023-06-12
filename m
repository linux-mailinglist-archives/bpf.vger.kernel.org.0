Return-Path: <bpf+bounces-2442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DC72CFC5
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AA828110C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CAC8F53;
	Mon, 12 Jun 2023 19:42:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB0881E
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:42:33 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED7E71
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:42:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso56078471fa.2
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686598949; x=1689190949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXw51h8vVp2WK0sQxFXIjxzS3/AzyssmHBJf+6K5QD4=;
        b=R/oqqYwNJvuIigioz6sy97y1QmMftNWM0Mp1s+k1Ua78wBYkVUe7ztL1YpZQuayz3j
         Oq9iFCf00oRR2oYygcBZFhZ1kEP8PBu0LJ7+AG1xYv3Q2kINQVSJR0b8t7auWCMUYX/A
         3nBV8PsUpKmTzwrXOPRYQHkfO5CF/+km4tvPkvl/vcYCgFXB2JY8uT9gJnclBrmFK6lt
         z37nXunUY0cchDtnq9tJ7HYmKQ1z2nwHlC1k+Wzp1Fbh6r4E7DhYWpuJ11icaXCejLlm
         k5JIan4egp8vres2/uXR2xoNK/+ccu0igoiLOfD81I6FcO2Gno3dyz4n8OfkpKGU9xFC
         VoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686598949; x=1689190949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXw51h8vVp2WK0sQxFXIjxzS3/AzyssmHBJf+6K5QD4=;
        b=RJpcr5REAa/pfKDl1UuQ/DSpvdoLo/vVCkG5Tkai+uxhEudRuW6FYiMFAqaWEDi1nh
         l2fOqqJzPjsbFZJTqS57TfPQDCuaRMagUa2lDDIDDg3RkHP7M4oRkORIa2QH6t3OqrFI
         poVwjzTi+6wenpFdfPxyDMNeho3pxPtTJ/u2nQM+3uAZUW/LrZD9PJmW14oYvUzhnjK5
         jkOQ5rlqNJAthYpMa+/9CWgt9m/suYNAfGwXbnFNr1BUXeZxpdGVI1+D74DC5nalmppX
         c/W6nVQw89rvLpQ9ivxMRLzI+4KIw1p0hqu4XPjNCrtrB3VMKYymnK94jz/St5q2JnPk
         rOCQ==
X-Gm-Message-State: AC+VfDwMqmsRN8yR0zfv52aHPV+8in0eyuta27f8RcqWA1K2xmABWI7o
	hon7mBTWvBmymufLJLS9qxY=
X-Google-Smtp-Source: ACHHUZ5iDdEbHK5jJpbrlicXdSAT4uQaTwGMDA3CVOd0R4LW5mA0+1d5M3C9u0Kbmt7QNpAsFAVxpw==
X-Received: by 2002:a2e:8606:0:b0:2b1:e74b:2452 with SMTP id a6-20020a2e8606000000b002b1e74b2452mr3237460lji.49.1686598949127;
        Mon, 12 Jun 2023 12:42:29 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e8692000000b002b04fc12365sm1895064lji.76.2023.06.12.12.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:42:28 -0700 (PDT)
Message-ID: <c8db6b0d05b6eb017e4d90b376c945c121735e19.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: verify that check_ids()
 is used for scalars in regsafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Mon, 12 Jun 2023 22:42:24 +0300
In-Reply-To: <ZIdYepniUlHlmtvO@mail.gmail.com>
References: <20230612160801.2804666-1-eddyz87@gmail.com>
	 <20230612160801.2804666-5-eddyz87@gmail.com>
	 <ZIdYepniUlHlmtvO@mail.gmail.com>
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

On Mon, 2023-06-12 at 20:40 +0300, Maxim Mikityanskiy wrote:
> On Mon, 12 Jun 2023 at 19:08:01 +0300, Eduard Zingerman wrote:
> > Verify that the following example is rejected by verifier:
> >=20
> >   r9 =3D ... some pointer with range X ...
> >   r6 =3D ... unbound scalar ID=3Da ...
> >   r7 =3D ... unbound scalar ID=3Db ...
> >   if (r6 > r7) goto +1
> >   r7 =3D r6
> >   if (r7 > X) goto exit
> >   r9 +=3D r6
> >   *(u64 *)r9 =3D Y
> >=20
> > Also add test cases to:
> > - check that check_alu_op() for BPF_MOV instruction does not allocate
> >   scalar ID if source register is a constant;
> > - check that unique scalar IDs are ignored when new verifier state is
> >   compared to cached verifier state;
> > - check that two different scalar IDs in a verified state can't be
> >   mapped to the same scalar ID in current state.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/progs/verifier_scalar_ids.c | 313 ++++++++++++++++++
> >  1 file changed, 313 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/=
tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> > index 8a5203fb14ca..5d56e764fe43 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> > @@ -341,4 +341,317 @@ __naked void precision_two_ids(void)
> >  	: __clobber_all);
> >  }
> > =20
> > +/* Verify that check_ids() is used by regsafe() for scalars.
> > + *
> > + * r9 =3D ... some pointer with range X ...
> > + * r6 =3D ... unbound scalar ID=3Da ...
> > + * r7 =3D ... unbound scalar ID=3Db ...
> > + * if (r6 > r7) goto +1
> > + * r6 =3D r7
> > + * if (r6 > X) goto exit
> > + * r9 +=3D r7
> > + * *(u8 *)r9 =3D Y
> > + *
> > + * The memory access is safe only if r7 is bounded,
> > + * which is true for one branch and not true for another.
> > + */
> > +SEC("socket")
> > +__failure __msg("register with unbounded min value")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void check_ids_in_regsafe(void)
> > +{
> > +	asm volatile (
> > +	/* Bump allocated stack */
> > +	"r1 =3D 0;"
> > +	"*(u64*)(r10 - 8) =3D r1;"
> > +	/* r9 =3D pointer to stack */
> > +	"r9 =3D r10;"
> > +	"r9 +=3D -8;"
> > +	/* r7 =3D ktime_get_ns() */
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r7 =3D r0;"
> > +	/* r6 =3D ktime_get_ns() */
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r6 =3D r0;"
> > +	/* if r6 > r7 is an unpredictable jump */
> > +	"if r6 > r7 goto l1_%=3D;"
> > +	"r7 =3D r6;"
> > +"l1_%=3D:"
> > +	/* if r6 > 4 exit(0) */
> > +	"if r7 > 4 goto l2_%=3D;"
> > +	/* Access memory at r9[r7] */
> > +	"r9 +=3D r6;"
>=20
> Sorry if I'm missing some context, but there seem to be discrepancies
> between the code of this test, the comments right here, the comment
> above the test and the commit message. r6 vs r7 don't match in a few
> places.
>=20
> The code matches the commit message and looks correct (unsafe). The code
> sample in the comments, however, is different and looks safe to me
> (r7 <=3D r6 <=3D X, accessing r9[r7]).

Yep, thank you for catching this. I need top update comments.
Will wait a couple of hours for other comments and re-send v6 with a fix.

>=20
> > +	"r0 =3D *(u8*)(r9 + 0);"
> > +"l2_%=3D:"
> > +	"r0 =3D 0;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> > +/* Similar to check_ids_in_regsafe.
> > + * The l0 could be reached in two states:
> > + *
> > + *   (1) r6{.id=3DA}, r7{.id=3DA}, r8{.id=3DB}
> > + *   (2) r6{.id=3DB}, r7{.id=3DA}, r8{.id=3DB}
> > + *
> > + * Where (2) is not safe, as "r7 > 4" check won't propagate range for =
it.
> > + * This example would be considered safe without changes to
> > + * mark_chain_precision() to track scalar values with equal IDs.
> > + */
> > +SEC("socket")
> > +__failure __msg("register with unbounded min value")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void check_ids_in_regsafe_2(void)
> > +{
> > +	asm volatile (
> > +	/* Bump allocated stack */
> > +	"r1 =3D 0;"
> > +	"*(u64*)(r10 - 8) =3D r1;"
> > +	/* r9 =3D pointer to stack */
> > +	"r9 =3D r10;"
> > +	"r9 +=3D -8;"
> > +	/* r8 =3D ktime_get_ns() */
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r8 =3D r0;"
> > +	/* r7 =3D ktime_get_ns() */
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r7 =3D r0;"
> > +	/* r6 =3D ktime_get_ns() */
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r6 =3D r0;"
> > +	/* scratch .id from r0 */
> > +	"r0 =3D 0;"
> > +	/* if r6 > r7 is an unpredictable jump */
> > +	"if r6 > r7 goto l1_%=3D;"
> > +	/* tie r6 and r7 .id */
> > +	"r6 =3D r7;"
> > +"l0_%=3D:"
> > +	/* if r7 > 4 exit(0) */
> > +	"if r7 > 4 goto l2_%=3D;"
> > +	/* Access memory at r9[r7] */
> > +	"r9 +=3D r6;"
> > +	"r0 =3D *(u8*)(r9 + 0);"
> > +"l2_%=3D:"
> > +	"r0 =3D 0;"
> > +	"exit;"
> > +"l1_%=3D:"
> > +	/* tie r6 and r8 .id */
> > +	"r6 =3D r8;"
> > +	"goto l0_%=3D;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> > +/* Check that scalar IDs *are not* generated on register to register
> > + * assignments if source register is a constant.
> > + *
> > + * If such IDs *are* generated the 'l1' below would be reached in
> > + * two states:
> > + *
> > + *   (1) r1{.id=3DA}, r2{.id=3DA}
> > + *   (2) r1{.id=3DC}, r2{.id=3DC}
> > + *
> > + * Thus forcing 'if r1 =3D=3D r2' verification twice.
> > + */
> > +SEC("socket")
> > +__success __log_level(2)
> > +__msg("11: (1d) if r3 =3D=3D r4 goto pc+0")
> > +__msg("frame 0: propagating r3,r4")
> > +__msg("11: safe")
> > +__msg("processed 15 insns")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void no_scalar_id_for_const(void)
> > +{
> > +	asm volatile (
> > +	"call %[bpf_ktime_get_ns];"
> > +	/* unpredictable jump */
> > +	"if r0 > 7 goto l0_%=3D;"
> > +	/* possibly generate same scalar ids for r3 and r4 */
> > +	"r1 =3D 0;"
> > +	"r1 =3D r1;"
> > +	"r3 =3D r1;"
> > +	"r4 =3D r1;"
> > +	"goto l1_%=3D;"
> > +"l0_%=3D:"
> > +	/* possibly generate different scalar ids for r3 and r4 */
> > +	"r1 =3D 0;"
> > +	"r2 =3D 0;"
> > +	"r3 =3D r1;"
> > +	"r4 =3D r2;"
> > +"l1_%=3D:"
> > +	/* predictable jump, marks r3 and r4 precise */
> > +	"if r3 =3D=3D r4 goto +0;"
> > +	"r0 =3D 0;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> > +/* Same as no_scalar_id_for_const() but for 32-bit values */
> > +SEC("socket")
> > +__success __log_level(2)
> > +__msg("11: (1e) if w3 =3D=3D w4 goto pc+0")
> > +__msg("frame 0: propagating r3,r4")
> > +__msg("11: safe")
> > +__msg("processed 15 insns")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void no_scalar_id_for_const32(void)
> > +{
> > +	asm volatile (
> > +	"call %[bpf_ktime_get_ns];"
> > +	/* unpredictable jump */
> > +	"if r0 > 7 goto l0_%=3D;"
> > +	/* possibly generate same scalar ids for r3 and r4 */
> > +	"w1 =3D 0;"
> > +	"w1 =3D w1;"
> > +	"w3 =3D w1;"
> > +	"w4 =3D w1;"
> > +	"goto l1_%=3D;"
> > +"l0_%=3D:"
> > +	/* possibly generate different scalar ids for r3 and r4 */
> > +	"w1 =3D 0;"
> > +	"w2 =3D 0;"
> > +	"w3 =3D w1;"
> > +	"w4 =3D w2;"
> > +"l1_%=3D:"
> > +	/* predictable jump, marks r1 and r2 precise */
> > +	"if w3 =3D=3D w4 goto +0;"
> > +	"r0 =3D 0;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> > +/* Check that unique scalar IDs are ignored when new verifier state is
> > + * compared to cached verifier state. For this test:
> > + * - cached state has no id on r1
> > + * - new state has a unique id on r1
> > + */
> > +SEC("socket")
> > +__success __log_level(2)
> > +__msg("6: (25) if r6 > 0x7 goto pc+1")
> > +__msg("7: (57) r1 &=3D 255")
> > +__msg("8: (bf) r2 =3D r10")
> > +__msg("from 6 to 8: safe")
> > +__msg("processed 12 insns")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void ignore_unique_scalar_ids_cur(void)
> > +{
> > +	asm volatile (
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r6 =3D r0;"
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r0 &=3D 0xff;"
> > +	/* r1.id =3D=3D r0.id */
> > +	"r1 =3D r0;"
> > +	/* make r1.id unique */
> > +	"r0 =3D 0;"
> > +	"if r6 > 7 goto l0_%=3D;"
> > +	/* clear r1 id, but keep the range compatible */
> > +	"r1 &=3D 0xff;"
> > +"l0_%=3D:"
> > +	/* get here in two states:
> > +	 * - first: r1 has no id (cached state)
> > +	 * - second: r1 has a unique id (should be considered equivalent)
> > +	 */
> > +	"r2 =3D r10;"
> > +	"r2 +=3D r1;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> > +/* Check that unique scalar IDs are ignored when new verifier state is
> > + * compared to cached verifier state. For this test:
> > + * - cached state has a unique id on r1
> > + * - new state has no id on r1
> > + */
> > +SEC("socket")
> > +__success __log_level(2)
> > +__msg("6: (25) if r6 > 0x7 goto pc+1")
> > +__msg("7: (05) goto pc+1")
> > +__msg("9: (bf) r2 =3D r10")
> > +__msg("9: safe")
> > +__msg("processed 13 insns")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void ignore_unique_scalar_ids_old(void)
> > +{
> > +	asm volatile (
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r6 =3D r0;"
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r0 &=3D 0xff;"
> > +	/* r1.id =3D=3D r0.id */
> > +	"r1 =3D r0;"
> > +	/* make r1.id unique */
> > +	"r0 =3D 0;"
> > +	"if r6 > 7 goto l1_%=3D;"
> > +	"goto l0_%=3D;"
> > +"l1_%=3D:"
> > +	/* clear r1 id, but keep the range compatible */
> > +	"r1 &=3D 0xff;"
> > +"l0_%=3D:"
> > +	/* get here in two states:
> > +	 * - first: r1 has a unique id (cached state)
> > +	 * - second: r1 has no id (should be considered equivalent)
> > +	 */
> > +	"r2 =3D r10;"
> > +	"r2 +=3D r1;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> > +/* Check that two different scalar IDs in a verified state can't be
> > + * mapped to the same scalar ID in current state.
> > + */
> > +SEC("socket")
> > +__success __log_level(2)
> > +/* The exit instruction should be reachable from two states,
> > + * use two matches and "processed .. insns" to ensure this.
> > + */
> > +__msg("13: (95) exit")
> > +__msg("13: (95) exit")
> > +__msg("processed 18 insns")
> > +__flag(BPF_F_TEST_STATE_FREQ)
> > +__naked void two_old_ids_one_cur_id(void)
> > +{
> > +	asm volatile (
> > +	/* Give unique scalar IDs to r{6,7} */
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r0 &=3D 0xff;"
> > +	"r6 =3D r0;"
> > +	"call %[bpf_ktime_get_ns];"
> > +	"r0 &=3D 0xff;"
> > +	"r7 =3D r0;"
> > +	"r0 =3D 0;"
> > +	/* Maybe make r{6,7} IDs identical */
> > +	"if r6 > r7 goto l0_%=3D;"
> > +	"goto l1_%=3D;"
> > +"l0_%=3D:"
> > +	"r6 =3D r7;"
> > +"l1_%=3D:"
> > +	/* Mark r{6,7} precise.
> > +	 * Get here in two states:
> > +	 * - first:  r6{.id=3DA}, r7{.id=3DB} (cached state)
> > +	 * - second: r6{.id=3DA}, r7{.id=3DA}
> > +	 * Currently we don't want to consider such states equivalent.
> > +	 * Thus, marker instruction "r0 =3D r0;" would be verified twice.
> > +	 */
> > +	"r2 =3D r10;"
> > +	"r2 +=3D r6;"
> > +	"r2 +=3D r7;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_ktime_get_ns)
> > +	: __clobber_all);
> > +}
> > +
> >  char _license[] SEC("license") =3D "GPL";
> > --=20
> > 2.40.1
> >=20
> >=20



Return-Path: <bpf+bounces-2039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9214B7270A2
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765351C20B37
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C43B8BA;
	Wed,  7 Jun 2023 21:40:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A083B8A3
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:40:42 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0031BD6
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:40:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so2450695a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174039; x=1688766039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5J2APChEfDX1eiJ8avKmlM6xFprftjkq+sIwSo+7x0=;
        b=Xqq5Zio7mcgfM1SX5aTko3gjGZ2ILloNCeOuww4np+HTmpGGCBu7Ov/kblF+9K99L2
         GMsDqmfmw1x4TXg6Ku+VwINsS/VGOpEfMPA4ibpluNrz3+/x4fntdUQy83pXW2yeUtZ7
         kvl61qVybu3lmkoN1cB94j4CPOYHlnSNYDQ2kvh6ozN0fhw/WYd9FL2yli3ldyRgWr7d
         mX2wPCiBbGfi/xXZlcXCTEar4KrvOaV9DQbU/kPOCCgkK80yQnj+tmZ+jC2MKAtaYkl/
         O7B+GL5Kqa+XPkHTwpBSTx6Hhc671zUFAHBhWbxiMaEyg0plzlddMXTEoH0kH1AtM7/l
         /5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174039; x=1688766039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5J2APChEfDX1eiJ8avKmlM6xFprftjkq+sIwSo+7x0=;
        b=g9mSw5S3sgm+Ceg0eVK8wTQIawv3KRZ+o1qTkejRjwyqtgngoyiKZzyNOB3MztiZtH
         qnv+6Fpph1vp7NVLxA6x9Pre0ipSwmlKXQnTAidovX7hHubAY+kT9n8ey7a+uF2CD16U
         y8eFEcdpxDEzBmuBa/ZvGuoszrNUnOhS2Syex7Azd7zTPxM4S8k3+vQP8yfdEJZAFY2o
         CwQb7vuu8UnqQsiILLPatlFI9ByunNUnxW9LVR03NT8Zg27LPWldXjfVYeJeuKDy588n
         LVtaySzzA27kjuaPvyqNp7EzgSr/rHRmgwe4DP8W0TpUZI2DATxvjpVmuHl2ahYgMbD9
         vX9w==
X-Gm-Message-State: AC+VfDy1TlkhmO7F8Iw4mTdSoqk5IDD1o4n8DBiVSOGHOlwwfqz0dZaA
	Mail5mJUKvUZ2l/+9kbViOx6qHKRGpngy93dFME=
X-Google-Smtp-Source: ACHHUZ528h6yo5JpDSD2wMK8u5qb5+Kk8ftHzvgLDDHdxNSYr5PX8pYTG6375EnSL86o0PG1LSXa3AEzujhc1PT9jQI=
X-Received: by 2002:aa7:d3c3:0:b0:514:93f0:e15a with SMTP id
 o3-20020aa7d3c3000000b0051493f0e15amr5539530edr.16.1686174038810; Wed, 07 Jun
 2023 14:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-3-eddyz87@gmail.com>
In-Reply-To: <20230606222411.1820404-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 14:40:27 -0700
Message-ID: <CAEf4BzbLSe8H+ER6UTMgORH--bXKkn4popUsU2W0hHadSQuv1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: check if
 mark_chain_precision() follows scalar ids
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Check __mark_chain_precision() log to verify that scalars with same
> IDs are marked as precise. Use several scenarios to test that
> precision marks are propagated through:
> - registers of scalar type with the same ID within one state;
> - registers of scalar type with the same ID cross several states;
> - registers of scalar type  with the same ID cross several stack frames;
> - stack slot of scalar type with the same ID;
> - multiple scalar IDs are tracked independently.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 324 ++++++++++++++++++
>  2 files changed, 326 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids=
.c
>

Great set of tests! I asked for yet another one, but this could be
easily a follow up. Looks great.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> +
> +/* Same as precision_same_state_broken_link, but with state /
> + * parent state boundary.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("frame0: regs=3Dr0,r2 stack=3D before 6: (bf) r3 =3D r10")
> +__msg("frame0: regs=3Dr0,r2 stack=3D before 5: (b7) r1 =3D 0")
> +__msg("frame0: parent state regs=3Dr0,r2 stack=3D:")
> +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 4: (05) goto pc+0")
> +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 3: (bf) r2 =3D r0")
> +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
> +__msg("frame0: parent state regs=3Dr0 stack=3D:")
> +__msg("frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_ktime_get_ns")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void precision_cross_state_broken_link(void)
> +{
> +       asm volatile (
> +       /* r0 =3D random number up to 0xff */
> +       "call %[bpf_ktime_get_ns];"
> +       "r0 &=3D 0xff;"
> +       /* tie r0.id =3D=3D r1.id =3D=3D r2.id */
> +       "r1 =3D r0;"
> +       "r2 =3D r0;"
> +       /* force checkpoint, although link between r1 and r{0,2} is
> +        * broken by the next statement current precision tracking
> +        * algorithm can't react to it and propagates mark for r1 to
> +        * the parent state.
> +        */
> +       "goto +0;"
> +       /* break link for r1, this is the only line that differs
> +        * compared to the previous test
> +        */

not really the only line, goto +0 is that different line ;)

> +       "r1 =3D 0;"
> +       /* force r0 to be precise, this immediately marks r1 and r2 as
> +        * precise as well because of shared IDs
> +        */
> +       "r3 =3D r10;"
> +       "r3 +=3D r0;"
> +       "r0 =3D 0;"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* Check that precision marks propagate through scalar IDs.
> + * Use the same scalar ID in multiple stack frames, check that
> + * precision information is propagated up the call stack.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +/* bar frame */
> +__msg("frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10")
> +__msg("frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1")
> +/* foo frame */
> +__msg("frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1")
> +__msg("frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1")
> +__msg("frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1")
> +/* main frame */
> +__msg("frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0")
> +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")

nice test! in this case we discover r6 and r7 during instruction
backtracking. Let's add another variant of this multi-frame test with
a forced checkpoint to make sure that all this works correctly between
child/parent states with multiple active frames?

> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void precision_many_frames(void)
> +{
> +       asm volatile (
> +       /* r0 =3D random number up to 0xff */
> +       "call %[bpf_ktime_get_ns];"
> +       "r0 &=3D 0xff;"
> +       /* tie r0.id =3D=3D r1.id =3D=3D r6.id */
> +       "r1 =3D r0;"
> +       "r6 =3D r0;"
> +       "call precision_many_frames__foo;"
> +       "exit;"
> +       :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +static __naked __noinline __attribute__((used))

nit: bpf_misc.h has __used macro defined, we can use that everywhere

> +void precision_many_frames__foo(void)
> +{
> +       asm volatile (
> +       /* conflate one of the register numbers (r6) with outer frame,
> +        * to verify that those are tracked independently
> +        */
> +       "r6 =3D r1;"
> +       "r7 =3D r1;"
> +       "call precision_many_frames__bar;"
> +       "exit"
> +       ::: __clobber_all);
> +}
> +

[...]


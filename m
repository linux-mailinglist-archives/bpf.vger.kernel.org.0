Return-Path: <bpf+bounces-5197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F587588EA
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0541C20E8F
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11617AC4;
	Tue, 18 Jul 2023 23:10:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285217AA9
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:10:29 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6EE0
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:10:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so58399485e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689721825; x=1692313825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=od2tleXLGu+aCo9as/mqvfJ+C1EVO+WRd1H8Ky0yjBI=;
        b=HYcmI+Ofy4S0rIKXMxzMkh3sqEf625k4yEjVR0gptSZ6XbRJVpuQrtJPznGV7y/y1S
         cAM6j9X03fnBUPFA8hCSc93AeGFaGKwLh10oqNr6neCj2+7cAMVSPIyaIzhWjrlVMjwV
         k/J6l3kQKLC9ABcHX0HUhbD+wOyHELvwNcxRTWtd7jW/T5h4tq74Jmw5qMi9/+5tdSLW
         Cit+1PjLfl4gJCuJc5eOHq6N9/w7ljTPxjMuRHOzrMXp6cf9s6WtOtILXlYOwWPVqr3/
         UilWuz6Clw+kxhrkfiaVKl3Ff+Os+eAU46Rm/B42JOeZSJjgDjiwfTZHCP+FzZ8ziQiR
         TTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721825; x=1692313825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=od2tleXLGu+aCo9as/mqvfJ+C1EVO+WRd1H8Ky0yjBI=;
        b=Je3yeD6KyLnctnmCLz4yIcB5wRoz6mn0yGCpSmIniWTmA+loxSO1MNEjxfXVczkLHj
         nMsOwoIotmjAPCbdRAat6RPPGBp5H1s+uj9xUV/X+1wO2dsomijvORiBQhCozzfu94Fr
         ZOySjkP5HpU2X6ChETZy1sm1y1HKyXSLpi6AYbVm2ure5XR8GhQyY4zT/eEMg/bmBq6D
         MA58CvIYVh3nvChkOslMpQ2EblHC8+FFKDRpPKuYR4tqvQ1Y597TvMZcobq4vZKW1742
         L+ttATohdtHL73GZGqQdg654SCJMSujdOih1k/CBweHBNvpOBZ8ZzImBDU5PUC7zEMMP
         xjkA==
X-Gm-Message-State: ABy/qLY+Fe1Ni9ONkM8nGRUrRvMQ9b1bG5eyi5IDGWosJ2Y/8cJtRsUM
	FfVivi43/14yAmK8VrXsIO0=
X-Google-Smtp-Source: APBJJlHmRxEKiYNoopx/5m8tcQ7ry8Et4VRG+qHlK+09FSjqlQxSR5iqy74UQoymnHnddGwmE0gquA==
X-Received: by 2002:a05:600c:2255:b0:3fa:934c:8360 with SMTP id a21-20020a05600c225500b003fa934c8360mr637899wmm.8.1689721824558;
        Tue, 18 Jul 2023 16:10:24 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a1-20020adffac1000000b003143ac73fd0sm3623165wrs.1.2023.07.18.16.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:10:24 -0700 (PDT)
Message-ID: <ca8894041f7f33e86ecbc4e03925bb4c67401e9f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/15] selftests/bpf: Add unit tests for new
 sdiv/smod insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Wed, 19 Jul 2023 02:10:23 +0300
In-Reply-To: <20230713060831.396527-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060831.396527-1-yhs@fb.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 23:08 -0700, Yonghong Song wrote:
> Add unit tests for sdiv/smod insns.
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_sdiv.c       | 763 ++++++++++++++++++
>  2 files changed, 765 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 885532540bc3..a591d7b673f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -54,6 +54,7 @@
>  #include "verifier_ringbuf.skel.h"
>  #include "verifier_runtime_jit.skel.h"
>  #include "verifier_scalar_ids.skel.h"
> +#include "verifier_sdiv.skel.h"
>  #include "verifier_search_pruning.skel.h"
>  #include "verifier_sock.skel.h"
>  #include "verifier_spill_fill.skel.h"
> @@ -159,6 +160,7 @@ void test_verifier_regalloc(void)             { RUN(v=
erifier_regalloc); }
>  void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
>  void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit=
); }
>  void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids)=
; }
> +void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
>  void test_verifier_search_pruning(void)       { RUN(verifier_search_prun=
ing); }
>  void test_verifier_sock(void)                 { RUN(verifier_sock); }
>  void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill)=
; }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
> new file mode 100644
> index 000000000000..d92098d670ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> @@ -0,0 +1,763 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 1")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv32_non_zero_imm_1(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w0 s/=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 2")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv32_non_zero_imm_2(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 41;					\
> +	w0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 3")
> +__success __success_unpriv __retval(20)
> +__naked void sdiv32_non_zero_imm_3(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 4")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv32_non_zero_imm_4(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w0 s/=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 5")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv32_non_zero_imm_5(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 6")
> +__success __success_unpriv __retval(21)
> +__naked void sdiv32_non_zero_imm_6(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 7")
> +__success __success_unpriv __retval(21)
> +__naked void sdiv32_non_zero_imm_7(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w0 s/=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero imm divisor, check 8")
> +__success __success_unpriv __retval(20)
> +__naked void sdiv32_non_zero_imm_8(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 41;					\
> +	w0 s/=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 1")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv32_non_zero_reg_1(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w1 =3D 2;						\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 2")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv32_non_zero_reg_2(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 41;					\
> +	w1 =3D -2;					\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 3")
> +__success __success_unpriv __retval(20)
> +__naked void sdiv32_non_zero_reg_3(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w1 =3D -2;					\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 4")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv32_non_zero_reg_4(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w1 =3D 2;						\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 5")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv32_non_zero_reg_5(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w1 =3D -2;					\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 6")
> +__success __success_unpriv __retval(21)
> +__naked void sdiv32_non_zero_reg_6(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w1 =3D -2;					\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 7")
> +__success __success_unpriv __retval(21)
> +__naked void sdiv32_non_zero_reg_7(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w1 =3D 2;						\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, non-zero reg divisor, check 8")
> +__success __success_unpriv __retval(20)
> +__naked void sdiv32_non_zero_reg_8(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 41;					\
> +	w1 =3D 2;						\
> +	w0 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero imm divisor, check 1")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv64_non_zero_imm_1(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r0 s/=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero imm divisor, check 2")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv64_non_zero_imm_2(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 41;					\
> +	r0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero imm divisor, check 3")
> +__success __success_unpriv __retval(20)
> +__naked void sdiv64_non_zero_imm_3(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero imm divisor, check 4")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv64_non_zero_imm_4(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r0 s/=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero imm divisor, check 5")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv64_non_zero_imm_5(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero imm divisor, check 6")
> +__success __success_unpriv __retval(21)
> +__naked void sdiv64_non_zero_imm_6(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r0 s/=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero reg divisor, check 1")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv64_non_zero_reg_1(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r1 =3D 2;						\
> +	r0 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero reg divisor, check 2")
> +__success __success_unpriv __retval(-20)
> +__naked void sdiv64_non_zero_reg_2(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 41;					\
> +	r1 =3D -2;					\
> +	r0 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero reg divisor, check 3")
> +__success __success_unpriv __retval(20)
> +__naked void sdiv64_non_zero_reg_3(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r1 =3D -2;					\
> +	r0 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero reg divisor, check 4")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv64_non_zero_reg_4(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r1 =3D 2;						\
> +	r0 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero reg divisor, check 5")
> +__success __success_unpriv __retval(-21)
> +__naked void sdiv64_non_zero_reg_5(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r1 =3D -2;					\
> +	r0 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV64, non-zero reg divisor, check 6")
> +__success __success_unpriv __retval(21)
> +__naked void sdiv64_non_zero_reg_6(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r1 =3D -2;					\
> +	r0 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero imm divisor, check 1")
> +__success __success_unpriv __retval(-1)
> +__naked void smod32_non_zero_imm_1(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w0 s%%=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero imm divisor, check 2")
> +__success __success_unpriv __retval(1)
> +__naked void smod32_non_zero_imm_2(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 41;					\
> +	w0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero imm divisor, check 3")
> +__success __success_unpriv __retval(-1)
> +__naked void smod32_non_zero_imm_3(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero imm divisor, check 4")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_non_zero_imm_4(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w0 s%%=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero imm divisor, check 5")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_non_zero_imm_5(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero imm divisor, check 6")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_non_zero_imm_6(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero reg divisor, check 1")
> +__success __success_unpriv __retval(-1)
> +__naked void smod32_non_zero_reg_1(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w1 =3D 2;						\
> +	w0 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero reg divisor, check 2")
> +__success __success_unpriv __retval(1)
> +__naked void smod32_non_zero_reg_2(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 41;					\
> +	w1 =3D -2;					\
> +	w0 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero reg divisor, check 3")
> +__success __success_unpriv __retval(-1)
> +__naked void smod32_non_zero_reg_3(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -41;					\
> +	w1 =3D -2;					\
> +	w0 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero reg divisor, check 4")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_non_zero_reg_4(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w1 =3D 2;						\
> +	w0 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero reg divisor, check 5")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_non_zero_reg_5(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w1 =3D -2;					\
> +	w0 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, non-zero reg divisor, check 6")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_non_zero_reg_6(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D -42;					\
> +	w1 =3D -2;					\
> +	w0 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 1")
> +__success __success_unpriv __retval(-1)
> +__naked void smod64_non_zero_imm_1(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r0 s%%=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 2")
> +__success __success_unpriv __retval(1)
> +__naked void smod64_non_zero_imm_2(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 41;					\
> +	r0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 3")
> +__success __success_unpriv __retval(-1)
> +__naked void smod64_non_zero_imm_3(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 4")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_imm_4(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r0 s%%=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 5")
> +__success __success_unpriv __retval(-0)
> +__naked void smod64_non_zero_imm_5(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 6")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_imm_6(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r0 s%%=3D -2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 7")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_imm_7(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r0 s%%=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero imm divisor, check 8")
> +__success __success_unpriv __retval(1)
> +__naked void smod64_non_zero_imm_8(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 41;					\
> +	r0 s%%=3D 2;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 1")
> +__success __success_unpriv __retval(-1)
> +__naked void smod64_non_zero_reg_1(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r1 =3D 2;						\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 2")
> +__success __success_unpriv __retval(1)
> +__naked void smod64_non_zero_reg_2(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 41;					\
> +	r1 =3D -2;					\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 3")
> +__success __success_unpriv __retval(-1)
> +__naked void smod64_non_zero_reg_3(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -41;					\
> +	r1 =3D -2;					\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 4")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_reg_4(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r1 =3D 2;						\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 5")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_reg_5(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r1 =3D -2;					\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 6")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_reg_6(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D -42;					\
> +	r1 =3D -2;					\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 7")
> +__success __success_unpriv __retval(0)
> +__naked void smod64_non_zero_reg_7(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r1 =3D 2;						\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, non-zero reg divisor, check 8")
> +__success __success_unpriv __retval(1)
> +__naked void smod64_non_zero_reg_8(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 41;					\
> +	r1 =3D 2;						\
> +	r0 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, zero divisor")
> +__success __success_unpriv __retval(42)
> +__naked void sdiv32_zero_divisor(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w1 =3D 0;						\
> +	w2 =3D -1;					\
> +	w2 s/=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}

Maybe add "w0 =3D w2" in the end to check how division by zero modifies
the DST register?

> +
> +SEC("socket")
> +__description("SDIV64, zero divisor")
> +__success __success_unpriv __retval(42)
> +__naked void sdiv64_zero_divisor(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r1 =3D 0;						\
> +	r2 =3D -1;					\
> +	r2 s/=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, zero divisor")
> +__success __success_unpriv __retval(42)
> +__naked void smod32_zero_divisor(void)
> +{
> +	asm volatile ("					\
> +	w0 =3D 42;					\
> +	w1 =3D 0;						\
> +	w2 =3D -1;					\
> +	w2 s%%=3D w1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD64, zero divisor")
> +__success __success_unpriv __retval(42)
> +__naked void smod64_zero_divisor(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 42;					\
> +	r1 =3D 0;						\
> +	r2 =3D -1;					\
> +	r2 s%%=3D r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";



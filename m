Return-Path: <bpf+bounces-5195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6D7588DE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2241C20E8A
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D517ABA;
	Tue, 18 Jul 2023 23:06:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AB15AC4
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:06:32 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEDB129
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:06:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fc0aecf107so57232885e9.2
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689721587; x=1692313587;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6+RvYDn5ldOKsRZh3G9vzNUYWUzU0QFYbnYmouhTww=;
        b=O19n0URHP0ekAMP6l/fC2yL8PY4YGrtZlicLI0jIKaaM1+Zv7xgYs23w5SFBNHD6t1
         29Q7j8l79G67wUf0I7MPUvLtiiC4r3vne8hSN/6HnH8F8Jw6brngmHpyU9a7IHmO0aHB
         qxFLidQAicCK3tlnPXVChDp8wjVrejOC8UUs+V/JpFrPYVKxXWdZrV1xW9hyGu2o8pIm
         1kOE8EhFPdPh/biE/IfHnSKkH2MajKwcnYU1X7mGQypaE3mO7dS3oNP5xTkwN72nqOdj
         id8YjG5hnWjcAVfJqsgjG/fKJgELl3RQjDoofIvGCrOBMBLeMX93JOG8MwlYIRAKkeI1
         3zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721587; x=1692313587;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6+RvYDn5ldOKsRZh3G9vzNUYWUzU0QFYbnYmouhTww=;
        b=T1abeUHZMn5Z9CF25fb+JV6EaxROqS+PVWW5mhygQiFFFF7AWTIoV2F95YqToFsyxm
         WBakIwJ27HC3loM1ZBPg2Ts+gfYyOVIWMhm19z8S5apUT9/YOmmH0+kjSRdVTcxD39VJ
         UArIPFYHtlzUYFKOc42SSSitLfmCHQf08+kpRs2X7tKUMWTwoRV1HBKjkYQTsGZ35wy0
         N/qd3gAMVmEP53xO02P0FXkBz2/WCG0nkJJVbJn9DoGFdFvBewJxJkmZ/TS4n4alEzZR
         85lQ5YtnWraKEkBDOqpPHL7x4I4pytt1CwXicQauuq/ooL6lAUgtEtR6YiVtpSDwDMQM
         zcWg==
X-Gm-Message-State: ABy/qLbmQPZO9IzpW9fofuukzS54t7pK9iCu9i1XURcGlqOya+VANfG3
	H7AIxz0vnwIifQ2BhZHh1rQ=
X-Google-Smtp-Source: APBJJlFLRuy2asGEaw8ZpQI+noaM+aFvaSp2wSGF8QgHcXwuEKxSSIHpw2sYF9M0SSmmogL0YW9zaw==
X-Received: by 2002:a05:600c:21c2:b0:3fc:5821:3244 with SMTP id x2-20020a05600c21c200b003fc58213244mr2896783wmj.1.1689721586875;
        Tue, 18 Jul 2023 16:06:26 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b003140f47224csm3570759wrq.15.2023.07.18.16.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:06:26 -0700 (PDT)
Message-ID: <3b14f5d209973469ebcbffcfb84654715c19f4f4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/15] selftests/bpf: Add unit tests for new
 sign-extension load insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Wed, 19 Jul 2023 02:06:25 +0300
In-Reply-To: <20230713060805.393133-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060805.393133-1-yhs@fb.com>
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
> Add unit tests for new ldsx insns. The test includes sign-extension
> with a single value or with a value range.
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_ldsx.c       | 115 ++++++++++++++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index c375e59ff28d..6eec6a9463c8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -31,6 +31,7 @@
>  #include "verifier_int_ptr.skel.h"
>  #include "verifier_jeq_infer_not_null.skel.h"
>  #include "verifier_ld_ind.skel.h"
> +#include "verifier_ldsx.skel.h"
>  #include "verifier_leak_ptr.skel.h"
>  #include "verifier_loops1.skel.h"
>  #include "verifier_lwt.skel.h"
> @@ -133,6 +134,7 @@ void test_verifier_helper_value_access(void)  { RUN(v=
erifier_helper_value_access
>  void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
>  void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
>  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
> +void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
>  void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); =
}
>  void test_verifier_loops1(void)               { RUN(verifier_loops1); }
>  void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
> new file mode 100644
> index 000000000000..cd90913583b9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("socket")
> +__description("LDSX, S8")
> +__success __success_unpriv __retval(-2)
> +__naked void ldsx_s8(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D 0x3fe;					\
> +	*(u64 *)(r10 - 8) =3D r1;				\
> +	r0 =3D *(s8 *)(r10 - 8);				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("LDSX, S16")
> +__success __success_unpriv __retval(-2)
> +__naked void ldsx_s16(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D 0x3fffe;					\
> +	*(u64 *)(r10 - 8) =3D r1;				\
> +	r0 =3D *(s16 *)(r10 - 8);				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("LDSX, S32")
> +__success __success_unpriv __retval(-2)
> +__naked void ldsx_s32(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D 0xfffffffe;				\
> +	*(u64 *)(r10 - 8) =3D r1;				\
> +	r0 =3D *(s32 *)(r10 - 8);				\
> +	exit;						\
> +"	::: __clobber_all);
> +}

Note that __retval is a 32-bit value, so if I change
  r0 =3D *(s32 *)(r10 - 8); to
  r0 =3D *(u32 *)(r10 - 8);
         ^
__retval would be the same, probably better to add
some shift right as a last instruction or something
like that.
(Also applies to a similar test in the movsx tests).

> +
> +SEC("socket")
> +__description("LDSX, S8 range checking")
> +__success __success_unpriv __retval(1)
> +__naked void ldsx_s8_range(void)

Maybe add __log_level(2) and a few
__msg("... R1_w=3Dscalar(smin=3D-128,smax=3D127)") ?
So that verifier range logic is checked as well.

> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	*(u64 *)(r10 - 8) =3D r0;				\
> +	r1 =3D *(s8 *)(r10 - 8);				\
> +	/* r1 with s8 range */				\
> +	if r1 s> 0x7f goto l0_%=3D;			\
> +	if r1 s< -0x80 goto l0_%=3D;			\
> +	r0 =3D 1;						\
> +l1_%=3D:							\
> +	exit;						\
> +l0_%=3D:							\
> +	r0 =3D 2;						\
> +	goto l1_%=3D;					\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("LDSX, S16 range checking")
> +__success __success_unpriv __retval(1)
> +__naked void ldsx_s16_range(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	*(u64 *)(r10 - 8) =3D r0;				\
> +	r1 =3D *(s16 *)(r10 - 8);				\
> +	/* r1 with s16 range */				\
> +	if r1 s> 0x7fff goto l0_%=3D;			\
> +	if r1 s< -0x8000 goto l0_%=3D;			\
> +	r0 =3D 1;						\
> +l1_%=3D:							\
> +	exit;						\
> +l0_%=3D:							\
> +	r0 =3D 2;						\
> +	goto l1_%=3D;					\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("LDSX, S32 range checking")
> +__success __success_unpriv __retval(1)
> +__naked void ldsx_s32_range(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	*(u64 *)(r10 - 8) =3D r0;				\
> +	r1 =3D *(s32 *)(r10 - 8);				\
> +	/* r1 with s16 range */				\
> +	if r1 s> 0x7fffFFFF goto l0_%=3D;			\
> +	if r1 s< -0x80000000 goto l0_%=3D;		\
> +	r0 =3D 1;						\
> +l1_%=3D:							\
> +	exit;						\
> +l0_%=3D:							\
> +	r0 =3D 2;						\
> +	goto l1_%=3D;					\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";



Return-Path: <bpf+bounces-78175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D982D009D1
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F03302AFEC
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E48233711;
	Thu,  8 Jan 2026 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko202Zd1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FD157A5A
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838294; cv=none; b=f5Bmmb/F1fMNplX+RIHj/q4LPhaKm0zlCGn/AQaP2+lQr/NMI/ATvyDhN9Lqz83MOJL6wVezMNm/9Ebk8zNQmojb+WEjKSCTkRRa2NaazCPf2a4B9kGZxGZNSZfURkC6/R5prrNohGsj2JFhKZKmNCYHKj56/blb4w4nX4JMxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838294; c=relaxed/simple;
	bh=cVftGJ2LYMFqOac9oezkJjImltv09C8Dcl60pbTDQCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvQdgGjaCzNcYYxT0DQ5aKmdJlYwCXyrINuACffOGyKEJ2aSrFAEL0fnBv3BoG1uGu7D0ddZl2+/DZ3Oqne6BUp64M6qlXAsRKxJNsF6wxXJm9H5WHEQSARNSzKVu+DEokttY/U3S/1aaZXDSmID2ygmKqhlnu6dy91Ybx4XX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko202Zd1; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae38f81be1so2422820eec.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767838291; x=1768443091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfjdDeHpDq05/eRfWHcvgl+Rhr5y5MvHRF1sn4N97oM=;
        b=ko202Zd1JWMH9CMkq1EjZMJy6LlntHn039mgMY4Zz2YfMicDRIWHaJNwjqchcGV2h8
         ShfdSgzC5uDt9HmMxQ4HXhE4tV+td/3wGV80C2TZz6+b9Mt9vCiV80A/hhgJCSld0WNT
         reV9d10esnlUXnE9bb23gdie+V/GUesOYOHpVYReere2FB9wcVn5yxtfWX0tQKnjhLfm
         rbm3GJggNvGmKSaLuJv+wNR03OrRJrO8zNiim/ENjbn+Yh5Lrf59BizKXT/2nw5R3AbT
         i+cQKwO1fjGtbNos8DrWF1Z9PbBh8dGgtNdG/SIcGQYwQgQ9xE/0HsrP4Zo2KV51eDqX
         XH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767838291; x=1768443091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfjdDeHpDq05/eRfWHcvgl+Rhr5y5MvHRF1sn4N97oM=;
        b=q2fIlkmD+3cLrFjIAfxIho8rSKr+jryw+pPRkJ4kfTMEGBnw0sEhXGndMeRykA53M8
         zEOaWIAJQ0H3dUr0IrzByOKVH3T1BfVcMcVja/6qWJz7RWzopocnx4vqhaNXYzfh93EI
         cCMWD9krrxFWH3fSwdEI3x+vq9gsOnxQn7Un/ZPbYuc3ADXgBtZM+VT2MvnVLzQH2Z+F
         LZEHva6KzLMbgKbRfh+Z0yEZnWzwQB67t3tJSfGfakpE2PwACkg0R2Jvk7Sj44pLBBjc
         HWRlrCwOKD/2dRo2sC5s1g5rPEeBo7nnTKmZh9wscnXmOtIczGSFPr6hzrJMRstqj26t
         SJZg==
X-Forwarded-Encrypted: i=1; AJvYcCWGxmM+zyJSvT4mUxGypiPQ4+AFCcRT2OH59GiersDnp6B3L9GoMvWseYPRbN/mMjBlrwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BpG6V7cygUj5Ih80KbmAOh4g9U+Z3bv4oi0SPWE7O7ZFQLOI
	W2t8RV6RvlZDoHSzOf+MhrBdldR08X8+wrRK+qKHCLjIVWRfevxsfw9h
X-Gm-Gg: AY/fxX6nKlP2Nt0sKT2SwUstEFD7fAVeS/wLDEdy/VbIz3/WHtePrFzMpp+6/10JkIW
	l1kNAjpkXfyR/DFFEIs2jNUFF5a/5uiRtZ+vwXNRmaN1czgyokeKsu97DoQL8NZWvEUUTb6j1qZ
	WntNMqq3dFTjaA5CkC1awYnTWZ7dsaO0P343uBLSlYhm5HKTqc4Pv4F+LUcbxuH3WDeXmTmSBYo
	tQ9/mmph9ZjrBulbM7kPa1GxN1F1OnZBNxoPXMVHk9m0HvrMS87ldzyD+Tc/JxgDqtfn30228u0
	0HCsVxrOyvR5Aat6k2eRuRGZPFXVCBKcAphD1ghhsn9iLwf79TtpZljEAKph4SqDIPyfhOm50Fo
	9AG/kAmfuTGU9690Z5PFJXESY5S5MSAerz4GVvsmy5Z6leWXW44DZxhhV6CZIi2csfDyee3P2zg
	XDS/VLeXEWiJzq4mv6xD5a6PJEOBBLNZ4NPM10
X-Google-Smtp-Source: AGHT+IEr4Is3D6/1yk6IhtXWFD9soqpY6qaGGTgwnoRzkqh+zl6kb1AUs6+MEROHzDjSkxibFuVeuA==
X-Received: by 2002:a05:7300:6916:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b17d2c9a9bmr5108278eec.36.1767838291315;
        Wed, 07 Jan 2026 18:11:31 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6741:9f57:1ccc:45f2? ([2620:10d:c090:500::2:4706])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17067327csm7730332eec.7.2026.01.07.18.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:11:30 -0800 (PST)
Message-ID: <18201538f7dd8166dc0171b0970f15d4ab638f51.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tests for linked
 register tracking with negative offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 07 Jan 2026 18:11:29 -0800
In-Reply-To: <20260107203941.1063754-3-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
	 <20260107203941.1063754-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> Add tests for linked register tracking with negative offsets and BPF_SUB:
>=20
> Success cases (64-bit ALU, tracking works):
> - scalars_neg: r1 +=3D -4 with signed comparison
> - scalars_neg_sub: r1 -=3D 4 with signed comparison
> - scalars_pos: r1 +=3D 4 with unsigned comparison
> - scalars_sub_neg_imm: r1 -=3D -4 (equivalent to r1 +=3D 4)
>=20
> Failure cases (tracking disabled, documents limitations):
> - scalars_neg_alu32_add: 32-bit ADD not tracked
> - scalars_neg_alu32_sub: 32-bit SUB not tracked
> - scalars_double_add: Double ADD clears ID
>=20
> Large delta tests (verifies 64-bit arithmetic in sync_linked_regs):
> - scalars_sync_delta_overflow: S32_MIN offset
> - scalars_sync_delta_overflow_large_range: S32_MAX offset
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  .../bpf/progs/verifier_linked_scalars.c       | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index 8f755d2464cf..2e1ef0f96717 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> @@ -31,4 +31,217 @@ l1:						\
>  "	::: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("scalars: linked scalars with negative offset")

Nit: I think that __description tag should be avoided in the new code.
     w/o this tag the test case could be executed as follows:

       ./test_progs -t verifier_linked_scalars/scalars_reg

     with this tag the test case should be executed as:

       ./test_progs -t "verifier_linked_scalars/scalars: linked scalars wit=
h negative offset"

     and I'm not sure test_progs handles spaces properly (even if it does, =
the invocation is inconvenient).
     So, I'd just put the description in the comments.

> +__success
> +__naked void scalars_neg(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r1 +=3D -4;					\
> +	if r1 s< 0 goto l2;				\
                        ^^
	This is a file-global label.
	It's better to use `goto 1f ...; 1: <code>` in such cases,
	or a special `%=3D` substitution. There are multiple examples
	for both in the test cases. See [1] and [2].

[1] https://sourceware.org/binutils/docs-2.36/as.html#Symbol-Names (local l=
abels)
[2] https://gcc.gnu.org/onlinedocs/gcc-14.1.0/gcc/Extended-Asm.html#Special=
-format-strings

> +	if r0 !=3D 0 goto l2;				\
> +	r0 /=3D 0;					\
> +l2:							\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* Same test but using BPF_SUB instead of BPF_ADD with negative immediat=
e */
> +SEC("socket")
> +__description("scalars: linked scalars with SUB")
> +__success
> +__naked void scalars_neg_sub(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r1 -=3D 4;					\
> +	if r1 s< 0 goto l2_sub;				\
> +	if r0 !=3D 0 goto l2_sub;				\
> +	r0 /=3D 0;					\
> +l2_sub:							\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* 32-bit ALU: linked scalar tracking not supported, ID cleared */
> +SEC("socket")
> +__description("scalars: linked scalars 32-bit ADD not tracked")
> +__failure
> +__msg("div by zero")
> +__naked void scalars_neg_alu32_add(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	w0 &=3D 0xff;					\
> +	w1 =3D w0;					\
> +	w1 +=3D -4;					\
> +	if w1 s< 0 goto l2_alu32_add;			\
> +	if w0 !=3D 0 goto l2_alu32_add;			\
> +	r0 /=3D 0;					\
> +l2_alu32_add:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* 32-bit ALU: linked scalar tracking not supported, ID cleared */
> +SEC("socket")
> +__description("scalars: linked scalars 32-bit SUB not tracked")
> +__failure
> +__msg("div by zero")
> +__naked void scalars_neg_alu32_sub(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	w0 &=3D 0xff;					\
> +	w1 =3D w0;					\
> +	w1 -=3D 4;					\
> +	if w1 s< 0 goto l2_alu32_sub;			\
> +	if w0 !=3D 0 goto l2_alu32_sub;			\
> +	r0 /=3D 0;					\
> +l2_alu32_sub:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* Positive offset: r1 =3D r0 + 4, then if r1 >=3D 6, r0 >=3D 2, so r0 !=
=3D 0 */
> +SEC("socket")
> +__description("scalars: linked scalars positive offset")
> +__success
> +__naked void scalars_pos(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r1 +=3D 4;					\
> +	if r1 < 6 goto l2_pos;				\
> +	if r0 !=3D 0 goto l2_pos;				\
> +	r0 /=3D 0;					\
> +l2_pos:							\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* SUB with negative immediate: r1 -=3D -4 is equivalent to r1 +=3D 4 */
> +SEC("socket")
> +__description("scalars: linked scalars SUB negative immediate")
> +__success
> +__naked void scalars_sub_neg_imm(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r1 -=3D -4;					\
> +	if r1 < 6 goto l2_sub_neg;			\
> +	if r0 !=3D 0 goto l2_sub_neg;			\
> +	r0 /=3D 0;					\
> +l2_sub_neg:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* Double ADD clears the ID (can't accumulate offsets) */
> +SEC("socket")
> +__description("scalars: linked scalars double ADD clears ID")
> +__failure
> +__msg("div by zero")
> +__naked void scalars_double_add(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r1 +=3D 2;					\
> +	r1 +=3D 2;					\
> +	if r1 < 6 goto l2_double;			\
> +	if r0 !=3D 0 goto l2_double;			\
> +	r0 /=3D 0;					\
> +l2_double:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/*
> + * Test that sync_linked_regs() correctly handles large offset differenc=
es.
> + * r1.off =3D S32_MIN, r2.off =3D 1, delta =3D S32_MIN - 1 requires 64-b=
it math.
> + */
> +SEC("socket")
> +__description("scalars: linked regs sync with large delta (S32_MIN offse=
t)")
> +__success
> +__naked void scalars_sync_delta_overflow(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r2 =3D r0;					\
> +	r1 +=3D %[s32_min];				\
> +	r2 +=3D 1;					\
> +	if r2 s< 100 goto l2_overflow;			\
> +	if r1 s< 0 goto l2_overflow;			\
> +	r0 /=3D 0;					\
> +l2_overflow:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32),
> +	  [s32_min]"i"((int)(-2147483647 - 1))
                             ^^^^^^^^^^^
                        Nit: use INT_MIN?

> +	: __clobber_all);
> +}
> +
> +/*
> + * Another large delta case: r1.off =3D S32_MAX, r2.off =3D -1.
> + * delta =3D S32_MAX - (-1) =3D S32_MAX + 1 requires 64-bit math.
> + */
> +SEC("socket")
> +__description("scalars: linked regs sync with large delta (S32_MAX offse=
t)")
> +__success
> +__naked void scalars_sync_delta_overflow_large_range(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r2 =3D r0;					\
> +	r1 +=3D %[s32_max];				\
> +	r2 +=3D -1;					\
> +	if r2 s< 0 goto l2_large;			\
> +	if r1 s>=3D 0 goto l2_large;			\
> +	r0 /=3D 0;					\
> +l2_large:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32),
> +	  [s32_max]"i"((int)2147483647)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";


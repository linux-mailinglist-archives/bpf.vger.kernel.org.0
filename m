Return-Path: <bpf+bounces-72979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C0C1ECEA
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 08:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA793B3FF6
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32B337B81;
	Thu, 30 Oct 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbP9zV3k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAC19E99F
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809977; cv=none; b=VQZHaZs2wZsBb0wqO7pAxV/hmNp1vG03O7QRKXCWDU4Baen+1a2Q0tx9dkmJO0VJhCcqWjR4mfdt+/pwxIjExdrivUT/1fqjMQBtH4YDXXnI/aNYm4thJaYUGfKHqNlXCo5qZo0CNQHr4HWqdWREYydhaQOqESGZcBeXhDsjBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809977; c=relaxed/simple;
	bh=+l64EXpdFt1DrfN3+np4ABRcfKMULySFciF7f1OYXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQKFUfqu5FpHmTCZ1tYa/wuNxZzGUcSm/nFOWBj5E3G12uUiTEFZLodM4i1kCAwP5lapH2uj11OEk0VrsnC4AbXDhfnuemGw54g2wxxuqKMJpH6VB65ztvojCYFRZwfOp1hmrmPu+0VWLhCeYExudnvOvV78PhKEIZ7Y12PrRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbP9zV3k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso9256715e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761809974; x=1762414774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DiIIo0gUBLHLzAog1tLX9NVA6kGTazFh+oexNCeDwUg=;
        b=VbP9zV3kn7JsixTAmPmkBp3ZwPblpshHfC0KRdAgBkm2qQ9ueouGjbtjo6vLM5d3en
         AyCNO6CVJPKAZpQXn/sUKP3oj2Im2vU3ZeChduse/NyrfilqJLniJM/wA/rOXZRxzEKO
         +ECw0efvQ/iquAOGcWj8iZD8udY+1aShdkX8bePacNhu6enfoeeGiEKKby5zrQFhF45K
         OOy7Ork3C/v5VZBvkg0F2zB3ijOqx/cQb6qAnPZMtWAmX0FFqRxYWY2aCRE4QemaN3+F
         Sa/LuedQ2NA49EA3LOYf7XRwhJuIh51T1it9AaUnE5sBArPsI5HGP50JCkAmdqSCZd+o
         29IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809974; x=1762414774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiIIo0gUBLHLzAog1tLX9NVA6kGTazFh+oexNCeDwUg=;
        b=gZT/GkAlGVsOD4jgdvvwoSO0ZDCEtMHaceomxhf1EGehL45H4z7bdJPNdC/HDjaAZI
         20PhO8THzqWzY/z1VQK0SCh509ntOilgrpukxwcCBstMou+4FHI7lXXLLCvxH2lWVOVN
         rKgBXYSbfUDuTfGnTRSsIIVu1ArnGCiJc/aFa/GY+GfiXjJmHwPqkVfIqAgiKmaVIQ9G
         cleB0KX6gu1VyRkblZbyaqg5cVm0z6hOfJWyCqvWaKAzHu0tactwewX7scdL7UZbpvXd
         0zP838MCeTiCO9CS4vr3KX4O7V8NW3prlLieAr+WYigXD1uA/1jTUg9dRPqdOShZv+m/
         n1rg==
X-Gm-Message-State: AOJu0Ywxx2Hhzl+VRbVarq26mQKHkuI/cdulA+BQPEOcYxZeEu3USSoN
	pL82FBoV88g8NFv+2s4bl7pabY9C79pdMDVO21/155j0Qp9o6GvQ8snN
X-Gm-Gg: ASbGncv+hi4XuDqZxOWlbi7lafQXiFqQr2P8pj/DD/fOgFZCM0UfZfPihMVw4nfI82y
	KG2ieM7iKJQRr9awHcqxCLQrFqXZK95x09SrBjkLJ/3Fco8Np2KA1Wcl64QIVM6SFoymdXKUIzz
	CN8lX87J7DnW1eHTey4Jeb9oqBCoQM4vUkNB2bBdC03gPcZpojPfYoy5tJOI+SG0fHJOLu5vKsS
	064ePnjZIRsI0muvofdbGXFt+8wkgev3O9FPdg5wQbZ3gA2SUUoXdK/unYr+mCVz8LFC8SohlAd
	av9qqiFPkruHR3xMWtmi3gtQLQGVbnAc71jvFNpyhq7P5gzu3X17e8cfX8DtlR3+mPGnxJG1Qp5
	HglkqG6lRCg3918Ni19xxKzBNbgcgDSx9oKZikrVy4Pb9aoOf6sxDDg2ReDoCeQpaskX9r+Degl
	gGx2G6W+LheQ==
X-Google-Smtp-Source: AGHT+IEzE5AaUxjdDEFmGc09t9tGxiQyOLU4OFeseZ47qdXXE0m984AH1bZo51CNWsDPz7OkONnDLg==
X-Received: by 2002:a05:600c:6218:b0:475:dd53:6c06 with SMTP id 5b1f17b1804b1-4771e20a66cmr50165095e9.40.1761809973426;
        Thu, 30 Oct 2025 00:39:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771844127fsm63669135e9.2.2025.10.30.00.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:39:32 -0700 (PDT)
Date: Thu, 30 Oct 2025 07:46:03 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v8 bpf-next 11/11] selftests/bpf: add C-level selftests
 for indirect jumps
Message-ID: <aQMXuySPuw1r7emc@mail.gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
 <20251028142049.1324520-12-a.s.protopopov@gmail.com>
 <aa216ba69c31ae6cb253813379e3065ae5a850d6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa216ba69c31ae6cb253813379e3065ae5a850d6.camel@gmail.com>

On 25/10/29 02:49PM, Eduard Zingerman wrote:
> On Tue, 2025-10-28 at 14:20 +0000, Anton Protopopov wrote:
> > Add C-level selftests for indirect jumps to validate LLVM and libbpf
> > functionality. The tests are intentionally disabled, to be run
> > locally by developers, but will not make the CI red.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Yonghong added __BPF_FEATURE_GOTOX macro to llvm yesterday.
> I think it should be used instead of '#if 0' things.
> E.g. as in the attached diff (does not handle one-map-two-jumps and
> one-jump-two-maps).

Thanks! I will use some form of your patch. Somehow, having a flu
while sending the last versions prevented my brain from figuring
this out myself :(

> Still think that amount of tests added is a bit excessive,
> but defer to you and Yonghong to decide.

I would keep them, this file is more about testing llvm->libbpf.
(Though, I think, I need to convert most of them into `goto
*table[i]` form, and only leave a few big switches which
are guaranteed to be transformed to an indirect jump by LLVM.)

> Confirm that tests are passing when compiled with llvm
> commit b2fe5d1482eb ("[SimplifyCFG] Hoist common code when succ is unreachable block (#165570)").
> 
> [...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> index bb0ebd16df43..252fb9019d70 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> @@ -15,7 +15,6 @@
>  
>  #include "bpf_gotox.skel.h"
>  
> -#if 0
>  static void __test_run(struct bpf_program *prog, void *ctx_in, size_t ctx_size_in)
>  {
>  	LIBBPF_OPTS(bpf_test_run_opts, topts,
> @@ -29,6 +28,16 @@ static void __test_run(struct bpf_program *prog, void *ctx_in, size_t ctx_size_i
>  	ASSERT_OK(err, "test_run_opts err");
>  }
>  
> +static bool skip(struct bpf_gotox *skel)
> +{
> +	if (skel->bss->skip) {
> +		test__skip();
> +		skel->bss->skip = 0;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void check_simple(struct bpf_gotox *skel,
>  			 struct bpf_program *prog,
>  			 __u64 ctx_in,
> @@ -37,6 +46,8 @@ static void check_simple(struct bpf_gotox *skel,
>  	skel->bss->ret_user = 0;
>  
>  	__test_run(prog, &ctx_in, sizeof(ctx_in));
> +	if (skip(skel))
> +		return;
>  
>  	if (!ASSERT_EQ(skel->bss->ret_user, expected, "skel->bss->ret_user"))
>  		return;
> @@ -53,6 +64,8 @@ static void check_simple_fentry(struct bpf_gotox *skel,
>  	/* trigger */
>  	usleep(1);
>  
> +	if (skip(skel))
> +		return;
>  	if (!ASSERT_EQ(skel->bss->ret_user, expected, "skel->bss->ret_user"))
>  		return;
>  }
> @@ -215,7 +228,7 @@ static void check_nonstatic_global_other_sec(struct bpf_gotox *skel)
>  		check_simple_fentry(skel, skel->progs.use_nonstatic_global_other_sec, in[i], out[i]);
>  }
>  
> -static void __test_bpf_gotox(void)
> +void test_bpf_gotox(void)
>  {
>  	struct bpf_gotox *skel;
>  	int ret;
> @@ -263,14 +276,3 @@ static void __test_bpf_gotox(void)
>  
>  	bpf_gotox__destroy(skel);
>  }
> -#else
> -static void __test_bpf_gotox(void)
> -{
> -	test__skip();
> -}
> -#endif
> -
> -void test_bpf_gotox(void)
> -{
> -	__test_bpf_gotox();
> -}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> index 16ad6cf279c0..2f704f260874 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> @@ -6,9 +6,9 @@
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
>  
> -#if 0
>  __u64 in_user;
>  __u64 ret_user;
> +__u64 skip;
>  
>  struct simple_ctx {
>  	__u64 x;
> @@ -21,14 +21,17 @@ __u64 some_var;
>   * number of instructions by the verifier. This adds additional
>   * stress on testing the insn_array maps corresponding to indirect jumps.
>   */
> +#ifdef __BPF_FEATURE_GOTOX
>  static __always_inline void adjust_insns(__u64 x)
>  {
>  	some_var ^= x + bpf_jiffies64();
>  }
> +#endif
>  
>  SEC("syscall")
>  int one_switch(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	switch (ctx->x) {
>  	case 0:
>  		adjust_insns(ctx->x + 1);
> @@ -55,13 +58,16 @@ int one_switch(struct simple_ctx *ctx)
>  		ret_user = 19;
>  		break;
>  	}
> -
> +#else
> +	skip = 1;
> +#endif
>  	return 0;
>  }
>  
>  SEC("syscall")
>  int one_switch_non_zero_sec_off(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	switch (ctx->x) {
>  	case 0:
>  		adjust_insns(ctx->x + 1);
> @@ -90,11 +96,16 @@ int one_switch_non_zero_sec_off(struct simple_ctx *ctx)
>  	}
>  
>  	return 0;
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int simple_test_other_sec(struct pt_regs *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	__u64 x = in_user;
>  
>  	switch (x) {
> @@ -125,11 +136,16 @@ int simple_test_other_sec(struct pt_regs *ctx)
>  	}
>  
>  	return 0;
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("syscall")
>  int two_switches(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	switch (ctx->x) {
>  	case 0:
>  		adjust_insns(ctx->x + 1);
> @@ -185,11 +201,16 @@ int two_switches(struct simple_ctx *ctx)
>  	}
>  
>  	return 0;
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("syscall")
>  int big_jump_table(struct simple_ctx *ctx __attribute__((unused)))
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	const void *const jt[256] = {
>  		[0 ... 255] = &&default_label,
>  		[0] = &&l0,
> @@ -223,12 +244,16 @@ int big_jump_table(struct simple_ctx *ctx __attribute__((unused)))
>  default_label:
>  	adjust_insns(ctx->x + 177);
>  	ret_user = 19;
> +#else
> +	skip = 1;
> +#endif
>  	return 0;
>  }
>  
>  SEC("syscall")
>  int one_jump_two_maps(struct simple_ctx *ctx __attribute__((unused)))
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	__label__ l1, l2, l3, l4;
>  	void *jt1[2] = { &&l1, &&l2 };
>  	void *jt2[2] = { &&l3, &&l4 };
> @@ -251,11 +276,16 @@ int one_jump_two_maps(struct simple_ctx *ctx __attribute__((unused)))
>  
>  	ret_user = ret;
>  	return ret;
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("syscall")
>  int one_map_two_jumps(struct simple_ctx *ctx __attribute__((unused)))
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	__label__ l1, l2, l3;
>  	void *jt[3] = { &&l1, &&l2, &&l3 };
>  	unsigned int a = (ctx->x >> 2) & 1;
> @@ -274,9 +304,14 @@ int one_map_two_jumps(struct simple_ctx *ctx __attribute__((unused)))
>  
>  	ret_user = ret;
>  	return ret;
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  /* Just to introduce some non-zero offsets in .text */
> +#ifdef __BPF_FEATURE_GOTOX
>  static __noinline int f0(volatile struct simple_ctx *ctx __arg_ctx)
>  {
>  	if (ctx)
> @@ -284,13 +319,20 @@ static __noinline int f0(volatile struct simple_ctx *ctx __arg_ctx)
>  	else
>  		return 13;
>  }
> +#endif
>  
>  SEC("syscall") int f1(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	ret_user = 0;
>  	return f0(ctx);
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
> +#ifdef __BPF_FEATURE_GOTOX
>  static __noinline int __static_global(__u64 x)
>  {
>  	switch (x) {
> @@ -322,30 +364,47 @@ static __noinline int __static_global(__u64 x)
>  
>  	return 0;
>  }
> +#endif
>  
>  SEC("syscall")
>  int use_static_global1(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	ret_user = 0;
>  	return __static_global(ctx->x);
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("syscall")
>  int use_static_global2(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	ret_user = 0;
>  	adjust_insns(ctx->x + 1);
>  	return __static_global(ctx->x);
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int use_static_global_other_sec(void *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	return __static_global(in_user);
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  __noinline int __nonstatic_global(__u64 x)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	switch (x) {
>  	case 0:
>  		adjust_insns(x + 1);
> @@ -374,28 +433,46 @@ __noinline int __nonstatic_global(__u64 x)
>  	}
>  
>  	return 0;
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("syscall")
>  int use_nonstatic_global1(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	ret_user = 0;
>  	return __nonstatic_global(ctx->x);
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("syscall")
>  int use_nonstatic_global2(struct simple_ctx *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	ret_user = 0;
>  	adjust_insns(ctx->x + 1);
>  	return __nonstatic_global(ctx->x);
> +#else
> +	skip = 1;
> +	return 0;
> +#endif
>  }
>  
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int use_nonstatic_global_other_sec(void *ctx)
>  {
> +#ifdef __BPF_FEATURE_GOTOX
>  	return __nonstatic_global(in_user);
> -}
> +#else
> +	skip = 1;
> +	return 0;
>  #endif
> +}
>  
>  char _license[] SEC("license") = "GPL";



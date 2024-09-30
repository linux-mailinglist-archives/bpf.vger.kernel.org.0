Return-Path: <bpf+bounces-40578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC698A58F
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B31F1F23856
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423D15C15E;
	Mon, 30 Sep 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VITAVuQz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AE18FC67
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703615; cv=none; b=NBT8hF0y1LRmq1rBS/5hshCa3mUFpHXZbzmpGwwehPkKOGYppUYTiagEHIAbNG07sGp1atdH5RUrKaVyG2cdxA49B25h6wV7HpflB7wToVal1M+iHOsV1DJdEMQeDsTnVJ/BQsmCPV7nBsemUS9FUo+TAbPSO7iuRSCkGUtmyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703615; c=relaxed/simple;
	bh=7b9Osya+1rnFcviabfJ0NNvrsKrfq/7kPgysfrkbRoo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8vlzsurR5UhQM288f/rjt1U2c5G0mJIWBv6KczGw2GOT9OE+I/us28PCaxhnR48WriCjjZSyWa9Rplh1/TCHrQQ8FsodaBgucNdOC/b/sq9tZ+Ta4cTHLkHXOtp/tfjML7njHI0OyQNYAkOL2kjtq3i+FnuZXAvVIkTaDz+pUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VITAVuQz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cc810ce73so2535231f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727703611; x=1728308411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euFlGHOABtbw1QPloGs+fLVR06Q0Ayuhb57UM3GCWKk=;
        b=VITAVuQzsqY55CQBmFfbKBBCZ51C8A/RHkv6QSJRiIZsf3vo4B20cOby89Z+Pahhlk
         Z6Pd36z63G5fsMDv5UwRDeNSYjyNNa2yfct8EqT3RoEVjL+6q888Sl5XR1sWBW/S5u1e
         Zqm+ii/xsJvpRYGhLeEsNmdMcVdEsYTgmTMmhEvDNw500ealKLZ25KGboll/Scmc7xYk
         +j6WVzTA8gu3F7UQKIEK0DKd50uyO0rzG+ecaWzyPiIunRCZouO9M11yHSj2xxRIDUdT
         PnKYy5aqLG3cH4gwn91d0PnoUzjr6odkEAfPm20EV4raY02EKSZ6Ov+QKnT1fbzLNEX5
         2+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703611; x=1728308411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euFlGHOABtbw1QPloGs+fLVR06Q0Ayuhb57UM3GCWKk=;
        b=ua5X8w21n0nSBJQMhzxhE+0nKfJP21akTW5fz/0vtQRLn5vOJwX4yiA7etSF2nMZ+c
         nOxMR1cqGInav11mCtqyej6h/X38PW4DBN2RRCx99s1iUX7a3R/wZQjsUSsqn1s25DLN
         mzr1ogEIkxNVLmuIjRc+4qZAsHv0UPAOn+nyVrmZMU3HA4TzwWlPmQo5v64R+4O42uYd
         01e/4zpA9m7lGPALHz/RIpajTQUJkzxan4u3nt+nI/0sc8FIann0VGjH5PYeZVsW3saq
         tbMDFPwm/YVu2nbPYbjb5NdhneE1PkEhWT9VDCcxWsApg076phSVSgkO7xdoSq/yj72x
         D8kA==
X-Gm-Message-State: AOJu0YzbrMyRsZYAXg+JZBBOt+EVYIOFSJEOUGalR+QjU4eYT8gtMS9i
	o+IYXo8k1vdP2QxcKex1A2d2zoTXy7b0tuzqY8lkmM4ukkMstuHU
X-Google-Smtp-Source: AGHT+IG0L/eAUSJxZC6k223VnuBArwFP7pDmzPekAai948e7/IbwrhWwPBV0/0Zsokoph896nI/klQ==
X-Received: by 2002:a5d:4a85:0:b0:37c:c527:32aa with SMTP id ffacd0b85a97d-37cd5b2d391mr5974052f8f.59.1727703611203;
        Mon, 30 Sep 2024 06:40:11 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299aca5sm535858066b.224.2024.09.30.06.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:40:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Sep 2024 15:40:09 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Add private stack tests
Message-ID: <ZvqqOTrK_0aLRolW@krava>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234531.1771024-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926234531.1771024-1-yonghong.song@linux.dev>

On Thu, Sep 26, 2024 at 04:45:31PM -0700, Yonghong Song wrote:
> Some private stack tests are added including:
>   - prog with stack size greater than BPF_PSTACK_MIN_SUBTREE_SIZE.
>   - prog with stack size less than BPF_PSTACK_MIN_SUBTREE_SIZE.
>   - prog with one subprog having MAX_BPF_STACK stack size and another
>     subprog having non-zero stack size.
>   - prog with callback function.
>   - prog with exception in main prog or subprog.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

hi,
might be some fail on my side, but I had to include bpf_experimental.h to
compile this.. ci seems ok

  CLNG-BPF [test_progs-cpuv4] verifier_private_stack.bpf.o
progs/verifier_private_stack.c:174:2: error: call to undeclared function 'bpf_throw'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  174 |         bpf_throw(0);

jirka

> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_private_stack.c        | 215 ++++++++++++++++++
>  2 files changed, 217 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_stack.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index e26b5150fc43..635ff3509403 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -59,6 +59,7 @@
>  #include "verifier_or_jmp32_k.skel.h"
>  #include "verifier_precision.skel.h"
>  #include "verifier_prevent_map_lookup.skel.h"
> +#include "verifier_private_stack.skel.h"
>  #include "verifier_raw_stack.skel.h"
>  #include "verifier_raw_tp_writable.skel.h"
>  #include "verifier_reg_equal.skel.h"
> @@ -185,6 +186,7 @@ void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
>  void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
>  void test_verifier_precision(void)            { RUN(verifier_precision); }
>  void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
> +void test_verifier_private_stack(void)        { RUN(verifier_private_stack); }
>  void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
>  void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
>  void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> new file mode 100644
> index 000000000000..badd1fd1e3dd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/* From include/linux/filter.h */
> +#define MAX_BPF_STACK    512
> +
> +#if defined(__TARGET_ARCH_x86)
> +
> +SEC("kprobe")
> +__description("Private stack, single prog")
> +__success
> +__arch_x86_64
> +__jited("	movabsq	$0x{{.*}}, %r9")
> +__jited("	addq	%gs:0x{{.*}}, %r9")
> +__jited("	movl	$0x2a, %edi")
> +__jited("	movq	%rdi, -0x100(%r9)")
> +__naked void private_stack_single_prog(void)
> +{
> +	asm volatile (
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - 256) = r1;"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	:
> +	: __clobber_all);
> +}
> +
> +__used
> +__naked static void cumulative_stack_depth_subprog(void)
> +{
> +        asm volatile (
> +	"r1 = 41;"
> +        "*(u64 *)(r10 - 32) = r1;"
> +        "call %[bpf_get_smp_processor_id];"
> +        "exit;"
> +        :: __imm(bpf_get_smp_processor_id)
> +	: __clobber_all);
> +}
> +
> +SEC("kprobe")
> +__description("Private stack, subtree > MAX_BPF_STACK")
> +__success
> +__arch_x86_64
> +/* private stack fp for the main prog */
> +__jited("	movabsq	$0x{{.*}}, %r9")
> +__jited("	addq	%gs:0x{{.*}}, %r9")
> +__jited("	movl	$0x2a, %edi")
> +__jited("	movq	%rdi, -0x200(%r9)")
> +__jited("	pushq	%r9")
> +__jited("	callq	0x{{.*}}")
> +__jited("	popq	%r9")
> +__jited("	xorl	%eax, %eax")
> +__naked void private_stack_nested_1(void)
> +{
> +	asm volatile (
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
> +	"call cumulative_stack_depth_subprog;"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_const(max_bpf_stack, MAX_BPF_STACK)
> +	: __clobber_all);
> +}
> +
> +SEC("kprobe")
> +__description("Private stack, subtree > MAX_BPF_STACK")
> +__success
> +__arch_x86_64
> +/* private stack fp for the subprog */
> +__jited("	addq	$0x20, %r9")
> +__naked void private_stack_nested_2(void)
> +{
> +	asm volatile (
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
> +	"call cumulative_stack_depth_subprog;"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_const(max_bpf_stack, MAX_BPF_STACK)
> +	: __clobber_all);
> +}
> +
> +SEC("raw_tp")
> +__description("No private stack, nested")
> +__success
> +__arch_x86_64
> +__jited("	subq	$0x8, %rsp")
> +__naked void no_private_stack_nested(void)
> +{
> +	asm volatile (
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"call cumulative_stack_depth_subprog;"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	:
> +	: __clobber_all);
> +}
> +
> +__naked __noinline __used
> +static unsigned long loop_callback()
> +{
> +	asm volatile (
> +	"call %[bpf_get_prandom_u32];"
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - 512) = r1;"
> +	"call cumulative_stack_depth_subprog;"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_common);
> +}
> +
> +SEC("raw_tp")
> +__description("Private stack, callback")
> +__success
> +__arch_x86_64
> +/* for func loop_callback */
> +__jited("func #1")
> +__jited("	endbr64")
> +__jited("	nopl	(%rax,%rax)")
> +__jited("	nopl	(%rax)")
> +__jited("	pushq	%rbp")
> +__jited("	movq	%rsp, %rbp")
> +__jited("	endbr64")
> +__jited("	movabsq	$0x{{.*}}, %r9")
> +__jited("	addq	%gs:0x{{.*}}, %r9")
> +__jited("	pushq	%r9")
> +__jited("	callq")
> +__jited("	popq	%r9")
> +__jited("	movl	$0x2a, %edi")
> +__jited("	movq	%rdi, -0x200(%r9)")
> +__jited("	pushq	%r9")
> +__jited("	callq")
> +__jited("	popq	%r9")
> +__naked void private_stack_callback(void)
> +{
> +	asm volatile (
> +	"r1 = 1;"
> +	"r2 = %[loop_callback];"
> +	"r3 = 0;"
> +	"r4 = 0;"
> +	"call %[bpf_loop];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_ptr(loop_callback),
> +	  __imm(bpf_loop)
> +	: __clobber_common);
> +}
> +
> +SEC("fentry/bpf_fentry_test9")
> +__description("Private stack, exception in main prog")
> +__success __retval(0)
> +__arch_x86_64
> +__jited("	pushq	%r9")
> +__jited("	callq")
> +__jited("	popq	%r9")
> +int private_stack_exception_main_prog(void)
> +{
> +	asm volatile (
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - 512) = r1;"
> +	::: __clobber_common);
> +
> +	bpf_throw(0);
> +	return 0;
> +}
> +
> +__used static int subprog_exception(void)
> +{
> +	bpf_throw(0);
> +	return 0;
> +}
> +
> +SEC("fentry/bpf_fentry_test9")
> +__description("Private stack, exception in subprog")
> +__success __retval(0)
> +__arch_x86_64
> +__jited("	movq	%rdi, -0x200(%r9)")
> +__jited("	pushq	%r9")
> +__jited("	callq")
> +__jited("	popq	%r9")
> +int private_stack_exception_sub_prog(void)
> +{
> +	asm volatile (
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - 512) = r1;"
> +	"call subprog_exception;"
> +	::: __clobber_common);
> +
> +	return 0;
> +}
> +
> +#else
> +
> +SEC("kprobe")
> +__description("private stack is not supported, use a dummy test")
> +__success
> +int dummy_test(void)
> +{
> +        return 0;
> +}
> +
> +#endif
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.43.5
> 
> 


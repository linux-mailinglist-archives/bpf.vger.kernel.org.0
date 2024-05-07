Return-Path: <bpf+bounces-28939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F08BEC00
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AA61C218CB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043BC16D4F7;
	Tue,  7 May 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+FEfJO+"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC216D4EE
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108070; cv=none; b=lLfukUFSNzlq9m1Zm+tPyM94LwBJlZNzMIH/eikDM92MbkpJSLSWhh7V4Yz+25JzvF+eB8MntRnP+2Dpuz+39+/YfELRZ/SHh1zy0tMeoPJFOAVYaUwcoa6yCp/93Sikf1zw14tEfsDpz03h1NgF8sMO/ukH3gKmzSZNLSW+1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108070; c=relaxed/simple;
	bh=v7pl4kgy0gM/T9Vo1GYoUA4orD8Vu2B43xkXTTOR+5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzTLBiAcX6TgfQxmnYteCDn6PW85a6ar8RNNRTLn932WUBnCeaVJNQnvlRPo6o3+Op7KrpVa7RHuqu09git0VAVfaQJA4Gu9LQS/vreJf9aaMdRfnAdBueB4Cn2+qBroPWQ5hE8XTkCgpmc1+r/MS92jJTWp9wCD4yg+bnyJW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n+FEfJO+; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e76d3a47-fecf-4d2c-a417-9d1f5935df7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715108065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5Yn05Dvs7waYlx6xxaMtWQy1uf+sQqv2rItthQ9FSU=;
	b=n+FEfJO+AL5pZX/d9L72TGeSmdRn4MD+1L5Jz+Z/Mdqelr4PvVLGGbphu99mL+bhnGTSlb
	7PSJRZi1kcsxdpDq7iCHHO82lAZ9kvy5cEdWe9wF2mfN2aTx0ODp5kbk+C0QsqI2sYRnJH
	A4ekZ8PZl6KhvLVPDaRtYKihBpQu+M4=
Date: Tue, 7 May 2024 11:54:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2] bpf: avoid UB in usages of the __imm_insn
 macro
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240507133147.24380-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240507133147.24380-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/7/24 6:31 AM, Jose E. Marchesi wrote:
> [Differences with V1:
> - Typo fixed in patch: progs/verifier_ref_tracking.c
>    was missing -CFLAGS.]
>
> The __imm_insn macro is defined in bpf_misc.h as:
>
>    #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>
> This may lead to type-punning and strict aliasing rules violations in
> it's typical usage where the address of a struct bpf_insn is passed as
> expr, like in:
>
>    __imm_insn(st_mem,
>               BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))
>
> Where:
>
>    #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
> 		.dst_reg = DST,					\
> 		.src_reg = 0,					\
> 		.off   = OFF,					\
> 		.imm   = IMM })
>
> GCC detects this problem (indirectly) by issuing a warning stating
> that a temporary <Uxxxxxx> is used uninitialized, where the temporary
> corresponds to the memory read by *(long *).
>
> This patch adds -fno-strict-aliasing to the compilation flags of the
> particular selftests that do type punning via __imm_insn.  This
> silences the warning and, most importantly, avoids potential
> optimization problems due to breaking anti-aliasing rules.

For all the modified verifier_* files below, the functions
are naked inline asm, so there is no optimization risk of breaking
anti-aliasing rules. Is this right?

>
> Tested in master bpf-next.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/Makefile | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f0c429cf4424..c7507f420d9e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -53,6 +53,21 @@ progs/syscall.c-CFLAGS := -fno-strict-aliasing
>   progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
>   progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>   progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
> +# In the following tests the strict aliasing rules are broken by the
> +# __imm_insn macro, that do type-punning from `struct bpf_insn' to
> +# long and then uses the value.  This triggers an "is used
> +# uninitialized" warning in GCC.  This in theory may also lead to
> +# broken programs, so it is better to disable strict aliasing than
> +# inhibiting the warning.
> +progs/verifier_ref_tracking.c-CFLAGS := -fno-strict-aliasing
> +progs/verifier_unpriv.c-CFLAGS := -fno-strict-aliasing
> +progs/verifier_cgroup_storage.c-CFLAGS := -fno-strict-aliasing
> +progs/verifier_ld_ind.c-CFLAGS := -fno-strict-aliasing
> +progs/verifier_map_ret_val.c-CFLAGS := -fno-strict-aliasing
> +progs/cpumask_failure.c-CFLAGS := -fno-strict-aliasing

All these verifier_* files have __imm_insn, but I didn't see
__imm_insn usage for cpumask_failure.c. Did I miss anything?

All these verifier_* files are naked inline asm. So it should not
cause any issues with -fstrict-aliasing. Since there are no
issues for clang. Maybe just add -fno-strict-aliasing for gcc
only to silence the warning.

> +progs/verifier_spill_fill.c-CFLAGS := -fno-strict-aliasing
> +progs/verifier_subprog_precision.c-CFLAGS := -fno-strict-aliasing
> +progs/verifier_uninit.c-CFLAGS := -fno-strict-aliasing
>   
>   ifneq ($(LLVM),)
>   # Silence some warnings when compiled with clang


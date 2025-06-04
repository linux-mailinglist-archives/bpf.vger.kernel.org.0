Return-Path: <bpf+bounces-59646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE09DACE266
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC0917670E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44E1E32D3;
	Wed,  4 Jun 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RDjpz6Xc"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA91A5BA0
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055509; cv=none; b=WjmLpJuG+0NDiAjzuAw6UtKvBlWsgQNufhLp/Dv70GVmhDEylMljYadZ8SLeTF0JfxGDJ5yFzpl72UetwlOydUoifNG6qHIZCITDz4BhstbkqwisA2yOKet0e2vthydDOuANVL/aJctI0YHXw++5LYRsMMklPNIc6M7ZoREnpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055509; c=relaxed/simple;
	bh=6wy/ti0G3wZnGhfqhfVYU2CkCy3cQbafhicsYvhq40Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZVWjT0BZMWX9sEYz4XwWrHJvUTnUpim9RETHKPgQUjHKyuKc3LHRs+Vi2ZQtfG1w/3WF4ZfyqX25qlm+Pu27+8alJJzRkcV5G/doX7z/nrxMSE/Q0mjybeuLuaOLPb89HfLUWSH6IMEaJx85RsDjYe/qJzHGRItvt3xcizstIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RDjpz6Xc; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f93ce37e-e155-4165-88e2-1a3cadee7c82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749055504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DMrr5KCHutBYTCA6gU+/RGbKiJDm3jw//nbW/aOSzo=;
	b=RDjpz6XcpHNpJi6JJkvOUqHyVSSavi+DtQfJBBq6BfUt7n46FpINmnW/gCf3+kpm8wmbHT
	CXApF4lmOQUDWwOoqUXQ7VZO3SZ5yJaMlfUN+hphK51DEfxB3vnnd0GycLU1xKMfVIsW+A
	IQLV73oILOlRleGBYf0mNCPXSoLdV7c=
Date: Wed, 4 Jun 2025 09:44:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
To: andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250604003759.1020745-1-isolodrai@meta.com>
 <20250604003759.1020745-2-isolodrai@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20250604003759.1020745-2-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/25 5:37 PM, Ihor Solodrai wrote:
> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
> BPF program with this code must not pass verification in unpriv.
> 
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>   .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> index 28200f068ce5..85b41f927272 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -634,6 +634,23 @@ l0_%=:	r0 = 0;						\
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("unpriv: cmp map pointer with const")
> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibited")
> +__retval(0)
> +__naked void cmp_map_pointer_with_const(void)
> +{
> +	asm volatile ("					\
> +	r1 = 0;						\
> +	r1 = %[map_hash_8b] ll;				\
> +	if r1 == 0xcafefeeddeadbeef goto l0_%=;		\

GCC BPF caught (correctly) that this is not a valid instruction because 
imm is supposed to be 32bit [1]:

     progs/verifier_unpriv.c: Assembler messages:
     progs/verifier_unpriv.c:643: Error: immediate out of range, shall 
fit in 32 bits
     make: *** [Makefile:751: 
/tmp/work/bpf/bpf/src/tools/testing/selftests/bpf/bpf_gcc/verifier_unpriv.bpf.o] 
Error 1

But LLVM 20 let it compile and the test passes. I wonder whether it's a 
bug in LLVM worth reporting?

[1] 
https://github.com/kernel-patches/bpf/actions/runs/15430930573/job/43428666342

> +l0_%=:	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm_addr(map_hash_8b)
> +	: __clobber_all);
> +}
> +
>   SEC("socket")
>   __description("unpriv: write into frame pointer")
>   __failure __msg("frame pointer is read only")



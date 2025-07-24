Return-Path: <bpf+bounces-64286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29004B11011
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE39AE6C6D
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C62EA754;
	Thu, 24 Jul 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jOP03sx8"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D24430
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376337; cv=none; b=EntZwP+yGLbva4ICaXhDq4+BbxKelUEpmzGezNFXgkorAxwQUPOrP/h0C1ztmPqiB060IVV7JGcGnKwx9IOuxDwVro5qETD57eMJtedSCXAgJMDElrGZX44u0yw4n8ZUPKApEeoyZTgEqzkAV6ZQkBFjGZ9qQXmDn4Tr305Nlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376337; c=relaxed/simple;
	bh=ULqnRDiGljYbECfABDQTYSmB8vco71D5XVnYc6WEqxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=updtBL+t/paDyehhXI2+oa8LCUmZnMGbCjDPg3kZdmjslqi0k4eW6yHRre40j2ZRP/Tw/djR8nngeG9j/k3xD00UyuHiODnjPbMbBtdna/vzTrEuM//1boGnG/8ngDLvqBmPmlp9cXKMlhClOUKE3OMdLLX1mbO0bi8vgU1wbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jOP03sx8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aa80ed3a-caab-4dc6-9f04-34017f50c230@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753376330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aafe+v25p0Kh+Q0Cq36UTDajIHrXWB9PDFmqRICuxnU=;
	b=jOP03sx83dzxiMja7hra9W950gY2TlI+cDIsXt2UqaTdrwF+pQwJxJ9PIYdjLIoblNhiRJ
	aWUqeslMVO5K9pt1Ql6hfHDXGxqkFu9JcZKoo9NnYTA4RUst5+FRiVFn3CQEHtQbLViz/C
	GOHc1xxLcj+jHMAHysWXYhwUZ8aTWh8=
Date: Thu, 24 Jul 2025 09:58:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf, arm64: JIT support for private stack
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
References: <20250724120257.7299-1-puranjay@kernel.org>
 <20250724120257.7299-3-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250724120257.7299-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/24/25 5:02 AM, Puranjay Mohan wrote:
> The private stack is allocated in bpf_int_jit_compile() with 16-byte
> alignment. It includes additional guard regions to detect stack
> overflows and underflows at runtime.
>
> Memory layout:
>
>                +------------------------------------------------------+
>                |                                                      |
>                |  16 bytes padding (overflow guard - stack top)       |
>                |  [ detects writes beyond top of stack ]              |
>       BPF FP ->+------------------------------------------------------+
>                |                                                      |
>                |  BPF private stack (sized by verifier)               |
>                |  [ 16-byte aligned ]                                 |
>                |                                                      |
> BPF PRIV SP ->+------------------------------------------------------+
>                |                                                      |
>                |  16 bytes padding (underflow guard - stack bottom)   |
>                |  [ detects accesses before start of stack ]          |
>                |                                                      |
>                +------------------------------------------------------+
>
> On detection of an overflow or underflow, the kernel emits messages
> like:
>      BPF private stack overflow/underflow detected for prog <prog_name>
>
> After commit bd737fcb6485 ("bpf, arm64: Get rid of fpb"), Jited BPF
> programs use the stack in two ways:
> 1. Via the BPF frame pointer (top of stack), using negative offsets.
> 2. Via the stack pointer (bottom of stack), using positive offsets in
>     LDR/STR instructions.
>
> When a private stack is used, ARM64 callee-saved register x27 replaces
> the stack pointer. The BPF frame pointer usage remains unchanged; but it
> now points to the top of the private stack.
>
> Relevant tests (Enabled in following patch):
>
>   #415/1   struct_ops_private_stack/private_stack:OK
>   #415/2   struct_ops_private_stack/private_stack_fail:OK
>   #415/3   struct_ops_private_stack/private_stack_recur:OK
>   #415     struct_ops_private_stack:OK
>   #549/1   verifier_private_stack/Private stack, single prog:OK
>   #549/2   verifier_private_stack/Private stack, subtree > MAX_BPF_STACK:OK
>   #549/3   verifier_private_stack/No private stack:OK
>   #549/4   verifier_private_stack/Private stack, callback:OK
>   #549/5   verifier_private_stack/Private stack, exception in main prog:OK
>   #549/6   verifier_private_stack/Private stack, exception in subprog:OK
>   #549/7   verifier_private_stack/Private stack, async callback, not nested:OK
>   #549/8   verifier_private_stack/Private stack, async callback, potential nesting:OK
>   #549     verifier_private_stack:OK
>   Summary: 2/11 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>



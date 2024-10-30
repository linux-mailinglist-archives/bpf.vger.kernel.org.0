Return-Path: <bpf+bounces-43543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5809B5FC0
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 11:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E614284457
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DD1E2312;
	Wed, 30 Oct 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gnbgPfcW"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8E194151
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283072; cv=none; b=BP+cnEqHfSj/yP0NBJZTonalvgmpTWqRae/LaBjSeZrmcKxs9HPQXut0mF0Rg2lnbU7yhvS0rSBsHDA0zNzo4RKGQZr4jUodp6xBb4Om0iEoO3VqLB+LQVDjtdbqMi4M1YATI0ALyYa317wF/JBr+A+6buBtDEtkUw4PBDG9Lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283072; c=relaxed/simple;
	bh=R6HIuQ0AStRaw0mMRrOSDAWNTnhK97B84nmMpeRtYi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm7q+KhdGchiswCnFl9yqVfPXl9mexolyb84L8ljQHhHOdSsANGzqZB6Gqs+tM7EcBDtdd7l1RhBSQA7SJYakIdT8PnjHWBhNv8jsOVs4OC6tMZbcIoYzaCcz8feYrutKCtyCtNr2XfzptIRB+Ed6caC4sY8nqsgKKRDmGxMwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gnbgPfcW; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e404d1cd-cf40-48dd-8a49-82c03c3b641e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730283065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+IPZ0Ax3CP4X9v6mKBzWRxh8Uj31G4xSneYUwIi27Y=;
	b=gnbgPfcWE5KbjzlHrQ8e6XPH2Ak3d6ha7ejm0DBwr7vWqwJ4Kn0uhL192YloqGh66XM/Nk
	uCePKvx2+WcDWUtjsHzlj+LA4CaNrkhO2cxrjKx18H3OQvPOU+J4c8J/lFM28cmDVeBht0
	KQUX5zS4HShkZl1qUhqhBRu3TO5gUQ8=
Date: Wed, 30 Oct 2024 18:10:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-patches-bot@fb.com
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20241030094741.22929-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/30 17:47, Leon Hwang wrote:
> From: Leon Hwang <leon.hwang@linux.dev>
> 
> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
> 
> The issue stemmed from an incorrect program counter (PC) value used during
> disassembly with LLVM or libbfd. To calculate the correct address for
> relative calls, the PC argument must reflect the actual address in the
> kernel.
> 
> [0] https://github.com/libbpf/bpftool/issues/109
> 
> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/jit_disasm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index 7b8d9ec89ebd3..fe8fabba4b05f 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)

It seems we should update the type of pc from int to __u64, as the type
of func_ksym is __u64 and the type of pc argument in disassemble
function of LLVM and libbfd is __u64 for 64 bit arch.

Thanks,
Leon

>  	char buf[256];
>  	int count;
>  
> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
> -				      buf, sizeof(buf));
> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
>  	if (json_output)
>  		printf_json(buf);
>  	else
> @@ -360,7 +359,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
>  			printf("%4x:" DISASM_SPACER, pc);
>  		}
>  
> -		count = disassemble_insn(&ctx, image, len, pc);
> +		count = disassemble_insn(&ctx, image + pc, len - pc,
> +					 func_ksym + pc);
>  
>  		if (json_output) {
>  			/* Operand array, was started in fprintf_json. Before



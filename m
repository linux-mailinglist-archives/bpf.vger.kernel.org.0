Return-Path: <bpf+bounces-43592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E49B6B02
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED281F21497
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408131BD9E1;
	Wed, 30 Oct 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cFQrjRaf"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381C1BD9D8
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309343; cv=none; b=KAyz2YKIs5SwF+0IemzGpx4mxqAdL/2Pml5FBM/R2RtTjncnCn6xDCsh9vVO2CHKRFyWnbIUYCIJG3+6f59asvhTJgNcQKZ1B7GIr7/bVZ1RYZSftccNUsTYWQ0cOv//dg0VnTLBECsnyYJ6FQtSz0/0ApFLvEoAP0Y93256oCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309343; c=relaxed/simple;
	bh=06CZivvSBR6kmsEsDJRdRCc5zDNoEUndOVeK/3PhBnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGqFEpK+0cJVwG2mFekvW1zceZJgHUyxCBg4Pr5l4BH2+ezFFAX+zmDzwcMN/U3+O+gN+RXwMFSQG/m0y6lKjl4hARiO29eLfkkGxBet+6gntZ3l2MsZxAFveaknoTrnuHQnf4Vj3n/x8+1Y52io1HB3kT6cbbhaBtCdkDYu9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cFQrjRaf; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a31cf92-311d-4abf-b076-8940da41629f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730309338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5g9SRjabbhAs0KXn+79iZ7966f2F+grY10F6ipPGnU=;
	b=cFQrjRaf/Y8657JIoFjukOv9h3foGPUItiiN2lGESZdyAqGqMv0T7Mv7RCRbQ9ejRRSoYK
	MHnGDRNBHWPAGBzQrCccTrJGfHA7EjZJ8AhWHVwn0xRQkEnoQFZWKUvEJ8G1jpo1qvzT0Y
	dwgUSGYh5e5k5pTXibiQj8jajMoczC8=
Date: Wed, 30 Oct 2024 10:28:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
Content-Language: en-GB
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 leon.hwang@linux.dev, kernel-patches-bot@fb.com
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241030094741.22929-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/30/24 2:47 AM, Leon Hwang wrote:
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

The following is the LLVMDisasmInstruction() description in
llvm-c/Disassembler.h:

/**
  * Disassemble a single instruction using the disassembler context specified in
  * the parameter DC.  The bytes of the instruction are specified in the
  * parameter Bytes, and contains at least BytesSize number of bytes.  The
  * instruction is at the address specified by the PC parameter.  If a valid
  * instruction can be disassembled, its string is returned indirectly in
  * OutString whose size is specified in the parameter OutStringSize.  This
  * function returns the number of bytes in the instruction or zero if there was
  * no valid instruction.
  */
size_t LLVMDisasmInstruction(LLVMDisasmContextRef DC, uint8_t *Bytes,
                              uint64_t BytesSize, uint64_t PC,
                              char *OutString, size_t OutStringSize);

In the above, it has
   The instruction is at the address specified by the PC parameter.

To call insn itself only encodes the difference between
helper address and 'bpf_prog + call_insn pc within prog'.
So to calculate proper final call address, the bpf_prog entry address
must be provided. So we need to supply 'prog_entry_addr + pc' instead
of 'pc'.

32bit should be okay since addr is within the first 4G.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/bpf/bpftool/jit_disasm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index 7b8d9ec89ebd3..fe8fabba4b05f 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
>   	char buf[256];
>   	int count;
>   
> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
> -				      buf, sizeof(buf));
> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
>   	if (json_output)
>   		printf_json(buf);
>   	else
> @@ -360,7 +359,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
>   			printf("%4x:" DISASM_SPACER, pc);
>   		}
>   
> -		count = disassemble_insn(&ctx, image, len, pc);
> +		count = disassemble_insn(&ctx, image + pc, len - pc,
> +					 func_ksym + pc);
>   
>   		if (json_output) {
>   			/* Operand array, was started in fprintf_json. Before


Return-Path: <bpf+bounces-43617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C89B712D
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 01:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6118285199
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CAC2FD;
	Thu, 31 Oct 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eplL3jBB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F04A35
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334451; cv=none; b=jPoja92j5jCcr859ohHWDtzcHMewJ7LIqipF7Eb/TIkOPCMsSOHS2QfYkA3sQQHGw9IrORN44p78SHnwl1n+htVMMBykvtU3ApeLEEpsUjDdMz75nmR2C+PSrZG1bG2d1Qi23KY+d7TZmSH2a+V8xD7UBtPC6cR4qPNkgSv+zWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334451; c=relaxed/simple;
	bh=uyv2yFl2pZ69wjW5YGErcZoroHl3Q5Sryt+UajVlzyE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FCt4EuQ4wUm0wujFaPwETQSa5cPaGS2gYh7s0JLteTsoZxMkfcO/1vutpHKhXb7teE996z1c+dwsYoxavP3iOYplNyclitdk4otefIxEMN4HUDhKpNtd2Tet9aAm0nMhCX/map61QctkPRk1N1dLevOtRuIRlB5UESRIbjChPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eplL3jBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F2BC4CECE;
	Thu, 31 Oct 2024 00:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730334451;
	bh=uyv2yFl2pZ69wjW5YGErcZoroHl3Q5Sryt+UajVlzyE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=eplL3jBB9QNzcw/RNbeMo5maLQf89MHb5XLrq7SCfHbEdCbGrQTc5P3XcnC9977kI
	 J33DJINjrP3dBJLKf0hJ7FIM8wbn6OG5YSZTlooX5wjf0SmvWqoHqrejQOUKprFxTV
	 /F77B7sv9mjeijOCYSXSWld1xWYFVRESBrFqFz7ojtc3XUp4tpqvUdoOo3e4v/kGmi
	 HSGXtVeyUWkn/fxThl3WAYtaUiatR+n+8f6tK7eLTx7eguMnea3h6uXS0jzFOiRiwg
	 YNN9c1KWUA1KOgovDVLQYGkruuRepMicSnRXwyc3vY0s9UT4vBh4AbtzQtlVbeYzBi
	 1TS72YpYtyYvg==
Message-ID: <1b492a6f-c7e8-4dba-84dd-35aafb6c2ede@kernel.org>
Date: Thu, 31 Oct 2024 00:27:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 leon.hwang@linux.dev, kernel-patches-bot@fb.com,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Gray Liang <gray.liang@isovalent.com>
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
Content-Language: en-GB
In-Reply-To: <20241030094741.22929-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-10-30 17:47 UTC+0800 ~ Leon Hwang <hffilwlqm@gmail.com>
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

Thanks a lot for looking into this! Your patch does solve the issue for
the LLVM disassembler (nice!), but it breaks the libbfd one:


	$ ./bpftool version | grep features
	features: libbfd
	# ./bpftool prog dump j id 111 op
	int xdp_redirect_map_0(struct xdp_md * xdp):
	bpf_prog_a8f6f9c4be77b94c_xdp_redirect_map_0:
	; return bpf_redirect_map(&tx_port, 0, 0);
	   0:   Address 0xffffffffc01ae950 is out of bounds.

I don't think we can change the PC in the case of libbfd, as far as I
can tell it needs to point to the first instruction to disassemble. Two
of the arguments we pass to disassemble_insn(), image and len, are
ignored by the libbfd disassembler; so it leaves only the ctx argument
that we can maybe update to pass the func_ksym, but I haven't found how
to do that yet (if possible at all).

Thanks,
Quentin


pw-bot: cr


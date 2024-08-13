Return-Path: <bpf+bounces-37053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BD9509D1
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E795F1C22519
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10891A3BA1;
	Tue, 13 Aug 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lIlYDSgJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C81A38F9
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565134; cv=none; b=WrsI27Aije/u4o3ZphD5GOUKPMo32fimaZrJ5o3gYJKFEMwPwJ2QfrOdk64/rd6FGERb+hIh4Psbo4ouW9hrMBs74ZcbIDPo9r1WMH3fzbYy29nKVK2P3TN/SHGKNVgMvs8rXM2+gvV7MEGmpHkqAzsWsUgcl7DSAsM4G7+Bz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565134; c=relaxed/simple;
	bh=OnVnFRbOI2EOiHO6qf42/N7C8BA/eS2ufv5IHC9fHg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=losIXNyA2IHwQJxXj3hWh9EPp4+qqNWIANZGmhCB1xCK3myEkboBfN3mgooJGzrdaTRE/aKvCvnZZDdUJYbewXInmkHSV1kBAk0/ZcT+rJ8q3x2TSV0TrCo73yv6TN78HNFeOsZJmdl9a0tMqRuONuyf+1wCimf09BJSchTJBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lIlYDSgJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59186574-984c-4ccc-9861-27a9db15d2e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723565129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE6Xch0+LjaKuKukO5ZunKT7HwgWUu89ksKwOc6tzXw=;
	b=lIlYDSgJMmAdon5i/Dm9FyWhmAraTYn+rIoHvZMaxvi9qKXyhQ5KhTgBUif4zsIr9YTQfC
	hfPh5ZSb/iuIze1kggv3NKH2BUb6G5jHavYYmvDNyGxjzAQYjEpH3H60lrtEp9nE7fTvD3
	8/PWwrwiWsidzX6sSQ/CJ/98D5dAdZo=
Date: Tue, 13 Aug 2024 09:05:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, hffilwlqm@gmail.com
References: <20240809010518.1137758-1-eddyz87@gmail.com>
 <20240809010518.1137758-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240809010518.1137758-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/24 6:05 PM, Eduard Zingerman wrote:
>      int get_jited_program_text(int fd, char *text, size_t text_sz)
>
> Loads and disassembles jited instructions for program pointed to by fd.
> Much like 'bpftool prog dump jited ...'.
>
> The code and makefile changes are inspired by jit_disasm.c from bpftool.
> Use llvm libraries to disassemble BPF program instead of libbfd to avoid
> issues with disassembly output stability pointed out in [1].
>
> Selftests makefile uses Makefile.feature to detect if LLVM libraries
> are available. If that is not the case selftests build proceeds but
> the function returns -ENOTSUP at runtime.
>
> [1] commit eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/.gitignore        |   1 +
>   tools/testing/selftests/bpf/Makefile          |  51 +++-
>   .../selftests/bpf/jit_disasm_helpers.c        | 228 ++++++++++++++++++
>   .../selftests/bpf/jit_disasm_helpers.h        |  10 +
>   4 files changed, 288 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
>   create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
>
[...]
> +static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
> +{
> +	char *label, *colon, *triple = NULL;
> +	LLVMDisasmContextRef ctx = NULL;
> +	struct local_labels labels = {};
> +	__u32 *label_pc, pc;
> +	int i, cnt, err = 0;
> +	char buf[256];
> +
> +	triple = LLVMGetDefaultTargetTriple();
> +	ctx = LLVMCreateDisasm(triple, &labels, 0, NULL, lookup_symbol);
> +	if (!ASSERT_OK_PTR(ctx, "LLVMCreateDisasm")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	cnt = LLVMSetDisasmOptions(ctx, LLVMDisassembler_Option_PrintImmHex);
> +	if (!ASSERT_EQ(cnt, 1, "LLVMSetDisasmOptions")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* discover labels */
> +	labels.prog_len = len;
> +	pc = 0;
> +	while (pc < len) {
> +		cnt = disasm_insn(ctx, image, len, pc, buf, 1);
> +		if (cnt < 0) {
> +			err = cnt;
> +			goto out;
> +		}
> +		pc += cnt;
> +	}
> +	qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
> +	/* GCC can't figure max bound for i and thus reports possible truncation */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wformat-truncation"
> +	for (i = 0; i < labels.cnt; ++i)
> +		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i);
> +#pragma GCC diagnostic pop

"-Wformat-truncation" is only available for llvm >= 18. One of my build with llvm15
has the following warning/error:

jit_disasm_helpers.c:113:32: error: unknown warning group '-Wformat-truncation', ignored [-Werror,-Wunknown-warning-option]
#pragma GCC diagnostic ignored "-Wformat-truncation"

Maybe you want to guard with proper clang version?
Not sure on gcc side when "-Wformat-truncation" is supported.

> +
> +	/* now print with labels */
> +	labels.print_phase = true;
> +	pc = 0;
> +	while (pc < len) {
> +		cnt = disasm_insn(ctx, image, len, pc, buf, sizeof(buf));
> +		if (cnt < 0) {
> +			err = cnt;
> +			goto out;
> +		}
> +		label_pc = bsearch(&pc, labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
> +		label = "";
> +		colon = "";
> +		if (label_pc) {
> +			label = labels.names[label_pc - labels.pcs];
> +			colon = ":";
> +		}
> +		fprintf(text_out, "%x:\t", pc);
> +		for (i = 0; i < cnt; ++i)
> +			fprintf(text_out, "%02x ", image[pc + i]);
> +		for (i = cnt * 3; i < 12 * 3; ++i)
> +			fputc(' ', text_out);
> +		fprintf(text_out, "%s%s%s\n", label, colon, buf);
> +		pc += cnt;
> +	}
> +
> +out:
> +	if (triple)
> +		LLVMDisposeMessage(triple);
> +	if (ctx)
> +		LLVMDisasmDispose(ctx);
> +	return err;
> +}
> +
[...]


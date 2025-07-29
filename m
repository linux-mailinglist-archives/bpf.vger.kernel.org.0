Return-Path: <bpf+bounces-64678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C6B15575
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 00:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC718A16F7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D2C280328;
	Tue, 29 Jul 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWaArqh1"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570C1DE2BC
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829686; cv=none; b=rAu4ynrbV2hM+jOVsHFy/rabLeT3CzbdMoLYfgwk7zap26ZuBi61NWWgn59d1wQAp3vrW6tORzlqRFX4rPA7WHh5b7rAT9M1bTY5pRwXYSHMoTzpDM7WfdtEcRdhxoYE0ywlN+4YDIcQhRbSnSaJKM4O90CsBtfchI25SQaWOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829686; c=relaxed/simple;
	bh=SOB/o1iuwBQz2Y81Uao0nWrVWivItWtYYSlGD/JY1UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bzy0Mzo8dLNCfchQ+t6n9sEytzeN6m8xUcXJfQ8a2zjlhTbM8ke1QZqCIZx6BSO9R6nOTShHiao2O9xIDwn2rbfj15CENI03cPrqmcX5+3mKqvVuYf0f220oVTCt464nnj0kzCGWQzdAfG93xdtczI+SQkdKtQ0PJ3DSN8IJqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWaArqh1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23caf44c-48e7-41b2-bc9a-e286f93bd96f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753829682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR4nQsxlk4hEmvm6cSvy4y/DxKWhjZh62EU3mdesfDI=;
	b=gWaArqh1gSMDugR5FFecY/eAWa4VoEiDOtvPvfUEsQqRgx7spmxn/nATg8TFQlcI2A6X5g
	Ce0cGYtEvw51oaXJCVhQEsdIVUl7DBkk/z7BGKuSC94NU0hnlHsBRsxKXHoUlwQv2c2FjC
	jz2RoWPahdqttNVQzhvignn8it6KEPM=
Date: Tue, 29 Jul 2025 15:54:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] libbpf: fix USDT SIB argument handling causing
 unrecognized register error
Content-Language: en-GB
To: Jiawei Zhao <Phoenix500526@163.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org
References: <20250729161722.35462-1-Phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250729161722.35462-1-Phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/29/25 9:17 AM, Jiawei Zhao wrote:
> On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
> addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
> in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
> to fail with -ENOENT (unrecognized register).
>
> This patch fixes this by implementing the necessary changes:
> - add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
> - add adaptive support to `__bpf_usdt_arg_type` and
> `__bpf_usdt_arg_spec` to represent SIB addressing parameters.
>
> Change since v1(https://lore.kernel.org/lkml/20250729125244.28364-1-Phoenix500526@163.com/):
> - refactor the code to make it more readable
> - modify the commit message to explain why and how
>
> Change since v2:
> - fix the `scale` uninitialized error
>
> Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
> ---
>   tools/lib/bpf/usdt.bpf.h | 33 ++++++++++++++++++++++++++++++++-
>   tools/lib/bpf/usdt.c     | 26 +++++++++++++++++++++++---
>   2 files changed, 55 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 2a7865c8e3fe..246513088c3a 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -34,6 +34,7 @@ enum __bpf_usdt_arg_type {
>   	BPF_USDT_ARG_CONST,
>   	BPF_USDT_ARG_REG,
>   	BPF_USDT_ARG_REG_DEREF,
> +	BPF_USDT_ARG_SIB,
>   };
>   
>   struct __bpf_usdt_arg_spec {
> @@ -43,6 +44,10 @@ struct __bpf_usdt_arg_spec {
>   	enum __bpf_usdt_arg_type arg_type;
>   	/* offset of referenced register within struct pt_regs */
>   	short reg_off;
> +	/* offset of index register in pt_regs, only used in SIB mode */
> +	short idx_reg_off;
> +	/* scale factor for index register, only used in SIB mode */
> +	short scale;
>   	/* whether arg should be interpreted as signed value */
>   	bool arg_signed;
>   	/* number of bits that need to be cleared and, optionally,
> @@ -149,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>   {
>   	struct __bpf_usdt_spec *spec;
>   	struct __bpf_usdt_arg_spec *arg_spec;
> -	unsigned long val;
> +	unsigned long val, idx;
>   	int err, spec_id;
>   
>   	*res = 0;
> @@ -202,6 +207,32 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>   			return err;
>   #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>   		val >>= arg_spec->arg_bitshift;
> +#endif
> +		break;
> +	case BPF_USDT_ARG_SIB:
> +		/* Arg is in memory addressed by SIB (Scale-Index-Base) mode
> +		 * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). Register
> +		 * is identified like with BPF_USDT_ARG_SIB case, the offset
> +		 * is in arg_spec->val_off, the scale factor is in arg_spec->scale.
> +		 * Firstly, we fetch the base register contents and the index
> +		 * register contents from pt_regs. Secondly, we multiply the
> +		 * index register contents by the scale factor, then add the
> +		 * base address and the offset to get the final address. Finally,
> +		 * we do another user-space probe read to fetch argument value
> +		 * itself.
> +		 */
> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +		if (err)
> +			return err;
> +		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + arg_spec->idx_reg_off);
> +		if (err)
> +			return err;
> +		err = bpf_probe_read_user(&val, sizeof(val),
> +				(void *)val + idx * arg_spec->scale + arg_spec->val_off);
> +		if (err)
> +			return err;
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +		val >>= arg_spec->arg_bitshift;
>   #endif
>   		break;
>   	default:

If possible, could you add some tests which actually trigger a usdt pattern
like "-1@-96(%rbp,%rax,8)"?

There are much more usdt patterns e.g. in
   https://lore.kernel.org/bpf/b3ce39f0-c52b-4787-980c-973bd4228349@linux.dev/
===
with -O2 and with gcc14 on x86:

    stapsdt              0x00000087       NT_STAPSDT (SystemTap probe descriptors)
      Provider: test
      Name: usdt12
      Location: 0x000000000000258f, Base: 0x0000000000000000, Semaphore: 0x0000000000000006
      Arguments: -4@$2 -4@$3 -8@$42 -8@$44 -4@$5 -8@$6 8@%rdx 8@%rsi -4@$-9 -2@%cx -2@nums(%rax,%rax) -1@t1+4(%rip)
    ...
===

But we didn't add those '-2@nums(%rax,%rax)' '-1@t1+4(%rip)' as
they are very rare.

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 4e4a52742b01..260211e896d5 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -200,6 +200,7 @@ enum usdt_arg_type {
>   	USDT_ARG_CONST,
>   	USDT_ARG_REG,
>   	USDT_ARG_REG_DEREF,
> +	USDT_ARG_SIB,
>   };
>   
>   /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
> @@ -207,6 +208,8 @@ struct usdt_arg_spec {
>   	__u64 val_off;
>   	enum usdt_arg_type arg_type;
>   	short reg_off;
> +	short idx_reg_off;
> +	short scale;
>   	bool arg_signed;
>   	char arg_bitshift;
>   };
> @@ -1283,11 +1286,28 @@ static int calc_pt_regs_off(const char *reg_name)
>   
>   static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
>   {
> -	char reg_name[16];
> -	int len, reg_off;
> +	char reg_name[16], idx_reg_off, idx_reg_name[16];
> +	int len, reg_off, scale;
>   	long off;
>   
> -	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
> +	if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n",
> +				arg_sz, &off, reg_name, idx_reg_name, &scale, &len) == 5) {
> +		/* Scale Index Base case, e.g., 1@-96(%rbp,%rax,8)*/
> +		arg->arg_type = USDT_ARG_SIB;
> +		arg->val_off = off;
> +		arg->scale = scale;
> +
> +		reg_off = calc_pt_regs_off(reg_name);
> +		if (reg_off < 0)
> +			return reg_off;
> +		arg->reg_off = reg_off;
> +
> +		idx_reg_off = calc_pt_regs_off(idx_reg_name);
> +		if (idx_reg_off < 0)
> +			return idx_reg_off;
> +		arg->idx_reg_off = idx_reg_off;
> +	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
> +				arg_sz, &off, reg_name, &len) == 3) {
>   		/* Memory dereference case, e.g., -4@-20(%rbp) */
>   		arg->arg_type = USDT_ARG_REG_DEREF;
>   		arg->val_off = off;



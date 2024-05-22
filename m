Return-Path: <bpf+bounces-30263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BD8CBB4F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 08:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F7E1F22FCB
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547677F1B;
	Wed, 22 May 2024 06:30:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97478C6E;
	Wed, 22 May 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359403; cv=none; b=souKNVna+6qUFfUm5eMnde1j6X+AJ16sefmMLsCp1uoFCl0iFw2cat7wU3oTMtCjAFpu6watKxMokPF+KMQUxzn6YYcHs47LCVnrOQSoXgqFgN4UvHAI43gpPFIkN6Zn620VUWg4HRTyPcD4afpY0MgKYGZAqjtTGxz5lW/APzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359403; c=relaxed/simple;
	bh=quOnlt5DLdCUqjEiDgFP3oeaAMtVdt+qKcoJc86FG/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJugPmkDp66Wn0B2MICo66SKaiWpsRpuPQTXiyaoCT1F1kkyll72vkDkQZgRTHYnKNp7AbzFsbeOoHANH3TXofy4Z+WQoSLJjeSfWzcb8tmT9efz1NupwfrFWHC4tvVcIUGorgLzL5LIy9jd/ehaD4e2N2CIsaaq7DYSLoJQcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VkhFz58Wszcj7F;
	Wed, 22 May 2024 14:28:39 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 356FD1401E9;
	Wed, 22 May 2024 14:29:57 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 May 2024 14:29:56 +0800
Message-ID: <af4cf420-558a-4893-8469-c354d3e337eb@huawei.com>
Date: Wed, 22 May 2024 14:29:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Use STACK_ALIGN macro for size rounding up
Content-Language: en-US
To: Xiao Wang <xiao.w.wang@intel.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <luke.r.nels@gmail.com>,
	<xi.wang@gmail.com>, <bjorn@kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <haicheng.li@intel.com>
References: <20240522054507.3941595-1-xiao.w.wang@intel.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240522054507.3941595-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/5/22 13:45, Xiao Wang wrote:
> Use the macro STACK_ALIGN that is defined in asm/processor.h for stack size
> rounding up, just like bpf_jit_comp32.c does.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 39149ad002da..bd869d41612f 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -858,7 +858,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	stack_size += 8;
>   	sreg_off = stack_size;
>   
> -	stack_size = round_up(stack_size, 16);
> +	stack_size = round_up(stack_size, STACK_ALIGN);
>   
>   	if (!is_struct_ops) {
>   		/* For the trampoline called from function entry,
> @@ -1723,7 +1723,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   {
>   	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
>   
> -	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> +	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
>   	if (bpf_stack_adjust)
>   		mark_fp(ctx);
>   
> @@ -1743,7 +1743,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   	if (seen_reg(RV_REG_S6, ctx))
>   		stack_adjust += 8;
>   
> -	stack_adjust = round_up(stack_adjust, 16);
> +	stack_adjust = round_up(stack_adjust, STACK_ALIGN);
>   	stack_adjust += bpf_stack_adjust;
>   
>   	store_offset = stack_adjust - 8;

Reviewed-by: Pu Lehui <pulehui@huawei.com>


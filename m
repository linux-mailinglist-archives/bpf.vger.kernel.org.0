Return-Path: <bpf+bounces-32554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38D90FB61
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 04:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F191C21298
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF31CD2B;
	Thu, 20 Jun 2024 02:41:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4E1C680;
	Thu, 20 Jun 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718851303; cv=none; b=jp/1Whibdn4sv9bvDpRflEDhhq6JMLL1/pMTaag7QeOHrc3rD926dPUHHUS5Qn2LQPGMQzWIR34XonHfWz4tOJez/hG4RQdqQckMGEN37sspNdNpfF7ookp7KMyO+BuFDAL99EYEkyRupv35S/RY6xc9xxZ+tk7mWZAP/qKxUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718851303; c=relaxed/simple;
	bh=zlT+RN2y05WjaAuWzKTrbl1RWoP7avKxWPuu6j9IFY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrZKG/QFVpsvvFMphNon0D1EqSoSRFzlSgd1G88wjqLitzHfYEYonqj/UV/3OhpEzIhwi88YOKHIjtGAeWDHS4+MK6P5ok6RjOM97dPcLEHnnlwOWPKKbhHKKaM6Wh221ALIwlOjc7/Ql1cJ3o4fg43XTvVuA16IZddQhxROk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W4PrJ0cwyz4f3jMH;
	Thu, 20 Jun 2024 10:41:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 826911A0568;
	Thu, 20 Jun 2024 10:41:30 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBXCgjZlnNmZ5a6AQ--.63178S2;
	Thu, 20 Jun 2024 10:41:30 +0800 (CST)
Message-ID: <e329fdce-8c2f-4bc2-88e1-b079ec382eef@huaweicloud.com>
Date: Thu, 20 Jun 2024 10:41:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, arm64: inline bpf_get_current_task/_btf() helpers
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
References: <20240619131334.4297-1-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240619131334.4297-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXCgjZlnNmZ5a6AQ--.63178S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fZw1fZr4rKF1rCryDKFg_yoW8Zw17pw
	s3CrsIk3yqq34jgay7Jw4DZr1Ykw4kJ3y3KFy5K3y0kayFvry5Gw15Kw4fCFZ5Ary0qa13
	Z39F9FsYkw1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/19/2024 9:13 PM, Puranjay Mohan wrote:
> On ARM64, the pointer to task_struct is always available in the sp_el0
> register and therefore the calls to bpf_get_current_task() and
> bpf_get_current_task_btf() can be inlined into a single MRS instruction.
> 
> Here is the difference before and after this change:
> 
> Before:
> 
> ; struct task_struct *task = bpf_get_current_task_btf();
>    54:   mov     x10, #0xffffffffffff7978        // #-34440
>    58:   movk    x10, #0x802b, lsl #16
>    5c:   movk    x10, #0x8000, lsl #32
>    60:   blr     x10          -------------->    0xffff8000802b7978 <+0>:     mrs     x0, sp_el0
>    64:   add     x7, x0, #0x0 <--------------    0xffff8000802b797c <+4>:     ret
> 
> After:
> 
> ; struct task_struct *task = bpf_get_current_task_btf();
>    54:   mrs     x7, sp_el0
> 
> This shows around 1% performance improvement in artificial microbenchmark.
>

I think it would be better if more detailed data could be provided.

> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 720336d28856..b838dab3bd26 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1244,6 +1244,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   			break;
>   		}
>   
> +		/* Implement helper call to bpf_get_current_task/_btf() inline */
> +		if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
> +					   insn->imm == BPF_FUNC_get_current_task_btf)) {
> +			emit(A64_MRS_SP_EL0(r0), ctx);
> +			break;
> +		}
> +
>   		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
>   					    &func_addr, &func_addr_fixed);
>   		if (ret < 0)
> @@ -2581,6 +2588,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
>   {
>   	switch (imm) {
>   	case BPF_FUNC_get_smp_processor_id:
> +	case BPF_FUNC_get_current_task:
> +	case BPF_FUNC_get_current_task_btf:
>   		return true;
>   	default:
>   		return false;

Acked-by: Xu Kuohai <xukuohai@huawei.com>



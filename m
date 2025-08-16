Return-Path: <bpf+bounces-65805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA502B289A2
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 03:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF933B1053
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D86169AD2;
	Sat, 16 Aug 2025 01:31:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FF33993;
	Sat, 16 Aug 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307865; cv=none; b=IxCMAHSZ25g9bu9Vp3sx3jMGvz+A5KcYgO+ZfW9UtQOBdlMrJg9y+jYOeCt8ine/K4CqRITrihsI9+LMgOaz1EKD6FnhyUDyi/BglRYsl8EKMoaxo+oNizdllIzLh3L6T6aaKfLGaApfTZ7xc9DEWRzstje0GtKGkgkV3/+RIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307865; c=relaxed/simple;
	bh=UkTYxZdXAU2D6+3HUsLzb6XAiMzEMUOi09A73MBkkiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t4ATqiha1PYPnldGFVoMK5DIPHar/eGRXY2kX9oXAxdJ/HMVs6COwUVDKijTSMF7b4sUkD7EWshxPVQEnaaK/jhSrT30UWuCkWKGuT5OD1lMKgsI48mm50Debd0guGIMR75xF6Yz98opByS2S6udY/mxrg+c0RicNBb6XCgCpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c3hKT5bsCz2dMMZ;
	Sat, 16 Aug 2025 09:31:57 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E357140145;
	Sat, 16 Aug 2025 09:30:53 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 09:30:52 +0800
Message-ID: <deec25f9-9e58-4650-8920-eddd9995c28b@huawei.com>
Date: Sat, 16 Aug 2025 09:30:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv, bpf: use lw when reading int cpu in
 bpf_get_smp_processor_id
Content-Language: en-US
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	<bpf@vger.kernel.org>
CC: <stable@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
 <20250812090256.757273-4-rkrcmar@ventanamicro.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250812090256.757273-4-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/8/12 17:02, Radim Krčmář wrote:
> emit_ld is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
> The struct currently has a hole after cpu, so little endian accesses
> seemed fine.
> 
> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 6e1554d89681..9883a55d61b5 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1763,7 +1763,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		 */
>   		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
>   			/* Load current CPU number in R0 */
> -			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
> +			emit_lw(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
>   				RV_REG_TP, ctx);
>   			break;
>   		}

Reviewed-by: Pu Lehui <pulehui@huawei.com>


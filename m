Return-Path: <bpf+bounces-29915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56768C8158
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700972824AE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60628171C8;
	Fri, 17 May 2024 07:24:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA4171CD;
	Fri, 17 May 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930653; cv=none; b=u92WELbgzsEeXCVgxl48+bxkeUjk8DLja1ZrWoGB9jGG4eF4R3Ln0ATMpM4TqSwdkjCQZqmpAh0ybyI16HnBr71/61Qhnv96Oco/+YMjmyf3vHAzvTrslvqQ8RcmXWYTfCBrYvHX+wnT7/P7okisIMBeqXu2Ks9odQrKPnPVO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930653; c=relaxed/simple;
	bh=odoNGMu/3qS2xPrQSQQ2G3rCOTGco2UvLrGeYTCz0P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C/HkceSlR6MYecTLy6MYO17w8xVkSN6GS0E1HnBckzc5Up4Wl4yhsGhi0ya7GnB5FbqYvvtbp6GLYo5s1S949l6yGd3YrY5iRe/oOMT/uhDHoFufYZ5x7xprd0kfOjtzPIiJFMdWQCgqO3eNDnQ4BRLv+W24vhvjeuxAJUpZh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VgdfK1Xmzz1j55s;
	Fri, 17 May 2024 15:20:41 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CCBA1A016C;
	Fri, 17 May 2024 15:24:05 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 15:24:04 +0800
Message-ID: <3d7bca4f-492a-46cb-b65f-0bf14da97bb2@huawei.com>
Date: Fri, 17 May 2024 15:24:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv, bpf: Optimize zextw insn with Zba extension
Content-Language: en-US
To: Xiao Wang <xiao.w.wang@intel.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<luke.r.nels@gmail.com>, <xi.wang@gmail.com>, <bjorn@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <haicheng.li@intel.com>, <conor@kernel.org>,
	<ben.dooks@codethink.co.uk>, <ajones@ventanamicro.com>
References: <20240516090430.493122-1-xiao.w.wang@intel.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240516090430.493122-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2024/5/16 17:04, Xiao Wang wrote:
> The Zba extension provides add.uw insn which can be used to implement
> zext.w with rs2 set as ZERO.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
> v3:
> * Remove the Kconfig dependencies on TOOLCHAIN_HAS_ZBA and
>    RISCV_ALTERNATIVE. (Andrew)
> v2:
> * Add Zba description in the Kconfig. (Lehui)
> * Reword the Kconfig help message to make it clearer. (Conor)
> ---
>   arch/riscv/Kconfig       | 12 ++++++++++++
>   arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..b64d55dc929f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -601,6 +601,18 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
>   	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
>   	depends on AS_HAS_OPTION_ARCH
>   
> +config RISCV_ISA_ZBA
> +	bool "Zba extension support for bit manipulation instructions"
> +	default y
> +	help
> +	   Add support for enabling optimisations in the kernel when the Zba
> +	   extension is detected at boot.
> +
> +	   The Zba extension provides instructions to accelerate the generation
> +	   of addresses that index into arrays of basic data types.
> +
> +	   If you don't know what to do here, say Y.
> +
>   config RISCV_ISA_ZBB
>   	bool "Zbb extension support for bit manipulation instructions"
>   	depends on TOOLCHAIN_HAS_ZBB
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index f4b6b3b9edda..18a7885ba95e 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>   	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>   }
>   
> +static inline bool rvzba_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBA) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBA);
> +}
> +
>   static inline bool rvzbb_enabled(void)
>   {
>   	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> @@ -937,6 +942,14 @@ static inline u16 rvc_sdsp(u32 imm9, u8 rs2)
>   	return rv_css_insn(0x7, imm, rs2, 0x2);
>   }
>   
> +/* RV64-only ZBA instructions. */
> +
> +static inline u32 rvzba_zextw(u8 rd, u8 rs1)
> +{
> +	/* add.uw rd, rs1, ZERO */
> +	return rv_r_insn(0x04, RV_REG_ZERO, rs1, 0, rd, 0x3b);
> +}
> +
>   #endif /* __riscv_xlen == 64 */
>   
>   /* Helper functions that emit RVC instructions when possible. */
> @@ -1159,6 +1172,11 @@ static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
>   
>   static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
>   {
> +	if (rvzba_enabled()) {
> +		emit(rvzba_zextw(rd, rs), ctx);
> +		return;
> +	}
> +
>   	emit_slli(rd, rs, 32, ctx);
>   	emit_srli(rd, rd, 32, ctx);
>   }
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>


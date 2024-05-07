Return-Path: <bpf+bounces-28815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C58BE278
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBB1F22B8B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534415B155;
	Tue,  7 May 2024 12:47:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF913158D9A;
	Tue,  7 May 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086042; cv=none; b=NTITYmpDxCpLqs/iEyWUD/fArh/BfexX22yYhxB+edJP6ql2nhElkMRF8elqUAypTXGO5xGD0uFfLM0/hTVQTS5Xs6M16PS89c1Jog5XIdo4YJ2vM0dXIcvVz169qx8tD1sYSUI03C6xNru7vFKMSUiu2zNd97U8u7yJq4NOSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086042; c=relaxed/simple;
	bh=GKhXYVZz0pG3Da+o3ocD9EU+yf7bVkGor/Rs5rLaM4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IZcZQwLYvUDeI+2KhhZvlCNrhHMcn26GtPUCPADERkeBPjYLGyc5gr8f3AoFihbrlxPzJGzDC2meSqvgwE53j3dKiRHosDPzCMWYyvcG/+9jeAaM4BFv/7ZsCi8NW5shs8n9F/9H/WOyGBa+YSmNdbueUgJdKyfHahXG0VttwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYdHM1fVJzYmKg;
	Tue,  7 May 2024 20:43:27 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 89DE2180065;
	Tue,  7 May 2024 20:47:16 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 20:47:15 +0800
Message-ID: <6836eb5c-f135-4e58-987b-987ab446b27c@huawei.com>
Date: Tue, 7 May 2024 20:47:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
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
References: <20240507104528.435980-1-xiao.w.wang@intel.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240507104528.435980-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/5/7 18:45, Xiao Wang wrote:
> The Zba extension provides add.uw insn which can be used to implement
> zext.w with rs2 set as ZERO.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/Kconfig       | 19 +++++++++++++++++++
>   arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..0679127cc0ea 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
>   	  preemption. Enabling this config will result in higher memory
>   	  consumption due to the allocation of per-task's kernel Vector context.
>   
> +config TOOLCHAIN_HAS_ZBA
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on AS_HAS_OPTION_ARCH
> +
>   config TOOLCHAIN_HAS_ZBB
>   	bool
>   	default y
> @@ -601,6 +609,17 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
>   	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
>   	depends on AS_HAS_OPTION_ARCH
>   
> +config RISCV_ISA_ZBA
> +	bool "Zba extension support for bit manipulation instructions"
> +	depends on TOOLCHAIN_HAS_ZBA
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZBA
> +	   extension (address generation acceleration) and enable its usage.

It would be better to add Zba's function description like Zbb.

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

Looks good to me. It seems that Zba has fewer uses in rv64 bpf jit.

> +
>   	emit_slli(rd, rs, 32, ctx);
>   	emit_srli(rd, rd, 32, ctx);
>   }


Return-Path: <bpf+bounces-55849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65874A87CA0
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DA172BDE
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D72673A3;
	Mon, 14 Apr 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="TdfLlrUB"
X-Original-To: bpf@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011020.outbound.protection.outlook.com [52.101.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DE1AF0C7;
	Mon, 14 Apr 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624754; cv=fail; b=VdJXM9oOwnvpfJO4MFKgyNdRrXPCyvPLdAaxUZi8rj96Y1YIo/6AbRJWqjjnIAcEGz/k4gAxbtcDex4iedG0mJXh3JyYq2F2lUVoQ2GJ4JozzEq0Lpcni5NT36WVdOhIBzrslKujY0j0ouW0JzslH45lV7kfrJnG4gnbwNq0JKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624754; c=relaxed/simple;
	bh=WRl5bNnpBudpVqldym05+PRM1qryZJJ4i9XAuo/2slo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUs5C0kJ3n4FUTF4+Bt0gf8mdo0GPSgjy16xEmcGftlXpADJcOGswNyMmiO5UZz/0EPMdivXgbT6xBP8CuWRG0G6Qr7fS1dW0FdbDJoBbuOKr0ssm0otSIN6NZJVh+FvBcy/BSFz3eGpiME3eb+oZNy147LoleH7pMXQCOpWrlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=TdfLlrUB; arc=fail smtp.client-ip=52.101.129.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDvGSX8efv8D4UaQxlR27WXfJJbCiXQk7HXfjEVXyzPqzs//MyWJK1Vhz/Z4mFs5AFJ6B2hD65tTKHxdqqgq2S/COZOOJ98b4hDULv/DdPrSDuXdYL9jKTK0dfQfqIawGTw2qKct6RtgolZvBi3R6gRESI3M/i7Jo5mRAOnKddv3rifwrn1eorMM6eIkp4bCEC72CclyBy0zZya9JCNkgjrNDP+Jnfd0IOx7s5C4J4ALWDh66ryjTneVyZdnyIsZY+yh2gYCWoTIAbr3tObhaFkwZbXq5yhnc918zL65J6vl3wR0fy/VHC1znVMxpLBydePvfPqqDIf8lhww+yBBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOXr1eEY5TU6O5Ym6JE6bY+USqOFX4YOjRn6m0UbaKQ=;
 b=YCY0a/Epio6Z984S5LwVBhLJIArJnD0qkJUav8nXE/HCYJKHQaB7LShtlodC78nVXVvvK6SNfpm1l01rTySFuNpjzExGOxkGPDMgqdro3zvFofui/C6RbVQo4ugCRFIX3EBybSIG4NMUUDPiPPK6nISmrMUx60HXQE7WrO9hJxeNFFG0GZuiZFWw6UM0PmKBSr1oEvRznJdljhJyzqaAYMsazShn7QTWz/91S39ev7bZ/eKT+NNy+WSVqwn4HDR3UhtfVVQoyYfrQUwsJwOOrzQGsUzKr3zJbRDLXljDdQ+DN2TYean5nZg1KL4hv2ll4xdR9zPBildsInhfS29VBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOXr1eEY5TU6O5Ym6JE6bY+USqOFX4YOjRn6m0UbaKQ=;
 b=TdfLlrUBVUSWiCbhua1VF94vnc07JQdnyGiiszhFcDmfbc93tI3QYt6Na0R04MtiPOUaDnApSVrr8LcG/6bqxdD3HUdP5kx/qNkukZVKk/qzS1z02onaDMFDWE8aGfsiQuBixHk0e+6l0HDgOuKPZuykegjQ3SEflr2iHOooMFM=
Received: from SI1PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:1f6::16)
 by PS1PPFEB36B4825.apcprd02.prod.outlook.com (2603:1096:308::2b0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.16; Mon, 14 Apr
 2025 09:59:06 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::ad) by SI1PR02CA0045.outlook.office365.com
 (2603:1096:4:1f6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 09:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 09:59:05 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 17:59:02 +0800
From: Dao Huang <huangdao1@oppo.com>
To: <samitolvanen@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<catalin.marinas@arm.com>, <daniel@iogearbox.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<mark.rutland@arm.com>, <mbland@motorola.com>, <puranjay12@gmail.com>,
	<will@kernel.org>
Subject: Re: [PATCH bpf-next v8 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
Date: Mon, 14 Apr 2025 17:58:32 +0800
Message-ID: <1744624712-472774-1-git-send-email-huangdao1@oppo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20250310222942.1988975-6-samitolvanen@google.com>
References: <20250310222942.1988975-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|PS1PPFEB36B4825:EE_
X-MS-Office365-Filtering-Correlation-Id: c47ccdf5-1fd2-4554-512c-08dd7b3afdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1ugjyEjE11c/adXDMb/Tz3fAjIRO+0DviyHct3M/67oBi4KIw5fir32yuBF?=
 =?us-ascii?Q?cDNSFIwxV20CggVX/fl7C5UpWX/iRgdf6dpo0QP+jf5cQkLfBPjXPGhurv25?=
 =?us-ascii?Q?W5XtUcG+VcbvQqvK6l87AC0PN5GanJrNhIQrc9Eh40VrdQm505nSTMB3U/C6?=
 =?us-ascii?Q?xjEiMCU6Y8weSdPPtZuNutXDXlweaCFKGanZdphMVsy/nZmsBORCtdo4xti4?=
 =?us-ascii?Q?NjQPzP6W3oS97A0RwVfFQCk5PCaende+zlIJAGN1GfDmwW/SCN5stOd3ebX4?=
 =?us-ascii?Q?tdflPx1bznM+pJcwO9l/Zj+QB3PtgcXW07xHWDdTn3AKyltM1ATnN0Q+U3dT?=
 =?us-ascii?Q?14S3tpENZOm7JrxY3qekRFy0gS1qzQkvpL54xcd3/zMlEBKlvGvEXTOi+tiW?=
 =?us-ascii?Q?6EmmKpvB2t14WPtla7bU4odBK66H8SQ8989jDSlKwxtfC46BfLlorQnKkiL2?=
 =?us-ascii?Q?b+AhbJlK/wPvqd6Id1Yqjsh19YyeEQYlDEvHrTnHp0jRxomFvpNWxQCki9TC?=
 =?us-ascii?Q?XLJYczaVcmWURlM1TQxGQZ291WbXIEBqDG+gQCKJRon27ypywMFwPUf8YuSg?=
 =?us-ascii?Q?bx2m4aC9yHE0hcTKp9KQhZHYMJSEClU/b1e9pWu5uqo1ptgAZtXAr1E7gN7r?=
 =?us-ascii?Q?G7uYjtrJ0h6e/oyJ77kt/8ssAvIX3w2IG1Qdv9H8qEDJLaC+K+P5e21hjxOe?=
 =?us-ascii?Q?TjDToAIZaKm9TKWYyfKhH1csV92fIJLJD4yEL1V8qmuZX2V4c/uQf5KO6471?=
 =?us-ascii?Q?DF0+KettsBwLL7B35WVVCYtgoAREvvPUJupo7Zlb0OJSofTZk7GFhv8Wl3mr?=
 =?us-ascii?Q?83ro0L2gA9lsSUWmuAv1rJgSGL+Yw6WR/k0u1IgFDrohodrcENuqeD3mUPv4?=
 =?us-ascii?Q?ZU5i635ugihTkxl+z4GbIPaPC/oC9SOK4S6ZzQExjkp4Fay5WuokEnuzY2SU?=
 =?us-ascii?Q?kymjnRRjxur0qQRMuIWsYMSg/HEL8lD34AmvujRWc4ow5SkpseEmaOG6mGk5?=
 =?us-ascii?Q?3HKmzUlrAqJk1OFtGbvy0OL39WQ21s8kOwEUQFyBaB3uCEPsz1I45iXpOq6L?=
 =?us-ascii?Q?f2rPPnpMKxcPQvIVslqiVykLjs6CvoJ//LjnwijNih9adTksf7+KxWTXYeJ9?=
 =?us-ascii?Q?5Cme7gwDi0bce7+zSOILWy13UyBKF17yPP5Zp3U0S7KOEztcyyJ88ATBgrvl?=
 =?us-ascii?Q?3UaFLIXAfB8GQqKNIKHJWpoylLmFV/z9a9Mq2baFcOBTfXrbTObO07hmPI24?=
 =?us-ascii?Q?NNIROzFFJuSmUgPHSWtRpaS9IBgO1G+n8yKBS3v8p17bR15dkK9lxP9iVXyq?=
 =?us-ascii?Q?IY93uOhjCgx5LVp/DW3z86GJMsgo7i0yRPeZI8wrmWe0TAwnQXL0tGZ1uXG7?=
 =?us-ascii?Q?P2e64tiJ2Z5gwP7Iu+6WOp5L9zWbxFekPXBTJlEjHz+cJdLGedn8zfM7C1ZQ?=
 =?us-ascii?Q?dVjUGJEZLkU9DqPhmDCxQASDxsGBPIL0TSr+NI+UPHg00n2ezNDApP4R4yyU?=
 =?us-ascii?Q?1QwIQ6b6o5UpRZ42fmhpWfwpQ4rR9g/D5S4o?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:59:05.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ccdf5-1fd2-4554-512c-08dd7b3afdfb
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFEB36B4825

> From: Puranjay Mohan <puranjay12@gmail.com>
> 
> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> calling BPF programs from this interface doesn't cause CFI warnings.
> 
> When BPF programs are called directly from C: from BPF helpers or
> struct_ops, CFI warnings are generated.
> 
> Implement proper CFI prologues for the BPF programs and callbacks and
> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> prologue when a struct_ops trampoline is being prepared.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Co-Developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-Developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/cfi.h    | 23 +++++++++++++++++++++++
>  arch/arm64/kernel/alternative.c | 25 +++++++++++++++++++++++++
>  arch/arm64/net/bpf_jit_comp.c   | 22 +++++++++++++++++++---
>  3 files changed, 67 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cfi.h
> 
> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
> new file mode 100644
> index 000000000000..670e191f8628
> --- /dev/null
> +++ b/arch/arm64/include/asm/cfi.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CFI_H
> +#define _ASM_ARM64_CFI_H
> +
> +#ifdef CONFIG_CFI_CLANG
> +#define __bpfcall
> +static inline int cfi_get_offset(void)
> +{
> +	return 4;
> +}
> +#define cfi_get_offset cfi_get_offset
> +extern u32 cfi_bpf_hash;
> +extern u32 cfi_bpf_subprog_hash;
> +extern u32 cfi_get_func_hash(void *func);
> +#else
> +#define cfi_bpf_hash 0U
> +#define cfi_bpf_subprog_hash 0U
> +static inline u32 cfi_get_func_hash(void *func)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_CFI_CLANG */
> +#endif /* _ASM_ARM64_CFI_H */
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 8ff6610af496..71c153488dad 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -8,11 +8,13 @@
>  
>  #define pr_fmt(fmt) "alternatives: " fmt
>  
> +#include <linux/cfi_types.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
>  #include <linux/elf.h>
>  #include <asm/cacheflush.h>
>  #include <asm/alternative.h>
> +#include <asm/cfi.h>
>  #include <asm/cpufeature.h>
>  #include <asm/insn.h>
>  #include <asm/module.h>
> @@ -298,3 +300,26 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
>  		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
>  }
>  EXPORT_SYMBOL(alt_cb_patch_nops);
> +
> +#ifdef CONFIG_CFI_CLANG
> +struct bpf_insn;
> +
> +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
> +extern unsigned int __bpf_prog_runX(const void *ctx,
> +				    const struct bpf_insn *insn);
> +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
> +
> +/* Must match bpf_callback_t */
> +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
> +
> +u32 cfi_get_func_hash(void *func)
> +{
> +	u32 hash;
> +
> +	if (get_kernel_nofault(hash, func - cfi_get_offset()))
> +		return 0;
> +
> +	return hash;
> +}
> +#endif /* CONFIG_CFI_CLANG */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 70d7c89d3ac9..8870c205f934 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -17,6 +17,7 @@
>  #include <asm/asm-extable.h>
>  #include <asm/byteorder.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cfi.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
>  #include <asm/text-patching.h>
> @@ -164,6 +165,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>  		emit(insn, ctx);
>  }
>  
> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
> +		emit(hash, ctx);
> +}
> +
>  /*
>   * Kernel addresses in the vmalloc space use at most 48 bits, and the
>   * remaining bits are guaranteed to be 0x1. So we can compose the address
> @@ -474,7 +481,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>  	const bool is_main_prog = !bpf_is_subprog(prog);
>  	const u8 fp = bpf2a64[BPF_REG_FP];
>  	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> -	const int idx0 = ctx->idx;
>  	int cur_offset;
>  
>  	/*
> @@ -500,6 +506,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>  	 *
>  	 */
>  
> +	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
> +	const int idx0 = ctx->idx;
> +
>  	/* bpf function may be invoked by 3 instruction types:
>  	 * 1. bl, attached via freplace to bpf prog via short jump
>  	 * 2. br, attached via freplace to bpf prog via long jump
> @@ -2009,9 +2018,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		jit_data->ro_header = ro_header;
>  	}
>  
> -	prog->bpf_func = (void *)ctx.ro_image;
> +	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
>  	prog->jited = 1;
> -	prog->jited_len = prog_size;
> +	prog->jited_len = prog_size - cfi_get_offset();
>  
>  	if (!prog->is_func || extra_pass) {
>  		int i;
> @@ -2271,6 +2280,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  	/* return address locates above FP */
>  	retaddr_off = stack_size + 8;
>  
> +	if (flags & BPF_TRAMP_F_INDIRECT) {
> +		/*
> +		 * Indirect call for bpf_struct_ops
> +		 */
> +		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
> +	}
>  	/* bpf trampoline may be invoked by 3 instruction types:
>  	 * 1. bl, attached to bpf prog or kernel function via short jump
>  	 * 2. br, attached to bpf prog or kernel function via long jump
> @@ -2790,6 +2805,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  					   sizeof(jit_data->header->size));
>  			kfree(jit_data);
>  		}
> +		prog->bpf_func -= cfi_get_offset();
>  		hdr = bpf_jit_binary_pack_hdr(prog);
>  		bpf_jit_binary_pack_free(hdr, NULL);
>  		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog

we oppo team have tested this patch on Mediatek DX-5(arm64)
with a kernel based on android-16(kernel-6.12). It has been running
fine for a week on both machines.


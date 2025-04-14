Return-Path: <bpf+bounces-55848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05AA87C80
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C37A1883927
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83098269B13;
	Mon, 14 Apr 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="ntLrKfku"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05D269AE8;
	Mon, 14 Apr 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624453; cv=fail; b=ETRjCOgJNhmki1xyVIkg6BBGIxO/76oLHgsc9DceGfE1THrvtm9GfrH+vGaqMd07jUJYPrQuZ9M6r1HUxrMwvb7dqmKFyKPS0mg7jEYPXXnjtyLAFu2DTwTz/6vOV+EaOSjiQoMbnqgRMnM6kTxjKtSBOLgeOFSprmFQrG1QWW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624453; c=relaxed/simple;
	bh=Uauk3EXYiIdp0b7lcfLckmi9M2hKivWJdhHphy20Nqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXSD1bP7TDcffkcppLR+DFiLXISD2l/VgmpoTIbfBd+t4jMReHJ/AFsuUVRDlIJXTXs+d8mn08DLPSuv5nAkkQ17IHN6gknfa+tcLl47W6x0u3RTPF7/6REMDqxoutvF4WFRCr9L0bd5ucc1gpcPtcqBrdR77bpPAHOSsn6aBhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=ntLrKfku; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfy2DhIaQ6PsRDsvEGdRpz/AAxlWWqMyEMZVcMVk03wuLyD7H2PmLGqVO93PArgJb/FKUalxsg4XQ9Xl45oM9cM6oDzvXJaXtxkSPFhqItNJa62LyRQ0Bch4ClMFMCIekZH3k4VhTRNCjoVrFODy5rmCcBJzqpkmJJMnAq6rG/PdF4mOtvqJA9k+rKdsWerYJ89kqJeMjMyjtOtlTprG6A2y163NUFnsO9aM9YBJHytOk6odRSDVwuV6MauKsbNgeO8eKQsc6zHlWjGXUMZnFdjObVLsyW4TJeuP1XgVBIaf6BqY1IEEJVYfWp0Ux6tBmCrhlJOdIoSW8qxAXGa1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWBimcmlCJhaiI1vYrzUYSndzBVtyFZ5dAIyLYnTAHk=;
 b=h+p3uZeLETlNMih/926RURXsRfQmltt4uK0ljIMaa7t3uED5WRqrUdd49asVWUfTdlXPv7o5bCYd/pPxF5DzodJAIqG4j1aqQbO8WZ+ajZ/XO3fqwPHZoBdM7ywnAL/qsiRR5KWMXqBg1lvVuElyfjBqkwAdmvi4WjSVJasNAbOFDO6YOoMXa0l3UBtmVYQFtyil9GP22MxHoVD/qkYi02UpyVq/DB9CgRV9dAV5685Ug3fULWL/azcvnnsKBNwVh74nKLtZTSy0yzoiQxiW8kb2QCZQrGRHIKWX0/3j6lNCUGoWQ84KAWEAsS6u48SOIxQaQVpGJY7qgJAVmrD/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWBimcmlCJhaiI1vYrzUYSndzBVtyFZ5dAIyLYnTAHk=;
 b=ntLrKfku3mKdj8/qnHOIfjpfi3MV0/eZU1+oZDgtLOtS23ffWmV80lR7E9xreMWqCC21VK1NH76KiYryn0+z4WC6yT6gKkn8hbba0bXHveB4O6TedF38tCPH4VFRMrax6VQ8mzvew0PkJXQvSWGFQP0jfozV62cHAUZaRVOh4TM=
Received: from SL2P216CA0159.KORP216.PROD.OUTLOOK.COM (2603:1096:101:35::10)
 by SEZPR02MB5496.apcprd02.prod.outlook.com (2603:1096:101:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.14; Mon, 14 Apr
 2025 09:54:03 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:101:35:cafe::95) by SL2P216CA0159.outlook.office365.com
 (2603:1096:101:35::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 09:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 09:54:03 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 17:54:01 +0800
From: Dao Huang <huangdao1@oppo.com>
To: <samitolvanen@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<catalin.marinas@arm.com>, <daniel@iogearbox.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<mark.rutland@arm.com>, <mbland@motorola.com>, <puranjay12@gmail.com>,
	<will@kernel.org>
Subject: Re: [PATCH bpf-next v8 1/2] cfi: add C CFI type macro
Date: Mon, 14 Apr 2025 17:53:30 +0800
Message-ID: <1744624410-471661-1-git-send-email-huangdao1@oppo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20250310222942.1988975-5-samitolvanen@google.com>
References: <20250310222942.1988975-5-samitolvanen@google.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|SEZPR02MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f47e0e-e1f2-4f39-c920-08dd7b3a49d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSJcZMj/lXl78rdEWpxzVohLAaMq6wiqPlFowfk3b+0lQm5RP3rR9k2myRM3?=
 =?us-ascii?Q?4VPbDf0WQGMMYE5PVxX2BMsqBlT1akBK7hlZmJF7o+A8tjj7GROXy/iyWGd4?=
 =?us-ascii?Q?VfzOixQRgvjdM1rfpL7WKb+6HdwDS9Dw6BTfRS8jzCAWnARfkxva5iUQ9hm+?=
 =?us-ascii?Q?tkTEAoncBNbolrk66UsUY6/cu3yETaTexQpTSz+GxPaPV50hcM4boNhOoZvQ?=
 =?us-ascii?Q?ShxmRTZdrF6FhJrp2W9RftIbEcvDJnlL4JkKF18jb7e1fgDeGnu1ziaAgjLp?=
 =?us-ascii?Q?nqM1keGtXyRKft0rGqiOC2XosA2UearAQ1byB18cPND0FBgrMVjcF2fshjJc?=
 =?us-ascii?Q?IApOt2IjPEC7glnPZ+6/t+n1Eus9X/Y1e4TPpAqlNjaSwnC7uBeV+VOszDDo?=
 =?us-ascii?Q?jvyEISJFnClLlK8ms4V2meSYzzDAXbjXy5L6aX9TWnngnVdn179wnZHVwvBy?=
 =?us-ascii?Q?Cx2jUlbJgGQkSJIFY2AoBHzta+/3S5gabKBUF/bhEdNpzmd5N0vLbWH12wH8?=
 =?us-ascii?Q?EY8NldKSEwQ7qBBL5B8c73aK85iBFuteDxN+DRpm6pC8ZtIynwkZnZI5g1YS?=
 =?us-ascii?Q?tjYhjHYuAsxFiyJeb++JD20V9gNk6Y6p40pXq0jIyAkaIPeT+wpwfAdYLVA+?=
 =?us-ascii?Q?9Xw85WGu2Bdr8zX/UfKf5IBN+ZcNc8ldwekZs8bWFgO05g+GzxfhBXlzs1eH?=
 =?us-ascii?Q?ECGjVc6mp/Om7wPkqVoih+n4M96Knk/eRTdV6rRfvNFRb5Ld3b2mJ5J6XqvW?=
 =?us-ascii?Q?qkp0jv0W41Jbv8eiLJ1SFcfCEqKSg7tdz31xbCldyBqymBC7nZjKNx+qBAA7?=
 =?us-ascii?Q?g2s2rtuZeVN0ps8tx8SuTeJNZHmeHeghEdMxqHmqldyEhAcZ/Vm7zdWRKoI3?=
 =?us-ascii?Q?3uMBGYnYgYB3EzplLivI/9dEexefQrZMG44bklWcTIuGPDEL0RElBofuyMMS?=
 =?us-ascii?Q?DjDm3RtUtIXtIVCN7Wiu1DeuzsG+4j8PFdTIN/5xuGfkN7E944Qr5Bx9tHvZ?=
 =?us-ascii?Q?THI4WGsGFAFhgcDnqMo0AmdX66JSdtYrLF8cUQGBm1W7rb1TF3C0k6Bcd9G3?=
 =?us-ascii?Q?KnzEdtPwNvZ5I104vBUsbwYiScYE+gTx0f4Hec6mJnMVLFI8y6cNo78agi2x?=
 =?us-ascii?Q?Yr3ALDPWMjbzGuyKEKFuiLqHGdrZuayPKVXY6B2uSUmFpqmx+j5/GcUnyY0W?=
 =?us-ascii?Q?al6Qc79zc5EVV0wFlHDfcKLeOBepBTiUK+ThRlBNm3EvPmt9aeIqugE46EyB?=
 =?us-ascii?Q?KX96zq1DZXIiOtDlXfNfV+GHl8dMA/e5Lga0j9fPvQ2CYGD9EXLjeScssa0B?=
 =?us-ascii?Q?JnX2iwPhB5shDqygn9eecWz39NC/tmyrxKa4HheUGUDymV5rG3yf/z315jet?=
 =?us-ascii?Q?GSRydkmxzm9P3om19n19k+U/DPxD1LSno3A+jYyX1F39zd4Z+Yo9yzvgu38k?=
 =?us-ascii?Q?DavaKbmuqzyT2UJPIZkSLUrK09l3E5FUQ/NZQSzgz1J7EzvQLUtz9yVaV108?=
 =?us-ascii?Q?mK0y6DRMH2J58DWex9favYuCe0dJzNZ64ELs?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:54:03.1695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f47e0e-e1f2-4f39-c920-08dd7b3a49d3
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5496

> From: Mark Rutland <mark.rutland@arm.com>
> 
> Currently x86 and riscv open-code 4 instances of the same logic to
> define a u32 variable with the KCFI typeid of a given function.
> 
> Replace the duplicate logic with a common macro.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Co-Developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-Developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/riscv/kernel/cfi.c       | 35 +++--------------------------------
>  arch/x86/kernel/alternative.c | 35 +++--------------------------------
>  include/linux/cfi_types.h     | 23 +++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
> index 64bdd3e1ab8c..e7aec5f36dd5 100644
> --- a/arch/riscv/kernel/cfi.c
> +++ b/arch/riscv/kernel/cfi.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2023 Google LLC
>   */
> +#include <linux/cfi_types.h>
>  #include <linux/cfi.h>
>  #include <asm/insn.h>
>  
> @@ -82,41 +83,11 @@ struct bpf_insn;
>  /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
>  extern unsigned int __bpf_prog_runX(const void *ctx,
>  				    const struct bpf_insn *insn);
> -
> -/*
> - * Force a reference to the external symbol so the compiler generates
> - * __kcfi_typid.
> - */
> -__ADDRESSABLE(__bpf_prog_runX);
> -
> -/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
> -asm (
> -"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> -"	.type	cfi_bpf_hash,@object				\n"
> -"	.globl	cfi_bpf_hash					\n"
> -"	.p2align	2, 0x0					\n"
> -"cfi_bpf_hash:							\n"
> -"	.word	__kcfi_typeid___bpf_prog_runX			\n"
> -"	.size	cfi_bpf_hash, 4					\n"
> -"	.popsection						\n"
> -);
> +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
>  
>  /* Must match bpf_callback_t */
>  extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> -
> -__ADDRESSABLE(__bpf_callback_fn);
> -
> -/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
> -asm (
> -"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> -"	.type	cfi_bpf_subprog_hash,@object			\n"
> -"	.globl	cfi_bpf_subprog_hash				\n"
> -"	.p2align	2, 0x0					\n"
> -"cfi_bpf_subprog_hash:						\n"
> -"	.word	__kcfi_typeid___bpf_callback_fn			\n"
> -"	.size	cfi_bpf_subprog_hash, 4				\n"
> -"	.popsection						\n"
> -);
> +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
>  
>  u32 cfi_get_func_hash(void *func)
>  {
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index c71b575bf229..a9f415e873dd 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #define pr_fmt(fmt) "SMP alternatives: " fmt
>  
> +#include <linux/cfi_types.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/perf_event.h>
> @@ -934,41 +935,11 @@ struct bpf_insn;
>  /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
>  extern unsigned int __bpf_prog_runX(const void *ctx,
>  				    const struct bpf_insn *insn);
> -
> -/*
> - * Force a reference to the external symbol so the compiler generates
> - * __kcfi_typid.
> - */
> -__ADDRESSABLE(__bpf_prog_runX);
> -
> -/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
> -asm (
> -"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> -"	.type	cfi_bpf_hash,@object				\n"
> -"	.globl	cfi_bpf_hash					\n"
> -"	.p2align	2, 0x0					\n"
> -"cfi_bpf_hash:							\n"
> -"	.long	__kcfi_typeid___bpf_prog_runX			\n"
> -"	.size	cfi_bpf_hash, 4					\n"
> -"	.popsection						\n"
> -);
> +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
>  
>  /* Must match bpf_callback_t */
>  extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> -
> -__ADDRESSABLE(__bpf_callback_fn);
> -
> -/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
> -asm (
> -"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> -"	.type	cfi_bpf_subprog_hash,@object			\n"
> -"	.globl	cfi_bpf_subprog_hash				\n"
> -"	.p2align	2, 0x0					\n"
> -"cfi_bpf_subprog_hash:						\n"
> -"	.long	__kcfi_typeid___bpf_callback_fn			\n"
> -"	.size	cfi_bpf_subprog_hash, 4				\n"
> -"	.popsection						\n"
> -);
> +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
>  
>  u32 cfi_get_func_hash(void *func)
>  {
> diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
> index 6b8713675765..209c8a16ac4e 100644
> --- a/include/linux/cfi_types.h
> +++ b/include/linux/cfi_types.h
> @@ -41,5 +41,28 @@
>  	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
>  #endif
>  
> +#else /* __ASSEMBLY__ */
> +
> +#ifdef CONFIG_CFI_CLANG
> +#define DEFINE_CFI_TYPE(name, func)						\
> +	/*									\
> +	 * Force a reference to the function so the compiler generates		\
> +	 * __kcfi_typeid_<func>.						\
> +	 */									\
> +	__ADDRESSABLE(func);							\
> +	/* u32 name = __kcfi_typeid_<func> */					\
> +	extern u32 name;							\
> +	asm (									\
> +	"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"	\
> +	"	.type	" #name ",@object				\n"	\
> +	"	.globl	" #name "					\n"	\
> +	"	.p2align	2, 0x0					\n"	\
> +	#name ":							\n"	\
> +	"	.4byte	__kcfi_typeid_" #func "				\n"	\
> +	"	.size	" #name ", 4					\n"	\
> +	"	.popsection						\n"	\
> +	);
> +#endif
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_CFI_TYPES_H */
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog

we oppo team have tested this patch on Mediatek DX-5(arm64)
with a kernel based on android-16(kernel-6.12). It has been running
fine for a week on both machines.


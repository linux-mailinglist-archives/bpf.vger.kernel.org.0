Return-Path: <bpf+bounces-60075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD962AD2546
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E69216DA99
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7B21C9F5;
	Mon,  9 Jun 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RmJ1DlfE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F01F19A;
	Mon,  9 Jun 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492102; cv=fail; b=VacGDY6OUQIctpLL3cZEpOkaM18Ou0Vios14FMRD/gW7LIeQY0XFZA+liMIpcqXsOy0VUnCE40h9tMFXSlkmqGCACYd7EKhHGo5iYpqQQJewA1SSncFLFrG7XAZhd/STzc0veLGBTeBtcAMXrEEEr6LYNjMT7x2rlAjKVB+Zlzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492102; c=relaxed/simple;
	bh=nVPFhhvUDPOYV6vHXi3/LwWSe65kBRaqEIY+xeA4gdY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nx3AMbOGvmf8aGGlogXq2gfmUrVXFTW1b3gNEerb3omMpcWcgZ2M3vsb+VGsystWZfoBgVeTyLZxeqX97KG1DLR4KmLG1Kb2zNcHUK7aNUUra6lWBL3HXEA8qSpwVF92fZwVaxnPYYp9R6nIPVlAPynFyCb5lFBG1p5EyRhH5Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RmJ1DlfE; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc65Gb5A0SJYKGN7O9HZY1gJyVzxieoS1z12F4/3gbxSk4Aiw0STrNPfPcZYDxuWZakjmOTKD7hd7EXHFLsTR8HzBtZMmMD+S94rEpwuue6XfvG8Tu9Juhk1voD0Gr+TslAUQ5MuCZvg0phA4OuhpgnvYpO6YbgY4+SHO7hT3A7zhPWhDqYJjicHbucJrr0aH5JRwyXGJwh4Xwl8Sf02jINZu7PlPq3QumAlW7mhnXbd3S1A0gG8VaE7u9QerwGc8ZD2AQ70PgVeSZWuhkmIsp8y6RcAzhyhwvOIVbg+Sk+dAdLx6Ch14WuPEu9wr1gvw5//2DLzN0Jl0Hmm8qSEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaIy+KJFEtwP81OlOZZyT3bxJjFww3XcWt0oOHWdhxs=;
 b=hMDXQlasyCVGpREK5U8dSjvFRGkQmmtpHQMR4/ZR4UhL45dRTY+G68CTfcCcWXvEPcyvdxoRsWPY//JaLQVc13qAKfAY+n64hXGhkFYmq51zJYJuE1luqgiDZGukf7t1hp986/ujlNU+kp0Q8sKr1bw0JhvGfnc3AoOyN55wIkeSCjCDbattjoEhG4u0hGga+O2NAYqcRwboPMFlWWaUSCdda1UnNindAIVYkscUJl4EOwmKZhcq0DSgHnsPwmXsPzvk9+zfWS0Fy4s/u1+JpdkjkjgTpiWJxK/3zwmGMNMlhqemYBcAAzmtXWrChdOfknL8PGPwnzDraoP618zYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaIy+KJFEtwP81OlOZZyT3bxJjFww3XcWt0oOHWdhxs=;
 b=RmJ1DlfEuSj2UHF47bpITNA4CJcLJIEL7cWZqdAf5O80D9Xgbx0Hid+X2tG1w0oIjtQWJmLPvqLN6RmB/5fo9wxUZ7TWyOGMYZoUra+DTwmCRGffz7WY7UpeZRj/GLLt+omsSPjQP0g2EQo+z9Js6VQbFjzme9GNDKDyNmK0FypYQmVglVyQtw/TvQTXmCmdnsC3QJMxDpSKfA/KWFxnGfo+auP6hN/7umysoK+TN4dDZBrnHSIoC0gGX6pG2tO+UceYVxoig9NNBpr7/+RpcfW4gRciI5CBGPnNuINs4ttQjPtpV0cgy+tm75x09NAdBBWNO9zRxqGuVBvMDGkT2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 18:01:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 18:01:32 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 1/2] context_tracking: Provide helper to determine if we're in IRQ
Date: Mon,  9 Jun 2025 14:01:23 -0400
Message-ID: <20250609180125.2988129-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:408:fd::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ab0787-d435-4d10-2013-08dda77faa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LMH6C+gT9dU0+WQbQeLJUYBcHfjHkHEPJ5PMkxLkxxU2H6mX5R2IGgb7V+AU?=
 =?us-ascii?Q?FH5CpoO9aY+H8w7m7JSBjt72bOVe0qyJBD+Bp7LcG76Ih0LKoOPS4ck/k4q6?=
 =?us-ascii?Q?Q+DbM2co0t25EMG9g7TO0FbeGEfkFLVxo88D/oTJzMXSFoDU6zhm5B6WzsQp?=
 =?us-ascii?Q?GHx84miuRlgC4V9oSlKzDyUnf9MTy+UsMmn1Lgi6J05CduqqrnhnDyEwFSB1?=
 =?us-ascii?Q?KEaybo/C4CJJRixNj81E3vWglm4dlHWktPDkcgRYiEK50zfI2JZjwdF0BlRq?=
 =?us-ascii?Q?FZgsM57GIvZ30dzWRGh5UhP6LQXdFdoAxSbZb1lRslru9z7ruq77fGM9CFL8?=
 =?us-ascii?Q?prFEB39FaGJ94PJnZdzybhtt/Ev47zWEg9cSsWh8/Q+kmLrTgJjKFOv+RfSy?=
 =?us-ascii?Q?zdWVbnlrxrimR0a5W2mWGugdt65i3jYS/MnJz0vT/1vsF5O8mvmvTThEwkmH?=
 =?us-ascii?Q?+QfS41OQCpHC6pgV0Kjw+rTNIdQZ6CT/uov1+ytrcX/3jeeXqLBRKTL+rAM4?=
 =?us-ascii?Q?xRMm8EH3PUTuWU4RE8CuLe5SfjP9GOpnmD6W1LHX63LZZe/bNceqe3q3jDC1?=
 =?us-ascii?Q?z/FZ6oCkPaQ4ABSfJn+T3mkGTwZABw2w12PfrHVRCKTaiju6P2rXRfe/9Axr?=
 =?us-ascii?Q?rbFbUogqoF8xMWZmuDwYDHoeNmvvSA0Y1BAgxwi3JHEgyUcToefOwF5rRuxI?=
 =?us-ascii?Q?IPA/j8JBMdlN5h5W17O/2fv5CVXKu7HamW+4t1H7ybS3OrvVPqpifj8AhdKb?=
 =?us-ascii?Q?6seMCujfq3RN7/0HDhDdAOWHn7lYcVEFIR2Qd6TPDa0beadR6c7PEQbOxn4c?=
 =?us-ascii?Q?w5YzHBcfXIAK2nTkt8MsSH4GETNS6rjIwNcKw8qcZSoXtVHQ1m7QFqoC7YWE?=
 =?us-ascii?Q?94WN0vwZ5gBcp1hOF0lpCxbsKcveGIxZAtw5KErtKSiqv5sYBItg6OIZaivN?=
 =?us-ascii?Q?iqdFB41C5dnMZKaVGfdDIObcKXeEK4Cb+56R+9CLxqYFG5JZV16LI/Irw9zC?=
 =?us-ascii?Q?rvsHHNLAkku9/gNEzmbkINgAHVPK9bA7o0kfeNJqQl2Nphxbsl+YCxuTKkIV?=
 =?us-ascii?Q?4NHQ0wbpySwuN/ANsYPLAOkOg9N/Bgi3SPO4cY7nfceDoeuisni2Zh0HlfEG?=
 =?us-ascii?Q?9gH+kHGRexF5glh8zboV6JAyv+Sv0hgacu+kvckJevxYqPvHiwEjG18erhT+?=
 =?us-ascii?Q?lxmuFNLvfleOHwaDfuceC1fqK6q1ujN/jTlK7Dxlc5Ks4+IHbeok0AbA59Hb?=
 =?us-ascii?Q?0JFNo3wXZwEWOPegYg6bWckecCVTw/9JdY0EkBqaIYDit+r0Qp136oHdAZd0?=
 =?us-ascii?Q?Cs+cTfX501kLMi0KQgVDj2z3kLsZH+pS9telqore0DqZ3FYccRYngUOSUo0P?=
 =?us-ascii?Q?oqc1NLZsxbHXp8s19X2yyswprylncCGoZVfo5wjP+/WHN7MpWDXs3fj8oFKg?=
 =?us-ascii?Q?NGvyBEeu5QA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XuvX3Od74+Y7dFHTVIbBgCWNv9KMP+h9YFA3I1LcZ+Ij6fCKf8axy/iQvO2?=
 =?us-ascii?Q?SjBsZAHtL1Qa56Cr4chfLzAymAA91XnF4eLkryndAo2hf7E0CSbyU3DWo7FK?=
 =?us-ascii?Q?BqmElFI/YLSPOHl2c8fa6yGvRt+MaAmn+HA7fL8lexUeu65WTGaZMxgL1jIr?=
 =?us-ascii?Q?pfqo67Ferq7jaE+k6GRK2Dm6STg1zqwvLjo2MpkqYvhMt2ufaVnzyBa01EMd?=
 =?us-ascii?Q?la3fivRsQtkHAw5S7+EQnJxFQpAH2gvt7BI9gD6YYTggK8WLZ10XZT2xFqRG?=
 =?us-ascii?Q?0n4ue09YLqv3ePmAVqOH5HpagxCZ227TgTh/AY8fn0feAcaXMjVTJf/Qlqvk?=
 =?us-ascii?Q?FyeD2ww/yySrvI9sN3XQvbpUcFXOitjsr59IdgGiAyz0D9Vdv8mmjJyDwwPQ?=
 =?us-ascii?Q?46BHA/k/zUlwJlK++zEdjFYVwHhlWJEpJbO2aasEikCz9glQ1t9+L2JdGI6y?=
 =?us-ascii?Q?sSu5UZpWBPq5ax1J8tA1vWo99IjJXpmi+8ZzsWaXSMFQ7N+2kHkrH8Z2Xy1B?=
 =?us-ascii?Q?161EFpak3hBufXY+4of8BeQcWIm4hGbiyfG6LUXMODTRolzyNfgQH0QEOcoC?=
 =?us-ascii?Q?pIZK+Lwtp8Ml6n836uaOjHYNiRKsoe/iDUlNcvgov7FSUyI6giP6nLaCIAeU?=
 =?us-ascii?Q?/PyofIO2A8X8EoFPtVjJhwkZetgZkdXpqSoAuSI2e0GwmDmboPJL7tCF3ncT?=
 =?us-ascii?Q?Vw+G0TXrxIOxHBp/4IL/1GgsBtKdLaDao1Ps8fYO/IMB/tjwQo9Ci8hFzthu?=
 =?us-ascii?Q?v0W/miiczSwyi31Oe2eVWXuLtnFwS+PgvMHWA14O1mJ1DyMjiinYOMWiNt6y?=
 =?us-ascii?Q?fyv1VObfUcY0OAhyRuD3V5lpQGvvhn5+tTJRfKtpaTgov0C5g05U748/IvXR?=
 =?us-ascii?Q?HfMO26NxQSTriCfjTvGQnDROFbiag82yMEhGzoDp1T3nUqGtUrgsDlNBigII?=
 =?us-ascii?Q?ih+Nv9Sd13hY58bDSj/mj2GqgLTS9iad0TfbxaOYQfExeWyy1Y04z+2w+vni?=
 =?us-ascii?Q?4TAWHVrR9BnBKUx2z84fHd8+mlhcA4XoJhFt0qOeaF9l07SroYL+Fo/DWWtr?=
 =?us-ascii?Q?2jo03sTHBDzpih4rHPb5wK+kEiIJ5j+uiFBzLPUsPcIcUSM8sBbWxkfG2L4d?=
 =?us-ascii?Q?O6UPvTNAz4hy8HH09zXEI1dfLtNysQQg/od3MffYlNn+qI3mkWHyqTeCvEmh?=
 =?us-ascii?Q?wvVznrZ1R+I9TmPeRpwhuutvpxCSjgKcZUAxbVXQDTTH7UERZoDgdYPKDNks?=
 =?us-ascii?Q?mKYTwN9dOIe5fNERgBhwAlhmn1I7OmeWXk2ojey8xE7V+dO/gEQ6VBGHR0fS?=
 =?us-ascii?Q?gXaZajGMbAg31pYHiCIU4ZvVcm0Dk5YKPoVeNA4BHzimjTDQko1BygFTTC5V?=
 =?us-ascii?Q?B6huDoYmZ59+9rnlxa2tF6MjQOYwBjL4kiXpwUMH2RE967HHPcvNYARRM/HP?=
 =?us-ascii?Q?zZsakrVlpuxVJKoSR2gEkDW/zF7ccDH69kAj5Bl7dfpbbVgggTVMoa6VNbTx?=
 =?us-ascii?Q?d5u2tlA/ACNmImVDgfwN1t9zgHQR00hWsXwgIql3hztMt3yq2My9nYHFiA7T?=
 =?us-ascii?Q?cvRJF+oe4Tqq54DaNKuuc5N8P1MH8ST22JflBO9x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ab0787-d435-4d10-2013-08dda77faa93
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:01:32.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNGK2gtVWoxtvQhYXoIbQiSnYE3Wh5afJO7oIwbWfbD0mTg6OqiTmNi88FUVmLTTf5kByU543rkjzKn8tvc9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

context_tracking keeps track of whether we're handling IRQ well after
the preempt masks give take it off their books. We need this
functionality in a follow-up patch to fix a bug. Provide a helper API
for the same.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/context_tracking_irq.h |  2 ++
 kernel/context_tracking.c            | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
index 197916ee91a4..35a5ad971514 100644
--- a/include/linux/context_tracking_irq.h
+++ b/include/linux/context_tracking_irq.h
@@ -9,6 +9,7 @@ void ct_irq_enter_irqson(void);
 void ct_irq_exit_irqson(void);
 void ct_nmi_enter(void);
 void ct_nmi_exit(void);
+bool ct_in_irq(void);
 #else
 static __always_inline void ct_irq_enter(void) { }
 static __always_inline void ct_irq_exit(void) { }
@@ -16,6 +17,7 @@ static inline void ct_irq_enter_irqson(void) { }
 static inline void ct_irq_exit_irqson(void) { }
 static __always_inline void ct_nmi_enter(void) { }
 static __always_inline void ct_nmi_exit(void) { }
+static inline bool ct_in_irq(void) { return false; }
 #endif
 
 #endif
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fb5be6e9b423..d0759ef9a6bd 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -392,6 +392,18 @@ noinstr void ct_irq_exit(void)
 	ct_nmi_exit();
 }
 
+/**
+ * ct_in_irq - check if CPU is in a context-tracked IRQ context.
+ *
+ * Returns true if ct_irq_enter() has been called and ct_irq_exit()
+ * has not yet been called. This indicates the CPU is currently
+ * processing an interrupt.
+ */
+bool ct_in_irq(void)
+{
+	return ct_nmi_nesting() != 0;
+}
+
 /*
  * Wrapper for ct_irq_enter() where interrupts are enabled.
  *
-- 
2.34.1



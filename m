Return-Path: <bpf+bounces-60055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92F0AD21AA
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C596A16E9A1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947411FFC55;
	Mon,  9 Jun 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7iBwfjp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB11A2380;
	Mon,  9 Jun 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481162; cv=fail; b=AZPxayZI9iJxkFcNapjS0z26/UFJEMfZ4e4lGBCMsJ8KbZeQ2eqMFrtRyhUIGWrcqbkXkYdtWk3cMeSXdkNppKjndZWT8W8paBuXlEoPtjmPGnM17P6HGCByF9Hs8AjUs2APfgSYHkQxJLMVDSJRkuudao7vzvan/w2cczgv460=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481162; c=relaxed/simple;
	bh=MXJCFpQk0ITlb68Z3rITxiHhTNvSNng24lrxHR7pRkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4VCRsq5LL2zQL/B3lpV5w32qxhCzeqTyUFkOPb/uUFMWsCLvTYn2Yf+Jn6yGqaRBOywJXt/kDzcvo5tj0yeMOggLaGT2l+9DF1cTFLSQX6UiJbfsg9tiWagoXFhJEyHf/GKUAKp/StuZPSTi/vePTJ4ddqHX8NCYG0Z+E4PQys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7iBwfjp; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWrUeR4rKUidwwKqoAjypYeDfWD3zfdPebfcsf3otcKHxUwTO9r6tmkN9kHq3BYTnFfZs2gluU3hCljPJ64+UNM4PNfCwHP6AFu0KDdHSdBbWk4dKUPPVsAEY2daQw3vqLYx9UM/aTUKyYx76H7SkQJtKVhXaInOrYcc4IJUBvSDhXUoUcUPjIkhAF4ONCWx83xz91uDeJXUMEnSuhSAHPFP5TZQl5tbUl7EU1wPNi+kOgT/1HArKOArRpF8r16Jj9fgKsu5lsQr+lPDDCRFW1w9p+6jts/90/oAiKmFsQnpXWBz3uc4f607uub2XtmvmoUxN4wIA+EuXYVZflH89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQzZQO1GCTLQNzZAF0PQ2CE0PXGyWMF3kDIh86h9fDY=;
 b=bcogcmphuTh2Kdig0XA4Htt2eNXtV05Fyy3MBw2NnmmPNyyk+G7p88fdGFqXy+NRNS4+ChSJz2WlMaefSslNm0zOmSnMAcsDmDhIWbLpSQDOZl6KaFcd8PMp8WSeei+b2EOjAnxVF153fFLnIJ+o7I/aXcqSRzX+/So0+JG2Q4YH/bggj6jwbOHui9BpYpOdQ5JMOxrLtskrsqCGLKqqM1EbZQxv6Bk81tvslULLIyvsHDWlqtZ1oZ+rWmjW4WcXjMGtn47eJ49MGw/b8N51MqWTntcz45fqIGA+1k4xXS+wZiquoQNGCUjfutsiIFPqYniP/pbrvmrt/Pnwwk6CoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQzZQO1GCTLQNzZAF0PQ2CE0PXGyWMF3kDIh86h9fDY=;
 b=B7iBwfjp+Qj2fpfxqDEp7xSDfYtdlx2S3DbN+kiFoMIbrxH71Oz7lhNcE/cWNAG8zTtRy8pHnfiJ5l3nH1MRYUOYuWRR1lyYTQ+AtX4YbPr0cuftwhhtpGeuE8ENaa0ydLnZs2NZfbHR3AhlwgHQ+1KUbT98bqoF9YMC6WlIgLwAD3BOaYUJvOUNJtryEjecy3PbXpw7UwLUr8ZH8zTKDeqP4br0u8KKhXTK33ib2bqRgbYSKMUPBiGkZbWpEwbTJpdDezqBoSgiWtamjVE9plKHlUxDnbo/a2UzRTaXirX2ABk/fDw9n9xgS2+zlx8XpuZo+lC+19obIYsrY18OFw==
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 9 Jun
 2025 14:59:16 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::39) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.13 via Frontend Transport; Mon,
 9 Jun 2025 14:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:58:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:58:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:58:50 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 02/12] net: Add skb_can_coalesce for netmem
Date: Mon, 9 Jun 2025 17:58:23 +0300
Message-ID: <20250609145833.990793-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609145833.990793-1-mbloch@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fc9c22-6292-486f-d03d-08dda76633a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lVWfZVCyFrvEdG29TopiDTOaXbTwuoVPRtyyVVfkRUOyl09jPD/2rU53u0ex?=
 =?us-ascii?Q?fPEoc7EfoKg5m/5K8Db2KcVj0zTCElbPJiAvxjNgnAfjOiLh0cmbvGjRUUap?=
 =?us-ascii?Q?CJBfxonHPG5lqbJ0Lj6LG3ksH1ycJw9J5VIk+b7oXPM0VB45brgtRGRPl5vy?=
 =?us-ascii?Q?k7GatCEnNRSM2Hb1cYYooBvnn4poArfhYgML9dcr95BMvkmkJIY8xx3hSmUh?=
 =?us-ascii?Q?t/uRh1R7p9qO+Fu1WoJ7aoI+hqxMslFjMRWy8xQwfeCectD7SaIGytK/1Us+?=
 =?us-ascii?Q?eNNkEkZa8LE8fgukPJiZlanV/NoHL8GjCX/v2brvgmYWkWfpptT+mj802fTF?=
 =?us-ascii?Q?x3vTY841HBrdsxxREKTL2jHLcMIm2bBFi2pvSiqyZeqBJI4TJq5W3zF7U3DB?=
 =?us-ascii?Q?wpL5mkasnCwmE/+3o7a0gggkd388ygdG91VJnLEhIEufaRPUgdzD2+XGLn0E?=
 =?us-ascii?Q?5P5pdcF9iVyeZA+qAVKgaPcedCOs41bliRz5J6ElwL3Q1CfuG6M6UgWVLzJf?=
 =?us-ascii?Q?HYyM7J9KLiaMTTnOdOorTApmxcm7CFFuXHDt3L9hfmVbIsIXNYyCE2O7mFWh?=
 =?us-ascii?Q?VYN3Jt35TuSwnPHSC5imXvmRrVRgutYzR/9U/MvODVd2vAuoV3MVskX9zEaX?=
 =?us-ascii?Q?TDa3+v4qxvQwbC6/6ppAhrz1Ooec0b/c2VdejuZYq7rK4+6AxKmku9koNC/d?=
 =?us-ascii?Q?BF/VjVEMTDLBD6ibrjd7N1sOf/gllEvgr02bY3SfjNRnguehfmKeTAddyTQ3?=
 =?us-ascii?Q?Ey3Xz7YBsgrd896NsNKOZV1ODjCXFhIAweMmjpFkO6OTXfI1Ecq60WjOa1q3?=
 =?us-ascii?Q?3r/loPAyf1ntw+IvvcvRkMc8qelpFMlYd/YI2v8AOb7+hWt65NPRnz2XJ9BJ?=
 =?us-ascii?Q?rdnm/d+dS7/WeAlfO4DVdgV8n87KunkPGbfYV3cnqoN1ZaRBhz/jAoT1n2tl?=
 =?us-ascii?Q?qqoNEVYDy3HruYm0cdBZCDPnyE5YLWzq/SJes3oNhWcGgJ67qDK8+MVK0bLo?=
 =?us-ascii?Q?0FtLd5qHJ0ZjuEUZYasi/WvAQfHFCCqtBHjbmVuW9JCl7URF4yTftYvW/qOX?=
 =?us-ascii?Q?bWfKSiZHCi4ohgANLhlduBzPiGeNL+1x0wznMIlHGQFukTPVFFxIEI7HJp9s?=
 =?us-ascii?Q?5vC4HWgl8FWal12Y2ZzrQ+e+cAE9fwuv3XSxfEXDEn1jhFjBBsmj3csizQVZ?=
 =?us-ascii?Q?Vzke8yzC+MfTJPWaod3u4mWeyMkz49LFML3dUo/ZZ7AYxJ6w+JO0zhVuXAjL?=
 =?us-ascii?Q?78plOCy8nolGv5LHNK+sAGhp7djXAnuDq2P8exQ3A8kSXhfISSWdJ+ZyYDaR?=
 =?us-ascii?Q?5XtlqXy9N8mc51bv3M3nyzkO+MTt4SCaau4lpJVlN0eyAbihbaPi1Nq7DbXr?=
 =?us-ascii?Q?lszymsRFWd2SfnuOKHb/W2G0WfyRPrxQMxagRTGFJ15gjCUUMR6aKbuLjEyK?=
 =?us-ascii?Q?z+XAExtVCuyTJMI0w9yJDjUhu3gVj8j0quldE+1Cc4WQzJlA5UusUrkLY+Z2?=
 =?us-ascii?Q?Gx3UwuNcrCtmSHJZUndSy0BI+wLSaq/CaGR6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:15.0094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fc9c22-6292-486f-d03d-08dda76633a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

From: Dragos Tatulea <dtatulea@nvidia.com>

Allow drivers that have moved over to netmem to do fragment coalescing.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/linux/skbuff.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5520524c93bf..9508968cb300 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3873,20 +3873,26 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
 	__must_check;
 
-static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
-				    const struct page *page, int off)
+static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
+					   netmem_ref netmem, int off)
 {
 	if (skb_zcopy(skb))
 		return false;
 	if (i) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
 
-		return page == skb_frag_page(frag) &&
+		return netmem == skb_frag_netmem(frag) &&
 		       off == skb_frag_off(frag) + skb_frag_size(frag);
 	}
 	return false;
 }
 
+static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
+				    const struct page *page, int off)
+{
+	return skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
+}
+
 static inline int __skb_linearize(struct sk_buff *skb)
 {
 	return __pskb_pull_tail(skb, skb->data_len) ? 0 : -ENOMEM;
-- 
2.34.1



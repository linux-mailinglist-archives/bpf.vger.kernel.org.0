Return-Path: <bpf+bounces-58760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D25AC1607
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F1FA42D89
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF82259C91;
	Thu, 22 May 2025 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XDdiOsK/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3B257AF0;
	Thu, 22 May 2025 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950163; cv=fail; b=sFssbqFV5ZpVdilfL5yUg1yR8IEkj0g9AIwtykgp9wr9esiU/S+shqLIuiRVK6aL795/Z65Fm/wZyWVr2dQbI2ci8cOllH9DM5GokA8Ufhm9BoBXyonzi2wWXGOPiRIC3suHlrc6WpD+SjDP3cvcYthwPcFgbaXSrCeVg6/TKaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950163; c=relaxed/simple;
	bh=M7MxanVjVULE9x2mwkXlLWjxmoutL1vh3tsvmwyADx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyNS8U7c3+lvKG0SLqgMFogt2QEk5UwSJrMwjT/yy9i/Z1Cti5S9mSbnkNRPRLmZTrEuM0vZCrFsMflccm0hD8qoF2KVJ/ACzkfBscGus6++6i3xAK38llrNksdP0w28/5Tvwx9yeUHIQRArj8CA+3Go8lpd/T9qiBTtQY1lGTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XDdiOsK/; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxzSMDGy2EuDkP42eRp3fmG3f0knR9xDkCDioXwf5L/wU5RRGKv4C1PT4eqrxVAA0ouTiZzMVhD2l4NoCAV8Ez2j1oePg9QlUVoPr3lIN88z3LFBahnaJaR4sIdCDM9qIGGINw8VMSXGF757NNozpqsn/W0rQ6b4B+KBiXuOOOXEg5U+x9GwsAFjhY4KCNYlmT2fobRA1OB3cZHehMnevLX/zk7/Bl1DBTIJSLuiyj6dY1RIvbYR94U2UyRFH3vbXooZrkxhR5VJMLn4MsEuCV+ZdoEWzjfBFwwbVRsU/WDl+3ZKlW6iIXzDfNLmnUkCcOI0u8DflBWd7icgYSbsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W09Vf5IAkO/VnGWbk7I9t33hv6IrDXSb4Y0Vj5vacWU=;
 b=iLamHh0S9DO27p+lfuOdfbmFtG69PbC/KsnUMKgGOMmRT+YyUhAJoyDFYPqFUh0Cm8yKYRNO3bREw82Ke7iWm7QGCjGh5NJ97skOVarzQD6Z6WczBQo/jt2bB1/ti/rQd+NaJSvBBWZ49vnQyBgLvc9yR045JG1R/zbf6nIZjHLsFzhDdUItL8GYaARyAB+3joXjn38kglxN7lpjTTNHq9WIlJKDSiAE9Cxp6H8hv47Wd7VM5k6DgOtwc5z6EhZA+kLyslsZ5nqZ3tsGKMEmclnMmaEPhTkLo6g+Szj1UWEuzQy1kqei9rM0dCYqKQ4wq2SSmmRCIUkeMYdNKGbsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W09Vf5IAkO/VnGWbk7I9t33hv6IrDXSb4Y0Vj5vacWU=;
 b=XDdiOsK/VOUu8joRxDPDW2VNNrDksPlQSZi92AKE7UXcdLSpzHIEIgW/1SgfdTuW6EAjY9WZvYu3dZB4uxHnRjJuLCW5/BrrNxdmpvnb26RCYCOC2cxMu2a1JhUyuqPnrmq0RLOuw18FZMRN4m7p6teBLKdPKVIkm/QvMgztzBEu6T3XiP0MD0sqe9yJCQZ/6L5qnkkgbkApJEoB+gu0BZaZwOgtHx8fDXF/mnN5LBgtbvSj0fruekiLehM5RXckcfj0cDecWEz9FN9aJd5aKz5euCNcTvKbFxueFAiYjp9Lrsh8+r+kmWVPte82+8Y7rhL3NtYzmIwxUm4Q/7TEcw==
Received: from CYXP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::13)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Thu, 22 May
 2025 21:42:38 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::a9) by CYXP220CA0010.outlook.office365.com
 (2603:10b6:930:ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Thu,
 22 May 2025 21:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:42:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
Date: Fri, 23 May 2025 00:41:17 +0300
Message-ID: <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d0492f-2917-4c2b-fa85-08dd9979920d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?waCDSyvyYJvQy9YTyfhnVkzFOMbwLMaRUMK8PZ3Co59T6KXrqdLLG2cBfhb3?=
 =?us-ascii?Q?YtiGSihCYFhvPdRzhRthaPjmaAyB32k4T6VI+iZ/yahHLZeEyASFjeupaHjU?=
 =?us-ascii?Q?OJY7847XI3hOX0WjKrAPBnggf8hsCIWJgo5x3jD8LVEOrljfcghpaNtJKDYn?=
 =?us-ascii?Q?TocAKicrAxkV3pOqwyMgD2+PljlqFYEay9Ots5xUKmOnjoGocoq9PWsPjK9x?=
 =?us-ascii?Q?KP9qneCPhOcxl0CfuK4dms8Euu/9jJBhYKaJlTAjmzSFB3twRcSRTas8page?=
 =?us-ascii?Q?SKpt8Zmty9olAgIlQcQFyiU8LdfgonjfhATAsVt0/sW0FWVDx1XIiyEsLICa?=
 =?us-ascii?Q?TeM40SJYw34CCVCK1DswT9vdeWy6BvVIrQrfj8RVmwnqKm44M/vMhWuIqA+P?=
 =?us-ascii?Q?CO8jbjE8wi8pUetTbnGE2Y++4jHBU7HWLJ2DAdvnJjA3LZDeAEus7Gf3t86m?=
 =?us-ascii?Q?m6lDrIOz/xfui+mDO/Zy0UMfVzgK/4MJmXBL3wxvbtdnP5CdSlnnDIAPTCa+?=
 =?us-ascii?Q?O5yzYVQiSjNAvGPUkbzT0YgKI5ZzwaZNk+jDwUKrK68TB4a5S7ADB79Hq8Qk?=
 =?us-ascii?Q?sNwxmqnSl/z8Yu+XFo4q1DTQz3nl1/2DvASHPY8jYp3lW8/4pO7D6zPeI/fM?=
 =?us-ascii?Q?MduOa5pO3Flpv3FQDMWgw7yVHEeaxGf1DOfNd/s3MQ/FPumQbMEJJufcVIp+?=
 =?us-ascii?Q?ZLF47djhS6QNelw2lFWOZD7ygk7azz++5Pgl4aPT9wUrl5+yszZUcJ4xTqor?=
 =?us-ascii?Q?jkIro5MkNGUx3l9b1ABVK39/WG0wM2opRK5HYxMyJBISzRGqV7T6FMh9XpKO?=
 =?us-ascii?Q?ZPp4XfQ0FPdTqESxskzjjDlgTrcfX2OZOH8AOB0od+1xtuBacFELrH2M+eKc?=
 =?us-ascii?Q?rubwh/XbamiRSGa90skrWVsDZCswOdTZb3czU9XD0xfKACHKdUwKxo+rZMsW?=
 =?us-ascii?Q?o4ud70gdUAOjQ54EXc2s76bxue+0V6hMafXIAxWe14SPWVrZamFsuEgs4B5q?=
 =?us-ascii?Q?vGbR7xO5KtiRonQKpMq7DEakAda9gBI0QO62rU5XdRCFgjfnm30DiDf0xXWf?=
 =?us-ascii?Q?MkTESxDe7s2DconxQ3XV2H2p281GVVmFnoJTMJtmIcBgqt7YpIJyBMeLGfqa?=
 =?us-ascii?Q?p5fH2/wjwmTjSAbrW9sfnv7yruKarfBxy8WrQl7PweWwRySiQQ3LLE1qhVa7?=
 =?us-ascii?Q?4hhFp7SrZe6FdHYvJd2Edpu4C/3Ql6J3h8gXC+FvEiTAIgBoTsnl0evGzQbs?=
 =?us-ascii?Q?dBZ52TdOV9nM+PDojyVyI4uT2XFPwsjkryZdUARs4aXtIrewKhmrcoeLTsH8?=
 =?us-ascii?Q?pzu4viQ87mMk0MNceLCsWqyDw4LxISeHpecpG9Dmo9YVhXclTtuhHnzvUPgu?=
 =?us-ascii?Q?i0sk6PUUug1HYhGJysoBVZX9xdLR8396yYMeaBm9MObgXRydqS40S9Yb3uje?=
 =?us-ascii?Q?vsVaKkxlJcBoSWRHb+hmfFnHJChpneBhm+9+gKpJP2ib0Z+JBzp43ZFk+r5X?=
 =?us-ascii?Q?v8zLh6/yeVw24/BCtVOMGXVu/7kKjaxBZwcX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:42:37.5521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d0492f-2917-4c2b-fa85-08dd9979920d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

From: Dragos Tatulea <dtatulea@nvidia.com>

Allow drivers that have moved over to netmem to do fragment coalescing.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5520524c93bf..e8e2860183b4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
 	return false;
 }
 
+static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
+					   const netmem_ref netmem, int off)
+{
+	if (i) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
+
+		return netmem == skb_frag_netmem(frag) &&
+		       off == skb_frag_off(frag) + skb_frag_size(frag);
+	}
+	return false;
+}
+
 static inline int __skb_linearize(struct sk_buff *skb)
 {
 	return __pskb_pull_tail(skb, skb->data_len) ? 0 : -ENOMEM;
-- 
2.31.1



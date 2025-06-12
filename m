Return-Path: <bpf+bounces-60474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4371AD76FC
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0D51884041
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37AC29B8C3;
	Thu, 12 Jun 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiO9juod"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33A298981;
	Thu, 12 Jun 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743259; cv=fail; b=girnZWIcKM6PKPo2KZpb9z1vFlBcAW+rZ9kZbS+vpIYFW/FGaYZwkxZtF9WH4D5ScsjX4tBWBsuJ4VYIbtfIaLvbONtSacFr0M5eOqgWts4l0pLgYx7D/1O0UuR5oev/FcVL6p9yB1UGmULv02G88AqoUfi8KCMNDpiOini/IBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743259; c=relaxed/simple;
	bh=Y5QrKk2GKjvlDZxqgtnc1qZkUcYlk5ODoRqJJpH58MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0k6qmhYn2KK2vh4/7R5jOWeU1F9oLAG2GEzs5qnKtFYwNtRk+UyX7zrCPBuvHAWGyJYOPAuEQ/L/jeykxuw6ueA8Cj7RB+O6lcuYzwfG7ErnkmIYxBG9D5HAwAm7Q+OCnMTfdKghTd+kqJgSzLRsRrDkmhBsn9CoFFoQWNZqek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiO9juod; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUBkw48EprHkcPNkW5LaO74Rhv8JXVKv6Pe33fhqXbwDTjOLjNIAvdU0CB5Oz11CfY/t7aD7/WMbfXvw9Y/11UHBZOWjWW63lDwhhue+roHmHBtEjnqIB+1ERVYqfipS3SQ8HFGgUtFklTFRVtyrb6hLdcK5JKzpOAi33kgPd/55D7Js5tMIYHbBfWW/fAeEtAEA8YDUtFXMkG3pQgjg9P7hMBaOug0VE9E9vctY5LbVqi/L1XNSco6RPa7+UCzlE5h+I4JALxUvxbysu0sU2nvh6m/vsatC/hnI1DzoLdC3ydaUJXHHQdSB/omnCCPCwruQyEaBCDvKjOUHXEuu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKyo/oed8bpU2jO0DE+TE7nZpkQ1pGf0+2u2xASKhoo=;
 b=RiCCkip8nhKYZcaYSLlyoJwyhK8qOqF8TTTML2JWiBuzTmbR/LzAPPNBbqGULc4+kz/b20Lm9WLb7Loy7KyI8lxlk7rlK18CarQwgFBhqZfaMSR6EkYFUHjt5sTo5qSvUNwgioCs6lFc+Mpfte7oDByFLCxmrKX+dUYCkBwCbaBwHOoNCpB7shVlnMI3nZvP1jpeN1xmC2tDE0FeTvE/kMZqJ+snrcNUv5huwlLCaXBIP96WEqcJ+Eig8xgtiRJ8DtP5KOLvZpF/cGAsgrIh6J6xEHSkx1H13zwe0BvOiaCDl7aUmUOMe1zqAlOBQcZfplbddueQFKaaaU0ySIC2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKyo/oed8bpU2jO0DE+TE7nZpkQ1pGf0+2u2xASKhoo=;
 b=uiO9juodwV/UtaJSFsFD385ZNhaVwvIeA42rKwb6KFP7bN5+JS0vDAPb3odCnNfhQ9CS4XOOCRmcA3aWuAYqVf1wU+xT9ov+WksN57UPqbylR57BohuTYSV/eBeuOYlWGxp32ZhF5FdeJX+DKJi7QiuKPFhmuCYR3w5GLZc6zOLIjvw9Xk+PUJHDrIU5dLSU+kbaevRMWnnDOX5mbbITsqIPHrX3ReTYWiqo1j8r/Z/WVIslYK3ck4TcSCBScgubrfsg8Edyno8oEomM2/UtbqfmDs3ZnbpeV0STwTYL5jtDMF5gaOJJWMN0BaT1DWrUATVXvtkEqe7fwCQTStwG7A==
Received: from SA1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:806:2cf::10)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 15:47:32 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::dc) by SA1PR02CA0005.outlook.office365.com
 (2603:10b6:806:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:47:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:03 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mina Almasry <almasrymina@google.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v5 02/12] net: Add skb_can_coalesce for netmem
Date: Thu, 12 Jun 2025 18:46:38 +0300
Message-ID: <20250612154648.1161201-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612154648.1161201-1-mbloch@nvidia.com>
References: <20250612154648.1161201-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: f51ad945-6ecf-466f-5013-08dda9c87167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kLBOnvAzXVEC21iYHzYFSbv9vNR+wU7wpN6/oUh5q/pQChiHFB+H4hGBIDrk?=
 =?us-ascii?Q?i6Jt8aqPx4gKWOBTgj5N6pFivQ/j+kNz6q6+oKEMxzmmNprpPOIDkr+pGbQE?=
 =?us-ascii?Q?eEo/01A0GkDPjzU4oev0mOh+j/0SQsCnAmmsifvDnpqmUPq0N52DS+Xhvjaz?=
 =?us-ascii?Q?eRYElr/yhu6kNHvB6yIL0JcqC5FcXXwtcSCGDeBvhOj6MKtrluzQmVgFnvGp?=
 =?us-ascii?Q?GqpYt1YhP8CTTpbmDYuX8juPUmjCuguPr+pzF9HJ1yXB7vshMtgaimLulSCa?=
 =?us-ascii?Q?e8HfXL14rptow8yXYjJ71HNeRyCIkhVrFlZaI1YigLC9cot5is56/UQvn2hd?=
 =?us-ascii?Q?VAQ0upl+tqzSh1EP2uVT6NRyaQd27XOvCjgZmfQRasBNDyiNxE597Tvt1dTc?=
 =?us-ascii?Q?FG/iXPtNu/lR99lLJD6aOu6rsz4j46Dncvzn1PqAM0bfYpVO8useq2K/VEhk?=
 =?us-ascii?Q?+xl1VBSL2neJAlGi3Lxxh7LRRNOawltGY2WspxKfT8zi49LReXd/942cIaY5?=
 =?us-ascii?Q?j4jyZ7F/7pA5i5a9VbCgYRgfEjTYe0vA9pDeJrnGYJX+y7PcgcmMs4DnQyr5?=
 =?us-ascii?Q?SEWkszwcnE2ZMv2nuwuxA2ZhPn07CVdP69tngHbdrC5h0AqbF9R++YsbDhAd?=
 =?us-ascii?Q?2TwtEXZSMMKzPJphMeYZcLlJsVrCc71jxh8QhRbfQVESC2MJhPYjdT3Iko9X?=
 =?us-ascii?Q?rqi9n8zPuLmvluzBNwyfa6B9ixBLWl7ALTiaK8HqzfD6FhWhT5+5xk+/isCS?=
 =?us-ascii?Q?7Wp23HVCT/gdWAhI3ZqAU8GjuDxYK1IosETfwqxbvMqbDk7EFrLsTKtCFbOC?=
 =?us-ascii?Q?Bb5KfMIS7OjC0FCbYHwIbJwykNwQrqP3FumnXU5y4Ztz2Pwtr49fiB8WXnC7?=
 =?us-ascii?Q?YwqJAy65nzRDpfW9ihOuPBBr6aBaPcKxr0ozP5str0c0vYBydgPUA9ziVcVY?=
 =?us-ascii?Q?vQ9iVX474B/WVNydKzyJ+JGu1lPqUZdSTbv5o+lLL2rKhOkstKPsLEyEcTF+?=
 =?us-ascii?Q?zeP+7o9VjmJeuZgwovK01mF4qWkvGpgngFnGPTaCDTz+P3kdRg13ZCoDBEF8?=
 =?us-ascii?Q?uY7htEAIU+0V4WigZpo/6/bIJ0tY5ZtSGJlZyzG+QYSO9apKVtaRcDblkc3i?=
 =?us-ascii?Q?/drZ0iNJuALU7tvtByoe88jjuOlOAT8o/DH49+D4lo9PMLRea9mKfBl/tNua?=
 =?us-ascii?Q?56XDAY4PWcDdLFU5w+e4RDKH6t/ZYzfjzgT9AgqpkL1xjkfIBxX71hjQFWvk?=
 =?us-ascii?Q?Zty6MtyI2xisUxtkESbb/Y0aBVzkqSNDa0GaGzz/mk+plvuvmON5H4cSnpfA?=
 =?us-ascii?Q?bBbzvCtVIqMFjtIWV4A4y90p9obXgFmsix3DGTqak9iMr9/OlmbbsXYJTlcF?=
 =?us-ascii?Q?xI0eAfElMFXSsE52QUqEB229XSqNaP//Smj3yLm5EoQil5ulQQp+ExBDZuHI?=
 =?us-ascii?Q?Efx22nzehdwbd2uQ0s4RAIBZLmsAQX3vdhOEi0XLSMG+Jxg1gXB6AsixKBy2?=
 =?us-ascii?Q?cGj0tltFyhdR0d1RZv4kQaMLP5lC2t9KPGBQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:31.6138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51ad945-6ecf-466f-5013-08dda9c87167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

From: Dragos Tatulea <dtatulea@nvidia.com>

Allow drivers that have moved over to netmem to do fragment coalescing.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
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



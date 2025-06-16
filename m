Return-Path: <bpf+bounces-60718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305FADB35E
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EDC7A427B
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6C1F09AD;
	Mon, 16 Jun 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnwUvOY0"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2421DEFD2;
	Mon, 16 Jun 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083327; cv=fail; b=I8X97fPRU+uGanDMu2dEexN/OIhNmpZ3Dkcfc1kOoKmq135ZpfHhyY05jk3U7GmBrY6Yh71cEuqntI2dO7g5Q5PzDNYXmhosdZrtEuM1rLeVANWh/sofQjpyyZRbvY0k/KVaXG/psoE363EdnXIZqB9/urd9FPaIPvmUSqaT33M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083327; c=relaxed/simple;
	bh=Y5QrKk2GKjvlDZxqgtnc1qZkUcYlk5ODoRqJJpH58MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4XcXJbHvv/8TF0IUd11/MNV1nulR28KNjZbmQqrm0VKK1hr4hNPjCoTpbBapNdCFnPojWfZ+IYnFlMkohoQ5/82X0cMO07X3hF2xSMrAjYFMFgsJiXPSfcyE68m0EnXH2YJZKKdXzDYrV2Eb86BAP3J76U0LBXBq/2UdAhoWCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnwUvOY0; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9IJ7QLtbO68jiBf9iCzhxEq2vZ+TDt7A5CX+ZMitl46wy/+0CqR+x006xzDJlnXjBOJonTqSA+IpuCrqGdVNSXamTY8UL98/QowGSGb6uLtFY5vZSgNLSmGh2e/6NHbIXxCfkPRktA/uPOyGMFn//MJX5/dAcctUm87dU6AUfJ8Fx7T4O5A/wQkyKTNs2WZwckYAjGvD9zs1Uutz4Ud+YseekIfMwvtlZrt32NoQKZ46l7S5PR010o6iQAgNYWfNs2oz2KlpUENv6BEjgM38R45nkNjbq98xRRJli8tcGNc8rzNidMabRgODjfCCI+abv79QJPtAMPM39FjKDAMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKyo/oed8bpU2jO0DE+TE7nZpkQ1pGf0+2u2xASKhoo=;
 b=tXXc88p48QiduE9qVpd9uhv+/fBDCELEzVzzr0lQlZznavWCSfyjYTYp07O/0K5jl5iSq+FH1q0s0gbH1ECiX39vX9wdgLeAU9QD/EewzUx2S3y7/3Pv6yCDX4MPG4YWQ2YIpSk4l4dwyaG6rvC/n+Sp7U6jvGZaDZtyrYb3ngGFVaX19jTAnXKGbM56yWlazMBGg7fQQWBkn7GIeGmoCXfQOfeB5iWStcmQ1vZcfAuAEuPpjuM3IdPw5m1uSXhRXFd7JIpOQqVDtCtB8Kquu0zQAB8lZtnnFP/ysCpNVr9qjc9wKVNMJxTG5kMQJx+BrR9x5R26sL6OhdOlY9xVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKyo/oed8bpU2jO0DE+TE7nZpkQ1pGf0+2u2xASKhoo=;
 b=mnwUvOY0uy1uat7HX+kHMSF3g28S1pYuhp/ncKIUArxFrN6dNYj2ocvIEJqI0rYb/MyXY+Yl1UsCQaPIl1Cf3GN+/+Hj33Ob2q1D0SZidsT4ES2tjfPIb6PWN92+mnC/6jrKCwKclj0YtWVlUAcB/hPy1Pw8Q14FAWwp9JFaXOWWZb90Im55asAm1YJN9sey+tVhvwgc6pwTCvWlCvQ8ZPKrmRpYK+9qXRh2qt+t+PPIbPWia8QBWTnYUXpzfvNQP/fX0e1eJnb2VHJBZXzimOzte+VG7SK4JhymbOR6T6moBq/QPpsb47vtDbN/rx8GtyXkiz1i5IaOq4G/neg4Cg==
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:15:22 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::ec) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Mon,
 16 Jun 2025 14:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:03 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mina Almasry
	<almasrymina@google.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v6 02/12] net: Add skb_can_coalesce for netmem
Date: Mon, 16 Jun 2025 17:14:31 +0300
Message-ID: <20250616141441.1243044-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616141441.1243044-1-mbloch@nvidia.com>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7e70da-5e27-4105-8bb4-08ddace03b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OEUlX36NNM82/1qP3BKkup/kbUpao9jqEANL4c36XfWyiyP2fcFlTOdXZ2mw?=
 =?us-ascii?Q?ctiYL1G7EA+VmPXM4S9qMVqZMNGyEfA1a9HF7CFWx34EsmbvuxICN9v2XqRj?=
 =?us-ascii?Q?XO+glCvSkhaYreLoDhVDGIcz2vqxnmtchJ4DR/IixNY1tT/2RTbP4RfEwLuF?=
 =?us-ascii?Q?X6WwOUZkLwH7TrELqe0tt2HRJ64dfF8lOCR8Jquz08daxLdcenVniWGF7Qhq?=
 =?us-ascii?Q?8if8ys8IQuzPGk27ulNwd7Og65bKHfHWT9vo0vVHcMPaMmZxha5HPZC+B0W5?=
 =?us-ascii?Q?vb6UHws0nnDBfiHI6gAaG56a8p9Rjxk5Wrf4ZRttJNFAGVnQ23+jPd26pdvA?=
 =?us-ascii?Q?H3EnwAmrpG4dyS2m2fNlRJhlbjUsXJYWe8tCL34VUcyGC+jx+Tbt44VsS62T?=
 =?us-ascii?Q?yQTIwBUQRp92WcKxyxNZZWVlSb0z1C5zO6QfAfehewPyFHni5khM026Mm/Bz?=
 =?us-ascii?Q?k0zojUX6sjmjYyXFbBI8ZrEZGXIcbEJ8ua7v9QE2pN7LhHU1G+5W8g5JuRt/?=
 =?us-ascii?Q?OqxqG3sr7mq1lAQemA50J0upVFWlmA7FsYpVNCmTZikEXwn8hct+1j++h3aQ?=
 =?us-ascii?Q?EHWdZA0z/uqfn0FcMyBoGKUopOthZC0s+9nM3plCNPIIZbAeyccHWfn6/HCU?=
 =?us-ascii?Q?y0xzoyEjc/fblXD5a17+TDT5j6CTqBhAqBUIduDFubeJzwi2QPZONVFZ1dk/?=
 =?us-ascii?Q?W9Kp2djd87FB56VBVU+YXCord9WT0rgje4/mcuHCfR79/Zq8TFsTt3Nj96BO?=
 =?us-ascii?Q?mVeFtkeSRAl6C72kyefFxoTCKz1RvllDwl1RelBNA6wQwDD/dYjUjgWoYiDn?=
 =?us-ascii?Q?5i3mfLCUKBHXectdshUU0WLYkL3/1aS2RYF684xKQNcBM/TMGH1PdM1rn/JC?=
 =?us-ascii?Q?UhwtTi3SXzWLQSlNsxNe+gC/Yie9Y1l2Xz+774XFxPvUq30j8nBakqjw4y1w?=
 =?us-ascii?Q?+FV15Ji/MqjZq57TDePU4RDLEt925ea8nRdXhDjw2Gtz3t0F8XWiLWec71F2?=
 =?us-ascii?Q?9E0EjRV4PY0jl7437X8+g8dEMpUYheoocqojiCG3KonA5A8+wRpgf8hksO8J?=
 =?us-ascii?Q?BlRvmz5HtiWvu/jLSNuzLfvfS/YCmP4qF/8D6HbzRtvjl0AQOF288X471gIi?=
 =?us-ascii?Q?2ABFTMfySlTosMC5NWrVUqWjaI9Sb5/SObK64POzD+1YLp0mMKUQ0rWjqfeH?=
 =?us-ascii?Q?iOjLFEcU9h9rAMaAyMuqdNeL4CAZdwNm1sY6cxlDiM4lq8uzdOPyCQktNI/c?=
 =?us-ascii?Q?Vcja8za8tY3CdcB1kzR8tFT8kyycwZupQmi7ZCGL7erte7w4RBdTN8bBAFGX?=
 =?us-ascii?Q?3mzOkqxkHtX10TssmZJm4uwwTtAERiFsuIYv9kPcpclT+fONGaSABDlPyPIp?=
 =?us-ascii?Q?wGIEkxQ1uZe9ckVgRe6VXCdgm/6O7a2l7okdlFtTRfmHyuLi7FJIUOg+gsgE?=
 =?us-ascii?Q?moHRcRr7uEecRvlYF5ejlDsNbto/SH8u0wIXqLSwNHrpdgiJ1A2V3CoToPA0?=
 =?us-ascii?Q?feB6sz0ttO97soRBJTyzJqmXPGKlD3IF9etT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:21.8896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7e70da-5e27-4105-8bb4-08ddace03b12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999

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



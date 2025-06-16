Return-Path: <bpf+bounces-60719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC971ADB360
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D99D3A6314
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357E218AB4;
	Mon, 16 Jun 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjSWrxLv"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFF20F08E;
	Mon, 16 Jun 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083335; cv=fail; b=OM5td0BMvJtnYiUpNa6JZyQIEEzgXcBitoIxGOTdDvnBtxuVV2jR5PbAFgbDryDrNOi380CXpLZ/3HRbRR+o1R6gbL7ea8SmsL5xiInp3bfpplIVY1RjIwcnjml02fOhMNRPvM0C1QOwcHNauH7DboAGj2RarWi/hANhkV2RbIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083335; c=relaxed/simple;
	bh=drwVzHBaftccBHv/YmuKNAOaDtDea3gF9yPnRvBnrX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpUiINv6VMBmoWKGbGPQMz2g05b0+vgqYZznnaKWfTpLdMLtUxichLrDSxoUzFROQzfMvWcNJbsK8mEFiYU1v62nwy2o6iSUYRrUhIOCnGkjNltDfzpEhsQIoV8v8xRPf0ScMhxZLvzJjqess4+zSA3MagrCjNPYjcvZ15DuNbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AjSWrxLv; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DumhypU3xLxQhueVoYz+W4p1tIj6D2GLrX3hYDw4jgKAuTziBF7JFB5NsPwvX/0gtPgGJE7Ew0gyOE3LPstME44Bt45T5vDYs2G/JuWykv0z6Hs/HTRw8/rv3I2bIie1s/WLe/ykHWY3dXZsgr32XT8MORRnq6VvPZnd7DelQvRxh+mpXgOKXdpOtwMBmFsQBkTyvRxGxrwLaL/S9lhiwfGrdyziFzWutdByz6KnF4AmDP4Bn62daI4wcYEZg7/qu+ukdmhhsBPDXd8dCBGiVE2Ak5i790aOcD779rlFZXCJ9CXdjWE5g7GdItyD8yf0Lw/Kgqw+3/T3oGnjyrR6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaKHTu1lcud+psWMv6qnXY1iDtspPNP8Mddz+DiyyD0=;
 b=rwmwjzdLHujxdEBzeN3KwRN+c4mCiDdAVutQGUSmWHde9FzIA4wd7Iu/wmFVekmVekqKnrc8DNsStzQytsIT+tZPqUjkxcrc/9AMGUPAOC2vier/8g62sjC1oxlYpCjk8L7QJZXG886B1WHwUxvvvsLGGZZE8B34ol2elt8adk0KFo5dm+7+hfnEt+3NhjkGz8RuK41/XeUz3epgVi0nDBnhTl5ezHpH70AiYUDZol7yJf1M0thnXpXpduENIFLLY8iZHI08aJs1/cRroiuT3z+1DccyFRhWUH0BFtipjSjsPLBz7MWPQRawWa0bb0HFH8eAIABIvQ9U7h1g5gMPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaKHTu1lcud+psWMv6qnXY1iDtspPNP8Mddz+DiyyD0=;
 b=AjSWrxLvyh4Nrwvg1OEROrGVDAiRtHGB1C7LA3rQtyA1/NPM+p34zc7CoSGPaEWPq11iSItaRJekQ8p/0D+0Ve75GwEnAAvsnvey7bo0v2AejIBDt/9jGV3VqY46ReMomUq772xWUi6cWQ+fp0fo9wJ8R35wH1VHZeHtGWpWjf4YEUGiRyxGDXj8uKCtaQQPJvyyqy+2bXNFSNrUW43txW80eADuvQ6kg4/9mg8IzkIrnAN7RpWMbb3fMDaWcWxt5Okwcw69hmZpeG1MIfvW4H7IT5hc7JxQMeOgfEFya3SP3ilGiDqiFjolyjVOoCZGR/lYxRDaq+lde6qKOycpDQ==
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:15:30 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::8e) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 14:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:11 -0700
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
	<dtatulea@nvidia.com>, Mina Almasry <almasrymina@google.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v6 03/12] page_pool: Add page_pool_dev_alloc_netmems helper
Date: Mon, 16 Jun 2025 17:14:32 +0300
Message-ID: <20250616141441.1243044-4-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9533faf8-98bb-421a-2fd5-08ddace03ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?40Hjao8peWqM+YIeJwih9mWN+7kRRMioIZFweqHKKWtnoSihpoIFYPmjAXIk?=
 =?us-ascii?Q?iVOcfUlNnxTbRRYAYE8xKGjiD2vywmrWX+WejaLPeIRkdrTLPqbS90FyQB36?=
 =?us-ascii?Q?ey4WEo3BH12Ft6rJo81AKiv3e1X6EdFIy6kV6dAmnM2Lova4czFYPyPqEz+Z?=
 =?us-ascii?Q?lkl71wI6QgHObz1owFWjy9xsGBLQoXwPWXFj8lej00kVhcdC6/TmIp/9XpbD?=
 =?us-ascii?Q?Tqsj+BaMoF7rx5PAM4gPAqSLfIf7OaH4BMXK/+gOXfx8V1VTqS0lIc/nnqoq?=
 =?us-ascii?Q?Rl+7Lerutpcczz+GAp+i9LhjKJqmYn0jo/SIF/MbAEZrG1VyF3nCjcgNdjFH?=
 =?us-ascii?Q?W0Uz7VcnDMGc/H5bejbWAHp2+mAadEZ88DDdD/xDQMqZg0lX95QZDSmQsbYy?=
 =?us-ascii?Q?s8gS4KeZZWYY7UH7lCySn4wjvvNsFZoTUR8b/hOyKhakyiryiyYaiAKOfKSD?=
 =?us-ascii?Q?b6grpyaO41qtbM82WFoWiudCyeWMY83SOTyJG+wo5ugfyEsjqNL8TA8TLL0e?=
 =?us-ascii?Q?legUyDkuudJYtDLrHwmJBlcAyETAzjxinnf4lRsCew50eWIFvwQW1VHc2u8F?=
 =?us-ascii?Q?IZfZu+V1ykPMIiPnCYrQv+BAbndUlC9Mz7zfG8nwSiVrI+hQF90bU2cmT3eu?=
 =?us-ascii?Q?OHt7slVfDIqZ8e06BuIdASHukp3yynZR0MOq6EH9A2MdLqRqvShzcg5MIZpc?=
 =?us-ascii?Q?UmPe5iY3IbXVSIiAPpl2viFpv8J4XXx+PnoO9F+YEs4YYLm7G98H+SxdbTYl?=
 =?us-ascii?Q?I4wNTt0rUb+f8rzH154IIl/SdrP3yu18GUDZevbfBosqV2DqemSG0RfM1Rq9?=
 =?us-ascii?Q?FnDBZevgW9ClnBuDc6sB6NpbFLdsjrEzUWTeTZFYIdappU9ELkhTI3Ub1pJq?=
 =?us-ascii?Q?bi4qs8RMr/wILp75QPPIJTSXO0OhottLBqKo/JrcmNp+mkcCTtjPCf+IzmmP?=
 =?us-ascii?Q?oTq7nMAry9ZWV0+ZzyrsYOH1rNFjZBOJrGK85TkpJAxg9PZccPPZ8+XIXIHi?=
 =?us-ascii?Q?Ki6AM4eiouSsEfPLBdy/DgHTl7THjoAA8xqN4sIUTLSvyN1LfyIDtzcBsuvb?=
 =?us-ascii?Q?l+H+KUpDhY/lyVffOUGeXFs58OG8p4yEDYNaNJMNLNwvTxzaZ71DhjjDijw6?=
 =?us-ascii?Q?8Mr1f5qZC4TynvItEihCX467uuO4Fc5uhsefYCedihq5PMae3t9tPI50zICG?=
 =?us-ascii?Q?z/uvRALNt6QvQvuMFB+NO75CanlgFX5Io4Zdpa3td5/QKe4iiNcAqI8KgKZE?=
 =?us-ascii?Q?0zBm2ybI5HwFSCApaI5tOCsbOsCZQPesZ6MFKFrzJu0z6e+IONHc80D/s4gr?=
 =?us-ascii?Q?74pPyEk52OgdLZiDlegoffVNm1er0JQTM7VX9dsGnrvBvSJI5pRvTHR3L7YQ?=
 =?us-ascii?Q?KqEQg1NkVyLOai1Z8IiO+bqE26jmM8j0DWKIlrgaKHOw/9OORURppdKFT8FL?=
 =?us-ascii?Q?cZuGLsjs1B/9Gj/HNXHZOcyu5A37d5e5i6meFs9DSA/v2p9ftSCrjWJRz1p6?=
 =?us-ascii?Q?q59n6smXo9zLrpyNUHmC5MRB7Nlifmj9NgR0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:30.0488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9533faf8-98bb-421a-2fd5-08ddace03ff3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

From: Dragos Tatulea <dtatulea@nvidia.com>

This is the netmem counterpart of page_pool_dev_alloc_pages() which
uses the default GFP flags for RX.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/page_pool/helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 93f2c31baf9b..773fc65780b5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -153,6 +153,13 @@ static inline netmem_ref page_pool_dev_alloc_netmem(struct page_pool *pool,
 	return page_pool_alloc_netmem(pool, offset, size, gfp);
 }
 
+static inline netmem_ref page_pool_dev_alloc_netmems(struct page_pool *pool)
+{
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
+
+	return page_pool_alloc_netmems(pool, gfp);
+}
+
 static inline struct page *page_pool_alloc(struct page_pool *pool,
 					   unsigned int *offset,
 					   unsigned int *size, gfp_t gfp)
-- 
2.34.1



Return-Path: <bpf+bounces-58767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A805AC1624
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36FAA43809
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16925744A;
	Thu, 22 May 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WX52t0QP"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6C25A33C;
	Thu, 22 May 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950204; cv=fail; b=ZzVNv2IX2+hUkV+uwyds6iyYPePqYtGh6X2AtgFyoXT7K8QhDMsUXsBJpplzoiPANigb4EZicbGkRpMypJEtw+XjdXWgC7i5lXygcl+b+KRzL7XwNYcJwG2/THu67ulIWmbwDK0OkS76aLHJcW0tnQjwWjv4tyR46oJ0iWxtnSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950204; c=relaxed/simple;
	bh=GWUp7eaAdmMMIfEAwXDCo6kBkeOxRIZIDkFDpv1NsTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhheqigFa1p6SRpmEZn8Q8LSgg+Csg7qHxq8lbniLyJjhxcBaMjW/1kYletSLoiZaToPy4FhW5V0lr9xyypxWAwwJiIVs6kupNE9bowXRkq5k1bHMSa8d3uPvpLMurjePo3ogsGeuG36Ndm8rgU9FJnHpaNJjF7TUa59N+d7fA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WX52t0QP; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4BFErxi7PU33yewKZ5v8b+8gkmTq0ijt4t1c1Hu5uA1YuTldO/UalE6Yz0ZpVWrgjCqtuCOYNfLETEfYyjKG1IXPPIu1cF3EStizNFFcnGfPCy1C5ujTmYua8/1+/zK6Kjvrevp0MYqEln7qeliIGjHtNGrk9ApzlHBEYe8TZc+vQ2Pv5SxdtDUO3tXOoOoIe3PaJZoo8QkITJsDGav5lfv7TEgkyZ9oCz6inZOmaeT54vWc4M8S/kXudVLhgVeISAHMlaZTX8+Y/EWQsBQbu9G4JAzTBXDcMZmm7wW9IiYh6tD3m4w30Cbt+wU7HEYXZmuL8aW3Zc1gOYw24u2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh+RTAhAaXDLOKmF4fkqXmjGBzoH37FM0UMYThS81ak=;
 b=eDGjiP/WN2SGAC252b3vmwI190avj77HtM5Gptfmy3JPDWEV/LG6fIiGwLUtOhAfYcczrUM73KeeEBJoieGF077XqlJsPQLSd1F5TFZiuneN2fKquLYUkw55+8Bhc/xkPwHZ/aq6VZbmNm+LYmaqq091Fk6qnmoXjwcPDO7liFSDFzLO9AICD0MZhxQWQJG6sivyLOuFJFTIUqWeJDVlxfqZyeeTPf9nJbuWULWJ+VrzU7oz1Cl8DbpRd/+3zFFgM9mZLy/pkVkAIihBXovSwYiqZCHZArEfKqTJmcQX/TocSq2gTi5CzqC+Hqh1mnhHI2Ci6pCkzH32n1MWuweV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh+RTAhAaXDLOKmF4fkqXmjGBzoH37FM0UMYThS81ak=;
 b=WX52t0QPmOSCtcosK08MeTZR1DFSsiTK1T1/JxU6JAeMyZ3tkHGcojSN2y9H7gqKQzfBZEwTWCdlT00nrtra3cqLFFTi9jsyL6DVGPcFVTwpbBzF5emOiZfPRzoamZ62MhFyRQdofckl9XVE7qVogSGZPHrjeCm9/U4uzlgo63Keug6TAzowf2XTle/JqiQcxK+8ulDhNpJLhd/VxzH8MRKgcZLf2SxQWNgcGx2P34zHC/bWE1nrCCkRyVLrw7fp7O5eAkvItwAeP3/PoSuoTyRgdRgdGxIFG2WBmrG4tsIznNpffkK7qiH5ZkzrXdPTianGWtFOs+7Zr+rRXQWkfw==
Received: from PH7PR10CA0005.namprd10.prod.outlook.com (2603:10b6:510:23d::11)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 21:43:18 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::50) by PH7PR10CA0005.outlook.office365.com
 (2603:10b6:510:23d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.34 via Frontend Transport; Thu,
 22 May 2025 21:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:43:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:43:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:43:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:43:00 -0700
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
Subject: [PATCH net-next V2 09/11] net/mlx5e: Add support for UNREADABLE netmem page pools
Date: Fri, 23 May 2025 00:41:24 +0300
Message-ID: <1747950086-1246773-10-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: db75af11-6e8f-4289-babf-08dd9979a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/fsz7lg6NnIGRKC7MLralCpP9zWMYMszmTmnUfvGQrNlbNhy8FG4luZEKjb?=
 =?us-ascii?Q?nuYxXNa9FfmRT+EcOC2nPj6qL3RKntrUV+osyCw4qJGY97YWar7SoHRyJ3Dq?=
 =?us-ascii?Q?2PmX5ippN/cnWRVAR6DQawM1bbSaBCWZ8MM9rW+JTAKe6WbJ6+R8dGhDK6Bk?=
 =?us-ascii?Q?Jayd1jH2KQQfBzZyIbbfKqK+hoedLWEWILep7ANDIsSexx6mWjCsbWk82sGY?=
 =?us-ascii?Q?jWB5sW5qH85K3sy6QXxPL43XaIfq9ffeRLZzZhU2vbH0o7H1AURiQheLdgEz?=
 =?us-ascii?Q?dXhBC5yqGAx18oXR4UTP3IaHCXNqWFohQ0dzXLbEN6dFnqrEuK7Rns2RSWR1?=
 =?us-ascii?Q?Ag7V+p22f+Ivu/ctJiAADbShw721MFRVn1QbXS3rtlv8K9YE+iqN1EKBI32W?=
 =?us-ascii?Q?TV0xDGaB7mcF7aObU8UBnYrkSbdoPjJmWYqGakosE8zx13reVTIPd6plrw7x?=
 =?us-ascii?Q?MmUysgccqEKVIW4yhVxpTbjd0c2dMylV259T8O2EKiDCbvB4knl0uER1YPOJ?=
 =?us-ascii?Q?S0MNQsfvk7ie3Q80TE9+WGl8ryuPgZBrBUSRcQB3Jgu08vUQLh0MXshGVwKt?=
 =?us-ascii?Q?c5ccj9hCQxDjQjO5ghbZ3FhUhpVSeu3ZEtxo/I7MNbUJiEZu9vBo2hyoNmfz?=
 =?us-ascii?Q?lakDXShxXYC12gnBv3U96cije49YPZReEj0haaZjnK81RzwYz1qweqil+LdP?=
 =?us-ascii?Q?Qk7HVXgSGRQ8d2Y2iOgZUwFstCyJEvNdJ3DoQu2DDrOHQDyUZliioYo2sVwa?=
 =?us-ascii?Q?2UyLZVKyYqhBfYe/4/EAgJZZk8u3Zpkg9rxbhupf8Dh70Lt0KUCnwzl/fp3B?=
 =?us-ascii?Q?Jxay1RG/ENYIbLL1779w9m2KIDjXI1neCdc5DsgEUeGcZU1WdMSAP437MQ3d?=
 =?us-ascii?Q?3s+f6oJ6eElrfDp5s/0/9Rx5UxLGmfBkjRm8h3ANc+vENoa1ARt3y2MQjqDW?=
 =?us-ascii?Q?f4IrvgSnAgMROLNnXu2Ju7xSEHRgPzHsU6qvk+OBRJAOdyHlp9Whr9uFkUoT?=
 =?us-ascii?Q?8MaVwnLjG/diE2mwtlt7LhWzc45Ar+tm7MzajEJsCCLOM8zbzue7Yj00imua?=
 =?us-ascii?Q?Brdu1AIQsVqc06SWw5kM95F36S66zjzz+nHLL7ZW+Bo6tvGTSnFFsdJND1eN?=
 =?us-ascii?Q?+WCoUp7esLM7BYgDj97d58UXvUV8DIIIVtC3Lccd7NpowWZznAjGJJMg9aG4?=
 =?us-ascii?Q?f8B8S0WWWAZObNTDazOW8Z5DR5aXe4As4hlQ0dmpGK9mVpqbMEAi43qD46l4?=
 =?us-ascii?Q?grjSIY1125B7FJPKf/ywgzQ1nqrlrySCt4JNARNEujLRuV1ncOWT74IEa7AM?=
 =?us-ascii?Q?caethW4RS/pCBqIguRfRAUMRjfHT3ibnL6BL2Y25X0tauUBrKo22WvpUChuA?=
 =?us-ascii?Q?2iGyZnQMKsaH6wtlqL5T5KiCm8tUqxD86enPhTO/9fbb8lYiV8R2cIjoHp46?=
 =?us-ascii?Q?11D38VNFE0yJOi0HVDK9zOMC9XLP/3uErmPpwlQXh+O2CqND1KedvzOKFRil?=
 =?us-ascii?Q?ymzkr86Zxft+bRwK/1w0w17cHV7JKejwY9J8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:43:16.8117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db75af11-6e8f-4289-babf-08dd9979a96b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

From: Saeed Mahameed <saeedm@nvidia.com>

On netdev_rx_queue_restart, a special type of page pool maybe expected.

In this patch declare support for UNREADABLE netmem iov pages in the
pool params only when header data split shampo RQ mode is enabled, also
set the queue index in the page pool params struct.

Shampo mode requirement: Without header split rx needs to peek at the data,
we can't do UNREADABLE_NETMEM.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9e2975782a82..485b1515ace5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -952,6 +952,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
+		pp_params.queue_idx = rq->ix;
+
+		/* Shampo header data split allow for unreadable netmem */
+		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+			pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 
 		/* page_pool can be used even when there is no rq->xdp_prog,
 		 * given page_pool does not handle DMA mapping there is no
-- 
2.31.1



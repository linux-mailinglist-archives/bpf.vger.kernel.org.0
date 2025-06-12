Return-Path: <bpf+bounces-60473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A8AD76F3
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D3D1889FC2
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E729AB09;
	Thu, 12 Jun 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JPpUW6ml"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF8299AB3;
	Thu, 12 Jun 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743253; cv=fail; b=XoslcXoWP+fhlnlVWU00hDPt31jsv3+8OKIcrnjYSYa3Y5iB6Rpr4itqoSO4i5E6JKsHzQ8/nmnEV5JbH4msOpIeGBkuZhyAIlB+a67GSRJHYhpVm9oBInpR/rHFmMALwpp4oGWcd0MT8Qo9KaPH/JTkBcTYPbFgGnZO6wx2O8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743253; c=relaxed/simple;
	bh=cBpW0vFRslgWmkQZIMvJScA6C1rWhBAhrjH5OfMUgXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DViFUWAP4T2B2mDJ+kBtsb9XXtxUgwhukiGFXNMUlWZH8kzk2roYNDt4V/WQNt7inXj5vCYksUR/g/tL/aYrJjom56qxQZzN+d+19n8RckrC0tFLrIQNTW4kJHtPMozeiOq7rPOqUwHDh4ikYK8yxHa/XFmW8pn6wsXukIhX1c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JPpUW6ml; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFzilUKOV6TQO0Ul6zBaK69RHuX7QAxT193x+Q0SiPLjzs+zCpHYSJG8+DHG9F9goxEcD2nzziRPLfhUjt+Lo23GSz9p5ulyBAhGTOIyHp/CsCbpAcYjsTWxp6GIVBphUtN3goy4PNdGHxJTWgSy4RiAYaL0FsDW/1viwjtrfYNwSy5XVc71LlsJxnDo07kNaDCmfOBQVj8pdcfWkL2O7YG4v04IFy7PoP0Get8/v0LAjf8mdvEpsmLyyoHG4l9mxD5UCV5UJPB6r+Xm9z4GuUbKepeBBV2PVRto0gyfh6i7XieKlpmgdXb8mbOSPFLazUVRXuy9H5Om+LBsRgxEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/2UfgajKeaXX5S7CmuBPl6iJeOl68wEF+lSMt+cegE=;
 b=L5CHOe5hrxOZytLd4hshr5/XNojSSACK1IqtPcSvcoiZfdJF+/2A0ZdArJtLg7IKaEkSn8IwHQ/u4mJigAj/U1Mu7QhspHemQBc3PzvV0eryQNl3qBTRP+7VRW7cAj+X9gBcGVFNWGcFf3U0bVB868uaDnOCCkLcxc/Et1YHIQoVE0ifKca/Ro2U5/JmP1xeeSVta/MmR3lTv4W/1mgZuEPYsq24pdbRWH1ADY1TOLt92K0iYHWBYq9mlFemmrYj9IRd4xAmQ3y5fUEe2Fk+W9jkgZv0ccoDRDYrOtdYY25NmJDah1yVLGKm4Do9OxW4ZVCoqKzue+vx2em4Nggrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/2UfgajKeaXX5S7CmuBPl6iJeOl68wEF+lSMt+cegE=;
 b=JPpUW6ml10Cm7A46Zumw4zp9UZAFaCl3+rWqJz79HXLvBl+3Uy5aWflo/aKy20OAVOrPF6cU+EgB1aEKnuFnpmLAdlX3SFL+j3aGTSluiuS9TxvzAF6Wxu1MCVhnhm8uDnfy/RFe65BLsz754q8qTXVZ3ihKbYid1bRWMMsEFOxNfoLc2CRel6drhkhDb8dnnX//7MXmsI+bItwNTfzf06U6OBtBh2lioM7KrE7zwLyjKI4oXA45aBzJRtiwns5NlKt3OJsNQI1rpUEAFC1O+vjjwZrEGQaWAHwHay3jz1yOJGnC62pbCJNtnuffibi8BvmLhbN333JzbZTB6jMjCg==
Received: from SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36)
 by DS5PPFBB8C78349.namprd12.prod.outlook.com (2603:10b6:f:fc00::660) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 12 Jun
 2025 15:47:27 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::2f) by SN6PR16CA0059.outlook.office365.com
 (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:47:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:46:56 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Mina Almasry
	<almasrymina@google.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v5 01/12] net: Allow const args for of page_to_netmem()
Date: Thu, 12 Jun 2025 18:46:37 +0300
Message-ID: <20250612154648.1161201-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DS5PPFBB8C78349:EE_
X-MS-Office365-Filtering-Correlation-Id: 4881b05c-e966-4646-a651-08dda9c86e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FFi31Hro0iT13FTwX9JXppVC0bvKO+VidEtLUYgV2iUgqQgJ4H9QyMF60XWO?=
 =?us-ascii?Q?V26b4VaZgfJSNDyHuFL/meWT9Qp6Bmm3MGZQGhgR8yz9rMqptmB94/8ONV1s?=
 =?us-ascii?Q?ASzjzJOMvEL8sVYpoRRL+yIj1H72m0A2kT03npWEwcvRmebrwn5XPZKqwCac?=
 =?us-ascii?Q?cFfk9OfZa4KpNmVugnJzl6VsbJRdgCEAq9gVjOx9C9Y9dG28G3SDjLFWokFY?=
 =?us-ascii?Q?UtjxhBmaoP0L5x3GMt0rGDDp94HMoy+7zUKrMj5pbOMUzbaS6o5w7Ztnbx/i?=
 =?us-ascii?Q?lufi2Iw4V/NyO53Tz5vDct4/sdzCw69QRTK7CpwMHw3w2cQAy/jJSaoZczRo?=
 =?us-ascii?Q?hw6nTJWR1jQaMneBTlct9tOcffjPSkJud/7/fxRZpQQwfecfzQe1zfxa8vGR?=
 =?us-ascii?Q?Ioh1kyM0jzWl5vzjDyYDL7AgzfJQh4rC8PXwi9ayu8j+RusKtFlAjbibq8jQ?=
 =?us-ascii?Q?ceXNlx+bradLfgqTq1zNYTte98ONlqCNtV8ycBB7NnBHZ/dKMyoiOrmSVF4/?=
 =?us-ascii?Q?95PnhZyPMJIaNvY/tT8VWFRR4Emry97dkgpv4ITGDAAn5bB5C3MNbLvPILSY?=
 =?us-ascii?Q?sOcDKMjjOzikuYbeTS5oRj7n76j4EXv1fPdL9BQzEWotyjROuqpaCRg80ean?=
 =?us-ascii?Q?c65Hx6+UWr8FtL7EqQJUgz/Dg3fiAzbWphbtZMH6NaVEXAJLPq8yXLv6IEPg?=
 =?us-ascii?Q?DFPPnTy8TBZtX/638yNHvD6JMDvi+QgoBXrfKbKhN4Yqk+ONUrueFuNF1cN5?=
 =?us-ascii?Q?IAEu3pwXtKtm9wI6WGRECfOvjI2CSgXFhJ6XFFK8ddN/IJLSVccTcF6aeUVK?=
 =?us-ascii?Q?GiVjYGY5snUCqPZ9gGrm5b+8e9SILyYPTugp+DT38xXWlfqBJN+jg5UAOvNZ?=
 =?us-ascii?Q?STc0SfGreN/2fI+gwmzN4xsx0WW0FRQPDCzDwxuOEn60BjKY2pUiQ5UFAxsJ?=
 =?us-ascii?Q?q2tql752DiH24FVFKOr3h7ACQPdXX+32xlXGYI22DKOXEXRA0oVD6/kidfva?=
 =?us-ascii?Q?lanf/0/3Z0vP3lgQ5qoAyLZuL32LrEJ8apfmCHija0yO1L2B1ZC3LKPezkT2?=
 =?us-ascii?Q?qC5v/EXGGUW+ttKOqVPFrMEVDcC6JOANcoOwGJMaaUofTYJUaCz7B/igCn+7?=
 =?us-ascii?Q?5FYjuDST6cOH+wXPBJ4gIfNQyZvZzqqx29OZaSYC5ksLO2sNa7Ctaf1AHytb?=
 =?us-ascii?Q?0lVFvm2LvyxOM2uwrMmj0EofCOBdnWMN2nlOE43W/rLo1G8C1p2wEc58IPVl?=
 =?us-ascii?Q?U8LfHvG8c4o4DZOv5iikn0wG0d2MdfQ2k5Cr6bDvLgo3fsyiiqrBZoc9XGbG?=
 =?us-ascii?Q?KKW2vQD5JCSBZtDzFkYr/12xVdFWMwYvKv807NvatX0PHz1ifoQNwrpMmcjI?=
 =?us-ascii?Q?JfFkYFnlsu+6gtqfWzB+q1vH3IErysDBbYvZ6WG/rp4DmLFFf2MLBOn/UdfZ?=
 =?us-ascii?Q?uvKbb+q7irM3rJPlwG5dfpOUk6jL+0hdhgEHCfcJ+cl6aNhGKfwP6YwluILf?=
 =?us-ascii?Q?Fr4BCcSYn73xAC9IPHqVM/sXx5KiM0Pd07km?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:26.5402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4881b05c-e966-4646-a651-08dda9c86e5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBB8C78349

From: Dragos Tatulea <dtatulea@nvidia.com>

This allows calling page_to_netmem() with a const page * argument.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/netmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..caf2e773c915 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -143,7 +143,7 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
+static inline netmem_ref page_to_netmem(const struct page *page)
 {
 	return (__force netmem_ref)page;
 }
-- 
2.34.1



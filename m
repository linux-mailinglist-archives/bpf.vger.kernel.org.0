Return-Path: <bpf+bounces-60054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74591AD21A7
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC49B3B086F
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D821A94F;
	Mon,  9 Jun 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UsHpK2Bc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065B219A97;
	Mon,  9 Jun 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481149; cv=fail; b=dts4WMVMQiQsgUagIXlakWg7es04GUY2RshJo98cbjMhtECrpCPkBTdIzfX4g7rhHFbT78kX6uK5gnerKJnK/JROyLySEl1vXiGY5zi4GIm57pDK2TX62NlM1PXzALpKGG+N4lSYGietPxiUwM64rNud3uwJ77JoMcpfiVGq3hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481149; c=relaxed/simple;
	bh=iQ405jlpUdi2M2mlpiwGwBGuNpLG7h7qji6ME3PIh1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxfQNnAb7DEEFhg3uHFGMc5k6Uqk95IlZ7esYosLB0MaOskgtQThkM9TxT0I0WyECa7Th7kkAH0QHEuTucJCBlv7roEKM7t4Wda5Ik0w/Cb09GamZVtkIJt8sjP4MofnrUTctgGumbKs53++WvTXpdiRGdFVnPwYDZWxt/w+v00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UsHpK2Bc; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsaYkP1W2XdHDl6bNIE6KTXwPfGJU1CLre/PqAB19kt86vnxlza4acLdR0zuYb2t8EBdeY759Ot34lTPTV7SnHlwUuDd6A5u8B28yPGiiFZ274rmRubvUcXZNuXp2QQxtJgQxzejiKzV08DMQgpktZ6snUacSq9t2yfUfGhA6rng54XVThd42/K+TVfGq5uIgCyZYc11xlY5FxlI41ht4WKu/te47rbOOCmIR2+oQnROj+6GdkTXULyhrQ6aoFP/yhf83kwmZmD/skaXlH1oKoNNmf7Q4ROR2/bXw4qVAHzpz/7mhlpoJs+ccg4gn3B+wqQfK50omyJizNAGiOepZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9tB83GKWoV97ArXyO52qnwT/TP4jHi0S9un8/W/1Xo=;
 b=iHGb/XEfDNoiR5Ivqp2FVDrnLbdzgFAYTgahUratzMMGDYo4gmOUe+SLOOvG+ceRbN1RKQZdBdrYOuvf3DaPpsDLC6r9x+9J+EDS1e8frgpVHaLWybCHLG4gThlbJLdSUdjBgvWks+crwdxMt83czefcPULh0+ySyw0hOIvcHH7mUk+aptXFOKDL5Rx+w3PndFFHHayMaGPls/MQDs129NOUn9aKOQygPPT7vFfY7Rb63OVVuames1vbpgZ2S6ZRiZyeg3KpFmArBMVDJMvmw+ZuJ41KBn3lV7jhlYmIdQCfkL8kzWi3WhZ0nLKl2ZZwoB3RDE17XMLuuSAQatRrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9tB83GKWoV97ArXyO52qnwT/TP4jHi0S9un8/W/1Xo=;
 b=UsHpK2BcCQLb97w2Xx3aZ85I6HPt+SqQ6dVmNYoTPxVKL6aeF3Ha/Lg16OltsaTYLchpA2x6CkXerg1ofmfhaUcVF+EyqoCYjDuR2fBmQDFBvh+/PpnmcQGDzyYa05+SUh8/mTgMyKpGRXEatXc/esxeg6uUziRNYLfZ22AuULYStok5mMxcdZeC5bWTRxrvD3vz/uo3U5FjLajXBCuNrt7G3PMKcx1t/njXwm3TxTYWu6z1fDBZ1ASqu+kSxUeD5h5fOxjV6W7jNW+7tL4gYTV5PRMVylYcjNilYoaPrFUiV9SHkogIBiIZaUqmlwQoR8BQLLlkxmsjcS4Ypf2s/w==
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 9 Jun
 2025 14:59:04 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::41) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 9 Jun 2025 14:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:58:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:58:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:58:44 -0700
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
Subject: [PATCH net-next v3 01/12] net: Allow const args for of page_to_netmem()
Date: Mon, 9 Jun 2025 17:58:22 +0300
Message-ID: <20250609145833.990793-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdee816-59d3-472b-91d8-08dda7662d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dHUloNOCnQ1nFwy0c+HbzJOrWU8Kp7JwQkn0eqHMTm2JvZeuX44HDhb0yqVB?=
 =?us-ascii?Q?ydZlASjzB4TcPJuPnmvSirY50wTb7OsfCBBQjRRtuO7DlXk2PI2gMCcHRRIA?=
 =?us-ascii?Q?r0Z0hOftthB61Zt2xMcHl8k/nBgWy9J3Ev0GqTPDtjk10wGhKGlVX+Jq8hES?=
 =?us-ascii?Q?jg3VmDxD0F9anqSZgukXgP3Qlz/yk+8P/Dz9LX6WxtLL5YLATDRjsdI6CKNe?=
 =?us-ascii?Q?+KjK50UKT3dkE5tWvsV7odIAovHea1OoZOUOfFurl8LrMVOxxrHAlmO3LN4H?=
 =?us-ascii?Q?g/c3B+jTChWGFTTsn64SCHY46pciDtf7qRTX/XsAXnLta9XYaLj8Zte2Srfj?=
 =?us-ascii?Q?HNDMmMiqZEmfjFqrF0Y8rUW+7/vn/ym5bCPAQoJh78kpT82iq8+/z0wHWyIJ?=
 =?us-ascii?Q?LP/o3Ua+xvBnbKy4/Jtz09JqyT4IA/UUwgji5JrBAx0uArQ2rf4i+B1Ii3Ou?=
 =?us-ascii?Q?y2IM1S+Gm8krojBlv7ISqWDN6NrLdHhTMUzRbdDG8rDg06mO9hvIlybCUmGR?=
 =?us-ascii?Q?JVRUmg1aB8OWR3X69v+h9bRu36Z79zNFubkJZ8bp/PIoaIl4ssroLQNaBQcZ?=
 =?us-ascii?Q?+QDKxxdL3Xak02bCTfd2VlH75ur87xT9w5bf0fl4le7Yh1W434/WOKQHdDYQ?=
 =?us-ascii?Q?e4un6iUyp07oNb4VPHgY27fv2Vq9mCg3fLcKhR9yIqXya5BWqXOEeMrp8m+f?=
 =?us-ascii?Q?GloIQmuuSg96Y4QsNvMBlQGNk+AtW/HUkhccOJbXQexS/6vQWc2gSI/3xpK/?=
 =?us-ascii?Q?2WKWPXDwzaF0r0TYrdqZdnUm0Wk2LP1ZrBvmSsb9hLyEdZ+DjQDensdx86R6?=
 =?us-ascii?Q?57xCs2/tlpxIKXfK9vt/s6Qk4LRAhQ3Uj2ZWRh40Jn9c1tL7+uiz61i6lR+Y?=
 =?us-ascii?Q?7MpUyfQLUyy6wiXnAAd4sMaAX/heOxwgaGupAQEJDHnYRyj2yIhHFUTcSe4V?=
 =?us-ascii?Q?2ky+6SFWdRbVSVezNbIqT4I+DRKdHCzf2vHHjy12p9Q90iR7Eqo/i0Va6kSd?=
 =?us-ascii?Q?cM9uKRoIe0ceRlUT2N4UBIA+3l9wdjjJqDOCWaVN/42V8xCWjWG5LBXIrUyl?=
 =?us-ascii?Q?yO43une0lsz2FOkTW9SU30klE1j68AmIoEqLL7RR4GA2q9aWGMFD0n959CdK?=
 =?us-ascii?Q?ELR0jxmP3bhYQRsv6EteurYXsjNAPWsDLYluHj44vNXxm78F2mMo69x4vmQ9?=
 =?us-ascii?Q?rPFLjF/jPY5E9eGa2XkrCnzmg8HZN694yRlackt+qIRXJ+zqTey60o2yWgiA?=
 =?us-ascii?Q?T5ns8CQPUIgRV81OerXs/xr44C/pHWI9S3bKI9P+1vbqP1m05CvyKxgj9RBw?=
 =?us-ascii?Q?86wx4YkZBfKp4rNUXfn2T6asA4R1vJzwo/IPR2jRx+oc9Mo52ocxVDBUFOWV?=
 =?us-ascii?Q?Uj+LZGdyVRmA1boBp8V+24DZayYwDjZiXcEQGRqdT8Ok+XYA+wlk38GHYj8P?=
 =?us-ascii?Q?qarnAzZtoBNBiaOjD6Sxjtt+rIuXeuzen7tTphuj2LmnWfOthGxymNY0Wl2G?=
 =?us-ascii?Q?RXfsYQ27bFbKziadpHEAxr1ohDIFBNBZg5D5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:04.1294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdee816-59d3-472b-91d8-08dda7662d27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

From: Dragos Tatulea <dtatulea@nvidia.com>

This allows calling page_to_netmem() with a const page * argument.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
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



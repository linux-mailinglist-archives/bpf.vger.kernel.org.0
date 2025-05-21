Return-Path: <bpf+bounces-58652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149DABF3D8
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7984E68A1
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E062686A5;
	Wed, 21 May 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hKETg3Pu"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE55267F44;
	Wed, 21 May 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829426; cv=fail; b=YElhNY+vyFXb5zYlJNm/+jdiNW+RIrDou/0Ng56mTpt4SYRwr/BFdui9UF55QaEsSU832FZJ/4pA5A4eTFvWmI++W2uOPao8KBYP4kxrvwvsIo5iAmjdwuh4cPe4obqq3nVyur7ULKpY1RBwK9ZoFK1aXUVopQHIdkoXVPripVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829426; c=relaxed/simple;
	bh=kSxuhH6CcBB1pGIlCR9bagjHmIGUG2t2VaCaszXtcjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXxB3xlt2IOazn3R8haKmbNhYtuJ9qKASvhp7wvoAcvK1YPmdR12RKHbvD4lEBGzrnGrB9TEnkDxIf+/d6I+7lkorGIV5T/jLssGdRPJPDUYqtoAQsjFuIn0BiNcpX7FzcOCGfiW0eUlEnwUh6/uJvk4LRRhsdpZUm8Vcr7Qe68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hKETg3Pu; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcDMXhXk+uQLy3ShuEUXWtYEMjCYxuXzFZo8uyuAGaeU9qruPm9xzlYqpRPJiM+51yCSausLpq3vCk2baYViZ5d+ZyCwIfKEqujtC2EJajwm450ZWE+Jcfe/r+BUw61t7MLL2cPZELbzN2w+E02HMUItT0fCt1GvvBtbBN7nN1Z6SJ3Q73HwtSUTCbpLuIHbO6o5bC/qav9zdQ3dNu+jUEW0sptyHyNcYbH8LGrFOHK4z4NOoa8OzImjxx2swIZIaRa9XlodA43W5BIwqxVEzFv+B1lu4hKTLgiaKZ51Us5dUGjoxS9tUbcO1pe7rjaIVLhlMVrGEOeUs15OVTKb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+7Vej9OqVluxU9s5Dxz8U9W9HlMyYxsBYhdPtNATiY=;
 b=yOZ7Plq33Xf1+zUscqiKf5vHxnYU8ucET+/yoyrcPdT/NDAfNrXcKXYSKeFIblZyJknK+BMxiz7M3PuVeDjG2ufg2usxDfV/8DMkNvEnnGUEvRHZKSOHW+QnkAAO1eizYO6QeMadxJ5Eaxrng2nQjaPTEq+IQUMBMrp4c4g3xli7dlAceP92QCNgmeLqiqnVx3MyM4c/Ijm7GcIVA2MYIiH55Vypq9BvvMnqMqjcQ9tWNulPDworTCovjttwvHIgXYV4m+6BiZ6IgzeGVasbB6BGRysXqNnH29/FHANnQlkt5ztqNXmJ8eXmxbrd6j+WkUGmY6/82LSH2hl7VbmgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+7Vej9OqVluxU9s5Dxz8U9W9HlMyYxsBYhdPtNATiY=;
 b=hKETg3PuhaqH0tIsDJHMc5Y3WsQfMJSkvwgo+Lwwsa//TvBKBJacUYm/eX53m381tz7usbNmlLYV6fryXuKPHtnyvNv039hM34UsL12qMvrc8NNTrVkvyVApeOIIxltBUmzHM5QabyP8sQ7caCO6nVYCSfeJgyb95SzQYZVMy3e/O1RAqCVmnTjqdu+Ty1HWyuDJfB4P39XNrWqgbcSEIiw1Pw+1BK9CBDUUrT8rtxxtn01XPileRzB3vXFfm9P+wMVbzvdoxonV+QGniQ+sn0XJzVbilbJbFIXXGaPg7elXaWVYszkl1dex8u7ZyvN+yPUHCEhWBY64g7SQ6I7j1w==
Received: from BYAPR07CA0022.namprd07.prod.outlook.com (2603:10b6:a02:bc::35)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 21 May
 2025 12:10:21 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::fc) by BYAPR07CA0022.outlook.office365.com
 (2603:10b6:a02:bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 12:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:10:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 05:10:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 05:10:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 05:10:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: Don't drop RTNL during firmware flash
Date: Wed, 21 May 2025 15:09:01 +0300
Message-ID: <1747829342-1018757-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b187d7-e54d-431b-6570-08dd98607563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHYUKogkKoZPgjf0bZq7H8h4TxgComi16AXskmDdoRhPyhZM+HhQATOj1BXX?=
 =?us-ascii?Q?nUyUeISwuSOvtbGKlDVyhfI3FlKJDc/l6v5bg0V/gzzYU4uu+Jcyf/6TX188?=
 =?us-ascii?Q?Wjs00iOE+rqgAVwi45ZNPZQF/8V51UOp6unWxRLO0KHwt7YmS8Sk0ckvDgAd?=
 =?us-ascii?Q?D3utSRvfeyo4iAkOJ7Gn5YxdclxpqGTUKW8eIHJKMCcAnIl3NG9b3ToVsAj6?=
 =?us-ascii?Q?G2Vbx4+cAV0/jXdItre4/7/r8csZ22PbVMyAtxY1mLYNTKmeRwhj0IHIBvAW?=
 =?us-ascii?Q?jT1h9sUYXic6lCGkRoHDkAX4UvTQc3V6EuyuAyVN0WZLbAeweJWiPRQLGSHV?=
 =?us-ascii?Q?SjzdUz3QLzZpETysEGko/fS5H/YsTL1Q9uaAH10UmPdUFB7qJ0jmhK9oVYsY?=
 =?us-ascii?Q?sa6iJP1rBXHZQWunxDLGN1sjcnG/NLd9w653zmbB8mqUgEKHQBjPDUkhZObZ?=
 =?us-ascii?Q?4iE6bciTgruUXJjfu8b4KGaTgI9tTNGgbgFIgiHa5ZHqAfetEBp43jb9D4R0?=
 =?us-ascii?Q?YigxpLNRviECERtw4DrHmP278IT64Db3hbIfcyJockfWw6X9/EXAukykW34T?=
 =?us-ascii?Q?MdteVDh7hSvbILOzYFFh/s5+w4X/Ww0Zg1VKAxq/kZR6PUFL0BlhXn7ASugN?=
 =?us-ascii?Q?vn6wKvqf+yikHqvUvJs9VzKDMZMCEZ0Kqu3fhQoEG2X3T3ryoPRrsTqGS64Q?=
 =?us-ascii?Q?klL88SiXHuOoexNZYsTVSJ31bAtDfqylUNwWFbdvx2s9DCX1QqBhC6Ck2JFG?=
 =?us-ascii?Q?lGM06yKJZiSSd0UZJdEsLsa/4nSXj9IGRok0f977kvvsOB/aaxC6g8EuHqN9?=
 =?us-ascii?Q?/1uc1WtfQRtst37yiw1zbkyqFLIC/kPa/hzklVLPWtanwv57m6k6C6jeq9Dy?=
 =?us-ascii?Q?QSmn/1i442elAb83dSUz1TgDtcB7zTpr2BCrczJ+/p5iWNhKwA+emCHOk4MQ?=
 =?us-ascii?Q?cH5Mozim1ZTHx/Ewpr6l1FTnPahwKY/N1bFSGmibI6Cxr9gLZdnh0+voVJ15?=
 =?us-ascii?Q?XgdcCRTHi+1Z87U6EjYgFgVcJk6R2a+yKXLdasQPNG/Ab5XsE6oSNT2vlqYi?=
 =?us-ascii?Q?yXp/dk7yQtvc3fgQ7YrhvPeoxPS6OOMIaespY/ixf1iQXu0bS7ZdF4vt08bb?=
 =?us-ascii?Q?Pxz8vaSfsrQ85+oCHJMA1RV/Gqrh0PSXZcQHq59NWUOCy/gVEDd8e0G5UBMx?=
 =?us-ascii?Q?8voiHDhnhIjjsVfZGrD0klqfELyHuDc5W+G61lT/T5YPOpIoJcGq5mSJIQXA?=
 =?us-ascii?Q?x584wMLTzaTM+4jOABTZrd/mG46mFuNqE+Q+/7unqVZiPyp617EUbDSmYUvL?=
 =?us-ascii?Q?DM4MbzZV9ip5R5YW9DLrZOTcuTzplQVOw2h/+8a+mFkUhXCt6uRVmFHLEu2a?=
 =?us-ascii?Q?hlVeGILqx7a6mEh1bCh8aMC/Kny/kfxVL6ympY8n98e1VbWghuOpbs/dQwsY?=
 =?us-ascii?Q?jGaLukySIY6TUs3thW8QMZk0KHoq0rkjDXubWoCF9btcZOHRz9CiQYdmR25b?=
 =?us-ascii?Q?JYNZZjakFhTI7u+ebJfR6Q/UAMisL4qAH3N7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:10:20.9932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b187d7-e54d-431b-6570-08dd98607563
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

From: Cosmin Ratiu <cratiu@nvidia.com>

There's no explanation in the original commit of why that was done, but
presumably flashing takes a long time and holding RTNL for so long
blocks other interactions with the netdev layer.

However, the stack is moving towards netdev instance locking and
dropping and reacquiring RTNL in the context of flashing introduces
locking ordering issues: RTNL must be acquired before the netdev
instance lock and released after it.

This patch therefore takes the simpler approach by no longer dropping
and reacquiring the RTNL, as soon RTNL for ethtool will be removed,
leaving only the instance lock to protect against races.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index e399d7a3d6cb..ea078c9f5d15 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2060,14 +2060,9 @@ int mlx5e_ethtool_flash_device(struct mlx5e_priv *priv,
 	if (err)
 		return err;
 
-	dev_hold(dev);
-	rtnl_unlock();
-
 	err = mlx5_firmware_flash(mdev, fw, NULL);
 	release_firmware(fw);
 
-	rtnl_lock();
-	dev_put(dev);
 	return err;
 }
 
-- 
2.31.1



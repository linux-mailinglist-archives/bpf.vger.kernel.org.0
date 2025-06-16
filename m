Return-Path: <bpf+bounces-60717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F5ADB34A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38472171565
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CCA202F87;
	Mon, 16 Jun 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="el3/EzQo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469651F0995;
	Mon, 16 Jun 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083312; cv=fail; b=ZaFvNxtQULuOWMSOZ9y6hC8edXVt3Ch7EULtvu3j3tkuW3bMM+PPJRasMowp/bAj0ATebDZQWxTp7Jiux9vUOiv7321wrA29Cr6OsYXB2QSsz5QlvIA3iw/lGYwdc5AJ5DtzaZJ37w8yB3ZOXVxUtDpsPqfpHJySP/Jb0gRE7bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083312; c=relaxed/simple;
	bh=cBpW0vFRslgWmkQZIMvJScA6C1rWhBAhrjH5OfMUgXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i38sSthox7noVSuK13MIEZTiWPvDHb4zvudsD6Hd9IrcbKM/5nbtDweoA7Us6ACLs9CGjib6qBbKbWRGGM7V76rInMeg4iX1nbDVHS0bfjdYeY/gVV0l+lqPJqcdmEVhUnm6QKh3CEXgrgwV+JrZYMj3yzgvwdVH8BAYdczFDSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=el3/EzQo; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLZCwVbtY3yNFI6YUhituEUp2E29gW4qknwasgZQN/SZQPq5EBeUNkB8MJvXObZDMfSCd4QHwdaIRtn8/1wAK0ktFPqhxV9TB3PhAQGxObMhdA4hD7/DCYT/UVyYY5kZZUbwQmU0CvwZlZzJshMWa2uVaSPurmJDp6bodzQUXnRQfKpqqua62BaDvN0krAuKD4N59+wv27MYYjHCIlY1MqZEH50Gh++GW5wJA6JXdu4dqDNtyVocBsawbt+iIMsJKGqcPWZx5yQDcnPuLcyiBrQoePrHe2kWfrQw06s/Jtg1kLLs2LXhdPX2jeV4KpZxr9a4F/STixW+0gFStE0yXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/2UfgajKeaXX5S7CmuBPl6iJeOl68wEF+lSMt+cegE=;
 b=jvE/IzOCUttmIQf7DLiELqR+rh6O8BvNXmV5LpZYkFyj7cO6KMm40NxjKSpSb3z4F+h0SeseI3IIW3/C1cmeZ8rXhiuEVCnuAqaaQ5xVEkVK5LjGVFWV7ZizouUziYD++/9xumLGjG2MKWEYGMprRuyrdpkUWABC+Iv5o3+4qs40Ac5bvtP7DocZESsdNIAJcqLHxLneNCRQqifA/85IxYPqGmE4JsCkjfhQXBexGxadFnpiJcEs2cIkAnEdO/yl4pt7MfVYI+WdO2RBwEndXbBsxt1F9C8bPWQxYrhi/DyBBXKqdjNUmopPT+7czP3w2R3YDD1SmaKdeQgTtaV9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/2UfgajKeaXX5S7CmuBPl6iJeOl68wEF+lSMt+cegE=;
 b=el3/EzQoCxs5qQr630r1Q25OS4A8g9EzJJM23K1LllKQeDixZYAkPqep/7xDM6ee0wgL7pAXYxirQYOEvsD3r8tT6tyUsxwPODcyDHl292ErATlBZ6aBVxgqUpeaMCm/girL5CbO2iMpu5jGXKprOdmvxqh38QykyQ1S5nZ7aiLpDoURIvPP4LloyX9zmbJ0EvKA1ZiOXGSlYz/j+m3xqh1UnXuo7zPsnN9G/YbJV78u5e+ghIiiHBDmbpbGVWxXNOtaahCv8fKnqSzO/WTxrY1rqBxNsQTadinQ/UMLHLJThArVvwKdf6iHFWtJVOXwDCCuxu/T6nyqxEdpCTe7xw==
Received: from CH0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:610:e6::21)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 14:15:08 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::e4) by CH0PR03CA0286.outlook.office365.com
 (2603:10b6:610:e6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Mon,
 16 Jun 2025 14:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:14:56 -0700
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
	<dtatulea@nvidia.com>, Mina Almasry <almasrymina@google.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v6 01/12] net: Allow const args for of page_to_netmem()
Date: Mon, 16 Jun 2025 17:14:30 +0300
Message-ID: <20250616141441.1243044-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cce0bc7-6446-42e8-7a35-08ddace032b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VgtfhgE2pg5Rfqmcomn41l653qAXDlytgxjamrqAj1EmNCahAZezQtw678hY?=
 =?us-ascii?Q?Ux8Ba6R69hVN85D1D+jRDq/obn1SCCNzQbbcMYrrwJGgzWYcYyi008JWLuui?=
 =?us-ascii?Q?MlAoUYsTRJt5Kes+0eJrXUX0OoJ5ZrCGLtSSm1RJm1z2nxNLVXP+f8W7mURC?=
 =?us-ascii?Q?SLbaid2Orp0ip8+f5ozU9GXHOUwohYHeRx02qKmkJEIstAe+rUtQzNIxLCUL?=
 =?us-ascii?Q?mURSf7pCHm4EdUwFeW2mMA9S8g7nGwFXiQRP5C7d6ZBS3JK85vOi2bFx5r4Z?=
 =?us-ascii?Q?lFR01nIk9MjUvcJaUBE1VF6TbsM7H+7GJ0IZWchu7nB6FMGt0MUO7mQI/IJz?=
 =?us-ascii?Q?xBIE1zkpIBIz03BzM9ltKkjeLtDKQJct/nwIVjdZbcuSpQK57LDrV55gHpWT?=
 =?us-ascii?Q?XzL3lEZM3Wogz5lNqsX+QmvHaFGsHrQW95slPNrutVQQbCs+rZarEq11fgAp?=
 =?us-ascii?Q?WKL8nQENDENcGN30QVxXPk0GkLxtJWNG38lqRk54R8K++vjgeIhvBv5Rg0S4?=
 =?us-ascii?Q?87KXQwkUmqUoKoF2hPW5und8bsoAgSVvHOnHXstGqRxOQLtuQFot+GYg5ers?=
 =?us-ascii?Q?ex0m2RAApVjNX7Ox/PkuqBwFR1HNagp79pT+D0jONnvvJwOt+v2O+kbn1Ywg?=
 =?us-ascii?Q?ud8s8UlSX8hZSD5c8Uja1uEu5sCowD+aAgNB2KXPjFc/Sq2H8iuL29j9m09M?=
 =?us-ascii?Q?M36WmCQTFKx3lTuuXCZgsA867iDjwrFRLrxq5lmJ3Mt6lE4W1/WnutURGHs7?=
 =?us-ascii?Q?CIcKfbskVamu6rQgRXrEO7CQrdyLQFjMt10llKcxP+mqtJXGuVhPAQl91vKg?=
 =?us-ascii?Q?dqYuM2JBnRkw4+0gkxP2MHVHTFmtdWhJbcbyDFBucH4QrYYpBBRloKBmiz8b?=
 =?us-ascii?Q?QoLNcaMqFV7gMpTm3y1VoFN8l8kxZCVTmd6xhYxNkSOXp8cUbRDQy+WtQ1fd?=
 =?us-ascii?Q?ca+XxiAWWsJD9/5PzGOLFZsAi2ss0tzjXQ4tRCGiPTvXixP+3ErRrDoXSKU5?=
 =?us-ascii?Q?Wv54hqT9V+YsVdOHCQ4OxQqLcL8UCtVhkMNmGBx2RbQjsL9WyXgVs4gbl1vB?=
 =?us-ascii?Q?jXv/QD28oB+ACa+Yrq3bJ/omG94fNfsivNWJujaXu5PTc//mDuv5nUzUAvpR?=
 =?us-ascii?Q?Fk0uQKledREAFLwViKfL59ECaIDKIwsj5h9LaDo2AGwgY4zl05x9CpUeP3hF?=
 =?us-ascii?Q?ayLMcOdgaYhrVur4ABaPZSttOJB27OhPSei4QPimZ2vvLrXec66a6OgNu97n?=
 =?us-ascii?Q?ZXikaTxsuxlIlavxbjTGJH4usr9rqQ60n1okkkMOzxyUeIn6XTyZJH4M6Fx7?=
 =?us-ascii?Q?5jyYzsLLqhu5CDbxd1k/bJ74lxsLUmJNpg1XK/VJVxfWDdt7ktXL79qvyJs1?=
 =?us-ascii?Q?mcs0qRg1YqKQ2H8+trYGL9EdT9s/AzGdEWtKPwBbqOmQckzAmQ0T1kzapJaD?=
 =?us-ascii?Q?Bz0AhegjOQw9IzggRDiQBDqXPvYaxIxbIuabHTDZUDBw0znwHkGwNGfTnb+K?=
 =?us-ascii?Q?sryapWoH0gyjvWsgyqqrGHZI0ZnqA1TbMuaH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:07.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cce0bc7-6446-42e8-7a35-08ddace032b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

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



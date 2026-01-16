Return-Path: <bpf+bounces-79208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27830D2D614
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3CF3081AFC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382034C9AD;
	Fri, 16 Jan 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHSYJRXb"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FF3203B4;
	Fri, 16 Jan 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549304; cv=fail; b=i/K+/ObGQf9Otl1PhLhU+KHvgiXQVxqA5bJBBwFnZ6rlQ88D/EM1rxFq2K6iHQItzRrCy9/zTklPvte3KcMFo2vXzR+AO1VrOXaNK+jWAA4PLaSYXD4t1VEnaLe+W2RsChIBqQlVocU+RUUzM1ASJUfr4J79dH9vqa8t40hOlvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549304; c=relaxed/simple;
	bh=fnbDq3IQmsUw4K3cOukufw3AirZSVsWl2yaxlA9Qa7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gx5029yQSJ9aa5QXVbCjMvfrrB87Hw9nrZFiqDU3pr5K+uF1/3xrtnLOzGNv44edYmlWRAYqhHPw7nA5Z7dSMn5w7WPwalWvxoLERjVEWHeLGDs4cx/ObZkRlvD3v4gjXB8oZQjNAT/yIW43ZPNN9EM942HLUlYdYkZvtojSyNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iHSYJRXb; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4eAoFiiMw6egtuiBK+D6/lAA59hwbjfzCcdxim7Lo2VwB6HrMJTkKF8zGTyF2UXeT4jTfgQuZ8uLDdaGJ7ikbZNerGliiMqWUMj76vHvUp9NE+8sD7W/Y1gr82PkMn/QDaNmRgHeVKbv/rPvtB2exm2OLkYwn4GM0tjLEkH13bfiQHF7hBako96N01mokc6HiVCHA7qFEdKseYaDxTg37xPkEuphpQEKuFaW130H+Po9xT7MSQr+IQZ/Z1PVDcluVExzTYMGiK8t3W5LpNMdwoo8pm2/CY2I62+2lz4xPcv24/mI+jYB+/lnAigMEi0vzSOeeuKJ+CNqKVUohL/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O4hCL7SNmkL9b9emRHnpbcd91ZfJ4HquHZeblddsaQ=;
 b=O/qtPebQnAxWEvFdozysF8iTETsbLHeCfANdIfCa76tEFAnR4Y5JA2LyTIRZX764TH3qQHJW2zUOiC0AzenmEXw6QWamSrdYL31vMDxUszSxmKZDKW6MsRB1iHjNtfczFqMqSakDHsR63dccDY6QsNr6Hy2KAmsJo240Uq/zMB8vk5QUuakTnMI07uUzAgDYetLCWYieMqsWJbrcsSZ20Lbfe0SeNuZ2H97OVxAkv+njOLWYwSNfgV7PC1h52AswtCeyKC0odRSLU+0+nKY4yjf6J2dlNNVuBfDTdclNZoZAELuI252R17CbZiJ4a70Q1aJIk7aIj+xq3t/ATm1hyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O4hCL7SNmkL9b9emRHnpbcd91ZfJ4HquHZeblddsaQ=;
 b=iHSYJRXbBsWbe8xEaFhBAGIR0yIe0p/bKF1ztqlX3kzd87VmmhuaOfeCLEiRNigDTZLt2XRMsKpiU3P/JfJdbXUvH076KN7By8Nsxt9nZZh3Gqls0kCYaWVXk4C0vpZyn1Q1k8dAMUBTtzDF77GhaoT0D9SU+Y/HKRwqhO4elfgP4iC2Y9V+2kq10dU2O2p6HFNYjglA2PVTpwvJ24J5Iq9QsdsWCgKU7EAaL55qK9LtHlvf53fC9oEAAMkm/fGyrq3w6VPPuHOdJZcnnQnrb9q4oIfNUB9y63b0RbarnCdj/CMSAhtI7Z4jS0u3xUkNhmW9ySFZ/KwKTK61v/383Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v2 net-next 05/14] net: fec: improve fec_enet_rx_queue()
Date: Fri, 16 Jan 2026 15:40:18 +0800
Message-Id: <20260116074027.1603841-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116074027.1603841-1-wei.fang@nxp.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd04be0-1740-4034-724f-08de54d2aaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjOKwuhjbDThlP4iO5J00pu7P9CaoCJaJ+G8rCCgLNucrwKWSyUZbpapUnPU?=
 =?us-ascii?Q?lVuKC617CBosFFD8Tr9TeHWpN/4sooBOiArWSud0ulFvFEzblNZ7uzIB9LkG?=
 =?us-ascii?Q?nuDJsd+DNuUXRx6Txm/42u0Rmc6PGjt5sRuKsjqs9+rkUVqmpXIFaja30uzm?=
 =?us-ascii?Q?Rc93zIP1bNmt08NEQi1otQZP2Ucr0FGKKFGKLzItWkFMU6byoTxGRzLGI7ID?=
 =?us-ascii?Q?4v0IKgEVTHaMYUVMYygjn6XvrCkYB1sHGTc4B3AdmsXCc4bIibukFbVkfSI2?=
 =?us-ascii?Q?5I8D47x37virESOgk3TanLBtaF8kTGmWg50khFkWr8rm3HA8L26r+SJET5im?=
 =?us-ascii?Q?rYu+ECO51wMLPRZ95IaBtFqxRhps9S+HPGwronq33anEUuy5yWJWuUsbbAoA?=
 =?us-ascii?Q?wrqlrrYU72V1Z4zBZByW9RbySafK3b7HzMB9ITi8JVA7OAkcoI8tlp815xi9?=
 =?us-ascii?Q?/tGVA/4W2soWAZHX9p8rfZdOFBXzsP8jx678sm5NztRF9xiLeTOINi0vHKxr?=
 =?us-ascii?Q?6DCjZJKPg/iVZx/Ire+yOxnz+c9zhUfb4i0j/fdTYhTH8KhQQECjgqxvZ/PT?=
 =?us-ascii?Q?3uv9suZ+c9UPKiywcoZMfhtgwjRTUw0kH9Ayn2d7pn4G+TshkAZDTGcP5Rmz?=
 =?us-ascii?Q?TBPNdO4ViCDy7OK6eiWW0pDbblNOJWuhcbLMupnSopKX3YrI98segS3YWQHA?=
 =?us-ascii?Q?lVgUTa9zjHyfhxfhYf+egdngZV/jTGT+CiYOS2v31k0qSYLTKQSZ6dTmpmN7?=
 =?us-ascii?Q?6HhOG421zYO4IsVsdI9QwEVRXx0FZckB8rCxdbR6d/vQtPzJRuN3CvO0iJD5?=
 =?us-ascii?Q?ogcUpdBdsx9T+fJxsh7FR8OfU7xs/jy2izHRkMhSTlhqo5D5GpHdKSc8gblq?=
 =?us-ascii?Q?rOOv0CUkwBuV32MoYGykqkfx+HDbiENnA51vCF9x+8uTcQNBnfZJ6FK37DS8?=
 =?us-ascii?Q?ghOb8WehXhedat3aNOV+5SX31XpKUqk3T1VZKRddOhXZEfW6hDEsLmpNnx7t?=
 =?us-ascii?Q?acxAYGK2d3R+mZ1QIDBW9O5MQBuiUxC1cloX0k3DcnUYEajSfyBJM+yEzPb7?=
 =?us-ascii?Q?3mAz0BycwsO8nqnjc0lVstna+iparFpAfymQ37Y092gk77aVoTFDhgYOj6Fj?=
 =?us-ascii?Q?iYh/mjW8n0mCqt38WncyGhbdPNiJsEr+aks3BR1kbr3psNzvdK8OsGIWbGHf?=
 =?us-ascii?Q?R1wA4Y4KpCkvEs1Wnzf2ZyjNlVMYeJelYwztLT2qlQh54wyWjAIOGVLnXfE6?=
 =?us-ascii?Q?AFYLa0yfyrfrPJcrqsUjEMBorzbrGrCkZIHeUnVse2R6wZDKd2aik/Cvx32e?=
 =?us-ascii?Q?aXBj+hp4vvXHjqKdinhqoIW4YxZgvae2Gn1fpojTbP3r0jX2mdDmqB8TuwgW?=
 =?us-ascii?Q?FrJ3zZu6LDkGKIHQ8Uc6nL/8pJaIZpbfGIkIfQCjpR6PbYlCeINv8sf/RzU3?=
 =?us-ascii?Q?3yz5/5gP+dAwEdSOShEoNfoB6HyVZ1VP3YEJB5aqeoXxwJXizx36C5XYdZAU?=
 =?us-ascii?Q?mPvUycCqdPKEmaH6iGzEAyKS4cJmvB3xD9af4zExYKjzd49liJV5s+upIGHd?=
 =?us-ascii?Q?reniWeQExBAmMjvkZzp/JHyKmRnvyOL2gAof8NsT4KdyRqH0EeRIOU73Pk+K?=
 =?us-ascii?Q?c2eUyCVgNfdG+kLJ4z/TJgj3U1xt7X7Rc4rgkiIvA4DJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtWS0mw/p5sGTl+zlCWo9pnNSf2phAkifKBQIDEhLaP3rF62rL543Vh0+6Vu?=
 =?us-ascii?Q?eAQYVXTTHdm1jiIgXlLNJ+5K3w3mco8yuCGVeC6JQGdn+10/PO9vi1NlqB3d?=
 =?us-ascii?Q?UYNGO/1AkAYkNvLralqmLdVL3AETr+vyR9ogoPGfjY/t32MYnNpmGJTRxEsh?=
 =?us-ascii?Q?SngbSDxyvaZZm1deWt6o3kX1X+YSh1bWIYk8SxuUDEWMjAiuORLXtz4U/RlD?=
 =?us-ascii?Q?lEZl8WcyMZxM5jldVglbQHbhIf+QHkqbpySpBnligZRi09qdeNuHKB6rQKik?=
 =?us-ascii?Q?LgecDDf33O3xj+/FrKxPOZYA6nUOvyYwJlVIl6kslT9kZ8JWQT47hkgagxzZ?=
 =?us-ascii?Q?NAUSCxyc51He5H82D2L5bO15KlBzQXswsJCHrQoXhdJzwaWnisBbD3YiUVE5?=
 =?us-ascii?Q?wMj8wFZsqIUkx5EPAMJg2s/fY4klm8F8pt33WVZum5M3ehgfnIRYuJjvZRpr?=
 =?us-ascii?Q?3IjhHd3MU+kYcoq0BqXuGyqjy8qxtxuFrzsn51TiLvYOIZmRQDfQ3baNzWNk?=
 =?us-ascii?Q?Jv2TulPom0cmy6/D5IMyZt3G9rorzgH8xPkJjlEdHdgdsJb3oLSEQTtSXo23?=
 =?us-ascii?Q?/TPPQVeFo3JD68tcsrdc+hGFeAkih9yLN4yc49a+8npaa7aEHVC6r6n8wxwN?=
 =?us-ascii?Q?jYbOWIlmLo3f4NB+5eIIsyK3jQQBQX5CtHgRNVIj+5/vdQwtnQikBC8aqnfw?=
 =?us-ascii?Q?wbdevRsJKGjzVPKvOJbZG0n/AOBQYEKi3LeC+F7ebNxPIW1OAkwClY46kpz5?=
 =?us-ascii?Q?ndX8ouJ7VAQ/fHQmi2Nw3C6B9W06eBzqgUaYPpgJG0ro4TwSSVjoBFQXsgxh?=
 =?us-ascii?Q?5oMAojiixJ6S6H+R1Bzkkx9KyqEXCyBvqez12Rf3wl+qcBuXGGJYGGaFWofG?=
 =?us-ascii?Q?JFv3Nzlr8rgQjj8JmlLWQCcg8gWWwEZdUZHRMXSXP9j2obdpOtxclM3seska?=
 =?us-ascii?Q?DG2JRCyfSEK/zhRM5D4A/NIE66MEXsxkIJyTry4MIlhLVgoyu/PAR2aNHWEN?=
 =?us-ascii?Q?IeJi309z7gCPapLcNoG1ixtpMxU6H2BjLbAf2IyBYAqrzoz0RmvelHXbMreT?=
 =?us-ascii?Q?wzEQtHarJsFZdPcBD/F660g4Mo9OoSzGiupP4dpd4BH82Kj+mXnWMaWXxDkZ?=
 =?us-ascii?Q?ldmC7bzf+4OYzfbRD72t5ll96Xvvr4r5xi/lLdXkxlskLVhF/HMpCN9mDHu/?=
 =?us-ascii?Q?G5Rc0W1Etziwu+WEGHorRjy6MURzkIQ9ilQw2S1sBQHcOss9oxgsRG4h93xC?=
 =?us-ascii?Q?dGOQxa5TZhwx9VzycHM0w1GHlBHoX3CHMX0j9czlf82qA4J5cUHhlr/6hyU6?=
 =?us-ascii?Q?OMrRyumj01DpRVR7erLr/yCxPP3bfLbTdBEM0g+YeK2TnxCrfLXVSFVGAJxD?=
 =?us-ascii?Q?+y5oFIa1YHAAV1tj85KO6oZwJVS/et9xgxcWOTE5dyBTIZRqtZC/1jGGqkCG?=
 =?us-ascii?Q?Ba7nRuak6LMdFz7ecUBLm3bw0ABpYJilfL4vxfpOPrpSs0Kg5Knsl7QnwUN2?=
 =?us-ascii?Q?FYNaWqkXrqHiREz8gDEWetcdzKJumuCIKvCxSaO1iJZilQnndj+rE9G0rdW5?=
 =?us-ascii?Q?ar0SdNWvDZmNNKDCCJMF7oIFFMuuq33cNG44Zq5QGY1MzKSefIOS1lVYjnyg?=
 =?us-ascii?Q?INawlZxOtoYp7Xmx5b1QJ6c4uy8+vddxEKFm8DCjoSxoqk8k3fbtCgTd6IlZ?=
 =?us-ascii?Q?9Joo/z4Q2j07l6ILev1ydDEFFgazq8FIRUC325d7qNg7bM3KlXuoNI8Yt4qG?=
 =?us-ascii?Q?mwSxHEe66g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd04be0-1740-4034-724f-08de54d2aaca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:31.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7RKW49goPfbsq+dyqtiMj9E0M1lxWS6m+onJsP68LWTSsZ4khGCaXqzw/S2vkzUv/zBeJHvaUwmCsjU7pUngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

This patch has made the following adjustments to fec_enet_rx_queue().

1. The function parameters are modified to maintain the same style as
subsequently added XDP-related interfaces.

2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.

3. Replace variable cbd_bufaddr with dma.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7e8ac9d2a5ff..0529dc91c981 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1839,26 +1839,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1867,12 +1866,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1881,7 +1878,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1895,15 +1892,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
@@ -1979,7 +1974,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+		done += fec_enet_rx_queue(fep, i, budget - done);
 
 	return done;
 }
-- 
2.34.1



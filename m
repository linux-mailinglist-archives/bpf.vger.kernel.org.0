Return-Path: <bpf+bounces-78653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB161D16821
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27A433058579
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3FF34D3A3;
	Tue, 13 Jan 2026 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ty6xMW4D"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABC34AAFC;
	Tue, 13 Jan 2026 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275067; cv=fail; b=rYQ5m7hdlR1gSzOF5Sq1wwmlBYGzwRpHHtLITFW0DrpODzRa21f3lOA9p9T9JxW/n4+l+ceoCNEfqzVEJcUi6Tz5onntm/Qe/LzrCw+YXJd/1yEbwWz7sYIgrByjl+v2oBOHWFx/ZufakMwU1sHKSR+/13mcmZpEUNi0dRwdD64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275067; c=relaxed/simple;
	bh=aAl4tMmdw3j6clf1rJzMLp16ZLIzA3LqdGND91eJ8gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgFWaT0FLCdXhCeW46pcHtrEDFBYioINY+pRNE7YC0iBhbIN5N0KU8nYT9KpDTH3zPk0let9PfUiUvy6XuCdFywj0YGr99zpY0bsnFccpnQnA5iSjGMA1K4e/U7O7ut6vDxzEIxYgnoAP01PJ7Hfyp39TcNTmTBiLxyWac7vdt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ty6xMW4D; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4Z+rQy7VF8rUSkPzzLFzh2M0A26ssVjBKM1bk4HgyWFqDVUmB2Jz0AJ8DGCV+g8EtXbEckasJ26bYHZF8xgmPsP0yOkgTqVPIWKoNd8MeNkFb3whCMHAK4i5n7UXaMpy4vTAD7mB3ipsNXgoW3XWuhuZmUJioe4d6spyIn0cI12l7zyIqzPelWmGx0yDAj9yezii+rRgJYJd2JE7auOq6XFQBvmElh32rF5s0T/iYcpytNE0O68fTDbFDyw7Qr9nTAJncjo8kknzYqecG5O0VdENBDKkF29Y5NfF+CLE1Z5SQlwSSuGSLwc/PfcLjwHGSywFC35ACu4OMnWbCyxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YzMfdrD+UekmSxhzQWegOB3JrFJMc8ToNdJj7Tp300=;
 b=bOSrlM/ws9RY8jjBVRK5pUTdSpGJo3kkzdeGMZJPYTMNFKmEwcjFaQzjMd3fxVuBbdZhzTk8JdqlhndYS/00mjckm4GbHqwAP//NL6/9v/npCfZ++yJEWIrakQyj9X288D8oFPF1NqG9RGBPWn/8yxWXdmmuaj80jdOmJ3ZksFqowVgHr7e9Miit85SXXNtkRj+HrjKZcPMwjeizqhjX7KyRj8dxPZ9IMm6g2XJM5V7vM8vmy/JlCoUuAy2lszXCNIizmfgtGNH1wdaeGNSwDcytIkvCFHlzfGoql1FYN+I8KBHlgXDAIS1entfpi3u0mGZWLXO5bakyLwZp08lZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YzMfdrD+UekmSxhzQWegOB3JrFJMc8ToNdJj7Tp300=;
 b=Ty6xMW4D3hKAiJbLHDJk+G5CkN0j60fg3wsHfG5pwLNTYZrQiaG1qslrMMsEcgaWFucV9collKr2+ngby70Vfb/VtQcm2GC2Pc6nWn1Xixq+4vMKOn6yef1hLA8UgpPUV6uwLYOGMx5S2/TNNTHSWod5fxJmTV5nESCDdxDN1/Zg4xCjvovKcamItZNkKCtmHyMMVgNgth07gJoNYuWS1gcICwVTjDDJFBAV52R0m8D35SHPk01coGX7s7MIYTQuYHVd3wgssdoi8aGZUN1YaODnyYkvlff0A3QNDXc1X8VBkIBcPIdNjIyLGtT9R499pu0Ec91jXo9TcFbIxpNU1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:49 +0000
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
Subject: [PATCH net-next 09/11] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Tue, 13 Jan 2026 11:29:37 +0800
Message-Id: <20260113032939.3705137-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113032939.3705137-1-wei.fang@nxp.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: fbee9a45-7319-485c-07a2-08de52542578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9SFr5Ozlpi+EdgAbaxdqr9ylYybnGvHm7sMNuw7T0ycOOJx2GLEmMP+aoge?=
 =?us-ascii?Q?GwcDHIsSOubJXC+LBrQkbgvpApa0J0fgd3HNGM/59l29T2B6jCC26OhkuKS2?=
 =?us-ascii?Q?Ww5SJSDfT0v3uc8uM9Ti6Iaf11PlT51IcjbD7Z52hgXSQMa8j//um5O0CCuR?=
 =?us-ascii?Q?z3M411mIa5ZXD4YevHxoHqmlfXd+ahfIHjpFFety4b6Fr39T9ofvXzBSPn/R?=
 =?us-ascii?Q?FNN9UF5WHUh0Ng8ojfhH5SIUqDNJTkyN22//fPg7iVsuzWTSKLfA2LH/KA7p?=
 =?us-ascii?Q?WTMQ8TxSljiDbJUOeCJxtsU8TTMdcLQWIPlGZL4RJoDMEdpdRxqIR4mAy+0d?=
 =?us-ascii?Q?7W2hAx/IntdM9IwDgPIYUfKPSqiT1CuYN6Ut1RTenlyYFFo7jLSRdtfwfynl?=
 =?us-ascii?Q?k/UTYRjrQEYSleSLje2jfZYS9xRSx080lOBN54owRRVSMMGH05hf3+ygwa77?=
 =?us-ascii?Q?FyrtZweAE8XpFl5R+XoXTJLMCa/oo93ne+BYXVE+p3u7dm7x/HrCQj6M1jkB?=
 =?us-ascii?Q?Ear+hM/kvyEXDVd+HMXYP9TGxrhZvC2wa9iYaIeu5zdyhYk44prFPUsp6IdW?=
 =?us-ascii?Q?RA+m3Gii6XCpVISyI5C4kyeREdazf+rgTFc2s7wyGknUXFODWqaGETq+IjBP?=
 =?us-ascii?Q?Etmlex48DzDKtaBAyGAhfpvr83nAqq46LewLibdsfYRN/7if9le/6Cvz4+Nr?=
 =?us-ascii?Q?VJwDGKKS/+gSE1tiK0VU0xorV8IrdNQGjZyYomeAn1B2LW+TLKDc1ORlm0FO?=
 =?us-ascii?Q?dt8Uc72FfhjVrn+nMK4f+ijHR2pKV3NKSsKG+zZlOLbkDFGNRfH1/kyksq2l?=
 =?us-ascii?Q?HtN2UJqx30vR6Uh2cm90ZlvzJoO7NRYgtegE26yCil2mnZZXULxgbbNDNHLM?=
 =?us-ascii?Q?iaKdXcFRxFkCaVYriIr3K3HFMvjlgsTPTRSo+qUkKc16mH9URBpiPZOsDmtn?=
 =?us-ascii?Q?CX+D/qxX5CNCLHm4yUwuVG1sQo1BtK8gCvHJtIzQHwmz3CwEt374FdcsN22u?=
 =?us-ascii?Q?pw2g+M6Bf6SRnnE2YXX6dn87QKLxPCmdKMMI9ce1unjvfRsXvidGX+OKc/Sx?=
 =?us-ascii?Q?xmkZaHfSLx1SAlmlqG/tWNQCqJB+GDSUXwdIrvdaXtWbnHWUk0M/F5BchOkt?=
 =?us-ascii?Q?Ibxe7apGnDdPRelXkQD6X5cQO5OxOBnQhx6dSS2M7q5d/YTaFBB3qYflR8jc?=
 =?us-ascii?Q?zEPaQEbF/TICGk53oqbrmtQIetJhoCV9USI8xnhJXEOM6oWc3F2QDFAxL5QI?=
 =?us-ascii?Q?xFwCdV8HhWQYINtiYfXhPz6965LgUeZmFUz+aH1D24lL+ooSD5MBE2iS9g6f?=
 =?us-ascii?Q?4Nv1cpMtmdxT0CrhwVTUoIwdZ6OOsFD8SA0Pjk3ZpdrwFzD/5Kkttk980z1G?=
 =?us-ascii?Q?IMPwBEVH9M9NoXr4Qn2vYbZQ+uRcrcXiM85wCRWe9VkikwkQSrD8Mn0A3ZST?=
 =?us-ascii?Q?qIy2s5iS3nso4JPUDyZLwUmpomWARc87axGhL4ZSgh5nthFBR1NmKMT5yyC2?=
 =?us-ascii?Q?58OYnx2gQNoCTASDEIzLS3JxYh1DTvVPXubJmO8HC2y1UjjbdCzPBV44Hg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8K4VmY65ne+j1FXAB+V3J0sSESjlv3scvrDRg/WQ7cEhe4vc8s/QFR7jh3HE?=
 =?us-ascii?Q?+Pb2dzxt55/8gzyQ0oRn0nBfNiJZ8fEEAlVrdFglw6fo9uERHiX1CgoBQSx/?=
 =?us-ascii?Q?lH/wTtZ98tduBT7tU61OMOlDRC4LYNfkBODDwMBZcDQSEdMCCEW1gIVGRkYO?=
 =?us-ascii?Q?EfoC7DGKDlH2yxkBVbabLMjzdhHEMtqn/NjeX7Br6PghxgFZCdA86aNTk0x9?=
 =?us-ascii?Q?cAqXvXjuV2OFvJkmKy8zRpaYm2toO9dqIpfag0dH/q/bFKU/HxrfPJVkppWS?=
 =?us-ascii?Q?Mr8WlORowdozYqWdQcyzAnCA8k5+MIv9DJlvgmO2ptQryd86FYrae/FJLe6W?=
 =?us-ascii?Q?83lMeiAvsNch7I/sJfbxblWUTfOlekC10viP1gpZzVflgARJx3t4zUVBwhnS?=
 =?us-ascii?Q?MdisIveKeQiQN3+RSik/vtZ0TwfMQWsUnPtMe8LRdDZj43j8pLpzuZ7vAjJC?=
 =?us-ascii?Q?VgEMqL/ZSEp8raaUznKlz6aNPbkrwjhFDsazN9yMzQA6ZuzLU4W9IdBRjjxJ?=
 =?us-ascii?Q?M9TKRzsGEal5G1FZYS5UBzQzEBlcDqyGkhfygBaX1fQLmcmuhBup6b9wWPsn?=
 =?us-ascii?Q?sdmkeOos8wAIt9Cxt4FVirMWqLUYV24LR2Fxv611FaAj6ToW67vOdkYBIFAa?=
 =?us-ascii?Q?BVKEFTSw1/t0kCy8Jx0/u7QdHI4uDAgmD0DY/1tvo2ZRLmuP0FhqEw1Pdsbb?=
 =?us-ascii?Q?3Fyon13tnGBPAYxMqynXwwlOxeL3FK0Ho/ge7efUSZlje5HokrTUV+vx+FoO?=
 =?us-ascii?Q?s8zI4yJDu+eoMe/+NOPxa4euJOcaoQ0XN/Qg/LaDcbFnjDVnhS8orgv/BfP1?=
 =?us-ascii?Q?+e/HbkU8I6XLgUbnNc/IwllLcwspuPTCqFJ3Y/mDPLuU0BSkDoE7WsUNjkXo?=
 =?us-ascii?Q?ic7757wGVTm0LfCUOE9xNv5zJt3cvsD0t+EHgvsSvOiS95q44L82g7bfxND3?=
 =?us-ascii?Q?ButhaJZDncHFF+BIgLkWT5r4W9CvzQ/n+6td+3E0JGocg0qUKHLM9XN2XNCd?=
 =?us-ascii?Q?CwhQZSNNuWQW7YZ9xtYHTko18ul7HhhDibZrDzmyNTzPIHlPxRABXi7ZZJUq?=
 =?us-ascii?Q?7O+ZuNErGf1fSziBGBlIzajxATXhKB0tj3jFyAnBOlu0bL3j2Tw6BqQ5lJQI?=
 =?us-ascii?Q?sjxY2pmmiDtdFNQ+KUjxnTCnQDb1FORpodgyk+/8nuEYG93hEmKp4U1gXFS7?=
 =?us-ascii?Q?owCBCBdZAAjvr8KV27glDdGzTqqY4ODYsLt9maqoYUzh5UEPQ9ia1RBluekD?=
 =?us-ascii?Q?BDAY0k3UZSdy7etuCx/VOS8DaK2s0YLB6IdWLTpELoZroA/VcOsIkY6/2oDB?=
 =?us-ascii?Q?91J8vgFnmOWRIOcvwdJF57Yx70PFRthGe7iiFrxfCcs7SYkXfzLUrhXTkzxe?=
 =?us-ascii?Q?4wNLevnEnwbBLlk2Rq7z7pW/O5GgNoLOL3KPKB2OcgTJArOS8K/xOCImA3k/?=
 =?us-ascii?Q?2Bf/kdeRmOEH3/yMcWJu1NSgHXrbiA6o3fcJSljBTPpdRPNL7aPYQCOqTcqF?=
 =?us-ascii?Q?edpWXrRDRbeN4i2GzfPdduVtO1nc5RXknq4RQ3GeHLBvKDD3fTXqSEDDzXpQ?=
 =?us-ascii?Q?peMY+U3M1OAaXoOdgt49/etQn638hFy9/Dt4yLkCn+T+Z8hQ8TMtS1WL8ITf?=
 =?us-ascii?Q?Ujo5bUA8D9hmPysqOsHJQr5Ev8JMUTOy7r1YPtLz+Wi7miE7vMMht2y1bkLK?=
 =?us-ascii?Q?1VpkhKYIk4Faw/nIAuCFAIvNz3FqFqffv168Z9tEDIuAMllI2e9ooQ4I00bs?=
 =?us-ascii?Q?XTlQCdmgYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbee9a45-7319-485c-07a2-08de52542578
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:49.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlArsr1rqQyt45/CCRjH/z8O+M4KGdvryXm2sjwQPvC9WPdx1jcBeq7WMFbZRvVnX3QMLOTPHqo7OfFWLSDXkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f41cc26d1a46..9f980436bb5f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
-	if (err < 0)
-		goto err_free_pp;
-
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
-	if (err)
-		goto err_unregister_rxq;
-
 	return 0;
-
-err_unregister_rxq:
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
-err_free_pp:
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
-	return err;
 }
 
 static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
@@ -3403,6 +3387,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.self_test		= net_selftest,
 };
 
+static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
+				struct fec_enet_priv_rx_q *rxq)
+{
+	struct net_device *ndev = fep->netdev;
+	int err;
+
+	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
+	if (err) {
+		netdev_err(ndev, "Failed to register xdp rxq info\n");
+		return err;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 rxq->page_pool);
+	if (err) {
+		netdev_err(ndev, "Failed to register XDP mem model\n");
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
+{
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+	}
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3414,6 +3430,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
+
+		fec_xdp_rxq_info_unreg(rxq);
+
 		for (i = 0; i < rxq->bd.ring_size; i++)
 			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
 						false);
@@ -3421,8 +3440,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
 
-		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
-			xdp_rxq_info_unreg(&rxq->xdp_rxq);
 		page_pool_destroy(rxq->page_pool);
 		rxq->page_pool = NULL;
 	}
@@ -3577,6 +3594,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err)
+		goto err_alloc;
+
 	return 0;
 
  err_alloc:
-- 
2.34.1



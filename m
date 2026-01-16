Return-Path: <bpf+bounces-79211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC7D2D5FF
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4D193026D85
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B534EEEA;
	Fri, 16 Jan 2026 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nb9T/QOM"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936034B197;
	Fri, 16 Jan 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549320; cv=fail; b=B5yj3NngWYvgzUOjLR9EDy66mN9u2fXV6LlxLprE7LT8MTYeIel0vw5XEFer3GVBNa7i7vrGv7U/WaqhBYLdLljM7fV/3/dyLtWvK1nGKBwP7z5/2db3KbgUC6FhpEyHKLw59yAjQ/gwaJH59uqGhU6nFkYX3UUFqK4dhOHca1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549320; c=relaxed/simple;
	bh=D5vr49K6TfdRvKoqCmvSYMzLNmtmCzeLU5+EyL73ZfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A80FXPhDXaExcI/rQBcDGzifCbX4nJMulIBjQPGZro95zJX2U5DP1XIguqy+6+3wUXyph9VtZCTUKZzaJWfvzjTjmAzTHF2R4wewEUnVV17voGbqeXxw+IPQM0X/Klpj/9z3FHJrT+s8dhEbF1RkwfD+hw7hc22nzjWQNgxOWX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nb9T/QOM; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPo84xZlu1RO3wu8+VCFSGvE82eNcoPh9WfZh5Cd4kv56IuXn2wglvzxjQe8NOsT/d3L1YlP10vJXI0DPeYohqIhkWs5Mll6GJo72FnuQ6AZMy5FVHWRnpQnEf+4YldP9LEo5ZB7PUuloTX/Hg+5UzsNo8KCrq6IS9AuQEGnuX4sxaaOi1stGZgTMk30ti2W+dTIBo3RNoF/ETyD+hQMUHU9CNBDt8oyD5hFPj+qUA09yHDEFoo3jffwf8Ob/WGz3b0AD7mFnLolfVit4bWD/30crtBYDpkEGPIqz5a+7LtzVlR7qcS8f4EPFyHdDHtRIIjaabyCoHTDpVMg692LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3qAXLnBzqHFpEtnKJrl+vnb9ZzOPrPyURt6l+ydAKU=;
 b=NceWQzv32pFncacFRnfYyyOB6AEjtvFvlqGCfia9hCgd6VxoC12RxLIJDQEPyoEpb43rilwRxqJzqW7T/LQOQUhkGkKZ9UGhGUBJK7sckKKPyQQWG/iujA6LgBES5QRJRjMe6Aio0HgsdhzYUOTRyVKUCkJ8mtGL9wwAtyVoV+lolOSOgoK+q4JY26paSKDtNFiOPztAi3e07g2J931fUzVQvvrfmO6HC/UShaBwFyr2AAFgGwsfUNJmKHM2BzjKOA7E+/nZ0t4Gdb9boc1d1+rK2wRunjCakqtEPTpPZbepYBkoc3w6Xs7YPrf/tmdiCQHD7nDCx883gnpzTJt1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3qAXLnBzqHFpEtnKJrl+vnb9ZzOPrPyURt6l+ydAKU=;
 b=Nb9T/QOMAAK/gFZN3I7VjskppkeVozWkCk/FO6WoU3S4glxhj+6nhCPecBC5AF4OAGqpc+Pn2i3sOWxW5Umr1Y4UtjT6exsZ20oyRNIfdDLLU6uYDKtvcslusC02MHvSGAGz32IAKxjsXtsDIjeQ7C+UWXp6eE8mkTrJCLJs88he0EEl7OyMU1kUZcxjuA39wT7nn1knAcaq3lBz21RsFtijmlfze1LD97Y7LVEW2AmyJPmk4mW0R2rqogDyKyIj5sID7ST5iC24yNyJ9OS8+2a3Qxp52klyuApvhQw0ZuyvQfNzGAhonMexzbjEwb3uRo1x1FEkCFOsGV6TE9EmAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:46 +0000
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
Subject: [PATCH v2 net-next 08/14] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
Date: Fri, 16 Jan 2026 15:40:21 +0800
Message-Id: <20260116074027.1603841-9-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3b82d10-5e44-4cac-fd05-08de54d2b378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JbSnNar2gPUZjpaDsQw5aAQOT+W8/tsGNYCRJiHZbMf+aKz1Cc9yrLGn0ugF?=
 =?us-ascii?Q?FbbYgSQa9L2ABbsI1ZuFeBTDpK+JF4rEtjPKmb88c/TPoKcLCW7Y78xPnJ23?=
 =?us-ascii?Q?HKlQ9YjFUXdwJLWuscz8lldlX/o07iKCyvTofoioBqhgz31CB29rGkhj2HJ6?=
 =?us-ascii?Q?4aacaem0U1xy4uiw/VFlm8QAhr+1iKKkGRdFMPUeJ37mzVMKhWec8MXJc29/?=
 =?us-ascii?Q?3CCWOtmfpRX0pUGspg4KdhXHORfHeNizd0q/17PXBx0u2zZCma6J8cH8D5GA?=
 =?us-ascii?Q?Jg6H1UISZ6AhoSgicMb8AGdLtTyCT8sV43ADsyMapvF6CcxinMdjWMKLUdAm?=
 =?us-ascii?Q?vyxAAnq8Xml5HDicu2N0V/ivufG4yKy8eaLkSPAb7+PH2NRXmXsakBa37nBR?=
 =?us-ascii?Q?YGCPd0/OKdaVEF2oSQzRhBOGRvrKXbFVcuRRyxqv/RdbiX6ePhD1pJiNckkI?=
 =?us-ascii?Q?mg5Jb4rO4zDQGtMKUOHv6cLLkMrenMC2uobTIYLJJAta/REqzhYFMbQVJMXG?=
 =?us-ascii?Q?7Cjuuh1yMu1TF396Vyjqc8IRdqIkrQWATE5ERUh3ZCI2u5yNObcw5NYASZL4?=
 =?us-ascii?Q?snt9tE9xxsSoXp24TN+tQMA6B5A3yZ1Mm4bQfgnQ2kG+j2HDLg2ZZRUsMV6n?=
 =?us-ascii?Q?o1i9vCZ8eeQeyoDZYxEWeoV8nMXNRxuriafJIkha3h/gc/KNc4LeYFEYyr2L?=
 =?us-ascii?Q?BRvAdpwWTyZibmt3i6/VRI0HepN46HXee17tIY2jWKpwq24WEuCR0Xr1nXUM?=
 =?us-ascii?Q?YiVxHwo/SQmChqquqRiKcMVnWtUxIDtZylBCgwQj+iv6TW05k/paDDlWdoYx?=
 =?us-ascii?Q?m8yDrs+M45Jmu7P0u9b93dGt9eTRjFF7CqEyqohB7d9S+hEqPvcXyeDaCNy+?=
 =?us-ascii?Q?8oHYKdvd7E5MkvqtUoMJzTVr4vmLE/h+Pb1oMQZxzAG4J5GiDIm2wqJl3kx3?=
 =?us-ascii?Q?lTtqq+Vk3k9HuXYCRQRqZr0CKk2JJR/UxGxOXufdUZpEpJbNIDtr6Ehm4Gkl?=
 =?us-ascii?Q?7+35A+DcZ7Z82u8fB5/6A7ZXQ4Bb2DFBFJRRpR0abCaJtIRrSpeBkDTWn6xr?=
 =?us-ascii?Q?IkU57Dqk8MnxlKvVAsJmxjw5KF5aCqsxnc7KHk1T95px1qZIV/pXO9/8g0ca?=
 =?us-ascii?Q?9V2LvQJc32JZIV5dOeLlm/f9VkGRAAlFwmhNZIghkGOXOHAo03CXU5cH01dh?=
 =?us-ascii?Q?06WrdI9iJKQrZNBVx36FurxNfA1LQKfat7xT94Fhlv927GhktFMWull9HZ0z?=
 =?us-ascii?Q?PqwS78DUxEQqy1OZGqnT0+gRE8CR4EJUqgR2i7y9TcrHxxjJ9pAPfeavRQkR?=
 =?us-ascii?Q?f347dHtj4T/3FSyEOl9recJ+pIb6Dp9P90EsebRli2H41OP4mNzvfXNkueo+?=
 =?us-ascii?Q?QJ8EgEYWvDsSStTnciPuxOygsXvb4gPQsKExUILfujWoQoV/4rQvm3uV5rLn?=
 =?us-ascii?Q?IxMbGhAc06e2D8X//Rjfbwde1T4dM0ttA2bAxkYG2H+vO8zp1GQhQdyJiVqL?=
 =?us-ascii?Q?gIPb2Hyl2jZcui0zJn3R5F0mFQ1Fb5wV6dV1Y4uwKzunQfyV4HYITX5xH0+C?=
 =?us-ascii?Q?tE8SuMplOBr0LuVdk7qaQC93XZyvI4uhl9bhhNkR93IIPM1TgthZkCugPAKs?=
 =?us-ascii?Q?PzjaeXYr/6UaHzZBJpUldnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5e8szfpvQ7BNlu7k5MDuILdNGutB3XLJ6KkpZ4WT2Dpl1buWYW8NX8pvJ3oV?=
 =?us-ascii?Q?nf4uhNGr3wf8GB77kWXpJahiXQn+nUQ8zIV+5MlVeimNeDoSdGherpPf3OEG?=
 =?us-ascii?Q?PAnHjW+yhp35HdWDWsTUk62bf+rOBFZFaBXLYQzsb21KDh52DJ/SAylEKv88?=
 =?us-ascii?Q?dZXYMi6DEw1KuIXqPLOJm2Xx3n3juqbOcwtx87szMjGFDlt4N3IsiFwCpUGl?=
 =?us-ascii?Q?t5Yk83skUcbZnKxoOmGms37TOkCI7imyFDDCfgHwgVjf9uXnxhWigiRDOiLW?=
 =?us-ascii?Q?Q/ccddHhwrN5lal5BXHCutjVeDBZKiVC4DkXM3dF/gS7Lo2QnhJhIIYriguT?=
 =?us-ascii?Q?tk5QhR8rtBJSGdvzeHqpbzDNu6th7kbLjkCOXCjsrLdmOOb1GL3/R9Fzw8IV?=
 =?us-ascii?Q?jfpasDjI2w2MCKk28gfxR0K1bDb3yQHSZ8iwiak/FKtrx79WO/NfAC3qdym0?=
 =?us-ascii?Q?puCMy7ANbQkc4t18VILsNreyUsPvPBFJS8k/IdzOl8O1qxxRlQZ2xWMEUAuQ?=
 =?us-ascii?Q?bfBJ9wRdiaiTvPWYE5n5qqwmHLJI5nuhzLkQPMEN6nERQtWZH+/6uQ2DofRm?=
 =?us-ascii?Q?5UJZ0/CeIHLPYgasO5UE8joQV+lRwZgd3DRl6JfK7QWLNuLETrQaKT0tBULG?=
 =?us-ascii?Q?KOywl6QRek6FQRyfBV4vojNivE9vJVfEYzz3ZpUSuK/aWbfidJbcaZMd4u+E?=
 =?us-ascii?Q?yvnSAbU/cu43h99E6iPEGFKZiqJKPncDo87knzmq7tMXgV6Hud2Ln+Q8hcKR?=
 =?us-ascii?Q?5pjZ3ICTFhng3i/ZZSM6sv3WAqLPGPAGp6Mk3NVYFU5TVmxTIbm8zLzjRqgE?=
 =?us-ascii?Q?9kJWhwIUi+m+FpJ/qTc5rjwU71ODefsluddNLu4RnZD94J7ng8ylzWGuaQTm?=
 =?us-ascii?Q?8bUqOBoTA2oTwfLWszfTadn7ISGcINCqSSsEue16kJjvwqX3Pwxi0HuTypE5?=
 =?us-ascii?Q?JrX7XGjHAFzpXDpQpmX2p+lOWWHLV58GKmo2Xqv+ueMIQiSsUlk/FizSM7Pe?=
 =?us-ascii?Q?NvbPPzoI+dan9hLirqGnuwq/wzi1VSkL4/RI9fCahPkH+NOz6bOUh0kbQg78?=
 =?us-ascii?Q?Gob+J5jOqfs9nT4y9abY3IgzquufCRony58L3HIyR9mZiNXmp8wEcte37Squ?=
 =?us-ascii?Q?8ybPw5qj6YpN6FEsHgJuZlAiT7xSjoneQjZJfN0j1G76Uj3Z8LFfGdJYfvmC?=
 =?us-ascii?Q?rz48JXH4voZIfT23ge/hWUFyvBu4eCBMdKrI7onxaktmmD3gqqLTaP13QBZl?=
 =?us-ascii?Q?eslarE+2RySojpzHPkJBjJPqvoRDe0TXtXAKQmlVLMh/s1BCKD2wSoPZ5GO6?=
 =?us-ascii?Q?6UKWRkDMs3N9R/RzyFma6nZdt/nEmaT84vhVOYQ3rGgNZ+vhPy0vZtx/seI6?=
 =?us-ascii?Q?0yjllHLG6Ub4csvQ0xnCxKZRgOvPowz+zoV+zsosePiDCZXK2iftLE0pqJZV?=
 =?us-ascii?Q?pTzfQI087bCEEju0iIVmwK0ZjArQismv9ULUfBS7Jj3keg/CuCGAfAmmeXTQ?=
 =?us-ascii?Q?DtdMNFg1/BMgvCPNSzIZSURHj/g0dPz4UFidBkl1N7wJ2f5Jyz9BAMJ0fIQ6?=
 =?us-ascii?Q?IPe65k932GMH42wRI1x+neCbyMdATHcKdcTgOFzMqxSkssLLfdqjWz52bxeJ?=
 =?us-ascii?Q?4YNYw5Cns+cEN2UHX6ltypPCCQLZqg8fHARKJGvU4pTQgsNwdF6mPKqxQvDW?=
 =?us-ascii?Q?QqZksE0VPjNXt3n1XWsUZEWlh1YvFxSB+loQZEoi9FBS/dO5JC0RbCBh+S1s?=
 =?us-ascii?Q?RihdeSy07w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b82d10-5e44-4cac-fd05-08de54d2b378
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:46.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS+hN66PZWqXh47+W38Ues+WSMALVyQckGZj2qCMwxDhrwc8fos+skUDDs9PB4Fwm2n4iLnW7Wv4301RrHk8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
will do NULL pointer check. So it is unnecessary to do NULL pointer check
in fec_enet_bd_init() and fec_enet_tx_queue().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 52abeeb50dda..0e8947f163a8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
 			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1537,21 +1532,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 			} else {
 				page = txq->tx_buf[index].buf_p;
 			}
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
-
 			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
-- 
2.34.1



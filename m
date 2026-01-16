Return-Path: <bpf+bounces-79209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DDAD2D646
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C964E3091570
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90D34CFD4;
	Fri, 16 Jan 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MgbINVPL"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BF3491F5;
	Fri, 16 Jan 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549306; cv=fail; b=sJXpSf9x3ynEr8uK1RaD8RDeAgbM9gPJouvHLlG9zjg4afuYA/DnJZ2dLtnnWs/lT6nxJjFbUsJqJJfa6sqYV2pMKitIaQQWOAiHEKwvfyZKHyiWBXvGuRro4uAoEBk37aWnycT7R9sHDolz3kCk85grsjIWNIzrb9fs64JTdW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549306; c=relaxed/simple;
	bh=l4lHLh9/smNt/RWmhWUerBtpc3RS/UHfbphLrlSJHPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GA98RU+S29NZvJTDxk0GKi/r1OSrWz+Y1lPuSQy9JYzlPwyi2kOsdSfx5Al3aYs0SskKEoXVBwnfN1WUxvR4L+4UjuHE9yYjA1Dvayi3J69dBIhpx0PqpOgShJ+UqyiaREMhrqfDfyY/VQAVy55DbsJDqERqlR1qCDQdYlmcRR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MgbINVPL; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqjVpFgN5omWBTUM0TbO7KezUvqVJB54OyXWCUARxjgkcYsbhnZWaXvOrCss8pqGwxmNIEKgIxt6+vgskiqV9zppf7RLsLCNoLmJTCdOP0TbWzBVOJg2ZWe//51V1UZTqnenluaFo1VZcZJZjPho9ZmzwwHoxG2/UtWB2ERRxI0KAcuJbljq/+t9i7pLOso3zLa9wtt+N8B/NHkhVNDdjlgluDwrMGYINz3TvpMXTaRQdES+EJYMU54KpqvsASIOt2gLNAMvn+9b0rui4V0RiEJyx2OMb+HDDj7/2Moa6gcvIAtfAV0HOt/Q1ObmM5efWUCsR3vpDL5C4vOtB4G0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7UwX5AmZ7d+NxyGs09/DVZDtQv3MnzyvIdoYlh1Ajc=;
 b=k24gnSxcx8Zb+MDEBeEPPeBAhRjjYUzibrfMKMj8myxqpZHfRO/eUaMYVHlWeev/+ElUc0oYDVn04bkJ03LfyrQ8pHuw+PzIA4iJ6Fip98wSTE9h+N+gd1gRTZzZZAOpP2+7mDRBp888wDBYOMW/SFb/usOvXSB2lvTUZ+thh3l2uy7LJdhPW38Lox2clBJN5pvAo5KVEaTavMZGvy5dBzSos88NtAGpGyIk7IwVCgYE1l3hBQ4Wcr/NpkozGHRfbyJZzUM9BLH0lUMkZlZMFcurmPrLHCAlA1VEwlskvK3oGeXXiY6u0bqUqKKADPYDRpXeiI5dJvBXL978DdeIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7UwX5AmZ7d+NxyGs09/DVZDtQv3MnzyvIdoYlh1Ajc=;
 b=MgbINVPL4yl8QAxmB2NihtMMfHbEw68JFTKzXtJD/5jsYi/gNr8ObhBDnvydEHVM/kgMsD9rVN6g+WIlmqWNp/jSSGgcsBTdNVa4TYF97nyj5rteHebokB1crhHvjc0xnKT6WZin8QNYFU+6G3tuArD8mTZKccWKCaxZ4zpFsBzEhBRAFIcIe8wRzHClnKH2VdM+gn3eKI92LIk4BQcbB6JDVjbRyPnf6iXmarItSXAIwHQj0trdCWQh34hoHDfZpifFrvyXuvtJ3vm33qO/2WAprCPCSveThwrKfVTaZEGqZblzuuuPtV8kGh1Y0a7b9H5maQJOBo5n0Mc8EImR1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:36 +0000
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
Subject: [PATCH v2 net-next 06/14] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Fri, 16 Jan 2026 15:40:19 +0800
Message-Id: <20260116074027.1603841-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0114ea7e-b854-41a1-6444-08de54d2ad94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+6SDqeO0hzYnQyTI5CGtAbZ3dQRhjCdkrEqWzi5flzttL+AxqATCotyKTR5K?=
 =?us-ascii?Q?JaMVzWcv2oavxhYXAym3IC/+3+AXS/B8UoHr0UOrYDKcQvMezSH5tg5RQc00?=
 =?us-ascii?Q?zPYojZ0rVdOpqNrNjuEPgvXG/9AfX2BbadvTt60KE9UkBLjUQkvqImg3L0Ov?=
 =?us-ascii?Q?EpmPl2bhiqCPEA5ADbZY9OxTuta7Q1YAMhTdGCveoM1zeu8pIJNFe2vrYf/O?=
 =?us-ascii?Q?069Az3FerhCzGgpgXi0htWb0zVfjYl5CdsZADfvRpgkQBu1MM7RR9efZZM79?=
 =?us-ascii?Q?v1HYAY8XxOMogPwxQL346FafBMvcFYnLJsQQN6kmOg77OmDhKUp7Keq6sQm1?=
 =?us-ascii?Q?6V8jFz9pjBS8DWbULbF1KOosJ/u/93ZhtsVlXP8nrfmVf3wnHllz6zMd+o6p?=
 =?us-ascii?Q?L87He54uacpttK0ZcufVyXKyNa9dgTjqIVCUgLdoZGRUpHA0nCJZo/qOsSCi?=
 =?us-ascii?Q?0U0Of5hEXI0jZXNPxHEfjnd/nCEsOx8nieKdSkCXydqhp0mNiy4GifgDSEvJ?=
 =?us-ascii?Q?b84S1jp6K+E5C4K3fihQpVkIDzvdP8m6P3FMU0ad3Xao90hadSAJRUdnfQa6?=
 =?us-ascii?Q?sEoVS6XU7dvjsKytK8MYeqYsT4Bh4/xgKbDy+dMyHZew/vpnhT09VCbNsQo3?=
 =?us-ascii?Q?weT7Jkxd3Nv0xqrOHQoFxfnDgZGVggnrBs6njYNpxJVpNiAkWAeW7zyT9ovj?=
 =?us-ascii?Q?/gNUCTTXIs/R1h1Bz0L/FWjEdFrBbhMl7XDC46fF5uQLDPflWuOpuaw1Amqg?=
 =?us-ascii?Q?2ScQfDAZJGqtnr+Lzgn6fhahuO5WybQ4SYPAHox+nWRHCNgwpcqiXfC6i8ZI?=
 =?us-ascii?Q?zk0IO4RFn9msa186Y9PwTiCKkKU9pU5sBLHZ8WvMKadmGO0JaWzyUhUcgyXD?=
 =?us-ascii?Q?ZbzmqCO552+UWNc/muQzQxtH13EZMJXoKUtWYuF20B4Eb44QbYt3n0d/62gE?=
 =?us-ascii?Q?Bnbn82FWf4VhBe69Pyrk7UitpbXzo004mLciYOsu2GbqqacxIKBe9WS8SHne?=
 =?us-ascii?Q?PMYCGR0Fi47rnmOTONEF12Pa3eiBkLQGVX7akkTAMGz+Tj0Gf8uU/kvcN43j?=
 =?us-ascii?Q?tI8s/C4CZFgPwFF3R4sVQcg9uTo3LbfGxkXZ65pObt6t8sdCRDJVrnYohwEs?=
 =?us-ascii?Q?85MsJ5kC+lGTdpk9uqlXgQk7ySTqrzlD3PVTqnYZW7T3pvFMjemrSNuCpEg8?=
 =?us-ascii?Q?gM0N1rygOeVxKjDlLZ37qUPiD3lzldxedEpFq8GSVvJW0N1rwfcTtT7/G+rV?=
 =?us-ascii?Q?PsMXBumnUMNtscCJKT/hOFutXwN3Mkmf9v4s6wbkNpf783Ypsxqa6wnO1tRY?=
 =?us-ascii?Q?ZLTtDy+RDeE2ArOnJfru7DMMxTDCiA/vnB9ZfXNxhHEqqB2xSEN83k69oIjz?=
 =?us-ascii?Q?TXHz+8Fx/KGLhWfxPYDJuXNsYKuUsG4ChZfQmTSbLsHB3cXmQTktePux5QLr?=
 =?us-ascii?Q?Vr8eP4YhA7F4gd4eIYOU6/iYeXL8UxFE0vwfMGKFoxCleVj304RTUQNbZjBI?=
 =?us-ascii?Q?sb3EJPQrUtAIbSIbga7Xh05ZpiLMEeKlhtAJcgj02NmphkOQxN3QkN0IHFYF?=
 =?us-ascii?Q?u66Y9/Tp+jTTDnCQY5zFlTGnotUTYBSrZEzs9vYfpdseUPqFG858DSgu5JJH?=
 =?us-ascii?Q?+BpYkueZhK9P31YC0Qaf3wTE0tKZt6VEduEGwhcwYTQh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0s1rcECXKui2rjGYsqnvRzotBRlxo6J5Y9oxH4C/MwItE/3PRBL90POAOfws?=
 =?us-ascii?Q?qTaMtu4uC1NlZLy+EArBtbX6euxuaZk1y4qZJccBh95/ERJN55Z7+MegywYe?=
 =?us-ascii?Q?NwstoWmPu10+hgPEAVVBFgXU9UuYh7qN2NRy7LyloQElPYiRw6PxrBQcQ9sB?=
 =?us-ascii?Q?lzEU75H4LUVwm1Othr4UhrKhGdzBFOB/N9u0dL50kb/H+1eXZlbvJyPBRM96?=
 =?us-ascii?Q?d2q6erbcKGzDaTZfmTbksK1d4gfzQRtaQrO/xqkYvtUKvwiagI8sRzt8BXdQ?=
 =?us-ascii?Q?ZA5S6foNsiBO8JurwjXICABsX8vugIqChKOLipAXewgyWGv2jnN+PEqV5Kpk?=
 =?us-ascii?Q?bXg44x8QVxURFZLudUIRalSPTC5/Uhaxw8ABC0u3cCz+XbxQeKGRt1dw5OK6?=
 =?us-ascii?Q?szg3lEMw/u9zKQHUy9SfJcJ11uvU/JPIPoI3dO7wuaqGEobYayKYPrZf3+Nq?=
 =?us-ascii?Q?RlxOWhylzkXU/Vk7PJp8YQYYeXUB1tAMcEgLbpmniwgQ4lVpjRKipID8tBTq?=
 =?us-ascii?Q?jBWpV63Bp1glSWELq8K7sgVZHN+/L9ezoIa8R4xoa81de2Wk8WpM0f+6tyHX?=
 =?us-ascii?Q?rW1ztvgeDGXnnRmNgs+7O9SSUjixvN2aV5FAYY0EDoyshszUQP5Ct4IO7Gr2?=
 =?us-ascii?Q?wzQ7qak75VLHNBVkXC01AkAtNVMxnMOZ4MwJiiVQaHgXsgtwedNLQDBJ/KVG?=
 =?us-ascii?Q?Boi6K31TfF6X9OXgTcm7g14mMnQb89UIif5sVG1uxuPqi+K8dEliPwMBhrWo?=
 =?us-ascii?Q?MzRhZuEhfe8NXvZ+uKtWKnLidLez6sm24xRSzy3A1iUTQxeRMz9D3Z/spcnr?=
 =?us-ascii?Q?2YWWSt0m6WjruGnQsymnvnY7anqHdhiC58weGleXmcK0jxD+ysFUpGxi7E3E?=
 =?us-ascii?Q?Se5G4UGYbOtnXp6txBs0ftnCDUzqGk5ew5uN9QLaGmGfpK0shokHd3Fs1Yb/?=
 =?us-ascii?Q?YNbxOkT91kw9gTDn21U//ju6TAD9a5oSjb/+9SDcVgL+LNNNoG2qCzZPGKfj?=
 =?us-ascii?Q?oob0sllDoylU3pjWeaPrV5kr6BVSqlF5PLNqGS286McSSVfzy3W/dF502Khv?=
 =?us-ascii?Q?A4aVdvVYW0QLAk1C3IFq5MDVtizkgtqZJXuEs4VJLvmNdmyV18z7hULRc4r4?=
 =?us-ascii?Q?bDr9b8OWGj6bCH+3AstgFpAkBXjXcER3WAdcfw2clHJO02N4i772RqtmhCQb?=
 =?us-ascii?Q?0mz5AWykkMDo+tHUOwa0HvXcvuvLdkxV4UUKaTMwiE3i/lnaTWnEomfJSES9?=
 =?us-ascii?Q?xQ4NdCYdFM0Y+PguNqxVRw2T/vmPq3QgpsPvtwRqT7lhUptGgJ3/86wLgnpH?=
 =?us-ascii?Q?oY8h/j99XvzST+9Wj3RQO96nzeb5FtSwoImtZOV0tEtvOAFqwqxlJyArv5kk?=
 =?us-ascii?Q?85476eO9J4vYMi9h9ymkoP0z+RqqvPNJlO48Eg40x/mhTguIz4TEzuE3BPWi?=
 =?us-ascii?Q?Hv7GpgKvoTAUVCZreL+Dj9iA/ZK4clHtr4hwUBW48iHL+dccjVYIDarGMVAn?=
 =?us-ascii?Q?m5SswUT1d73nLy6eNqSCNE7Zrbn6BXtdslNw351Cm3XmQwkYM2pZEjhXH6ZN?=
 =?us-ascii?Q?6YDhFL88ZuyI4rpVd/Abv/h4czqWH3eYv0uizESvaQs9rW+CD3adK/hwpFVv?=
 =?us-ascii?Q?npQ190A5EYYeLZS9q+irG0e28xEozutpu41dl97whj0KB0ezsEz1sXI9QKi5?=
 =?us-ascii?Q?99p6vw7N3Tq8AXcbgaqgMJGQrHCkvzNxyXBi2Q0B/+pqXG39S1Pw+U6vIuDT?=
 =?us-ascii?Q?+iPXPnn+3A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0114ea7e-b854-41a1-6444-08de54d2ad94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:36.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thbYj3wIG+9dvIwfJ4/Zx5/LVUt/Cb11Vwnd66Nx0uoBn/b1rzrohQZxMu9yoXcX8YtVwDiJhpL7i/WI8a5Vqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. For example, the kernel path does not need to call
xdp_init_buff(), and XDP path does not support swap_buffer(), etc. This
prevents XDP from achieving its maximum performance. Therefore, XDP path
packets processing has been separated from fec_enet_rx_queue() by adding
the fec_enet_rx_queue_xdp() function to optimize XDP path logic and
improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After the patch is applied:
xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 292 ++++++++++++++--------
 1 file changed, 188 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0529dc91c981..251191ab99b3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1665,71 +1665,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1842,19 +1777,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
 static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			     u16 queue, int budget)
 {
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	struct net_device *ndev = fep->netdev;
 	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
 	int pkt_received = 0;
 	u16 status, pkt_len;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	struct page *page;
 	dma_addr_t dma;
 	int index;
@@ -1870,8 +1800,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
@@ -1902,17 +1830,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1961,7 +1878,181 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	}
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int
+fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
+{
+	if (unlikely(index < 0))
+		return 0;
+
+	return (index % fep->num_tx_queues);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	int tx_qid = queue;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	if (unlikely(queue >= fep->num_tx_queues))
+		tx_qid = fec_enet_xdp_get_tx_queue(fep, cpu);
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			} else {
+				napi_gro_receive(&fep->napi, skb);
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1970,11 +2061,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(fep, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
@@ -3854,15 +3951,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
-static int
-fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
-{
-	if (unlikely(index < 0))
-		return 0;
-
-	return (index % fep->num_tx_queues);
-}
-
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
 				   void *frame, u32 dma_sync_len,
@@ -3956,15 +4044,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len)
+				u32 dma_sync_len, int queue)
 {
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int queue, ret;
-
-	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
-	txq = fep->tx_queue[queue];
-	nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	int ret;
 
 	__netif_tx_lock(nq, cpu);
 
-- 
2.34.1



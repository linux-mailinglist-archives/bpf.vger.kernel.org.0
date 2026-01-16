Return-Path: <bpf+bounces-79203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29006D2D629
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679A730B65DA
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163033469D;
	Fri, 16 Jan 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I4LvO/8W"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0F2F5A35;
	Fri, 16 Jan 2026 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549273; cv=fail; b=CWPEmOLthfqyl5gMC1/j8d1TIO6qG+p2wjEGUMYtdZ32G3GTtbhXDj/Ilt4F4OZRzzrpXyoFm2NrBQ+RIvKLPsev/XayO9dRaEl25/uKPNTD84SiSvk3rJCx17YDIRNJZYS7wt/gMOmnAnSynEZGsno0I3xxdyEBiv+4DSjZCl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549273; c=relaxed/simple;
	bh=yA8kOKDSgF0bNlrqzx762OxHAULNCwh0KfNlIm/zyIg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r7TyzMGo4aVHv5I5frowtVCe81xnthiozlKshAU57qTXF8yGKGUyaa5fzPTcESthEmebQGflZjyomCpR5rB9p4PCfVP8BrIu+5nHDWpp3exgzsnLkwRTovt09EJI50NlxW/LWqo28fwaZU4v7xaBTM/XQ9fDlG3EQqWqv1VY3zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I4LvO/8W; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0zZZK6OtnOgTniVR3t5ziYxYDsAad7obaDjcbF/9z8XzmhKGKtL/gwBjAxKjtq9vsLxOPm2Qm1ihxZM8mcUzakjgD2vGgFGWFqEib+76dcg4s0qmJwWqz0OvVRPhBJrvPIN0xFgK2MsnumYOLZRSpR5kdkuJvCMi7BmmXewU04ykHrUZjJivVnJfmTvN6EQgdmqITIC9UqIbkXloNz8B2Ug1aLvI/DmTEh8vEsY7jp4bm9+/y3Xtd6FvTB2jc3fneXZDxnGzLUl7S4ePmJYVQQTu02K0AG4174fVrqrS686nOiNVK3Jg5+zJEBZ1jgwE3YmdwuH26E+n1tCmebl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMR0K00nKAliwneDzWyGKNy12S0JKlXaigGkglmbGZY=;
 b=qRjaWt8uBhqWCLkVtqVXDVCnDd1vIKiQL+3GPzVKi66yxnvtEP70Oc0w2Jh65AdHGU9UVpuYzkFqvviSMunlOEBFJw8rRDZ3jmz1TdJJHZZMsUYwU2V5lbmDOxJ5JZciGksPT3w+Xb0HO8L8evOmWae/4JB7k05yQxJoAag8D3KphBQHPvB8FvDhGQ0CUgRT9w21Tdqkstu0gF6bnxHC6I77+lb6yEFJd7SAJmje8By2VUA4MCfGOxnVX65vF3dwntYiDGuWKjfrzGmMrOJWruFrEDSVDSe8dtt5rUxcjx4n8TsQZIH0hVmH/cAO2802Np1+8wrCyJt7LFDTC9Q18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMR0K00nKAliwneDzWyGKNy12S0JKlXaigGkglmbGZY=;
 b=I4LvO/8WJ/HqBob9Oj4PkimBYusZZ+ssF5/c3OSKG03iffbJc1QSngZ8W2bq0OLEJhnWXYK/pgzaSTi0d3YTyOgvjRCt5l++zZ639tiTD80Lr6dTZ+v1e11ihvdCuWTPiLYA10sMDVc7v/o4EqBMQI0zd9haF/FwWWDremnSRJU2p9y3BrWPWXRmp9/I87diNCrlelF9KpvXDfQF0tJCZ9axQZGlHUtp74mBR4MgkIXviWFGmo4m299EF+KNXGRnGTo4ZzwSNWOrLbd0NKzobmlxsmiMWcYGWwa0Wz4XPCaAOY/814490sLZ/7mHAE6uN3vsrzPBhwwpnNV6joO9/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 07:41:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:08 +0000
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
Subject: [PATCH v2 net-next 00/14] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Fri, 16 Jan 2026 15:40:13 +0800
Message-Id: <20260116074027.1603841-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e15152-426a-42bf-9418-08de54d29c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9dzLM5QIVCyphfc5bT4ykcthjGfsOrEm9PW0yiqdk1/MabCl3Qqwwx+vnUr?=
 =?us-ascii?Q?MKDdpyvxULf/+f9RAc+bgtU8tF+6tr3/k2q11+9lPUc73ydSF71szPlPoiys?=
 =?us-ascii?Q?kLQHk5zXH5w1bDkcPRc/6q7XQCeOlIxnBUKCFaowdORRrp3uvXWYHnWnuTsS?=
 =?us-ascii?Q?iLoA8zN11/5Cj1FnwIDRLgvNStgxDLHkTEqyo9SesFBzktgzbYtXcaRaaShg?=
 =?us-ascii?Q?3X7tvs7JegdQqpGumj23WTdRQPOZpQMcQp9JvcGjw9kViWzCZsajyzlctGm2?=
 =?us-ascii?Q?zTOAvHcKR+9OvX5KzWSt93HBlQYrKfxXcUpBJoP/dhxHlcVIvR0ZT7bkpGTz?=
 =?us-ascii?Q?9RWiIh4tADq7OqTq6+FzO27C5LrMS1cLpiWUPgnjbB38pmffaX3Atq1aVgFS?=
 =?us-ascii?Q?N/8uNfizJWzkPsXl7XnMZSKnHlwWw+TVJU7PqdInUxDF3/SHCJ3+JHRKxcaO?=
 =?us-ascii?Q?ea3O33Ms6ETLGLsQ6yZTmRG8zR0IV+bMPxezXUgg1PLA4hEQaOLB8aS99A8U?=
 =?us-ascii?Q?J+jeSQhYL6dhSLJoFk1twwThuYyyurijoo3awqqORjANvTPNhaEIu639QKEh?=
 =?us-ascii?Q?V0vPMU0E8iUD8Ru8HYbqAVtcD97V0bL8TcbkgJjENHz8EqUZtGWUCc7YpQzq?=
 =?us-ascii?Q?D5vifaIksNSE61yp9Hj8I5H2t45LbCPcHWSVLhZVVz4Yvy8G1iPKZ/Os7rhc?=
 =?us-ascii?Q?eu+KJcUD/mMI4Woru5KAcy+vlqcU5Hvg77pFcWUEbt6O9NDur8hsMwOs8HSG?=
 =?us-ascii?Q?/6ll4VeuFSlE/lOBRRaWqsppaeOJ6haRU1YerZJtzeEqZKQwKa1XxaSPZLwe?=
 =?us-ascii?Q?xUQtdAcr3TF8VzYMJe/GUpEQP1hp5RDpts8qA6H2WRRKIxDjHf93qTAMAJS7?=
 =?us-ascii?Q?XU9hiMHMl3GuFQkmvNvckhedwuiarSbJL65opaKrWdzPBD6t4ZjCFvxEvHK4?=
 =?us-ascii?Q?4zZmbeChRae1Hy+Tq5y79/gCxBcIBoI3j+c4b2f4pLI546PvMBkGDumzOoCB?=
 =?us-ascii?Q?tgBoCVNcenCH8MhY+7IWu7zPkMia9Sh2UfHjAoDI9w2Hjg54u5k8AZVhOb3c?=
 =?us-ascii?Q?Iz07d+qiXkh9LEGNa7ULwOGhMp9jabGtJOhnWVyNw8lMv/e3PooEOPkvJRde?=
 =?us-ascii?Q?q/DDORPYy9mD5x+SaFtpd8Dqi39DKaMlmo6UzaXkDxsATDqFjUOE6MsLzWtG?=
 =?us-ascii?Q?wmyKQsMS6fgVMrmHSIdqf1Kgf0p2cMe/dK+ECpSIpCeeL0lEVCbALTWUU98w?=
 =?us-ascii?Q?auM5ciS0t8Ns7mn5Uq8mienFKhUX8Y+A2Bcb9IGqyG5LkgKdbXWD7tYAzIEt?=
 =?us-ascii?Q?jq8RIQTU09WYNmNBY9JWN2QPseJhdcCaa/iE1chFISRg+22CkhKGOnm8eRJs?=
 =?us-ascii?Q?hpWX4ZYaptjjGoBnXZ+swA9l9K2s+sH5SJzSSgJ17Bn0HDpSlRtMFJMb9eX6?=
 =?us-ascii?Q?Ckg1+Dykju5W3P8FJrGMmFZHoAI3iuI1lBXC8rjYkyG/0LhcrDEcMqZr/nwu?=
 =?us-ascii?Q?CR4vA0FH2swiuEmoxFoikcUIeT/BHTyAm9Pl4Z3zG0oB3peInvtnyEBdZPum?=
 =?us-ascii?Q?yGmWQNixgbyRkSFcnE4wRaNeW/iFV7mMfBPWFnVIJ9TXjY4p160R6+gUtQJv?=
 =?us-ascii?Q?IoESZY9nX7fidyG8ZMtYjvobybWrMwVNZRP75eTX/ZsH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTX1ZcpvmJkiNXKwpxJEVtSu786aV9BF5ZbC2TIdixiAp/y6BnEMjzZ7p2JR?=
 =?us-ascii?Q?4x4nuvT4fU/DfkLR6QPvdVTUF9788+j25DEVy93bqnvp+Zr7/0GktWn7XaYY?=
 =?us-ascii?Q?Q9bw6zkVklvJUvMIuKqcnIN6bHRApZp1KKNdX1g1QF7pbbfKUXlrDTKqDD4Q?=
 =?us-ascii?Q?HhLGBTLBdAXGim+p2c70VqWcojorKCgNAySTGr3I5JUgPqT0qNsY6si1HeOM?=
 =?us-ascii?Q?yinKSNc+9OE7d8OOuwOpxb0IAyMudsB7LsiHcVTSiizW2cYndPokcmtoWiM7?=
 =?us-ascii?Q?TvlEiJ6Pf4BpaGqZenkwcbFTTrX3pEnjGF3xn7xuysUTNQMlcMHDUJR5aeU0?=
 =?us-ascii?Q?WxwOfvaY27YY54/R2fMG8C/L8aC0kNYpDiEJunGauGyrkf9XC91WREA6yRAz?=
 =?us-ascii?Q?p7/81SYLSRemY7uOd9br4TBi5PU72V9U8q+HIsRP2dVWk62jLIoqmptFcvaY?=
 =?us-ascii?Q?02Mf3+5h4HqCRwUgdOLj8Znby29zP+z3J7dWl1T3vOggQeJibhIHuvS5nDDu?=
 =?us-ascii?Q?vbYMZfSSs7jWt++wyEQFzVy2O+vc6aEmZbRyxIpAS5ZQaLuwHSY8/B3XJiu4?=
 =?us-ascii?Q?OwR6dTsVE78PYS734MkanlYxKnZLus3I6BkGlTLGtnG4FJ4s3O0N688FtgxH?=
 =?us-ascii?Q?y2SSB1LiyLypQcoJokilHi/S0WvvVu3tHxOcM1D9ULkN+04/s8oeC1u4vZ5w?=
 =?us-ascii?Q?w4Pd44omX9+Da17QSciLNV3rYXpfxI4m/P2FjXFBXWkggejbBlMpKBmoDer0?=
 =?us-ascii?Q?hnAuigD6eealbs27o5VDwEVy/aVAIZp2fiZ+1va7FB09EUKQ2Jg9QkRXqFk2?=
 =?us-ascii?Q?Q4D3Q5fALvF7zQzkBMoBuunK/Gum6fuR/xOqXxu6F6GubTgEKy3ep6jq6YaV?=
 =?us-ascii?Q?AXjT05AsIfOllBfQs9Es2inRoBr8UMLGGE7GnhmcAFr6//9Ivsg2dGJb7l0B?=
 =?us-ascii?Q?/1tmsUCPfkbhDvVp7X+mmHRK0wExhQoFRAqqfiRm0JVu+coIqiuTfDcJCr8N?=
 =?us-ascii?Q?BTGTSD9jIEK3YbK/WlVNfo1M9/ZYladfPLM/LCDwzre6gYGQ1VCaQLZkRKwo?=
 =?us-ascii?Q?rSId4HqGW0WcxS5dNXK+qMg8eLq3RjpNteLOB4EQ0gWaPVrquzuCQRm6SxEZ?=
 =?us-ascii?Q?FxftA8ijic9x6ByJSQZzqiH3ghu5+tsCgZgucot6MijfjgsC/Uwu0X2q5uxl?=
 =?us-ascii?Q?6JSMJNCE8FkgadMNacvgzOHuQW2VgEOSuRORoydVF0WoVL0VhLAiAJaAoG0s?=
 =?us-ascii?Q?Y1j1gBvGAy4vK31yE9bvjnwhqpz2GiEmmMcn5olQGU+f2cTILVqyVjRJl1DL?=
 =?us-ascii?Q?CvdlHKKZGb4JxVhBk7g7GItrXwi+HcOewuOySRC1YCIDO1TQ1KoDfLOEVKAR?=
 =?us-ascii?Q?weCu3dFBqx8FQRfAF5RGl7oVM/n/z7lnSjLxvsLpacYU2GHJMrm3GtBD6XMq?=
 =?us-ascii?Q?vXI+hKDHSWCDl0fRrV4lvzL5i1j4kW1jsYOVjuhyFB2JAXf9Yp4M6lXsr3Mk?=
 =?us-ascii?Q?ayZr+navZQi7OWQDI7hA7l6J849swTvR0u+GV23Y3XlpLZt9MbvZqKAYZWv3?=
 =?us-ascii?Q?QpPNvarlpY5g1zhurGYER8MfxyQ+KIuDtoct1KUA3w6ESYH45lnjucl9i3uB?=
 =?us-ascii?Q?0amuu7nvYVluGWYOV8qBv94GS2oy2/D9VAqjeJGK1EKjF91oW0ZfLF2jZrRY?=
 =?us-ascii?Q?FBueMJdRG0iiZhQnnPFmkDFSjQIMH9Fx5Sk0lJFsVSyG6jwIyvNiEle+LMrd?=
 =?us-ascii?Q?zRZ7jZpKEw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e15152-426a-42bf-9418-08de54d29c92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:08.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1d6nRPFKiiRTm2m7yKatOhkwthobiR9n8c08fKhgNQ1UkptQzjEWTEZNEm09imLKG+G4EHYpmkCvfd6Oor/UiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

---
v2:
1. Improve the commit message
2. Remove the unused variable dma from fec_enet_rx_queue_xsk() to fix
the build warning
3. Remove fec_txq_trigger_xmit() from fec_enet_xsk_tx_xmit()
4. Separate some new patches, patch 4, 8, 13.
5. Collect Reviewed-by tags.
vl link: https://lore.kernel.org/imx/20260113032939.3705137-1-wei.fang@nxp.com/
---

Wei Fang (14):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: improve fec_enet_rx_queue()
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: transmit XDP frames in bulk
  net: fec: remove unnecessary NULL pointer check when clearing TX BD
    ring
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: improve fec_enet_tx_queue()
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1455 +++++++++++++++------
 2 files changed, 1079 insertions(+), 390 deletions(-)

-- 
2.34.1



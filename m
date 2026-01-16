Return-Path: <bpf+bounces-79206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C77D2D6A6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3137E30E9D87
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602F3451AF;
	Fri, 16 Jan 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dHymF/oT"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DA32D7F8;
	Fri, 16 Jan 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549293; cv=fail; b=B6IgXiRstXzCYo7VBL4sUd9z/Yk+hPaLih1uNRX5j9LC3++/jKqsSbVFeoyFDFw/uggD7m6bBXwOvZlRlbsv/vLC2TRzh75rnyBVWu6psKoofYhPxEktz/+1sOOezulplTEmXsmQdt+EAQmDICd3YzZNSQ/IpnKNd3MAF4C+hwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549293; c=relaxed/simple;
	bh=hrOXuo72j3c6ITj6huu2FimsWjiiEBCzUo+9DyENXR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6/QP0JXPEUUW+FFn3sF2dm1J43hZYVcxAMVsAbmwpSjdoEnrzpW4htyn+SQKrkQrVOf2ssYg7tp37/78xUnLXNjC7t3soQ7Mn95qC2u0zxr5LfN8uIWX9tLC2SnE618Da0y5yXi2ZpMqCTdELHRYekDgyjQ/vuTco4BbrIjKfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dHymF/oT; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGUQXZoF+qKVw8bKmciZxeKEJFu1nuH5oG6uG8TwaDFthpT8hgogu/LjCbr7PXeoCT2V2dU0eG4yI7yIsrZ3SYbMGTAtM7MPscgBPAfTVQ77xkiAsOrYGoR+kFCc+rQl6h7wwiJogOUtFf/zI71HHff8KcxjGgGu2bo+QxvTHqn7Dp9puS/eybAiufAFVasjNka9bV5S/NPiQJxmWGBlaYpWnYH8tpAKUYoSKfSibCpgVuO/tvpkd/yN+OeH7zL+36ZmfZ5027O6cr0neHNAyuLy2E2WkB5vnpj6zJCXUMVuJ+8RWUPfXiQXRwJB1CjUQufgw3vuNPldyiJpMjZ+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUuI9yxuh89Kp3lTnrvIy34OFS5EOA5JgUX8IqWLaVA=;
 b=kJRHCnTfAfiHu1ILyuPIvsvmgpNbrqp9S6fYY9Lx3+Qg3V3zukUqP5xa7r5/qwrLvtsoBdM/363u7LoXgSFYSqqKVOl9VTVz2oSyzuyknq9tGlg01jFikKfoU7P8txRFRxAo3Gho4y8v1MKIQvyMQg7xmuyhoiZDSBozB9TlVBwtp4NpHgAeaqcfiQiysYHP6KOWmx7bdajQyAGPDc4edCYrt+LaGfc2IaDMXjxrWjwIgVJdB2gy7bvdHd7lne4fNUvLa2VtVtQDzsx2DZExD7R4NxFYJkswwycnoDNqZO9/KXT5qL8p1u0Y4hbQvnAuAjc3hj1AhLsuv8/mpBQz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUuI9yxuh89Kp3lTnrvIy34OFS5EOA5JgUX8IqWLaVA=;
 b=dHymF/oT/H6d5XyanSagt4/nqPgg1TVEWZ/6vRopqBFb1AU4SPb9HY80UiigjYcpyUYtzGVTcoQaG0QU/VHhyZay9LWADamxQ2egqPQ+wtzRfO78mH/sri3/wSjGfMUEAxYcmkVPWQMYhMQIfwDmLUL4vlRDGW4ODAyDSfhxgIxdbtDs9vbIWsEfAhOOOuA9DDW7paLllnDkWbxJS5exZutRlLh+YesF8VEQcgLYetKK1ByquxRDXHrM8L3qpcpzbzqowhEia+xvXfTFTVLxsIkCsSDrSCa5sLvtPMgkoElJZp40gJMOUU+FeTjT3mA+8K2Bb+0X8P+ZCPrNOan7Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:22 +0000
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
Subject: [PATCH v2 net-next 03/14] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Fri, 16 Jan 2026 15:40:16 +0800
Message-Id: <20260116074027.1603841-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51aab6fe-d55e-436e-2d1b-08de54d2a53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uAZ8HkQtJyFuOpz6karOQPubr+7TZTRnT4gD4WtohMAEbbBwEg6vgQ9RgRHl?=
 =?us-ascii?Q?HXvt6psWlANJhvT1BTXmCltx4Sf3szVu0eRpyjVJjlysw5N+x1Tz3kshHERc?=
 =?us-ascii?Q?KTL6j8kgzivV2/cqOCPsHW/FX/IlX2MyEvBpt+zrUq23BuEzeh/pOR1U1Itt?=
 =?us-ascii?Q?xNLVda04SU+w8sVJ823uz2QqctONHYrwNJ05IztFEL8IDQtqtrdyR+wQ/1CV?=
 =?us-ascii?Q?1LzOzJdXM/p5WH8OcOp8t0COwL6+729iUfvXy5sNslzo6a+7+FfT3qu9Lhq0?=
 =?us-ascii?Q?sOqCw7Dp/IqKJIVVpAoGwzsD5/YMpTaGazeqnOY3on4935YOVKsy0Jhd1dIx?=
 =?us-ascii?Q?uzbT9Skrb9j0IP0zi44sQ+nIO7ZYCf0jXeZnJRqpP4YBekkIA18pHcYCIvlu?=
 =?us-ascii?Q?pPgFy3H/Cnke2dinkGSWISgeJVIvcHUDLhyWUuuwSw0fgooNgTpujRhnwzns?=
 =?us-ascii?Q?dny34NMgTq2ZSFSJcDP5NEkdHSEfCeUeTKwWObCA0Q/5I87sqbz+Cfoc8h3t?=
 =?us-ascii?Q?2W5NCNoi6kxmejKhesn9YaqzpWDY4swIXWbrsG8Yvxc7QoMz1ZbDNoji5Yfd?=
 =?us-ascii?Q?vxFnFj9USHgVZOuLodvefAYzrzbo0wxuPL3b6HQqeZTJjYoaaDYErYKhk0O5?=
 =?us-ascii?Q?bqTrASAgidfyzsQ+URhWbcS3Ax/RKjbowOs95YQbfnKZIEkKXN2QuJBlFQS+?=
 =?us-ascii?Q?63BehZdEfJuKti4X6550+fmFWDtl1z0gyU1OR5s4CXqAO1gCWcijEWS6gzyg?=
 =?us-ascii?Q?9AovcCJWPj0xp2Jmd66C/0f03swQLGOpiiqb2uFu9l7CxNsmgMimoovFL95O?=
 =?us-ascii?Q?LoJdORbPXfJhoGJoWHzMCK3BOQBRl4VKeYAzQC/p3VWXoPW/IvGhMzTcHLWS?=
 =?us-ascii?Q?gEn/SxLnIM8coHKAjGtRIpTwK0bdsf9Zbxel9FoGcA1vhCD2thEVe6uP91o8?=
 =?us-ascii?Q?kg6osh22Umc5QWtkoZCmtGrLFhjzCpykXuCjVoeX6bJyDHRgTqi6DKlH9IsE?=
 =?us-ascii?Q?PGmvj4iZjlqFcr/cSE+Arf7H+ycMDZ3EQoLMwNFn6BQgHlq8igy2VSFoyovr?=
 =?us-ascii?Q?vEABDqBskk+aQWhobZxxSrfyhT9SqfDwWjSnOdggRCJzPnfpMQn7i3M3IAjT?=
 =?us-ascii?Q?eRvDVUlr9JuCB3a0KsA9Qa3+IKUK9Ns1wfmGH97FrX+YJudYITC+JWNJNcFr?=
 =?us-ascii?Q?Vhkj6OLh/RANB6C1gXbzmypInMa9K9FVpvhZV82KA/LCyKsZj6y0QZo+ZU8b?=
 =?us-ascii?Q?/yBQCnGwLwV5r/C3ieGILpCcVhYOOLhdTn/Utafv/a16dgjbiqHKguc6b7js?=
 =?us-ascii?Q?xQwV9UKfFGfg/w0MlP0pG1UKs4DRSlEiGw/OGCZK1JOaEq4f2BPlTbv03q0h?=
 =?us-ascii?Q?C0ieCpam7LsC0Kf/xojZA+wz/HfK3uzXpAhTTHc1Spc16GjGxODbR1Lpsfho?=
 =?us-ascii?Q?Xtg0zwv/MHV+7jfFnypUhFJsw9OwjB3fR+GPcAnqvvIwAm76MxIbZmo+0e1F?=
 =?us-ascii?Q?cAKZFuZ/M4Qnqfwe2cGpy80P0tbzyCWyDBzrXWNx9iPBmAKg7FtM0YUA9ouN?=
 =?us-ascii?Q?yplBAL8JTD8bhvB6/bmn+iMkhje4bAwOpxYN1RJ3355s6KQSqbAi/lBBhi9w?=
 =?us-ascii?Q?PhEO6nAXHkPqVCvwINnm3K5mWCOez7SQT1tGsWaybcR+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44CATnb602DzRtiq7s4DFubGAkHa4jmX2GzbjUeJYD+ECAcAYyXkmy9Bm8xW?=
 =?us-ascii?Q?cAzJKdB87UOn43/v/5oW9Z4CNxc/sYByzya2gunY9CSL1q1owe1GIxQ2lWwH?=
 =?us-ascii?Q?gqGKBJNo8VUHXKBF2P3/XbTFEa5US5A5fAWjwxNAggHD2Xv9sCw2ppTVQ0Xl?=
 =?us-ascii?Q?ADwzMRx2pKAJe8sQ46AGQIClNdxEQJ6d1Rk6vLnq+LiNKvVvHpDr9+dLyxOO?=
 =?us-ascii?Q?vOsZ8hPqc6pOhpH6q79HCgl7yO4Y5+HT8Z4NwQxliT0dIeEeIN0nPVpcLgFn?=
 =?us-ascii?Q?km25Cf4Igo7CjhWj2lbHEITe3eFh2Y0gbFooiNg8Z/jRMNumWxJabzDxGn5I?=
 =?us-ascii?Q?BsDg17JP9JzHudXUlC9uTqSCgjOA1+rW4oZf/iznepJ/znAi9NgR919kaNZ2?=
 =?us-ascii?Q?QngoIrqLgUi7uDjgNSUbX/zusRj3FGZV0O5PuYE94Etez1lnLVUMaQ/1Wmq/?=
 =?us-ascii?Q?cY6I0bps26bSZOjWlWOGiNtNtTWhT04XIXJAVQNp5saClyalkBO4yuPO6Uq8?=
 =?us-ascii?Q?cwDLowmnSYT9IeMozVImj+E023iEd96a/0Ptu6X1uO58kW2zj8/033ARwv9c?=
 =?us-ascii?Q?D8Bec7hKIB23poRAO6WEFo1pkv/eFr2C0tKVJGtS6ejXRx+Di79TlEfZt0q+?=
 =?us-ascii?Q?govBRiGlaZpYk9kXO+lqYTJzchQHj9eqhwKKXEM5YNJ36KGicuUP28QPKsic?=
 =?us-ascii?Q?RJQPSNZnzdro52Gb2ju80eQ8l2O0caQDr4vwjUV1/cB343LTS37YEYCUpxxy?=
 =?us-ascii?Q?PkXsGNAQ6r3fYLrTHnRwym7EMLSzwlfeW3kl0AxoGhOVAuRheiPZOMd3eHfk?=
 =?us-ascii?Q?EiRFrmsCValNswAKmO/KkIGxDmUmCkY3OIIW7TcDGO8iLQ8XfRDMLoAJu520?=
 =?us-ascii?Q?45c2Nz6kk8L8DHmPz9AYbiz4TFdW/ot5zNYtt8ZO3f/sUihck3EOt4zbFlud?=
 =?us-ascii?Q?N76z6VkUNP6j4l0t5pVaenXw23bggZ3Dbop8robpqsqcqFlFKRRdNs4wHk6r?=
 =?us-ascii?Q?Ewmwg0K0FuGS/I4fNXPpB4qoPHNp/4dVpc0nyN62VGaEjqpDzb8sml2Qec25?=
 =?us-ascii?Q?ND2oU00dvaHtli1dZzbk+G3C2je4rdfGd7uC6ybE63aN1bOvxdTX3h+Fir/v?=
 =?us-ascii?Q?CZTFc03euygfmREslfjcrRJYNYU9O4AC2NkxWN/ITeMEc3j9uA7mJu0b2br5?=
 =?us-ascii?Q?x3veMP7Vym5yPlvfAdRMncLjKnDBXP8C4SL6kuzV0Rkpc36zkGNvg//KqAhs?=
 =?us-ascii?Q?fSsmiH5w4gSzxJu5h/RMA54us+QIUWljGLlu29pi+q0qfzLjMwPIciZziqDy?=
 =?us-ascii?Q?vTYi+ZvUpz69qtg3lCGtzEnZomWh+be/zKW8OEZ0CaN/ZqTIakS32t5kMjdE?=
 =?us-ascii?Q?Icg9K1hu8kPGDA1G72BnmNk92NZ58u70cSg6/oVhOOFuhil4bAx5xf5l0Vuy?=
 =?us-ascii?Q?wk+V/32jIj4R5YOYYNXOsx6ibaqEiXZaGopmRxdYVivpywEjObjAxjk9dQKV?=
 =?us-ascii?Q?mAz/NvGybX0lsIAvJmzyWIQyEZS1WJETdygs1J9vGA2vSRpDp8haM3VsB1es?=
 =?us-ascii?Q?Eb1lAHmu5jjUQfggLDUjJ0ut3YofXMpVqk7XIMgjsytgRwukGcbgoiRv13yZ?=
 =?us-ascii?Q?TdK283EzSM2WXDVlADsqhSgBIw58HnnZ91XblGHODN6RU9LXnbdopTFAcmFo?=
 =?us-ascii?Q?ITsfwPtF8n08K0XtpOrWOhi1iEcM4xwXalwwK+spf/ktioT0CXTc3q9LwJPX?=
 =?us-ascii?Q?ZvD3/zBC4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aab6fe-d55e-436e-2d1b-08de54d2a53a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:22.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk/pi6frLyh6hnsJBKS/HC/ZyFvTCtG3HNGXNLD+6zcyXsWj0Ayg8yTxZA06gOOJPGwfLjCQcB7VVJNnVRPu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

The FEC of some platforms supports RX FIFO shift-16, it means the actual
frame data starts at bit 16 of the first word read from RX FIFO aligning
the Ethernet payload on a 32-bit boundary. The MAC writes two additional
bytes in front of each frame received into the RX FIFO. Currently, the
fec_enet_rx_queue() updates the data_start, sub_len and the rx_bytes
statistics by checking whether FEC_QUIRK_HAS_RACC is set. This makes the
code less concise, so rx_shift is added to represent the number of extra
bytes padded in front of the RX frame. Furthermore, when adding separate
RX handling functions for XDP copy mode and zero copy mode in the future,
it will no longer be necessary to check FEC_QUIRK_HAS_RACC to update the
corresponding variables.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index fd9a93d02f8e..ad7aba1a8536 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -643,6 +643,7 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
+	unsigned int rx_shift;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0fa78ca9bc04..68410cb3ef0a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1799,22 +1799,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
-	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	__fec32 cbd_bufaddr;
-	u32 sub_len = 4;
-
-	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
-	 * FEC_RACC_SHIFT16 is set by default in the probe function.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
-		data_start += 2;
-		sub_len += 2;
-	}
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1847,9 +1839,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
-		ndev->stats.rx_bytes += pkt_len;
-		if (fep->quirks & FEC_QUIRK_HAS_RACC)
-			ndev->stats.rx_bytes -= 2;
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
@@ -4602,6 +4592,11 @@ fec_probe(struct platform_device *pdev)
 
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
+	if (fep->quirks & FEC_QUIRK_HAS_RACC)
+		fep->rx_shift = 2;
+	else
+		fep->rx_shift = 0;
+
 	ret = register_netdev(ndev);
 	if (ret)
 		goto failed_register;
-- 
2.34.1



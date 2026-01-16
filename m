Return-Path: <bpf+bounces-79290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674FD32F4E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39A413024A1D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5DA396B9D;
	Fri, 16 Jan 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RHjSNY5f"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CE337BAB;
	Fri, 16 Jan 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574882; cv=fail; b=CNaWyXq3MDdI/G/UA4RoIRSCv4vZryntZHEjHXgQ/qCCRoc8sH7PVfU58twn0V7i8qSnPkiruPJWWy7MAuGZPmSlxaOzZJQPfETNggaX8QPwZ9ZiTOC4MEZLiLKks793Te5C2eOp6evJ7vWrFXnlY51ZLvylRPW84KAaeqtM3Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574882; c=relaxed/simple;
	bh=vtBMVQTK/MW7KQNzvR4fh2jWQcmoph7n5yt7UvmK/0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CevMGRRWxUw44hfxe+er/wJfhBjmTc2CxQqWkkUz0G2bNLGcU3RBgz8+n8Tmqe+w3UTc8K1YOsGHkc29jKsTVwhH95wRzKAh0FD/bsm68qqd5rFQ5NMz8iR1SKpLRvnWrq66UAo5KZrSIA2PTH4CEMsbRYFntEFw7Ahtx1R/swA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RHjSNY5f; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0pJAJXem3kIfh6g6xJr60N4Sd0h4YC1Dxk7GDps/lW5Z00WZK+CQBj3a55j0AkXmSwhk5EGcvJd2kEQPPl5zanZ/9NRFPnFPw9tRKuTGU835E9HmqDbgOyWSb2rLjVH4c/+6A7FgNLAgRsV+KMhAAKLvZYt51gBwp/yQIr2kQVgtlSYLF45Z97C/In5BB2EPa4dERcLdP/XgnjE713DscjqfGydgofEPfmcdvPq8KCd1Pil/ehJztxA0TtCJPk/hgrZsBfLNWUUqPFQ4ZtV8lEtFx/ezCrwiDYJOzxpLxkc6bn8r3Qh7CZqbvRCrkVrD72iilWkzPMxa1Pg9dmFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iKjH+pN8xIlZoSNGFBUeHW9ZBumwBXHx/Mnhaig8CE=;
 b=cXHCTHEm+n7P0dNadgiQUySDbdRBcSsTe9fbkXG1HBDQHU97FRO6XcHBmUTtaqrXMYQfzR0baBNlQi3DFLjxJrlPKKUqpt2dYPXU1RsW1g7LT0ATZ7m+FZFJjOn8IEkGyqBDgdZGLPG4nwicmw1kPlrGbHqNFTnlItBzxQz8t+eoqAFtR5RZ5a/YpOkStJqVg7veMuUhiGpFDMtw391s5TBpN380j/sba5iZPmMwkZUHN33Xh1o1+Qnne/2QTajPZZ4YTKpnP6z21v9yFO5UFNdAfjqcX7DY/yXOZdl2QYG/XGZnZh34UdV2/sHWbODNxNr/Bgs+EV4M4Tx4saRF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iKjH+pN8xIlZoSNGFBUeHW9ZBumwBXHx/Mnhaig8CE=;
 b=RHjSNY5fg4+v9W5V63P/kz6TZ8b0/HpsrYo3TMhyww5aeC35t6FM5jb9e7avuqsS+1zekFU4gr9OvR+umtFPGqRNZeP5pgOU6ey9T7xTlElBv96YwOA5LzWbZCZNQa8BeSGPrlPNWLejE0Sro1VkYjnGjsLk3C5drjmcfLYAbOrdM8gQbZDE++c+yFmWwA8+FFXerxaa6zWa/VkXfrJ9oOBkfkkTqDaWaNY9Wn06MO6w211AkNc89gPdeeefwFAG68DoaHBhN3Sry9Wlz58wey2vG962e2cQzwSvdDlaNlu/qMTt0Hnxom+je7JZsf/hvFk002c4IzHaZ1lN5rnlZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:47:56 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:47:56 +0000
Date: Fri, 16 Jan 2026 09:47:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 14/14] net: fec: add AF_XDP zero-copy support
Message-ID: <aWpPk6PrHuL+zdMr@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-15-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-15-wei.fang@nxp.com>
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: f00553d2-d75e-41ec-b71c-08de550e3c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IL7xU2zpzvDxaaLO3/K92DSSUJNxUkERBvxvSXfmETYYUxqm2MzIkbVWClqF?=
 =?us-ascii?Q?r90YjWxfysWzAlrCoPWvXAYLRsuBvw+7ZxPxBBOmSpUxDPH6JaTOUvYovtXS?=
 =?us-ascii?Q?bycQPHFHcMdl6AeKid5E6XoWV+eXIHTngClWjj6CzJGMIDi+wE1xzL/rYgf2?=
 =?us-ascii?Q?qP6nObe7WgEgzMHgdNpK1zGRrX6ZWZWz9x4VEGvCVi17yCkUnR4pq7j0gVVR?=
 =?us-ascii?Q?y8r55MktIgcdaDb0IS/uRGE9wZsATG9oWj3Cpe1LqptkpEAJEY1Hi7qRK4ws?=
 =?us-ascii?Q?BrvkXd3QUCf4MoG0fn/e8Yw+pVyyazUJj9arf+rZ3q8svpIymqm15hTLJNOe?=
 =?us-ascii?Q?0xSMMfYB2LQKGyN2OyM9sdPMQgEsFBs3bGz+pcTjg58us8f4pVHotARP+ENy?=
 =?us-ascii?Q?oUg5BmG71ZS6LColD/YK97cb8WJzlxh2bcXeJ8oH75AiFV1kzFH+IacOR4gI?=
 =?us-ascii?Q?ET1bswAazn05ZoBJgt2PtRMgUakuCARTUNy+jJSrUmin7Rjh52rfbdNO05bd?=
 =?us-ascii?Q?vsSaQlb0odO+02NJw0Jt9VeOHB1+W02H1KPUQc1pmfl+1QfXlsx5woxXMSFo?=
 =?us-ascii?Q?srebHHIW3uDP7RFgwObocPKQq0FQPNut3YTu3g+AlIccNZOfVYFwRSdR92im?=
 =?us-ascii?Q?B4gayWpmdgh6Dg44yCy/TUkxaOxebZkwXDf1r5EHY3URGpmTVB+8+tLEAR57?=
 =?us-ascii?Q?73GYAcg1ErPfeUMXbCxadTLXNxNTvuY+id6F1fMWuR39hcbfQkX1eH/3quLp?=
 =?us-ascii?Q?yPEZf/EFm6NQy+KTKQknNeCxZKaIh5/PXHPUeDvTwUAJXDVqXQjJL53V25Ik?=
 =?us-ascii?Q?ctm7DXImrabNbp2JcBau0EwHfv7LMEqhHQiHTVsFXkyrU3esPuxePl7OCo5F?=
 =?us-ascii?Q?w2NrAoTDEu2CJjRFFhwa3z94C/vdXmrZcCJDxQ01ndI+dokRkS4EW/chKK/W?=
 =?us-ascii?Q?6BRl0EsypFQ14GXN9uBx3RD6cuGxKzz8gb/c7cJKUEgkahK/l6sFYxTKHSLo?=
 =?us-ascii?Q?cI1VbRXSmstjoCfrtC/rJDGgTIYRapccl8j6sLRiuWquXOmB3hvOjmhe5RSv?=
 =?us-ascii?Q?hnSsw5s1BVdRBmo0VG5D/2jI9QWPtbjvxA8u0RIErKKC3ybkFTHnQihKj3C/?=
 =?us-ascii?Q?JHG6xBLPlpGF8A2/ipy1eGYovuPJAOlVCaU5ev/d6JllcqAIkpLQ8j3c0VKc?=
 =?us-ascii?Q?n4PXxc/u5KKfLmNTAGNC5sAXv2weMc1v2qZTfgEviv4YwSTSUMPumGRxoMXe?=
 =?us-ascii?Q?L5iOO2YYt/dzqwcsw0XLblWScLC2r+UV/R2rEe6z8zWiSFHpG/ldEZrTkiJE?=
 =?us-ascii?Q?mWOSQNi37lQ42z7PwyhOE4dPX8wJurw29weLci2kCnoefxH9MGqjAH2TKqbD?=
 =?us-ascii?Q?t2W7zxBzmIKO+XyRuS7kvF4AcVFrAUYGVZdQgEr/gfvOlY+sHAna2m1sBIm3?=
 =?us-ascii?Q?yCE3g18eVUXRyrB4Cf9lcYI5TaEskPCDyMZVZaPxUOV3hzMl1VCg9FlpoqIx?=
 =?us-ascii?Q?6XeoeblEuBsXMzPZjVuVqyWvgSpD/4Rm+RSyJF9cxooykLqrRB44DEKWzmD9?=
 =?us-ascii?Q?7r7gG5trP8syOPpuAEE2k7o7KSbqENomyuUYoSbsSiNxUDszaWcNqIkdj4eL?=
 =?us-ascii?Q?j8MAQ/HHymwo2tJrxMAXjWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggC5ZPxxQmO/CU8Ar3740hNZCa1mAhYNygH8paFS6+YQb0uNdK8QUckkBKL6?=
 =?us-ascii?Q?PvsRfBYC3xzhpmuh1ZzVhRbEC2Hy3kUfjBgmvymmmTA10irP6BQsHNIEib0h?=
 =?us-ascii?Q?r4X7TkN9lQp2Z0nD5uJNE5kKcDId0aA1ye2l5FnRz37HZZyZIhkRB639OJTw?=
 =?us-ascii?Q?6t3VqR5IrDOfvVEsb6Ag3v3yBdbws7Fx7ZPzJK1/094N5mm7kKNMfO7Qph5U?=
 =?us-ascii?Q?5i5vR3UHFzy35oKJr3cQTqdazi2svl9YfNNWD9r6DqSS7CATu7zTxF0qsilY?=
 =?us-ascii?Q?PTPMCpoObL1PsDNnDkOwX63sApb4gc9aGVAEi19z6QZePgwsK/2+llQ/1SdW?=
 =?us-ascii?Q?omT/v3J/zJK8JSNPfJ9IRqXeQVCB5tDmY6Zbix5RlQ9eNK0pcKcKLIbV81KX?=
 =?us-ascii?Q?TbxnMYrAdJfmj9gviSNhWBfHxnqBpR5bFI0cjmXFFaSle5vfVyinGIqpUu4h?=
 =?us-ascii?Q?EISlHrHAshPaQGqqO6slD3WfLrf2ZTIa3E4ILVs2Z5/C9A5Y7tqRmrBK5R4H?=
 =?us-ascii?Q?Hwf3b29Nnkzcjc/o04tYrAHVB4h0qtkdoJr7X8DyON8VvYd0t+6KLYAfUOGx?=
 =?us-ascii?Q?sujplcYkyhhmcYT/aPvIJGgRloLH5CErBHsCUo0/G+icCjjrahDgQ8Tw3Ntj?=
 =?us-ascii?Q?bmtgKH7NNqLuhH9H6BoGi9P7ZHsy6j8ePZTjc9or7HTOlGEcpb8EEmpT97TD?=
 =?us-ascii?Q?PFBGKTPnfHQTTvx/N7rYPU8PptMlu9nodoJ/EulrpR6Zu+Gj+oTnwbJ8pmAJ?=
 =?us-ascii?Q?jnM6MJThBclAn5JZqQ4JCikVSv4xKNK5nJ2FQAXUl+HgyMhufc6vgHgeKDdr?=
 =?us-ascii?Q?W7VjVSgtEskLGvidO0aZNXVTqc6uBL6VDAGLowHqEDjoWgW39VtDei7KEyrt?=
 =?us-ascii?Q?1l1E+3gT6tGkh5IcinZSLOWRoQSqoJ7I8o7V+Fl14a4otKigKpo+Vd/V2G7a?=
 =?us-ascii?Q?9txXaZKL/0RgXzUAncOKtEIxq9LdhPDi914cA6zC+m6+qOk/bHxRXDDYtqSg?=
 =?us-ascii?Q?mreP0f7VQjFCcOkEtuYgP+1oS7MCJHm+kHi+Xxoo0fk/SHCgQJSG4+47Ia+6?=
 =?us-ascii?Q?9U9ps49UuBtcHVurhYhC3nRDmdKV8Ie+cWYAuiQs8mhu3CKaV4J6qknd72OA?=
 =?us-ascii?Q?Ea7MPK8Qnhqyi87amulDI8HtHxq62p1gdOEv3sqcgo5TmndBDo73hFC+j2U7?=
 =?us-ascii?Q?AGV1GaKnz6DtqjPI/DIkQFJITRhsE9nfolL6FzNjZMFZp084O+BGeR0FIppJ?=
 =?us-ascii?Q?H5AQ9lxL/GYFsQIUh0yjIV6au+e+PGqIN+sZR58J+jjRxKciPQvXb8cxZBHj?=
 =?us-ascii?Q?VeYe3MQuZeeKIGWCUSruPEpASxZ1iajGfzkkf6MQ/eUibCARO6xB2qvamgQg?=
 =?us-ascii?Q?bUYBkF0Ai75Y0t/8l9YcRe4h05gLetQdjWsASaj6DBJzBiZMslhA1IOrsNGx?=
 =?us-ascii?Q?xD/rYCMRibNxCEHzHOOlenK7XWILudaKVBg5ULAK+VGrTIqdgcZM74gp8PzU?=
 =?us-ascii?Q?GAyOSvzOSICt9U1jKTwmPaQd2z6xuTrzb4cpkUf1B8ptyC6Jgf1SXyOhCwbz?=
 =?us-ascii?Q?aJcx2I/SfZiR0XV3x9fcNB8o6jALX/o3FaZyJeo/v0eyquyXm9diVaVYZbvt?=
 =?us-ascii?Q?5QsgQ4YNBNciB1U5z6RBtaIPgr9qc37sm7wVHjR7B/oqxzVmmKJdXQ8kvjQK?=
 =?us-ascii?Q?wSG+Caw0NxPuQMYjlWmutrmwBUKBbYnx1QPOODDHxnaNEx9c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00553d2-d75e-41ec-b71c-08de550e3c75
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:47:56.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ESA+QWUCC78ovojXe1s2ZUdO5KgQTtLHUrVpxUBm4H2a/690pZKgT2gikFNrYo8BQxIyMRX/EDy/3es9hpS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544

On Fri, Jan 16, 2026 at 03:40:27PM +0800, Wei Fang wrote:
> Add AF_XDP zero-copy support for both TX and RX.
>
> For RX, instead of allocating buffers from the page pool, the buffers
> are allocated from xsk pool, so fec_alloc_rxq_buffers_zc() is added to
> allocate RX buffers from xsk pool. And fec_enet_rx_queue_xsk() is used
> to process the frames from the RX queue which is bound to the AF_XDP
> socket. Similar to the XDP copy mode, the zero-copy mode also supports
> XDP_TX, XDP_PASS, XDP_DROP and XDP_REDIRECT actions. In addition,
> fec_enet_xsk_tx_xmit() is similar to fec_enet_xdp_tx_xmit() and is used
> to handle XDP_TX action in zero-copy mode.
>
> For TX, there are two cases, one is the frames from the AF_XDP socket,
> so fec_enet_xsk_xmit() is added to directly transmit the frames from
> the socket and the buffer type is marked as FEC_TXBUF_T_XSK_XMIT. The
> other one is the frams from the RX queue (XDP_TX action), the buffer
> type is marked as FEC_TXBUF_T_XSK_TX. Therefore, fec_enet_tx_queue()
> could correctly clean the TX queue base on the buffer type.
>
> Also, some tests have been done on the i.MX93-EVK board with the xdpsock
> tool, the following are the results.
>
> Env: i.MX93 connects to a packet generator, the link speed is 1Gbps, and
> flow-control is off. The RX packet size is 64 bytes including FCS. Only
> one RX queue (CPU) is used to receive frames.
>
> 1. MAC swap L2 forwarding
> 1.1 Zero-copy mode
> root@imx93evk:~# ./xdpsock -i eth0 -l -z
>  sock0@eth0:0 l2fwd xdp-drv
>                    pps            pkts           1.00
> rx                 414715         415455
> tx                 414715         415455
>
> 1.2 Copy mode
> root@imx93evk:~# ./xdpsock -i eth0 -l -c
>  sock0@eth0:0 l2fwd xdp-drv
>                    pps            pkts           1.00
> rx                 356396         356609
> tx                 356396         356609
>
> 2. TX only
> 2.1 Zero-copy mode
> root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
>  sock0@eth0:0 txonly xdp-drv
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1119573        1126720
>
> 2.2 Copy mode
> root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
> sock0@eth0:0 txonly xdp-drv
>                    pps            pkts           1.00
> rx                 0              0
> tx                 406864         407616
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  13 +-
>  drivers/net/ethernet/freescale/fec_main.c | 611 ++++++++++++++++++++--
>  2 files changed, 582 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index ad7aba1a8536..7176803146f3 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
...
>  static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  {
>  	struct fec_enet_private *fep = netdev_priv(dev);
>  	bool is_run = netif_running(dev);
>  	struct bpf_prog *old_prog;
>
> +	/* No need to support the SoCs that require to do the frame swap
> +	 * because the performance wouldn't be better than the skb mode.
> +	 */
> +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +		return -EOPNOTSUPP;
> +
>  	switch (bpf->command) {
>  	case XDP_SETUP_PROG:
> -		/* No need to support the SoCs that require to
> -		 * do the frame swap because the performance wouldn't be
> -		 * better than the skb mode.
> -		 */
> -		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> -			return -EOPNOTSUPP;
> -

This part can be new patch.

Code itself look good, but I am not familar XDP's logic.

Frank

>  		if (!bpf->prog)
>  			xdp_features_clear_redirect_target(dev);
>
> @@ -3994,7 +4497,8 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  		return 0;
>
>  	case XDP_SETUP_XSK_POOL:
> -		return -EOPNOTSUPP;
> +		return fec_setup_xsk_pool(dev, bpf->xsk.pool,
> +					  bpf->xsk.queue_id);
>
>  	default:
>  		return -EOPNOTSUPP;
> @@ -4143,6 +4647,29 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>  	return sent_frames;
>  }
>
> +static int fec_enet_xsk_wakeup(struct net_device *ndev, u32 queue, u32 flags)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_rx_q *rxq;
> +
> +	if (!netif_running(ndev) || !netif_carrier_ok(ndev))
> +		return -ENETDOWN;
> +
> +	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
> +		return -ERANGE;
> +
> +	rxq = fep->rx_queue[queue];
> +	if (!rxq->xsk_pool)
> +		return -EINVAL;
> +
> +	if (!napi_if_scheduled_mark_missed(&fep->napi)) {
> +		if (likely(napi_schedule_prep(&fep->napi)))
> +			__napi_schedule(&fep->napi);
> +	}
> +
> +	return 0;
> +}
> +
>  static int fec_hwtstamp_get(struct net_device *ndev,
>  			    struct kernel_hwtstamp_config *config)
>  {
> @@ -4205,6 +4732,7 @@ static const struct net_device_ops fec_netdev_ops = {
>  	.ndo_set_features	= fec_set_features,
>  	.ndo_bpf		= fec_enet_bpf,
>  	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
> +	.ndo_xsk_wakeup		= fec_enet_xsk_wakeup,
>  	.ndo_hwtstamp_get	= fec_hwtstamp_get,
>  	.ndo_hwtstamp_set	= fec_hwtstamp_set,
>  };
> @@ -4332,7 +4860,8 @@ static int fec_enet_init(struct net_device *ndev)
>
>  	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
>  		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
> -				     NETDEV_XDP_ACT_REDIRECT;
> +				     NETDEV_XDP_ACT_REDIRECT |
> +				     NETDEV_XDP_ACT_XSK_ZEROCOPY;
>
>  	fec_restart(ndev);
>
> --
> 2.34.1
>


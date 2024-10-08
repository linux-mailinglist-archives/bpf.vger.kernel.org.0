Return-Path: <bpf+bounces-41303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F77995B22
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417E1B264FE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 22:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9CA21B455;
	Tue,  8 Oct 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EOo9JOty"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA282185A7;
	Tue,  8 Oct 2024 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427700; cv=fail; b=FhTGOzyufPa+4b2Cmax54arH/p27VI829N0zRbMHRs3mvFxfDb3l/CyoiultBUR3zWmODNwoR+F0zOCzn9nwUaxDtgYebMf5MwEQEkil8xFQXWaI4I3GuRz+ZM+Tui7jfeq8hD2FwSH2BO0YZWUeDUL9WQPrbP1g0s9soV8NUGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427700; c=relaxed/simple;
	bh=ij0y+0VK0EV0SE7Zzk2IePDUrjyj6LkqfLFJpbypKQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UC7mtpgeiRdLJVsMOiHeF9rgIuXrH9MmjRI8Y7jw0I+xyRQpINVnc13x+zHvfEuAJHPoR33nXmdE3xuKWNXUC6U60pHph3IIdSLt0Ln7RxUcUUnU2hpv6Q8B4AimvSwHOoMbQjj/IB3Chg+Of95/p+niwOsWiLkcYebKl/BMyfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EOo9JOty; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTJzQTSbgT0w0Ib+MtRacrG3VlI7zeQF5lqOvwzamWEcMqRc6SFWpeaXWtNHTwp812vCko+D+bsLvr5qjVf+4jgh0R+SBiaBstzBkzpoDyY965bKL9GqW9z+kyHFyoxGrRgapf32WUTc5zIgsLEkCLULRVteLqVafhOymeVl0603Ceqelp8beSrs2VbmNAWRgEn8BNvLts3XJdFx8sHXjZIOSx98CKxzA0qTQGgODTNH9y/Fh9Tnk6/6W7rW4fo9UkcuxtwIReueGSV6ZRrLFqfJuL5WmrRVIedS0ekUWGyOyLhyBCjO7vsC1V1cQwO7TItfBi3wvp4QrsvZsQQJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIroOgaTRGy19/KvUuPzHIQVYoDEA11qR+BegddLGhg=;
 b=P0KC6SaFG3k6sUMOF0684te/kV03qvEWjwnSeqq0cxlJblanX2SaJ9ifBLWRtz1+Op7Vx2i7FmJhRauTstC8p+rEbryQW6QrKN3UloRZFYFkSvO/cxBJ75D3F5KO9akCq8PhN4cnVoYUrqdVRxctMgQ+nU+XTMGUnOMMmZlFeashhw9rYinG8uLux04ATkIiWHDwxUYpxKz2RLT04qHp4AGDEGLGB88sTd/fRguoyrKgk6sepixtH8YNhTRhCKkFlYJIeMYShSKvwTquwKfC3fcEQdUCS5RiyioC1nMPgrz82fn63neFzxUV83ybTUVJKwJxaTKTRsD+wqpL+f6j2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIroOgaTRGy19/KvUuPzHIQVYoDEA11qR+BegddLGhg=;
 b=EOo9JOtySQDMRyusz5FgUod3hLHC6ggrOFunvLefu6L0eQoNRbxlp1Oi8vvwhyPDtZ9zBkNJ2AmFwifarJo7KRG/p+1ZHgjqTBu2iC2GhmUH+gZWJSt1pnI0wOxuo5jmPPT/Rfy2UiVclccd02vP6Pb4wbjuRr7WhStvELsb7RIDz7udmguoCdonmdYiH8xJAVHyAwRY3ttO+KPjO3f8smW4VQCuojA4wUVuZtNC/ITl5UvQowig9ybN1cuZuBcAEA0RTXYTt+W2Vivz7MxzmriPHiRG3jbA1UFhcFBDb+mvjzd9cOnTJ1i9mU1x9r8vwWMGSRTS/ok7laBElr2koQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10381.eurprd04.prod.outlook.com (2603:10a6:150:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:48:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 22:48:09 +0000
Date: Wed, 9 Oct 2024 01:48:06 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"rkannoth@marvell.com" <rkannoth@marvell.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"sbhatta@marvell.com" <sbhatta@marvell.com>
Subject: Re: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Message-ID: <20241008224806.2onzkt3gbslw5jxb@skbuf>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
 <20240929024506.1527828-4-wei.fang@nxp.com>
 <20240930220249.dio23fh7mqw4pojn@skbuf>
 <PAXPR04MB85102EFDDEBED7C602ACBD4888772@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85101B7AC1C1F46E8DD59958887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85101B7AC1C1F46E8DD59958887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VE1PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: 293bf33b-6913-4786-2006-08dce7eb483c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jEXABSbn9LGD3qqhqTLEITUoh8dBB/7Li6ktgNAtFMqqTAOqX3517bV4fOfs?=
 =?us-ascii?Q?AwhufRrLyzh6TKIRKi5FJowoqPgpEnNihHHEDt/YGzsiP6E8REDCCkAx5er5?=
 =?us-ascii?Q?J3PpP0Lk0xM2ZIqaBRrch8x5WH1lNdio7fC3ZpLtDQvtx7YxI++ZMS+wcKtc?=
 =?us-ascii?Q?F1M9ta7CiZiC3zn3KGIKi3aHKHISOpSVIUl59AtpNCZa8M/MlhuSt7y7bh/4?=
 =?us-ascii?Q?GG0HuSbZoSA/KhqH7vQL+FL/En8PuC39JCqTq11Dt0xkVvXZRot8fAkMbE5c?=
 =?us-ascii?Q?cIlNitx1R3gvAEG5uazEMNzQPz0gcvkDc1fNxs/jrmVBEeVdQur4QKKILUtQ?=
 =?us-ascii?Q?AGm4cr0oinVfD8LCDtv7eaGBS8ervoHXqGU9R/DYnvar1L0vFL93gDf9+K/9?=
 =?us-ascii?Q?ooigbGRv4o5P8cVCh0mDyLHYJQ2EF9FaZ9hGzhaVh8NuHcOSX34mLvJ6yivA?=
 =?us-ascii?Q?7Iq8QWnslcocWQKIyI/QIhbQ/YQ+M1iv/a4Dg48CoRA6Yr9swcovew/rYrtY?=
 =?us-ascii?Q?2Mz8kdDiIRy5tPbASTjYrsrS59lLg9AWA0746iw+A3JQaNMcHlIgAg0zmcSu?=
 =?us-ascii?Q?zTBs4IeSFEfBgJeGQnuRuKw2ODyW4hYmy8OCp6WUE/jSulWL+153dZ311M3Q?=
 =?us-ascii?Q?rIYDvFTpTiIBiJ4jzFuUr7jujfszu9/TT6xzFPKUjuywNXHVvyJMeaDujAve?=
 =?us-ascii?Q?JSEkx6Qeu4/pH5UcwmSck3qu+Wu85ConMmxf6LD7ppGgER0/UoriLVJ7jtf3?=
 =?us-ascii?Q?TxFsaGHFEQJlIJ3ZJPurRdP350Jhp00hb3h5z6++wpB/chHuktG+lOelNvT7?=
 =?us-ascii?Q?oT1Yc726yCwQdfIGR9SCIRJbakQ2jI+1gkJLROXX9Oo2cTApWRTfS0QUh1Wo?=
 =?us-ascii?Q?MaOhk4QGCZBTajllmHAAh9Rs2C3PJYL82YiPV0+aBhYd104rroh6pxHosTTD?=
 =?us-ascii?Q?eth+kYFVv+WUJfPDRdiMy7k3+0CZgQmNYM9F9Byca4ej5MpGm9dlqK8xqn49?=
 =?us-ascii?Q?BVd63zCs1JJIyXrlnwT+z/jGaDAWu3PxKvS3Ufp8vSpBALPilZe36BlZI7a4?=
 =?us-ascii?Q?Z/0HZ9R7MaY7+FEyrVvX/+IzE8i+/EkXmwb0RJOuzUqvnwIA9r3qm27R2+3p?=
 =?us-ascii?Q?G7nFRIvXzHFCfvMS5a1CIn5BKY+yw5FczwtzU6mrxjm4HL3TgRtqh/EkEuvV?=
 =?us-ascii?Q?o6Gwc+stMiFFV0rcLOHglRpzOEBjTyZRa6fCNPcrjwYTJeVtrS9+6L8ge5EL?=
 =?us-ascii?Q?AK6o29wlX4SrjolRwVvbxcOedJoOK3jGgJTiLa4iwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMo0isPy6yEO589TeYRfcKj7mvSAL7JDbEImQKu4+32GtgT/eZEW/4oQxRfG?=
 =?us-ascii?Q?xSnbEdhxMdJghEXYTLrhYgipV020QdykOOLGHy+P7oZ2DivBVTF4ZQ1gJ1F3?=
 =?us-ascii?Q?GS/6GZUI+aNJcv/yRqejaaNK60wocCao42YDELHawqkWICjW34/lfMRgVO4W?=
 =?us-ascii?Q?ugufORCHzv7q+Et+UEbUuUVLXbHIcgkN2IV3gME9eAFusxDfRVzHmAubaH/t?=
 =?us-ascii?Q?HyiBFOX7w3uEC2mm3Q5d0nAgfFXw04YNr/WiARWBU07r/FWaNlSfwtMLnZk4?=
 =?us-ascii?Q?9Erc7hS4YlBzQJATTm4kbNYO0zNvvhT3VT8hEh/r1LCJskrBu2OwI+OaN+5y?=
 =?us-ascii?Q?mm9SMP4qWylYMs8AaBKSxgYMcdS0QzrefbpzSiS+Q9eF7LjFOnWFiMq5ZNP3?=
 =?us-ascii?Q?78GP2rqZBlqh+kUpqFnCJpgqWca/YwtLsNgY+JRbhZhIWZWiqbLVyR/BJSl5?=
 =?us-ascii?Q?gw+Y/gImMCR8bnF67LUiohlCPGZ8Tog3/0GxGeVaekgb0YIeQPHOS/5u/N+H?=
 =?us-ascii?Q?ASGur6B6/8KUa4MGhPhm/sQRYk7T1nwa18bHYdCIHioEkYYJkZiFTPBWhHp9?=
 =?us-ascii?Q?mg0j0wN8y8i1QNcYCahoWHfAoAqow40FH8u8r+mW+i4pJihuFfF/RXcs/pK4?=
 =?us-ascii?Q?LIJHqTWAf7az+XpNvuRU24YYhnO1p1VIaTU2DDlfYzhXuy6fmBjxTI6IUM8D?=
 =?us-ascii?Q?7ivLiyu5an+sIeDdyIw1ErwxgkaCYGAOmRETyBxc1Vgga76VKXH3bY4YftA7?=
 =?us-ascii?Q?o+WxBxY2y/1ZSSpHeoYbleXkadxaci1wpoub61ew73oBhccOE48l5iRy+B+5?=
 =?us-ascii?Q?V3Nz35A+LQy5mJYEEHL1w9y61Awli5o33SJojBetKX2gs3f/x0VlRQei8rF5?=
 =?us-ascii?Q?eGy/xaf4v6t8CdzrPl9XMc8reYKC0qNbrM08T5f0MkAnR3Fu4+BxX+UTpcAb?=
 =?us-ascii?Q?oXZvzhzF2EIm4QPUpUoHRXlxOJHWbKOGaGPx117kZ6/0HtpFfTUoltoJhU2e?=
 =?us-ascii?Q?mD1kB2EwHIkiCxfwC+REuLkgBpahi3isi0CEGwig4xo8ro3oJnJDZ8p4XDxp?=
 =?us-ascii?Q?V6p6QbFp5XQSaUOrPoVeG0rcd7CnzhvUXddwpeydgzU1FtJiFcMfnSp51F3F?=
 =?us-ascii?Q?VDAtl5MnkqNY9miA4Vs8mDRIX5GeuIEnzucqFG+/6g0Zf6sUw36l0fh/doN9?=
 =?us-ascii?Q?su84HMwTOqoBc55miIw28Ag60SAbt6atoFJYpXcUV3n92S3l1HbswiDU+NL4?=
 =?us-ascii?Q?z25raBQIFFWtMLUhXX6FwdLXbeHtRrVFzsLbNmSx7I8Gmyu7C+1N8ppExcx4?=
 =?us-ascii?Q?RHfAzYz/45fEqK/n/XExbJ+RPBoMfG+igvIf2BMLndkKL/TCxkXbvzs+MqTA?=
 =?us-ascii?Q?1wo9z6w92IRWYaNGu2+/zxujhEMb7ZOfa5et6nPKoHcGye1upM+BcrZOd0f/?=
 =?us-ascii?Q?hLFyzI+HELHGAVVT6z3mEAOMh4Acy+STMWvLNE3VC6wKskHt29yFr9nn3hMZ?=
 =?us-ascii?Q?ZRmYobLwwmGY6RoGuvIg3l7Jo/ixgc7URxwiGn+c/Lq68t03E1cdlya2woSj?=
 =?us-ascii?Q?1gfTf5zXU1p5BWz0q7B4c/vOZf0FtEeRMu2aE3yh76nrg/bkO65Y30WrXiA3?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293bf33b-6913-4786-2006-08dce7eb483c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:48:09.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: civ8GF1ItZe4Z8vx/xTSv/RZpyT5wCtJ5l6ISEs9wLgm3GRhVT+h3KW63wrtIQWBOD1H/DLWUv5KT+BI/pLCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10381

On Tue, Oct 08, 2024 at 06:30:49AM +0300, Wei Fang wrote:
> I think the reason is that Rx BDRs are disabled when enetc_stop() is called,
> but there are still many unprocessed frames on Rx BDR. These frames will
> be processed by XDP program and put into Tx BDR. So enetc_wait_txbdr()
> will timeout and cause xdp_tx_in_flight will not be cleared.
> 
> So based on this patch, we should add a separate patch, similar to the patch
> 2 ("net: enetc: fix the issues of XDP_REDIRECT feature "), which prevents the
> XDP_TX frames from being put into Tx BDRs when the ENETC_TX_DOWN flag
> is set. The new patch is shown below. After adding this new patch, I followed
> your test steps and tested for more than 30 minutes, and the issue cannot be
> reproduced anymore (without this patch, this problem would be reproduced
> within seconds).
> 
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1606,6 +1606,12 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>                         break;
>                 case XDP_TX:
>                         tx_ring = priv->xdp_tx_ring[rx_ring->index];
> +                       if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags))) {
> +                               enetc_xdp_drop(rx_ring, orig_i, i);
> +                               tx_ring->stats.xdp_tx_drops++;
> +                               break;
> +                       }
> +
>                         xdp_tx_bd_cnt = enetc_rx_swbd_to_xdp_tx_swbd(xdp_tx_arr,
>                                                                      rx_ring,
>                                                                      orig_i, i);

Yeah, it works on my side as well. Thanks for following up.

I would argue that the above snippet should be a fixup for the
"net: enetc: fix the issues of XDP_REDIRECT feature" change, and a
rewrite of the commit message is in order. Currently, as a reader, I get
the impression that only XDP_REDIRECT needs to check the ENETC_TX_DOWN
flag, only for the next patch to come and say "remember what was said
about the TX ring not being allowed to actively transmit frames while
disabling it? well, that patch wasn't sufficient to ensure this condition,
because XDP_TX needs to respect that flag as well!"


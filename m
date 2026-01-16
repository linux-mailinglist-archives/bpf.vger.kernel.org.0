Return-Path: <bpf+bounces-79254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A6D324E9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 888793015460
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065092D63F8;
	Fri, 16 Jan 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E25kIafv"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384B2D063A;
	Fri, 16 Jan 2026 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572296; cv=fail; b=Vy1hQD1Nid1DOG+MyKiUQlfhubs8CgUzHNxzxwGzWhTlj+7Fz4sLLkCZhL2bKmosP/WUtMrIvGljJHsW3W26tEjMarBi/cKHRf36AtgiQcG210kYuj7kZwvSkUofnPbf9BNLTmjlbNcT1t4BVjcl4YlFJTzKDtgya35oWbDqb30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572296; c=relaxed/simple;
	bh=9dfNBWato+I+q7RGTLa+wXWj7atKjI2blU+unnKWV90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ksYdrBdbFEDXmkBaxIQ0o23nh9agtJJGHz5qZceg0uxuXKBLh5WduNLhUuxTJECyP2p9HsGISSjtOe4mz1WZHJHIyxMarZ9lUpHI2wlDjot4TZRJwpIhIkcKsjpgA2FRb2GMBrWocL/22njr6EJF4a9OyX2mI8oDlE0yazdJcy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E25kIafv; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFR36S1m/gMFmhULVYsVDA/cxGW0PLQFi8Tclt2QreOviF2InLs+Rd6KDFTe+Yrl58wms745A/cUdrLmhcuyvoop2EET5cH4owiu+fhGU6J8euc1cwgNEsdMSlC+z7jTaglJYutWs3rfh4MxlIur4KxF5avsj20sfBmjxCqzndTVQHv2QFPqxerx9Sk49qDQEdT98n0cvRFymdTHMBPnP54CgRIIKUHYej1Lsc+Dnd5ow0v9x5G98JPLIN3DS+N3ZdC5M+XNs1lq06umv5QVwCXetw6WGt45+GvoPRGNSGXJazalar6SHd+S5idcRWAdtXC4LE2TgiWXtNSYwA61qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FER/LA1oGYon3nsey3wSdfqa2C4v+z++9VO28mmfSCg=;
 b=oMQBJ8ujr/AX3S5reXPvjwGSZG/6QJH+wIOe9ydN3/DqWYkAxPyrJj55SZvn6BnDqUQthLHZzzyFARloZNAowAyLzveNYVIF6DQkGa3u0ci5zc2ZG306e6hdz0FyoiSVqcnyhG8oYK5KqSWNvT2tmnjqlXwdAP4Jx/HJxKv4hVj5Ep8HCcagGY24qbliWtGmrQ0mRJZQa1MXN3oyW7IbD2wv5exNFYaDudmf5sjx9Ch8nimjVR+O6JPJiVnX2Bn8XVdZw3cE5pm7+pYZVs/qQxvrHwdpEyA8VRIBvcXwxt1XMCBHkg87W7GZA5tno/ZyNAwjETyDeW22HQ/dOmi6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FER/LA1oGYon3nsey3wSdfqa2C4v+z++9VO28mmfSCg=;
 b=E25kIafv0M0dtH2vtpDsrQGdBHqJfq06Yg9ZBfAl7sCq1MBHqRfoFwlxd+4DfbLkH10SklGqJ0CZd2WGaK1JUiNRm33AuQFWbi/2E8qMfjRpXX1AbAKVyVbIktCi6zyybB+NG9sHDvmUmhbWxTyNEsm/DDFB+DtXG1WNNR4J6S5uXmz0XBAVmYaaqrzopdxKAx0b/csse0l4ST9oQgf7NijMOCfFzsKRyiEfKeiO3ftiXBUiAE/GLIUy7LFNhpDNf5xxIgwvgcMqI126XgfhpDolozp4pRikIH1rifzqAm3bh6gDFwvB+47GnrXMo2k+8dInkwL5pYwDq4hoh8r7uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10758.eurprd04.prod.outlook.com (2603:10a6:800:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:04:52 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:04:52 +0000
Date: Fri, 16 Jan 2026 09:04:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 07/14] net: fec: transmit XDP frames in bulk
Message-ID: <aWpFfQ8se5ipy7G+@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-8-wei.fang@nxp.com>
X-ClientProxiedBy: SA1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10758:EE_
X-MS-Office365-Filtering-Correlation-Id: 6145eacc-201e-4ebc-7143-08de550837ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z1RgGuMfeNYkZwU2oUC06AiL4NACJ+4N++6KvIyk/PnFePCrYOKkXdS9Xmxi?=
 =?us-ascii?Q?hSLOA0Qh6Gz3HZ2JEGyY4CjZftBfIGz+HkJQrbqTegEE5TB9LTn8vBKvhZe7?=
 =?us-ascii?Q?zYg7JReO6wwpe1tnpF9fgDozqFp1QgaARE3/Kc3TkAyd75R8ww14wJc83Wev?=
 =?us-ascii?Q?dBSo+2XDlNefUYD80V87Pcidh0Dz8a1viI9bSbFiLChUPVhpZoLxAjFYqGIW?=
 =?us-ascii?Q?3XTge6Bt5/qLen6WoaPFp46pJe+NIXkA6JH92KiMjcpDpuh7Ti1qUJktz7fw?=
 =?us-ascii?Q?RLUHopziiFkEgW5ViOSC5NGUx42YN9CL9mLhswQE9/OaBo+/+Ht7cVkztDiZ?=
 =?us-ascii?Q?P11DwDw1MgM225E1gyXs7RamCrUyoHrpv/xDC4VZnW34t8cl8VU7og6IL3zL?=
 =?us-ascii?Q?+UlqLpI5HY8CQOpjQoKOENh478eXVvNflklmTOZ902TqQnWAPb7WkTEMCjk4?=
 =?us-ascii?Q?JO2IPfEHpoZaAeJ8IBEyx2mFKvwwFwE8sTz0fOeyviVvCVaPjHFmXd8Y90gS?=
 =?us-ascii?Q?nZQAkSoLSy225JDdH9FQaYG7lxprG9DkfKNQY+QtuTAc+I/vfy1cITs+7Qsa?=
 =?us-ascii?Q?Xc1Ruk4ncmfafR4EvFQ3t1ZVmkTibqiQRWnB6stlwwMxIFJfA/1J8x7MIF4t?=
 =?us-ascii?Q?uMk7OaE5uHwVAm/1S3aqqvnJ8OnyIBjRyvKmfQ8xHvdH/fYBnboDnXJq4/HC?=
 =?us-ascii?Q?TBzRevo6M0AZ2f8V6FFSWAYZZH9FHTNGNc0gkfalMYoOmCuSeef9y2U26h8+?=
 =?us-ascii?Q?UH9RzWAS/b2e8i6m2DqD192I8oW2AqHrMBe7cVMRJp6raLEMMKZXS6ASvC9X?=
 =?us-ascii?Q?QBngetmY92XjYobXebM/oSAtEjbAWvNu7DIAs8HKRNS5JS2veYRcBRkYK/BG?=
 =?us-ascii?Q?e4er7YCyupnqG5db+uxh47hO3R11R3P3nU5qGbvcco3lImTZs+DkuEkyz7b5?=
 =?us-ascii?Q?QzPnR3tfiQYuL04oUPTdpRCE84PRx/yIxaXG7HvaCa9SATjyuCqiMVZDM+uB?=
 =?us-ascii?Q?u4Osfq7FOKAVrcRBD6TgBE5BTPE0MjPu+M/w9E8yDVBN2KKVM9MQUw2QrclV?=
 =?us-ascii?Q?O83A+NNke1xgHxnOFihQVcQfjDjWcuSmenj8JN2QZGk49+I5DYNTT6hI/zKS?=
 =?us-ascii?Q?VH/dJY60Z3RvB4PIHoi8J3vJXIn+yWYGumCfdhEICJtytJTUpGKd22OE8kfY?=
 =?us-ascii?Q?kfik8WO4EFqbV4UZO3g9CE61HgutduNtmjSx03StBpq+CBgsgDN8s+n0xLGF?=
 =?us-ascii?Q?Mp5LvD8l92eE39AsqvRtTf6Vm2w4UXb8APA9TOkBBJAcEQTNqqXmpQkIEDva?=
 =?us-ascii?Q?B79cNfxuWATCmN1y104hRrhSLdz2eB53jyiGR5jurrHaDRdneqPybQZQHg+t?=
 =?us-ascii?Q?p7Gs8qTOwtcV6VrqC6odt/DJg+NH41mL0A7w8BJiL7mb9ydWyiqKdcYUwKk8?=
 =?us-ascii?Q?T17WiK3576iJdtXkD7tmNwNxnZ8Kg8g9+5jcca1uz5kh32MV6YzV/fEVVvwY?=
 =?us-ascii?Q?XIcIP05SB+nNfTvRlRZF1eERWx97UPEpwxSiR/wxyYTx/M/6tBjEgTZzBmBc?=
 =?us-ascii?Q?ggPCsXoskFJZ9eeQ2Nb9nQmxcuLDINjBFeXF6WPR2mQNx5DBCxe0RDsDWJgK?=
 =?us-ascii?Q?7Cev8SDecMVtfTW+Ygqxrc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ArCT7NsxXz1V54/lH8P0B4005GnxQUIWVD5lxWmks0KITkYHtPlibyXSTxd?=
 =?us-ascii?Q?BCPZpxxsmwy3aF8kN8fRqH2cwz3VAn5IevXxD3MjzSef26BeaQdV7u67qCUX?=
 =?us-ascii?Q?q9Q7MZDfXLwAGKV1D6YQH8eR3096wrSGTT0e5cuomMXfiNElJ/549/ADj9Hg?=
 =?us-ascii?Q?8Bn2kMhA5LP7/8E+WcyfXzd8zqwFSjivbWK54nB281WTblQV5lYZux9TDg0D?=
 =?us-ascii?Q?u1GxXEsMTMKN/hrQQHgMNoUI4B8JierNPdjzurHKv2shijREDQk/zQJwqdCB?=
 =?us-ascii?Q?oa/MtSmGnAMmLKEXYPauoGuT/0fkI/LLGLAZdfvZHPIQH5lQ5cnpLapBAxA1?=
 =?us-ascii?Q?axbDtlgjtq7phUm0MgKoJ5vnFaxftMp0j3Xdh4vyx7RK4CY66UeIAFe4GtRE?=
 =?us-ascii?Q?Re7fc92kLToni3VHaWUIigc6rboBqrNBlugVBHuMJDdl9RBKufW1PaR4onQf?=
 =?us-ascii?Q?exMktVV1J47jNCGV6ftBahDJc1bYpBU8PQH6ioksyEJhPVlIncMYM0F0ygd0?=
 =?us-ascii?Q?t3L2Oa5wPIVhMGPVbLeOEaQDbzOi7ZhJ7Bx9Li8OvRCAMyfQpZCnVbdAf1gL?=
 =?us-ascii?Q?mZKDRaOOn/IN8oNVLxla51n/CgviEwHu1v97XFK3eDR8Gy9Cz+ZUxIW7IeWQ?=
 =?us-ascii?Q?93rt+ALnotpTxsXRQLk+AU7vJc8etXcJRb6Q4JWLm3J2iHbeFenIDn7gXve1?=
 =?us-ascii?Q?o8/7qKLKxziWIRoEcDIvAXMba1aOWovX2iFLlnmPNZWqbCC9ZJCrgSCnmJ4S?=
 =?us-ascii?Q?UHTNIpcU+ELPyjcABTFzfDSAR2UxKc5SjJdOmmnVpPV9uzlSE3tuIXJQiBuO?=
 =?us-ascii?Q?vCe8kIkJyIOU9annhK9XB9NPZFkWTudhUCx4RVYq6QbHPijVcdm9heQaeCLW?=
 =?us-ascii?Q?l9dIsTiNRLEOe3IAa35FYniCsyj8njRO9cyGNJNaiq8eWMHowqWkeHAt9mEv?=
 =?us-ascii?Q?IAOlEYswVr/sjLbeGv+N/APadvV9z4h63WWI2iNVmN8w9sL1FrfI7lad0FE2?=
 =?us-ascii?Q?5NsyqHOMJZOwFAOlSQBlskhq66WmuPh5Su93sOkSKyZQA7yRhyqA4TLRB4sZ?=
 =?us-ascii?Q?7sH++Q9oWGHgBJ7hTM1oa89B+n4IZE3ZWnxZAO5IPp8EpS7TCj/qtYEl03OM?=
 =?us-ascii?Q?nlkJmINNojTRsKJ9S8KR0RLUMsurNVevHYCtT6MwT6dvyYySN9ssSnTAldKv?=
 =?us-ascii?Q?Jh/xNE0VgZiFPiYUK+JLvL+ul3xzOGIUDjW2UIs45TcER2G6fHVr2Rc5Kvmr?=
 =?us-ascii?Q?gyU79D3d2aWdmxofseILv4/40UUE0lxfAeXIS86VqejJ5LAv0AaQMrn6+GaH?=
 =?us-ascii?Q?UOFsubjOwHuYGMMKRkV4a0WCe1eEeZy3z35Nl8ntF0LSoqtb1Y/UTimIsFVH?=
 =?us-ascii?Q?NOKAgvLHDRVgWBrktc2IMRj53dwPtOVo9CBM2UZOsiv8NefN9DNrXb2E34qC?=
 =?us-ascii?Q?8oP039Ocwgpd4NXul7+nWcx/gubwhFBcsoZ689V1LltC/93bTvTjdhbTPR3l?=
 =?us-ascii?Q?ZXgfgW6dxVdvsvVruwfKmHcsoiKA2ogOh+is0EF5n5QnHV+KMZ3NMMQX7XFP?=
 =?us-ascii?Q?813Mp1SRPFiGhhyhInf8ZgYNVe4PMHLM8Go4gKkDcd2/9+FFv0tinkKoxT8S?=
 =?us-ascii?Q?9AUXhgxKP5JI9JpX/07qHU8zvZe1NdgRfj7V/iCvbKy4ROFLU8PXVChkOGrm?=
 =?us-ascii?Q?oPRh/CHZzhMO2bPj02tyEWwN32uQmRuL87hRGI/VFSBtsBFa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6145eacc-201e-4ebc-7143-08de550837ea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:04:52.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0HZ7HOfx0i3YQHUp5+vH6aFC+PU3hTe5P0DzLDTQRHt64jh22VyWaF4DINfyLzscD0qTWu60X+23QBDwEW+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10758

On Fri, Jan 16, 2026 at 03:40:20PM +0800, Wei Fang wrote:
> Currently, the driver writes the ENET_TDAR register for every XDP frame
> to trigger transmit start. Frequent MMIO writes consume more CPU cycles
> and may reduce XDP TX performance, so transmit XDP frames in bulk.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 251191ab99b3..52abeeb50dda 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2006,6 +2006,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
>  				rxq->stats[RX_XDP_TX_ERRORS]++;
>  				fec_xdp_drop(rxq, &xdp, sync);
>  				trace_xdp_exception(ndev, prog, XDP_TX);
> +			} else {
> +				xdp_res |= FEC_ENET_XDP_TX;
>  			}
>  			break;
>  		default:
> @@ -2055,6 +2057,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
>  	if (xdp_res & FEC_ENET_XDP_REDIR)
>  		xdp_do_flush();
>
> +	if (xdp_res & FEC_ENET_XDP_TX)
> +		/* Trigger transmission start */
> +		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
> +
>  	return pkt_received;
>  }
>
> @@ -4036,9 +4042,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>
>  	txq->bd.cur = bdp;
>
> -	/* Trigger transmission start */
> -	fec_txq_trigger_xmit(fep, txq);
> -
>  	return 0;
>  }
>
> @@ -4088,6 +4091,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>  		sent_frames++;
>  	}
>
> +	if (sent_frames)
> +		fec_txq_trigger_xmit(fep, txq);
> +
>  	__netif_tx_unlock(nq);
>
>  	return sent_frames;
> --
> 2.34.1
>


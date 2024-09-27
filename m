Return-Path: <bpf+bounces-40419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EAC988726
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 16:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AE1282DD9
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DDC1531CB;
	Fri, 27 Sep 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O0PDo8ra"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816184D13;
	Fri, 27 Sep 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447596; cv=fail; b=gEfh7NEQmXZg92+Dn+WIC7+LtMQLeqexMAWHR6Nh3QklaDzd/UhnfqAL5kxYdA5SnBcZLXURw3fsAW551ufnc8LhnD5p+FdsOmjiTbBAjW+zYoiPePvWTmMO2ZT75fzxM8MedUghf3dzqkl4JA7mCSm6pxgNFCppA05EOW7tUd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447596; c=relaxed/simple;
	bh=2T1oJ5aupdpUhrsGMobtGMP0QJJQR93KoXOdQJZQTTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcTHJ2WfpDF6zWBaBG3aoQ0SFCUlcTsI1cUPC5vNOFBtbBHwzRnRtFC/7ZmfcWqJ9V+k5zA+kbl15nEe8WlEux//o/HfGDb9IFNCC1tjnzrTKl8ZQTcPF/kAC2NXh+PDcaghvHri1t9zV2DuZAUjPDxnht4gxwXx4wx4ex7/peA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O0PDo8ra; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XovaoSxVExqX332SwgcYkBG5tAiMTCOFuDC7pgeh/aCYCsYVmbk3u1FBGhBYvqZSUUFZG17R68LSsyBDUOzA7HxFqKsKf5ulBnC19DGkK3hN5Kdha6VISjFLJxbQupCq7VENpUPwlLEDnMQJmR10s3RDS7N3NG0jDYAyJmTa3BzwUjoRzidMvNIEbrgrUzvmjoTgpCDbHzqU7wbc814mg7KGOYRvbTSiAi2zXYdSQeP18k8XAWS1SUuYLsPJDg1hj0PSJXyJUht9EpmMKqWjFzWpjCYNz3ECurFSwp7DT8zxQxRhwgJ/AEHRzm1B+u56HpYXPydJdVgH4Q0UhjcuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT34bhJCsQn3xxJWgWw545ezggihTffmcv9UzLkuPqw=;
 b=sFk2EkSK/Z4OeKtd2yVUg6Q3ErOUrZlZF0+V3+8eR1gY220qpGhmFC+Bf6ipIrcjuOs/npTV1dSuYBdY63D2z8M+Yu9JEfpMgvRvOWoSQj8zVMjxF6o4jMgsMX5nMznwF888nwt7V1SrQM1nfdBTPfmv5T1QDjSDM/kjTQpZeje4FwKbyl1AlAet6vhMNuVCCdHtUx8uO+WQtIdo2qFyfky6sTdEN+0NaOfToAiOjjkqzTNLkvYUiFpPjRQ5Sl2Fuo4Z7pY+vf0Xir44jO/Msmc+H1QsVyCkrX5lU/WpX022XGGHILwHFmprUaggf0CXT4BvkKOLyDSP1z35ACutYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT34bhJCsQn3xxJWgWw545ezggihTffmcv9UzLkuPqw=;
 b=O0PDo8raf5f3Mhy9pnd2C+YZDaZ16zGzbIfhic0CZqf/IiWcprMKeAHylAIUG3flJhidO6BSnCHcHZGuui3ZjC2LYjIYP1u5LPYAQl9UsJguO6xKIdpDrX+/70KVT2Tbui4DuMDKx9oCajyd7gzg8GMz3NEzLaNhqVfcX0zfcAw1AmkPDYdVayk6U3qcLP85GrciA22jMwhDErrWX6O9eDBkI8hbjme0umuVoELH0ZgyoqnYcVh6Xs3yf6n6U9pOeFauyujfKkXqUdqou171u94e9+0UniwW6diU1pvDXj2sWWw5TxrnX1iMfI56x2l6BnOrQbKK5wv3gSnAF1b+lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7641.eurprd04.prod.outlook.com (2603:10a6:10:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 14:33:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:33:12 +0000
Date: Fri, 27 Sep 2024 17:33:08 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
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
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <20240927143308.emkgu7x5ybjnqaty@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
 <Zu1y8DNQWdYI38VA@boxer>
 <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240920142511.aph5wpmiczcsxfgr@skbuf>
 <PAXPR04MB85105CC61372D1F2FC48C89A886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85105CC61372D1F2FC48C89A886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BE1P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eadaeb-d7ef-46ee-6b59-08dcdf01508e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eRla/qukmuMfoYqoR5shm6wNi4TG//hsgVciW1gzelHVmrVp8CJKkHjvnKjn?=
 =?us-ascii?Q?ID5wo6y/9BgbUYF5R0Awc+QJt+nkeAibHKEkSgpeWRjhqKW3cOvbiCLMskyo?=
 =?us-ascii?Q?wdbdcwOS/Mysvv6e7l2Pdsdsie1liKwvDNTSvivWH55DV5HRY7KErSO/uPS8?=
 =?us-ascii?Q?DmVLRlVVV4n8ErIJpuff61jid0RenZVrwpkTCHefNNDNbZk9/BJfBgcFEP1n?=
 =?us-ascii?Q?PDuHd4tlZA736ORUqxBJJZVhGiMF91LYWdXim5/p0RVFNH9o4uUQ4TgSOLSF?=
 =?us-ascii?Q?RWnFqFIZMRdFjKpJ7EdqtJoWeC/6W40FWBe501dW1cD+EE+hq6eUQeMoiUFn?=
 =?us-ascii?Q?m/UZ+WeHD2Un7WMw5wp2uyQLzwgzANOAT6AYw2I+ZE1UiM89r3Pn2174E5Jw?=
 =?us-ascii?Q?90NPg/Mb4OiY5FmbxpBjOku1lGjedqB5F7i581B6Kg7ZUWHWVl+uWiw7EKRC?=
 =?us-ascii?Q?F8L4RHm7Czj6dry9M+9W8kvnRyLujRGvE1tTtW1DbeTPoePAfiVPWBPOazf1?=
 =?us-ascii?Q?KDgTbAcZZvSGiRyj3DjBRk8+OnJCdr2bd8ML72wq8jvZpSl+XGTgnI55Wjvv?=
 =?us-ascii?Q?pXtbfQMR0bDM16vrAemxcTZLZO5hdLGStqxE7SoQzR6eXCdaIILkO1Q22yZS?=
 =?us-ascii?Q?OYTLcTD4h//Omv9acd/4qLaK0xZrPw+P5P8CcklkGs80KT5SgDZfAThr6Qh6?=
 =?us-ascii?Q?ABs5YZp1AvY00HOarXHI3mGjXotpllfsOCMKoHE0cRuzmz1BOfGRbDtSG2i7?=
 =?us-ascii?Q?ofooklJQgvCeyxnFh/890InIxzeyIj8VZ546XPnJBMx46D6MddEh92jmSDCp?=
 =?us-ascii?Q?BZojJyh0XJayWPQJ2VrLPWGEGu6+r2ZnDZG6WPaOhKCxAGkJ+saxXPKaeC4Z?=
 =?us-ascii?Q?S9i91f2RyyXZm8DO1z5WV5imMMqJbsVBZdHqX2rMTYwUi+pW/0uPN3hXzzkd?=
 =?us-ascii?Q?H3rs/7Fd59JZ16+Sxc2cErJD4nH5WIICFxIUCqtRRWjxhBLKGVgk96PJ2Nf6?=
 =?us-ascii?Q?mUoRgBVgceD2Hcc7SDOPZtXgW/GGUUwc+JzKIZOEbE4mz5AWYvnVM1d3lKVC?=
 =?us-ascii?Q?CcBVToaCOu9r1UMp6E08ho7YI/05e/iLteMMIKMv02OwhIHPJdwdpW9+Lp4b?=
 =?us-ascii?Q?jU8SdJNm/M+EMny7mG3jfP+opWDzHgSgT0eBGx05i2d343IvORVSawZm3jMe?=
 =?us-ascii?Q?o5wFWUG1IJ63qdl4wTx6quG5S5tTJmuMlVzPG/nZ3udYFSt0P+lbhWSVQTsw?=
 =?us-ascii?Q?HxRNJasWm7zX6sVrcYIuz+tbhSpt3RKNKBf1NAsu9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7x5gvLtgCFhQEUjP7JJe6nPwh4gX5ddFdVWU2t1aUyzgAdiMERk/kaTt4Q2f?=
 =?us-ascii?Q?fzjRRjHzvZ0zvvDUxwr3qTCu51T9sR82fULggwp91cvGjoBxgc97R8MPveom?=
 =?us-ascii?Q?CJJZCjfEIjRvb7mgJHII6wWOOFzmfJxZQ47TBc9gTFpMbDRkC0CDsFuyBOQ+?=
 =?us-ascii?Q?YknyvWRMYvMV+C3j620m8A/ZX+WWBjNMXuc/V5bbnFawpLVzRL0dgnOCn52m?=
 =?us-ascii?Q?zSPX4eP36nz/ta4DD8q/vFIS2z86vzdoqPd8Itw98QTdtLJNWDYeit8sLy5h?=
 =?us-ascii?Q?QpWVPdQSI5nVg2RK2A7iZWsUmav6VZN9GpDjLrdO5MvIo9R1ShbcNh3RDPuV?=
 =?us-ascii?Q?QUmY65tX27+SfF59ZIcs4Oy/MKlwtQ8uffDJULiEokx5gQqUg56A6dJCmeTr?=
 =?us-ascii?Q?TBIu1YqV0Um9NDC2QGmFHZoZm/F5hAxVctjBXiRNVUtE9ZIo1/QOlI51/BHU?=
 =?us-ascii?Q?o365eOG0Ocb5U7YgZfbPB6DfKzt03zEZuSatiu9LQ+0lZY4qPGQS+o9ZMY4V?=
 =?us-ascii?Q?z9+33BMaSRfiWMgfakf1hy9AaIuVDr0f8ohLiSb0qed+as7Ib8EKwTxPw7VP?=
 =?us-ascii?Q?TdjlGeftOHV93IExznmZ8Fdbga0/D52NjiNpJJMCJBXar2Cd5/ZRrm4mEjIH?=
 =?us-ascii?Q?INDjj7mjquAARtBtywimMQ3VrlFHw9GkqICBVHEjXdx5HLPEz65ZL26s+j3a?=
 =?us-ascii?Q?VqYbIcOG8jQB/Wz+Xo+78fxFYDRFgv1Fe3DTkbS0upsRb9lZnnwhw0KALSKj?=
 =?us-ascii?Q?x2JDmkTZfyy0voJazhZf1hSnSKA9mMUBqDrdAT/rJ8hlPrgnyyant3CBcDei?=
 =?us-ascii?Q?0dQsBonop+pOKxyh6Opuf5FhvWIbMyDF4rIFHvkae0fA0EyXWemGZvrDSmv8?=
 =?us-ascii?Q?qo7t0g0OvGSabUT+/Q/X4zjU6yF+9NUC2CrEbuUAowF7C3J4pjfg9hp8Gw3Z?=
 =?us-ascii?Q?He4IURJa3AhgKZAl6K+NScNJwWJZGTzvt2JGApg6RCGW0erjKeytfRBHNHnr?=
 =?us-ascii?Q?F45SXIAwBQG/7MGWiBBakozhQKHUUP+XhgD/qVANgqJ1x8dSl1LR5gFYa8Aa?=
 =?us-ascii?Q?dv5xtwe8I3p2qe5gL9O8CSfenoFPi63OB3VN7TRwOqcDrXB71mqsqj9/7oY3?=
 =?us-ascii?Q?Xgm2eNdj5Cxr+kauswdWmNIrE5C9EQMGXXg5LY6fTXS351sNhf6g4Qj3gTik?=
 =?us-ascii?Q?iIucGH8P5tBT7zccKDGInLpacZyqzhtmcRgsCv5wUS4ReFHe3MB+jB/Rbteh?=
 =?us-ascii?Q?tzDV5HS4Qo19Cr08Rsc87ZpNrVnsSe94J9Gp60d30Pz6EIOpFD0uVaAjBwXs?=
 =?us-ascii?Q?ewYVzehbVWppmxvlVD+rF4N5qV9e00SijefVM8ilzDOMHD2s2oxkTSCdkYTG?=
 =?us-ascii?Q?aMvpxpRmu5LoBDjByLZXhLgUo2LRmRvlECyC98u3ID605bW+stalHqg48iI+?=
 =?us-ascii?Q?d3XwIt5jk/ccu04odshRqeWzR4948pt3aj9IxAF5iPGYsrsDxxOyyk9+n7pG?=
 =?us-ascii?Q?MUjLKlwSGQjmo4SpEBsyrRqgj8dyHe6aikR9b50yjdXt/wQi9sW8+TsemwkZ?=
 =?us-ascii?Q?RKt+fC/G5DCvfjhUANQ3VodaK9N6U+SvOTFPb/UVAG/CDl1OZGUxK0IMYW/h?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eadaeb-d7ef-46ee-6b59-08dcdf01508e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:33:12.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+Pbb+EcIk5PwuI1TUAXnd6N/xmHQQnAuGGvFf0wQX/uOxszYFIjSxCNuPoNJ3WEe6cTIVGCDEqWRG3uGSXl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7641

Hi Wei,

On Mon, Sep 23, 2024 at 04:59:56AM +0300, Wei Fang wrote:
> Okay, I have tested this solution (see changes below), and from what I observed,
> the xdp_tx_in_flight can naturally drop to 0 in every test. So if there are no other
> risks, the next version will use this solution.
> 

Sorry for the delay. I have tested this variant and it works. Just one
thing below.

> @@ -2467,10 +2469,6 @@ void enetc_start(struct net_device *ndev)
>         struct enetc_ndev_priv *priv = netdev_priv(ndev);
>         int i;
> 
> -       enetc_setup_interrupts(priv);
> -
> -       enetc_enable_tx_bdrs(priv);
> -
>         for (i = 0; i < priv->bdr_int_num; i++) {
>                 int irq = pci_irq_vector(priv->si->pdev,
>                                          ENETC_BDR_INT_BASE_IDX + i);
> @@ -2479,6 +2477,10 @@ void enetc_start(struct net_device *ndev)
>                 enable_irq(irq);
>         }
> 
> +       enetc_setup_interrupts(priv);
> +
> +       enetc_enable_tx_bdrs(priv);
> +
>         enetc_enable_rx_bdrs(priv);
> 
>         netif_tx_start_all_queues(ndev);
> @@ -2547,6 +2549,12 @@ void enetc_stop(struct net_device *ndev)
> 
>         enetc_disable_rx_bdrs(priv);
> 
> +       enetc_wait_bdrs(priv);
> +
> +       enetc_disable_tx_bdrs(priv);
> +
> +       enetc_clear_interrupts(priv);

Here, NAPI may still be scheduled. So if you clear interrupts, enetc_poll()
on another CPU might still have time to re-enable them. This makes the
call pointless.

Please move the enetc_clear_interrupts() call after the for() loop below
(AKA leave it where it is).

> +
>         for (i = 0; i < priv->bdr_int_num; i++) {
>                 int irq = pci_irq_vector(priv->si->pdev,
>                                          ENETC_BDR_INT_BASE_IDX + i);
> @@ -2555,12 +2563,6 @@ void enetc_stop(struct net_device *ndev)
>                 napi_synchronize(&priv->int_vector[i]->napi);
>                 napi_disable(&priv->int_vector[i]->napi);
>         }
> -
> -       enetc_wait_bdrs(priv);
> -
> -       enetc_disable_tx_bdrs(priv);
> -
> -       enetc_clear_interrupts(priv);
>  }
>  EXPORT_SYMBOL_GPL(enetc_stop);

FWIW, there are at least 2 other valid ways of solving this problem. One
has already been mentioned (reset the counter in enetc_free_rx_ring()):

@@ -2014,6 +2015,8 @@ static void enetc_free_rx_ring(struct enetc_bdr *rx_ring)
 		__free_page(rx_swbd->page);
 		rx_swbd->page = NULL;
 	}
+
+	rx_ring->xdp.xdp_tx_in_flight = 0;
 }

 static void enetc_free_rxtx_rings(struct enetc_ndev_priv *priv)

And the other would be to keep rescheduling NAPI until there are no more
pending XDP_TX frames.

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3cff76923ab9..36520f8c49a6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1689,6 +1689,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 		work_done = enetc_clean_rx_ring_xdp(rx_ring, napi, budget, prog);
 	else
 		work_done = enetc_clean_rx_ring(rx_ring, napi, budget);
-	if (work_done == budget)
+	if (work_done == budget || rx_ring->xdp.xdp_tx_in_flight)
 		complete = false;
 	if (work_done)

But I like your second proposal the best. It doesn't involve adding an
unnecessary extra test in the fast path.


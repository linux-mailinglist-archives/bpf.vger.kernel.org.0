Return-Path: <bpf+bounces-79266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32CD32D20
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8156F313DB36
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6716394478;
	Fri, 16 Jan 2026 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/Ed9A+8"
X-Original-To: bpf@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214E3933E8;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574442; cv=fail; b=LBXBJnA241IHmNvz9OIxqtKIP0pa+6CGZ/YhapmFL+9wIoiMnZ1dbxuaiFiFFW0E4rqcQlZXLScS+tsPN3B4HzFyFf7sioq6Kkv2nsPqQ7iz9e4J8oU/pfEsdHXlyCYHaqMH10Jd9JbUMn+UKp+XaIIGPLBuh1hG/qLA8ncFBzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574442; c=relaxed/simple;
	bh=dPWtZYyZyCiVyAsgmPutA1KmpveD/qeRuDbx33aBj9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RGaK1+6TdHaJ3AwwMN54mlWGg627l7mtAKCw8YDObdNgfBIOMV0myjibCstjRh7kF6O6nqIDG+GCWfYV/re14mOwQXsGPLfYc2zk6K9dvYXOFiZI0786N7OV7o1R9T89lUsG8gO1ux5XGFW6qMuroxrzqG7e69XmBdeNpGviqJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/Ed9A+8; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yigUCHXPcW9E6jOYz89y5hQQ/fT1uNy/I0EH+BVnlUsaUCKR53jeYDlI7Nlw7R/K9ndN7MO70sknT7ckpA3htEC1uao2njgHIjHy6qmwynXj5U/NwZl8OytP17udwGw5o8zl5oNj0nc12GuRQv8ITTm5Zj7Hc/pWFygXqbs+8zLCUKhruAr9ES2ZOKRyikHcphvmDiBbnqfj0q8wS+n3vtFKC2LbrZ5HfKmdcfCb3UwC36B31jsTzxDkgwcT0Ko2PHBocF7XEtW/WTghmbhxZAiliYEvLxiIkwjYeehDvbg9jevYVrqbsMB/VQybTUULxYFZ8zbQKPQELlySUNH8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKBfvBlaz4/vDwa0aqifscrs45ovyk0JW6GpImJjWno=;
 b=Zue5Kyo5125OvfdZQo+lLzpBrEkWERgfUzM+OnhutxbYy/1P3icaVUWUYf/4N5UOQIlVguKaprcgOZXBDErnTPXsSQMZNprN9smed2U2BzMFGNiJ8OjPZU2mrpVAo2zS+ZIe62eff6huMaPhc/9K28TbIfWFVT3lL2oLxA5i+4eCfJupb92Jb6K2/zstIG851Te/6zof1J58/Vqn4gIbPv6rQcvLiwyUF0NWBaA7QK4kthbCT1kSPlOesflcjgdBhdrstcycCObAnYSSMoyOK/LNf9CeGHxdaiHH/05A8qxVGf+jwKedZaWW6ie2E6iTsBCwoAvJF6HrbpnHHDBQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKBfvBlaz4/vDwa0aqifscrs45ovyk0JW6GpImJjWno=;
 b=c/Ed9A+8b5z41PFVHGQLFzSfHMVWBtUdKMDBPVMoG7+RZOHAuB45Kw/pvVBDf98joYqmpr5eQyljDUq/Oct6nHtqzJHVaDHKwTBd+8Uhuc9YznsInaQoRSwfmapcqFJyTASg6RqzFQ/qgY7xYVCugsPo9PKBMgdeCZ+Xo+B4O/cQn/IXTFLfh8VfG039Cj/OKdODPDKUzCGvmrtmGhUychSqeUW/yVNR52GW9HXe+znVLWUPPZGv2gHn5iqQjZIIHFK/iDWXA00/Pys8Fx0dkiAEDONKeKjackv4ITDXG+tDx4jVSNVRGwYZ7IKZkcBFMw6eipcpZOGiQCnxebVMEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA2PR04MB10506.eurprd04.prod.outlook.com (2603:10a6:102:41e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:40:36 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:40:35 +0000
Date: Fri, 16 Jan 2026 09:40:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 13/14] net: fec: improve fec_enet_tx_queue()
Message-ID: <aWpN2uglFxlJgoVV@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-14-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-14-wei.fang@nxp.com>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA2PR04MB10506:EE_
X-MS-Office365-Filtering-Correlation-Id: bd87eac1-66d3-4e0e-abfe-08de550d35c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YtPw5q2JS2PrNbXfWlq6Rvjelk4RXaYA/KbuUq2WAHVyHbAiByE9zQKsvNp?=
 =?us-ascii?Q?jyt7wEvGEa11IonpPRuVNjpaXQLf3pOf0gaj6jy0x7YDDc9GfZAIzs6B+GOG?=
 =?us-ascii?Q?7vSbZiSeE1uj6vQmvBiWnoeDKZJw1UdmCK0flC5aU/68luUmFOWStNuDDEvi?=
 =?us-ascii?Q?yKkTTqJwDYBetq5y40wRqxH7mu/8lpf40qZgFEocMDXIYWFrgN3cc90UzHSe?=
 =?us-ascii?Q?hPq30Q7mQHPiSAwS5ZGVjyOIQg6maQqG9Eiv4ALeqe5mmiX0KiR1NqNZ+GuV?=
 =?us-ascii?Q?FoD5M8pL5jsVfbEj0VobBcCoFwMafzl7+vCmq73bXInzSAiC7/WiIR6Pj47C?=
 =?us-ascii?Q?tPsxYNAZ6TXKkfXXorX2hxh79fKn/r3N+QjcAIzJ/OTz6wr1FgU4qjpgFuoW?=
 =?us-ascii?Q?IUDcMafdFFZv2Mq2+eA+TBSE+pgsmO2QWoAU0wfjrnaWmUpLyiRsoRczo90T?=
 =?us-ascii?Q?Aiy0+58ZwM2w3qXdKYvLn56Bnvtw6raezQGs2DP32wit3pDbY8Q+b/iDti1T?=
 =?us-ascii?Q?EoIJnpysv1jhi3GoZNqpdgMR4XjcZhL+vAe1Vymw86kt83keonRc65nDtgbq?=
 =?us-ascii?Q?ilS5vYK8sJB/GM+K1ffWDalGhlnRvFriyQVr1L8MMaL9D1hzbb8DTAPp1aJH?=
 =?us-ascii?Q?xI2lpf6fWJpi8BtuPqB8tO0NZ7Y3B3xaD3BafmQJTkxU2ve93ivlnb/RH2uD?=
 =?us-ascii?Q?hU9/42qUjvIB5VlwHK4IA+MPHjdLjsPpQYyGved4+k2znwsNI7MZmmehoLCq?=
 =?us-ascii?Q?UpTb6+X+k8gcg+QVTdtU070n4KjowmDtyCXm//ZUk/MUcfu9WUXjN1slkr9S?=
 =?us-ascii?Q?JPCYW85cXTPGynIji7LM3HuSiE0OJ4kgS9R5TPUFu9TsNWkKILNFv/iMrUcS?=
 =?us-ascii?Q?NGfvdB4NHj7oBwW/R7srfcURBlZpwKUxlYlFp+07z0EfEwkmiVj7/4O5O1Ze?=
 =?us-ascii?Q?V++Ws5+Ex8AVr6rMVu9Vp6lN2/JgbxP7mVyGZyKa7Vgjs3A/XAWO/GIrWBYY?=
 =?us-ascii?Q?WAJX3K97hsj67yzI4Ux+vZdHgoUoXRyZss9+2cbKq+r4kJwi0tCyR0X/BLAH?=
 =?us-ascii?Q?jIg+V5BzIsImHUel+5HetDNunPcuYNvF3pFfTbw1yimPvekioQuJv/4wZZNm?=
 =?us-ascii?Q?x1Fa82Tn5QL0xVO9qhMoxfClOj063oi3kAWHAMmSABR8NanjaDWQhzqQFLA3?=
 =?us-ascii?Q?CoDrRUkxTP3NQ+63BT+Wrf/Vs1fHmgJ6RuvI9eBG8MfgC4m6M0VayKSRQbHj?=
 =?us-ascii?Q?selNt3hyOUgI1BeAspgaHwi9KBCyvNrvbjo5SH735XCLZLMKqOS5SKajKSzB?=
 =?us-ascii?Q?LN/Op9hep+XwmlULo2vO2+5pYN18Fks6fs8FV56s43Tw7qU0My4kRaN+PSFT?=
 =?us-ascii?Q?QpLNnFLqAHTFpeFwMBrn0hUY47txTk2XZT41bt1YuPR0uaFz5kbcZ/nvldhE?=
 =?us-ascii?Q?WxFwqyzcWIVlbpyX/nBbZqBCxrczbZ54aWbgIkTZbCEEUJ3nUDMHTHfXxfVg?=
 =?us-ascii?Q?k4DYmO1BMEaQIUVzVtBz6voI0DgAz+W8qPDEZxgJvvO3FZpTPN9B/ec57wT9?=
 =?us-ascii?Q?2BDWY/ys5poBv7WtHKZF2Oa+/IksHEG8wxm1IGPKvVE27rEbtylHxjBYQF/w?=
 =?us-ascii?Q?KjU/XeNPB1Rrnb/b1cdAWnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jkr9/jQ5ehoY5yBx38zkqFJK/OHzBsMKHhcyCufEOksecMJx6YY6AvegAvFQ?=
 =?us-ascii?Q?FNVui9P6tF6jntnyJbyDFFtoTwLwf4HuY5iyCEXcCCAIkQVMdE9sE70f1xQi?=
 =?us-ascii?Q?9WIPtBWsqX7eK+x4RCDle7w+XVJLfE+tPmUHud0ef/sZwQlVsnMT59TpcL4l?=
 =?us-ascii?Q?7GD4On8vLCvvPFEf0kuU7ZngAdt/sg0YscTLLnNWt2sRdZJafZ91jRY8P945?=
 =?us-ascii?Q?hdjtCrLVJP5dndBmn5d7dBT0Tb63HR0jZVEAULjYwlh+QY+37spXWKgR1XW3?=
 =?us-ascii?Q?73ir6pzlkxQFQh0TVKD0rnVYkp0doME2Lf554SRlQfNBQqG8sQR2vYiKJgMB?=
 =?us-ascii?Q?sw5oXWHP/Jr3pXgkJMy2rXIrBP7Q5AI6heeqoVhvAC7qHpdH3LovEOUuBhi/?=
 =?us-ascii?Q?z4l2Ws14NDF3jlaKpHJyLeBD4NBjPlgAjsw3BsNg5bt6aJ11v9hNZIj6nw0C?=
 =?us-ascii?Q?ly947T59x0z02YwDTqYpngdU7p6GEDP131C4RC10AqROTvd+tqYJWFl3b7uw?=
 =?us-ascii?Q?XJafLI6TObPjtifLux/Vgqixe+R5rB8RtBZWtPCYW+wq8JibQyc9iUzz4pTx?=
 =?us-ascii?Q?hqVa7DXAoc5Qk6eigwAjygTD31SxkKVj3LNDX+nx1rDL+n2jEBm+RjO9VLyW?=
 =?us-ascii?Q?tfm4KrWD9OQqIFEJsCphOOlMKTsd0cUGWZl5ojmj74rJED2eXGI75ml+pUlV?=
 =?us-ascii?Q?Onou/hhmN2lNlrAT3DYHdHivBxhybitnV/a5CQ2mPp96tkjbtu3hgRcNnhyX?=
 =?us-ascii?Q?mOcdfrJGFzuaojCzl0hevD0lYw1o0wwyBusK14xIfsJBjYh/cuttjmjJANml?=
 =?us-ascii?Q?a414DumnLrEB1LXZnnQwh2VNEehqgfm/XUsMVAcpDPsmUhU4L6P28vrbOpey?=
 =?us-ascii?Q?813nBHt3qL/4kuiniYCLNLzHHIRksUBbJ5Vj66/eftVyxfycTpitYP9VVfZr?=
 =?us-ascii?Q?XRLs954tGSWJnkYuF0Xr64/7M4WkAswf0+KoAauRHYCnwYqMFLeSlco1JYpO?=
 =?us-ascii?Q?QnA8EBBvq0zG10WVb5f5LTRo9wo+VhkDNj1ON8K3SsWGlOntpdohjei/sKu+?=
 =?us-ascii?Q?YOwFnEABLqND7aF1N2YAbkYgmKKpl2A7o7Fa8BM4bpGWTNs8EzuElfSh8CzO?=
 =?us-ascii?Q?tCwgF8siBeS7NuS6VAFxk4ydLD9eszmhzyf7lQAsE891JUkh0kpgF5z957mi?=
 =?us-ascii?Q?PIVqttebyDl9lU4PAbpgFOZPe87GQHHSc3BaT4vvyqjbSCUiaK3waFrE5bLy?=
 =?us-ascii?Q?2ySKjr7yDqR+DN2bhcituX80KiwE/QBQ6IX5mU/DEu2kVntGCZE6GVkiblQe?=
 =?us-ascii?Q?N+PJM3i2v1s6XCgmm/80/9yAnLjj6pFOKeRzAwHzTseUDj82lj2hXc6UjiwD?=
 =?us-ascii?Q?tbFfr5VmLk7KK6ewPgJcuq90Ele6spFDiBFZkUANczt5XRBDibcWK1Ec6v+D?=
 =?us-ascii?Q?d+EjzfdDs0kKPG00sV9reF3XuU5gCMxUNIjyEFpjxRZQ6m0+yNVaxYfbbzvT?=
 =?us-ascii?Q?oMOljgAUpDoc2w/Kk2FmJuJcyLcXe9w2B8gwGZSo9oQG/kNvqbmTr0U+YHAx?=
 =?us-ascii?Q?I9iNAuSCBjj6zgcp5NVgSlMoxZjiomRYhxbvT/PGHMizIwwliPBjOP96l+jo?=
 =?us-ascii?Q?7fgeXZtgxv38yl23aWv9VVJ6ffRrnmHnE0NM//dG/iHNaV5TNgLTrXXV6xgu?=
 =?us-ascii?Q?ZTkIrMiRNJJ2R+Q3dP+UZJr/MWUacoIDLhOZWmeKTvSbmfPD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd87eac1-66d3-4e0e-abfe-08de550d35c2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:40:35.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwZfsMhfd4M0GaOQiKxzvXk+/VMLdHMeusHsavZechbAD33dt5nVjrKcy7oLokMLQp2wbmF9k21RLgiK2RtXjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10506

On Fri, Jan 16, 2026 at 03:40:26PM +0800, Wei Fang wrote:
> To support AF_XDP zero-copy mode in the subsequent patch, the following
> adjustments have been made to fec_tx_queue().
>
> 1. Change the parameters of fec_tx_queue().
> 2. Some variables are initialized at the time of declaration, and the
> order of local variables is updated to follow the reverse xmas tree
> style.
> 3. Remove the variable xdpf and add the variable tx_buf.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/net/ethernet/freescale/fec_main.c | 43 +++++++++--------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68aa94dd9487..7b5fe7da7210 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1467,27 +1467,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
>  	hwtstamps->hwtstamp = ns_to_ktime(ns);
>  }
>
> -static void
> -fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
> +static void fec_enet_tx_queue(struct fec_enet_private *fep,
> +			      u16 queue, int budget)
>  {
> -	struct	fec_enet_private *fep;
> -	struct xdp_frame *xdpf;
> -	struct bufdesc *bdp;
> +	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
> +	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
> +	struct net_device *ndev = fep->netdev;
> +	struct bufdesc *bdp = txq->dirty_tx;
> +	int index, frame_len, entries_free;
> +	struct fec_tx_buffer *tx_buf;
>  	unsigned short status;
> -	struct	sk_buff	*skb;
> -	struct fec_enet_priv_tx_q *txq;
> -	struct netdev_queue *nq;
> -	int	index = 0;
> -	int	entries_free;
> +	struct sk_buff *skb;
>  	struct page *page;
> -	int frame_len;
> -
> -	fep = netdev_priv(ndev);
> -
> -	txq = fep->tx_queue[queue_id];
> -	/* get next bdp of dirty_tx */
> -	nq = netdev_get_tx_queue(ndev, queue_id);
> -	bdp = txq->dirty_tx;
>
>  	/* get next bdp of dirty_tx */
>  	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
> @@ -1500,9 +1491,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			break;
>
>  		index = fec_enet_get_bd_index(bdp, &txq->bd);
> +		tx_buf = &txq->tx_buf[index];
>  		frame_len = fec16_to_cpu(bdp->cbd_datlen);
>
> -		switch (txq->tx_buf[index].type) {
> +		switch (tx_buf->type) {
>  		case FEC_TXBUF_T_SKB:
>  			if (bdp->cbd_bufaddr &&
>  			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
> @@ -1511,7 +1503,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  						 frame_len, DMA_TO_DEVICE);
>
>  			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			skb = txq->tx_buf[index].buf_p;
> +			skb = tx_buf->buf_p;
>  			if (!skb)
>  				goto tx_buf_done;
>
> @@ -1542,19 +1534,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			if (unlikely(!budget))
>  				goto out;
>
> -			xdpf = txq->tx_buf[index].buf_p;
>  			dma_unmap_single(&fep->pdev->dev,
>  					 fec32_to_cpu(bdp->cbd_bufaddr),
>  					 frame_len,  DMA_TO_DEVICE);
>  			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			xdp_return_frame_rx_napi(xdpf);
> +			xdp_return_frame_rx_napi(tx_buf->buf_p);
>  			break;
>  		case FEC_TXBUF_T_XDP_TX:
>  			if (unlikely(!budget))
>  				goto out;
>
>  			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			page = txq->tx_buf[index].buf_p;
> +			page = tx_buf->buf_p;
>  			/* The dma_sync_size = 0 as XDP_TX has already synced
>  			 * DMA for_device
>  			 */
> @@ -1591,9 +1582,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		if (status & BD_ENET_TX_DEF)
>  			ndev->stats.collisions++;
>
> -		txq->tx_buf[index].buf_p = NULL;
> +		tx_buf->buf_p = NULL;
>  		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> -		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
> +		tx_buf->type = FEC_TXBUF_T_SKB;
>
>  tx_buf_done:
>  		/* Make sure the update to bdp and tx_buf are performed
> @@ -1629,7 +1620,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
>
>  	/* Make sure that AVB queues are processed first. */
>  	for (i = fep->num_tx_queues - 1; i >= 0; i--)
> -		fec_enet_tx_queue(ndev, i, budget);
> +		fec_enet_tx_queue(fep, i, budget);
>  }
>
>  static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> --
> 2.34.1
>


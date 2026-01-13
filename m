Return-Path: <bpf+bounces-78732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53213D1A0CB
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A0A3300DB29
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7AB344047;
	Tue, 13 Jan 2026 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCAAvbUx"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DD3043D5;
	Tue, 13 Jan 2026 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319963; cv=fail; b=Er4p42pgNkpJgXQj8G76SdG2u5vuzr9oXl8WokgGqp0tVYPEt8HKpM03H6jCM8waMoPIBXbD4K/LkKQOpuC0g1UTosovFh61E2gc2diZPPbmNhYlyHGoaCwKZ9BeGacN/dPKYGGs0ddyyD78M+73JgN2r+QiiUuoNzzFyhERgGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319963; c=relaxed/simple;
	bh=HfU4Joog9Q1IPT3eelUZqiitNdN4pvRcNSrKzJC2F0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BnJM9SoxPig8EuMzsfHMYC5fGKfgYiKaJk/2uzWWhgxvPNGwizcrCHcwNTEzKBIbVCd7Hn3rN3gqqw+eaPFvjY+rfvhvqbkJg1fgOmdmyneTDAxKopCzvMNAcOY0/c/WOxb1cM+Ot99G/Kbcm0Cpej5b4VPG1AdLTlzn779huiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCAAvbUx; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoxDB0bJgDHYsjMTvTBdOp3UAVW9/Tsd8YD0QI7MyPAG7pRbb9cZG9G3Gtddg7ZwOr6hbhhg7WtYBy04XVuWWQLNU25wmXnqK+rK6shJH6v6MABBw0POt8lhFZqjkVSBS3AmB7ElcomAh39bXPrhdiKCzvqiPdztwSNzvMto9YCcc0/lZKhJ+o2GX8wRR01hdYqOxRNAzwu1dyD+Vt/KVQ74sNzFMCtXYRWI/Sb/QdXV3sNukhpoQmCGjsS8LldXr8E5zepUb4K5mAwwVxW0v8WZSbIWPn/bu0Kd5Yl5E20NSK75E1x7QMMbF7NDqCZfSWVHNj80RuzCmWCo29Ydpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koh3kjKETNol40FWJLeGOTzykos4xQU8gMOMUtdCk5U=;
 b=RCcGFVq6MML/OgjNDvsgs/vU7jXzcwhh4ERQoSM6rKkXzmJr+SkMYECfXzZ84dKjZqhWnLi4R0HWfqOhUHVZtml2YzTAFWILrlZougGwWXq3oyUjw17JHQDWo8fUeXUdjUbgZNwPqAEPnNeVpaeM7ldIWjOPSa0pr981cTXwr59nr9P0CKM49Mo04lCO+PMBdYPn5zvEeRSAiRWhdIK0kA2KUZMI25BUQsLana9SEJBc/t8KzE1zScLCBlSs6ioRAh0qgPwYBgvZpdRve2dc143g2DeXQ772vn6792YB/oxrFglbSjekur1v2Ln/1VZT/xwqMkWwY9W7Y/O5Es5Ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koh3kjKETNol40FWJLeGOTzykos4xQU8gMOMUtdCk5U=;
 b=iCAAvbUxlylDe4MRLjvD68XnPl2m/7I55vNd1dOS+WwXMvQjkBC5RCLw7w2xRDMI6FiBX7tF/DQRmAUfz/F6dvkmLNy+jmQWd/J7CX6hs7G/zuc/6PsFUlm7TKqSiwHnpVejr7fXtcyKzRXOaTLltXJNirXPRDc7n5ECoo0Zakv/fGVGUkha3JlihhVxdsysBnInjPi4Xlxm4XQ0VTQcB1OnEnR+zTB7rq/SC/YCA/WLb9Z097ydK0pikoXNmvDqWe0wsfZQpYbufPBv64aRYMa2tw2ZTyW0wXFKkOebTEhcoTehdhwq6OvVW/WBoydaPblR4vYdJXnymV/5BO2C5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 15:59:17 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 15:59:17 +0000
Date: Tue, 13 Jan 2026 10:59:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 04/11] net: fec: add fec_build_skb() to build a
 skb
Message-ID: <aWZrzOiL884q/7Gq@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-5-wei.fang@nxp.com>
X-ClientProxiedBy: PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::9) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|AS8PR04MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: da165bab-9891-4270-74b8-08de52bcb4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E+Yr4Z5pC8j9qRWqeJmVVXraCV73qStWKwQ0Ka8LG++Zdg7/IoTZHpoJI84a?=
 =?us-ascii?Q?sOECPxMavSPHK9CgWBmF7ov3wAQcEaAPdrNJH21CNX5bFM/3UA/qDjqxceL9?=
 =?us-ascii?Q?4glO5yRyDQzzTnPrRjgDpe7DMpFGqpxk3kRjVQcpnPRBcVY9YDIqU3F0vXg9?=
 =?us-ascii?Q?J8kJ9eQvdCqKdB/dGC4cPDU8o362k4Qsyn2/dHflUysY0whGwuTl/jcnZfq5?=
 =?us-ascii?Q?MDTETfAyAj0m+gWcuOnbSq4UyqxHPyPri/2SMmEyAmdp0eKzDEUEmKn3CtPP?=
 =?us-ascii?Q?ApF4gsKG/mtX47yQ4n6PwVdgiJ3HCDnxZozKCz6nOG6wIiiA+fpA5CMdelsL?=
 =?us-ascii?Q?iYi4Kull/xUOUI89M9yVFitauReO4SP6YWbn3lJFJogd873fXQqSK009x7h0?=
 =?us-ascii?Q?OIOBxWLZqtapG5VfyEdtlH/eObtZRApcoloqh2jXBpmz7yAMdfhH+ew+ltM+?=
 =?us-ascii?Q?nExBL18N4So9RqBKcLvkBK3Uw3cP9uzDhzHhfEYtq872DmeP5SUCrARcMPl3?=
 =?us-ascii?Q?CeJo2ogPO/aMM6tCiRzUp2NZIwyEyZHm1F4E/ehDjT1fIORUagk20TQ7YmBG?=
 =?us-ascii?Q?ysCuFGYYYZ/047rLM56r7Ih2mffJLDGb52+KCgJB9W5sECm72abhkmktz4CB?=
 =?us-ascii?Q?G3TLj2xiCovCBg+u6vGEs2GKiwy+Ex4AI4g4r8xmDdduxgXYgX4B8qIX5FIP?=
 =?us-ascii?Q?HeTPzmwHbs09gw+e3H0Npud0wdWH6OAHOvrqRHEYIFP2VomS8cDOuJecNsVm?=
 =?us-ascii?Q?R5cTO2b/x/yHPQnHGKezyUwCcxp/7ogMZ6ryaYo75BifkNiQBfZlYB80EVX+?=
 =?us-ascii?Q?mR6A9+MKlhx4UdCjx3kVqOZ7Nlhg+yGFn5khKDlxrc6vF27HVaO2DO00T/z0?=
 =?us-ascii?Q?yM1jsCM1VwFNmPMGXtvqU9nAkaeNgchuF0a69gIPP8BlepIpJEG4ic/nL9Dg?=
 =?us-ascii?Q?5Z71Teq7rKENtsHWZojXefSPbgsd8QfdYBxkUqQaQ15ykMAHKKtdjCt61gbx?=
 =?us-ascii?Q?uHCUjOE6mvTRb4XcoUaJweGIHFYgsUhkQOP2T4iXZs1dgmTuFbGKDEmIhzH+?=
 =?us-ascii?Q?RDzc/FnntEk9pAFtPlV2zgx/Dz1K/h7W7pKB/3lyafDiTPFKa5eLb02dWOhn?=
 =?us-ascii?Q?AlV3JuZZCIJzAW7hJZq17gU0p4q8n4AnIcw1Kd2ELbysEv+nB04KeeqDJGbs?=
 =?us-ascii?Q?CdkFdSYMXpCNbNfJFtyVU5XGd4k6UFikkn+e9HkEwaaIQxIdFRaQwLIOfV9e?=
 =?us-ascii?Q?U05AeWttY+MhiWteMjzuSRcZ9xIW6YpKEnn8p/n7gRc29u8qpjSotk6Ar8rU?=
 =?us-ascii?Q?r1p4wwWEU+YHVXaMeRwixwiHJweFREsBcizNEHxIHi4Xz+cx1s3Sxd2+ezjK?=
 =?us-ascii?Q?x5Vmjsy/mw9Fo4r3Y84vkeMkDUOjlkHuXpO8mLDJsJi21M+cmKD5MccoKBwh?=
 =?us-ascii?Q?1lkb6bZONZ5KhroVVQJr1ohScKx9O9OJnXdcof4EKpDwa6mufN25huXHwJRT?=
 =?us-ascii?Q?G/1BzzNOhAVhQx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mOylAixWE0d/cfFVLzzdv7vYu1qcuQ0RQNGhYnKSOlFrjKgXPQl8iWRAltk?=
 =?us-ascii?Q?FgxU9HlUln5aQAxhJcjhrnj6R+dQ/jPUTguEVSyBPauAGEnw0OzBqV/vc640?=
 =?us-ascii?Q?2hP3MbqkzAL+iFXrY5gGJy68+16Si3Le5xuj4sn2nMI5DRG2AZAdAbY5FY+y?=
 =?us-ascii?Q?tlP2gXK36hDPW3yAZc3ZNS7s1gcHLwEN5zJhvD2WE4SD/pkH71v/suC074Co?=
 =?us-ascii?Q?HUY6ZDhM/0K0Nz4k3vgS8NpTnuFC5wjaYlx/JDK4vKsnLkjybMQMci7bJiRN?=
 =?us-ascii?Q?kFS00sWiUDXo4rEwt4l0N8SRZOjXA2uyU8nKbOdMj5WZ+eDIA+NXpsybwtJg?=
 =?us-ascii?Q?Fxv/ZlaSS/JE3BTl44I/Y71ZVJdk9l69Sg5o0Xo9jGIpjqjE0Yb3m4MSU++Q?=
 =?us-ascii?Q?imt/wePjWjAZw78QwqaHlYc4dyljXg6+W9gFFVbcxfGvx/mG49FdwtsQtxqF?=
 =?us-ascii?Q?US49PHcRegxbQOKd75mc0jVfJTp5feKuDINY2V/l6r6nkXfF4EENxTEIeGQm?=
 =?us-ascii?Q?WikxhCAx0fKwrhIsc+40T7nOTlEXgfjLBHQb8ws2j+E9bIvBS+SlTT+kdwXN?=
 =?us-ascii?Q?LPObwsRX4cNO9qMbJQys1g2O0Uhl8dfPLzTqR1na9JoyyVdaoDlgYtFzi8Db?=
 =?us-ascii?Q?3DBbY2n1OrAC2VxQ2myyjF1JavfhYACIJe7JI/4dOIwNnVlFcpxXbQLF0KdK?=
 =?us-ascii?Q?4pSs0esM1tRrSAhy+1BYpLTcbfL9dR3qObqKpd+vWP8wNvRBtE5JxL5FbsJ/?=
 =?us-ascii?Q?LUBvcRRh7HAdGN3sS9qp/Gx+kSHk2O8uytgisoCN8IGWn1uX7QqDJF2ViBVB?=
 =?us-ascii?Q?n25cu7JZH85qVAxVGZW10t7z3AuuMWXuU0b0aabhjsHipqCTK5UIh792Jcbo?=
 =?us-ascii?Q?OiI7IxfN/GVYsIy45WjZKWFGnpvsStTx4L5gkbxBpJBXjDQwoSISkinuW8l8?=
 =?us-ascii?Q?xY6MWZEuZlVQ/KEG7t+qH4lc2s8+3b9z7qOWAjetpvDh/FhC7iAgTpt74TyY?=
 =?us-ascii?Q?WaUinAySN/ZfCWcJvipLZGx4d7yLsIeZDwv1GXbQiLYMOyNcqngVEdsh9yxh?=
 =?us-ascii?Q?WzkI22Q0JYN17vgDH7kq8rMJ5Kzed3O7BOZ9rSozb+4hZ6kvyYONeewQ06Mp?=
 =?us-ascii?Q?tBnSsGVGRVjmg4Ix4NESPIILN0Q/GsPmz+ECGWlcILY2cZsoM0M6BpLWctP9?=
 =?us-ascii?Q?fHr7o1UDxkOB+VKbcYNfbTAUMSjS80cBfCokubEqR0Q93CfB0ALfV3uBTqoc?=
 =?us-ascii?Q?B0sIykeRSi56qt7UGpjzPduUvnqHL/UACpstnM/64F9IEhPGtkvj8rHneE/j?=
 =?us-ascii?Q?abWaGYw0U7VQQ8lf9UZIzKXsvH8JPobS6xbCPPEB+S9CnmKfXcoRXXktRefs?=
 =?us-ascii?Q?lW7sLh939TbCBNZd802nSFmJ42H+3nRGq8MakKewRCgZlxVMNqdHmAw7cYBd?=
 =?us-ascii?Q?Okg5vNwAqS0NOfg0/ytrRPK7u2S3HzrMBBA2uBQfTEjWQzCrFxm4YMkntLpP?=
 =?us-ascii?Q?YxHNYjJromZw5YgbrezibTawD/SrdlbUDcMYHkdZ0WEigA6VS2qHKdOwK8+d?=
 =?us-ascii?Q?HhzWy9RuBWJRxxv8Dcqq1oYkyN06EkkwJrwUGBdn1qKBh6IEDZJ2/hgRXdEu?=
 =?us-ascii?Q?k6J/vAaXGXkVv3wXxjU3lID0RmtLM+UckuatUL0APPb3oK6o3gbj10n0sCDd?=
 =?us-ascii?Q?6PrSc587cFpou6xWG4J4LMxrYWJuc/hdVn7tlMFC1jB6rPYl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da165bab-9891-4270-74b8-08de52bcb4df
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:59:17.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX64ocLq0TjpUzP17qU+9QT5flZ+Lm1ukRVCRpmv3EvNPmg6zThxn128uj7wQYdsl6K09etrD6miH4tkSH8YrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672

On Tue, Jan 13, 2026 at 11:29:32AM +0800, Wei Fang wrote:
> Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
> code for building a skb is centralized in fec_build_skb(), which makes
> the code of fec_enet_rx_queue() more concise and readable.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
>  1 file changed, 60 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68410cb3ef0a..7e8ac9d2a5ff 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1781,6 +1781,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
>  	return 0;
>  }
>
> +static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
> +				     struct fec_enet_priv_rx_q *rxq,
> +				     struct bufdesc *bdp,
> +				     struct page *page, u32 len)
> +{
> +	struct net_device *ndev = fep->netdev;
> +	struct bufdesc_ex *ebdp;
> +	struct sk_buff *skb;
> +
> +	skb = build_skb(page_address(page),
> +			PAGE_SIZE << fep->pagepool_order);
> +	if (unlikely(!skb)) {
> +		page_pool_recycle_direct(rxq->page_pool, page);
> +		ndev->stats.rx_dropped++;
> +		if (net_ratelimit())
> +			netdev_err(ndev, "build_skb failed\n");
> +
> +		return NULL;
> +	}
> +
> +	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
> +	skb_put(skb, len);
> +	skb_mark_for_recycle(skb);
> +
> +	/* Get offloads from the enhanced buffer descriptor */
> +	if (fep->bufdesc_ex) {
> +		ebdp = (struct bufdesc_ex *)bdp;
> +
> +		/* If this is a VLAN packet remove the VLAN Tag */
> +		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
> +			fec_enet_rx_vlan(ndev, skb);
> +
> +		/* Get receive timestamp from the skb */
> +		if (fep->hwts_rx_en)
> +			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
> +					  skb_hwtstamps(skb));
> +
> +		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
> +			if (!(ebdp->cbd_esc &
> +			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
> +				/* don't check it */
> +				skb->ip_summed = CHECKSUM_UNNECESSARY;
> +			else
> +				skb_checksum_none_assert(skb);
> +		}
> +	}
> +
> +	skb->protocol = eth_type_trans(skb, ndev);
> +	skb_record_rx_queue(skb, rxq->bd.qid);
> +
> +	return skb;
> +}
> +
>  /* During a receive, the bd_rx.cur points to the current incoming buffer.
>   * When we update through the ring, if the next incoming buffer has
>   * not been given to the system, we just set the empty indicator,
> @@ -1796,7 +1849,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	struct  sk_buff *skb;
>  	ushort	pkt_len;
>  	int	pkt_received = 0;
> -	struct	bufdesc_ex *ebdp = NULL;
>  	int	index = 0;
>  	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
>  	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
> @@ -1866,24 +1918,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  				goto rx_processing_done;
>  		}
>
> -		/* The packet length includes FCS, but we don't want to
> -		 * include that when passing upstream as it messes up
> -		 * bridging applications.
> -		 */
> -		skb = build_skb(page_address(page),
> -				PAGE_SIZE << fep->pagepool_order);
> -		if (unlikely(!skb)) {
> -			page_pool_recycle_direct(rxq->page_pool, page);
> -			ndev->stats.rx_dropped++;
> -
> -			netdev_err_once(ndev, "build_skb failed!\n");
> -			goto rx_processing_done;
> -		}
> -
> -		skb_reserve(skb, data_start);
> -		skb_put(skb, pkt_len - sub_len);
> -		skb_mark_for_recycle(skb);
> -
>  		if (unlikely(need_swap)) {
>  			u8 *data;
>
> @@ -1891,34 +1925,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			swap_buffer(data, pkt_len);
>  		}
>

Missed swap_buffer() in helper funciton()?

Frank
> -		/* Extract the enhanced buffer descriptor */
> -		ebdp = NULL;
> -		if (fep->bufdesc_ex)
> -			ebdp = (struct bufdesc_ex *)bdp;
> -
> -		/* If this is a VLAN packet remove the VLAN Tag */
> -		if (fep->bufdesc_ex &&
> -		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
> -			fec_enet_rx_vlan(ndev, skb);
> -
> -		skb->protocol = eth_type_trans(skb, ndev);
> -
> -		/* Get receive timestamp from the skb */
> -		if (fep->hwts_rx_en && fep->bufdesc_ex)
> -			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
> -					  skb_hwtstamps(skb));
> -
> -		if (fep->bufdesc_ex &&
> -		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
> -			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
> -				/* don't check it */
> -				skb->ip_summed = CHECKSUM_UNNECESSARY;
> -			} else {
> -				skb_checksum_none_assert(skb);
> -			}
> -		}
> +		/* The packet length includes FCS, but we don't want to
> +		 * include that when passing upstream as it messes up
> +		 * bridging applications.
> +		 */
> +		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
> +		if (!skb)
> +			goto rx_processing_done;
>
> -		skb_record_rx_queue(skb, queue_id);
>  		napi_gro_receive(&fep->napi, skb);
>
>  rx_processing_done:
> --
> 2.34.1
>


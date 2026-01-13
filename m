Return-Path: <bpf+bounces-78729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD101D1A06E
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF908301D602
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04138318133;
	Tue, 13 Jan 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOiir3uu"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF102D5C86;
	Tue, 13 Jan 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319551; cv=fail; b=m3RdpEWzqx1MdSAz5NswVQ74SzMxkVeucj3zRh0BP95Tu1s41iaWiL/R5Kw0149+hOcMjd89AGfbJb41Z0+3iWQ82v2iPbcmnieLHO8KtpstOHqaEOo7z2gE3MTqL0UCix2L/h29GdX+6MDcyohm2NsiKMQ1aepEPiwifFzJlwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319551; c=relaxed/simple;
	bh=e3u573vd74tT/8ZXyHUcvyaRL4i7LMZNUGFaiQDNUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CcFlNOHHiTmyZuLBNlbaWTtA2XXGkKO7i3hMZCMH9wo5Com+G1oRzzZ3h9kB3F/XtEkI9BYbEDQCuau04MEy/bydHaKdsICNLO/ZxuXATfusWS+An2adL6ni7vFAlovtS+6K6XVSdZGQmOQju7mCp/qlCJ3Zi0JsMqQxIaCuqb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOiir3uu; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfh5j3dsH9hCkqi9fCgn167aX/eg89Q+FNBXbgROPPigRYhXlUULMs7YWyMvLNx78cj8WkcztFQTydpENOEEV5xW3FtPzbPXjZyQX8U051d0yTIGVl2oRSIIfmj3eedk5ARH190+FmD4FrobMqVwvJJfHNNS8IA8MNbrTtA1NLU1lPKM5/lbNm8JYg2ZIAj/iDXm4HD49YaYupuJpM+iiguKilQmyS8Em/hFx9MF/uVZ2VBNtnsm9UVDQbZOBpuuTfHr6bJWAHYeneXsprfegk8M2QBXhLiOkwybz1xghhTIUm06gNQZr7SopZlURprq8XnfP2TvpV5rFqLw3ENccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2hzwK5HSHU0LL3jk7pHNZaFUf1zEUh5c+2DH9oR+N4=;
 b=v944LlLhNkFizppSHHAGKaV+ijMQSGL47Nh0D0gX/D6nrpidWpzxe0KyZOjl/ufXPFOiKKBVMNtVnDY9BHdQEjjLGCkCyj+ROhizarHlbazuf9pmFR8tihuokvTO7br+Vh+BiNMHNvItRrNNnv6+NYliycPbDPEtcPSeY3NPbTG6X5Z3nopPWWzrFS5s5+Pjz9rUE9XgdSp2L2NkqpvxYQIw4ToiLyUbfzM4G5u6AuZXGI5JGuLTDUgbKokR8olDCxaI8w1Mb8tvogtHqUIEYtEpS/oXh2APH/6PbNYIhde4U2HZTOZOOzSBXrEu848jdvTDcz9WzhaXhewizU4vvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2hzwK5HSHU0LL3jk7pHNZaFUf1zEUh5c+2DH9oR+N4=;
 b=NOiir3uurMovLs8CmbBGHONAx5Sb53ErrwsSJC+V4vbqinpn+2dyVeTJiA7fbEioWnkMYqb/f7gCqrKCwl7TT6GTMSA7T2WnEFikX2PqSh3+NL/Ok5OUafebXOWQDzrbfqEFjTJdM8xPYV3s2dAhwwwRbOl5r336lSP2mEEejtOmvekLNqVZ5dKQoY+E92KJeSBpYcBImT/SrvFDmKs5TCWLvxA+kmy0Wu6iyDu80G+cTyLCib6SbEl7asEIvXUFNeAvfothiji68GfKIUlYasY4mtPYlDL15XBVTxSX4UsSnMIaHJraIMvCbaxM30lPSUoUuaAOtJ0VWPexBV5zIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:52:25 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 15:52:25 +0000
Date: Tue, 13 Jan 2026 10:52:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] net: fec: add fec_txq_trigger_xmit()
 helper
Message-ID: <aWZqMdV72tgwiBcq@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-2-wei.fang@nxp.com>
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baadec7-8d77-4ec8-c84e-08de52bbbf12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gKLAU3R8SU3N+bdZhb3a3wxxKBE6jEgthwcdRWoxcR6U91JShSfR7VWrD+G?=
 =?us-ascii?Q?TR43GXWdBUe+oKNGd/hiyA+0+QwiHtiDMnyapL61Mi4PQtUWJw84VQMS8ESt?=
 =?us-ascii?Q?vKu/r7hxOBjyKdp+qgqhhtpCEI2BdhY2gPfytEcvugUfcXofu+X4YVH+7H+d?=
 =?us-ascii?Q?swtNsownP8cCedWID9YzaC0l295h3qEGUrmn1p76vGMZ9mkzLK4d+bEqqosZ?=
 =?us-ascii?Q?DEvrLPWC3uK5R85Grp0pbbefAh7SWFkIswx3CDPa0RdorR1/wPAwTkaE/Bl8?=
 =?us-ascii?Q?WSrHvzrU3mI9xY9iap38pSpesWOkL0ICGMVCqrr0VcQndlxyHhRN0q2G0Opm?=
 =?us-ascii?Q?rEM/WltTLETeBmM74skwe3rWq4AQqNdgfduBul2jjABrNLbQU5yXsvOkrhIr?=
 =?us-ascii?Q?+ky1acS8+FjKH11HWsvKfNlN1oXdlWndu6UXnBRWCaE7E3d6EroNtwZQlu4M?=
 =?us-ascii?Q?W/H81X3rXZe0pS9nhxnZEzZTTGxXWEImA45llkO26I0kmeAEOeHWLCWpxtTk?=
 =?us-ascii?Q?FHY19YVKninnFi6MjcRt/1W4Ems9QovYgw3qttUmbxzHwLKKQoh2RTs0jOU4?=
 =?us-ascii?Q?YjnlVtlJ8IO4ykHKBEUpS7RWge+nPW/YyBh6eBWF/vnvT3C5q4NEeTg7TDyI?=
 =?us-ascii?Q?WFn1kR2QLGwZzPZ9NmqaY9vTzgzEYgm+FpTEF4jEmd/S+gOS6HGrAfiF2IE2?=
 =?us-ascii?Q?DvfDmwoGJMuhCx8UQGGTXtqq8HWKXO1Z9IoAV7fvya2UySj6G4077Gt+xBeI?=
 =?us-ascii?Q?GHo0jHYY+aOvpPlPERNekpiTrDrLaVR7E+kocI1UTTXz4z00wkWkLYn9YQnM?=
 =?us-ascii?Q?uw4++PdQ8T7WRa9kkVMNgebElR5vhFE4rE6X9ayzQiRWO5zZyt1hXpNy04cp?=
 =?us-ascii?Q?7Oi7kc+NmUNOBLb+RDnIQFicdsG1ZfNM8zwaBwIcgmghEC30CtS65PfWJRy1?=
 =?us-ascii?Q?peqHCT6tXlKVie+eDw8NGw++lfllOYmxlT7vXiuJ4sf8shxRdWfVyVY7E7oh?=
 =?us-ascii?Q?RoHWKL3IZUV653CIfRP0E3IwEBZN9NnDXv7+vzZm8ZNKcy8v6hao7vWLZtJa?=
 =?us-ascii?Q?Iwq7T6MYNPzvhrqlXQXOuba6fZ429LNCDFWhkfenYXSyViqiN/fH7INj08Ik?=
 =?us-ascii?Q?kspcsehEOtmFsgiXCvlPZxe9ayD3VVcD3/1CyUBrGFhxBlZ/lonzrL4SOKyT?=
 =?us-ascii?Q?9uHoplNvQkyQK7A9Ugxl7Kr4IWVzQFG8YU61P5TmBbWJ4ykxZewPHBV+3EbE?=
 =?us-ascii?Q?KAM7GCKly+BLE9KzYwyfmFhAduCT9KisGhM2TzRPGLyvCvVvQ6yBx/9mKkZa?=
 =?us-ascii?Q?ZO7jIZ+I4GK7o3Q0ro/j4+3lt1otu3nu2vKNpFWGv0sguYqgca6NZs5YxxG+?=
 =?us-ascii?Q?meUtPm8+lJFMM5O88D0Hc/PezDMmx8Nb42CXSbaaRHktNSWCcFj/lYIgjJ+I?=
 =?us-ascii?Q?8kHDJID6UvWNw3dQYp1o799zlU756LmgWTCISjDYyA4KcLlvwwRLls+OQuzK?=
 =?us-ascii?Q?9MjmEV/xaD8ptdM94GLoDZYv8IeGGi07+2b3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebq4jEnfba9FV8erCAZEvsmYb6mGFlfeYseet3+dNVzaoiSBjUpGNtX+HecL?=
 =?us-ascii?Q?/2AS3H0KyZVO3H+TF+HsbcCUeomBxKVBtqESFpMMssq9eIC4kRyudcqx0cZz?=
 =?us-ascii?Q?FvneELBRbRk9f1Uu2AkVCJsEfepIGVZIZSKQ6D5/QfDAP41wsvdnMfgRcy3s?=
 =?us-ascii?Q?25ziyW/RGjiwVyeNQLU0JaKeoAfg26djvS4B2lrar6ZkNFharBXGZ06c/Qzp?=
 =?us-ascii?Q?TBavPB7Q38vJQLe1L0vluhhsSjFpfYOA2NDLI+0BrX/ZY2kQHYkp1xsAZe/q?=
 =?us-ascii?Q?rRk+spVSE71UWiSN8YktDejUC79mQbWTpNcAsK+9wS+ycmevDGM6MqTqBQB0?=
 =?us-ascii?Q?eEqBvWr1f2kYiYgEsiafD1MkO5ZWAUZW2lWmgWsz8so67v7BmOWNzaNa5YMa?=
 =?us-ascii?Q?oDHVFqKSO5m/+FPky0BSseqxv9DxY/2UCUPf1IZAXg6HNGP4+OMkT2OIpjik?=
 =?us-ascii?Q?rOhTh4Pejb469vktRGgMUD37kV657Gb8y39pWYP9k2d2SwvkYNteZWvz9VKn?=
 =?us-ascii?Q?YCewkNpmU5bze+StccsyYzZqGV14abeUmdcy/xoDhGqlEdPCt4h9eWmXyshU?=
 =?us-ascii?Q?A51ROxapGDHNTMuenqwBA7jKYC+TYa9G8kstECylvgj8jxBIKwg+0s8Lkpbk?=
 =?us-ascii?Q?OuHAWKx6w199rGWxnfTVMFd4JDPuaArOSXSCqSdNcJ/3ZlfagiSgHR9kQF8r?=
 =?us-ascii?Q?mRxnx3arG42lIzrLoz7LVvxlWlDXyCQUJDEeUlBP9FKqW0G2ELc+tLi1Wew8?=
 =?us-ascii?Q?9p2mpZdLxJXL49pvDuH57vwjeUJaRc2lDMIrLu0nogkqnmiAYgtWJyy3ePLk?=
 =?us-ascii?Q?FBtCwS5j4XRQ79NjACQsxyj3BUtTizsoyixovaObNJ9x8yiJSD2TkfIR2oja?=
 =?us-ascii?Q?TTSwKZRq8FQf7lIT0q4nWsyJYhe1H97+/2I9k0QQLTmhFSNeXe4eTKw8B3rR?=
 =?us-ascii?Q?w6tQZI0w/xdbGbZ4Cam8viz/n2obPtwzE9NYINvQ0KOo+Sml4MTyq13TSN8k?=
 =?us-ascii?Q?kPHqOstx+cTYprxGpjE/q7kjSYmphY3P/kWlpOsLe+aN53I0GjayZmgxU7VT?=
 =?us-ascii?Q?EOc573qKQuoEtLVwrwdjTCAJu0yB8sHnlfQ5Je12W65a4cA82Jt/P2iw3apR?=
 =?us-ascii?Q?zQSGori8M2l0P8oNWZLadzxvoLpcAmGsN2/UtPPHRkBHBNXgre/pg39FqfvC?=
 =?us-ascii?Q?J34KdKyRhcxyBkRuuBvMdeLJRPxX1pKxw3Jq0jdAhBxjH3Hz9XqOOheCwVC8?=
 =?us-ascii?Q?WV8PhK2OaEY7enwQ8BauiaXIJ/5qKTBpVYc+qp+74mbjK7fl5RJRg55gqN35?=
 =?us-ascii?Q?/rbfDYPiMdIVTTJLwLFprFjEH4Fei7sxm/1zSSw2iXQsAz6w07DwSTFiG8CA?=
 =?us-ascii?Q?X2laZbp3q/pypwE2I2vz6RPSsyo94KYKfCalEdA2clHEks8CDAw1wsFVBekf?=
 =?us-ascii?Q?/FqXyE16Y3klUijDsjz8eTwIk0zE5U0mHxo8q4iRQ7r1WHFT3fLh48XiCUHj?=
 =?us-ascii?Q?vt9Rip6oehPgt4haWuXiiWoQ9HdBaVh4rDWMt6EvIzQ9IYLnpBoet39GjuKV?=
 =?us-ascii?Q?eCNKPXxTLog0niVGb0mmOfyAK94JKvuP9QJYrwXdNA0GsdCLB8wEphyUIojE?=
 =?us-ascii?Q?ec01/OQUmnQ7ckQPe+cuV8VOKEk0aAe9fDXpkQOw0WUeZVwKb9YJTvFJ+r+X?=
 =?us-ascii?Q?sh3LkY4KrsAnicXi63OfT444GwnuDciNASFZ1qssMAnlenLgyaRwaj9dFJ7Z?=
 =?us-ascii?Q?d64VcsVeUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baadec7-8d77-4ec8-c84e-08de52bbbf12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:52:25.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2L0Xl6HZHCCvVWFDCpY2ERP1ETyDpgMEPKjJrmR18qVJS6py4CwEH/yTavoFIeGFhgNIAiKYJ7HWduJGbm4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253

On Tue, Jan 13, 2026 at 11:29:29AM +0800, Wei Fang wrote:
> Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
> so add the helper fec_txq_trigger_xmit() to make the code more concise
> and reusable.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index cfb56bf0e361..85bcca932fd2 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -508,6 +508,17 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
>  	return err;
>  }
>
> +static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
> +				 struct fec_enet_priv_tx_q *txq)
> +{
> +	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> +	    !readl(txq->bd.reg_desc_active) ||
> +	    !readl(txq->bd.reg_desc_active) ||
> +	    !readl(txq->bd.reg_desc_active) ||
> +	    !readl(txq->bd.reg_desc_active))
> +		writel(0, txq->bd.reg_desc_active);
> +}
> +
>  static struct bufdesc *
>  fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
>  			     struct sk_buff *skb,
> @@ -717,12 +728,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
>  	txq->bd.cur = bdp;
>
>  	/* Trigger transmission start */
> -	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active))
> -		writel(0, txq->bd.reg_desc_active);
> +	fec_txq_trigger_xmit(fep, txq);
>
>  	return 0;
>  }
> @@ -913,12 +919,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
>  	txq->bd.cur = bdp;
>
>  	/* Trigger transmission start */
> -	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active))
> -		writel(0, txq->bd.reg_desc_active);
> +	fec_txq_trigger_xmit(fep, txq);
>
>  	return 0;
>
> @@ -3935,12 +3936,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  	txq->bd.cur = bdp;
>
>  	/* Trigger transmission start */
> -	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active))
> -		writel(0, txq->bd.reg_desc_active);
> +	fec_txq_trigger_xmit(fep, txq);
>
>  	return 0;
>  }
> --
> 2.34.1
>


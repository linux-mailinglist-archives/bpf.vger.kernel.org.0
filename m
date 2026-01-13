Return-Path: <bpf+bounces-78737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF7D1A3C1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C159130915D8
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82A2ECD39;
	Tue, 13 Jan 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WM2l9TN6"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE802EA498;
	Tue, 13 Jan 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321348; cv=fail; b=SxOSD8qbYLnsXup6FAty2E3qn1bf83/NpNpayPumQQkvO7AUOAinGP5JlGL9ULRbNZ4Vqr3bNZgb3975n9A00IzF4+kHIy2QLOFYtgs2x8Bk0QptbMCE2apr1997kgLd3Pyq2ZBO+6utwwqvhba0UZmFIcYnchrRA3mXbO4TRpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321348; c=relaxed/simple;
	bh=bIUL29shfJ8vfop+tJyVRggY3fdjVSHDhLpfeNn68+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iR34TUy0EzhU2r35HRMWtPE0yhLf+wW/JIcUv1pcUD17Y+jwt+L6kLGU3tFADbFEWhY1GbECi86002EYoQZhxckXUfjVSHLSyJZ/xrXns/Mr8TKeE6vbPPxYuf+/TgTGyzI80iNibYxYgo4piKp5cGP8l88JvTJmEfAvhZnD+vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WM2l9TN6; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2kLNMQcNw9FPB/fJlJ9vSCiZp0SwX2RgTyi+LDRD03V96RsJxKpNrMwbMipboDhUuzQDPDOoZGxLvYbUSliBdhuWBxQyYPNAJ6mLltWRZBfQFrvxQE3YkyCHq/6vwDsx+6NY4dwqfH0SVjnD+/Sk9Ydr1UHfjYtwCrHJCCDJEt/9jM0q+SKvgokvKjbWidRuWlqfetK+4+NSWCFzKlsDi5xIeuJPlfr8VWHDtNX5d+CiR2TGdsGGjiFTNt4q1xDdeQsPhdmtD2qJVRcb/UrrAZ8vGiL2PIcmd1L3k4F19H7vz5aOtfS72HsUKqYiQlwDhIR75TF0gKWzs3cvR1gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioqzSQJOi2fSGDA/vh+rcUHV4gFkWuNXNbzHB5ztj9M=;
 b=cwwswN5M9e+ROkjM7aoI2iP6Fkd2kud9IEjXZb1E9ypSChbnWNYrE6CdNDxuelntPcuZ1nnqguCvzNVNjlhnICGuaWhQuIrwEmEFOlR7W3teOcDiOsXXoLy6xtyhIB3PYehgOJqbj6RN3T6VcWg4bvcx7Jt+Ewx2lbFaqVgd3l24wXXh0ktopB26ltTwKSNrYX8tjGR8wX718hPQKiQz4vYs4uOiQr4ajl/Uaj44ZDlN37FEbU9537XWATnsA4QpssCDp57qybjNwYE7TSptepo/WpzsfJBjm8TUbbjkCvUxYZIiWfWqbmVvM+YvtKe1uaN/N+p1LlAEiff2ffP9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioqzSQJOi2fSGDA/vh+rcUHV4gFkWuNXNbzHB5ztj9M=;
 b=WM2l9TN6icai8KE2/ExCHrwODvU4O5o32SLAuYiAyRh2sG4MaNHSc+uew61uMuXpKTFJMBbUoa15tQ52gdNPCgZK5go7CvOoWSIlv3yNhZkO8pSdXn2zJLhUihRuzGC55Ukotez0Ckg2ZJsssQPTj5QdEIxyxAOIdS4LmST3dzK1b0qisQNuNuYJLOsRu6j9vBt1QNYazsTZt2orsivNZnKGMO1TIziv2tvO5MK62XNkS03GDQEyBxCtIObBsBPX6Zqx2beZdDgjRVdtcOXsrs8+Yvm6OFCTJZH6cuU45dztiClykKLCC59GrWAVwQWuh0kOfkbMiLjOFyJWDuBh+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by GVXPR04MB10660.eurprd04.prod.outlook.com (2603:10a6:150:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:22:22 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 16:22:22 +0000
Date: Tue, 13 Jan 2026 11:22:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Message-ID: <aWZxNFIh2trMm04T@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-8-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|GVXPR04MB10660:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fa5b02-c374-4c11-cbcc-08de52bfedf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXOdNnd5GXh1ZtrudXRLNWxf1poerY8iTAPFsNXPtUNDc9sU4Nof15rlENGk?=
 =?us-ascii?Q?0YnqKrMDxrgELFXl7rmAsS1BNOtrfBMg7awh5bxzgJKuCQqCLbyUL35pxHJ1?=
 =?us-ascii?Q?emvy91iEooH2KtlVQ+agOgaIWlPBv7vQVwrwWonwtPZlZK2Kkl/nvMHZOXkj?=
 =?us-ascii?Q?f6HKl+GykDU+CzATZTNWrazIrfs+NGhwvdcYzIrHK0WmW1XSIwS4EQE60Boc?=
 =?us-ascii?Q?zNQVNMcpnbVlnDonP7BplMiwlvwskdk6WebI5dbpDZLELp9eG0iYCKlo479k?=
 =?us-ascii?Q?pGI52iwNkZ9EYExzwngPHmR9gDWLptge+VNxFbq5jpEsHpnHKUrQRvSGkyNG?=
 =?us-ascii?Q?diCl9mdwjkOcCZ2J9iGMKkxAmwZeYnMe3tI4aeNhK5R/red61t501IU4CkGH?=
 =?us-ascii?Q?9S/0VpCPMp9i1J7dK1V0Yurs0efTLfyqouffdMvnlrUL8aryEBh3sg/fQcu7?=
 =?us-ascii?Q?d2dc8JbNlHfBsSQL1FPyAFLL6+PLrv+vF0Mql7CR3YXQmls8mGDLpSLNsqBv?=
 =?us-ascii?Q?BQJQDB1lQy1cNsANK8d3VuWShAOPQF5FDZuu+ZnQ1NmuE+ChROvEuhzD1/8/?=
 =?us-ascii?Q?EOADlHza0hqHCjcv5FwLnfGh5rPXmuPeSyJKlDFUWNci4evKKnr4m85EiTZ7?=
 =?us-ascii?Q?GwviJBU0OzEWM+uDfBkm+OSgk3jkNQ7XsBbUl3z4e0JGx8GtVkNAy20Lymc+?=
 =?us-ascii?Q?fUIcPPr8BsIXT5DQRwhJmFnDKfPoQd5rBrkWSceW6VMpteqPi7HZoHu0+Yig?=
 =?us-ascii?Q?5KHQegOXDIRmN1QCqcjEQwqJTt6XAmCc8BIUhXDV76RTMF+fG3+dB299xYaS?=
 =?us-ascii?Q?jRllt/Ae6kRkMo9JDIaPx7oO+uUfS2A8oi49TlXKjyDq+sxwi3jEyoYDwncB?=
 =?us-ascii?Q?IQOgICmWh3E2KRi6qR10D+HpQzIS2JEsaeMLebWnXxPUXUhmqeWNIAFw/7Md?=
 =?us-ascii?Q?Wjc9TKgEu9h6O+5HYt1fO7FL7edJNOoTXo+alISSwFBff6KW6wQcVR314fhM?=
 =?us-ascii?Q?Izk08u6Xa2JKVLqY42CR52FG9OfspghrgaNe3j518Z/EC7oHOq9Mcwz8m/3w?=
 =?us-ascii?Q?Fj3IVV/HSpIw+KGaY7H+VkjJoGefVzMUG3jcfFvEV3WXsaKp9fzYjP/b1DgE?=
 =?us-ascii?Q?nOPGVFzfrFRWmAz5lODMc+WNnnJ5dKVAyZ3v5HNxlcWJuwS8bP9lEl0s16oJ?=
 =?us-ascii?Q?AwNY8yMhHSrblPTfBK8iFOU4vuBl07LAy/lVuuawfdY1UMEoExrK+hND2082?=
 =?us-ascii?Q?5x79HDJXGDKtu2ZPgkMcBwW02+4C6DWbvXEhuKVfz0JAFPzwjBqWEjXAcPxz?=
 =?us-ascii?Q?VrDOflyvaJGzFBStVCFmuR2VOBK5xKX8ugfr6oHL5ifn4i5xMik2iwhWWyHq?=
 =?us-ascii?Q?o4cwsEAaOiS9m30DeGoqT6M0Fhq1zc8Di+q2JmDmA81nv6o3X28QHVvCeVFt?=
 =?us-ascii?Q?rXrz0gR3xmFtcjt5SGpMHhsw9tKQFum0qNglSZ8AKGr6QjpOcpvwnwG+2VJX?=
 =?us-ascii?Q?txdB9CH3PHIOKS+RyKgf+Oit5vB5c3/oOKp+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MIfvvYVTbIi5OE20jOCs9LpqfddhdG9EKR55dRV+clR+FCDhnUqFFRtIbg6y?=
 =?us-ascii?Q?dS+neiDij5BcIXNtebZa+EuLPUti++8IASBUS6SodVuBH/fYUYfz2NXjd6Zy?=
 =?us-ascii?Q?PZyrxM6PXQxISDgiqhUuNvg+5nt2xuakM7Rb8ynBwG7XavE8nt/oxdh5w3+h?=
 =?us-ascii?Q?AyimVqYLZzKs+O7mFEqyatAyC7a7wVUOmQDVcslDDWupEBMkwNo35jApjkdH?=
 =?us-ascii?Q?dp4s7seuXxdh0gef3MhP5wHGptdp5q0XDRBvZBLGIjAlJWeDiE3DKl3l8yV0?=
 =?us-ascii?Q?W/Aia6J0XjQr62d+b0yqo743e2pFdTSA2p4nWpH5eAZbEv7ifCWfYGuo0y/b?=
 =?us-ascii?Q?HCKAL8UEyBSd5Qlh0t6Ta4WFRdSnb2sOduf3YNRH8U0hX2d6IMTGBIiOugBW?=
 =?us-ascii?Q?iZcFlKqlw45+T4LmMlKxkZ39jTcd2fNKgg8MEMhAa/PcjWiq0/XMAzL1Z9st?=
 =?us-ascii?Q?hWR6IAFzppd4otRcnd0tbMKLgYD0Q0MM+zLmbcSwtta9dwPHIu/akUZ+MNzq?=
 =?us-ascii?Q?FQBBKtZJ852hzFowRWAThxmUan/nC2Ys7k6vJ88jmfsng97XU8g/v6XnMFwi?=
 =?us-ascii?Q?WcH8yUKUXY9p0dFpTw23gy99LIrIxVzWTnawwKXctb68EDtxdFk30OjkNpZ2?=
 =?us-ascii?Q?iCplQioJcCMTeIcFjowRaJAUAlbSHtr0sNbKDBUy4ylSaG0Tn9CjS7yMjjmX?=
 =?us-ascii?Q?ySjQL0FCXx7RHkDz335BBCKEJVm6S/8RTH/gW3B0M/uaxc7R7nXOEn0Bkfst?=
 =?us-ascii?Q?SCRo2O1NKgda5S8qwm3LImRtWFPiVQjXCBxQ5HOXDDeegk9LV1wgcLizd2N3?=
 =?us-ascii?Q?oZdm1utYTfTYqlmrzZV4bMa1r2h3B/IHpptFfNE/b62rtbNPym7d4Qvy5N4j?=
 =?us-ascii?Q?I5f9uLpx2z+omqVdN0MKAbC93spQXaUXGVC7sjMHPfiiRIG5wHUQp5K0I9m1?=
 =?us-ascii?Q?5UG4hOuWZaEE1TdzPJlWsxvcETkTvfssLI8g9YAMZ5+zFKiMTdCoGqWehyFK?=
 =?us-ascii?Q?qIZpS3JXWt618cG/cv1jek3u42CmIgPFK1tPT3ptJ12zfyNVnZuBum63VcMY?=
 =?us-ascii?Q?QtSeTtvEcXfo4vMbJBp6VhYfNwOSanyUoIOmd4kFgXdja5C06ouVjA+Bk2uW?=
 =?us-ascii?Q?yFAIYm6ww/z16x3c4+VZsZ0MNMkEQ7vtsrpWVQvZu/bpSXtzV5M8ykpu66u3?=
 =?us-ascii?Q?T4OtKP4REZ9yvWka6xqIf3l4756rNpg9A9saaO/rcaegRSwhfhiR1zboLC5L?=
 =?us-ascii?Q?a+A8QSd/q1VHo4q1KNmiVFT55Usb7w9zGKW1F5URaQg/ahNj8FsUSKehArdP?=
 =?us-ascii?Q?KI0Xa0HHA59D1z9MXYji4uWI867KbiC10GLM5UvpfluH5WDgYo+gA3ttbFbj?=
 =?us-ascii?Q?FOONgEXd0bMelgMuhCCUWcD+2/Uz0p+xGBIG/SbETItI/3rkex+0KsM5f/kG?=
 =?us-ascii?Q?IgnMYjVts3gLsdIEu0kmKemX3dxInmz4C53GwGQxAgEedgpAMxDwNNgYLtKp?=
 =?us-ascii?Q?Re8fllFi9RnWoO92YfUthbR+NwaLeMTF9+Wfoo2ivPB0//15Qe3g8w6zehHD?=
 =?us-ascii?Q?qU4hYp9DbOmbAjTzkxx3iANgKQeCHmPsUKRXPshlElwiTe8p475cFo708PC3?=
 =?us-ascii?Q?8pcLzC7qgXMx4ITyLb7Bu6C1GoYkGtk0Ud1xMU4JOtkCHhoj7kQJbmwEekWY?=
 =?us-ascii?Q?ZGr4rCOJd9fDMA50fovzHhKQZi8Xa2I5qtqhJYPC5itBX6Ei4EazlZ7hAmiL?=
 =?us-ascii?Q?X0LAGsAASg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fa5b02-c374-4c11-cbcc-08de52bfedf3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:22:22.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1e6zu3vGVd6WxODwfAxOPGLqrNSux2wgB8S+lFataqdfKmr7Z/IDMTREq1Y8Z73lGgRTwYjB1YJZhm6BJNCPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10660

On Tue, Jan 13, 2026 at 11:29:35AM +0800, Wei Fang wrote:
> The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
> FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
> to check the type and perform the corresponding processing. This is very
> detrimental to future expansion. For example, if new types are added to
> support XDP zero copy in the future, continuing to use 'if...else...'
> would be a very bad coding style. So the 'if...else...' statements in
> the current driver are replaced with switch statements to support XDP
> zero copy in the future.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 167 +++++++++++-----------
>  1 file changed, 82 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index f3e93598a27c..3bd89d7f105b 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1023,33 +1023,33 @@ static void fec_enet_bd_init(struct net_device *dev)
>  		txq->bd.cur = bdp;
>
>  		for (i = 0; i < txq->bd.ring_size; i++) {
> +			dma_addr_t dma = fec32_to_cpu(bdp->cbd_bufaddr);
> +			struct page *page;
> +
>  			/* Initialize the BD for every fragment in the page. */
>  			bdp->cbd_sc = cpu_to_fec16(0);
> -			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
> -				if (bdp->cbd_bufaddr &&
> -				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
> -					dma_unmap_single(&fep->pdev->dev,
> -							 fec32_to_cpu(bdp->cbd_bufaddr),
> -							 fec16_to_cpu(bdp->cbd_datlen),
> -							 DMA_TO_DEVICE);
> -				if (txq->tx_buf[i].buf_p)
> -					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
> -			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
> -				if (bdp->cbd_bufaddr)
> -					dma_unmap_single(&fep->pdev->dev,
> -							 fec32_to_cpu(bdp->cbd_bufaddr),
> +			switch (txq->tx_buf[i].type) {
> +			case FEC_TXBUF_T_SKB:
> +				if (dma && !IS_TSO_HEADER(txq, dma))
> +					dma_unmap_single(&fep->pdev->dev, dma,
>  							 fec16_to_cpu(bdp->cbd_datlen),
>  							 DMA_TO_DEVICE);
>
> -				if (txq->tx_buf[i].buf_p)
> -					xdp_return_frame(txq->tx_buf[i].buf_p);
> -			} else {
> -				struct page *page = txq->tx_buf[i].buf_p;
> -
> -				if (page)
> -					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
> -							   page, 0,
> -							   false);
> +				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
> +				break;
> +			case FEC_TXBUF_T_XDP_NDO:
> +				dma_unmap_single(&fep->pdev->dev, dma,
> +						 fec16_to_cpu(bdp->cbd_datlen),
> +						 DMA_TO_DEVICE);
> +				xdp_return_frame(txq->tx_buf[i].buf_p);

look like logic is not exactly same as original one

if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
	if (bdp->cbd_bufaddr)
		...

Frank

> +				break;
> +			case FEC_TXBUF_T_XDP_TX:
> +				page = txq->tx_buf[i].buf_p;
> +				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
> +						   page, 0, false);
> +				break;
> +			default:
> +				break;
>  			}
>
>  			txq->tx_buf[i].buf_p = NULL;
> @@ -1514,45 +1514,66 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			break;
>
>  		index = fec_enet_get_bd_index(bdp, &txq->bd);
> +		frame_len = fec16_to_cpu(bdp->cbd_datlen);
>
> -		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
> -			skb = txq->tx_buf[index].buf_p;
> +		switch (txq->tx_buf[index].type) {
> +		case FEC_TXBUF_T_SKB:
>  			if (bdp->cbd_bufaddr &&
>  			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
>  				dma_unmap_single(&fep->pdev->dev,
>  						 fec32_to_cpu(bdp->cbd_bufaddr),
> -						 fec16_to_cpu(bdp->cbd_datlen),
> -						 DMA_TO_DEVICE);
> -			bdp->cbd_bufaddr = cpu_to_fec32(0);
> +						 frame_len, DMA_TO_DEVICE);
> +
> +			skb = txq->tx_buf[index].buf_p;
>  			if (!skb)
>  				goto tx_buf_done;
> -		} else {
> +
> +			frame_len = skb->len;
> +
> +			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
> +			 * are to time stamp the packet, so we still need to check time
> +			 * stamping enabled flag.
> +			 */
> +			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
> +				     fep->hwts_tx_en) && fep->bufdesc_ex) {
> +				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> +				struct skb_shared_hwtstamps shhwtstamps;
> +
> +				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
> +				skb_tstamp_tx(skb, &shhwtstamps);
> +			}
> +
> +			/* Free the sk buffer associated with this last transmit */
> +			napi_consume_skb(skb, budget);
> +			break;
> +		case FEC_TXBUF_T_XDP_NDO:
>  			/* Tx processing cannot call any XDP (or page pool) APIs if
>  			 * the "budget" is 0. Because NAPI is called with budget of
>  			 * 0 (such as netpoll) indicates we may be in an IRQ context,
>  			 * however, we can't use the page pool from IRQ context.
>  			 */
>  			if (unlikely(!budget))
> -				break;
> +				goto out;
>
> -			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
> -				xdpf = txq->tx_buf[index].buf_p;
> -				if (bdp->cbd_bufaddr)
> -					dma_unmap_single(&fep->pdev->dev,
> -							 fec32_to_cpu(bdp->cbd_bufaddr),
> -							 fec16_to_cpu(bdp->cbd_datlen),
> -							 DMA_TO_DEVICE);
> -			} else {
> -				page = txq->tx_buf[index].buf_p;
> -			}
> -
> -			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			if (unlikely(!txq->tx_buf[index].buf_p)) {
> -				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
> -				goto tx_buf_done;
> -			}
> +			xdpf = txq->tx_buf[index].buf_p;
> +			dma_unmap_single(&fep->pdev->dev,
> +					 fec32_to_cpu(bdp->cbd_bufaddr),
> +					 frame_len,  DMA_TO_DEVICE);
> +			xdp_return_frame_rx_napi(xdpf);
> +			break;
> +		case FEC_TXBUF_T_XDP_TX:
> +			if (unlikely(!budget))
> +				goto out;
>
> -			frame_len = fec16_to_cpu(bdp->cbd_datlen);
> +			page = txq->tx_buf[index].buf_p;
> +			/* The dma_sync_size = 0 as XDP_TX has already synced
> +			 * DMA for_device
> +			 */
> +			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
> +					   0, true);
> +			break;
> +		default:
> +			break;
>  		}
>
>  		/* Check for errors. */
> @@ -1572,11 +1593,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  				ndev->stats.tx_carrier_errors++;
>  		} else {
>  			ndev->stats.tx_packets++;
> -
> -			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
> -				ndev->stats.tx_bytes += skb->len;
> -			else
> -				ndev->stats.tx_bytes += frame_len;
> +			ndev->stats.tx_bytes += frame_len;
>  		}
>
>  		/* Deferred means some collisions occurred during transmit,
> @@ -1585,35 +1602,12 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		if (status & BD_ENET_TX_DEF)
>  			ndev->stats.collisions++;
>
> -		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
> -			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
> -			 * are to time stamp the packet, so we still need to check time
> -			 * stamping enabled flag.
> -			 */
> -			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
> -				     fep->hwts_tx_en) && fep->bufdesc_ex) {
> -				struct skb_shared_hwtstamps shhwtstamps;
> -				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> -
> -				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
> -				skb_tstamp_tx(skb, &shhwtstamps);
> -			}
> -
> -			/* Free the sk buffer associated with this last transmit */
> -			napi_consume_skb(skb, budget);
> -		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
> -			xdp_return_frame_rx_napi(xdpf);
> -		} else { /* recycle pages of XDP_TX frames */
> -			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
> -			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
> -					   0, true);
> -		}
> -
>  		txq->tx_buf[index].buf_p = NULL;
>  		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
>  		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
>
>  tx_buf_done:
> +		bdp->cbd_bufaddr = cpu_to_fec32(0);
>  		/* Make sure the update to bdp and tx_buf are performed
>  		 * before dirty_tx
>  		 */
> @@ -1632,6 +1626,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		}
>  	}
>
> +out:
> +
>  	/* ERR006358: Keep the transmitter going */
>  	if (bdp != txq->bd.cur &&
>  	    readl(txq->bd.reg_desc_active) == 0)
> @@ -3413,6 +3409,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>  	unsigned int i;
>  	struct fec_enet_priv_tx_q *txq;
>  	struct fec_enet_priv_rx_q *rxq;
> +	struct page *page;
>  	unsigned int q;
>
>  	for (q = 0; q < fep->num_rx_queues; q++) {
> @@ -3436,20 +3433,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>  			kfree(txq->tx_bounce[i]);
>  			txq->tx_bounce[i] = NULL;
>
> -			if (!txq->tx_buf[i].buf_p) {
> -				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
> -				continue;
> -			}
> -
> -			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
> +			switch (txq->tx_buf[i].type) {
> +			case FEC_TXBUF_T_SKB:
>  				dev_kfree_skb(txq->tx_buf[i].buf_p);
> -			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
> +				break;
> +			case FEC_TXBUF_T_XDP_NDO:
>  				xdp_return_frame(txq->tx_buf[i].buf_p);
> -			} else {
> -				struct page *page = txq->tx_buf[i].buf_p;
> -
> +				break;
> +			case FEC_TXBUF_T_XDP_TX:
> +				page = txq->tx_buf[i].buf_p;
>  				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
>  						   page, 0, false);
> +				break;
> +			default:
> +				break;
>  			}
>
>  			txq->tx_buf[i].buf_p = NULL;
> --
> 2.34.1
>


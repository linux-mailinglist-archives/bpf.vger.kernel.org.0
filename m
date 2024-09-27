Return-Path: <bpf+bounces-40421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24D98874B
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766FB1C21B11
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CB18C924;
	Fri, 27 Sep 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eCkgQ9aG"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF67A2D;
	Fri, 27 Sep 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448115; cv=fail; b=qEa+SK79n6pPTL1TQpt6+pgiriwR01bYswT1PLl6x7jcNbPdLxn/hQom4ai0O4lXXpP/Or/3TAA+dyLyPh2SCFv7fP3prBHT/iGwHcD+NP1TKZAt5ghvpBSHiwLJQLKuILwSTUieIsU1p59Olt3rE2KgI2Pt99Mvs1BaXOXKCjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448115; c=relaxed/simple;
	bh=S5nOVCRwuvY91nPlut/s2IS92HhWxOcyONhF4o9Uy3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZOGSxef5OBQjL2GywIIlcFm76Wa+qk5JqaYno9Jk7hAWPZ+7Bypg9jiSYVXFtxBohusE/+u1toa6UTuUhk41B2TIbEaJvLw4UH/InYti7HQPqZ6BrL5N3BicokLUWAwd8sDR1OPHPtWJF/7rWH8rNU8YpNwf27aVGkB3ESXHOl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eCkgQ9aG; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/GL1HctDYTcpgZ5QLFn10PGIftv2HfOkiVOcCH6cGxVZthKErS88KpeErYZHGd6MoaysDgaNnWsVyHHRUpEad+YUtEzkghnqbR3HdoEVIyd6Lyfgd78qJUSqovPk1HBtcnwgDDc8qnhX3aNBiZRVd9fGeuFOCSi8v1MfvtgauXW1/xYvFjp+TR2Oe5ORG3FpkNf6Fic0QIqQS0FV6mVUbLQsmtiteyLwcDGxw/QEz/o/l3JE5KbNI/7AFlSSvN0Ei76pSwIGaj2YJUQKJo+3Sd5Tu8BOyF4lm6GDF3jREtvXuB9v4Omkg4Y3ram9raa5Nl6lojHzi+FHiuGIFBD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDIBLZrVugHU/d6I0l7vyw2d+PIV6I8HRw5PE8cwJ+k=;
 b=XIlhuS0Z/LiLKbQHdXq19BpnX3fm3cB7RPrjY2X2GgfeQOO49mzVrcXklikhQ0TQeEyAmzHCqJsasganxkOEwMa5asxlTJdrxxygqTYzQxVIllVaspA3GJTOj4GEBx/Tlqiisbc8GT48iC4QDoi6WdTaYfZyCI3W2ZXdlnFP/RanA3hyCMSsMDll48CSELiNKdA0uT8T12jt3AmqgRdj7Mb2rh9i1LYRPJk9V1fbUTBRCt5B18B9PwhGTBLZf8dzBlVD8PI++KRM96ffd8DJqu2O+anvH/tnoRAbgnwpr4OOd3/59U1hdV++Y1Bmk8IsjsCsXAn8q6VilLHxMo36kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDIBLZrVugHU/d6I0l7vyw2d+PIV6I8HRw5PE8cwJ+k=;
 b=eCkgQ9aGVuycNsmKcoXUnVaxyEZoBaahbSx8rso4A7LCA1vMmSIhhseUacg/ZXZMfx7AeqW8rn0UPs397S0dGjriYCj3PiOiHfvB8mvrV8HF9GP7DxlLU2n7O8pFNUQ6smhh485uF8FZEWQ29iQxqN9pOiFK8fHLaQCji3Y1Tl+Jf5VIpXoA5nIRcAvTphD1K8hu69lDBl68+FtH4aFQPXoKgaAJtOe/Ve4YHhTUydrfTcrTghRCMPweMfng4ypnMJXMH3kJixdDAczcuAeqy5/x/yVu9mASgOWvV9ClI4Fsmus0arHQOG2nUVwCkKEUL9GVYDhP12egqkwMuDbAiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6845.eurprd04.prod.outlook.com (2603:10a6:803:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 14:41:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:41:47 +0000
Date: Fri, 27 Sep 2024 17:41:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Message-ID: <20240927144143.5ub4sqayqqdofscx@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-3-wei.fang@nxp.com>
 <20240919084104.661180-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-3-wei.fang@nxp.com>
 <20240919084104.661180-3-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b752cf-6871-4555-6d0a-08dcdf02834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PdRKJhq7z1IFGpoXBfim5+eIwCmi9+YovIubLK7BnmbrmVGwrXDiMGc96RDx?=
 =?us-ascii?Q?8nvIz5hNuYlwiuGs/bkQImJr1V55diY4/NIb/ukGpRJnjWKyw/NT4dTApkdG?=
 =?us-ascii?Q?evAnIJJqE1kM/FHYxdAhI3pnFemU8yDYjVfbB7YrQeuFeLE2nkUgVcCB4jJk?=
 =?us-ascii?Q?aLaMJvWsSOJWqtntmcs34dA1SsM/DLZ6EFsmeDp3BU0sD5EBIZYXhEuFXxGz?=
 =?us-ascii?Q?r79vaVe4jDqXJGJJB1LOg5+y8rV4cxqXnHw7oVDMwaP7Alv/+i/yMmOZ04zS?=
 =?us-ascii?Q?nmWhhw/3R/UXw/y7lVlwoqF10cX4Y8JakP8owI7iCfFCwa6FSRqzi3WCfP4Q?=
 =?us-ascii?Q?6XjURfBIkThhNKs6Jsg8Dlrrdwvbknjq/6l0GF7TNA8ejbd+G9LVjSiNoz/3?=
 =?us-ascii?Q?ez5OFiBpB5/zV8qUKEgsINfgmD5C5oQd1fLA9nVKdN+AthGb5jE+WPM6Z+68?=
 =?us-ascii?Q?GyKtdhlWerH3rU9CzgPes8IRItbsYcNQ4Y/GjDQtFx6Ri1JyFgYp5jHP9+YO?=
 =?us-ascii?Q?8AuJ2dznWnXVner7y2AXmWtb5TSpJSS1GS+ek4s9m16VKJyBcuYRR0kl0a9W?=
 =?us-ascii?Q?rybGmebuq6yGcloPQX1YEFvERMlOiIjFnvzdRIMkqtcR/QGj9U8+K8iY4mqb?=
 =?us-ascii?Q?m8Uy3Ok/xSOy+KIDqK2Z64CUGk5tJhlTCkZkixFbts83d5TF0ijt3Sx7SqFg?=
 =?us-ascii?Q?UFNbM3Jb52ffSdOkSPw+qhq0+fZj9oyxm/5rDR/SFNzt7O0KYE4mJqvWyVlF?=
 =?us-ascii?Q?0OzOCbRnYSk2sGq8QfNtFmeUzpXwgXqK6F+OvGDZpXP/5q6RQNUaciQNqLzB?=
 =?us-ascii?Q?U59eg4D96W6m8hFxGA4weInRnvU4st8OR5OiUOccKLtYh2y4ahrlHgEdG/A6?=
 =?us-ascii?Q?hk6kfZsCF7QfIpTqUmZfvLVBxkuvOPxsBpinKFPIhtt3OwBeOtWJzVJqzMlV?=
 =?us-ascii?Q?ILwxNdUmhDwe2NxiXq+T/bsT1vODiiXrFWCD2ZApAN7WSR2bHVYkwTr5VAF4?=
 =?us-ascii?Q?lgim4f2oR2Mr6m+82ocAzQsl8VhEyayKitMBXuE5FsrLW+0a577zBIyPP3/9?=
 =?us-ascii?Q?QKlv2PME2pjec4bWkK4VJA7zgv9azlu6Fgtj8kBaPu9ioeZtZYIulr9iTlSv?=
 =?us-ascii?Q?J2ZMqIdWW1bBJXtpR1X34Ww2+fEvZLVzLlSBnRMDHVRBou9zAQsOPo+H6tol?=
 =?us-ascii?Q?JE7LUQYpDJoaOqAeaqvh9rkARyHbyvkvYGGFhz9gOFrzrMNGJ/GKfJi/KYDz?=
 =?us-ascii?Q?gIm4qM4ABqpbsjTeOJsQbffBOHRHj9ftK40liudlOkpjqsShnb5VRCL0J4Da?=
 =?us-ascii?Q?mwVebG96ZwX1Dg1+A21/wuhhIzgSV07DBSF8Y5+ZfuNS7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ThtPBlWslSgXEzEtjv8oTqv6fxcftvpJgAQODF8pBKjGkhXy3QLhMgsg6lTx?=
 =?us-ascii?Q?8Rm1EVLtUJecw/zGvL+rD5FO6oBeVId94Q9fuViTQKalaG8AK7mYL9OL5zzH?=
 =?us-ascii?Q?mgTIuVeoyUs96hrldX2xHxeDixZjTwfTFL3WUdx/qgfx1/ByT0aWzwQ6O4yW?=
 =?us-ascii?Q?2qu3DYZMKddyo71k5WnvVpSr6asb8NoKR36OLgsMKzQ/tks8mqL1llmvbRks?=
 =?us-ascii?Q?O1RFalYzQwdUWWCSSNjxqeP6W0yj+jrqJqsYJibNgHWOIP+GJ2svP/mXpRAM?=
 =?us-ascii?Q?kg4HhxZ11Klv8dGfui+/jugV7tmqAx1OE5hPgqW2krfYEavfrH/KSu/5TcK7?=
 =?us-ascii?Q?26gHCNXFdRIJXvDWHStaCJMWIsd5yzZgphQ3xC2laUrh7umQ1VervTzwmUVB?=
 =?us-ascii?Q?N7+xkH6QhoDOp/8ZNEQUCBRI3pcsBDZ5YcoRLp58Th9mAKM/Srx4iZs6IB61?=
 =?us-ascii?Q?hW35CG2rKUCuB5QIjI1hqBrNT0Hcn/amFxfEqsiXBNM/cjbnRqXbXwfPeHpR?=
 =?us-ascii?Q?L3YY50DZ5iYC5uzTWbW7tbxf1gnE5nBuFkolrz29ijbRKBnEpWxLO9WlANWR?=
 =?us-ascii?Q?8mywTQR8b5c2nmbKbYGsJlWMGmxehg7ROZq4V9G95+emLH0E6htcmPCGxqDX?=
 =?us-ascii?Q?pJAq7+dN7q542MHfByAj6/eS2s/o23ka1jFTaMpGgjzB/z+/GKEodVRV/4xf?=
 =?us-ascii?Q?P8CdB7NAgHLbvwX2QZQP/EVhNXMX2iiEFLtEEcS1LvhjeyDCHJrUFtRXNwRZ?=
 =?us-ascii?Q?nnYejV2xWZyxU+3MQ6RpczoE6e2nsGJ6a0UTy3kwiP/dxUgh+W8qCBhR/M0n?=
 =?us-ascii?Q?jE3KtrPB5l0vmG8heJTZtl+edtaCXI8EkQ5XczV9z35Wia92rmdhJm9xC0kn?=
 =?us-ascii?Q?F86tzat7fwlvO8pnuR4RFhFPsYXKm4+obrMfooWsF9NmL5I9tdauOgnATeM0?=
 =?us-ascii?Q?mUa6ZmKksI3XYSiIa2IF7+ZUQv7wnYquIeTZI2rvqCD7u88QDLpWBEAPv7Wk?=
 =?us-ascii?Q?y9sA49bYbV5Is1wN0jwHjBf6JYDYLpslB/xx7H8hyXa/oBRZ3LOqq6qNM6wF?=
 =?us-ascii?Q?ZaLixcUratkqsjveQVUzZa6pJEW3PYwbTBo7XkOe7Fb9Kt121n9HZhRB8Z3R?=
 =?us-ascii?Q?qDKo9Kfhn8elEirECiSxe7NMoapCMVE1XfYchThIl1g7i6GNNYXACPBtAe4S?=
 =?us-ascii?Q?mzo7E0aGryx7wvzcSSZHW85ryQHlAL71HibjwEe/CHb3bbMmDSS6LfoPbGuU?=
 =?us-ascii?Q?hsoQpdTR53oPtDo0/BBl5UIPtuEXxvROvFbH443PPwoATjojGacgvapNMXYf?=
 =?us-ascii?Q?ekox8plp/1hXkDzpAWxW9mWpN+UcWtSo7IJRzYvl4e2Cz0gH8/wJjJBGSeIf?=
 =?us-ascii?Q?zFt2fCM8BlU2nFNzOy6wQ0yfsgCFCT+c7tDO3ddT70aV94EhUOVwfrmQTN+y?=
 =?us-ascii?Q?get0/l68OO9CPAuRtALLv5RnkVh4XV7YPOARstlph5GBhqfn96wcC2M3bVi3?=
 =?us-ascii?Q?ULmRuzvfRb7IfNDYH8qpTx9X58LcDdVdYhef4GMwF9+4EJyLxW7VFHVZ9DrE?=
 =?us-ascii?Q?UbIHbVKa0kVDqoCNxUY3KG9FLE2vWtzLB5ZtqGOYFEW+Etdc3K6vI6MPOutN?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b752cf-6871-4555-6d0a-08dcdf02834c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:41:47.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW0aJ/8H5sLhsO3PywNWRHhla2B2LZ9Fh1bDzjwSuWKIbHWDf1H5G2pNjpan53dFog1KXeskq06W7Fs54UYIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6845

On Thu, Sep 19, 2024 at 04:41:03PM +0800, Wei Fang wrote:
> @@ -2251,7 +2261,16 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
>  	enetc_txbdr_wr(hw, idx, ENETC_TBMR, 0);
>  }
>  
> -static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
> +static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
> +{
> +	struct enetc_hw *hw = &priv->si->hw;
> +	int i;
> +
> +	for (i = 0; i < priv->num_rx_rings; i++)
> +		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
> +}
> +
> +static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
>  {
>  	struct enetc_hw *hw = &priv->si->hw;
>  	int i;
> @@ -2259,8 +2278,6 @@ static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
>  	for (i = 0; i < priv->num_tx_rings; i++)
>  		enetc_disable_txbdr(hw, priv->tx_ring[i]);
>  

Please do not leave a blank line here. In the git tree after applying
this patch, that blank line appears at the end of enetc_disable_tx_bdrs().

> -	for (i = 0; i < priv->num_rx_rings; i++)
> -		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
>  }


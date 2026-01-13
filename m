Return-Path: <bpf+bounces-78736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27FD1A26A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FCC03004859
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA3F2836B1;
	Tue, 13 Jan 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aVTTW18Z"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788A263F5E;
	Tue, 13 Jan 2026 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321035; cv=fail; b=IhM4kOxcuCnTfY4IZKBlKBxNBf4gP0mu4Dj8mwtXTnDqo8kbLZt8Xt/2gvjCj15N96tgbUFlrZInVzvpyYyhTfgVQUJjuy77pzWWNjIzQxmB7+Rxqb2sZkOLlxJ2p79uyhQ+MRBhvlzk5NIgC4KuRw7neE72moVMY0/yXGYmUb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321035; c=relaxed/simple;
	bh=Xer253/fApaKLjNBvDwInte+PJ1Ode7/sf35bsaKx+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TofV6xVlRg4XqZiKzwb+tid+go3v0/oM16qGOMJuN2//WjunqOCCLVl+4j8QyULNKd0YmKcD9g7/B0PTsG9S6CY2x+axp29r5eWtamSsO2mZn7GMyLzOR/3Vs0K11VFS+xD+xn5T6zS5OGQG/bwCkMltANh/1GoowTFsEpguUtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aVTTW18Z; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS6vVLW1hQKQ74L3HRsXZwhpc78Yckm8VDanw+JsiNiXkGvZ9c0lK249namRWgxQrG475sfvFQnjAKHq2lGs7MIWBjZ7UVtFfjOWexKGJL49vFu42IddnuGW1MeKzFA26oI/EnVCmhn5iYwez3o6Z38+2XWigDHgCUFIfCbeaUokckVB9OjepDvgn2NDO8OBz/FHzX67gcNfFZcd4C1lrRE8Bm0Nx5pIdoEVL1Gjn1ricUdacRLQkVDvUVc3fu2PM63h8vCtTipi2HRBzmtARnmC7JwNn8sWMuln+66NCwnV03pj436DfWoURiSaxxm8kHjTX7H58fcFOl24KXAycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7hvN/ZcY/DxDLMxur/Uza0asa+TFjqPgFFmMzk7bPs=;
 b=XTKlHp4pR7qgvm2ROgnb5C8+6fNLPcxls3LEqeypVIT0bo5w+sQCOpuRbaaY1D6Hc2pPnU7OFYuaFbYeP2Pr46HD/0HaKG9bPsUg1UA4Ysu0GXtxd49S7dnSedouPNQguHas6/UA5Cv47TYGVdn59Yu+DjQDiNtCUywuLQAtdET5hvHAaVTAalcp8jOYBq8McV9sSNvjDsKLak6ApBmIXA9tpffefHaydyrCiu+kBnnekmhwH739OqJDqUxUM79p7af6E/0gDTeJfrhVtGv+Usd5E3lVPLejfTZI3SV/evIOl1htBMy/1fF7Tua1LZ1kdsEA0/2hPeHwVYPcJ2jm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7hvN/ZcY/DxDLMxur/Uza0asa+TFjqPgFFmMzk7bPs=;
 b=aVTTW18Z7i2hO8D9zyIBnUCTvOXcZ0Xd2RvpKF4BdGfRP2ktWzmQNOwddF2lzlgOCKTQ8+k/0WeJkjiodZSVn9l74V5m1ju2He+Zg9f8tURenSPGNq2Ozu1MCtqJFzOp7t2JSg9zCMSGRYPwD2aQVah3aJWgdnAgAqujwHu4K+3zuqPoGPhohO04g9kHXCDOUC0CxgQTB5KthzP7WBEEkagoM7qduECm+OJkCkPUxXNoVpsESfOUsveRakelJxqSi15+Z6IgbzKfukG8CQOvw8/0GX3avUBvpHcUjed5Ik3Rv4FJ5UfDwxW76sV/59BrWuD9aotLk6hlCNLSIYM1Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by GVXPR04MB10660.eurprd04.prod.outlook.com (2603:10a6:150:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:17:10 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 16:17:10 +0000
Date: Tue, 13 Jan 2026 11:17:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/11] net: fec: transmit XDP frames in bulk
Message-ID: <aWZv/mAixEnFoMK+@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-7-wei.fang@nxp.com>
X-ClientProxiedBy: PH8PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::23) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|GVXPR04MB10660:EE_
X-MS-Office365-Filtering-Correlation-Id: e8584f1a-7c65-4b01-ee39-08de52bf3474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T041Bx04WnlspdPJ8uUf/mLBtT1OSqOUzOmH5G5NuCYBcRcfMv4+VGiC/JTP?=
 =?us-ascii?Q?hxPExZnbeDjykkqdT0dQ0yHtAoIVT2xgFcTlz5pncvGJK+4zVhesfy+40bwY?=
 =?us-ascii?Q?iGfiEMNivJwc46uyyButA553S2ON6ZyZ/H+mhEuh4rBsyNkfGx4J96g56bq5?=
 =?us-ascii?Q?4iBUmQZBfeCLA6HTlC7J6XZtz2/2R+cWj9Tpw7S/Ie2L5Poe56Bn1Ar6yI5W?=
 =?us-ascii?Q?d8EP9bTYIQCLuxVOicEkFB5jBnZIo/zfB3O9LHd7K9A1oPGW3MkvQDTknvHD?=
 =?us-ascii?Q?ZLd743ZSqP55Fs0upevUTKClL0hrN3L+pCccOFm9J7Ov3GyxjBWKbiSU4XLL?=
 =?us-ascii?Q?g4J1lKo711bKhR65MsrHZEhy+k4tAaf5yjB5ivW7s0IWKdWBcJP3UE3y+nWH?=
 =?us-ascii?Q?XiG5Xv1Ipny99reC1TwaWxwHcMFUPw2J27W1bxGC+yQCIn7huFNKJ7X53UTp?=
 =?us-ascii?Q?06hvE+g3ceVMHvStX8zPvUBooypZDXH2vj9aMMP2nSN6vc4EKrD9SqTBRhOt?=
 =?us-ascii?Q?qvqCShEwS4obKZA/iYV9cMigeybnCEGw4xkDkkOCtz/Of7X0MhuPxaXBuzjT?=
 =?us-ascii?Q?NUUZWBprchHRmSQo1Rv02kuWg0MoDzFcI1qCq8ceINHBKRTusOhzuFqmT4/r?=
 =?us-ascii?Q?Id9h/Fqwf9j6rlJtZqMlReUONJ2wcgyf1J6dGFIBD0NComecT9JbXF/kmI1P?=
 =?us-ascii?Q?DdKbc0liHzQupEC8yDasVDQ0GQvdyCgWHsYnKLP1OY0NLSELI9InrOu7owe3?=
 =?us-ascii?Q?M97A2ui5DR+36taL6BdR4WLodaQM69IBfjEgtX/Eevq/F7I6BUs08Kd7U2jT?=
 =?us-ascii?Q?lkER4qZHYLN1TeiTOAq8sIHTPU0iZ60Mwghx63HtwcEU4gQiQmT4q9xhCC5C?=
 =?us-ascii?Q?TV9tBRFdt+cstrWKdsIKcdmtLrcE59lUfAu5aeVmM5f9GJWY/grvaKBSGRKy?=
 =?us-ascii?Q?bL13cf1nMucB8+/5irkeEqvvWwxalv/F4ObF5HkihkWzQBDWApHX88Op5nyl?=
 =?us-ascii?Q?rJ3FGTH3MyjH+ZBzr0cNKx1lEGPJOD7ggJF/Fgva53TECMV3Y9fFGJ+bB5gt?=
 =?us-ascii?Q?rXzDTMxywF98zSsuv+saC0vYlR8zpv4H8Lr98uGyRDlyfhOSMrONfrLS48qa?=
 =?us-ascii?Q?QYvgagyNPm1JxjYVnKqpL7XTGtsjztZIOn5b/X6XceUHjWY65ANpTKvxh/L6?=
 =?us-ascii?Q?vE0ZtTgjZQ72TIN1cg3uk9e5UisjcW9NG0iPGZDbvdajpYM8OaDULfT19JWJ?=
 =?us-ascii?Q?Ca9yUIZxnHnvCmrhMeaPaenNCP0kc3dC95pUKl/h3XkawV3At9vPNtqeTbuP?=
 =?us-ascii?Q?IaB5ynwiYZRPF1K5y35fagQcDhdI6Wp7gw375VV0lYu8r8CCrTSe1mIsRMNW?=
 =?us-ascii?Q?B04tkQS+sASyIMR7Ycv/EGYDA8VTIjVQaMh7eGCRdGdaBbr3QG1IsDGiPEF+?=
 =?us-ascii?Q?oeWzCkjnJ0rExDlO0z0Jrq3KNlwdfckpk/d6CLzBkSxEzqhhnSHeuuUCO1lK?=
 =?us-ascii?Q?+kiv00470d8jQn22f+o2mnAJPjDprUUP+BAW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFDUBdknt6rgEo1C1xRSbz7D02qySBChetvhoQpogq81uzhjozBA5Cl5+VUL?=
 =?us-ascii?Q?20lIem3mLFXrFC4uoFNWiA9afkJrJYwKfGS0Za6mndLJFAN+dymwyXvzKQgo?=
 =?us-ascii?Q?Bz2i3/Av1hvUjr52/zJchSzsPFYLj5oUd582PlXTcAbvERbqPECrj3cpx/jv?=
 =?us-ascii?Q?pm2UepS4o5jQkopXIr6QjEk26dQde6Z+gVY2/Ef2tlh2vlHjQKaPYYZh/lyC?=
 =?us-ascii?Q?N0kBecvj/W2qF75Td4Y3B9Q+CJFhX9U/D7XAmOKqtxhaG+0LjMKDOZCOYtSI?=
 =?us-ascii?Q?bKgVNv6BejJB39nPJ0uQ3wl/Qz/hRgxA2+aGAWdw4tQ0StodqEMGd7oMVSPv?=
 =?us-ascii?Q?xjpamq/Dri05GWO2QM90T199SP4ML30U2Dty6F8Pzu2tAu8t5hAaWJKbziXf?=
 =?us-ascii?Q?twHgH1mZ550OdMQbFMMwNvJEJLXPj53ffi2K7r/9LBH0aP59rBZYmt6TuZpX?=
 =?us-ascii?Q?a0qkDi6tYGwcm9WuuINfIR32oKBg3FAUesaxvbD3DdQ2fW8c0nXDhgwvS0kU?=
 =?us-ascii?Q?/OO8/1oqZ5buKFxu0WveP4bXiaLRom4/FBEMCl50Apl+nkzHZqMhsQsbtP1o?=
 =?us-ascii?Q?ZrVyrss9lFf/857QeyWiIy7tR/ZrPsnrzXc/TJEYU87YVTTf8/FOo8dvNPjt?=
 =?us-ascii?Q?V/lic34ZIiUvO7BAcnVi8KQ09vAj3Z/qAFm0Dlqbs53hcqamhG7wyf1HNyai?=
 =?us-ascii?Q?+ds2cuAkdNqPZnfqiJooFOStvo0b19fUa48IFXYxhc/maeXSn/dmOWwcS/cR?=
 =?us-ascii?Q?Y8TG7C24sq7FEPrhNOUlDmyiTw43sFBeazQuFjumvL3ij3FSrfs8RBJijYnk?=
 =?us-ascii?Q?OmXoW5WQPB4X71bEG9qOB8ccSNXUzLwnfsE3uLlSyk6rodYb4UnbfF4zaoBi?=
 =?us-ascii?Q?23ljBvPRvnVQy12wJZ24SVxtNyMqmfDcgmiMfW0dJYjwnyITTNYqYOOhqgJU?=
 =?us-ascii?Q?/fL2/rRxHLUITpwHiLjTTJHEo635DPb0c3rE0DtbEGO0u4TM1BQMLWUOTfmK?=
 =?us-ascii?Q?hsSHwHuECDpGG0NIxgY8WJ1mKx2h0lGz8cGQKQiEAPsgTOZeEkrg96Ejr+Ao?=
 =?us-ascii?Q?MDuAhEO8Gg1083l4iS2WvOPnzbVBFXZdOpv6sCmC6ebjLjiD307gk1tFId/Z?=
 =?us-ascii?Q?aR3GEghd7Dcki2W0n6HPJ7kiIK0amrsECzbGbU3bNZJ0zJO4qT2mbMrK7zHz?=
 =?us-ascii?Q?zxmuoTZPU22yAbOSxDkNBt5zOZQaQDo/3ncOQZ38WJEAv7oUE/BW9s/ifroL?=
 =?us-ascii?Q?BcCOMetiUmAnHFhfeIO4LTl6MEKp6YALSa6oEzEdVayTHHh6yQBBraQm2DT1?=
 =?us-ascii?Q?txgMtiEChBP2EIAWg+kPiyonrD81JY4UJb0XSD2iGldb+EQcdAIypbx8fmD9?=
 =?us-ascii?Q?/Ee1oS0B01fr5QfJrLUjIirdFpdPUAcb6c0iA/ugwUyBxfiFg8LrGBmHl/xL?=
 =?us-ascii?Q?8h2RAF4oiCa8v+9Lq2muGMbczedZVvDxGp6mvh+pzEtSf8OZ/WHfhkR8EsRZ?=
 =?us-ascii?Q?vFgXHBNIUZzuMb8RLqHkAgrhwMGU4myrDUmbKQ/eHcPJGBwRDW+zVKK5m+9K?=
 =?us-ascii?Q?0ky88EpkyaiQywgCCFbiRXVQVDFCqeD4B3jEwYhosJvOALgSCsEmevDfrU1x?=
 =?us-ascii?Q?NMHzx09JDICCg+LlrhdjF57V5NKUdIxF1afLjX5HsSpzpkg96b/mZhidh1e+?=
 =?us-ascii?Q?HreDau6rAE3wpY+zj7y7NgCNYpZmrvIo+bMuIg7MOhZ0voO5xJZGcaD94xHb?=
 =?us-ascii?Q?1F8Kp3cpcw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8584f1a-7c65-4b01-ee39-08de52bf3474
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:17:10.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acIJcUHsTyirWkNn6SDHPoui5Y56wXXHCKl/YsTkV4467oA08Zouf+dh4/7pQuH9AKVCTy8YO4s8qk1LDM6Gvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10660

On Tue, Jan 13, 2026 at 11:29:34AM +0800, Wei Fang wrote:
> Currently, the driver writes the ENET_TDAR register for every XDP frame
> to trigger transmit start. Frequent MMIO writes consume more CPU cycles
> and may reduce XDP TX performance, so transmit XDP frames in bulk.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Did you test light loading case? Any unexpected latency happen? sometime
missing trigger is hard to find when heavy loading.

Frank

>  drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 0b114a68cd8e..f3e93598a27c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1994,6 +1994,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
>  				rxq->stats[RX_XDP_TX_ERRORS]++;
>  				fec_xdp_drop(rxq, &xdp, sync);
>  				trace_xdp_exception(ndev, prog, XDP_TX);
> +			} else {
> +				xdp_res |= FEC_ENET_XDP_TX;
>  			}
>  			break;
>  		default:
> @@ -2043,6 +2045,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
>  	if (xdp_res & FEC_ENET_XDP_REDIR)
>  		xdp_do_flush();
>
> +	if (xdp_res & FEC_ENET_XDP_TX)
> +		/* Trigger transmission start */
> +		fec_txq_trigger_xmit(fep, fep->tx_queue[queue]);
> +
>  	return pkt_received;
>  }
>
> @@ -4033,9 +4039,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>
>  	txq->bd.cur = bdp;
>
> -	/* Trigger transmission start */
> -	fec_txq_trigger_xmit(fep, txq);
> -
>  	return 0;
>  }
>
> @@ -4087,6 +4090,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
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


Return-Path: <bpf+bounces-79252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F4D3244F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7295B301E161
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7EF29B217;
	Fri, 16 Jan 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d4KocsLI"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE312882DB;
	Fri, 16 Jan 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572080; cv=fail; b=d8tzju38DrqKay0PjW24bRuYFKVIESRqJ40J67+1BYjJJP7kA0q+Ra+CJfCh3yd+7ETXyULa1cNaMELHGiJaGW8tg+SFhKDW4Vv/gTdbgRkUTAETg//A1tG8X4KrweaXLmjWEam9HgqvN7aLbGpDamQm9vzgwfLn/hHY8w59+OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572080; c=relaxed/simple;
	bh=XN7kBdwTPML6GWo/n/P2oFTImo3JXx5oHd5myyV1jYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pM9IvqBfwXr9WrnGX/GyGp82aaOX8saLdSckYX/zr2m+/tdd/qxRzUUaKFVq5txii7tSTz7cCuQLmYuMqZ3uqYk2WrdCd8x+flwSl7hOTMFxpBwlVu5BQs5DxkctdGsDhfNj75Wi49QE4mthaHZNz3qffDRBThora82ToWrr/7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d4KocsLI; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIpny6qC2yTZ03+hx66DGHmrDdVjztaW9KZKiL+AzCAnVdjJGtRWXzh2oBbuAfysvv2M3OOtB5dWt953SA1g584IrsBPZoz9V0SiEDfk8S4m64nOfzcPLI58dwejHZjrZPioJ00oJfzyFHln250bc9VvZuY4rgG2h7JBUFAvvVhGgpfGWV/u4QM8dGNKRWs8eMQEXqKWU0RuFVqSEFV3ffg3DRW4jfMCvi8aiRlr92BCeHnY2zPjNqSkxWq2Ls9FzSbou9ulaQAIl6B3WCVPY8KT1yTV1vWDKOA5T+0qurDFNtNKKYhu3LhxIpn8TX3zCE81vt3u4OZ68LwyYZ1FLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cdvwi67a+ioOse+D5E5NcfG1HVFThBFwcntDBPyqMrg=;
 b=riI2SzVRJHS4yRwpgpi2DpyU76RW2sRmX082xsJ3tMtW13etx7i7viwTR9e6gP2sDnosSBJy+1ACevzScssK+lEGm4LkJkdT8QrFM7Tb8KQBDWVM1hu8cepf49XRHiWPwRFnTolB76zWIuJYpTnmRMtfBykI4CRxQsBkcwE9AIbG3W2Ubic0WHjM2l5H/Xi+p2+tpQ7nsMju8tXJbKb9SxX2vs8O6JdjauELwnR5RPiGPFkrWJE/LtwLbOIsqcZQtTsYIEfK2Z3DgzH85LJ2QLR8IT9niQDyUDpv/4A1y93aicVzzGllyVlEFfe173TqG7nJV8s5U7g+lxKq13zulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdvwi67a+ioOse+D5E5NcfG1HVFThBFwcntDBPyqMrg=;
 b=d4KocsLIXcnCCHgqjv1ABkH23zYeEMujpXjkCJqZ57dOTqdvbBXQXOPwZK9izptovg00QB5tPTGgCUIY1rmIvKwg71pqnRVvMLJ1WfgFMdS+VHpl3Bs8tqN+bJiXHsHKlPUL2AFKQwktyTuYhmNdhhWbvPQFXaxTKUAycJ2hwXhkOdi9lqkzCbVUBa/CUckyHFaR9sdjyLbf0jCVkIzOGZ0qyKMK1b9sDURe+tM+kKr7E2GHQ3RGUE60f0egnUG3TfNsXT5zivV/9EiO9H3Rtf1v7Kx2oCWXi5fAo3dQRAkSjdhq34RF//6mWpVAJLwQ5v+Z1pfCm0TPGT6+rS+isQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:01:14 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:01:14 +0000
Date: Fri, 16 Jan 2026 09:01:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 04/14] net: fec: add fec_build_skb() to build
 a skb
Message-ID: <aWpEn4taq4DNOZLi@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-5-wei.fang@nxp.com>
X-ClientProxiedBy: PH7PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:510:339::30) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 2332eb0b-b94e-4a8a-13a3-08de5507b664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F28xamJIdwndDblXYxzv7AUlYEuK4M2Pw93cjcoiMfYHjggQPVHMK2G6fv+z?=
 =?us-ascii?Q?9gcW+g/aTUmVkkixUTsmwFvwYcunTvtGfV0OweIpODUxO3WpYD71zwUYUcwP?=
 =?us-ascii?Q?g+xzAqQWPOShSrjC9ahsziyQqXtWbnedKB7jCHXBYW+MI/LTH/PZBVkolvPd?=
 =?us-ascii?Q?E6Kbem93SdU2Zkc7twV9IXEJozV+vNG3169Y+Us4tO7YDplF4V1BVYqMlYcV?=
 =?us-ascii?Q?2PqNaOaPbk0L9nrYTrV83Ok9H5JlKaGRvrR8OTqWI4QhlWUsQoCk+fgVXZui?=
 =?us-ascii?Q?556tN45Upg7bSC+RH0xwhptLHHvjXA9dKqYWNXr8AYNja2z0eUWRGZlzzkxl?=
 =?us-ascii?Q?eNOlyUOy4dt9gcecUwoKvpMAFtEf8ccGJZXOEezGllNsRbpJvoJZgIifobqE?=
 =?us-ascii?Q?5C7qPfNGmz6cULc2dSmT2rWvH7noz4Z2gD/ETO0XNAIGpffAarwhjMLg1HV9?=
 =?us-ascii?Q?7YDnfCC5Wd0cmMb5czWiPye2wpfl4+3uxqpSvSM+6uYOOqcdkFuoo9HCQ3uk?=
 =?us-ascii?Q?Mv54Zu/6QJpSYEf00tp6KBqqyPWNQG9KZCBTfb2EC2lO7MHNpfAzz554P2wY?=
 =?us-ascii?Q?wo6PiSatCaWYB0iPIrmnRrcL31Cv1Pn/NBBSTw8KvOtNCnq1scuXojjowVp/?=
 =?us-ascii?Q?9q1dpcPukRCt1rTdin1obXpk4OSj3VHXocB9I0jzSnaHkSTcNo13pyHQb0Hm?=
 =?us-ascii?Q?RsvN384JroDK5bs46cSUK084vgFKlRUYVLiEjHIx8+no1Lctzwy1RlOUiPtx?=
 =?us-ascii?Q?vu3l/KMEyB6JHpVoqWcwvKkrSR4vmgFV2aY8+eq745RJ63iqAQF00273sYVI?=
 =?us-ascii?Q?NK+cSEiy9eDSAcDlz8io4hCtRIU9pXvMJ3AJ/jdfPTfueKg83MBlLQN+MuyF?=
 =?us-ascii?Q?lWL172+bvFGy6+eB3b3fR8a6Ov6A+GdF3Cj85c+QwvL4MB5lq9Is1yHw77G3?=
 =?us-ascii?Q?lKY86Ro7WvEiD0YHdUt9A55n46RdRtwF08xZHsE4s0H05AMC3CUWU9klpR5j?=
 =?us-ascii?Q?ekcMUL1+d8VNwmzi6pxTuxNt/y9XRwJBRqvbb4ETjfvGvZ17ZzDyzx7kbns3?=
 =?us-ascii?Q?KKWuyTi0PR54fhEKdSE5iat74VKaAg4hDIdIRxu5R6fLrVyI14K0JWgTdiIe?=
 =?us-ascii?Q?djoevkBwuaaVYprq+hSXHJAjHkqcLlbkQ+QLfZoKVRVgTZWQGwVS/xVSiU7Q?=
 =?us-ascii?Q?/Y0tV5Iol6BCajzxUtq93c0XiOnB1dMX7oe5w6gYhLdls1w0rn/1yEePAV/n?=
 =?us-ascii?Q?XMDDpASgoA3WISjOlQi6Cpp0pKNYs3ysFYT9UVGJ2k4iBjk6EqLjdVaPCSkR?=
 =?us-ascii?Q?VaX1gnmGnMWN+5LucRKNKJvxTdAvlYRb4sTcSrVUMDw+VtwYUa72EwmcZdm7?=
 =?us-ascii?Q?T3zSOZ66gRb2Nyg2KddEDxpooTH4yvZo/aLkVZT7UfH2b0dvQeBGM3SlHuj5?=
 =?us-ascii?Q?66PAh2XibjRNUG7Zubu8WDrelu61cbPdj/D3gZKjpgdwRN44+qrTq8BvltRO?=
 =?us-ascii?Q?9mZ930skExanQW8UdgFID6SI81JU7Lidhe6dxvH97aZKq58nMtoPMjbzE1I6?=
 =?us-ascii?Q?UvDFb5Uvl5qf7zwhi7ACW0rQCKSXn3xLYmAMR4mNiNlohex9lYTKuTzRCDqG?=
 =?us-ascii?Q?Ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W651Zg0JqZmLbrQJnL4EFPyhjzAYzjRXzujhoBirkWOtM3ZPHHwdELfVGVNx?=
 =?us-ascii?Q?q3OSvI1AZMMhUpKn/tHybmnvAGMwyX7NAcDsIjuNqJkRfGatCsfe/bju/UOZ?=
 =?us-ascii?Q?GMb8Ymj+OSqUUxrn6rOe2lgTGfkK+SIOs6noQMPNolSTmC/EC8yYsra5Ms5e?=
 =?us-ascii?Q?eOk1cOiWLQlYRWiSgsdDiHdOQOCloObMxjH4k74JtjNLLfXKq+Wdv7WVs+h3?=
 =?us-ascii?Q?Z7lfU9M7LTXPaVfwkyS+nN1+iUTY7jT/E7oNOTR/fXoHjaLLvjDGvtiGAHsh?=
 =?us-ascii?Q?OyzYztFnaJYCiiaLh9odHTJzd+YpvIwyFHXUXsLMdGXkRdL4qOAIgG0OVUmP?=
 =?us-ascii?Q?99Z1+shNCFiCASrQDbTpTwOVk5/De0/5NvAl7+PThRKakfITsgn2IMleKTXe?=
 =?us-ascii?Q?PcYwfthpxxri0XRNevcYJmeIVm/Dkp6+4sxd4tHo6xUIRTFHyPXnoTTd4/e8?=
 =?us-ascii?Q?UngTAmz3cOkifUd0KL2OtJqfBhg/0fk5VPcpUzSj62v4Rq9Djhhq1qwhIaDz?=
 =?us-ascii?Q?rn0aXaSUeUkerg/r0VntaVTO1VXvW/XUpy4AHiRjIW1FJ0jb0YW0MbC7PN1q?=
 =?us-ascii?Q?7fh4ro5EozQ3AWHGTwbESAvPgFonCUIWrvKHy1qCjDfkSdjzH2RIc71nnGFO?=
 =?us-ascii?Q?AjsteT/Syntk06SgcSUFXmP6wjjJv8IUsC9GDmlbhFtw3ndqzdSt3uEsOdwC?=
 =?us-ascii?Q?4klmKdl0BKxMatOEqIxbSZLHLZLzkKQmq8Uqaej07tN4PWAJJk+7RZj13x2J?=
 =?us-ascii?Q?XDrpB/4tqJn6kFg910ulQJNwrgb9s/qEjFbzyGHnOmN4yxHZI3koSSH0l3oN?=
 =?us-ascii?Q?OaWi/ho2wE+UtEJhXNffH3Qncm/TyNpAjaP47AV3Y0ahz7dp0Fss2xOIu0w4?=
 =?us-ascii?Q?42T+r7/jPkuuyoY8N7XZ9jTO0yzXvV7+i/8U4+7qjp3zBRwIBVv1744MasqP?=
 =?us-ascii?Q?egjZxR8KZMjx4BQZeXunxcxTkRPdx/w5Bv956SIvJMqc6aUa7zhe+BpZC+cY?=
 =?us-ascii?Q?H92Iq0ro8orOz3nYo2Jqova0bS3haIqH60bf/oxBYWU/kgJUOaDzzkG5+qYE?=
 =?us-ascii?Q?MjvU9SSU+i+jx2zwvNXJw4P9pTDZE+5kzdKmUszAerusLRkKRJtU14GGZY2o?=
 =?us-ascii?Q?bgSf9tEWLsLymbI31phkOUJiU4LqgWHH8nSguDsqGkGl6elRuuAphJ7ZHOp7?=
 =?us-ascii?Q?eyJOrUNTRKJB3CdYEEAp0F9L6aoxiTOorvSTnA8LqOk8WL9EQn0k7mQwALL1?=
 =?us-ascii?Q?tRnpyAdVgq7SjPCnkWA61X/Lzcwhw0eynjdAxPWx4P5I5ekRKE4IKZPAWpkM?=
 =?us-ascii?Q?ZLjmkG2FjwMSCAMbM417Yi3v6hgG7deW+Y+HC/KlwpN0k5gVm66alQKE3e6W?=
 =?us-ascii?Q?1ji4h3cvqL76AtqI8SzgBVOcPPnKZv+Yvq0RO2XpnXbbQK/TU2PKlRhHZNVj?=
 =?us-ascii?Q?2SOL3K3UXeJ09poxq2Dj4eC09sCo917+J2Y1fpZ3bcMajzkd+J0SAMNkVgmV?=
 =?us-ascii?Q?yR8AKICoxMwpv2b9bxTbcR3PiNiXwi6jIHn9Bwr9G7N3H4ahn1WzyFanAP44?=
 =?us-ascii?Q?GB56+pdkxMGFO3xrc7Kg+KIZ6sBovaSEDWEbgSk6YD0FZgOYAjiXatocog2l?=
 =?us-ascii?Q?/6HSo+IQEYybOyJ/f3UWt2olIXTcu0tUy1BME94+tDRyaOPi/e+9P4LoADk1?=
 =?us-ascii?Q?YtxVA4hrcBDXY79d/U3SkjznryAJavE6z1DY6fDVgRPPbBD664mkbhOBJvux?=
 =?us-ascii?Q?h4qPoSRgjA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2332eb0b-b94e-4a8a-13a3-08de5507b664
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:01:14.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ2Z8hLPfLSlv+HOsAfIAfRrigwHDRaVrJ+XT7qGAtOBuN+x43EUQG9ovCxyxxtr08ZMx0to8oNGQVOB2h7FIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

On Fri, Jan 16, 2026 at 03:40:17PM +0800, Wei Fang wrote:
> Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
> code for building a skb is centralized in fec_build_skb(), which makes
> the code of fec_enet_rx_queue() more concise and readable.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

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


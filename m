Return-Path: <bpf+bounces-41389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BB9968B4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C6B1C22E5F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798F1922FA;
	Wed,  9 Oct 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dCxoWYrK"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013027.outbound.protection.outlook.com [52.101.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437D191F85;
	Wed,  9 Oct 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473043; cv=fail; b=dImGNMPTBXQTlO72dK90tfIcVW0Mx76lWXNHLVeEnDkbs9nYlN2rFuVncyzodmog2kPAlpW24JoWfsCw7FVc6Q+zWbm6aV3YeNtbbz1OeaaBbGqJSgEWEt6S18/9geew8PKSf9b37tveZIovR4uw2SDoQXGRZkJGC5vXyy9t5ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473043; c=relaxed/simple;
	bh=syMpOAAg8Nkd35Vvo63j//9dUtLlQMewT7XHc11dVgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fh29MIJoItWZ1GXgrYT6R5dd+vVuWv+oCs994H03OiozZ72MFwsxvpHISCMZ+PqIkfjoXzzplwrZ8YXsT+THuw1b8i/nIQT/gvKHgjaePNbPMo8qUTs8IV1rDCvxCtz35fKDocZcwoL24jfQHolZW+jGDv22mBmDcee2HCbJjfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dCxoWYrK; arc=fail smtp.client-ip=52.101.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGLevRUBw8pV/sVMOb5cIh6CYVwAmKmnE6Hn+r4ytNy+GgV10nZYMHOER4j0z7u0gyMf7pzuoYz/SHV1LerL76wjWnDM29qbRsbrp+8vUNYH/aFob1JIwFonwtUYWV+fKp60I3Z23jlzCteB8a4ukiuPggGURwR8omCD4qrLS0T42cqN3K52Ud4iGFQJ9J0xlv7s/H554TVSw56vOAoTqUklHj/smDKivylCSH+lpo2+Ma9Pn8pbQvjU6PUEolZrE5sw4zWrY/UI0kpBUWReLQEIVolaBecb098hBHxaaWS5fpo0N+6/8MseVtYLlM+5CZ0l5TKWb0z5PTdGo5ezfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bsbwrDAt8SGVXH/B+q5qrHE8AxLvDu5bMbnP9Q4Pt0=;
 b=RQ5dQzoAKT2HlML4ZEH6iU3ZCQsJvCDB0XqI5IZP/sBaKXngApWGSXp4nbmCMOswnf6hIOlDr/hItB2+MTEKYfx7rt6dwZGnAfbSwk3ULnMkhXgK88klBPL02PJE1OOpqCn7xNMhHnpZqHVLJmb0kdoxcFg+0Wa4OA/1jc6iiwz3qGrgFCEKJ0UZlG8s9mvuhbgVYLKeq1kSaG67mDRJC56jFMJESpcsszhHrUSUI397U9kxtMvgtghz2LndHvYutSusc1m/6QZb/y+FV9E3ckZf/6X4wxl0xoBnppyY15D6J2LP5x3W+Cu7iKwjSTF7iexDzEmv2ZClKljjq71W0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bsbwrDAt8SGVXH/B+q5qrHE8AxLvDu5bMbnP9Q4Pt0=;
 b=dCxoWYrKg9pXx7EE9Z81i20mig59X4JSMUr+tXz6Y0/3rVWhZ4w9qrFJfy5PpYnj8VgCnts7tBMYs/45yW74YDe0PwQhTeDvFrAYyeqryw8n6NWhwc7hH9EXPP70lBqisYmqtnDrTCixyxfiUiTdXrHTU34rs3BVfs2VDln2/WNs47EUIy5MdynC30La71gajCmlq2jeJ1cuX9RD+c4jfRhoAmCCXFxMm+FeH/pmYHV7uIQciC1I6guAuHb/fNRgGjEqU1LZwSvQy6gMN6vZaFIQmfTwm01BWag3PY1Q29XeFyEHaM0sBPUtBuJtqsyCpqBnEfce62LC2iZAc0XNJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB7038.eurprd04.prod.outlook.com (2603:10a6:800:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 11:23:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 11:23:52 +0000
Date: Wed, 9 Oct 2024 14:23:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v3 net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Message-ID: <20241009112349.ctk4gog4lhrcmxxs@skbuf>
References: <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-2-wei.fang@nxp.com>
 <20241009090327.146461-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009090327.146461-2-wei.fang@nxp.com>
 <20241009090327.146461-2-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: fe32b6db-9f00-4017-f773-08dce854daeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmAsx50MzocNlLnWt8d+rPHxqZcAXlFE0fiHBB4fnWpbETs9JPV9kx6AVYng?=
 =?us-ascii?Q?ebiaBrUzM0kxbst9YGUq4uv6ZK6w9Mi2r5akdy5W08XDSbrZLlJ1TRt69jhJ?=
 =?us-ascii?Q?P7cijmXqx4SV/AvvYmU53TzqPEtOmwGvJSsPtzo0QSEgxdPK0C7INnZ7o9g7?=
 =?us-ascii?Q?Llppeb/egrnA5D1tfJbSthW/KHyGqjttqGarF5XdBrg+8rCOQO1u58e2QLZr?=
 =?us-ascii?Q?vTSXUBDUYjWBiEWwdiVb/YozujL4+YxIWLJee2E+81raYymad+cIhJpjRYoJ?=
 =?us-ascii?Q?X7GwJ/05tvfdhOqrLhQcBPhJtM1g2oHB638dKKi0jpIyzRLPE306ZBEfk2dw?=
 =?us-ascii?Q?7p+iSu9323y4PhOYvPw0nhejeVYVPz5vMTbXRQPnENlDiAsJLoCzztOR8xls?=
 =?us-ascii?Q?UP1ZLFdvGJQtx9wXT/pRDsCYr6h9CxjUoDCHkbShXtEBTaaKXWSFdDDo6Qf1?=
 =?us-ascii?Q?yQG+DVEllfj2ZW0PagYwZ/vq+jfbh/a47lV0GelWF6u7WhAgTvxHvzSYFIiw?=
 =?us-ascii?Q?51OUV03WE4DawtW/EHTFwDCYCKVFNbRTGB8jrLwP/m8KSQV3IRxS3GM5QKyE?=
 =?us-ascii?Q?G5y53nggpcXhpbGko2DA0Hnh333jrQzEu6HjpACaJSxKYiXQAWNJzEMqYWFg?=
 =?us-ascii?Q?tnWnPTtPgoCE4EykJ7yvG0t1ac/UybfDHHtk+asm7YhBLGFwFmyAlVuam6jZ?=
 =?us-ascii?Q?Sb3X8tGj7uDg64om8+QbtaoVdnsGSgjXVEhYouFvpI/6aVv7OBs74xQle7do?=
 =?us-ascii?Q?OiIp9LDDtEZ+vpml/Cl1W3kQTNxrRTZfPUzJ99mxDhYbwBfP1O7rj/Mw/g50?=
 =?us-ascii?Q?SMNRjFlzygTbMfLo6ARWN7DVe2g+J2133sGqHROUovMu+TgaX/dsyPQ5UJcU?=
 =?us-ascii?Q?48B2cMTnoCALDyIVBG9FGHMNq3HP24qjOmwEuC58sui6W5ldpYe59ilYuYiB?=
 =?us-ascii?Q?TJHD/fB2bXJXGsTIBKjmZtvQkYvDqeRTGHBkgCCH6h6YYTqoa/1tsGhqp40S?=
 =?us-ascii?Q?fxQisY7ertLB+BxN7OT6s8n00Os+NCljBsVVooI/cNGhB71pf4GrOuJRGnjr?=
 =?us-ascii?Q?Gvui3XApBSNG1E98DR0kvTpNW3ZJdmS9Gm9e1dYQaG0zkwf+Uq6q4U5loLCV?=
 =?us-ascii?Q?3O6eso5r2l5IGZpPBY+c2ve0Yugfotba1/LliuSAZgzc/cecXWMVmjkL0o8E?=
 =?us-ascii?Q?R/cL2ivg645uH55CAvb16IpL/fQwOXBVNByujK3UIdDlrTfRCq78cF4qLgNN?=
 =?us-ascii?Q?gcFu7kSmsHpD9a8MhzkUkTj2HaaAqSgG94LQMjfZFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbNIj8+UGkAt0dKHtcp7F2c9AhMeusCHD19XkQv11qv8pLCX6kdNOi++uVJR?=
 =?us-ascii?Q?NO+MEjr4madQ2Lk/BUU77v/EHghRgjbJyYVmFv562QongucFW+Qc7sEBC07j?=
 =?us-ascii?Q?ydWWPQG7Kf5G7HrSLlKibVpvXMbLMPV3uvJU0iwuOW351bFvj+mi4OvXzl8y?=
 =?us-ascii?Q?5qGnShaNI0GWH4SPgUdpFADnvSih2mdILdh1EU3ECINoT+YUkcme6q8lV8O6?=
 =?us-ascii?Q?+r9W24tDSNmYIZyVZlA3H1s/URICsYJxsnI+OqhoxtX039XkHNftVMVGS0qd?=
 =?us-ascii?Q?gni3MOHgz0+pJ98s5Yzrm/UVIvXjoHHA2XrmHnqAJKH3l09Ul8pb+ldPrACq?=
 =?us-ascii?Q?7Zn+VNSS4Fl5WXIVAVKQqZqJR+j+lY1tozTXgl4I+UejMkfrUuAbCktXAtQc?=
 =?us-ascii?Q?aJld/Jp8QlEzkZhGvqyf0TUaZsHFDPjyNcZr8wtvLF8my23H5i4YgffvOwir?=
 =?us-ascii?Q?CuPeR/InWa7AXnKbwx+nafj3qNvIO2I/9ZG7TBPx3k23GrZqxG+1rXDoWL11?=
 =?us-ascii?Q?sFXwtA920twzAu/12fL1lTEaSZTx6o65ksKXgACvFdSSCO9WUNdQEUDEfW9/?=
 =?us-ascii?Q?Im6Qd4WCG9Tz5IALXJ2NinK6Y1fUfYDvwK95Vu7bdYt1c/RKxCyv9dxAYSEt?=
 =?us-ascii?Q?dLTRv51Ujdxgkt/3f70t6f3c5L9vsVU4DYETx9q6ymsG+lIG1m+5ctquINvB?=
 =?us-ascii?Q?/Jyvoby8tddWko/DBwSI2bVriCAxkKgnNxkAMcvMfec9GNC/joY5GATc9NgG?=
 =?us-ascii?Q?4dH4aHcKMZjXOwBKbq8dBENdYPJ+clE6BLGRdCyXA3avbNcabAzJb7bgt2qO?=
 =?us-ascii?Q?VnYUTu7L4f0ox0APjQtsJ4H4ey65v0Hmc837MaQA2DxHUswPp1LPR/MHp3i3?=
 =?us-ascii?Q?pEsUIAMIMsgtaF/AWgBCU8r8NY80+DJN3BKr2kzl1NGZcDMsPWkkqnimCL+7?=
 =?us-ascii?Q?B5xTCWpyYqubMH1suzS2DypBYpd6sSIj8t9t6nv+06UDPqNvvPN5oEXKBagG?=
 =?us-ascii?Q?/ZzIwzLiN7uFbTeFAlSWKBUY3VSHu0LvrmfbSOERJ+YdbU1VtA28Tg5WatZ4?=
 =?us-ascii?Q?HFIU/ms6TlsSHg8Wvxrrx+P14R2os1Qx03QeZLaq22fdfGhH4RiT/yWF6vQ3?=
 =?us-ascii?Q?Mj9wes98z3Pvg4ah8LUdMXnm9byL+toJfP7Ejm1qLoJ/pI5bE3rZYabN6GRM?=
 =?us-ascii?Q?NHnFkxR9HrN+wKCZw+zKcVrmZDOk/4YPw9BfARcLrPClawKtQzO31Rpc8O1H?=
 =?us-ascii?Q?SuEpoN25AbOhDofg9jvnZpc80mT9+NK2iUcvRIpJ9fOyJt4lsyoeu37Hs0Yi?=
 =?us-ascii?Q?qvT2W4U+SzIj/9R/23q135deYrQyy035kjKtNCMyHJB/uKj/aS/VPUvyQ77c?=
 =?us-ascii?Q?8hLYl+QvT1zeMwXhPCR3YSRl7qXFrQjtZD+4pwEbuQ5YP0grTeS4SC3J+Eh3?=
 =?us-ascii?Q?tETZHDIiw+Xm7mHjT7aaDr6WrM+B9dZoIHMbwtE5xfLt+ZF0bAxcvFceCvU9?=
 =?us-ascii?Q?3F3q/wLuzz/s9GzqZTCTutNwSV3UaJC9il6tln98w521AZXxnE0FXR3D9psx?=
 =?us-ascii?Q?F9IWjShF4b+k0xBqRL4mQ+sQoBEGE50vjJsFTFx2UDbpGKFUWOo+a7QooKE7?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe32b6db-9f00-4017-f773-08dce854daeb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:23:52.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt/2MHlx+g1y/gz5Bald0OaohXp+9lBc9ZZBHh6BSTD9GAyj1MPu+kpvMKEHii4ylSYKGFvpyNPIeTcxGB8GgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7038

On Wed, Oct 09, 2024 at 05:03:25PM +0800, Wei Fang wrote:
> The xdp_drops statistic indicates the number of XDP frames dropped in
> the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
> XDP_REDIRECT actions. If frame loss occurs in these two actions, the
> frames loss count should not be included in xdp_drops, because there
> are already xdp_tx_drops and xdp_redirect_failures to count the frame
> loss of these two actions, so it's better to remove xdp_drops statistic
> from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.
> 
> Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>


Return-Path: <bpf+bounces-76373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7DCB080B
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A739C30C40BE
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893443002B4;
	Tue,  9 Dec 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WviC73/9"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122C2FE05F;
	Tue,  9 Dec 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765296283; cv=fail; b=n8N3d+i16hzh2DRk1ndVtAc4+WW4tQ/f03yBAUn8cunrgdBRWMP2qlRL/ANOv70f/fqBRxldkpMde0nzDS2Rw0Uap4vrIRGZDL420xXmkJdABRbxybC066SbicS7EsDBckHWxlMb/fg+NakNEuGtDuNWMRxKA1v4uNmZ2C88YbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765296283; c=relaxed/simple;
	bh=2Ims4wXyBNfLyVgAVWkClgqaJZQjtjs3cK5eMH34fgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjJ8HsWy4FNC+KHM7Fai6ShaH4/7BbSMe8thr9uAbnqg8MXZXASl52JIlTxenZ05c47UBHGWBP9slTKvNqmJ6CXr4E4fcP8t88oVQn8K7AHaIED7+CYD//krhher/UTq17tToReDu1WBYOBfyzpK/U+zS2Ai9tWJyQVaOV/C+Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WviC73/9; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTFsLQ+BOolYW8Rhqz5rNc4hMNwyqeMSfWNm/B1NgA3tsKLe2ndc6FxKTkonQGhI50bpdnGdgXyTG9zGF6lq+Z3fCaBB0vq9T/zKqwTONNuHgNZw6Hypn8qXDDHVESdAHQjKW9LYyqv8GhtQjkMzP14QCXJSw6oa+rXcSpAJnFoO9/+lQQWtXzpbpv0GfvB55uO+C9f/TaObXnKdf2DxriP8SFdSBsDer/Ci8gm5x8B0+tRTghx3HtT1PgzwoiIt6W3XMKXqPFlBuqYLD9VoL/BV5uKsN0xl/FIfJ3+XSViMsm9NL3VdxudU7c9xyMAXGj6AyivnDYXHD1dEsiOUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgnzVVpVy9BHqIrTF+GHeE/QUaDOKcyGFPUZy7LVJJU=;
 b=V2U/eDJvcA783B5+jvmIBMuTmkCOiGyes1soPCIfxBZjbkEfbLhI4U9xbUQwQtqZvhGaaq8ogpjXS6DOAfFvw4Q+SJDIeaDCLG3FJYRcT5fBlmOKrQ8S+DYrCjmabWZfxU0YsO5jS+2NWtZOWlTafnABpQuP6e+nQJobLOEd7Xfb2eTmDXwjnthH72sYmDtk36+h+2EnTmLduVrsYZj+gC2WzLKf1Q6KHSRrDXIxL/7JUypMd4fwQQiuqo9D3cf0CrvObrYQ2NKQl+/LP1rI1C1pMko3cvUzxfqQwyqCRa546MlvSBRgQuAh15cpj10x2gOTZBveZjyOuVixj3/j6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgnzVVpVy9BHqIrTF+GHeE/QUaDOKcyGFPUZy7LVJJU=;
 b=WviC73/9H3/Sz3XjS+nh9CSmmLQbzfi/v3nub5KcPaEpFLDakVoKHOYIa9G34aaaoidnPcqh/xhegW3THKTXSI73aQT7nSlrxa76I7kC3RTPCJUZ32Bg1FVaP0Vys+aXm4ULfyq0C8gYI0qsREr/GL0CambNmp3hS3foklZiFTIvmOv4eNiY6aKU61irmJlZyigqm1/n3wjtt1A1gl2/SXoPQBnS/NnGXtZAgzBAOwoRPKcEOS4xcsEVS3dlNN4Qc1C9Lua12BinqqG1a7P/dYh4wbZ2iZfWOgAsf1yk0Zt0IQZoIJ9RJgz4TCSbAM4yTpl4SMEg5l8FksAT+qyFaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 16:04:38 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 16:04:38 +0000
Date: Tue, 9 Dec 2025 11:04:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Message-ID: <aThIjQESEvc7C/aY@lizhi-Precision-Tower-5810>
References: <20251209135445.3443732-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209135445.3443732-1-wei.fang@nxp.com>
X-ClientProxiedBy: PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c04927-8f57-4732-cda1-08de373ca717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3H887PYCkgZwVyjPSmIs3NzyCbt06E0rXjs5Eg9WaNogbrXIbuYcjUCuufD?=
 =?us-ascii?Q?QdoXcO25uAnZiem9jBC0IObV0lxv/yI3W0B++RqndwffYHi4e4zqDJTsqWRW?=
 =?us-ascii?Q?7p7/2bRUKTjgu1bnrrZgGNbUbv++R+ZLUSYH11EERVYu0Smkuql3YgN7fwRg?=
 =?us-ascii?Q?xhjXOzO6Z7v33kdwDHG/Lk3TNswmw/5YbI230fF8ZpiCAnF8k3WGwB1klhtZ?=
 =?us-ascii?Q?tIGUTmTeu6omQjcrtDWAKNDMAkXTptgM/Vdfk/LdNpf1+is+Gh4KxTBqY8UV?=
 =?us-ascii?Q?RFAVC1k6zauu6reZx7iaXVNwos4cemUbpOmsJXtnrNZWEDcOENgMoia/bq1l?=
 =?us-ascii?Q?Ts/HyCTqL7GE1s4NIEXCfqTgifniID2AhoICw655aD/OZe4ogBn7HiPvvv4C?=
 =?us-ascii?Q?uW5M+GFyd8aigD0+8DNhLy5UiAdqJNqmySPD0F+HiLciKUBC+NvvsYXQlbr9?=
 =?us-ascii?Q?0HicP7MVYnX/iYi2zJpD+zUsOkPZJJ8rrRtNKybYKZrK+HNEV7W7MywN1KF+?=
 =?us-ascii?Q?Cj1/q+wN0wX+x8vHVoWmghIwIUT9JS4RuXGSUTx6RMFFuUkOEEdqZB4REv7e?=
 =?us-ascii?Q?AJYd859D0JQo4Svl49EyfvEBbwYuY2ip4C0neZQYsP6o+sa2GJPVxiGVUszD?=
 =?us-ascii?Q?PCF9qa02UuTtDnxEPpD6l6SRe1YoQf7dn4yy7wo4RzqrzpTydwi9X7ZnP0h+?=
 =?us-ascii?Q?Oziyfj6PXbfBSCYzITtMF264o+RqH7GERJfkWs5UbFO1mirpfgPoTPLZ4EYW?=
 =?us-ascii?Q?L2Uiqhlc325QLRYeb/ny3Q6SG2Up918xjEtPkxQRhN7Jf37paaJp5WWmZhJf?=
 =?us-ascii?Q?2anyDkV55ccNoJBdPlLndAFZMT2TA2BFUQgJzbt2N7nIrXjUpmztq3VyybbD?=
 =?us-ascii?Q?8QzaUUPJNeWpUc4KtlL4fJMwhCeZLk/C6xliDe6NxMpUwI1Uke0DUCm6STAg?=
 =?us-ascii?Q?5HzMs3xaBVtV6i1uGkijvwY3yHf1/+OxqL985aKSrqLurLrjxJmwyFYSY2Eh?=
 =?us-ascii?Q?SrsnGCATAeKCzqUPYGvIpk7r0l2sRMKJB+3zjeXWqe0MGzzzHduGJElZkJLI?=
 =?us-ascii?Q?PTR05lgHcdeUaYKuvX2y6P7eUL03cm7vgT1AULCLFAC+27dEWyXNdLRnlTUP?=
 =?us-ascii?Q?idzxqtR1vYN0D8iiEVslGY8u+lIW5rd2aEMhBjmqNWcTFadUZDcC0rInwd6z?=
 =?us-ascii?Q?hHgKNiUd8Gl9b0q5MzDLowx9qR7CZ8bFvjaFOwc4sAHTSStbhDBJJRTHwnL4?=
 =?us-ascii?Q?xmjPBz+f459pWGFQVS7645GVwDwd1D9cuSLThy/tQWV69Vy36J2yi/lrhLPV?=
 =?us-ascii?Q?LQWXeEVSP772qaibeiZx7TUNG06he7/DEtyiXTTrRDU1YEtM2axhPAYJhp0v?=
 =?us-ascii?Q?wx4zD8BPo5Nuqj9t6owQIFngmHXF5tF6ZLI2e8xQ+AYy9k9BJocGtuV7rc8i?=
 =?us-ascii?Q?F4DlEBtzu8aS/M2e/tirccmGtAJ/CODwkyByjDNeDcGkaTHwWkhmDRv8Cgfd?=
 =?us-ascii?Q?NQZSRxRdUpk5pBPDq8OdUi1VLIt1ktp6p9IU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckkBfO20X/Mm/8tRlSQ69PvKf5iQkoUOTR6oWLp/1uFnCwevGJgyMt5Hq5G5?=
 =?us-ascii?Q?IFfEKkLQVCeRc+mxthUDQYc0OpfccukPTOTCI18ksTiJvJwjY/v7BCZJrAtR?=
 =?us-ascii?Q?nTl/chKJd05JBP9BrfNSEPbAdCnW6eO/yDyXkq39tX6rzgoYDxfOIYUeKLni?=
 =?us-ascii?Q?cGIG0TYrDFdAzoidNfu7AINWMVLrToirDazkcrxHhUwfAur9I+D0+DMlJyH3?=
 =?us-ascii?Q?dWQ7L1y3JXmLlI9X9K6t5Zr8yOHvzwDloV93kqZMlBiF/n2NSeizRgt0SkWk?=
 =?us-ascii?Q?ietchjT8c6+7eYh6EShopKCMjiJEytBWj+4cvQCmveZnWo9YVA53jjMi8Box?=
 =?us-ascii?Q?rpA4rDnC2R4KsO41+qX0P3ZRdihNzmKyV0f4pOvsugky4Sz8xAbjGtbXlIKa?=
 =?us-ascii?Q?dVmqYsYODg7zy5LSobqvcB2WronyK+iBCZZktqSIUMbkxCdGBus8fMxM2cKh?=
 =?us-ascii?Q?2iHI1c5ovcF8th3wVAIg6Cwg9ABMeirGgpfWkoHRcfwYeXilxtDfzYLVa3lV?=
 =?us-ascii?Q?EVPvSmx/cV/QqD4bYfB1tiwt7o/XmosQLBmY8Sk/77EGh8k35/W3cdpV/xo/?=
 =?us-ascii?Q?iZg2nRH8D2hGm7skOjBxa57Sced1+U82O1Z0QATAku7XJ2SB0EOXs01V4NJP?=
 =?us-ascii?Q?bcigrO/loTiUfkZ++sEDLZiO9QUjU3oo1ZhHfMpiNhhHOqqv0IFQEV4M0XKj?=
 =?us-ascii?Q?eCn4ga1uiS8TW+GGz9kRnuzVjeenvTvexfb8upG3kLdeeLmvml0yVfIJLm/g?=
 =?us-ascii?Q?SUuYbssE/2359fQMl1GT27sGjxrb17jdWz4AQRgjHS9pxfC2W4qBKmpybtX4?=
 =?us-ascii?Q?Q5GaGsKFyqGFrqOdHkk1fIK3p4q+tb6sC4NRmSAnmAqyulp5xVMJrt8+m6Y6?=
 =?us-ascii?Q?JrIt6dLW75g//4X5ILyNEe9GdBjg9i5uKBP7v7Mew4VGcNmz/7leAi2Gf+RW?=
 =?us-ascii?Q?tlni/Hitwv6Rb+WKpOpFfKRggR6jLpqF/E4sBMW6g+WhyRJkrCBvIp1VWMgV?=
 =?us-ascii?Q?iJNEjz8/OmDqwgbWBJ3SL4yLu8BlunWuehsRRs57CAO2RWvQBW1LbOQQot+q?=
 =?us-ascii?Q?GR5AmdgLG0BCP9HOhTyUInADMzhWpdeqmKmp7f4oM2EUBZRwsviwJ1BvTwqE?=
 =?us-ascii?Q?zVLawGc/fBtpmcXcbSPxVJoZSq69NmPDhzA5dyAYC0yI2Bs1dYSPAOgD1QWL?=
 =?us-ascii?Q?z/vH5M04Z3NPNYb6p69SH41a8bPrLrjcGYRcYXD0LzGsoTAKYd5y6X3uGRvM?=
 =?us-ascii?Q?qXRq3eUvm92sHOdR1he76nStJ1NNjjmYv7OQWVOLjPz1W0PxdrVuCfvjRYc3?=
 =?us-ascii?Q?AneUhoFwL2g67Rf03zPPidSMCv6H4NQSz+Gb7eqXEJ4q5F5plMUdsb9CGCFd?=
 =?us-ascii?Q?KWTbtnLtm0+2+oXn5y3TltKrDq9rVIv+jMbVnjgeuYtHSIbnc8cVLQ5vMven?=
 =?us-ascii?Q?wBKrsBBRyMwQKbVaIR2zMFQIDY+S3vMRBZeSZJt9pzbwBcVlIEgXHFia5uyr?=
 =?us-ascii?Q?YI0R8kFhKiB+AZZONoScfbYwAT3G9goBeP1jBBbXVzNmBuI4qUCwUfWFgLoG?=
 =?us-ascii?Q?poA23S8VL5NBIbwgBSe5SHQZ9pxTybbCYD5D/e/8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c04927-8f57-4732-cda1-08de373ca717
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 16:04:37.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W2TU6Agcd7eka84R+qvcshuCUch0JOhbRx8RtyRXjcmZFI2schUwWbVU7nszJMT9fO95RgBko0iKmE+1hMOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

On Tue, Dec 09, 2025 at 09:54:45PM +0800, Wei Fang wrote:
> In the current implementation, the enetc_xdp_xmit() always transmits
> redirected XDP frames even if the link is down, but the frames cannot
> be transmitted from TX BD rings when the link is down, so the frames
> are still kept in the TX BD rings. If the XDP program is uninstalled,
> users will see the following warning logs.
>
> fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
>
> More worse, the TX BD ring cannot work properly anymore, because the
> HW PIR and CIR are not equal after the re-initialization of the TX
> BD ring. At this point, the BDs between CIR and PIR are invalid,
> which will cause a hardware malfunction.
>
> Another reason is that there is internal context in the ring prefetch
> logic that will retain the state from the first incarnation of the ring
> and continue prefetching from the stale location when we re-initialize
> the ring. The internal context is only reset by an FLR. That is to say,
> for LS1028A ENETC, software cannot set the HW CIR and PIR when
> initializing the TX BD ring.
>
> I see no reasons to transmit the redirected XDP frames when the link
> is down, so add a link status check to quickly fix this issue. However,
> this solution does not completely solve the problem, for example, if
> the link is broken during transmission and the TX BD ring still has
> unsent frames. I think this requires another patch to address this
> situation, but it will not conflict with the current solution and can
> coexist.

It does not make sense to transmit redirected XDP frames when the link is
down. Add a link status check to prevent transmission in this condition.

This fixes part of the issue, but more complex cases remain. For example,
the TX BD ring may still contain unsent frames when the link goes down.
Those situations require additional patches, which will build on this one.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 chages:
> Improve the commit message
> v1: https://lore.kernel.org/imx/20251205105307.2756994-1-wei.fang@nxp.com/
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 0535e92404e3..f410c245ea91 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1778,7 +1778,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  	int xdp_tx_bd_cnt, i, k;
>  	int xdp_tx_frm_cnt = 0;
>
> -	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
> +	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
> +		     !netif_carrier_ok(ndev)))
>  		return -ENETDOWN;
>
>  	enetc_lock_mdio();
> --
> 2.34.1
>


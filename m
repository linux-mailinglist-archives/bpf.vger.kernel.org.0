Return-Path: <bpf+bounces-53897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D13A5E0DE
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04147AA420
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654FA2571A6;
	Wed, 12 Mar 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VUP+WWE0"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCB2528F0;
	Wed, 12 Mar 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794388; cv=fail; b=Ul4EGrFhA+4tWyRuUqBbgfS5T/kdP3ItUEM4ZyBJgHnbrRSc5OKJzz6Crw6Rg14j0BlGYUFl9c6+PPEJm4Co2cCgtVdnJ04w/0qYuiPwbPjpzuDbc/uIbqoKAhVQOUmlFfmh0M+QtU/MEnWAuXrBXODe2+kKPgaJHQTQSnYuppQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794388; c=relaxed/simple;
	bh=+ZVo55QWTjcF/6vLupqJU+kl8cDoeiEAgNOBHp4HBAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sJNPYIxNLu+lj0SLtMHjR3oC+rLsjOggBfARqd1xU+GfMdkJYea2PiAs7It3DUqMAG4Va1FMCOQESx4SzuCJBi5D3MSB0hRVW6flzhG3+fwJV6v+DMXNirWys/BbAm+2htQ7SLjuCZow/Q6P5FoY46dNxN4hnYaDrlWKXNY15q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VUP+WWE0; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sted+Io+rHxrMDulKT4ZEO0w2idWlAIkFLnoO1QieWMX89wOhItlH07j6VTBj9bzvEXPqiOwQTMZrmsx9tQShtJzpgkwWEusp8Oz6DqbvEo9NhoCjz/yHqKtnzhkdxPkvy80A+SE0Ihsilspp2MQkfM5ALf2Q61T+lyAOR/NtxPJooL7pXLYd85WwgIKermJAfpSQyOHkN/WQ7Qyi97Yyd5ndgq3AbZAQKirrB2kOkIce7jwGshIH0FmUuiyV8K9uS9S1KA446teFzz7QrrhNDJqyCt6mo7lRT9NHWaZu0W8u8FJ4YCMejGHMqH83muSPuRnOmsX9ZdWhnfhY4z8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuvCP3aBG2Hmlr5Ro1PpX6BTXtWwMjca0LiioyUMKlY=;
 b=Bxk2s3+npJa9UiOLHsRebcW6UkvR/54iouJjbULfV7NRJT9iaXsgLb3ZPtK6EDpgc1iGjZA+b2tB5uBjd1PpRSl0Vk85AKSXknpnMJhLix4FeRrYKQu7ClrFGheRfZubfwZ+djXYatOSWYNMfYrB/aca0f0fh4zttEXYv0+SATIYoVAZmerVWgg5EbUyqN/SrDPDHo9nmPPrbUekKM/PdyYGY0+6lFi5fkbgAvmukRmOvLr4Khv27BPew/gWGdrlJLnOwyh0VnFCr+FCa7qh+IQj1gczKKw98jkDJLZ/IZPRNug8OWlicW3jiCZCc8TnlhyC6Eyor4ZlcDmK8H8soA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuvCP3aBG2Hmlr5Ro1PpX6BTXtWwMjca0LiioyUMKlY=;
 b=VUP+WWE0zjJuUpoodgV6IpxXBROD/ALOuxzW0BnCdcrutjWRUch8XXsasB5JQrO7iDV6Nq011qdGtTrzhAcZKqjOzYU3bpl+M2DAQMUW++HE3D+w4uj1fbR6XtxRjU3mLWELQj2z6n7iS6jv/I82Fz2gZ6G0ZY0iZ6wBl4Ot3OT2TRZCgqI/wMQixgTrSpHfcwrBv8BQC/BMfVV1ciWf4SVvtzRwBFV1er962NyvUlixsmzktLg/UDQ0G0uBZJ/pHjsGkrrMoSF62QKzMpAPd2Z7P45Oe4oHk2C0iqG5R6eSwnOSnETjbh/lP0IK/NS2aMkYyx/8OW/dZVVFXOqQPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PR3PR04MB7260.eurprd04.prod.outlook.com (2603:10a6:102:8c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:46:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:46:24 +0000
Date: Wed, 12 Mar 2025 17:46:20 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 02/14] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250312154620.abqswbrzqvakeeau@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-3-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-3-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309104648.3895551-3-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-3-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1P194CA0056.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::45) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PR3PR04MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 60df5548-bc8a-4237-049e-08dd617d0b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?thg63XyYnvLsw6ggyeqBwpbBVmVWFndDP1o6zq9YWShYclHveE9JcZs/YOlf?=
 =?us-ascii?Q?6LTk5+2S81GXW7zsxHPXYqSkBH0luHvuNg6psaKgXAS/S56iQq+YN4qhuvTc?=
 =?us-ascii?Q?ORmoM4QTywW0NOJKuA0Svx4PP8r54RnXeKLGJVTgg7jATi43P0SMXVePtf5u?=
 =?us-ascii?Q?j0Xt8YNaBK+D/Vfeux8LKwv8GuhTYXkcTKIGmnEbnW9vc0h/jJz8T9AsV2vs?=
 =?us-ascii?Q?JDF+f9ROXmbqRxAY6pRVl2FtYDo5UKMw9K2B75JAfeOTuFgIV5qdR98tZtp7?=
 =?us-ascii?Q?gCFCeShV+H367yVx2aAYXTWNCEWpyg7ZH4ZNfmbqKND1dCyB9Z/aHk+RyAak?=
 =?us-ascii?Q?8YQtjOHSkQBH45DNh6S5Rh2X2FAAkICfamLCtD6M5ij6yG5rc3UjQbwaGwjR?=
 =?us-ascii?Q?cBdAflwQF/FC8eNldZVVArEyaqobCAkfOZzuhoYkUb8QJk5X+LWZmN48mWAC?=
 =?us-ascii?Q?1fwWXsgnveDap5jOitqwcYlyWd9NiCuZZRG0k5qVWreE1cMCRwIxbITLCGF4?=
 =?us-ascii?Q?ToEuKsBxL4+hBSzhOFi1fSyTeF6cFKs3Y1bLZppMOOa1v/EtTUegOhOy9h4A?=
 =?us-ascii?Q?Lp+Ego1ivsbAy+TctLqHEYVGsJ3Y+ta49lHIl2veYHyC9hZemOmiSaWMO/QT?=
 =?us-ascii?Q?vVIb4dxg/OxV2gZwh/P3QlQXMaJYddzwZXXKqRd/ZLGcID3riRhnAEe6sUCD?=
 =?us-ascii?Q?Kq0Es3fhL02BIExjnNsW088lWP9bh2AG3wxd7tNy5nDkGtm9zPJ8BUNL3R/M?=
 =?us-ascii?Q?KVnwYGk1WrsOInKTk0ZFJUlryrdYNMhvhh5w/vsiM3eW2otlhFNz6rpleMhQ?=
 =?us-ascii?Q?XIZVHONKHEEEVfeuIGxcvsfPv+KB7E6hNywrKQKtWkq2sxA9AADQu85HeCqs?=
 =?us-ascii?Q?AYLn+UkDkCCb09bONFaZyjsgjlxb4WSvv/DDEcTfnZ9iojYntSDcEu1D5B0b?=
 =?us-ascii?Q?FbO7mjBpQGkNoH6cWwB04bQtIs9X5fbTDGFTX8wNe+xUSKjaQfELXfiENYG3?=
 =?us-ascii?Q?LPz4Jbl57GKimKKSLHgGINPxqQbq5ayCeodtxvzt5eKRL1nztzlMh+3AhC3j?=
 =?us-ascii?Q?SperuXC+5kT3dlME0rTLMK4HcB26fyHgrbaCVTnQJ5uDh8cLqh3DXkxJi+9x?=
 =?us-ascii?Q?Ym+wXLqqVZlhwZGhIW3Y9++WJYv+4PPEaG5s0MkwO6FswTb5QfOwj/1iU0wA?=
 =?us-ascii?Q?98kqeUU7Kzx/6MLNZl35QdV4faPu2hH9+wBu2Y9b4QGKRGaA0+3cWMT6IEHK?=
 =?us-ascii?Q?7rMe+4t32OT1chlf1zHMjwEJAae7FOJ5RjoXgxwldT+Jup2ir7CmkfmExbb3?=
 =?us-ascii?Q?DudVr2pZxLyiekwNpnhwfdEFm4nkCdDUeYBSKPmxU3jIVfWHvV+akdJa+CyQ?=
 =?us-ascii?Q?k0ipBqg9bksV03bvy7KdBPFs3XBZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?944TzGxLW6Cv6lQBw3zIXRUGkva0w3F+0feG2B8g/+y1xHDS7azJ0StXr/EP?=
 =?us-ascii?Q?80bRTaZ584t4jQfOLzNdupS2Apwyu0eYyf26nhhe75jYXwKqnpk8kskalXKZ?=
 =?us-ascii?Q?RVJzFwZTRHYV+wzlOV7hG7lqzG1hkutrLEkTTLNg8IUj9W3c4CFY9ZxOzLyk?=
 =?us-ascii?Q?2TNZPFkHwh5DEOPSZUtsAsHVn+Oupn5ylA6kFXbN3J6M8RzRtTTx67xytdnh?=
 =?us-ascii?Q?F/NCbDPPOVmCM6+/9gsrev1Wy6z8dlHrhT/0OiVYZYptJ+ZHu3VoE1gVC4NM?=
 =?us-ascii?Q?K9zlipt0MldI21uK+ki9fh2P/t8d1TfB89Ox0E4AmI1/eAlsqcMu7hsnqHag?=
 =?us-ascii?Q?3F6FLt9wlCQBx5uS44hcA7Zqbr9M+m6tX+dptknp5olFTH9pt8/YlHOg6O1M?=
 =?us-ascii?Q?t/YTUt9qd1jydOpNz4c+lnCe6U7SRUjORro9NMq0Z+y0AzhgoAKO/poio78k?=
 =?us-ascii?Q?Hgit70anbc3UIWj+ntyvAq26OlGUKdbyM+wqaFbmNE1xzF9CXoBGtV+jy9EO?=
 =?us-ascii?Q?2RcxUpRDoemWXIJ7CPWInBwmBaR7CKv2ra7FLtntlI+T0U3grvJfpsn/qhJC?=
 =?us-ascii?Q?UiFR/X0eD82lKUPR3Ec41UvgIM1rxNPGWX5yi2dJ/TUtmjekxsKLngII2vIr?=
 =?us-ascii?Q?b4jD2xg48XOinQGMm8hvJIHAwFcJxVajcYOiy1CCbrL1O27IfWoXTXmzuNES?=
 =?us-ascii?Q?bM3Gc2Psrqp+wL3dO4+1U9gwp2DgHMYf1xvHCrO0iLhx3l8LcK56bUVprNXW?=
 =?us-ascii?Q?LTVkp+rENQgltezkSXByU4bHXA8P90AI624zaRuF3gtkhePtTiuQ6dxhx3+p?=
 =?us-ascii?Q?OPOmJFxynQ1R2t6MyOLqlCBb1wqIl8MyUGKerQW7jfmxXSpgvxlM6O8RdKto?=
 =?us-ascii?Q?AIPFCQwl93IAZ8Hp1Xku4fqIQ7DzVbsu6m1jmkKfUUKUwcvqccnJzlVS0DFj?=
 =?us-ascii?Q?queGZvPl6xDu4tY8HktehxwURWW9D9HuMrXqTlV+EBoJfUOaO/EwBsJnOFn6?=
 =?us-ascii?Q?PdMBEYZk6dD8NPrxGrJOTaXUEgrswXDe5Eue3QwpXgdj1rrjMP0up30zyueb?=
 =?us-ascii?Q?qBrv7tdrYKv1zbSmm4ldjVPvCRGX75XrM11xF4ovvSR98Jqu3dkBN6+wVyeC?=
 =?us-ascii?Q?0n1hieyhpQB9lIF0XbZbVX86V1ISMsLIOvYa/5hbPfTe9hBky8uLfX4dk59Q?=
 =?us-ascii?Q?Eo5293Y/EBRR3ypJmeP5y6GPEBQWQ8uFhIZr7RS3jnhDVlfeuUIF0bVN6GvS?=
 =?us-ascii?Q?XFxoQHdBJ4sg23gAzBOf/1hLpeHRWnY2rh+/EvlZV2I6H8ehQl4ZmAGPd8j5?=
 =?us-ascii?Q?p92vvf3IheZz93DHYZArXz+IrUu7eXCR8XytFvfaIN1f0h+Twy7Jl9bzyEj2?=
 =?us-ascii?Q?Ji/mNznXb/Fib3jNwzegD3KmLAksjtIHJvVl1t0dibO01iO0w17TbhXa+qSS?=
 =?us-ascii?Q?D7lBZLfu7Edtj/KWhd0k0RSCZsqIAA0t3uQUOGbC59/7VePlwDTfm9Nmy9js?=
 =?us-ascii?Q?gXzr9j+vyjdlRvFl4bmtXfK2SA0Sfbc1CotroO6sTgMJ6JLYQEmiW4GYE2ku?=
 =?us-ascii?Q?vs1/EWFZSyhGiCRdcNEXHPGOOrCms31gdWr+poFEeqlVDAKCCT7WMXzc+re3?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df5548-bc8a-4237-049e-08dd617d0b22
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:46:24.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s2oP9DAIxjc4nn6F6MOwGYAtsKQeOoU9XWbjtYaYYOUvhx7bVZL0w1xxgzovnVFFmqZebB1quysj6urs+2Q9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7260

On Sun, Mar 09, 2025 at 06:46:36AM -0400, Faizal Rahim wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> It appears that stmmac is not the only hardware which requires a
> software-driven verification state machine for the MAC Merge layer.
> 
> While on the one hand it's good to encourage hardware implementations,
> on the other hand it's quite difficult to tolerate multiple drivers
> implementing independently fairly non-trivial logic.
> 
> Extract the hardware-independent logic from stmmac into library code and
> put it in ethtool. Name the state structure "mmsv" for MAC Merge
> Software Verification. Let this expose an operations structure for
> executing the hardware stuff: sync hardware with the tx_active boolean
> (result of verification process), enable/disable the pMAC, send mPackets,
> notify library of external events (reception of mPackets), as well as
> link state changes.
> 
> Note that it is assumed that the external events are received in hardirq
> context. If they are not, it is probably a good idea to disable hardirqs
> when calling ethtool_mmsv_event_handle(), because the library does not
> do so.
> 
> Also, the MM software verification process has no business with the
> tx_min_frag_size, that is all the driver's to handle.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Tested-by: Furong Xu <0x1207@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>


Return-Path: <bpf+bounces-51462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11AA34DF0
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7ED7188F379
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1C245B06;
	Thu, 13 Feb 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCXmjGtI"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1528A2D4;
	Thu, 13 Feb 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472384; cv=fail; b=n29b8/nYkyCo/GTE6CBoe/t4FYa3KF2t6IUyzMQhUyKGHyMIn+3Z6I+4dlUUqFTWGycOPrZWBrlaPLxNm7tOxk3rG9EAmi+eIRSbkDL7H7iHVs9pa8JxrN6xExgccC+F3xLGQusbwdztfrB1kXvehaTlRy4A7qzf3xNYw5iG9bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472384; c=relaxed/simple;
	bh=40v4dsM6hqvHz6gwpkz8OYZiJTETPCkVw6dQcQ8nBeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gl0lbTs8uoNcjj9tQqeU0+HUkFjXfVodrbeZExqqZR6s/lT3p3UJZ2RYwSBB6/ZnDfthxytZomWSe1NkNveDzBa3VeUrueyhYkOKJbjdjSI5oigHLQENRBY0v5FcjLzklZcwHlLUjyIpOJjx3oj5PWD+I1lx66CGfCiRYaSRI2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VCXmjGtI; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYhto2lowkm/yD22gDXZjfI1r32pYX9hafFHLCzmqa56QP27VxO3xaMCb6juggkgl+eoWcnBMBSr1BednEX2qiydX2S6HsL04FM3ehAaarkHtXXtNDD4CogrqMzQAdoASO+WfpY+rqZrnYteiH9CSNu6NXJXPjyLuxVQ5CX9gVR2wsUwYxk+GbXD16wWJ6WyHvOnKQ6bUQW/zh6nFkxJEszuqAQJb0x8uWss3wxE9cyFJmB4OCDdO7lo87gjMSbeokAIvvw/NnJOe0LRCKadEpkiHqHpyieTjNSQ9B4f0eDDenP5pVMIuDWIo3+8WtpxpyU3UdX4VZFn6VcaL5iTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cbhEucmo2HU1X6kViLKNri9ALyHc/syeQVfcb47aOg=;
 b=XyNhOs+GW9OR3OSt8SOoAeqmDgFyRhW0aBx/qNU9jNwzSYYLoctLIuPHpsj0aCK9bIDJx3d3kuteQQRfgMVTvpaetWrBzUreXvB6sIKQKwDU15L8eNijAuwZzIhQCUzsryjui3SNubEulKlxhdTNhFElbZgsm9g2W4gYitOnS282izImGnr1T5TN0CjRZqoMfBH47Ne9GhltlUk3aReOKgeASAa9kW5fubyLg8DDUed4Rdrby9tRvAOzdwvTCkJXn50omaYZNsEWWXj0BgAGda+9r1h9lcIsbonId2KJslABPkvTo8w0UGOv1qhY+iPg+0P7uTx6Z6/EwnJo2SqwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cbhEucmo2HU1X6kViLKNri9ALyHc/syeQVfcb47aOg=;
 b=VCXmjGtIkaRmMgHTw2WDDK0qYkuYrvzTEe9QjSZk0pjshMJ0zu7bq5OZS5kRw2jWCF+JqRI+5S8gPt1eT4BHHlvbA8s9+g1HiCj9hfcyGEDj8kkYuEmpsC5zi1zi0ify4Odck9N1TG1NOGEZHpjT6fuvS5Lj887B02v1BHHvp9syFfsIji58IlO9hQcvxdwWLX2HhE/6oKQVyyCk5uEV3IGjcC9c2uF5OO/VjIqEZa75Rdx+0GpSXHBWc2GD4ZvyoHgbOW+5DA2hIkRlVoIOLtQZmFWoZ2eDg7Xv04rffMq/GfRvttjKsTVitZvNkBPo/hvXrGsrfY95sgZG92UszA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAWPR04MB10006.eurprd04.prod.outlook.com (2603:10a6:102:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 18:46:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:46:17 +0000
Date: Thu, 13 Feb 2025 20:46:13 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
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
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
Message-ID: <20250213184613.cqc2zhj2wkaf5hn7@skbuf>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
 <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
 <20250213130003.nxt2ev47a6ppqzrq@skbuf>
 <1c981aa1-e796-4c53-9853-3eae517f2f6d@linux.intel.com>
 <877c5undbg.fsf@kurt.kurt.home>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c5undbg.fsf@kurt.kurt.home>
X-ClientProxiedBy: VI1P189CA0032.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::45) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAWPR04MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a047e8a-06b9-4a90-3bef-08dd4c5eb34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmR0MmhzRDYydGJsSVNmaEUxQzFaeDExbDFYSGtZd0RXM1FveEN3cHhDWFBB?=
 =?utf-8?B?MTg2eCttcmY5Z0JkY2NocWxCY2x6ZXVxUE91OGt0ZUZuMVQ3aFpteGtFcHhL?=
 =?utf-8?B?Q1BadEttUkllRWVndVdiZkpPY0YxK0x1ZXpVeWk2RGV5eG9CeXlrMEppbWw2?=
 =?utf-8?B?UzFucnlkd3JnWkluc1QwOTZVOHBZOTBIVFZJWFdHUHdsZVA5U2Ryam5nV3Zo?=
 =?utf-8?B?ZXg1U2RwcjdJVUwwSUc0SjFpTitSYlpCN3EyVzltejNjdUtNRy94YjBqQXJ2?=
 =?utf-8?B?SXRWVXJqN1JtV3RPN2czQldBZ055bFBmd0pNTVBWcnhRaEpIVks3RDluNmZ4?=
 =?utf-8?B?aVErVnoyOVhabjFmdDJ4SkNQc0p3RWNTVXR2QXpLYkhMU0dIamVWNlJSVmdq?=
 =?utf-8?B?SExNSHd0NUIwd1BSWUJlQ2hWQWh3VFhGU2lGNGFxZ1RDWkIrNjczSnZjUnNn?=
 =?utf-8?B?WDRtZ2tQa3dXSGhRSFN6WVZ4WU82SW1GNC9ENngrbzF2bmhrZWVLR29GSmhm?=
 =?utf-8?B?TXpSZ3BQbUtRa1hpY3VaL0FSM2cxYUU3K2ZwS0tTakZFb0oySWlvNkl4TGVo?=
 =?utf-8?B?eTQzN3ZyOXJEQ0ovQXUwR3U4UTBIUzRLNnhOcitzOUtPOXh3bkpxZXN4K1Rk?=
 =?utf-8?B?S3lHLzdlYkVnZkt0ak9HUURpSGlTdCs0VVFkVlF6N0IrNkhOUEV0V2l1ampM?=
 =?utf-8?B?cCtyeXZkNnpxQnhGNmFDdzlUQVIzOFJsQkFVRlRKOG5peHkxanlsVnc5aG9p?=
 =?utf-8?B?VGk3c21BV1FlcUI2Y2k0dnRudFRubGozUU1JRVRqQnpDamJYbGVJU2dEanhT?=
 =?utf-8?B?bUNhV1RjZkFTVVBxRWcxQUF5dVBZVUUxK2hhUHB4R1NyREU4eHNjc3FRWjNq?=
 =?utf-8?B?N0F0NnlGOVJkQjQ3U3FTSTE5Y0VNMk1oVkxtWUJTajM5K1Y2YUJhd1lSUWRi?=
 =?utf-8?B?TXh4dys5OGtiVjBXb0owcmZjY3h2dnAzbzB4Y2ZZbTlJNnFId2lFWVlHcnNs?=
 =?utf-8?B?bTV0bnIrUERxdU9vSG5qZUgzNUpVNHMwNE0zQ1BhOHozcW41dWoxUWhqYTZU?=
 =?utf-8?B?a3lPVm9GVUtsZDFrQ2plRSt4eWlvN3FjazY3UGJsb3JsRm5IVExiOXpWblZ3?=
 =?utf-8?B?cHhwWktHVzZEdmdhME5pN24rRUhYUFZsWHJVajdSSSs0aFh3YzE1UElMMmdS?=
 =?utf-8?B?Yk9LVlU3VmxwOEUxNnBlRnFjMVlUSUFvZTdSOUVoK2tPdlh1eURiQTduUDFH?=
 =?utf-8?B?aGg4R3MvMHZRL3djWWt2SWtrbk5RcGF6U1RQZ1VTK3Nmb0F3dXhpQnZ1M2Rn?=
 =?utf-8?B?ZlBSRHFBL1c3ZDRlUmtRRVZKbzFNVE9ubHZ3RHBRWTF1ZDU5bFRueHhidGN0?=
 =?utf-8?B?Z2xxSnFpR1JURm9VMHFaUkNKdkoxcWx1MUVYRE1GM3ZUdk9xd05NdXozODNQ?=
 =?utf-8?B?NkZoVHJOem15Z0RmUzFLZURYaGd4Y253UVUxOTFtMWpsY1MvdkhocGpYQmhs?=
 =?utf-8?B?Ukp0ajIzUStzNWZIQUlydWpKUng5bDBQMC9mV2NBMk84aVFQd1J6ZVJxVnVW?=
 =?utf-8?B?VlhOSUh5WUcvMncvZ3hsbkp3cW56WTRxK0N6ekpWcGQ1b3Nubkt4WEJRa1JW?=
 =?utf-8?B?OGtUQ0NiL3VTQlpVaE1CMVF5ZGVsR20wWDM1eUl6UmNyR1NoNXdHMGdmN1JM?=
 =?utf-8?B?QjVsdDQ3bDcrdlNMbUlTVVdEOU9kNDhOQzlXcHN3K2k4Q2tpYWZoVmJ6YVha?=
 =?utf-8?B?SDFuWTd4N1Z5bFdodDlEaW5yVHJmVU8vdUYwbnBKOVhNK0xIeC81b2grZ1B0?=
 =?utf-8?B?a2JVN1g5SlRwZmRhTm5tdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2JMbGRveG4xZDFxWXZDZzRLcE5QbkIxSTRmYTdRL3l3NVM0eWRzN1ZFM3NL?=
 =?utf-8?B?NWVaT3RvU3FVV1Y5RjVYSjF0ZFdIOGE2N1E5NXA0L0dNT1ZybS8yUFQ1U0th?=
 =?utf-8?B?a3FLVUlEOGhjN3ExMytFNjJtWVJzODQ3aUhQVmptaXI0b2dnZ2dKODJRaUFz?=
 =?utf-8?B?TDdFb3hkQVB0UFFxWnJ4VUJXbTJnQy9lNFBWdldTU1ROcXg4enphbTlEMnZn?=
 =?utf-8?B?NmhaY2hDdFRZVkFwK2RtVE5QV1RNeVZnaURramR1SXo1TXJPdUJmKzJ4V3Ja?=
 =?utf-8?B?N284UFVyUCticlBPL2tXYUxrenRxa2tJenlVa041L1dJZWcxWGQwMjBtVk9P?=
 =?utf-8?B?VHJrOTRkaGdzYzNyUzhTOGYxazdnbzVDdWdma2YzNnlLaVFVSFUrNk1Ld3Mw?=
 =?utf-8?B?NHovNFlOTWxFeEo0Ny9rcmRXK0sxbkYrT3VyTmhtRTM3d3ZDOFpwVmFFVjk1?=
 =?utf-8?B?V21jL3hhNWRlaXV3ZDlVOVFobGRic1EyN3FMbHhnaEdjVzNiOFduZ0NnbGht?=
 =?utf-8?B?cVA1SVIvQUgyZmQ0L2dCVU5keER3Rk1JbFNEN1RUVExsSkZjRzRHajJ1M2o0?=
 =?utf-8?B?U3VucHpKNjR6RGFQclByMGFqSURPRkx3c1pmK1E2MktUN1IreXhiMnVaR0I1?=
 =?utf-8?B?YTNKRFBjOXVuREV2cDhEWVh3cnY4RjdFV21CNkptcFdLWlZLbllhR1RYMjQr?=
 =?utf-8?B?bURPTVB2aWVpNGhWMTFrRnUzVXV0VGg2ZkFrR1pWZ3F4NmU2TEZtcjIxVUVa?=
 =?utf-8?B?RmhnSVBYQ2lBZUVhRnZZL2VUcXVBY1dUOC8zY3FzSXI3WS9pNEpLajR6QTE4?=
 =?utf-8?B?ZGoxaUxKaW9NVzZNVWNxMEwwR09pWVdLSThXSWJlcHFWZThEYkNkRHFraFhx?=
 =?utf-8?B?YWpDZHZLbFJVNlNpckVNNFNENUg0Q2phMHB4UjZPeStqbk9GOWJkNXlRMU03?=
 =?utf-8?B?Z2JKaXk2TlZrYjI1Um54RWdIdmd0eFVTb0Y1MjQvblZwVnhtamduVCtFQlBG?=
 =?utf-8?B?YXhzOFUxZk4wa253VFZiWUI5QzhFVzA5YnlWQXd3R0dPSUJuSFlxWnpFalVn?=
 =?utf-8?B?Z1M3SVRSdHBuSkxqM2ZBaXllSFNUQVgzSlpCQVdnYWNqMUNqOHBnNWc0RWxJ?=
 =?utf-8?B?dW9oWmp5L2xaZHp5cUk1eFlVM3lua215WUtQNjJYQ3pRZThTZThqL0VKMGlo?=
 =?utf-8?B?UkRYWmhrQkNDVXU2Q0Y2VEVnbHJLWkVqQUo1Q0xjQWdmb3RpTHhxUHRGd0VB?=
 =?utf-8?B?VFoyNTNXMFBxR3lyZzZPbHZMVUl3b1lpWnZXQ1Q4SDVTUnV2TjNNMThUTTZa?=
 =?utf-8?B?WGtwVTB6OCswL1M5RWJ4WFV0VTEzMTJ6UDNycjRuc0Y2ZXJFSTFoaCs0dWhP?=
 =?utf-8?B?TGMzS0tFTjhScEV5NXZJdmlBNkV0RS9PSTdVQjRHc2JBeWEyajBiZExiT0Ru?=
 =?utf-8?B?dFFPVHpuUk1xWnBBVEtzMTJNcnlUTnNYTzFXaE9jQjVJRnFSYXdVVU5jM1pv?=
 =?utf-8?B?Qmc0MWs1THc5dWh4cisrS3lwQTI3OUdkTmxENllWL0M0M1M5ZlJ0L05oSnBI?=
 =?utf-8?B?c3BGRzFDbkcvM3NpdXVBYlU4ZktGcmFtZjNJZmhKaTFxVGplN21OTTUzZjEz?=
 =?utf-8?B?cEszYi9xSGtyeWtuVkN1ci9IWTZpQjNwc2Fsc3g1R1JPQWhEK1I1QXZVK2Nx?=
 =?utf-8?B?Vml3Ly9lVlNoZUtndDFVYndkdFhQcTJsL0J2b0orV2l2aWVGeU11aEI2K0J4?=
 =?utf-8?B?Y05iVTZPTTZmR0Y3ZG02MU5mbTZ0dXdkOVMycEZrSkZhdTBXTmxPNWNLK21V?=
 =?utf-8?B?bkRIdkZlS091SGdTc0lpZHBTQk9mSWdSL3hDcytpQW8wUTFoQ0NGOE1xd2p2?=
 =?utf-8?B?VkZNekttNWhXNWtRZ091b09KQkJlV2pCdnZEaE9vQXVpS1NTQ21jNXZ1UmQx?=
 =?utf-8?B?dnZCYUo1L29tQlRHaXo5OWJvN0JtUlFYdG95UUtaa3BRdHYwaGQ0UVdjeXk3?=
 =?utf-8?B?d292cDdWdU8zeW5Yb0NmTzFtWGpvVlFLdDhxM0FNdWd3SWJydk5ibXlIVXhr?=
 =?utf-8?B?RDZVbTB0b2NlaU1WQXhLb2gzODRsbFRYYk5kaWx4WjFGWjgzVFFmeEkzWGlB?=
 =?utf-8?B?bnl3Yy9mZXpGRC94U1VnUDBsUXdscXA1VWVLM1JXSmtvZzJVWXYvN1JvblJP?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a047e8a-06b9-4a90-3bef-08dd4c5eb34b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:46:17.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbmFxIidc7ZDlpRKiahnNIdES1bUL7xxqsg4qQHog5iDCwFJ7WxOlYKbNdUa7v/VU9ER9hcWUscKnJf1YVGfgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10006

On Thu, Feb 13, 2025 at 03:12:35PM +0100, Kurt Kanzenbach wrote:
> On Thu Feb 13 2025, Abdul Rahim, Faizal wrote:
> > On 13/2/2025 9:00 pm, Vladimir Oltean wrote:
> >> On Thu, Feb 13, 2025 at 08:54:18PM +0800, Abdul Rahim, Faizal wrote:
> >>>> Well, my idea was to move the current mqprio offload implementation from
> >>>> legacy TSN Tx mode to the normal TSN Tx mode. Then, taprio and mqprio
> >>>> can share the same code (with or without fpe). I have a draft patch
> >>>> ready for that. What do you think about it?
> >>>
> >>> Hi Kurt,
> >>>
> >>> I’m okay with including it in this series and testing fpe + mqprio, but I’m
> >>> not sure if others might be concerned about adding different functional
> >>> changes in this fpe series.
> >>>
> >>> Hi Vladimir,
> >>> Any thoughts on this ?
> >> 
> >> Well, what do you think of my split proposal from here, essentially
> >> drawing the line for the first patch set at just ethtool mm?
> >> https://lore.kernel.org/netdev/20250213110653.iqy5magn27jyfnwh@skbuf/
> >> 
> >
> > Honestly, after reconsidering, I’d prefer to keep the current series as is 
> > (without Kurt’s patch), assuming you’re okay with enabling mqprio + fpe 
> > later rather than at the same time as taprio + fpe. There likely won’t be 
> > any additional work needed for mqprio + fpe after Kurt’s patch is accepted, 
> > since it will mostly reuse the taprio code flow.
> 
> I think so. After switching the Tx mode mqprio will basically be a
> special case of taprio with a dummy Qbv schedule. Also the driver
> currently rejects mqprio with hardware offloading and preemptible_tcs
> set. So, I do not see any issues in merging your fpe series first. I can
> handle the mqprio part afterwards.
> 
> Thanks,
> Kurt

Currently, igc sets tc_taprio_caps :: broken_mqprio = true, meaning that
higher scheduling priority is given to smaller TXQ indices. This is a
special case, as normally speaking, higher scheduler priority is given
to higher traffic classes, both in mqprio and in normal taprio (see
taprio_dequeue_txq_priority() vs taprio_dequeue_tc_priority()).

In commit 9f3297511dae ("igc: Add MQPRIO offload support") you document
the intended mqprio usage pattern:

tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
   queues 1@0 1@1 1@2 1@3 \
   hw 1

Applying the transformations described in
https://man7.org/linux/man-pages/man8/tc-mqprio.8.html, it looks like this:

        ┌────┬────┬───────┐
        │Prio│ tc │ queue │
        ├────┼────┼───────┤
        │  0 │  0 │     0 │
        │  1 │  0 │     0 │
        │  2 │  0 │     0 │
        │  3 │  0 │     0 │
        │  4 │  0 │     0 │
        │  5 │  1 │     1 │
        │  6 │  2 │     2 │
        │  7 │  3 │     3 │
        │  8 │  0 │     0 │
        │  9 │  0 │     0 │
        │ 10 │  0 │     0 │
        │ 11 │  0 │     0 │
        │ 12 │  0 │     0 │
        │ 13 │  0 │     0 │
        │ 14 │  0 │     0 │
        │ 15 │  0 │     0 │
        └────┴────┴───────┘

In this model, prio 7 goes to TXQ 3, and since I assume prio 7 is a high
priority, it makes me think TXQ 3 is the highest priority queue (I don't
have a lot of spare time to search for i216 documentation and enlighten
myself).

Then we have Faizal's example from patch 7/9:
https://lore.kernel.org/netdev/20250210070207.2615418-8-faizal.abdul.rahim@linux.intel.com/

a) 1:1 TC-to-Queue Mapping
   $ sudo tc qdisc replace dev enp1s0 parent root handle 100 \
     taprio num_tc 4 map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
     queues 1@0 1@1 1@2 1@3 base-time 0 sched-entry S F 100000 \
     fp E E P P

b) Non-1:1 TC-to-Queue Mapping
   $ sudo tc qdisc replace  dev enp1s0 parent root handle 100 \
     taprio num_tc 3 map 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 2
     queues 2@0 1@2 1@3
     fp E E P

        ┌────┬────┬───────┐  ┌────┬────┬────────┐
        │Prio│ tc │ queue │  │Prio│ tc │  queue │
        ├────┼────┼───────┤  ├────┼────┼────────┤
        │  0 │  3 │     3 │  │  0 │  2 │      3 │
        │  1 │  2 │     2 │  │  1 │  1 │      2 │
        │  2 │  1 │     1 │  │  2 │  0 │ 0 or 1 │
        │  3 │  0 │     0 │  │  3 │  2 │      3 │
        │  4 │  3 │     3 │  │  4 │  2 │      3 │
        │  5 │  3 │     3 │  │  5 │  2 │      3 │
        │  6 │  3 │     3 │  │  6 │  2 │      3 │
        │  7 │  3 │     3 │  │  7 │  2 │      3 │
        │  8 │  3 │     3 │  │  8 │  2 │      3 │
        │  9 │  3 │     3 │  │  9 │  2 │      3 │
        │ 10 │  3 │     3 │  │ 10 │  2 │      3 │
        │ 11 │  3 │     3 │  │ 11 │  2 │      3 │
        │ 12 │  3 │     3 │  │ 12 │  2 │      3 │
        │ 13 │  3 │     3 │  │ 13 │  2 │      3 │
        │ 14 │  3 │     3 │  │ 14 │  2 │      3 │
        │ 15 │  3 │     3 │  │ 15 │  2 │      3 │
        └────┴────┴───────┘  └────┴────┴────────┘
              case a               case b

In these cases, Faizal leaves us a hint that the preemptible traffic
classes are the ones with the lower scheduling priority (TC2 and TC3 in
case a, TC2 in case b). Here, the lower scheduling priority traffic
classes are mapped to the higher numbered TX queues, which basically
matches the broken_mqprio description.

So, confusingly to me, it seems like one operating mode is fundamentally
different from the other, and something will have to change if both will
be made to behave the same. What will change? You say mqprio will behave
like taprio, but I think if anything, mqprio is the one which does the
right thing, in igc_tsn_tx_arb(), and taprio seems to use the default Tx
arbitration scheme? I don't think I'm on the same page as you guys,
because to me, it is just odd that the P traffic classes would be the
first ones with mqprio, but the last ones with taprio.


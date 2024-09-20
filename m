Return-Path: <bpf+bounces-40135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583B97D6D5
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8119F1C22D22
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144CF17A583;
	Fri, 20 Sep 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y08hE+Eo"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3681E521;
	Fri, 20 Sep 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842320; cv=fail; b=jZ4SzlbjAn2dEnikqYFGmyBexem+PzSLtWTi8prkLwFZV5E1idYDv6PL0da68QWNLRVzqGAPtG9B1gES46mdnuTjTPLFVNUhnzO7L9Qw2UTaUc5wl1At6eftTLjDexquF8fSvO79s/uo1WSinta6aIaIZ65YJBTqSLiTsZQR5HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842320; c=relaxed/simple;
	bh=sxBqhhFwWqSTKoVi/Qajx7QY5MpQccQhM4MOT5LxV7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fdy3vrjEROxOR4HHcXzmQVBK2W6o5sbX34O6YEljIN5ahJxCpTVbzlCFIj2e70OqVmKzC6Nr8CzK3+8+MngNZR0agKUiSSCDBFJh0niogD98pYew4m9BJDr8jl1wVIX0p8KtVxAvxUgeQsOmbqBxne+1+rsqN1hEBb5qJnz71JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y08hE+Eo; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuXXEXmSf5LHzty8Y08HPO2Jezx3imxyb+TWIyliWVDdH9ZgosZYfY7/3cwgkbKn9tP3DpqhJvv93YMD/5YoOLFTb9HuStox6JwtZDxk4nc+TqCNs7jhxbj009bOtvWoZimDVeHY8V0jOAYDx0c3o1zwXTXFElR7zY5Llw13eBgNir5ld1dmayCqhqSVP5GHuhPz/IMgwjveQB6AqMOBYGDzW147JNU2dfFOm9pUB4ptbHp5AWxZk7G8UGEAoHc4u9BL1l8iKyMvvxEAQF7+dvPHhZSZDC6zvSkWirPf76Ck+aQwDYrpceCbKnfDmQgbwBrqL3Vv10XyfgrU32pbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy5Wqn1iLnWsj9Zb9UnTWx9w/dwvyDGlmBEQmoSXoVY=;
 b=TLGu26ZHbTdk6tfaPtGIIV+NhgCXwrvzK51NTWaG19yUl94B2cV+lCH+oHX4tWNfaN8KwMxkneidnEjFy4cQ/7zTVSTuzPNVJdlDlBfPlCYiuhNjy8a0TteNaRg8qMsyldQgOO+Ct4qJOk0ofOgiS08g8IekFyLoxxiuDEX2vQmLtsrrDaxVbZhfBHz4wPI+7AwZjOCBUuC5T4PF6qJVI+RU74qmFxxUdRNT0dmiZMucODbG+5K8MRzts3CxS0nAUj2Oc35CDe1tWOjYjJTFXbkayykm2Ujy/F6wQA8x8vk4CkHVvVWkQQtAurZ6uDEUAHr0raIlXKbiPiKKgFyuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy5Wqn1iLnWsj9Zb9UnTWx9w/dwvyDGlmBEQmoSXoVY=;
 b=Y08hE+EoTkXUAjhkFaRGjbpr8fJypL7Y3HnBPh5VoJGf+BXbK5s8I0MNFxyE2FMH+OKDxyQwT8b36TvQq7ycyVftUR/wi3imj6hppoqLXaJPElw7+10yob4vuKrQPIGS4WPPsz79thBI1gsRB0+qEg+4oR3FoVrYManK4VoPQIdEcKg2oUhwr2Ot/KNIqpkRooFDot5pYakq5z5xLKqYLzbOSuQ1vS16fSfc09Djc1HGcKPGjR5zNIq9pJavUlAKZBrk63zFxihHVTHz21NWB4XJ8cnKhX1HEjlwyKpc9FkKzhdDjUiDDGDS4Om6gdmMLBd14Ps4oo3HDeemPWEM/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 14:25:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 14:25:15 +0000
Date: Fri, 20 Sep 2024 17:25:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <20240920142511.aph5wpmiczcsxfgr@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
 <Zu1y8DNQWdYI38VA@boxer>
 <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: e777a24a-b7f5-477c-5496-08dcd9800b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQIB6F+qtk0Ln+nakjYdH8hqAiJarYIlD6IMmsNhfu8BLWLwGmduxjfEbzYG?=
 =?us-ascii?Q?j+wd+07IT4kYhnWjIiYb7AqDkdK7yZegTeKQ9cYvtMnfUPqcpEI/wPKiW6D4?=
 =?us-ascii?Q?svvtS5Cp2+sNTGnq2qAOcSUAKQjFO/81dSMMzNesJ+L2fLUkb8k6PKFantik?=
 =?us-ascii?Q?Q//OwBTgpI4Mohq40pgsbI4PviRmdGccVmrcJd5IHQn9tD2MdzX7aN4ygU7t?=
 =?us-ascii?Q?DZJ85Md+xOVuNXFjz6GEPDHmUjUmMQKOpqGryDTB6I7qtCefeUsHgnHkriQY?=
 =?us-ascii?Q?MCCG9Z11X7DjpmzZ6gXBBhoKQlr1oQH0hi4P6hpABG678I0XLB38rRUvbh5d?=
 =?us-ascii?Q?sWvy67ls0MKSezL811nP6BQS2lUZJKx09/FbL0tCc6kHLBaQwWuUPGSsLKAd?=
 =?us-ascii?Q?G7ep/aQTJjGIafBYo2/nqdwzL30M22ObG9Y2meGt/QnouW9ptIiV58YstvH2?=
 =?us-ascii?Q?dnU+Tey7rVJGAKtcGxsWSQabvX6k82VDV4NaH9and9lrkZ7UhAH5CFSuCnOf?=
 =?us-ascii?Q?fguL4fdyuqloEnwKpAHtMHxtL+oigHiBXIKiIdVW6J/9WCrmWwayLAHkVYIK?=
 =?us-ascii?Q?oevacot/LX93TaZ2hdz50g0YA6ZLSqT7Ofsex/PxsqXWMK2I9iwVQmrqes4g?=
 =?us-ascii?Q?d/Y6CbrKEcsd9Yj74YU6wnUvlp/cRqk89kOE9vX7ej42VPrd9/JWXV33nbBp?=
 =?us-ascii?Q?y0ZsIU6MsVGfFDjRXLeHoM8pxCwHhpDLWySdL2Ax/nCBQH3dUUFuc40bdqTX?=
 =?us-ascii?Q?cCOBbV+LIDFbPUjRchP5iTO8TitWJzOtiJSyckJIM4PH5RXkNJx6Ty/d/zR5?=
 =?us-ascii?Q?nB5fUEYEPsv1I6y+UsAFqw8axmYg/0Njp6TPeQ8eymD6uRDbeYdtmjhQ3Q5I?=
 =?us-ascii?Q?XbPeNXQQW0qLngmGdtBtlFn9crgpbEHaufsuWNH7qlUhES/YBjfIc5HqYM58?=
 =?us-ascii?Q?2BDRuixGPeYxnnb9K5jFovqIt0eLqp+X4jlOgymoo81DjI/pc5jW/oA8bvNm?=
 =?us-ascii?Q?m8AZzNx3/ne8TcIrb5gfPKLiyW0/kDkYctwb8vSVrnMfuk8MS5j8HIUZ981k?=
 =?us-ascii?Q?sobS+4CkKRVhjGtSZGlS1n7Oj4qwjcT0/eEDa0A4mLO3vXo3ZWQadGX6vOy8?=
 =?us-ascii?Q?Nkmz9t89Bj9NNrXHOqgA/O1FwT+Xit0UiKszXoSTROkltQw085Xvma7J5l1U?=
 =?us-ascii?Q?s5AzsfDQ44ZZNUJQq3OA+RQZdmSj/be5w5vWLThvqqjCqA0BBhiWDUuUgfhv?=
 =?us-ascii?Q?WMwyqiYXApTDXAm7/61kImC6tfL3a/Dai+qBdapavQl1UYcDknR2bjGNoO7J?=
 =?us-ascii?Q?ZkhMqUaKxzZ7ka49IFyyaGUIlpJeqD2TFwm46XaZUBP6+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7Owzn9srrMDWruclAmQ8d9ycsBKfX3BWZplZvgDqpABFPNuIeDH6c9hZ7Zs?=
 =?us-ascii?Q?aUvhgutJE7DdI6Be52f2BITpPQXwF/U5rYUE0unYkh7t4F2/TLXfEfL9c1uh?=
 =?us-ascii?Q?7Uu9BtG4zQel0b5b4Ujd01A64jyEQ6GmGGgwurCKFq+wyD8xu1pdMakVb1zN?=
 =?us-ascii?Q?1W2zXN7vC7kHPn9gRn55iMxXwdfud+iME0DafC54+Y5B3aqXCmCrCpzFHryp?=
 =?us-ascii?Q?r6KpHoYfUTbO3RAaBurhrOggUw9tD6vfaeo6t4UChvHmGZIatzBIlflVxlcc?=
 =?us-ascii?Q?jApKHZY2Jfesu/KfCcWbOMRDQqEZfBV0buSINi8vNMDiZUraJO03PimzCJy+?=
 =?us-ascii?Q?JVmVbYd4KWTxbk45npG3kA9nlr0GOtLVgXwAhpEAIkw2ru7pJjlk6iWSYzWw?=
 =?us-ascii?Q?uuB9K6hLkXztP+odHbf9n5XUveoOr9v/5d5EH8YhmL3wL5j2+yBMWiJ4BVof?=
 =?us-ascii?Q?GL1jRW0TGJPN0uM5L+ceMGvkThEx7ZVHmlcwlXBB+7l/wzWP3l99Nb7vpnsp?=
 =?us-ascii?Q?duJYUw7hQGnqkojC0ba5PVObQ6F5VOA/UM5/aHl+Y6YxoLLVO2OfO0GkbuMT?=
 =?us-ascii?Q?WFU0PQhcfqGPO1eRclMzRpWr5tcdjN3LmWU31Utg2nbHER8+Yc6Me3iQGGpX?=
 =?us-ascii?Q?IxB9fkMbVgYkdjRbPOiceni/ZyXh04m+c4WMU6TKHLi8wv2KYqyA906E35bu?=
 =?us-ascii?Q?eBtBpP2rlU3zVLrDKzYVfntxwisIt7xpdn3W2h0qstpcLWQZLITFfcLaTO4C?=
 =?us-ascii?Q?eHDFie1a1wrL3ryO5mUU7t6tGVh+AHRXzmV2hrVcItZ/9RDhuqP8XRaWXwVs?=
 =?us-ascii?Q?nT3hoCfa9vwIX97mh5/Q1jQbawhIkroLUSaa7legEVRqB0ZHlEXapFAds9W0?=
 =?us-ascii?Q?VYisbYET+77fJrETmWA2hMV93k3F8J9m6HmDJmAO9BruqcWaJkvRJBJ4wtDa?=
 =?us-ascii?Q?u1stP9pIQqadb97yzHKXDiGiZ11VVUeOF2oRsoqqKutYvLyfshdG6LpmRAy2?=
 =?us-ascii?Q?PkI2Z+hkKs10jZXcaGT4gXplUAE6zoPPcsQstxy7wFxQikKiJg1bLiaLRTpA?=
 =?us-ascii?Q?pxScMIRj+wSORPV1qeDy0I91IdO3lTCjcf1PjjoHjvviLP90c6nlq8azbQsK?=
 =?us-ascii?Q?e/6ZpDlHNxjcVzZ21wcj9IMTmIeQOTp0iaXhkQNDSTMr88zZPgC6NoLWMDiX?=
 =?us-ascii?Q?4vsfdS8qnH1K72NuibFa9wtF7uvUeDa1/Ayp6sKK4tVPhCPfdoRNx0dGCBHM?=
 =?us-ascii?Q?lu25/X7MvGXaM8gvIBNGg5HXSO4oBexYeWN3msy1xGSTle9uWtgDCBruvJcB?=
 =?us-ascii?Q?UqaCigwnIFtia9bMP3U+G92GE5liFBbulqq1ub4t9KVNs97ewDOZRIgXV6J/?=
 =?us-ascii?Q?dZQeUZWC4wZpJpkmNTfcRIyP7nOYEadclpfcMR7i7Km7gzeX5Y81cEfycBb9?=
 =?us-ascii?Q?bwu9HnDb9SfhXE9OkVg51uABkcjStB96O+lxIZPfIyU/H0QeL8L1P3bjCUje?=
 =?us-ascii?Q?Rr1Vek4CAdROEQq7F6TqbYeosyWzSkBNPPacN7rQxUUP0w+2clanHMWHDG/f?=
 =?us-ascii?Q?oDQvwjonhqLDgOj9Ir243P7z8TItPkIsWSt5tdi0ua/Z14BS3QVNwbJe1oha?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e777a24a-b7f5-477c-5496-08dcd9800b20
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 14:25:15.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ova1rxVnF68gQkgypHF0edEfnpvzovM2W7slXzu25xfpVl7+pnSat8itt+qJEOh2msoj9LZec7/wz8pXPiNnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

On Fri, Sep 20, 2024 at 05:05:14PM +0300, Wei Fang wrote:
> > zero init is good but shouldn't you be draining these buffers when removing
> > XDP resources at least? what happens with DMA mappings that are related to
> > these cached buffers?
> > 
> 
> All the buffers will be freed and DMA will be unmapped when XDP program is
> installed.

There is still a problem with the patch you proposed here, which is that
enetc_reconfigure() has one more call site, from enetc_hwtstamp_set().
If enetc_free_rxtx_rings() is the one that gets rid of the stale
buffers, it should also be the one that resets xdp_tx_in_flight,
otherwise you will still leave the problem unsolved where XDP_TX can be
interrupted by a change in hwtstamping state, and the software "in flight"
counter gets out of sync with the ring state.

Also, I suspect that the blamed commit is wrong. Also the normal netdev
close path should be susceptible to this issue, not just enetc_reconfigure().
Maybe something like ff58fda09096 ("net: enetc: prioritize ability to go
down over packet processing"). That's when we started rushing the NAPI
poll routing to finish. I don't think it was possible, before that, to
close the netdev while there were XDP_TX frames pending to be recycled.

> I am thinking that another solution may be better, which is mentioned
> in another thread replying to Vladimir, so that xdp_tx_in_flight will naturally drop
> to 0, and the TX-related statistics will be more accurate.

Please give me some more time to analyze the flow after just your patch 2/3.
I have a draft reply, but I would still like to test some things.


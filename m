Return-Path: <bpf+bounces-78731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E21D1A092
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 018A3303364B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D034405F;
	Tue, 13 Jan 2026 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nz82Fsru"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738C32C305;
	Tue, 13 Jan 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319773; cv=fail; b=WCXU8Bo/OO3EgIGuWx2xhVyOF6lvemO9mFrjTXovbgaCAWW7OHBOhiVKHfb65ctMangfuR18Iju3Zl4yajJ5IDVLvVdHO3moh9DpDxGR7c99Y7O42p3dSBiqINGNu//06E3ij81hnXkyYHqci04f6S6z9GCNCDZzVHoPPwBo6ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319773; c=relaxed/simple;
	bh=huP+J43gZxXwrod0tVxcLQtHI6NFWatFMRtWlY00+WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T0fYjfcXxuE+/z7Kqq2E9crS1pkvS4K/z7kxgSRnt1g9/jJsv51ukT7D7dULERISGZQbtBMsk2F18nrG9Ci1C1cGAXPkVtOUAoeyfS8YewQfSAB+I3M5PwplR8s6heqRvzrPB9nhg0a6PQe8dUagCH1cAzPZaCvFOJ7b5wxfM3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nz82Fsru; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9/V1TQ1K2dbuaPSUx2KbKWkSHHwrRawlgJuMX3avaxmzysTPZU9dtl2BDshbL41vrUUV5SCQUMh8Z/1/Qz3Ee1OUW55RLtWbTyre2giPqjbsl5o9PeoL4FCFQNL4fTjq64jIo8bMGi8yaUtmhEuFfi7JfrpL4ENAx/YBGc7zVFkq5f4JbEda2ST6lVD0h429ygKOZpHNdj+enMxL3WQjbcIOCD+XXEGYeu2cq+jaowUMqZJELfhXFyNShXPLlUGnNwI/nmYGNDATyBYqCTX07YndGi11EEVtYt/LL1AObFd84d6rN1Nkf6YkRGyHFy5iGbKeJkCruBw3agTL0WeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoawCt4Z1FV0G7KqaZeEQLj0/qaUpaz+EcdtcRy6fGw=;
 b=OW6IpWOyVcnwaGrVAwd3y3g9fe8Cyo0lQBGR2GV/2wq58XxXT9uDB2A3OsgKo6Xb/uY8hYEZU7OsmH1e9XJNP3rZ00hIyMD8O6JgFuuhrlC1w+SwUhWVnkCE+gCX1OWTmPLp2M0Afdqk/Tmhr1TY+M8D5rU/cSufAiw6Sp60Bum5GtnXdiszlT/HWh8yKaiN8VI8IrcKDng7hognBLD0Hy8pMorOipkc1TNa3mbUI8B0mrVFEMfZjxuWSreGMYc98564lVIzqoRTerKj6fSdMnVlUkXpPu34S6XE86iV9n9664BqwB0yHCXElyQpntUzDlCgzUmImwKGEiLRUnIORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoawCt4Z1FV0G7KqaZeEQLj0/qaUpaz+EcdtcRy6fGw=;
 b=Nz82FsruSJQbNgcadjH6JqgvwswH+7z4yYpa58k7n6L6BQOI8kVY3O3eXrHU0brZIyywaj+uHJU+DJrzGROpW7t5tEzD90iHKF9cnApIbJjuec+PKkKmnSOPJJzAWbUAIohqqayKJ+mGueDQ+vH/AByyVObA7InCQcsSS/hXavNFD9B9548W3bEo6Gr0az9IQQLhjlZ2dpSiBYY+nxCCB8qPdLh/5YyQp2LfrMljR0qWJwkQQAVWMaoSQVlqg5c50MLRXuUVwbY3Kgz7PIgm0Hzi9H9SIamSUfb53rmtsjrQ32WWwyNaJ3zTJ/rTCOlclssJTuPNdzsPRO3CcBTliA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DU4PR04MB11411.eurprd04.prod.outlook.com (2603:10a6:10:5ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:56:09 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 15:56:09 +0000
Date: Tue, 13 Jan 2026 10:56:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] net: fec: add rx_shift to indicate the
 extra bytes padded in front of RX frame
Message-ID: <aWZrECQIy+a8yEcJ@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-4-wei.fang@nxp.com>
X-ClientProxiedBy: PH1PEPF0001330B.namprd07.prod.outlook.com
 (2603:10b6:518:1::1a) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DU4PR04MB11411:EE_
X-MS-Office365-Filtering-Correlation-Id: d19e4a9e-06e1-4cb2-01a4-08de52bc4470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h4OW30a8p8gBYKpqDHA8RQXgzmyuK7gEQcyw0izR/ysll40+aMDjhApuVKYo?=
 =?us-ascii?Q?S7qnA7SPMu76US+UDUVsMhcS/nuopSSa/kB5bOmAZ0gns42wGwiYB6l5MGri?=
 =?us-ascii?Q?353V76V7Qu0y7jYWtCaYj+jSppRLQ4HZqrDhR3iEq/Okx8dCSrgQ1/rkB1iM?=
 =?us-ascii?Q?khA67LuZcawVD9w/nw4TpqJXtXYoFb/HZxD9jbCIe1eKPJQS9mcJpOBpe9oo?=
 =?us-ascii?Q?a3stpA7lJ5NuSAA2YZgvvOt5YDfEgOfVk9nbqYQVXzku79X+AhqFETdVnvVm?=
 =?us-ascii?Q?v6w9eCTGbsWD95c+rA2e0VELYZwWZMSEdVn79sRuoEq7Vc0Y5PCjxbBAMLsI?=
 =?us-ascii?Q?QrJwBPi643fdjPAuSpEuRZtB11XRp1AaIrV6nsEYXHg31hhnzlO8R4QI6PAV?=
 =?us-ascii?Q?3T2aBv25a7LT9g45s2dDYZjqAZNFY3hD92+fBC7p26Rx+t+EhfCxErHXB01L?=
 =?us-ascii?Q?vwdWmH5WV0PCood+BI0RYyLw9wpfKNOK3mEh5XrsMuXAH63K8K8Krnei8DwU?=
 =?us-ascii?Q?cV5aeRb6Sgs/EINhjv7/TEkN0KR9plCZtJlWxcgreu7Q9nTN+8ja2sCQ7bM4?=
 =?us-ascii?Q?hAF+ORlAXwhpOEyVF2tF3dJNl2B2Ful83gZnpr3hvOyINqS+zYjKffmC4vjn?=
 =?us-ascii?Q?15QXzDCTWMV9mW7O3uBeG+D+gkT8paOL29hnCtPQq65zF5O51fqkybwg0ICA?=
 =?us-ascii?Q?oO5dltljAQCfHeGDH0cyzHJxUNlL4ZMSIRwrycBlFDrQ0j4TGAzaKMKErrE8?=
 =?us-ascii?Q?sfg4fwzingwY7KSTdCKSIO3q2/yigK2jDlnY4vuOcuRq2jBtl2esH9cquRnF?=
 =?us-ascii?Q?KemXsKFMEGoVN3G8NvW59ncQ7NpDRvqkCQb/2q088jqOVCHWWXM313Fk1BAU?=
 =?us-ascii?Q?uPipwasZOagVPxbzhxEcx/E3YrYpXvBEpCMi4n8xOgNyBA+bVYH8zyXJNgZ1?=
 =?us-ascii?Q?8pIU3N0qMJAxv/lW7K7RTK8SVVUeS1J/cM2RA9qgavLUbjbglBfYUpbBgf7o?=
 =?us-ascii?Q?jpK6ANF6/lmhyywnTtBrixmmaoDEg52oPRWrQOHbZglGjh0N+GzDpoXOa/Wj?=
 =?us-ascii?Q?HhzheLlBHJicb3L5IrFgY3D+y/RWbfIbfKsedFczczshEEni1dzFIv/gCNZg?=
 =?us-ascii?Q?Jiz5y/uWzJSmJbh2JdTsYUiPtDxXUderWBn8rQ3UWCGrx7d6jT6O5S+uk48Y?=
 =?us-ascii?Q?kgZZwOfB7+TH4RYkCbdCKB6j85IfYw1TIKV4Oaaa4HY4tRZd4YjbMtA331S0?=
 =?us-ascii?Q?F9T0Xyk902YJ7z0yoJXlR+WWng7WD+DQozVMMucwWWeY5sIyuH1mDBFOuc6a?=
 =?us-ascii?Q?64OCsbvwb2WoR0hy5KZMbX2yaqQNUO6aEo8GZ7/r1nVngjJyIZSq2iTg4wV3?=
 =?us-ascii?Q?Qtw0dAjLK9kPLTvU3QgvlIsMbl/b7K9TIMxfeHDKY/oQRrnj05aEu5IqkSaP?=
 =?us-ascii?Q?rSpj5S4e778YmxNNQfbEdvjc0viy8ZYI/bTA3dUH/OZP/YgAaJsmJGh8wSOm?=
 =?us-ascii?Q?h1RaviHbgvTCB6bGqlOKApVy1NnLTy3X/3DQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fo6EPIvPX4Bllikjea5kNGjIaBrMbXH2AgbsbM2PSTZ3aq7iE8/+CL+6zk4f?=
 =?us-ascii?Q?8P7MI/CfAcHAS3tdIMVSSwMfGXD3ldqKdOr03DE059pwKYf55bjYYu7giDQp?=
 =?us-ascii?Q?Mqp1THp9zMrBaBkX59NsTUE6wiQgCPcyJY6B3qDItvEkCVMuh1IU7N3fGHLj?=
 =?us-ascii?Q?dUO9XSeTL9HqsBbDU6pjOLBC9HFVLMxSkQXCtORRGKj3IWYEDfP6f6PdwB+s?=
 =?us-ascii?Q?CfOyW+6yhinrpmxIv4KYsv/9WQ9pzF6Xdknj3AHGgl6r3/LALNpnfjFHPGUk?=
 =?us-ascii?Q?uZZu9MkcqmUsxmjXAKKQ0m/AK+pM5STNPNjWv+Ck/W1KwC3M5h0bvpLELiQA?=
 =?us-ascii?Q?T0XQWjgaUHAJIvzvVazhW2lV5aHUxSS8R61QfRvo4w6rd6apfUSztD/sSxIn?=
 =?us-ascii?Q?axpe6eHn2Zw40gWblUvxsyv9CQ5VhAXkqrBgMaQSzqHZWr21nbJqajkj5Na+?=
 =?us-ascii?Q?7kBaAaspN6lKKUwVWyWdAe+H3Pubqqq9ObGm5Yg+QZEdyhOYMBCittebJ5lV?=
 =?us-ascii?Q?vKEUf6lfmCNsLOyB5JsrgFXkf/cg+0H2lSFnPDvq+9yxOzmjOzg24NchhvII?=
 =?us-ascii?Q?i5GC9O3ELL11FKEEFV9NPO1AJrok0NC/m8YpkOqJf5FY7OO+rlUWscW7Mjzf?=
 =?us-ascii?Q?ArpMf7POii0DbmW5euasaDeaHOHbsndzL9lWwBrKJtwj3uWzDcqyOq85761a?=
 =?us-ascii?Q?t5kH0gAUB1ra9p5pODgDhBWtaaWIqtarOSXtmVa510NDIz5EV+JaQMQB+uaz?=
 =?us-ascii?Q?We5932jJQf6G8KRcaeY+G04eVKqsOgIMcrXLVVGNQUALjfARHnkszDYGlLVE?=
 =?us-ascii?Q?rj9SqJBn4AOfkfSs4a8CKz1rMTW+Fq64gJpnH2nNZHa4U726faVNRNYhMMma?=
 =?us-ascii?Q?N+o8m5a6qZhrLt+ovjO1TQzKVO6K2XuxgOacLznH4YyLT41EzAif3dT5MUVB?=
 =?us-ascii?Q?T77lI8b9/7QwEWKxNhr+DAC8S/1fHiV9lBo9xqljafyHhRqdmaEYrfjvxG+0?=
 =?us-ascii?Q?s+PtBqpuOIiQjLh3jptj0X1ptVqvH0b3SNX8EG4TuETLtxHF4Q0ET3PgQF3i?=
 =?us-ascii?Q?fce9yXHmMwqZHxbyOdG6GQh6TW7oLbJ9L32sTxZFLAtAZXlp78Dgy6LCQqAz?=
 =?us-ascii?Q?fxc/11ylEVVCccpbw6cWvTetlG/YDf9dpYHwqBtjyj+E6uteAyOe/p9a+KL7?=
 =?us-ascii?Q?ncuqymefycokn+03wGG+8m5HIok+e1Yg3jIckM25V6LURGtK7rT6bdk7JR+I?=
 =?us-ascii?Q?tcjfyY9jLUJ5dBK9ZVSQbNf58wKF5vdR2AbKrdE1aW9haD1xOM6qeu7ReYQC?=
 =?us-ascii?Q?g44F40Nk7WPbOC6PQj3ZMOUrMwu58wYUx805HsssEEK3VLN4v+SUg6Oi2xcP?=
 =?us-ascii?Q?l9gjO7/5wETU9DkMOHH1fJduBH70LCswJN7FRodB4Q3q2unZWw2rFYynUrmP?=
 =?us-ascii?Q?DfKoCsRnX1WSTXwlV7hb1P4MIR05N317BGxu56zEzwyF9bHYkLFkRLiERltF?=
 =?us-ascii?Q?0SxmWCgetZE8DwNh6v6tjJHY/c77zJMhi9QiVhEvpx19yuWBK7tcwl5YLrfG?=
 =?us-ascii?Q?uQwMa0MvKaSy6vec2DIoYGPgQeynABQiZLfKA4FB+E9mhU4nAjDTiEqkUTvD?=
 =?us-ascii?Q?9zV4qgbcOz7FUuI9E7A/63IJOpddRf5E89cHxic00fO5XBYUddMobdeG6OB8?=
 =?us-ascii?Q?WDjR+SzbXM1PQloCVCueUMIr+rTb2SX3XjLBp4ZxKn5iXiQxIq//UWyEJoqB?=
 =?us-ascii?Q?xKUUkS2xdw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19e4a9e-06e1-4cb2-01a4-08de52bc4470
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:56:09.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN9aUsuVGpUaKFz5CbWNqLRfoasIOm47fdo2p/BfSliBrL673IbLR3FfnwJWPWbnULTT5P5OWbK/+BFcfssWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11411

On Tue, Jan 13, 2026 at 11:29:31AM +0800, Wei Fang wrote:
> The FEC of some platforms supports RX FIFO shift-16, it means the actual
> frame data starts at bit 16 of the first word read from RX FIFO aligning
> the Ethernet payload on a 32-bit boundary. The MAC writes two additional
> bytes in front of each frame received into the RX FIFO. Currently, the
> fec_enet_rx_queue() updates the data_start, sub_len and the rx_bytes
> statistics by checking whether FEC_QUIRK_HAS_RACC is set. This makes the
> code less concise, so rx_shift is added to represent the number of extra
> bytes padded in front of the RX frame. Furthermore, when adding separate
> RX handling functions for XDP copy mode and zero copy mode in the future,
> it will no longer be necessary to check FEC_QUIRK_HAS_RACC to update the
> corresponding variables.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/net/ethernet/freescale/fec.h      |  1 +
>  drivers/net/ethernet/freescale/fec_main.c | 21 ++++++++-------------
>  2 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index fd9a93d02f8e..ad7aba1a8536 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -643,6 +643,7 @@ struct fec_enet_private {
>  	struct pm_qos_request pm_qos_req;
>
>  	unsigned int tx_align;
> +	unsigned int rx_shift;
>
>  	/* hw interrupt coalesce */
>  	unsigned int rx_pkts_itr;
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 0fa78ca9bc04..68410cb3ef0a 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1799,22 +1799,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	struct	bufdesc_ex *ebdp = NULL;
>  	int	index = 0;
>  	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
> +	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
>  	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
>  	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
> -	u32 data_start = FEC_ENET_XDP_HEADROOM;
> +	u32 sub_len = 4 + fep->rx_shift;
>  	int cpu = smp_processor_id();
>  	struct xdp_buff xdp;
>  	struct page *page;
>  	__fec32 cbd_bufaddr;
> -	u32 sub_len = 4;
> -
> -	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
> -	 * FEC_RACC_SHIFT16 is set by default in the probe function.
> -	 */
> -	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
> -		data_start += 2;
> -		sub_len += 2;
> -	}
>
>  #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
>  	/*
> @@ -1847,9 +1839,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		/* Process the incoming frame. */
>  		ndev->stats.rx_packets++;
>  		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
> -		ndev->stats.rx_bytes += pkt_len;
> -		if (fep->quirks & FEC_QUIRK_HAS_RACC)
> -			ndev->stats.rx_bytes -= 2;
> +		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
>
>  		index = fec_enet_get_bd_index(bdp, &rxq->bd);
>  		page = rxq->rx_buf[index];
> @@ -4602,6 +4592,11 @@ fec_probe(struct platform_device *pdev)
>
>  	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>
> +	if (fep->quirks & FEC_QUIRK_HAS_RACC)
> +		fep->rx_shift = 2;
> +	else
> +		fep->rx_shift = 0;
> +
>  	ret = register_netdev(ndev);
>  	if (ret)
>  		goto failed_register;
> --
> 2.34.1
>


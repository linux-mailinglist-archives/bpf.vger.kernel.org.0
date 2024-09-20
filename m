Return-Path: <bpf+bounces-40136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6697D6E7
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD15F1F22AA7
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858217BEC6;
	Fri, 20 Sep 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jr5DSFeO"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33117BB21;
	Fri, 20 Sep 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842582; cv=fail; b=OtZwSqQFWwN/9bXVePGETBEYzCj5U4hxc+zabDaNTa09OwyhZ2uP9vW5TiBAY/KdDi/TElCmddGqNXrZUYfhuOI8xHi3NJ2pZW00twJ77nVYYympQB6rdp//OF7HF1HAjfMMTmSrtSAyc57fcxuR7+TtzRdhPv6WKG6b1MZe+qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842582; c=relaxed/simple;
	bh=uRDQrtqmDrseNr3xa1d0zffDcVsh39vBZAwCJVu+1Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bc9yoLMjWgwS/7YZxUTADFTmPPdurVYacTg5dX+NS26JLyjlLXJoBXtCVhwViJxn2zSGJNn3Fu9VN98nmODkFO+l/VZd1GrKLe/Z1pwg1u5ctsdT/tyQz2sQDSbGxTQENs17oLErrFtRmgUuIqfzWXFRImGPbAct5TmLCqfmhQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jr5DSFeO; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU5cZSPQZ/j7SdYnxmhfbXO570Gf38U9v7kasGxOE4vbOX8xLaxujbtxFE/HzE7kPpoQZC62n/U5GdjhMWFRmzf6Rh2AYyM4XW1ZB1SlLu0MYhqCcowu3iByZbjx9n1HCuK81bBgPTBrCtyRWwFn0yiLBNBQZ5H8ZELatmgj7Ec68z29lYTf5Eh9qZd5DbFbjS59W/krnor3RIzCF6J+ob5kUwvfghYMWR2u5DsHdwlSRLXEF0HBUvdN01cx7s0rkOoYi2kvy0Gp/tjh1avX/2dSZJWO0WHEnNiD6RetAYb8OjZSjbbQ6A9RlL90EKPBcqk+MNyHNcDJUEPrWeFCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRDQrtqmDrseNr3xa1d0zffDcVsh39vBZAwCJVu+1Ao=;
 b=XsHf8JuWHCpK3jgxXd5ZaHUPQSclzUU8/+RmBlNGNUImZAnB+M/IXpF8O8+g+w00KlLf4oU/aMCGsTINQkUT5+tO6MeQ85oxzTZVH2qHXHKuEvfeh7kjynJDfYHeUIuCZOaUIJ8fJwPiCXjC98RQECW+pCIE0xcfZY6rE4G4oe0bJ4ZBegG2InG8k5labVd1HTDTcgKlc08LwYvtbIwINB0UtsERQqOt77DmkYNhMDVDf1ySCrqMXvtdV5Oipq4oWmeXPXFiaSfKAIRXF1seM18+Wmg0avvts71GCiRe//WCL6CA7VBODmNBfwh3wHTtLlpwgbkDjt/NTbLLW5OH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRDQrtqmDrseNr3xa1d0zffDcVsh39vBZAwCJVu+1Ao=;
 b=Jr5DSFeOO870u/uCy/WRMJEXbqdHy+VZzgEEAzUtYn1L1Nmyrl32U+ESdS56+gg9Z4bzaWKQdxMkcBmLVXl1ns/ct1g1WblB7ZxXPfST31mxA6oLuB3LFjAOxBf3YvLA9huAQpezR4WMF9gVaV+tdwxsZNf4+d38M1En2usDqUobQKL4pCj5UiRrfnWfblYlhnsbyhENBDQM8IhqWZen+0YTxNfWQjx//vV/7UY7oXdqjzFO1auzFIuJ8vq7mu3/jVnR79AcYjkVSr3OOEYzuGmgX+zklLii12kGC2hznECFGDFRYIoaOyWvg62vrgvVi/BwEUL8rN8ZIxut9BRGAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.18; Fri, 20 Sep
 2024 14:29:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 14:29:37 +0000
Date: Fri, 20 Sep 2024 17:29:30 +0300
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
Message-ID: <20240920142930.qo2m7pvxwpgcpkei@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
 <Zu1y8DNQWdYI38VA@boxer>
 <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240920142511.aph5wpmiczcsxfgr@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920142511.aph5wpmiczcsxfgr@skbuf>
X-ClientProxiedBy: VE1PR03CA0041.eurprd03.prod.outlook.com
 (2603:10a6:803:118::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: afa69a6b-07fc-4869-c03e-08dcd980a59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zGxRKC36+0bgQBZI+Hy+AG7Yz0SHVk0N5GJUowxzcN5MS7jJX1DKrzHhBqIJ?=
 =?us-ascii?Q?CLnycKljPPxjw4dJKbrWojylrVPyY+5qLadOZTmU1ed5tU+qeX8LHQ5vBa+H?=
 =?us-ascii?Q?596CcsMbehfM68E36MMXnzHscMC2MdARfbz6k1HFuGbuBczL7etBbjENcBLU?=
 =?us-ascii?Q?37+sJESqo1VlkvxDryH2rl7e6vq/l1rAnKGwWhwBMzMs1p4KkGU10d3zkk9r?=
 =?us-ascii?Q?ug9tBHZrQWWs111s6Ocb3BbAjMvPTkyb1wZT5RgKkCk3WAG668E7YbLqWCpR?=
 =?us-ascii?Q?Wy7KRe0zL2US2p71EXu7DqiLeLosUM3o4oj2Ny1wrPClgM8RxwEbagzrA6eH?=
 =?us-ascii?Q?s2oCVbNPBpYuI9sENxTRXVQFc2MzK7AfRi3HCFYdPtvmuwd7EU55uQo5IKS4?=
 =?us-ascii?Q?9r05oA4j3skF7BoSNVv24RRuf3K0H1hhWlMYxa8CYW9i6zX/XSGXiaOwlwMs?=
 =?us-ascii?Q?/ubmKQPF5zI+2xnVBiSnp6jQv1EOSH7G0FEvfirG67WQbi36vFRg1Njas83l?=
 =?us-ascii?Q?u1GgKj6GKmxnme3ZS94QjdxV4aD9IQNNyU2y51scbuNt9E3HtMV9YeUwdu3M?=
 =?us-ascii?Q?29BNFuLygJa35JOUj3ebJhgdd/2WHFsXyDr+O8gRfIB/3nXTBJsVVztxoVRa?=
 =?us-ascii?Q?Vd8MGg4k5jF4Salv12uk4BvcMoQnhE0gU09rEu8PitafXn08IzOHcEyfm6ua?=
 =?us-ascii?Q?68E9+cm7/9V5pqmsuav1n93YcE2+Cw6VxrEfa4DrKdNi9UCvizEh52Ury8QL?=
 =?us-ascii?Q?mLjmy3cFiEN77lHTeuaLOy4sG5bzSt4YfDScIdBNDvu4QlrEaBfXCZeuyJ/9?=
 =?us-ascii?Q?3hvhhXwWrPzWKeDUmSM/GZ2MnYoX8j8mjEC4rZEYPOFUX0Zzw06T59XMXK3D?=
 =?us-ascii?Q?vvdBz5nkBw3jUm/Ys8vUbqbtRhGlUnr2E4ndfGDN+vH/jYZbXcgeQhEl+YfC?=
 =?us-ascii?Q?rkZHrPK2dxaTruD0adxVwjZ1LXsbLWK3Lzg1Plk5yiVxR8B1MeEEXNfNGge2?=
 =?us-ascii?Q?uItGivEXu/5ltmS31GuXm8/zgpGTV2TVMuV4JLIO4A/FVGMtkO2JiSDym0Q8?=
 =?us-ascii?Q?6XoCWgaW3QniBSMFBld2HIoEpigysBW6l6RgF1EMbM7p/fqyaqtN4tXcM4Je?=
 =?us-ascii?Q?f62U1K47aKt8BtMG4d9EksvQ0SHS4Z+P233iskPk4hqE7WeqAbqjib5N9g/O?=
 =?us-ascii?Q?DsIBXs4kCKvM6c22lsMTbEzi08axUmNsjebDTsreDhBPOIC9JfvB6JLYXl62?=
 =?us-ascii?Q?bOpeUJ7glAV61/CKTL2eK5Z8XqiMRcYcVQBOdnM+kzv3bNkczJvxpYcKHzYP?=
 =?us-ascii?Q?jGImU1H9BFe1J1nMsYzLfsIrLetKe6z2/6BpXoTtzWGy6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aKfY6A6H8KDO0ZsujWkFCukBdTfwSrzBljP2RvIGPFNSBR1b1HnEelx/yfJD?=
 =?us-ascii?Q?iAdcFNTP//ivDMXM9eJABmI6M2IC8p+RcMjKCMh8CkZoQuQWP3eKgGz8i3iF?=
 =?us-ascii?Q?fa/skCE5n7Nh1UR9iyTa8Pn4drJLSd4KTw6+5jU8+aLlVgjO4uVBDSdMQDmS?=
 =?us-ascii?Q?PMbpP+0T7J6QxM5v0T3wllu8iUdSkxhQNBxBwI5qJmukh8IhjZ2YoD0mF8+o?=
 =?us-ascii?Q?F1GZffQFzRk463j9QxZAqddaF5irXCUaQM6XC8t8bAT6FD5vOxAhvHxYlVzt?=
 =?us-ascii?Q?MCYOkmoBp6P8mJnPgTjonFD8GeVMaMoc9vjB8FG3Lqw7GaJWPGUlyFegTvqz?=
 =?us-ascii?Q?/0F2S1iJyOFNtMyLrqJ+0UQjo3HHikS1Tig5zRdeDXJ19yTUPJJaEmjd/jUd?=
 =?us-ascii?Q?DoIaPWT/DRRShdsFqdRWyKZwkFzACuDV5k0PJ482yjkvT75Ec8FtjJpH+t3H?=
 =?us-ascii?Q?iHkb16oriEaA/cdROdCTPjcIe/fSRVuKJZ0M2F2IjKMwOxQk+OP7wWyMzUHe?=
 =?us-ascii?Q?NVwMubTmBXM5K2cJXsis61nQM8JKOdD/99apDG2IhlrNuayGX9iTjyWw7u+v?=
 =?us-ascii?Q?Cfe+VGULbwj1Q0IB2CHXepTBFxeMcdM2ltMj1koQ1p+shpgS44oXAJAUGKUo?=
 =?us-ascii?Q?SUyCttqbyh+G87J4RP0I2A6h09yXh3TUiJmfD5YS5ul0SPHV2yxJ564EYfhN?=
 =?us-ascii?Q?o5EAtDzhvJqsM14P7myPb5OWyNCOXQBO0ONoTtx8R9RTd0wEjxEPIXaEyjr8?=
 =?us-ascii?Q?fxyIeCewA+R9jpaTNRtMTP+C4kjUSfYmd6cZvre6tX9o4mfZQ2+AHwiXytsF?=
 =?us-ascii?Q?KqG93uV9bDzEycq450M5gp06/qR3A2g/JZvzqDcYxjDwH2yBvSgSOxVJQOWn?=
 =?us-ascii?Q?ikiZPYYOFjb4vMPAdedD7I5t/qry0tZ6GQf0jv/R/pR6mUxUB7C6t+IDJxJp?=
 =?us-ascii?Q?DkfgJWkbh/lBFJmwUKt2HO5JUOcBeRpJBan578vLCN1gxa/XntNXww5uiPm+?=
 =?us-ascii?Q?Vch2cc2AV5kfe0O0VAPy+P6Grye+5g0RkQi9ip29Z8AWh8BG928WMy71B1NR?=
 =?us-ascii?Q?Dw120/UjjBrl0UD79mEg2BeVl3WWiSgjQfGptQVWTXVFIiHGmkO6buQwTsMG?=
 =?us-ascii?Q?mmSjTsN/0cTlUJpRU56NG7QQRSPG5x0hXfTWRd+BCH8z9M9kiKrmWHy295FK?=
 =?us-ascii?Q?5w3pztqggyNyTOPUOIjfXFd6sk4xVlOF03v67t3FY18AUmlVOb13DYr3OEXr?=
 =?us-ascii?Q?cIee8qbf8z2fWCqT/iOKSpip8Q8mYFqA+LgYUHPe3/RVDvU9xDan52R3e2U2?=
 =?us-ascii?Q?SPbfxrmHEPBkZFJA6iwkH4+TL5RooWuNEx+0uVLZLQpqK+6O+XhsncWmzyBp?=
 =?us-ascii?Q?aNFU+HChhFF4GJ+CD+Vy6Hujnk1INzhHAK7w0IP0AOObdqo1cBrRO0QB31TY?=
 =?us-ascii?Q?pJ351ocsUh6LB5PAEoNaiCh3FLzuJ9U2WdvbQ4FUFZghDWGNN9mz42Qr+p1A?=
 =?us-ascii?Q?1kUhmj2gy4P6n+K+xHwaxrIdMq//DkrHA8X8FD8kuHMy/J3IB5QKhXbey1ul?=
 =?us-ascii?Q?3pqH5mv/a+9bdgmrNcp6rguNMEylrrev9L1UoJd5Ezfxt4o1pNoJrGTxmKfq?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa69a6b-07fc-4869-c03e-08dcd980a59b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 14:29:37.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCY8IK9IJM/Hg2LSgTXM5OcjUs/t620jdkuFlMM1QrWrGphNECiw2eR/m8l38Kx4DAkp9B8bEgjCWjTtCV7kCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142

On Fri, Sep 20, 2024 at 05:25:11PM +0300, Vladimir Oltean wrote:
> That's when we started rushing the NAPI poll routing to finish.

routine*


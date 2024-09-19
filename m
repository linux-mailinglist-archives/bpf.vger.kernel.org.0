Return-Path: <bpf+bounces-40103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5B97CA1E
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 15:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D9E1F214D8
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CD19E827;
	Thu, 19 Sep 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VoFopt5y"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC219D09A;
	Thu, 19 Sep 2024 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752124; cv=fail; b=doxO87ExbF1QgTUkjzXFQZDrLnzwNLts+hsOcMflDkuepeVgCugnWaus0yQPIvOMIxU6gBtP5ewY4ig3LFfcgnp7xfUPsoFQjz9rkH//b37jo0w7Y/6Xd2KH7VXHHCVLDkBUWDHtTiGnoMTcldycuJ5cuBym3C0LTNaRJF4tJMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752124; c=relaxed/simple;
	bh=hnqLf1Wcgf1DgEPCRivk911EyVCtzne3vT/Wx8aHRwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l7pPJJNkd2l2vHWBf2v1LnhfXciBiuq2WeeTrQKHjMwKS+tiZsRxSkTx5esGj/KZsUGICU6+jMuPwtBvz+XzR4zBl2kiG/II0Kj9NB4BA6BehW3JEE20KcW60pvzsr0ydhpwq82gQ93hw6xE9MUZr0o2pKRDwRzTatL6OhsKT68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VoFopt5y; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqSEFYkFPW1KPb9uJle+gpkaPbmb99oXPNrAOGx8VOnC58M5z4+c4turTXg9V5IwCb7gKdzPiDtk7YEXAukpOWfx46pw+cr1V9RHwoEnXM2Fg3pFa+qIYJLnLjgcHgqdXQSGsB8F7d2Q7TJt/RBWNYcZi1oDptlsiMkcq76osQa6KqT1x+W9BRDXlmkdW3SscTQne5Sf8OkI91hvYlQ+dWz1P8B5XgZ1WKF+ZMl6Uk9FIiQdbJKEulKeq4siHRbhn83DOnbp2vh4SAltS0xCnEm2kvMo+93GYUclACUZIMJxOrj+HrzRubak5BwBePlVDv9oOcavETr4O5Av21y7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfu1DOIPSt/TPgIKyZhBQGYMu0pHQt2ZiwAYq6KkjOs=;
 b=W8PI0CfhyyKBk6cg7Wsgwu5i2I4+EVUFEaymRIsQIPm6b/74vUHMF3P25T9CTxz6J5eyr4/C1uuaAHbaa8ZpocMoes3DkyEf5PyhkHSSNNOScY2Aa9CYk44Dw1F9GgtWmrnsz6po9MyTSPz6JOXHvtMBb/w97ve0anMhFErowwZq0WqvytunPdV74DQY+bPdmiHqAp1HrcMFGI1jqIxCpjoFeBPsO29y5/ANBceS5A8aMLLZgC36xSSqB+yGvKchPp/c3nbW6IQr5WFs2TbYQfG/dXdrRUP41AgjsPeHMxT/ymIKk+xFpDqXk3dOnDhi1UebyA/hsELIZgWdrknRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfu1DOIPSt/TPgIKyZhBQGYMu0pHQt2ZiwAYq6KkjOs=;
 b=VoFopt5yLwrpZyVuKYxr68kwQgyvG36U4WIWk+W2HUbjjth3K/T+cC5/vwpIgF0Dyq/SGNQKX6Mi23SaSUnj52YXBFE/fOJ+fE/jkXiNOI0vFV01dUgDki+2uNaLmGsA7VN3b7ttTVtGsyJy5nJLTRhRksObOuiZlK624ma4NLYfobXcR2XwvCQFzj21c1e8JP7N72xunIPNEADTYfsS3MwemR5aWHaBNH2bP05tiQJ8DUtkCjp4bUJ7A7sOTplV2FtInHlQW7WxzwdOSeBoACgVntsVtIZSLPR0PUbjctJO/cpWugcyhj11JLDIGdxN6TnQUBk+bhLG3egXw3kAbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9262.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28; Thu, 19 Sep
 2024 13:21:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 13:21:58 +0000
Date: Thu, 19 Sep 2024 16:21:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <20240919132154.czugz52nirmijohe@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-4-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR06CA0209.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd07593-d45b-44ac-f17d-08dcd8ae096d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jjKVdH16T0JS5DPlX2j5RPxOpqzUIk/d7Mb9zW7zu70hwNV1AS6NT/jqIiUu?=
 =?us-ascii?Q?Aa26XppZXrhP7lH4VRpwIFYu+OWWGnzm+WMuRe4e1vAehLjKJn0JVRDe3E+u?=
 =?us-ascii?Q?FXuH6RMnU5NdSO/VYcJtDSYTs82KfcCC/dp6Nk9iXK22ASFKiJQZVjDmomWE?=
 =?us-ascii?Q?zZc+m7xLOMe81jUbzRlSyvH2EjePv2+HSUr7BwkZGHx7fpMQ0jtBmJlJfMRj?=
 =?us-ascii?Q?1l7UhkB/VttreLXIO8xUWtdZ7m+W3VQ1qZZ0AZsMQIVnbGHKAX3XknvMqiC+?=
 =?us-ascii?Q?mAuu0IsoDkunROHMglNOJcYPgrVGwetLihcWAUyY2GrJnrZQvmPOKS0jTBlI?=
 =?us-ascii?Q?JLRGBf2w57EQIo/Hm9VvV0ntzF6uStI1kK21EfO7wh1BJxYMtxg2u+YzitR6?=
 =?us-ascii?Q?yWURsOdJ1nY/yNIRSCATUCZQhNj/iU0/Gdhw5zgq2oqc/4/ju2vc2x/e2dK7?=
 =?us-ascii?Q?3Uhq+UUOZol7321EmN+5zBsugoa4WxkaYcdcq0pnhYNcrO+Cre36NiuTEV2V?=
 =?us-ascii?Q?EdYre92lnIBFuyfMXDenGuDn5I39GeaA7WAgaFPxWGfZQssFBub5h7r/eRV4?=
 =?us-ascii?Q?nSe5l/kGlyiWYwRa/LKrAS9uNCpJMF+sG65W5GWEzSZWfToLs2QDhsKnFl5J?=
 =?us-ascii?Q?ljE3T7+d+EiXoQCeHUm/zpvAOwcJfKB1ym1h27fycULO5/e7u2a25iet8kB5?=
 =?us-ascii?Q?fN6X4f3IbiZo//9OPYIbbl/p5n3oc3NCpbFqKx0UQ6GPIbmMPsqqZLguPoDV?=
 =?us-ascii?Q?J0oceE9RPNLwZzH8HvaCeShkI1FEUYbrgWQ5b3PHNsrIDl0CFRNwLc8Hl/VN?=
 =?us-ascii?Q?iMTN90d2PWzW8PfKgxgUsn7LL85/BEZFdBqOOJ9wsgjtH+dkVTL/n95N8DTO?=
 =?us-ascii?Q?YmqXU9Siea8Qw/P8IgclqOfPjGp8KZZwrB+AVAmRf68MJaWNbhpZkXmIyZFV?=
 =?us-ascii?Q?a3g5p/tcBoBGz+4BDamKogKlf7jn/jNkrYqFgb89ILourPf/ItTRrkZLRRBt?=
 =?us-ascii?Q?KmS0fLpyLtU0xpSlhYeN9mu88Q3tTPcb2d1evNAkqQ7XzWAqv+JA/hloiUdM?=
 =?us-ascii?Q?eTD32/wXHuA2qnMp93CUt3az9P+2Fy7RGemkt3St2pmjDFlpVY3SOTiQlzQq?=
 =?us-ascii?Q?5Z+wohYqW+MxV5sQ7ioBqS+0HzmLPDeEknr0n2tEOyjL5s2ZKpIdmgV1U0MN?=
 =?us-ascii?Q?rosi97Fu/DfF8UmSjokj+51acftiT9eHnND2/jBmn4zAXpH7g03bEUjs83eo?=
 =?us-ascii?Q?Ry+3qXbPoRoNyqCtLPMdQmy3rGSA2lsQfaJBGGBLjlYKgd7s+ISL2vFfZxtH?=
 =?us-ascii?Q?VwvxNmQmnyUnlCp2MELudmkFKFvOWHGlKihT0d5cPJKrJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bd38et2WQlcy8QmJRsHRmklfKftJxap8CieNyEUM3FwSJemFX2naHiI8pwui?=
 =?us-ascii?Q?U10OSCPf/J0o2Uwe6ZxdWKwgkpndyFgjd+BFvkrQZH9Aocx0du9QcpLflf72?=
 =?us-ascii?Q?pLwSUU7Flm+U8ZZFxufe+UA7TKi6Cs58ByKdaGkzvix+7wBhwf2eWWoH4tNe?=
 =?us-ascii?Q?j283kTxQDQliwQBfmD1K2HAyfPcCNwOKFIjbHIJwr06AtHhsllyNkHOXNdgz?=
 =?us-ascii?Q?Piv2N84Ki8khtDZHxGxOIETbwB7f2aJeU1vfZnukvKBZi+X5mnYJQyo9dm7/?=
 =?us-ascii?Q?L3OfQlgXQ7Ifz7vuxZ3gugLo10R6dkTU3Yhykr+fSirXcmlgjTmwdSNnh3cR?=
 =?us-ascii?Q?fWT9X4tmDuDrQAANos7WM8X/EwobWGU7JjUGhuYVPa9vumG3fO40kL1iAWSR?=
 =?us-ascii?Q?8G0tY1onqXO3Lu3/SfABqbh6N05AnbKNzGlTCpmRWsjj7oD3AAhrQ0xf3aF6?=
 =?us-ascii?Q?5sC2yodNh8c//fRX548EUcbu0MWZ/mgURJbeSKhn/nJfWYNquaiqbcXToGp/?=
 =?us-ascii?Q?nSGVuP0MmlBltudyBGSVbUeqKsY7ZPA8Y/zPSeKKYm4d6wNgezzH2S9CA+SR?=
 =?us-ascii?Q?xN/btje8QY1bFetFfeP//RPxx5bCJ2mkDI/+fqUCxln6Z3ETy8CsLBz9om9k?=
 =?us-ascii?Q?jrXkr/te3YRSwfVVrs5N9FiF0y+M9hLJmG77WgJ3xxmGx0PRbDMmrYqaguuH?=
 =?us-ascii?Q?MXE7qa+GKMeuzHdYDXomIRgRi1Q9u1qV2ahQ8OEoUx/yTu7s1Awm42Ja5DE1?=
 =?us-ascii?Q?5oA+xPv0nrKxb8dJVOMtmeVekxW/5TWar9/r52ZzZQOCaiyliCHZh3P1zxmO?=
 =?us-ascii?Q?uY+3zD7t1W2kwyka3NvQouJTCKKpx+qyd6+NNsU/jqy8JEPH7aTfn/VfVaHH?=
 =?us-ascii?Q?xVFXIHXe8eE9ffOtBZCkdKJTw5f5wEU6NOzr9Dhu1MSa8ux9N2Og7UrvTeRc?=
 =?us-ascii?Q?YW9XwH4C1ENaVdLtPvD2jvjpKapko+t0sFkUQQFpRCUH2OnW/KbZvY0FkLaz?=
 =?us-ascii?Q?lSjwJguhx5iwCOVA/ZPf9b0oO7Rk6YhQmbhiXB2Z3IiZbIfCztantJIxJZKV?=
 =?us-ascii?Q?FLHSDc3qDdZiEfnkbtp6MIumqjClmaJYCd1DCHSq9ukgs27qtjfPEMPOJ/jV?=
 =?us-ascii?Q?aX3pv/lZTuUmz13N7JpFqrNSv0hbyORyQq2k1K3Vct+cFCyiwcGsrINsR5cD?=
 =?us-ascii?Q?OwsNF1S5cFTwKh7i1b6v0GMkJu3lOBXXrzw8u1pkMDBXeM00sbIuqupCKE4K?=
 =?us-ascii?Q?kMRiXvcHo4OGGtkPv0vl7NMmRIYe2nEodqPeMWrCSG3jSIxfZkUaCCD+TLpM?=
 =?us-ascii?Q?D5OrDj+EswCfj/yLFODGsy52e6vvoogrMBLnlZkMNOZ1GyXilvr8Hq8xyfsn?=
 =?us-ascii?Q?LRAs3o7iPHsYeULwtv2L+fSHdJgxupO2+J5WHk84ADo4EtukVjY9oMarstPC?=
 =?us-ascii?Q?lYHObriWoi3eejWkEBup/xX4su+nplr6onlm6dIIpCzYsuDs7BpjwhoigxQL?=
 =?us-ascii?Q?Pkm6UW3JVyOQ9wDkJbMy5TiSMZrbyTFPFxfe04CPur4gQTbzXIZhflLCWIuq?=
 =?us-ascii?Q?t8UXxygnERDodHjuuMG9KnoF4SzErepizqR5ORfvlywIKb6sdo8JAJOKTH/F?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd07593-d45b-44ac-f17d-08dcd8ae096d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 13:21:58.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iry4xSqmOj03fnpjE1goxXeEc5bYM8OYF0efjnUWYJMUyU9NMG3KNOzOQqqzQ7Bi4FYkuaVsXOhKbUsEC20mew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9262

On Thu, Sep 19, 2024 at 04:41:04PM +0800, Wei Fang wrote:
> When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> on LS1028A, it was found that if the command was re-run multiple times,
> Rx could not receive the frames, and the result of xdo-bench showed
> that the rx rate was 0.
> 
> root@ls1028ardb:~# ./xdp-bench tx eno0
> Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
> Summary                      2046 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> 
> By observing the Rx PIR and CIR registers, we found that CIR is always
> equal to 0x7FF and PIR is always 0x7FE, which means that the Rx ring
> is full and can no longer accommodate other Rx frames. Therefore, it
> is obvious that the RX BD ring has not been cleaned up.
> 
> Further analysis of the code revealed that the Rx BD ring will only
> be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
> Therefore, some debug logs were added to the driver and the current
> values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
> BD ring was full. The logs are as follows.
> 
> [  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
> [  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
> [  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110
> 
> From the results, we can see that the maximum value of xdp_tx_in_flight
> has reached 2140. However, the size of the Rx BD ring is only 2048. This
> is incredible, so checked the code again and found that the driver did
> not reset xdp_tx_in_flight when installing or uninstalling bpf program,
> resulting in xdp_tx_in_flight still retaining the value after the last
> command was run.
> 
> Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")

This does not explain why enetc_recycle_xdp_tx_buff(), which decreases
xdp_tx_in_flight, does not get called?

In patch 2/3 you wrote:

| Tx BD rings are disabled first in enetc_stop() and then
| wait for empty. This operation is not safe while the Tx BD ring
| is actively transmitting frames, and will cause the ring to not
| be empty and hardware exception. As described in the block guide
| of LS1028A NETC, software should only disable an active ring after
| all pending ring entries have been consumed (i.e. when PI = CI).
| Disabling a transmit ring that is actively processing BDs risks
| a HW-SW race hazard whereby a hardware resource becomes assigned
| to work on one or more ring entries only to have those entries be
| removed due to the ring becoming disabled. So the correct behavior
| is that the software stops putting frames on the Tx BD rings (this
| is what ENETC_TX_DOWN does), then waits for the Tx BD rings to be
| empty, and finally disables the Tx BD rings.

I'm surprised that after fixing that, this change would still be needed,
rather than xdp_tx_in_flight naturally dropping down to 0 when stopping
NAPI. Why doesn't that happen, and what happens to the pending XDP_TX
buffers?


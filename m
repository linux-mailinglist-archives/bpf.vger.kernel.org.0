Return-Path: <bpf+bounces-38180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7C961331
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0594728319A
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904F1C7B6F;
	Tue, 27 Aug 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPsjWy+B"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B964A;
	Tue, 27 Aug 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773570; cv=fail; b=eeVX/iz3B64bH63swUVLDt+ABghbzFoP83cg+xWSzq1FLhsiv8AGDfKq6/ncfM+9fTEtASS0N02I2O1h3O2p3b/Qx51qqbv4s8qmNm0EnwffAqKe4Z5+QjY0wNIHdArzk56QQE/hvlUhBNAUkHAAomBKy7dN+VIQh3tSRg6IlRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773570; c=relaxed/simple;
	bh=gyRPQcZqajzPEBBhsXYUPfKveUBMGQHt19dLNI0WZmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VQFn9xm3WwGDgGyGRzGj/Wf22qz3seBNJqWrnXZt1wzcBmf07ZgToRDOoQKNk2oxa+MPnhMdU7dNh2vHDdNTVylT36PhzU6ORLh2xVGWpztkP9Cq5nqVWz+28ETWB3ObSfQeuHG85fSxEdLq4dJ3s//insT4uCPepytcLTZ1Tlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPsjWy+B; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JweSiUjsttm3lbDvhdnLNhDw7f5JF/elGI5BOeJphIxjDkrNogskua44JwkKBZI/qMCMwfTg14C2L/q0PFbyzxYS6jQUnNlc9bsJr40ExJMZjbg75P4ZIgc/wuzRRj9A6CLJrFKqlryvki0OJ5H4wxpIy4Yb/y0QSwq2jdvzeS+X7SYH3vO4BXPyZAcYKrwsxryrb1Jd64zhnRTffMNZm3e8BoqiMDgldwlZCjmySceybB6jrDtqJkLL6GIr6KTlFfvaXIinfL3xs9LlCHRiws6FMsrnp0PdwRfFTL15PV72lK0wVJLekFZk88UN+mhgwWq5P0FGuz/BJ5qESh9Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42f7+KNGXsY5FLIvjNOWJE9E29LaAraSYzfYjUgqGoI=;
 b=iX2P6l5a6fzyRLh7yBwmWZWRzSORrUwCLBzTlhv5tGo+lkuts8W/W7uRTGBWaLQ+BX1Z3cKkig7rICAGIMlmx9a2AcXKkuf70cMQFWu5rjPXYNnuiW/NxPDOV+ZNbPdEWcNoioGhriBiZrAzslHbeiWQMsq9wZwOeLrc/USYJawwIVmH0Pmh5b0Eh+um6lxoO/88Z6AJaRLFjiBeoTRQPES9hN5Jqiq8O0ETWmPjA0p8LYHJw/W5DjpIxwBDczc6UNP67yneGOR25V0entcLXf7Lnev8E21NMYnKA07qNA95Ey4O0r4CfiSTZ4g8nIFAsyCNmK1qjQ0L+b/XQxkoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42f7+KNGXsY5FLIvjNOWJE9E29LaAraSYzfYjUgqGoI=;
 b=aPsjWy+BZcCqY2A7QKkGsSWc8Su5sGkrz+PBRiJ1VZtou25gUn+0yrWf8NXty9dFmQjcmBE3zJygVc1YO8ArdG2Ljoq24BqmJzvMQIDv6XeMTtmyZPWbEl3WJC1P4Q2LtmP7jmRRrd/VJD66q695f8kJ/Wmt6D1oKUT+UubUS2KIgBNgXiSWNUk0dznQD1HE6+32oskIyqXTw21p4LVjGP+eOH3/iqy5ztZv+mIHoL+bsvf4GxPniKdAb+Ha8MAgV8YMjRiiOuEgwzfYzyZatMnGPTFsy7OB8KEHfuUzcJJ7LX6kuFgDd2iKil1u/BR8TLQ1fEa5BykcZFIZTrm9VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:46:04 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:46:04 +0000
Date: Tue, 27 Aug 2024 18:45:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <Zs30sZynSw53zQfW@shredder.mtl.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3Y2ehPt3jEABwa@debian>
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd551a4-5ab2-4ef9-b4a6-08dcc6af5baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7tjK1zIlTkEF1JO0x9J48D3632qJTGMmL5I/NDq056Pbrf4A38brbnVBB1d?=
 =?us-ascii?Q?CoZG1otOUuDSRRcaxZmEl3MKkCo5KFln/gpFwB5F1u0E9T1H8d3lhOXHsCVW?=
 =?us-ascii?Q?DQcW4rNZ/mAs7/J+icV653FghfQ/fZtOXh9NjnvRBmKH+xyv+avsohXCdD2r?=
 =?us-ascii?Q?RhHlI0hyNucKDtt/BDhv9MyGzDUpgJNQJnFqhKV58AJSDyCbHh6Um833/AJu?=
 =?us-ascii?Q?VPBD2bUvboKaPqw02US/RfsmRXzWHjEGD3OyqL67HKW0kVhEuJO08cD5KfF9?=
 =?us-ascii?Q?huc6hkHcYVqPlpbvGNa540DYhC53E5aizytmk/e/2idcbnrMkwqiQJX5gXEB?=
 =?us-ascii?Q?hegYfbs+SNfdXoGbo/lbfLQu6l38UdCz3+gBw07OvAtyj7yZi3+3UknakGIh?=
 =?us-ascii?Q?04qaogkRU6B1iViK8r5k+DUCkgO5qhkK3OwqHE5ZeL8gILJcltwP2ktRZREy?=
 =?us-ascii?Q?FAdf94YAjFDmiEXvCE9gNZ5qEX2CgVo2To4rni8Bv+lFMRsrlxNgH56hU1+p?=
 =?us-ascii?Q?on9ILWbXAihwbB7Q9JVTfdlgxcEoJvHqA922kK+P3GNIFtgzbRusqO0wAqB/?=
 =?us-ascii?Q?n4RBfusBTksugBZRGaNB2Za5c6gXaB8ptLb+Q6kFU8k65um+c+zKNSaEcYUQ?=
 =?us-ascii?Q?PtlmPy8ZH45Fy8l4GbKXzu7DYDewFoFNY97tGALK3iIko2vpPOMcADYEzj1t?=
 =?us-ascii?Q?OC3NEF3up/+x5TDSsIPWqhHEzXYXZKhqIo8fK2TT29jcLF1yvsR9mr26YxoU?=
 =?us-ascii?Q?FlJYYn0HzC4ZW98hHW38m1MHGl2HdSyQY+P0lLDkPySaiV16l1i9tHcn64GJ?=
 =?us-ascii?Q?+UzSEfZi7xAu/TiRIZGC/y9UTf83ZA3ej7d4pSnaKrTMZ6fLXYTpEn427iPo?=
 =?us-ascii?Q?/RUHuv7krd/jnJS2KkmD/SPQT0ohdSJY9lEAXGXnoey1N78h1+RxRk+0V+T3?=
 =?us-ascii?Q?d7R0l8cq6V32anGdzFHNyVCFOapRsxIbMg8dLyZcTv9GqkHH4SLvp3A87H1o?=
 =?us-ascii?Q?ut1aDelc4dmJ288w5oOGoJPb+vFtD+ezXlwySk5CuzkqtE9XoDmxQRPezFo0?=
 =?us-ascii?Q?07Z7Pu0YnW837mfHzoZFg92fxoXDO/lhTlwwW3tkxJSD4TJakJDvzjxYxI8F?=
 =?us-ascii?Q?ynEJ6NM/ge7nyMuhwtUx+TVHV3L0aLYa9fAhNRgCfYSDGx6MEIZSPpIXPgza?=
 =?us-ascii?Q?3x5c1Fk1h4E65aHXTijRwtHDn/shz30i3QbwxiX53RxMZOc5dojgtpIapmFG?=
 =?us-ascii?Q?yypEaqzJx4FHrXk3Afwb4dnSQ07qx0k4aqAa8JLGGKneH5nyaY7VXYl/5SDh?=
 =?us-ascii?Q?/2uau0nfkB8okSg6YeWN07VphxDvaT+lJ5lbFIRpBx4g/imMT3DpURYNcT0k?=
 =?us-ascii?Q?w1eP7YU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgG3GqtLG8oX3HKVNieWH6Py+lLE3dTxi8dsZF/Jz2xZxlPwd2RvZCcfS5Ca?=
 =?us-ascii?Q?VkMUotICWkUSoX0BWW/4E4ayFMHwb76lIrIkW003GaxzH/0EF6VzmkZf0Zvb?=
 =?us-ascii?Q?pV+ISqzrG4dpO5FTHnpDMlJdkMoHY1/CVQlKiDy8v5vkDbZ8aQsFFD4xaxH7?=
 =?us-ascii?Q?5EFvnWGE5LLzRguJ1BLOZrDpRlVieP8mwEXmyZ8LJi7sj08kOiR0FtJ6Y4D3?=
 =?us-ascii?Q?2UsSAlV8WcLisiTNdkBBc3Fmwr30Luio97cX79qjMHDRRT6Ns5NiAOd1ypK8?=
 =?us-ascii?Q?Iwn2PyYDtIFFI/6Mcy3m69TiBF6Hr/5taGTgEMMJw9BKsc6f3OSWT7RCOOo7?=
 =?us-ascii?Q?NOtQmJPdx+9mJUPAOptXh4HANtFTJLwf+ZV0boyHYtw0ZWM37gc9HoRvwdr3?=
 =?us-ascii?Q?5QptT7kYm9UoN7LqTIXyruQzLGzuAsRsyxuTWGyN+UatBe6qwWkuUCfzjhva?=
 =?us-ascii?Q?pc4+0r8hf2EekhR/m8kAYCYydGD9JeoeX6MeLFOp2psg5G/PVZwc32r45LS/?=
 =?us-ascii?Q?/zw29Gmn/W75l/qzPtcytGkIJC1HJutpFxhb13+Xj6CZQ6ImO80++sCpCtqC?=
 =?us-ascii?Q?ZMaKGi2P+HAYVCSZkClFgA4VSIZn4m1/iM/dpEI/MSwa4MHscKqeHc7Hk/9d?=
 =?us-ascii?Q?ubtJjXD8D3ilGZp/InNYlTwANB+TIeZFkOEB5BFoRocX3PfD/9rz7/1vsWGO?=
 =?us-ascii?Q?fVcSgpUumhAu71tcqtX4emHg4m0tr/ypQFq9fWvCxXpyqslZS+tEueUnWDUM?=
 =?us-ascii?Q?FEf/8QZqXdGS2arrzOtFALD9U00UvznvZABgd3cG/Z7AGJUCIxuaupWgg2LI?=
 =?us-ascii?Q?6YLt0GfUF+aaRTt5PFvbN0q3/SCVVlRY+J+vsacx2WR21ExXyKwWradI1pHU?=
 =?us-ascii?Q?yfzjplJP2mg9bpGIaFZcj8B1EJaETwHAEF6sPhUh4NquPJg7SM2vwJbfnelg?=
 =?us-ascii?Q?G9RCMempmhw+eW/dXu45p6bpRKgX/+8ofr5aCLMyogoEDKvjzPeJrClw9AO2?=
 =?us-ascii?Q?ykbgTcdNbsDIBi5l+shucTxXHLqmqPqQAIxQ9Vq5Wc00teeC6GNuMNvwzi24?=
 =?us-ascii?Q?MSx3gNmotLadH0rDI+JbAbIm3nvy66xZuqsjAWyFMfuQQr847Vml4c7wthcL?=
 =?us-ascii?Q?oRWQRZdoXfi89W+zQAbFbCcJoW5B4Dg/jlRmqnwR9SDFiFqlmKVlffEKsMH6?=
 =?us-ascii?Q?9iJv2B7ZlZTpTxCEonCYHnLHw1ILcYf5DW1kaQIC09xaxenpteLOw7kRAi90?=
 =?us-ascii?Q?gKR/6kBncHNS1gBAVAmHXm9/xj/IqpCXFtwgMdsI76YkDoprIKDZGJZXKqHt?=
 =?us-ascii?Q?H9up3Nsrbr+zUlEWJeGqOMs87zph2cylElaB04r9ROmeFZ6EsUxG4gnzy7tN?=
 =?us-ascii?Q?arL1D7XQYpKQ8/3LHfbyxm7aBv40cZulKVj4OTs8lTaZeSAi3Is/wOX5hx6Y?=
 =?us-ascii?Q?sXF9m/FERaD6YwwdGmoDzKH8B4VQiOKsEFg8u9wkYC/GxKoO5WDiXchhd+62?=
 =?us-ascii?Q?myE8X1kT8Yz+Tpn6OGAtDxOEgtI6NBzicah8zAFbf3feuvst7+ry4/OYjTYg?=
 =?us-ascii?Q?GS1X8YKpcE+yaGEJ8GZjyLxkgysAZ5oYbwzHFsqs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd551a4-5ab2-4ef9-b4a6-08dcc6af5baf
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:46:04.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw1sT9VcL6EZQgnP5oU4Bl51rOyr9/OUM8nTEGWp/znUv+jaliEUoEt8eIukjligUNYP9u7kSX0QBkaybVMMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > DSCP. No functional changes are expected. Part 1 was merged in commit
> > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > 
> > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > lookup to match against the TOS selector in FIB rules and routes.
> > 
> > It is currently impossible for user space to configure FIB rules that
> > match on the DSCP value as the upper DSCP bits are either masked in the
> > various call sites that initialize the IPv4 flow key or along the path
> > to the FIB core.
> > 
> > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> 
> Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> necessary as IPv6 already takes all the DSCP bits into account. Also we
> don't need to keep any compatibility with the legacy TOS interpretation,
> as it has never been defined nor used in IPv6.

Yes. I want to add the DSCP selector for both families so that user
space would not need to use different selectors for different families.
It's implemented in the patches I previously shared:

https://github.com/idosch/linux/commit/a3289a6838a0d0e6e0a30a61132bdce3d2f71a3c.patch
https://github.com/idosch/linux/commit/ff5dd634fb278431b58437654d7f65b57fd4ae4b.patch
https://github.com/idosch/linux/commit/3060ecb534475eadabfa1d419dd64804f0bd0148.patch
https://github.com/idosch/linux/commit/12ddbce4f519b42477ea1e130b6d2bab1cca137c.patch

> 
> > need to make sure the entire DSCP value is present in the IPv4 flow key.
> > This patchset continues to unmask the upper DSCP bits, but this time in
> > the output route path.
> 


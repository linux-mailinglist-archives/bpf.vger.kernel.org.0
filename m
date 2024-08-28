Return-Path: <bpf+bounces-38265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A7962693
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60D11C216F9
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743A81741F8;
	Wed, 28 Aug 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8GtDpoY"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A617332A;
	Wed, 28 Aug 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846976; cv=fail; b=hclEDosER7qqlE008LJvGgxnHYuEXLpctYLLcDpraiB/8JT5EhTJ8rRemPI8FzC0wFP5AQpuT/iIfNmHQWoVmDhXdHtHuq8vhYRx/xaLAVEjdyeu+bEKd09sYxZvzpAMp/uIs5kUdZL0ToAlBHTlfkGzmSjrLr0PgoN54PYLoKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846976; c=relaxed/simple;
	bh=uYfK9CExzAGgIfl0kjx8+H67urz6Ro+ltPE6IZVzXjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxCuxb0QQgEaVFO1HBoLkHkUo7ob6upxIH9ejfzKEbTv8C1Avby4gkBWcwkAKvCydxWNRrK83oDDbDTna9nmAFoct7BH6KOZfofRTevjai3IMxhDRlCoXm60j7N51EWsjptGHzO5r6JLks2eHkfZJY63AMJsUARArfn5aHsLXTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8GtDpoY; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5j2hezZTiT1RnCWT47DKiEE8+YTIn4RF1EAGgS8bbc46TQoJL+4Zrhms6IS0r1sB7s2MQ3FhIpEmNzY8uk4yWb7K88Q3tkyHUUVqSUJznov37cy+fvY8wE0juNDX5mrD/o4HbgyEp2dDlLTCMG5niQRqrdXroK0reYHkQIIxEO9Fes9Lws7TUX4L76UW2q4aY5nGBztDsuUW84iNf7lxi9nWbjIdsC54m4FwBIvq2+DmlKJ4W2x5l7BbfhnyIsrydUjQo+jkvAhpV79EoTMjp2DOuRQQBIsd2LydzYmXDuuV26ZSY7MSwhHBGExeeGAN94hLR3WaLaWlS5dkuTN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hO211biHTGluACnkIvm48z8D2bBqbe2sPkKV+msZow=;
 b=pLVK803JcasJMzDCOxBbz6b0VcpnvMN71yiTW55qd4eHoJGrv6Dy5sw9FYN4fpjV8mJ4wg6btIXFZ8N0/dqciCgSvU7Gvv7HG0SQ/wtLxRkKR0o4YHGv8bbQpsAr/3MGjlwsoh76cMTkFlngZ9Kwk0I6jPQ+NWIRbUrDuV+OZmO4Gar/Y8rhHTXeGkvVXv5imsIC7yNYLxtqkH+nCviq30TpE252H19IJDG2Ob4b4C4HnayvVbYEpQIN6Jn/aT8gJA+iyGbb4wzHZe8ycF23zPWLDWbM1QTLYGv9pK6UGjqlOKKxLtw4aiCRJOg1k5z3fvMEdgMhIm6plPjU+Vx8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hO211biHTGluACnkIvm48z8D2bBqbe2sPkKV+msZow=;
 b=b8GtDpoYRap7TGZNJmHtAZuNjjn0wZ6z8MZgO03/EKCtJCmck8rIkhybfLSgSx29smjk0BM0eGopz6siqmRemwN8EeVH/IxuymghPy+fKX5F3afTKyV+ZjmMZTNPMSAd+ekEmmTRON1deqzD8ZccFKFM7lDydTI6ZGmaogtQ2G9+XAb21zVS36X3GtTayATLIHGRdayXAGV6yFMwiDc7OaPMVoWAnmVthvXVqn/cwynQe2FbM506mxlBtePJ0NfPOQbEUSrG5z6BiAClZXbtdRQZMFIc+zRf+Kn50A2CvnvqW0Rk2mCY0jfwMDiJE/lA9MPRX4d+TSSqnVmDwHAPtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 12:09:32 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 12:09:32 +0000
Date: Wed, 28 Aug 2024 15:09:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <Zs8Tb2HXO7b9BbYn@shredder.mtl.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs30sZynSw53zQfW@shredder.mtl.com>
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfd5d94-e581-4b80-c909-08dcc75a4616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqw4CxQUrJqEa160yDmdawJcSBqzUgHA6Ibl6ApTYa+eT/MRlQUtUTtIJbxu?=
 =?us-ascii?Q?+ltHH7K5Q1pJ7MN/vluIQIEQkp+spDSOpFB0QDsGIFYEyNvzEIWg25BWhSg2?=
 =?us-ascii?Q?jpSgdMZ7me++WDz0hvTe/VbaoKlN6DlhGP1CNfDyI5fCrRLbLCYpcaIz+GPs?=
 =?us-ascii?Q?IYT1N2Y9UGdaj+h/SgpYYgFn68mKSsNL/fsFbpAP7VcfMN5qSoOb2mC0IV2F?=
 =?us-ascii?Q?OLotltRIhPBByddybZ6BSPzIdH/PYiTyuSGNR2Dvcu6Q0pMvekQI/Mb/KTWD?=
 =?us-ascii?Q?ikUF1FwKiA8wHo5OHwFuUq3Xbqq7wLHA8KJnyvosohf6yUhZrtaH+lvysUbt?=
 =?us-ascii?Q?jJKDIgfhdI4zfXOtOIQ05v4mRawR3FRnRzixgavuPbuI3tyhonJdJ4KuGdhu?=
 =?us-ascii?Q?vi5kQtvE2ovepeR2HniZonCH/VpRmlMvYCUFWBmuraT0d1APGnhUfA0IlKwo?=
 =?us-ascii?Q?dfsKWBpWgu+rFPKBP3GZavYLkQf7f0+YnI7vZW1Xj4hfAYFETl76gUfm3Kg5?=
 =?us-ascii?Q?xeI+5p3W3JrWGqHUjrL9I0ammWclvMGZlandNUQqb1RV0wqRiLyvKLPEVZPC?=
 =?us-ascii?Q?8iETJ+F4iiThJBLP27wAo5vB7FdAPxmPPRsRlB4S5awU4MutRN76OMPbq9Sb?=
 =?us-ascii?Q?phFMd6onh4QeCqZkLVLycSHnMmboyh7sSjg+W4TsTwN7s0QgFiHA4bHeBGnQ?=
 =?us-ascii?Q?oQW68vTVHtKeVGEt9/fQnkEEVB9Y3Xn91ujSWtL1KenjMGMPAxr73rU5WTTT?=
 =?us-ascii?Q?u3O5uWIPzV1rBhzsNWrqvfvI5R97dW58q3gvjU7hgHhZWFIt96j0c25d9jsj?=
 =?us-ascii?Q?jTr/GD4P/DpaqVu2SoCiKrVxwnSIBb1N8uwi4NGFvjE+3nXfNdlfxC/jZKsh?=
 =?us-ascii?Q?VauFuxEA8nNOXlND7iKy3dbetQG7gUUMeNSPhJ/Siv6B/auib08x4NnJgPps?=
 =?us-ascii?Q?iNgCJ51zuvxjjYF4SG0bEH/+tRs62PF7obL2L761DMLXhCTZ4HCPtCCaCWUW?=
 =?us-ascii?Q?+d6wbq9W7ALfWL2Nq0arDCScDxuEgLFW0vuMZ5U3aZAYY9l+mmPKqFFp07qB?=
 =?us-ascii?Q?78fZVWmSnoO1CuO9iClIjw0m/Xxb9hyBYqSFk7pqnPpTlayiSQJbg/qIU/zb?=
 =?us-ascii?Q?tqfqWiWyT31l7k3B6XUkXrAR5x4Z/i/llXXnUsnMzpkybGv1ZqAqrpSTDTxm?=
 =?us-ascii?Q?13ylZbqvBnR7XR1yMyLulfSjPnYYBh67Ouy7JI2ShstzgGtE6cBA9qPw2/e6?=
 =?us-ascii?Q?FuTMYGH0Xpu7tfwqU6WgadYEgL7uJG7GQ1wxGFr2Fnks+64vzSK1oE6kiLpY?=
 =?us-ascii?Q?EtuZf3MFINDx43dISLhAfrWEwLaMbU2ny0Z+UI6Nd70sOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQnS0AdTPULjp9jAmP/u7sOdjgm/5fofhcFRpqFO3JhM1fdCxQNKUlOr92jV?=
 =?us-ascii?Q?gUfby/vpnDKFLu5XPKL06gCTDz61DylVbTVWCViO2w7rLqDMFwGNv+P1aJZH?=
 =?us-ascii?Q?ZDLEOOpb26uXeGDsukC+ej3CR5zQ9CSi88xsbVh+Ermg9GmyGKy8JotwFelT?=
 =?us-ascii?Q?6itudn8/WpHnRqrT1hqIUtCtutBJ8FpFJeVtqV5Qb6mXDpLjOMUc0RqEvcsf?=
 =?us-ascii?Q?yR4N9ZxkbR5iHf+5nssujn0tsuu5R9NGk13xlkvDW8+UaK2PhAK38LuwQtYu?=
 =?us-ascii?Q?z+32bmNIGumcCOaXc3zdg8jVC0bjAshF/si2rfvO4wZIOuwSHSMW8THmxiHg?=
 =?us-ascii?Q?h/OnPS1qLF+5Q2/uczk4VfGWW62f7+y5Th/j14Qs12ahHPLYKtX88uKQ4EDP?=
 =?us-ascii?Q?+iT6Qw67/s1CYvRzptVy89fmHOoqLTUX0JL2q0JBg5cV0XE51XuUV0P1Y30m?=
 =?us-ascii?Q?ktJvStSTrDGojkeyUnibwrpd/jg5hP43BEhSAONaelrlzO00X6w3TrSmeNbv?=
 =?us-ascii?Q?FH7EI0u2GdE2VbJaVYh6mxBAx07pS7ffFYhSiOH5g49z2yCqaxdOHBWbvGzk?=
 =?us-ascii?Q?xBjmGKJiFUD7YmgPU+SU2LjN8cilz2CmqhyjyWJSSNNz+qoZ2TdorX2u1iy4?=
 =?us-ascii?Q?LZYnEQwYKqLhrJjN61Mz6oPUWNbkHGYEI3vXdXXyH+U40x6pqna7428Q1xPR?=
 =?us-ascii?Q?Mb55+mDdovzmstquLsl4ktimcaUd3gxaBWjo2Mqy/9jdIfwR+vBh9GtV/1uN?=
 =?us-ascii?Q?M57odAh09P7O8svMyPyRBFxyM7nUEnmU5rxYdo4ZgBGJ7T8qHlQMdupatC6k?=
 =?us-ascii?Q?484DnZRmMvc77O838DRkxrqjiCoGABb3A1pFZPGPAKBGB+lqsrRuK5J+yMNd?=
 =?us-ascii?Q?kwT+AJzEw4WG0kbzGiuK3d1sGW+pQqk9vogQmXgNE4EQ7oATcCgNMopv13oC?=
 =?us-ascii?Q?pqx3Wvp5+5Q1yxTkvjGWqwqzGOZ10CnFyvoldxfUTcWiL2Qylz1ToG7cExIo?=
 =?us-ascii?Q?tsGspD4VrDYlRxeBi1j4eJ/qpkuKwV+MBULuaotqIFl875k6xqkUwlysz1H/?=
 =?us-ascii?Q?Pg7EioDxxhZitIESr5nryQRuIa++0BbhtdffiUSyZaWpm4cumAGJnogCLShP?=
 =?us-ascii?Q?6So4aB8oZLu8TIWGuK23BPxQWK6JPNxfSVlKB6hbdQ5qISsJ0blCMUeWIDWR?=
 =?us-ascii?Q?mp5mrhl+AY1afZg5Lkt9ia/kzgoe33AIZHXiqEen9Hhhu9YAQziv9wLaSNjI?=
 =?us-ascii?Q?VT1xBPNmrgsd8VzOy9TNvQX2A2hgBvhBvbgXHwI8koDpQeZrXwPsvc3Y5GV0?=
 =?us-ascii?Q?8GDZlh/Q9L93yEURtQuFtDX990cJajGn1vHcAu6xju2yr/wFBrB8DAxxMPKd?=
 =?us-ascii?Q?8t72ua8ZuSz2R9c3ylQqc1rcKheT9CsS6qNHoxcpgAQfgO3bMemP8HPsBubC?=
 =?us-ascii?Q?8Ev6uLdpOWHwV/2giI5Y8deotpf5Vg41VBT2l4ILfrpsydOkw8NeCWDYHg50?=
 =?us-ascii?Q?DoJLCCtX9VyqwXjMObW/I5mZ5/gHzRbf6MrhdQAKw56BZOR94GZVyWmsm3x8?=
 =?us-ascii?Q?u+96oOdqQ11OwBxCkQb3thSrtT4IZObtZ+1SxYvU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfd5d94-e581-4b80-c909-08dcc75a4616
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 12:09:31.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8wgwQ30GwZKFENOgJTjQEPivlkoVZFzS1G98uKtEtHEO47jThd99s7Nfvb1zH0dr0zXWozpNgQdaN+MgM3dag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > 
> > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > lookup to match against the TOS selector in FIB rules and routes.
> > > 
> > > It is currently impossible for user space to configure FIB rules that
> > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > various call sites that initialize the IPv4 flow key or along the path
> > > to the FIB core.
> > > 
> > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > 
> > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > don't need to keep any compatibility with the legacy TOS interpretation,
> > as it has never been defined nor used in IPv6.
> 
> Yes. I want to add the DSCP selector for both families so that user
> space would not need to use different selectors for different families.

Another approach could be to add a mask to the existing tos/dsfield. For
example:

# ip -4 rule add dsfield 0x04/0xfc table 100
# ip -6 rule add dsfield 0xf8/0xfc table 100

The default IPv4 mask (when user doesn't specify one) would be 0x1c and
the default IPv6 mask would be 0xfc.

WDYT?

> It's implemented in the patches I previously shared:
> 
> https://github.com/idosch/linux/commit/a3289a6838a0d0e6e0a30a61132bdce3d2f71a3c.patch
> https://github.com/idosch/linux/commit/ff5dd634fb278431b58437654d7f65b57fd4ae4b.patch
> https://github.com/idosch/linux/commit/3060ecb534475eadabfa1d419dd64804f0bd0148.patch
> https://github.com/idosch/linux/commit/12ddbce4f519b42477ea1e130b6d2bab1cca137c.patch
> 
> > 
> > > need to make sure the entire DSCP value is present in the IPv4 flow key.
> > > This patchset continues to unmask the upper DSCP bits, but this time in
> > > the output route path.
> > 


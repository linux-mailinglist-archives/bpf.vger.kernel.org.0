Return-Path: <bpf+bounces-60068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418CAD2276
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857DE7A52F4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4A209F56;
	Mon,  9 Jun 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HjXpYsoZ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A961F3BB0;
	Mon,  9 Jun 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483085; cv=fail; b=EGSqId+OufzS1fS4PZ84Y6+pOf2OlqnknHGWB+RofIgeJwc7E+BKDEx36p0lyeZLmjMU5QX0GAadpxNxI1jikAX4yNVNm1a7D3xI+fxjq7cgTFgIaftV5fWhRWMoOCumLjT1ZDuLJN3YqtNpEzxdBMRw5hQyhj6esXOtKFqa3gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483085; c=relaxed/simple;
	bh=1fg5XKFTM826w59g5xK7d12PaLljm3bGvSEN6v38Bxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nZJMUJj9y9D1aSUKbIlPhdbzDSAzEKIt9GTJcaDdJuJGpYdm87w73HrTUbYdjU4FwkcLOeKtu+xGHM6NcSxaKIPZ+A4tLmGkP7f2JlrVwT8PC0Opt3I049jD/oyHJzeU8NkKTK1wNFOzqE3VXpF1CWLKdSEBOjN9cJrV24Ghiuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HjXpYsoZ; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzZG7EJHFFPZTZih8PNa68JUL2P4tFiQq2b/zsGulxHUNWLnxhDJzfhdytyyvYBPcDHK2dBEP/VmQu5W7qtup/VAf6Dxn+Xyq35HoQXVFB5dv16pcSu1yupCH2KFpUNTMpwEAcwXjS5ByQ/0++UXlylESrpLqfmVJM9IoShY5bqXRBvcrg3B2enkCjw6bC9me3/SFJqjqCswD1bKeyqXcvf6+B1nCO85NVvNHHAAJ1DNRko1Z+e2v6cd/BqTgOTTZnkoeFfKeoNuYOrNUNPbnc8wURVS7K3FVHYXR4a1FU+hVCiMiRtIlh7cSuvJDpjvoOgwF67qcWWXZf4rkBg8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll81H4sCgYB/9GIO0eNEn54E3N4KNP8Byz39fWUT7q0=;
 b=sTshG09QRqcWtNKFLvAMyejvCGggk6ITgSc7wd6ZUPyQJAw811tp8gwAczNQGFj+wo74TdjDrP3oYRdx8eOZh0nFhfpcTbHNwu51dmFPwDg2ylCCENP3SIIhV7jFfRQcTGML1nFfFwO/ADdXce4gKHVs7x5v/rnZ4J9Yrb8Vk9xw5esztbG6FJGC4j84D6UrCHI7TmtVVp4FiUnl1yxHVBfZMv6AdVcq1ueNV13M3K5Ru7PQXk0ySTAPoZTy8YZEpeju7tBLTBhlK/0kEz6mYAaGir9KoMSdpCb51IHrluf3ey5XHZI4xh5sLoF2R+5dm1pubZ5Hgg66m40hGl9TUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll81H4sCgYB/9GIO0eNEn54E3N4KNP8Byz39fWUT7q0=;
 b=HjXpYsoZrWziDZtlC7qIkBYiw46OPl3YSFHgMwTutUdFFVECjCnJXzT2l4r/NqWsSY2UKIphaHjkDkYq5t8OiDRREBkNM+6Mp740DqqYuMvBixSIdL/QcNbFjo+vFVXF0q4i30B2YXOBifMQQ6XMXwhywd4Qwt3QyhGDjbon546AZrDUufE7JvYK9avBKPTsf0YD5lTATySpFOc+ynv+7/0w308ZEGVPOmSIiRBOPabQVb+aJz4yAuJ050dr6/+B7Uj/dI64rDlyX0Cg0yqHPMWsTGAm3HvyWXlvsJyYflSjP1dZlPYBrU+5BpUYY/F5T+PrWgyqsLF2VrHHFH29mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 15:31:19 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%7]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 15:31:19 +0000
Date: Mon, 9 Jun 2025 15:31:00 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v3 07/12] net/mlx5e: SHAMPO: Headers page pool
 stats
Message-ID: <ga65ehnqozlkoh5hjuujdv5m5yetmena7qpt22evtqgwq7tzdw@c26wfwrc3hkx>
References: <20250609145833.990793-1-mbloch@nvidia.com>
 <20250609145833.990793-8-mbloch@nvidia.com>
 <20250609082152.29244fca@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609082152.29244fca@kernel.org>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 586bf50b-5447-44ac-9b1d-08dda76aae60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmUIwF/cH7aYQVJfsZWo62jMrd1VpK19/TZkDSeNZB1FiEA9lzEQBwNCTgP/?=
 =?us-ascii?Q?oEr3SVLLzOfF2pk3R882NbSMa/xvClm2hB6cqGzlYaCx1YGJi0n4pkopyMmE?=
 =?us-ascii?Q?Ex8veTGRynHTHnz2KFeGzn2FjGPlV/N2+bXt+qjo50DgW8+8//CWHOdElqCl?=
 =?us-ascii?Q?rRSRFmv7vjWn4SgBCgVQ1xGAIXyaRcomC7B+p7nP6sZ0klFkC2anuSTuTwi8?=
 =?us-ascii?Q?9uUXz35N+wG/J1XWVlCS0ryalBmNGjuIuxybDXA/zHaF9h9a7LdSwqu48p2/?=
 =?us-ascii?Q?hhW8ZtsRDm+TO3zFsqndssieYqP1tuVAGDu0csD9URjO5a45ShrocymSR6kU?=
 =?us-ascii?Q?yShnNQQT/H7NcjguyeKwdtPkwR2lINbbkwoyWKSUtCma5/2ETB6dqRrnRK9E?=
 =?us-ascii?Q?hOJ7ESQ3T2eaqM+CJSGpbSr4f/lMDAKoL4NmxjcVsqZ+8yYevyWE3ZVl6Jcc?=
 =?us-ascii?Q?/UADaOFFwf1O54T4MqlppYbdr5NNboDV4T2ej2LF80a3EMkdrzw9ch9aqz4b?=
 =?us-ascii?Q?B9pNRUrWKWFksBOjWsLAFofaH6bxQtRtbMcTP9v2MPpGID2Iorv2QfGwo7zI?=
 =?us-ascii?Q?Vimt57DQHjWf0/UizRbsTfuIiqafObgsedhtflZxAdlRxSvWZ4uDfXMCs7F0?=
 =?us-ascii?Q?nT6IARi995fwoA+LSW00BNiU4nearenjejkEBsz4rytqyvbrTRXYz98iROc3?=
 =?us-ascii?Q?SMNqMI3xzDCse1ljK+Yi1ygo4dJHEvplNMFaxEQTZrdrRIoP93ChxCkkpVY2?=
 =?us-ascii?Q?OhPTVED131xuApXm7ZZDAAaWVHckIm2AaJVRn8KatYubZ/RfwyrGbnNYVciM?=
 =?us-ascii?Q?iQvudDJXR0uJkPQEtmkUTYDmlx5WdeW7bxkhtLz0poEwwHmxWRMswc7nzwf7?=
 =?us-ascii?Q?lpkofKeIvx0xriqEhreGVXwBXyv0gPlIfs+4e4iOyUO1vhkVRhlH2Il21FX9?=
 =?us-ascii?Q?fsUBgdezjph3tiIPKrncOKv2uz8aJKNpIquWNfg1yiCX2IveVkcw0KqE3nPO?=
 =?us-ascii?Q?ad306uB1ms54kG5fvx0aYyWupNUu+Rdwr56DsxnAwTLhbrykeRtxpfheVLtX?=
 =?us-ascii?Q?/dN79yaW+BCnuOjSlc2jucdquBDdgBDGiR39Os4XliMKK7veJ7BqC1/qq4MB?=
 =?us-ascii?Q?8PQc5hJoXd/CS2r+plKC/HBFcdqSuMKHjpA8uwk9DZUMF6XUVTOBm+9F49n2?=
 =?us-ascii?Q?SAVu5HMUSSfLHpT4FaiqFuIdWamdKEfDWjYlwCWwA/+M+9djRXjg5lU5Nm28?=
 =?us-ascii?Q?TFb0lXpj3Zd0W+S9YC12RayiA/JRcrQ/mYdTjqZwMVARAYowLwgTn4dP/qJV?=
 =?us-ascii?Q?LFperv7OSViVmOZmSuulDI5lKuTtDCzTYflWk6lzS4gJMIWdds+C2iaB0vvY?=
 =?us-ascii?Q?76f+3loriMZEMJsAJV3W2bIGXwPG3wsS9zeACrAdsHAVwCi1Sb4pLjZ2leDz?=
 =?us-ascii?Q?blU1mZw2roM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I19oF38eHZoRZ4rx2mWwHza4myGPTRQ2Q+XaY/IJ2llT9JLVf+xx5B5P2k71?=
 =?us-ascii?Q?8sq3JC72rVhzk1iflErrT5QpmIS//QtTukWsSwmDZhViOTzuRVUfEHSTSgkv?=
 =?us-ascii?Q?ke8WwEYWkt8+vSdIOr+w+RD0+DeDLWFmH0RiL21f4Ki8WzXEfKm3WA1eriOE?=
 =?us-ascii?Q?FPm87ZkGeKgvjCBgswFITmiul6brLwvmqcyW17IkVqJxx308jaj35ZWzQ+LX?=
 =?us-ascii?Q?jbG1WsI3DLqE6M6tObw+yWDrbUcIzZfVkTZb2GdDYGLqsaZ3XIKcIW7bqmj7?=
 =?us-ascii?Q?a/Hqz6ZY123t3Vy67PEzITnEkjT/+yXkyl5Mvr8JBUDcGKWdFo2x2d6XET3i?=
 =?us-ascii?Q?sw2ndeFsOJMCJkj/8P2wleFH7pzczfpEX9vI2a6+01bfBLeaIUgpHhGcF+/l?=
 =?us-ascii?Q?ViAIGEB6IcbyIvyOa/VhOgJcFzQmKPsJY9qnpc/GWPkGPBZyMtKTYDXcx2Ag?=
 =?us-ascii?Q?HhHrmsFN6arrBHUHiEuTfvwywR4GMbzWlGlB1yB7jnYziK8WXH9TvnnFf8Yq?=
 =?us-ascii?Q?fMuPjEPIEFjKMs0hjHdLImTRxjlj0p8pOosJokDBfLsUDNUcZFABaDqG9rqy?=
 =?us-ascii?Q?t1reM1yQRP9efkzgDsEop8bCfSCukhjdXhoQn+hsDr1iEu1R5BHHfCsLOtxN?=
 =?us-ascii?Q?c2H4a6T0iKHwTYR0C2K5o80TmLkDmKFZoIoV6bJ9C49SLJAbRR8wf8B+N0n+?=
 =?us-ascii?Q?nDZvzkS/N86y/2G9PtCDDH1Qh+nHQjhjb0FQujVeCjd6X0yj5nAPQG0ZC0I7?=
 =?us-ascii?Q?VC7azpTmjJ6UglcJrxrbzVWW3ly5NN4QDxlGUcCli25Oi2Ci35EGW9RtwulN?=
 =?us-ascii?Q?ASBvbuhDaUWfS0elgLfaBdgR6pYHJpQ0vp6bvJgHldsTXKTatNDcBzqWT4eP?=
 =?us-ascii?Q?+HyD6wv9tE9S4Jp8FtLbI47s2LUG3lIczKvJpnt0hw8QVi3O96t5HTi7BI14?=
 =?us-ascii?Q?T9InK7lW1NLWpfWwsKbsZOWFIOVSn1a54EkGchnkFszQ7yHI0I6SHwgnYIn8?=
 =?us-ascii?Q?TK2qy2KWJRj0kjuls3XV+QO1Vzh3vVKzPAlMAzzPj7a0Yt5bq5z5yXq8Ue1o?=
 =?us-ascii?Q?u0mgi/Ec4qnndsUpmPZJxrJCM2roLPQOsn3ATiDaglvABv/xY0N2310Ry+ux?=
 =?us-ascii?Q?WCo0hUm0j2vjFxKerwQ32Mu7nUEbguVvPyT7MPOGOqE+kbhPeT7oYqosRhNF?=
 =?us-ascii?Q?+7TGw37maDF5Ak74fxWkg/W5XfeZuTqkbbe9vlO0c3TgZWgX8FbJj4KOfg/z?=
 =?us-ascii?Q?oWuxilqe2/EzXKWJkkcS1vEjm/K5sFD7TAmKB8yKgvKSsp5kWGzV6IQCYwv/?=
 =?us-ascii?Q?3n8qzZmW9rkUJCN4yaaewtNhwf4QRx7k2x/o1OxsK5aFDBLn88yNq3HSunqX?=
 =?us-ascii?Q?bnnrGKt9Ent2oKbD9XnApIKPCfw3AfldWQ2jXqF/3qotWBxnyvEW1JBAPMz5?=
 =?us-ascii?Q?rDBiyuxR7lt1rRs/2NckD5tFW34Wo6fvoFnyoD9tQqg6fSSf6dA4+r3Cl1EW?=
 =?us-ascii?Q?1nuThIU7G5/4yEdnfH2fKSyALP5SCZHcFgNzPfpdwhJRyUfqnlTCxhU/QE40?=
 =?us-ascii?Q?26izv4FAVRwiV4ci1w/kywVAdqLwNdUzi/YhJS+t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586bf50b-5447-44ac-9b1d-08dda76aae60
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:31:19.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCNTRrFsW1bOSTRDpIv0dWv0R39WzzmOSYzySb5QwC3/UrOWGqTRmXmIu5/+UgbTccusq9b78HLXGra91IxvxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

On Mon, Jun 09, 2025 at 08:21:52AM -0700, Jakub Kicinski wrote:
> On Mon, 9 Jun 2025 17:58:28 +0300 Mark Bloch wrote:
> > Expose the stats of the new headers page pool.
> 
> Y'all asked for clarifications on this patch 2 weeks after v2 was
> posted and then reposted v3 before I could answer. This patch must go.
Ack. Sorry about the too short window of response. Patch will be dropped
in v4.

Thanks,
Dragos


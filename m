Return-Path: <bpf+bounces-51113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F435A30485
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C073A3A53
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2E1EC00B;
	Tue, 11 Feb 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A92xEgI4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220926BDB6;
	Tue, 11 Feb 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259175; cv=fail; b=ahS5jb+GIOS/rh3BOiue3BTyOeRNkDhQgzjvFuUSnqWKhW26Or/sq4QuSPVphByaG8bCi4+Xp/w0eLoB5Tc6wl19b/uunF7uGTBHc75e4LgBWYw4StE3FcKCoRDrVNeyZfHgLlxteXEsn9sY2AgV+t4v9/cs5IbExLNxoBgHIPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259175; c=relaxed/simple;
	bh=LJhj64eIhqu60eCP+67kdYjQ3Aziq8lZPJzD1uWN+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fz1kSMA4OScpFSJklVpghtx7QNvMZ5ZERRSaHSyaFxisR6cBH3oDA10mA8M+ZgNKVqYh9e5TnSdvK2b+0iVwm10rgMYgXRpInMuhwTATJP4EYOuNRmLH+vWKIRUjZS36tkRtCwJlzzRz5/jOkk5rCqfL2Gjk1+Yq+UM5gg/yrfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A92xEgI4; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv+5FUfhS2FihM/A17znQGODn0+BBjIZz4r+LZ4+IuOQK/hXLEOyyGwVcIl14jy2DxRG2FjF7fXxudyfQyDtIg/e3JwrNyuyGez4U57q5CjNoJUATPhcnSjb43vzaSgovJqOmErfJ1BMYWP+QpJny/hEJarYW9Y7vZuFgzTl8i0Fz9Y/urwfjXCTJjL2iy7AXXZ+msz4Xq6fA26RDi9XVMOmay1AzBwjT97DqhZWUCSaXkjxyj68gxvxmva75zakyVvuD9JdhWHkBgkYoryp0F3xJgwBKpNdUCWjftQtIgvqz7Fud8/YSfcqfJz7mzNISGK67c9o2vG8aAnteG1oQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iz29bJbXptYywYhcYmQ32fIjcRaZFeXEtB4Qjw7kKk=;
 b=V820vUtOiDChCcSsUVDm5wCKIC8DGLhRixLZOefl8sDQFma8PEnaUy3YAoDBnjyFUy1WfnjVW2udfJotQJZLotEjFTWnfoTuNGTMFhI+9W0FshhLZWBwfs4D3A2QOFhmU9KHD9BI9TLyscZnPS7lMRZG5sSNRfox1NZd+dM44FhlUm94xKd8yKjxcfIruPn5nxyYcIt2peLq2xa9l3RSUp6VnkMe2hZ4Ei60a4h2SSUAkq2gRYuLRb8/NZGFLq3vtSU/PpTkCcDJ0qN85DuYClSQfKSKFmhSfJ2yVWQ+UPTmCHoydee2dwx9+dkiiGQT+p/cKxp4JlfpfY4VhpcCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iz29bJbXptYywYhcYmQ32fIjcRaZFeXEtB4Qjw7kKk=;
 b=A92xEgI4N5/hyiks1YW1YETBto9kYOpgBOIDDAVnB8unbDohirmc+kz2HkIzLhGvTwljs+Q/D7BcBXNoX26V4y5UZzC7QtWjG3OfQvCbJfR34v4RUNau9JzlI/KhfkNTWnqf/bkNQZdKtp5CFe+M+AtJRg9f5BiI9vX4VRkS5lZ4mLNCwDuNrHNC6cqS3IO7LKMbpMxbLK5JwVeHceNthZ/vCbs6J9vO76JVoqwropiU0UC5mVthqrb2CwvB+ZCOOqJbwCOha5m6oa6MKkTVkjCH5jXXaPXC+hf5JKmgOe95V4p+hIqcUzwwtPgMkrLj5nYXQKdgPEhYvAdjR1dQiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Tue, 11 Feb
 2025 07:32:51 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 07:32:50 +0000
Date: Tue, 11 Feb 2025 08:32:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6r9H6JukZi19dQP@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6owBvYiArjXvIGC@thinkpad>
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: ceddea20-0acd-4c23-34fc-08dd4a6e4a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0Bkbwi7RHwooJnEwXI/Mjj+XLDFuGBuHRJygWEq726e4ZHv4+8gZS/2tYwK?=
 =?us-ascii?Q?aXd9elLlbTQ/GHCBIl5XrRIyEizA4YXM/e9vYcs7GYzmbnvQUrPxpUdOIs3S?=
 =?us-ascii?Q?ezvN0KGys9m28+K5KvsIeaALNT7z+FI71EgOBxsEXVa8mz+REhXHS10Qrmh1?=
 =?us-ascii?Q?967H7q55dUmLB32QcFr2jls3FdoJXQ21qgxhVwY6kZaHSY3+jRkOPQhX3Lj8?=
 =?us-ascii?Q?HkLnJwhg+84cikUwA8k1tAeYMbaF8KCXikhBTqLZGBrMZSmndcHlyKe3qmd7?=
 =?us-ascii?Q?XCanKKLjdY7+eSGNlFACoQhFzF3KsiqTRMem3g/hVmq5JYny6O0VPp91sX/s?=
 =?us-ascii?Q?mwD0OOesRzrha1w7Luw1Vpz+ajIejTz4fDNEnJhHxhM2M7OKkJ57/OxsW6ob?=
 =?us-ascii?Q?zC6NdlrWgzGe6VgkIMMdcmOcHA3xH7DTEg231m3lHrgeDiUzPVQyrfgqlZdI?=
 =?us-ascii?Q?b8B6Mej7cx3cq5Q3IC26hVt+b0NOFFIAFQpKfAgUJLjdE+FsTdRDS8W1ZwU5?=
 =?us-ascii?Q?rQ24de50TddRAKQbD/jHaX8W4zpBIWgrbRAtVEhocANAD3GliYCYCO6McBkV?=
 =?us-ascii?Q?qI4qLjztpjzxP0SmYNE8AxPMJCXiEOIbI7T5thH+OzVPxaEakIm3KQ+5Dm/X?=
 =?us-ascii?Q?2OfK1Mhr7lMo3qX5UucB3Dvo+Y1P69NT0RlYqgL6UZnGfe20LuFd/XrnRvfo?=
 =?us-ascii?Q?RfQWRdaRh23DNuyVobHXlZASK8fRvRBj7JAtDFe+UECqmaL5LnySSeqz6bFz?=
 =?us-ascii?Q?g1ZfLgPy83HjEoqHEQ+xUK4wOhmNDQVdPunEmOAKUbeZwvOKR12855t6hu0n?=
 =?us-ascii?Q?nEBCtt4iAubTbjhG+i/VRYjJD21L9ZJjvJMeOfxSRwX6C9H6gxmSYUTsm0KF?=
 =?us-ascii?Q?Zn5E+AkE6WHRU6ZU3K2Rz+e7aDTWyl0nWp/d5A42tJiEW9qlLSBKlRhZdkGX?=
 =?us-ascii?Q?lmmih+YakM1Oo5u1afZCoNcHIvBgFNyWCBQOpIW/VrrLXtB+rnEv8Ljk103/?=
 =?us-ascii?Q?V1NfjPV/Nk/ykyAIfnN3g0/9DZ2K7JWF2mKF+lTPlpUZqDfARR0ErHphs1ID?=
 =?us-ascii?Q?WEE79sUrvm7CotqkKfMmfmVCOiV9QfULUB3hmgIWJwuCNBTU5FkCK92CGscU?=
 =?us-ascii?Q?tc+2VrbM0pGzOqyNQmjUipWFhirbfkOt5fC4NIiSCiMNWvDSUSKMmIn4lnGL?=
 =?us-ascii?Q?Tpdg7BP84uyUfBvcW1DddkNLJ8TLmyuBgUcbbd3ZneFXSw2raAs9/kqCZCIw?=
 =?us-ascii?Q?YgL/JnIkuZ8gkIWpScV2Yk/9NkXhPhTkIAfyqHPCjOhRlacPYkVVa+VEGVlQ?=
 =?us-ascii?Q?6CIDIXzzK81kzyisF54TbDMPMqXav72K/RIFqZn24qM/gGnHYGJUvr/ZXBdj?=
 =?us-ascii?Q?IWD0o2dhhDkH6mwz63+6Um04mpwa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?itJL/C9CFOQ0rIVEopPvmb0XE5DKv7LBXJQ7C71y3zhdpyyJqwd+J6oazo63?=
 =?us-ascii?Q?LOXw0jNe26UnAKfJQNpnWcTXYcgC8ZX0orP4e1qVkUfm7Snv7h+gjZ5lxqmG?=
 =?us-ascii?Q?hG6JuRgnIiJbnIyEtAFEqCPNEMgx96BstxuMPKpNu2JUqPJGK0cEiXK0pU+e?=
 =?us-ascii?Q?Sv868DeEc/8l4xWbQUvBzKMt8ATUwtVblgFaK0FfmOSCKKVY5BLhyEsBuOXU?=
 =?us-ascii?Q?HmLGDR9Z2s/iMAyCm85pOAzZ8speXUMe+lCmeuw7IPvUP3cfylpm6p2u6xjh?=
 =?us-ascii?Q?vHJWYgPkt/Mz8ipEmgujB5xHT3s6VXl2cuLBT9a3cHWkfcnS2vSbqF/cHekY?=
 =?us-ascii?Q?+vwXN8Ay4UZz7EHkaKDWZ/ym63U93VsWoiHtwVOyxPIdF1HbtRJZE1SHIl42?=
 =?us-ascii?Q?SUREOUhweJwf7XgnV/cid4AmtnG0YmmHBltkea29LnGt5T33nnBYifaBwMmB?=
 =?us-ascii?Q?GaDU5pb46afT1kWuVWwFl3ZOXv7S7Tt33ZDKlcOTgLwwXJMWKRSbzlAj6Ube?=
 =?us-ascii?Q?K0aGs6seCNa8uCvyjScHdOS2Ohmkj+ZGR++oYtReW8Mmn0a40Fkytn/+BDgb?=
 =?us-ascii?Q?aRgELbqHmhmyaIbJcZXcikN7/0Mgqd9womOmlZO2MF69ySg8BI48Mm9M4l+N?=
 =?us-ascii?Q?aKdyS+bfMSqK2XZpa5eOKTfvslzbjzCyAK4Qle7MDAD7x1PXeIR/o64M1WrF?=
 =?us-ascii?Q?48vDUAjCq+s+uwtbeMxvXjz6uyHIi9QvWgCDwksi8M5rRaNsDLjMXnIKQtFt?=
 =?us-ascii?Q?GAN0s6VzHhtRGPEyvU8Ux4DceipqneTjQ8C/F7bthYXGzjEK3jBbT+FRtHj/?=
 =?us-ascii?Q?LJAspqixly2Bdq2KuF4pSzPSfArIniZJteZIAKON5U6Zw8z0Os948SAbNt+8?=
 =?us-ascii?Q?wuPJ63PiDNu3K0akPNfimsgqE7A4bZoeInoyGYHtgBRt6BddzxG1biZ4WE9K?=
 =?us-ascii?Q?n+HktlRYnexbe2J+KlhgZ+iaOUK+i/fOIz23PJSVPYZbpFeLVfS4NC5b+hGv?=
 =?us-ascii?Q?epuQAeZG0x29bKU5pMplkR8cPZ236l8YmSpE+kJsrA973+lk7StxbFFCRu9T?=
 =?us-ascii?Q?pFyhFxckBADfPPwhqBiSZCSO40++6ywU5GAP16EV5OXiN5QCfapgbwTcOZch?=
 =?us-ascii?Q?8WhRAd6+i6gS5sx2lgJbH9IOgX/HW7oI/nhxERCM75nwBI39iTspIQG2+oVf?=
 =?us-ascii?Q?djULHYs1XbmNt7dQFYX2MxEuXSd22sYLEQdYgWODeb5cYoib63OeSmomjVBh?=
 =?us-ascii?Q?TvUyYHkTqrX77XlNyGHodlG4ykmjFc8ftOXx2SDCsWwOrgGGYSzmN9+1YkPb?=
 =?us-ascii?Q?1vPR8oxaHLYBt/L7xWY+YD8ESLsfHDfJ2+EPxk7dAd8VvvyHnyWi+n0OYUav?=
 =?us-ascii?Q?fJJOgpY3zpI0Ig6tkJWfgE+4SFsPtuw8nHDNrbSOWkadMMaOtYQYUaqqRuRJ?=
 =?us-ascii?Q?jkEb+kX/Ilj+g2SOYdFfby/ElaxoR3JNf7MDMviM+SPWBmM6kdtz1G/hypTo?=
 =?us-ascii?Q?D73Yy04invLgWd6DkHIroYP4+rrQodEX9o9xD6wREUogbPnGcIfvxAsZXnY0?=
 =?us-ascii?Q?3HBtEl4XW4xBvQT6VybC4Wi52GMupvGYkqnBrlmt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceddea20-0acd-4c23-34fc-08dd4a6e4a06
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 07:32:50.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+JRSbcYxFy6NpYRFaT59L9YFBr3r7no2XfBxhFbnq+iAb1GKqDYaStU9k5CgbBeMzbGMQg6tjhuWpJ+qqtjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308

On Mon, Feb 10, 2025 at 11:57:42AM -0500, Yury Norov wrote:
...
> > > +/*
> > > + * Find the best idle CPU in the system, relative to @node.
> > > + */
> > > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > > +{
> > > +	nodemask_t unvisited = NODE_MASK_ALL;
> 
> This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
> stack, right?

Ok, and if I want to initialize unvisited to all online nodes, is there a
better than doing:

  nodemask_clear(*unvisited);
  nodemask_or(*unvisited, *unvisited, node_states[N_ONLINE]);

We don't have nodemask_copy() right?

Thanks,
-Andrea


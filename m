Return-Path: <bpf+bounces-64690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB764B1599E
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A923F3BA81B
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE628F51B;
	Wed, 30 Jul 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMA7g9WG"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29063C0C;
	Wed, 30 Jul 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860729; cv=fail; b=WvQW2pqspI7h64jQ6Y0XDqE7jbff3osTWChQaZmH3K8Y0l/a8pkYIzm3tJM9fEvX9OE4wuH0heF0qC4b2uWlo7S+uQAmXsXGjaTto/RHbSxw2XcvMlyUA/S3ilmKjmiV4Bzy9sWmlOFAsRQLGN1D+0yX2LTbed7H81A/Z16O3wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860729; c=relaxed/simple;
	bh=aDTBfp/WxP4wiwYQRSXztTQtuVe72Ix2YHJKwcAMcZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOI/OKseL6bPfrhzXEzvz0tRkSbrhQXoZEnuG/JCJPs9VltUsmTqKM7qxCFD+bZYD6yFJx46+XncV4/0g9/w+eurKUu870wCj1Vx+hp8HFUc0b7YoksLJEDer4W9+vgXEX43EulopaIEl1MXTPngS+egt/LvmK8TdWU9MT6ifzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMA7g9WG; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWI3LiBOuMvOrH9jBvbfXqb8/o4LSw+8/VFFoZLp9nmpSmBCdCcCssJzUXxp0ZqBUBLYVFRFwpr9Ywoc8r/sKQquFmL77SR58i0AVzaN0FNtNCArYZ9siE4bVr8wsvXyNTbKGMuqW1N8zTRhtTlhthsLGcAQngQb2HoapAvNJJ9t9WbyG6GSzxJM3S5av+Fp6lGIukYTmWZqF9GKnHAt8B8Cfy2XJE2GMfMwsqJSRWOOrdaLg+6Blirqc0MoCpbhKKAhv7nD0yBtzscwz89uTnLotEQ+a4hNZqSvrpn8i10+/sdEogw9KMRlLIsqaKpNPsclV7ImWgz4Fm5WuJlAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5EuRjGBwMLTxFvzYLAIYjJEMMGR9wUddyvU2ZqwheQ=;
 b=RCFGzBpcfIfsbJ7H77wMwUyLyCuzOA+9uSbpgoJWipEIMwZwvBpl4EYsB1TNqUA1wnFVyyID/ZUdBJwoQTkF7XVN7dK3tqPMzPyLGmAGqAG6JgGYjgBKotD7X+Iz1qzKPanuFPBTKW8mT6PZFGyntZ6QC1PTAA/1tw83trGuYroCoae/TIQ3nebhAgmzG4StvXxZmNyeWzVyutJdLvvb/7Xehftg3r8Cd5uFxrbK0SsLVzk7++4uBEeJdWE9EgAi6PrexXjDREmDADQncmw+4PTz94N11+Ix5mgkhC5iqE7Ol0K9zBtaQE7QSVwM7qDjVsCg3yZQSBkjaQyS4cw6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5EuRjGBwMLTxFvzYLAIYjJEMMGR9wUddyvU2ZqwheQ=;
 b=RMA7g9WGYAl4vMVdyjxp0ZP+Y7k3i97XrPrO3g8YSbbiLu58PRCz1F0dad5hPUWNafXgzjnvk4S/jLupKMZe4LT9O6x+JB0Vm4QSVw0uTFnHSqr0QEVv1EBgyuWBn/9JX+/T2tWAyh8oe+NvDwj/YXzoHhISaJCEfnWVFU1bHzhJXLHJQKZCSoEkEEq3Dyxpsd8OoRBPXN/iddTvzuLrBMRBWcPyKdSBXCksHyaieIgl4yNtGNhYnz1bp1vd3shpLqIXgj+dYJHkXCSzNu33usmKup2KP8CMHx9pAtwi9ngARVxq6xcqTuHmN7zfgFGoa2rSGevnt2i9qoN3VpFRbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 07:32:05 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 07:32:04 +0000
Date: Wed, 30 Jul 2025 07:31:50 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: horms@kernel.org, kuba@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com, 
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com, 
	rosenp@gmail.com, netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssengar@linux.microsoft.com, dipayanroy@microsoft.com, Chris Arges <carges@cloudflare.com>, 
	kernel-team <kernel-team@cloudflare.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Message-ID: <i5o2nzwpd5ommosp4ci5edrozci34v6lfljteldyilsfe463xd@6qts2hifezz3>
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <73add9b2-2155-4c4f-92bb-8166138b226b@kernel.org>
 <20250729202007.GA6615@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729202007.GA6615@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: a91eb746-42d8-40ed-5d87-08ddcf3b2e7b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oIF2OswLY2DwBnK4xh2bwjk9/GlpxJ1q9FWKDcNeI1hAdHycoMIvL4VJGXgN?=
 =?us-ascii?Q?VZb1dGKrUocyClhLodDp/tcSQ91gL6xyjigeW0rxdvYWOzhwvmnvGIksBBzU?=
 =?us-ascii?Q?kOjowORohBAkzPXxCHQCwOVCKvLq8a7NEmw9KRd9IKmlCliQ6FWtiPMGsgin?=
 =?us-ascii?Q?BG9J5oNWb9PtBSR4h9z0RBu9q8p9P9IKSteyl1DDVNq9k8cQpqH1JQLd4hj/?=
 =?us-ascii?Q?oJo9PM/3jNbX9Q9A5jo7czQkn7lVKQLZkHgWYt6imsNfv0tpiyC9MXPEA9L0?=
 =?us-ascii?Q?wBbNZ3ys4Pdh4Z9yN8rw7GyYtgUSQ9Z5SgRpLA3FyXrg08c4uUAOJZt6WzfT?=
 =?us-ascii?Q?fd78m8S9hX0A95aIbkqgkpYiyGZRtuMNdTtHnCHRkFfMlAvDN5SN94cTPr4p?=
 =?us-ascii?Q?6H9onfiquCfcYJNKT/b+MBJzaVikgnK6cKPmhOoCP0e6gsO0p4CSCxDWD5xC?=
 =?us-ascii?Q?I4NPbDNVo6ZmSD22VIZpRYhv57AUjTmPzHWwMp54ZSxgQKE0QcvWjJkdkoAI?=
 =?us-ascii?Q?4sHJ8Cba1e6jfD9tJs/jNvrmjBYx6T/+HSI1jpGycy7H+GekGPW2VCv9Nhno?=
 =?us-ascii?Q?S+H3OiM9tO7F/XkXEGF7zZX67pfuoJo2MZc+8vawxC9FMIeU4Bije1pJnfug?=
 =?us-ascii?Q?LgN1n892y/1jQKQSIfqHS3uH33XJsDitrB7CxC3Caj3m3zYYKejUzKo2/30T?=
 =?us-ascii?Q?OOCTlUpDsQaTuf9RxaTGKxA7fr+gaiLGdWRQBHUkrTcJlZrgE6tW+tjmxm9B?=
 =?us-ascii?Q?MFauENcNFDx6zqiXMWijzlaByTXQcUQ6lRYENxqgne4YHWpV5liA501IjZVp?=
 =?us-ascii?Q?eMFqbbt/++t596ENgd7viHvO6dRRGLtx6W5ZNMUAlL/QhkDMRUOpy5DFmibP?=
 =?us-ascii?Q?SBC0/fKi2PvMEOfKZ1SSPDZuVsOrmC4SdhpoVU7DkGNe4I8LMe73/Uq+7qWd?=
 =?us-ascii?Q?r+eA6SDkW2ixgswVx/Sj+KCYl9VFo2hTll8KZQifPpAtTaRIg6/gJJ8sE2Lh?=
 =?us-ascii?Q?8ZB7+5IqZrTfkbUg80WqR/zD61KnCL7X15gClDXNDBxPbFRhTh4wA7jm9aW4?=
 =?us-ascii?Q?3ohH2i7WE5vBmRKrqePehwDaS3VJpuL7bem3CrHY/WJ6HUFquVoxWzJEV0O3?=
 =?us-ascii?Q?dn/fSE9V0dR89rZdcCvT3EO3BV4ZnXXtOP1axvcuO1RrcLUay5Xspi3eUEhT?=
 =?us-ascii?Q?fZ/CMKxuanwdMJpetcpdFUY3HzEkVGX4sRglLPlpiVobZPTVTURS9wYFDjq6?=
 =?us-ascii?Q?/FHaT13d4c0Oc/6RmSDYPymWjZa2VbQI5qGMSUIje3x7w92ue2TgoWkrld1f?=
 =?us-ascii?Q?6mgu9D0d7Cj76C22KKcg9FIuXtZ2dXO5Q2OK95RXhvwHAhVE5jql1dketi+R?=
 =?us-ascii?Q?dOwTRFAcwyQQoyHxNO0VCSqSU/fdD0VLyzTJ0nhYJwO7GNcgwJUoxiHkyHDh?=
 =?us-ascii?Q?rEZ2qD5XMQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ULEtg4WAg7nv1gUMOe5ULJSHLSXKa/6y1euWhuDVyMlPodtL/N/yuA0AbfW4?=
 =?us-ascii?Q?nNqBmRCaLZO1CfdKjHUrvOYQgRQho3XdnG9v3Wr/UCnNAviWOQBJvVP0lqyu?=
 =?us-ascii?Q?7qjGd6/G72TwNlYIp1LXtPnr3VWlDz01aPf2ZeL1PapcQtiL86nWzQX+trq/?=
 =?us-ascii?Q?26ZgjC8Id1ntv6OngFhf0Ynr6aSXfg7lVMSsBjzv2vuYEdtl2NxwN1i9j4/O?=
 =?us-ascii?Q?o1KrLnds0wp+BIew7dK+ZVo3uA0pCdsO38+4XFTnsgmOL8pcRh7BO1pM7AAW?=
 =?us-ascii?Q?vwjNcu0BK1NFZaGcFoS8UHOUeQ+QRsCmwFO9h52qWYGDdD0YtA4Wq4Ua+BFU?=
 =?us-ascii?Q?3qxG0eyi240txgrB57d0sc5Hf6QCmbvkL6OCGvYc1rP/vkaxnnKYvq/eRKvz?=
 =?us-ascii?Q?G1EZ2Lbl3cbf+dbU4f+ABex+douzRyDLmKXdgEQ0DqFK2SuFTtslMcfHrlub?=
 =?us-ascii?Q?a1jzYelt5YWziHVAYm2Ll8KqV01jMSgbdBAqFJ8/edXiO+vCkjouR05u0+1c?=
 =?us-ascii?Q?YDtNuOV6bgohoxnCuWf/z3zSkraDzmnSc119p9B4kjtO3jmkv7zKoAqUzY5o?=
 =?us-ascii?Q?hCwOXkC+M9kKOGnmr4EEKbG1NZX6fD8NVbicoKdPbxEIJknrBeO7VgHn7hKA?=
 =?us-ascii?Q?RRSzkeCou1Rzn48+4CTqaNW9CCqffBAvsV+RD6GBxVGmYOPNsQcmsVXP7pYP?=
 =?us-ascii?Q?WeyLRsg3B/purBO963sGU07SijMax1+zEsU6TrW3lcpD2ReTr8S+FAibomXI?=
 =?us-ascii?Q?2chk7uFCB93h7I3uCR/T8STf/Yeo/YQLov3rEQ7sj/utaRUKkJfCOoTHfSAt?=
 =?us-ascii?Q?G5yNQU0pUb28lovt+US0EKnaniMK6GHXMjUZzyzgufbQVG7w/5dvPqyVR4RG?=
 =?us-ascii?Q?MfEEcPfCqktKLZP+vhgO8+AjEa31LaROo9TByMXNmbCC8aPU84D+/rRFEcpq?=
 =?us-ascii?Q?drZ4dApFIIW8QpyMB3VRmx3NxwRYqvIHa4ObXSz1Fx5mcRIZR9AzW9V2dDsw?=
 =?us-ascii?Q?4ywQm7JUr3LvZqhbU2iMnA+lCO407ciktE9QuqpXJut8Mvkxv4OZTycbGuOP?=
 =?us-ascii?Q?RheD45GQO0QHdc1hz8cRJ45Q0QICCh76eYVPckBBG/RsX0RkCHvbsO+lP7oe?=
 =?us-ascii?Q?CsegYz6dCYtJKFBqusBp87WjYxWUvpMz8lfo+j/4dNRcwM7IGW1ExwPOFlzM?=
 =?us-ascii?Q?XUODebvjui4iSP8uwW5oXLwxoGELVZMrS52y3NVOCy0z+zN7ktSL9PsL2ANx?=
 =?us-ascii?Q?2w1c9fi0VDKu+jQYmz7ikj3+uJFf6j+HYui9dV2KCAt4tBkiYoBgTU4OTXPR?=
 =?us-ascii?Q?1G5zydMfLgUDMhjtF5Ydu0v6zf0l8gwIVPlFkiODvKVLyfgDmqNo/63f1z9e?=
 =?us-ascii?Q?hsCLxCpnfdqzrd5eUsXi2clbvV0TU7xwyo5ajm7IpHHFdxFjnc+vRF890ZyC?=
 =?us-ascii?Q?LKhOGy9EQR6mHGhpMCXi77eBUx2i7AdKT4vz/tTpT2shpHygEwyDhqooidgw?=
 =?us-ascii?Q?AeJUVWAu7GZLTK4P5VrahOcTjRIVqmWknUxyYXp+Q0Qqa8GyJjNhUS36r8ep?=
 =?us-ascii?Q?IHeYs/fdRP6QkuwjO0klGPgSMbCgkOIb2A26ML7Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91eb746-42d8-40ed-5d87-08ddcf3b2e7b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 07:32:04.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NImzu78KoERBq+cL4dwMvEFoo1icPpYrIRDtZkjiF0FWyik9mP/cnXpPpO9KDdrSFnUcxb4DQoVXyKPxPxoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483

On Tue, Jul 29, 2025 at 01:20:07PM -0700, Dipayaan Roy wrote:
> On Tue, Jul 29, 2025 at 12:15:23PM +0200, Jesper Dangaard Brouer wrote:
> > 
> > 
> > On 23/07/2025 21.07, Dipayaan Roy wrote:
> > >This patch enhances RX buffer handling in the mana driver by allocating
> > >pages from a page pool and slicing them into MTU-sized fragments, rather
> > >than dedicating a full page per packet. This approach is especially
> > >beneficial on systems with large page sizes like 64KB.
> > >
> > >Key improvements:
> > >
> > >- Proper integration of page pool for RX buffer allocations.
> > >- MTU-sized buffer slicing to improve memory utilization.
> > >- Reduce overall per Rx queue memory footprint.
> > >- Automatic fallback to full-page buffers when:
> > >    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
> > >    * The XDP path is active, to avoid complexities with fragment reuse.
> > >- Removal of redundant pre-allocated RX buffers used in scenarios like MTU
> > >   changes, ensuring consistency in RX buffer allocation.
> > >
> > >Testing on VMs with 64KB pages shows around 200% throughput improvement.
> > >Memory efficiency is significantly improved due to reduced wastage in page
> > >allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> > >page for MTU size of 1500, instead of 1 rx buffer per page previously.
> > >
> > >Tested:
> > >
> > >- iperf3, iperf2, and nttcp benchmarks.
> > >- Jumbo frames with MTU 9000.
> > >- Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
> > >   testing the XDP path in driver.
> > >- Page leak detection (kmemleak).
> > >- Driver load/unload, reboot, and stress scenarios.
> > 
> > Chris (Cc) discovered a crash/bug[1] with page pool fragments used
> > from the mlx5 driver.
> > He put together a BPF program that reproduces the issue here:
> > - [2] https://github.com/arges/xdp-redirector
> > 
> > Can I ask you to test that your driver against this reproducer?
> > 
> > 
> > [1] https://lore.kernel.org/all/aIEuZy6fUj_4wtQ6@861G6M3/
> > 
> > --Jesper
> >
> 
> Hi Jesper,
> 
> I was unable to reproduce this issue on mana driver.
>
Please note that I had to make a few adjustments to get reprodduction on
mlx5:

- Make sure that the veth MACs are recognized by the device. Otherwise
  traffic might be dropped by the device.

- Enable GRO on the veth device. Otherwise packets get dropped before
  they reach the devmap BPF program.

Try starting the test program with one thread and see if you see packets
coming through veth1-ns1 end of the veth pair.

Thanks,
Dragos


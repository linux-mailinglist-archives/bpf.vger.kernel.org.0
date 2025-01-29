Return-Path: <bpf+bounces-50023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECECCA21815
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 08:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520851885119
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AE194C8B;
	Wed, 29 Jan 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pYrjbz02"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DD1922EF;
	Wed, 29 Jan 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135640; cv=fail; b=gvzhmT1+efyLYLxKaDpHIof/2eSfRwmboM4OhJ27xWRZS5jF0+8NpVh3To04KMN3gfXskTEwH8/f989diFQ6l8TrA8ispAy54n9XRaNtDoVQhhqE0d3PMpc0klMVmopTEtY2hFuXTSngWrcsPwUSxc7JIAYfXQAoFuFmRgNdoew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135640; c=relaxed/simple;
	bh=UsORE50Shxm2uzkU24CmP8BNtD6DOW8L2YaaXN6zz0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W5gsZkH0u2StmdtYPsyNdUCxWESy15Tury2Ykrg9Ybv7GOaMLT620KfMx7Brs6hayN4QJKaNl+xwQucOGj1LcsgoKREx+Li20RB/8DOLoN7tRwrLaIqgqMdfSI8H2sGdJtav4/lCnNfD4zxX0r6RbIOFslK7VkNBCQqv6xUwQeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pYrjbz02; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se2YBwcJhSMCf2uo2RiU4GW3+pUu4ioagfprezU6xOlBywaoWFJa+oKUQF0lQxkYvU1j2zFdRCFRA0EY99yYVKcaq283VaKq4cUMDY2MNzDKQjL9/aVx0ByP3qx33vzudRQt6hT9MFkWILjn5TBygKHYQJCf/SnAVFTRw3sg8p48WOQH2Bd63wO+Kl09cQL/kZ9CJpqpQA3drhlWDTYoXVnZyF9SdzIEgcFeXxYgImaz6AnUb7sLbhzrFfMJIzqzs20HuDhmdknAX1W1BXywq3v8Fb8NcrHn3ZVIb5hYxnuLRrMisNL4dnMLTepCqtiGI3EUTvH3ltQP/RDrl2O5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPo7oAJKLx3HQlv+t7YgXqS8LRWoxP97wx5zFGQmu6U=;
 b=s9F5kH7y7q33Lnqo+zYZ3f5/wgPD4cy1n9jxsmjZcLS883Y0I1vwV3uaOgyXh/yPKUz5kZ8eHcmb7IzVFGkrT1qfIeoaxdnYEdXFzDpBL2aeyaNKke+ZycHWRAO8UBCIcoMZD+5dMtUyGkgbQl/OWZ6zCJZ2sO9XiPAYS7JmCyMl6eHtzIpd9sokE4k9775dOMrrO35r9ez3ntgmBHxWlrUNTiP8M7rFPJ/7L2aDUaqdfBzfrZ72al+b14xd4qajunTeHHyiQxN8zIeagHRK+67XIYsy9oTXBBFuGAK+CIfzGAVD6K2M55jXA2U3D4sFo943l/1eLDdclsB87TpWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPo7oAJKLx3HQlv+t7YgXqS8LRWoxP97wx5zFGQmu6U=;
 b=pYrjbz02DuDiV85jXB/w9jp1v0U03NUJLTm1lO8RojwfTnWPpmVdLXLMVvoZzRGH+boApAQc1ZURGlC3kumwd7FsJnlM35TuxV49phZgAPKJTC62DYnMjiB5yQXRR1o+3hO0hNu3eZgxx/ZMG50+6SDAYHEjhC3US54uoXqRlMeGUTN1Wj5p4jRy0F+a8TSQhX4WlvKnCKjg9VjuYzDK9OwQpvvAel+roU3+1J/1o8Unx5N/YT1vuRmamrEs/fmPCfddsDkhdfdF8J9BxEK7AfqM51k7k6D/d462F50Ey8eCDpDj4vnU/rNRMCNlSslZSEaB0cEMya3jlNJLdWmLvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 07:27:16 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%4]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 07:27:16 +0000
Date: Wed, 29 Jan 2025 08:27:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: selftests/sched_ext: testing on BPF CI
Message-ID: <Z5nYRj1L4h1KCWE1@gpd3>
References: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f973ac3-251e-4fed-5e4e-08dd40365b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bH1vFx5silpf957krndWLJ3WqXyko9g2O19eoxVAmUsEsLRpfRdfedxsyf/y?=
 =?us-ascii?Q?xDOCijqUAhzjh/xtJ29zmcxOuEwgHv4zmB/grcgjTrsOiD8soQ705HwSgJn4?=
 =?us-ascii?Q?hXDLhmN1bwPNpMvKSTYJ1frdd6Vipdw95yqbdOCq+tXLqFQ53BPxbcJA0HYX?=
 =?us-ascii?Q?g2eoByjixb/HYyn/Uzs6ri45JMHCPhM2BLUur+vAPNZ2/A6xEUzyDV+fUwwE?=
 =?us-ascii?Q?1Vyxbtgm3uwFzzKE0Vpbq/miYrjI5myD195Avx3M9mkYYHHILqEFTVoBcZ1A?=
 =?us-ascii?Q?qP48Zqgxo/evAbESxGV703E4XGDlBH7yBl0q2QYY3dOWVCCbgpICkXVs/MHr?=
 =?us-ascii?Q?TIkeklQCje73BEr9gBU/L5d7MOqzqN/Rc4F7jjlFFbCv12yruA/S5nZI62mZ?=
 =?us-ascii?Q?15CmYNE7yqJlqWJ0rr8wNrqhZdtubetNDO5oLqNmanrwUyD02CNG5M6Mp5ZV?=
 =?us-ascii?Q?rmC8ZYru9bWn0UQ/1SX1xu/iSnH0z7VYxnzS/DBxlMuTswNN49l8ezk/gSrV?=
 =?us-ascii?Q?/2GONoIfasuOGRpURWNHm1PeYMWCmwYjuEsCu3r+lHCocqY9JbohnsMpm/rx?=
 =?us-ascii?Q?GWguJRWjMUuf/bWwY8lgK3TdeZqZxcrJVVEqIiOAM8a9niVONCLtpL4Qz/bU?=
 =?us-ascii?Q?y/u5uSACJNgKw3yDajrhPkbDGK+tGIz0zPuks142VNZyS8t1Rb9LyUpG3w3G?=
 =?us-ascii?Q?Q0beO7dm8B5Qe2woURtMDLptzNPaC2/a+ISd1zBcGpH5nviIw6vPSL48OzJU?=
 =?us-ascii?Q?BwmARH1FTea97e3DEhE9cObPl7+Vj8DN+6bONx7Fbg4VCM5//B5vMT0X98Tf?=
 =?us-ascii?Q?aNUHhRY9oWsdqVDI3tiwAC0k++0R8/rTzT0U70Ejn15JxzLIunQqfq5u1kCd?=
 =?us-ascii?Q?TcWewomdN+qrpQ6Gz3vXkQOjkHt7dCnqxTLcwts6diWdUhZIeV8yqsOwnv48?=
 =?us-ascii?Q?/Ti1l+TeNrGg+tRkje7LPNWhxid9dASS/kHqlNAPh45glgB3K4IPe3L4kdBZ?=
 =?us-ascii?Q?9jpVWa2k1zi4PWSdZx7BJvcNMBlgJh0kTQrTDToogu6oDdngswT1EoFORNKB?=
 =?us-ascii?Q?gUiFrg+AnKHCUY07+MELYXur9LgMfxVaSx0mLINd3yRvz+SxoLsubLiso55N?=
 =?us-ascii?Q?FIIPKzbI7BHL5Vd/oJwbPBBSKi0AXcdjG0tc9l8bV4g6IQH1Cs1WWxG6AKDE?=
 =?us-ascii?Q?rciNP+BCbLZV+Bh+BM792ND+aPhSPFnbIwuUJXwKWJKu7DK8PGoNESaRsQX2?=
 =?us-ascii?Q?9JLJ+aZxWuLvjZDePqTI5CxwuT7uc/DazE2ytA0LWuDrkkrTlH1kXx75sD9N?=
 =?us-ascii?Q?CPN75N2GjgkYu9eWIkvPInWVa4f6UtMd7tZaBF3HrskG+WM3ycyToxDkn0vi?=
 =?us-ascii?Q?NGIkUmdNx3diOJuydXEySDGCLH9V9DZqDVza+NjehTalJdn0fg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wq4c7T2d5aWKvliUuHCpr3UslwjgOIqJrACcJgoRhrU7T9JIKMpec9NcIx3Y?=
 =?us-ascii?Q?UjsEuYfvk6J/4hOfoeCr4Cf6p+z9kTQ8T00EvGuC7KJoOwDorcNmZRxgGgYH?=
 =?us-ascii?Q?6ar+gzf0f7S1codzJXiTneKLGC8Ilu4xSprxU2pnzWPMxJ1LS674feWDxTGn?=
 =?us-ascii?Q?4Ow+3aJJQu3V5OsuFsrqgVU7JR45fGZ4lL+AWW6imNvngL1OWhOahtUKYUir?=
 =?us-ascii?Q?aLg69SUHkDQNrQ5NqoLm1sSGlgo+7UY3B6xhpfGvXwt1aoef6kns8QjUgHkx?=
 =?us-ascii?Q?AyWmmIakXUq0Z/qwZnR82IxWtCvt5u9S7C/Yl6YfJafuDVdSrnhQ1JxRJ2qT?=
 =?us-ascii?Q?4JvA/pNAdEb95NrAlMUXoemtJzfC3VZXJab4kwI/WOw4q+KC8PlCyzXdadHM?=
 =?us-ascii?Q?zNDZYW2SsZMHPsF3WFEpBxlXeSM4ve6M9d9qCQdbBYWcDYsoEJppRvu1OsSC?=
 =?us-ascii?Q?JjUcKBO8uQyI3OKDa+wNKuljhPr8tdwHm575IMwOspuf3Mkr75LRZKMVv7R7?=
 =?us-ascii?Q?qcSG+1L9v4/bjyB8zFUxbCidFf4t2xVGP/0/0cId+xyTdy53fgBgBSbpN4/i?=
 =?us-ascii?Q?KKFpwqhfSPThdXykVkprDy9OLhX6r/Tz5a1hJLrzJzCBKOjJACQnfoGWC9L+?=
 =?us-ascii?Q?WRqXPhAORl3v8QeT/Jpl5eZcs9qahuTwIDI05ZPCosNX61EFePDS6QwqRQxo?=
 =?us-ascii?Q?Vg7BIFgLi0KrJtcOjUs1y2gWt2u/qNyGE+IWJfGGzmVJUxhFZ9e+omaigJjI?=
 =?us-ascii?Q?v9kbqjhel7KpncsrnVvXURQNVPf1tSDjsHh8Ubr61ENv7wdR6sgvb6Rxyz3F?=
 =?us-ascii?Q?lNPih5/G0WdbKMjf1p//HoId+W8j1fMuIrWh+eOQqUmTgQ9zBVRHmeX+E4WS?=
 =?us-ascii?Q?yyx138ECKLnuqK8L/PB/qYR+tU1PoLbLbIsEw4bf+aR6yfS+jDiJHv6got4F?=
 =?us-ascii?Q?RrV2ZIZWzlEq8Tgnq0/AgVK46/UqodcBg6GmpSFTcN+qN+nj0EMsEFb6urxB?=
 =?us-ascii?Q?aKxOIwjnvSeOIFmsYg0a6/tQ4RyX6fcRWy97qceEEFUY3zz67pAB/0sbndO3?=
 =?us-ascii?Q?A+LGC9CCdbMBAaL6CidkwUArDVySiiA9HnHwTij3sXswbxtq8x5OuDyu0jET?=
 =?us-ascii?Q?h9NC3CKgqREv3lFrJ580KwgksPYM8892nWgDLPnAiA8bMSZNamZ0ihnogR1V?=
 =?us-ascii?Q?O6dGjM+Frx4EsjSkG9Pl79yP6DAe4r/xyzxtEM6NnYBbN/uZR6xpcoVoQVDa?=
 =?us-ascii?Q?cU6VjFhfswXCACOzXLwEzFEbmMOP+HSvby2/3NIEYLbyfAG0pSs9j41KrkYR?=
 =?us-ascii?Q?cPkPB2Xatj8fxUNDiI/nfV2v5SZ5WACcWdyvtyyrYbPrBJ/bel8IV+09AfQz?=
 =?us-ascii?Q?wQdrBb7s3XmyjInriDivz/SwtLkOUHMp4a8/F7X3zxzHKB8jdg4N56paJMqU?=
 =?us-ascii?Q?DQEI0YjD1CE+AMS7likuXTbio7MyawRjYwta4Ij1Nhb2MbYXN70SZ9El1Zw1?=
 =?us-ascii?Q?24LGgKpfmzBoqTQiMga1S0uTU0lQx/D7Y2S5NT9KHTIZiDxo2JuX8cXdFAQH?=
 =?us-ascii?Q?sdyEL1zpvnjkKiDRexuWRMufRWTwVEEGBXW+zBcW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f973ac3-251e-4fed-5e4e-08dd40365b40
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 07:27:16.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBUym/GoWCu+8ibuVB2sDQUOkYizRvC0xwIJr6WBRtUSJ20FVOjFv5C4FoI2paIEyk4H9DeDlpV7LKfd2VmOfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

Hi Ihor,

On Wed, Jan 29, 2025 at 12:21:43AM +0000, Ihor Solodrai wrote:
> Hi Tejun, Andrea.
> 
> I tested a couple of variants of bpf-next + sched_ext source tree,
> just sharing the results.

Thanks for testing!

> 
> I found a working state: BPF CI pipeline ran successfully twice
> (that's 8 build + run of selftests/sched_ext/runner in total).

Ok.

> 
> Working state requires most patches between sched_ext/master and
> sched_ext/for-6.14-fixes [1], and also the patch
>   "tools/sched_ext: Receive updates from SCX repo" [2]
> 
> On plain bpf-next the dsp_local_on test fails [3].
> Without the patch [2] there is a build error [4]: missing
> SCX_ENUM_INIT definition.

We definitely need all the patches in sched_ext/for-6.14-fixes. I think
once Tejun sends the PR and we land the for-6.14-fixes upstream we should
reach a stable state with the sched_ext selftests. I don't have any other
additional pending fix at the moment.

> 
> We probably don't want to enable selftests/sched_ext on BPF CI with
> that many "temporary" patches. I suggest to wait until all of this is
> merged upstream.

Sounds reasonable to me. Tejun?

> 
> You can check the full list of patches here:
> https://github.com/kernel-patches/vmtest/pull/332/files
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/log/?h=for-6.14-fixes
> [2] https://lore.kernel.org/all/Z1ucTqJP8IeIXZql@slm.duckdns.org/
> [3] https://github.com/kernel-patches/vmtest/actions/runs/13019837022
> [4] https://github.com/kernel-patches/vmtest/actions/runs/13020458479

Thanks,
-Andrea


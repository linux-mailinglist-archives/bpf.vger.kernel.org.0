Return-Path: <bpf+bounces-51738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFACA384F2
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71761889FC8
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099721CA17;
	Mon, 17 Feb 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZSI5Pxmg"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406801E515;
	Mon, 17 Feb 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799698; cv=fail; b=X8N/fNcrHZkC/Ju7ivB38uHyvw1Yo1FtV5UzzWkD5WqBfXkH9y5nzA0dzew9+alRBs6z3vgBYN0ECqAXIdHUFt3i5wOSbBxibA0rmUNKIY/cAphjtck8mExTIhTdwYOi00soxRNyW2hikJw/LoaVcoH/AY1FPYQbRPKn2bXAxdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799698; c=relaxed/simple;
	bh=5XqAoGCTb85A5tJY8O88yfcKAuXYXs5RQkGzpO+MIaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxCSm55d5z55sN0PwjOyLJ7WMUK59tKErZBUcFOOeiWTNMG+CfxGneNFIdBUr5Rgg3Y4fzOWQFreCnpoeX/HhUf+lpBdz2NKHd/YuHU6apKWm86yfqhXMS6EybJuSmnFd/GP4K+qluNysoTK8bFB+elDRSe2HKXIqFWWQnnGyxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZSI5Pxmg; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB7+LNA4a4pQ59wirclB+PhyOFO/i0dF7BwMhI84ZvIn10YZqycWFDfIoxvCnbdnDWRPiPA3Kn9k6SyKzX163qwADFj48OvVEhchZNcpli5pxeaa+iMZ8ZUYEgyLuX6u76yQ0DiE7ZGXTs8YekK59OAcSbpT83K6hDSvf0oA50bgyYAFsNCVbB12bxjbKdvQnpLgm7zQYgl1e8b+R7tOYPs4pBdTln011dPUCE8DXGTei3RnnugPWMLbbeeyIJnvLQk7C9Hg4YlORSrnysBIGr2PUfSkTzSN3Rzb6j4XMzdpiBdCSj7a7AIzWT0gpZhG74VO8K0OxHR8MAOSkgdNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxw4vdlRLBFSC/n86fo7LfA7Sjl2PGQ3fiINIekcgpA=;
 b=Bx2v7U1Zerz72d521AjxgUr81WUhYXZ+7+3hX9GUsKr6ou7uG8fNb9txLoXkcSwmKgGc6Q9xV/V5OPKUX9ydYbIww1JGlrP93dk5+niB92/R0/r1KN8DJtmGNUc8Cxmy0+BHTfXG0BCPASpDTTBFqmT8pfa5w7tA37RtXB2XUhMbHTUVZH545vGjniXsp9PmU+GeNaqLV0tsUz+AaKFA5Y2jOrLHU8UK3HhozRJUPBlZqeDEm3ABqR7liLXR7mtoh6luQ89hDc8Mjcg9RP6ogYl2eRcs5IAKyttBnfcW8o8N/sDLGpns/FJ2rNF17/RvaeSWMzMlPCTrr9582/pKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxw4vdlRLBFSC/n86fo7LfA7Sjl2PGQ3fiINIekcgpA=;
 b=ZSI5PxmgOLnIEFYH5Tuv/E5CoJd0b2AZoWQUyD6KYubW2UZt2ro2jSRNE9BT08fKPdXaPghgE8sTe7+4upDKbI80PqDtfi9+RDnPYPbYEt+1bQSEnOWP71AH3XmnMBrhEcoIg/5UnvhHPdNHhqMgRqd3ZMjRdUXjZqi0shRUDuXA6y6iiuNoppORnKrs3T3niiNG3SgU8H05LHmbi7QBjZUqpBlrPUMt/XRGPeIWi1afk1DsUhr0rkiFKBZBUlH39FkaEyieJiYMMKpdBGtle165PS/5bQXGuXUonoAhhORD1dnsnIborWWggOcKI+Ab6SeG6DcmDbCmJdMQRq2JYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 13:41:32 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:41:32 +0000
Date: Mon, 17 Feb 2025 14:41:27 +0100
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
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z7M8h8jGEPoPmmiT@gpd3>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-9-arighi@nvidia.com>
 <Z6-1mQMBhq4OOlvB@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6-1mQMBhq4OOlvB@thinkpad>
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 75593f8a-6b79-4eec-d50a-08dd4f58ca09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0M/t6FkD8NxkN+J8XZFh281oj/docGAO8FoLaFi6wd+UUkPWoA4O4PlCveZ?=
 =?us-ascii?Q?fyuTpFZoeua5YnqzNsi0beeS+7KGQxBUa3LiZpxaTYNwizk+pSVkQSVjIZEo?=
 =?us-ascii?Q?lSuG6xUJNbDNgV/QhAIi2UH5ArAvE8Tf8n94MjU+GpecW3RHCKqxzsR9/hLy?=
 =?us-ascii?Q?aXvHRol4tKy7NMEEzvMvd8HoA2+fjx7WsKTOMT1a7RWXywNirULGDbLvhXtj?=
 =?us-ascii?Q?bEA2CEcl3wNq1AXdzIw+cXB130t7nIJt4a+Fm9Ydj60JE98Lfx/IrmF8Q33u?=
 =?us-ascii?Q?BaSFXJIYCuCDrVyxkMfpQQYnTq6hprVZ4guABMgGU0FpogIGIhOBPvkoUZk1?=
 =?us-ascii?Q?7KxZ8Aq6oBLGXlMBb4sgU9CF4OC/0hMDy38Ls2ubNLMtXmdattWiweUF7QaJ?=
 =?us-ascii?Q?rNnbjdJsVG2s7ZNRtYwvbcXlvhSSw39mu4H1wk1gXvqc2UdQaVc6aaN1/xyu?=
 =?us-ascii?Q?msmEPWFiUre1RDVokf4hJTCwUt0wnqcU4E5MWwVTd1gIIUgmruAfPpoA3m+I?=
 =?us-ascii?Q?qF0wFZ6sgtioXO9H+hpC8oPoVacLqhuFBz5rpPc/Bch/1ZcnjKzV4CDsaBjS?=
 =?us-ascii?Q?sGssUpwWN+gaiM48qRuD2nfYBt9+cJWlytzHGEPHxDP8fj+plhnx+YI6fhNc?=
 =?us-ascii?Q?YTvNe7fdzmiyn3zUNfTZTkXOqr9w4kh2rhteanHs/YOulfLMlDc4s04FjQub?=
 =?us-ascii?Q?O14kN0/OaRcZL4EzaKNIJU8Vox41LjxBzkFXh7Cug3C8AjItG2QRYPrV2YH5?=
 =?us-ascii?Q?cO7lUrX/a+fmb9hkN0AOx6FYDZPGqfUfl47uZYK2Y7Cdzb+4nH9sADPsehaO?=
 =?us-ascii?Q?vxg3piJZksLqUxhzW6QjUzulRwWNmSMtPMM1if9OnTCC88E4+lQ8fLnYdJn5?=
 =?us-ascii?Q?6t3Td3IEU8J9b1BbIuESN1p7lTwXPu/dz4zgChb/h3BXdtZX5yEqDWR5Mv7o?=
 =?us-ascii?Q?OkxHHTwBk/PTTBdXXWEHXiypXcZ7dHk4Q098+jbBxHh8RMlYIWEZ/oTbINSd?=
 =?us-ascii?Q?MIW0zjGZl+ikpAjMrD39kI1V6MJQ973mTl68YFSnL0HL1ijB51YvkMu8pFfO?=
 =?us-ascii?Q?TzJAHiu9VNskolsTtALuovCPpqB05MaR2N4kMS0f76Nt9ugzOX7Mbq8ZK6nr?=
 =?us-ascii?Q?iih5zKAYjHtthwwqO+IMNyHNyRl8eEWA2UIrWMtTzlkZj1gmE05NPj1N7R33?=
 =?us-ascii?Q?zcqREu+s/jKfSAmgsHLyi+DZMOrJy1mIr1sIy3TdetphnL3rMh0zkI96fxfy?=
 =?us-ascii?Q?uoNFKPatwIOeFvCfMgY6dZDkVetnQ2okis6u8S+8voVFdr3jnKNbdY+PCR26?=
 =?us-ascii?Q?yTPRQW2XKl0iAW8tCIgQRvPkvnMpiwlMlWdxSk9lsfkZMpAGaM5PvHEbH/wj?=
 =?us-ascii?Q?pymdGAYmANO5lpQ9hQ9ln/XLsZfO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYE0HT3bK0YeNBZo6Q6gMVZn9kLSHNnYtdX7gwutXfMGldOzqR0qo5BC8RgC?=
 =?us-ascii?Q?+2uptJSyufxRqlFAGUMI+gJtLv9Ts5nrQsuAluqQd8OsAEU6QGtdMvZlzK1W?=
 =?us-ascii?Q?a+zJew9VlogYYCOAybX6Qf9RN+79U0ARrF8zi70QMDzTH2zCZBBqMY6AAvjq?=
 =?us-ascii?Q?UTRCygz/L8LZydj3JGKxa1oGXIgy+AulvwU1kjxFnequGYsd4PUTxN0Eu/K1?=
 =?us-ascii?Q?z3rQJAFOS3+2JAAAcf2CJ2OuRYzE6Qt9byM8HLEBwXrzfZVmdM6i6TPpbBVM?=
 =?us-ascii?Q?5ZAidEToslX6Wx9L3bOQhabqtLxEo2mDlhgGWvQzPMkc6C3rXCHaarY+Nmlb?=
 =?us-ascii?Q?2iLYSRW+OzD9BCmsW7LeltvXM/XnEg0JIY/ivmUFor9pOP4GiYLhPGcUUB9w?=
 =?us-ascii?Q?Tn0x6P6xozu7iATssmbaOGosErfBTpy1TiivrQOP6Vccy0mIZ4wiY1OwBdi3?=
 =?us-ascii?Q?DXxB5YsRXJE2ZQVd8IuGRyEQFNWRdA6kW9Ue64VFPfPBRfdHOFhi240dnwg7?=
 =?us-ascii?Q?ANW226SdpRHC2GtgFGFaDhCNszdfIUs2Kj5NR07st80dqgRypPgxnEixqNAU?=
 =?us-ascii?Q?6qHQ5GcE+4cb4nwwErwXF2EIRgxcnr3fpb7Th5AVLGRhQSiPGV2WjYARrkdw?=
 =?us-ascii?Q?2vQ0H50wmNLEj2lr1+wqlC2/BzFx9Rj/+KHORW7wgcOF4DzMsaKo0Z+DaoO7?=
 =?us-ascii?Q?EEEteF/2LBWsTq0T4h5bbo3F30GoaPCgmq6a3R1msGrnAhNhvqrOE/kbxd+g?=
 =?us-ascii?Q?9pcLwDxUQJ3UaaJEn1DMciA4MhxZjpLzJdQ6NrIIQUlJbuq5tDXFxSXPg6Ee?=
 =?us-ascii?Q?xEoetokCPYPmi6jJygny/ksPETdse+H+zocMnDyicX1k45euYolFK4JBoEBk?=
 =?us-ascii?Q?oTqUOjwze4d6wsZBeqQkD27bckK8lN77Oaq+bjNnkkcXkbEAASarWr/4PkmD?=
 =?us-ascii?Q?LUAX4ZM10IzcwhJZRxGdFUEqgtZ9jzuLrkcsFjIfBKLdZNV+hj9UodLKsuCW?=
 =?us-ascii?Q?qWfikjKaFls3ifIKapJOvkj9o35GDP59K0uKNLebUgsD137N8KIFvbP/40fB?=
 =?us-ascii?Q?iceRsnIDlp1TTjQecLwi0qPtPr0hfcn0T20PpPJAInhuPt7E4NVfSvr9uG4K?=
 =?us-ascii?Q?AQohKhPWbVvTivtLPUgqgW8hMOvR3kGMHN0dv1QQiCyghJmt9OqyKhy1Fy2c?=
 =?us-ascii?Q?/87Ejb7OWmqSVWN3bvOrXm7J+7Ne/jdciHzFMEfbso1p0ure3v9f8vfZfirv?=
 =?us-ascii?Q?Eydgo2F1cH6Nadela12AfFOPZ/HN3V98x9t/OjqBKHIT9kfIo8vn00B33bzV?=
 =?us-ascii?Q?QUiY5dqOKBges1pDTfbKlvghvX0TV272pZK4KoC9JY3aUzxsTMD+fkUhpfFi?=
 =?us-ascii?Q?vJCj4jGPlmJZ2t2oONB1gZxxOVp86ybjVPOlNKVmHE7HGftytjLMQFO5mE+z?=
 =?us-ascii?Q?I41+g8JMrqFXT2gqSJBojpJgQCwz76d3G4O2rem7EwTXLC+nDAgc2zvr0DnJ?=
 =?us-ascii?Q?0Pgpk34auG0lh2+2wlz/3Mj9DjK0EaA25R2htpDRUmIqrNR8pBgl/m8EYfqC?=
 =?us-ascii?Q?P1wlRvcLej+/LesXbSQaQ5lehQ+tVRNBFPyMiQ0U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75593f8a-6b79-4eec-d50a-08dd4f58ca09
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:41:32.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dhRLhyLsW0sh1dZTBov8q2kt+4WVJJAVrORIyTLKZJ7nuqrLaIDzTCsxYBGJvHvGhTWhdyqkm55dZ3KXFQECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

On Fri, Feb 14, 2025 at 04:28:57PM -0500, Yury Norov wrote:
> On Fri, Feb 14, 2025 at 08:40:07PM +0100, Andrea Righi wrote:
...
> > +/**
> > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
> > + * idle-tracking per-CPU cpumask of a target NUMA node.
> > + *
> > + * Returns an empty cpumask if idle tracking is not enabled, if @node is
> > + * not valid, or running on a UP kernel. In this case the actual error will
> > + * be reported to the BPF scheduler via scx_ops_error().
> > + */
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > +{
> > +	node = validate_node(node);
> > +	if (node < 0)
> > +		return cpu_none_mask;
> > +
> > +#ifdef CONFIG_SMP
> > +	return idle_cpumask(node)->cpu;
> > +#else
> > +	return cpu_none_mask;
> > +#endif
> 
> Here you need to check for SMP at the beginning. That way you can
> avoid calling validate_node() if SMP is disabled.

As mentioned in the other email, I'm not sure if we want to skip
validate_node() in the UP case.

I guess the question is: should we completely ignore the node argument,
since it doesn't make sense in the UP case, or should we still validate it,
given that node == 0 is still valid in this scenario?

-Andrea


Return-Path: <bpf+bounces-54224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB4A65BB2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6C83B7A76
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B01B3952;
	Mon, 17 Mar 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJNP1Jmp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC141B043E;
	Mon, 17 Mar 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234275; cv=fail; b=TQgZDn/TZkVzRvs8U1dFf8OWxZSRMqu0WMQz0s0Umt/Hxzaa/xrChO9K4P92C5zL+nrrUs/N4sc0zJG5b0vRgzHJJ4ZcVMfC4JHU8VVHYZjmLLzAoYx+ch/Az8nZ1vkN4PIiDVUmqkc9+fIHBCY+lqMcrEiP4IYAv9n33xyS8Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234275; c=relaxed/simple;
	bh=ImQw7EwL9efOvUCMnWUXj4YK+duFCy2Ne8C3fAHntzE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fGoXbyEO3JKx3Jj7uBTewQYNACXU/Y7mT0xiRuFOfoHQLTz4WDBQJyKq9H0RdTG8adKnFEWm/myW0eDF24nUh+67pGKbFO/zQ6jiRAYpC18hQYKO4kOLkvQzwCrPANMgftEOczveDfuQ0ivymg3KNy6Tq2i6h8nzU8MGm/sPurk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJNP1Jmp; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlpM77OrwTyFMu9jL23+p1i+iPln3F5wd+hiNptzKnobaVHrz4pVIp4h+0qd2Q2cusFZ+bGoOafZkaG+q9YrUzAUPVlqyq81hJ3r7fbCqTTAhvViA1EAukBiAPYjSgu5bV4J8C6kDVFBnkhiYeFaLGoDZcgGYE32JWTYsH8CZJp7+MlOx7UEKSZO3MV9qYzRSGPnJcJsThfpfQnJDI9qDIccw/LVID538l9tdC+Ics5yupls+dd4kZg60AXks2ye1g6tLn+8jdH8YBaCMtZylJHs68bKzbmAcTig0+srcrZYNYsvhfGQtt+n7kcLAINqn1r9LufeyvbQnoRJ7oBpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUqTNql0JwdfkPMo/6XDfY9Q9CGpTKrrTvgCl0RcLgY=;
 b=JibD0fRrvEaf3SCf0M9JpeaMFRpezzBwvaDIBLdW9PiKkqg5VdfbI0Tw+kLUJMgi/52qsMA8ECD8xazOTvcEloWqjH1SOrpiAG8BMvBKWd7F/XaZUMZ8mCfZfu2jFPr4vCJtvaUFXOS6MuITb85GW7xiFcGdT2J9s5fWD+A0oQGFXTE5lB8AsSfpC4Nyq4yBgcmGiU+ZKafldgy0jBvmcyX3ijrcX2CIzn6mfsXg5oa7Xnvn1Lczbg4uVGM8KrOadYJCgpfJBp1GAijhMwBMk+mzYAT/xNviWeVCZ1zgtrMB8ZIB8z4J8kngA8QWWHrJNFH9kkBVCZU+5TBjNkabpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUqTNql0JwdfkPMo/6XDfY9Q9CGpTKrrTvgCl0RcLgY=;
 b=aJNP1Jmp8oNnlhEiAtAwZS/nFfI3Jkm9N25pLqOoeq0+nhxatfC6N7sMnmqxTSwi5TPHCV5hE6+9Psqi/lrK6OZTUdDqd0FytSl/8M7JpLEx1hnCSumDUUJOMaBdqtKrfRfSlSvrZHndrmYSKPdhgaAtkHXxcRXccYexKaQoBxeBMd5zRBYeRW64Q/mClG1zoG+7TTql/j8buOl719gompfsQMnMLSzqE1p3dJvE8IKowRgFbvbd0zIcuIcL/8E5J5MKZmk2l7h5jrSDNn8vLwMy3i/z4BHUKkUfd7JFa4ZUicKIIWDXpQA7koVgWaYh67cAHLb7CT3Zf3+eCkIQ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:57:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:57:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v4 sched_ext/for-6.15] sched_ext: Enhance built-in idle selection with allowed CPUs
Date: Mon, 17 Mar 2025 18:53:23 +0100
Message-ID: <20250317175717.163267-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:205::19)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: aa351449-02de-4365-8897-08dd657d35b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aAWlWHEyNGUTxSL6k34DoADg2fHzpOUclrIS0ts1v+4yaI2yp3Wq/1aB/BgL?=
 =?us-ascii?Q?TixUO6DwyswNorDpS7PQQIb+v6/9tCVjtHaYDQooKcfK0G+xMLvC3Ci+Q+Gu?=
 =?us-ascii?Q?a1uObVFwu+2xP0RmmH4J6zuaj9WQMR+KM7lrVEpTXb1sZUrR0pjEYHF8S9c8?=
 =?us-ascii?Q?VmRklAvKVPVqGzlZjhNhJSoE2N20wSu2GBpOys+vcBCpjnd45r0uykFaZm14?=
 =?us-ascii?Q?MkFg1euFN6QxFbcLmDluYBOXi9iBwWvtOTfImJDw2rVPi9CsCmcDiEzK8ID/?=
 =?us-ascii?Q?wFLg5Z+VtX0g98LekN7c96lCE3SKJXvFA6IN3BQi/pXFaPLJWLQdhzCteMB7?=
 =?us-ascii?Q?a15TIN9jC+fdI58WCgSW8thNS1d8gcS0Z7yeWGsR+EjhkInElUKr1AVA4dcw?=
 =?us-ascii?Q?tLHWTzMHHUnL6MMjYXwB9Jm+AcrQnwILnnCeQd76ccBAU225givz/frfy+gv?=
 =?us-ascii?Q?V5s0Ckip2P8BzyFj9zjK/avMOfbKjhYG4LRz5GHdbTRKmLQIj05g/F6We64g?=
 =?us-ascii?Q?YNftHsdokkRT2vGmAayPN5I/i+qLeDACERZ6vuHA3O6VIsyg/bQiUs8Em2fz?=
 =?us-ascii?Q?cVHVMnHnDzsmgCSYSAlPKWsvvNddE4FVuipRygrWds3IfEkQuX2IGmOnxIMH?=
 =?us-ascii?Q?W2C8GE3KqAc2I4EJ9EtAtiLzCJxKGC+D6+bSDZX3vxE0feuBv4niFYUiDXcV?=
 =?us-ascii?Q?gk/z3Ehq+VdmymDYlGHJ0AGBIMj1vq6bQT9lxwkmo32iyU1o0hnmiaJWg285?=
 =?us-ascii?Q?BJTOgEJZbk5mS37wc2x7GKJpZ3S51bBb0txbi7pG/ExLBoR4wLzJ5xVzZXtr?=
 =?us-ascii?Q?32/RnwdfayEroSO6mXmQ3LM4IuiM6zAMCFF972xO6qjwjO0QFcQpzmepgCnY?=
 =?us-ascii?Q?IXT69ERVzpFizvgbxBa8h6DloWye9c/lv6xGiwD0eRe0Dfl3DxKa4gYbDAPO?=
 =?us-ascii?Q?yINM2LbxcklGpf166ziNQtT8fRJKJA8ZMTQl3ctZWPuh+PI6C/5Y6Au5b/of?=
 =?us-ascii?Q?z5iseA3cfBPKNeiHymFaM2ERA8jNbTGPoLjqFy1HO45sMhfmzExEwQs1rQHT?=
 =?us-ascii?Q?43GzLR4Rk8QGcYkaOca+N1Pn2BqCdaVcNN5UQEX83i/KejhrIVMsUTML7co6?=
 =?us-ascii?Q?rrxeVgGgqkNQUVLQUiyL1KJmXxL9BQkDG9K6PkiPTY8OFvlUOPpwOY0DQcRM?=
 =?us-ascii?Q?LtZ4CFxlI4RWSckEccAFNtGLcR02ee/gPhzEpYrdKu60kIHmBE8730PcnOEM?=
 =?us-ascii?Q?haO+uoPHeKjsqyfP6vl8XBn8RTJF2R78Cxb04vM9l5lMNv/gFpXwjTGaoLtU?=
 =?us-ascii?Q?zeB8cRC5A2tzRqMcaywkFmQaA+gWJWtEhUHkDrj16OiLmzHwApIx0AHPaEH6?=
 =?us-ascii?Q?xkkYynG8soY7lR7M1e/DKZlT2K8m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qNe+4rWqSXHhQBYwJ/3AvwL3VkbXXJmwy0hoLE2StalqIgDPdTl4RDLS/tjm?=
 =?us-ascii?Q?th5PRSt7zwdbGpY+6saTbH4OQTvTu0wOgYHiYlUH354B9/UPmxSDEiaaEQSq?=
 =?us-ascii?Q?D4JcZNaI0X4VYe9ZUhF35lZz3Hj46q5K51fJf3ncVRddp/SGdeSmGD18f/4R?=
 =?us-ascii?Q?jH7J81x+WkAXYsJPI9ZtUnkU+R9lOjyfpmu2UUrLlcsVJ6e0TWnk+QF19l7B?=
 =?us-ascii?Q?ubtknDKHskLnukvxtLqrel0GPlOVPJIOHkEJO1OkWMA4AVUnGioD4qekmLcP?=
 =?us-ascii?Q?P1PEExxVCYLyG7ZYxTO5wmJ1lspRXmvoL6FjLXQcJg23doPD1q+IrU3o/xgS?=
 =?us-ascii?Q?oDz6DBohYwppOY4MgP/SHpGBnWOe2t8r2eQkARccBNTUsww1gQt+5eNE71Hf?=
 =?us-ascii?Q?XQumILbYqS1iOg/tw1lVo/0pGRA8CTmAsJXqxlO4qENd7yZ+G2koUG87hZwv?=
 =?us-ascii?Q?D4kmS9SMdNW+MSdEbiheQAZfbPGzLwQ5Ykhptf6tQQUSgGgPnzLa1h/3cabA?=
 =?us-ascii?Q?Ev58W/9cLvxQdKl761h3WLY0M6rzDlAjfPJRHSyPsCEbBX8vaRC6WQKQJ666?=
 =?us-ascii?Q?viazo6JaGcSRPhrWKdRzbAD634ixyvtViyo1htsrUmpIBeNauV5TkoYXhx7V?=
 =?us-ascii?Q?SV6DQFquk01HBDwLRpz+cjJMy+bWJLtT3XX6+2mrstzeKYjZWr7/V49OyQWF?=
 =?us-ascii?Q?HjhTtAYTkTwthQRt8aMb8MeWdAjBNopPXo+CotfviQ78SPXyaSeZJzP6v7Qx?=
 =?us-ascii?Q?NyasYHbL6D9CDotKYMrLB+F/59GPgk4KxfWN55zECiDbubQrz7KM00oVtUjs?=
 =?us-ascii?Q?Pwgzae14lZUSD2Jm4gjYI/D02GW8ZtLKSvTmOSrd41vdyH54dNg4+qZlzVzK?=
 =?us-ascii?Q?e1YE3J4lU33SAgnUGsAFr/4SHgJsjEh3idf5SmB+ehWDOTdJw6fBDeJFsUJF?=
 =?us-ascii?Q?aMM3NaXhg0uSl2drKi3Psf6jeAD107YWIMFWQYFYBYXmd+5v3WXXCOQ61XDt?=
 =?us-ascii?Q?H0j7wknjKo1MFMBaBV0D/wEd3jxj8lXVEFW3KHZcms/hw0ZdWufRxvhIwR3e?=
 =?us-ascii?Q?KPfl475mRr5W4P8oqmb3lu4aBMXJztsr0FLuMr6xXS4S5s0iq/3vdCsnEqK4?=
 =?us-ascii?Q?2f5JT8sWkxGqXqrdJ5+XcriXmNiDQbIUNYiiujPeE383hiLS6zrbNeDrw9Xh?=
 =?us-ascii?Q?OuDDV5+mpv3LWAe0HsbUkM40q5EX4Iv4/eLWKsENtQx7bw7XPsTd0Q4bi1Je?=
 =?us-ascii?Q?wfiJcS9Euy6if82nK3Z7FzuUd/zB/wgW7/85Q4q7gF/RVpvICz03gEXJaXJY?=
 =?us-ascii?Q?bAToX80bhm3KqYrXQUuugnDQpAuMWtu+czAyQQ9VJY9xZWGq4UCgefzOnJ6a?=
 =?us-ascii?Q?ZWdNsK888tj6qr0xzhgsfpUVVvB1N18WuDO6io084ZhoFGnnl/krhzim2pTE?=
 =?us-ascii?Q?xLRfpqrzXAwnYip3yoJM25D5vNyxvIfoV8usMRRJ6YTo51th3YDXBpJyCWAb?=
 =?us-ascii?Q?DpFxebRKAJVmTOcPBIqgbOTLTpVqd6C5/TZ2JPCn6UwSONkcYUkFawoy7FoF?=
 =?us-ascii?Q?rQHpMYLTdrm6hr7LMlNL0imr6CkaTsELH4f5q64y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa351449-02de-4365-8897-08dd657d35b3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:57:40.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9bhlhEhV4Kp2MJowAgPEVeX59szjho9HmreQK9NZ07ltXUEDWmV6psKAooEacz238PcDQr+PQWExQZTDb5XyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

Many scx schedulers implement their own hard or soft-affinity rules to
support topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., running certain tasks only in a subset of CPUs).

Currently, there is no mechanism that allows to use the built-in idle CPU
selection policy to an arbitrary subset of CPUs. As a result, schedulers
often implement their own idle CPU selection policies, which are typically
similar to one another, leading to a lot of code duplication.

To address this, extend the built-in idle CPU selection policy introducing
the concept of allowed CPUs.

With this concept, BPF schedulers can apply the built-in idle CPU selection
policy to a subset of allowed CPUs, allowing them to implement their own
hard/soft-affinity rules while still using the topology optimizations of
the built-in policy, preventing code duplication across different
schedulers.

To implement this introduce a new helper kfunc scx_bpf_select_cpu_and()
that accepts a cpumask of allowed CPUs:

s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu,
			   u64 wake_flags,
			   const struct cpumask *cpus_allowed, u64 flags);

Example usage
=============

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets / 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses the
new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:

     $ vng --cpu 16,sockets=4,cores=4,threads=1
     ...
     $ stress-ng -c 16
     ...
     $ htop
     ...
       0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
       1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
       2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
       3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
       4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
       5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
       6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
       7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
the available CPUs.

ChangeLog v3 -> v4:
 - keep p->nr_cpus_allowed optimizations (skip cpumask operations when the
   task can run on all CPUs)
 - allow to call scx_bpf_select_cpu_and() also from ops.enqueue() and
   modify the kselftest to cover this case as well
 - rebase to the latest sched_ext/for-6.15

ChangeLog v2 -> v3:
 - incrementally refactor scx_select_cpu_dfl() to accept idle flags and an
   arbitrary allowed cpumask
 - build scx_bpf_select_cpu_and() on top of the existing logic
 - re-arrange scx_select_cpu_dfl() prototype, aligning the first three
   arguments with select_task_rq()
 - do not use "domain" for the allowed cpumask to avoid potential ambiguity
   with sched_domain

ChangeLog v1 -> v2:
  - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
    select idle CPUs strictly within the allowed domain
  - rename preferred CPUs -> allowed CPU
  - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
  - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
    and provide all the required backward compatibility boilerplate

Andrea Righi (6):
      sched_ext: idle: Extend topology optimizations to all tasks
      sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
      sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
      sched_ext: idle: Introduce scx_bpf_select_cpu_and()
      selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
      sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()

 Documentation/scheduler/sched-ext.rst              |  11 +-
 kernel/sched/ext.c                                 |   6 +-
 kernel/sched/ext_idle.c                            | 216 ++++++++++++++++-----
 kernel/sched/ext_idle.h                            |   3 +-
 tools/sched_ext/include/scx/common.bpf.h           |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
 tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
 tools/sched_ext/scx_simple.bpf.c                   |   9 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 121 ++++++++++++
 tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 ++++++
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
 .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
 .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
 16 files changed, 422 insertions(+), 91 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c


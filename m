Return-Path: <bpf+bounces-53496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1FA554ED
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E113ABF18
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8113D509;
	Thu,  6 Mar 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JMhMTotU"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7B265631;
	Thu,  6 Mar 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285569; cv=fail; b=rdFVJMI+ImdQ6EL59A5LKG5J8DUfkI1Uok49lDlfmfweMcDJ7oWpGWxdUKtrST2dB85ZbJrZKc8F7UMffnIxCMvfTqewimxgwdf55wtmazRV0S3BPUscyc2p5wltEqmTWvZQv23Nuk6pbI48aL9DbnMVC9Scbor3JB1u9R0DYsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285569; c=relaxed/simple;
	bh=WewbsyIb8QZKoJUoVnksEaV6ppvaESDJdlJPv1m3RNo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=am6giOD7GmP93B2NlIbvHJ7r4zC5QmNr9F4wVxc2FsMj4eywhgoZDS7fDahytugz2Hq/4fRkIZGSFtPm3AWbTT0xwXTV4ixga4+QRfVdQBJHxFFn7qzfBxxsTMwBxQmzinyI+S+ViUrgjzOCRGwoBK1nIYpwasKc8Ga6+0/Kpiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JMhMTotU; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj7E0C5Hk4Lux6YII73diO/Lbz1IpypFrHLraPtr9RWwZ08+dCgbOtkWPrekoKEQGON2RVXwlObTdF77xS9THBeEMNUF4qx3H18lw8zX2BIF74ywhv3K5B/FNulHY2JLwQcVWsgpBNbDOEAUsOrIjzGlv+JZ1pwCO9+2W1NtjnK2hEzybKQsQUhZyskbMRc3uN2UrV485n4kNCBjq6tS0qoLqczpYuDuCyJWc+69juq4y7iZVF58xqzeyDS2kNZP4+LBYNV1F+Qb0j94O5mX/vTI9Kj/rKMYApX+J5ShyDwwSwkh526ucxCsWw3CQWnH06kGYW6DI5QWghoRpdH9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XczncDd0ObfBp0McC2ZVPp8xHHrSeD5dYF/esl4C0Nc=;
 b=cFB9MOihHK+G7hyWV7bGSFAKl0ozM1rU7OjANcLG/986LjokUa0Ios8f7VTOWwhW9DiM/XL8l33H/ODS893Dq9fw151oLLAC77FEB5h0bhULfKpD5adXhEqQsc1zgpkSjOQrc+l6CwkzLpW/zL7LgALx9JugjFAB6QwIhrpPz8QisieRGebuXhXE9CiDg0X7uFg/bwQdgO6RVvLnUAVUZbhtp/maTTXQ5pxAnrGiWmCBZAWz4N+TMedauEju2jReue9qtEmbBwOwRJemVCcXd4RvnWN0as+gT+aMXXv2+89qvfovA+ekkXbKPJtutLzdJuHGdQf/rV65ols773Jz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XczncDd0ObfBp0McC2ZVPp8xHHrSeD5dYF/esl4C0Nc=;
 b=JMhMTotULAAS3MOo6R7Y4tCmTu3cHg/g8rj48my/bobTVjzvW9Os/rT6SAzQvZxST88g4UU+SglYsk6VdFh1dkluRbNsvAiL7OCpXUYzjhoFATU70H1UmNqKKx8+UyZgoP7uI2sPRhrzTdiHhn4GU2fZ1+QweM3sIrQtUg06tga5C8z/JtFrEkRYSq5kmPoKEXg7rN20NAj+taJMrWsDQDi2WFmLjIU/2LhKSh8lnIYslFvk3Co58tkOBpM3kJpLpke+KJw3ewTohadPe8FyHLqH7WsWkgY1iMQ2YU3/H2BEBBN+NftMPYRZM6f0Auf/nvZ2KeOmrx7LOR87hJwxJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 18:26:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:26:03 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-6.15] sched_ext: Enhance built-in idle selection with preferred CPUs
Date: Thu,  6 Mar 2025 19:18:03 +0100
Message-ID: <20250306182544.128649-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e455634-dcf7-4a1e-2479-08dd5cdc5a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?riMaUOvlLtquGhl5G8QAVEJte4UpxWGqEA85u6JII1AfQL/R++2lQUv+U5XB?=
 =?us-ascii?Q?CiTkUmR1qZSbR0pZ7HQN8vkmupc0+eM9B2Al3+Hme3PywGu9iSxqVLOgdnTu?=
 =?us-ascii?Q?kXxibYfFCccDN675JF0Z4yqhkQWgKL1dn5EW5l/+t7v0nTIK09HtjnI3Pt0F?=
 =?us-ascii?Q?D2pdkY0BHYCkLhTQwZ2pY/9YXPz2xjfXUC6wn1n6DW4Srp3C7+ljthkpsQWI?=
 =?us-ascii?Q?kSob6jA41FDFqsYil1etqS8t3QVt1n8UrcaZjl3UuAeGqaXAKRyBRVn3W2DR?=
 =?us-ascii?Q?6kD4xK6jJ57P8PaBJtFao+BSKHVEjJC98mH4mjic6ksvswBT5coN+yey9w/D?=
 =?us-ascii?Q?CyHdAIJWKunrVrVlf98/+BFKBi7PSjQhLE3VPObSgByPLGOtBtQ3MsDb+b1q?=
 =?us-ascii?Q?pRmyUFqnXaP8GIZ3GK1c5Z7hDMrpXsKeIfza8NnRPL6vUOM9EHO/c3b3J4I7?=
 =?us-ascii?Q?P2C3VhBLSDZNg7swZsVQ6S9HTy7V0kudWDQHe+2paTCbW/4lk8Z8f0wGDpqV?=
 =?us-ascii?Q?BRp1+ttSKmRBdFYhIllIpdNz1SPhW2AzqySSN+ZaQJv+SfBjeY8IZ4e+NTkt?=
 =?us-ascii?Q?C1zmku1qDayC3BARkt30E8NXSnlL5to7his7jEnpBEHAF0f4tdvCH2Qohn3u?=
 =?us-ascii?Q?aDLWZAizDe9SL1d0d4ebVW+qzx7L7y0PmVxwUchaFPAQypdQmRnU+Shf8IJ9?=
 =?us-ascii?Q?S34ynZn6TGLLuFVVU9gu5v9E3Hm85AOEP45xWRUfiOz1Cr2oCT7RbnH46drM?=
 =?us-ascii?Q?lp1nhkJBnJhRSkxDei0k250oFSoEHpTgvqDEELANcCqouZCmzS68KNHC0TMb?=
 =?us-ascii?Q?PiQtFYnB/3mbqoggdetYhWl7RfPkXD7ilqUP07h/9x3LXHDT33FYKUqPKaKN?=
 =?us-ascii?Q?KtgCD9XfK1qCE5fbcJxaSkEDvvXubrLXL8g0iLRCrvKXFNhFWcRQpBFE/R8k?=
 =?us-ascii?Q?vFL/EIQFIEpFM0bw6xUo9RaVwENx0dp/oMy0cNVjj/wWruiWc9LRXvxrNtVa?=
 =?us-ascii?Q?mLp6EADjf3q2dRggNO21Hk7Na+WtOkH+pI35smMCo5oIHMnAQJfUf+Jlv8ve?=
 =?us-ascii?Q?QnW8DU1OIQnjg8GTjbffHN5bldfxzw59OkBkznrYINoIRKa19S83bp0aJUy2?=
 =?us-ascii?Q?tMN0mkLogr6Puj+dOUoeDuKMSYHoRv8pxbxMqjbb5K0KIhcUkFXD1L6m1hcs?=
 =?us-ascii?Q?/eaub8RaMQFs+BtarhIaPSIHr+buttAh1voNhCQM5lF0ATZlOl+QoN1q+SF0?=
 =?us-ascii?Q?V55ufE1kAolWAh1Bqg4S0gyUmnekOLSW48LRF+mpc21LWiGs/FGdH/YTJOV6?=
 =?us-ascii?Q?Nv1VfImJUclhNIK9MLiHvx0FbXmTWCp7cS0zR1H2sKN41sH8lKPXQbJsfAeU?=
 =?us-ascii?Q?jq1P3FtMsqOfSbRV9iqW7rhDuPSH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RmQqhMk7tEbcPuvMfMPMvxgmlLaAF94S+YFfkSBB6Ac5Ra7pPvp7EDwKTGNC?=
 =?us-ascii?Q?uIZOIyV4Dop/vGnOH/YWAd3pj9I+w++fIBVj8u3LQXejJYtaiKjPQea2AdqF?=
 =?us-ascii?Q?8ZwN/lKzAwLpjL7NIWgvfEtHFUUMC10pX7h9PZjrvd83FR9ifeZSkdZsRU0B?=
 =?us-ascii?Q?gWcrg5InoiNPt6pgnunAPcimtnmIia4aYxGffDOZXiioXsdK15QrTjEEZiAX?=
 =?us-ascii?Q?VNwOWGZ9IEUbXOb+3jK9N8Ai5WB2lkeUPKKjbnezIZxFMxCpNt8OKb2FVatt?=
 =?us-ascii?Q?oD8HYhXZ1GI0Y2dMUhTiMHViJcBKvnw+ZO+SBJQtWk6dGdtzuEKc+UZTJvdg?=
 =?us-ascii?Q?fnwWG9oXMjJi1GSat9U+AblaIymHVEFTJfZuhkw7iFuoLWjVjE2rb7dePu99?=
 =?us-ascii?Q?UGPc9CvGl2VJ69S4haxXw64GsFGoawrqwBcr+VdIsON6JY6MMEJSqeCRhYqg?=
 =?us-ascii?Q?8Z01x4PyAE0hYR1YEjAN/rMy32TulF5y74stQL2XRXdD/c+/m37wEgwjftyD?=
 =?us-ascii?Q?cUivnG/76puAQ3W+Ji/FMriRgyo5mURaseWv2F7oin1R4Xum21XD7eGmXdZz?=
 =?us-ascii?Q?1JzXnIQf5i90r2xjXjUBI0wKymzxH466t4Sx+cw6rMVmueooxzIAMBIy7qjl?=
 =?us-ascii?Q?IRIkqOZ2VcwUjlLr/oMKcK67Er+4pF5It/jgYulnRuDhmQVDO79sIOgIjVQO?=
 =?us-ascii?Q?hkLSZXSbb6otZnSgI9jD1FpknvoujxeZIc8ekCZC9FXOP9rpcsE3K7MQl7D8?=
 =?us-ascii?Q?cfjaELuPHwzG/Kxcn7e6nq5Ltbc+VwTNJ6s+a8UWGGfpXYFSKU+VfVlbwEHs?=
 =?us-ascii?Q?Qs/Li6IxSHX22FzQY8suYZEyD7PGrWQcBqQ0xkgnYPGSyYA5AtYBXM9X7VuJ?=
 =?us-ascii?Q?AFBx7qILXgXsCWwLewg39w8U2B0KZn6uPseFAFaWJDDH1I3NcN9dv+BmknMY?=
 =?us-ascii?Q?oXUuU/zJeyxXMDfOsKx4J9rMZ3TPitXpk6w+9aZFXlTcCSoMqykaWgVGMTQH?=
 =?us-ascii?Q?cP0WjFFpStEaQJ117nkyMRdBjFIbHF9v/PXHcqL00++d/FUiT5U+SXqhk+dm?=
 =?us-ascii?Q?TwS600YLVCOOXy8GA0Qh/OJKlx01QrMJqLJBRGlnHWS6c8xbR1JQQemGMooc?=
 =?us-ascii?Q?xOdKeLYmrCEvntZIdb8cLauNIuvTaWyMfM3FQo9hbR7H4L5dOLZnZD41DAUc?=
 =?us-ascii?Q?baCvXYKsYlwZsHzjghHQpn2leU9Flg73XoChRNofV/IrmE4KAQ+IUya+WUns?=
 =?us-ascii?Q?lY+1Zf3lN17HeLzrPUu0za5xq6tmH1jrj5yT241AeSeM5LDqIGvPhsObjUBT?=
 =?us-ascii?Q?SjPbfE/xL8YuybIy+qYm7XX2VT0OI71Ms30Twx0WO8HE4dL+WQ2T5d1Kuqhh?=
 =?us-ascii?Q?8bQh3ehJgdcga35tP7G7xYYPdXd15ecRgg74F2fsySrDy0s7OWHjCscBHmIY?=
 =?us-ascii?Q?0+xRPZ3LY2aVpphIaaaiL4mrCf4LI5/jTTtKdEH+7Hst2/Hk46lW45M21cUN?=
 =?us-ascii?Q?GE9M1DBlqRJsgg1Du3QXublOq3ZzQ1pP0/4Fia9N6hWPfL61v6EuFBA/RNbb?=
 =?us-ascii?Q?LhVrBPjf2ZQ+g4VZssmYNfpr2KW52zZl46riRIcz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e455634-dcf7-4a1e-2479-08dd5cdc5a41
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:26:03.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JhhCuKg/wS4RRSATsRflwSa/g0oUy436qygxUhwE5bWPfrPzFALdISKbaXLAavBWq4ooq/g7NeUyyHJQ+cCJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

Many scx schedulers define their own concept of scheduling domains to
represent topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., setting the soft-affinity of certain tasks to a
subset of CPUs).

Currently, there is no mechanism to share these domains with the built-in
idle CPU selection policy. As a result, schedulers often implement their
own idle CPU selection policies, which are typically similar to one
another, leading to a lot of code duplication.

To address this, extend the built-in idle CPU selection policy introducing
the concept of preferred CPUs.

With this concept, BPF schedulers can apply the built-in idle CPU selection
policy to a subset of preferred CPUs, allowing them to implement their own
scheduling domains while still using the topology optimizations
optimizations of the built-in policy, preventing code duplication across
different schedulers.

To implement this, introduce a new helper kfunc scx_bpf_select_cpu_pref()
that allows to specify a cpumask of preferred CPUs:

s32 scx_bpf_select_cpu_pref(struct task_struct *p,
			    const struct cpumask *preferred_cpus,
			    s32 prev_cpu, u64 wake_flags, u64 flags);

Moreover, introduce the new idle flag %SCX_PICK_IDLE_IN_PREF that can be
used to enforce selection strictly within the preferred domain.

Example usage
=============

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *dom = task_domain(p) ?: p->cpus_ptr;
	s32 cpu;

	/*
	 * Pick an idle CPU in the task's domain. If no CPU is found,
	 * extend the search outside the domain.
	 */
	cpu = scx_bpf_select_cpu_pref(p, dom, prev_cpu, wake_flags, 0);
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
new helper scx_bpf_select_cpu_pref() and 0xff00 as preferred domain:

 $ vng --cpu 16,sockets=4,cores=4,threads=1

Starting 12 CPU hogs to fill the preferred domain:

 $ stress-ng -c 12
 ...
    0[|||||||||||||||||||||||100.0%]   8[||||||||||||||||||||||||100.0%]
    1[|                        1.3%]   9[||||||||||||||||||||||||100.0%]
    2[|||||||||||||||||||||||100.0%]  10[||||||||||||||||||||||||100.0%]
    3[|||||||||||||||||||||||100.0%]  11[||||||||||||||||||||||||100.0%]
    4[|||||||||||||||||||||||100.0%]  12[||||||||||||||||||||||||100.0%]
    5[||                       2.6%]  13[||||||||||||||||||||||||100.0%]
    6[|                        0.6%]  14[||||||||||||||||||||||||100.0%]
    7|                         0.0%]  15[||||||||||||||||||||||||100.0%]

Passing %SCX_PICK_IDLE_IN_PREF to scx_bpf_select_cpu_pref() to enforce
strict selection on the preferred CPUs (with the same workload):

    0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
    1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
    2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
    3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
    4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
    5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
    6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
    7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

Andrea Righi (4):
      sched_ext: idle: Honor idle flags in the built-in idle selection policy
      sched_ext: idle: Introduce the concept of preferred CPUs
      sched_ext: idle: Introduce scx_bpf_select_cpu_pref()
      selftests/sched_ext: Add test for scx_bpf_select_cpu_pref()

 kernel/sched/ext.c                                |   4 +-
 kernel/sched/ext_idle.c                           | 235 ++++++++++++++++++----
 kernel/sched/ext_idle.h                           |   3 +-
 tools/sched_ext/include/scx/common.bpf.h          |   2 +
 tools/sched_ext/include/scx/compat.h              |   1 +
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/pref_cpus.bpf.c |  95 +++++++++
 tools/testing/selftests/sched_ext/pref_cpus.c     |  58 ++++++
 8 files changed, 354 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/pref_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/pref_cpus.c


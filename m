Return-Path: <bpf+bounces-54031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54203A60DC5
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE78C7ACCF0
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B851F03C7;
	Fri, 14 Mar 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h48BnuJK"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473F1DEFE8;
	Fri, 14 Mar 2025 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945725; cv=fail; b=uQF1hQDRYc+gXzU9kPSigpX+dxHuGWKivWbtTqlhVVeOev7RqwamWl8HAfEQvXX3MFXOPbSTgu73vH0aMnCKkLJrV5BISxHnV2zvQGeGYbpmmMa2MvAFZnNKyPZIy7nJXS/v2w5mwKNgCJadKa+BRMXvgFTP7vjpkKkD8BruUCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945725; c=relaxed/simple;
	bh=s+D09oxIzDJNODU8K7tRTIODBlYm9EKlzfHiYTgEueQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l3ipG0+ODpI1gOo9MY42ssopdJBUx0mEYXsstzcAzQztVgZ9TlPQnIE7hZH5nOQ4tV43i40Xc5yPXjQ7cWSo8eLWt15xZNS8WMHTVQOeT2DwXF8dLufx3F+bWVdPWoUEApa2zbQ+9ElzUdq+JDRTpSpCqli+Ae/m3sYhsaT5wWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h48BnuJK; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxlfQ+PGG0UFg10ro/Z6FoANP/CUD5qsim/j2hwhu1gZjbcLzfBej493qRRdupnH12A/TZM9nNQjX6vh6N3Hl74DBrwjKeDbsC5gqHACAp5cjmizrYs+yECQXbEnQ47pA+YBH5UWHWU0LTlGy1k2N09JNZ3eA4g/M4nTqN9TpQ/rASupWrcXexUAlHtb+ipKCMmlsAHo7NTbDavhn//drZVY7US4NG8K/4UHCHxAbUrs8vEkFlcqqPoneQhNV4mwf0uLLbgHQz5NPPcHoBwEXwGrzrOAGt29AInFGaEn86Axr7z6i39QAO5drpjaiJZjjFaX2V83dWSgdLdd6aoV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJDuzdihoQ//NMLwfyo20sYOcnEJs+wLyOrp7zloQdw=;
 b=RcYtp9u5FVyGgPAwic1Dfy7JjiagE15fRF1P7CwyfMBe6xRdSaKMsmszKgshTsJQLalEjd9KiMM7umo97hxwyyyv8j2lbKzP0NN1SMhw4ydWfW3UDfVhR1td3n1ies8oLeu7XmUreLQC3ePM8Q3Ctbj1hLofmf1iggxv5vdjSZKtsn9zL7S8nCcSIxLIS4OFGLdMF39HTjF/mI8CKoSD/jUDb3A8mO2SXsJV2KEG8yv40LKNIiCDc3TFEtuSiRjwkzAIx062glNlAGw4kk7GELCwI97jkHvCszLG34XSc0oWTD+SLHnck542afioYTl/2Kin2jJuWN3XrExiaxPORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJDuzdihoQ//NMLwfyo20sYOcnEJs+wLyOrp7zloQdw=;
 b=h48BnuJKvD2JrcBvBDPnGbySk/M6ZkPerFYJ3aDny88zJo+SUG03LcLnwE2lO47rWJsYLPfrX2HSONdctNM5rJT294/rCwn9dFMm7Sbq/uY9SS32btF4Qp7GExT/pEKkO2ZuM0JnTFfx3BY8xUJ7BhXpCrkBQcL5d8DTWsrOiqfuzbNiMnWJisPMZ/aVEIz6b3xaykT9Pzu8k6wJ33B3YL4ZCaCnpk1RPvYS+JRP2kGE/9LjEC0+Lz84fgxn9U1JYV1MntTIoqy1U47FqyCWwdFeNoY7Hyk9j2CgI+vyrFzyTH4HFx9sSC3G7WxM79JSMsBWiVaysdxGlGekV9E70Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:48:41 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:48:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-6.15] sched_ext: Enhance built-in idle selection with allowed CPUs
Date: Fri, 14 Mar 2025 10:45:32 +0100
Message-ID: <20250314094827.167563-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: de5f6f93-7b31-4e73-c3cc-08dd62dd66a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgUFUV9/r0pxltKMQ9CBZnaMZG6KW8eiT86Mf9Yne9NN+c0P4J5+u/M7j/wF?=
 =?us-ascii?Q?f0ip9fe8d+IzYNg7O7i88s0eSiYVDnhxj021AIUhX3GtIFe/QGLigfq1vnyx?=
 =?us-ascii?Q?rWE6KfYs6CqzFveiUrUXZfVSGl/5ZTgRH1JjK9HicKQy6KwEpLDLZoodWdjI?=
 =?us-ascii?Q?Uv1Fmv/NNFI6/ra787AUWDZwBR99KGkKE7dUSPFsVnZOz14UqK0Pjy0VYKo/?=
 =?us-ascii?Q?5lfhfjKiELF2AGwkqBrDv5EFAewxoFEG2d4zoTPh8B3T9YTyj3eB7GqcMv7c?=
 =?us-ascii?Q?zKvGJ/WaxWDaHdVCnDtDJD9BicHN4Jb2y0YfPN7wkvnfKWZRezCyBJhf/JW7?=
 =?us-ascii?Q?4PLGhedb9iUTdh8wfRAJyu/93J1DOhDNFEqcJQq1RaX+etDFMknoza9JAA7m?=
 =?us-ascii?Q?gCsCLjiRCcgSpKHXivxmjlEzNFRItDgu6Qd+1oIajUJ9pmz5gm+TJaBd5XKv?=
 =?us-ascii?Q?y6VqMRMNzxsR9A8MJ/XmiPa7J3AH6D/AcbhrnrOeDGc/aKC3Mfn6V0jsFp9B?=
 =?us-ascii?Q?mHZZrS3nQDdp+DeLzMrpo7tZK1Nod2b9fY1RqSZ0yoaW+HbMPr3rVrEo24nU?=
 =?us-ascii?Q?6WapxpMaOkx+ujNz4nekkco+qrgqsOAPAD62+xJXTg18zkruTuxTg/ywtRWK?=
 =?us-ascii?Q?+yrhhqfxGk/Xdp0pHsDXUDqDwBH9aJh9U8hPWrh9PR3RVUQ1QS8GKBWmzIsR?=
 =?us-ascii?Q?42CRWCaCmUC95WodyxbQy5ugreUIwxZT3pyAe0FJGJgnYZaKKpXC7B7ZUqWe?=
 =?us-ascii?Q?51BTC2MmUqpvZZlbMHodymqAccKlgrPuCv9nXYpkerS7HmUePe0NkT6tAQ9Z?=
 =?us-ascii?Q?2zfiEeLuyJJI0QRBRyIUkTPkbRgDwky02Zs+fGjSApxAkrODKUYPMBrEZJit?=
 =?us-ascii?Q?2WmRiF6IV1yZAGaIG+vF2lOyOEr2T5h1NQcOJ57SywQ9BqtzrnHcJ0x3xE/z?=
 =?us-ascii?Q?qUzLLBYbBo2TUw0K8R08ZBLVBMmom9+XOGBKjHhk/Z7E7fTT0Z0c6V8AXVZL?=
 =?us-ascii?Q?NKW7WI9s21QspfmKihG3i6FQwVtelPlmDxDTqdYY5FR9+bx3SM1boV/0hq2Z?=
 =?us-ascii?Q?bi5PXxF3IpJHzLWrnPXcIED1J7mZPc+IlPXPQbC9qg/zcu69TDgg7tS+cGQX?=
 =?us-ascii?Q?xiwph3kNq7y0yR9WCkYB4JVV9Jje+DueIk7FURzO3/ZvSRMln3v51svXex4Z?=
 =?us-ascii?Q?+E+hdquaP5QzCEoBxvD3nOiJ8jeJrQF94UrPRIpy6y2aE63BU5ujfIjvz4+7?=
 =?us-ascii?Q?ZoqTk48HBANCwp6LvU29Tp4KqiyiSgqJ9lLGNy4sYaPUuQTdyuhsEGZLvX7E?=
 =?us-ascii?Q?mtgc+upCBqWHj2A3dQkbvDjI3fuGFMmeHnEpZbSDi6MejksABdkW1ofCzI2q?=
 =?us-ascii?Q?SZqInPXJnJYBytzd8AEi3f/f24oG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbnKHXqaiYfmenuit2wMJau43ZXNzsFYdEeTk5dz3uxuBfB85ZQa3ULZ1S6Y?=
 =?us-ascii?Q?ZLSsdkrZFkPTiRqzyjqUYy4fUHnnTSQLLf93lC4RneZKPhQBFqSh8sIEQKtm?=
 =?us-ascii?Q?T6xrZdbDZxiU9NatbMjcHSWIF/6zI9q/9Vq/3mNKKWHdRl0mtQ3XLt5ZudEq?=
 =?us-ascii?Q?uDp3Z3z4neex30mf5qjAZj9Gj29LgDvsbx1phi1OMZ5/zyuI56h59+wJtkk7?=
 =?us-ascii?Q?A28PCy2vpu6QhxmL3cbgWZ9Bab51Kr/6V5WpSccH2Qs9ytQljFtxKDLAtPh2?=
 =?us-ascii?Q?F+Xq6ruaCAWRWmG1S8F76XR2c6vU6mRyo1fQiGjrKCPM/90l7rVEKqEFL2iu?=
 =?us-ascii?Q?pyUPnfTiLtLJw2R3X3kFm5iSu2LT9zy84sZR1F5vU8cEPn7jtZ7voAmJrFNZ?=
 =?us-ascii?Q?Ka3anKUxxspYCjxQC8XKj13mVBgdNafusLARn6GJowMAirJ2dSOH7uZq3A1/?=
 =?us-ascii?Q?DFmIW9wF6VAv3Y5TK8QvlrGQIH3TNh0kOxITOHaReMJwzKaWLxWePHUn4Boh?=
 =?us-ascii?Q?MbvzRDIUaA/ufxgeVp8AuGt93DRj0UTiRRf8x3V1bgmV7g6pWXq2y6W0/7Sd?=
 =?us-ascii?Q?7bAst/S0tJm3gvwLdLgUisphXjhKw11h34f1quiYIUP1Ge2P+2/F5zq6T/16?=
 =?us-ascii?Q?ZpWUX5lVdaGOOG8o2nzPyY4GGUCGN8KWlRbkVO0/u5qSnROfgyuWixjdUEFo?=
 =?us-ascii?Q?ylmMyZX4h6Uajs/2GXM5vMbCDWCfz8NhD0YSKG2OuUBmcZCgfmWl70dCdd6j?=
 =?us-ascii?Q?5jPbFnKBIzPuSoq9YGQoL0N8MhFsDzfBGy0M+C2DoFRKW0jnTENJkLASHXxm?=
 =?us-ascii?Q?KNm0Cv9JnFjcVEC/xrgYyz255hnhHl7yfJpSIuMAf0AcbotFq67k/8l1uCcG?=
 =?us-ascii?Q?64jo1ddGXVFHRhKbxSjr6ytBiQO07G6OrOmZmycE7+PGLldMHcXkPGBCla3d?=
 =?us-ascii?Q?vX1VLEQcpwWfiDq9fi0n5yxeFvjFQuudkiV5VH1KbA/m0kcRCRQJmbcwtIj0?=
 =?us-ascii?Q?oI2+bIH1tLSIt+6HyWhGX7sTmBXpSDe82IcPjytip7IlNqX5mfBObgQC1ice?=
 =?us-ascii?Q?ssTas3/NjlBB0iQn6KGpAHjU8aR4fLj0UD6RZ53d+LqaVcSLDxYMSol9PuqK?=
 =?us-ascii?Q?ACoKZ4FE+34xIQ8Z9I1rvjl28UOIGpvo575SWUScuT8weSkf0fOIwWrdhfEx?=
 =?us-ascii?Q?aX2wBoRYpeKCIQyhyOJJkCxeevhKva334lU++CRjnihUdAB8sbzS64YClt1u?=
 =?us-ascii?Q?mydUx4FcBnG5FaGHFxjXYTYSwIZj+TV7jvVAPNcAjjNHH6IQbFi1J/aFGadd?=
 =?us-ascii?Q?L46aGyAx6dOCCJMIcHWml9ygEbHQmOOMvNGglayMo36FUQhxD+lTWq0wbRh5?=
 =?us-ascii?Q?ne9gd/lBdkMkyDzPdmDyyegz0aXxQPfbDtxM4yhqkOj4epj+OpYtjRJqszM2?=
 =?us-ascii?Q?UxvD/xTX8//SEisdV5WNb43/lHfrPlk3DM+bgkpWYX3b4p5nxB/MI4spddy3?=
 =?us-ascii?Q?kSaAZ9n0JBEmjAliZovwqYkrY6Sptfl4bMnzF+LTmZXVk1CgQZ0WWCyANPBq?=
 =?us-ascii?Q?w8Ypmjn396EShyn99BdJAK4SC3DTpgc9ypa8sSlc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5f6f93-7b31-4e73-c3cc-08dd62dd66a8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:48:40.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6kOzXZ5IR/D7Z4Vf5NZa4h2aKu30cBNf867JeJqrIW6cCXkklTUzgiB23NcYvYkqoaPHVqoZ3vQ6mU7p8tK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

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

Andrea Righi (8):
      sched_ext: idle: Honor idle flags in the built-in idle selection policy
      sched_ext: idle: Refactor scx_select_cpu_dfl()
      sched_ext: idle: Extend topology optimizations to all tasks
      sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
      sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
      sched_ext: idle: Introduce scx_bpf_select_cpu_and()
      selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
      sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()

 Documentation/scheduler/sched-ext.rst              |  11 +-
 kernel/sched/ext.c                                 |  13 +-
 kernel/sched/ext_idle.c                            | 265 +++++++++++++++------
 kernel/sched/ext_idle.h                            |   3 +-
 tools/sched_ext/include/scx/common.bpf.h           |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |  37 +++
 tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
 tools/sched_ext/scx_simple.bpf.c                   |   9 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c |  91 +++++++
 tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 +++++
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
 .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
 .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
 16 files changed, 424 insertions(+), 115 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c


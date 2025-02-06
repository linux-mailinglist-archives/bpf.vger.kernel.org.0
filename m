Return-Path: <bpf+bounces-50691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E2EA2B34C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0381670AD
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101E1D79A5;
	Thu,  6 Feb 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hY73q8Dg"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC601D61AC;
	Thu,  6 Feb 2025 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873307; cv=fail; b=X0fs1aEMkuYbxP7beDFaZCVU6gcZ7wMKK7p02ihc20+SDJKxyeBYFRhsCxSyAvmQey+2kUSQdqtCNNBxgP0htnGkesruUqHhWDmckW4uF+nHf9G3rkFVnR4MEkCsDb7oPyOh2H0RehKrY1p69mc3KekAwVNi3DeeLYZ6ZlHRKCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873307; c=relaxed/simple;
	bh=mDuNfCNkRGEvuvfqV/052sJGu3YDtdn5+yhQD0NBlns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5+L7plUlp+2rq0eaHoH9JtSvkmfbwDZydy9KagpQYmpK2basJwsxYUhg/jYBxZnzumTKg84wXBpZ7WBU7O9yh+c5KLDEOIm5sn8I4aLXd8f5tOkVnT8tmi9KJmundkd3IlSAon/jug5ATO3jZMGd9fpq/TwUNuKNMfQ/iMhIXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hY73q8Dg; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6EXTZ7O5l6HXrzlmuFqj9DVYTpFOh9hzckIVzidMs0OejGaWX/mXVPzURXGBj0oHUR5YNB+dKvxND+GoSBV8jLSxxkSjMTyXFuxjDatZJDC2k5UMg8F92wEPett+gaynlvdeTnHjnwr0ZBKdupBUzWho2I9Uyz3u1zYNgAHnFJRAoA9dxdNlADn+tyVrn1kU87SeyiODZEFj1Hpf5D1ktz7Yx5zRkO1Syk/Dgx3wFE48wCCfzftoWnOaKT9SvikOCL7oBRAEx6JnIs3k9GKTwoWSNIzLSTGfUgoNmKWNf06aiWXcxA3Lg71avZ2fQl3kCfq+Wb2aVPYTYIQyP4rkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mu4UXuLIiu8Q1lZW1J8ASwblTQIw8h9hBAWfUkYbnk=;
 b=Uf1tZQ7OB6rHeLzd6h4Y3oMWUagFwWZroNF4+TRaB2sjAmdQK3TH7+NWbWj2hmyJBQZze5K8KJi4/y0yaBNNAbg7ML7nLNpqVz0XzC/RqolU12QswPWZw+skSkcO4ZhAGlsPyduWPqT0datXTU5XO1o8DjSM1dBSuSWuirFa2lgOML0Xt6400fvAXrBa+iNpUMnzpa5+8WJouvKsEhxJiQMX9s3i+7wtJSfowM/2Or/+mI4qjQR4YbXMHszA6+Tu1SlSIITedfMZD88ISGpsg9gqeBGkoqiSR9XQYlWZw+XLdsHH+Bi6/MEHfSh99uLUazwws3m8AfD+pvrocicBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mu4UXuLIiu8Q1lZW1J8ASwblTQIw8h9hBAWfUkYbnk=;
 b=hY73q8DgSHVIqaL630ZiTevnSLwibRiLYPc+HN2wuT5QTabuKYKm6XCq25qNztm4Re+1aJ01X/SxD0FRI1SnEIfEFuF6lSGcQeBHOsH99qui0naJtZHTvuvC3TIoebvB54hOpdslSn2pf/sK6VipJsKbnWfpxFF/CIRM2V6XROGzqOZShPbj+uNDgnVfJVrbwR8JFrOu69m4v2PkcSpDc5xOqY+EVGjPSqOxK/9FI/qq7LMYBm+WzUuhzMNaDzkNsH4ZU32z4BWfiegiR02g32hiUJ7xfleKUeOs43GZK2LYL7wM4rzi0OWMnHSQwJfV47/JLSPaL5lQ8dEQhZRWKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 20:21:39 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:21:39 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/5] sched/topology: Introduce for_each_numa_node() iterator
Date: Thu,  6 Feb 2025 21:15:31 +0100
Message-ID: <20250206202109.384179-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206202109.384179-1-arighi@nvidia.com>
References: <20250206202109.384179-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 031552fd-658e-40c7-4a2d-08dd46ebdcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ecPziQ1NZAyquVyd+uU0D7t4OdkZv2gTIwHxx6QggBBJ/vTXRqR4H6XnUN8?=
 =?us-ascii?Q?bpxlrLWqzRceaKi9u3NNrXs1mPSERGp62I/QX9Y4Up5VHHQAHHaX6GWakrFb?=
 =?us-ascii?Q?ckdd931GDzJ3diSqMlRbOTu93LL7LmGfk5lMlri1/+CNygzhIrnkn2rWLz+D?=
 =?us-ascii?Q?WSbkBzDnV+z4pUdQBg3E1Ag77YCHCH9H7/WKRwldB0gKmhHavqdp0Nmme/AW?=
 =?us-ascii?Q?GAVZZEgzhiTYsR0EP7Lrb6VHpxhu+BeMhqoxNWTcsCWpafNeTPL9JEbXc1qv?=
 =?us-ascii?Q?2J4z5du5INvV+Qj+AKavdUbYD5Vp/rAST393ft2OlNi7OTlmV/50uhpMQxcS?=
 =?us-ascii?Q?JOKLKaPZF1M84fZnDA2DmCMyoCf/kKnsoRQtT9ySccEABV7bCvcMDelfzfoX?=
 =?us-ascii?Q?ocksV4BGMR5cBs0jKbWlJjnd4L2d0zio89HV+9twEkcF1aaZOuLdLIACr9bd?=
 =?us-ascii?Q?aezBLUN/5oMllyywxRXJeAkWCOwUv4Q4+eyLAmfqE6KT/LaNulZI44zqsezb?=
 =?us-ascii?Q?q/CQO0MPYpolhpw5bQs4MNK/CBcxMkogy/48Q6j/OLKLbByi5tIOBj31fxiw?=
 =?us-ascii?Q?BSELbk3MZVfbB8g0wraCECXPm5tvzeqbOXiznPcRYQG6rfKrx+jAv5NojhBv?=
 =?us-ascii?Q?71FvH2Bd2yVzOh62P6Ce+aUAwXBSmQI0PPKMUT/TGZI1v5Edim9fybifPCFT?=
 =?us-ascii?Q?tausE00LWyZ8FhcKvbZr7/0nqWYSHJPcn1kLvlKfupRYHQyRkSIl/D6Dgyu/?=
 =?us-ascii?Q?tllz3tsrTk/KT52i0bel2D2dWNjt6/IRZEFCL748NQOIAYztwnaGlJWUJV13?=
 =?us-ascii?Q?TRBs8yXW1mTXJw9lR5d31OQOYWplZM33LLQbyxBYTngPQK71sAhKp347TeN5?=
 =?us-ascii?Q?wnjlD+EzKwPbkCjKQTRuxBxe2pwHtirpzWJGjUMnPu7gio8ZH4kScJAsBkQk?=
 =?us-ascii?Q?i1t/7RvRMta4zkG7MC+sIHrST68j5YwiwMjBmKTt8Pq7jpUxA1rNV6tvjjZT?=
 =?us-ascii?Q?VBY6yYpFSwLeUtpL9gK9dGJf92FyDRXfdmgYjTMfuZxQuld+IUo6V2/7ymOp?=
 =?us-ascii?Q?aICRExq0+luMo6rCpOVOikUpnwlHZGw0nzPklPHPWA10FxHGoxXvzFKtK7uJ?=
 =?us-ascii?Q?ztc5tc8GT6yfOBosAvBn7/yg/eP+ZgwmB5na6GEXxKp7G+FXbmttNEInBDTY?=
 =?us-ascii?Q?p0a1Q0RuwqylmfnQ7I8pU6wSc42E3su+gNwFTDYkRUrOf5vKU24sSnZ3gFOw?=
 =?us-ascii?Q?dzebU9xJe30xxVADxD3lr/dviZMcRFhTrXR4hQ9MaYTIAnYD8UT5YIM5w2Uf?=
 =?us-ascii?Q?M91DlzjH184Twptj6ibE8pwd4Rjh9rCncWNrjYvqJ5uKNK9TBQ4ZwvuVLmy0?=
 =?us-ascii?Q?Xv25zGfoq2aeghMxRx2F21JzdrAJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QOFq8IFjgyw9lmNRxwWjZfsCndX43G9ZR0bh4pl9vpbYQNbyMcOk9Iy6qoMw?=
 =?us-ascii?Q?CK7UDOi4g2iTR1lq9E+72L0IKSvWDEfKhfU1Og3wx3OtaKrdwJ16MZ0Ks/3S?=
 =?us-ascii?Q?NbKL44oCJVSUncoS/+Lc59+EnOfIeP2H1Cz5K8+5SVR46GO4HOuI0P8rqySQ?=
 =?us-ascii?Q?xBkIA7qk1aGZ5C5WGlsh6XA1mU8qZ9McZMifM+63ZKawofLliPCJ0yAhzjS9?=
 =?us-ascii?Q?Hq4gGSb3NSLX8pEyCD/vO16iMnIy7WXIzY4LHgPM0PC8ZXz5TrObVthhdPte?=
 =?us-ascii?Q?gNqds/gi+OSGrMxmhUdxbYKMBg3UAHmI4lXSNxnphmOPesX6C5qClZYkI6+9?=
 =?us-ascii?Q?fSXePC0UOFIQWm2iZsOh+c15l0uIm7ZO1f+JmBZicZ+jKWsd+BPL+xAN6YCT?=
 =?us-ascii?Q?UTEEZtS2s8W9CmaNR1VsV1ndvQqdFBDN8aC9AZbNiYe2jLVNcTAABzSsYPFn?=
 =?us-ascii?Q?3witOkuWEFDR7HqNHJji06rsPr7CSg6SM+oBot3DwqtPi654aXOkPPfvYYgs?=
 =?us-ascii?Q?WBTtUOo6qYS+wGIcFi0BCO8VCJoG4NaRIuAW7E1uCZogsA8xRa1dVT26j00a?=
 =?us-ascii?Q?yTHi2hrBqNVhgPaxIeOEyaSJcZxbVRE/S/CY31iF3KdYPcqWZSPQTysS+vU4?=
 =?us-ascii?Q?JLl9RumIfr/OXvD9C3CLz/K9OCMuJqF0ewuPNaX57aWuqoae4UAViUhkGkxE?=
 =?us-ascii?Q?qdrtlWXH/yqbafg0ccsMCXhjgqecah1XCXxUs4oGY523cTm7Zk7MW0Z/khd/?=
 =?us-ascii?Q?nGzxn3FlTbj/EePue9iDZdxHm0/VP26zHkLQuPTc8FlG/Lwfsi4MGv8zRSr7?=
 =?us-ascii?Q?jnRQv6PRwwhdu45JUsO0YThD02OGammBRmlKx7BjitGU8HKWduMZMVNI4eiG?=
 =?us-ascii?Q?o27XmP4/7g9RdZ0xWNWCmzRP+owzrItUPQEcbUq5gTFTr9RT8aPXP8oF7/bq?=
 =?us-ascii?Q?5To0hY1FBUygyXJDl+ws+lWMX7HRpU/Zy9gzoIGrf4fIXfvdIU2Kssypujur?=
 =?us-ascii?Q?XjaRVyvywlXVcnauSgD6gjJae14UpL6Ii+FCSVf5u5+HUZgc3ICwY0zFiDgT?=
 =?us-ascii?Q?M1I6GrZmRAhHFnpOE7NJJvNze/wCCwKhk6SqQeiAeiMWbcDLT/+cCAJTWTy/?=
 =?us-ascii?Q?HMlSVimN/0vuhsnaqxaMUlYE5CoytgzUSg16UZATf8TPpPyOJcWtAA42cLQc?=
 =?us-ascii?Q?nzM1maWR7vr+MEmHAqwNM27w822eoi8ZUmnZVpyl2cN5TY1qDlX1cX0KVVpH?=
 =?us-ascii?Q?MEA+NlLk7CWTHOLd3VwN5QGDrGIYWk7OWvkoonWeVn+R3kjSuDZCaHV2osf3?=
 =?us-ascii?Q?tZPJ+KAyrwLy6RtzouT0I7GYXkmZJ8EsTiSYI0sz+2Ht3ptGJ9Ml7Hy6nfWt?=
 =?us-ascii?Q?0fGKxATW4xDcQBkFAf7q3ypwZIs3pjO0+vCPQhJljk3eEZdOnAhPGQmKbn6R?=
 =?us-ascii?Q?3EsHigf8OdXTKoAcb2/LC9XnkJx59javLuGeH8o2Rr6knn4yyB3HkKS2fjBm?=
 =?us-ascii?Q?m+yTdsVlWLpgGBkeu8A0MRFYwX1NN2P3ZeQa+c9jPw48aSrZWnzI1dSGz5tK?=
 =?us-ascii?Q?fhb2Fbx/b8mgfa9/jiux802slo1f3Z97uCzRb8EB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031552fd-658e-40c7-4a2d-08dd46ebdcf9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:21:39.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQqDk3koPJ30A36yTElkFoAkrn3zjyYT4ZfFKYzLFeb1dnO6kSE+VpVu8hA5JOAHH0i9c/OSv6N/u1nU9ejXuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

Introduce for_each_numa_node() and sched_numa_node() helpers to iterate
over node IDs in order of increasing NUMA distance from a given starting
node.

These iterator functions are similar to for_each_numa_hop_mask() and
sched_numa_hop_mask(), but instead of providing a cpumask at each
iteration, they provide a node ID.

Example usage:

  nodemask_t visited = NODE_MASK_NONE;
  int start = cpu_to_node(smp_processor_id());

  for_each_numa_node(node, start, visited, N_ONLINE)
  	pr_info("node (%d, %d) -> %d\n",
  		 start, node, node_distance(start, node));

On a system with equidistant nodes:

 $ numactl -H
 ...
 node distances:
 node     0    1    2    3
    0:   10   20   20   20
    1:   20   10   20   20
    2:   20   20   10   20
    3:   20   20   20   10

Output of the example above (on node 0):

[    7.367022] node (0, 0) -> 10
[    7.367151] node (0, 1) -> 20
[    7.367186] node (0, 2) -> 20
[    7.367247] node (0, 3) -> 20

On a system with non-equidistant nodes (simulated using virtme-ng):

 $ numactl -H
 ...
 node distances:
 node     0    1    2    3
    0:   10   51   31   41
    1:   51   10   21   61
    2:   31   21   10   11
    3:   41   61   11   10

Output of the example above (on node 0):

 [    8.953644] node (0, 0) -> 10
 [    8.953712] node (0, 2) -> 31
 [    8.953764] node (0, 3) -> 41
 [    8.953817] node (0, 1) -> 51

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/topology.h | 31 ++++++++++++++++++++++++++++-
 kernel/sched/topology.c  | 42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3e..0c82b913a8814 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -248,12 +248,18 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 #ifdef CONFIG_NUMA
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
 extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
-#else
+extern int sched_numa_node(nodemask_t *visited, int start, unsigned int state);
+#else /* !CONFIG_NUMA */
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
 	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
 }
 
+static inline int sched_numa_node(nodemask_t *visited, int start, unsigned int state)
+{
+	return MAX_NUMNODES;
+}
+
 static inline const struct cpumask *
 sched_numa_hop_mask(unsigned int node, unsigned int hops)
 {
@@ -261,6 +267,29 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_node - iterate over NUMA nodes at increasing hop distances
+ *                      from a given starting node.
+ * @node: the iteration variable, representing the current NUMA node.
+ * @start: the NUMA node to start the iteration from.
+ * @visited: a nodemask_t to track the visited nodes.
+ * @state: state of NUMA nodes to iterate.
+ *
+ * This macro iterates over NUMA nodes in increasing distance from
+ * @start_node and yields MAX_NUMNODES when all the nodes have been
+ * visited.
+ *
+ * The difference between for_each_node() and for_each_numa_node() is that
+ * the former allows to iterate over nodes in no particular order, whereas
+ * the latter iterates over nodes in increasing order of distance.
+ *
+ * Requires rcu_lock to be held.
+ */
+#define for_each_numa_node(node, start, visited, state)				\
+	for (node = start;							\
+	     node != MAX_NUMNODES;						\
+	     node = sched_numa_node(&(visited), start, state))
+
 /**
  * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
  *                          from a given node.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index da33ec9e94ab2..e1d0a33415fb5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2183,6 +2183,48 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 }
 EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
 
+/**
+ * sched_numa_node - Find the NUMA node at the closest distance from
+ *		     node @start.
+ *
+ * @visited: a pointer to a nodemask_t representing the visited nodes.
+ * @start: the node to start the search from.
+ * @state: the node state to filter nodes by.
+ *
+ * This function iterates over all nodes in the given state and calculates
+ * the distance to the starting node. It returns the node that is the
+ * closest in terms of distance that has not already been considered (not
+ * set in @visited and not the starting node). If the node is found, it is
+ * marked as visited in the @visited node mask.
+ *
+ * Returns the node ID closest in terms of hop distance from the @start
+ * node, or MAX_NUMNODES if no node is found (or all nodes have been
+ * visited).
+ */
+int sched_numa_node(nodemask_t *visited, int start, unsigned int state)
+{
+	int dist, n, min_node, min_dist;
+
+	min_node = MAX_NUMNODES;
+	min_dist = INT_MAX;
+
+	/* Find the nearest unvisted node */
+	for_each_node_state(n, state) {
+		if (n == start || node_isset(n, *visited))
+			continue;
+		dist = node_distance(start, n);
+		if (dist < min_dist) {
+			min_dist = dist;
+			min_node = n;
+		}
+	}
+	if (min_node != MAX_NUMNODES)
+		node_set(min_node, *visited);
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(sched_numa_node);
+
 /**
  * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
  *                         @node
-- 
2.48.1



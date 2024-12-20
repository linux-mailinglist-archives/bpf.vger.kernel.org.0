Return-Path: <bpf+bounces-47426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD99F959A
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E88B16C7D5
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8017219A88;
	Fri, 20 Dec 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JaB/Xt5b"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1D218EBE;
	Fri, 20 Dec 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709290; cv=fail; b=MwXf85AAS43c5iLdP7l69h2iuZtUHMe8/hIibM/qNN3nWZn05XH470URAhCc2s8M/+1G/R8iUR4yOFgi6VaYTgDV8etluMOHz2SofUkEpBrO+lfdYAV1OP/zRN47XFZ87DzfTG405ajNkSEd7YpaOyuW9A1G43GSu+fspoLm35U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709290; c=relaxed/simple;
	bh=BrBs5mzicuG5ZdP3RUCKmuf2En7S5TxXbYK88PAnkQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odn/z+IHwpGlqJUhsqVH/+7rR83sMJ95BuaWW3dwT29F2YOPOnmHEXZClOOD1FlZDf/VXlVXEWnfMQFkb+rfi3fYzTVqR1+zsQkypoWGtJEkHi38g95vacnVQI7Fz8TbUGIRk610N3+FWptk9mY7vitckjRawfexvCzlQUWjves=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JaB/Xt5b; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjHDEOeK3RWei08fKjosvnwtrmtQ3QdRKSEE7tOA03F+bkgKEBfN8VSxeTZKERoZdYhPRgPZqFwuyg9Q9sChK+I+qyFgWszSSn56gRQi5B4PmZEjN5jC4OkaIkNpOBnb5ziBs7dWFiSB9Ji1oW9WkFD4eBWPFhRTMsbBhNwyXbxN4x86F6MKD6R1G1GyhMMt2QPnhsvW9x9P0Z/72PGrz+sDUetgZa7JGCKq8DGwUDomBeXdh4PyTLH7wdhx4sylKPt8pt1x0DLCeUG5QRE/A0gmvqkKr9leHIX6PM3/C/SyNre+29x1srDJwQ7/cbxejKytnpdINLKHALijckwgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkOUdcjd3q8CSg46dJCG0LCHLYMhldMZ+SAfCYi6qdw=;
 b=bQnPDEL3WDB84AqtSvexNANsT6IWlFrTKqK3k5g6udpUd0T5ngigekVerSGKwI7XGkQx+z4UdDWcPEel4WG924TKEPZB0rP8ZaAOvBi/EinE4O8KndM61L3KS7gwuO1po3VUIFT+hAfcV74bSIDvR2Cvp0aJCp+hIn4BDr0HKt0GMwF6x+2/IZRk5f6+3Tw3QCzulkCltOYkfxdngWX0nrlAeyv/PompmEDp2pP2iiFop/DButpARRBvNsrysTtzoTSiCdWOEAjB/sVumkJVrpQjzVNqYk63OJIIxCQV44IiySqWnERQRUV0PvVY5DSHND4D1S6Fnt6ctmlyfGILzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkOUdcjd3q8CSg46dJCG0LCHLYMhldMZ+SAfCYi6qdw=;
 b=JaB/Xt5bZCHUT//bAJE1s2dUvp0MY+kfY6x1jDXnnvcuEALTVJnHxXvW04CwjYmILOyEy8n2l+Cdd4Po1w3J512mozVMtEql1JE7L7V24S6rEIn7vs5ydCNuFGm22yglymFeRSB399SnxAAoD9XF2kmiQkdlCDlsXiswMRzeP0ADyo/++k9sB1tNtkzdfwXfSRhbL0j3O7mx03/eCaf7R2k5C4sICwQC18OWRN76Kty5jQiNdBUYgkblxEemxdbb3u1kVPG7gLa3DjchSJEtgjlgv1zIburGXpgr3VA2UCk4x5fJ+8RTKITij51GPOYmGl2wq5rq1VV9vLtOb/iXIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 15:41:20 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] sched/topology: introduce for_each_numa_hop_node() / sched_numa_hop_node()
Date: Fri, 20 Dec 2024 16:11:33 +0100
Message-ID: <20241220154107.287478-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 801a0846-d37b-49c6-19b2-08dd210cbfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sf+DVSVdIrBhMzBRHy/PBKtmH44REcuzRhwGhthT5b32UlJVfTxVvZQeakkl?=
 =?us-ascii?Q?ndh3IjTuGZVokIAP9WsE5VQKdguZ/UO0I1rEsytBdfgOnh9/rxJb7prgmae6?=
 =?us-ascii?Q?vdAum/PvQ5039SE3kt3/sWmiGsyw+2h10i0SUPWDwe0KFUEPhfVeTAfYGsOt?=
 =?us-ascii?Q?7UtpSHHxRsatmKe/AX7YACUav+vDALyb1nd+vtlDn4nCdP//IBsqXwjP3Hux?=
 =?us-ascii?Q?Vkj0wL/FswgRDuh/lln3rlAbSoVwhJnedbr50R9SXjUbVCihGEV0GFtUNnE6?=
 =?us-ascii?Q?w9U/wO2K86ZrumYlsdt6SNnnSY/+0ncIAWo0ff85/2DCP3D1NX8OdFs3nrBu?=
 =?us-ascii?Q?GpQH+kxEgRI1lPXR/sL8RIJgH/LNA1+vbJ+UGBco1xHSboaQqx7UQ/dDNnNx?=
 =?us-ascii?Q?9irE9dZDZsFDm6iuAqzlM2DdddhZQguDG719r+JNTkVc/0M0K5s9EcddAmYb?=
 =?us-ascii?Q?4S8i6cWyRMliiEGbU4bFnSb2MynyTxQmGIzp2DUSZK0i2JCz1mc9Vm0SGNcS?=
 =?us-ascii?Q?/32G+d6uXCL3tqTXrFdxDx2lQ7kfZ1z3XC1fPr8u4KSWjEfUGyk0VH767x8q?=
 =?us-ascii?Q?WfjSEZ4QSDXZe3o+PNVpSPW+gerA7EB6yiJA+oXfNJTnTeGrR3ZvPn/zpjA8?=
 =?us-ascii?Q?bHWHcg8QPuqrmi3WMA7nRV1ptfmK6XN6kzzD2b6r8h0FINUdi/xlzNBk8tRV?=
 =?us-ascii?Q?tamyDfYpjtpSHU4Pt0hbRMFs8Y7+newx078FX5EoysO8OoOYZ0Cas3kJpkmY?=
 =?us-ascii?Q?Q82nWxKeRE3joecntMVgnR3xd2AeOMvDqOL0fSQDovRNyIxxkuwCdG7ZH6xV?=
 =?us-ascii?Q?7LcgZjd+8vFSWoK9RyUq0CwY3u+OpgLYWujKcs5OqhIis9r1T209pxKeYDP4?=
 =?us-ascii?Q?ooTS8V/5SxslhoMZs99PyCslM7TETBsPMh3Y+YPgGc2J9EFWv2PLJnICSwjv?=
 =?us-ascii?Q?lZW07G7soH3BsZxgS+Bz7RNUnot9UawbNxcF9e+7O7quONo6tn1nDAfBR0QI?=
 =?us-ascii?Q?3MuR4yGQVF+PJjjueGmhF/aYjj5jhLiLvQznh9U22z6jlHRS6UvaEuw4IdQd?=
 =?us-ascii?Q?H2D3aBCCNtaynA0AbU5fXAKMNiXUY+F+34QGgHXoMokxlnG2rbAvPU/quPRI?=
 =?us-ascii?Q?sTAUaQGMfOwXKpeVEX3rUM/AQ3mWHRIhwmua7AITthi7HskJGNzByS7cFOTQ?=
 =?us-ascii?Q?L4ZKpcQOKpxmpoXU9HWybEQPEGlgbvRUBxLNdXAVINB8K907iYu6DAMzOUtA?=
 =?us-ascii?Q?jKnZ7iHNQ9JrpOz1ZWXXjuD1l739ibSgiFv/8T5+jYCEmkWuqgh8zHjYAiSO?=
 =?us-ascii?Q?Gmqg/TluS4DmhHw01eaUXsjzNGep1vWtr0OTKdXi6rTRare652EgrNClHfRf?=
 =?us-ascii?Q?R+XG3vuJyaSbJUdw0odLup9nT+WE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nWUw3q7fpBgcZcPaCpnWGVgfQi4HZUPyvokoozPE2pGqkCMImF8HQkJeZ/O?=
 =?us-ascii?Q?zwVpn1ObpKx/dxGn87QUNAmhVEa0P1Bh/1KjyNV2bN7qR5dFNCqyed7wM/Bo?=
 =?us-ascii?Q?V8bwEMtkRuDcZm2ye1malv0yRrQzASSSLJB9HQcu5f9SXjhJzLLEVG8VOEcI?=
 =?us-ascii?Q?xIbdsi/Dc5E6aTptUAoej5I9A0/Tf3ELitL05LI8J+CJTwx5nSHGD3Ewe89u?=
 =?us-ascii?Q?lJeAxhLRC0dJd96DFgQhQKptpsAEGKuvy4It5kt4eHyb2Q2Nx55X7y/fGBa0?=
 =?us-ascii?Q?imEpDskbb0AWi6TNeO3qV+ioO3PoR2cbWLRH8Nqew3lpECemDUldaU7p9R6t?=
 =?us-ascii?Q?WUjB/V6oAADo0o9w64nLZbH4IytFmy9cEuiCdv3Y2WIewP0ylWHf0z06t8sB?=
 =?us-ascii?Q?jqQfdWhzhrBt3IDFxBf1ee3HJLu+JP5WyhEecvoZOogV5EJdqimqG9VhkG/L?=
 =?us-ascii?Q?ko33V8XTUY4yJAuIVki24Q6G+8QbIsBFq4eaMHY8UJzw+mCJI3ivOc6mvsno?=
 =?us-ascii?Q?GsUhUc4zs2w9TfzavflRaCiRoto4754HZUhpWVp6Te4j404vIyeHYiExT+bv?=
 =?us-ascii?Q?jUIUJhpL24cJHNDYOVMOHS/qEr4+LG8Jeir8ANmCIZbbLlqdYSTR+llXH7Yi?=
 =?us-ascii?Q?Rdcyg5KdLA8COPEyjc3mlEz2/0YoLp3N33Ud9hos0NYp1ZZNNiQT8L7iiPjv?=
 =?us-ascii?Q?RGWupr0KrNvcxcswCRDcxwHh5Qz5UJ6J8oF7EhswzhhYORjYRy9pOdyOFYrA?=
 =?us-ascii?Q?CmXwQPpVdtLXFEN2Udfb6Jg1EssDzfzZ7/oBnobjkmDA2fK5K0hE28Lg3Dvp?=
 =?us-ascii?Q?et5HO3gBt/Rug1PlVy4Agm5XeQ89PYXyUzrGvURasFkT+AUkIn15JoymDd/x?=
 =?us-ascii?Q?9QSYaa2K7/taHXRlQZVu71Pdcgvlw1l01rIh3U5Tek0upqUFoPdyQwpvK0fK?=
 =?us-ascii?Q?GUmeZ057mbl7PMCSlMFgp9FnU2/I14XzYjTbA88vnvmiJrurtKjMwjha7HCi?=
 =?us-ascii?Q?Z/IR4LkICnGFBpo/PQmYnAY0Vereycei25Ht4+GApKMcuXxeNJaBKgpSRovN?=
 =?us-ascii?Q?CeNQIRqz3EV8bMT2yvw03jKRsj4uTQxJ7qGXngaW1BeCPxpTfFG2DEQ2L5GH?=
 =?us-ascii?Q?ezAltgAkCYu80mjuWWoU3ZfVSZcaxyy9FufVNVgMelzhFmunGMkUJgUaQp9U?=
 =?us-ascii?Q?LUsobY3CDEY1hT5fbiAZRhz7H8jVXgic6zMMiFzWQVBBvE1057Vi/3MI1n7x?=
 =?us-ascii?Q?0Y6QNxXvYECEC3VwegJZSIK3pIcNdngjrcYDQI4qMxKYSKF3x+O8n264PxJy?=
 =?us-ascii?Q?b9YqZp7+Mt1fbT7Spi5oMS3i7N0ODWRdEm9enSy5TEcAS1ryM7xANpNaGZBb?=
 =?us-ascii?Q?uSYDr2PfhDWTSuwNH8AsV1y5uG6MMuRnu/U5XxfdAbo984BuYGhSayNeRvMD?=
 =?us-ascii?Q?fe5RleRgubdUF3pflV0U/ela1+OgqyQJUa/efLVkY3R/zCxnqSzBGR00KIsr?=
 =?us-ascii?Q?tMhgC0ueULQ6rwE2ovjMC3e8CLoU1h04y9bnT1R7pwmGya7IBtwjsuIuk67i?=
 =?us-ascii?Q?msggFkoebVs5qSqOUKcN1BsTgmrOybaxxGHZu/YO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801a0846-d37b-49c6-19b2-08dd210cbfdc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:19.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C8dY68YaADPlDSpY2kXeo7yU2cpoD643Zhs4EjV55m85mPsOF5uG+DYY9Jdr/uCvkmyAZSQqmfmvdviYPZ38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

Introduce for_each_numa_hop_node() and sched_numa_hop_node() to iterate
over node IDs in order of increasing NUMA distance from a given starting
node.

These iterator functions are similar to for_each_numa_hop_mask() and
sched_numa_hop_mask(), but instead of providing a cpumask at each
iteration, they provide a node ID.

Example usage:

  nodemask_t hop_nodes = NODE_MASK_NONE;
  int start = cpu_to_node(smp_processor_id());

  for_each_numa_hop_node(node, start, hop_nodes, N_ONLINE)
  	pr_info("node (%d, %d) -> \n",
  		 start, node, node_distance(start, node);

Simulating the following NUMA topology in virtme-ng:

 $ numactl -H
 available: 4 nodes (0-3)
 node 0 cpus: 0 1
 node 0 size: 1006 MB
 node 0 free: 928 MB
 node 1 cpus: 2 3
 node 1 size: 1007 MB
 node 1 free: 986 MB
 node 2 cpus: 4 5
 node 2 size: 889 MB
 node 2 free: 862 MB
 node 3 cpus: 6 7
 node 3 size: 1006 MB
 node 3 free: 983 MB
 node distances:
 node     0    1    2    3
    0:   10   51   31   41
    1:   51   10   21   61
    2:   31   21   10   11
    3:   41   61   11   10

The output of the example above (on node 0) is the following:

 [   84.953644] node (0, 0) -> 10
 [   84.953712] node (0, 2) -> 31
 [   84.953764] node (0, 3) -> 41
 [   84.953817] node (0, 1) -> 51

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/topology.h | 28 ++++++++++++++++++++++-
 kernel/sched/topology.c  | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3..d9014d90580d 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -248,12 +248,18 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 #ifdef CONFIG_NUMA
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
 extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
-#else
+extern int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state);
+#else /* !CONFIG_NUMA */
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
 	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
 }
 
+static inline int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline const struct cpumask *
 sched_numa_hop_mask(unsigned int node, unsigned int hops)
 {
@@ -261,6 +267,26 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_hop_node - iterate over NUMA nodes at increasing hop distances
+ *                          from a given starting node.
+ * @__node: the iteration variable, representing the current NUMA node.
+ * @__start: the NUMA node to start the iteration from.
+ * @__hop_nodes: a nodemask_t to track the visited nodes.
+ * @__state: state of NUMA nodes to iterate.
+ *
+ * Requires rcu_lock to be held.
+ *
+ * This macro iterates over NUMA nodes in increasing distance from
+ * @start_node.
+ *
+ * Yields NUMA_NO_NODE when all the nodes have been visited.
+ */
+#define for_each_numa_hop_node(__node, __start, __hop_nodes, __state)		\
+	for (int __node = __start;						\
+	     __node != NUMA_NO_NODE;						\
+	     __node = sched_numa_hop_node(&(__hop_nodes), __start, __state))
+
 /**
  * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
  *                          from a given node.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..8e77c235ad9a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2185,6 +2185,55 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 }
 EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
 
+/**
+ * sched_numa_hop_node - Find the NUMA node at the closest hop distance
+ *                       from node @start.
+ *
+ * @hop_nodes: a pointer to a nodemask_t representing the visited nodes.
+ * @start: the NUMA node to start the hop search from.
+ * @state: the node state to filter nodes by.
+ *
+ * This function iterates over all NUMA nodes in the given state and
+ * calculates the hop distance to the starting node. It returns the NUMA
+ * node that is the closest in terms of hop distance
+ * that has not already been considered (not set in @hop_nodes). If the
+ * node is found, it is marked as considered in the @hop_nodes bitmask.
+ *
+ * The function checks if the node is not the start node and ensures it is
+ * not already part of the hop_nodes set. It then computes the distance to
+ * the start node using the node_distance() function. The closest node is
+ * chosen based on the minimum distance.
+ *
+ * Returns the NUMA node ID closest in terms of hop distance from the
+ * @start node, or NUMA_NO_NODE if no node is found (or all nodes have been
+ * visited).
+ */
+int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
+{
+	int dist, n, min_node, min_dist;
+
+	if (state >= NR_NODE_STATES)
+		return NUMA_NO_NODE;
+
+	min_node = NUMA_NO_NODE;
+	min_dist = INT_MAX;
+
+	for_each_node_state(n, state) {
+		if (n == start || node_isset(n, *hop_nodes))
+			continue;
+		dist = node_distance(start, n);
+		if (dist < min_dist) {
+			min_dist = dist;
+			min_node = n;
+		}
+	}
+	if (min_node != NUMA_NO_NODE)
+		node_set(min_node, *hop_nodes);
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(sched_numa_hop_node);
+
 /**
  * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
  *                         @node
-- 
2.47.1



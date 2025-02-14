Return-Path: <bpf+bounces-51591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85453A36650
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80593189497F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AD1DB127;
	Fri, 14 Feb 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkJc0Ru4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E51DA31F;
	Fri, 14 Feb 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562128; cv=fail; b=kFcHaTHr4M+o8ljRLr3Il7IBt5VqdRmKI2L7zhEdvQsfFWNpBT5+bLCL9ra96kFFiQVf69C8A8NW2i62QZTjFaLBTXyWEDC9NjY01mxEy69hFleAfPcwSvthBrBbS3ZwZ6MV06VB7LFQHZYtYwUvcQ8zpuDuMQ9e+hNeFXJVM6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562128; c=relaxed/simple;
	bh=pVAiNBUT6jVisQKGQ7Va71KZvIlnoTy2TLlx0HM4OSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7sl+UUgooxgTvpmOKbVTOs3WVZpqZOPCWbqntLPCugVnk6FgSvyFibl2FOtRkb/w37zX2SguRwqgbFEsMP2FQbJhGPNAlx9rMFALC7MfSVFGuFWnbcPQQclzh2hjFxFpP5tL76V2XvU3/G3ww1QLNe87RBiQrO2IhkJfjhK+d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkJc0Ru4; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgn25fYO+gBevTF5pxKKuU7/L6vW1zql0PUiPemGvoM/2fl8VMSeAikFD2CKr9tpN8PSR/iiehrW7+RFsAINCjJly7jPo7Mf7tM9z65VEEgcharBooV5mCWWLvcTKklp3onxu6/V0v3UYuhuJKCTrGaTvKkDVjN1QoFFGqULu9VVvOHOuR/sPgWxc5qp3GlQqjEXtggCREzmX4qFAWuhKHm/hROpWwKwXpixZi3Pe7PIwvyrGxMOC7gBPSW9ocoPpdP1gWY286LAFTdFAc0JwmFUNlkk7WF6ZCacDTt4ej9OFlpRZ4vrmfT8xSDkbudoOmNIjX4q5mevOwOqhLQA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHIKu4nBCiUgwyvw8fABVAjzYFlRa1GSTcgtMxEW9K0=;
 b=yIY+QTqYk4eDFb1aTJce0kFKwdnEKh/B7oz2kETiwBWCcbRWmXV1Rbx9yBGCBVsDYdQkXY9vpTKKmqlIYsUm4XERf+GTWDmLHGTAjUEWf32bTQLP/8gkVaKq7qNRNvKgD3+tjbVRolzIwcnVLeTMW5HHU66QL6Oooss2BxwI1lLuTDIhxHpKUah2neofxRV+BHY5XfW//nVV11SZUUKSrN+Z3jwh1a8/AENxOlWX0EbPHVca0ncibJo3ZB76Kb7hUpv/wW2giQ5oJ+bgDa5o3MnvyuPLZvnS3IDpDRkH2P5uOZXgHjG/uHjjxj0VSULBARHjvTiFNIBq5NHhcv6EMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHIKu4nBCiUgwyvw8fABVAjzYFlRa1GSTcgtMxEW9K0=;
 b=fkJc0Ru4yE+/mfS/ZGjh5bQ2YgOzF5kV2M5yfQkcZ2UH2bXr8tQa9XDhxA6Jzu3JL4doD57RzPVelbMBJvTzytqXK7fhgvIPU9qb++45yaSHGPDCCg7vaw5Tw3TQe+HQ6VagRGq3mgl2iLa9ijubnMZeREHKJeEeIhkjjlZ03FWUmWoQYE3lCwPz7EMlWylG37M3QLoGPvz3baWlb60neXF2u2c9Lg41qHt6dSeZUghN68YlkIrWgHsKSMaTiOxX+n6Afe/dtapGOyQjaq4AXTUTxeQUJObLrYo/1VhFtM9cRoTOVoGkMnN6Advu+KnqJLGCQf7Mi2TZyIMWpnwo3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 19:42:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:42:03 +0000
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
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sched/topology: Introduce for_each_node_numadist() iterator
Date: Fri, 14 Feb 2025 20:40:03 +0100
Message-ID: <20250214194134.658939-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c72032e-eee2-449d-1598-08dd4d2fa7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?USYEpbzV9TypuRHFDA2cvoBT5GX6AzjQxMhdBBlZby0/Cw3unrtkOg5Kapuz?=
 =?us-ascii?Q?B1Qtg6Pj97VSULVgcvoneeRKBGpTKHKVFSDzywkgJ38x4O4UP0jTkeJMA2VG?=
 =?us-ascii?Q?Y4YJfK2UxRUORfzLytSKqpmbGnp/QQocA0+PY6cF9eVf1UIZfxbbH8i9qI7n?=
 =?us-ascii?Q?xbCWK1OuqXHmn3uGU8FBn8Cp4OUqA4oHfvdyTHiomzGl5AoWWHGDDvRNY6E7?=
 =?us-ascii?Q?9LyT5QEQTCumw+S361w+RH+cIOJlz7/SsgDKK/OfVeMou7CWrcu5WQidxfoo?=
 =?us-ascii?Q?SRljwT+TY5kev3IvTgkeNJDXWn9wNHtaXtzH0uw67mkzUAyBwKfnwsxdsGlM?=
 =?us-ascii?Q?LHczBr6G/TVbQOyKjQZG7FX41GSwR/PoId+F4j/i0ba7u76bwRKAUXX0kzcb?=
 =?us-ascii?Q?qQw/gjNoW03JanYKWY7ImCvKZ0Iy3D2qTBw14S8fDHF9EpOt/zpr4p5/x44s?=
 =?us-ascii?Q?9Me6gO5af/nXHmcKZRJLhB4sQzPoRF0nmykCawGHkDQcglI9uE+WmVNf9bzz?=
 =?us-ascii?Q?HCsSSrv+7tIuzaXi2uT1061oryslUZMEzs1GXuIwJuSLX6/ZtoqKs0eo/Drx?=
 =?us-ascii?Q?mVxCIbKS83mIpN6M/oVVQ3dfd+YOlKJ8xcKs5Vh/S1vu61Q6JdGtNc9Gezdu?=
 =?us-ascii?Q?3/aZD+ldkZsYDhzPFgixxPwWrFunreTs842qDGRGuFK9CAY5hrMNSQPr/g9L?=
 =?us-ascii?Q?6f7gvuR/imutWfef1Sqe5ziG8bMgmknNC40gQutUyKJyzKsB2JOl7xxsFBUj?=
 =?us-ascii?Q?zUFfZoKWWIybRePhZjEgVeGtKmpL//KANl9qJrP1TnTQlLaPLCz/JpkGTjgN?=
 =?us-ascii?Q?ysuq0eiqFA4zOM+ULs0x/D3UjGQSYS31Ao302myqi/wfYd+U/6O6OTkmGmLH?=
 =?us-ascii?Q?ljT5kRa+U7p+XZWqXuYbOgI9lvIneVoYGEhYCB7UynnOMVJYuF+uwV4EiiRg?=
 =?us-ascii?Q?8EC0onTN6O4DVoGKSZT8E10enU/wMqGxwTqhGup2g+z8tyUZ+yBQ99WSVyDh?=
 =?us-ascii?Q?K+HyMyLVRXVdmMNWgXmm8sIsmeDqXvScoxKBbox4SEP77l9Nnm8BJSHpT020?=
 =?us-ascii?Q?UZUGyiuGpnAnNedoSWJZBmfxZCKbvwa4T7r8Joc0ETo9MwguhFIbVPyKPo7T?=
 =?us-ascii?Q?cxU4xsUWbmxL8hpUrjtVpWj+u/AuHzL4+XqpmhmWSLGUZ1tJDRUF9aqjNxZD?=
 =?us-ascii?Q?edg5SvGkUb/PJ2AYw7jda3KBXVsni054YU2lN7qeh2l+jgprQMltF/Em8g6Z?=
 =?us-ascii?Q?fVhfEUxQNNJf3pP6v3d5NW4cu8PjHfDVH8bnb99Febo6jmQSrm3DHOqLwn/J?=
 =?us-ascii?Q?RORplTuaxXh9LkgAimcMzSQ7l6/JMdFDwAk91hkkaXgrGcz9eVc2It9ow9P3?=
 =?us-ascii?Q?LuXcBWVekGEPf5cQ/KtB3gtW1MQJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RImc71S43xn+6AkZwNlFPvkTUB+Lai3fyf59otAVjE0LutrIkbJMdCNQm8aj?=
 =?us-ascii?Q?6h1UaoWx/AtWEV/IuOMGOvASdvFlhex1NfmgHx3N/Ru6G0Rstwo3eY9vNvNE?=
 =?us-ascii?Q?5t5AUG6bjO/JKsn+E1TezPW9BOztltVhzhkmAnJjvhxvfRHM+Whi2yIFgEZG?=
 =?us-ascii?Q?Odx5q+LQse6FHFL5uG4YZz6ztcgAoQ1cPSEfrXwW8ZB4JP8CWH3K8sb/TVPQ?=
 =?us-ascii?Q?eXycdk8rTvF+eTH/oNSGe0fQiXMDF0DRJOhdeF2mnHIkRTtJdLlnWeRre/KV?=
 =?us-ascii?Q?wkVLYVUFH4UUVmxlDnvs/MD4Pqz3zVOJmenST4LUO+O6F/yJSA4scRZHQerm?=
 =?us-ascii?Q?d+Nyrjz/uDlNJx6TMWBcIlcjAPs+gllb1bWkBU/AIPNXl8JyW1/LL2Q65T5s?=
 =?us-ascii?Q?hg5wfK1O09tThBQCswF8/Q1yy4Wutbyr/x8NnU+qjouOMA1ApbwdT1hYyZ+v?=
 =?us-ascii?Q?XnCUqW3JxNy1vUN5VSzE98So1PCTojmzr7U0yawFvBKRKg8eklqJR2bWrrSy?=
 =?us-ascii?Q?K79mjVNcoeLft4G2yxINytHzj/XAdLQQ5+2IqisHW3+nBXf2bQKq3qb8VJMt?=
 =?us-ascii?Q?lP/aDdRC71SHTZP3NPStq2zsoAk6VlwJJ9TEtNO1ph/8NUffK7Iy8bc05qXl?=
 =?us-ascii?Q?1NdhGFDarrrplDVbSejwQBoqLjlDVXHhORnU/BGZZVVDFuIbQE2dYBNDazbR?=
 =?us-ascii?Q?8DcsJik8O9GkUBvuGdVGblcxFucREBsxIMLe1wShcFNxhRdpdw7b4qZpHwmF?=
 =?us-ascii?Q?sDzrkgr6TEl4+c9skwt6uEarhsNDvXEwZvsA7JcHcaGOygHAd3Bobxfd40z1?=
 =?us-ascii?Q?sPtOJYpOD7cX3qTcbIKlqU61IXMALWt/EBWv6/r2WRUAY7Y0X/pLsLTjcgGl?=
 =?us-ascii?Q?cv1f0knI0f0F6nfWUjRpk61+/2jqF/dzyNmtRCc3MBL3behshAJRsEn4YzhB?=
 =?us-ascii?Q?sE3tga2zPuD3V4mku5/ofqZHmQBqcHSUStacCSRtdXmFUgumPLP2ECJ/96gQ?=
 =?us-ascii?Q?l/sVaRLol2DQks/jmNhSBGewZ0AHHxllcLAWNIgiEzxg7GBcpuebPSaTHnpm?=
 =?us-ascii?Q?SYvj4g4sv3E9u3qSju4qloyQ8MMSzJuSBsVBmUIaX5qAmtYpjgk9ABctsXHc?=
 =?us-ascii?Q?qRTtNjUnlUHgnDnY2jQ9AE1MAmEjAtBV3LrVfQOyBMMFIAFb3b8MGtJEo3OW?=
 =?us-ascii?Q?krK9xLSY+f71fCBojc9QyL8p7sac6Xg6sTpsuFrfqR4f5z+LDLSjwkSXABGZ?=
 =?us-ascii?Q?OPLSKGwqacp6bW5v0CY6dfs/7zFTTXJID4zAAKCpQTLN4NG108J0XH6MTX03?=
 =?us-ascii?Q?ZwEJtK4F3ciHyztEbOQpbaE8dOWtXew5kgtXOI4cRJcrcnOilkAD7kpNBgy5?=
 =?us-ascii?Q?0wsgUTBxqJkf9WbsxNasNtVDg5hSHOZ+FrEbs2+mmbgHpdwopIxnRrTTv3pN?=
 =?us-ascii?Q?2KSyU/1b/Oier8fzm7cgcGKclWaHfHNYWEaAkcjfVbLYFAJVW9KJ74Tde3tW?=
 =?us-ascii?Q?BtwRDT3kfA1LT3FTYLFWVbdKz/5gUzw5ViYmOn98LE5Fca4dCi4IrUQ31tMu?=
 =?us-ascii?Q?i6xDUizQYfzZovEOfL5BnTc6VQCeynyXl/M/+BbS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c72032e-eee2-449d-1598-08dd4d2fa7d8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:42:03.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj+r+qJJMGQ3yTR14tHJWK23rUUy5rXDDVo114GBNLGrKcujBNLz90P2JO1sbk4hB3OfgiSPhML8jTI4i7hcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Introduce the new helper for_each_node_numadist() to iterate over node
IDs in order of increasing NUMA distance from a given starting node.

This iterator is somehow similar to for_each_numa_hop_mask(), but
instead of providing a cpumask at each iteration, it provides a node ID.

Example usage:

  nodemask_t unvisited = NODE_MASK_ALL;
  int node, start = cpu_to_node(smp_processor_id());

  node = start;
  for_each_node_numadist(node, unvisited)
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

Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/topology.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3e..a1815f4395ab6 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -261,6 +261,36 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_node_numadist() - iterate over nodes in increasing distance
+ *			      order, starting from a given node
+ * @node: the iteration variable and the starting node.
+ * @unvisited: a nodemask to keep track of the unvisited nodes.
+ *
+ * This macro iterates over NUMA node IDs in increasing distance from the
+ * starting @node and yields MAX_NUMNODES when all the nodes have been
+ * visited.
+ *
+ * Note that by the time the loop completes, the @unvisited nodemask will
+ * be fully cleared, unless the loop exits early.
+ *
+ * The difference between for_each_node() and for_each_node_numadist() is
+ * that the former allows to iterate over nodes in numerical order, whereas
+ * the latter iterates over nodes in increasing order of distance.
+ *
+ * This complexity of this iterator is O(N^2), where N represents the
+ * number of nodes, as each iteration involves scanning all nodes to
+ * find the one with the shortest distance.
+ *
+ * Requires rcu_lock to be held.
+ */
+#define for_each_node_numadist(node, unvisited)					\
+	for (int __start = (node),						\
+	     (node) = nearest_node_nodemask((__start), &(unvisited));		\
+	     (node) < MAX_NUMNODES;						\
+	     node_clear((node), (unvisited)),					\
+	     (node) = nearest_node_nodemask((__start), &(unvisited)))
+
 /**
  * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
  *                          from a given node.
-- 
2.48.1



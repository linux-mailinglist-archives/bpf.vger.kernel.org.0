Return-Path: <bpf+bounces-51276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8845A32C77
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5833AB317
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179C25A343;
	Wed, 12 Feb 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kz4ltnCb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA2257439;
	Wed, 12 Feb 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379040; cv=fail; b=i9e20bZwibj2S0j7hlDpKJkzAphIQMAXOnF0+Y+XLKCrfXyCziQtRe3SQv+K8lU3ool/P0e3JS0eThPQOJNnpK3rHupBTkDAOmtKTgI2TDHf4AATFKQzpBrzhXwpDGDrPR06oOIy38GeZ3ObzeKW0xh3NPR+BU9bYQq5nV4pwlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379040; c=relaxed/simple;
	bh=St2v1r5ySAVsGsxeK0bBw50nu+iIUN/8rwO4XeQkIKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IREQn94MFfU/NsRMKYNRUU4sfpC8pkOOXwPz7dQWCNKgRtnprLwL1hj5urnpCdr/V6DMbhbgXjjcja/c9LgXeoR2O0y72dikjoUzCUSGb4v+nhz2oNY6n0nPCU6sOnjabV+WTNpdpa/yHAbKVEhjvGimmqauPBazOVwnVD9q03Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kz4ltnCb; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYhsWaqk0vNlPF21ks0mUZoA5edeb+OXazgGtDDp8OwTjng1gHkINSg7JHin65cT4gEha9+bUQKJ4PJd70v+w9JiF1K8/tTo2FrKZRnpNYyyLAvkt0vkfl6Jpf9nermnfxKjIiXcAQpUjCtvrfEwXDZd3in9YoJ7Kz8f/wGd9bMDjugXXu/X4UPch6EhjESjNZCjY9QT+/RyaFGlyvxSE1RTrHlrhU9K4M46AsWP+H9Ab5wNW2lVDg+AWPvx65k/bD5ivO5ZhH6owb/R3hlcBf30qYzAsUnSXqSlo0Zml9f+zJcHBCvmCN/yXC0hNlCCzmcHDNpbHdcJXRXF0RmkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVLHWob9pWr5FytegMnz9CiEpRbFdzvOWQmRY/JOmkE=;
 b=KjA+Yyqfecpbyo2t2tHxzyowCxVk2cBZmsXrAxufOpxtAEEN+Klvg3P+NuldViy158hA25jMI+1vudo5c+IPkVdzm/aAqff8n6P4eVarjyYGJF8x1ycDIZyOAsjGoROVhvhndjA9683YVY933ETGUX6naPbHc7a58DH6dMul2v+QDqZPhStyNRl+oGJOcQm0qWV20X8JQccgnuHlqQHjBl6g1LQLw5YcUXj29vyJiNt4BAdn6GGPOBz4QzY+9SZgFkIapDvcAN54cdXMn+ShB0SXxSIlljQFVdiwI1/568kNQGIwqHBilU1wF0ivIpzSaILsl/e9X3dsyQLj2szpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVLHWob9pWr5FytegMnz9CiEpRbFdzvOWQmRY/JOmkE=;
 b=kz4ltnCb6uYI3nhu7UVXIRw0oHAlUJtR/tOFbLBYmXVYbjqAMxBYIw7GsBM/uesVwF/L1QEq02zxgCEWDVOIGiwDIG/QI52ZUzCRNGIdf2Asa8txxLtx3ikbHzafuFslyS6Om9dL2O6hC5Hw+uS2jfI9O/BfsENOEHw4XCoZc1CC4btMZ+zDzFMbWYyLrpttM5aZgZFr8SjigW5rUSdA6yNBiFAuexJr7Qs6nNjczb0I+fNlnMv1IRGkdH1I4GXsxMwsJS2jhRVOEmZH+C5BvEtUyhTm0bHmQl+VZOjLq8+qopEG7ebTGWx00Gv2ysbpeI6zD3cRoTFwKGfmJlXOvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:36 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:36 +0000
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
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/7] mm/numa: Introduce nearest_node_nodemask()
Date: Wed, 12 Feb 2025 17:48:09 +0100
Message-ID: <20250212165006.490130-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 06429a17-d16d-4cb4-3dba-08dd4b855f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNZkNUTm7m5b6YzHGVp49Eby92nHotE//4iVBEXabtzmq0WUjbklcqIZjk2u?=
 =?us-ascii?Q?rBLrTvFy/1hbvV1iVIr+3jqhzqm3SwJHnvEhkQRYckr/GA1M30wUVtsMILJ+?=
 =?us-ascii?Q?Z6l/cXTaTDcO05P9IkVw6UdXrUuksIalL/gl9ztd5ScC2F0A/CfinixsYaac?=
 =?us-ascii?Q?eqCRA3larpjK7gPLIaMNbS/OYgSpFWMLhZ7eukxHqzJHjvkr6+0a8wH7w7IL?=
 =?us-ascii?Q?ImKsem9ZP7ERZqbyJjhkVjx/Ktx3D9PXYRvlAoYstS0qOHEmreNIQsim171I?=
 =?us-ascii?Q?DF15UmAFw1GH8Urv9qeMRwhpqi5ZQmW1bfxmk2h5FnauAqGJrZkByrj7jfK8?=
 =?us-ascii?Q?bxAf2vW7+gAO1TR3eut8Xy5zMokqswDMS10XxSkP0xZuy4dXBqbDDdT32rtC?=
 =?us-ascii?Q?asfg/mlzaKT9/pGHSQJn+zT5U/DhP8OHGG3ackOJ5vfoquTJobxzChD/pXe7?=
 =?us-ascii?Q?A5whM98AexSGvWersLliAnyjVj7w7cFvzGAXQL6n9HOm0c2bQbIMzoTuMVIK?=
 =?us-ascii?Q?+VzXvTdo8m/QbuEXvkdg+Ir1KkrCWK28hppZ9eJqKgSJGvtxAMZU2uxeUrAs?=
 =?us-ascii?Q?DzoP6Sx8I9S7pQs1M7ihnclDC3VatsYQUakpk+pfv3g2se0P5aD4PP5bea0a?=
 =?us-ascii?Q?z3ErYZnL+yTrCft/w4DvVwsviRiiwBVw8kiiqx0QDHN2+gxVcXtKOFTtmmkm?=
 =?us-ascii?Q?7LA6NarJNRGWKGTWCYfuhFC7Bg+b9NrRcvEzwuXAYXbThh1aa08jibgGyHwf?=
 =?us-ascii?Q?A5bNN1XILKGrEkTgfXEq+mfuQWT8tZO+wbh8mXBmxKLhzYB+Rv45Fve9GW6a?=
 =?us-ascii?Q?t6p5JrPzUgLUw/EWBiSGzTeZWgRNGlHM6X9RbcwvmHWsyqb2HvxiigyFoLtI?=
 =?us-ascii?Q?weVoI1RL60Gmx39ApiQiEm8oSBLM4zwTCO4IljRPQ6IVYYI6s6ABiJn6lEJS?=
 =?us-ascii?Q?GBlUpFHD/uZQfe0riLJmutXFDDci3oGS5ZNoDP22xqGYSuEDt3SCXZddUfE2?=
 =?us-ascii?Q?5SXWWrJ0fP2yI+xhy2GdVabT1JKjWcr7IOnhgJV6P1zr3uOab0LIJSrYOrBg?=
 =?us-ascii?Q?hJQY+qkDNe3rYo59gaCsa6bC/UoTCr5+IpF/X61YqL5NQ/BtsU8CxUwQDBrf?=
 =?us-ascii?Q?6bk3blL8BvAzI2AvdT63XR7F8WtCWeKgXNpw8z3lz+soZ2jtnL/qHgDS16Hd?=
 =?us-ascii?Q?Ud4VDnamJWwk8a3yIxRbBko+55tJd254/lJWdtwJlfSQ9U210idciOY52qy0?=
 =?us-ascii?Q?KPI5hl9FEilMjwOISkTQlDPC9T0eimOvCXP/A2jqODtRJEQBfahQqk9wbnN/?=
 =?us-ascii?Q?F03hchTyr9DOReSKO+VZW0oH8C8c6b4BPlwiE8UtZX3hGWix6J1CeL1K1MQd?=
 =?us-ascii?Q?JJusKFjlsbbxDdj+zWKer6Divn3H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHlbhitbtQwincmYRu0ZFZPcpFzt+QDadUjHgurFe0FlQ210H2/suue8xjWj?=
 =?us-ascii?Q?OBaiZbMTH6LkVVyKwDVJvMu04RqLjhWP5PrQBVVGQUxEdnpIrUM177jOtjhY?=
 =?us-ascii?Q?r07YOqkcq4Sx5xpRkJmKP+OJs6xjrouNnYKM4mIiAWi83gPR6JU9qJQwL1GA?=
 =?us-ascii?Q?H35IwH0TIDnBKqMVofkOyx6KHAfv81GDjjSAx8NevYDKZSafhSQUVeBB08Rf?=
 =?us-ascii?Q?+AmKrLpPhPFnFkzeWWPJIluB+AB0nTV0kgdfLXVwRjtAy6nyi/qh3Ri1BKcP?=
 =?us-ascii?Q?v10Er7BDqMdy/1sNLQOpe63koh4waeJq6yeg5ngeYrTLjI+/sYFfq6gu1/FJ?=
 =?us-ascii?Q?OahfR9eAWAIRmWDh5WcaSYoXRBavzfcWJXB6IbmCgmzzEbuusHflqWf++voP?=
 =?us-ascii?Q?qKKAJlnFbVTOHfnvnrLbaLdMDSc89vJ67vFsvmoHycjCQioHQdMvmEHqxzYG?=
 =?us-ascii?Q?ujMIqUU4TvHS6L7l8Ha0XcsRvntQG8XuBRF+FOik7U1BuCXZ68Uatn2/wT7/?=
 =?us-ascii?Q?i7gIH/2/w8YuT7hhYBKoHgxvTUG9IE9HGmLvW0Hzja93hMAA+wxznwP4d8m9?=
 =?us-ascii?Q?euWB2XWrFcPoiUPyKzSdsGxIF7dkxABZSGaZE+wnAl9nZyI6abMmoY2tZjPh?=
 =?us-ascii?Q?BpX+R2WNv2fIJD/34c2veRgkdaof4G1Zg4mL7nefPgHTq3LcUVKETO6+undp?=
 =?us-ascii?Q?VqjM0OYxAP1NGDfkoZ1ErRb7gADle/yEzOHTNWcZ0xFd8mRXzI5CHy/Jiv6a?=
 =?us-ascii?Q?WS3FC47GGCp+pRHaKBm/nkOEnzS7ZklizfbWyuz1xp6MgR9wQDFg6jyAOsHE?=
 =?us-ascii?Q?L8vIeFmjkX+Xw6CIu/uJ7fUP8DGCbPbqPoq0PsegJqqQXQU8Qqmx1TSVw1D7?=
 =?us-ascii?Q?3OUFGG3YJxoolLwOyiMGLAzFGNfu5TEh7n/Ub1+ESlTVmWfg/b8+S8sJxhY9?=
 =?us-ascii?Q?teh4L56UQZ06hAXIVWt4nRQLuZ8wBrCgqZm/B4ghgTSZ9eMoWlqi2u+GKJyT?=
 =?us-ascii?Q?a/I6vATgYTC0cVR/yJ2YShg6ylIqX1JxZrlKVYtczpkomnxODyIXhE8YRKZG?=
 =?us-ascii?Q?cfXuKbdioUg2SLY9t8lpcHRvNGyJMgf2W7+y2VtG43OE0WfYhJQQvAS+CwIZ?=
 =?us-ascii?Q?122Zi9oXiqQw9Z+kG7abhTu2LXHztwNnZ1NtLTn19qWG2eQjizGRGuwkM6l+?=
 =?us-ascii?Q?rIMp4nCKlBWvrXmjQTC0XaVjhvCWsdq9+oqjaEqSqRpswOx7BVnqrs7WHmoQ?=
 =?us-ascii?Q?hQj9vVjJkWz6ifKhYnoHVcZ7z3TYwnukGWeGRp0pfIqPIzhcC1B1VK3S/P7P?=
 =?us-ascii?Q?gMLfsSx4rU7TBeMkqI9tRvay4VNK+fyJvGoyCzpLI3XFCtFKZzxWd7hYhhzD?=
 =?us-ascii?Q?Z2oYIXP6QsUuCMZEyuI0hamGeVYCVOLNO+6iKIvejKGq/utaFuObb4so+d/b?=
 =?us-ascii?Q?borUKASdswkPwEJ4mrXyHX4YfD0vtU/NXoDoV+5FFAJiRSQmn4wP+fmqmdoK?=
 =?us-ascii?Q?yO3V1p2uuUlTZOXkOl/eJhGHJCzjtS30Ki57ftfJ/hlZqLk/9sPRgowzxydO?=
 =?us-ascii?Q?bFYD5x4JvEjTMIzf2FLQAXsxwebsCi85iES/fhsq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06429a17-d16d-4cb4-3dba-08dd4b855f9c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:36.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR5pkTHmHoQPYiB6yfcW32z7W3yoUAILXK7IfR3GfZFr0b76/fBaDZuLx49WwcWlV+t+AT5eHcnUlWsvntQ5Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

Introduce the new helper nearest_node_nodemask() to find the closest
node in a specified nodemask from a given starting node.

Returns MAX_NUMNODES if no node is found.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/numa.h |  7 +++++++
 mm/mempolicy.c       | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/numa.h b/include/linux/numa.h
index 31d8bf8a951a7..e6baaf6051bcf 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
 
+int nearest_node_nodemask(int node, nodemask_t *mask);
+
 #ifndef memory_add_physaddr_to_nid
 int memory_add_physaddr_to_nid(u64 start);
 #endif
@@ -47,6 +49,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
 	return NUMA_NO_NODE;
 }
 
+static inline int nearest_node_nodemask(int node, nodemask_t *mask)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 162407fbf2bc7..1e2acf187ea3a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -196,6 +196,38 @@ int numa_nearest_node(int node, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(numa_nearest_node);
 
+/**
+ * nearest_node_nodemask - Find the node in @mask at the nearest distance
+ *			   from @node.
+ *
+ * @node: the node to start the search from.
+ * @mask: a pointer to a nodemask representing the allowed nodes.
+ *
+ * This function iterates over all nodes in the given state and calculates
+ * the distance to the starting node.
+ *
+ * Returns the node ID in @mask that is the closest in terms of distance
+ * from @node, or MAX_NUMNODES if no node is found.
+ */
+int nearest_node_nodemask(int node, nodemask_t *mask)
+{
+	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
+
+	if (node == NUMA_NO_NODE)
+		return MAX_NUMNODES;
+
+	for_each_node_mask(n, *mask) {
+		dist = node_distance(node, n);
+		if (dist < min_dist) {
+			min_dist = dist;
+			min_node = n;
+		}
+	}
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(nearest_node_nodemask);
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
 	struct mempolicy *pol = p->mempolicy;
-- 
2.48.1



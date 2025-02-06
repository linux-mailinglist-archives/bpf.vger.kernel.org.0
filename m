Return-Path: <bpf+bounces-50694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF9A2B352
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD033A59E9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E291DDC0B;
	Thu,  6 Feb 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vv0a5mfa"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EA1DD88D;
	Thu,  6 Feb 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873316; cv=fail; b=PI9d5orPH4SF6g6QACR1mP3vHHmuC2EtG7uykYbjJJkNquUFhJmcgR5heS4yvDSHVqUh1LHWeIuUsKLIrXr3ZwIt1SwMXCb2zvcZ2RMpXqCAU4AbgdMVClIb1ZG3DhAbrzPndUKPTqXl0ySy5+8VodHienCgi9oI6230g+Hxoq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873316; c=relaxed/simple;
	bh=LqyrLHSXL6jnkmBrBqugmKkAoR3HbJ1fL37Ozl8qTNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXYcn+C9MCVn5bkaSrBeJpNI2IT4G583Rl5Gakb8JXj2mQxX7DCLpM2lg3WFCaDfrQq2eNFJVDF36FB+5iMyKtQMmI6ic10I0P3+nobo/pQ+pniygbVOZG8sarnOJMmpDAaix5YiStsvl7sbu3XpdtGtUq/PkUFgHTiLQGAKASY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vv0a5mfa; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v93mH5LhE5+FLP4Rh5gjBfL4SC4K+LhvZJmMOFz5qhmb3TPXStejn+9H52cack18GYa48UUmF5+5d8KspiGNSZdqQEEEYbqeuCsr+WIZjArW035MgqcQIHO/UK0b1oQmaeK56HcQ8ofwpEcMylwZu6u7cwKjwfEQxmAjRdx6g8D9luxTK+aF/wDUqHb3AaivSs0th9PIBBOWuEqk8L1N7DEPjdnHmLIX15BpGIhTCGziDgWKZQ3PxQg1aQqBr6/FEFBV03f3ac+QOH450vA0apFYe3NovSCb7SVn7+9dWwECedunwuHgFJLKHnplMnBAn0QmxgVlcoufCk0M1hDKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVEPn9XqLa3m61C1zxeSSIOpUaFl+cdrHrASERdp54U=;
 b=tOwXR0X6tZfTJzR3kFC0E1Kamgr4x0msJ0jYLLHE7LclOijFYsxyWAovvTVXo+7qZ7Pqzb4iwc1+b68vpHtynYt0mb9tRrSLFHFWYdjoIrNFMLcVEJvka+VvYSwxnn36Dop/GClWxk1g+f1y++t+4/wPHlOC4vu39NTHDOsd8SrLDznssFlFXX4X6K0IUlStbxQeeQ/Ct9mTIAsBNUJS5E/jHpCumXsUlRdjT7kWGkcQ/ZLEewX6LvmybNP7p/61Jt/BP4+j9H//ZrrbZrWOLK6kGSswzQkvs+/jYiv9lVrSfiycz+YbCMPylIWt9TfR2dmBU0t7lCckg/mOiupWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVEPn9XqLa3m61C1zxeSSIOpUaFl+cdrHrASERdp54U=;
 b=Vv0a5mfackPrGsK+5TU3/28E1NDnvOo07Z8/ZvggiJG255rECfuWouuJJaJfHVVQyxSc5Ze/7ZG+4nwdLs8+epzsfKOfGQV4mvXsigsymL46QcUfNfvoyhn6GcHMOR4OsVBBHTXBFx8lcqW5vUwpd1bUt4B0DT20lRVZZOR76gj+XLSyb5qk0zucTtywZKxf+7mluzfpjYZkSIx7bRysFPROYtNGnYoKblZMmM76Hb0F845z3qgnBvanvvTn2VlSniCQgZDeRbm/tzGXrIqmNi7rpB80OI6RPps/PNdw7ZRLmsOjrDOMsMqp8xHidURKps5HsZf5mtbrxgCKPZztPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 20:21:51 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:21:51 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sched_ext: idle: Per-node idle cpumasks
Date: Thu,  6 Feb 2025 21:15:34 +0100
Message-ID: <20250206202109.384179-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206202109.384179-1-arighi@nvidia.com>
References: <20250206202109.384179-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: fedadfeb-07ac-48ba-79ca-08dd46ebe42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vFk7m/5l4nD7+hDcuS2V4uOLvAuopRqTyJQ1cj6y8Jhv9vut9/jmt6/LtkYO?=
 =?us-ascii?Q?hNk35YihIjBvNhjb/Dg5T/gRM7OfbtnxiYjwzBIt3lXqq6CEGYuVLmPc+nw5?=
 =?us-ascii?Q?Gf5G2QdlPHfocRH7i9mubprMWHAScaI3LLWr6KXAnooBVk6OURRvOdzRBtvy?=
 =?us-ascii?Q?9oRLyFTb7IHaw2ta6WFCwVr8v8m8IrJeIAQoD5ca+DucJxVhZyJctT+gTbdl?=
 =?us-ascii?Q?sp0l0Bht/4snLt3sPc0pE7ggKgt1AjxeB3YcOUvnhZHFVo0IGZFevCuICfGb?=
 =?us-ascii?Q?0kFCIR363Xu0oMrQiJJJGWswQwW/Ti9SzQoeUhvUccH2hz4xmhMUu7Hs4h1n?=
 =?us-ascii?Q?8MxXkoUVpTAXV9pOJKdjg43jPeTcqyEMnHdthYQ4fGkkAFpo4jHVkdCypc7x?=
 =?us-ascii?Q?XZmNH+PtgbsazoK8YZM/YzbS5Xc8iZpEYQDKX1zHUVqnB3t4BZD1fYK0kx8C?=
 =?us-ascii?Q?yaTfc5GR6DUqinPB0leYhXSjZL6gqB9hkz9poiMsZPhtgfkWZYdBw2FjMEe0?=
 =?us-ascii?Q?eGtLQCH+av6scvErQq7xG5co50ETHHHQC4iwyPSLPF9P3fCm8WB/bL1pFWMx?=
 =?us-ascii?Q?xZLIUcEzce56Q2nxkykOJ4s5HCJ1Hv/I/+YeW2RUAS3Zj30Ezk8aP4QRnFPo?=
 =?us-ascii?Q?hTM/2+/1m0nHTITOQsruNQqH8gCo+NVHYqlWHwzOoYpzLlLdH1s2xEHxSi15?=
 =?us-ascii?Q?RikiCNhY/PlfSXlirRtIJlHs7CdHk7u4ZzCqZvPKrfqvKQ8w9o/MzzXithoF?=
 =?us-ascii?Q?uRnY5WMsxne9v3DwSyfLpU628TMVLBFaCUArFp0+tRiQcIMSRd+zJgBFi7Z6?=
 =?us-ascii?Q?kOYe32VoGxZNZIaEvCBDnL2pSxbAvUBJwAfm/795AGKVtZ42O6/yfL2sLV1n?=
 =?us-ascii?Q?QLtnzH5/Dz76PS1jBgpAFR+kut68opYptspgCfkBMVY405H/zJhSg9oCZGv6?=
 =?us-ascii?Q?qZXQu2hOY+y1XFllSnNkZEkCcD341xfngFbMxAwvLcDKy+CI1v83XSiWyzB9?=
 =?us-ascii?Q?WbLtPptPYKyCgguKjG2xDX/SGm5ylB/OePTmukgXGDSgbkSK+sCqeAd58EGw?=
 =?us-ascii?Q?vu1oNwTOYVw5UHzESUlvWHJ4g2qPX7F9RLamAN4/UD1nfCLUuXM+mNdVSKXy?=
 =?us-ascii?Q?RI3LwZz7TiwO/Dd8/18VWVH7H0+/G9/RUSV79AJdrFu87ux8n/P15Oei21vX?=
 =?us-ascii?Q?/Ggh/wBGhh65nWrcjROkkmsiiCVDIdJkX695odDzyunS1/zkVyHBkM7RMtyo?=
 =?us-ascii?Q?RvwdYSWBKnOhh7fHp7qfE+cQCNewgIum9GPODkb3kKMP4ZeDr1oYiKCXlrNf?=
 =?us-ascii?Q?UhWSNUHp0KH3nD74DzXvn76V062QQPhWX0SrtBUmPuoixbfwVC0FRzizMPNO?=
 =?us-ascii?Q?dEiv6cwW/w1DOrsydK1Qe3b9Ahlp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tg/AzAvml0A64pSzTkeQ7WIVCT9ZXlRM/Zw67Qt3kffKnKfWQsSvzsfFhLKu?=
 =?us-ascii?Q?PvHhXxcUgjIDBC5+m1NGwLXN+DZ/WFc1m69+7SkS15XrFO4L7zue5jFxjd2O?=
 =?us-ascii?Q?C5z3l1PMglL4k7atzT54ITkMqRAlheyb/7egtZTSkFVl7lEzjvFY9vyrF2UF?=
 =?us-ascii?Q?ydOqNM9MbOosUeWn/3Dwm5tiMe9XRM7V1WsOR3954+9ivHw/AisO6rZf+OKb?=
 =?us-ascii?Q?ihBBmWOAmKZLynKyZDyZxrCwZ9cXABQf0BRaCKedu6EvWO7lB2L2dy1Pzkek?=
 =?us-ascii?Q?4vgLzzBR5BoXxdzXeu2NSseJGrIqJcvev+mL2/bUAIkEccJa+bbAnunBqjqZ?=
 =?us-ascii?Q?8VhbdcnFm6hNDA1ki/6yvEayc73w/JXLvLOrSZPZTaGJbsbBFkWWlVM5gLTO?=
 =?us-ascii?Q?/Yo+0Hv5PECFMNuLgd8z5cvggydxfMG8HNs9sWxCiWziZ0R38KZt5jt3/zQG?=
 =?us-ascii?Q?4jNPXNfwlcy9uHB/xYAJIl5vJ7bQ+KQIYWAzzfVROvRmc5Ufe/FpTwRAkF+6?=
 =?us-ascii?Q?Mg+hPCLGP9Sfpql0ORSoR5xYdY6CHnvz2E7rIpLNaszvim0Vf5Nv9rD3U+eh?=
 =?us-ascii?Q?v18QWeQ1wQvWL1xlYxZVpCVatsDGdHF2iJ5E1jtRVeKbgjdM2Lx6R6k72LkW?=
 =?us-ascii?Q?6hxw6zqW4MaNaGHpXAGgB6ElwdkSdcyZv348TcJslC0H7tjny9gkpbvZbY2P?=
 =?us-ascii?Q?jA3JvW5/vOJ8GaryW0AljkfY+rZUOCjvP6rxot982w6i4QcVsjvNC3tKXTNv?=
 =?us-ascii?Q?/hXpikr1JZmKzAXfjPGW3S/rgeda/hRtdq58i3UxZQ6s1Ao/aNVMtGTZ0QUM?=
 =?us-ascii?Q?N/KWDD344fJMJ6+HyHUJjq3FXdo1inRAkHwwUDLFY2/4z9kv/v2LRoO1te2t?=
 =?us-ascii?Q?2M0VikHHxi50qj+V4Rf0bS+J3QwAmiucmIikdPUrv45HR5X5P39ZNRtgMqiR?=
 =?us-ascii?Q?S9MKR9Csx2zSStM0rPBerY8XLyPiDowxhNuHTanirka/VaiSX4RuXRG4HwSi?=
 =?us-ascii?Q?0gVHcVEve2AsqPVQGqYMJ66nZAty1dRLpC7Gjrx96q/IBccxJlcd4uXt4jOW?=
 =?us-ascii?Q?aVZcLNigi3a3UuHLSPyHu5uAim40A2VLKITVYb5LGM7tPzxHy+0l/d5ZGylL?=
 =?us-ascii?Q?x5wD8t/bUrIabsL0VbGurQ2a8l/LbevDeNDCOQkBoBsfDVPzsS7JA/SvPMhW?=
 =?us-ascii?Q?B5cNljvd9lZSQZrn5K0+Kp9EUhg7M0Bu/maq+Wt8gZxhBeygkyliA7f5+ZVW?=
 =?us-ascii?Q?jcACcLvdVDGr/dwp7T9J+35XkgOtW78JQeaV2Un8Bu9icnJNrYrB4CIHW8RS?=
 =?us-ascii?Q?f74IvYPgSCG9hrZvLfv0QBOm237KEfuP1cyI4lAt70tDYlTMZBzaC4tSE6Qj?=
 =?us-ascii?Q?YpLWzh0COnJUsFRGXjoE3D+p+uJcikXj63lLWRg6hRVEE/siP4BJZjC+yZ9e?=
 =?us-ascii?Q?fh41TfVUc3GjCozoRfGAXPoCqXIBMVesHq4UqAFlF1Dmmyqbh1uo610Eynh3?=
 =?us-ascii?Q?T/MzpIPROK/jCsDvlu4mrRo1x3eVOwTg+cE6b40SG52LLrOoDrNTkwCS5e40?=
 =?us-ascii?Q?OgXZQFj9+gcZ0A3415xxifJ9J9i7nC5JNlpYc5nB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedadfeb-07ac-48ba-79ca-08dd46ebe42b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:21:51.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Slcc9pL8ZQVsJ54XZtBhd03+dJZrOG9tf6rbjDbsIOIVbVyNAc4+cCv7dozVTYak2B5XQOd4fohzBPX37lLTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

The split of multiple per-node idle cpumasks can be controlled using the
SCX_OPS_BUILTIN_IDLE_PER_NODE flag.

By default SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled and a global
host-wide idle cpumask is used, maintaining the previous behavior.

NOTE: if a scheduler explicitly enables the per-node idle cpumasks (via
SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
trigger an scx error, since there are no system-wide cpumasks.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 236 ++++++++++++++++++++++++++++++++--------
 kernel/sched/ext_idle.h |  11 +-
 2 files changed, 197 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a3f2b00903ac2..0deef6987f76e 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -18,25 +18,88 @@ DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
 /* Enable/disable LLC aware optimizations */
 DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
 /* Enable/disable NUMA aware optimizations */
 DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
-static struct {
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
+ * from is used to track all the idle CPUs in the system.
+ */
+struct idle_cpus {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
+ * is not enabled).
+ */
+static struct idle_cpus scx_idle_global_masks;
+
+/*
+ * Per-node idle cpumasks.
+ */
+static struct idle_cpus **scx_idle_node_masks;
+
+/*
+ * Initialize per-node idle cpumasks.
+ *
+ * In case of a single NUMA node or if NUMA support is disabled, only a
+ * single global host-wide cpumask will be initialized.
+ */
+void scx_idle_init_masks(void)
+{
+	int node;
+
+	/* Allocate global idle cpumasks */
+	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.smt, GFP_KERNEL));
+
+	/* Allocate per-node idle cpumasks */
+	scx_idle_node_masks = kcalloc(num_possible_nodes(),
+				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
+	BUG_ON(!scx_idle_node_masks);
+
+	for_each_node(node) {
+		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, node);
+		BUG_ON(!scx_idle_node_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
+
+/*
+ * Return the idle masks associated to a target @node.
+ */
+static struct idle_cpus *idle_cpumask(int node)
+{
+	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
+}
+
+/*
+ * Return the node id associated to a target idle CPU (used to determine
+ * the proper idle cpumask).
+ */
+static int idle_cpu_to_node(int cpu)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return NUMA_NO_NODE;
+
+	return cpu_to_node(cpu);
+}
 
 bool scx_idle_test_and_clear_cpu(int cpu)
 {
+	int node = idle_cpu_to_node(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -45,33 +108,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
 		 *
 		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
 		 * reduce memory writes, which may help alleviate cache
 		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smts))
+			cpumask_andnot(idle_smts, idle_smts, smt);
+		else if (cpumask_test_cpu(cpu, idle_smts))
+			__cpumask_clear_cpu(cpu, idle_smts);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+
+	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
 }
 
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+/*
+ * Pick an idle CPU in a specific NUMA node.
+ */
+s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(idle_cpumask(node)->smt, cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -79,7 +147,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 
@@ -90,6 +158,49 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Find the best idle CPU in the system, relative to @node.
+ */
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	nodemask_t visited = NODE_MASK_NONE;
+	s32 cpu = -EBUSY;
+	int n;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting
+	 * from @node.
+	 *
+	 * This loop is O(N^2), with N being the amount of NUMA nodes,
+	 * which might be quite expensive in large NUMA systems. However,
+	 * this complexity comes into play only when a scheduler enables
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
+	 * without specifying a target NUMA node, so it shouldn't be a
+	 * bottleneck is most cases.
+	 *
+	 * As a future optimization we may want to cache the list of hop
+	 * nodes in a per-node array, instead of actually traversing them
+	 * every time.
+	 */
+	for_each_numa_node(n, node, visited, N_POSSIBLE) {
+		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
+		if (cpu >= 0)
+			break;
+
+		/*
+		 * Check if the search is restricted to the same core or
+		 * the same node.
+		 */
+		if (flags & SCX_PICK_IDLE_IN_NODE)
+			break;
+	}
+
+	return cpu;
+}
+
 /*
  * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
  * domain is not defined).
@@ -310,6 +421,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = idle_cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -367,9 +479,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -383,7 +495,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -393,7 +505,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -402,15 +514,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_from_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
 
 		/*
 		 * Search for any full idle core usable by the task.
+		 *
+		 * If NUMA aware idle selection is enabled, the search will
+		 * begin in prev_cpu's node and proceed to other nodes in
+		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -427,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -436,7 +552,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -444,7 +560,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -460,38 +576,50 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 
 void scx_idle_reset_masks(void)
 {
+	int node;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
-}
+	for_each_node(node) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
-void scx_idle_init_masks(void)
-{
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+		cpumask_and(idle_cpus, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smts, idle_cpus);
+	}
 }
 
 static void update_builtin_idle(int cpu, bool idle)
 {
-	assign_cpu(cpu, idle_masks.cpu, idle);
+	int node = idle_cpu_to_node(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
+	assign_cpu(cpu, idle_cpus, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
-			if (!cpumask_subset(smt, idle_masks.cpu))
+			if (!cpumask_subset(smt, idle_cpus))
 				return;
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smts, idle_smts, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smts, idle_smts, smt);
 		}
 	}
 #endif
@@ -599,15 +727,21 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -618,18 +752,24 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  * per-physical-core cpumask. Can be used to determine if an entire physical
  * core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 #ifdef CONFIG_SMP
 	if (sched_smt_active())
-		return idle_masks.smt;
+		return idle_cpumask(NUMA_NO_NODE)->smt;
 	else
-		return idle_masks.cpu;
+		return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -696,7 +836,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 	if (!check_builtin_idle_enabled())
 		return -EBUSY;
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 }
 
 /**
@@ -719,7 +859,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 		if (cpu >= 0)
 			return cpu;
 	}
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index d005bd22c19a5..b00ed5ad48e89 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -13,6 +13,7 @@
 struct sched_ext_ops;
 
 extern struct static_key_false scx_builtin_idle_enabled;
+extern struct static_key_false scx_builtin_idle_per_node;
 
 #ifdef CONFIG_SMP
 extern struct static_key_false scx_selcpu_topo_llc;
@@ -22,13 +23,18 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_reset_masks(void);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
+s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags);
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_reset_masks(void) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static inline s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	return -EBUSY;
+}
+static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	return -EBUSY;
 }
@@ -36,6 +42,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flag
 
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
 
+extern void scx_idle_init_masks(void);
 extern int scx_idle_init(void);
 
 #endif /* _KERNEL_SCHED_EXT_IDLE_H */
-- 
2.48.1



Return-Path: <bpf+bounces-50801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4EA2CED6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093E716CAFD
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A819CC0C;
	Fri,  7 Feb 2025 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gbb0CQYM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7121ADC7B;
	Fri,  7 Feb 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962692; cv=fail; b=g4e/fcnv9dBdd+lQaboo4Qhs5mq9NWGNXqsXzaqYovpjtSf76fFPhNssq/iMOHYofva7P23WdLIYRJqbKHNMw1XVGBe9bo/eMJUthqnsO+IxbaGYhNEEcoCBcQWwqA05IaLIuaO1GwjmVezDtxd5K07/AHCX9Khq2BM5s+29tIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962692; c=relaxed/simple;
	bh=f1U0Vaev7Kgb3EC4ErBy/w/cG2iSMqnE7fLY1E2uFko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWbAbYvQ8v6j+he1LyZHhl3yyJNfhfqsg9AJKsiUpqed3npsnl67+rzCdZj2SE4a2aTVEHAPxG7ckqxsY8TJmihuVnbD19yt8TH7quD1HDYQS3ISdy4bvNg6gDRM3RMbTjI2mZAjH0tLFjRy8httyimZOHMFIgBpVaxgq8qePCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gbb0CQYM; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo/sY1lAEllYhRnQMQl3ZcabmGwvV+x6F1N5WLdtyyd311Om5HjThYeptWLKlQT/hyq1IvsLzAnUvX9/4Y4I+FHbjpojxBHvfaEXhPWl22/GtHpC/3yoRM8MkRrflJJFUGNeykv+BDviVB7ncjCfmQcyriD+RTZJCc8LVQFh7bVBpglhewrppTupTG137funDp82JL7uDsMLW8C3VmUbdz6vqqCMKkLGsQFWIVtAcTOFBycqzLI3DQV+3uvawrbWORCCivQDeFUwM/+pk3MHPJEE6SOwQcmGyfuZCE4fpXFpZLjcfyLFTz1WWBLymxqujxtwJ53i+OUaK2VkkuT+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRtNytf1M9PTm5NN6VFbbYEByuOaj7l/V6UFE1j+oj0=;
 b=iYSceCKqPpyHGCch94oDarVzQjsgCFvBgL0PYjNhmaCVftfq8z1fHidkvrwTc9Z4v7iPxgM9dSwRz1tGIJpkspIVLbJVqTFK/yFzfZFEMAdwZVB1yrUpXa52D2LGI4iZExWi8vFK3OZUNRbZ/pkIxOXxqp26Ha3Bv+wb9RRb0TfMRhEYHHQ+mPTnYkeLVaeDXeHC9hK3DnXw1nDZE9LfKH8ibl3f22wbIg1Y9TvZ7F3z9GgpidilhSXbwe+w+iqcqm/XdMAaBNHqBlCwNlC7gRCIwj9QAivk+ra0QG40WTFBk2YjrWa2xIE80JtWUzFqjJbKumq5WC9Hz+ZFz0QxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRtNytf1M9PTm5NN6VFbbYEByuOaj7l/V6UFE1j+oj0=;
 b=Gbb0CQYMLtxBax/WWpr6avRIoZjWuoC63mUpG8BGM9A0yLe+YWosSfrtuSm2aRiMrVG6gsGJ2njnv4jUF2bDhd+970uw7rclvJyu5rZNZDD97dgg3FQA1/0pwFdO5pUhml0RUEfSo1sdkfEPfDJ9IVH/lcRE8DOH1BPChddETuHR6wArCvsnuIJv6pWdkMTk0vqAk3/L2qq3we4bHh4lSlAFxywU1M1H5XxyJavjnkjKHUJyUeK26+f/4kqrKdDjR5vUTisItPoM9O9AhXZJncW2A4E2WgOQXLCEhFC7uAr8iWCQCeqtUqv28lVShlqtqZJty9piEEtItvU+4wmMZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:25 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:24 +0000
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
Subject: [PATCH 1/6] mm/numa: Introduce numa_nearest_nodemask()
Date: Fri,  7 Feb 2025 21:40:48 +0100
Message-ID: <20250207211104.30009-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207211104.30009-1-arighi@nvidia.com>
References: <20250207211104.30009-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d8e71c-06e3-4f31-dbe5-08dd47bbfa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvEsVVJ+fQP3jtGhWpWEgFE12Mok8SF6YohKH20L0OfrTevYh+RmQTIyQqhB?=
 =?us-ascii?Q?2XQGGagBG3BKUw3PpcFd3QgJaCANhW2rax4032fsogj7aYQ86DlUleRWea3p?=
 =?us-ascii?Q?X/uJCXFByd6Yb1SMT99VbIGVKSOrPZ48pykP53LBrDr8Y9o2hwN7b1xfuoEh?=
 =?us-ascii?Q?KYa00+EGAG46gSLge3u3gQ5/BRRu7k0jacAQR3J0Vjljbz/JZBrwkHmpcIgp?=
 =?us-ascii?Q?gjVnvVzRB6qqGeijylmhQeSKrkT9i9vdndAkVVdz6Vc2epCzF0lvLJq29Su7?=
 =?us-ascii?Q?hTjLae7KIDLWsKSqyGn9w2P7+8HHxGlGKAp9qha1b2Qg0xwJBlFlTsbdFLjL?=
 =?us-ascii?Q?8BwfW5b1IUfB9P6TK4UZuy9aafIjz8GyygGzNFmlQfREV4XQ9tqMczX3ek/W?=
 =?us-ascii?Q?4+4x99FGMS9S7/t+pQCa5seiTUj+ec6Zdfrj+UWnchF6R4hgBF9chrS0XDiz?=
 =?us-ascii?Q?AW7mKpnvLBrDg2PMmyyhDEiY4mtJfNW+gmk5aqorJtcZfLKbfFKtEnsB2BvK?=
 =?us-ascii?Q?8Sh40K6Pc9/Gm7CXpkF+qvevmKTJo6QZCNUyRHdL8cgAYHAPDJgST6Aw4VFJ?=
 =?us-ascii?Q?CsxJa8GW14dSiSvqruyyxcRrG0e9Lfd6dWuQef0XcSh3EVWn2kUxHnXDFGih?=
 =?us-ascii?Q?CjFxCaLZgzOlnGlqdMiwTKr6XZMn3Yz1wJ1Vc8fyawE1FBWyZXYTRxV4Lb3t?=
 =?us-ascii?Q?8C3c2ElqV+5NHSbUIvFMgM9ySoWrDoZWPBuSuP5PL3ufSN5xMC3kYKDyGT6g?=
 =?us-ascii?Q?zQjmj8sxhJ8t0QLPGdW6qYo14/oW1PBYRDhSVOQCttwcjfKJK6MsBd1HxiFx?=
 =?us-ascii?Q?CXLSqQoiNFGAAPenl/+ni+Wvju865MhVVnppe8YhMDcpdZb7x02zGOauYX2Q?=
 =?us-ascii?Q?F0aitCS+kJo/Uq8D3gemS5y99jCk2G+JTXf/4b4ugUzBRr6WplMAM8tL2XG8?=
 =?us-ascii?Q?GPqrx38D1m59AjtI+LOxSbOmh3x079htigpWOCJMBCr/7s77JARJwIMwas/d?=
 =?us-ascii?Q?a56zyZ62pkmrY600wgX1DcyTyp3PYYd0DR7yby6enJfNUmfr0PNbIRjSKNem?=
 =?us-ascii?Q?Ql0vau5SIsHKru+2jn++uPKx2mxppRMIRpQ3vKVTmk3fqtDfxRTvepu5mT4Z?=
 =?us-ascii?Q?mPKFJ8mfe3PkQhNhfwkKRPLRHt/mpj26WJ/F/dwY38DTO1nKZTC71oHeFShe?=
 =?us-ascii?Q?M43UTc/ENnOfMb1ybN2FFSVPP4Tnl90xCOndAQ2eEYrgDUAqUr+VGoD7q8/l?=
 =?us-ascii?Q?ZBP2OVUDvy11DESY8BW6zrE14XoNZWPNMcYSLvHgj4CmnC+/16UiBkub4EW8?=
 =?us-ascii?Q?wWWSVgoxhD9d0J2iavAu7/bzb+5PcyNeT2Tcn/XSPJ2zWdhEeK9v2/6MDe+d?=
 =?us-ascii?Q?w+P5BjEQ0wi/fD0D8I7IJWLgeOQZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDv1MNElaprqlfxseDBny46JX7fdI5jc7IntrAzqzUn8b24pJpXz5Exv+15q?=
 =?us-ascii?Q?O1lYYbCtYrAWsCcgOcc4h5G7BJzsiwpc+Z1XwYyPJdFueyxdsJyeeIb7eFl6?=
 =?us-ascii?Q?N0NoBMZq0JHBD4vMMt5QYrxnqfEFX4RLrQjnw388UqGkbdVpPo/fHa0KiaNa?=
 =?us-ascii?Q?9uRpS9N7zLcfCBF920I5BEtMT/knvEfSI14fUmUVyDhYXW9IQ3U0c+q7LOHk?=
 =?us-ascii?Q?dZcfbfb+GeA/wjKHk9mV6UeFlqBLkNVwaKAtb+S1KwWqRiTzZKKGGMQL7pYD?=
 =?us-ascii?Q?LAjQNakZM2w5x3pWPu9shmK9mPzsh97T9lHdU6HUgZYbrGUCG7jmfVC/tMnJ?=
 =?us-ascii?Q?FHJ5c6eE0R2PWtwmou3t53wpGc13zHWaeLipVCP68bvPa4g9uOxyOyXqqfim?=
 =?us-ascii?Q?PhV/RleL8HoOimySo4rLTeUIwUfboMlQT1KVxBt5SKxhH3yAVJh9czNp0rhQ?=
 =?us-ascii?Q?mykC0pXeUGptwVGb2A4GNOxFkBZHUJbN9qfveI0kPuuUT0T3EyCuI47y8AwW?=
 =?us-ascii?Q?tgjidoZBS9gHcU+w9nzXk0TJzgesi371/K84W53tyX0eKlnxwDcP7mcwiehH?=
 =?us-ascii?Q?6FxHEwg626m3s8Vowj9CTzGfRQyM90QJglI/vVsTByClCLcaIg9xIRPLuoTb?=
 =?us-ascii?Q?+q26oHrx07wwONVsYHgTrofd7iuElCCF92uzxuhfSftTU7pE5l+1DSHUDKY5?=
 =?us-ascii?Q?7RXlxOJ+qbBxTqB8z6iphjUbxzqyt5ld1I04sVOQnCpxiyN6I9ljsGWXLseB?=
 =?us-ascii?Q?s2YrDLp80SA2WSHS9sp8KPzAHsL0z0M97lEsP5h5azKkHh1gdV3SrVCfboSI?=
 =?us-ascii?Q?9UQexQ5IemLCpAorqBf+ZeculHluRm0vhH1Osz+TJ6yiaIg4n1D19+78NQN1?=
 =?us-ascii?Q?A76L3NXtoWHBxA2IbVlSVmL8H4Xxy2knZnMGTCenwhY/cVJ01+ADoOHI+vhW?=
 =?us-ascii?Q?WP0oU4WgtQdBmhgjPuTtgAMG9bvHcFqilNpByET4AP0HwmXyRYpyVcVd+PPF?=
 =?us-ascii?Q?1g81/UYvd8kGTgNZ2D1j3In8DttPYaeOHGoMdewsUyyoPkMOLqOtnG5bl2z1?=
 =?us-ascii?Q?fc18I0rFVkctAV3aVBYbYou619bUX4bTX1oqSnpUrvaI2Yn3cBy8k9nSeexv?=
 =?us-ascii?Q?JkSjsW/Gdn7T9BOw6uSnnyXFr3Ui32oIgrQclvKyWlEg92YaCYySr2zIWqOb?=
 =?us-ascii?Q?dRhA1FDYBjk51sh1npHt98pQHFIHACLDrF58a2nCFz+NyKUkeqNPucZkyi3X?=
 =?us-ascii?Q?Kd1lyXxmNBuKAAwMlBxY1dd+d9sIaZYCnyPBvOf3uBNkXwToAOUmSTs8Euia?=
 =?us-ascii?Q?A7LKlrcg1lwlqyEnB8P1NoVfjFiFHWLuzh8o+S+sfeFLimaGyvF/Mz4pxCog?=
 =?us-ascii?Q?S3AtHH4pGlXclu0q4WtNhBhmIKImM28TDg8Bm7abJB9iI5t0PTgQI6RAZ7IR?=
 =?us-ascii?Q?wPfG+Z2AA+DZSkntqMse+Nr9p63+9m4FlAW+xc3Pp6lGcncMl9bb0oR3NfgP?=
 =?us-ascii?Q?9arQP0zeWd+cR1qxWUVtVLL3EtyeUwZjrOgC+QGN7ed0+wLZjTlY5OgMton5?=
 =?us-ascii?Q?5kZnOANLzdAonn4F0wtl9T6eT4vWdAFKO1bhbzn9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d8e71c-06e3-4f31-dbe5-08dd47bbfa4e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:24.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhu5GOO3+byh2IROErjYphS2MS+VJax6hZRNKT9SpY4oignBszYhkRP8D6zx3io5hYNQHFmbUAb8cyT7oRZLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Introduce the new helper numa_nearest_nodemask() to find the closest
node, in a specified nodemask and state, from a given starting node.

Returns MAX_NUMNODES if no node is found.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/nodemask_types.h |  6 +++++-
 include/linux/numa.h           |  8 +++++++
 mm/mempolicy.c                 | 38 ++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
index 6b28d97ea6ed0..8d0b7a66c3a49 100644
--- a/include/linux/nodemask_types.h
+++ b/include/linux/nodemask_types.h
@@ -5,6 +5,10 @@
 #include <linux/bitops.h>
 #include <linux/numa.h>
 
-typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
+struct nodemask {
+	DECLARE_BITMAP(bits, MAX_NUMNODES);
+};
+
+typedef struct nodemask nodemask_t;
 
 #endif /* __LINUX_NODEMASK_TYPES_H */
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 3567e40329ebc..a549b87d1fca5 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -27,6 +27,8 @@ static inline bool numa_valid_node(int nid)
 #define __initdata_or_meminfo __initdata
 #endif
 
+struct nodemask;
+
 #ifdef CONFIG_NUMA
 #include <asm/sparsemem.h>
 
@@ -38,6 +40,7 @@ void __init alloc_offline_node_data(int nid);
 
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
+int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask);
 
 #ifndef memory_add_physaddr_to_nid
 int memory_add_physaddr_to_nid(u64 start);
@@ -55,6 +58,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
 	return NUMA_NO_NODE;
 }
 
+static inline int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 162407fbf2bc7..1cfee509c7229 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -196,6 +196,44 @@ int numa_nearest_node(int node, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(numa_nearest_node);
 
+/**
+ * numa_nearest_nodemask - Find the node in @mask at the nearest distance
+ *			   from @node.
+ *
+ * @node: the node to start the search from.
+ * @state: the node state to filter nodes by.
+ * @mask: a pointer to a nodemask representing the allowed nodes.
+ *
+ * This function iterates over all nodes in the given state and calculates
+ * the distance to the starting node.
+ *
+ * Returns the node ID in @mask that is the closest in terms of distance
+ * from @node, or MAX_NUMNODES if no node is found.
+ */
+int numa_nearest_nodemask(int node, unsigned int state, nodemask_t *mask)
+{
+	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
+
+	if (node == NUMA_NO_NODE)
+		return MAX_NUMNODES;
+
+	if (node_state(node, state) && node_isset(node, *mask))
+		return node;
+
+	for_each_node_state(n, state) {
+		if (!node_isset(n, *mask))
+			continue;
+		dist = node_distance(node, n);
+		if (dist < min_dist) {
+			min_dist = dist;
+			min_node = n;
+		}
+	}
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(numa_nearest_nodemask);
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
 	struct mempolicy *pol = p->mempolicy;
-- 
2.48.1



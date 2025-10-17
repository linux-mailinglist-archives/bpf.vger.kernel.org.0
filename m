Return-Path: <bpf+bounces-71191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F352BE7D54
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4E56E31C6
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049331196C;
	Fri, 17 Oct 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yv9sqEh1"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15621311951;
	Fri, 17 Oct 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693640; cv=fail; b=FSI0ywnQUOuX5Cb1PhnxLA3LD78ENUp06f6w/P/wATpp0/qzMdTTHmyjjJyjY7pRsaBj0wWAmCH+uEu75qFhYlqbzulaToxqxu7rDw9zngt3ynWi/Hz0UhJUVQ/OB4vN8Y0ELho/vbBqKgFhBbrZ9CYx4zBD9Dl34Zp5LPLx16w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693640; c=relaxed/simple;
	bh=enC9Emx/3ZrfVCyunLK5KOjXK4WJM7M2rO3wiVQg4BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7g6C+rfKxjGxUGE3GszowGjBjiehUzW6/Z3PWZ7T+gXZ5kXuduVdGMU/Jvn/hLlrb4Ymo/r/MdlMgChkt7X7mlzRd/nuQjNVQW8LJ80PhiHaUU1SdY0/1kCX2qpINEULkc7U21zzN6fxFSRLFU4aVRpYEcLSidmJz4ZCW1Z5Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yv9sqEh1; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux9Pi4h62ea8LuYzspr+oqM2QUDlTQQv/96IP1RpgEfRrbmpIFA92YWr3CZGOKTBuELJm2dalOXyO3gHvBhPBlpfnli2E1wsJ8sLTLje8tQCbxdhugwzMuMbpobnI8f5jUbTcqUJPSEpdrtFqEBax1ABRbf6l+RiKazuOxB3uMQv/RvuNLtu9ahZIFIPqEdue4xKfPMxZpTcD2ClCvRWaiCFBRJhWTJdo1jOKJ10GzlsoAmPFyM4FsrkMe0WknZZT0LKsGA02CAbvewSIqwQPGvtcXU0ZQX6+Le6s5g/X6jsF/qu8mLMOyQwG3veNSV82WCmPIazoqi/TtSQlzwJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOSlgjhXZ/uyjW27pcJs2NgEsZbj/GKkffX7hnlz3Hs=;
 b=qK2zAb4HWkqY3t21syxha2V7JgEU5npUlpLYfAKy4C+l+nrcBAj2AwP+wh00Wt41CETbMsHlAW0R8+DhW4pnZZDrrWNAWCMyTFNEMHCLIvfoasRtn+S1cys/LBXzGr3RpVZEOKar3wngTTetb+pRIDeCZFzvnSV/OCl1hglv7Ak/PGv3xDIcYmgBheKQue7O9IUqcd4bV9MLc0+8x2oqPAvYNGSTWODlGv57oWj2bonlXwrbAlax3Aknxx8CE+7vdBuCUYw2lOTsDfH6kF6xjBniMJKU14A2VsjYv1pUqaY45VnQGlGktXqKf+RODukYEiHUIZoYLrHAuAfpp6GbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOSlgjhXZ/uyjW27pcJs2NgEsZbj/GKkffX7hnlz3Hs=;
 b=Yv9sqEh1erppoLvhA2TE1MVFjF2HT8sLeILOr5zYAqkYvLDoUPmx9ALKjTEBgaGB00ZlHN2R7cIclbW/lmJF5Y8fXBHU4O67JbQkyGEgT5oXgPiUuslkbyLq2D86aM/BlkJKiMIXsGlgWrTkVmmN+LF26ffNQ2kqIdad09tNqMUCp0u3aapoqEnkYG29WPFC6QpLOjaTNN8Cwf5WbTl6T4mogP2BJek6c5eXN74p9rou0Gt8FNSvTVsTQpYWm8n5vqIQW5FOAzMB7pBZxb4bg5lF/We6UsCAUTKf3NED1zWKSGpkhhLVZAA5fCWaqRrZBCP1TyoNSdWtFbj045jpJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:33:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:55 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] sched/deadline: Account ext server bandwidth
Date: Fri, 17 Oct 2025 11:25:56 +0200
Message-ID: <20251017093214.70029-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: c10882e3-a372-4710-ff14-08de0d604abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HIaCDwTbYF1zfQlvslhyXo/gCxq0Q3nqnnlxag3fwjAO410hvF0pYdV4/5pZ?=
 =?us-ascii?Q?YsCUjur9r2LbXZyeoXQ+8j6I0HMHw0VW28I/aTplkhakYzyM4jjrMLerjkxd?=
 =?us-ascii?Q?LvLC+DYCXAEU95aFcicrmDZWbjoq0bAzue/7oZ+7QyWWQ828gieFWSJ+1dni?=
 =?us-ascii?Q?FNxG5avekNUdsPGa/68TXJeG7kMslmDqKdRD8wNSeQjrrjabCfFq8WYgKS7v?=
 =?us-ascii?Q?eNFp7ZOfqs0e9oAnhHZziho3QeUiTV6AWM3cHcvgea6Qw2uEeC+J3C7Ugouq?=
 =?us-ascii?Q?8q38n4sUBCvW6tlVGJiaxSod9wWVPbBHvBEXLyq0BedZ5bh2OWI1ZY8Mbij7?=
 =?us-ascii?Q?Y+6AoDI6Co0S0ek/DQbgcA4XFeHwGKijnG920y8H0IUcuT6E/DM5P5Nap+2F?=
 =?us-ascii?Q?4IbYb7kg5p7BktJPGLEROCdYReXlXdO7Zk6E2Ov7PwaaVAMrb/m6HljLp+Tr?=
 =?us-ascii?Q?z0anB3U6IBLN7w0Axbew8tewuAtxnBoC1BYZjSngUS0Hm9HU12k7a6YSeECY?=
 =?us-ascii?Q?/3uDrCC2TKcwfeOI3Za3hWFdiff1pgIzdZxmyW3caDr33tN0r815Vz5lqkbA?=
 =?us-ascii?Q?fVnIEp1v7MmUDaIn59Yo7FPK2Hyy5YFms8noDNEYZjx+cKuBaly2z+XSUFlw?=
 =?us-ascii?Q?obldekY8FB97PU7lca5TUwS3j6KfwoL5P0LwYg6A3gJ/viCWccJFUqjRW0hu?=
 =?us-ascii?Q?Rk4fPxotRxAMKkQ/RyNLoQJDH5WH3pUyqBeaWJABWZSMTj5mUljHTbuNaEdq?=
 =?us-ascii?Q?aHFbfRattg5/8QYZ6Ks7K1I+qc48iUjwgsAbsLJODMnuTbYT5VCh3OAjJxFy?=
 =?us-ascii?Q?sktPwpSTMKu7H4XTg4D52oGQJZL4bZfJYOmWelp0skhy1Cv+DUprCDd0w2fR?=
 =?us-ascii?Q?2O5GuDarTWINAUZZGYL6Fxf4vspkUCe80+z4a9im8Bsy7Tf5K31Jd1mIuz9A?=
 =?us-ascii?Q?+qJf2gaGR5ntpbRKx1MjRSbQ4Lm3gCqRYAOl/Vzx6VunYrE2+9KH7TItfLSW?=
 =?us-ascii?Q?59IQTkaiSl9Ynl+BCdgRRrkHez6UPzf6k6WLqJNCEj7nAIOVlZKosJ12Jesu?=
 =?us-ascii?Q?hkhiuTcHaQ0g1STnApBH57nUbbcLi/gcy4ic1lnl7u1jDQlN/Kmst9xvFOpt?=
 =?us-ascii?Q?+VM3QhRABW3jzLVhigyAeVZkT/dRbWQRyzyMhoKX0XMbIU3jIdWqaI/5A0yr?=
 =?us-ascii?Q?iWaFnYvEdwGg8hF9Qa+/T/KsPIfe8/1sE9C3YHlK0B7Ynp6gKs7ee4tQSSK4?=
 =?us-ascii?Q?ZSbchNFoZwiWob1qCx5BWG0CF9Lmw3EkMr8RBro1XnAR8bFfXSI4m7T8loyE?=
 =?us-ascii?Q?Zahnqu1piv+tIxAOsppgED7YHQG6sNPXoOHz3UUUrNzcLDdtA4rNo4I/b/s6?=
 =?us-ascii?Q?d1OiAfJBRlUg2dGLAMcCNabAfenqqiZeq1b5PNcRZrMnW6iVifjKaJXJPBg1?=
 =?us-ascii?Q?08IKRc0GNmhmCRKPmtXLzQ6m59CoY/lyvukuSfqC1/+vTrz1IyRGASPsWdXW?=
 =?us-ascii?Q?q8TiYxcm2Ydldfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9TBOjPS/cjlpJK/28Mvdb9oirf7NvVE7jbWh5c2lL2NOXJR1N6mLuZYJrpd?=
 =?us-ascii?Q?JX97zT5f763I0gjPA2XbZJjxkjTHgtsD9peH6XhHlTMB0gO7oDWV4Cvq1EEB?=
 =?us-ascii?Q?43r7atCDmB215NvrarZ0qtOe4eTLFItxO6nU0ff5dFXZaSOz8OXy7C14RWK1?=
 =?us-ascii?Q?dHg5aFlPPK+Wng7hubVNugVKxqnQGBjkm9g9mn5ailg8e6EAoalwLU8XrBq7?=
 =?us-ascii?Q?SEn2GySVOewRrq6tqFYqGa8DjtgWKkFtW3dpRA2XNwlEeZZUc5S5TPe4+n/P?=
 =?us-ascii?Q?8q5mRnXtbZgq1AegDPTgBtfeolNhljm+HR/S/+RI7+KhVfFHgThGpiD+/JNl?=
 =?us-ascii?Q?MhBQ+41lPybpwNWdHnbxquuOAwfAvhrktuPSgDgD7s6mr39oW4Evt7TzlFLg?=
 =?us-ascii?Q?enUc9gcdCB2TuyPTeQv5yvEgHuDKzBPdibtG+UUL6BlI7mgt3+jOz6JgvcZT?=
 =?us-ascii?Q?QTpozUWq42l6lnd7+JPBVjPu2Q6BpeqAu82Pozb2jJRw+zI2RYQX5Bf96eE+?=
 =?us-ascii?Q?v+T2wFZdTeLV8S1uC3Novtypg6p3jZqsMSFl7bjwQ/VK3RxmHKtcNtBWfNuA?=
 =?us-ascii?Q?vMKGIZZMx6skzF12W96HfAXt23KYfZdeDCOLJiFuLhVMJ9djDTfWPsZH5t8r?=
 =?us-ascii?Q?62aRLYXeOgMnfukPvtExVmby1gK5jXlT6IFwVEdwkCv2FfCFAv2Y2tKKOW0R?=
 =?us-ascii?Q?FUqkSaMocswaVAH32PMhfE5vYkXqAaOofyVj2JjSk+5sstpqwB2rwXQ73jxH?=
 =?us-ascii?Q?WKn0mUv+4FUdmIDa1rrKV/WO4soGoIlkuJwGv8rtQ2ytBS5f7IMoF/GTZnns?=
 =?us-ascii?Q?WLX+rnUhpfnPMxPB9BHp+5jRbbWWE2BuHkGTd+fxYLS7GSbO42dAeN81z24G?=
 =?us-ascii?Q?Me0rDSYNEM7ATRbPgyOhUZrcylkP8xkf9/vcfOcF/dc882CCm56L7Ez9OhPm?=
 =?us-ascii?Q?JhDEAyXVUppYOFK2A7ttwH5vBuMcDOSxsgfzBbc59K6P0N6AYP6l9+008dNy?=
 =?us-ascii?Q?MY3lcpmuW1B0ICR33KzZquAjp39MWj3TAL3LRhOcfzgvGlRRUOPvUdWTfqTm?=
 =?us-ascii?Q?erVUljnRPCxT27HCrLpivJ+nsSB1RDdSbpybjm9rIMzGESgSHw0SR8QajkVY?=
 =?us-ascii?Q?Uu4P8ebNyJezp/Gm2DZ5cvFw+hih1WiRjkUxYnalCCjxpMZgyqRmAaPa/kct?=
 =?us-ascii?Q?tXLErQ/zD3L5fEOQ+ZOfN8nB3ClMD7qDY0EqJ4aK1fJaZ2F/FrvLJjuxXbz1?=
 =?us-ascii?Q?sX3HmfJ+KFNdcrnTc8fDhnOLI8wSL/wnJCKxAY+Ws4ZYjL/rpwjduazmZJHj?=
 =?us-ascii?Q?l4VljfgB2epCqKsFfhnaTDRklPI8hLQDEa9nPHZOkW42kRqtuUVUyt5rb0YE?=
 =?us-ascii?Q?Gd3lRNfGz3Pnc/Nhn02/JmRsKaGW2NOO5FHK1UMr6EuAO5BOQvJjciHl5JPv?=
 =?us-ascii?Q?zGF8lcwn9YQO+mj6gODS7l+7JYLGxcjPLXu/gZsYeUJ0jc6qmMNWb71+5jI5?=
 =?us-ascii?Q?N9+Bhg6Cex384aPvglANWjFEtsN6F4rUL6Ri1kJnrBqJcIOwfptjHQCi4bvc?=
 =?us-ascii?Q?NBof0MF/IV1ukBZF1sAKcSg3s0NQVR4rZrbG77GY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10882e3-a372-4710-ff14-08de0d604abf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:55.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3F1HKounbqTzMdAUjfkYT80+WX9A7qaw50pO8dcbxp/P49C1fTN180tKxwftIoMMwSttP398erQPMfZYgr2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

Always account for both the ext_server and fair_server bandwidths,
especially during CPU hotplug operations. Ignoring either can lead to
imbalances in total_bw when sched_ext schedulers are active and CPUs are
brought online / offline.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 29 +++++++++++++++++++++--------
 kernel/sched/topology.c |  5 +++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d585be4014427..ba2d58bfc82c8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2984,9 +2984,17 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * them, we need to account for them here explicitly.
 	 */
 	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
+		struct sched_dl_entity *dl_se;
 
-		if (dl_server(dl_se) && cpu_active(i))
+		if (!cpu_active(i))
+			continue;
+
+		dl_se = &cpu_rq(i)->fair_server;
+		if (dl_server(dl_se))
+			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
+
+		dl_se = &cpu_rq(i)->ext_server;
+		if (dl_server(dl_se))
 			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
 	}
 }
@@ -3485,6 +3493,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	struct dl_bw *dl_b;
 	bool overflow = 0;
 	u64 fair_server_bw = 0;
+	u64 ext_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3517,27 +3526,31 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
 		if (cpu_rq(cpu)->fair_server.dl_server)
 			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
 
+		if (cpu_rq(cpu)->ext_server.dl_server)
+			ext_server_bw = cpu_rq(cpu)->ext_server.dl_bw;
+
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - fair_server_bw - ext_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap,
+							 fair_server_bw + ext_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 711076aa49801..1ec8e74b80219 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.51.0



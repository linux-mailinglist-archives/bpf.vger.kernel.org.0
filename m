Return-Path: <bpf+bounces-67263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81347B41A94
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91CB5651A3
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1852F28E2;
	Wed,  3 Sep 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZhKzcs3"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C02F1FE1;
	Wed,  3 Sep 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893046; cv=fail; b=BOKU8GdKwS7cGQp6iRs5C/2p0gdve80dLQDPR6VNu56YkO/Y4VGCwOTxJRaoGWS7hnUjSwDoHUQ+MEVP9J4pUBH3mEqnANorEuUBeKXZutRGSZx/K6BOb8nq0E48GnyYgXKPBm0FT3D0XG9/4bElMdIXTKj+7W2z2RGHfC1vtrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893046; c=relaxed/simple;
	bh=iRzmKgFXw7ZOy5+oewENhaQpc9hGCSsY5/mMGiGGE8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJe546i1/oLC9q5wNeEzQ/CKYEtpujCh9DfRO5gMJ70f51bv9PPk4oyBU7VWKE7a2jAfEWDBoaNBmFxxY6QAoer2QjszLk7Kne6M4mYzsSRMaCFnnqq/N9OdV6hDigtZ2Py5K87SEGeUFapofVqkttB2lwvnMyPwTSOm3DxC2LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZhKzcs3; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAX5knvnsETii20GNjYFKx9OWzBhN92+Qug0q2MmoZZ3Gooon9agTveQ4BlWWPYZZj09W9aM6wTlkKLiC6oomLXqMzO3ec/pU9jgE4brDi34BJFFK+lckMWXYWhL7R/d3QPHBWXJ7I8qgCaQIsXRw2w0sQjbKwzLDIFnBdItv79B1bMrUa4CSYzQQ4u5CJcTfzUbRlG8bbbXNdu0kJvD9iQbus8xceMwQz0KuHDGlm2f5UbegUaOddJxSQmefRRmJiaU3LD3uPZr3sNYzwXPnuhHlGgvaKAl6ommipYMlTyCPyJ5WUGscNkKLg/fYudDoFYNdM3ZfsdCO++b2HKlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLEZBCuyNNai4ZfK6/y2yC13lBsJG34+KpGQNpaO/do=;
 b=JWiLbrEHMhgmjZDtP7hbuPuntsI4WpcKsABr2v7s01DIFRPlPvM7rjYWvk3cnmMFasbSZ11/Nrcr3Lb9+IQ1InwXKoPkysnMWwsPaxRc4lPmH1dwqWvi1m5EoWdPu1DQN1cuN76hdYJg1Zkju7oSxkCOgPrG+or+yYkMwe0BbbQpgBxYO+UrEckRqGdf5AzabIQA0PfU5AMgMjuGayHTY2996gVTgGNB+gYgjKO9v4N4AESVcmRIcfXyqfkeASJZiEOFLWG7XgSqe7Brry7QjDQWqO92nRAGen9f5BHegIjdiyZB8QddNXbOOn8XbitYkK0gNKHP7DyZkitMwGCnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLEZBCuyNNai4ZfK6/y2yC13lBsJG34+KpGQNpaO/do=;
 b=rZhKzcs3OyH/0KDKuuATzvq+S9ixelIdZ4XT+MizBlL1hdkvOYpG8ofvqWh/kSvu+dz6P3IzVaXVEVnaojrxUflvzpnE9T+dKEHF9pcAnVjcTS3HoHTgm5J0cTBL2PIxi3zb+dtD314jftDrI2+mvog1gb7rHObxdQwV4IrYoUYAZGAu+Bf9893oA61PNSoVGa0U6gDI/a+2Y/tR24XjNk8NjTk7QMF5KujiJZUQqeVXJU+EQECe/kdDZMss49PPtYnnZAvIO/zC4Y8ZvO+G65Z/h54mtNO/A5tJ5f9sWxQoGGj+eiMxNI/GeHdoJlVapLoKv49sovP2KlTP21/vxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:42 +0000
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
Subject: [PATCH 06/16] sched: Add a server arg to dl_server_update_idle_time()
Date: Wed,  3 Sep 2025 11:33:32 +0200
Message-ID: <20250903095008.162049-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5a8438-238b-4063-6f88-08ddeacf586c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BoPf70pGbmZRO+X+clBb71VpO4/xs+3c+LG9xa1OAuUx2N0AH3GKty48ULCk?=
 =?us-ascii?Q?b4i1OXEjLiSecnAt0+1YnpqaStCXRqEkPgkL3io6FltCzCnZR0pPWp7TTZzf?=
 =?us-ascii?Q?6wheIkxePBA76VDkNyuoEKQlhT+mTeZCw69Lot91JyiDG4Ssn6/tFwePG3Yi?=
 =?us-ascii?Q?hOPqQgTOtBTwDVvyNQC8S79SXFGc5BDENT7WL9Ima1k2IcBVJawE15tQf0PS?=
 =?us-ascii?Q?V82QaKfpNCZtS05OTsdE5hPBVnVLOkctWjvQJaQQzoyZSXhSQ9EW6V4LYO9Y?=
 =?us-ascii?Q?UbA8RrEepSiCJ6tfO3dI2XyOXm4toJsIfHbU8m3K8GkTNUYI6Rcl98kKNfqe?=
 =?us-ascii?Q?rAa3WjRdG/VeLAl51lCrg+cg8IPCKQ6JyBgVvnW5t8ebsEjzPe5wrrbPEEGo?=
 =?us-ascii?Q?/5KnNh3IzvdOZQ2tHxR/mjj2GdRZckOvpvMnYvuQYWPuWastScgsn1oaqcJD?=
 =?us-ascii?Q?p87OtfT3dmmrzTJvgh7YTU7bDuYREN/AL6XUi661D8KRlFpMbZkzkX1yxT7J?=
 =?us-ascii?Q?yvh1LrodQWyS17oi83VvCouN6Q3GGa6nEyVnRm67FImAnUPa0XbIuHOm1mfk?=
 =?us-ascii?Q?Z/n+YuSujAOIGwVdZywk2OMZ2A3YrlPhHcmUJbUIvKI9Qj3w266NlQUFzgnX?=
 =?us-ascii?Q?Haw599yolULgwbkCoxrd/4OoX3olBAtC47XY8FvvLWgoGr61mnVPW8ct5wb1?=
 =?us-ascii?Q?aZNLmw9xZabh9QpvoPH5+J0xPXIK2+l6Wk6ZCMppg3NH0I/Y0wBFmRodvgDr?=
 =?us-ascii?Q?8RK9VVZ6S+HG1e5nUZt9ZaZUSXXuFyuy1aiay/aRrGHSofI35S7agk3aBBoV?=
 =?us-ascii?Q?0/iNMpwvxvfyoeqSvjT9ViwBwoKX5Tr56/KlSOnMejQNRKbHlNcaNtAEu+ry?=
 =?us-ascii?Q?95LIvTJ/Y+/+YhZIwayAkkZ0guDk7fozQijuAgKuDURdSrx/QH43pfxjDXxt?=
 =?us-ascii?Q?nKow2rhHZR4nxGzyG0wwYnroUmlb0xLhG53+9fcBymwfdP/EuWKUTNkCYW3Q?=
 =?us-ascii?Q?cqHPIk0oQM9Qpxm+6YSVLmhjfRDgYlGdgWrFbdBDCpNRQzH0k5DDE336ROQG?=
 =?us-ascii?Q?jJzmLgGKsVHribuR5OFJKhupqC+uRp8x87W/VCtarFMvKp6gADTXFmAct2Pk?=
 =?us-ascii?Q?GK5tJ9F14F5ytrUv1+T2i+qB1D94vsR7iyVKExrUvl6veTvm6pPSHAgz6xBp?=
 =?us-ascii?Q?w6QO2HgA6CE3kW7Kb0Lm8iet3Q7enXL7/PES+WVsdeg9HmlXZDKIJulkj8pK?=
 =?us-ascii?Q?z4wTxbAAjlg//y2f25EWEc+GtPYTMNtV8399c/ZZAF/02IJHq4CR1Jlzc8eC?=
 =?us-ascii?Q?Igat6PO0OkPWh4RC1tNV1QsEgG3YbpJa6p4/oylCUDG6GH8WSFcjmstM67eC?=
 =?us-ascii?Q?cdU4kYsPk6HnHKuz878op8kdB+kSnwOTqdDS9b4Eqse39Yeur2UA0mvxugiR?=
 =?us-ascii?Q?dKSL8IYuQj2weiTX8R6CYdW2WKX59QsN1NHbVn82DmwLrTNLh+7PRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amc46c+tuPEXAe0aVUDUsTADwlqAS7ALlfGpH7XJLXXs/hbLdeQE0aRulON1?=
 =?us-ascii?Q?2wH7nkX0FE8IG6uW+llN4LO6kenfIHeVTWyINyF1O9khKo0wkcZ3hANYTlDR?=
 =?us-ascii?Q?rCO+5w/6bW7wwlkt7iUbexqFBcUAbUNO3gVeSSMsQZNdYE0E/0WVvxBynQ5a?=
 =?us-ascii?Q?aBnsoolXqlqjXQIfdnfaLzj3OB5PwvTYrWgTH+EiJlCPM3QvUr8sqdKhaSgX?=
 =?us-ascii?Q?4iT2zpYK0ezekBlM30epKJj8NERugz6sGIHfYtJxCLCPXXky1wft+4EL6LoO?=
 =?us-ascii?Q?zL1aoRM9D9MGgkpEkGNUaGaZXbXt27s4087SQxAGJ5/CV7zHflf//yC/kKAm?=
 =?us-ascii?Q?KpTJTUo6zqoFPrUhTTAzwPiYZxwsWtuAHB/wcbRplLCwIFHpVF2wXNV54hNh?=
 =?us-ascii?Q?zGjFkmkQyYsV2hgtMU30Md/Belpns96IaZqsvhmrbYbDhbKx76TQSixdsI0t?=
 =?us-ascii?Q?mhmAamyvTHROp75F7xRYLADoPT9Ko4XkeRs/HGGZcWJiI803/SpIC79LVPkF?=
 =?us-ascii?Q?vl6yfPTggPvOEM0kbriHvZLMAdWG/uaCcL3V4W9vCwetxCRqdBzyevgL+4wv?=
 =?us-ascii?Q?O85sjMQAXyZ34ZfZFRBSyWx0PqtqhHXCyJJYGnj77mmiui0ZUBEtHPHTxLVp?=
 =?us-ascii?Q?hCOry8f8VS+TjtMxq0NVR0YT/H0H38PHCSs50mP7zF7nCZRingUS4DsJc8aN?=
 =?us-ascii?Q?SQMSBv+vUYSuzQKXn4fV6758RdFqO3nK6/KMUSYhZKMKmjvkmI+8E1H2/n3G?=
 =?us-ascii?Q?Jq3hcwVxKgrk8Dk26b+AFlAPCTZu5xDGIk4nP5hGaMEV5NtTMpVQssR1f54W?=
 =?us-ascii?Q?PBELlx/HUxTLokRj1pan+LTyoRKp7uvTcNi1sRdskPE4vUpdgaov5FTRunTY?=
 =?us-ascii?Q?g4P2zZ6aIrlykUISlPevtAe+euG0N+7LT01ba5GJMab6rYlVC1S7pWyrqk5e?=
 =?us-ascii?Q?1QUmiPkmVt+c8QgVBmzLvQs94/5RLnDoWJZxMxFPpShw1EBm7rPU2YpB7OV8?=
 =?us-ascii?Q?QoYahqmtSA6r5jOH5D+Iq80mKkuWZImGzh18miRgcf40PMckbZg2McO3nvds?=
 =?us-ascii?Q?atza1aO1B8QJlKnwfFkE0wYrAZOBf4HwyCzqwB5P2xwjru5c/klOWV4be1EN?=
 =?us-ascii?Q?dGbBvkXbPjisSjyrOPmVp+Zx+kRqdJlX7o5EOLs/6HVmqQdtFqOpo1gxmR+Y?=
 =?us-ascii?Q?xD94kPEfXROJtdSpIpbNdKkGEtxG/QzkddKEPNqEb74nSAHnNvSIds9UJe7g?=
 =?us-ascii?Q?2pwW2ZUyo3Af79jwXYSEMIzD8ZHMagxpVTJxqnB2U24higIqPK3SCcwvBfhx?=
 =?us-ascii?Q?sBqJD7zhhFzJx/sHu8TxnkzAJ2n09cPo++IVZflcO0UM3g+OL8UGVE2ZvmRG?=
 =?us-ascii?Q?CX/iUu2Jxe597yn5UG4TVDguecNR21F+s9dfYi+hLbLAqUHHGryTXj08kp9f?=
 =?us-ascii?Q?dUQS/6nnqye6KG/msu9CsdENB6gIfT18LM+HvihDeGTBQsv4aEqtvyM6sFZm?=
 =?us-ascii?Q?pFUXqkT/TvTHkSZvLXnVdDeSXnrcN5g3BqKALA7WH9E5hNVH4F6tW01izjOO?=
 =?us-ascii?Q?yiMaT6itsEptBxi6hCqUiYOvJmXellWexwuC/+Kn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5a8438-238b-4063-6f88-08ddeacf586c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:42.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr8jSatKwPZctlwkaF+iGmhNVnS1XCJfZZBTfDD+l3NrYD+dV7LqErZGaXblh2VLLvrrx8GQPyHIAWm/dfJRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

Since we are adding more servers, make dl_server_update_idle_time()
accept a server argument than a specific server.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 16 ++++++++--------
 kernel/sched/fair.c     |  2 +-
 kernel/sched/idle.c     |  2 +-
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 753e50b1e86fc..75289385f310a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1549,26 +1549,26 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p,
+			       struct sched_dl_entity *rq_dl_server)
 {
 	s64 delta_exec;
 
-	if (!rq->fair_server.dl_defer)
+	if (!rq_dl_server->dl_defer)
 		return;
 
 	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
+	if (rq_dl_server->runtime < 0)
 		return;
 
 	delta_exec = rq_clock_task(rq) - p->se.exec_start;
 	if (delta_exec < 0)
 		return;
 
-	rq->fair_server.runtime -= delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
+	rq_dl_server->runtime -= delta_exec;
+	if (rq_dl_server->runtime < 0) {
+		rq_dl_server->dl_defer_running = 0;
+		rq_dl_server->runtime = 0;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c2..7573baca9a85a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6917,7 +6917,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+			dl_server_update_idle_time(rq, rq->curr, &rq->fair_server);
 		dl_server_start(&rq->fair_server);
 	}
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09b..63c8b17d8e7cf 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -454,7 +454,7 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	dl_server_update_idle_time(rq, prev, &rq->fair_server);
 	scx_update_idle(rq, false, true);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f75..f3089d0b76493 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -388,7 +388,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
+		    struct task_struct *p,
+		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.51.0



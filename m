Return-Path: <bpf+bounces-67267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF60B41A9D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C1768197C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5FA2F39C1;
	Wed,  3 Sep 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnFsY8am"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AC2F39A3;
	Wed,  3 Sep 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893060; cv=fail; b=BHJ9NTqgxVqKWLkkj4QSRVOT8Wdu2BHpHiS7ecEJRaE/NeO15blbwrV+LhSQCkIlNFGc1ere1d+NqNcIzT/+2EULfBAkxMqNj9AW9G9j7Q8pbeOD4MwsY+ZbhUASTdXdOUUpZpZ506eATuwVFTukLifk8N1DS4GPBmHZeZJtRWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893060; c=relaxed/simple;
	bh=WSv63E86qvPUj4IDkMuTgyn8XXwV8M7kWuYrhqJEGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnyhqEc05qOxTUZuB5qnMyUnhTqwNXEd8fsuI0bdsWK4aD5oKhGpQIHFEsVoiTnwTa35kdLXOyWwJwzioYV5j676trCG+PLsz/wqGfAE+fHtHCvCMJ0T/ATWBaX0IieDh1vLrbCbunRXqSipN+iOFRGnrw+HAemLUmll8wSZaQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnFsY8am; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTuNNTVDrLkPhoPbrkA9YiCVdr/sTe8hNJpaW6xu0y43LHmss8eIo0obKlXIe3MaoFelVq4tuZmPy2WofH8iZD0mPjLyWRdBJO/WB7TgEwBBA+wDeb2MMtoqAOPYUhhlh80Yp5wPxw1eoE5RCAirXdumwpgaDoUY+K+HbkmmbRLqzf6XYuuVnsR7NkX44MCin+O9k2JpR1IqT/sTNJ7CiC+pRKiK+AYx68W6T3dlHHhDh4F1KXhdJ/IgL6ygZa7TtLW2Bj6+/m0sGWONkUsYshiXb1VLXvR5UoAVOTpwuXADe8Yy+/OaYlyPabJzkqcTqWlI8ELBGmtrXz9zWoBNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99VjyEFKoXL+1PQZk1EQK8/5CigZbqHALovd0MszeCk=;
 b=wIwwYxFoWTNBQo4T1mRdReRIqg/o1Aif0B3iRwbe1YAKJTJ9mnjazQ9Acgtb0n7BIat0OceEZuaEFKWpjhH+FbLP8XtHhQoe+EmQNnAWqIAlNEPTQe65qU5I4rr3nNvaWunc1J0e5quvUw9TyYfSXyYkCDf2a1fnFsG8hpcUI5Osf/WShMP0rRprDZHM8DIhSWILEumR5xYlD1K7tuNiFTjN7gWl8a4NyNODxqCjkgzahignlZopZJUcl+W//exq+bbP+fTHXQv/v4cDesl7BGDMLMfhQfdU2JI4f0vFNLOAFDW+xeHGl1P+zN/G/dYNg0vc7Lo9KIH6Xhxmih1axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99VjyEFKoXL+1PQZk1EQK8/5CigZbqHALovd0MszeCk=;
 b=OnFsY8amO/30ubH3DXT5JqsMwHPHFeD6m0Xuc2p1pmlviNaALpXRfKdVbJEFunacy+vEurCGpdOhAx5PjtXKcM55DKSUOdRFDr21YwMJNO4VC1k+OTikmiGW5QZjX/rGEImopr7Z5py2RiM0kpZS/J4kmN69/KKdjS5SmRrsbQi7Iasi9UtDKLWe5VOi5EQgOx0YE3MVwk0Ne769yevW7ymigMy9nOQm4hs1B4iDQflCmp7ttwqLXZeY14HUj8XKoft13FtnWTn0qn55uZWH2oHWMjhzLcKB5tReEXFZS/OgLQ8miMqsLudSDGooBsMT4fOn4SsXV3RX/Gom1K13hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:56 +0000
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
Subject: [PATCH 10/16] sched/deadline: Account ext server bandwidth
Date: Wed,  3 Sep 2025 11:33:36 +0200
Message-ID: <20250903095008.162049-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da882e3-bebc-46f4-1ea2-08ddeacf60a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0K1DNNb88uqYO/7Q403uNdUM0R9rOFut2Y4IPt651xyhUc24UwdUi78QK+dW?=
 =?us-ascii?Q?yCI4mt25QVRuSkV91s/yglKN5zq++r6vE8nosvj3vq85SaWUmlmW3D2P5510?=
 =?us-ascii?Q?3oIHSZQwBr3ilUGKY5KuOhx3JIvg+DOij6ESRrK9/ZnKQ49dqF5/dl+lMOo+?=
 =?us-ascii?Q?TiqIJTbEhg3ZBQDjz1w+G55UYMbCOofEnR43t/ZYV6TSubye+CC5+P9soCZN?=
 =?us-ascii?Q?SFXSIWq80KWJlnXYyPTCKMuvTV97sZ7M2+M6VJayUHMZpeHF+9M3V5FEu4no?=
 =?us-ascii?Q?nwfsDQ3EOyWnnpE11kcAoM5nrO4QKNonNTBcahRyAyhLUDvnsMudAwiiK8uw?=
 =?us-ascii?Q?LefuGYIYxtHBS+J852Dt5/pGEB0MswG8qMuWXi3BSHzrv707SRLJg2U6BUhz?=
 =?us-ascii?Q?QYZF8SpBa2aCjNqaPEwQrvbdtyZpb9b2fvXk6w0z7KT2SKzKlcGFhmn/ewtP?=
 =?us-ascii?Q?6UK1vduP9qNmzB54Ina/DrYJyiSEPY5qh5hcJZrc5o6NsXkZ6iL214a/xVOy?=
 =?us-ascii?Q?tPwf8uZGywPT8A1Mmp2F+2YGnY40sr3Ms6HvDTmF/QaTJYIfC+qaTiebF8mh?=
 =?us-ascii?Q?JcixnXNb319OAZxmOsAS6Zlij35HbajdhjKnruXzgNp/bGar4xhhkkOPIGNF?=
 =?us-ascii?Q?4wCaFNSjES9VwOl8fMvLmPG1jDJJaFldyod8h2+q5XpCHD+50Vzz6KCC7U72?=
 =?us-ascii?Q?lVik2sXC42+TWCHK7Z88lnOT+pluAMwe6QQvNR/sQSwQJh+qgGtgUL2pskrk?=
 =?us-ascii?Q?TR4xBcfP40w6qAf+UgigX5DLwansLs9xF+oInhyrnRL9xQiuVxfvBUbYulMv?=
 =?us-ascii?Q?/5JtTmy8BIaiorPS0DRLFYX2YFTXrSitlx/DuvBYa67xt0FFZbRDrNBJqaJe?=
 =?us-ascii?Q?519fXyixNYC3vw7H9xTgBm1MoCFEH1gEYRimE/Z+/eGDIsMPbSjNUvqRu2Tv?=
 =?us-ascii?Q?uDFUA3uC4wB+zD16UD08uupRmwVo0e7cz8N6NbSZkBpHy2BCGKlQoShtjY7l?=
 =?us-ascii?Q?iTMh5Ci/cnhf1NXEOIjPA+Uf6If2jbZm1RW+eR68orAhJM9XxE0x4n/HTbx8?=
 =?us-ascii?Q?8iJClmO/Oddh4oJ9lWzcn8FL3hcH6N3aGaikc4MmzqvaHKdksdFvD/pd3K0a?=
 =?us-ascii?Q?McYKZ9jqFcSYMdKZakNFhIYeDf6VLkM+DfkHOggTF/C45sGYVT2/51oEmf4E?=
 =?us-ascii?Q?qe6oQAL6cWBfpEa5VlYbkhNbftp8SWMQ4EmXkxvZDV+e3JuQcXbnOeL5BlyU?=
 =?us-ascii?Q?EB3Ze1VmMuB2Jo52DvvxL3Sm7Zv+VZsyyNxe2kcKI1hlar9By3hzMtrbJJfQ?=
 =?us-ascii?Q?yKhAVpwo3IVkuML28IRvSiRjOrj8TGfXDEwcMXcVKMQEKl2nunfBgt2ZXesO?=
 =?us-ascii?Q?31DMOO56HyhSqcQr2xatYVkJ+XtfECzcGLSRpIN1Z+iFCYdOmfIanqsRyka9?=
 =?us-ascii?Q?RT7y1Yc4riM16W0u/zEZxg5vZwFpN86x8Yvf0ysPaD+GSbADKlgHog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dsK5UscOKYX9yMq0G+2O/kiZ7shTg2YrUTfRT2aonNhoUiBcMXkJXLfWSVS?=
 =?us-ascii?Q?/d8euHhwgcApVht2+I/jgn5Uj8Ye9Xh9yd6sPmTOlsYwPD6aKyVBaOMyTgQT?=
 =?us-ascii?Q?STWGxG61BS4lhN8MAe7lDDgchZRHOK4Zl14b0w3lUgsnVktVvLEMHCdhjFXG?=
 =?us-ascii?Q?u+zsA+7C2W1LlkEv4abgIUJ2EZRG4Kvg5dglusnfC62LCn+7qYsr95XwVWpI?=
 =?us-ascii?Q?QHeeciEldgAojy+7ke/35iu0wPwerchPXh1NQDSL0m364lZeSWePDjtznEDK?=
 =?us-ascii?Q?EnVxniERVWke80Pi3WYK4KAefO9Yf+X9Hj4U5gLJHRuqzpqHHvAx36ReJcj7?=
 =?us-ascii?Q?SDn/HyFD0iGhSvaB+3A6mRO1O48oe6SVzNPyQNTB9T7n/7ilHIgUmt69ot32?=
 =?us-ascii?Q?IzP+Lpu5jrNxWWozq0Xh6okP/Us3mxDvou6zL1yTVcaV39UplXDQqu0PHsDB?=
 =?us-ascii?Q?ZbDNFQl5YbUQq5a8gMBLlHdQZtI+xp5XXr+NFy4JbHxmZL/ILOXdr+IgbNBX?=
 =?us-ascii?Q?+Dyjw3Qi/JXlvdeH80KOQJG64MeQIav69LGws3a0Sb9nUgiT4zQ5aSpRmTNK?=
 =?us-ascii?Q?63DHAS4bJw8xQIuF9UjPIv+TsKqyRVILyMvkA+YMgOAkLIn7rWC5cjhdW0tS?=
 =?us-ascii?Q?uc2AsG78bdFkq7gyQcNL8SLP75hjY/WxUof7bfg2bGtZIes4RF73P2qWdA9w?=
 =?us-ascii?Q?c1dhxwF/KY9TibmRUI0/YBBcuTlJAJlz5ozbKo2fcsHzv4WMBWtkw+j1qkIB?=
 =?us-ascii?Q?l0PQ6kObfs8qzF81f29TCRdNiBh0vUbgO5rhk0sz3AYQP7PQ0jcqgEmIFSrJ?=
 =?us-ascii?Q?lb8R0d/5OuNduHmPFTpnovSu2Ax5gvQlss1rRZHwpSuuto4hBCbi0Ef4O132?=
 =?us-ascii?Q?TzGQrXLWL5XIPC+QsDuCPDzw3SSBp9UJjMkkfG2l1LeV8avBQw5q4bOOUQ8f?=
 =?us-ascii?Q?v8xxHVqKn9c2eI81xaOcSsPFaQpOjU3cAs+kviu0jdnXqo5US1rX+KZwiwSK?=
 =?us-ascii?Q?ylYC9Eg+BFFiVODs9VUJU8KOUoqzN5AYQDydYyKBm4nkN1TeEcZOQH8A7j02?=
 =?us-ascii?Q?7igBFydjnjZQt3NeZcnVojhX+SuNXp9sRc0GPhy0aOQous2QS3/Dx/3DuHbB?=
 =?us-ascii?Q?z/XsAvaaPtparjDqmTI9+ZZw025lM9tsmptKmmpZ8WOj6d7OeXAGjHb7Iz1C?=
 =?us-ascii?Q?IJEzoCS4YdMjqrhFVogFI5O7sET8O6wA3enMm4i9fm4Xe9uzhpIb/j40uoL6?=
 =?us-ascii?Q?8ncZn2mjc/GQyFwBFzylf8Ev9dlInCBdoWszi7t1PxhQt1e4li3EBD7aeP9u?=
 =?us-ascii?Q?PSFYlSoOTzUFRAa0HKofqUUcY2mC2v8hj495yEyqXmr+zuKOaVEBV2Y1Z+sR?=
 =?us-ascii?Q?5R3QIPCCO2IxtdnuyioOAm6gFrcK8GK+JKisFSAjBbfarZEXXzPzENGA7+SN?=
 =?us-ascii?Q?B2RTR44HsPoFIPxJAxfrAxvhVRu8okNDwhdVgWdrTNIGHazzNIJMKt9wNlMN?=
 =?us-ascii?Q?nJgZ1KZIG/F7+6imGZJK6z0sCt1XWJC21rx6ByVgsgptp7fLwGes7JVVHvV2?=
 =?us-ascii?Q?A7hdBKBdrqNganr2TBTwgAVe4Kmj/C1IwUGsIbxv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da882e3-bebc-46f4-1ea2-08ddeacf60a6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:55.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUMwYZkfsETvsP2nLRItNeWxhxAGrmDqRUIYoAKeFySq8GPI9YtQ6EZ23emxY+fu2WvXHkxEn7FtHow+ol/Mnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

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
index 31d397aa777b9..165b12553e10d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2981,9 +2981,17 @@ void dl_clear_root_domain(struct root_domain *rd)
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
@@ -3478,6 +3486,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	struct dl_bw *dl_b;
 	bool overflow = 0;
 	u64 fair_server_bw = 0;
+	u64 ext_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3510,27 +3519,31 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
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
index 977e133bb8a44..f4574b0cf8ebc 100644
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



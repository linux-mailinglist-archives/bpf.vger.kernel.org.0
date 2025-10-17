Return-Path: <bpf+bounces-71194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93ABE7D7B
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53324422BB8
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2552DC76B;
	Fri, 17 Oct 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZK+3f8jY"
X-Original-To: bpf@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF43128AB;
	Fri, 17 Oct 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693666; cv=fail; b=uH9WJMph6irdIjRL7xch5aRVCQImnOqrycfobkToH7VQN8HC8tuBjFNw9JSsfhunpJs3H1CC1fNT3osSwSgdFgBHxclzmkATZa72ZQchh7WiafMv+F/LYBcmaH52OKj0T31ZJj/ApmUpNRb2/M+sp3JweHrAz+daQVKEaIx8xvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693666; c=relaxed/simple;
	bh=0OW4dldBAmein3b+zsoaZgHufqV5bKL/HF5XWlV6ZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtEBO4Rw9nURhZ3s2N0eMlR/ZYedelpqVAp2Q3chKufq2FWx6DULCLsI0krMAiMqjyGKK3l1PnXEYrAf/WndzkTfVryHaKgD7fCjtOktc86redX3g1/dX1/uDVHT4FdHBko+KYTzPoIF7rmgPlIBwEd5t+wJe4BipY+q1hRyi9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZK+3f8jY; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Crh2h3wW05xismSofGOYg0lpsBiDqOWBh4m3ZWlaIrZTrxNAvE4dlFzxm2sqHjADKvt9j+nPYKSHBolAy0PWlAz4z1MGjwk6SjPP5q8+f7LyjXqQV9sycdqDR5E6SnP3X0JEvrXSinpuYbOzLzkBvmdcZbev2//xBerf6UN8GKab6lEFMae8DcJ+hBLLyMvSbej8pQxIMy4TG2RAnxqnUdyGAyzZYXlDt6O16DBXAZe/EX0kgDBpo6PdIbK8PSVUEXt2Gj3Tvo8FaTyCYKGN7HFRVHd2+hnEKCLuYPHBB0OVPGxHoGaKkz88M2DzhCgziJy1ZmsHei4lL3qBNb9V0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPg5EHa/m/bCoWDmwA3T+RaROvsdu/lueUsrpbqZWTg=;
 b=UMb9CAgDH9d4quOaugv71fI3rlkInG9e1jJgaC6MMjRrwGyHffZYTD45Qh9MmN6qg00O2K3Iys5/srXRY3uJk9WuiIsyQRcu0uWLX1Lmb957QjDXeWvn0Zx1JTHVTVNUOIE7TNXnCsQe1Y5qL1K9S1rCut/raMt/FiLlET3e/qangfKY6XpeI+tgTpJeN2Q+VpQh6UwNTv0dBOc266IngmXIq+9PfZwgR1Q0+6qmjy+/DpKWBwfjeYa0Anq/Ee2tQOjTLPi7od4AzBkqnTkwYbQNW8dKttDUts0+ll1KtKQH+Ze8U6upQLXV2Q53Mu3lemOL00M9O7ph+ZVjX1QCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPg5EHa/m/bCoWDmwA3T+RaROvsdu/lueUsrpbqZWTg=;
 b=ZK+3f8jYDQLVdjHLdkOXx9iJeO315lw52PLKpgKhWBzBiHZNACGG5jGsxmJ+lOtY0Bq41dFfyQfl3lCG7KdhSwKl2+l4nvsVNIWI6pEXIHoJtjrNjjLQcjY7BlkGlLD37KZqNGLbYCiZnkTBzukNVPY45gwK4JfQTX+FIlyk7LWpY2imDCqxAcKTI46b/O+GWXStO2s6rr8t7JHIyb7+uUnzy9Mn6Awq+FZCzGRpxqcDMRi38/uW4WfvDhiJi4wuFlwxTsiUnr+E/zPzXQL1WvJQeY5YLPS6Ti4i5zA++D4zjgl5kfoOnVL18SEO97S2DVTwEqz3YmmIhhxHrUKOFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:34:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:34:21 +0000
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
Subject: [PATCH 12/14] sched_ext: Selectively enable ext and fair DL servers
Date: Fri, 17 Oct 2025 11:25:59 +0200
Message-ID: <20251017093214.70029-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b73e4f-3e83-4c34-a76e-08de0d605a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7+1OwlL1iHM7+PSqzRluuj3qtATpVm7APYigEjDYGFSMrPF4Cj2+LgnN+g3?=
 =?us-ascii?Q?GMIQPyk8n/J+wNTtEk61By3fulHEdec+9obz8fTCux7kGubIN+nop15QopgY?=
 =?us-ascii?Q?4gvkebL7Pv2HedWSCZIjrgS3SVMEvllvWQ4ONc8rlmI/+IH/qKqjesR4fXRb?=
 =?us-ascii?Q?tWuRVBU387t5ZNam3Z4OmGzDoHw0CJ5/NW7gkQo3WjkIrBiFuEbVUd7Sjak9?=
 =?us-ascii?Q?CmViKFz0Z9DIBFxWsOdwKVHI6MyRQgTbnSqBjSpCf6IBcD6AVwIPME3izzdb?=
 =?us-ascii?Q?EqYNpdKAU7vl/CUALEuLdmeXZiTY54dFzoVZNX9hj1LDSVJH9aW+GEzlGWsA?=
 =?us-ascii?Q?ZCH/gtW714MRMUyRDU3NHQQgkP5BsCdn0A139OWFgP+ppeXhxnpNua8ZueiR?=
 =?us-ascii?Q?WJqgkwbBKIhzPucHm+EW2EUMBWsNi76VEDeAxZlv1f/RqZYYjnFPG+olvprd?=
 =?us-ascii?Q?76pzi8AxRskkubrcVFqYMji752Cksr9xxZ6mkc2um1aoVdsABUz2m05W9c/1?=
 =?us-ascii?Q?uYE7hRVpf5o+hZ9qMi4MQk+kClF7uSPeK9HQkFK7pPwVeYTod5j9RuVg/EId?=
 =?us-ascii?Q?613KJ3Pk77gz/9VXfwx3NzlFdav5wMnSNHUZEPzR3+u+g7JHHpLmIP8W94LJ?=
 =?us-ascii?Q?woF1rsV5JsTzJiv1AVote2r+k5gHahYmfjsG5tfqjK01S+yqKTWLkog2DMfX?=
 =?us-ascii?Q?X/oLCgFyEa5TlNBxdqpOPkmGL8cMPnSxDNqjRh1uf9SFM47zS8Z7zCngc+/0?=
 =?us-ascii?Q?C2wS2bonM4Wp3vbLCxnREt/DfDx1u2av8fcnwNwNwC/vdPGI3kzcyXVMjAnO?=
 =?us-ascii?Q?xVCPgN3POsFmzuUnu6zmu43zSZBhAxG+ZhxR3FgsbTb6strv+vk32SP+MgMP?=
 =?us-ascii?Q?T8+VGJUePUs9NGwsz1AbunGeYlxNkm52xDL2m2lLGuoENr4hMTyPWeUc/Bzk?=
 =?us-ascii?Q?PdKLDI07SzSMjlkSqhOHr/fewhiWXctHQCV6G4ZNu9cNDiInYZj8m+1QjJ2M?=
 =?us-ascii?Q?LBFmaUtuYa2BKen6tGLVDDOMjwnP7CPxahZM7ScM3umUhvQI8RcH9gwELk0C?=
 =?us-ascii?Q?m/cfn0KdLX5pw/heA+osIpKlp6HoBUgkxvI5koVpGBoBkyruJ4VUDZDZBOnd?=
 =?us-ascii?Q?cEpE0HNOfCp6XlI5md82hEAieWcxtBAgETXRaUJZohYiG4lV30I0WBPNx+pE?=
 =?us-ascii?Q?QGZBYzmHyncp6x2ofpr99LfWR0XGy+B6lmff2TcW3gGN1XCU2RYcWLw+1KIo?=
 =?us-ascii?Q?/vEyzkJevWn5QOIbnhoeG8dmd4q2DRz3kJ+US8hQnG2MmQTc9VVX419oEiDM?=
 =?us-ascii?Q?HcSjrMbs6fI95XTGZ/ZNbXkpuH9484qqnAg2OFqCDuYV7/cqGxDg8KGD5j/c?=
 =?us-ascii?Q?CvIBMMNFRKtDw78w4MzLfIhTeGMBT7W29WEL5Sr3AfBO3Rqlv9ZmVOpCcFRF?=
 =?us-ascii?Q?b7W6SVCkIMJxIyu8AlBMLTt1L/dVupkZkw8dHVpHys8knAdfnRnGv5OxxtWB?=
 =?us-ascii?Q?O1LAOfetgQmaVD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsaC2GsdBjd5mGTAN5x23NHOJIUd7lXhjFVZjhzvT2TFdTWfUCcHx2WQAKnw?=
 =?us-ascii?Q?PxNMYzQDlAlaoLJngDmlN+kwM63QfDckOQskFuKGHTbY0CecWDgufFixSXQv?=
 =?us-ascii?Q?akIDaGHwd640go4OoL3nHy43DFnHKE0Ca1s38XqPS+SWU2cON0WGa1CC74z+?=
 =?us-ascii?Q?MeKdxeChD4P/Q0xwtGCSpme82XJ7tWdEpUp6lDpDltQjBEFuJdMI84vWLMDk?=
 =?us-ascii?Q?aL3ygPHSTte8OLGgLwP5qpVr9CAov4CX3gFxq3A9FVyGcmP17DAzbVjqYabW?=
 =?us-ascii?Q?5IHuRTxNlYT8oWWcSNjjmldV5GkDitfXZZ8gyPq9oQxrnALEC1NeIN5izKDI?=
 =?us-ascii?Q?+Q4pmik7W038Fzz0bAXek3TIm0TlBJ5eJqLoyxJL7byCUdDShOEecaK5sU/4?=
 =?us-ascii?Q?f7vZdA8aDsFJNQuMZu239fujPeFvi80sFFuLZcKUDQDN+bmAhkG6pQ9o3KVo?=
 =?us-ascii?Q?+kIcW4w6LRwXMdXmX4Uet7tiURetNwH++A7/98lUzbtlBHBV87TIvs4SBg0i?=
 =?us-ascii?Q?A6hpt0Dg+KKivrNadK6AOoU1ZDYeNHaLg0gV+DNswlrCDpJ1CpMCMu4BVHNB?=
 =?us-ascii?Q?GieFaU/bqUZbrXhqIiIcHk+vJbK7KOGrEmOCVDqBwD7qxkssLIKua0KIirCo?=
 =?us-ascii?Q?LOYg0gT3QXdauaVMR+zJhLFSKFw0fs4tCEVbO//+l45iM3g1dKAcGrN1YLDS?=
 =?us-ascii?Q?RjGOewmIm2sbHkELmvNIDSTyMcw1wUp6GoEwwpIpzOIDyVSIz1AIo/6Yo+zd?=
 =?us-ascii?Q?zIPrevdh9VrRryp0YMf61cJ0PYcDh3UtOi6BSzln8w8ptCF6k+lC6pHHrBWt?=
 =?us-ascii?Q?/EW51IIrXkq1eKgYbzfHUP1vD9BARt5jdN1ehZi1OTyiRNvSzuaJM74TuH/8?=
 =?us-ascii?Q?mUMs1F1lnpRebTbO7dc1QFAkhjPP+fbpwKjCr9YCG2j+wpk0EgLbXSPbm8Og?=
 =?us-ascii?Q?LA3OXccvVC782Gf0Cvzs+2H0iR+plDFqI8KkoxHRjayj/i1KrGbHYWZCqPY7?=
 =?us-ascii?Q?eDX06l3Gg8thBA8J0DLDIPe3HWwn1w3hTG4BEK29h5LAShN8sMGtfPbPBc9P?=
 =?us-ascii?Q?wvSuEivfWbo53BfIkoxBu+/H0UOp7MBfKql5UZJ88JopF0R9boUEWt0fKGIA?=
 =?us-ascii?Q?qSdvFF0iK8/SmbkBsOp9oSgCgyWFKAfh1jVfB5jtX9thIh+s01ms5ZVX2Fe1?=
 =?us-ascii?Q?6T6zGSYtNxeHq/RdqiQ2MPMn0F1CXLe0lxWKYJpCnVnYkkoveV2nQTtedjLu?=
 =?us-ascii?Q?HgzbcMKyuYG46+jx11s1nE0XaPHO0Zcsp9TAahjhRGz2PYEhmWHJlsEFtCCi?=
 =?us-ascii?Q?QUOPal886RizWqe4zOz+ROFbnCEFHeMmlGlocdNQY9NIph5EQU2hrlnfVOjq?=
 =?us-ascii?Q?MBpMJNbtjjgGGEObOS7JafJnqy+cKDeZcDI5x4d2qAcfYwo/Y3CqSyHuuWWo?=
 =?us-ascii?Q?bmLiWt2vL9LxDgDm+ov3i58HO8fzUOwJEBTJ/V+EuPKPERN1vBT1GwD0lrw4?=
 =?us-ascii?Q?irpkotPX7gM41PPTCTYQPo5EiSsa2V3bxRHsUfhV03VOgDjMChfWf+GoEAb1?=
 =?us-ascii?Q?z1JtpeT4Nu4BesXGNQ8x9IYR0Duj38UfiPA6/ORW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b73e4f-3e83-4c34-a76e-08de0d605a4e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:34:21.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Me/YrvjeDS95j006fRN4rBZ+h5YMvwZ2m5gTW9R1LUDXYPotWc9EJusQJbdjLQUiNuCf+CLFkX3asXQSRM+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

Enable or disable the appropriate DL servers (ext and fair) depending on
whether an scx scheduler is started in full or partial mode:

 - in full mode, disable the fair DL server and enable the ext DL server
   on all online CPUs,
 - in partial mode (%SCX_OPS_SWITCH_PARTIAL), keep both fair and ext DL
   servers active to support tasks in both scheduling classes.

Additionally, handle CPU hotplug events by selectively enabling or
disabling the relevant DL servers on the CPU that is going
offline/online. This ensures correct bandwidth reservation also when
CPUs are brought online or offline.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 97 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bc2aaa3236fd4..c5f3c39972b6b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2545,6 +2545,57 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void dl_server_on(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (switch_all) {
+		/*
+		 * If all fair tasks are moved to the scx scheduler, we
+		 * don't need the fair DL servers anymore, so remove it.
+		 *
+		 * When the current scx scheduler is unloaded, the fair DL
+		 * server will be re-initialized.
+		 */
+		if (dl_server_active(&rq->fair_server))
+			dl_server_stop(&rq->fair_server);
+		dl_server_remove_params(&rq->fair_server);
+	}
+
+	err = dl_server_init_params(&rq->ext_server);
+	WARN_ON_ONCE(err);
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void dl_server_off(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_stop(&rq->ext_server);
+	dl_server_remove_params(&rq->ext_server);
+
+	if (switch_all) {
+		/*
+		 * Re-initialize the fair DL server if it was previously disabled
+		 * because all fair tasks had been moved to the ext class.
+		 */
+		err = dl_server_init_params(&rq->fair_server);
+		WARN_ON_ONCE(err);
+	}
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root;
@@ -2560,9 +2611,20 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (unlikely(!sch))
 		return;
 
-	if (scx_enabled())
+	if (scx_enabled()) {
+		bool is_switching_all = READ_ONCE(scx_switching_all);
+
 		scx_idle_update_selcpu_topology(&sch->ops);
 
+		/*
+		 * Update ext and fair DL servers on hotplug events.
+		 */
+		if (online)
+			dl_server_on(rq, is_switching_all);
+		else
+			dl_server_off(rq, is_switching_all);
+	}
+
 	if (online && SCX_HAS_OP(sch, cpu_online))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cpu_online, NULL, cpu);
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
@@ -3921,6 +3983,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	bool is_switching_all = READ_ONCE(scx_switching_all);
 	int kind, cpu;
 
 	kind = atomic_read(&sch->exit_kind);
@@ -3976,6 +4039,22 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		/*
+		 * Invalidate all the rq clocks to prevent getting outdated
+		 * rq clocks from a previous scx scheduler.
+		 */
+		scx_rq_clock_invalidate(rq);
+
+		/*
+		 * We are unloading the sched_ext scheduler, we do not need its
+		 * DL server bandwidth anymore, remove it for all CPUs.
+		 */
+		dl_server_off(rq, is_switching_all);
+	}
+
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -3997,15 +4076,6 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		scx_rq_clock_invalidate(rq);
-	}
-
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
@@ -4778,6 +4848,13 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
+
+	/*
+	 * Enable the ext DL server on all online CPUs.
+	 */
+	for_each_online_cpu(cpu)
+		dl_server_on(cpu_rq(cpu), !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+
 	percpu_up_write(&scx_fork_rwsem);
 
 	scx_bypass(false);
-- 
2.51.0



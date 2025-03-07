Return-Path: <bpf+bounces-53609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3649A572A3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D3A178B15
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCAB2561AC;
	Fri,  7 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="psEvXwoM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D29255250;
	Fri,  7 Mar 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377923; cv=fail; b=q01JXwgzFFPPxxlP5ApzvK7MWJvXeQ+9oTGV4tktlDeMtwFpuEJNUwSYo8dTe/HMm6N//He0yiKBtC7qxTcBCK+GSD8wlwh/wgspsgrvYYdm27vI6w79QbEzYrEAAASAO6WVLAGOAPvSotI7djcHe0R6xLUUJjbrlXfz1uS8Mq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377923; c=relaxed/simple;
	bh=LZMv5srYSfXpVdnHh3ECFQR6G2sqKOPRi3fPqjgzXrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4xXEj1RlZeTCjACgQCyLORV4KWz27BfJtIB0CQSpxUpGOseJPqddwg6GeHkbTIxBZ4npwDQbR5GySWAp2JgTpFrJnAj3nv9UqJbYi2ZYOFpR5yXr9Q4P/0hoeuhzxNKM0Mh7G2e/GyJ2JgSNGPCZrYbkGtaFjwWhu0BBYmvz7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=psEvXwoM; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzeca/y+cUKJ+wxxyDiH8XHX8pxc6cyCXZ9mm5jba3zgIJoE7NSJdbQM2Ged3ZiRKlxgRgOaomhEFT4oxEMrNHuDKZ2xXCrrFPcLVAlbDjmPbQb4r8ZioUrfFxPxgn0QWJ0VY+L0hNmDfZffTTWzK2MrL48bKymeqt3aGYCSx+G/KsRYEQeRTNCZR81VLmkg2eDbMS1ZzPLd4ULyTAa3u2MxMLN1kMSWo6IpVSrHqv3TbQv4SkBdrbJjsFWY6iC28Hm551jgBmrPY+q/cFnTcgz5dzhuwHvK1+57wccTlaTQ1IPa23WcE+QwcrL4XiF8s7z/RXOVuwUjq6Y+uQqa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCGu5N0lsnzCz8FIYttM56vGucMJOruAWAl4c96NA+0=;
 b=Irx/zjV2o2AS1JoYd68DHGgtcBKO5cNqOIlD7ZDyBtAL5tw21JEq/hyim1CNGOXMzVErGSac+bSQfvw77BfcPHwt+dOxBRIrY9wywRek40ICP4SpZIjAtNquHRFwND6r2AHTQSsRWMzvT8ZfGeeDWF7Idf3l+pWfEWg3jfTo7Hn9ym6aHef83VaqBBou7F7UCE+Q/nKAW1aC3snAjRDtrSafoOo7IEVjMGTrZoreOiyrf2oE6UD6WlqvNwQ5xkyLTttFVcpvXz20LiB5iqp1QEuGCELEGYdqvkrrN4+4zleyC0SraaYyCeJCStyyKzLblfQDBSB7GYqHUcxn/5jlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCGu5N0lsnzCz8FIYttM56vGucMJOruAWAl4c96NA+0=;
 b=psEvXwoM/ZvcqpE8xkCIrgOuPpym3BOkDeGICoR4WL2URDHWp2dXMqumSjqJhdQH+iDq2zVpmmdFtBckj9xBUEBHAM6YnNfdgicjlLYIscMrAJXvnXOhCfr79PQhKXD7X/BEYyqEInD8j9c/gfZRTflGI5HElM0/x8UTahqJJDlzvyeBvG+mKupIINJAQppVbGJ4/sgmrJNuEcYwSd2kwvzh5PVaNVnXLkxF5lZUu8tf/if5oR8ZGH9BiKTR3FekVpxk/Q2NTLB5BgHhPAJb7qz1FE6JZ93VEpYO53XWffP6dDNBA9k71TC8CKVNw50233pEUZZLUPqbsNQ+3WyJMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:19 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:19 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched_ext: idle: Honor idle flags in the built-in idle selection policy
Date: Fri,  7 Mar 2025 21:01:03 +0100
Message-ID: <20250307200502.253867-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307200502.253867-1-arighi@nvidia.com>
References: <20250307200502.253867-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cfd4e3-8505-4283-f282-08dd5db362d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivQhHbsQtfOQ1Q5X5QncfyB+soFssv1LuLnfPDZE55n6AqYy4dPOlbGKV9UO?=
 =?us-ascii?Q?tstCpB+ZV5hK5UxRYyQezatiW/iMHUhOSR67yg2ladKtD1FmlOkZQ6W1XrEb?=
 =?us-ascii?Q?UHTLdPk8qrongrfjIk0fbJTHReTjghH0ZYmsGlxWhdw5oGqTJN6hgzHc8RNS?=
 =?us-ascii?Q?hTX9rTXzNaldO8EYuzYCSz/0+1mvoHaKDcLgE4yTsG2TIcr9WaxmjGM8TpMO?=
 =?us-ascii?Q?nQB6CxSZGU73SDHbfsNkO1oqTYbG4F/FIuolc/qCctbjqWP2jPHr6hOgy01P?=
 =?us-ascii?Q?aaOEjcuSWeu+1BVxiRTL1uMIldA3ekZ+dVbMSGiajGzdTdLYcZ368ADCGsjd?=
 =?us-ascii?Q?42FSafasNyx7ZcH1uaCyg61XvV+lOPWzp3C/RJEPHG213mLwaavG/vnWHCdo?=
 =?us-ascii?Q?w0R2iB8S6JPnzGRUDpYHRA1cRqzw/h/F8tNI23yFac71pzCLl10zVoSr6vFL?=
 =?us-ascii?Q?lgOQYpdyYvIzxXHYTkSI7elZLQK332sGhbX+2fLx1NSxCcvdIkGEskqhsZ/J?=
 =?us-ascii?Q?U3d7KDqibAeOcI+9+C75p1/A2/Pn0wTGlNbZOLEKKzKXqV5WccPbgI4OyUFL?=
 =?us-ascii?Q?0//kxTEyMIV+PKpVyXiLopJbxjwYKRdBkhGiLGwQaB8NndhH4wD5lQbbacr5?=
 =?us-ascii?Q?tNU9nsS5vA01wUYdWEAWfWdzUN0W9uYechySUkUIlKffr1gE7F7VLF5jeUb2?=
 =?us-ascii?Q?AXGAbycqeMW5YFQ2IOf9JtBU3Id9a2MhhNFXi1dlwbpLkaSZFOtJhuysZsiJ?=
 =?us-ascii?Q?ryAAjl88tSHNmNaM+cfVsP0lCL4plBv77/Zz3iLGil5d8MH1yA6wcbuUybis?=
 =?us-ascii?Q?PeMNMVEU+eH0E69YXBUykIQ2agUY2Xlw/cCFg8ty6upKdnHhBzDfY7D1DjuA?=
 =?us-ascii?Q?yF+nhJznS/EUPofTmkbdTBzUqrGPP5Nsx5yr+9b8pz81HgHZ/jZTxLZMOajM?=
 =?us-ascii?Q?P/w8clghrGqjUK9yVvtKlyKupNZIC88b/T5GSZBMjC9zTeCUly/ZMIKRdMtn?=
 =?us-ascii?Q?QOg6h33hm7MFZLXgaJWJZ2eFtBtQuKUi/7Fb7eJrGItlpyHRygQ8jeEHW4IQ?=
 =?us-ascii?Q?43g09GX/8V+lRJ0yoTMqYwa8j+eCzLk8mHOhcc9Shhtjtu/VNTjO3PI2Bwpd?=
 =?us-ascii?Q?qx+eUYa3yR8Q76OzMDG+fsB/4xjStqtoT1ldWh9sCfMKl7NM9zMeeQ6cHnuc?=
 =?us-ascii?Q?ovEYXlMcx6RVxx6OiEocs9/+Iu6wD6m3muIXAU4QLuZeGhUGwJcg2trJ5lCo?=
 =?us-ascii?Q?L1njDqyI7Ig6IVpkEjdG02bw9E5Gm9E4pfCUFjt7R1zpYzsAXO21YInVkGbC?=
 =?us-ascii?Q?1DZbgw4nBZNhsZH82KL1XhYAl3Itl+HT5/2NbiJa0Xe3A7KbQda9XSPrCtN7?=
 =?us-ascii?Q?Et1xA8j3fdC/sKwd7YYfE+I/VntA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fi6eYHtW/P3ip8Z99X651ahFFrhTIUN4G/pK3m+t+oIP5jYzLos06HjE+yS5?=
 =?us-ascii?Q?i/r4ROv5MXpIwbh4Fcki/cNXpKtMuEt4LZ00Ae2yeEumNmPv3Ph4Yq/FY+pt?=
 =?us-ascii?Q?AzbbOgx/q+t/99HSF5d6xrMHrpF7ECwRldIkvgTq2GxodnRdH59RtZWsUpku?=
 =?us-ascii?Q?KxvO4p8saGzYtC2YHm4CAp6L/J9EYJQ63vLkPM5E+GLAD0AZ6c6T0OL7e4dG?=
 =?us-ascii?Q?U6iBGSPsMghon3HW6k/bzWa1HAOURXFZBxB3vOW3rk3rre++IMGGDSNnK2Rd?=
 =?us-ascii?Q?3lE+lpFwp9PFkxxagibPtFk1UuAmxHwdLwNzHgLdyyoHaChjGvCmtiu8tkvD?=
 =?us-ascii?Q?qrT0cheDBw3nt8FHGMVc7WSM+c7S1t5t86DxiTAARmZ6fcn4yndwTsXoAvOI?=
 =?us-ascii?Q?S+/ge5MVc//hAY+TPV9d9aOJkYTnBspIqguKAaqNeYv298+RVHPyUkEjHnYk?=
 =?us-ascii?Q?/i2wJ+ay9MWOzaOeYssJz8hMaNwgubWOgsT7VUz1VS10hx66/brW2SC92di0?=
 =?us-ascii?Q?jlfApBMLX0Pd6oOnwJRDi8HtvY4EoQMdaAL6xiEZyam7YV8Sx5dQxU9EOCdu?=
 =?us-ascii?Q?MVF8evxDm809Nv7G9QSpN9bWfHkILzvnU3w2fTdofETKDIjeHCJ7vrd+MHk7?=
 =?us-ascii?Q?bCzD6N2I0AC3sTGOYzpOMZT8RIGZFFpvqhwOkCprtBMeTmXfnq5dMj2MNPga?=
 =?us-ascii?Q?psRuTROi91vAKbaJE9HDxhT0lDk1U0jGap/4JuWVZnSVSlStQRKQdhVsYPVW?=
 =?us-ascii?Q?eGjvCv4OIbQk8Gtx8yyHCPzu0m8OIeL4yUyi/rQk1a7+U4HX2Uq3oWKTkIY7?=
 =?us-ascii?Q?5LhPmbYUKjoKcDU24A1siTIntAGqFac1orFDtOcRTy1BivVB5XHT48z6FCL5?=
 =?us-ascii?Q?FkzKv1B/gJZ6sR/nejj+Dnr7Qa7EkUl+DRlU9c4kPjj6XaXGez+PdnEJNPcM?=
 =?us-ascii?Q?whEaVTC8/9GxBkFSPMirBFh/gJZSsQq56UdwZsZnfGrWhcThWCFXj+yBNtUQ?=
 =?us-ascii?Q?kY9+mRiGXKh9EondbRromL0ewNfkFjwxSHwqjwGNVdPIjv9FHg2KK8Ju8HGr?=
 =?us-ascii?Q?wKnhGUDXcdi4fR5eKt+vygzn1OhbFrXDemmufwqczCe5dHavmvo3NPnQnUbt?=
 =?us-ascii?Q?5V/gx3UtrefwMQJUxlfguT9bTxIw5DLxcDYzzyAK7vzw/EQmOzTDnB18gvJK?=
 =?us-ascii?Q?vF5LHLMKuTMeIJAyabs5xgyIq7rpq3Z8nnNVKN3iZAo5Ph75fwnGSIZBDLW8?=
 =?us-ascii?Q?K+tZycKty8i4P505SH1cjN/AeKOOW7auys7o9xwFP9iYivmwfrJxlOwpBJw2?=
 =?us-ascii?Q?ig2hHalgkAMM8kkw2Tn/T2VcRUxI7mz4koB0XuW+3UBFolEjEaRHOWuCx2XI?=
 =?us-ascii?Q?L49DAEqs41xHKQ83zo2TozbTHc9l9Si3Z4X3Gz4GGatDUww6DY/XLabyBNJ2?=
 =?us-ascii?Q?vRrHz+pVQY9XfWs7yOzL/SC9pSi4XpdyrzSMdeExfFyIlllDUyhBUnM5GW+D?=
 =?us-ascii?Q?PFfnSiDbHCW+dNSqKVXN8VBK30Yj1IScCingmoBBoqaAnCV24YtJQzglEZwI?=
 =?us-ascii?Q?myqG6mWfI3vnmWYbAsrKuVvcG15NMGK5on9L1NE8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cfd4e3-8505-4283-f282-08dd5db362d0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:19.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ajlBneii9FhzJE+z41erYsdaAIHoKcGurqPgalNShPzMHJn1SFecXKjqJq2utdiYuTeXp5lIkgc1JN5lZ3CnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Enable passing idle flags (%SCX_PICK_IDLE_*) to scx_select_cpu_dfl(),
to enforce strict selection criteria, such as selecting an idle CPU
strictly within @prev_cpu's node or choosing only a fully idle SMT core.

This functionality will be exposed through a dedicated kfunc in a
separate patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 41 ++++++++++++++++++++++++++++++-----------
 kernel/sched/ext_idle.h |  2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index debcd1cf2de9b..5cd878bbd0e39 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3396,7 +3396,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		bool found;
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, &found);
 		p->scx.selected_cpu = cpu;
 		if (found) {
 			p->scx.slice = SCX_SLICE_DFL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 15e9d1c8b2815..16981456ec1ed 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -418,7 +418,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
@@ -455,12 +455,13 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
 	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
+		int waker_node;
 
 		/*
 		 * If the waker's CPU is cache affine and prev_cpu is idle,
 		 * then avoid a migration.
 		 */
+		cpu = smp_processor_id();
 		if (cpus_share_cache(cpu, prev_cpu) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
@@ -480,9 +481,11 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
+		waker_node = cpu_to_node(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
-		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
+		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
+		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -521,15 +524,25 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		}
 
 		/*
-		 * Search for any full idle core usable by the task.
+		 * Search for any full-idle core usable by the task.
 		 *
-		 * If NUMA aware idle selection is enabled, the search will
+		 * If the node-aware idle CPU selection policy is enabled
+		 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
+
+		/*
+		 * Give up if we're strictly looking for a full-idle SMT
+		 * core.
+		 */
+		if (flags & SCX_PICK_IDLE_CORE) {
+			cpu = prev_cpu;
+			goto out_unlock;
+		}
 	}
 
 	/*
@@ -560,18 +573,24 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 
 	/*
 	 * Search for any idle CPU usable by the task.
+	 *
+	 * If the node-aware idle CPU selection policy is enabled
+	 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always begin
+	 * in prev_cpu's node and proceed to other nodes in order of
+	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
 	if (cpu >= 0)
 		goto cpu_found;
 
-	rcu_read_unlock();
-	return prev_cpu;
+	cpu = prev_cpu;
+	goto out_unlock;
 
 cpu_found:
+	*found = true;
+out_unlock:
 	rcu_read_unlock();
 
-	*found = true;
 	return cpu;
 }
 
@@ -810,7 +829,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, is_idle);
 #endif
 
 prev_cpu:
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 68c4307ce4f6f..5c1db6b315f7a 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1



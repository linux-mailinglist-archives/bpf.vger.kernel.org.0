Return-Path: <bpf+bounces-71183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ADDBE7CDC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBED819A3BB5
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B52D9ED7;
	Fri, 17 Oct 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FF0y92Li"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D42D7803;
	Fri, 17 Oct 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693581; cv=fail; b=BAJjl3rayx+rCCOwHHmJxoEqiY1Uj8WJFpTT7teeHZV6hNNhXMPNr1RCLTPbrPLQTtvenDBZzoFKD9fd2qgcjZ/PxwHAsRnnOHB+8tHqzQqVRA/kHUCA6N3KfoTprHUQ0Z6w1l0xxWe95lgskk8DfzR7ZsIHGSWfj40eJOpEkg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693581; c=relaxed/simple;
	bh=ZFiMH4pmYj0OLBlaUvySaa6YCqw000SVMNXA7elQSdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OR6xATjB+ljl7QhsZ9zafXyAB3YV5wn6cEpRAERHyTeA6DEFbL6iPeQMP60j53KdB/yYRwDt3hrhJI79rTjJpKBvUujJfX8XHWF2WqMGgrXsB4RDiArhOhkszEIk6DvZTBEQLggcTwQcf9lC+75v/6zlETr1GpF1tT2ftu510m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FF0y92Li; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNg/ICidCo8Xv5mjFMm4eJm6Itaj/w4IuUX0bUxOYzm5kR2Dtcwn5eys/Aoci+mlRZoEKCINNblOVOC1HfMMiVLgndo4Y6ozddwQGCfaaVeXi/nMdJI/5ULbNxXSSXaFxIkXvV4R3iePnb0WMeNbSMJuNi4nlrccm0LCzb73E/KoPO7u3fG6IfzCkdddn9yiTfASmgqYrvXfJ14tctCxCsj4C07n1O4aLiA+9nDJdtHHJiCwv0YhzDpT3tgZIJ9mmBeiHyPFK8RXCRtopGN/diJX+L1todtbyx0J65d5HXOkAWzj7QLdH/44XmB/V4q1JKOc4gT56k6pHL8Q/+52qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkP0hs+PXUCkUFvgcDIc6AfTStg1yp63bTrTldxyVYs=;
 b=ShwEv1MS6SUnsaD0LeDzDdKMlafWGhBhNtZBU4HxQSF2vWe/SgHxvlh26HfQ6Ye6F4A1pEDUJvf4O6BuiS7yC0EJtvXgHUcM/F2yNogAPJMrZbc22r4urf7EkBQA7fG6Hw5ZzKoVDKSiopG8JiJ8R47CJed2DIlE83cT8FORRak0CbAztIGtuuGTi4Av1FwwQgB3+V7b7SCoZoJBZndkuVlNMP1NQcTjBW/svtwq/eQ36Sp61P8yd3aj5/D5sCGiHsbIg1UalnbpOSLiiqSGcjrzmUqen/kTBNAjMKJzJsbaXRiZxVdCcei68OFXm1/fmUGGtqdWH1GrHIYPSgVgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkP0hs+PXUCkUFvgcDIc6AfTStg1yp63bTrTldxyVYs=;
 b=FF0y92LitE+x7I2e9mu5pWSQ9QaOLxq4Js0unA9m+leCb6g9yWeasmYLc783id8B9rIrKf3T1/7TQZXhr3EphZ+kFBgk8oRZ6YsQUMjOxPcpNinHr9KSBnIZclCBXHNfTZVOLSS8fgcMNamn44OY+jIO+So4FlLz4nEfUHdEyHa/P2JdPFCnTrauXckJD48C/5n3+n2OqzhCR+kPuEPGzCjgFoKZHb0cKLXZYWw7A1MSp2JqZKxfjPaovgpGfTauPDy5MpnmPSo8Zt29S5sUVKs9t74/dAGpgrG7O0yRfEuXK0LItZQJ3E9clC2P7JEccKQgVW2miL1SglYwEW/UcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 17 Oct
 2025 09:32:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:32:57 +0000
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
Subject: [PATCH 01/14] sched/debug: Fix updating of ppos on server write ops
Date: Fri, 17 Oct 2025 11:25:48 +0200
Message-ID: <20251017093214.70029-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d2faf9-1ffa-472c-d57f-08de0d6027cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lwz7VOmYksHwCmdy8DDv3zuLT0nwMMbpnbqmAqxT2gSadXQJCGVwpjyaVn6Q?=
 =?us-ascii?Q?3rNMffkoXcKSXzJH90lJFtHygD7t2sbxBjxWMsbXruzPd1VEWBAJTIEM7kp6?=
 =?us-ascii?Q?+cHreFagJe+S1qmHvIz6S9qU5Uj+oteenQsLpMAzoHhdheINYKzUjSlyjl/n?=
 =?us-ascii?Q?GkePKKY3NNysONRjbEOzBEIZv1iuQFt66haQKQXypqlm1j5qAEF+dq43pMkv?=
 =?us-ascii?Q?oUk6Fw0Jdgwp4nYL3MpBKCNOlrCGVZPw2fXuBJ7R0Sr1GTMmkWThtY/vkO1f?=
 =?us-ascii?Q?9PUzKfa+tpNXA4qN4WndxD7KZtYvh0Tp5R9yZdb7WutL3Au134lXmBh3jX9k?=
 =?us-ascii?Q?atsLhm5XbwfO/9jAIJiG0Q/enESGIIS+qvDnUq0khJAcJwxP/ChDpqYOPP5H?=
 =?us-ascii?Q?Two7r/UVKEkEnngFlOTjZAoKaRut8Wrtg5C8WwHLZin/wN6lNhXv2+u3RwcD?=
 =?us-ascii?Q?T0qgU7nfGvU7vMqoWhgEWeOlVq9ZdzosHoc0doPUB94vP5Wc/txCrCdNqksB?=
 =?us-ascii?Q?iRbexO7ZcShnf5PwTkMBLlPYxZyL0/Tc+KzEP8mNP1XVJfj4NioEtKnbzmO/?=
 =?us-ascii?Q?JGH61iTmbwaVNvlB+9nIMN+ruHoo0ZHx2fme7hiOpWw6LT+4YllsOhDFByrO?=
 =?us-ascii?Q?yFKhkff99LNgN8NoqkPDnuO7DYD8Tr+DyoK0iBikA7AX0r9O4rz4+VMFcU6h?=
 =?us-ascii?Q?3l4WhNnKKZ9sNiwlf8KWah8xxPkynmU5p952kMbtpxmjMC8cOIKLyIR6SirS?=
 =?us-ascii?Q?Aayb/ll9uaJ1IG3geAENmhOpkxR1R9RfcPDtIW6I/Ymrhip/HSvVcQa/Re/B?=
 =?us-ascii?Q?BTwCEMSmTCDNlYVmFy4USqRurFt6X8zDC1jCmRG0b1SuhcVKJ/g6JYpBTPhY?=
 =?us-ascii?Q?CP1onVP14ETR0DsiI69XoNb1HeB9whUmfEhg+OLhRRTvX5Wn8RtJOLtxF8Tg?=
 =?us-ascii?Q?XczHvQv/T7gbdPAGEBa9tHkjB/WdTG7+PrFObYSg/BooYkTnb6UPHfFL6iu/?=
 =?us-ascii?Q?z21OCygX9a+fqeDL5k5evo93sKlF/Xs0W7lXy2mjQftiUHvJ1qxzByuo+yPN?=
 =?us-ascii?Q?bCpOBnzuAn+M5tB4C2OzpSdxo90JYWcBT37mNmnMq26ou6c2l8OH9IjpjsMZ?=
 =?us-ascii?Q?sG6h53DdtX7be4UnSankTudtnEB0Y+ay9biKwwphmMdT2G8PEKCc4impLzUn?=
 =?us-ascii?Q?RRZDvkKGDFLFNlzJS4GtTV5u4hWpHmsGeLsZujDsJ4RlQpVt3CIZY1sJb+ZX?=
 =?us-ascii?Q?iGCS9q6CkX8QZ5vKu4Ac4DoUbB2j8snVjSa0uRKjXf5ZQ8rVpPX9RXHm5xar?=
 =?us-ascii?Q?aW08j4TtltCeEQO7WK4gh4PUrnoSWRZSV2vAOaGBp0j6kutbB+oZRxLYKvl1?=
 =?us-ascii?Q?LSWWFcVe/QbMOZ8lbhac9l8ssKSqdpKAbHVVsd7l8OGEzz97azc9OmFQDdq8?=
 =?us-ascii?Q?pIKl5eLPJD6LLzw59cg22wsuIoQqJuTcO/zcOwEpSji7UsfUpFJHu5C/qYgI?=
 =?us-ascii?Q?gxoUv+RCyoRpDpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YVJ/Qz6DCFvlpJdPi+17OUi+elaXMxFl6OXbtYizR65TtKvEpNdYz9lodSc?=
 =?us-ascii?Q?EbuODrsP8usDHU9rj/xzRhd5rluOMbKbuZfPq6UFT7K3P+9I0z5iDItKQml5?=
 =?us-ascii?Q?IAoVt9y0N56Ekfldla72wyimOCoooLvVHQdBS05cCgVeOiPUhepEH9gqsaGL?=
 =?us-ascii?Q?cLJRCtmJq3PuGHFg80vjOaTVLcM6cvrvthuAq57RX0nfvSj6uteBs4hD8XOn?=
 =?us-ascii?Q?IS0HLf7xTSNOsurq1jH7Z7+qKJoqGFZ2YVpDi3xN15XGCmGUD4F3bclUBdeG?=
 =?us-ascii?Q?UBAbSplofls7SfteuJDJ2J5q0Ju2C2rxWXF47lf0MWWIMvZysPQqLcFeUXFU?=
 =?us-ascii?Q?eIqC1kZdHQ6PGK5vUqr+753JGNIEEvn07Jex5tRCiaAKMs/m9htLsGLiE9P+?=
 =?us-ascii?Q?qkkK6KkI/NWdWfV2BhQ3TW4X2v8qXot4vpnKAwRTRvfmR4K51WPgKqeeMR7N?=
 =?us-ascii?Q?NlbCHdLI1hW4eV4dTJ86hkNHxqt3RB62ulE2CgLfuD+kQWJvYcKp34aQUJGA?=
 =?us-ascii?Q?Z6TQveNG8CIfwHMiUr0NTUSEPNpWGAAAV8LvXvDbzC+fjZqWjaS5+bgFljgh?=
 =?us-ascii?Q?jP8hH4O9huIInuJDqAhyfqEfgmiw2CH8xNiKqXkP8wnVDkHy8oR13eR9qYI7?=
 =?us-ascii?Q?4k0F6R3M7rHULhHeUUaoGz6PfYp3WuKlX630elfR2WSYYCet+zHicsyTnDx7?=
 =?us-ascii?Q?bKaHCk9Ra8Oq1hMdeJxW1Z3DI3qc1xS/3E3yLCAfkG+YNnTtqoX91aCLVn3e?=
 =?us-ascii?Q?NnXxvPJb+R+LIktn5Ox4MG185UrM5zyeIRLuqpdd913ndv5YzeKWzEfpx0G6?=
 =?us-ascii?Q?SQEMV6U0X8WCpCvLCRpzConvbl0dR4wfkSB0NV4gzAC7LaCPovEeKvx6dtz4?=
 =?us-ascii?Q?UsL9oODa7nhaXGEA2+Gu2Ade/KZsCrN7mBCXaovU4PjiTInzodrJ53+80Qg0?=
 =?us-ascii?Q?3F8x8j7jlUl5n33RArBQoraaQRv/N3Td1slZC0a9qSHEFo9onM7SvDw29EF+?=
 =?us-ascii?Q?DG2+yoe6cF6x2Bx34K/p0Qe2ob+EZjz4hgYACAiBzdwKfYJBkc9h3w+SWC2Q?=
 =?us-ascii?Q?YOhxkauAd9cwMDmO6XvafE+q6G+bA7Khm3fvwKF4aP3RI5GZUJggXm5Mw/FO?=
 =?us-ascii?Q?h6hvxE7afGTQzIE/mQpANxpWQ4fi1vBt4n6GUGM7I/bT065NtLWk0hu/T7YC?=
 =?us-ascii?Q?MrKjU13QZKfES4UnkB2ZjenisnHo5hRcLKvS1yDMfCLOFjSrviGozAeYogG0?=
 =?us-ascii?Q?QLE4ziy6RIOg8hoAp+cZeonshxLffiQuzzP5TXEyMWnVYUVUZycwtDL7N0EF?=
 =?us-ascii?Q?6jsu3w2s9aozxd16XbuhcrAnL32Pdg6INQITxl9HyJFG0u7CiG2Zb9Focspx?=
 =?us-ascii?Q?9hBmOBlIKZVbGTd6w1W+lImqOFXH7w4WGWIwUR+msESCFg4cZIojazVc/aDL?=
 =?us-ascii?Q?KN7YWg5lIjkgYq7YwtmBJ5+yLIU1r4z1z2Z9+Bycd5h30Z/d8Rp/i1BtEUxI?=
 =?us-ascii?Q?W3VQRuFnGr5UtOzqrdtgsTTwUxeu50degCE+mcDT9hr4avDmvJ5ru1wvhjPp?=
 =?us-ascii?Q?lhGicOKwQ7YJdVaqYlDByD8SlWJb3LZyYsM99f73?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d2faf9-1ffa-472c-d57f-08de0d6027cf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:32:57.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1u06syxEaOJRJl0GA/dTQ702xxMPVrsX/1eSiwDFSBw4FWilpKKhv76Ua2K6tzA0ESIox6SHZ3wAPCRRlRNyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

From: Joel Fernandes <joelagnelf@nvidia.com>

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b70a7901..6cf9be6eea49a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -380,8 +380,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -389,6 +387,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.51.0



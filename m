Return-Path: <bpf+bounces-71184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740FBE7D0C
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C16E1D0A
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8742D6E4B;
	Fri, 17 Oct 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKNAEBzn"
X-Original-To: bpf@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D112D7803;
	Fri, 17 Oct 2025 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693589; cv=fail; b=uPJ8YogVM7DwzJpU9YgbQ2JVn3GKW7n1adpSfgFNiVSaEOJqnxjcM4uAMcyHjZbsS60c2ANiy03mUPbe/aRI4d5SslmzfjkQUIThlC2hwpPFuZCDRskMcKyLB+IWYO4gX+6zzh98BdTYXu0iHh9rggAPopKK/hlZY/mBFY3gj6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693589; c=relaxed/simple;
	bh=sUMORa4orT2d/FAGDha4LN3PeFgqadtbGIdf/S/fy9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hf+8RnWV7fNW7aBXz+yY4J9f2jk/SqaXM8zTCWsinjgXB6C0CRt1DlOd/chA7ZqvJPnEe6enKU9AXtTG+cUCohkr3roEgaf9dvq/zM4ZaLo4Qsedo7W44mMgYifoAOL5NWxi0KnhxhVAu6gDv4ySR8JKlSZL79ZZ+Evwun4OBkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKNAEBzn; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPsyuVOmqM8G8Pfm+g8z7rSSnLoMHf6hdcmjViXL3GfW98qSevGArLo7tXK7Zi0oUSh/yRdkIphZx8vP9JaCZfEwu1NNK+xZc2PHm6nnzyx/j24IiBUod1N/Tx+ZgI0gJK0/03detf6HzKo3fZNZHTOvVRWlk23VCB6/J0VCYXWufXgK8EUZRo/cFXghZbuFQUDwtNVwFGsq6dO9NGw2tnFjqemOSGI5j6pXE6IxoHWm12cMwJFI7BGjzGEEk+QZY8D6sw/qpUI7E/CkRw1+Q+lBpjR3W4DHIDxI3iK1TweiTlqs1rug+qSGVaiZmnsm6jMs4pMu5drgyUWDqbO2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNd+xn/toN2oExnwoiU1DtjHBgVGINrWFmCQc2665/M=;
 b=s3npN12nXbgXupUAoYWZ10qh3NTywUXk/X4pyoPg1z6x+lwHGi+Gt00gA15lV0btn+T8RvpzDwZrO+D+O6A24fqL/9xlaJHrnu1cv8K6M6nixdAzTw7Gtm03PDlLIdjpOXkuFJis5TVjncy3QDLWpWbcnD1vrP8JWvU36I+cvA6YQSEAP4zWXWgbMWngk5+MpFFOPktI2AzbR8rdSTmm/ntkMkPSGc2qmfjQhEKprg+9+b/rEVXk5FAQm60s1pJHlR7K81P4SgTmNepr1eFA45CoOuUInX0umKdiZCLb/6pIzGHYm7wf45Ov/7hCQ4mUvwIAh9LxGjpadPjC3VtcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNd+xn/toN2oExnwoiU1DtjHBgVGINrWFmCQc2665/M=;
 b=YKNAEBznWa2etdrQxpNW/oQcIXu9MjQdZ3xGsE/kSymTchPqcjiYARuZ9KTxsiXfv001u5nO2byOD6ERXLlAkORYpkitnOIXB9M7nfsZXd8rXqrOqZMu3NFEPJVe+ei66Vu9wbX/sG/a2jB4C7UpqffmRE1JS5S8SBync2pyk98VuH/RGxXCr6vF47t7stLUi5StBylph9jCxCEjTsNUpzRnh1wp0Bq2/8orxInlOBgvevEt9ttr9Iu6/I17kVRMZK3LiEeoOzGRrTOr9K/sFCl+VJvdsinkDIMOiDfCI17SoseInDhdFGG2w42N4Fe/d0/bAmoKIG7iSamavC/+9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 17 Oct
 2025 09:33:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:05 +0000
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
Subject: [PATCH 02/14] sched/debug: Stop and start server based on if it was active
Date: Fri, 17 Oct 2025 11:25:49 +0200
Message-ID: <20251017093214.70029-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: bd77a771-4c01-4619-4ae3-08de0d602cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tPNfc2XWblici0GvAL57WiGNIQlm9N6iV12LVUELWvY7uuycO3jwwstcVYv9?=
 =?us-ascii?Q?FwnGGl6xxLeNV7z6gB6zqWoYbOg3LhPNRn7yNwvfawsAW8LpTkBbpn9tFZsD?=
 =?us-ascii?Q?XaLEjsKheKXud/62FQN6eWf06CIj5qeKRm883tWllruzjiuoU1ZQLST+ctn/?=
 =?us-ascii?Q?tZnBlBFBeTQ6pre8LoPNdzQciVfSfuzj3m07xaBEB/5ORBDiaIbuH5R+jvYi?=
 =?us-ascii?Q?SR8DO1W4nNefCXrrAeJBAYd5e7fCQsM5PRW4qGj2gxVLQLtseQXXV+6c38x6?=
 =?us-ascii?Q?fM3XsBplZnGSEHLAziyMWDKieCWGCe6EyeQBnNlwuaLNLv2mMNWLZTWrM4qs?=
 =?us-ascii?Q?xM8N7DgudEDAgOhhJv0vRC7ThHlueFufVPAwLl8kOWjPuAwBfXmz9VCBN6XG?=
 =?us-ascii?Q?dG8Y1wo2nf3UIyzezCRp/G5dskagmv0wNmSTKv6DK/0PMAtctHz4rNAKZrKj?=
 =?us-ascii?Q?sz68Ro6wvbUptoxOStQQyCUOl9OzZhey0EBymFwVfj0U8ETqeOFyqVa8Nibd?=
 =?us-ascii?Q?iLJ9F3zcGLncG/oM2iPacWz+yrAQSlyNwLYsOhfiCItfAxrVH8G5cs4YoTYQ?=
 =?us-ascii?Q?0CB8GPw4BkGuXRkETkUXkueEWgl2FEs+oEjUOCuNvRiD7hFiuhGgwj99Heuf?=
 =?us-ascii?Q?/UuufHlSax7kG+AmV5X78FpNKGlecmMCJxBN4RQVXVpXVFxDHN+mlFRDGL7Q?=
 =?us-ascii?Q?LEOlaEe5rz051KIgbJJK7o7Xzd4G6f1QYIJz5Kv7osBnfAGIGvA/sC9cpH1I?=
 =?us-ascii?Q?2/kc4HL9engl49bj/ha+QND1VoHZFOwqQ8PE5cRy4fIUm8Zo5WPP4WiA05Yx?=
 =?us-ascii?Q?bp8n0wv8QyKG+StmgEI9UCy1iajrelxEZ3NDF1g+MQxeYqM/LVs24RwauTmm?=
 =?us-ascii?Q?CCbBNl+qZx0KanS3Zu1Rd/4lwZcGWBANOm5peLOdB8avrlS/FZ4dwG8xNL7v?=
 =?us-ascii?Q?gMrrnKTfw1l+R7O7t+iM+izFDhPq3ECfxzt9AIR12C9l9DM0LaCK3zPT51Be?=
 =?us-ascii?Q?oKhLbs1JtBQt1UWEnCbAOhSNFK1tbjC+QvmcVvESde22ISOxe3E8MNi068IG?=
 =?us-ascii?Q?R4bbNTlt6NzndIaBO1LBj7Iq7MuxCUazoZlVqcEsnN3gpvnjjF39KGojePmG?=
 =?us-ascii?Q?QhIojgSxZGYKyZXpSYIN9gzErPaL/a5svs8+B+excfgpK+Lp1Fd66+KjvCko?=
 =?us-ascii?Q?Bc8pveMRavhhsAJ1oAmNDC74/Y9i0fGVcBE55QQy1ZwLenMp3csAQ1ShtD8V?=
 =?us-ascii?Q?E/k605cbTfv7P+0OeDuWHed5KMhtn1GZUvck/p26bOI1UEgoa1KUvwvWdlqc?=
 =?us-ascii?Q?TRuDyHZPIDKNEdrhdzq42f1bsuIHh3BPXlO+I+PhuIcKJHmhjypiBnMp6/Le?=
 =?us-ascii?Q?GI15v8LHf2LdG3WVjHJxnlICow2NzWbz/pXnxouGjW9tsVtIoFIYqrATlgEM?=
 =?us-ascii?Q?8a51UbKB8EGSiKOhoEqiU3ZqKM8WoBdOLljk+tTzSqNnyldW2COQYEyzv87r?=
 =?us-ascii?Q?Xq0FHAA4DhzNF3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5ssLngBH1aBGYmEn0NMG37YWJu3f4cJD3f+rzimK4JRihfycdWLL92KxUsE?=
 =?us-ascii?Q?FImGnd5DlZ++rJYJFRxt2WLhsVP1kYl/MGF7YVS+h/4fXAGcHCe/x5Qwx9pP?=
 =?us-ascii?Q?NOM11weQLhD2+FDE3WUTyCDGvwFeoRWbXvWFZRSluJECFycp4hyOIOb78Qci?=
 =?us-ascii?Q?Bs/nwJYnaVGcZGs8yH6VglsO701PyGl+pVeF1toMy/1NlkfFnyzJCz1z8oxb?=
 =?us-ascii?Q?FcbZXmWSS9bdq+YR8CzSjNy7Jit2g9a18PyfzRvzdVFYIBBVmgBONszyJJ+v?=
 =?us-ascii?Q?SmgljKt/EXBHgRR3EFw+1WL7GitIZ11+gm8DqjDAe3Z/pX0esE5oygZ/xGsI?=
 =?us-ascii?Q?hr6F4vinR5eLeKKcOAwfMMVtOAU9vDyv2NCOTfxARNyECbS8qkhZyOhBnCLE?=
 =?us-ascii?Q?YlHL79eYXt7B7YmhnSV0PVhiw4Cs2HhbBBJ30x8/sGcHONRTIWocD+Te8KaR?=
 =?us-ascii?Q?2l83fJnPmbVt6oGBrSJ2IcSt+gxZ9G+RaUuJo3Aw10SPDPpaSzYKoxasITW8?=
 =?us-ascii?Q?4PRmyJD7GZDoVlP+Dm4iVSDDQc1/IgttG2d96fA130DIBLOI2WA2pqftdf4a?=
 =?us-ascii?Q?zJyD2ecvr0iOpya3Byq8uLt8MxpxHSeT3LwL60zq7osWi6t73tGpZQs8pOeo?=
 =?us-ascii?Q?9f2FPFx57+/aw0FqV5q3FZibc80vqxJ70onIlZxim5sEZAPziNi0pY6t8+dq?=
 =?us-ascii?Q?a/5Yr/VLwTQH2DGerfhPpUgIkur6xcUttthXqnQ8ocRM6jSyqoo/5VDamHCc?=
 =?us-ascii?Q?gYSl5cuNPxqNEQEWKXMHZsbw5ucmzOF0Wvz3IHt2X34wdsNGtPxH49CxlBsW?=
 =?us-ascii?Q?uZzME7RjKbaFT4nbsE7A6O3YDPn0dixkhwfur8S/1KhHfUbYpCVEN1jvI8+e?=
 =?us-ascii?Q?8JHhzjKBUQj0p1vtJbcb29510MrMmIyCPPcBZPdvVVuS+8Ow5J9iayGSMhHD?=
 =?us-ascii?Q?HSuSeSEroAjao6cNRPtOYjlpzoQdEAUQKLwtAqx3EqVXMwqtHxS6k2pKukDk?=
 =?us-ascii?Q?kxFOmaQfpeNtmAVoCRETmMWUwKwsmIf93vSWm9GN120v9PXfsbtdNqUiRn1j?=
 =?us-ascii?Q?FXTXdLsxHrcQRcy8nqBAQMNhTb1GB0D295LSZ5ZbSAMCQ6NA3MMrwb9z0GDB?=
 =?us-ascii?Q?4pda2GYNLA1dIBm9aMoassr7qWL63KPtrBLQFX9ylxUxqrGe1Dfanko80qGG?=
 =?us-ascii?Q?jWSo50EEj7N76tQTc+J0mpusRQuj6i/QE6N8EA/PeVYbMFI76/7FmzmDyPUp?=
 =?us-ascii?Q?724dW/6ehCPQrAcu1Dg5ubDEZc2csvcP+7OgfDwgtWRbkyTlnyTSfy+N3xzW?=
 =?us-ascii?Q?4NzuE9O2tl/yOOFd0sYM0Dc34mBD+bmPythGPcSwni7IoqcxKt4iijU9BzUu?=
 =?us-ascii?Q?NV9oqiG6gJdN4jbRoC/1n2pApyhWAW/jyTtuUIB9ZS/I0BSs84CaQHA8AYMo?=
 =?us-ascii?Q?4LycxCGPZya2kpWvb8g7SHzfHsx+A9P6lgyxBjDDfOCWr8oXdmYx71/yO9tU?=
 =?us-ascii?Q?WrT1XKpK6CJayZNzPAX/dMsxzfilT3RotNvcDNvu+i/Hb1l4uRYnJO/Yjimh?=
 =?us-ascii?Q?mqku29IQCyuyGLudsKOrrVLMHaXsAhFJhU0V50Zk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd77a771-4c01-4619-4ae3-08de0d602cd5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:05.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxOvS+2lfC/aBaE4st74A0otd9dzAIFgXMFRLDkLiZoikWQFv5HuJmqmrk1GIF4z4PQWmbSjpmNxm9tnClzX0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6cf9be6eea49a..e71f6618c1a6a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		update_rq_clock(rq);
-		dl_server_stop(&rq->fair_server);
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 
@@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.51.0



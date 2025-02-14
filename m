Return-Path: <bpf+bounces-51592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB9A36653
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF6A3B290B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01C1DC070;
	Fri, 14 Feb 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QybbOVze"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6801D8E07;
	Fri, 14 Feb 2025 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562133; cv=fail; b=Y58CDLh7N8N2F0hvoHSxCNm+XrYc4ddzkVscyhr1VKa9KkBKZXjXRJP18MCQz/DoBKbDyOtLLj8xmXrKNc/FyB3dfG48aFpd2Xom707lKQfoPCoK05OvpZmD+KOLKTDDwIOUpuBjyzNXO59sGzjQCYGr8L5S1nFSo78EDrSz7G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562133; c=relaxed/simple;
	bh=CItsehmqbdTccVtapmnGN5dnL03FZ+kLAg26xi1qK9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cf8PN87bCxitTIMQkcMORSCPgM8fGKpQMzDavdBOo1qBftQx+h70p2Ni8Pa0vF0rac+w4PsJh8TVr5fIwniV6yYyP6nJsuZBAx/RI0HAVAo3aNxTTO85HMl/A3graT443WsqDh40+2nuKrW/rG/VRYPaDOigMwkOO0gItkhILIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QybbOVze; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le+/Ch97s24D3MZcCsj109OLScQqUa043gJ75qb4hpjsIJjGqU1jpmJGnlT0Z6lZFcd9aH8n2rpheuPOfVZFrXHgkJpPFZJnqqgxa8tiEwQEjIgMdHcYc+bWDZwWa4gtynU14MWpNLo33I1U6pU+AXWOe8QTH21sTzWZs+tLEVZxHjTGVmZ3E6fG3DQYPp5RhsbJ0Nbv6O5501qUdmdknZorJfFLvWIjEy5wOuI3Q/odQaVl1SbRW0INVa1DJzztykFGt/lFLlrlG2sJ32cbpkrYReMdNiIh9h/Brd7AZy/SX1JlBMvyRYp4ztMLPA9KH2aNI4ubZTjRplrv1IFIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkYo7l1lX54LOJduEAk6T7PRoCqM4p2mBOaSQz+O2Fs=;
 b=xrdoXekAbX2So9WVGNNIXx39A1g7RkTCPQiELmJELDubkW975cj2B0vPPmXiOd9H+4ia9uhip4A2X/VTVVqA3QvLsht/IO+YGUF0h8BMjl153Y38edFIMJO8xjlRYNr3HgjPUmQW3KpSXZWBBAQVpmE8KzvfDu141Bmf6PwjJ/w5AMvcgW68RuSVQ0j78NV9c95UToOWgB8ZmvrxlW8ObtuvPYSQQ7/GG0APmEa0XbnB6RrpXLwN/vwICrpKcbkgPEOB9jHhU24Re3hWgrjehpoOxNU03eZiz0QEdgAm2T3yCkODk3qvGWpYycDYW/shEGFNaENXiMJA90Iicr9fWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkYo7l1lX54LOJduEAk6T7PRoCqM4p2mBOaSQz+O2Fs=;
 b=QybbOVzeXkS+P8Ok0qDaYzfIlZzA6oQu+oXZy7yKjIeJsYrp91Q7LXvAX72jrmAdBEZ5mb4oW7O4EDsBRT1b8IOzLv+7H9g/VEQ7WRf581UTS414O1yicEce4c0SHHJp3HGNV/UkWZWof90S0+Hrs/V4jMuHyI5D5Eg9nDoEme+u8t6HM377xOyc1XQxZtw3F7M2TtShLPTUIA70w4WUQPRmnylgZB0bj1PWP4gQajhFgYr6sMH7+UyKDux6ZzN5qpExj01o+OfVZ+lVi13zIS3MWkJtlfvycAswXyhTZXrUrCU+rNWp/psKFl146HUFDulT1Pj3WFUyZbfQflEs/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 19:42:07 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:42:07 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sched_ext: idle: Make idle static keys private
Date: Fri, 14 Feb 2025 20:40:04 +0100
Message-ID: <20250214194134.658939-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd5258a-0184-4ec7-1716-08dd4d2faa97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UmumLfuZYnpFuytHPVlr14sDllgvY66x9IoptGAriARla5r+hBiMTpT2vjsi?=
 =?us-ascii?Q?6gfgB1ZXOH1Ba3cQFD2BFzvJZIliNNEclu//zxlH+Em/CkXrHGlabGNe4ylF?=
 =?us-ascii?Q?cyAZQkatixje2fDR7e/jYVU8YlZG085EqD9WWdo783qNM5KnMfpEejCArhw+?=
 =?us-ascii?Q?n7FDVVxA+6w5/EPry8u6+dfPJWqKYJQuJUyJ83qpbYw0EGsFavuu3bnjS4LN?=
 =?us-ascii?Q?IROJfXlThlBflhYWwPFuiUWlyd+64FnUoH+s5aRtPmHtR4ubw6+rhKqTATyQ?=
 =?us-ascii?Q?gbDVMRhk9yqa9HZ6rYujI5fn7+s/wBhAGwl47yPFrzb566vTQLDnScPZeyTy?=
 =?us-ascii?Q?+1WcSXg4ef4k0EIGHvUmtTciqVK3YFfl1szJz/wTket3/lEGBdK2TP1QmZq+?=
 =?us-ascii?Q?okZvY9YjZUdUuAfvKThqWFI2MPtEvYIzjVUUWHSAdEyByT+J1kfyp9Bmp938?=
 =?us-ascii?Q?mDwd+kpfFmoK4GhO66isi8N/Y0RT8ZcsSJi0OZAGITilxSK90cZELiSXsx73?=
 =?us-ascii?Q?QtucCPRrC1k9o14FqIvfUkCPDSYoGJbSbo72fPTKMdt7Mixwl6wpojkbEFcc?=
 =?us-ascii?Q?O1uNhjY1uvKmvlB94W1rj7ghpOWrwqyM5NQXjhZy4z3+kdxZBxf1O2ozAC/x?=
 =?us-ascii?Q?A4J/eT7ALnfY3qRTCA3z5pKjeLPXpxElEynosDdV91421TOjTOoZCjGS7p18?=
 =?us-ascii?Q?xBE4nrcJJ/A9L2n6n856kcJnqjWA8cblgkaP7w1f9tYsc0hv07t2DiKiXJ7v?=
 =?us-ascii?Q?TcO/a9vz2u0PDV6JtXeLtfYSVo3/ruCdigNbKszyYC2q2LUalcO23+OIP/ye?=
 =?us-ascii?Q?xqA9iXeolI0c6MX2bciKBhVWamEaqet5VNSoO7gLOgxheiLjZe0znXagoz+w?=
 =?us-ascii?Q?pCpc1wCF3oqc6oTdGkd/7r/R6TOLcJYIJurZonESKUKaE1NAR26W1RgJ6hC8?=
 =?us-ascii?Q?0FhzgC0vo5SvL8oYwcl3fv9uIfQWCYCZMzGWH0S7rKCm67cVh43120iOp4vL?=
 =?us-ascii?Q?hRH0ThUMoDYpHUr+xsZ5Gu+W7xEePgQhVnQg/c9q/p3AGZvWo3Fnsfk3ntaV?=
 =?us-ascii?Q?6HU5NGQmhmTSCN0iegwxtUEhRWOHgSnKJZJl9jjXaQ3XiGUpS8UT1zbF/geJ?=
 =?us-ascii?Q?YnT8/X4jcy2n8IXw/d8ijayFSFz89L6kiOg0MG3ak2ZBIFWqAIm3XTA07kUr?=
 =?us-ascii?Q?WESCXcnb+Gnownf4LxGCzIWVntZ+YraHmx6/yfpYhcw3g1Pjfvmly7aLnN1p?=
 =?us-ascii?Q?X4YVfagOCuhWS5yscgaVcoOcCKce7Y4vUwXqRnjqlKgFkQpAfIRFzg+QwMXy?=
 =?us-ascii?Q?/hPqYAOE640xNnBxcdXx2fv0wbbEr5tLZsBn3qmWsx+575MBUfiFAKmkdPfE?=
 =?us-ascii?Q?VEXypDzOlWLG4Osdpkpc0zrF7pZy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNuIFJusOWomKzmm8iG8p74VX23WZyaVUMJ7RAjm3WHfx8f8FVOz8E5lmkhE?=
 =?us-ascii?Q?TGKCP7ZEW53Sapr3NkI4RtAQtuk+Q7xHu5qflINN03OL33dinPSfG0bl8jmk?=
 =?us-ascii?Q?Bn6cRtljIkkhivPe17drYbO3Md7uR7nll6sVWkZa9/W4W1/qrXDZTza3oiwz?=
 =?us-ascii?Q?4sUZhDBEqfm6726BI8n+gct3+H2TfHFCRsMwmeLNfs+dAVXAV9O3k555gzgE?=
 =?us-ascii?Q?pXvgTmGFvCX7GYoR41DxCs+hL0RImH5OgNw/075AkX5P17F4JYF6yvziqjN5?=
 =?us-ascii?Q?oylwoVHj4mZFKbVpJX4WZE6bc32RgIV23+0H1gE3034hr6G4QXI9aGi8pIQ+?=
 =?us-ascii?Q?cvaAYMDYOQyd1LOjRTkjpi1OSvSsC8Pyb28hfg2eKCa+A6h+nlQAQZ6sGyYR?=
 =?us-ascii?Q?X1RH+E2Svbufg+Xe8W8t4N6i1D/Tk1iCRUoHDLBx2re6R4SQ/ieMFS0wzHMo?=
 =?us-ascii?Q?kKWOppUfAdvKNgtxQrjuP7KKH5FGp/SVyQ3AQ9vVHQ/R5RxgVZqjjwWJ9x39?=
 =?us-ascii?Q?pM0XdKkvfMQ8eEEWgokjPn7uz2amkSMirscqpZRkY7IJxPz+idrb2Ygq0MIw?=
 =?us-ascii?Q?/av7jlsDPsnB1ZbqkpzY4Wd7mrH2bCieZgehLNRsgdDZRaRyC5yeqBSJq5qr?=
 =?us-ascii?Q?hz/AqOnfgTTbSw4IFOoYk5fdB1d/L+5bOTTE6HqUIIfqe5HAZmQ7TWkK+JJz?=
 =?us-ascii?Q?ev/na+SF0s0ExqV9isH289YA78MH5JH5zF7Jo7WKti3y1K8iBzmbBk5FtdrI?=
 =?us-ascii?Q?TgROmhBVVN4oJ6EEM/NeXf5J4RyUnmk5yMNxliL082QS6l16dFsPy1OwYyHg?=
 =?us-ascii?Q?BSStARTTQqJJnBueCXoWd+xNmEf+93CnsKBsQYdcEC1yyCF196pibjS45d8G?=
 =?us-ascii?Q?63BnicFVFHADETnET0eA8tDNAZhjOpfI+iN2EeuGNsgpBgT8inmhXbPTwtV8?=
 =?us-ascii?Q?me41N3X4n6M4235DjMNFy61tevhQHhARjOD9aPMAsDib6m5vLKUpuzQQ9fOR?=
 =?us-ascii?Q?fYCT/2Vbj3kaWfWwx10Zkd5DtIKi0aNt0BCfClAbfVr56hPl/rzzUy7jj35C?=
 =?us-ascii?Q?cW+WX/05Qio6XXs6NpWwkTIvTeBteL6RMpD4OxqC0tcTDuMs1sMX0zNDjUgz?=
 =?us-ascii?Q?DtIBiTmz1t2+P8ZBXTZFnyLi7JO7AjhmwjHCsuxJOD6awD9Y1WHRZB+gfyyk?=
 =?us-ascii?Q?rdBiWgxEHyMuNer8eEuCygRk9OJMqlcysUkMUbcfzvXHUBYXTc5wQMX170z2?=
 =?us-ascii?Q?r05dpoOif88W/4c/yU/pvVP4enZp+7fAYSrjWtAOfGHOaGqjQMgiUqEzDsX8?=
 =?us-ascii?Q?57l6iLkr+2WaTXjpsIfjI0nq72xO0u9gIISZkH7i1jfdxH/j0hr8hSMWIQQE?=
 =?us-ascii?Q?qITX0UYkmIk6760H8rpLMI7b3cKbHW10gZZKM45S4JM0tXs2PNe5vLuf5Bcf?=
 =?us-ascii?Q?Hyd2f8om5YNdGbmwYhtOV/WK9S6mmScVaWZIKv/EN3f6dTKvNE0rNWq4LIjW?=
 =?us-ascii?Q?KgRX7QlCpN1v0At4w3ASAnmtne0h5wATaT6wvhfGsFmnWASVLdzx+nUScfGH?=
 =?us-ascii?Q?W00y94bwiGrrRF/nLIeF8L9TRh2ybhlYkFHiOvxI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd5258a-0184-4ec7-1716-08dd4d2faa97
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:42:07.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1AZuWVTVFnooCxw7AjZnbw23tlefjCcwjAhzd7UmJGZ9YsWH8jLgI6vW/5WCQbHByND7BHweqn0jyDAbMMuhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Make all the static keys used by the idle CPU selection policy private
to ext_idle.c. This avoids unnecessary exposure in headers and improves
code encapsulation.

Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  9 ++-------
 kernel/sched/ext_idle.c | 39 ++++++++++++++++++++++++++-------------
 kernel/sched/ext_idle.h | 12 ++++--------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index aec098efd6fbc..7c17e05ed15b1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4765,7 +4765,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable(&scx_ops_enq_exiting);
 	static_branch_disable(&scx_ops_enq_migration_disabled);
 	static_branch_disable(&scx_ops_cpu_preempt);
-	static_branch_disable(&scx_builtin_idle_enabled);
+	scx_idle_disable();
 	synchronize_rcu();
 
 	if (ei->kind >= SCX_EXIT_ERROR) {
@@ -5403,12 +5403,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
-		scx_idle_reset_masks();
-		static_branch_enable(&scx_builtin_idle_enabled);
-	} else {
-		static_branch_disable(&scx_builtin_idle_enabled);
-	}
+	scx_idle_enable(ops);
 
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index cb981956005b4..ed1804506585b 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -12,7 +12,7 @@
 #include "ext_idle.h"
 
 /* Enable/disable built-in idle CPU selection policy */
-DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -22,10 +22,10 @@ DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 #endif
 
 /* Enable/disable LLC aware optimizations */
-DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
 /* Enable/disable NUMA aware optimizations */
-DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
 static struct {
 	cpumask_var_t cpu;
@@ -441,16 +441,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	return cpu;
 }
 
-void scx_idle_reset_masks(void)
-{
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
-}
-
 void scx_idle_init_masks(void)
 {
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
@@ -532,6 +522,29 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 }
 #endif	/* CONFIG_SMP */
 
+void scx_idle_enable(struct sched_ext_ops *ops)
+{
+	if (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+		static_branch_disable(&scx_builtin_idle_enabled);
+		return;
+	}
+	static_branch_enable(&scx_builtin_idle_enabled);
+
+#ifdef CONFIG_SMP
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	cpumask_copy(idle_masks.cpu, cpu_online_mask);
+	cpumask_copy(idle_masks.smt, cpu_online_mask);
+#endif
+}
+
+void scx_idle_disable(void)
+{
+	static_branch_disable(&scx_builtin_idle_enabled);
+}
+
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 7a13a74815ba7..bbac0fd9a5ddd 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -10,20 +10,15 @@
 #ifndef _KERNEL_SCHED_EXT_IDLE_H
 #define _KERNEL_SCHED_EXT_IDLE_H
 
-extern struct static_key_false scx_builtin_idle_enabled;
+struct sched_ext_ops;
 
 #ifdef CONFIG_SMP
-extern struct static_key_false scx_selcpu_topo_llc;
-extern struct static_key_false scx_selcpu_topo_numa;
-
 void scx_idle_update_selcpu_topology(void);
-void scx_idle_reset_masks(void);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
 s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(void) {}
-static inline void scx_idle_reset_masks(void) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
 static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
@@ -33,7 +28,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flag
 #endif /* CONFIG_SMP */
 
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
-
-extern int scx_idle_init(void);
+void scx_idle_enable(struct sched_ext_ops *ops);
+void scx_idle_disable(void);
+int scx_idle_init(void);
 
 #endif /* _KERNEL_SCHED_EXT_IDLE_H */
-- 
2.48.1



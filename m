Return-Path: <bpf+bounces-67265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2AB41A96
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AD91BA4CA2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397E2F360D;
	Wed,  3 Sep 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LQ1cDnxj"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60F2F2916;
	Wed,  3 Sep 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893052; cv=fail; b=QqS6pbwMz7qj7wFkWJKKQSpHbYzm4orfF/xQd4qDzC4kNK6/EdB3C9lK9iFe9KTsTyF0nOn7tD3idIl2c4rokqcVO17hig6/gqTCE2dCSraxsHLgtMT0lpXxMTbhYsRao2U54KscFaEdL+ayaB36UDPRkzd/zy6iU6yvxX8sD8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893052; c=relaxed/simple;
	bh=tV3JsBIKtpy5s4327y18VGZzgB0OXrOyhm3Qgj4duaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jv0MzRYMcmX+7E6ZWC56KDCz4h4Zykq/2Vp0BD/sF0EtWgjnVG8n9TRGcRYsPpoxuM6TlyvLUzPNv75CmTRLT17EBRps3MBvk+LsDekw6FmeQOgVsW2bEA7z2DxWKtLCpchLWGbc4sNVg6f2nCcrW6CUQQsCfTrNe3UNXoTffn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LQ1cDnxj; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0BQRXOUjY96yZ/7k3BReYZjQKd7Yrmt9OkluWGTx/W9dhjLw8e3Mc17FvdZJHWmJU50iYAp29eN+tQlCOXL+UgnQgcNESyY1ryv3sBHHTlhLlzKNgLNC3rbmW9aicoloo6xXNo2GPTS7WX3kmx/kYWRBnVkbZvt3jG8XShTmuD89PKekLHvRlMxKfaFmN/xgF8+PDxU9GqRKTPxAKIEFODXdxH1kFB6namaHktShFEP9zxVnsI7ULj1QC9XytCli7cjTL1iUvUwNlcA/7kOFa014eh8iOmVyDalvZgyRYvP7y+ro1+XOWUPlyzuS5aQPgCEoEAqWwbxlEHs9qn4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbEiaeMNYrjH0JBkdsB0ERyFg4MyLtj10cpn0M6fzPI=;
 b=ZDe6GDxGhuahcUdiPpP8vc8sBhUNOP09euuKV4EDCiwRLDlVanBjpOXFZuZwHXkIscoCNnmHPrNvii1Oh003dsR96afUgIyXyQxwz/RDKBumfzwLQzTaWfLgGVcZsDq8veKh55nTzGnK6DaNAX8AFJTC/NVKow0iENPCUpkrinFHgHW7z5hn3BGq6jK8EKLB5xOvX4I7G9lhXe2pEP6VFTTzJSMxNpYPnygz95rwJjLzRZaODtHOFCWo4c3My16ZFYBH3EEOXuahVJKb+y7qeKj6PNuy0ozj9IiVExZLY+IaqMvpyLqFX57Pcnm5ZG57U55pknak17j8NhMeRooO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbEiaeMNYrjH0JBkdsB0ERyFg4MyLtj10cpn0M6fzPI=;
 b=LQ1cDnxj50sSDQYmiNeidHHBKH9i1Dd8Rhrc0kcesCb1um849htXVl55z1PZIPxgBGuUAgT95Jl7BXUCSm3QEDxpiB5febMDG/AKUxG7YybMsyFy6AcyR53bvibX1f6RyY/1MKQUXl1AuFfS2zR6+LFPgW9uZ46nxK5oXJiUUyWPbpYGEimxl1WZOmYQCNtUNFXEusMDnyUtN6cTA8vFCiL8dLniok3ZdW9XvC0jUue1WAND6c+SEslnHOCRweIgTQUc3oAZZVDwWILVdLFATG+yM+OZKr4v5JiJFQKTREMvC5tdxplJDeAEOufOphulTuNxRSFN4WBOFqHjmEe7qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:48 +0000
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
Subject: [PATCH 08/16] sched/debug: Add support to change sched_ext server params
Date: Wed,  3 Sep 2025 11:33:34 +0200
Message-ID: <20250903095008.162049-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f57633-3944-4b75-9976-08ddeacf5c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDJjfnP/ev1bFJH2JjN+lZTpRiT0PgukcoobXFQf/Dd+xo9dcZ/+F/OFbufN?=
 =?us-ascii?Q?32DfkVMS4nEzg1WcIP23HJecUcSQRXYFeMKzQydQ0ljljWI9B3em4UDH/yiX?=
 =?us-ascii?Q?u7TywmPGsLz3smlMy1OgBguq2mn8nEF3XRIUVe+GiUecbQ+foZU66KQDh++a?=
 =?us-ascii?Q?l8mO/flPZAXRmJc/ZbfZWqjWpl9u4yY+kQXzn4S+kbXvWFjB6O+FUyrPWbvm?=
 =?us-ascii?Q?rmg4fBuFacWO3bSZH5jSMe5yRp4Cb9jzJMeoWZ2Z9MBQAodcFFKQkS4FSob1?=
 =?us-ascii?Q?c19TWlgL2aai1/C/Z55MdmPCYa9g4VwRP9yOqWNErXjB+w8Sh7LzypjcDJwg?=
 =?us-ascii?Q?djtZs+D7CrqW53Rp6M3XwAIpoTo/HHBiTq617fJpm6KtzL4Z2fumSuZfrR6R?=
 =?us-ascii?Q?GEDqenpI1xwyIXy1ETX8HwGq3Ok6uSziexVHwShBdcTmTu5gd1w3c7LvESsH?=
 =?us-ascii?Q?A+xmC0fTYo9LCJ8xJCQ7KV2l9jlYT6JHKN/U2DGzE8n0rvgXEkREcTUvo092?=
 =?us-ascii?Q?kgBIgaUlVWPIaRTOfsBaXoRc8jhRtgJ5I8NMBSqQmYif0NNIjHXiZfdt4S9G?=
 =?us-ascii?Q?7bZj9/xzyIUfjWqnXar6OS8NEGEJlMr5CR7jLfnSsPIRwYNf7XcivYs59M/S?=
 =?us-ascii?Q?9AmT+UCO8ikcCuEQWF2GbQld2RJwZ/WYC96qNnqbWrBVRtEEeUhVyOOU/KnO?=
 =?us-ascii?Q?X6r2cMlpaiQYjF8WfQeiWAMWnOn2SNtcFIWG41bBy0bFzvOL1eiz4J0rzz/X?=
 =?us-ascii?Q?2EW5ITatDDoRixtqCxT6e2TmENa/bnv0lWDuu+sKTRb32B3d51nouM9lg2YL?=
 =?us-ascii?Q?uxbJFxbw6j35nw5OFir+/0pIYb/+gwYdko+NBKaB7iiJ26JSy04XnDfNWppa?=
 =?us-ascii?Q?1d8v8xb9UkmYHl3oQbEGLv0lt7SLSc6p4buMPPHFkq4oULzB2d46aNYBvPoy?=
 =?us-ascii?Q?tLIZNL0GXVgzdINyOVoXarHiyd4bvRdhy6YXMjaxpE9OF19UGFph+6tJsAS8?=
 =?us-ascii?Q?gmb4k6Ie7JkAa9X9tY4HtCON3rI/+1chZxqoJ25cgvJ9XvWmn+piLarf39dA?=
 =?us-ascii?Q?x4/149oioeCOMIDTe4FwD6lejXEplgKksWOt/GNgwh7E5aefwKo3P5IXh8L+?=
 =?us-ascii?Q?OJzRa4T7HSZchNhL1hCVfYfoQDyErTNSpyJCl21rLYaKqxYq4YtLvieLcvUu?=
 =?us-ascii?Q?06+rtweQWuNXHX2QzEWodcYtaRNsVRwy5j04sO2eRCFrmink2BOMKsXuGxE4?=
 =?us-ascii?Q?TLZ9Nu4J1kVHYCuqUhbgWQ8FI+xeV0jt0JUOMIAP/FfjxtPyDtQ5Pa3+OQN/?=
 =?us-ascii?Q?koeR0rIokhGdSW6XFQTfFeYjOyHNtSbVBylXShrdC/tCUj8oJB8QkA49bpLH?=
 =?us-ascii?Q?TqvOn0zlWJ6iiRJckW6K5WM+XQtz9vd0ncDwRrsZJc6O0w2j/5Ax+TBHLnsC?=
 =?us-ascii?Q?FCwhM3YPwScTDGa3OSLrUVQy7jV8KNZcH44amH86QWpVcfJnJ/U5pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDOL7PP0FIl5PDnfMX3McE9x0dWvYED7u5nIzmreS7I4kmEDIdIJxjAg8FWZ?=
 =?us-ascii?Q?RnTex4IXW5pNsDHM5n5QRqdZSm5HP9mDtp6yMmp8oyov2QpMsh+IObjn9lHd?=
 =?us-ascii?Q?4fxE0fgzVpTiJYHNWmm/xRm0TfOV9MZha7Fu3KFcD3n2Oun15dDhys9X7CKt?=
 =?us-ascii?Q?p5V4bt95YOPX8GSCdyXXB0hZAU7vMYeed4TfieqJb/gG31pxghEmEx8idRM6?=
 =?us-ascii?Q?26Pw7xufrTSZdI5rGa5Oy0iEKDRuLYoxl5ZgH55/DyC+ymAuLwxA0MQ8Inwf?=
 =?us-ascii?Q?sSyg30M3DCcy0WlhfQoH/tFFwfhV50T/UTuP+EN9e++oP5SxPd5vj1aDbF07?=
 =?us-ascii?Q?KrFhaoOX2sx1JEqIOnimyRp+5IN1ZRw8tVUyMxsRVvaHu3lopFw++DFxepMH?=
 =?us-ascii?Q?ojHDJaqkCPt8JsEafsnTKKuMQkP7Rlwnsq79CS0auHFp4PreVOKA7kNmzNoy?=
 =?us-ascii?Q?ipjK3/y2DhszryaLeFiM5OQ8lPIIRE3EPJdcju/x65AIxt/M9J4U/cSqUzsv?=
 =?us-ascii?Q?FhCJGQzfZyn54btPRCJ6NJ2cb6Q5IMPZhIBy1tZk/M68m2q4ZyrXJZtxcITm?=
 =?us-ascii?Q?Hm7JrvB2TpZJfTy7Jtb7w+jQsZjUO/2u7pcTh1CkOsMymP8Ih3dZP9vdndrv?=
 =?us-ascii?Q?pHGtjQPPBdEIL/cO7cB9TqymkEwYN8P7csSTmUITF0OCShVm06H/RPuGDFZ3?=
 =?us-ascii?Q?MAE/vCBFQzLN+SNCTFHvTXsNj8IzPUFSnnBTdK44DJk//b/+30hppLwSCDXR?=
 =?us-ascii?Q?SfGnL9bk+262HgnSaZY1O3+s6gZqaQKEnoAibCMauAM/Wri4NQiZTYEzMD8j?=
 =?us-ascii?Q?bswMrMRh/AwdvcTa16ClEq+JFjAw5BHG/kTXh03RDM3vDR77bxYKZm9rRPL+?=
 =?us-ascii?Q?JT7l7IDchUTZtfRwWvHKckyr5YNYizKN7xWSmEbCrkakT75tE30v1dNi05r+?=
 =?us-ascii?Q?uE0NWVkjpdN1/7fHIyF4qxnraZCkJryqyLkdnx2nuBASBEf9Zrv8Bv4Gj+Sb?=
 =?us-ascii?Q?nOCc9bMTLXpNHl0+/aX3+oGhbvB7Fn22RIQ+5NU/XWsv4grz2i1pw3jlPIt+?=
 =?us-ascii?Q?lDTgl58F6XOypT60+qXILcQfMIup24353Reha5twPbib9sgv0qmgrXKCoEPr?=
 =?us-ascii?Q?tIs7E7rwsURuI507joVxoz2fuAgXwVgtdZAAaGX+Q5GWbJreVm26FtrblC0l?=
 =?us-ascii?Q?woCOB/o6kjJvs+BKbqQO1lAao9G1jxl9HkbUn6/s3m7RHYpGym6Uo8L1fdrJ?=
 =?us-ascii?Q?bqQOTdvEvs2nzJBTKyAP3iXbFEMRNZPVDaI/CLR5NH8FpVxcdBxsSD40EG/U?=
 =?us-ascii?Q?3oEwdmfmpPS6gD0+jxEKqAq6VkNPKPsqHjSIQMQYZhNZyJZOGYKwj5Vxr8J2?=
 =?us-ascii?Q?Uf1g24OD74J6Jl4YNgigYdBffjCGiz+Drgk5CTcQqbfMUpG4Ma/jxho9eFWI?=
 =?us-ascii?Q?1tt0j9CGSayfCH0G9kDS0lNDI57gtHL4v0HpGtyEnbb1LR4G8U7PFRyU3GfV?=
 =?us-ascii?Q?xEqPl6Il/EI8MaNWlfeU9Sp1a7WChAd7GagOBizIAZkokg7wDiTQuxpO8LBZ?=
 =?us-ascii?Q?uSCQZ6SyOQrsFcvOsN/PfqdIc7dHUUSwUlrd4T/M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f57633-3944-4b75-9976-08ddeacf5c37
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:48.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl6H8TBm+F5OBGw89kT6G6iA6M0aqWxynmF3AZYRBitvNBEdqfBie7cLmRpr9YdJrQ8eRDFOvXoYFwLmud4oUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

When a sched_ext server is loaded, tasks in CFS are converted to run in
sched_ext class. Add support to modify the ext server parameters similar
to how the fair server parameters are modified.

Re-use common code between ext and fair servers as needed.

[ arighi: Use dl_se->dl_server to determine if dl_se is a DL server, as
          suggested by PeterZ. ]

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 149 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 125 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e71f6618c1a6a..00ad35b812f76 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,55 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +518,38 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +573,27 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +632,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+	debugfs_ext_server_init();
 
 	return 0;
 }
-- 
2.51.0



Return-Path: <bpf+bounces-67271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A97B41AA4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7301BA5628
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC52F6585;
	Wed,  3 Sep 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EY40KgJg"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069242E8DF2;
	Wed,  3 Sep 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893074; cv=fail; b=uBXBZD9/6i5PfqMDCOvMFjfJceimZUCHO6wdot/ex0t6UhxGRLkRQDYmw0kC8fcsWFRoPRNqqFeVfEmlhK+8+7/Juji6VGncqTLZPVcNNir1nJ3xDt79etfzQX5n7w17zeWi9XYKwuG7Y1vEbSMRsugHqqVQyXjaz+uF6R0r9lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893074; c=relaxed/simple;
	bh=KLEoIEePb+YN+ceLEDKACaXwPm9fuZ0R2vL6cPapioo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8JLeZN+YqO2KFaCTpSQlpH/CYhuaKkU5vswRae7UU9oEfq0Nfj8uPhGpg1z39jdwxAXx5TMhhFDl5fZr94QdF5gTp0Rpg+t84dGVUGCIP35/0pn85g0vr7t+VJ1GEMuE3pH1dCpdlrMutKAiian7o5s+PFbHUyn09y/lsgmH7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EY40KgJg; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDIM2b3m3zUer7GDjoJVVxKx2foC4nLkN1vg32eWjiaz22qbNr/GsOyVLEVPuEvHtlLVKfNbUE5Fosrsy5/7UAyWCWiMYVT6O8iSj90LEli71Rcpu+7dLBT8e05JVlq6LDVAibj5AFMYhIZUSYmyk5ckbqJWKt/eVpjygTQOfAP8WNhbN6zWHyCKdCyTzgLZCbxruoLo7cKEU2r5R4EnCbzkkz//bLpPyvfuKkRHIqfQ/e/288NW6Jf8tpiswVL+DypgfqMT+KWJEmyuCrmrQ12Yy8sm4jp/7o6B51Tqlu8l0jv0dWjbtEHv7rlRtacKjeQPffIZmOQpjgm+YDqT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzVsd/81OziSfeB4qEmjBaxw+cliGbpsF/oRhyugYaE=;
 b=qt6llXZJv/sENXfdZ1E77OrRrOb+E5lzZJ+3o4cXD3a0K0SXgen2YcGKGOJOSWpXtL4ckp5ZGTvBr9SmTlcbMaZ95Zkfs3Ir/mg2NrHB9tiR1+dfPjYj8KHWbclss4dFW7gF1gIHIrIPowgUg/+moNe7BsxrbzFxLxpEMw7fjU6VwqhfPNi8KJkaoWBisWRgl1MToONGFh0RcxedDa9igKLzTZGQlNhYH523PF7leGNsv8JKHtzxkjgMms2oaoYgW5PA090S/xWbnLYxTmh6+NEJfWjcAhgpEiDsbts40luD0rNZ2odpZSfTW5R2PyUrHcba8ULhIh6GVfzu/3SzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzVsd/81OziSfeB4qEmjBaxw+cliGbpsF/oRhyugYaE=;
 b=EY40KgJgJBqZZB9pcwMZtUT6YvG+0dC2/PrFpYyDNeHFFkxDNIOeTgo00dQbPsNvtw8IcwRy09IBAQlgTnolOuZ1GflSXGTU/OLhw4AW+4Vt7o9m26s9QxkXKxXNg9fxG57hzDKColiLOp7XKLq31sxZWE3SdnlscMzj/f/nUH+qPpBV2CoOABGUhw+Ys91HaIRAsB2UF0XA4j0EsdH1pgGYe9VSYupSMQF/J9bOqA3eiIREHRhaOh0qcZBSJaCUIbzepdRef30ritBRgVA6Rh+Qbf/H6y0yK4PUgpsjPwK8UzivcX6eWGUvBtWrhoIarcBOgBFqpJso4W9r9qhzsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:51:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:51:10 +0000
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
Subject: [PATCH 14/16] sched/deadline: De-couple balance and pick_task
Date: Wed,  3 Sep 2025 11:33:40 +0200
Message-ID: <20250903095008.162049-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: f93662d2-31a6-4f8b-1b16-08ddeacf6900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dc5BEVRySlsD6GVXZoXKo8dYeF8qrZaby+VQ35Zd0y1cPy4lTZES2wu9xYs?=
 =?us-ascii?Q?pf5qmiP/9AAapi0DKG0qL//K7FsIsFa/B2YlpsEw5AICQqY8r2vJ0KU9KJ9y?=
 =?us-ascii?Q?C3iHok4p1DxNVvJOuOeA/m0C4MUZqgEz4Jj5CgOIuNEWGa+5VacK8sljT7+3?=
 =?us-ascii?Q?MBMfs2+Vgx4FeT1y/FlzbOGwMfLsvatjPpW+3K1kPreYPoPgkx4vF1foyODe?=
 =?us-ascii?Q?K6p2QsucOLdNk+wjbjMX4WbAzn8Xz76o8dugoOpTE2k2izxrvC/tFfyQDIft?=
 =?us-ascii?Q?zlAf2KhyKv+IPHxS10sd6ouCMtHbnJrwPZ3OCYBfK9GZTqkJ7ywul5EcMm2e?=
 =?us-ascii?Q?PYhYNfBJGS9AHboaLp0j6Pqa029Wu6Tt9f1Y1+hZ3zw01ux/sNPumMDou3kf?=
 =?us-ascii?Q?khF/aS9EEoWsnqd1hOYt1hVUxcQbzvfNQOeqRak34blhHR6/a1SxLUJ0YIJ7?=
 =?us-ascii?Q?uKP4LUx4mYYeWstJGUH9wqHAOeihSIoo+FTPw2KQIxUgwnCjCpPIunEzu1/7?=
 =?us-ascii?Q?S53AC1+/n98wZHiVVTvBJd5767N+z/DAeubVjJ9HZ0/ha/U5L56MBEMcPLQv?=
 =?us-ascii?Q?hzQc6JjHA+aKXvJ4ystZsQFd705Dd3bAlvhrWS+MmCP2qoFR7jlN8K/HqVtR?=
 =?us-ascii?Q?9aDYeR0NZtKVSQzQuSsvvUbKcs9EcJcwhjwjeGqeiz1hFWAqFVo9eH6Xh+i/?=
 =?us-ascii?Q?mhX3dmlBYkZY3JnF6fLoRVIIN5pdUEme4WFI87CGuyVtcuE7SVy71HUTV7vm?=
 =?us-ascii?Q?PgnRQ4AD8uzNP6pW6sj/QtowUOYwIJ3kuPL7/P3GKMp67mZ/6V4QluDBCHCb?=
 =?us-ascii?Q?a5sgyyIdn2qJ/Nb/rNJvHZvV91AlN+KFbh1N/bpTKv0NtVGKZiumgoOLe/vw?=
 =?us-ascii?Q?Nc3sx6UiOPdnudT83tA+bDKbGJnyB0WB4M29XmGPDMRnDtqi7womrLXWarKo?=
 =?us-ascii?Q?/rYn51/Bwoox/RJn5w0x2Z1KqP8ndrLaHH1I4EzxqoNZgImsZLqfcqV8T1zB?=
 =?us-ascii?Q?Hyp8OvWkPc+LFxJrvu6tgKDMOTTjnE/AMYRYg/D/BFHlDg0tjY60nW2ankXj?=
 =?us-ascii?Q?SOARp9RFGKCdihugIGtECBLFA1LegqYq25SdUHPevNYWuW3famrkUEVGjkSh?=
 =?us-ascii?Q?EoIMIYEokKWbFbW2GmXPZ1f7dC9j4ITKnrQ6Xh1EBa1DI65lKXreio3SoNVE?=
 =?us-ascii?Q?OoZIpasoAr/8WdZPHYoiPcqR9jYx1mFccSboq8GdTofWvUirWEZG0zZnBCtk?=
 =?us-ascii?Q?u27U8sucY7AJ4p6gCW0JJXv+M0oAYWg/erluPeBVbCfH+sx0kQRfqBa2FGhz?=
 =?us-ascii?Q?oL22JGNU1NDdcfBAtnWgnzOqiIUCQISxNu2GTk2UUepNfNqZ+lA1pbSgeK+n?=
 =?us-ascii?Q?wLb3B9A56WfQow+j2YW2BpOsUZd7oeRj73gGYRe1Qn9DHO0ofA6CJhymu3Gm?=
 =?us-ascii?Q?kgkN+uPbpIujOoANwhHM8jjhzB33+MiuM1G4Xu8kjVjrMLYor1Dcyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/ywSX0eZpGNyGPMPOkp9dzt+vqojWewvNzp0ZhNOUkZGt/bfZi2JH+Anu/6?=
 =?us-ascii?Q?HW5RA54o9rlScT/AN+hYn5OLHyvuzAVPOvp2WEm1gSV3FFV0a+aZApoAZwOG?=
 =?us-ascii?Q?AwG862ZbO1pySiHXafiQ+KaVqS4TAq+OzCqZhDqRY3Hm/IVKeVN2gNba+kdx?=
 =?us-ascii?Q?mR3ZMczsI8QZEKq+UhlWLSW23fATbZPxMfjxWEjuQw3QYRN884jA16+vJAn+?=
 =?us-ascii?Q?afDC2YD9DFWMpd658bB15f3rYZ17pNN/6YEL5wM7iFWRTqkUnjmwvLWh196x?=
 =?us-ascii?Q?0x7DnzkDgRgiMjLPV7rsl85Ww/zHm7sDim1deUaj8QD5V3o1CsPFoABlmzYI?=
 =?us-ascii?Q?48r9F/s/aCc50QnFw2gjV8fSCfe8A/Hxm4iI01DPWEhXHl1I2/MNnXwhMorL?=
 =?us-ascii?Q?8uDDcK7QEnnzBiFDAdiICICQHGSIT04xYTdBofkQ3sDx4B6qZFGc3YUkYcSv?=
 =?us-ascii?Q?V8QlqNCvHkSecivhH6KjAt14KpRcy99XxhPSQDByWIEs4grSkEUB9tNPS5ET?=
 =?us-ascii?Q?qXlx/8MjuZ/FkXANJOUezgBdOxNe//AhNdJyIo9qPWd9sLzdrJS7Q5d5Cq/D?=
 =?us-ascii?Q?LVG2IePl8MgGovdfnJ5Ns0PxbhagK9/AROa0fqzZIcGnXE6d5HRCcdJ6Pmo1?=
 =?us-ascii?Q?zgrYRiagxdKx330cWrhWd78iWgM6g7lKPlmy55qZ9lwdGuWDUUTJWXjapXk5?=
 =?us-ascii?Q?aRS9qaYtMDQCTCnWDKLfIjliQ1I4SnkeDGIKnOX5k2H7EuJEjknETP+fD8ns?=
 =?us-ascii?Q?9RatWhdAaWEgS0neN/xdJJngAVW21YVn6b2OMW6eJRL9V5Bl+khFig8dg/v4?=
 =?us-ascii?Q?TkYKTk/Pv5AMxb7Wo49YZt9ATGxJHBHD0kkgYxTkPshv/qaOmdIaIS5qdtUA?=
 =?us-ascii?Q?9a8SbKisyrQStgGOu47XPkN6h0LULB1Tq08r/GlmuYJPpWjOPVLOH53dBWjc?=
 =?us-ascii?Q?eZyIdPO6ak3RFJANxGkzDLBMYDKYqf5BM2dS1lKJ9Bu1bxwuDFFZ8bTNQYwL?=
 =?us-ascii?Q?v6fiRI8RHX+kAhXY0AvpMYoCVon8k4t++uPDyJ4iqTS7rof0whGeNDbaSPoe?=
 =?us-ascii?Q?FXvl/CCj6RrHlfgOlangFr+wjrJ1MlDRivwXZihPJm2YhZH39ERLHW/Fhclo?=
 =?us-ascii?Q?dTPGuYimVsX2ST7jDJwHRsGM0lgnjDccyO/HnvYRCIGCABiSH1xATDp53EMQ?=
 =?us-ascii?Q?A+9fGZNFpSnDcrVHXkvOZxFZ2L/+ImZ2cTIl1DHAuazz41gZHytsB4m47+KR?=
 =?us-ascii?Q?PJBoMsDvy4Eq872Jzw+TIoak7B1KwwCo1kJueIq4sjcEfQrt6IuAbv2UpFI9?=
 =?us-ascii?Q?CkqUPuHzPs90IL9JBZCmqQvjVP+QMxzAFHgni1Gyxr5uWUgcOaBzlTdABbPu?=
 =?us-ascii?Q?LAVO/9leA+4pmxsJHpJBfbMK72OWOOQ6AscdM9v9pMVucCGj04RBxSosVP8e?=
 =?us-ascii?Q?hiuvU/7b5kr0bSZq/WkqlVg5A6NyChzAQ9U6jGz9udQhYiE8D/KKjZu4GXGT?=
 =?us-ascii?Q?OqBwZPh98hbk2eu8qeO7Gopu9P2Oay0fpApZYdfgTfRV4qSeznb829ssJmOM?=
 =?us-ascii?Q?I5m4SCSOliIHimpqeFMF6YE5sPbD6Y1zV2G6ygMz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93662d2-31a6-4f8b-1b16-08ddeacf6900
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:51:10.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pADNzezwDC10pIKCkmwbBrEIUWKu1TZIoQuofQ6q6nLxeaazXuAkJ34S9P/nm4mZW3Q+DYxPxdlAyX/aZI3bnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Tejun Heo <tj@kernel.org>

Allow a dl_server to trigger ->balance() from balance_dl() for sched
classes that are always expecting a ->balance() call before
->pick_task(), e.g. sched_ext.

[ arighi:
    - adjust patch after dropping @rf from pick_task()
    - update dl_server_init() to take an additional @balance parameter
    - activate DL server balance only if there's any pending work ]

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched.h   |  2 ++
 kernel/sched/core.c     | 14 +++++++++++---
 kernel/sched/deadline.c | 16 ++++++++++------
 kernel/sched/ext.c      | 17 ++++++++++-------
 kernel/sched/fair.c     |  2 +-
 kernel/sched/sched.h    |  8 +++++++-
 6 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b272382673d6..aa3ae42da51a9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -635,6 +635,7 @@ struct sched_rt_entity {
 } __randomize_layout;
 
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
+typedef void (*dl_server_balance_f)(struct sched_dl_entity *, void *);
 typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
 
 struct sched_dl_entity {
@@ -734,6 +735,7 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
+	dl_server_balance_f		server_balance;
 	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1a7ad7e560fb..3c2863d961f38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5950,14 +5950,22 @@ static void prev_balance(struct rq *rq, struct task_struct *prev,
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	/*
-	 * SCX requires a balance() call before every pick_task() including when
-	 * waking up from SCHED_IDLE. If @start_class is below SCX, start from
-	 * SCX instead. Also, set a flag to detect missing balance() call.
+	 * SCX requires a balance() call before every pick_task() including
+	 * when waking up from SCHED_IDLE.
+	 *
+	 * If @start_class is below SCX, start balancing from SCX. If the
+	 * DL server has any pending work, start from the DL class instead.
+	 * This ensures the DL server is given a chance to trigger its own
+	 * balance() pass on every prev_balance() invocation.
+	 *
+	 * Also, set a flag to detect missing balance() call.
 	 */
 	if (scx_enabled()) {
 		rq->scx.flags |= SCX_RQ_BAL_PENDING;
 		if (sched_class_above(&ext_sched_class, start_class))
 			start_class = &ext_sched_class;
+		if (on_dl_rq(&rq->ext_server))
+			start_class = &dl_sched_class;
 	}
 #endif
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 84c7172ee805c..1f79b1e49b49c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -88,11 +88,6 @@ static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
 	return &rq_of_dl_se(dl_se)->dl;
 }
 
-static inline int on_dl_rq(struct sched_dl_entity *dl_se)
-{
-	return !RB_EMPTY_NODE(&dl_se->rb_node);
-}
-
 #ifdef CONFIG_RT_MUTEXES
 static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
 {
@@ -1650,11 +1645,13 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick_task)
+		    dl_server_pick_f pick_task,
+		    dl_server_balance_f balance)
 {
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
 	dl_se->server_pick_task = pick_task;
+	dl_se->server_balance = balance;
 }
 
 void sched_init_dl_servers(void)
@@ -2349,8 +2346,12 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	resched_curr(rq);
 }
 
+static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq);
+
 static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
+	struct sched_dl_entity *dl_se;
+
 	if (!on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
 		/*
 		 * This is OK, because current is on_cpu, which avoids it being
@@ -2363,6 +2364,9 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 		rq_repin_lock(rq, rf);
 	}
 
+	dl_se = pick_next_dl_entity(&rq->dl);
+	if (dl_se && dl_server(dl_se) && dl_se->server_balance)
+		dl_se->server_balance(dl_se, rf);
 	return sched_stop_runnable(rq) || sched_dl_runnable(rq);
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 69163927a29cd..e6d84b9aa70dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7715,16 +7715,19 @@ static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->scx.nr_running;
 }
 
-/*
- * Select the next task to run from the ext scheduling class.
- */
-static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
-						void *flags)
+static void ext_server_balance(struct sched_dl_entity *dl_se, void *flags)
 {
 	struct rq_flags *rf = flags;
 
 	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
-	return pick_task_scx(dl_se->rq, rf);
+}
+
+/*
+ * Select the next task to run from the ext scheduling class.
+ */
+static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se)
+{
+	return pick_task_scx(dl_se->rq);
 }
 
 /*
@@ -7736,7 +7739,7 @@ void ext_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
+	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task, ext_server_balance);
 }
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7573baca9a85a..0c16944d43db8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8875,7 +8875,7 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task, NULL);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1fbf4ffbcb208..a8615bdd6bdfa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -384,7 +384,8 @@ extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick_task);
+		    dl_server_pick_f pick_task,
+		    dl_server_balance_f balance);
 extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
@@ -403,6 +404,11 @@ static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 	return dl_se->dl_server_active;
 }
 
+static inline int on_dl_rq(struct sched_dl_entity *dl_se)
+{
+	return !RB_EMPTY_NODE(&dl_se->rb_node);
+}
+
 #ifdef CONFIG_CGROUP_SCHED
 
 extern struct list_head task_groups;
-- 
2.51.0



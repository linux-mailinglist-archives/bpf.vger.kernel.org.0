Return-Path: <bpf+bounces-67264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD6B41A97
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470B6547067
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D32E0412;
	Wed,  3 Sep 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7uyiut3"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717662D94AF;
	Wed,  3 Sep 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893050; cv=fail; b=VwjN4NRso5bZCkd1+Ac/YIJJnd7+3bp2uzLZLDLA5KhHLPj6HJid8JxkiGyAY4M0fLMtLT0ydmmDGzRwJMQqw/Et5juZZoONDOzYjjucCNxiDhJ7BS5EzavjxFBFhh/OUcWX4H/AJJPQT0C62+wOWCfLSK+dRMz/Obr29G8G8Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893050; c=relaxed/simple;
	bh=V/fvRZLw3aN0cQZq8c+kEUJI7IBixUbReWMGH6RngqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SN+JTuYvBqhRenQcGF/i3nUbEwNiUB4AUkslBhtVLbt+tv6SZUj8asi/hFqDtO/YV2O6QQW3G+ZDnho65+mqoDTOnfTN80ki4Z8VfHCjW900HHc0HDcnmEfm+HmVRF7vRXbVPNQssiXqql1pFvuSLwlyIpvY8DwNl0bNqqEOJYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7uyiut3; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udnb5nhp/NP6e5RvvToUvoRB1wZ3/p4NbZWJ+pw1CIXIaKP1gAGg3nN7xpyAu4xD7hQsrlb9zeb5fQnuIjZQ8NgesPxgU37ksVNdfzC3yp6YoxDgn17qHdWIYDWS3pHgb1fYR6bAR4jyfSg+vY5L58fSZLhUkIWGhsz/Kr1Ro+xc9SGetjwLBg1X4U5BnYdSdHVkCU48wKF57GvRd59+jgDoqAp+8qN8KVORRm8wzP9I//FuECSxTc139p97F7+Aiu7tJO4IyPR5tTuimLyVRP4KQccqTJ0FQJHL3mSHv1gEURy0z/Fx6S0JqLiztcyEjdHaF46I0M2lLPOGOKQjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOA3RvMmorU/wd/jNt3HwoD51AQJz62CZyLoSnfSNds=;
 b=tEut8w4HDpTZqzGD46BnFtBuTH6XnhhmebahWeYCLHqnvvXZgIrzVHG5stvjedwWjm8jrJOwvUDh0OC3ho2PQO0sgWNWLec1nmrFiRX8CjKIXn6Do3JCV8sQ5oFuISV/oDTNIJ9ianCJ36T/8+16pC/i4XrSA2Iz0+ZwHgsj3UWOAj+3ftUgzcEPksba7hg07oIsidAJ4YGpoMoRLgw7VmNexciJLjr3C9RSZlaY0nVb5xJFGUAgOVaXyfILk3s1YAnjhagdHt2ZeDJugHmtg4T4qb2MTcnL4lJB4/G5Rzxa+NDoOcbx9NohzEa77eakQdmqZxiKyS54kUj/eOD9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOA3RvMmorU/wd/jNt3HwoD51AQJz62CZyLoSnfSNds=;
 b=D7uyiut3rBwz3fGZE0g3Up2UFjE1l3n1PLO9/VwRkd+y4ZBnoOUcqQoV51JzPG3Vjg7d+3VeO/tMWRWhfYBMWL+fObXvH2MkMs5bY2PSTQLmV4Uxjj0RuAum1/Hk4ToJKXYi5Y04GT/I9aqWWFSVvEhGEuyAG+FKk2Exxow8cNdD6wohHlWNoWKYJY9MYTcCOQUb/dMJR6jDtkRpZELhClpZDkJDzsHxWxR5sw1QwIrqWeIp0aBfbZ91PbeyrpdPJrBJgbAJmrtMCo7d1sE/b/6CvPXyM98ZDDOsybHG2AA1AGwIOpK1hyGz5CVdNXC6OzZNAFUOMlO4eGEV3GWvUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:45 +0000
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
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Date: Wed,  3 Sep 2025 11:33:33 +0200
Message-ID: <20250903095008.162049-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: b1355800-6b2e-4af8-7855-08ddeacf5a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXLz6E4xVFYn7XJwAm7tOeMh/PZglrJ3ZaKBNM0xJP1lGg4bnKrPiwmPSM0/?=
 =?us-ascii?Q?JEHLPEKx0aYj+PSUQ3XeZZHaZGYqrTDSdyZazdtvfTTTs6nSyEFSHKgSmFHT?=
 =?us-ascii?Q?9gZVDJrZbmvasevOQ5nsJ/t2SuzVUb47AUQIIwIv+PDcEYLr3MG919SnP7jo?=
 =?us-ascii?Q?UiDHOaaqNNK10GBznCQ/SrEVBqYrpuvBMV1MQq/LQqEbVdxOjzPiFmTJI1NR?=
 =?us-ascii?Q?GO2najCG462JPcccv7dbv5jumlxwtfoFmLEPNEiWTyZTPodtQUK+EBafOpx5?=
 =?us-ascii?Q?22K5fRswPzAoPSY4SxHjmjhyaAdyHIOKjoZg4w2cRk46GAYifbUOpjoRHIp/?=
 =?us-ascii?Q?uk24dbE5WBTM3lRVU9k/ynLRlHzSNkmW02OWY/qRwB9K7D2dEk5NXekgBsl1?=
 =?us-ascii?Q?lAZ+7JLcmDNZArjxjgg4zQdGBO+8+uCVD/lg46buBg3nxXXJVp5Fj38CdTqm?=
 =?us-ascii?Q?zXy2rLh9opw9uxvohzetNKh2CX/Eajwa33LXzDddM7nF2myVWcZIgUxSQXM8?=
 =?us-ascii?Q?XZ7fXX6iTGTaxsD0oaGekOOH2saDEyhwwLhs58NmN7BNI6DxYlhsx5/2T/58?=
 =?us-ascii?Q?EjmQnPz9zjuf0d8tiYjkNhxgalmav7sNoZmGpHBEiixNhuOg480wq35GE3sB?=
 =?us-ascii?Q?Dz3J4ivKmVU9ARIIj3BU5EyeZ0/jXss/DNWOi+gOT56CGk36j8MfOt0eKHWM?=
 =?us-ascii?Q?/vhQiEvR/K7uEPAvc+z5vHi6mU0duMcR1uCYHEI6pXUKJ3kkS6gAYCr81nS8?=
 =?us-ascii?Q?i8DrQ/qRbedrke0vtD1Ua6zag/Xe6I321f+XqNI3ahObuvm6XIOzNNwpL9O8?=
 =?us-ascii?Q?ljR3AaVVCgxmWeao9qlsiN5HHwS3SyBLDZDANN2r3of57DtAvLHe5/+ZDh71?=
 =?us-ascii?Q?sU2Zxvsu/qqApdEH//sV2gjoy/f0okw61mNVdnV9qNA1nx9pPKmQgCRuiqMp?=
 =?us-ascii?Q?WAESaivc17D90/YACkeW+BHz3OqpoRcrB7f4L6+jDiCT+PmomME5OcoSRGnh?=
 =?us-ascii?Q?rhnEPtqE1uBA+Pkx4rwVsn0956B0OCldnjHuPdk21aCwTNySQ5TVII2X9GW2?=
 =?us-ascii?Q?9R6hsCxByWbfe1BFRVoqNBIOB94dLADOW4Hr+rGYqLrm6c9ewESchkTrh5Lh?=
 =?us-ascii?Q?xb0RiqFIw98xYLz1TRO3rqX72cQXJeAvTns6W44H9fF7htLiwCVltHgakXTF?=
 =?us-ascii?Q?QLoDCjbhRI5SzXBjdbczooy/xNqyscbEwk+mRhIGPoHBaENtf8zXIvdFay4x?=
 =?us-ascii?Q?VgwEZ1QZaUbf3SVF+cwlK6fzRANcR9/ZB8OsrOyVxa78RWs1Iz9S0oK14Iev?=
 =?us-ascii?Q?pMeI0ZUrP0HZgweOqsqOjlC0rg2dRvhnF5CndgXIUqYEDdRXorGhNKitOdQW?=
 =?us-ascii?Q?ZFRjXKYjp+G1GO43rnvSI1cVl9HS6Tcksw5hpewuqJyD1NE/+MhjqyoLP+YU?=
 =?us-ascii?Q?cAiCpuJp0jZ4Js//hgxH3BD10QXh5qbQ9P56yuj1j6Z2eZXdAoD81A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BOsPottZnJ25ZLY6+j2xtxxLNMCRyP954yW18EYksVj42N1aWuiTyd1QfFG?=
 =?us-ascii?Q?7guRdecCnb+Rk8Z7oTAv4gCxYQUwBnsjVPMnI9EbM55+2LaigbDuuaM3SmFx?=
 =?us-ascii?Q?sy0DM02ZsSedZcOaC7y39k/2bUzmXCP4jeBLfbtukW2R2sUE50mvrehYeIDh?=
 =?us-ascii?Q?UXv1l+1uNWbgH1l0R1PATCpNNhqAqBdORFewErTzGUmzb86TS5JTxoyI8Vj7?=
 =?us-ascii?Q?YYw8rkk3u/HLChJO8WJTuiCfOupPrav4WeUnBqrY+9oam/aczB4Xc35Ke97U?=
 =?us-ascii?Q?h3k1XxKqzxg1igehkq0YbBu0UPW1fC7SXrPNXnmZIfarIwjKmcd3cPnvhmIG?=
 =?us-ascii?Q?BmVWuCDZcvUavae+GWg49tFZmZS3Vrf5xfdWG8IhZsZVlyS6DWADvTiW2lvx?=
 =?us-ascii?Q?pJv6sI7Ej8CerlaIapTMJb5NG6DZKlCb3+J7Ipppvdwh56fR83yBzEu6A1AH?=
 =?us-ascii?Q?Wyuc7My8+leG68rjd0iImfW4Cw6aswQQKmvm7ssaRvOOf7nV1K2Md4AYPWEL?=
 =?us-ascii?Q?g6OdQsXoAIBaMDhKFrrhksp+10ZLJL7asAPD+Ho5QjHq/XphSA8K3Hknn22H?=
 =?us-ascii?Q?DzdM1Kg2vrT3pKComAHNh7srdw6/kUM6nzcVJb5vDbE/mHq9G0W+xfJbkYqF?=
 =?us-ascii?Q?iUlvyUKVbmhB5CBLl+9PSAKCgbJHsapqJCV88KrPKodICPhbJ0fX5DN78XUy?=
 =?us-ascii?Q?DIyJIQO3/tlNL+iXOra/+1XLUL4nN9xfQsHATQZFVv2rH2GuVBNBfeg8kqwL?=
 =?us-ascii?Q?2R5YKx2TGyl8Gb47FXpTjCZ5J8UyK0K/d1VM1cWzWxrGEEy7+XZTsaLNs9tE?=
 =?us-ascii?Q?ApNiWqUTI+g8xsl2L3j6FqwoNk2xjhH5s0xCmAszzgC1YomUO1wGC9ae+d+q?=
 =?us-ascii?Q?OTlISL+0UacEIyr9/NgbIq0+/NcMM3qaFdLDg/WtUtz7ZRAN+3aNgK0JGLXJ?=
 =?us-ascii?Q?AZoTNsZC0jTsJMS7JeZg1CKjximDcD/wvhgfL0mGk68yxdyEISeUJK1fCkJr?=
 =?us-ascii?Q?lFZrRim92SkAJzwtiuwpcKUr6c44exxJvDM2C5R02HlCGKtB0M/9vVuf4lVo?=
 =?us-ascii?Q?3of9VXsNrMjcNzM3e1tfMC0viB6B1d/rJxBpi6zKCvtNVU8r1AfMo9doaQrX?=
 =?us-ascii?Q?zD3iTG9fglRGn4LOs7fbhTkfg4z4oxS/2ZvxtMQE0XVkKdTrvwohikDsNQaR?=
 =?us-ascii?Q?tvWwHctm2in3fiW3OJcD9RaIySNiCAP/uKZ6RFH5a/jJJV7OfKDjl9FwxLxf?=
 =?us-ascii?Q?CVub0kiAbT5IF3ny/PrUisFWyw7xZxPC+4GiRG3nrGpTdNZXW2dpw5PazzIK?=
 =?us-ascii?Q?SvEZob50OqYFPMyMMK6F3X/k+Cb1q7q47zIFQGMpzG7i4b0Yp+UznbYT46Or?=
 =?us-ascii?Q?Av8MZQ6IJPtFGvG0ebp4n3FC6IQtJolf8OWWi1UVTf1yi8iAYXtAaGET/bRz?=
 =?us-ascii?Q?PHjz2ZMwkstnD2yR/S/MB4D65KtXygZ5gt2YA5gORKW66/tApNcQgxGvQ+er?=
 =?us-ascii?Q?jsH0a53B8k2qBrTiLKGFiq34ep5NN9J8YnA7KVajdb3L04N9CclLCt5Xp/gm?=
 =?us-ascii?Q?FL9Wxg+nss5BHJ1aHVrKwfmXq0x5csQD2pccqD/4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1355800-6b2e-4af8-7855-08ddeacf5a5a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:45.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp+J0oDJihbOCO36o40bC72ZDggSk5PssmcEyZyC5DklNW6vS7Cgnw+qOvOHZGoGrvql0XQ0lJtiLsaSlaI/Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also provided later to verify:

./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
ok 1 PASS: CFS task got more than 4.00% of runtime

Cc: Luigi De Matteis <ldematteis123@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/core.c     |  3 ++
 kernel/sched/deadline.c |  2 +-
 kernel/sched/ext.c      | 62 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h    |  2 ++
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4c..f1a7ad7e560fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8808,6 +8808,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 75289385f310a..bfa08eba1d1b7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1510,7 +1510,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * The fair server (sole dl_server) does not account for real-time
 	 * workload because it is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 63d9273278e5e..f7e2f9157496b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1923,6 +1923,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -2410,6 +2413,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	if (rq->scx.nr_running == 1) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
+
+		/* Start dl_server if this is the first task being enqueued */
+		dl_server_start(&rq->ext_server);
+	}
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2509,6 +2521,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	/* Stop the server if this was the last task */
+	if (rq->scx.nr_running == 0)
+		dl_server_stop(&rq->ext_server);
+
 	return true;
 }
 
@@ -4045,6 +4062,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
 	scx_disable_task(p);
+
+	/*
+	 * After class switch, if the DL server is still active, restart it so
+	 * that DL timers will be queued, in case SCX switched to higher class.
+	 */
+	if (dl_server_active(&rq->ext_server)) {
+		dl_server_stop(&rq->ext_server);
+		dl_server_start(&rq->ext_server);
+	}
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -7311,8 +7337,8 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
  * schedutil cpufreq governor chooses the target frequency.
  *
- * The actual performance level chosen, CPU grouping, and the overhead and
- * latency of the operations are dependent on the hardware and cpufreq driver in
+ * The actual performance level chosen, CPU grouping, and the overhead and latency
+ * of the operations are dependent on the hardware and cpufreq driver in
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
@@ -7604,6 +7630,38 @@ BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_ID_FLAGS(func, scx_bpf_events, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
+/*
+ * Check if ext scheduler has tasks ready to run.
+ */
+static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->scx.nr_running;
+}
+
+/*
+ * Select the next task to run from the ext scheduling class.
+ */
+static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
+						void *flags)
+{
+	struct rq_flags *rf = flags;
+
+	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
+	return pick_task_scx(dl_se->rq, rf);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f3089d0b76493..45add55ed161e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -391,6 +391,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1125,6 +1126,7 @@ struct rq {
 #endif
 
 	struct sched_dl_entity	fair_server;
+	struct sched_dl_entity	ext_server;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.51.0



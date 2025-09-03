Return-Path: <bpf+bounces-67261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51FB41A8F
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC62682208
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B232EA483;
	Wed,  3 Sep 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiWbXoQG"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162422E92D0;
	Wed,  3 Sep 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893039; cv=fail; b=Dw7FRzAe890c1o6LhUAEiyrULTBvhVz8TMYWXAbRDB0aqWL+Enw0dmIk+hdHljYQnVbFCJkOk6peq/tsb/sBdpzOpKnBn1Q6Cly+L0yJQoeO4cP+7G1pgdu80QJBMAFBrOF0PcEf6G5aHR0PmOT+MPrqav0Z29/Lc26xQ90wpX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893039; c=relaxed/simple;
	bh=eVkK74ceaAP4BWGMw4aiAE4rdhoD2lWBSPCbBH+7nKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZoGYLjiqCHf/QiI2aswufBv+0zg89XSw3mauYmu5Wvlb2qtNQ/AUKG+HDJ3YxLkDiLS4OgtQmyiG/wEsWGACO+IZtG+1WYDepiqT4ExaEyK/tnG91VxXIwb3j4B/xiuND05U5ftOZ0d9aL3Uop+Pl+aRTlyiJAgQXht52hfB5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiWbXoQG; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvWOellr67AF03yAIo3XpXkzmdtObUW3hA3pXWAzpFLu4NEDsjw2QobSqZJKmROFRnfKj0xBgTvILxo7TjJkuNHonwsyjIOavsenI4wz8uI+Gf0Zt4Epwtx597tomovUUJdXiwjAYxIQilSsrCxu2bqZlgDWNpaBAGl+EHmubEQbeiCIt6Tfn6Nd39LZZug6rxk20VZxdBAVzYWlohvt5z6bwlfQwG9m41GKBNUUYjfubNKYhd0g23BT9+w6J9WbT+4z5k2bm9SzGqheC1MBE0HStMUQ8Y/1ZWPpyALRzvIo26tjdw77cosWgDQ6DxjF8VTAeRgh8N0SIuo8ofGejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTfGDXYJ7tbiSqGmFr+e1CuATmrNDFrWtaGVycTxv7M=;
 b=uj7Ys2ngFSKma1uB5PCDmGqeBAzDmupN+OmIkERWgSd4DwcHH1uCSz5wPanlVl3g7X2rEWPXsOmG8YGfqVndMGQDH1QzRmXlq7vdXSq486qZ+maApqCAhOcn4Os3jfemCDH00GQf5YBxInAVdyHNnShMuSABc0WiANqZ+1eIx59Y6qJuNwkRzUySbBxQ/Nf8k3ED//k3wvtemvCyI9ya5dMVrCK4HRisPizQeO1K0gJP1NqSb1rywT7ZB3BBbm9hwzkBkp6CVkbBxsGjLL3QcqMSRyGNNGN6Qy87SPWkCyn8sJWEOfkHsc3KHHMcPbXrNZ6gIIDLmVyQgH4YrS1AkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTfGDXYJ7tbiSqGmFr+e1CuATmrNDFrWtaGVycTxv7M=;
 b=uiWbXoQG+4IPXfAxsl/nsJNzY84MG5Mw4olHxAECGipf77fIKjf9dSPd254stGqDoCZ6SR23J3pLN0LG/8AxhFCAn70d7S31LJ5GzauLFjgj+o5vB7tJ6k3bBcpzK8y09H4okenYzhFN4LsFwMG1oTtIv5fbw5dI5jUGQQhl5laJqPKVraucDI4cfujaCfKcdEO0k2xHIWgIZ8A9yrgE6Myrqj7+q3PjAd4j/wgnlCYHVBDCvstC9zJkdCI2QQ3AW2GN/DfHfMWm65MQ4RzH7w26DYxTGbdv2i5aW5pLvx8uHMgaIXT+bIfxW6YdoAc1iNpx8AM4aXavDourSTCyIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:35 +0000
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
Subject: [PATCH 04/16] sched/deadline: Clear the defer params
Date: Wed,  3 Sep 2025 11:33:30 +0200
Message-ID: <20250903095008.162049-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 17996af2-c744-435b-8ae3-08ddeacf548c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlbaRHeoycWtFXXrL0O6lbRQvrVHUa4VJGOVsSy3aI8OuIra7a5Nm8ncB+em?=
 =?us-ascii?Q?GrKzJG3jUgH8Hga2m/nuavDDFL/Pkm58KE6YHNvTFJbopFv5BYP75UqtEd73?=
 =?us-ascii?Q?GdGqqNr4bVBMFQspOjV9XDY9VkAUYKOpLu94556IBao1Z6YD7zPgFBvfK2mD?=
 =?us-ascii?Q?8mocWJE9vfebl5YQRNze8SWU5BEoLEUO8W2HT8az3bJluwmbFp6qsWYah4Jr?=
 =?us-ascii?Q?uW9HVES+Td83qSzcV5drMx6yP1ezXu+dhHhGGn9YBYykEtwF19jFn/w/xudf?=
 =?us-ascii?Q?anSNIwciALKsauQSyEy9RwYbTHLS6mi3Q0lx8ukAWSUvqfOxkpjghvUC5ww7?=
 =?us-ascii?Q?gpAIpzcQEw0zSWnk0cwWQQmThgupYaqOF/XU1S4bs2fFPTmqBUGAZ+rH4Ymj?=
 =?us-ascii?Q?zqP6dz9qEvmb634HiTSOde0pPPK9SUHcmLjsYtTELYbcxL6av1wkbCVVM7w8?=
 =?us-ascii?Q?yFbokByWAHtNlUuVstwqbXLQvrdb+vCxS/jg2TeUfVvtjuRuyzSKEK09AGCG?=
 =?us-ascii?Q?fQCM7eN6M235hpPFS3LlBnVeivhBW13uHiTDB4fR7a8sX8lAlwfx1Hz5bcjG?=
 =?us-ascii?Q?VCGB/SY7v3ePSpWEJ0u6AnxyDT4NJivowEdDmvQLsfBj28VAGUMCihj8r8Zy?=
 =?us-ascii?Q?4Z9GGFCwMleOXwc8hU8IavYHahD1IvTNSl+kFmYZvEB3j80ufUXDWsLyUYhI?=
 =?us-ascii?Q?4LZekA52a8+OecJcHcVUK39IuAk1REIhyolRvUWhDkwX77C2YsKX2f5Q5x5k?=
 =?us-ascii?Q?2EsxrmkJXeAZDfNQs42zB2/YB5XwDYYKPW550U4YvI+rOMVzOhfmxbNaGWA2?=
 =?us-ascii?Q?xxxIaUbDVazwNP48lolVCPcwBCexaVa/as9avKOlxqIvjLnjzdcat9x3rzem?=
 =?us-ascii?Q?d9V8Ez6kPCkIeB7aeDDO6O8uEADYp52wcY9LyR+6AKQfAzrXVXcbBUjLFAKF?=
 =?us-ascii?Q?0mojIYdsAwIg+qwaX1uwhx3eNmMg1rnWy06o6tpWbICm8mCKPyc8yE5j+HpQ?=
 =?us-ascii?Q?MeEOIVxvZufdGi+Y3gc/XV3uHTBJi84Ovk0ky5wlM1ZZv4MhaSlC5pMNKNue?=
 =?us-ascii?Q?vsb75M46EGNHnvmcfsgSmpemYqAX8A3fMYxLbs/xH/IUj7phoGP52D7MTanl?=
 =?us-ascii?Q?BC5JoJGuBFvB8VOVoOkMfh4vQgEyG0XLzpWvJzecY+g4rdXwOt8kVrsFGlrn?=
 =?us-ascii?Q?q+8I835voaTlU5AC4PhSaSF1qtX34C3q+MINw8nlJlQOFBsWVN2Q0bpMq9jC?=
 =?us-ascii?Q?D+Bg9AnxdDQXdELvElGB8fZnVhuWHL1589d0Zq5YVI+u+0GADjnt7vqG2OsU?=
 =?us-ascii?Q?JzLUpto1kd/PH413IbXIeX8Cg+e2vxIl7fxz+adPGW5f6bbO6Pc4EIsPwxKx?=
 =?us-ascii?Q?6ALwStEhO6DvNqnzcUin+LPsyYkJGyBWeuAHtm1rMfkaSXmxQzjYk97MX8aF?=
 =?us-ascii?Q?tvtuUAt9NcCeovG5glVVvd/ukG6kuBr58179pDxsTfEgos5lqfpraA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCOSwCSp0FMOHaroFyM0zUX0Runu7nw6AEX7zbyL2mYClO9LcspzVafTYdBZ?=
 =?us-ascii?Q?ugcaT8NMuqmmNNFIcB2fmxv4W2XFoZZIuHYsaxKC4qtecxKjKaGpyU4UQ3lu?=
 =?us-ascii?Q?jV4N3hwbUErS0i6lHv/o7SLL72kSa7v1V9mnV9/Hd+tlGLVraU71YZS5yqd2?=
 =?us-ascii?Q?yYfrN0gD0Ogg8PvMvoeea2nSGViMsHTedG1qqJdELH25YWD3igY9e17vA1gM?=
 =?us-ascii?Q?Mgls7iqT8xvsWVu3/ZwmQvZdXBVhHslrEiAlXijuniWPnoSPL8St78ZNbIgZ?=
 =?us-ascii?Q?A9s/N7B3B2lUR3kbcU9NyBM1zlcgG6r2SZ8aML2AkO4GMOBs9LPG7neby7SO?=
 =?us-ascii?Q?/2B4/gtRtaGGihoYc/RB0gqbSnBEKi0twargU+ABl0jyhLDO5DNfu8euNtaH?=
 =?us-ascii?Q?q6GQNtLdZnSLXTzLPzvUXDMfSt1yWiTil86x+e2rOSbi7g1+ONqAj6kmzvXK?=
 =?us-ascii?Q?bOl2jlPQuw63xZgpxu1HXzxBHN8AIq7XM/0LCnasG3r1WoVb1/TJmd039Oos?=
 =?us-ascii?Q?vfhoB7XjYorhyyIRXx4usBitgr512r6+/eez2M/QAOIx09WXD0/kcQE9777y?=
 =?us-ascii?Q?3TcIp53MVCJKRcML8B/wJHwlvVX4RsPHeX3sTdGr6X2kPsxOBo+tkBYk85ak?=
 =?us-ascii?Q?epI0GcrcAR+GaDkpMfr2SS9cZQxA7atbH6X3mAhe58W3t3Lqggc8PBgg+jV7?=
 =?us-ascii?Q?oqnMTEg8rdkNn9GkCzwPi3KGQXR7Y4WqDYvxqbBHgifsr5EmREyS8iL2pkAu?=
 =?us-ascii?Q?+DOsfznwOBlEzp4SAsmhvZxHsSWT3y4asro/pfaxEtj4ZmWOszKs+yevcNCs?=
 =?us-ascii?Q?1OI/qS5GB5eLx6RT5wxyuXUOQ8mE+BwVnXOSyez4bKtEyidPuptUmAxVwC+P?=
 =?us-ascii?Q?Z31RLoPWZnMPtLieCogpheIV7Q486KcDUMkdkpqVibL9VrvC2GX28RX/K402?=
 =?us-ascii?Q?d4sGE9N8RlnxGaD9bWjDybN6WuNU1bOJrnu1KGGaU0xdw0vNK3JXB4r7rh4a?=
 =?us-ascii?Q?s0Zp+zHXVxL2WFEajKLA0ctSZqPh53Fpw9VpCd0EHb5wF5bsMinl6FROeUTk?=
 =?us-ascii?Q?ylGh7MNj3BXOWuX32FCGKzzG8b/csyRHYoYAY6sFetq8SL0FSy43EbhM3Q3d?=
 =?us-ascii?Q?MbOfmPDDNacxmmwdzBjNDh4vDpU3ea5CrV2q1GpqWZxJsBOGfcaFm7qsmb0s?=
 =?us-ascii?Q?pmoK+sNpXSa/hkDe+uXAkaMOD+yszV5BnGAMCx503xAF1ZyEpFtNko34rkwi?=
 =?us-ascii?Q?J3JhMTW5wUaqJMEeHlpRs7S6q8F8oyy9/W+5LCZSqm4u6BY2B6KBkPi3f9rb?=
 =?us-ascii?Q?CjOeZDZlMTwu8qRIMiAYxSFB3JGIuyZOdEqh8yjFiLkUA+xUrLc7khG4aCKZ?=
 =?us-ascii?Q?VhZO3Z+ter2ZDBVwmQyk+NUkFTk1Cq+jF6zYz8g54ED8lwhKXpD0xLbQGk24?=
 =?us-ascii?Q?LhMRgRfUityY0xV1C4r3BA8LCr9ZAOTfSsAV/Pgn3eILgde6m+tGNoeR8Spz?=
 =?us-ascii?Q?DD0l5i9s+dTha3SsPqYLEhHTM8WlG7h7vacmKXXZf1S1MbN9gD71LIbO8z45?=
 =?us-ascii?Q?nTGd+s6qv1fWgr7eaYFMRrd4kBFnScb70SWEJNi9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17996af2-c744-435b-8ae3-08ddeacf548c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:35.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axi3kd9gjNv+M+m42vW7YsaxCT4y/0xhNRPbapCzCjJ08kexBdaMDfLKJ8kv8vhXFLz0MbQ7c1Cr+bOstbUMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b31..3c478a1b2890d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3381,6 +3381,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.51.0



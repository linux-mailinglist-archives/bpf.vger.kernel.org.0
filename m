Return-Path: <bpf+bounces-67266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF419B41A9A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B67D7B6A9E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B52F39BC;
	Wed,  3 Sep 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KIYqckTS"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE782E7652;
	Wed,  3 Sep 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893058; cv=fail; b=XwrxmeFMek7nG0d3IH4SYAmOWcdJWE7m3ItQ1M+mc0YiMS1NCjLy/p7wW6ngy7U6XkzAh+kl0uxTBH84s7B270a0raYxdKH4QPM+/owfXOPF7D0of2yreA2TM6//PNU2acLYwhjH0HPCkb5kjwPMJ7c0e6VBzA6H3T/dBBV40jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893058; c=relaxed/simple;
	bh=TutiBhDySWpkhmGp5RVw1Ud/r9AvzlzAe64H3r0f1rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUkY216vqSGMFJOwXW8AIik4AIyfbo3YldYZ2Td6EnNM8hkr8jOU5oxquhwqrNIV80F1hvkKzNhxtmbn1wUmiZO3f0TIGlOQEZr7SUMn6PQ+7xJih3kDku4YsZGcFMWesaMjVzCrva5nqjlI/rEy1SP06nveGSE42DI2sQUaqjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KIYqckTS; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI1fdOlWhmp/ZA7wsjcsatJRsafSgyEy+tXSqyEPPH/OiVXUFdG77HRbzXloYKf41pmTYZJGVl3dsYnXuoJhp/WYd/5NV3agUPMA7jHbTQmAwFVyqdBiiYF4r1+LLf1eANfXmMTk0PjCELpItZfaIQR1Cuswf27Fvet29XoauPLK3nKD03ZHeqjiwbpcM/XiHd/4b6GDjEU3NgHZaq0tpR8Zyd+yFN9Bb2BDs0YvPlJvY4m8LiLE7EMKZyqwHujIXg2YGrEEGqjLnzmFqRc+/bR6zgB/4xij9unnJMOa+le3NKwo+h+hkMnqA+q+q256VRQZh1flP8QF6Yb25OGRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKE4kzrY9NvRswvTxoaWOLGfdIuLd/gbXTKWY55tKKE=;
 b=ArTuHTZT4FDgvTNCyPxQJWgr7XILD7+FPicIuOjz2xD35i7SBYQEcJuL2JH/OeS4aHwqf2z+vaMvDCL7MFq83PTKb9/VH5Zx9kB3ypf1VvIXBrHNZwXiU4npySf9caf0veOr2PttH7wz+jQr/jdFWeVFIsse7C8iPCWVSrxa6O9kBoiDbICrjbIwCtZqRuIgqX++CxVQm+ZVz4fHkkl4VoTgHrm+KRSuz5i4avYUuK7p0bAQEw7VAuyTcaJmRGbWendBXZxM5rYkMCu3eVQ6SUIXgmoG4KeBKe/zJRhAzOf5Fq+zwBCBD6s5bqvIvdg0Qiu0nQybhV2mZo/4wO5W0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKE4kzrY9NvRswvTxoaWOLGfdIuLd/gbXTKWY55tKKE=;
 b=KIYqckTSj7SQQQe1dr8Ne8hcaVmnSijnLZZhhDsaXErwp9aCcjyC2c9WutY5WanwVs9wgET1jaFauFCIutSp8mgn8hIs5C7Q1GPPSawHVI0qt477L2li+m19uQV6568bPNEQw+506QOCEflqXPGFkg64XhalXzYVufNo9X/yBwLlOWB8NQ1kww37W8LyVHtIXEeDZuxKXVgQruJI5I2vE4dLI17LRTcO4Ch2PkeqvZ0SIsqGNYc3wsrOmB4F50QodwOT8ouRuXuhTpz4VqXcTokah5S/2UbZ8exeNt5YvrNpm7979TBHen8lHK8zwXDkWZpwXEOukLnQEnU2t93Olw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:52 +0000
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
Subject: [PATCH 09/16] sched/deadline: Add support to remove DL server's bandwidth contribution
Date: Wed,  3 Sep 2025 11:33:35 +0200
Message-ID: <20250903095008.162049-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de62b98-d34b-442a-1dd0-08ddeacf5e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SD8Y6kg+HQT0jqxlNKg/uIKdjW+V8OvCeyh8qKjkssEcMLXh4ZRUn1/RidZ1?=
 =?us-ascii?Q?kmYA34nkHSNioU1pBiSXLY3rEr9XX859VzBLaYU1vG2kWJ2CU9kDwYdj9qiG?=
 =?us-ascii?Q?R4GznZpuymPkQuZQ/gZvwmQ/y1J7pfprdtw37h8z/h7dmhK7VbwGKaPd018T?=
 =?us-ascii?Q?pqEXL9wj44hS65wAkx3Z3sm9vrafMoEzkj73m+3p6w9mXgAq4N4MkSoV74Pe?=
 =?us-ascii?Q?ZCTx1qyRCUohRNzEaI/90JsJQZLDkXqLxBHqdgHaY2HFyuUqb+MYLB5+xtjA?=
 =?us-ascii?Q?RGQ8EiPrZpAyS2T9X9BPuu2M2HWArdyTe17xWNT0NGOqlq2Jh301/95zXkRq?=
 =?us-ascii?Q?oOZxnCyzszB+m6YMjVxlXKC2qZ1yv6DnTc0RU45bbZmE6Bmq3YU6w7mcviUK?=
 =?us-ascii?Q?TPdb6IiNLIwVPmIbXjy5hBxpsAOfLty/2zbBYRt5CghXjJVV3ejbYxQ5S/X5?=
 =?us-ascii?Q?VXOHKFQeW+MeSoXS/PKEYZ99+p8fCdE/dsqzH05iyx1OHdegTPvWvtZ9U/CP?=
 =?us-ascii?Q?vUsT5woia5ITWksWIjh5buyeqCiQe7g6kI97XJ+0G+zl8Du91ARQScdZ8E9N?=
 =?us-ascii?Q?jY4gF2aLXHZnEVKIGSsJU9z9yswm2yWkYPIOLBC5A9C+E0frXOiXJPY/bsXS?=
 =?us-ascii?Q?NhavJpSwJgLEOE4bJcgMycKO9bcrRIjgwXFOUet2nJsJUBlZSFTsCN157oi0?=
 =?us-ascii?Q?/XrLXmHN0n/SksEavmgBY8FTmpCxfT3891maPIP+FAlHP23XrZEO/rhgV44D?=
 =?us-ascii?Q?Zp/o7glRa7iOrKQVkhlDsJXJV1NMO+KsuLkdwg389jJVF4aQkTTGdcqWI5FR?=
 =?us-ascii?Q?lMm2KRu1CimzGI+2DeO0ge1SScI5ljlmscZJLwgZuh3NmM3kcLR6LO8ciHuQ?=
 =?us-ascii?Q?j32wWBzhRvd8hbjxsARe4TxdlX/HJklOnmNAUCm8cgKzkwKoxQAP5keo6AeU?=
 =?us-ascii?Q?6p6bMbfQPWWOvqIBUpfYWRggU+RUEGe8WljU2AKCxIAa2xwazNTi6J5V7RM+?=
 =?us-ascii?Q?S/QDluBF6614xzLR6Pkb5PC59cQDh+lxnWhHea26wokX8hHTNphREr6e52av?=
 =?us-ascii?Q?q4MHWTTB2aYKXCRMlL3nLymtc/KjXXuAV3TfP+iW0EeUz0mrDxo4IvtWgbrh?=
 =?us-ascii?Q?pEMn0YjOnnnVv3kDb2nBtNn+k/ll903v/oDdVRkZBqx3OHODlGVMaVK+uy90?=
 =?us-ascii?Q?psjG0HRTLmtG8UiKJjdFTsQ0l35QT22qlYDKggUyDEuP4DjTG8yeJ9faA4bj?=
 =?us-ascii?Q?zfZZqpcdyHufQAwTvrJiwiqK46HsSJS6jkQdFnyaOSWJJPWbNR9vVkxMcnxj?=
 =?us-ascii?Q?38SGeEhHFrLb8jOT9Gq8lo7w2Nh1gYfpcB1B2rWFPNlyisrDI/goYve2Xw+P?=
 =?us-ascii?Q?AI3vTKL8G0IorjO3MpqBCvap4M3Txi5aZsHi6xIVPAXZkKzcgcRh3uxbO7Ij?=
 =?us-ascii?Q?xUm8Q3yR1RKapqaFaZcbFnH1EtdxKUF4hMVDK9Cdy/A53Qfh0b07Ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aTWWoIFhoHKutON61syXSJ8FfH/T/xTnfGgyePHJZny9D0ck7MeS3u9fnioS?=
 =?us-ascii?Q?pUnRMH2qZaGXObVZ4I+ELkRI5Qv2dkJDINOV/pGtucFB/T3bpcWjceQf087Z?=
 =?us-ascii?Q?FrwOXWERRjRN4R+DTkUO85kZ/lTS6s2rZjT/4jQ/X97Vuj8fAj4E7F7X1Dx4?=
 =?us-ascii?Q?cAst7SSrDLg0Zb9zeoFpRT27z1+hx/A2FBQgn2M2jawqZas0QX/kLE+oZGfq?=
 =?us-ascii?Q?3V8/sA7fed3WivBv4bM/W0AR/IO6BwFsnrOtTjnAFGnFeafvap3x5aidednk?=
 =?us-ascii?Q?nF4HavGGbxzrYbujC6aTaw7PSETlcLar3oB1PdAWYyOTEptWoFH+xAddEB/9?=
 =?us-ascii?Q?5Cg1rUjCVCrxxrdh9v6dVCn0HayWKK2YQFRdcJJrFP75qESMJpNXy9KAy7wC?=
 =?us-ascii?Q?QVzPQFu/mJpTCk2kZgTys5GowAiuueRLTx6Q+mKpefvbY2jh+NTv2o0j5TRB?=
 =?us-ascii?Q?3dJ7cdnRUdQvPbkIybNcbQDKN2J1hEJcKQ/UUwncXQNhsAkpJM56JFx8j68i?=
 =?us-ascii?Q?uODiUlk9xxrjEdcoe8lyTTHOEKoL0NFfp7VHrA/dl9d+HRHj7NAVJP7pwI+a?=
 =?us-ascii?Q?+6Ya2KZ/zqll/BLCM/oBcsKOHVQVlMY3evoja4H44nKbkLcGJKISqB7sBCbN?=
 =?us-ascii?Q?T+FZuEupepo9xnRKP+4qoURMyXNW3+g9djHZO5E9xYx+a+y40YvOFkK4iUH7?=
 =?us-ascii?Q?crtg+BELAecAdhXTbF/DqYr6VaZy95neV3wz0nPydFreSliRX7k9GztTz+a6?=
 =?us-ascii?Q?AxDTT16UFK+ICtOljGvUEMqAe8TdvbXBWgUB8atix1OUZ0RTF7U5DbmJFnnc?=
 =?us-ascii?Q?vkc2DZFQS0NUq5PoR1xDmtJ7mOTjnPNEBJ7H2FjusHfx0/SytSkRgVyrwsZS?=
 =?us-ascii?Q?SWJgWkMwOOsiQy6zKREDftA9qJo/Hpac/pc3fnUu6cuZvySwZ4xcTQRwgv65?=
 =?us-ascii?Q?QTN6QzdiGhhM78hpnmePxKNtyNY96zgiG4eTy+QB3osr4Sr8MYReimSQ0tas?=
 =?us-ascii?Q?prOBTme43ougz0mtP1f5ZSGybmYIk+ioVwKRzaD0SYyeay2uVFEGEVyFY1x3?=
 =?us-ascii?Q?5HtEyZ2j7IEJWtnC3YK6zWg6x45kxYBynZS5FsYqwf7csXqalgCm4ftZFV+e?=
 =?us-ascii?Q?BUM5gkV12mLKAoR6N+fSbg82V9qjuyYxVrjyJe/N5UkXtjr4NPJYahtMKfF9?=
 =?us-ascii?Q?JrSouzZTa31fIFa34bcI2m8xVoJ2SwCdCfVj/uro/+hMPsSM7Kq0nMmHRiRD?=
 =?us-ascii?Q?PTRIdrXTyfMpLXtvywJribEhhCiN9MNpqO6S4P83OHc9Oc/mryCDuy24ogmT?=
 =?us-ascii?Q?+8KfatMGRzS0DMa5vfOtHV2kV8qgeya6uEtRZ4BG8JoCqln9hAfpEc2Ne9A8?=
 =?us-ascii?Q?8wG0Uyqo5nQ/laSvfu6e1ubOrM6nYjmpHAXpota11ujluCQpGkSzcojIQVr4?=
 =?us-ascii?Q?ESBF9yUxUw/EwYJRgidu9Or/Cx5HWvGxZDhpulbAPQBldyEURc6Dg2pisouQ?=
 =?us-ascii?Q?PumZEBK75fN9399K6+27ZAAQyy2Cj/O4wBL5kzO94N45r0/WfY9uYYIvvCLS?=
 =?us-ascii?Q?Yx+ezRizOoivmQUE4UyrFmgyKQ4MZmvN7n3EZ0xJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de62b98-d34b-442a-1dd0-08ddeacf5e79
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:52.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svHK166I01bBbB9CX19eIXbLLDS7vOX9aH6KD8j1ImXeAYW3ScjpTOAdVG2p0zq5QbEwHo6cZhk6zzjKaF4ezg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

During switching from sched_ext to FAIR tasks and vice-versa, we need
support for removing the bandwidth contribution of either DL server. Add
support for the same.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  1 +
 2 files changed, 32 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index bfa08eba1d1b7..31d397aa777b9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1707,6 +1707,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
 
+	/* Clear these so that the dl_server is reinitialized */
+	if (new_bw == 0) {
+		dl_se->dl_defer = 0;
+		dl_se->dl_server = 0;
+	}
+
 	dl_se->dl_runtime = runtime;
 	dl_se->dl_deadline = period;
 	dl_se->dl_period = period;
@@ -1720,6 +1726,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return retval;
 }
 
+/**
+ * dl_server_remove_params - Remove bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function removes the bandwidth reservation for a DL server entity,
+ * cleaning up all bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_remove_params(struct sched_dl_entity *dl_se)
+{
+	if (!dl_se->dl_server)
+		return 0; /* Already disabled */
+
+	/*
+	 * First dequeue if still queued. It should not be queued since
+	 * we call this only after the last dl_server_stop().
+	 */
+	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
+		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+
+	/* Remove bandwidth reservation */
+	return dl_server_apply_params(dl_se, 0, dl_se->dl_period, false);
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 45add55ed161e..928874ab9b2db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,7 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_remove_params(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 {
-- 
2.51.0



Return-Path: <bpf+bounces-62688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE4EAFCD70
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1990E1BC7982
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCD2E0B4D;
	Tue,  8 Jul 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8aRXsZ5"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7F2E03F2;
	Tue,  8 Jul 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984566; cv=fail; b=r6C+Zd9ffoN/ztbXzBpFuwDOP6w6P3AjXDVkzCFPm9I+ZmruOXSQ2o0w02C4IySek/p1PXR9vDe9kgEoTLJCBQrUysWdTc6U22qgnsJxK6NZXJvQfLT3AsgeCbrmoCoGfXgqU0p17PqL6fRO+skBv6CIP9iBUq53ab/A6eboYX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984566; c=relaxed/simple;
	bh=YCo2euGYzqqpXNXFvkJPTX0aYPCz63/QGbYVns/ELWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOTzAWYz1qVOhLvnR4y0HZ+M4BcySKb6oruPQFP3+4+AvaFp9ARet7ELRI/bg95AXQggsEFOxbNftckFzyi9RRfuNuRUuYDUYor0FjG3TlWH0biZpYe8cvL+4FhT8VtLDEyhSRERN3q25HgW2VjsYfVTKaq+ChiAcb0J5kPeWfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8aRXsZ5; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZD8+CL/5QApnobl5cfSk5W6WBWC7wUHOxoA0z55Ia4580m7AhQRg9ihmWCASRFM6LYcBczHOyDJd0xzaD2exRIYWWBhrJZKbWL8wyzCpTBpPqNNhTTxpB+kAKbjEIXHRl4gbNS8yZNG4Isb07t1JJKL/oeRkOkNTU/fZG+CjOJykjZ9W5i3DD5j1j55WjoZQZTn9PFKm9VmgxOn7kJPiAQsqPZilCJCpSrV0vORF4mOdBiuDae6Z5rbQId3S3TAU4P0Yz5DLOGuwusXVvEwBLT9hBUiJ2sx8H+4c7u+GD8hTnOaKm6XxkQmxs00byViBSc9gjbUtQeC9fp9bodK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iF4gZ9DO1wP61bMFZVVesG5wtFbOGs3N/YJJfbAkzU=;
 b=uy3cjmdZ5isn26xQRru5BvOWkyoYRR+FLLR97GKQ5ZfdOyHSCUQg5a8rK6x31b9mbFmHpQC7mrNLsxl4NoX486ctsjhreZI0Vfw9UbkwEdwhAog3Fp3AMXCk5xHLeRpZ1PmTWqXlG1q+keC2GHNDV+xt0WG3ZHDjCTiZ8PafMXAwOJX69ozPqkGCT3UkUBgO/zxiNCOleuzcF2tUuRvic6Ix8BPUoUEmBBzUtZsZHOisUQ3MqByxODgYphsj/Q4oaxN4/h0K/6U8iw0KRgQ1qtJcACyLC7KATMGM0NEpoMNH0TlTCN+JFtqedRJ8CnYGAVnDVDGzwScdfbXQTjvCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iF4gZ9DO1wP61bMFZVVesG5wtFbOGs3N/YJJfbAkzU=;
 b=P8aRXsZ5aHW6PggNWoPViLnFVmRLAqcbpyOE5Ge6RjMkcTPYswQfahBz26LharIt572nQ2bsE/NyYC+LD/bdHq3UCyN0DjkbhH8pivV/0rjHCx0nsbzcgsOEqGFGellIW/O67ocWcgpmkEzlidEY/PEsSJSeEChZK5j96dLzKQn+EYyvpBpaTdbi+9wYmqMyhlqE1B5M5L2gULmwl1YnyIQ4O2l6XTt8b+Vs/gyVLonuZdbi7tE686cszCnenrVEfWXjRtAVr1GeRScX28AO61OY08Wmuls+kaRPP4BOIP71R/CeYw1hHqt7PqoiNwklgtrzgjaQtysXzWs81OOeZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:41 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH -rcu -next 2/7] rcu: Fix rcu_read_unlock() deadloop due to IRQ work
Date: Tue,  8 Jul 2025 10:22:19 -0400
Message-Id: <20250708142224.3940851-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708142224.3940851-1-joelagnelf@nvidia.com>
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:208:23d::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: cd94b8f0-067d-493e-c851-08ddbe2ae5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8vRnwgrwh5CKytqZOS7scu5Xg108y8gN4/ggFWfuv2KMcUwp52JR2u7HmPji?=
 =?us-ascii?Q?SIwpbdti9ah5aBwdnMoJIV5ckzziRoEbs6pyHtRzI1N6G5UFjnFSihUkzCxJ?=
 =?us-ascii?Q?pHtIU9v5nzNWGVjkKQ3ldus+wER4NtkErV+FlXEtpvbGvG65WXTM3oDQjLzz?=
 =?us-ascii?Q?CjbdMRA+WHReMXuqgIw2L3iK13RL4PrbOBJKlBMY1mLZ4U1OwSOSZNczrnk1?=
 =?us-ascii?Q?/J4wy2ADbnJVmHW3bcUQMBNatxtWq5BjzTcHUSxFCp9J55LzniGeO+WfDS+g?=
 =?us-ascii?Q?SFO6nrPzsqnWRYht6qzvjyejuC7ughanAfyAcPcD9JApo3jP7wi/tTxWjsDC?=
 =?us-ascii?Q?LmeEPFe8SHCEaEyBRnKGohAcFOLJfTscx9U4lL6+lH6cNhmCF1e/FmgQQ+Yo?=
 =?us-ascii?Q?GchOSBcJPuqEHu3DCtHt085X7od2o7onvfguOHCtX50P1KAo2GYVorz6ut1s?=
 =?us-ascii?Q?LPtLrMgqXnUGEcaxwN72spN5kI/H5kJ5nd6KmQxL5J3PIRO0GKNng6g8pMO7?=
 =?us-ascii?Q?ITOEbIJ+5FO4uHCo1w+vrN8uKfXuKmjP9ENNexs8Z+3K68bGYPP8H8Lc4EUW?=
 =?us-ascii?Q?bJxPBGVu7aZ4ceO44MMAUrbW5x1cc+JMKJSmp+pebPWWLKgcN4KyHybWWb+m?=
 =?us-ascii?Q?cJNixbEIbic4CSSmvqnQ/naGgX4azAzj3EpiK2v4lAHvsogAWI6reb1OIXfT?=
 =?us-ascii?Q?iD3BAYLSdqSFlA9Q3nif2NZfieCbwNkF0CJKazZOGFRVc/GK0oHXaluAISVX?=
 =?us-ascii?Q?hr3cc1smETGJAKGh3sIyRai8oVEe9tBgRURTpLQeMzc6lYQbHdoLL+kH+N0y?=
 =?us-ascii?Q?kRoOa4DV85RQms0tGlzrsPRMM+tPhNXNKPA1CXpegOiG+xmYf8RGm1m7WF4f?=
 =?us-ascii?Q?HRto2kVgNrwcZ/bJitUWmAsPl8fj9fEraM1FP9d31xaLdtObTgfz4H04D4JQ?=
 =?us-ascii?Q?vw+n6Xzd89qNXX9GfPRCs991Zr9evrQli7yRSFx+Z3UEf9hP9w1NUhGoFyMV?=
 =?us-ascii?Q?HWbcILMk0soclC2eakfqMgEdUZ1aEhpsmRBfCCuzSouVYVBgzl/jAMQS8rpL?=
 =?us-ascii?Q?6Qt+YwkqK7cDHukuKgtR8G5H7Pa5UsJAU8wttwbvnevULwb8InfK/NtolabI?=
 =?us-ascii?Q?5ne//jCWjZQus/snrX8B/YYun4lYEwqrZwNN0pIgKxwF36DMmPMvCE/jaYLu?=
 =?us-ascii?Q?8NwEbaq7CDLTgyNTyvwIS/EnMi5lC77MlQoJH4jqsnMz9OuhHjA5Z/eQL0kJ?=
 =?us-ascii?Q?YlGKIhE1gp6POkEkIQIfVwQvQWy4Xzan/FGX6BqH9g1nh3UsrI+36UnSY/O2?=
 =?us-ascii?Q?oLy6Ws009uBtLqutEDYVLl4qJdvx46f3x6ifKqln7NdU33PwxM3hlQFtZ4To?=
 =?us-ascii?Q?FJ4UeDa+f8C8pM64MbnXzl7zErp8l8vGVmvpG+xBzZupyv9B9A2JBFNE6Fg9?=
 =?us-ascii?Q?L4ss3ZO7hQnePyQZ8gqFPq2zYn9dRSGJvPPAzpOMx7ZyShwIwKDYVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bq8EeRM1YqG2xpvEIQfJX99cKwDdz1iykkipIElXnAoR/+8c0NKcnycPwmqY?=
 =?us-ascii?Q?i/TPt23cb2drb3pFNjgO2B3MwFemxv/oNEeyQlwsgV9l8yo87Fk6rw+nbx/Z?=
 =?us-ascii?Q?FkHlM2PnjpfiIEJzkvWFBykSyC5JDXpvXwxt0tEl94aIaSJ28AUXR4WSwWmv?=
 =?us-ascii?Q?xu+rtQMu4FofrS+WAl3FNNWpminFQ9waOGE/P7Uy6TGsV++03Fan2Bu8DCNb?=
 =?us-ascii?Q?vV8mcHDI88gsHYd+WLQ2c/8GuyesEMokYVEu5+Oic86w1b9su66ZNBbc4Bop?=
 =?us-ascii?Q?2GND+1Q9nDlGQw7E5ahE3HWBgwqt5BaynCmbuqHy0g8eKv2nEJsJ6/RmeYTV?=
 =?us-ascii?Q?AW+5PmYD7k0Lio9lTnZezyQuTdr+a9tL3EmAAi65v9mkUHKFvPZmzed30x6J?=
 =?us-ascii?Q?p87a8hvrntnbWv7A1FU+O2H0eCv7x3+7aPqdCjJPyVGW4O1TksHQl1nixlz+?=
 =?us-ascii?Q?EYzI7qONHUsSyQGkEUz1bBkXYg1rGk2VDggKQzvLkoAMbsIHS199NgCMaPgj?=
 =?us-ascii?Q?++AskUSfu6T/CDZgtEFCrF47UPnK9W9+E2O8FIBp6zzI7n0yMWobc8dGarO4?=
 =?us-ascii?Q?xWvsYfUAKtW5OdASmkh0EjW55bmATrMkauJSEV6tFxHZk2/7FZqitQUDmEQ+?=
 =?us-ascii?Q?41E7rWk1bMnRIYbaV+wFcSCkIRtyDsy5jGKbhVKtJiwAg+ORrHJOKD+f1/wz?=
 =?us-ascii?Q?ZhMMzzeT1AwoFn/e7GOSSfEqooUg0n8HCHR/oRRrkrDnWQOH0SSvbbg3GgbY?=
 =?us-ascii?Q?dV6Kt2BkpWMWiQzCWT/dKk6z15WqEO1PljuDYvHASOF+VspPPaOIHJCcD/55?=
 =?us-ascii?Q?Rtr3zk/wnDR+tkp/Cbtc2YSyU67iX6LTe/L9kj+dUApNfR7yB/i+QE8S5GmE?=
 =?us-ascii?Q?LodguYmGvAifwqGednCc21G8ZYM4AoOXDaW3EgQ+iNSJy+Sn4yctsUHXZeVG?=
 =?us-ascii?Q?LVx1KINXRYn6ubQFXWiT3UHvnFqQSxa/IJTCXa4U5CGTm8kOOrlPL7gML9Hh?=
 =?us-ascii?Q?QlPf2kRmFd4+D4kTGBLx4hAnOgyN2+WO1dL+jN0m6Mw6cdGwKBJsJk1ufOYD?=
 =?us-ascii?Q?6TRZTFDM0LWbkFQPhBzITdkTu5ND7Fsfj/Spa/iXUrJRJUHFaqvK2kV1UsjO?=
 =?us-ascii?Q?MNcUm193tTMlTl58cvPfsmPyuVD5Af6A8zfpqWx3CNVCUwqYZJlCOoGO0Hfk?=
 =?us-ascii?Q?7v9IGy0LwnaeH1tCiGRbkDLurbVgbvi+FLp7jlKa4vMq118iCNzCqgqY7ELR?=
 =?us-ascii?Q?k4L542TYaf2/Lsr+Ag4S9XyQVbw4ZfZ6fnTlx6FJAtJKq1EVCfYKtFfNxS5A?=
 =?us-ascii?Q?n0xfeQspFt6N9Cyn9uY0iLQ4X2oQzvWBABEuJOhED91njJhb+gqP8Aw9nkS4?=
 =?us-ascii?Q?8sHpTYDE4TKO6e990HdIfnKAMrI4WGqVHyYFdqmhrEb0mYfqv8ELvp0cOkoa?=
 =?us-ascii?Q?hTq/uyabsnu7vnb8klRgIAsUSItdWUQCPvLoHWsCDq7ejCEm2XCQpX7ucLQy?=
 =?us-ascii?Q?gZnR2CH2/rlU5hWrI5CcR65gU0PPeFH4v0pybk6m6VK6AjH/m2eXeWmYrKBj?=
 =?us-ascii?Q?D5X1lmDEXJP5Y0gYZ2ZDojdrZQolspkCEebn0KcK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd94b8f0-067d-493e-c851-08ddbe2ae5ca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:41.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZi0b4vM0qktwvI69TnSggy1N3AA6FtysHIKXNJt6wow/kU7A3dfgqnRnZLRriGYQeK+K4h34jzzooSg2T6NBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

During rcu_read_unlock_special(), if this happens during irq_exit(), we
can lockup if an IPI is issued. This is because the IPI itself triggers
the irq_exit() path causing a recursive lock up.

This is precisely what Xiongfeng found when invoking a BPF program on
the trace_tick_stop() tracepoint As shown in the trace below. Fix by
managing the irq_work state correctly.

irq_exit()
  __irq_exit_rcu()
    /* in_hardirq() returns false after this */
    preempt_count_sub(HARDIRQ_OFFSET)
    tick_irq_exit()
      tick_nohz_irq_exit()
	    tick_nohz_stop_sched_tick()
	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
		   __bpf_trace_tick_stop()
		      bpf_trace_run2()
			    rcu_read_unlock_special()
                              /* will send a IPI to itself */
			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);

A simple reproducer can also be obtained by doing the following in
tick_irq_exit(). It will hang on boot without the patch:

  static inline void tick_irq_exit(void)
  {
 +	rcu_read_lock();
 +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
 +	rcu_read_unlock();
 +

Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
Tested-by: Qi Xi <xiqi2@huawei.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 11 ++++++++++-
 kernel/rcu/tree_plugin.h | 23 +++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3830c19cf2f6..f8f612269e6e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -174,6 +174,15 @@ struct rcu_snap_record {
 	unsigned long   jiffies;	/* Track jiffies value */
 };
 
+/*
+ * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
+ * It can be in one of the following states:
+ * - DEFER_QS_IDLE: An IRQ work was never scheduled.
+ * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
+ */
+#define DEFER_QS_IDLE		0
+#define DEFER_QS_PENDING	1
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -192,7 +201,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	int defer_qs_iw_pending;	/* Scheduler attention pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dd1c156c1759..fa7b0d854833 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	struct rcu_node *rnp;
 	union rcu_special special;
 
+	rdp = this_cpu_ptr(&rcu_data);
+	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
+		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
+
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
 	 * report the fact that it has exited.  Because irqs are disabled,
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->cpu_no_qs.b.exp) {
 		local_irq_restore(flags);
 		return;
@@ -628,7 +631,18 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 	local_irq_save(flags);
-	rdp->defer_qs_iw_pending = false;
+
+	/*
+	 * Requeue the IRQ work on next unlock in following situation:
+	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
+	 * 2. CPU enters new rcu_read_lock()
+	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
+	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
+	 * 5. Deferred QS reporting does not happen.
+	 */
+	if (rcu_preempt_depth() > 0)
+		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+
 	local_irq_restore(flags);
 }
 
@@ -675,7 +689,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
+			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
@@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				else
 					init_irq_work(&rdp->defer_qs_iw,
 						      rcu_preempt_deferred_qs_handler);
-				rdp->defer_qs_iw_pending = true;
+				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-- 
2.34.1



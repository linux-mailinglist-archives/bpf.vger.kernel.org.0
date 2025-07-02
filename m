Return-Path: <bpf+bounces-62208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABEAF6635
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 01:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE1E1C40B25
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C82566DD;
	Wed,  2 Jul 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fnuIQRhh"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7832DE709;
	Wed,  2 Jul 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499000; cv=fail; b=kFow6JrSA7grXpgZtCV62gciXd5pPVgZGGm5EEr4LNsVGQxLKn7oYPGeReTOOAL0gh6n1UHF7zOBNAYEzgjqMaohzdOfhXZxFS7nw3Tc31e8dE4io36FrRiK/kGT3rHKi2df/ZvV0kNRI6o0+2t3gQA2DKAV4OPzEHuP5kE06bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499000; c=relaxed/simple;
	bh=OewI5XgjtzK8zBWCdXtxsE6RfLxyErkCGcKf8CoxTXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D98gdB9s6qIJhMioRHtGu7RV3s1NPmO3eOMU2y31NJjgjZRFbBX+mSHOY0HbfQWCcL/Cez/hrVZfCUSvoWREkl/JjH7zjSy2U6yon0YWz3hU8yxdJ0AagGcYaPSoX0Tn1ajvHJicnrM255GZoYOxF9yjhruFe2lqYCns6zm/TaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fnuIQRhh; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONekU7sI6+6WGLFGbvk/F1pg136GNx31CSIRUeCtse1+bDT8qHs8Hnw/wRyE7TrZNJ7ZRaIXJogO64ZBQL+1sR6RUvnC3sYGJ2odfV2CvGvLo4dScBGAGOQQoXVLuwcjvcWf9eLXDx48a3Q/E+FYneY9yWkzG/hZuQpXwWgwKEfS6WLXzTK0yiSEOnWA++Rzk33MBnUNd0LgMz6ly6Et4PeYQnTfYrOgvOg4ahiNlwLTrvJeScagg1rq4JOd09O3ctM5DWtb6s7OrN2ouNjejvRhDpKKyQKX+LVFukSR9WkVtoiYFvSqDvfZXhxFptJs63pWu/uiZJnmPt1KfIMm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH6oeyhDNG+inGpwNHonpkKRGesJSpsWf35yAshYhyI=;
 b=NuS2RFAehf8jlMqiJ3UKFpNuRXRg5TghudDpkG8cDYbRKcpkU1+wd4E7RdhOFKFV15yfKG9YELIlOlxIIG5WxqWQJE7lKeGOmkVma75Hv/mxUz8OkJ/erE8zlItsoZpEZS/DH2nbpz3T3Vzvxmm/+Z+OOeHep2i67sDhBfETWEREyajIST0hbk+7iqU1dWSCFgvqDMt9J3cW45Guis+fX5CrQxUWW4r6tZxF4FXwrzY9Ki/ep/+Nusqw7NoQ5rA44xX3wWWqA+BPk7zcamQhotO1Vw6JTvmR20KUAgP/YG0Qov+U5pakabRzAixNMpzjSCm68FsPbsR2YQAa12350w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH6oeyhDNG+inGpwNHonpkKRGesJSpsWf35yAshYhyI=;
 b=fnuIQRhhwGj7HCU0XN8hNr+Fy9t+5sx8d39eBwRRzI0WvTF/pSccB5n67NeuDE8GrlsCtm0Cz0iPGy+jhJfijOhZMotU750a5ode9z3KKlj5R+nd8uX+EvTIyvsYK4d1yJo0deDwQfe0UxwZ0CbsWRWJ0zwvdYmVXbe2I9pId5uWBzQpD7fhN7Ssj3ZWgEBBhGQWTGuU0xZ5/0AZ6tM2Lzo9Rb4sP/xL5Pk+xRafvFsBapX4KHTZYZa3qJ0G+JF6J8OPkCpJfr3q3rDNjqqh4+DwjvbP63EtqU1tQPlDlZnR2h7OPTW6g3jB79OhEDvWnpGJfX4FRXHyiTQ+k6prtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:29:55 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:29:55 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org
Subject: [PATCH v6 00/14] Add a deadline server for sched_ext tasks
Date: Wed,  2 Jul 2025 19:29:25 -0400
Message-ID: <20250702232944.3221001-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 80332b26-763e-49bb-dc3e-08ddb9c05a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzJXRJNn1fVknCtKmMayiJgoRHP/I5OFB0fiUDzUz0RPzy8N6dxhEWkQpCn9?=
 =?us-ascii?Q?nOC9tj6vlgSD34ewcVc1qwQaW6lYklbzhekspXJaDbwGLvRzwxZ2yO3Rj8Gs?=
 =?us-ascii?Q?twl7MOeKgE8juah15OV/Jt/6IFIkpOffd5zCp+J6+yWu1jyHq6UZx3Nphhie?=
 =?us-ascii?Q?VIBzpP9lVEQxeX65eCUYordexEL8x4WNNf4TVatPjVeAaZrg1oJMaLOwm0ZC?=
 =?us-ascii?Q?IlDrljIRRU7UvffslsX+kGia79EfIdp/HSbL487sEPxpyYMu159ozyTJPa7H?=
 =?us-ascii?Q?lT9K93DMcm8jRAGac+8GMEwwFAXGRyD/Ents6b6PMywKya/3y+stpT8JRafx?=
 =?us-ascii?Q?/ZZWderE5JZkcnVl4Phbhx/yNcE64xwMtYNd4uUuBvdzixlPTSfS1vmgu9zS?=
 =?us-ascii?Q?LyDqO0zaZQbEfx+GHwxBzQL19EZjS+ONN57KkXfMFS6BBuUInmoL07hRmh92?=
 =?us-ascii?Q?QTepTKL9J+/5ePuEMkD7eU6piDC0gEuSAJ6vImVKZ90Xrv1Jgzr0DM3hc8jJ?=
 =?us-ascii?Q?sP2mbh3yYN2Ykv3b7Y/cIwGzi7+xv936NEWe1k8wU7mPZKmbNvA60Ve4QyMU?=
 =?us-ascii?Q?1BkDF+Iw7x43zi0E3lmEleUkuG1jOr+0QGAVbd63/0+whW4Qr7QskN9CYz7Y?=
 =?us-ascii?Q?OJ8O5arFOBqlZIEHbfWA6MU2PJQm2VokdOOpTojBbBnYt1JO38nDKZv4vKTy?=
 =?us-ascii?Q?n8PeGJJU16urHASnj2bW5pmvob8Kzxs2dbWbbXP8RhpOahv7e7i+4ZQ/jbJw?=
 =?us-ascii?Q?VJyGDLHfRngCdybES+jCtFBUJT3NT98zeVf6RWexsJX/u3mf4GftMe9W8nI9?=
 =?us-ascii?Q?8Z41B9fOBTn2+JxbNyjv8IBVv7XMm9awHnkVc6miYs9c7vv2PNZ6WUsKeld7?=
 =?us-ascii?Q?H2hVDx/fpHKo3/jd1uYTYfc6he9YVDlBaOAXtHH4gOBju3t1cKIYBvSwP4U+?=
 =?us-ascii?Q?fwjcITCgO+YbOZNACkJr7vQyWNhZqk67LYTb6NIDDUwg5qjHMlWZ85btSD95?=
 =?us-ascii?Q?zIOYhBLjqdxdfhFRsuAa9ZYFu+vs2IJluYsugmThFZSj3JSBWqJ/i2zR3RV8?=
 =?us-ascii?Q?zy2jb8WmL/XCtOso0fWb0N6yC8QKC2hL0OQgbXTGjM6NJrMlZMaBcRNXcmVt?=
 =?us-ascii?Q?qlmsDYP66B4oDn0GOkX1KqvEswOj7Uey/Yvz79nqNjSij5uHkjChZBQtOhOy?=
 =?us-ascii?Q?nehyMslr+xnbPveEbQxnOZheRyOvOvfasJj2rHn2nLjEvpgn509+1LMKQ8d8?=
 =?us-ascii?Q?wXeElq5duWTZ5SyoJOxoIxtSvTFSQutJPIq1OT5EVqAyCmilm9GaH5VzTEvx?=
 =?us-ascii?Q?TOZM9r6jmFJUiC5cGa4HJ/Pb+UHVynPVy/Els7QCAUEhcHFypB1WWwxrYnl2?=
 =?us-ascii?Q?Rt2Ac0V6hhHnwZA9LNtSfaazolBEe9hfMVesB6AzBn8MleyGfb7qvG4m4v3K?=
 =?us-ascii?Q?euWERwcnWPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8foM2V4MTbTev0QyaDiULOsVBL8/mabSnxSa+2zQ4KqZTjHMvgT+ddlhroTU?=
 =?us-ascii?Q?q4fekdqHO4XGDLtWcP2dXv8pheiELhly6cD59wGEk2ThD4friAI94aUaEbZQ?=
 =?us-ascii?Q?03jMiL0ZG6qDyPQotBHKA6ehYeOHUXEgyDRIbfApmRKOETkjSfcCecFPeU1f?=
 =?us-ascii?Q?co2PI6l2Mr6XUfbfXq+BDWCK/v2hm6tN1t36vtXKx/rWOOKXqxRFxFd1V25K?=
 =?us-ascii?Q?VsuLEuoE3aUf8VoUouohzR/h5JwbgFk73GW3NM07foYdu3SYHLtmhGfCr2dR?=
 =?us-ascii?Q?VHLXc1ki6gfPS6HYmoah15LxdrUk3J0xMn6/bP4wALQ3T81/9o55dzltzBAN?=
 =?us-ascii?Q?DAIbHvY1R6KeOcuPeO4tfAWFxYKoKJR2gjdLTfhUQsN9izkGF/x/JnE991aX?=
 =?us-ascii?Q?AaAWv36QnMv2dI+Nbl4b9aQ+wv4ob4mCDoagLVPAfaGg0swV79g+bFKoxL4m?=
 =?us-ascii?Q?Se2LhVTQBWwsKNM7lZ5dKdPkm8Ml5T+EvalFqAhUSfQ84+DQNxC8XCXM84XS?=
 =?us-ascii?Q?I0ypaAcfFBnNldsBUDcEeHSkDvJcMwao9fLYjAgWoftihqXoyP5P36T/oz9N?=
 =?us-ascii?Q?j4Ay9R+3STJs4jyPQ/2TX1okclSqfsN/JKkD6v+dfQ6Ky0nN7zbAD/3taY/e?=
 =?us-ascii?Q?/+F0KzSmHNBeNSW32Ce6ryHxQh8PzJSaqd7FdpXWXA1hAHHJZsowXLS881hi?=
 =?us-ascii?Q?Q8nlx+Qo0+pdJdLx89Ks58Jx/ziAYQ0MdXJdFzlLdPdaeI4xr4ypOeducaLf?=
 =?us-ascii?Q?bUL3ODe8P274IqDXRzwAadWoq+H7T+yp6CIfOx7rz+wXMOa45SmseuexXFEn?=
 =?us-ascii?Q?9w5IMPs/QuAEN+zVmqwNlmA8cnKIcKiC/O1sdDoULbqjHwq9WeYHBs0pRxQQ?=
 =?us-ascii?Q?KL25hHl0rVk3m0Fu50K5aTONaxvyHPjhLJtu7wu/hM4ybfa71UOg1k7sCHkV?=
 =?us-ascii?Q?xOoiCJOG9B4VtiXGDQ8pOWOFxwQUtolKyc7f6uBzNBWHxjOnrO2FuAgt0ioK?=
 =?us-ascii?Q?WyBL3f0DJJu43YV7NNir4zSdB9M6HDueSYvhWM/H0WeRzdv3e1x43vBbih+T?=
 =?us-ascii?Q?fHcAbT5yfZUW7ls3o6PPQll+hmuxSSHkgnQAtE2eazRKYFpZ1HXjJhBDagZ8?=
 =?us-ascii?Q?UbOTjpoGuwLeSWLCltUibRt0GrEYH2iTc99f4XXwCDMzhojNV5ACNKymrANr?=
 =?us-ascii?Q?PuXKkwRwneJzyGhrfOhtTEdAH80pqATUpFtABBbZAj3MJyDwDbtJ+rfdHX+p?=
 =?us-ascii?Q?PFCHwj+lwvG4zUmq/ZDqP4iA42WiXk9O41ZSQoxpHius/GncBlQYPhTndByj?=
 =?us-ascii?Q?Y5xWYMyV/BnCui/H3zN07o/+EpyyscoA4SXtyc+koOZM+Tnn0qWhADh71aL/?=
 =?us-ascii?Q?+w0G8ZMgOFJWbLCVy6jDUJFTfkJs6ydglgwmphWYlwFVAm81BPdlsrsQJk5s?=
 =?us-ascii?Q?c+SjV60pIXeBhxDMTf6ELUAZ+xdDAxOc/4ElJfI5HEB/XV02gdNszCjYtxst?=
 =?us-ascii?Q?G0tNECmOyCOJ1FeapUD/kqp0endJ6Jn4WiEaRHYim27luUSEtGz1XyspkpcY?=
 =?us-ascii?Q?jTkppwjxShj17WsN1LsANviQfIJmlOuAdEbTVCUT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80332b26-763e-49bb-dc3e-08ddb9c05a09
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:29:55.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l97Aztkf5rA5dO3pgt+pvYVbgboVOJXXdeVE84qH1/6fiSL5XC9y8scIH2jkze3o9UD/H9O50rIb7FXFfzdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

sched_ext tasks currently are starved by RT hoggers especially since RT
throttling was replaced by deadline servers to boost only CFS tasks. Several
users in the community have reported issues with RT stalling sched_ext tasks.
Add a sched_ext deadline server as well so that sched_ext tasks are also
boosted and do not suffer starvation.

2 kselftest are provided to verify the starvation fixes and bandwidth
allocation is looking correct.

v5->v6: mostly no changes versus v5.
- Added Acks to few patches.
- Fixes to few nits suggested by Tejun. 

v4->v5:
-  Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs.
- Address comment from Andrea about redundant rq clock invalidation.

v3->v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX.
 - Fixed other issues.
 - Rebased on Linus master.
 - All sched_ext kselftests reliably pass now, also verified that
   the total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with
   these patches.

v2->v3:
 - Removed code duplication in debugfs. Made ext interface separate.
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch.
 - Fixed running bw accounting issue in dl_server_remove_params.

Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/
Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/
Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/
Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/
Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Andrea Righi (2):
  sched/deadline: Add support to remove DLserver's bandwidth
    contribution
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (12):
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/deadline: Clear the defer params
  sched/deadline: Prevent setting server as started if params couldn't
    be applied
  sched/deadline: Return EBUSY if dl_bw_cpus is zero
  sched: Add support to pick functions to take rf
  sched: Add a server arg to dl_server_update_idle_time()
  sched/ext: Add a DL server for sched_ext tasks
  sched/debug: Add support to change sched_ext server params
  sched/ext: Relinquish DL server reservations when not needed
  sched/deadline: Fix DL server crash in inactive_timer callback
  selftests/sched_ext: Add test for DL server total_bw consistency

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       |  86 ++++--
 kernel/sched/debug.c                          | 165 ++++++++--
 kernel/sched/ext.c                            | 120 +++++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/stop_task.c                      |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 +++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c  | 286 ++++++++++++++++++
 14 files changed, 869 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

-- 
2.34.1



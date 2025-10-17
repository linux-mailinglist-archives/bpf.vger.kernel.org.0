Return-Path: <bpf+bounces-71182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CABE7C3D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA6C334527F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E202BF3DF;
	Fri, 17 Oct 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AGlpN6TH"
X-Original-To: bpf@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C02D5A16;
	Fri, 17 Oct 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693573; cv=fail; b=NYCWkgcx0aShOnfhzNc7INDN5nX803iZgeHguZWPjevH+jE1JJqbbbt/z2E2nMLl+qsyIs4GjKMbZHgQP/evcUZxQS/QFcPds4DZri7yIxalsFWVExoVJ55BP5PjGNFwrrbnDMOWQ2s1D9DB7H6akE57fytu0J2ZRK9NkS6MJ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693573; c=relaxed/simple;
	bh=9e/GsuNzRauYHZBPJIy6w+WsaQiW4myemH8uoEtZhcU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dwzCMvqRz52mNVlw/J/JRYQuukOm8W4NfUZro8ManKx+uYNae5PSZIT/Wds97HIPqike6B5pPV6OS7oX8B4YPEXzmmZK4TrOZjJDXVDVW5q8z2kTaZssb1wTnbI+2WNNhvA0sQS65/C408+RKZGj1ifoTYpb8pIGDFZVLPTI/Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AGlpN6TH; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLPsQ9ae0xrE2T+mUHNf5T1/nZLUWI6o5ReH/8B6Zc5s1WJyUQo29Ifkvko+OtrPuUSAzzAlRmAPONJEVMnARUUsvAHAgddJOzCdCKiD0ranjk4JdTsyGLORy4EH4h35XxC50frzCzrTVjPkUqbeFJgwgZUUBLkapv/YuJzRKIX6+bJ7vQs8yKwiMzwjaBYlg8dPXBTP0WYvMOWO89U9S8ku6JD+1La+eWPJHRrvrGi/8rmUZTW53ghfGLE8RvloiLXnZpRCsWoZouzFBjpFHf27Wt7cL/Cptz7MrMh0ifk4kGlBklrviPTAFeP1mHDiElNIR89UGnyzrLhklOihMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeKWeM7lGpUuvgWNJtX4w0J7ZcRM24XHW2qPixi0DvM=;
 b=yQOlt8yE/5fQI0MRm37xeWexESUx7ea3DUe0T5qpxifbgiUz74QKw0JyN+65hMl9RGKgd6lbtS6JcLoSktFiAneNc6Zm1HMC3JPqwexFDH7u8s12i/fXgllRB7VM04V41DbyYRGcQb/xlEKm5FqbbOSdZLkHahqj5FoF/Y0yeQue8Q7f7fMoEr21e24EHGeX+MmH+i0uKddbXzBeUR9o6rXXpkFxnDwRFN/hKf4c0788kpsPjSccyVQYyIXiyLM3CbBVwiumZZuVVy6aWtHJ+St2bf4/EMVZFHWjhuO83Zc6YXjX+Dj5ayeAw2dysQzdFV6TV0D7iaLdt9j+uncKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeKWeM7lGpUuvgWNJtX4w0J7ZcRM24XHW2qPixi0DvM=;
 b=AGlpN6THgh6cU32xuFp0zT/qQh6SVBqhetehYR09kgDMSy7tvWmZOdryPBgs1UZrIzYmWwqUKT1pLY88hnFoHAkBIMLPgufFCM2UE1YeZAJhrlESCeGf4S10UBs6t0wYQb5xOfsBwY1EmuoufufM5NAeTC5bVmFW3OytHGenapPGoq7kUoJ7WILD5vqaX2jwvjIQMpY7EVQPeXBz0IDllMcLNaE6kYobUnerbtz8Fbg+Uad2bvUV91vH8D7CYv67kitOKHiMXeO6z7YRqz5mB4aAUv9fPSYlss2lGpqOh3r1g19T7CBgQR8V0f3vGGktjoBBqXd6txh/gNCgytlQSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 17 Oct
 2025 09:32:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:32:48 +0000
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
Subject: [PATCHSET v9 sched_ext/for-6.19] Add a deadline server for sched_ext tasks
Date: Fri, 17 Oct 2025 11:25:47 +0200
Message-ID: <20251017093214.70029-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aaa177-c8d0-427e-d9d5-08de0d60229f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8ZTP+iO8T8V1CZ5qJnzlugeZPmAQFDRvddS7Pi5uRPRRUQ5duWBQ4nRGhaH?=
 =?us-ascii?Q?JklwG30D5jcxtFz+hmDvz0KZ6IcNZnZVFfH+xz/+kZkAwxL63+/pOv3YrPEr?=
 =?us-ascii?Q?K1qgwFPdeyrGEcqgXJS+Zc9tZKUytZXNCVki73RZn8IMZ/QWLj3uPvOt6485?=
 =?us-ascii?Q?m9wmPH80pkriUoqgVE0QlHqT0413UD4ybihdIFEqOiTpszEYE1RxJKBtNept?=
 =?us-ascii?Q?n6x8dxMu2g0a7lnMcn9zM+OdIqnAkaVXGuOxZyf99taBYATFi5Ru+SEeudQC?=
 =?us-ascii?Q?p0EZ3BU62Zphph0vzpantQnKfL5CDCvQxPLXbMBL62p2CHb4VQPSrPgcgTtV?=
 =?us-ascii?Q?MoSHOuPs2TZj5lX4WrQt42R3r6TrYTK+ZwKJp/kGjU0OmBRA0/gHHyuB2ano?=
 =?us-ascii?Q?bUtbOuNjdsaJGt/cKX4rESNnx1zT/vAWEzNzoQhpb023dUA78xqL+Fz/Cn46?=
 =?us-ascii?Q?aZmXx/8Ucm8zcLXhdpdtPUaCraGHUzDflSR2Cgel3wYGxDpF6FDRiZEySSoD?=
 =?us-ascii?Q?JjzK41g3nTAAMY5iw0xTwclUyD1GNsT2la8TouF0tHzuSYLm4yI7HfxIetAt?=
 =?us-ascii?Q?hYdGQAB/QE6vLiu0yritnKeh8vkbiv8wgpj5ZA6b0E3aRrkvVUEoW/3RfY1L?=
 =?us-ascii?Q?1i2vxFTiPxG2imloBaP8kMsn6EVg6DzzPM7ML9CRHn5JSJxgrfthIta82xJS?=
 =?us-ascii?Q?WFPduI1H2muuyPaPEpukOunjzmY0LE0X0NT2JQoxN+Tuwa447744xAn5Xrtw?=
 =?us-ascii?Q?OPhocor7qbMX32StWXTiNxhRRKiCjRg8DUAdjYJl4e3+ajnLmm2zItrkoFhV?=
 =?us-ascii?Q?y2LLo4pJaPIJJZEvaXybp/t85Eyz/tCMquTDTlcU8aaolPPAGUTU4LljaA3K?=
 =?us-ascii?Q?IS027v+bXuJXvWAwh91MNe/TKtUi5cQEopMyyZzzq9rDGgujBNOL5AJaMBqG?=
 =?us-ascii?Q?H1RGP9H23mu4hvcaGJDbdMK+0hu5xkrYxvTTqpy2tXAY77Sv7fKXheRfHbyX?=
 =?us-ascii?Q?7yWWTrk3ni4ld6Lco9MaqmaqZXahG+oz1TneqTwO8Sto1QT4phFxoiJXZmTS?=
 =?us-ascii?Q?iMRQWD86vHHbfRdw5gvJa3ShRrfVze9H3lyOwNEhJNd+uyF+zOkm9f9+CdAG?=
 =?us-ascii?Q?c8sJP/d+yXQ4N2eAJsb/5uops+IUC4AFrNOCFYL/MLdpHkrh8+fs1UuskFaZ?=
 =?us-ascii?Q?io7xVa6t6GrGNU9lQA7cj8V1klHtx6vo6AG3V3CFKflKQGuoiNANRLJLy5+k?=
 =?us-ascii?Q?eTl5IOvCy/ERl8+/FrAR1TZ8Jaq8jiOznFyaoG2kUf0zt8BrolaqvldGblgE?=
 =?us-ascii?Q?gqUwRh+PBVcXQfDSjgfZTam1l8dHDAWIPhKLQPrMnbh2sbDIwAgGEzbeHRnr?=
 =?us-ascii?Q?lViKgK/Y7lu9qmcsXtS6k0yPw8OG/jW7S9E8hUsGjz5yms1FUso4GATjXOxZ?=
 =?us-ascii?Q?SQkNCkv8fKExdaUyM2nUJH+/T/aA7Ty8NPDYSeJCKApmtWn2cG91Z4+GgaKp?=
 =?us-ascii?Q?f76ZSN6TwGRz6KQxFS/oEd2TVjH1wUqU0CfT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6uunklOwY0Svme+klB3RE0EauPjwm7+11cBZDyOU1rSOFvrePblrSzOAyCFZ?=
 =?us-ascii?Q?HuqAg9PG0UyoK5ATuwj0zzQk3a9sOl/YSAndFygsqGHxyhUm5DB8XRK2ZXt0?=
 =?us-ascii?Q?Ak7KwURLd9eu8IM+JdTUu9avzd7sdm60Plr+r0oCTrUkY0BvyrnUNNeTj36d?=
 =?us-ascii?Q?x+u19BvNQ0TVM7rkH+CpAwpW03/W/Aw/DG1MJPLA5i9SVlJfCKBQD7miBOJs?=
 =?us-ascii?Q?nPdJFjCn3XlOdfP7iC7uJxTh1fLnNxPMvkyi2FO0ZK7spm4pC2WaDlGPS7si?=
 =?us-ascii?Q?YkEB/dctwImmRdf64YWewXtlW1X/GiUsf3O0O1bRC9iVIZaNez5Inx7b1p8N?=
 =?us-ascii?Q?DcmerPSIcZs7PSQ12ABrrYzgpVc8KjZvfHtA+MiFfxiMYWlgJIqIhQYcKom0?=
 =?us-ascii?Q?yIXE7XZJcfWqEUtXFwFuJ3t9NFYHwVqg1edPQ7dr4ITC5TfYnmAijdOL+uAK?=
 =?us-ascii?Q?XBqnicX3ZElUIFlImgzT00SFZUHe0ZYH5yh5HTnWtKvlXKZA9klsTzw7Vhnb?=
 =?us-ascii?Q?elGKJJMolYr4p8ZIfO056Et5VgFqALK594YxXOHxJFRwzfgjXtvHjNoOS3Ns?=
 =?us-ascii?Q?nDJNw+doBKYqFwQ5/gWS0UEg+rtjxBIVnzPQsj1SivW5IuIQLyNRHX0g9HeQ?=
 =?us-ascii?Q?oR3MpHoAewI32/58+oRUAVvWrfLile24dKNfjnqZALGPa/PTOxGtCzILFH/4?=
 =?us-ascii?Q?NyBSb6tNRHJGQZcBctJlDaNA21EgpfDy6azI65BvEyUJZRhRDMWhcF5nSgz7?=
 =?us-ascii?Q?rbZEqoFE0fZ0YbDXAnt/mLaDQYCtwaXhFW3yFxoD4T9LjQlWMWJckQy7Lu5x?=
 =?us-ascii?Q?dSn4UyxqvWoZFg8YheFrrmnQ+25st2SICPas3AEhptPrGDy2NArvkFluxt1B?=
 =?us-ascii?Q?g7Ii+l9Xj1Bwzq5KpKud4Z6nKzGUcRmZtviLePyGi1hWA7j90pxxxwbn7jwe?=
 =?us-ascii?Q?c1twp1c0FaVQPwgsOBaefX0FzP9WaKyaXfdftFOUMJTMWnJjnwjwVwXLQwMy?=
 =?us-ascii?Q?UQAHo1ELWsNZPv+u4uDsCjB1E7tPA4n5ovbrlRDRbBxGHiCdqeJPnHLokn0t?=
 =?us-ascii?Q?3XlMMUYUbAd+va5ACQRLIJ0FQUABQIc/dCcgsv0Q0anPzqueCKxp6liC0jxL?=
 =?us-ascii?Q?6zPoHbpsFetZ1VdS44GVpVxPUfsFPTiBdE75FSqlnB2gKMw4jfX7KNRWKa8n?=
 =?us-ascii?Q?2fnXteGPLF7Ilw/sDPcWfQUkHiizuMvmnyxZXr8nnkxaehAAYMF8Xcu4Ml/R?=
 =?us-ascii?Q?6ICGevgPaossTZPChx/YEWKhnEv+Hi9mQCo5RNFF8Ac3joSoejCd3QGMAJak?=
 =?us-ascii?Q?1KGDYq+42ZRt9BeKGOXg3TbJtC1Cp7yvEirny5mRU9OeJdXG60+o523ETxUt?=
 =?us-ascii?Q?ELScpSEATTgf7gBm2mKPv0uIfHyIWytDCmAcEeC7mXcxvWhB/8JasU6EcvJZ?=
 =?us-ascii?Q?ZArr7SoFZgvroVk7M/QM6YOzs0dC3pRf7Hs5Adj7wtXZSztCXZL8AcTw7k6W?=
 =?us-ascii?Q?8GzsFAFk10WtA5LcZpt0GDOnukxs/QydKKwOVLEKItzb+exySEU31RsouHlp?=
 =?us-ascii?Q?ezqRujAuBW7K8l/8DeDPgzw0ihTRcDvg89amXM1S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aaa177-c8d0-427e-d9d5-08de0d60229f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:32:48.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kj7nPySQItzN9UciO+5N7MbR77iSUNkWwUlNZm8yuuoJ6GG0MRLIqTf+PojOLM3qOWCD+EOeyHbK1HIZ1hCNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

sched_ext tasks can be starved by long-running RT tasks, especially since
RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
tasks.

Several users in the community have reported issues with RT stalling
sched_ext tasks. This is fairly common on distributions or environments
where applications like video compositors, audio services, etc. run as RT
tasks by default.

Example trace (showing a per-CPU kthread stalled due to the sway Wayland
compositor running as an RT task):

 runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
 ...
 CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
           curr=sway[994] class=rt_sched_class
   R kworker/0:0[106377] -5043ms
       scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
       sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
       cpus=01

This is often perceived as a bug in the BPF schedulers, but in reality they
can't do much: RT tasks run outside their control and can potentially
consume 100% of the CPU bandwidth.

Fix this by adding a sched_ext deadline server as well so that sched_ext
tasks are also boosted and do not suffer starvation.

Two kselftests are also provided to verify the starvation fixes and
bandwidth allocation is correct.

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server

Changes in v9:
 - Drop the ->balance() logic as its functionality is now integrated into
   ->pick_task(), allowing dl_server to call pick_task_scx() directly
 - Link to v8:
   https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v8:
 - Add tj's patch to de-couple balance and pick_task and avoid changing
   sched/core callbacks to propagate @rf
 - Simplify dl_se->dl_server check (suggested by PeterZ)
 - Small coding style fixes in the kselftests
 - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/

Changes in v7:
 - Rebased to Linus master
 - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Changes in v6:
 - Added Acks to few patches
 - Fixes to few nits suggested by Tejun
 - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Changes in v5:
 - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs
 - Address comment from Andrea about redundant rq clock invalidation
 - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Changes in v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX
 - Fixed other issues
 - Rebased on Linus master
 - All sched_ext kselftests reliably pass now, also verified that the
   total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
 - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/

Changes in v3:
 - Removed code duplication in debugfs. Made ext interface separate
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
 - Fixed running bw accounting issue in dl_server_remove_params
 - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
 - Added support to remove BW of DL servers when they are switched to/from EXT
 - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Andrea Righi (5):
      sched/deadline: Add support to remove DL server's bandwidth contribution
      sched/deadline: Account ext server bandwidth
      sched/deadline: Allow to initialize DL server when needed
      sched_ext: Selectively enable ext and fair DL servers
      selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (9):
      sched/debug: Fix updating of ppos on server write ops
      sched/debug: Stop and start server based on if it was active
      sched/deadline: Clear the defer params
      sched/deadline: Return EBUSY if dl_bw_cpus is zero
      sched: Add a server arg to dl_server_update_idle_time()
      sched_ext: Add a DL server for sched_ext tasks
      sched/debug: Add support to change sched_ext server params
      sched/deadline: Fix DL server crash in inactive_timer callback
      selftests/sched_ext: Add test for DL server total_bw consistency

 kernel/sched/core.c                              |   3 +
 kernel/sched/deadline.c                          | 138 ++++++++---
 kernel/sched/debug.c                             | 163 ++++++++++---
 kernel/sched/ext.c                               | 148 +++++++++++-
 kernel/sched/fair.c                              |   2 +-
 kernel/sched/idle.c                              |   2 +-
 kernel/sched/sched.h                             |   7 +-
 kernel/sched/topology.c                          |   5 +
 tools/testing/selftests/sched_ext/Makefile       |   2 +
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c     | 214 +++++++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
 12 files changed, 918 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c


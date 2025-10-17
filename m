Return-Path: <bpf+bounces-71193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE4BE7D60
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B886E5BC0
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49B31280D;
	Fri, 17 Oct 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLJDgWoD"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EC2DBF45;
	Fri, 17 Oct 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693658; cv=fail; b=q9GWUoSwwejZnHUeORygtHEuPcC133wR+6ulRNn108EUGIXpsUuAsIp2XSgLUJltfyM1z8PcsfsQCWBWrVAObEYGUuYXTA21EfND6OSTQXvmVkBKyMP2RQ0SWBnkxSe6vMyuZGaMDE+89G4r56KkhUgySQ3T8YoPO1iY/DJXTcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693658; c=relaxed/simple;
	bh=uOaNe+lNIiSHpXVf2f06hjWch9eSU0R+KgcWn4G9GEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtF+h56OFoSNfts7YEZwZ2//gJaFWZp27JmzjGT3Syc78DvYrDNkai8HaSj4D00/duEpBfkMgvOaNRXI79oPdITqCpLpOeCxjem/AcH+JpQVBSbqC2i1eKL24dpcMn9mtpL3zRn1TeSu3jU5ZAbf1U+403TGyCRj13r5V4XffDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLJDgWoD; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWYpoMU6+G4L48tGVAP7yvltAkYcKfpSmYHLNceKQJWHDw2m/P7aFAOBCtQUEd8Tvy15EVbMC9E2hP9kK5Xpu329wPjGpBjco7pXDC91CIaUENM7mnsK8cOPeYkya1TvcLpNlb612k5QUKLP8gCy5Elqn3UF5Rd14asyvsY0wf6n40dfTYxjhMAwcDM0HXQ/dvoKE8JiHmJX3MiwL8jiz/HtzOsJd+3NC0bQMkQmCzjWtXGS53+i4A4Vb81NKyJiMnXuhr9TYfEt+Aixhw43oF27YkEdz0Ga3/gMdjMo1p+T75cuKkv/ywTLJ0LlcUFdyVD0UbFeybckee6avCULDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt1xwGud42ZJ0r9fFSLLbVFSiSMrty9ATutcCVfkB7k=;
 b=jqJqSnDr9o2lOyXI7+43s2cxusAyTvPbQBcNI8IOW9p7YlG2aB5Z1KRrNbr9GXpWODtHC4AKRfkqmMfkdVeVwody93gwAfmPM9D9XLlVygPq34cftxya15OcTc1mOEg3nVLmj5xZGYXkjlOdE8ByH8K2dZerOXnJxZn43WY7Ta510Vyfca2i+HKX74gcrXAmWelyRa9grbIW8ZajOwb3EqckSTNvTnZYN8h3yS1zX8WqUDDxGKjUT5y/JYTWCqnjX7YloGiVqufj/norR4BZ9kRmWMoZ37rIiEFyAl3+u4v38j4hoozNC/Wt08ZYc5mCmOBSCEdFCWy4hramDynccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt1xwGud42ZJ0r9fFSLLbVFSiSMrty9ATutcCVfkB7k=;
 b=hLJDgWoDxRsjS4Z+w65ed9rs+eg6DoVsgFbLukxAo+5pWstf5Jp7BWHMht3gnE0fiCEZ0Xb/bcYDlcpv8a4hGOD8JZQ/0BzKQ4zBsj8LaZaGr2eER/Ukj0m6EnYDgG+kAfAxNYvwYk6aB93WP7oew8OYX7EeD3GSv9c+7fYvzZxyHEyPSkbfttzggbZo56m2ETh4WNZsUKb5ya8XBBiuM9EYmD5rtR9yZLKF3THd4nl7Av4zDZykj+rv17+2iz9KaDP5xk1d+CeUu8Qv74dj6dZNVDlXbs9KqmSIIb+U/mzWTx3BrEvVnxP51BoTJL/7XDqE/P5HWgqMNmiwO6iuDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:34:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:34:12 +0000
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
Subject: [PATCH 11/14] sched/deadline: Fix DL server crash in inactive_timer callback
Date: Fri, 17 Oct 2025 11:25:58 +0200
Message-ID: <20251017093214.70029-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 362ddfa4-08a8-4557-765e-08de0d6054c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hm9HTZl+CVSMkTj4ZK/zSpnbMy6asGuNKscQFEuMQB2dasPkHo0rDPEozfvq?=
 =?us-ascii?Q?dSlXE1h3r3+aPQsnLR3TTO5pFTj4XmfBxabL5e786DAWsyd0NGVwu2SH/6vx?=
 =?us-ascii?Q?rNIfC0uHTgX+S+ON5Yn0O7fn+nU+n8LnOs5nI6VNBET+SlUouAejQIG8c4Ms?=
 =?us-ascii?Q?8fmYJb08/RK+e6URvAHQdWKfqn84vWRAE7XLC7UQHYfIaES93x64jQOheZ6+?=
 =?us-ascii?Q?pfkv0/QZ8zgZGGUCmjD6y5FpQ4IOkWiqtO6feVNVMd/PFR5BJHaBpVvB1IBn?=
 =?us-ascii?Q?vliU/tOj9YyrX0lqq6OB6+/I4+WgjBYs7QqairfhnQphLomRNxrbLa3LJ0o/?=
 =?us-ascii?Q?cyzK78Ok53wgeigJBKpkcXiWzVGe7OgABy+HPyvQjJUN1/eCmEB8oswXPtOm?=
 =?us-ascii?Q?VHo2m83EPyXo28hwR9TlSpJryXaWhOGCeNr14FlmUoV/WX2VMGNZ50V6ZnRW?=
 =?us-ascii?Q?sPzAAQCtuRXFETtkEljvpIexgOnmGQL8hsjHpP1JtEW8ksrA4s5Zr597rRtx?=
 =?us-ascii?Q?VzZnycNJNvh1g3wBPrZyAGXtOocdujbtVDH6cnH3PGt0okSZDs2g5BRIBeoP?=
 =?us-ascii?Q?Q9yiA9Ad+Z+uSPdjasi3frCs22RGLGGFpJ6i9P2IuWIWDLIDmB5AxCQa7Yzf?=
 =?us-ascii?Q?unH1O56PIZ4g3ldJm3Q3SstvZ1upeM0GT/ugS8O6k8ifrXyTxMQPXQlf9JX6?=
 =?us-ascii?Q?ru8qGCYoQ670yg/RNyzzBmJdog3OnWleD8xc/rTQ4s2hrAjYhUkIpNDPNDRj?=
 =?us-ascii?Q?Jt5Up1IL1RPLxo73LJ7yaSddCGE80X5FF5r1s8xAxbuwdgo1sxAwpALtvFA4?=
 =?us-ascii?Q?jktJJnKz1sX9Qj0BCTIeAjAfqzImP5YHzftwYGTAK8MV3IbouItR0ZhGm2n/?=
 =?us-ascii?Q?W8CPpKxsOMbprD0ztuuT1zcm+A5aZov0uRbpskXoM02CEBxE9fL9flAYAUfF?=
 =?us-ascii?Q?UQzBNpZumvh2ysRlHY4TnPfee2YsTCtZtZ7J2Pte+QHTZ6E5wmQBEtYQvaHI?=
 =?us-ascii?Q?XltxK7LWzoQCWFu46Jk2z2K3fpjXYUYzIOuc3o4HsYdIh9s4iaC1otKJGn8w?=
 =?us-ascii?Q?bZJWtV9MFv73aYQKZYQ3GY3qvmnEmj/QoOlH8ZwFAb4QQuaewJPTd6/I/ofp?=
 =?us-ascii?Q?zfQQkfx1/iLIgRFdPgq/xcpxnHHcZHvp4pnWJirpPVmpMVISs0fz3kT07lVQ?=
 =?us-ascii?Q?FiKhz9IVDBLjaallyRLDIbhH6MDg+pW0JhEJ+mlUANJFq+Mv0/EsHtVkNmlj?=
 =?us-ascii?Q?jh7o7LNN4rtsNjTRdAzKMqH81RhoFMzHpINGFiC10ttROsYWj0dCZ2L2h7dc?=
 =?us-ascii?Q?0Kv63cwbI3GeudKLl0H5hD5pYiikf1TnzlaZxMzlZEQLjztQOR4F5FooGPYs?=
 =?us-ascii?Q?qpXmXXtV9BMoeiDY+QSZcuCXg6FVuHKEE91vhVARAix7+ZnbHEnD0Sg7vJ80?=
 =?us-ascii?Q?p/pJG0Amv5NLA0BdSEFzypzdjNX3p1X20+Foz0OHvvl/+S/XIqWKNk8Gt2Nr?=
 =?us-ascii?Q?bEX6jVM1+0Cp4eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFuLYYzNX43vNnK2SlNHPpbYtdQLCDfUvNhaA4qG5HJYksWfYopTVvpcwRKl?=
 =?us-ascii?Q?bZdWzWIr/UH8db2S6bkNZ22lYTeUyGNXGVLhMvIo2ULtqfNtlSpFjLKoZN7n?=
 =?us-ascii?Q?JpIHTCf3y6cqmZxVfIalQcid94k0q43EatzRllwvpjGmgLlOP3KxsJ0lQJ4y?=
 =?us-ascii?Q?fsM4XZW8lOQhRrI3iePqMqZL4/0wR+JCyRAAlbgHku8gcfbZICc7qI9PXCDl?=
 =?us-ascii?Q?mHzyZAxOiAR8G9QdLgT8u6SVmfg6EJGPT+2Zmju0vLm6XIuMXh1AdNl9BOgy?=
 =?us-ascii?Q?b4bRW3zjPuZEEVDj2cBAXqBW0zYmIlnuQVWfMCOIb8XPg00t1mAvjsplgwS6?=
 =?us-ascii?Q?dzg37za4g8mNPNvZXw1jAOTF0Yc8k+P3bsU2nxLkWSS2MqrOkUUe+zW62rRN?=
 =?us-ascii?Q?zjT9og8/RBAbWpQDloy9LM152MAGp+FM539oO6RAFulDO8GW+0KEkyQXW4Nw?=
 =?us-ascii?Q?TES5GNpSFYmQeEfxpwj8TxUM/3dkgnrrwJOh6nGdlSDHiD95Vv8oEXzkpQ7X?=
 =?us-ascii?Q?dWwxgYGnkDsDgTFofZsZx/D9DMgdCEy9DOWcHXRMDJRF5lyJ3+4l0GEC5cha?=
 =?us-ascii?Q?aTxJJHN3zUKMdbTTH7YsKsWKEr0P0wjucFDfr87xeIgDlg+0zRxqBhGfSvM0?=
 =?us-ascii?Q?XQjxUOjIIBBU5KrwKjeCzzodfy0LQkVw0xvPsl+2mLcm1il2WRy9F5YDOAbH?=
 =?us-ascii?Q?R3rhFEfYgLLg6kYvxa13zWPRmgDek78bmybcFLSW8Da8qnZfWkFlgrIEQvwj?=
 =?us-ascii?Q?Gud5pnBhaY40fLrpnuakEU4pkkfFQwDCoA8/nJTlkp0MfKO9v7KZYQY7MYkH?=
 =?us-ascii?Q?Q3HRXg1xtIdnDl75NEeMJ8ADXBvzOVhGxTh/36fR2r3ayCvAvoW1z5swl99p?=
 =?us-ascii?Q?a2JkHy3jWQs7gqu28Qsv7RGG9y5ytpvP5HNFgwaYDm3Rh5WUmlc0yXgjdR5U?=
 =?us-ascii?Q?EmyCVMgtmKCD716nhIOs5vA3scaCVG1ILztFRvPQ2/NCOHRn6VDmqBHL2K0h?=
 =?us-ascii?Q?a7m7pIdtG9AgCjoSN87CzjQTaXeUU4AIIM9CMkn0K7ggNZQ6lJuPV8C6WL7Z?=
 =?us-ascii?Q?u144M6ymL8uJU5yGKbbRJK67EXmlasbvA/+XYmaiEuHJMSBf6YocLp81FLAG?=
 =?us-ascii?Q?ayz8gr9IkS4rsHKA/zi+Of0EEYlR5uxu0Yz44+fSj1Ip+ZrxRmejhxjbUDZt?=
 =?us-ascii?Q?5W2gMLzo5JmxwbUUzic/nvgcB8JpuUA6yHvqcmVwgRQ9ULy4kt3NJTJPgYnn?=
 =?us-ascii?Q?KhoCjiGh0PKYk9knlTxvRGwXM+Kn1zPhzlg/Uo04EHzgXtJEJPEQNr50fKhw?=
 =?us-ascii?Q?/PIhk+7KfTlpveHrLe5iqQLzTi58nPl4K9v78vXS0Fcow8aW+qpBQTxtk6Rb?=
 =?us-ascii?Q?hHAyuMablIAUhN6P3/kM0MrQnXabttrK1e5FdNo7Z1u7zGHzvrOAjXBeUkh9?=
 =?us-ascii?Q?/bV3vbWMDxqbrC0eNX1tr2m84CGRK7Pljz7PsyUUnsdaLZyqjOiDjBw8b7fP?=
 =?us-ascii?Q?DPUXqZdKU4a2YzeP0JjmYSomv1P+TiHW+gYNAJ3lCt6x0msEnfWcE2ZPyLi9?=
 =?us-ascii?Q?bkhuDCWWym1Asj+Fpea+epvi2huClI7TV+f3m3iH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362ddfa4-08a8-4557-765e-08de0d6054c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:34:12.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGDpyqUcCA1XlxaqyDXLGCdf8JG6npnZlJ4kyWsA/1IDmaMe9vWbn/wi81xKIBHLKaALfUcx07iErakDYY+0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

From: Joel Fernandes <joelagnelf@nvidia.com>

When sched_ext is rapidly disabled/enabled (the reload_loop selftest),
the following crash is observed. This happens because the timer handler
could not be cancelled and still fires even though the dl_server
bandwidth may have been removed via dl_server_remove_params().
hrtimer_try_to_cancel() does not guarantee timer cancellation. This
results in a NULL pointer dereference as 'p' is bogus for a dl_se.

This happens because the timer may be about to run, but its softirq has
not executed yet. Because of that hrtimer_try_to_cancel() cannot prevent
the timer from being canceled, however dl_server is still set to NULL by
dl_server_apply_params(). When the timer handler eventually runs, it
crashes.

[   24.771835] BUG: kernel NULL pointer dereference, address: 000000000000006c
[   24.772097] #PF: supervisor read access in kernel mode
[   24.772248] #PF: error_code(0x0000) - not-present page
[   24.772404] PGD 0 P4D 0
[   24.772499] Oops: Oops: 0000 [#1] SMP PTI
[   24.772614] CPU: 9 UID: 0 PID: 0 Comm: swapper/9 [..] #74 PREEMPT(voluntary)
[   24.772932] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), [...]
[   24.773149] Sched_ext: maximal (disabling)
[   24.773944] RSP: 0018:ffffb162c0348ee0 EFLAGS: 00010046
[   24.774100] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88d4412f1800
[   24.774302] RDX: 0000000000000001 RSI: 0000000000000010 RDI: ffffffffac939240
[   24.774498] RBP: ffff88d47e65b940 R08: 0000000000000010 R09: 00000008bad3370a
[   24.774742] R10: 0000000000000000 R11: ffffffffa9f159d0 R12: ffff88d47e65b900
[   24.774962] R13: ffff88d47e65b960 R14: ffff88d47e66a340 R15: ffff88d47e66aed0
[   24.775182] FS:  0000000000000000(0000) GS:ffff88d4d1d56000(0000) knlGS:[...]
[   24.775392] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.775579] CR2: 000000000000006c CR3: 0000000002bb0003 CR4: 0000000000770ef0
[   24.775810] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   24.776023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   24.776225] PKRU: 55555554
[   24.776292] Call Trace:
[   24.776373]  <IRQ>
[   24.776453]  ? __pfx_inactive_task_timer+0x10/0x10
[   24.776591]  __hrtimer_run_queues+0xf1/0x270
[   24.776744]  hrtimer_interrupt+0xfa/0x220
[   24.776847]  __sysvec_apic_timer_interrupt+0x4d/0x190
[   24.776988]  sysvec_apic_timer_interrupt+0x69/0x80
[   24.777132]  </IRQ>
[   24.777194]  <TASK>
[   24.777256]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

Fix by also checking the DL server's pick_task pointer which only exists
for server tasks. This avoids dereferencing invalid task pointers when
the timer fires after the DL server has been disabled.

[ arighi: replace ->server_has_tasks with ->server_pick_task  ]

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 16e229180bf46..7889e95d3309c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1784,7 +1784,16 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (!dl_server(dl_se)) {
+	/*
+	 * It is possible that after dl_server_apply_params(), the
+	 * dl_se->dl_server == NULL, but the inactive timer is still queued
+	 * and could not get canceled.
+	 *
+	 * Double check by looking at ->server_pick_tasks to make sure
+	 * we're dealing with a non-server entity. Otherwise p may be bogus
+	 * and we'll crash.
+	 */
+	if (!dl_server(dl_se) && !dl_se->server_pick_task) {
 		p = dl_task_of(dl_se);
 		rq = task_rq_lock(p, &rf);
 	} else {
@@ -1795,7 +1804,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	sched_clock_tick();
 	update_rq_clock(rq);
 
-	if (dl_server(dl_se))
+	if (dl_server(dl_se) || dl_se->server_pick_task)
 		goto no_task;
 
 	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
@@ -1823,7 +1832,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	dl_se->dl_non_contending = 0;
 unlock:
 
-	if (!dl_server(dl_se)) {
+	if (!dl_server(dl_se) && !dl_se->server_pick_task) {
 		task_rq_unlock(rq, p, &rf);
 		put_task_struct(p);
 	} else {
-- 
2.51.0



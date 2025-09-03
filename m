Return-Path: <bpf+bounces-67270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F8B41AA2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7141BA5640
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09E2E8DE5;
	Wed,  3 Sep 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfXQbJh6"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669052F5319;
	Wed,  3 Sep 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893070; cv=fail; b=Ufpe5uh6dzBDoHyhR7rsED9U3KBhlZHXri1/vENmV5ymaonju+VI664csMoAp+wfTxpe/QAacE4pXI4Uh214T/pSQ1qKHtJOkJq+i3lag8ynrDC+h/11w1JSe+JRTs5TaT7DI3fqQSz5e/CaPGXDTM0IeQKPriiL4RV2PvpqwKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893070; c=relaxed/simple;
	bh=61l3mEdIyIFpeC4cjkAZPKEVr4v9qyL8SUFZZ1+hx9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CylOr/QVH9i57JA5ALf06vPzEUVgHcqB2nKe0GRnZ4dIXdXVRFd6l5LFfwncSXsaJP1xa2T8o2K4aGn3WW/5EdGHAknAR0PrvvHzkTIQWVyrF+ZUgg74+jIGPIpf8FjBFXf2w4lABuL0HvbChgNegx5h8dymJ1c8RGcaN9xt2wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfXQbJh6; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtwHwGJSDfKLP0gB2hhD7ACe1AShJdRy9x6MuaDlVArtJ9q/I/vH2L110Z3j8rR7bxf40/2Om6zEkH3X/kcWWt1dTU9XLERl00OjezHAz22nLCnxf30v5stosu2dxQKJfFbMaJdDv3Aiqdhdmz4xNUX9Xdlx4fvcqLchiJ4NgA8XUMNHJRuvY01OlW3BgxFxzjbgQSVROOT/uHI2R1SWUwUqEm++WFZiCjWHauArzphunXqIeZSqekAMsd5BTKu8nJSem/RDmFD0tKeOu41HwqFeTPLPT0VSoAlKIGIdW/wKma1aFfJWsCKU6n8W7vCa2xwOVR3CLy99+NN1cMQffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C18gpXQK7lLAGNGpY4AcmTtNRv9oCLbq3Yf0l2BON6g=;
 b=iQY3dnNfiVOMtmrIOv0hmDy+8CUF5HVQ9XOZtaNg2x/ebApKwxqp4h3ZfY/WieciRnBLkjmRm42cscNtvtEwLvpy4FsQDoeoIWdPo/iGGb9F/QeopfC4yYeD3kNsvtdbt9q+5iw0yYtw+87hhVWVtwRmLo1u+6QnB/wsu8Gzy74v9sFiwEW14szeb43748d6gTZhnG3X1cngjOY+dU7smkx6/9iA2oOP3ls2LpYimwZc0R2iGXB4rLA98cokYcwc9aEyJcwUUECycAkuD3lcjRJWSZhEBmMV6iho8OwXAgVmz/CAgHzs389IjO7x7x9xNf+l7kTG6b4JOmiQ88MAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C18gpXQK7lLAGNGpY4AcmTtNRv9oCLbq3Yf0l2BON6g=;
 b=BfXQbJh6n7urxnnz5M2NeoJ46GU0wrWOkm3WU9VkxjvitF5xWOIRt1vNAhQqgBtdCJYabMDtRKTrbD8yUT/pjWvmXc/jthaob5SVPkmAH9xyoVIuJeytBLXgGUqxURUyitwHDR9s0gsx27jfGE5b5lQLsDA+rTrrDvE8Ask5OvVFZcWAdUNyyVP3ic0boOe38MZ5VfuQLKCH1+4ANVGssrpCb/AgtU1qwssyHgpHx6K6oNy5/JFtqDo6eNDeDte710E9n2KSApJSdTYB1i9G1gyGHHTJ2TD3EkXK9ReNuEDfoBwrLaFilDJc7MPIBKg0AjibP/2LgMvdV8AxTooLOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:51:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:51:06 +0000
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
Subject: [PATCH 13/16] sched/deadline: Fix DL server crash in inactive_timer callback
Date: Wed,  3 Sep 2025 11:33:39 +0200
Message-ID: <20250903095008.162049-14-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 5751aa4f-f153-4a90-6f79-08ddeacf66b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axIZDs7vH/PEAhkjI6kcqo1LTcrl3EOUXOMszmgM6/Nmi5ZbSoFY3hpG0bZp?=
 =?us-ascii?Q?Usj9/WNfyzwlWh7s4USrjPp6iMIQE59CkL+VXc2e+oLJ1poDeGy/Rj2j0oT7?=
 =?us-ascii?Q?OJL5Ify0ARKWxf3BMUIuYmXZAS18EG26N+2jPAOWjJUKNgLXuZ5n2Jd2cWEv?=
 =?us-ascii?Q?acflMxdNPJJLHxj3nFCXpDUtcdzbgDTttpKSga83OLh+PF4GaMhHmoj2rezK?=
 =?us-ascii?Q?u6vAi5k1HUSxY7SQ5azeT6tbmAqnNq8nW9MLkneNk7pfn3QeFn4+vUSas8qp?=
 =?us-ascii?Q?2vii2CDg4/+vQByMAE/SltQxQpnYh/inBWGoRqj863gqZvGeouik6zrE65B+?=
 =?us-ascii?Q?hhh1JgLxeSWVIbQDKG1wfNQj13H+QYeao/h8P9+msCyFfggSUhfOvLGY+QTn?=
 =?us-ascii?Q?SXeq3asM6jCM3W9w5rGK1ZUD4yJgUZ4bI1veFD/fOmJw+p1WCF14liDlh1TM?=
 =?us-ascii?Q?dOCfk7q+SDKWdFMarHYniHKofEpZticWhl3p5+sftheIBWsJb5DVyq412x2K?=
 =?us-ascii?Q?37/Vk97HAp8zFPWCVENkUXXBfURU8jg+WTefvn7H5ZyvwQ1dRq9c5q/SGjMc?=
 =?us-ascii?Q?ORTzsR44J4RyY/Mm0r3me5YoOQu4B0uwIP4adz2tMfWwp28bkfqlNtnrHwtF?=
 =?us-ascii?Q?hV/beowNlJKhLRaSMpJsKXFOnRDTDkI6I+kURnccgteuPsFx1xvlB7zjKDDq?=
 =?us-ascii?Q?IAqCqAyVtc6w/ro/TSxuv9FsqwFWPyUv50NogsIlc3SNIvN6mvYlgjNty/cS?=
 =?us-ascii?Q?YpNo27DSl5xXt6JNY1IPFx0Wdgw99Jm3UVqNVCIkw/PuwNHI6yvNlCjGdr9M?=
 =?us-ascii?Q?64vxP0waeCUkdGjGnGfX8Tav7Bk6zizWLH+hXF6x3p8TChlVj6kRvHdemp2A?=
 =?us-ascii?Q?x7oXsBxf61U9i1+3FkTe56OPQ0KiA+ErpgAkwz2aL6mdvHyj6/Vi4zkMIepc?=
 =?us-ascii?Q?/uQtCF0L4pCaI8cr9zSy055sdKcSwq5DkO8+KOpEaS+mPvwXq7vmO03U2jri?=
 =?us-ascii?Q?cB3F3Vlu3qQ6oBU1vGl6pjzTlM2HHxswaqLhwf3BOhrHVpZPW3ZkfPQA632J?=
 =?us-ascii?Q?CcaPYCpUtkT6SSmvmMMEbmpPoelAOLQ9yxQ1YT/Oyu17TkStxwJnUcd1PJUV?=
 =?us-ascii?Q?27uvVtvEc/6hXlNDTWebTmVCu4adouncK4dfQw4w0rrefSGrT0BEA40Vlftt?=
 =?us-ascii?Q?slMvRGUfHkK/E8zWVNuUqQHWiF48Ymqc/xUkt6hTpGlh9JnVmReR40KcFTZr?=
 =?us-ascii?Q?DwKiIKZ2WQXXXEACORBlr3tE85K6KbyW3hAF08OUQtAenGBfHQZGn/+TNLt+?=
 =?us-ascii?Q?9LfVOeDko9NXwJq5A8abcm/eChxO3uMOsOcivsZZEtjzzO7CCI3+we9HcBnA?=
 =?us-ascii?Q?WmU4XY1TxVyJqzNIwk6mz6UC45HCRRsEBCUorhhssOdNdy0OXWJzNuJyUzhw?=
 =?us-ascii?Q?CCweBN1403hAVDwjrfA5iaguvNIAQb92IPH1AhRM7/YHUJz4fa3DLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?869Am5W5awSsZfhONCJbf/dna6D2tWYi7r57t89+wPjWyg2U5yqKkVrxwQ8u?=
 =?us-ascii?Q?8PB7iX9ysgtYWSkhRM1ywmSzorZcsQeFz5FMjrO9m3Nu8iPnAT6mHtQnQZYL?=
 =?us-ascii?Q?6cwY+NHN4tKC32n18g1PhodKUaaJaQ7KWasXtfE1VBNPUI32C37ZoM8J3dOa?=
 =?us-ascii?Q?uzUx6gQo4A93ZUUJcoz2kbxniYuIW+fvY17Zm9C4kbiu7mlo9QGMpMcTeffC?=
 =?us-ascii?Q?K2xtrxPVQVOSMPczIwzy7cVNcUJHVIfZMg5a8aGwLK2Mk5vXJmhPjcxD9zYE?=
 =?us-ascii?Q?Z60vCyzHGB0wYxxsDGqenLwY4RMtTmJUQDpYw8HQ2a+qAi8tmRoNdAC/2C6C?=
 =?us-ascii?Q?ChNS95IEgZsvl3nacHyI2wItOUQ6JVcxJxz0rSay+S3Bos7+g+LYWtcBxClC?=
 =?us-ascii?Q?/3X/1q3DDrSeREeWxnRucluruLhhbvfKi9XcB7/QxwgYr/IpiNJivT/GVnIE?=
 =?us-ascii?Q?hM2gJcUPZwq//in2EP57SRmy5Xb+sQJUKb5gZqEVRCfvdmppvgpsJpR+C5r3?=
 =?us-ascii?Q?aXQmyOAIfDVkgfo3khSkYaxWfMPaaFrwFI0EqpwflzjAO0X7kCeCOHrchWUI?=
 =?us-ascii?Q?Tagssac9gJpaGjaIGYr6XhdeYkl0YFuVjgdQNtAnvSfawOxTFedZYt0kyXN0?=
 =?us-ascii?Q?lhH0F1bcJJoadL8zy1GA6nZbC4X+oLMqK9Xmq33xHlu3drX1gx0sdp9PQMRn?=
 =?us-ascii?Q?2p7duGxpp3LuelRGifB/aAu7hXECvrF1O37Lh8XPdQehFzO8h6kkKz9sVM20?=
 =?us-ascii?Q?9MUvMEz23uznl8N8GWqGmfwOqKE2cOY16LXBitzCZmPr2urxHxz/WV76E+Mr?=
 =?us-ascii?Q?2i5N8wQjK9HB7sqlo8UiP1i0ri1pp9OrgDofoisFkFgmV6qhGQdXFi61OJYX?=
 =?us-ascii?Q?zZOEd5Puca8qeSq230Jz2QqiRDjppFgRipJldXLLquP3imL7jdGmTC1rH/tL?=
 =?us-ascii?Q?V0TSgat+XAjHj4iTu7NBqfpbChZcAZX8z9/r6KSLPayrgN4KmlxZQ7SI/uF7?=
 =?us-ascii?Q?8jB35H0bEaeKw1h74mF98bSp6n0SmxQW0z4lljwfrzFPD/FUwKzGYbDwOEP6?=
 =?us-ascii?Q?1AsGCpEEiYixy+zGXhzWwcUeKCtt+FFF0kgl+Pv2XHuaoZfNaHB6+yPPDHfp?=
 =?us-ascii?Q?GueQAm07VBS96KSTu1XC+TqEQhn6aLxICxSOz5jsbmf3fPm471kBhxTT/gty?=
 =?us-ascii?Q?kJLY3KDC6q8q2REyMcIpN+aB0M8TcEWK2PKKhOuu2I9xOBtOPYAb+myZ1nWB?=
 =?us-ascii?Q?bl21jtXZFWQnah+lhY8Faa/REdzyaKPsERxWQaMS1lvBVCMJJE+DjJ7YysyD?=
 =?us-ascii?Q?P1EJpzcXWXlO1Saj7UOWZ+nDEMfiO0LbIK9quR1iou4yHsm1uSWil7XWlwCv?=
 =?us-ascii?Q?c9ZdHIKuGAhwDUvgMcgX7oiJ1XIEXezhgxCsxMYrqp6ZIUyoHoEFkBhRr/Gt?=
 =?us-ascii?Q?F7Ld+2GwcRTR2Ze8H6Y6xUnZnymubM0InEh27J0d04iuA6oN06tgCV5VU5Au?=
 =?us-ascii?Q?W8PHyyqG26kRdMKDuPz6Fj9Jl0R9BkkMXiW+vvIZmV4tfeXLUneaGqkBossy?=
 =?us-ascii?Q?D5HvsQ12RclGRdNljJzvoA+UsgGL6MtmKNjk/PKq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5751aa4f-f153-4a90-6f79-08ddeacf66b7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:51:06.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJuPqEjnCYYRvNUI6te0mXKOIjkZuVfoPkUNgMZEeTW04KS0XB5PBqviBPgQYct08N32G5t8UpaylyWYWlfhKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

When sched_ext is rapidly disabled/enabled (the reload_loop selftest),
the following crash is observed. This happens because the timer handler
could not be cancelled and still fires even though the dl_server
bandwidth may have been removed.

hrtimer_try_to_cancel() does not guarantee timer cancellation. This
results in a NULL pointer dereference as 'p' is bogus for a dl_se.

I think this happens because the timer may be about to run, but its
softirq has not executed yet. Because of that hrtimer_try_to_cancel()
cannot prevent the timer from being canceled, however dl_server is still
set to 0 by dl_server_apply_params(). When the timer handler eventually
runs, it crashes.

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

Fix, by also checking the DL server's has_task pointer which only exists
for server tasks. This fixes the crash.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b744187ec6372..84c7172ee805c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1807,7 +1807,13 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (!dl_server(dl_se)) {
+	/*
+	 * It is possible that after dl_server_apply_params(), the dl_se->dl_server == 0,
+	 * but the inactive timer is still queued and could not get canceled. Double check
+	 * by looking at ->server_has_tasks to make sure we're dealing with a non-server
+	 * here. Otherwise p may be bogus and we'll crash.
+	 */
+	if (!dl_server(dl_se) && !dl_se->server_has_tasks) {
 		p = dl_task_of(dl_se);
 		rq = task_rq_lock(p, &rf);
 	} else {
@@ -1818,7 +1824,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	sched_clock_tick();
 	update_rq_clock(rq);
 
-	if (dl_server(dl_se))
+	if (dl_server(dl_se) || dl_se->server_has_tasks)
 		goto no_task;
 
 	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
@@ -1846,7 +1852,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	dl_se->dl_non_contending = 0;
 unlock:
 
-	if (!dl_server(dl_se)) {
+	if (!dl_server(dl_se) && !dl_se->server_has_tasks) {
 		task_rq_unlock(rq, p, &rf);
 		put_task_struct(p);
 	} else {
-- 
2.51.0



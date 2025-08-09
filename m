Return-Path: <bpf+bounces-65298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B832B1F5DC
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 20:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4BD189A968
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077261F4621;
	Sat,  9 Aug 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PeynmFru"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63701B3937;
	Sat,  9 Aug 2025 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765302; cv=fail; b=SdKFkK9z22oWxMwxaZ+vxOzf4/+iCLLt7yziUAYEQdDxTZHRkeJ1ad/ppVK/vazug/5/PQ3mq0+3ed39zP8r7lDxeqSep9aibQ7etbe1zrU/zXe4/xLMONrdb4ine5sseDo49KI8CwaRA8WLx7TeW+UBzqvauz8P6b3FM3BTTmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765302; c=relaxed/simple;
	bh=16qRD0VzOoftNGdcYp9e/G3Fdz5aDOO2u1EA5L6LRwI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dib8D0rBvLNMnqs+d0jSClYRwZhVE/O6rxwhuj6Q//rss09pbmkMSrcllHReD542gkXnMf29L7q/F4w9My+26LdOzs8y0vgx+WzIP85Hy0/r+XSFUE9R0X9JtIGJAVBkRlggiDlDrwqwUGzXVCs4Jcip3jXMYaWQxUyi1J70WSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PeynmFru; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVdh6LMbTEn5CGToiYFJY1KiPGW00RwY+tYP6gP+yP2DGi40cwtv+xSmck94meuXNWfVzu0PEJHomBVEJKM8ZINK4/mIzCus0jhGau3n4DFv6sfTkt/eN3yBjZbmy6+6D2k0VmD6GWl+Tc4U7pzxfpf6CofFmmHvk3oRBPea7iO9IPc1rodUawhPQeIuB/EhygsG5xAnMDrgKIqrf6zkTtP2eJSUkA2Lu6jpzogdP8ffEYb/QM62VdJhCFd9Zsg3qlk9nKiGKZ39fblbvwUsW6symHqA4ZQbw7osva63gOeh8D25PdWn7tpYk2TaE5XWWgLEhVDccw78EjktbeOTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVVkWBb9SNxh7a5/sR3lgKIDb/roxMJjlHgT66xk27g=;
 b=qdy6g7A1dr2pINQb6g7QGrv42bkK1HDGDZgMsqsDCexK/llnfbkRsgZQ8aF7FbnxGh8EUhQACJiLtw7RQVqPfCk+WudVFZykwOrGe+m6gMjIauXIienwNhe3TQp7w60kh3+/fD3c1tg5lMms4ketnJqeo7N8NgTKFBW7buKFswTlI1Yr9pUdqWZFkfUFxacDC8FX8VybncsbmKh2oiGh5Gah/J9UYK9gd0AkJ4D63KcxHDKFwM/JY28G3wF2aYjkVbUUYO3wgGCp3KzIvbckmix/FYcL4rAauuszT/TdfLMNqgH3ak2ezpGZuAMcRqKCw1bVTz3LxDkwIovG4WFomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVVkWBb9SNxh7a5/sR3lgKIDb/roxMJjlHgT66xk27g=;
 b=PeynmFruFgdJvxUIJpKs/yY5jvEtwjPK2sDpoGuAsU5ydLhrliD6VXDecYfOdN+TaxP9nqX7ZHEKyO0azJHuIKEws8/Q9wsFU18LXgDw+4oyeLjJT0cu/S9tPNVMGl4WSqhSXh3A9NG+y4E9p6ZlXekdx+GEOIXOMfkclkWmeI0LOuOF2LT2anUVy27eW60HIIwXTsKvG7UAtEu3ozNCb+oQBV+pXBc+WbLCOFR87uckd+8SIkAaU7zb37kuRXG5EqxcUsyqU/KuS1943dKUpssQtKYHkRJuY+/Gx6MQJAmrZZmOC0P6vMjxfCdRVvfOxLvFFnMhOmwqe79Otqriwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:16 +0000
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
Subject: [PATCH -rebased 00/15] Add a deadline server for sched_ext tasks
Date: Sat,  9 Aug 2025 14:47:45 -0400
Message-Id: <20250809184800.129831-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:208:120::40) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3082cbc7-ad7f-49be-1d35-08ddd7754d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+6rykBa3Gv7/h9PWmx4SvJq68QsnIOcPtJEYSwc8eUuEdQI9l88Pz/K+o2s?=
 =?us-ascii?Q?uVnn3ne1B8t3SohzoOHE1/xSzsm5Ekh0ou19A7XMzgI1wO/FnJeP0/iUURz3?=
 =?us-ascii?Q?u7JoPaYEhrzrGHIo/jz+Fdk+Ku+xxtnA/ecJqBAsgp/YlEFxlCi7DsBdIjFa?=
 =?us-ascii?Q?TRipK1rOtymfoN3a7hdIyO+UTHn4iLbHUBXqRYIRYXM0HtFfvzGGQB1kPjbJ?=
 =?us-ascii?Q?XWCFTvE6B609bM5hRnPyWos70alU0/cBs8TzaX+WpaQPNFy9hYtPQESauGW7?=
 =?us-ascii?Q?yvdNLKQ04NHoTmVxkBCbyO3rBt2ajK0K3k+vT87FKJNdJVy/W9SYNMVWe7jq?=
 =?us-ascii?Q?3+RvJSYQaF55mAGIs6599ZZ7oAqnv4UFFQjVIFiSXNvC+N7LmFHx1BneriAE?=
 =?us-ascii?Q?saJsa/t+Wu9FKIVqUk0KSGue2EZ0d8CEB2YRtEQbdKfGdJyWKvtAWD+TUpst?=
 =?us-ascii?Q?sag78y8Z5H7zdYcA6thVr38KnwcrpjbNV61H6uBSEqrXmzAssal18bbKXTn5?=
 =?us-ascii?Q?iGvzvbMzVb+S/XDFvIvrEfcLtBUD/qDzULKwPBgptz+eRolZIcVaePB6VIwf?=
 =?us-ascii?Q?x2gckqz7j6ZndbxjHa2Uo7Zd0BvqkLYyUWXrva3LmZNEGxgWNuxMVgrsI+8Q?=
 =?us-ascii?Q?Y/RTPp7ldRLLXioIml1RG3Qn0YqhD942bLAyxZeVKPS5skJiqgEHYoe3/RuJ?=
 =?us-ascii?Q?CVNHacA2NOBT+DcGgnsbw8yYu5oRcZdpYX+Fk0vBRl/ky9TRCU0dOJjh/BBr?=
 =?us-ascii?Q?DG7xRxtafWPs+TU90EI0fRvw6eBTOojdZE2bZA8CIVpTTiieZc0LSygX7sjD?=
 =?us-ascii?Q?C8vAYsON7+RAlD6N4/pgy1Z0sT92eBte/BmgYMfXGafkpHvyXkPhkYf9bovK?=
 =?us-ascii?Q?x5HGTs8S27+OqMyLiT8FvTAafPowGQMelEkaEm6nXzzsrWF+opVZBs2lN0vT?=
 =?us-ascii?Q?s4GqHnSBqUufqTtqthZqR5MINNxe8BMvTtRkEasoSOghTTQye+5GdQloZ6gD?=
 =?us-ascii?Q?rLYtRJpmj8xQbXPjM4wp11vD5HsA/BpyScj8Kkujzif2H8uatihTlQ2yzBp8?=
 =?us-ascii?Q?BfJVGALksBYhWjmhzyBgNb7WyY7rWgIteMZ2qUfYNjfXZvJ0keN4gV7rJlwg?=
 =?us-ascii?Q?QRL2q7rt6+ZEP+bWmt/c4bC7cmzKy4v2ky8gPDcQCPSCkuIvYmScSz3BmGTa?=
 =?us-ascii?Q?KgsREOAJ+rRLaaDz2Y0Mb4lkA1HhIsvcK2wJlOXuBKYN87jSJZarmrrugIrG?=
 =?us-ascii?Q?wzw4orbayaDhSYRUJB5i064D7gHGya+sh3KG/mrWpLgSyXC+QOmCdCjWpMjd?=
 =?us-ascii?Q?7ifAIiPVV4z49/E4LOvRdmCZzmm4xE7Ifi7bFgzmiqzVHhrSilp9unitPCQL?=
 =?us-ascii?Q?PevBcpSJ2jl1skPDeof9U8zzr+J6QqMf2SZqzqNYxbwxyLrQHU1B+3y9RIB/?=
 =?us-ascii?Q?3L9Wkig9siU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMHfZFD9GQKrMEJxH8f32SPdgZ2JTw4QILYfidk6/V6IXCnVPq/xkPYOHXW2?=
 =?us-ascii?Q?zFfUHr8FvH6GMsRdDyoykxuwwGPa+xwXjgLC0Fr8kT1nh/HcHOdvcR50Z+S0?=
 =?us-ascii?Q?V8+jrd5Uaq21qepEtJCn+i3J6aGQKtnaf2HEq21HNMCLgMT0YB+M8Vqfleqa?=
 =?us-ascii?Q?Wbc9yBzf5S/eb6gGLZiO370YSD+37GJ2kW3mNLjBMz+GT1nSLSEB9RP4JOwj?=
 =?us-ascii?Q?xQ1P7qAjy5r2CJ9BZLain+xFnANXHkKc2t5JIFxTcv/fkl6m1C99Q7Ba9JNA?=
 =?us-ascii?Q?9hAOgVChEfRR4xHeSEBJENoZ0lRpcIQvC71XUlx1Z5X36KMNOWMs2pHJrf/H?=
 =?us-ascii?Q?pY1OGEn6zY6gycz+fnU5qgY4MaLeAOpjyRCSwE3qzaleUrW5L0eHPh4ykCQm?=
 =?us-ascii?Q?CTM/KSdx4FdSRZYcVhUAuis08caALrDIFOysqh5IZ1N5rk8QuEzEls6B9zal?=
 =?us-ascii?Q?UeVUJb0kcPdHjHUz168RkTePoDPhlnNUIthA5OXiqdz5pKQp3bImYYzs9KTT?=
 =?us-ascii?Q?cYaxWra4vnYCnhS4FrRwj1RPgXjUiK5vZZjVwbB4xsipctYpGoG+m+3s353X?=
 =?us-ascii?Q?rrsANJ8wsOVgLEnw/8JsYM08e1SYHtXeG9JEjh3jFaLc9mrqKrB8V9pfMuPq?=
 =?us-ascii?Q?RMSslkFy5J5L1T7t7j7fGRBDj5wi5Ef+15bRohdNhAySMO0hvj1WOfiBnJHn?=
 =?us-ascii?Q?UPNsZvHvE4FW/TAAU9dAqNL8rz0jRMeMGT4w8tzBsY0eNlEC9rs+TrT75ckJ?=
 =?us-ascii?Q?nDpYCixeWQH9BuvKuDdAainXkk/pJ18mIIYctVsYTmH2se1Hk86/UEiOYKEB?=
 =?us-ascii?Q?Y+k0NJyUjVNYjU3FMyVEtVbU0nvlmwDWVVsYwcprfT08ivsvjQIsLVcjJjfr?=
 =?us-ascii?Q?MfnsqyGvxUn1q/UOX3r2g8YHYQGgI+NpF5W+CLo8I4iy3qxY9Byh/vNsGcaK?=
 =?us-ascii?Q?NfwJiwpPqzojDNQYDaI4nk1djuotOdzTmNaTYCfA2dRR4M1AwCGbvT8OJp4G?=
 =?us-ascii?Q?bd+WbXsgKMt67tniqTbPLVwKl/AUo4KmIIIDLsOudtHh6MJB00N4IapwweW7?=
 =?us-ascii?Q?zv/DrYi5FQVLRh86gUA5RNnDYw+vKP4YxwftXMQnzDg1m+IYRX7zz8fW4IAD?=
 =?us-ascii?Q?DL0G/q14tTenCPwNBXV37Q8fsiTzV8z/+1K6Zpq3aaX48w4PsTEnIQfUJWjR?=
 =?us-ascii?Q?c4Nrq4ruGp0d35YgXXrgHxrclC/cnvwLa5lksrwYhkFJ1TOBxhcHsSVNpxQB?=
 =?us-ascii?Q?KLjb5f1/Utb2i/LMKNl/jRgIzxIEJx8u2uX7lsDY4d91pIjCRZTkLqqZPiE6?=
 =?us-ascii?Q?geFnW/dnac82FPZmSzaRO/4T9m03u9FATDqgN0z9FCH6SEHLt0nIhQfz2kac?=
 =?us-ascii?Q?GZbmX1W5kOJIedlK9sI5ABjYvC+VKeljhAhm6N52Hl9754+vUv2l+YNfKy2/?=
 =?us-ascii?Q?9+q22YG9BHYD3UORHsG170xqYkcZT/+wqj/pKpSdWlDTwNsUlAmRJ2VkQSG4?=
 =?us-ascii?Q?80RTQfpXNEC25DU1E19hCjbMnt172UNUP+ZIkPMQ9bBGJFfTcewtdUsj/Y1h?=
 =?us-ascii?Q?L+wxghKkOhDWkPvigpt653B2i6u57Mrlg0Itk2Th?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3082cbc7-ad7f-49be-1d35-08ddd7754d2a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:16.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7vyni/CevRoB+9AdBaP9i9Wf/jshqloyjXz2haz3HV27HIyjUvcy9A+ESSbFHdrgFGC+DIfZ1g9ax+t7MtcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Just rebased on Linus's master and made adjustments. These patches have been
complete for some time without any issues. I am hoping they are merged for 6.18.

sched_ext tasks currently are starved by RT hoggers especially since RT
throttling was replaced by deadline servers to boost only CFS tasks. Several
users in the community have reported issues with RT stalling sched_ext tasks.
Add a sched_ext deadline server as well so that sched_ext tasks are also
boosted and do not suffer starvation.

2 kselftest are provided to verify the starvation fixes and bandwidth
allocation is looking correct.

Previous series:
https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Andrea Righi (4):
  sched/deadline: Add support to remove DL server's bandwidth
    contribution
  sched/deadline: Account ext server bandwidth
  sched/deadline: Allow to initialize DL server when needed
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (11):
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/deadline: Clear the defer params
  sched/deadline: Return EBUSY if dl_bw_cpus is zero
  sched: Add support to pick functions to take rf
  sched: Add a server arg to dl_server_update_idle_time()
  sched_ext: Add a DL server for sched_ext tasks
  sched/debug: Add support to change sched_ext server params
  sched_ext: Selectively enable ext and fair DL servers
  sched/deadline: Fix DL server crash in inactive_timer callback
  selftests/sched_ext: Add test for DL server total_bw consistency

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       | 144 +++++++--
 kernel/sched/debug.c                          | 161 ++++++++--
 kernel/sched/ext.c                            | 161 +++++++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  17 +-
 kernel/sched/stop_task.c                      |   2 +-
 kernel/sched/topology.c                       |   5 +
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 +++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c  | 282 ++++++++++++++++++
 15 files changed, 955 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

-- 
2.34.1



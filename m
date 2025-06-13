Return-Path: <bpf+bounces-60576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B2AAD825C
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD40F3B245D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 05:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81A24EA85;
	Fri, 13 Jun 2025 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVvrjKic"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3391E0DE8;
	Fri, 13 Jun 2025 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749791878; cv=fail; b=JD2uKAIzKeark7vCTc0MPbeBuPDM84S5EobEGlEmhy9i7MuPEQ8P/hxdtZYBgQQvy2Gs/0o1F0LTtnZqXfiC5VvZ9d5ryJuD9CUux5XRjFHBm8F72B7eQFzzxEpif/9ngKzo9fXrhwEhslCceCu6NiOLSBAGVotw8MWAUmghVzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749791878; c=relaxed/simple;
	bh=dQdlbuTjl4zMOtaAmlFh+g4k/2LoxXgJuKSwK17qK+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YhNofoWDrFXZzwVzj/o02ifHhSxRQijG+KtMcRMOLaTcxBwOPGXUfaDW1Idan018Cy5zCbxSGb4leBGzKH4pwLvZoPgcDJiEk5+Pf0RvwMEVKmGE7N/4u0IGgYewoyroMGwTMQWPTkhDZRbNdy4pT2JtYd5xswwb0aNhJR/mIUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVvrjKic; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olzjj7R5wxcGJ0ID5zLgDRp/RZmkWUPY3zXXsId0DPnlfOJxv+72qgz7G9PtAohXqpvrfSlHdAR9jbBztHsWGY4AeGGCZ/j1KO+TkcmU8jZYoY1WarXS8Wh3oM/dhimO0OkdXUq01NLUxn6pTUvOcNWEKRsmtowP09s09wS/o4LhwLq/djAE3OfJgetCwSooKq5jnjG88c2Qwta7aViDHv/iOCM4lb3Fp8OB/A0oMOGs6cZZYDj/yu+6UVy6uFRlMQtgMibcpwGFxtcrb2auukj2ue9kTQeqPGjVdkh03GPuQ294+mIP9Irt5SqgKAXum+yhq9dUI7SA6bVXOcjC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qjwSlV8JIzKEMdGBL3bPm52Q6+jLlSWHcW1R7IOZwg=;
 b=MmugWvjjJKTWBE0bKJqUmN9hK6nk2311GoEI/rqrGXAqBij4PjEZQv5EVWTFQDd9qDyWX4sdJqqBk0wG7vKodnI0pmpcFMyBa2vN4KJs9u0A3VbLbp9BzivKX5RMURsk2a0DOdB6t4VSHXrdamflXSBqdUeHQhv7sTJ+u0oYBKuYRKjJFMLEo5Ew05ssZWFO1V9Wy3MWnl3qqy4a8SFYq8N1dm4QP9Oc9edmPq3E9ZcZeA0M/2hg/nBESUA75FOGawwIQ9cdISunNVl4OuDrzKp6T0rJYl6xHqV2Vmk1TJeNrHBRvwYJKYYLCScL8Pdcfy1ZEDwVd0rrgR0U2JneXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qjwSlV8JIzKEMdGBL3bPm52Q6+jLlSWHcW1R7IOZwg=;
 b=TVvrjKicB9W8vgGOE6SDm4dG22hyeg9bHMogzYbPZawodmkH3pU4dKmAsc6kaohFvFnMZIX8oaJo4Cle7Xf5hSpMpM3pmgnE0RRJwzOSk8yn5VVMFjCdTkrr776Q4W72M742JIOLAXFMxkbpr4w63WIVSKwlrY+2rRmyDJTme44ZUN5WRatebSNpuQzhDnTKjvrAP54D1DyzEMbum3WMn6wJ1MefmufjXhudbR9rtQyaikBdefc+cC3FCTubu7qAZq4IjIJTjZF/1cxcD3ZucxSqGHVimoLV4kUdK9/bjenN9gtNv0VaOTBgx/Qs8aENI8TIXrJhIlA/VGTvMS/33A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 05:17:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 05:17:53 +0000
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
Subject: [PATCH v3 00/10] Add a deadline server for sched_ext tasks
Date: Fri, 13 Jun 2025 01:17:20 -0400
Message-ID: <20250613051734.4023260-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:408:e5::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4cc391-9055-45cb-5ff9-08ddaa39a5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XL1WPNqUPU3Dds1OMVJI2ONCMOlXb6CeQnVeY+xQrpNQVf0q/Q174IqVLe40?=
 =?us-ascii?Q?E1lnh1zSQXLzgwJR/ho8OPVU/6l46IAsHc/mwsCS5twRBgSbyCfVzGVLjTw6?=
 =?us-ascii?Q?fb+33jbaoHaZ4SIykxhM8V2LPCxazP0bq3ptdfnSicBw6YC28mIVgBP8/shW?=
 =?us-ascii?Q?u1nFL/5ZU9P1QpGEhWCB3ZiRpE0IV8y8F81ammEuVgeb2DdT5YbiFIruwoWn?=
 =?us-ascii?Q?fhLUk1AFktXOIrRfJPHSWzDIbvWSwTgQHst7dDn5I5oleXUDtrk1c0DYYsk2?=
 =?us-ascii?Q?9JHXDtaVXM4rDel2uwEK0gEZ80hCxoAuFxYc8M25o+QgpRZ+fXGYHtXcksQz?=
 =?us-ascii?Q?VGQwgaSiZyRF7TYTatG3159Axt3xuIcOo1gbHRFklJ1kU2mf+Ai/sTAMURCB?=
 =?us-ascii?Q?jDSwb1Ytkz9FwctDJaJujzS7mh42TaY5Iad0cLrGzHxFtqOv82TCbnyAanhT?=
 =?us-ascii?Q?4yQ1FjKRL2pl5SNClVsDvf1Jc+DmzujYs7x4OBcA0864+mmKycdeigp7/5RD?=
 =?us-ascii?Q?eU+oVo+RZsp+nvB5jTuvKFjqCvrm54cKaIni//Ed3pH1ok97w9Gc/aSb0TpH?=
 =?us-ascii?Q?Lu99HnlY1bEvO2yOMzVxp9zgd/jf0ltgQATDIB1lu0iPiXAXnD44wyCMC7FT?=
 =?us-ascii?Q?uYLQmWkUhZvzoaBDfbQce1T6NF+wtgSLrjipamrCUEM72LZnnSwoSz+nz4vY?=
 =?us-ascii?Q?7nf13dC27mQ+lA0VQejWrF/Pal4fAo9zMdWP7xoh49TaI82DbXq+Tr01Fa+K?=
 =?us-ascii?Q?iF8kEMgMP8vqSeHBDykP9w8FLxMbIQU1oAWDSF/pErQjJpWiYshkeNujlF76?=
 =?us-ascii?Q?WSv/Ad6sVwhwo7/FEBomQPhy3QgTb0ss0Vkmu8GFZiNbt/k1xUYGsQpZalBE?=
 =?us-ascii?Q?Wc3WlpbwB1AdPmLvc1oRtDdifay8F71bTbHliAqRi0ysdpxBifxvJYMma2Sm?=
 =?us-ascii?Q?GuDLS1Eo65ar9IGvI0I4foR2z3VHzL9trwzi7Hut7DHVjzg/7zhNOqfyhtOS?=
 =?us-ascii?Q?YXrJryGQ2VIiJqveTAy1rufUR60j7hUQXtVp96cOuPbybCMZ6h5HFsp0m+2x?=
 =?us-ascii?Q?TQAshY1RgEvZzeF24U5rpbW0Htb4ViLPB1EZDX4zgSDynFeA3L8DuHXdSL5f?=
 =?us-ascii?Q?zVRr5PrsLjsR4b/cDfIJWy6udld1xtljzVVXzMo9xMvp6P75ijLNckJFGvOW?=
 =?us-ascii?Q?93OWIhIJjZl9S3+BisYEJ5sm3acLPajzjb7wilqoDDm8US231RftBLvT6gRh?=
 =?us-ascii?Q?b70qsDoF5HXCu+6IFzfJ2DMusPdrr8ONZI2iuwRCOdJTgOWDqPsZ1wBppl+6?=
 =?us-ascii?Q?kuZ8so/feqMWjKj79pEYywHyrlbA73qNiJJyysSrE04IWrmXMe32O27Cs15U?=
 =?us-ascii?Q?7z+zhsiExHag+fmAw5SL7KBEFhrQrsv4FnDoNj5Bfs8HNqUWtIEMLZJ0rsJA?=
 =?us-ascii?Q?EhbD/Srfh/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ISc6jPlz2Ck3g6mFxJ/VbZ2cWcZYKj3XYPihtanoc9vsh6WqL4QVi/fuN+A?=
 =?us-ascii?Q?XHbeNxOE2w8TR7ZyeyTHlo3rhxriP4GwciHE8vCUKFUw/bEHUqJfqWnVEFdI?=
 =?us-ascii?Q?CPf4fTR7PUV8N037la1bDIsPV9ciHcqQ/crjnQOWsDHxaDFyZfvc+81Pf2Xo?=
 =?us-ascii?Q?fXlw5NHWnHLwXIVPrT3US+T0r3HugwkJHAjCW+ObLQVFcvVY+fa3iIOha+EX?=
 =?us-ascii?Q?JfYd0bghpJjRfvglgnVqTJHswJSHOUJ8ZKiu4ZHG8OAswiJgeVO7cEpJl5g+?=
 =?us-ascii?Q?oVVGRpyvaEyS6e+Zb2w0P7pyW3Tc60+QvCfoD2yqABitx+EcOz7J5EJF1yoT?=
 =?us-ascii?Q?1js7Hl7dXv/Fg2EUkZM2vBNAuhwvQEDMat7TLbKL+WzjvwcgJ/J9TxkNiRqC?=
 =?us-ascii?Q?wMtOfJ6cbBIiXVUvP8GsYRMGyPUvDgo/j2MWA1yzhJMA3xEohwt01YIFqI0p?=
 =?us-ascii?Q?cqKULj4yQfuPVTvNHshZRnEXK18ZV/15Sc5uNshlTbKNqThTwy59FbNpVFLA?=
 =?us-ascii?Q?bBPN2zkOfExiu1WkE6ZAXHnro2136jXmhBtKtKYToVqcxx6V2xVTDcc/7AsT?=
 =?us-ascii?Q?dM+YIbNT7//SdcixtWFZ+4zyeYKsxj07f5IeH6mRX8qHhR4e4DYalC9FXU6z?=
 =?us-ascii?Q?HPMN8FH/6/ErphsaNUSyC8CsW3FQ0hn8X3Gd6kp33gKunj/LG/VjiKnWs2dM?=
 =?us-ascii?Q?3RVXYp4lZjHOhT/r4PL/c+P7clJy7c5vRlXyBNktTYtznl6I6KUa2ZD6kBTF?=
 =?us-ascii?Q?BsSqAkoGXdjkjkIJ1nXuZeZ6xvaP+099KaLZ/MxtlcWHs5KX0H+ecPq7A8ay?=
 =?us-ascii?Q?COg9yUOyJS/AoHnb15phSvcH5Q5OzgG66tltyEvVTBEiyfmAaEHiRh69jEEr?=
 =?us-ascii?Q?YBOMHVQSzrnovlGi2hpZK6QpwA68f0ECh/tdGNif0d71B8DfkimGOb2qGzZC?=
 =?us-ascii?Q?ZI5WYea9BHzi9FUuJYWzP84utJCko6TwB9jufYZAXooPJOeKgwNrctfOU+mY?=
 =?us-ascii?Q?IKgm7SLwwxZzvaFeIw8Mxb2hqRaTUhg0Bqaiqzz/jyW6ex1CQWHGAG0tcLxv?=
 =?us-ascii?Q?L1YQwnXKnCIianRoM1DZM0pc9dN+2WXAqsv79uN1S4Dd9EsGJKK5Pj88dI5r?=
 =?us-ascii?Q?Wp/0pAz8QXh8POWaS2HFCPx8zxeIssvOa7jsdUEFBX7eeeq5LdP70G1RbafU?=
 =?us-ascii?Q?ESM6hG/aO/f1mXuKoBnmyq7l84YKcxF700jLK5CrTCYRtdEOudWfF6S82vY5?=
 =?us-ascii?Q?Mj6mRde3U1AuwvJl5X1spYZ3IzAbk3sgf//ztyIqoqHnFHyfA3P+q+GzRDuY?=
 =?us-ascii?Q?DDqDYpfqtUhZ0JvGAAz7OjxHp1BfFVMcR+VRZeRt1HDG2BGshmC43pp+p2Zk?=
 =?us-ascii?Q?C20KGd4xWFGTabS+5tcsrwK+edehYtjKPDxmnqZVE+MmAZlIx8iqge6q4W//?=
 =?us-ascii?Q?uT2H5slJvWc/1vsBpDOtKgeH8l4P93BGR94VPxUhcwwAB9OqvX+qyXiTMxjv?=
 =?us-ascii?Q?wn7v4KWq0m/elLaCVuqeZKcMES5899RF7GO3oT+iP+bhBBaEzdqKz+Rb5luc?=
 =?us-ascii?Q?c1k1DXdy4D4oDbjeLanLjoptwyXe0V25kQnSM44D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4cc391-9055-45cb-5ff9-08ddaa39a5d1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 05:17:52.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKzeQhSUvF84kp/aKg8CL3lXWx+jLU1TFWoWBjHNnNad4VELhTEMiAh+dyXfb2BqoT9iTkNubOm4brNp9skD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

sched_ext tasks currently are starved by RT hoggers especially since RT
throttling was replaced by deadline servers to boost only CFS tasks. Several
users in the community have reported issues with RT stalling sched_ext tasks.
Add a sched_ext deadline server as well so that sched_ext tasks are also
boosted and do not suffer starvation.

A kselftest is also provided to verify the starvation issues are now fixed.

Btw, there is still something funky going on with CPU hotplug and the
relinquish patch. Sometimes the sched_ext's hotplug self-test locks up
(./runner -t hotplug). Reverting that patch fixes it, so I am suspecting
something is off in dl_server_remove_params() when it is being called on
offline CPUs.

v2->v3:
 - Removed code duplication in debugfs. Made ext interface separate.
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch.
 - Fixed running bw accounting issue in dl_server_remove_params.

Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/
Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Andrea Righi (1):
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (9):
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/deadline: Clear the defer params
  sched: Add support to pick functions to take rf
  sched: Add a server arg to dl_server_update_idle_time()
  sched/ext: Add a DL server for sched_ext tasks
  sched/debug: Add support to change sched_ext server params
  sched/deadline: Add support to remove DL server bandwidth
  sched/ext: Relinquish DL server reservations when not needed

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       |  78 +++++--
 kernel/sched/debug.c                          | 171 +++++++++++---
 kernel/sched/ext.c                            | 108 ++++++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/stop_task.c                      |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 13 files changed, 579 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

-- 
2.34.1



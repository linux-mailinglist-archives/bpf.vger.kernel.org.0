Return-Path: <bpf+bounces-60847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D303ADDCE0
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16D117F8AB
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E682EE986;
	Tue, 17 Jun 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivY2417k"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80972EBB89;
	Tue, 17 Jun 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190771; cv=fail; b=AlyB+7TyfzFJw7xGho2vdbc6b1ed0G+jQnV7u1mKvgxMmpK0vf802+eFVJwrL8jI1PXFGkKhtAt87R3VCsrCX5AqmYbu8WJ/6wsHZ0ry7gpPUDynqcL+8LTfXG5fdR5yKK9i8nEd2t+OdP5A57c1Zn9ZkNprejstnMLAk/wixIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190771; c=relaxed/simple;
	bh=+oA6/MNz+anp4oeHizWs4ZNeIQ22HLVYppl6h2fBYEs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OylcHWBxOPb7Rw7JJjtrqwau9/wgn+YJjwy1H43EfWAmOdw7IJPES1DF9fpLn5lp6mFZBEN4djZCgeTqmhuNXxifH6es2Iwej9U+tIGxUeAm/rp0A7qjmkg2mXTBtHKElgl2FxJMz6lbJyd+HcFcwE+Bw844ZnP0ArW2wDC1uIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ivY2417k; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU0FTNlGHggWFQzHlSKNVHYSCpuaqQX/D8LlPS2EVYcoYl50c3j5hDvLKHXjn3Jhv73wfPDErI0EQBjHEx+ZP+oHav7Vt21fdMDmvdnQYkDWXLzOI2OLHW5CYP95DPL04j6KGjA6ggkfm8GMgaQNIHKG1KopBBj2ClgjIpT5rsVyxBmM1lBfg6a3GNq2ObO/1iHGiIjvPwINDFUSU2KXpQJ4YknSwpztjkqYWskbYdf9I+woMYcxCJ+J21LAVYU2uFRle+CllHAAO3QvE0EfO/13WcoL3C2wE+o5+KmWK3WfEXtg3MXXdAGwQBwS0ibH5JDf1Ngcsyue4MHlB08lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUIyFgnUXO+GXJi27U75xh/tqssoDvpNDzFk/xACaPs=;
 b=i93sBH/+VkCKDAI/Li5ZtNu65fMKJb4kt7mbYr7GXWFUE4pypV9fVU2IVfINZQUu8J9pcmMZYcZ2DBITz16bHUFelSz0LxzPurLXXX0iK5VapKlj69dp6j1FNguwoA1jyuk+UTwJ+z/i4GWs7T5YYs9qIh36Jmo59xn1O/mbuqav0QrMNs3RYWE6iK6f83YVzZb62fSn+Xt7N9ipz9SILZnW7KZ3i3RLnQv9H89gojIgUeyd6t2INImOlTTR776+xyC+oAylLfD+syCWxRs4zBO39hlzGR3tW8aoOAW3Y2s2L/PKrENjkE3fenc68EUGrU97O8v2KQah5xm93iOU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUIyFgnUXO+GXJi27U75xh/tqssoDvpNDzFk/xACaPs=;
 b=ivY2417k5EZcpQZQuZDtKb4DaIt76LiQCx7X7UGuqkhCYZmdtxMgUFCDVsjCFDqupMRjrqgCWav7mLS+gvGZA6PX0OYWuHEapukREbPXNS/dAtLQO36Dlc6FqvNX1xwsgnVIBNzbnmb/rv5EQbuT8x/5YRurbHSQskjAOjLgCqhtnTHxgamvAZzKl80621obwwEtUg/Q9s9A5q8q9waODvgrSOgtMI22XemlLUVzjTOKQs2EvFlFVQ5K6GHkVpqODjQ6No+u4kdWuvTPEbSnszeQfVoYfG6PVM0a9p5B6dq6lIJOLtxTUJStBhMcAjNPg7qHouiiwemRbLMopyaJtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 20:06:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 20:06:03 +0000
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
Subject: [PATCH v4 00/15] Add a deadline server for sched_ext tasks
Date: Tue, 17 Jun 2025 16:05:03 -0400
Message-ID: <20250617200523.1261231-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: d81ff6b5-6fbb-4715-9ca5-08ddadda62db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QiC8IX+A8zX8muVr46cs31Nj8CwSLAhQmN1q3b1VSBPIGdOswh3xTaAQtm0b?=
 =?us-ascii?Q?oQ80LOMpArVDeyNTpOXRC1Ok1cOGUmnkQVemoxGs/3zx9PyMfvjW9PYQlTv4?=
 =?us-ascii?Q?2XS8EaijH1x0x0lX7zbXdP1+LlmattKP4snLXO3U0lQyaQ/9Nt7v6spdQycF?=
 =?us-ascii?Q?X9A/FlwTtX+IUn6mQIZCsboKw8yFIgAMYlbnPUDmGSVtIBwZvQO68P4TZUu6?=
 =?us-ascii?Q?ne+9dNq3HVLP14W3CYf3MutgP38QF7IJVW8iJPRST92lSZFkYK862tPKJqv/?=
 =?us-ascii?Q?Q4wnDYshmsPsrPWzqtvVaye3/yUhHW0hoET+P1U5nWEm+s+oBZoK0w0uUo+K?=
 =?us-ascii?Q?BajNHjU4XUxybauHItSSve4NjGbULpCQKa8I2CIYAYNXkSu/77ojmigTHiI3?=
 =?us-ascii?Q?ZtUFeKgOukT/jnPQKm+7c6SEQz2iktrgZ6EYMLe7sZF3qYhO1mepb++c6H8n?=
 =?us-ascii?Q?b4EUXU6YVcYtx8lCpJ+dyT2u0ujmMrK41KlyZD0956XtVutVTaMTllflQXIF?=
 =?us-ascii?Q?OknDYcsBz5IyzwhzZW9vPIKiaYO7s4TpupFq/e1EgDMuWccih9GbUqY0k54c?=
 =?us-ascii?Q?MLAAYRfppLpiXU+ZgYHPB5ht6wihkYbT0RVXSXt5yVTt1x2ljwyzo0FYiEuv?=
 =?us-ascii?Q?9is/W3ajiazwL/dRtnIn9lfl7igbK0gRyzQ1NHZ4Pq3V/fhBQFACsXImc1MH?=
 =?us-ascii?Q?E8hiq+R/YF6GkzyX/tQgP6EKA5GJcYYskdTD70eTE/MD9GTK8C2e6b9DGTGe?=
 =?us-ascii?Q?rREx/qI+nTIQR3kbHLW5s7KM9gEuYbREPGbliGx+KPVkHs5K2tPZVF+tAY/7?=
 =?us-ascii?Q?Vh9i465g4PjSCyTOpoNp5YJPHbgeFQ4MjxGeUVsa557d9euTQgA4yDewUhlO?=
 =?us-ascii?Q?evrEbYVI1YrHsKxpAGLZg++R4tBik04Eh5ZGtUJz3Juwr/QvrK0qwsHHYU1y?=
 =?us-ascii?Q?dP9ZTeO+utQNibASxO+BAFoateCR4w2cK/QgAescgJjx9FpWvpX800SGrrPX?=
 =?us-ascii?Q?eYGvYa2z5MVWxta1QwaapO8d98LurPZQagd/J2h+WDTdFQFuaCj6V1yT7OM/?=
 =?us-ascii?Q?cfGk16d9aURdHu63xtTY0+X6IHvd9KRniPprotKYA5F9kdtT8wQFhIK4kGEZ?=
 =?us-ascii?Q?l+JZSCI6cXlm8JG81WCwYb1pHHm7mzn0eergGsbfQqanOriViKUBGCxAgKWg?=
 =?us-ascii?Q?nsEADyOjg4Hq7fLFuxnX0Bjz4S5w9TdEBJRQmmbrxwbiuvyS84Jg50E2PZ6U?=
 =?us-ascii?Q?ZiGA2XctNxO99+QF95SZrNW2baWwcRy4IhXwvXa2N0KhKFbLAahD9Quk7qfF?=
 =?us-ascii?Q?WDbcbGfuBBXzENZjo/B0f4QaFTDPKzO6VPYfzf0VNXd+X+BJATWLkcr2q4yt?=
 =?us-ascii?Q?OqhSnJNriBVQzcvwC/dUy1hzk7qSW6Zg5ZkAsBQseN5dtvvNlARDTqoxqY+l?=
 =?us-ascii?Q?DVkWV/993i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaNdZH0bPGkP9xyNyiVX0zgxFTQLkFsDmOVtaEDqZ/rimFbs9C7Ulfs4ljKk?=
 =?us-ascii?Q?ibtO6wecz8ptWuOE+UA7686kjsVIEX49gN+/iozq4crodbWSc1NN2SBtXZTU?=
 =?us-ascii?Q?n7n7j0h656+12fRUPdY80S5I4kY8zZFEyBzPWY05sS76FE5qHF+oyKIQTV2Z?=
 =?us-ascii?Q?wOejfpjDdooWC9VUehxSgahR2A2m/KoxfxiP0Mo2ESw4FDpgMv0J1Nb5BFpE?=
 =?us-ascii?Q?NfRC6P+8r+X0pxiuSScZ5JqRWjFcyqX9qIbL0Wba4sHTgPtfGg8GsoZnHBsi?=
 =?us-ascii?Q?wAZHx4bP7tkF6AfEwHBv8SsiP+OqDjO0Nq7aP5akoXBwBZHQmQMThPo5LxCS?=
 =?us-ascii?Q?CoBjdMlZTXsIXbBCk8Wu2hc+48nBdg624Hg04deOzGVQwdRMpxUZpmbT6aY3?=
 =?us-ascii?Q?1A2T/ByN2PFeTMRuaeMKEaHAi0E4Lk6gBiAoRXeIomF54vob9rybxiFLjwRi?=
 =?us-ascii?Q?MyBvfYx+T1atk1Xesi7xJxEHPRgzC55dnYreJ790g+ShEKvmz62M5Y6UOw8x?=
 =?us-ascii?Q?lfOPSwEU6625tdoV5otx6GIoHwMJAauu5OCYFdpTzp6qbn7Df2y6e+VUA8Wy?=
 =?us-ascii?Q?sS3by2mg2oEstP0DbXjL+uvKitRFC505cxXitnhSviE4HcgZYMYWuneL3Vem?=
 =?us-ascii?Q?eW8kmqPofptICYrmDoFAaQbo8GljGXMaYuho2QjPdfbN193s9D+2ZefUvcAZ?=
 =?us-ascii?Q?xeGvpi49p7doV7eY7Tx/8FMjd4rguUSCBgYjF90velmQdIv5Wzg4EWqGsVkj?=
 =?us-ascii?Q?3BBL98DRO2iKyxMYi0pfYezHJy/FIqoXSscDw/DFAPAf1UdxEk7BeDqwGk6l?=
 =?us-ascii?Q?O7WHJK1bhwqROkfZjQjzA3VJ0d2mMIsK69jbXPVWIvBiXiIF7NsfC4wQt18g?=
 =?us-ascii?Q?ieF2u4R52rihrCLq6nFPY1C3gDM2JulOLAlfHZdeAfWQezhxKNl2EcZ5uSLT?=
 =?us-ascii?Q?kn5L1/wt8chJMPZpsImUSnDzvUoJorEXBvVLLq4AqvhCTATe9mp5UoyNv7Og?=
 =?us-ascii?Q?1EfW0sUJ/5jztGgsqbheyx4cR5f8Hkcvi0UTGsLu3dAu/+TFooUv3fklTOEL?=
 =?us-ascii?Q?Zzphtbyev15Ybv0SEZ1O375S7wCWFhcwsDjRKbLCNsJWp9x+RpGch1MAkJ+3?=
 =?us-ascii?Q?uvtvn1rlVWmF5EgJVs6WVIW6oTQIpu09fr9H2ir7nK7oPhv1uvf9Pja5frBL?=
 =?us-ascii?Q?ioD+y2aJvz677JxAG577jURcceiRUg9g44hbOInRLCE7QMp9s62sfFwlTqIr?=
 =?us-ascii?Q?BQYN88JHKcSm0dUxBTqHUmgNgfvUaXQ+o7YanuXNLlpufRqHohvxUzMWL0Vb?=
 =?us-ascii?Q?EHonSuFsQKxV1nOeAjygCIjI9lWiizYASF6u7w2SpviAjIdqRvcWd89sR54N?=
 =?us-ascii?Q?0bDgjKz3Wro7ksBJinsMRXbx6XtOyzZJQzXDcKRioiFzO3ttTg2bTitG5gIM?=
 =?us-ascii?Q?JKwNCZpnMxfVAFIxflYY6UynXkO0HurfsFSpCTQh/72PC+MLLvBKdEOOSwRP?=
 =?us-ascii?Q?Ux68IkIu1CaFhrcuxj3Yc8vIT/JSTYw9Wc1Q3F9SrtlvwTOuy5sGLxM2/ka1?=
 =?us-ascii?Q?b24bKUCVGljjDKxx+t9sgG7d3A0gCClFhBVu6Azp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81ff6b5-6fbb-4715-9ca5-08ddadda62db
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 20:06:03.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OrLGX31NlD91PxM7K8tTD7QA2RwBPBZGn95vR7D55Ye9NFxC6fZ4phb6aAuQ1lzNgZcGHnrf/Xx0pAFwv50Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

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

Andrea Righi (3):
  sched/deadline: Add support to remove DLserver's bandwidth
    contribution
  sched_ext: Update rq clock when stopping dl_server
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
  Remove the ext server BW before changing tasks to FAIR
  sched/deadline: Fix DL server crash in inactive_timer callback

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       |  84 +++++--
 kernel/sched/debug.c                          | 171 +++++++++++---
 kernel/sched/ext.c                            | 120 +++++++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/stop_task.c                      |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 13 files changed, 590 insertions(+), 79 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

-- 
2.43.0



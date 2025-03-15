Return-Path: <bpf+bounces-54088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C80A62486
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 03:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C2B3BA5D6
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550BD176AA1;
	Sat, 15 Mar 2025 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QzrEmM/T"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344537485;
	Sat, 15 Mar 2025 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005333; cv=fail; b=tptBWzOToNFR/Z3r+hUf5LNHp19+41AMMCpm3WVJ04+6/SDnBfjgIXRofrrez2XS+msJ7vtIR0Iu6UaGQyeuiP+CXnWscKJhEiG5f2GynUV3WZvM+Tc5apKyOh7sQTW7SUikVWyoWD+dJ+ZeWVc+O3jALkhM0zxQf8eq3pnazGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005333; c=relaxed/simple;
	bh=6Ptp/DAegG8qqjRn07KyM6MsHppAxvwER0KY1Bgsgx0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qog7Jf19vl2yVP4IMazsjJ6nwHn6ZeCO/SVYg+RJ6/OmlNjZqsOuJ9rwDvzdKqY+PVxa7t1Vwb1cbEu2J45fm6Kyp1IjL8pYP5vkOPfg7+Z1dy6fbN9uFQok+GPxDvVSuiLffTPXrRuh9txSp2cKVhaUajM4cMn+7Kkj/nPmTiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QzrEmM/T; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLrZ3K+unqXT3d228upj2WxTZN7Y+wAI6F+bRnykl28OG4/7pqQZQbAsAHAoRgYljGd/zJThKY+JvVf8/W26h+qrHHpefBqSverV/9EPBayUPo6An3VPEPqQCdjp3sBoLzk+836e/i2/LXpusFGKFVqStfT+GspssZacKjhKSb67R3PNNuU+XIe1g2liq8ljtky/FS1IpfRAU1srJl4TqfZxIRP+3nmRqH/A6j1dSMNlLYBjLattsSZlKE1hI7H4a4+OE4Y8E8+oN0BILxuviVS6t/K8BiopBM1WHB6QQ594SNKjcdh5Vc+D5ag/RNknvpkBjoOEkxY6gT26M8BJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKY6c/4B/ESj3rjb+HYGgc2c8zCX78Zu5iJh45xYf9A=;
 b=niyIad56ATa6BROZcjk+q5RFhIKBB0Jb7/82fuNlYLFZOMZGcJbyeYlBnZwj0/r5n9GYJ2p2St3P8/tq5hMuQVGlU4lIJGV0w+MvMAttO6uHBqSZP6El9EpQtlHpCXtXhhJ0llTSiFBQtWR7ONvNXOmwiSQCEQ+NQ1LR89NKHRH/GDhM8hfn1xBZCnhK69cQM1zZqqnT4/QAjV5ro38s3g47MO8SGIdPA+8puHPfv4OrR0lx35aoUfS12xsxC5wJ57h0qsl9BxbivNA8AtiAiJErpWiSdoYvr+RH2PRod2TxVcGT0xN67o/uQ2V4+eo0zSiwq43e/II070MY2Hvj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKY6c/4B/ESj3rjb+HYGgc2c8zCX78Zu5iJh45xYf9A=;
 b=QzrEmM/TyXYFlerr4AsRwdoTnNRJU7iRE8+5eP7fr2KCBDtArMbAkXUdcNkcD3JuVDlubfxlpzDSNyBsx7x6jQ0RzIDvSj5jVLCheFy2LA6svWXCHRaGZ9i/U6niWjGpbvGJ4JAo50y0IvgbOeiI0uwh40RnNtBE3Mu6FbzUsUbLanc49A7tc15os9HafUHN9YkVz8cta+QlxxNgbrFID5S2mLCxmvaDSkhG546n9fho2p8RarYq9LzaU9q4V4NRMRrw9HUV7vmAoujD1RpOPdGlmNKEeqBLAW/Smuylaqv5B7m62hd/0cy2tUPCfqMfBulH+8tRD//Ou7J3WIv4uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 02:22:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:08 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	David Vernet <void@manifault.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org
Subject: [PATCH RFC 0/8] Add a deadline server for sched_ext tasks
Date: Fri, 14 Mar 2025 22:21:47 -0400
Message-ID: <20250315022158.2354454-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbacdbe-7ee4-4f34-bbd3-08dd63682f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuPhNNTSA0V+Eov9PQpsQPmocZ2w2QBM4ONCyF4CgjueoD1wxWg/8mRZV9aI?=
 =?us-ascii?Q?1tw/vJP4ZUZZDpzylqVvjQZvtjt18XU0RpRgz4TJhb5TR5TiL3bF0tM8ArWi?=
 =?us-ascii?Q?RpSxYSG14WDvWv5kzMpRHfFfQAhNqEn5VLRiJZD4PrMIrm3rf5M18DpisvZz?=
 =?us-ascii?Q?gvpOXPEAItKZEflxMK0EtEwL5/VVxP+qRb0mtAlW4ymoN7Etnp65J4eeL7DB?=
 =?us-ascii?Q?qkZiBa6bnr05ipua1w7k0BHlwglpq//sN3YYMAujhbP9C1H0Rpq5cJTdJ/Yz?=
 =?us-ascii?Q?+AAAs1SXNqi0yKI4ATYL7uSMp37foWsuHsKkwJcfGvrTG+xhZVfSOvbYBhln?=
 =?us-ascii?Q?8DThts7Oi4SVzeSdYZDs5j7tnEQDLDnVG68eyAUnSZ8jffT4UNfZuHH5yuF8?=
 =?us-ascii?Q?cqEX9theSvAn5tnlKw+hvZJTGvvTIDkMZl8S/lnFxEwud8bschlWE0k181R2?=
 =?us-ascii?Q?vHjZH/0wKf6G3FH2YEzVbnoLeiUiXAJeYjtdN6hHD4uRpL3NgQ/SwZ3P2Y8x?=
 =?us-ascii?Q?RuHf4LcnlumkQlCOsHaNZsk3RtOHl6Q/z/mua6i7BwWZf6dgGMZ2Zyg2RFh1?=
 =?us-ascii?Q?2kNjOQ9WwBPc1rPC9QMOQvhB8VoEpoMKxHshSNCedaAflHH6d2mKXZgQsqZa?=
 =?us-ascii?Q?/suehXLUMox4uk/DnrX0IFPTVJys1jFBp/m5IphFUaKfs/YHaPGXVFMVsnZ9?=
 =?us-ascii?Q?FWiRwKvb1vi4mTet0MQ8cLTpNzfRfPIU58Eab9CTAcxLIISoCHCJ7p+O9vAz?=
 =?us-ascii?Q?q9ODkgg2zopHd/de6hB/XLxgn7a4likNn1RgtDoH6GjdGyPfoa0s5MowH0Ss?=
 =?us-ascii?Q?pHU8Ud6zm0QFjHHTtalmbz0nR7ekPaCFoYn7u3NDnQ2Nc1Xf7I+EMdBFrXNq?=
 =?us-ascii?Q?caUQb+MtNCAGMTNIXDzhBusYwS/vdJLDJuOWL5+PtXH/5wFS1PPGmdFitrjb?=
 =?us-ascii?Q?Hbcqd2BbYuFWf8riVtDjVwxpTx2wSium40zcKXNurktZwFR5DL6LwOqmjw8y?=
 =?us-ascii?Q?o4WnA7YOA8hmnE7R86Jm277w7bTpxgZ/WGqX0qG6mW4qQIBuPMqO7UNeA5Z+?=
 =?us-ascii?Q?dL4/IUEljr06vR6RiaxSHliCYHye0wJ3G6+v87WqCJzjOR7ovZIzJ88GxY5x?=
 =?us-ascii?Q?PQl1OBgaVwZZAOuTLEtaxXDUH7bSz5Fp31sc2ScW45THPdYpc7kROFYAxLjb?=
 =?us-ascii?Q?LZvCqi64J/pmuhGPjzinM+ffm+vsAozCRlHkmovulDV7LMfhI4kQt9cnFJPP?=
 =?us-ascii?Q?I91E1ehX/PSfwTBA008TKzbAUUFfW/VCOq2RAClOUM3S4gN7k4Zdy+t7Wnrx?=
 =?us-ascii?Q?5aCTW0UbJ61ljEwsJbm8qFkmXj/JZlIAK6/DLqXuusMUYXoKA5JgqzLI5pmg?=
 =?us-ascii?Q?o3dtdt50W2JtCRkkcbzmCBexuqz8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0R/0ejSEgQBtPLIzqVQk0QLmH0tLW22NRYX1zlW4ZMuqNeRhWZgM7YdZavBS?=
 =?us-ascii?Q?5rvGgzg9LuoLtItFXXChj+ZOVoGaepr/lulZntllEJ/mhsPbMIQPY2sfINSS?=
 =?us-ascii?Q?hX7eUsk1OWbT3ja1o1JMCHw8p23JPadmw5O9Uk6mSz1Q8GxBMPZId1A85EXA?=
 =?us-ascii?Q?5SqOm12GWckBK9GVJ2iRdAk7dUvCKsrtqLjuF/2pIhrxhTyxr9KQWAxEmq6d?=
 =?us-ascii?Q?x3BLC6KtRZNCSWJ8f7Lm0alfIeCCdZqOugeuBmOuTeJp08k7/v21kWMazKWg?=
 =?us-ascii?Q?9M8iiIDK2XNWyEEWMxgSliN8/w3y20lJe9QEunma4RRTt30MUi3vwltP2PUh?=
 =?us-ascii?Q?ilxQp7wjC43OzK3iHoWjxbDH8V4Xe6/6/SWVTLqPHcM8qgUoZP2wcw+X95P1?=
 =?us-ascii?Q?wx/lcXD8v97aGQwMGO2OloT8TvNRKf8xuJWCEkUwgOCUsf5+T5o0mnpug5Fb?=
 =?us-ascii?Q?WKUmHR+ikR9Dyn5UdODi5iVzfn4oOgKp6E8iC1qTNCL7o+5rHsD3pHd+zVcd?=
 =?us-ascii?Q?Jwi2rdvM14FsZID+rwWZgoiXoLiLUCqeQHtevoZ47Q0tPb/rOF7WmGsHRxmY?=
 =?us-ascii?Q?fC3SwE6DMFV+EMQspy+RrHIoPEjH/X38OZ5SrLRt1/VmTdbbpUKtVMAL495M?=
 =?us-ascii?Q?lDGS4RunDTV5fG8nR+uwhbcHnj30kiGaxZ43/AiS86rBCBuUCtFx28nnr2wz?=
 =?us-ascii?Q?gvLu5/C3DNG7UyMzZKxHH4hRdLwj2YOoqu6Bd8aLSzgFou8D2O+HyUH5Ti/r?=
 =?us-ascii?Q?O4eo093NjYILsZPmxkKzw8gKPX+FvoOIn3ZZLDjNb4JUrR2BmyEzF3LNYtXE?=
 =?us-ascii?Q?ikWc/EQUgDeKS47abE05kGBzGbkA0hy1kRdLj+VSZvXPExwK/d5aa+Kj+wXJ?=
 =?us-ascii?Q?1iP9iJjuwkfOV7h7Ja9oUl8x2oa4OGA0vL9Ua6zHjkUE1dqiank7U0dhuLeU?=
 =?us-ascii?Q?kQilJHXsb7Kn157xdAXNDwtCL2CRrmtqQGrhCgry+bZ8jpKXYbSLAcFp/EWo?=
 =?us-ascii?Q?OV2Yo3ZmV/OYO16K7QMjx1qLncul1ZfcqbLiYOuWJwubfdK4RXHL2MvNLqTh?=
 =?us-ascii?Q?0yDRPsimg30bwiFZR28MUmB/qfQ3wW+liV1lPem1wuWreweq8DsMr4BsCUUq?=
 =?us-ascii?Q?0kMv8lvBk/bgwvx69LUEcZ3x/DaRhdlSivm+igr/KY/fmYYy5XnqAIoWSR/w?=
 =?us-ascii?Q?1tx5XciYPJz6zAl7IXB0JzO0M6mAMUhzT3IM4/fjQN7J991+TZysluYCaM3/?=
 =?us-ascii?Q?WhFGi/P5XBb4OJHn/LMhrhhdVFJaQMUlVAAj1gj3M7Vh7mFLwix2+rv+FU/Y?=
 =?us-ascii?Q?1Thoc0PnNsAneS0NcRVyz0zRMeSI1a35GhvhRGzXzD83VWtHUL6hZqzMwzsW?=
 =?us-ascii?Q?Gl57BH8aONVIfQJCf3+sG1dar/9jCgTsy5blGiLRY5hSfk7omo4lFMhRFQaH?=
 =?us-ascii?Q?mgVdOO/yDud+tPytblwh8NqtdANDObdzsaSspITPyiQ8aWZ/6icfDr7zYNby?=
 =?us-ascii?Q?FNNzER++hYlJW3OxScK4BhGJRYnj6r+vzxf+GHWoRclTz9tJOYL8EE5YYxyi?=
 =?us-ascii?Q?tzG7ByM+YjvwRYEJ/R6Losh2XUomM8ujwiwiRS1V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbacdbe-7ee4-4f34-bbd3-08dd63682f6d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:08.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKMPxFQb2lBBTbENLLmEEPJeMTLjpNAJ05N+9Q6e6QkD1x0xuAr7a3oeHMA7aP1DXyMSjXGm971UH2qPahMnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409

sched_ext tasks currently are starved by RT hoggers especially since RT
throttling was replaced by deadline servers to boost only CFS tasks. Several
users in the community have reported issues with RT stalling sched_ext tasks.
Add a sched_ext deadline server as well so that sched_ext tasks are also
boosted and do not suffer starvation.

A kselftest is also provided to verify the starvation issues are now fixed.

Andrea Righi (1):
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (7):
  sched: Add support to pick functions to take rf
  sched: Add a server arg to dl_server_update_idle_time()
  sched/ext: Add a DL server for sched_ext tasks
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/debug: Add support to change sched_ext server params
  sched/deadline: Clear defer params

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       |  30 +--
 kernel/sched/debug.c                          |  96 ++++----
 kernel/sched/ext.c                            |  64 +++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  12 +-
 kernel/sched/stop_task.c                      |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 13 files changed, 406 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

-- 
2.43.0



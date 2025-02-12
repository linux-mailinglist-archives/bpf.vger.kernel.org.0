Return-Path: <bpf+bounces-51277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F6A32C78
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A0016A7A1
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223D256C8E;
	Wed, 12 Feb 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y12kYipV"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89E25B697;
	Wed, 12 Feb 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379045; cv=fail; b=geNO2uIoHKKe1e99+Jxysil4xqoqaX/1KvmYut0mvNJXJErsUNIqWwbC86qYlJb6Lz4ThAhJjTmEa3bMQvYblG1J7U37Ispvmtr+RZspAWGA6YLFlVppRCyg5c/sISgWRZSSyedfpz/etIvhrEgrolfrizCaQRC6oz4Pa3/Nhlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379045; c=relaxed/simple;
	bh=ejyrJgbw1tooeilXrAOvO/FUNS5m/zHDhxDYsEjedf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gq/HJnfZlTBdUSA0PxHV9j6VL1eD+64VpdvY0uSUvYhWmGALy5gydzi/qOimp90atAxeV+dz9tcNZEFoUHX0Lpjs/eGou1MLcz1pM6s8JWJRCupFlkdhuOSYjCQQ/T4ZhvyoDZzJ3KtbUhKjbsAP3w920E31zLDbdAnVaSsPBG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y12kYipV; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYVfO/o+TMuk/0sCXEhYfl71lJw2HY6X8Zx7hIAHeIR3n/KeejcCQXRyHkdjac2ZzJ8ykXXxbWobEocm5rrIwXIKZJk9bmVsIqVhdJ97bHZLO5LixX7fJ7BFdnqitE0nVG1DUTiskJC+tEvtTZi3JDszc2InFWeFnqRgS5AbSXbwkSZzwQSGuFAybLYAd7N1Fmo8gcb43yW/xETLKsnwkAv1yCGWn64ukOGVsdOGDSv1KS+OQtXszfWXqxpifFUIlpWVRldt52pTBHzvxvPl2T+M3SMyKJU4wd1yr/SxFlLcywPa0k1G4SW1HsZtRTQpZOW/Dh66g41gNkl+4P9mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/PRv7ChShaC6L7wToepsAMt/zCk6UJAmPRti5zIHis=;
 b=t182bNozubk5xp+2lCvViYZX3Ww0o65o8h58stbCFQdDaWTt41u4VeF/lK00F4uuh90d3xGjrDp2iTc59MANlJSrMmsT9vxYYUvCVyGIgPnha9/VyeNVOQCv+XyAZPQOspkyN2tTjaoxxYlYnWSNuzi7zOhAZSrsJebLDJ8oXlL9GxhsEJQ5LiwZhZ7HOpFnTlr+j/26cDVuyDuMqcYqWw1vT2TZHdNWSLaIPugTtHZ/I1ipiFK5XJIdxnYxioZcsWJ8F/hiTv6n71X/7D+9n7b3EObwMHcFDvO/JcsfJ2ZYb8KSiBjMjaSdvePUzfRUKmlfVB9Atshs0xiE+mLSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/PRv7ChShaC6L7wToepsAMt/zCk6UJAmPRti5zIHis=;
 b=Y12kYipVuO3X6DaYARijTKDcqkcKnOUpf43lOLBzxzqQmuj9UcwlllhdJtEqQDUCdpzazsFfMue62oxJOCW4vJvprqcn4nhGKnaJ0bmx+WE9rV4p6MxFshahpLwPz3ZYio/8Umsye4C0bnFmqREJx0kjPcINNLGTOcB6FE+QNKPh1JXlugStDLOJJtreuTFWRubuhDKet0YV2o2R0Vt13HwudVI/bdiBmDZJ+8k23IW00Or6rainENaTTzhQvbCmgiORBmiO3JJ3lk4kqqfqWdTQYx+qBeI+ROezFCyfSymoIpwz5qwHGxbb7OTnxJ4vREEFcUGVCXhIvSx8SiLLOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/7] sched/topology: Introduce for_each_node_numadist() iterator
Date: Wed, 12 Feb 2025 17:48:10 +0100
Message-ID: <20250212165006.490130-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c29e736-53da-40ce-0ae5-08dd4b856203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqqVNFk/pzG5rc7LFvEXUM4/wKujITT/rLLYysj9J8wU7Rh/hcKh85cHD0FY?=
 =?us-ascii?Q?t11jfnXhjUbUdpVLyO4dwGDRwk4irDSiQ6+GSMHV+3S7brfOHq+XSMvKx1AL?=
 =?us-ascii?Q?BKzG2mQBsroDrLH231rE62GtXjU4QYTSlrfeLXHsKYt70fFperfT3NTI+/qv?=
 =?us-ascii?Q?awMCLwbE7GkWAlj6gm0mehNBqk8MiIbIy0MUwbhZadJ54AGplqDx7fvMw5S5?=
 =?us-ascii?Q?1P3j9Kx/o+Kc2e3zadKfStpQTSr6dmcLNByuzA8T7zowx/yZAhbIder7iszD?=
 =?us-ascii?Q?toCjGHE36YmK3v2JKHjlVRyWub17IlhIJsrmx2z1Ywk8efSVGNsDrGMoNK0T?=
 =?us-ascii?Q?GpUrFXGRolEFglRxb6j75Q8+iH2Qsw2Eqt5pxv7TH2/zXcDpdhN92bFyR1lE?=
 =?us-ascii?Q?8xXQdUnz1tMO2d7FusT7r2yO59hrzakeWN9xx4aM42JbkWhbVGuGXCzKBFt0?=
 =?us-ascii?Q?CtAsBVOHQJKXJ8yiBfi+bDIdIozHjJaelC8MJbVrfNWNsE443kzRPlwlt5YQ?=
 =?us-ascii?Q?cMXlutkWLKmV8fzuCBtlcfQLVVAHb2vJu9FjBbRUIPvStwifbqEIAn0D0bbi?=
 =?us-ascii?Q?Sfz0cRzAGuHzkwZLZC3ZmlLdVg+tjfn7ATCA32JdMQo7+UbTQGQ0U69vGArA?=
 =?us-ascii?Q?MEun/rRy87/yPzDoIwHYwsV52B3G8f1fnZhEvnEIlT5zuzjaG+vdiFpaafil?=
 =?us-ascii?Q?znd/55bGul/caJjczGMpDAV5WRGcziWH7Bn1nLRHd0LOLFZft3z8f6JUWbqM?=
 =?us-ascii?Q?P3GgOs/2c5CmLja8fbYdXd6YXQiAq8GqgNcHtT3JyE0hyjt1N2Y9+1OSFeyZ?=
 =?us-ascii?Q?6gloRdlpsx1F/SxOXcXWVrYsipE6Wn9TZSpJuOZ7r2BiRlpD/J4zGWFWbs8Z?=
 =?us-ascii?Q?LOf8fXPkkGabZNnrCo0KbGKu36Z996pqNcCj/wluafXSY+Z1NXlChj0Ih1y4?=
 =?us-ascii?Q?3J1h+E1hGqfBq9F6p2XXFfckjZh7evQuGE66vM0EPWp1ixi+DYNjDRAxcC6m?=
 =?us-ascii?Q?7m/FKD2z3OexKGs4Ta+o65ihjpWNmAPhATsbXzVYS/EpRzrnK3zce2uuM+0r?=
 =?us-ascii?Q?SdUKZ9QIlgbkS/dQxFfK95A/ZWomYyL2Exbj3YBAqLt3kZXzQxGiYXY18vXS?=
 =?us-ascii?Q?mgvIA5bIREASO+oS3dN6HEK0VWI1jDTSbcIT4Mqx9uE60qVtNM/XPAyVbuyL?=
 =?us-ascii?Q?ZpFC6kK2ZpUzT9O/PGFNf1IfA1VyxnZjSFSxy74npeHhfxCK0wsIiIzFk+Fy?=
 =?us-ascii?Q?CySATiHL/Dhy2PIcd+KVgqjzg4ixRVpiENaOtWgw2FQfomGSwKIM/JE05BiA?=
 =?us-ascii?Q?OBZ56xFVuF13umF8p8vHC1R7xyiLcqEazF+Jo/NuW2ujSTTru9N4edhr6CGE?=
 =?us-ascii?Q?Jt470NqMEBr5Suf4q7rx+RS6crfF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tTkR7tdbe9W4WDknZCUJdMS2nxEtvLNfp+Sc60YEvwhr+2fLKXDro/wdkzP?=
 =?us-ascii?Q?hJMvqh4lUjBkV5zYjDPAiTzRNE7QSfFho75KdXIOnqZen05KumxU179AUAUR?=
 =?us-ascii?Q?xZk6j3nif+4txd8YAc5HgM9UVj5kpePcHZKNfUPVe0MpbbCzwMw/KAvHxs/y?=
 =?us-ascii?Q?Zp79AjBYmspS5mb0bH3vs03qfSYxdVtgrD+yXwGbDYV0CZRDsdEFNYT0Vn9R?=
 =?us-ascii?Q?onqcv6mnwe3DAIYGzL3h+cJhSqFNJXowyQGZ4vUL2P+4k8IiMjkn/vQNJGXF?=
 =?us-ascii?Q?xNdPbEKuLGIC8jYWXbMCLeBJSpVc0b0rGuVzFwrh+uGnECu+OMsoUzqA5iFj?=
 =?us-ascii?Q?6hkSsS0LljFhTlYZI8F4bwbGu8omlEREP1a8SXVfhBIHR+7fRYgDbv2KnVib?=
 =?us-ascii?Q?QYy8so6H7fhoAdtRCbgzMBLPn8K4PJWD/BT09fba17kaunH8ts0xDc48wK/A?=
 =?us-ascii?Q?RQiyByQHGvAdrU3+j34bJwp3ZrlkiUBjNhRyMrQDJz1fR4EdGeV7CfgU3MS7?=
 =?us-ascii?Q?AWUFEO+ltfgTxZmugV7KhJQ6u1UsW5dbdbMbVd+l44UxxNjYIOjlIgyrY3WD?=
 =?us-ascii?Q?XaVUX6t+IFCGVzkgdW48g9RpQly5mFLLGs8JxnyLZYmkni/ykbqsJp8UJrLO?=
 =?us-ascii?Q?FhF/no/nToPXBXWy6S/HgwYBZkoqu4cpp1m90blp0mocPFnB4f1NzsKW9H5U?=
 =?us-ascii?Q?7joW11TltjifwP1fj0Z4Et580wPhr3Pbelh3VbMRALSh96lM0mjXdrsiGyCc?=
 =?us-ascii?Q?U4XM9f0Bef899OfULUvRGTFZfW6osI8o6x0QjjHYX8OAbTzAF1Fn5JMNuKaI?=
 =?us-ascii?Q?NTlQHQj1k/GDqi0lg0suizgIv5/otV6uplum6jYzk1KboCMKDSt+VwSfCvyD?=
 =?us-ascii?Q?8JPLMzVZ1sVqCkTTlg1oXE4atxD3TKx0gVuYoQQYPeOddTR+wSRxmX/hn+fL?=
 =?us-ascii?Q?la1aKI0ytEC0scHJY2YR0eHMIE3oRSYeoVLldYeT8DCkfoXzHZd+MAmFrhtV?=
 =?us-ascii?Q?3K6dkJZhvo+dIqQv3Yq8LidQum7SVOMatSQQd3KB6XQaanFGKw9BjO9R9T41?=
 =?us-ascii?Q?SHVF84z6eS2EyWPYe5tZOXrVdyRrcGqzAT1higBPSvzVnFLQkuCk+h4LcY5d?=
 =?us-ascii?Q?TpnruKvE7JYiknsZLxk5XwGxWM06qUYdwKkXLvIXw9cZyzFz7JaOie6tfkpY?=
 =?us-ascii?Q?nKDOAeW/ZmhENRWbGTxArc4unn5KLsHtfdYsDITvm/Kb7vw8ghiVVYiNcgzV?=
 =?us-ascii?Q?2K6BS+KbSL2ikncdcqqhfS6XBepYCYg8qosvL+2UFbgNFouS+gT+W3ZikbGv?=
 =?us-ascii?Q?w9H6gkD127pryuCXDS7uejzEeHTL3Gp5oqeQ+o+YUbYc7acJgZS4ekVtw+Yo?=
 =?us-ascii?Q?wKLg+oPqkB5jLpNQJT1NHl5f82j0AOQvO1SMnYM5Xewb7xCaaXIxQ9K4hnFx?=
 =?us-ascii?Q?UgwXRJw/ONF1kuRrl9IIs/oufSc9dy3LG2ediNciRKspxKgxBOjTG2cMgG1S?=
 =?us-ascii?Q?SjEQ5H398p+3w/E4SUqQ+HLgVTvf7zkvdYfDOZqngcBGG34FERDvp3i/LO8f?=
 =?us-ascii?Q?tW6hUvO2SqJMd0vUuOBQ2Cu+iDolDft2urUmcrnF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c29e736-53da-40ce-0ae5-08dd4b856203
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:40.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHUAj3qVmhPljSciwF08ElJmphyZJn4uLG5wvidXLShNDsDSSbscu2FitJ7QZmb4XOAQwTPSJysRUzYux0IBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

Introduce the new helper for_each_node_numadist() to iterate over node
IDs in order of increasing NUMA distance from a given starting node.

This iterator is somehow similar to for_each_numa_hop_mask(), but
instead of providing a cpumask at each iteration, it provides a node ID.

Example usage:

  nodemask_t unvisited = NODE_MASK_ALL;
  int node, start = cpu_to_node(smp_processor_id());

  node = start;
  for_each_node_numadist(node, unvisited)
  	pr_info("node (%d, %d) -> %d\n",
  		 start, node, node_distance(start, node));

On a system with equidistant nodes:

 $ numactl -H
 ...
 node distances:
 node     0    1    2    3
    0:   10   20   20   20
    1:   20   10   20   20
    2:   20   20   10   20
    3:   20   20   20   10

Output of the example above (on node 0):

[    7.367022] node (0, 0) -> 10
[    7.367151] node (0, 1) -> 20
[    7.367186] node (0, 2) -> 20
[    7.367247] node (0, 3) -> 20

On a system with non-equidistant nodes (simulated using virtme-ng):

 $ numactl -H
 ...
 node distances:
 node     0    1    2    3
    0:   10   51   31   41
    1:   51   10   21   61
    2:   31   21   10   11
    3:   41   61   11   10

Output of the example above (on node 0):

 [    8.953644] node (0, 0) -> 10
 [    8.953712] node (0, 2) -> 31
 [    8.953764] node (0, 3) -> 41
 [    8.953817] node (0, 1) -> 51

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/topology.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3e..932d8b819c1b7 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -261,6 +261,36 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_node_numadist() - iterate over nodes in increasing distance
+ *			      order, starting from a given node
+ * @node: the iteration variable and the starting node.
+ * @unvisited: a nodemask to keep track of the unvisited nodes.
+ *
+ * This macro iterates over NUMA node IDs in increasing distance from the
+ * starting @node and yields MAX_NUMNODES when all the nodes have been
+ * visited.
+ *
+ * Note that by the time the loop completes, the @unvisited nodemask will
+ * be fully cleared, unless the loop exits early.
+ *
+ * The difference between for_each_node() and for_each_node_numadist() is
+ * that the former allows to iterate over nodes in numerical order, whereas
+ * the latter iterates over nodes in increasing order of distance.
+ *
+ * This complexity of this iterator is O(N^2), where N represents the
+ * number of nodes, as each iteration involves scanning all nodes to
+ * find the one with the shortest distance.
+ *
+ * Requires rcu_lock to be held.
+ */
+#define for_each_node_numadist(node, unvisited)					\
+	for (int start = (node),						\
+	     node = nearest_node_nodemask((start), &(unvisited));		\
+	     node < MAX_NUMNODES;						\
+	     node_clear(node, (unvisited)),					\
+	     node = nearest_node_nodemask((start), &(unvisited)))
+
 /**
  * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
  *                          from a given node.
-- 
2.48.1



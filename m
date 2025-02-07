Return-Path: <bpf+bounces-50802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B2A2CED9
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E433AB2AD
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E011B07AE;
	Fri,  7 Feb 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tU54VVju"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B41AC42B;
	Fri,  7 Feb 2025 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962693; cv=fail; b=rJ41UQdDSLTyj8dm2eweCGV819NEI4k0svH9ZYUXNzzh5W9bu1+pRX/4upJAjtwerid/IwJodT+pEeqQcqEcMg+NM7/taPAc2rx42uKHX+Oxavs/TktRX5uu7uEhjjfebAivXyU1KEt+KC6DA2PLzxq41HtIv1bOkyTBNCZsItc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962693; c=relaxed/simple;
	bh=hPrN/NXYf9iyAOTRtvTf0OYnWVi26KWPiywnj21bTmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OieJuZDjh2xGvXiUlJAoXeLWHyVaotjIiUMSZaVW1xE7o71LRmgRhCU9sNRXHl+zR643Mk/yKVp84HxpNnYQ4Vvp4kWtT34SCv3HbH02peaq4XfYFs+guvxq9KXmZBqAmDTy7hqzCEKs5MTNTtwCgGUPfZ5aoHOwo0F+OTxr12A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tU54VVju; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG+O2HzoHpfbso6fy75ZEyOW8mKLcvzLkRm2phAnfl55Rm1+vpxsqEECk7/IW1bCOq8Mgtkoi8gEbqgy67y8eeAtWpTO5S6Irf37AURdz66PC2NmCtIfVzHYQl235KP36e2sIJC0qIBTyMLnlL5oohZLqCTjIQGqEPLOUkMIUOy6QkFoQ+PEPmEQkzWIlt1Ez1EeXfmzfMFQPu3GEDiXG6r0fIjnOPiNwGXeYN4JmI0w4FiDdxxPtsZ+wb0L78SZSjelaYyf6d73glWd73rF/Eo5c7+uDai2R8QujRBVOm8I6XhUSAvrofHHOe5lyhdkyzA71zBzGhaW8hBlzFkblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3vn7S5h43JQ7Wb1tCw5bcivFGNoOZwO7Y1hCvIEl/Q=;
 b=NNnxEyT4571pVQntmxFFevIljteKw+vXOBKBHW6bKXB0qS6BDG1Ep6eU/9bVm2LID4sHeRozehgUUS77EwNMOUg8U+Yx7X9Og+InVQaSdp/gaV/c9qvGVJFMuseShWlJHEGynedWJ803n9wFo+Q/8PkfA1jikkCq/0kIF6g4EfRDJCillybmBrA4V3G8RTNJQDMWX9K7hUaF2VwBRuPMSC7DG0DPBYn2TMMr9XSFCODdzMizNhFWLKwvFLpqfcxNB2l7ci+Cz08YGK7WmfQGEsdX7XCWlAVXjjaOVWSk4ov2hrvltwTqP/ssB4pkkqHeWZ7fpEVyz+dIbUwlis/avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vn7S5h43JQ7Wb1tCw5bcivFGNoOZwO7Y1hCvIEl/Q=;
 b=tU54VVjuPZp7DBo1KffxfRMJfDsF4BgQUbuvEPEKtVmG8n01btEtlr+6EjAX0eOelkumru6aUk7Wnp+pbeo2htQUkhqBpYk0VajkIp6ChnzQ4drFsfEEZkfu/mP2oPalW9eVYsnprGGTNXsX0LXBWeVYCSiGO4TBSb/iGWxwNaWjeOXFK/AxRmoT5kBcihChXouC6XIjBhEZrVTae2f+wpFVvGxf0AC9yTG7c0of+sekOI6jWw2sQS3XFwBm8bS7x6s6/14Bo35RFKMypbUIE9pFTWHwVVQurIrGsXjnHqU8WDhqqL0NqJHXWDXAIRkupCIqFA3d3K8LE85sZdSh0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:28 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:28 +0000
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
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/6] sched/topology: Introduce for_each_numa_node() iterator
Date: Fri,  7 Feb 2025 21:40:49 +0100
Message-ID: <20250207211104.30009-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207211104.30009-1-arighi@nvidia.com>
References: <20250207211104.30009-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: ce99ebce-fb81-4ad0-0cbd-08dd47bbfc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTlGdNfw5iagx7bYiMUHsBZgF+8PS3SDvN3rmtacGzXYjxkrenOfPNGVhZuz?=
 =?us-ascii?Q?9aMVM1ehLIqYqALKUI+ROAaEnm/0EZDkUHXm7uwt2V7GvxG550Fq7687lUVK?=
 =?us-ascii?Q?aMY+24k9SwQnfbTxWux9Prfqi1g6symu0rUJY+aJ83QWrL5EUBnEeyp8T0oR?=
 =?us-ascii?Q?W213sXuKmgpo9rmUHcT0sOnamE3gFI1N1KB0GiDfB7xzkaz8+TkIcryAbQ60?=
 =?us-ascii?Q?fgPO/UhThdgWRCJ8G6p6fsitmr4nxBHvvrRFd6Yz4B089KdrIGwZMoviUv2z?=
 =?us-ascii?Q?VhHgwwy/cSZPajb5P4ELimXkBVzCj7W/S7N5CvvMnvgMkEjEJ5rqvfphYnU5?=
 =?us-ascii?Q?3PLHmUul/bCCq5+YXIQLIg2p0XBcDm58wXwuZ2lp/HjNGj0Njl+FGilQFr/q?=
 =?us-ascii?Q?rI0q7rPdm/rg4kQaS6Mw5q41TjU5UderoXStzJfRzhE1AthAkuNlGtXE4ma5?=
 =?us-ascii?Q?oq6rqhrp/mRROdmwKuV/i+Q/PE7nNsmXR1JIAWrMfncHPQ/fDP25Y1lpUmsF?=
 =?us-ascii?Q?OkD9B8Zb1EJVjvgmL+PyYJx0iasXfZ2sJk9Q2S6aEwiJsQQrWLRW948/tSjR?=
 =?us-ascii?Q?h8NhfBt1zgiLiiDarFxRhuqA0537GaCR5QQXx7AhtBYxSW3xjRtuIxwZBCFs?=
 =?us-ascii?Q?BJVb5fAmH6Ri7gF3fMGdKRCd0A+zQUCvlVFr0i2UaHy358Hbfl1qXdzP0gmV?=
 =?us-ascii?Q?ELG+kjVr4lZPk0nCI3+rZH9lG9+VG+E1W5z4H81ie7cfNXrcmQCSsy9bRP89?=
 =?us-ascii?Q?YsPyUaKfuAxRqXydChn9smB3Au7/YVIV65anmlSSqeKMuHiw9Vdmtu25hpxK?=
 =?us-ascii?Q?+PhkgpvvAEaKyIst6Vmkw+r6taZy7d6zUzYm+9BPWUgl921mybcUpb9sEhWl?=
 =?us-ascii?Q?l1Tirk0peUeCaMmS0h4ICUDfaGeagn0oukeIqToriuTucPoTbva6/F+irawM?=
 =?us-ascii?Q?gkTJlE77IY1qAryuJ5vMSuZ6YhzRAYh/OXRv87c5EdKKlXibHDRKZ/TcrHAB?=
 =?us-ascii?Q?8O2zySQ0w+GoiMXeuMfYBJTQfcUtYy4oT4Ju8W7By/zyQ5cBthHuvpXmKrpx?=
 =?us-ascii?Q?233SDE7SBIprernlGBuo2DnkL3tK/lBP6goKpxtk/xHFi9V0lY8Jm6JZi2v3?=
 =?us-ascii?Q?UwvKC251zXRoE5TgGhifbsrunHwqF/FUwyq7SmhHxRFC9wIuNndH3j3ShYIu?=
 =?us-ascii?Q?dHZIQYp3e88S8g0nLW6w5neQcyuzIWsMIQ2pShdLvjzxp4Yxy24I/Kd4KAE4?=
 =?us-ascii?Q?bc7WCKTWiYvsAdk4DN/pPLk/U9ChL4CxAEZO6a4vleBSuW07GBxKL5Hh3Wfz?=
 =?us-ascii?Q?SuKpxqYIigiurxinFyDZD8x9sUT9PcuwA13dFqjSEm+ri0Pv01gWiowqXHmf?=
 =?us-ascii?Q?UcmGeP2GNhjFWJk7BZsi/PS0DwvQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CvJIKDDpAABgCaPO5n1U6r9KCwHU74tbphMuVjRuPuPG8iXgnJ9nqWbTeUAY?=
 =?us-ascii?Q?zJEIrNXcKyiFOZzUWsZrE1Z1W365v/ufZ3mBud6E0e1lrvsAd8uSUQ1oFbw1?=
 =?us-ascii?Q?BR8T7P6v9B7IeFcdTCvcrCX/boCrl7uwS0pSF01di0E6PnSG4JpQGgTBzHyE?=
 =?us-ascii?Q?m3nBlVdzzL0fHvhFe6trDuiihU7ciXQ34vl1TnHhuZgoJuUgzVdYGXYplezS?=
 =?us-ascii?Q?Au+pF1ERu4SRX4KZ+srQXY5eC891HPcyx+TpaZG3s5pSqpZ3vGv41KchyyW8?=
 =?us-ascii?Q?iQVR6JYQ8/Roh0ALvbNj00QIGAttzQlOiRt5rVobF1gCwW5MCELjCuSg983x?=
 =?us-ascii?Q?CVtxwe/yEkVK1ZTG3TgjIurHzv3Zbf+7okzLfPUotRfNBO6TlzXBzMu4m9mD?=
 =?us-ascii?Q?fmpLZbbn50W1UICpCqnyt1/2o9klDcQXijrwkJlkwTVRC0U0nliI5Ghey6qu?=
 =?us-ascii?Q?IPiQnXqlpl7Fr5FkLWdae0jBiQiRy/LzO8nywvb9gRqY8F47CDRDftsttR7b?=
 =?us-ascii?Q?a40TUqD34AAa8gmtmKan05bMPnhy5X+jN+i5LcajKbrsGaO+dJdpcMMOAjVi?=
 =?us-ascii?Q?GR72f9EERYp5pdRb1EuUPlvElRPBqF0jGRB8Llccj2k/ttEfkxMOfoRiqcii?=
 =?us-ascii?Q?TbxS4NZUWB+pqfK4oI+9Co49bvfNLWWIRnm+Evr5cS0LbJjRBRvWYaHSObj+?=
 =?us-ascii?Q?7G+rst6N/f2jeXiWWwd6sSVbZMOUhiBua0j07A6iVwGL2APw/5lg8T1spYpz?=
 =?us-ascii?Q?Kam2zNJo0bfant66Js0Ikl6SblrLtVkU8lXdVJPMuBib/ND32R1UEFGyy2mk?=
 =?us-ascii?Q?1LzKO//dR8IviSl/8eTla3iUp57Hf0as9hfvuu3PPszttkiBt6Uz2LltE+eN?=
 =?us-ascii?Q?jw+PySCE5hR09R03gJt97D3YbkfqMTH/ChrNtSWbj544FkaRyY/982UpTYHF?=
 =?us-ascii?Q?f9DXmXzZzz1axyKOWF6OEVW2mg1AYGadTUzMYMaPoi3jGgnRr8JxkEahuc6I?=
 =?us-ascii?Q?v4mdh9k2/oyyY0Yp9o+J4TNzDSZxiCELP2Jz15HRUe/5nqDg7pZp/N12tXJl?=
 =?us-ascii?Q?1hmFBBzTevv5omJQ0joJaTSvkMlCh84aq4uXkVJBiK6F9e4KwqrN3XGoOGH6?=
 =?us-ascii?Q?Gmk4K+7reJ3GzQjET6MZxkEqB4GnkANCbecNoytR0sfkhnpdepjCyGd8Bdiw?=
 =?us-ascii?Q?1QfZ4Q0s3Q21SwFckgvRBQo6jCYD45aTHyDXNvMPnWqXwN1qmYRlvQI3voE4?=
 =?us-ascii?Q?cfsP0rWIOP8UZj7XNKrqrmxkOnNnuzA4UmYlEua8psZj3djf8hcv4fh1fKoc?=
 =?us-ascii?Q?y/GuITcxl+QjS3ZTuKZjM5X1F5NO/sYV5n2Koi+vT+q+LpXKpvpp9lSZ0Hed?=
 =?us-ascii?Q?lNIhniW0Y12yN4E98lVZwCSjl7c8JPOKtjT/TDRdL8QYHA/UnRHzrRc21klf?=
 =?us-ascii?Q?JrC28BcRyIhLRLooFatLXmfCf20R07NLpGsNdtZQ6OQNZXKNGsFe3A18vRou?=
 =?us-ascii?Q?173v/HAy7hzLPGA/CdAYF9ITLQDGIAAU9oOcZGHhgCXVM4CF1yQOj0mHjxLe?=
 =?us-ascii?Q?ju6hDDSD2tDw0tJtqPIoh7Kt+IgHD4Cqr7JGkPLY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce99ebce-fb81-4ad0-0cbd-08dd47bbfc8b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:27.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4I2EHHsOq+7Ba6arR+VeAVbMQgAc4uNKOsAMGghzNtjy4tiKiiGv85vS1mT75x9HySWj7daaDpnqPq8nbtP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Introduce the new helper for_each_numa_node() to iterate over node IDs
in order of increasing NUMA distance from a given starting node.

This iterator is similar to for_each_numa_hop_mask(), but instead of
providing a cpumask at each iteration, it provides a node ID.

Example usage:

  nodemask_t unvisited = NODE_MASK_ALL;
  int node, start = cpu_to_node(smp_processor_id());

  node = start;
  for_each_numa_node(node, unvisited, N_ONLINE)
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
 include/linux/topology.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3e..09c18ee8be0eb 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -261,6 +261,34 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_node - iterate over nodes at increasing distances from a
+ *			given starting node.
+ * @node: the iteration variable and the starting node.
+ * @unvisited: a nodemask to keep track of the unvisited nodes.
+ * @state: state of NUMA nodes to iterate.
+ *
+ * This macro iterates over NUMA node IDs in increasing distance from the
+ * starting @node and yields MAX_NUMNODES when all the nodes have been
+ * visited.
+ *
+ * The difference between for_each_node() and for_each_numa_node() is that
+ * the former allows to iterate over nodes in numerical order, whereas the
+ * latter iterates over nodes in increasing order of distance.
+ *
+ * This complexity of this iterator is O(N^2), where N represents the
+ * number of nodes, as each iteration involves scanning all nodes to
+ * find the one with the shortest distance.
+ *
+ * Requires rcu_lock to be held.
+ */
+#define for_each_numa_node(node, unvisited, state)				\
+	for (int start = (node),						\
+	     node = numa_nearest_nodemask((start), (state), &(unvisited));	\
+	     node < MAX_NUMNODES;						\
+	     node_clear(node, (unvisited)),					\
+	     node = numa_nearest_nodemask((start), (state), &(unvisited)))
+
 /**
  * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
  *                          from a given node.
-- 
2.48.1



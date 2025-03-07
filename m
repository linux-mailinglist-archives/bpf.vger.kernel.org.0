Return-Path: <bpf+bounces-53612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1723A572A9
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C39189AC9A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A2256C6A;
	Fri,  7 Mar 2025 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/KcaQCW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CE2561CC;
	Fri,  7 Mar 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377947; cv=fail; b=EA+JwrgGJcLuH2JS7y1Q/AjyI/nrsGRjlwinXxLtJdIEZeGBo+xCNtGn2N8ls7iteachH4WN9CgLEgz8z6m/dT97O9fZeVu5gucbqZoCBc4Xs68StCTP8rWoSjVBdp9TsX5QR/QtfeFtroMBDSu8qgMnpp8Y4aXD9kePCnYO3x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377947; c=relaxed/simple;
	bh=7xuuRI3AoE7LP6J2c26mO02ZQmue1l7yVB4l2APZpfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyhi3C1FzimfXNMC2cGI2tmXEmHbvtHs/UBuCv8KLIaj9DKhpXubSKbspbmLobgsfo++UYwe2oYXj9G1bQwWnAiZL9lzWcHusuNYaHhxnqS8lE3zQ7QFbrtSL3zkMhlIdOjKS8sPcd8U893gbCMtevGOakGINCSFmWzcj/foFVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k/KcaQCW; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4A0t8YobTFinolQe2a7WA4B8ksW27nOU0zX0he+PXvgTSprXg6gu/EDyLHweZUarPIW8oo3qoyH5BP/ELEyT6cXfT1+foMmG6SzIBGoGFa46f/+A+YexN2TxixvwwUqttoNF2U2XUqpt/PBvePvidlPrSnabZyjih9YWOvrr2WrYd02WOwXyg7C2qssntvLZWRqoCqu3YtKcHvTOjX2S+KNPerSUg1PrRt+A2iBdYeuKwjkeTTYtnYXEira/MPtSVp2rnjkVf26YWSbJrttB0f+Sv1oAuvnMxWdrthM2k/KkC8MLva4GKE3OQW2FaU7IbQ7kkooHekwaurO0qsPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qM3koAKV3gtG0xEekAe//suoKKIiVOw4Lipf/C950g=;
 b=RkI5/grTmRfKMKXm05rH7HYACNMVgq9NoOL1MR3phF3SHipna4bymMD3cQrOl9sxMxChYU7UaOmyuQM+aK2HvHXYHouQlAgscsyBOtj6B8sOcVdpRMZO1ifzSXaTGqHZC7Rg5f+OAWgZ81WqUYBlvMCRc+SCkT3Nahpiu0IFIp+Hvoq+z77bdNBu+IQdclwVlFM8HC1Hdob1tkPlSQ3Um3Cw+zS/vQ3wRS7bC3zXMAAzQYF8AWLxBR+UHgXRpYvx17J4HnvJQil/eCOf645zjlXMH+0RXBvCo2zdx7KWHlUZOpx3x6qK5h3WchXsPOVjaFuYHx5c9aDip/jTpw4pUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qM3koAKV3gtG0xEekAe//suoKKIiVOw4Lipf/C950g=;
 b=k/KcaQCWxEhIgkCoNVayrNxUllNjugJiL06ctYD+sAnUlRXYUYhi/PnurwIgp94U/glFiOc6g7RhbQe6opr7XrsoAl9CyfvXE7o93BQMjVMufnIVmSQ7pKk7QeduQgRcvlOqM1YNb+KXxqm4YKYJlQdxgCzCZTb1c2Eom2gjrhCTnHPF0epMdF2tYvJ1L9JzRpO60+IVzjA5qBnr/hHgiphwFgyGWZBnMWRW39K65VbNBSU2AkbvE7umOAbX1JRLkPMBEgvFENjZoQ1XbACnKh38ee2O69DU0yfVjJlD4ylK9qocavKLUOIqr4sMwI8exUp9cFR/IhOAueJV+72d7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:42 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:42 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
Date: Fri,  7 Mar 2025 21:01:06 +0100
Message-ID: <20250307200502.253867-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307200502.253867-1-arighi@nvidia.com>
References: <20250307200502.253867-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfcac80-c2a6-4528-0d94-08dd5db370a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7fsMD0Oei/xecti3ODvUuWqgl1shYnfKh7voU4zP+9Bw0IsD+FRSCsEo1St?=
 =?us-ascii?Q?1xlBWQLtkhWUOU6hCfUR1+PNmaZmW7wCM3+VSP4rLGm4GUlRr6sBr+67JWpO?=
 =?us-ascii?Q?Sc9EP+DLh1ra82rwFh0jVSiQDO0xFt8ylBpkrgFDOjBIEMzFkf8bd7AoeohR?=
 =?us-ascii?Q?ZT/Hq0ee46UPW6SqrhxzEHkqIR0bFcStaTSPPu79DuLtBnVNVlK/GcmE72Cs?=
 =?us-ascii?Q?QNqVn4+I0FdfNkzK0X+vpOUDu9oHDBaZd8AHwhlXSxR8DxsJ7qZKFsr4VmWA?=
 =?us-ascii?Q?BSz+Vc2K1CZQZyQvf1WCwYDrd2KwhVzIlHMY2rZh5aCya+bBwP83EjKjqf2n?=
 =?us-ascii?Q?NeqoKg59Ry+23NIAkJfz6mQb+DWEEwb00DMqByqyz4QGs1v2K8mRsna+pH2V?=
 =?us-ascii?Q?qCJAR3KJmwRWH/E5uESFqaPAQx5A655Siy9a5Z2M9hWX0caVop3wAmfi/5Cq?=
 =?us-ascii?Q?uTkh1MlyaQmAIwbPIw5hw7Jt8Y1rEnwC+QqFDJe5l2CEs21F/It5vnLbP+iA?=
 =?us-ascii?Q?lV7cHQSTBL2IVPn3rkzOOtrE6FX+NboHNuf3zR+WsVrSxZ4jKMmFoKHjrku9?=
 =?us-ascii?Q?W5XVv0n/DZsJke5MfnKHyqpcfiyz8aXTGSSYzHEPQchU5DAMo1gVRe6bEhf6?=
 =?us-ascii?Q?I1qSJJ7nJnmOcktMv1CCvCkkwaHJ0gRkSLZrRQ3bB3VlNqXdpQRCy80k1k/7?=
 =?us-ascii?Q?aAnEgLIjKn4rkS6XAnFtHsRJljy37fCx312t0b70OgGpbkRNU8NoacgOdSqB?=
 =?us-ascii?Q?pXYiMpIoViISNMT1tgshahNmC72Dv7+PUsWE2sXa4XUxc6VufdTMmIjfGjYe?=
 =?us-ascii?Q?15yf8hPN+5VR5DrlPn1ntvx1kLrLIjgWIAgZSWs3cAbeOFl4Uim1i1UbKBnZ?=
 =?us-ascii?Q?hP689lXcDUjv67qM9w4ApDeQjfNrk2Xq8kToqXQzLiycSTXeQxs3foVNmM28?=
 =?us-ascii?Q?cIGdnmjsh2lhbq3GElL9jSj8PSEuz6jUQz9FiLNVTw6R3+/9v2N0ieh9d/sc?=
 =?us-ascii?Q?H1m5TRVj06NQFa1qKJUAA1Dnvp8tA4pdolDa6/CDSGH6uf5eyt0OVTWtIhUT?=
 =?us-ascii?Q?lt4KdyzUnSwAuQxQ/7YNu0jZHp99T8Hr9wGlQrVZ2n69szB/xESq7+llMQDV?=
 =?us-ascii?Q?rR7ckxqBVohXG0NnGnxfKTvyT7mltVBSTPruJTTH5P9MJOEnq8oNbDLk+kDj?=
 =?us-ascii?Q?/PvtmhfB0IFMYni7kzhO1bJxy8InhIp4YFZTVTt8Rjuko63fkAYeWWO6nTs+?=
 =?us-ascii?Q?yqHpWYTvrVp5OnuvPZ5vjZWJeMfXVKYRWKV2fey5GD5KA7EGcgS9nAs1fZI4?=
 =?us-ascii?Q?EIbMyZKZCga2cWj7QCkC49sdmjSfwRWVZnv+y6G2TLT2aWvT7ilV5P2olurE?=
 =?us-ascii?Q?OK6AkIyjgqZz2XvUVcUxngoCYYS3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBVlCcZiqubxhCpQ0OTk+Xl1Css9DjJ8gMdY6xzMlAmkL8PJARlnIHvydy2a?=
 =?us-ascii?Q?gsDghOHnwTpgkYHpOv9GeX5PCaMr0kyey9MM1qhCVjOBDUXa007VpY1kfnRp?=
 =?us-ascii?Q?HiAGo4w5sWilwxLldp2j19YHBI8wPgSeBW3dJ6g3Ds2uU5U37uojY8EWQ0D+?=
 =?us-ascii?Q?vu4FE8MqAXOQVFm9YRyqzsp/kc5vZIetInv8oXF0pVFhoUoHNLGktIdcG0U4?=
 =?us-ascii?Q?lMOVDt8s9o7seYNWfCOrZvnVFNnrufCCQUcXLWms8rwRkap4McKKKCdezh5c?=
 =?us-ascii?Q?zLIVvVfD+5m6tp6O075UPTEW5gBCn1u6aYdTNAKsPowEvmATz1ldU0BwGrdR?=
 =?us-ascii?Q?XdIpSnuqLJz+Kz354dsA2lifZuXxtAWLr0ubMObk79F8t+PbLouyAzVpbcKW?=
 =?us-ascii?Q?yRNTzCdZ453so+YZbpEFd0ulcqztJ0V58iVTGjklEKX70fbJXvilVV0iE05F?=
 =?us-ascii?Q?3cfiglXTb7qDTs7bkCKxzoYN0kF+4nGSaPV8NiBfuCYTOFWk53dCHHEa2vNO?=
 =?us-ascii?Q?mX+fT0LtZCIjYO2up97DPy3TQSOHlfTXTECEkEsM2PJEDiYCQ2qyFn4J5/Ul?=
 =?us-ascii?Q?iRYHE/A/WUCQPYNRy1wAN7qBWOAMzcIEm9aE3+utGgiV2A4LyIid2wxskCbz?=
 =?us-ascii?Q?9jpPe39NTi/CGpQtRJ3F5byeVWceUeusDaqQmX5WG2MV2rvKjWtJug648Hmx?=
 =?us-ascii?Q?bwoz1HvCa+cl4uIe531eccBZjr3yhTZFmzqYjtBciLQrb9kjUH1c3VkPCSbI?=
 =?us-ascii?Q?2OkpHs37fvoDciXmSdgkWt5tJiTZrCCApCBx49tNrGC9qVarcPKx7EM7TzOy?=
 =?us-ascii?Q?qSEBihuDsx2XIRtb0MilRSsr3W5BqvDjuAJzwwPzT7SZNYU3piqF1zaMeDjo?=
 =?us-ascii?Q?952QL11R4SAPz1ah1DB8Lz6TdpF4orW8Z70PbEQbIdeCKGpMdQ/BcA3zlO4N?=
 =?us-ascii?Q?HAXwkrtyIweI2ilDWjc6vGDQyo2PajeopgFsgL33rIvHJsCmMwnYtwu/tPsL?=
 =?us-ascii?Q?cfKE+IuRQ/u90/STTT5sgMgVyrEhGsgtitpzlYKxx1ioaX4hffMj/oLE5vna?=
 =?us-ascii?Q?ixF1/qLLUz0mayD+pv+74L1WNjIeDUmSU2b1SG/r24kLKIe5J4SIW7DDBX8y?=
 =?us-ascii?Q?msno3JKttPGRaj3n2qEOXnK/R9Imo5QluTgWh0BQZIyYBvr7uACyu2EDlYb9?=
 =?us-ascii?Q?OmBvGtiR6Yv4P7rKbhg7jDuTuq96gNP6p+hMQhIlG6E3XSYIPU3jHBAMgTTT?=
 =?us-ascii?Q?bRE6z/T5oLqf+TRx8OPgUabqCvmPZINpS8xDllUUe8RKrGOoVKq02MtevgFk?=
 =?us-ascii?Q?quuOoXapon/sI9UEVPejVq8PKf0Zf7m341PMhQxPB5nZSGm6WIAqLDVD2uWJ?=
 =?us-ascii?Q?0so9oKGx7ECyJZPiznYDjscj+zZutkSAaP1pQ7sKdAqdzJQ9nWkRZ8inwBGj?=
 =?us-ascii?Q?+5OSfltJ2pz+aha4/9j0H/xkT9e/ghSvw4h6Id6sPklugp3pwouDj/HHIFx4?=
 =?us-ascii?Q?Xk9EXpbbYgQLWhvc9rE62Y9HYH2yt0Wqn6lawrLxAzVjF3Am/QIn5w/Q9Axd?=
 =?us-ascii?Q?foHT37JxDbihYEW0mZukMzYVSOs+dizUUCEleoQn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfcac80-c2a6-4528-0d94-08dd5db370a0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:42.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj2JKWIPG3+N37JL5g/LNdo5iv4F2n7Qw+Rs1LPGR7jVEiAUKCUS/TQMC7xJuThZ8E35jcT/EYRj1RnlM5a00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Provide a new kfunc that can be used to apply the built-in idle CPU
selection policy to a subset of allowed CPU:

s32 scx_bpf_select_cpu_and(struct task_struct *p,
			   const struct cpumask *cpus_allowed,
			   s32 prev_cpu, u64 wake_flags, u64 flags);

This new helper is basically an extension of scx_bpf_select_cpu_dfl().
However, when an idle CPU can't be found, it returns a negative value
instead of @prev_cpu, aligning its behavior more closely with
scx_bpf_pick_idle_cpu().

It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
strict selection to @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to
request only a full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying
the built-in selection logic.

With this helper, BPF schedulers can apply the built-in idle CPU
selection policy restricted to a generic CPU domain.

In the future we can also consider to deprecate scx_bpf_select_cpu_dfl()
and replace it with scx_bpf_select_cpu_and(), as the latter provides the
same functionality, with the addition of the allowed domain logic.

Example usage
=============

Possible usage in ops.select_cpu():

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		  s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *dom = task_domain(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, dom, prev_cpu, wake_flags, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets / 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses the
new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:

 $ vng --cpu 16,sockets=4,cores=4,threads=1
 ...
 $ stress-ng -c 16
 ...
 $ htop
 ...
   0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
   1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
   2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
   3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
   4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
   5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
   6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
   7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across
all the available CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       |  1 +
 kernel/sched/ext_idle.c                  | 42 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1e9414ffeff01..a3c7c835ba857 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -465,6 +465,7 @@ struct sched_ext_ops {
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
 	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 9469bf41fd571..1977b1368da7f 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -897,6 +897,47 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
+ *			    prioritizing those in @cpus_allowed
+ * @p: task_struct to select a CPU for
+ * @cpus_allowed: cpumask of allowed CPUs
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @flags: %SCX_PICK_IDLE* flags
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the selected idle CPU, which will be automatically awakened upon
+ * returning from ops.select_cpu() and can be used for direct dispatch, or
+ * a negative value if no idle CPU is available.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p,
+				       const struct cpumask *cpus_allowed,
+				       s32 prev_cpu, u64 wake_flags, u64 flags)
+{
+	s32 cpu;
+
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		return -EINVAL;
+
+	if (!check_builtin_idle_enabled())
+		return -EBUSY;
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
+		return -EPERM;
+
+#ifdef CONFIG_SMP
+	cpu = scx_select_cpu_dfl(p, cpus_allowed, prev_cpu, wake_flags, flags);
+#else
+	cpu = -EBUSY;
+#endif
+
+	return cpu;
+}
+
 /**
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
@@ -1205,6 +1246,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dc4333d23189f..16e38b46807fd 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -48,6 +48,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
+			    s32 prev_cpu, u64 wake_flags, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
-- 
2.48.1



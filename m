Return-Path: <bpf+bounces-50693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0B9A2B350
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3994E7A2EBE
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F651DBB19;
	Thu,  6 Feb 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+cc3+By"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2021D8DFE;
	Thu,  6 Feb 2025 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873311; cv=fail; b=PxmidxoaN62MmV/Mm6y7p5aWEPHHq0i+IwXNyBJFzg3SwRdRV8Nnk34/s5qlP9tSZX1kd0wGBoTmlMAV+RPNdgCVWG/wEGUy0z1vC4ceAk5wCCKpYcuP6AGyINrXNGCl6vxzW+JxMB7WxLFitKrjGUhYvfswM/axmbIll2WAY6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873311; c=relaxed/simple;
	bh=FvLuHn97ihMHWhIoMxr8TmtEIHIzwXHUbxbyZknVO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIS9cLRWuS1PyHx/zzr6yyx9zVfSB+wU/x5QJO/38SILnxeOmMFio+tkxRsOVt02pkrgSEVegZgI9fZ9I0hLddJYtKoToUOhP+sfJGGRMCWO7EHqhAGiL6Hnaz16Gp7WgWxVXuusguIzllr7mMH8kEK7Kt9AXCRgj9kRfBMDRfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+cc3+By; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOfP5KmKWIGxkahu0poPbHNtQZAfTbnWDoFF4bXMJclfAYKHiUMY5/fCMcXXPRImnNMbToW1iRlLn4g4/OPG+VAZsMq3rMCJuBla9D09gVqhgrZ69wXE5cB45tN/T9FQV72RKHXlhyWrMb6pOmrXlSL/wxMOMqru1/WDJLk/TJsoet/DNMC9xjbD7YVNoNDvEB/iXIY8JZFZAkgpJiZq5f9gBhZZEJ8+hfGMY4tAXfbksk6FSrHtVPht4IZljz5iItcxSgQh9wZ1xVvmVFO5ACT0w6T0LyXJK4OR3rMqHbi2QMYr23SbI4PqpeBTG4VOjO7VpZ7HVThq/qE5tPBQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Is+GHQDv+QhaaLW0HaFvTCx4kBiEf33Lc8haT3XMWI=;
 b=mDJh6KK5pmpUhWYbLMxOjhQd39sgDJ2rZOB8DLhnZWT7lz4+dFWbTy3ZDrl71wTs1LoR7eKh7ddFjYBobr8+VLZxR5GQcrSbYsheTGWTQ3HIP+UyDWA1EFnBLbKu/2DKaya4vyn2Lw9R/JOqYnU5SVWWliNpldV+p+F56axkvuzA5VFDWiK/7p/ehRGDLQ5wCP/hcQilKbNvrvhDLifRCKw1AMVp+ZEucaWgQzCgWEMqRaCEamqL+iwMwPZOpho6Ow2FEZvzJMN1yMKc66M1/yoUpKA9f8TtuhE7vQ3k6f5PyopJ2iKxQpG8RUvESsg6k0LxsOuvlAkpdwQ3LLM7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Is+GHQDv+QhaaLW0HaFvTCx4kBiEf33Lc8haT3XMWI=;
 b=U+cc3+ByEognjjmL4C6RMM2jwnQQxlZyvV4LSCjIBHq/MHORABG3kdmd20sFUgmtqQzKw9T9uYOmmNnu/87jhLDZld8jH8cNtLQdSxnHPVl6kxQ1jQxGA42TssdNwFie9XAvruQCeO+qXdVGUmfhcaizDFvQQ0BEV2lr2+Eg83Dp+8ozuMNuvtJPrNQETOZlXU2YMJ79XxCI2el4RH+wcT/Ta1NQ2VQ+QdMdeFhqbyFlXgMNSmvE45Qdb6UBX1xS7NXkHdSqaH6Wf+ELnORJVzHYL+M8J4KEOv5yVLuw7fssRjtuJ0EWQaJdbOQzQ2wrgfivmd9KIGS0Wo1384F8kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 20:21:47 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:21:47 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sched_ext: idle: introduce SCX_PICK_IDLE_IN_NODE
Date: Thu,  6 Feb 2025 21:15:33 +0100
Message-ID: <20250206202109.384179-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206202109.384179-1-arighi@nvidia.com>
References: <20250206202109.384179-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 965a832b-1130-4970-dd41-08dd46ebe1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e36oDfBpxIhLrTwGcncFizaN4fXaUdvmZwnma1j+Fg/uG7UMGz5pZ0trgFFB?=
 =?us-ascii?Q?EN6TnJbNyiTNEmtuftkulZbl2Z2XMVl9jv6AGi05au5Br+pynrbIuyuoGy0/?=
 =?us-ascii?Q?lBnM2eL/lV84jcDabXaP6Ogtq0tto0CdgVHR4ujD2IpBqJgN9jdNEqobZU/x?=
 =?us-ascii?Q?whu9hMKyS3s6Y/SALojs2UR9TEs2RKQB2yk4lDfahauVEy1/i/XXt8crXXA7?=
 =?us-ascii?Q?jujvap+9XA2/vQHZA1mfQFFiBLwzxylkCUZ8mCkgn9OAA91U9CiWFQGe/YnD?=
 =?us-ascii?Q?CxVecs42gNIdp18bMV6G1BCY2GrsRQ3FIWGAbdhShu59bQOnUxqR3Eu22Qfa?=
 =?us-ascii?Q?EUaW2x+5ZGGvsRRJB2Rr0bJp5SLfJpM0kGnJo+oJ7WToSdKjX7oZcxDUuy0b?=
 =?us-ascii?Q?UteJE8egWuhuFSBvyW69MMxupd56+GMb6kRMSRQVTtFMSQjwoJg1kWmVVb9M?=
 =?us-ascii?Q?LP1SJShpDQFJ1BJiDHku7kzhwmUSxfyhATtRoazM3fvVBHtcreSHBGF9fr1t?=
 =?us-ascii?Q?w88VAJOYEIZqJJsBc1hpaTumyocTRAte6eHLQUtULYDbyXocgB4Ir3LUq+Kq?=
 =?us-ascii?Q?uNc0DEMj3pk8gXLtigvM547wDTzMqyDDEuJI6GdU5Qk83lxc0MyaZv4xVDJE?=
 =?us-ascii?Q?KhWpVvmcjfMXhXP2FA/jX2c/IB6c9lR5xZ7kTXGFeQehyVP9KNlC7r+J21Bu?=
 =?us-ascii?Q?4fPOd+fhnZDpICi5WZki11kqxJyo8puNCjSxFcr2KmUixHq/R4IuCum2IcUe?=
 =?us-ascii?Q?1To2xqc45w6+5yKgps7queg4BPkp/B+SRyB01/OP9KSUKR4M5ZG6+kkoTOsy?=
 =?us-ascii?Q?piCVWdlkac6k5c0Mj6oAnYpUy+DJiaf28c6CXzQ6rliI26NdxohD4RcpLyY+?=
 =?us-ascii?Q?280yBpRl73yeJoczg/blEt8tCHkXgi78ZPfvqKxepSbRBchjHmkZ8lV44yrU?=
 =?us-ascii?Q?84XlATxJfFgtr2KbFzJjvzO+Gb5PutpILetucj9eCx7H3qUcOoKpjbWDl/h5?=
 =?us-ascii?Q?T1Ewl+mxCL3ARgs0gXJq8OlSMFwO5SnxBiqT+sIgaWPc0MqweLUn1B2eAiiX?=
 =?us-ascii?Q?CjDlUVG2h6PjVW8YuHcOBOdEdh1BN19HRcIHuFqpQ40TjH6RNEQWilF70fPy?=
 =?us-ascii?Q?S0SXYokj6whMHepSiGzqmA045hEzFjW96E1pbxj34gm3+sduk9MvdhLOqq2P?=
 =?us-ascii?Q?9lLJaJ463G5Xr9r+NAtL1d02wcUZS1SmpObMlW60H5/aeTYmuEZbLx9611pn?=
 =?us-ascii?Q?W3drxgAdfhR3qEuvCLqupXe3exDDAJTx9qlptF9aucXdAsMEERIn9kNUlVkt?=
 =?us-ascii?Q?DgWLq1l9ejCWiig8It9tzb34azjvW8J6oAOoIHB1NtFEmZ5Y9hO1ulrit1hs?=
 =?us-ascii?Q?fTEvFSw17YeYndOWNMt6/Uj1gGqj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/+UZp2ZpC2rLXnJ8U0IOITrbA3e0X4fYznJQEkdiNpi7nojZ/X+tE1fPwye?=
 =?us-ascii?Q?FtCRfS/beJT89sU+FMtXTlCp4P8+fNCVFqles7hsTS9Grs//EizvqmHW5qQ0?=
 =?us-ascii?Q?mGHPaT8VdxcqXidxkstVsvA8MtS0qqu8E+Lw2X27nzxtE6JovpaFLrw0ORCr?=
 =?us-ascii?Q?JY3MUYA/VHYUNnwBbFAEnNt6ay4LLGREh5AhnzUp4pLC4zgAcerbOM4YbwCe?=
 =?us-ascii?Q?J1yyZewlHIbtw1cuZ993hauigRZnyFghkHSi4wCLSQFf42LCMSBcnMXM7zFK?=
 =?us-ascii?Q?MQLMmXK6+DUZhQQFCn0KwYHYu+RSDhqipZbGt3L2/Dl3qDjRup710VMFsTZT?=
 =?us-ascii?Q?1fUaSYEFUmDhg+j983oYqMTOkcskipE3bOkGEsMmCygDtAI5Zs1uUH8u2Rg3?=
 =?us-ascii?Q?k6RZ48hkbJLRy1wMciaFHxboLQ5Kagv3wtdIpk4f4KlghpC2HuHGgIsXyxyH?=
 =?us-ascii?Q?RiKyERmNiD6UPrVV+8Riw35+0wzHz/bXfEpDm7pHfZ+D/k9t3FG8OJtzLIeT?=
 =?us-ascii?Q?JGK74+LQfrNySTvvzo1qn2uaReLMJaHGSTVp8cP4t6eIzD5K9erYA8rTrmO9?=
 =?us-ascii?Q?DbjN5nSrWl84IVmKaMdpw+4fZab2YUa1dS/CwsypItoAnq/f7dvFjxNiFC3g?=
 =?us-ascii?Q?1UNMrTKRdLBDPgw7Xv7YXmC86ovArnuEzpDUelKaYXy+o+drYMyuuM4GZHjr?=
 =?us-ascii?Q?YxS6uxDo8ZZcHxF6xIMGGUxdvkWgAY0ZOeaRjsNhGgik+sfVRRBuIxlrg6ww?=
 =?us-ascii?Q?z/e7alFQJ+bLxLaqOIgj7r8RroZGZNti2Yxk0g39dEMwcUtCqPBe4enGeC/p?=
 =?us-ascii?Q?0Ej2DGcA/gZdELb0iNew96rFMqgpNqRb+Ah2W1l/CCbQOCjak3/2TS+k3Kpc?=
 =?us-ascii?Q?FGoTcQQ6eV40YxqPxCXBWVqe90i1XvGot7J564I7ICaqjPg9nM7VW2al/hxN?=
 =?us-ascii?Q?dM8AgDZT7/+yCc8B90GkzIFE6vDAlzx30quiflf6NyM62YJ3XrCT3wh+Igdy?=
 =?us-ascii?Q?knnKE6Z+Zq6rxV/L+QkN/aTW8pOg+RbQjn5VMtZT6R1PKQG+GApPMmxpSs96?=
 =?us-ascii?Q?MlQ5vIX1S/oPwvaSEMJShE3gB9pZmcLYVQdhJxkrDpd4VKh5PIUI2aMrRPI7?=
 =?us-ascii?Q?Iwh7BlU2hhQzXsGBpCs/Vh18iAtlN/3NZ6IIGqhY23UjQ9+rBhNxujDA+d9s?=
 =?us-ascii?Q?CUxQRSWRTwjlcnxtnRZvk/Vdx7EKYMSv8QFdE3/VuZHX0CjrCUoOm30BE9ac?=
 =?us-ascii?Q?d1CM11DRqVsIYse52DP3QGKDJv1VC5kWZXkzh9r88dz8xYeHkzk5YfVwr1gK?=
 =?us-ascii?Q?xBmwLDWYq0TstPCw1QMgQaUakAZpGmnTPeXOqBteJUlQxyYOgJ2fyGOGCc0V?=
 =?us-ascii?Q?wcOybgjisZQdJKpxzC5R6Y7OGMAaoFqQn319JBDC/sMiIJg09134E0caaYvH?=
 =?us-ascii?Q?OP1laCUy3KKbxjq8vLfI6SQk49cEvy5vTh8IQgPDXnc7H8XS7B2U1UPj8llo?=
 =?us-ascii?Q?iFsnejF9betFrQrhMXZ/qIXbOVqSteqJgLsqZXzv9grpChBeUPH04Uv5EkW3?=
 =?us-ascii?Q?C1Q2chDMGUGCSi8qSWIpsI5Xx23WQjSsiPOGZxTH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965a832b-1130-4970-dd41-08dd46ebe1a6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:21:47.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NtH1QVfZYOo338dlyi4NbYzYyu/tiuB+iZeWZtfJS4b3JDSsbSKSmTQUhd4m2+V/BTbliOYa/6Ztr4U5IqY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

Introduce a new flag to restrict the selection of an idle CPU to a
single specific NUMA node.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0063a646124bc..8dbe22167c158 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -775,6 +775,7 @@ enum scx_deq_flags {
 
 enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
+	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
 };
 
 enum scx_kick_flags {
-- 
2.48.1



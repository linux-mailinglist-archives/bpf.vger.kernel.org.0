Return-Path: <bpf+bounces-50804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E2A2CEDC
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB591188C564
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6B1ACEDF;
	Fri,  7 Feb 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+9+vLLF"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CB1D6193;
	Fri,  7 Feb 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962702; cv=fail; b=kclNFNJGaxrOYRLV90HX43KGN7eAQ+8YXrLgLm6YyNg4CF7n4+2Iwke/7eQFXtA3mNgIp0HSSThDLVKbmoH/JfLTr/z8rwomNqqZiYhRCUWUMmWI/8Xs7bdibmAZDemo6NSzaIdFyyoEdJkjVvAR68Rlyeh6sAVbmQlGQslkmDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962702; c=relaxed/simple;
	bh=FvLuHn97ihMHWhIoMxr8TmtEIHIzwXHUbxbyZknVO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocVHK5vtF1NslG769DdWl0Y7xO6NVV4eJbixwFlbtNnOb6tyEyZXTFcECbL4zA6REoueRvUBfmy85hmsabNCKgN1nMZ+oS1S9dT6YfA515lKGAWbNcHlhk58WPm+P4HDMgPfueN/N65M2vhMdqRqrzH/AJufX6fUZKkFBJEIjo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+9+vLLF; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUWtzNYzkZLdcTf6YKdAuXA868JJy4SJTZSwqbi/+41A7iayuJDqaXzsoDAEcMfye6/um3pJflAQGMvTjq1FOJUIT+kpKkVoBBcRHfPQ91ZxnSufCPKfW3l02EC3JRNHBn2lIupWdMNhE9/1TyZiJwHiI4Cprkbp9sEW/d4a4uiU9gSYchHvD2Tarjqm/AoxDaIcopYixV7/H8sYmc8+DCTZeISAp/T/rXnQbHaW+brhy4Gike+aEVo6ZzhLEsItcgqRLb+/aOFDIZ7jUV/VJpmrNpp+ts8tHXiGURcCgsvqOcpFopm+kG0OWC336pk673fx0+rexxjmp5UsnBQGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Is+GHQDv+QhaaLW0HaFvTCx4kBiEf33Lc8haT3XMWI=;
 b=IlerCKkHoffAzCm60dWrwPMxk72+ruLsP9iuvCO7TJkgygHDLPwZm9TfZPM7qd9azflt0DHQ832z3+6Plw5B/c/mxAqVx7FCWCZH2zHYJHmwbkXSSjoWNvTcuFH3NZPTbYcKxBKzRxWsMW9Db5x3t1STFPC0Hmt6UX7vcVNAqWaoE6G0cMUSQDxOoMiHKeZ6fQwjd9+itHo9xv15eJb+aUibfN+RwviQdEYuKr0wSRqVGhfMs9eNzP/VCZhu6I8kPGEt6YRV4aO+wn/pH4OKywY3dA6l7TiN9Uz/jMrWSrSgOlTUE1t51Jh5Jg/M5j9E+GHopXX5IJf4GXtSCSmYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Is+GHQDv+QhaaLW0HaFvTCx4kBiEf33Lc8haT3XMWI=;
 b=S+9+vLLFH3VEY7kAHiVCsifRf5jgg5azf8s3O6e4GjjHcjXrn2Tw2Yhppv7V4u7gSDflzNlEjFhq1wnjRgH7EyLOH6U6r7piSlOu/pB/g4FwK7e2XkdBMWTZWzQnH4oPBH8M9npSxSGK0D8+IdmtuAcv2cOgeePGCcrNHhEMbNltwgRyLew4gCta0k58A0M18FzRVt6Mpwx8bE2f2vMMcLx4NC+Exj6n0YqSRFe21SEaIb/ep1NIlibp9q8qBvh74O3Qo0Zg0yskvvzrVRSw3TVQHreVXOd0pOEmIijNqFq0ye3UtcbVdmJiKuYTlmVV/0rUU0hAsTX2/1edxYTTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:36 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:35 +0000
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
Subject: [PATCH 4/6] sched_ext: idle: introduce SCX_PICK_IDLE_IN_NODE
Date: Fri,  7 Feb 2025 21:40:51 +0100
Message-ID: <20250207211104.30009-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207211104.30009-1-arighi@nvidia.com>
References: <20250207211104.30009-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eed70eb-6b5d-44bc-7fcb-08dd47bc0157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y2GtVA0YKoRjdufJbit+hsnzCO3F/EpKuJfCk66Dxu84/elAmKHa+2Y4Q7MB?=
 =?us-ascii?Q?H+3Ytjx6YYmppBumYxzWWUp/bkWxMpvsM/Ggj732TSyH307dRPyiBq/jqDHH?=
 =?us-ascii?Q?TSjFVLqMgsNmOacrdECn2Zr8/iq13h6BwGExJv3eudfkAEytW+3kADupI7Sc?=
 =?us-ascii?Q?59snSV97sxCqRMVkJ1ohd7ilgNBdPqwRlYi0/zw8YtF2GpE7S8UkAmAic3b1?=
 =?us-ascii?Q?IwUSEbS22b9FPDqQjPWWHY3fxjo5fVzSx3UL+BLBbw+pQafdsvhzlKPQUlvG?=
 =?us-ascii?Q?af1EcheFMzQvXwUY7kac1b8JwrDdjURk+h0PKtvI5dvpOcMMCHBALQ+OzStM?=
 =?us-ascii?Q?3ExEkP4HkPTtt0FhmheNdbIv4lgu47ZVJHNt+ie9IybKU+VcF2A91oeAjH6M?=
 =?us-ascii?Q?o1yA43ChTR6x1gJlZPOkqL1cX/t5YKCwaoJ7bxW+vILe+Ts9C6arEaOv6R7D?=
 =?us-ascii?Q?jgTQjWm2Da3nYnHxKUYZjx/hLqDpdmKR8Qd9gRuUn4/Qo3w7ApVnxBz/OAnz?=
 =?us-ascii?Q?Whi80gBMIEcopI8H5U54QrhcI/2JewZklxJbAgSopPJ4Pd/d7s511dn90shs?=
 =?us-ascii?Q?hmhx51ryT04TzW8Eq36hSJBtY4pBgmDn4Icwk7bHICyyrZdqvIAINKqDFCKe?=
 =?us-ascii?Q?s9DRkdywPYMHvpvFZtd4SZ32BKJ636MSGby2Rx/QP2IXtz8690zyXuM+5Cyp?=
 =?us-ascii?Q?mlDKKyjZXioDYaJDX8YBsdvGrXxZcCtcVOJik5LK2r4/tv4L8cwjr7U215nA?=
 =?us-ascii?Q?kmAig1YGbhL1MRQzCIPHy5kkRosTZyBPARhIw3dsbi433vI6TlLvL8leMgwo?=
 =?us-ascii?Q?RpybT3MTV/1xwmRG5igZxQa+BzJ2gnKkZXYydMV/i9Qu5UI4eQhOe9qBIWc1?=
 =?us-ascii?Q?9vmY/bSSd7+PnD+NW9R9F5HffNlCXkxQF4hwAB+dC7hA8VtACzMonBhac47M?=
 =?us-ascii?Q?Ac6n9VROXNASy27mDjvFtSDzQ/Jqi5rpXxJgX5eMVtBSfvvjPdGZHY//QtCg?=
 =?us-ascii?Q?H8Q40XEiJh8w9LfAnKj49nEVuE3ew1dH5lDZcmaeXQYfHICpx+wxhkR2lXRs?=
 =?us-ascii?Q?hDFYhckJHm5puNPc5/34PmvQm6LUXrFnwqXBzUa1PZKKLucs+bsPDiIqiri8?=
 =?us-ascii?Q?nNovSxmk5X1oGV44C9Y1t+zNfT2mqXTp+XZvmzXLrssfbnWKka63tBZ/cZMc?=
 =?us-ascii?Q?PLaQv81PT6jeWXpmMOb/J5fWZf3+MklV3FdIlL7C0EKjjeHvYWUtFqQD9CYT?=
 =?us-ascii?Q?ZtSDzVoTf0y46egUpu9ibiMvYhf8CQn4TC1/DW+Uv6qlrBnaRppq15jcBhPz?=
 =?us-ascii?Q?uGPDTXjzgz9cgwc344ZLB5FwHqHPEgghON/x/kjcgd4PiszLKk/vU142YKRa?=
 =?us-ascii?Q?GbnffU9/ayXEeuWXHPh73CXv7+Ro?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTtYAUKF7ob1R3wPKpbKLJag/3DzyHNmq4/e1HSbeOx5bW8I1vQt2+k31oYy?=
 =?us-ascii?Q?2XSbfonVDuStW+q9TE6MwbJ5CHZm5jfqNfTwkEsuu6HQ5ebqO3LJza1A53br?=
 =?us-ascii?Q?+kWLAV4c+5qpome5H8Bt0hKFLZmdJ0Nx945YQqfSDgvYo07NCMmVyGPGp1rL?=
 =?us-ascii?Q?youLrekws1+njFqNW+CiPfbbSOvnRALQUvxQ1rb7Hhkj2/enre2dppxa60H/?=
 =?us-ascii?Q?kmo/FVp0kQCan8Njbs3brssmJVlLYtR8kk8xoeXiVqqSgPRS759ZQUKoUsp8?=
 =?us-ascii?Q?nAFrgG2eDAlMXCQfuMV9yyy3C1VQ+tZ6zovGLS5rs7CX8wTC1DOBYoFask4f?=
 =?us-ascii?Q?+VnyFhMgl+E6h/WutTo9d492FRU9cWxjPo7/3S5rAIQtPeXzBJtvH+yWYuZt?=
 =?us-ascii?Q?2alJClyc4qieVdryfiFIPq+vT2Z8rMpJ5FY99CQB46VetVQpLfb5QDFvYEtm?=
 =?us-ascii?Q?lRYUj4m8k2kGZ9HmQ7KCvWK+G0He+wNSRa0Chb+6V8JvSunE7LB+qI8BtB80?=
 =?us-ascii?Q?rdTRZr2D/wBNdwBixvspFBNL5xEDHRb8iG1fwN8gQYXJmkZdU/1066lpXRxE?=
 =?us-ascii?Q?H6Ozvh0D6T2xK23Jn91/YFfyMKe9/mCEPvM4ED/M79Tty2jrqvuN5q5gZem1?=
 =?us-ascii?Q?g7azXL2iL/qVaPSzdH/OgI3iRiF6HPS/90ZChInlCxoLhWK/Qfpij9BPMpFi?=
 =?us-ascii?Q?tc/wXlRLWYKFpWJyi/KRjgUyFMnP7nneRE7sk6lNccApNrvpsWJpWXUfTgj5?=
 =?us-ascii?Q?ZT41Ui7s5mtzzGhFiC8Wmff5t6jVQmkE7R3My/zn5rOAKVqh7BA5tzI+KoKk?=
 =?us-ascii?Q?joI7Uf4b3Y3vVmrGiouKpqTUCGS8pxoFB52vXP47urJcIPTgDLZ95T5NisMz?=
 =?us-ascii?Q?0C8/UZfvmccx+KHE4bWbzfFG15Ozr3rdYI34HHAt5uhOY6AodhqvpppDwNtP?=
 =?us-ascii?Q?EwRauka4khTu4evc1uedvbmHG5Q6QcByoWLen3JzuUAM8slYUroMJLZgHWT4?=
 =?us-ascii?Q?/wdIPWkG0kOs3ZjgBfKz+olD/wYHMIhaWz54bGpE28Fv75/GeSWq7c6Fe+GU?=
 =?us-ascii?Q?vRNh82iqHeuSY+gswgy7kVCh+V0kL55tvqLRWJXqd8CQzrDFmoXYLYoUkwa7?=
 =?us-ascii?Q?jpV/qIF/KXGcc2jk6A7+dYuqb5GL+cCDr0/S4yb59epcETXpOVn+87xfQpBT?=
 =?us-ascii?Q?p7gPT9/z5mowxmeoBEbuX+XofK/cR7aNO24PAK72juodkKfQg8cF1gIazm4J?=
 =?us-ascii?Q?bHnG7vmzUy61JPgN+tLF2kCvOCPiyB1gvzuuq7JCGhR8xM4bfnuIhwJi31Is?=
 =?us-ascii?Q?UnKL2djqnvsqKfcGIaffXCnQmvVm78ESv8zMKwCuYNVn3mlfEP5e7y8UzS1Q?=
 =?us-ascii?Q?tjtPWcNwqkuVr07g3U6HiBFsHmD/rx69YOMHy/s77qC0h8QcS6tqFLTMd0vL?=
 =?us-ascii?Q?jSrWqm3LOseoy0WNk7kR0ZfbFZHrEB9R3Jh/cK3YbMD93ExXd5a8RvpkOuBq?=
 =?us-ascii?Q?zxY16NHs+XypU13F/VGS/hy4QHzfo4N5Nmee5SfiEYZxtHgsnt/0WxsUHGdr?=
 =?us-ascii?Q?SrsbS2LqcNzvFEFRoecXlCl1cZo0Md9uPXEcm8O1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eed70eb-6b5d-44bc-7fcb-08dd47bc0157
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:35.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2xjIb+H3Tlkbm+gdaY5s/150G1iYvDvm6Bl8bZ7x2XzNeowvDbs5HxAuIZ+sadUsP1Ye9ql61pwayaFe0heww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

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



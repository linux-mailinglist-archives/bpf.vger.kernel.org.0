Return-Path: <bpf+bounces-67268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76912B41A9E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADD9683FD8
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02992F39D3;
	Wed,  3 Sep 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QDeysBdG"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2D2F39D6;
	Wed,  3 Sep 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893063; cv=fail; b=c60yybUdp67ACHLs2ZSF59Mq2G6S83rbAuurCKBxeA0GsmNR9AzVuzPscZtV3aImFEivuGjQ+j9Oe3JoAjnS1XX9VCmMaZOSM/e8DIx5dsFu59oZ5I8W/dXrhNuGuonF0r1x0rH3YEyJRQLnP2zz5wDkK27q+IMZDOj9ySYBlhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893063; c=relaxed/simple;
	bh=vU02E43VmXOyr7a4/mY6x/FXjNnrjnKhsWEV2MvTQgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8zu0hTWvur9pXF4dep8GektWkEDSId47pkuHvXmF2ewE1aAoPHFz0hbPnI0dK+H+685UaS02zd5EGL0mbJuUKmLk34pY9LaUTVUjDhCJyzPYRXbyCIX/FIJdKX//1AqGZGrVnrTLNiY7fCABlm+lNLxN0xl0FN0lllrmQ+H0iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QDeysBdG; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW/BC3A6Q/mjxvvFQaqEe/6We5H/RmfXgM6ewx3NDKUrYapiKmDL1CVcZGl25yhkFFagNQFsmIGXo1r9cePcUWNtWN1XBToFj6ONH6u+8KSKNJqF4TfTMVIJZVxLjctblzSuPhmZz3W24zuWYT2vM8Lg0hA637bjC8UbwpQNAHG4b2lyKCftxKRemgaVspXOb1WNgMcVSdUyrPur9XqKOM7mrkJkOoXJLZCbJDfsZxfLFcm3nd5xa6Htnd+9xC3PBFAwaLcAc0WKAeBTp+5UDkJzO2bsOCZPnl/E6LLpPXeB2F0kRm/gVnpx6CItfZueCTldJ/WrcxqgW1rVCheyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7/RgfLA12LZ20bF89WMj5SWyV6IhVphkrsIumrF5wk=;
 b=QD5GorRM6wGEc+fexM5DHnSQuYDWdonj37nVCuyy5fUEra4qn8nOZ6zBrm1ZeEU27RtPBVznFgToITrY3iNwc/obYGy3aoikVjmCiD1+IzRt8z4XZEfKpO6zG8WWePPZnpuTXeTbDpjOYohZTCLmZzq3rjIQWrFs4z4pcO+0KMWj497Wlc+LadU3EIq26PTsU1Y+97JQ7rNM9C8Mkuwv8UQt5lRJM7VfLpaJyrPbVWqFyS4/DZgzOvg3JiAQsj0IbR9GaKhgxRXjwvNIKtNGymRo7LXrBOSizoKWqonk4qNsvT1+iG7MlELi7yB9SC4WAu5h+rPBewF2vgo6HVeGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7/RgfLA12LZ20bF89WMj5SWyV6IhVphkrsIumrF5wk=;
 b=QDeysBdGNMj6MXXemTlbaRANAE+ltKImkcjWvS5aRxEiiAHV8YfERRQgnWnx72taZeKr3XhP7r9ICWOLGRJ8ZBEB1Kdu9lGaMqr0Vz11RADzrPaioULPhz5SSedkNu+uTC96hz7vuF2TqNWFGJl1797s7iDOVG58e7A8vYSaOusRbqqTVl9xNZbNRK68q70BT3gsDIwLvp2fqX8c376zkgrnEMzV8NjzjhNMmsCkbSOyYyz96f1UOhEW4XaXz5N9wDLq285oC8cRxu3NlPh7sFyafEsI2YkZyBilvInoHfCBZihE3aAsVNASGywrsn8+LmgwsKAH524Qh+Aeco+v4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:59 +0000
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
Subject: [PATCH 11/16] sched/deadline: Allow to initialize DL server when needed
Date: Wed,  3 Sep 2025 11:33:37 +0200
Message-ID: <20250903095008.162049-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: dedc2c35-1844-4713-711f-08ddeacf6281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbBJPcEt1USSDQg1YbhYjHZ86Ej4pzVwRj6OjtipYBLGIkujtpO2whHp7sEZ?=
 =?us-ascii?Q?NZkEWVFGvTFTOZcx+ocHaKwK3bs+W/Oak6ALfUhoDWKL2gT/NrsYQZKai1lY?=
 =?us-ascii?Q?lHinnwjuBC6t1dkny2P4FjnUi4rU+qxXKXm6JJBhWO4x4rhcTBepRvWtMQ8R?=
 =?us-ascii?Q?IGj/4eOsNcmliOtbIJI1wqvhzl4iYNnlxEFYFsQa2Iixt9GyTjSzTyb6I+s/?=
 =?us-ascii?Q?7gzub/W+9IF1RaSa/sjN0T35vRt59IxjiS1nAQ8tl+/VwkAdN2mDYKFwOoaI?=
 =?us-ascii?Q?fLP/DgaZ/aZ3mRjorhMWA+0sMtPUvJAckbmFIsDxTNi2VLX3Q/s0ydDHxEFd?=
 =?us-ascii?Q?0RUi4frxLzfGofRdYWwJtOTI8hrcXuaUYEb6hZWyDCJDaZpvLT+ovVdDfcxg?=
 =?us-ascii?Q?s1kbV5GRTcO2oA/uL/epqHy7EY+JdcFY/5G+zhGnhwertgHovtJhQ1ujXIFE?=
 =?us-ascii?Q?LZuYk9Xvm5qc9fq5nEHjX9cP7/EKzSjibEZWbLSL3gI/Fcw3dnDaF7BekwFU?=
 =?us-ascii?Q?p0j84s7ltDcGwWbds334hFEuwNK6zX+ipLPaKott1lZ7y4mevcM8tBG4Pppv?=
 =?us-ascii?Q?ovCsM7IrNWn+UvitnggttLEo8IYcmq4xNnmI6Bh7gC53JITov0gEv9wvwuDn?=
 =?us-ascii?Q?hEMdemkzXz5bcrU+++45GFynOpVqWszpkFctoaunEf3n3OlThXtzaWM1HRV/?=
 =?us-ascii?Q?BMNup+w7TQ3O5FrRKhPLg7+rfnvLoGZ+aesxrY2HWouieGP5f5MYTuxT4G90?=
 =?us-ascii?Q?bO1Z1sxpw3vMIDEeUFQ6FG1u+7hzYonXcxzTrUpJ3gRzyOjuhLMZMSn/qcXU?=
 =?us-ascii?Q?UgJff85q5Oo4d7EEAvVeJQv9QQnQAT154JD5QSdVQ0JdGZAfO9ODiBIo/wy3?=
 =?us-ascii?Q?6czP/aMr16ApHQKq9shckaBXxPR8o7FU7d0K5wnWsYbHkclAtbdqXbJWANuI?=
 =?us-ascii?Q?p0uHy1nnreHktL34GkXRVB16PwZ2Tmf8+E7V2qgNwZhLpDWK07f4oN3LyOZo?=
 =?us-ascii?Q?5G9TDCcoOzgw6nrRATcSBSw7U5SO0GQMD3i4hfCqjWY18EZ2G/BRtnEOuC3v?=
 =?us-ascii?Q?BUJtkomhIJjWuqUjf/N2pvCyeEh/Gg3GOlmCQVp6l8aYacb5TA+ojDeJdbMj?=
 =?us-ascii?Q?88GGUl8Ty5tZeKOMQBpUjxiDQg2YBi41cvGI5JLpO1T56S9VaUnoSQJ4rdrb?=
 =?us-ascii?Q?I+lJ9HxtHjgF61hKrRi1Wb5w3Oliy8BqSJf9asJ0N+kLnCzdfQPyNsrZFSAR?=
 =?us-ascii?Q?CLS8DYMWDfo0oYP5Ko+pbzu99azZMHY3mhgB+WX1QDSMuCq7Zfrjgb4zKs3/?=
 =?us-ascii?Q?iw7A7C7db6siS7IJR3K7i8CJuMGRyfzjZEb4KzzMeZTByeLJeWCxM6ISQgBx?=
 =?us-ascii?Q?gF5R8nWlcyN+pvbKOi5m+SUL36aOfhkTBxdMJ+bpRHaGVklgpbWcMByS16f3?=
 =?us-ascii?Q?tv8Sb1D/wphJQtkCEEPV7DP5QTUPInSS+5Wy9yjJT4VPb65I8U6Q9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GtBUpDYtC8lEdqSkrfdf0KzNB/IPWYXZrgG+Z5MK+uXlWLCvlVypFHUWkXVS?=
 =?us-ascii?Q?JVbcxbyqx0fI51m20kj+mQ5rtsgOFRz8gv0ndApWbZ0t34B3mYQPJA8HnD79?=
 =?us-ascii?Q?UqZ7pfz6Si7wzUPVLHZNc0rbup7SdcBCvKd9d7cglXLUc+0VMD1QYFbRruF+?=
 =?us-ascii?Q?Y4cvMTl9JorQoFH6afLWSUhG86QGM61pkRoqBWSrOXjbRVyhsjgBzQwwg2k1?=
 =?us-ascii?Q?zJ30KFR4p/bw0x0gCpuWRR4ypCK3x7FCsm2JaS9VlaV9DcfDiZdY5FkvnXBH?=
 =?us-ascii?Q?rc5OulS+vqrRuTazUKiZVP0F/yN8ojE4+yhD/lm+mfu4sC2pNRUoyOqDO/y4?=
 =?us-ascii?Q?PhuYKUJI6wU5Bk/KYY3FZ0glWo0SlqFSjIRBakl0eBl0FOBIUr8jHg3FP7qS?=
 =?us-ascii?Q?u3PruoHy/pCfUCGzmOW8f4bYB3q8Lv5c1iByL91oUVrf8vsxab379crI/gkt?=
 =?us-ascii?Q?P9667Ok7dMnIYa9088jlbdpeI2KChD84lytN6skDSvzelPGjM8W3LfDHABzf?=
 =?us-ascii?Q?UAWxHeQpDwknsKamJIpMNs6cBWBYuuWu17EGg4yi6/wTE9/7k6r8I1q3BGqX?=
 =?us-ascii?Q?xfQZ32DL4CL1nAL6EcMBrCU7APQiboThTmyYjvSxcWoV/OORmUwO18WvcIhX?=
 =?us-ascii?Q?HLelzKysPd+fLbMwRqeVYjCE+qUw65ppxVIkTDBy37jEmivZYFqO/e73qTSC?=
 =?us-ascii?Q?p0+fJqsVKuIxrYzBN4KHbCWhZEsNtlTNlZgkgu55yhkFd1WS9GLGdFTMT2Zl?=
 =?us-ascii?Q?him4igFoHje46ksZLzEFB/n7eqbY/qQgeN68ptEDHri3CUuCDDsBhbm4WtFM?=
 =?us-ascii?Q?4tA1gtL3HdiDYGNClADUmBTCXijTq9xOKaFr/bSSg77B/Na3e8o2M7UWaJ0V?=
 =?us-ascii?Q?nZMSaWVRli1rIojPove2hLkh4hl468u1Nk4cmSmAZ+W1JfraeInTElz1afug?=
 =?us-ascii?Q?X9s0PgEn7HiSE1MepaneIWOBXMVs8/dx7uDRlIcu/0bn+AzIOesfJmGu8iuQ?=
 =?us-ascii?Q?nNwx+x9YU0oVt4HsmlirJHDo4IhU2XKdURQgPok1dW6LodaLSkEQouVg36F/?=
 =?us-ascii?Q?rxwzgww9K8XLITiU+MIROL6zXGQ2It16ryjWw9SyyAle5513LusfLT/6Y2zj?=
 =?us-ascii?Q?gQGh15yRwTvmTOYtnpHx4u56I6u82cSeBBc1p2XYd0moNMN7tkcZR4GisCoy?=
 =?us-ascii?Q?tJ52AZ6YzuAXLfwkww09eQ8iNFbcMsc3L5Cg2MaPG1DnjSUbM/zu4YH2hMlP?=
 =?us-ascii?Q?hgh+LwF4JwEay/4k5/bU1pselR9TziuJkicRc7I4NELpfETynk9C9SPEkc2M?=
 =?us-ascii?Q?4MCRsDj3447OfxTnb+1Ro3gMfT0B3ThA4pUOTpZC37vQK+BQq+L5/rhE+Mxa?=
 =?us-ascii?Q?dpP/6eHVMnPKfPXsfxUrUl43faUT2AFaoum2bz+4eENq297doslE4WBO4U66?=
 =?us-ascii?Q?nsIA7YlypiYzkInPnJdcHJJVkl2isJBuE8rmBb1rXzHC73xtk6iROdpLrq2w?=
 =?us-ascii?Q?UD7eUlb8DAYe+FhTZscRVfmDqObhbfwschz7MsMuuUy5vIz8x89i/X8UesHx?=
 =?us-ascii?Q?KVu9xkWazX6S+cUwPS/EDtqO4oYxCYwraZevksjc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc2c35-1844-4713-711f-08ddeacf6281
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:59.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0Neym/q5VsIAR83MNUk4gU0WroNdB0VxMJyLQWw+IkY4ghTqAWCeFTBD6MN4jgc5xoFdCrFFeoRcCRWsY4SKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

When switching between fair and sched_ext, we need to initialize the
bandwidth contribution of the DL server independently for each class.

Add support for on-demand initialization to handle such transitions.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 36 +++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 165b12553e10d..b744187ec6372 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1583,6 +1583,32 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 	}
 }
 
+/**
+ * dl_server_init_params - Initialize bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function initializes the bandwidth reservation for a DL server
+ * entity, its bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_init_params(struct sched_dl_entity *dl_se)
+{
+	u64 runtime =  50 * NSEC_PER_MSEC;
+	u64 period = 1000 * NSEC_PER_MSEC;
+	int err;
+
+	err = dl_server_apply_params(dl_se, runtime, period, 1);
+	if (err)
+		return err;
+
+	dl_se->dl_server = 1;
+	dl_se->dl_defer = 1;
+	setup_new_dl_entity(dl_se);
+
+	return err;
+}
+
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
@@ -1638,8 +1664,7 @@ void sched_init_dl_servers(void)
 	struct sched_dl_entity *dl_se;
 
 	for_each_online_cpu(cpu) {
-		u64 runtime =  50 * NSEC_PER_MSEC;
-		u64 period = 1000 * NSEC_PER_MSEC;
+		int err;
 
 		rq = cpu_rq(cpu);
 
@@ -1649,11 +1674,8 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		err = dl_server_init_params(dl_se);
+		WARN_ON_ONCE(err);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 928874ab9b2db..1fbf4ffbcb208 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,7 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_init_params(struct sched_dl_entity *dl_se);
 extern int dl_server_remove_params(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
-- 
2.51.0



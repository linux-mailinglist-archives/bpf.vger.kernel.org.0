Return-Path: <bpf+bounces-51588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD8A3664A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3C71895B28
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF391C84C8;
	Fri, 14 Feb 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3do4LjP"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5F1C84AC;
	Fri, 14 Feb 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562114; cv=fail; b=h+eTrhYukyQBRTdrldkVs/FY/4mpOxvQGGw3sXA26h5cQb+nDgz2HMj853MN6zWTEXX0bvFc79TDYVQG8thgBuRKerlGPznigBM10ujuNlDT4D9AJE3mowb5TwntgAW2W5qL1h2EWYOOReuw/BAENJ/iTPY/gwPu6xamrAcdYfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562114; c=relaxed/simple;
	bh=pQnE39Visvyu7+I/GD8/epZ6FIoOTGs0HAakpOTc+Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4pU3zKNJzECnmPJdSJ42mTqFDtv/0Les4jDbTZWtU2nVJWPhX5yAInctmdWbF9/H6lQfMIZsDg5Cgd3GXAEqZsLI53s6IM+MSUpJ049+Pdvlcq/iCq7Oe3NGWlnWtyLPvMgz3Va8GNfTP6PJGg0ZtZIE+PCsR673M4dSW0suJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3do4LjP; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSgQ+QuXvOZQZTlnWASDgLmWA0KN6uKphklPYb1nZh7NRVtuTM1q9kv/RlHrHKNkVtYzrXjuSxFVZya/PFCz8BnxC3DbaXuLbT+FvkJV0ofp/zBdjHnFdasdTzrtvXkrcDcHiVtapYHgphIdcpKrSrD1Jg7w7X5QoBdzKGONZE1S2N3LGhbyRbz+chUYsIU4uvMON3W2IPI+psTMmdW3HZzwd0r5JpN0LH6+QjdzCRuN+skCIB3nmHlgQobK/lqS/9+s6tFaxVVQir8QxqDo7EptW7O6OHpDAOGi3EAVzCzUCrgtxYIujED10YXMCP0V+hUXWpxvnXY5fq/Q/Ree/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D88WsA80FCFADNIXKmRk2q4zXQNOlHuP7WNgsVUjAc=;
 b=QtpOnxvmN6ik0daTZfaca4CvVmmSail/u3iQV4QOIGiUc56KZFAHp/fuhwC78FpneX7iqokt6IOX7C2l1jybs+a4Fu+migYdYf6p/yiOQwBLZLYcJG3dFIrs3npaNSoBHES5NsGDwhT9jC6U6Pz2RmqlUssYKcdc4rTsLNLDPFwVeT0KkVB7L1nuzrdktp5QkV4u04LFaF9hVevOICdua6yRQChvNh7ergc38R7o2cgPPJcKtA7FCo07wbpaWZpfCTJWTOl010ckvqlNd4vN5TD4IP4GO2ar8FdbpeDpMaZjdRdZmWuJgi4V2LVItCf4V0EJLqQWELOEcO36shxHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D88WsA80FCFADNIXKmRk2q4zXQNOlHuP7WNgsVUjAc=;
 b=r3do4LjPC3sglzvozDhgw/o5x/o/h80vPCZh7av8sKj4wUyysCdHRSzHNMrW7lj8UDzzworhynyjTod6p0RBPl//aUkgjm6AX4vR2kQ9Mj+PcaaOyckK6E2T+Oj+YOn6SD5szPdwFljaMPC6AwqOvkXo330KNix6W06HSMOQTwbqcXRgoPu1eSOVrvkbtyL4crLj/zcQrk//0WfdiWToJwclOMP51/XDoFUwcuhVt6QB6sQ0EShWJ9UbttEQYu6uEgj4gZvj2FiUj9P85Gs90zceQhgTOOZi3s1Pv7qAUYOHha+jwFNOAWC1I2z1gOSUQnou5/u+Z9VmNyUgGh41tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:41:50 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:41:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] nodemask: add nodes_copy()
Date: Fri, 14 Feb 2025 20:40:00 +0100
Message-ID: <20250214194134.658939-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: daaea6f5-7129-4e1c-f8e8-08dd4d2fa03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JJ/9KhFibKPf1VwQ3H3eUVMsO+4J41IrkwyMI7uxg/P7Tf4AZCp754WsCwEN?=
 =?us-ascii?Q?ylWEyscTqmAjx2ACCK4R8yg3ikxh4QZBIOInziOblLOyrxZQ5hwYxn/E9QmS?=
 =?us-ascii?Q?Wh4qWc/NbycfqijSwiZ4S8iRLxkVL/Y09E6lP5cF6Ys0aPIQBZf7Byi+vikO?=
 =?us-ascii?Q?KqPehIgdtdkLkQMknnU89Wc8lZgDRhApkz/1AAD/IGzOxOIUV7fozgmkX453?=
 =?us-ascii?Q?tWJPWKUtBvTrCh/9/vUSsuKPL7b+hRqJGFErDv3ZToxnEyPWd3vwUMF+jme0?=
 =?us-ascii?Q?KltWPWAYqJDeEEP8uh9asFD5gIQ+M+1feJCx3TfFjWStaWLC5sRsv30IU2Fs?=
 =?us-ascii?Q?/OcXW79IIkw0wXiGY/Qk03/xr9JjOf2yaNrZEtWk62J657EU3WVIck5ht3QF?=
 =?us-ascii?Q?w/SARibm40EXFGBw5quY4U16ch84XcwjY7oBcd88Y22HYEjfPry4pnHRMda6?=
 =?us-ascii?Q?zvtSRkYKtxJRWQ+dzpFmB5aj1oMBQnMMyjfRZ/o1WBzcdd4V8DiBrugkmz+c?=
 =?us-ascii?Q?EmdCwFW+Eb7wQPZuNacwrPt1CTIg1ODnwm2Cy+j6DYSfCVPN0hYDoWwTtTYV?=
 =?us-ascii?Q?40F4FUasRPbmUmwyaYeaUKNt4sySQbOaLTwIrzQ6uwEMUTRqI8597leuVKme?=
 =?us-ascii?Q?xvSuePjkOVp681s8UOVhLEELEYruMFC4mfDIWpRO0WWGNswy94C6XsfAbedX?=
 =?us-ascii?Q?RtrhZyBFBvXEGhCokk6KmniBsPnqeLNTwx4LqYX+t65DJ7aglUXJGcGbx3OX?=
 =?us-ascii?Q?qv8qigXqxu4an2+eqm1+i7/lm3OlqXvH93zQQ/Dxrp/RAfiAZ9jYVd/wx4EA?=
 =?us-ascii?Q?9zwm8h52CpKfGftKhi+yPz8+TV9jvSeEZX1NKAKp9L3aN2SCCvaIEyvPsBTp?=
 =?us-ascii?Q?k3yDGjq8LiQhIDh2r3kDZrlnytXeLycQP9nS8kYWmr6SohkIjhAMVgikHLhL?=
 =?us-ascii?Q?Dv6Rp3chIz9PN90YV0LoxJhSyHiMw4NRTY0CD70JY4hD8C8KstxTxOISqWPu?=
 =?us-ascii?Q?3RY9E3Gjdx+9WfuZDlr/wNuUsInbe0UhiTbIW6ObWYswxx+r5UmJcKMJ5mMp?=
 =?us-ascii?Q?BSZg1Ov6Pq4GgOD4zYJTD3yntzC6EPYiE9jj52rwAysPfFumj8OaY+GC0Vuo?=
 =?us-ascii?Q?OlWg0fnWfoW2fP2201iQNSbs4YntlgaeuVxTGKzeiU98PgzmEfZGaGX1NIIZ?=
 =?us-ascii?Q?taoUgHOAZ34UWQ2+qvrey4p4/7UsUKYQjrRVUIKX48OH6HL/5Q2uTAkn+GzM?=
 =?us-ascii?Q?hBeKA8Dlagi0wapDAweDbCWRx/L/1gEP5Yw59C8U7hUFYEC+PHQOgKz6RHv+?=
 =?us-ascii?Q?vEUS1ejExE5xdTIhVyHAjLdhuYO5aqiH4bTwKbG5lCXgUq0YhQiXloBKO9Ar?=
 =?us-ascii?Q?IOFCewV/UDz8+khabTLjzCLzb+yQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pEPGzztu0ZTkBLVkLEGIEa+5Tj9oVUwR/uHyAy/iszJrAJmZg+Txn1aoQgb4?=
 =?us-ascii?Q?4KxI3NUJQzNQLbZ6lisUQ+ERH34hTRSjGx8dyPrZpEyOtYSC5OjrSbbuGiKC?=
 =?us-ascii?Q?XGn7KyWdgb4Pkbupqo8KAf1fM5CoXEad/VI5OBn7kthiF9cphjvpmuPvDOaG?=
 =?us-ascii?Q?t4sX77HYgR7fcxcGx/iTUxZpJwZqnUnqZuE214w9dSeXd+MQ9AkON6QGKz8f?=
 =?us-ascii?Q?dKs9dtpLqPeBFVleEMjJ/uTjA4C4RTReOHEGnjO0yChcw4jxPO3zGjTEpSkj?=
 =?us-ascii?Q?xfLo/vDR237e8u2YKo5Ot9bJVl+v6Dmp9a9YRbvWtpbasTIZX2NKCDgTP1HJ?=
 =?us-ascii?Q?jFxNHdCqzPTMMOI97wkmpZKtyIhojI+k3iyN3LbNVfPVTZxJihSVdWv48YNc?=
 =?us-ascii?Q?j4dwUBNx/bVQQREoe7OBYPuRvXD/zhMcoQxx7swQj4BznP58zlCj+mjcLpGC?=
 =?us-ascii?Q?GPl67/RIzvO1yBalgzcpziKtOLVkKEUkBP63z70H0mbuzDqUEleEIegeAHiC?=
 =?us-ascii?Q?vg4F8cGonpUrxKcDVLwbjSAs9SEylSy0dUtl7n40IYOCmYu3Ta4vZ7VsLtTh?=
 =?us-ascii?Q?v07cCVpPBJFEbg5RgQXM6vNRHZVQ9ba/F6y5BcqkKGNoury1lJjjLStkNXy3?=
 =?us-ascii?Q?McahXKcIOUKF2lQqVYwz8cPe8cV8wkW5i4vDS/Uk7yfDIqMndG1CSdOAsU0E?=
 =?us-ascii?Q?Gu4Wn1x7OuQzQuxIH7eEQ3QiMGHV6/XiYCgXoNtkT6OlXXs4yyKSD6Hirzqs?=
 =?us-ascii?Q?kWqscpczV1LGtsRuMXMaySAbKv3RuyKoQ1qcL4dUThKeTmIBNlRfrKUUbuaN?=
 =?us-ascii?Q?cZ/YGQZOQcohHxi+AHto0emyNh6faw7OAFwWMrcNHISho8jYpPUMIu7kEU8u?=
 =?us-ascii?Q?ITJhxN1UZnNKQIKg9WaKVhOQizgkuRf0vp2s72lMxLvJH7o9NPY73phKMLXA?=
 =?us-ascii?Q?SeOe2lSBHRot8qpo7g+FxyuczdcaW8M7+yF2eEOsOIAPHxMNHQmy5KTcAJcd?=
 =?us-ascii?Q?2cbg/0Ae6a8TGSXyDihYvKDQt2X5L/4UEvyv9ZXNeOJq5qp2IuB7gA7QbK1v?=
 =?us-ascii?Q?xiDz4/0VMn7wflQCXNl618CdpFKKfSIkzYa+6abCij36sQv5uqkaYSRSd+3r?=
 =?us-ascii?Q?c6s8yyqSNinxMJGrJ4TmVZtKYokUzF1mkCPjm4ALBxc3P7woqkOE6Rnf9sy7?=
 =?us-ascii?Q?ZnlPXLSd76A5G+oLy7r7zrBabnRY270meAbYRiyc8iK+MMAh5cavogDYYYMn?=
 =?us-ascii?Q?uEoyLtk9gozyITMzG0s3RQ697KI4N63pGIGFrVeQpIRWJVV8sZqaDzByZq63?=
 =?us-ascii?Q?B59jiWOHmqV6OblOJZELaNzauKQRQzTXS84Ejrc16Reqpaq486e2/SWuZKws?=
 =?us-ascii?Q?G6NKWYOXcUt8RDoB7ySL84CQyBQdDpg4CrEaQyJISWLCx0XKGSho/GjtGR98?=
 =?us-ascii?Q?ct/8ORGWG90L2RUtKRslgBKQ6Jkrom8ph0srpMz8dKapPm01In/uQvNtn7CG?=
 =?us-ascii?Q?JRuDOkASTHwgQcaoGvywyCQ2Z522iu0DJlYw+Ocb9VF6ZgOJ1S8YcRMNvVqI?=
 =?us-ascii?Q?I2Exl+lZVlOpd0zx+1usuyYPjfpr9trsLsOszQIp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daaea6f5-7129-4e1c-f8e8-08dd4d2fa03e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:41:50.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSpdfXCUQ+l0STH94iIJzRY8ICzzRFz36Rctt24jZRwXSHtS5U2ci3mcFejLFPMGjbh5BA+rpH/bhcGRIry32A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

From: Yury Norov <yury.norov@gmail.com>

Nodemasks API misses the plain nodes_copy() which is required in this
series.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/nodemask.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 9fd7a0ce9c1a7..41cf43c4e70f2 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -191,6 +191,13 @@ static __always_inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *s
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
+#define nodes_copy(dst, src) __nodes_copy(&(dst), &(src), MAX_NUMNODES)
+static __always_inline void __nodes_copy(nodemask_t *dstp,
+					const nodemask_t *srcp, unsigned int nbits)
+{
+	bitmap_copy(dstp->bits, srcp->bits, nbits);
+}
+
 #define nodes_complement(dst, src) \
 			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
 static __always_inline void __nodes_complement(nodemask_t *dstp,
-- 
2.48.1



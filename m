Return-Path: <bpf+bounces-43458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B374B9B5876
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7206E286940
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051C10A1E;
	Wed, 30 Oct 2024 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r/+xDNwz"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2011.outbound.protection.outlook.com [40.92.89.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B710940;
	Wed, 30 Oct 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247452; cv=fail; b=qyxN3YejDqYW0s6M6mrEmYkO/bOYAcgw92dpde6Kl4Kf6mOPU7JKHnUp6xIwR5MJuXvis+hlq86wdvnb+wthdZiiwRVQI7rQub3WPskambuHjOwQCMWglZE98jLupPHRVVOCNL9S54UDZg0MG3ViEOx6h0fJ7B5NM5DQVcEgUjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247452; c=relaxed/simple;
	bh=dx0ybxqUrlzgqwmQ0ztItlfqUEB1SRgoqUxNidJDbjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqI4pwVUAGj2jsYmHDyDvOEqJaOcu5EG8Q7bhANKfpCveNFCiQDn3ygNvFQOiPBRHpB39SMLRMJUecTh3foUgyXgJ2B0L/K/ecF+vSsGA1gcIqmuPj/Oq4VJER+HN+19CA25uppvO6UMiC+eFb2w8zFyRWBF3XqMWl0PK5jWbig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r/+xDNwz; arc=fail smtp.client-ip=40.92.89.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1a4JXEjpK0sEb0rxiDzpVorAx4o6fJCH21ThKtE/BVEIXcWaQKtAigeOFjIK7/SJ3utn+GBp5hdrSBvuKm/jXs3jBzRIbT6WqqEj555jQsJmva+hE5/mRIFGI9hvnFg0tbdbPxS4wM+LPICS7wQibwxZzVtkO/JX8OkyZcAjLKErvSLI9gC9FHuUYcpjCjwR0U9mz8uITuNNJo3pKpXzqWDmKKGCDPN9mdmdzIYB7tVM9k93MPSh5vw2U3u3r+/TdpivmPU5av7+8Q95oJGKTXXOQg3sUl1PiZzSOe8T98/4NLNYx23ce32+SstOn4ceTNBCgTv2gEKq09brejqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9pxNH/v7o/ozsnWjwtaN8YP8vTDpkqyZeoksCF/+G8=;
 b=lfOQVgooXnw/d8k2xM4aZv6XTNntg44DWfSndPieEARYnzF03MD6rb+i2LutNLtYj8MkGtASsT5vqTR2BjXyCudpj0cSguMZZ0wTA+/Pr15M4E9tAStZGFZLZcz8EXAvNwLfz1o/h5SE3w3kqA8do0/NJEW1A/cVu0OtfloyoITglI4IYkzLWpgkreWJc41s6NkxMIBc08a+74gxAlxbJCogdILvaDuHOIq5Jorj9okMMhEVOiVeExAbMKfvZ5GoBbv5m/ENLinTBTDdLtgRjcwZOfXFPWai+Rd84VT22/X08+pbtUoiZHmkKqTdi/BlWtMfXHcsGH/d+SOV8kIuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9pxNH/v7o/ozsnWjwtaN8YP8vTDpkqyZeoksCF/+G8=;
 b=r/+xDNwzq/sULbYYrSE1XiuUbsv1E18J8H8jjLjTFIjBa6+eeUrIuwSBHgCBqth4zy5hk3EIi6G3aT2yUC/ZcT8xg10hAGYxx497xHufI6IjWjh6rV+Jz/576KxyOLkvlJombruynE60pG4WH+72jctBsKmsKEBfTGZZkvt1sv4zJEZYGikHmpoR1NtfJ5W+gQVcpYNNEB1+3kHfB49zi6TKnlT+nEinVMLbISlSi0MSICK45ZZojo76BGbtl0rqR/+zOF/InG4WBuNDu/9BqnUZSS0VGnvpLQlizs9xXMj/72GYboFzZjp4xrw+M8WJpjL3owjXOk4204BEyV1tTQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB4PR03MB10105.eurprd03.prod.outlook.com (2603:10a6:10:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 00:17:27 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:17:27 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] bpf/crib: Add struct file related CRIB kfuncs
Date: Wed, 30 Oct 2024 00:14:56 +0000
Message-ID:
 <AM6PR03MB584858690D5A02162502A02099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241030001457.15593-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB4PR03MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d77c21-a597-420f-2df3-08dcf8783c16
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|8060799006|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otqvHMVD/i6h1VQnpGHVMqjMSgCXg56Tm8kd/oF8OugBCqbMAnw3hQ7nC0XX?=
 =?us-ascii?Q?BbFMEWjLUV6mqng6IFHpfc0sYCrOxTpZfo1/RcYr1DUacjmOAllyrEvld+W4?=
 =?us-ascii?Q?veFZRIVPw2DMZqCD0pj/HNgcs1AXOPx+mmR0StdbY9cIKQDe4sTolmptkowp?=
 =?us-ascii?Q?k5W3co8uX2UgdBzySzstIhbeRkJlSytspfzKZDp0z6zeqzf0RAwVt4e0rGp5?=
 =?us-ascii?Q?r4aYwowqZVCgdFdDnn9bDMqznznJIq4Vn+7pJtDGcT1k4KY3EBOkFfD3hMVh?=
 =?us-ascii?Q?ScqQzHOZnLFWshaYY49cEYVwg+xjAGS3EVFnyyJwFDLUu1kZ2KLQ9ietIdwI?=
 =?us-ascii?Q?BH8ssigPZOM/25ZUqS+oImcm99TV4Fwn7wyoJWyrmsHMaqtAvcpuwlHPE2zJ?=
 =?us-ascii?Q?8wN9A5k6rwDgiQFHFcJQLvyz5PkgFygoRuN0LSW051pwaRckE0z0FvsA44X0?=
 =?us-ascii?Q?B+dn3UvZ4CLpaSW+GaacFP1APNgWPctZdyFfORwPmkXjFTIcZKLQy4alqOUZ?=
 =?us-ascii?Q?tioUb/6IUtKLl4nOFAj6HNN+pOCxRV4fl01Z3MZMWWJVphN6VtAc8ELqoW99?=
 =?us-ascii?Q?zu3vXqcOOIgucIMskDzqpoVhGCLbnEr/glUzfP2O1H+KqdSIe3ljbT9TRg/x?=
 =?us-ascii?Q?27MUQ65KCO3cBRYnR2S2C5NsPlK612W4MJMS8eywVw2YF1M2ok3iKDjev7T5?=
 =?us-ascii?Q?FDx/SnvWQI+yLC1YOhLvhW4LJg5T78BWKl6daHLkau6o1K/eU3jG01rifB5p?=
 =?us-ascii?Q?7xf3pyQvRvZWhLtoVQh7ByiwJt2cTlp4hTUWr4gg/5oluHo50lXC8jjQ8hlp?=
 =?us-ascii?Q?SPaazuGB2Dre6ywmeRqp66RgsWaAWa9UQpG0L12Q7lpIyKRV7DP9ORdlZZxR?=
 =?us-ascii?Q?A/Y5mEpniVmOszuQquEUk/34RDg96vB/cptbuHvxi3m2TpjT3IfmCGs62AzX?=
 =?us-ascii?Q?fIOgHImomwiZOi5D4ZfxvCVy/tV6YyHlVrYK7HSCGaXTDKvYErnttaujDsMY?=
 =?us-ascii?Q?eNAutLZCV37izYSJiVtiH5BUgQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7aM18u363T81Ff99/gd/mWMvg204OlDre2n1Xk10gQHF97GPtpQVqcvm+Nr?=
 =?us-ascii?Q?0Ho7G0MMC+Jib19pbC9GScw1rWy8+PgpIq3jlaNqYFP8AJiCFASfMltORW2J?=
 =?us-ascii?Q?XYyJPJF6lk4clP/4jvyXp4X6Bg8/GCRbkOMEJ716xYLcGvU/3jMbmeLZ2qeY?=
 =?us-ascii?Q?OSxmZZzmh8RpWt70IDqazZ3otshcX7TEovBRMvaX7b45yqzlSrNWo6roWV0H?=
 =?us-ascii?Q?5imwUP+SgCvIiFdWfYYh3SIzwRtLvuiRL9y0/Ub3ZpltDaH38aGVIWe9cnDb?=
 =?us-ascii?Q?t0Oe5kh/iqc1ohk/FEf3pQvI5yWRkD+LhZQsnYVsuzxf/zJQEVzNp2Z5gVCU?=
 =?us-ascii?Q?6S2TrsHfycxjDBRf5cLstGBS5TltPa617jx3bYBw8cgDc+dgKHwDDiNgrjjr?=
 =?us-ascii?Q?skKK2391XcJF1OGgMNTz3aY5H9w7RMyMSEiUh/99yAuwZLipj31fN6Vhp6kP?=
 =?us-ascii?Q?rL4SRm1NVA3mKc0nzk8BXrRoJGoFdyibv2szGPsy1PWgAjZL6z4E8We/tiEW?=
 =?us-ascii?Q?jJsNr02wtxswakFBOaK6alBcr/5WpOWMUGpEHdEZiYf87FCPZjucJZaxupMA?=
 =?us-ascii?Q?4542jFvfZTril6l5Sqmi3y/wYjdi4CU7eouLCd9Heh8NE64vpc3bGplOxsA6?=
 =?us-ascii?Q?T+YWSEcXMiCjMcu3mappICe5UbgIInVaXxwsn0qJuGAYQ9h/VqWS3MbjYp0C?=
 =?us-ascii?Q?rcgpEFCKVh5nCK+u6P53tnWne8Xv5PFZ4zOuAeA2QkSb8YT3z9pKJufG0n/s?=
 =?us-ascii?Q?Pgw+b1OvH7kTmHOetvwvmiKCFUpD6nuhP1QeQZ+1CHcN06YtVJrlOW2aqcpb?=
 =?us-ascii?Q?ot5de2vqF5ziiHlqyNa+C45o//fiBBAGKNcdlPcoCfXVEnKAUEHrkpixdsq9?=
 =?us-ascii?Q?GVqs23iEy5VMHE3n1k4tmKxZXMUzkQ9ZJqd1YDEmYIMIGNRuChRrHqIDo+rE?=
 =?us-ascii?Q?JoptiDbve1G20bWSzeoBQkQd46dbSdWpZHgZHQDUfQPBxbA9NJ9irH1S/iIo?=
 =?us-ascii?Q?3M16ynC+9kJj4C5Ci5ol+eInzk98FGeCpdNJ9RU6y/ZHFBPMEv4rXPH6mK4F?=
 =?us-ascii?Q?oE3hY+3ctGyClabZ8/k2iHn40qt8166xIGwwP2EbaFP3yjqFu0v8cZ8E1hZL?=
 =?us-ascii?Q?vrioHy8lsYZ0kHG+6HJ5qPBHuNJj+1+kTrJI/3TQVeJx8xvk4zi7rCFEzRy2?=
 =?us-ascii?Q?a4l0S0BHP3E302ClBt3fxzbbOPUDcRvO313wkabqToTRKgOBKyruJ/nYCG/q?=
 =?us-ascii?Q?LoHTFOB3dYIljLeowf6m?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d77c21-a597-420f-2df3-08dcf8783c16
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:17:27.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10105

This patch adds struct file related CRIB kfuncs.

bpf_fget_task() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

bpf_get_file_ops_type() is used to determine what exactly this file
is based on the file operations, such as socket, eventfd, timerfd,
pipe, etc, in order to perform different checkpoint/restore processing
for different file types. This function currently has only one return
value, FILE_OPS_UNKNOWN, but will increase with the file types that
CRIB supports for checkpoint/restore.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/crib.c  |  4 ++++
 kernel/bpf/crib/files.c | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
index e6536ee9a845..78ddd19d5693 100644
--- a/kernel/bpf/crib/crib.c
+++ b/kernel/bpf/crib/crib.c
@@ -14,6 +14,10 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
 BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 
+BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_file_ops_type, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
index ececf150303f..8e0e29877359 100644
--- a/kernel/bpf/crib/files.c
+++ b/kernel/bpf/crib/files.c
@@ -5,6 +5,14 @@
 #include <linux/fdtable.h>
 #include <linux/net.h>
 
+/**
+ * This enum will grow with the file types that CRIB supports for
+ * checkpoint/restore.
+ */
+enum {
+	FILE_OPS_UNKNOWN = 0
+};
+
 struct bpf_iter_task_file {
 	__u64 __opaque[3];
 } __aligned(8);
@@ -102,4 +110,40 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
 		fput(kit->file);
 }
 
+/**
+ * bpf_fget_task() - Get a pointer to the struct file corresponding to
+ * the task file descriptor
+ *
+ * Note that this function acquires a reference to struct file.
+ *
+ * @task: the specified struct task_struct
+ * @fd: the file descriptor
+ *
+ * @returns the corresponding struct file pointer if found,
+ * otherwise returns NULL
+ */
+__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file;
+
+	file = fget_task(task, fd);
+	return file;
+}
+
+/**
+ * bpf_get_file_ops_type() - Determine what exactly this file is based on
+ * the file operations, such as socket, eventfd, timerfd, pipe, etc
+ *
+ * This function will grow with the file types that CRIB supports for
+ * checkpoint/restore.
+ *
+ * @file: a pointer to the struct file
+ *
+ * @returns the file operations type
+ */
+__bpf_kfunc unsigned int bpf_get_file_ops_type(struct file *file)
+{
+	return FILE_OPS_UNKNOWN;
+}
+
 __bpf_kfunc_end_defs();
-- 
2.39.5



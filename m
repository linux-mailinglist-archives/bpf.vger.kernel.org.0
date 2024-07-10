Return-Path: <bpf+bounces-34432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFC92D87F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78721F243F9
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02681990A7;
	Wed, 10 Jul 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f/gwW6EB"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D59197A9D;
	Wed, 10 Jul 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636989; cv=fail; b=TELymdu/YiRh0cIEQWnHKhdCDsTEnox/Hbi1FtULrxlrJeEIg1/l212SLL3/ejXiiKm4ggFnhUdqYZGOBYtrDKzV2EHxEplPUoq8TTllc8jYF9DkAEHt/BIG4FECxzs77qPbdYRGYwaPQLok9sxrk416sr4w1M2lq6C9lWUQ9VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636989; c=relaxed/simple;
	bh=CagETmbQzxQy7tHMFmKMp8hlYorlYA/ZSNKsjsKz7P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkY5FGM2q+8GJTvfhujYNOKdvzZaMOjZ8pJz0Y02yza5JhrCEBboQdA8wyn7F+nklSce0eVr0MLxvJVK3eI8wmpBaN7PphXLDELeefIrfLau0asWbw5cWoj59D1arpoPMHavUUoOQuBCi7H3xxEh3PjSw2jPwCD7SG7NXRNzuc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f/gwW6EB; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M56pI++t09lCeT61ytShZHoXX6Mc+nFSba3xKMfmGMagmeYcT1iH17b6nVrF1B6KRBwZJ7NRwuLCfgqDQa+tA6MfNGhhTAkkjfTs6T1Xod1LhFTi0TxfbT48dW5a3V+Ud6hOmkKbT5Udn73ibhoPlZ7R9Jc3yOLvp+1JsAS9TLNjY8XdeBFzUbPRw+i+ZFxHXXpCnLGqdt34VM3GQgij4q3gHjTn3yl+jQ23HlADp45LfMvySj5/l4abZQYUQKJcwT/SOMfp4fIwTcMQj5xCZ1KHiku7WzaivaZrWpM3IiXjlVp4LvUlhRNBzriXS8bu/s5sRHHwjarZbwDHKVFp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRPnIsO7k3xpL5wwp/N9T6QoD19hlcJIS2GQY7S4vmY=;
 b=D0XTe+h8dXcMmpm/cROJTB5iEzMnlAQ8lx43BWLMn4CJTOqQiV+jTCHEUsL38rx7THXsDiFjXrEgZ6uMdq1h0reD9p7ffphSVYOVJ+vP2LkFl0r5NxhKD3AiR5/VrvcRM652S3zv6FihC/PGwQvdZiatYVaw7Q9QzWF5tnGLPQWGUYG3SAWy1jKZK8wzIE8VAuiCZpgo7jOPy6hp5FCiZXn3UZ5uDaBLi614OxlssMlyvCJnl+R/es27K7JkFyawq3uVIc5KQ5zUizPvHZqZGYFRGVpXLVwS4K90cAkOeD1cpH1mknVsTpItKmvC3/KT7AMlP6WCPhvUQjXnZlzRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRPnIsO7k3xpL5wwp/N9T6QoD19hlcJIS2GQY7S4vmY=;
 b=f/gwW6EBXcdlcXaFTDQbpd2QTDj8shl+3KXLzWSjwKIIYzymTLTAAhP6uX26kHCYMv5GKBve+YEvX60SjGjUjcjZYuFH6cfJPnsdXI7kvCF3mpoywwD1QUtvurrsTkJZnRLWbur2f6XsgEMtgvfP37wTRuES1BAZVKV7O9gVADiiqazrpW94rY3D2ZWtndtGoJg+zFDddMMyXhBgFN0K1BgFpZEXH6F5qePxF4KbK3Kj77e3ItYJzBQpt5i1CoKCG3yLWO9lAxRWuMARvjabuzVUGlV/dUd/qwmicv3Vp6uqkLX6WWcfPQBSTaT6yUZMeVp5jufpSQnKJ5FGTsXk5A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:05 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:05 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/16] bpf/crib: Introduce task_file open-coded iterator kfuncs
Date: Wed, 10 Jul 2024 19:40:50 +0100
Message-ID:
 <AM6PR03MB584808A67608030DD38E3E6099A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [joxeLc0fB8DnMmeFv/4yBULradmxBYYn]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-7-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac533ba-6db6-4169-9303-08dca1102263
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	/cdZY+31pM6pHxbeiz6Q7+872YMFfIJToyaT16r6tQRhoHWr8fhn+NwPkZUVqWz9kuWFWfFjLF3H73lne9HtZfG9a+N4I2EK42bBlI4P/di35eGb+ukLQNBM2LDJXyn3LEhIGPn7rW9z0pt8ODmLL0zMzt/UV+pCmQZKRrUz70ROBuE4bB7DhxQyhDSJW6q9ORPx2f9agoU/d1zeyIGizYehIKv9jRw4pjT9i32/2UisCCYnmLTml/I/YWLRezlqUpssZv6MPD53Vj2jNBa+x/nV4Xg53HqSGiTnAoEsmWd0Tzf4h3w6PDV2T1hBLKowVsaB1j8xRhbS3wQKWa+tFKUkHZHIQrgmz1NY4B/FSE6uRZ1OQTYGpx826g7tXmhCxYhydsdmmSMbWCGoz2FKxaAtDN5G/4froV0OFaRk/A/3ZBM1gMCWNFreptlrM15b7k6UGjTTp7G3LPVN28HvXx0X93s8Ra+/fvgeR5tryjsF9pFj8ASqpDN8Qm0Js3lEQJfZxpakvl9bwX5gwAYjsz3ZdP7B1wfr+95pj+DR2+CzQ8XiRjkiQsuReAunQ46DoUxMIgs+YnstYDBjxIjPlhJnzJsPosLjHgVt8tSVgm15Iaxvx//zddsSoeLD7YBlD7ffPbjvchQVts8YY+NHoA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwltLrgQp/nyQwf695Le0SvxyQi282oS+uGepPVmLo1WR2uTJhos521P04qn?=
 =?us-ascii?Q?Z+6yt8Tyn6CfOg6N6ZFfSlZdJ5N5TFIuwMeYNVJWvoZGEVK1Mted4YaVJ5v2?=
 =?us-ascii?Q?tTNuL4//7x+bs3y/9aEycRWGuZDPLfqq3PP53tt5QhEk4D11Xk5TS2TkExy4?=
 =?us-ascii?Q?jTXm2uafzMc4V0tQU0oxXWd8/EePN5dLNeF1zJKznLZuU1lmb+tOQ5fHAA8h?=
 =?us-ascii?Q?4dSoqbwcUhZUoIf4d2SqrsnCeoI7vNGxMxs0IkLeLMyp9JRN2V4bH4RWkkZD?=
 =?us-ascii?Q?8INwibLoR2HsBDKiq/+CWy/v2D5dbbzywqMM1P4H8+JHxwji+RokZbj2RGFT?=
 =?us-ascii?Q?yQdvvRSfPHKdVqHAk+3+L8oQH2uB4+9w7RLY/sDT7MHRVue9nh28Gx2JMsOm?=
 =?us-ascii?Q?5wUiK6Vodj9zWnrEHaexojAGG47ML3M0R/GpDW+eQPKt4QEQOQQ+VylCFAYZ?=
 =?us-ascii?Q?Zc+X2Es70b/YwmIVHx5JvqTi1lFc6qhRbwv3D2z+aFLvYIuP7CzNT3b+0QWN?=
 =?us-ascii?Q?7D/Ah91oTiMlqXoR/bQP/1cTZx0x0Adq6AnqW942yUNf3uYKt9LyTkcSJYRK?=
 =?us-ascii?Q?CGs7fCGjzsT2CWrRfHGzSAuRdo+iFK8xynwMBqBOKPqY6OoymHaKbe0097gR?=
 =?us-ascii?Q?SpXUUHqPnebPA5fMx8fDVbt91WdCozdT5VyLLVtHaJKk3mrrEwKRHe1N55XA?=
 =?us-ascii?Q?eYyO4Cy94/wONOS0067Jw9QkTXPb2GFDQRfL95NTV1PCzV+hxBo1SGx2g2vG?=
 =?us-ascii?Q?WNJeQPrifrYjRFY3/Sj+CkFIkNFaqsApruFDg9deKbK5ydMnGWaKHDoo+T3e?=
 =?us-ascii?Q?y9qWdutYTciBXpTau7KBCax6UatK2lKMhoNuV0uuHci6GAZRKdk66GoIr38s?=
 =?us-ascii?Q?XPdFzJx8gHaWYfVqOjb61FaCPJzVoy3gtwjWOuPKDa4Ak2S16WLwithDSCoW?=
 =?us-ascii?Q?0x6RNlyv9IO4TOhE2dTfkprgjicMkm5s8QGgwy8B+HcfP4qNZmzIg6psJO+j?=
 =?us-ascii?Q?JdlPsdPPjuQdSZ6QzyaxmcrNTXmhK5RwvJHV5oHi0mdjqxOB7sGnaNKmlUU3?=
 =?us-ascii?Q?TCcX82SUCBkPl0NWHwHk72gGzK+2xxLl/aoW6wGrnmT5/iYnbIdkkIru2ADx?=
 =?us-ascii?Q?4Uyg4thgnoxCSVrYg49mhVFskfHQ727TU+F1JC+7H99i4UEOwNtNtSqItXF3?=
 =?us-ascii?Q?s2PHzm1WPVELo8q9irkjCsOo448qpX6+DszJt6Um605r+tc1Vtl/xRobBQA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac533ba-6db6-4169-9303-08dca1102263
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:05.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

This patch adds the open-coded iterator style process file iterator
kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
files opened by the specified process.

In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
the file descriptor corresponding to the file in the current iteration.

The reference to struct file acquired by the previous
bpf_iter_task_file_next() is released in the next
bpf_iter_task_file_next(), and the last reference is released in the
last bpf_iter_task_file_next() that returns NULL.

In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
the end, then the last struct file reference is released at this time.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf_crib.h         | 10 ++++
 kernel/bpf/crib/bpf_checkpoint.c | 88 ++++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_crib.c       |  5 ++
 3 files changed, 103 insertions(+)

diff --git a/include/linux/bpf_crib.h b/include/linux/bpf_crib.h
index f667b740fcc2..468ae87fa1a5 100644
--- a/include/linux/bpf_crib.h
+++ b/include/linux/bpf_crib.h
@@ -13,4 +13,14 @@
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
 
+struct bpf_iter_task_file {
+	__u64 __opaque[3];
+} __aligned(8);
+
+struct bpf_iter_task_file_kern {
+	struct task_struct *task;
+	struct file *file;
+	int fd;
+} __aligned(8);
+
 #endif /* _BPF_CRIB_H */
diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
index efaca6bcdfe4..28ad26986053 100644
--- a/kernel/bpf/crib/bpf_checkpoint.c
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -7,7 +7,95 @@
  */
 
 #include <linux/bpf_crib.h>
+#include <linux/fdtable.h>
+
+extern void bpf_file_release(struct file *file);
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
+ * used to iterate over all files opened by a specified task
+ *
+ * @it: The new bpf_iter_task_file to be created
+ * @task: A pointer pointing to a task to be iterated over
+ */
+__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
+		struct task_struct *task)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
+		     __alignof__(struct bpf_iter_task_file));
+
+	kit->task = task;
+	kit->fd = -1;
+	kit->file = NULL;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
+ *
+ * bpf_iter_task_file_next() acquires a reference to the returned struct file.
+ *
+ * The reference to struct file acquired by the previous
+ * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
+ * and the last reference is released in the last bpf_iter_task_file_next()
+ * that returns NULL.
+ *
+ * @it: The bpf_iter_task_file to be checked
+ *
+ * @returns a pointer to the struct file of the next file if further files
+ * are available, otherwise returns NULL.
+ */
+__bpf_kfunc struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	if (kit->file)
+		bpf_file_release(kit->file);
+
+	kit->fd++;
+
+	rcu_read_lock();
+	kit->file = task_lookup_next_fdget_rcu(kit->task, &kit->fd);
+	rcu_read_unlock();
+
+	return kit->file;
+}
+
+/**
+ * bpf_iter_task_file_get_fd() - Get the file descriptor
+ * corresponding to the file in the current iteration
+ *
+ * @it: The bpf_iter_task_file to be checked
+ *
+ * @returns the file descriptor
+ */
+__bpf_kfunc int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	return kit->fd;
+}
+
+/**
+ * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
+ *
+ * If the iterator does not iterate to the end, then the last
+ * struct file reference is released at this time.
+ *
+ * @it: The bpf_iter_task_file to be destroyed
+ */
+__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	if (kit->file)
+		bpf_file_release(kit->file);
+}
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index 1c1729ddf233..b901d7d60290 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -52,6 +52,11 @@ BTF_KFUNCS_START(bpf_crib_kfuncs)
 BTF_ID_FLAGS(func, bpf_file_from_task_fd, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_file_release, KF_RELEASE)
 
+BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd, KF_ITER_GETTER)
+BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2



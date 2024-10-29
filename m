Return-Path: <bpf+bounces-43438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8429B55E5
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D91C20329
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000F20ADDD;
	Tue, 29 Oct 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T65IZc/s"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2104.outbound.protection.outlook.com [40.92.58.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A4199FBB;
	Tue, 29 Oct 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241677; cv=fail; b=lrfX8/7N043L30JqR+j6JI02BTNenzaHQ0L+dGc06aztDIPhV9DO3UnuKOk1BQryMQerHc+MLNwTQl1cMCXDndesHh160f3risz669AOU+BhnCWAECpkZTT/vyIFML+171at5/j8LS2Oio5krp40tQRGNrTuB66Yv15ojAszqx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241677; c=relaxed/simple;
	bh=GwOMTBxL7EBlQbeUT5o3SQTv1nbDs02IDXR055rBeOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNoL7gjm3/NIOu8QYTuFR7btRrlI6NBOKYeYrgJFDC1jyt3nFnYgcCZBg2Ms4ndtk7ZtkZnkXiaMfrhTnIAglvDYVHZ3Cg+NZfhjww1ygoMRSawRzMyIFvbJe5uDd5kZ69+DAZEtA0GQSeX7xN0gDxkf5CX3VU6qraj7yxwfmhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T65IZc/s; arc=fail smtp.client-ip=40.92.58.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIbVcVlHDmY0uJ92JEOeU0sRBhx6bhSTdJNJiBEnHdlJObBQvQgs0g0U6KyYmKizYChZIHTsvav3v7mx4Wctk/tWt/DkqNiZIlP5aG7ZFMpYbedPirqQKqG2PqLrxxL027tmmvPepkJZrl7g7yZYicyl+BcI15+EKvTxxG4JTBiHrWjdsc2I9/NvSFVQvTdN+a4w7JnO2y/nvG9OjPoXAmAVsxJr4O2bo7eoal+YqA7hkwR9Ns648SEQVsQcfPZ1LJXFAV/EDYUCXshA/l52wUA2V3uqB9Jdoa+Lp0LnlOROVZHoBmMYMnae4dvcqKFcOloAqQfPz9P/4p85glM/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOk1EtiAZ+PvJ1ok7hOJuKLuBgQ3Eoj1iPXa2vAg57c=;
 b=kcRShQtL7ltW/sG8Q72g7R6XsM8ZkrDTDgUasALasLSJ28jCSZxCDtI9EMricsfUU+sN3H7DDuilZLrvjESVLtWi4lCdIHQ2fgxD1Zy9LxiiYbBVJ4ubYLe+clMxiCdZXy4pVeIfH8O5LmU34LUZBwo+dEsxa2te0MlWdcbz0ZIQuuGKt0dHE0gE6Aca4Gk+2g25J49qJ6Ov6EMxMXmGgHP3JR1np4zU8tdOr/KSA8UCYHs6BTGo9ZfvzYO4q//mX1GsYTaAAr+5y2O17DuERQuSEUNjIDzqNtwub7RPz8VxeihvuOGllHUsDs+vavKjNDehdBxO72IGg2r8iltiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOk1EtiAZ+PvJ1ok7hOJuKLuBgQ3Eoj1iPXa2vAg57c=;
 b=T65IZc/sh/+d196vZucTR0oyx3AaIfTcbcOKx885D9SEE/jrjDFBA9Hp2Tcp691TdzqwzlBqv6MjKAdMSIttwG+dNhdH3uC1PmVgC2YvxE1V0/Ib+O5U9MjvlfSRHRekrkPg0Dq46Xz+uEOtf1OhD7n4q5MvlpckWY2PubXu68h7Y749bZJUIXWT1iKqDcqVWxC7j6DgvESm/XjnI7lYt91zrSLKc/EPu+SBi1Ar4RUJpP6MLpbo9qFcWKHMaH3dwGHJjRCw58gZWhDg8TRZZ9Hwytyw7cMF/RUjHVzE9Hf/ITzP197KbSPWmwJRAz2HLaMnpkUWaBPhjgpp2syLUA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM0PR03MB6130.eurprd03.prod.outlook.com (2603:10a6:20b:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:41:11 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 22:41:11 +0000
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
Subject: [PATCH bpf-next 1/4] bpf/crib: Introduce task_file open-coded iterator kfuncs
Date: Tue, 29 Oct 2024 22:39:40 +0000
Message-ID:
 <AM6PR03MB5848C3CABAE8E688A784E520994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241029223943.119979-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM0PR03MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fd812f-0a9d-47fd-66a8-08dcf86ac9b7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599009|15080799006|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rqv9xgBARMUwoVgkaQIU7/H+xmNOiwPKJ5sUN/IItvekja0AHci0a97Vx6kN?=
 =?us-ascii?Q?IxOh1YSMUswJUZdHKLD+ovjgeun3Txaqp8DmBLRy1Ub+HRjnMgIRjZZOdZ98?=
 =?us-ascii?Q?ZyFEub0mci3U5tACPtqH4KWOk5YXMI+IIhkIw3VX6bo8GRauRtH63L0wwel2?=
 =?us-ascii?Q?ARBN/y96dMpkDE+9G3YW4ejJEtbMTABccwrdETg0D7yWSdGSTQ+moaPBxtQa?=
 =?us-ascii?Q?kBlY0kkqKDZmsQYzWC6mu0ESth6Iwk6auhhtlmnKvBCKEP+a+s6Qi53nc7o0?=
 =?us-ascii?Q?8qPU6y8yyHR68EyvEI+gsvVwUkOvg0B0Giu9+HnwQIASe6tEQc4eUxXMLb1I?=
 =?us-ascii?Q?8bK36pdphurpChkN2+BEbYsFO0cOnaPp2xG86kjEPqTWnG3gXGImE0k3x1Hn?=
 =?us-ascii?Q?wIiYIHil05CKI8aFzC6y93Z3vMFm3iT9JxypjXjImiofzTp2kXXsSOG4qqhN?=
 =?us-ascii?Q?otUKEqYwILqyvpX+DbOuWGD0HlMk+vZh1bwWhmfm4TJp66G6c3Q0VQ3VfhaB?=
 =?us-ascii?Q?tnuWf9GPS4QwDU/5TbZPcjDnPIlUJ4uYWqsH2r3iZkIbhzMzPq7mNBO9GvGN?=
 =?us-ascii?Q?VwrIxZrBY7KdBOVKv8/7TPbuQxL+wFuAA+JVNISi1GTNGc/O+2sTDBV4jn/9?=
 =?us-ascii?Q?f4pZAkZo1M1H89RAgTH8KPfal13BfSvIRqDzCg5K4zDHTFQCqEHk/FthFYR6?=
 =?us-ascii?Q?U7pu6NfZCf7iP28MWWY/w4fxq+rND+/2/86yuAjR5DCBlcHUqFNpRyTR/NnO?=
 =?us-ascii?Q?VK8kEmYd/r/8PrT7x/PUxzli8Yp0ehgPDTglvmTmT4LqdkPM3fL/S8hDNqLB?=
 =?us-ascii?Q?dK7T+4for7+OM5DJHkz4me/MFGN4NqulRVYMARPh7gKjd15t1Zzh4SfLP8EW?=
 =?us-ascii?Q?Mc4TjUOGB7vCQZkKUrIYvbCG63TFtGAaB4pC4l5FN9W66iGlRjTXWT6XqeYf?=
 =?us-ascii?Q?8Mto9dg7gti7U9kADvbhL0n7Y+cO5UIL9l19zk3Swf9WU3ZE2MRSHUGQuWau?=
 =?us-ascii?Q?L/2n93FaaI3a6rO4RTcMvRn+qw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iK+/Iw2GxYWB9d7nbjMrYqtGUuG4afu/01EEl/cKnk/AtqDZSjGFAJOemx3+?=
 =?us-ascii?Q?S3cVxbIKydbXA6nAo11zvkD93vnUsv1qtStQh3jWjFN4S2GHZYVfMv0qLXvY?=
 =?us-ascii?Q?Ye+Uk5Qc3nsBZhfUd1pyMe4YbM0KGZRJhnRtrUWhPXRR/b5q1vTVwtGammka?=
 =?us-ascii?Q?3xxlEdegHh1on+V6tD3XglWk2zIdDlXJS/aLuvhwTNrDOFY9bjDQM2+tgLp9?=
 =?us-ascii?Q?gpVe/n+YhYtwbBUL99B40yD0onsSLfRpSuX49jXF0SuVJ54JRYAhaU+jfetq?=
 =?us-ascii?Q?SyQ3hZJsuErkgxz0cGhuK0c1cCC30945IdX3Mf/BGl1/eI4C0VElZ02oZXCk?=
 =?us-ascii?Q?O4kjGt/hakiEw+iFusZFW2J3QGRzRdyK1htX//6uxn2hv/hoD4ykCHNTFUX6?=
 =?us-ascii?Q?s6JXnVxMuzOxrhsg8DFag3/KdvpQcuDlGlnvPg/ukAKiweXkIpEpSMRNN4KB?=
 =?us-ascii?Q?EKAj1/Q1supiPDZf3VkhjsfPDbVHng/0MmVGROm5ZkBh6aMrl99KmE6C1s4v?=
 =?us-ascii?Q?WOcPI+hLakNq2scQSEpd/ikOGTmePn+61TYbsbOcoX7tiAfjG/4rsv88zShY?=
 =?us-ascii?Q?z4qaNif2gQrboNaMl07KiXBFPyZlydbfdR/si/OOSB5NDdrb17JwXC8ZOsVs?=
 =?us-ascii?Q?42G+enJ0TtZ2z/6d3sVwnAudyimfHJ0y7hapDqDnaatVioh0LKdqs7PcJ8xi?=
 =?us-ascii?Q?oRMJOgoaIYk7GP4twuMdOMVsM69l8Y0M/PeapPQp7SUsc1sRTltG+bWApS5z?=
 =?us-ascii?Q?IcmSgOEcrv07+7Yrwzr+yLolHGN0QXFmM1TvPZXYc4ZGnbZ+R7CGPQd6RRwd?=
 =?us-ascii?Q?Tihpv+vPB9vGhIpj5XZNzHPruvIHqegBXhcE49auHym2Sd5c7ipXbuLh+aJs?=
 =?us-ascii?Q?ZWBEq9LrM+bmdkaZmTL1sOVmZSzyeaxX8pVXYGoClbzFhoS8k3PHX6PVYTEg?=
 =?us-ascii?Q?mw4aWEvLbUydbHzP9y59oc1KxwJmOHO/VyvG9Zl+G14FKUWVPWIGuVvcxuWk?=
 =?us-ascii?Q?fDBMpxgLHWnESigq+A97ny0nGoYq1BGI7/uGfhDMwLpv+EENv7Bt4welR7Kn?=
 =?us-ascii?Q?f/KMElL4XHTHFCXv4fNR5XsGelLW/NrwKYwYdwbYvsc94wMvvriQQx+aHSW+?=
 =?us-ascii?Q?OFVLU9iKylGnhKi55wSLQog1JuNh5tNGijYtSGZag1VttxDTXuwwEhkAM6Il?=
 =?us-ascii?Q?+pDmLFCz0zLxzDH3GK9ZSrUyxWp4mfsFByDv6rucdqldqsaD+iqSLoyIswDw?=
 =?us-ascii?Q?DbC9/fxDav5FPxtYwkiE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fd812f-0a9d-47fd-66a8-08dcf86ac9b7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:41:11.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6130

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
 kernel/bpf/Makefile      |   1 +
 kernel/bpf/crib/Makefile |   3 ++
 kernel/bpf/crib/crib.c   |  29 +++++++++++
 kernel/bpf/crib/files.c  | 105 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/crib.c
 create mode 100644 kernel/bpf/crib/files.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 105328f0b9c0..933d36264e5e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += crib/
diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
new file mode 100644
index 000000000000..4e1bae1972dd
--- /dev/null
+++ b/kernel/bpf/crib/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_BPF_SYSCALL) += crib.o files.o
diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
new file mode 100644
index 000000000000..e6536ee9a845
--- /dev/null
+++ b/kernel/bpf/crib/crib.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB)
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+
+BTF_KFUNCS_START(bpf_crib_kfuncs)
+
+BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
+BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
+
+BTF_KFUNCS_END(bpf_crib_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_crib_kfuncs,
+};
+
+static int __init bpf_crib_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_crib_kfunc_set);
+}
+
+late_initcall(bpf_crib_init);
diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
new file mode 100644
index 000000000000..ececf150303f
--- /dev/null
+++ b/kernel/bpf/crib/files.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/btf.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/net.h>
+
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
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
+ * used to iterate over all files opened by a specified task
+ *
+ * @it: the new bpf_iter_task_file to be created
+ * @task: a pointer pointing to a task to be iterated over
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
+ * bpf_iter_task_file_next acquires a reference to the returned struct file.
+ *
+ * The reference to struct file acquired by the previous
+ * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
+ * and the last reference is released in the last bpf_iter_task_file_next()
+ * that returns NULL.
+ *
+ * @it: the bpf_iter_task_file to be checked
+ *
+ * @returns a pointer to the struct file of the next file if further files
+ * are available, otherwise returns NULL
+ */
+__bpf_kfunc struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	if (kit->file)
+		fput(kit->file);
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
+ * bpf_iter_task_file_get_fd() - Get the file descriptor corresponding to
+ * the file in the current iteration
+ *
+ * @it: the bpf_iter_task_file to be checked
+ *
+ * @returns the file descriptor
+ */
+__bpf_kfunc int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it__iter;
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
+ * @it: the bpf_iter_task_file to be destroyed
+ */
+__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	if (kit->file)
+		fput(kit->file);
+}
+
+__bpf_kfunc_end_defs();
-- 
2.39.5



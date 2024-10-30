Return-Path: <bpf+bounces-43456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29969B586C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62251C22ADD
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA910940;
	Wed, 30 Oct 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SqnrPC60"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2103.outbound.protection.outlook.com [40.92.50.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8BBE65;
	Wed, 30 Oct 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247318; cv=fail; b=Eu8RaDRV2oKM+w1M8GOT/3kNAQKb8aLhpT3tojxCCad5OQC7xLofluUrTvRv4725sZ7Er8MZd6K+zOZHKNbmpQ7mjwdluEUDlxC2cbfNxUM2n76FaOUv4C2kTK+YCkWhaa5Iorle23zqf/1P0Igg4vNZfBYZzXg3Z9EQmyRPoBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247318; c=relaxed/simple;
	bh=GwOMTBxL7EBlQbeUT5o3SQTv1nbDs02IDXR055rBeOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cDAPH+CAp4CjO6Fin8E4YwPvJBT5r+jP5FsSEZrH9WnNUckBm98D5xtcahd6ES9kcygPTKapA7I9sJqIS1YCutpU0XOhW/ih4qXf7ZtYfmGPiP6bsk5lxv+K/hXfzb/8csLQVTeUXkAwZce7QPymrtywYzjOm52xDmJ+7wOejlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SqnrPC60; arc=fail smtp.client-ip=40.92.50.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb38FPPJtIkSmqJKoIdewSR/8cb3ZWd0RyzrJZcbmYALuoQj7/u6VG2uxRBuEEwC586YL4v9u26sfW2A7pFeUOXbyPvLun2IWFoie/be/0u3SL7JBc/5eP3IB5LJDG5ABcbrDTU8+FqOGxBu8fp42KzZVrdPNsk1AiDdiLpfqIfnOUk1oO/srn/EyFxqICbgq4T0yiY64jriQ3y0hDEJ0I2O4Dep1wCMBVTUVxZghLcgblZvLbAdhySpKIoQHrUv7+ag8/NR+X1imPXyQzGB0DElSPQTPf4mq1Z6VA2wnP8bFa7iau/IhKcaKaiaKXzIk8U15TVog7A67FAJ0W7mGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOk1EtiAZ+PvJ1ok7hOJuKLuBgQ3Eoj1iPXa2vAg57c=;
 b=R3NsVhC+MZjCKsDPN3zY0YlceSofry2CNtzFV90tGEt+5zQllCgGs7mkPWh731Sjc4j5Qw5DdRud5WNI382rfNlFF4yK9Q+oC2ijUcOhr3NBc96qvfkjJKrI/kLTFBI9xY4Lq4X2f1dYDlZwu3DpFXV7Al45RoXqC0Lj7gB34+kiyWiVSZNMg2sOQ9H0z++snwJyxCD1v9HOnUqUd4Bu0hgXZqhguG2ofdowRLIIlnnQlirGQ7ykv24iUM9LzmHkdU4dBeGpbHLVLlg3Mbjpnaub5L3iwNEZuW63ET2oMaFsKp0pl54AweXt9ZabWv3GxKLqwa5DQQSpJQ5i5vpRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOk1EtiAZ+PvJ1ok7hOJuKLuBgQ3Eoj1iPXa2vAg57c=;
 b=SqnrPC60/5qfumpuPx81lRT2beN/6mJbmAiGYVechxieZwjei99+3Kc6TkotVrlX5uhpekQptWRSVLJdACT8XnHta0B0emG1fPgX1gbDPC4xCLsVS7KfhYITNeuKjnhvJpAuKFOEiOV/fVAUTuLNrkx81mDXMuSTaiJgHECKn8qL/4Scu1oxjksrlLCjgUmDhbc6QoZzuf+grCLBbJOiWNn5BIzVggZdamg/GN8T8JaZaWq40yEMNCbL8B/Y8Vj/+5qFDo9NSA0c1L6EOl/hFA2lFbvCwoukMtO1tchmz4ERuEYscpMBkh/e64qe6UV8o8mj/lXlAWXqJW+ZDpXjMg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB4PR03MB10105.eurprd03.prod.outlook.com (2603:10a6:10:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 00:15:13 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:15:13 +0000
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
Subject: [PATCH bpf-next v2 1/4] bpf/crib: Introduce task_file open-coded iterator kfuncs
Date: Wed, 30 Oct 2024 00:14:54 +0000
Message-ID:
 <AM6PR03MB584846B635B10C59EFAF596099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241030001457.15593-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB4PR03MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6151ab-0a31-495a-64f1-08dcf877ec35
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|8060799006|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHZCPUO2c3tzP3l+AFZQZ5H0Ney1/WXDPrsJe0zC3rlhVyBueGTkrbh3OKtG?=
 =?us-ascii?Q?23C0s+xOh64PpgSR6NMF7nIdRdmLdP/t7TKHlFkvydulKopMmEwFLVpyvfNY?=
 =?us-ascii?Q?J5VJ4ntiYqCHE+MsdqOHY0kR+V9qXZ9Ink/i7ITKY+qrQjwO3LMcU52SYH/m?=
 =?us-ascii?Q?Y7CXUvWEpdeV73f3ZBFmedwnVnhykcd5NWVD06J5ydySx5fT6YJrBCvthnbw?=
 =?us-ascii?Q?WS6bmTJvfuda6vKt0ayDKFtG58XK+buct/SiB0qOZ3/5Jp+SUMvLBBeQm8ye?=
 =?us-ascii?Q?dWC/0njZWmJGfPLwVDEemK4fWurIHbcIZJDApKLitpmRNRRspln/Iq105uJ7?=
 =?us-ascii?Q?s8MTbECuF11h+QnLfbNrylJQQOw4wyxb2L3nSyvQ0sGbMP90ecTzH5WQxanA?=
 =?us-ascii?Q?M3pFIblfuN9CJuhJEqSd71xkvOH4XtnzW0bflbkQkrPtjYruCMwpAEdm4UOg?=
 =?us-ascii?Q?5klZXUwR7V+6UQ03O+UGFaGlGJzBIaTkGOxPZ6HnzGoixMmGvS4BmNriP2Yj?=
 =?us-ascii?Q?cp2doVBu2K05e3ff/lHtDUtOlbyfjRiqARI613M1FXBNnAZL2q6FBttwdRxR?=
 =?us-ascii?Q?zC2OdTRQbgEBMnZTI5iUHONI5rspcfFQASn2v+T4rsK5wIDiprJq2Lg5tXIJ?=
 =?us-ascii?Q?mCWpDXLC/KSiGvuRLOLTQY5fKj/qajGMgdGcvfsHny65IuQb9MaT+6Kml0wr?=
 =?us-ascii?Q?0y556dCk0L40H0l98n4TlTT59ejsPe+/xBjP07/Q9u/ad9GIq3OFeHh9iNJa?=
 =?us-ascii?Q?DwjORjl2Yl8vTvLrxTlNhzuB4wcIOtfBIVVqwiJrMUSHQ5gDfmSMGsH6Q3pR?=
 =?us-ascii?Q?w3juUDfQ2no564fugC0PFHo56oLmQVYwpdoYw3XzI7kEvFfPFDU5NXtqyjJi?=
 =?us-ascii?Q?HunizOTk+OmLycqjY/hEjWTxDQO/9CDepagP+WFKcoRQdSpA0n8m7gfIhA0Z?=
 =?us-ascii?Q?BaEnSNAwIksRJpHRS73YU8zPde3Ov4e6/Pqs3UiCZQ30g6qW1w0peTBENJ2B?=
 =?us-ascii?Q?5rVbw3lV10Y053aw6taVBh/L8w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OfNjRhULOGdyETSnAWeqaM0J0u/8lY2uqWkBX1kbadcCOKH417hhrpr3ABDd?=
 =?us-ascii?Q?S5I73Vvm7w9gBcvxRGVf5HOQpHnYrSFWxgvd69C/Rg4A77Y6qWYln3JzXUBg?=
 =?us-ascii?Q?SLQqXAUL6+JYKoYerl2a2jx9VBWO5PRCKFsNWAxXo+hWqj22QLEBv1qIL8L/?=
 =?us-ascii?Q?8jJ1FfFQVx1oJwy9UJBtT/GcSMvXasANbNczZl6I4xpctQ8nqzooOPXf4YwL?=
 =?us-ascii?Q?5C9u3mlWJ3J3U8aj//dYGJ0aGlB6WBJaj51UUFLP7F+YZIPXj2iWKRROSHs7?=
 =?us-ascii?Q?puT4N/253iOKnboZBaDMpPn8oubj54guI0GlQScRVuXNJGTDt972VtGrZJ/a?=
 =?us-ascii?Q?r7DfTWYpOeTErvtWj3ER19ngyR3EBjEsL++beVeKRM4Sp3qPBKtCDGACMqek?=
 =?us-ascii?Q?6EulA1ykrUN5UCqLhZw/e20EoAC0cATbT6sDtGcUOgueKmVzb9ZgAsFqajJ9?=
 =?us-ascii?Q?xkhM3CfJU0Q/J/w5hBODAysZ9XK+c0Zwg/RmWBbXjA4xd2sonx4kbjAv0nbc?=
 =?us-ascii?Q?uz+XeH58n9iDgtyzKwS52wPQNPjBdsTihz5BycwRt4p0kBKiy/Mi0+uujT11?=
 =?us-ascii?Q?dZJ7SBHcj+o09KeYqw0nqqYVmv7QhLXwqou7tPo4aZ6+K0JCGMv4CICepZXz?=
 =?us-ascii?Q?bYWyjMllwSbbK6utA2kh/2wnCZoJObQIIryHJvT+H7w/c5hZr9jD6wqXtZDG?=
 =?us-ascii?Q?z0VbfLfkqRAGB2AjA7LqgQZZolp63/y2NOvI40QPONq9ZQ0oz6qpq/xYjGhg?=
 =?us-ascii?Q?npr0Q8OueUJyD0QrrovZK9cU+xJDR9dmALl/EH6WJnsZPyOK5gD5tWH2BEVM?=
 =?us-ascii?Q?SoqK91eNWnu3woQPKB+a0cKA3AbCw4mBz9RSLXvp0c0E1iWbva/hKJDD1mo0?=
 =?us-ascii?Q?P+cStbeagf42DL+5f/LoTasVqPUOF+AHASol2Jm7One5Q36YfBsk7VcgYkrU?=
 =?us-ascii?Q?p8ZCDA72wbz2pSJ5p431PcmuZanTydKZBuSvCZv3SAI4TDcVbMyQK+y+GvUL?=
 =?us-ascii?Q?XDc2WJu9ZfJtoV32CuyVSVSZ2ckiHn4uPflDkPF9m20iUCmOh23H2xqWNBz/?=
 =?us-ascii?Q?QP6J4QJrN7TJjb2iBhy58RVZLLIlYwdIGAHuad3Qx2VrDoXwhjhyhjx9RUiy?=
 =?us-ascii?Q?GMc4imT/IOtYGzjWC8y5MxhbkI980u8jurZH0D8nITmrJ/wUZLVG5/pyd5dX?=
 =?us-ascii?Q?fIdni3kP3pkjIuM4ER6b/3QoX3xRg4GtFVBtpbnFaaW1x+C6izL1HRZXtVCx?=
 =?us-ascii?Q?WkvfaNoZiw9cZ0Ad++gt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6151ab-0a31-495a-64f1-08dcf877ec35
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:15:12.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10105

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



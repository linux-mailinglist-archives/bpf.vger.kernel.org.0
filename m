Return-Path: <bpf+bounces-34546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4592E68C
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B89B1C20CC5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367C16C850;
	Thu, 11 Jul 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EqaUA2fX"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011020.outbound.protection.outlook.com [52.103.32.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11515B147;
	Thu, 11 Jul 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696947; cv=fail; b=ljaf06VqKVBzTXF4DcpNva+waFSco73ca1DewWM3aQfwaNehdpL4iMCOrt/8HzXRCPYPqPL+JWYOrAlyhOlXnmf4FlM9ulXpwuMpS7zWpr+6oZbS+kbL/J+2XPdH8e4BVOdJyz01Ihh6hVcjkgjHvt9fAAptebV1nlUzuxjyoWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696947; c=relaxed/simple;
	bh=CagETmbQzxQy7tHMFmKMp8hlYorlYA/ZSNKsjsKz7P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODKrNytl+Q15qK6hK3OnOeKIXAIh2I3rHhCBvIIWLjRYuX+7kpAjbz/t1OGhpGURtZQnEy0LxQ20ISBhNyrICdxB0rKnCxDYm4syjWaoCqKF9dAfcxhxOLE+GW2rjzExx7uAkNXJKEAojDj2jKcbfT2QT3rdv0EcyqcKtueWNIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EqaUA2fX; arc=fail smtp.client-ip=52.103.32.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/5+NGQ6AJ5V1QOaRrm2I/DUQ03t6qJq7NvLzCON8ae4sJyAP1NpX0hSveXy4D3XPUrt3VBr5fTueVRePglsQZOQuUL0kV1OXSFm69Qqv568FP15J7SMvcbHBckKoEsMaZCYiarKORSJ9gilaloomU9zgh/7VyF7yD38y1JJSErIekYiRQ/En8xo9q/W7okx8ayA7HLh+67oW25d/3uk9P67cTT7Exx6WLaFy1VsRS59Oq4LGzVKJI+iQoOeHHHeXDN3mYULiMFcDkTtnWhuJT8xvEkWImSJfR1q0XO288Jd93fYAmX2gZzkwznH8fnzxQP/DMNgEtxl/vboc1KrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRPnIsO7k3xpL5wwp/N9T6QoD19hlcJIS2GQY7S4vmY=;
 b=T8doDR9/7ZvuGESgdci7EC/Xbhmu+tj2Pn8NeF2ZEBn/IbC4mxEPkXqC4SIrdYgzoOK4GtdU9Etv1l9/+2zDxFY29+eYuYjERaP7ssIvsCAuW6llxhfK6EMB+7LDs2Q9IVk4Wr1gTbhvtZMg3YniX9LPgfOvJcI/Vx1vO8YSCNLaQnuQGFeai8kXkzJeAIfzx57Iasg0zMrif8Q/sh6AjNK+FP2y1jEisBWMXRFNbvCKN1/be7zf/+qFtHuXytYpIxhchmWJGD4+/U1XlddbxWE0gXHSTUDDlUkSKShOu3nlhebZmuuPIQnGJBx2QEuVZ2s4xTD49APvYPXVSa0hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRPnIsO7k3xpL5wwp/N9T6QoD19hlcJIS2GQY7S4vmY=;
 b=EqaUA2fXiNRUlFTGs5isiYrtNkIRATglEeI14oej9FLUoiluZ9XFarEwKt7Th1F08CvbNCmB+AIm1gJUSyttmicWbmGkO+MdlizShn4FKecZrM3GYmjDi68qqdhJbxCPb3L0f3zmXs5jp51VVCX+Y1/YyR8cxONTeYljaYaZElIt3qCriVIYjwtBl6PvDd+8tDMZjV0IqFb0nnBFs7T1Hkp/aRJQX+oLpuj7voo7wuNfj1HNnBn3GPBMpwNLXcb9mYSUdTCP0Aj37l29Dgp+kn09pMeC+lZ9P/sj0AFYtca8xpdB8gypKp5sDSFdOuL5+tNrKpTH0mpGJcREFbJUYg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:22:19 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:22:19 +0000
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next RESEND 06/16] bpf/crib: Introduce task_file open-coded iterator kfuncs
Date: Thu, 11 Jul 2024 12:19:28 +0100
Message-ID:
 <AM6PR03MB58488CDDADBC9049B186F4FB99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [gBOAKcYG9dXbNv2GXEhduZy9wJe9BsZ2]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-6-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 412acac6-e7c7-41a5-3e53-08dca19bba24
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	wFD86fpyoqFVl5oH/kTUHykxa03gaauAXSfFb6MeEPQzebj0+b49Pefmd1oCGNTiH2wzptTFPjEazfigrukrmn1fLV0fBlSLGlHy+cE8MfVCQ9a2XNVmtOUtVeiImrR+cKEEIW2GOFJEyAeL03Ik9LBGY+H/Qx24mVm5C6RxQtygFwYTAnwQZhLKP+ck5RRRLhxBc02e7I0fTm1u48qrJyKrHtqNPPA/pJzqSYiDkZtsY91hgzyQd4mUw4DXHUrur6KxeNYZrIRB2hevMIbDHwUmVa0g0g+1Oj0Kv5UWT2Zf+jIyshbEon5iEiG91DX6yMefXyiusO7nqsqw16wq7HOARBflKeQpS4mT9YqT7WfHRP1lrs9Y8Vd3aUQpCga+73NESVcqVmAJJslHHn7wGRVyp5WgcpH97pIUu4uFLxde6X2C+xSbw0Nv/Q9HJ+StFePpmYnN4b/E5iipwdfu+929uEweJTCxyX0Rh8Fkt8j0Bd012mQnCYHEWkbQX237kmK191z7Yc9+L8XmMtQapXNYc/h/fYEfO5JOxcQF1PpOVXfG5+LD+0uTHSXPd6U6KcTe5gcJhpiBSWlS9jY/4tmCEBzVPI1TtYnSFRI8nZ+u8+xgap4+jlV8TiZwNuAtvQSYspo9gvrI7nkugO9qqw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z3f1Br7YFZaULz/Fvd4peYJMazDv4efUT6VoiMMQOXsOp3QNH1FQ+o0WVLDG?=
 =?us-ascii?Q?pFaitQE3Yzf5RED+zDFoKLoCdjVkysS/tIvoDs20HeETjVGr1E6FwG2RDSBR?=
 =?us-ascii?Q?YaTP7rTnDK/lTzj/LwxyE3EHVDx8nuh/cvemvikslvOggbyadwzEu7YCbpQW?=
 =?us-ascii?Q?vOWyiBLolX9UY9RlhIBIV4bAqZLHJrkmfQKc1MxicB3c5Iew3mOCbw51oyzn?=
 =?us-ascii?Q?PyCR+NlgrWN1C6qxmVRQTEZJWc1YvgpuiJDysqYYPxlgT4+T3I8rD6SHTXHc?=
 =?us-ascii?Q?4viI/aKpOghCKPXbp6+dvvGkGFnDYTVG7JDuawUz2a+1rijZQliIs5s228yH?=
 =?us-ascii?Q?nKFRhjYPSDDIHHZTkwxf5ARizoNTgXe5ZpCngrd20wTbFHribU/qah63Qh9R?=
 =?us-ascii?Q?niNsUnwcAnmMd8HY6Zu9D287ZrNsBDdVN2LeCrQ9b4oxsnhoTxYvRCrQ4biC?=
 =?us-ascii?Q?yOLAsoeISrWK9ABI+c2VOBXpIGO4I1KBA/4KFP3Af+m7xN8rkQ1s4DDopD1q?=
 =?us-ascii?Q?wXo8knzZoOPmU2+kg1ZPRND49XEzYgCE3BLJ5uYRFv6cuGzKSwoen1fl/fuo?=
 =?us-ascii?Q?/GvBSVNPbKs9s7h4yejnPosNi40Ssw348/FRvG8ea84H4aClmAXoheyt4JS7?=
 =?us-ascii?Q?hrnnD92i+83S6mnWEp8tLzmprGVYs5/rJikOHd2owFWQKzYc4xrzr3q3ef4y?=
 =?us-ascii?Q?F7RVR99vOHIxhkx2utxeU4ZrHNYk3+OW7ysEEZqaF2x0PUxsib4lpi0eXn4k?=
 =?us-ascii?Q?xaM8/UW6YhgsTR3YWGXOC6Rz0SDRffsslSyUKTZBADDMe9BvQP7/2PW8n9jc?=
 =?us-ascii?Q?b0gAshNkk92/HMp/jrIXsDNH3Tz/GscVyOzm+jDlls0Aj1UID9e19UTpw3Ww?=
 =?us-ascii?Q?+px1EMnR0VDpiJ/MxeWzZCBpu+BITpG22l/wB7tLv/WR6hQwbiG0g/f4rUA+?=
 =?us-ascii?Q?i4FcDMHnIZKQWgGaNDmooopXh5FqxoFB4RLVChv35hmnYaKNgBkBMyklf64r?=
 =?us-ascii?Q?AdmaE1E2Yzpfcc3OZ3ldRUKmiIqFbTh8kAJ+OetOnfrZAT/bHJHC83Dr2f9W?=
 =?us-ascii?Q?mUfXdrW6yDxYGDpI7rWQs5NflWVoLgwF3B40AKeWA3E0c2+YNEc6GkLEuNL2?=
 =?us-ascii?Q?J/uSRDX84xZc6uTApek9tT73E0OJtCK50a28gT+rXI8RiGo4Aldfu0aSg1YA?=
 =?us-ascii?Q?kBi8NfqaHDD5MmLcQwleXFFVJc3FrCdK3FC0guH06xyRg+0dP8qSsGQkyw4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412acac6-e7c7-41a5-3e53-08dca19bba24
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:22:19.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

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



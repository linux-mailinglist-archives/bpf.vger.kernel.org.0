Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF716325A57
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 00:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhBYXos (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 18:44:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232791AbhBYXoc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 18:44:32 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PNYfD2027079
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:43:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xE5jfbmD7ggvOtV/7xXWeCQmjvzq79ebUAY3GevP7YY=;
 b=TvVQrF5jlR1RUpcgWlU1hQo6+ncsVcwe1zpTKKpxyqIz5v45lDcmRI+oVnIeUlxLJ4Um
 0eMUus1JqkPWHipxUuY8pLvz/DiqKSwVAszyBmPnfWQgVBwk5/rjbftrB3mkQBJJhUh+
 OL2JnCzhDI721AA3APhv/z8PbuEgeSdgazg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfk8r7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:43:52 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 15:43:51 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 38A4C62E1BF5; Thu, 25 Feb 2021 15:43:44 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v6 bpf-next 4/6] selftests/bpf: test deadlock from recursive bpf_task_storage_[get|delete]
Date:   Thu, 25 Feb 2021 15:43:17 -0800
Message-ID: <20210225234319.336131-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225234319.336131-1-songliubraving@fb.com>
References: <20210225234319.336131-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=921 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250179
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test with recursive bpf_task_storage_[get|delete] from fentry
programs on bpf_local_storage_lookup and bpf_local_storage_update. Withou=
t
proper deadlock prevent mechanism, this test would cause deadlock.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 23 ++++++
 .../selftests/bpf/progs/task_ls_recursion.c   | 70 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_recursion.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index dbb7525cdd567..035c263aab1b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -8,6 +8,7 @@
 #include <test_progs.h>
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
+#include "task_ls_recursion.skel.h"
=20
 static void test_sys_enter_exit(void)
 {
@@ -60,10 +61,32 @@ static void test_exit_creds(void)
 	task_local_storage_exit_creds__destroy(skel);
 }
=20
+static void test_recursion(void)
+{
+	struct task_ls_recursion *skel;
+	int err;
+
+	skel =3D task_ls_recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err =3D task_ls_recursion__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	/* trigger sys_enter, make sure it does not cause deadlock */
+	syscall(SYS_gettid);
+
+out:
+	task_ls_recursion__destroy(skel);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
 		test_sys_enter_exit();
 	if (test__start_subtest("exit_creds"))
 		test_exit_creds();
+	if (test__start_subtest("recursion"))
+		test_recursion();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tool=
s/testing/selftests/bpf/progs/task_ls_recursion.c
new file mode 100644
index 0000000000000..564583dca7c85
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_a SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_b SEC(".maps");
+
+SEC("fentry/bpf_local_storage_lookup")
+int BPF_PROG(on_lookup)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	bpf_task_storage_delete(&map_a, task);
+	bpf_task_storage_delete(&map_b, task);
+	return 0;
+}
+
+SEC("fentry/bpf_local_storage_update")
+int BPF_PROG(on_update)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+	long *ptr;
+
+	ptr =3D bpf_task_storage_get(&map_a, task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr +=3D 1;
+
+	ptr =3D bpf_task_storage_get(&map_b, task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr +=3D 1;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	ptr =3D bpf_task_storage_get(&map_a, task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr =3D 200;
+
+	ptr =3D bpf_task_storage_get(&map_b, task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr =3D 100;
+	return 0;
+}
--=20
2.24.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326CA32239B
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 02:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhBWBXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 20:23:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230430AbhBWBW1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 20:22:27 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11N19TbN022966
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:21:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xE5jfbmD7ggvOtV/7xXWeCQmjvzq79ebUAY3GevP7YY=;
 b=e9uF/RV3oJY7z4RbCb6z1wJwB7GnXCFZqLH9Mxa1++pKtUf04El/OovNzSPNZqYisUVQ
 S6TlGDGdcYPxgetHBDhzl3JDvA4ARKsvU0aOH07o/c++/VnRh/DJWn8vFFGPeK4FrupZ
 JUOlvOl7wqjrlo5I6OmDYg/zlF/IbulIMr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36u14q3fr1-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:21:46 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 17:21:17 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 083F662E0887; Mon, 22 Feb 2021 17:21:17 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 4/6] selftests/bpf: test deadlock from recursive bpf_task_storage_[get|delete]
Date:   Mon, 22 Feb 2021 17:20:12 -0800
Message-ID: <20210223012014.2087583-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210223012014.2087583-1-songliubraving@fb.com>
References: <20210223012014.2087583-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_08:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=917
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230006
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


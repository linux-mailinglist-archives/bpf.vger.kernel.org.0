Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38194965A2
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiAUTbd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:31:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbiAUTbc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 14:31:32 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LG5TDd016449
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:31:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gvNu4h4AYUism4y1b2swyFRPpsKI6x4aFk3+judGETQ=;
 b=QboqY2GUEdKCnn8dxpHvs4CGB1RbKLBYsUpbYHXv5nNPxnbPRavuQkQ8EVv+kjAAOVI0
 R5YuIKklFrOT+vfKre5TGqTix+a2uBAl2Yzg2o+s6n2+7Dj4PwY3sAOf3GtoG/rfBFmB
 2BUtLjhTap2ZKQLMdt55a6759egHt5li7SQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqj0gnfe9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:31:32 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 11:31:28 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 13D6395CDACD; Fri, 21 Jan 2022 11:31:22 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <phoenix1987@gmail.com>
Subject: [PATCH v6 bpf-next 3/3] selftests/bpf: Add test for sleepable bpf iterator programs
Date:   Fri, 21 Jan 2022 11:30:47 -0800
Message-ID: <20220121193047.3225019-4-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121193047.3225019-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220121193047.3225019-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GFY18_ZGyB1OaqJNHrPcAmV3ETF58bKN
X-Proofpoint-ORIG-GUID: GFY18_ZGyB1OaqJNHrPcAmV3ETF58bKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=829
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a test for bpf iterator programs to make use of sleepable
bpf helpers.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 54 +++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index b84f859b1267..5142a7d130b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -138,6 +138,24 @@ static void test_task(void)
 	bpf_iter_task__destroy(skel);
 }
=20
+static void test_task_sleepable(void)
+{
+	struct bpf_iter_task *skel;
+
+	skel =3D bpf_iter_task__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+		return;
+
+	do_dummy_read(skel->progs.dump_task_sleepable);
+
+	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
+		  "num_expected_failure_copy_from_user_task");
+	ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
+		  "num_success_copy_from_user_task");
+
+	bpf_iter_task__destroy(skel);
+}
+
 static void test_task_stack(void)
 {
 	struct bpf_iter_task_stack *skel;
@@ -1252,6 +1270,8 @@ void test_bpf_iter(void)
 		test_bpf_map();
 	if (test__start_subtest("task"))
 		test_task();
+	if (test__start_subtest("task_sleepable"))
+		test_task_sleepable();
 	if (test__start_subtest("task_stack"))
 		test_task_stack();
 	if (test__start_subtest("task_file"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_task.c
index c86b93f33b32..d22741272692 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
=20
 char _license[] SEC("license") =3D "GPL";
=20
@@ -23,3 +24,56 @@ int dump_task(struct bpf_iter__task *ctx)
 	BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
 	return 0;
 }
+
+int num_expected_failure_copy_from_user_task =3D 0;
+int num_success_copy_from_user_task =3D 0;
+
+SEC("iter.s/task")
+int dump_task_sleepable(struct bpf_iter__task *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+	static const char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
+	struct pt_regs *regs;
+	void *ptr;
+	uint32_t user_data =3D 0;
+	int ret;
+
+	if (task =3D=3D (void *)0) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Read an invalid pointer and ensure we get an error */
+	ptr =3D NULL;
+	ret =3D bpf_copy_from_user_task(&user_data, sizeof(uint32_t), ptr, task=
, 0);
+	if (ret) {
+		++num_expected_failure_copy_from_user_task;
+	} else {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Try to read the contents of the task's instruction pointer from the
+	 * remote task's address space.
+	 */
+	regs =3D (struct pt_regs *)bpf_task_pt_regs(task);
+	if (regs =3D=3D (void *)0) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+	ptr =3D (void *)PT_REGS_IP(regs);
+
+	ret =3D bpf_copy_from_user_task(&user_data, sizeof(uint32_t), ptr, task=
, 0);
+	if (ret) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+	++num_success_copy_from_user_task;
+
+	if (ctx->meta->seq_num =3D=3D 0)
+		BPF_SEQ_PRINTF(seq, "    tgid      gid     data\n");
+
+	BPF_SEQ_PRINTF(seq, "%8d %8d %8d\n", task->tgid, task->pid, user_data);
+	return 0;
+}
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62964F3FC
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLPWVY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiLPWUy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 17:20:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF137FBD
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 14:19:17 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxDUG024679
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 14:19:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=aagDdlMYu/q1w3gVsYfBvmK2+jWphuMM+tI8cMyDH8s=;
 b=dqedKwUc5xon6WCm+pzQrpZRkWyXxyYxDtMzEz0mcYjWi0qwzGI4NxJdJ0X+HlMIUhpi
 1XVCRsbdBfwmiDKEe+RDYd1vFH5Qlzh5c50bEwy7I4EGF6k5+K+IsqJukMQFvgjj5pCN
 MemU19TRM2e/08ZRCsFyOqFiavWXyqj4qOchQCzSYcko6dlzvwbMuuYWgCWk+txL7qZh
 1YtqKkzed7FcY3cuNy46oVfmDoXcDFCfAfFWgO3FSfMuBFB+ehhjXAgxjgQg2nCMKFga
 kJNTT4NmgV8J4WzPzKWzYQG7HS1ztu3odpeGSRBYAJG5M6nBV3vMv7MQg68A8zvBOwxX 3g== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgwvu1h1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 14:19:14 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 14:19:11 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 14:19:11 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 623B9B2A519; Fri, 16 Dec 2022 14:19:02 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <kernel-team@meta.com>, <song@kernel.org>, <yhs@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add a test for iter/task_vma for short-lived processes
Date:   Fri, 16 Dec 2022 14:18:55 -0800
Message-ID: <20221216221855.4122288-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216221855.4122288-1-kuifeng@meta.com>
References: <20221216221855.4122288-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FyEkxiK-kLn1fk5FNX9aNKTadB-s4I-v
X-Proofpoint-ORIG-GUID: FyEkxiK-kLn1fk5FNX9aNKTadB-s4I-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a task iterator traverses vma(s), it is possible task->mm might
become invalid in the middle of traversal and this may cause kernel
misbehave (e.g., crash)

This test case creates iterators repeatedly and forks short-lived
processes in the background to detect this bug.  The test will last
for 3 seconds to get the chance to trigger the issue.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 6f8ed61fc4b4..3af6450763e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1465,6 +1465,77 @@ static void test_task_vma_common(struct bpf_iter_a=
ttach_opts *opts)
 	bpf_iter_task_vma__destroy(skel);
 }
=20
+static void test_task_vma_dead_task(void)
+{
+	struct bpf_iter_task_vma *skel;
+	int wstatus, child_pid =3D -1;
+	time_t start_tm, cur_tm;
+	int err, iter_fd =3D -1;
+	int wait_sec =3D 3;
+
+	skel =3D bpf_iter_task_vma__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
+		return;
+
+	skel->bss->pid =3D getpid();
+
+	err =3D bpf_iter_task_vma__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
+		goto out;
+
+	skel->links.proc_maps =3D bpf_program__attach_iter(
+		skel->progs.proc_maps, NULL);
+
+	if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) =
{
+		skel->links.proc_maps =3D NULL;
+		goto out;
+	}
+
+	start_tm =3D time(NULL);
+	cur_tm =3D start_tm;
+
+	child_pid =3D fork();
+	if (child_pid =3D=3D 0) {
+		/* Fork short-lived processes in the background. */
+		while (cur_tm < start_tm + wait_sec) {
+			system("echo > /dev/null");
+			cur_tm =3D time(NULL);
+		}
+		exit(0);
+	}
+
+	if (!ASSERT_GE(child_pid, 0, "fork_child"))
+		goto out;
+
+	while (cur_tm < start_tm + wait_sec) {
+		iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.proc_maps));
+		if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+			goto out;
+
+		/* Drain all data from iter_fd. */
+		while (cur_tm < start_tm + wait_sec) {
+			err =3D read_fd_into_buffer(iter_fd, task_vma_output, CMP_BUFFER_SIZE=
);
+			if (!ASSERT_GE(err, 0, "read_iter_fd"))
+				goto out;
+
+			cur_tm =3D time(NULL);
+
+			if (err =3D=3D 0)
+				break;
+		}
+
+		close(iter_fd);
+		iter_fd =3D -1;
+	}
+
+	check_bpf_link_info(skel->progs.proc_maps);
+
+out:
+	waitpid(child_pid, &wstatus, 0);
+	close(iter_fd);
+	bpf_iter_task_vma__destroy(skel);
+}
+
 void test_bpf_sockmap_map_iter_fd(void)
 {
 	struct bpf_iter_sockmap *skel;
@@ -1586,6 +1657,8 @@ void test_bpf_iter(void)
 		test_task_file();
 	if (test__start_subtest("task_vma"))
 		test_task_vma();
+	if (test__start_subtest("task_vma_dead_task"))
+		test_task_vma_dead_task();
 	if (test__start_subtest("task_btf"))
 		test_task_btf();
 	if (test__start_subtest("tcp4"))
--=20
2.30.2


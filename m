Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEAD64E5C8
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 03:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLPB7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 20:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLPB7r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 20:59:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465522B636
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:46 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG0i8SB015068
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=OxsACo3ac+olhcG0dHXAbcHu/Qo0K4SqjG2VRFBUb4k=;
 b=HYJIp0+gSMSBMHZgcqq58jlTOVAPIIJ6clhdyZurWcOtHefv8Kna38Dghf1qHscL0jr8
 TYkJLpLRU5amg+ROBtsnFsqCSXjbPfu0eXm6WsmUAocqWE/ABTHlqsEnRDrBuPoCvU/b
 8bBVqLJoEn7b60F1zt2cJn0g7R4NoHleZooeIxCZgeX7p8MSwVYtMdN6aIXa/E1RfXZ8
 gOVxDHb+kDI73Z5oLx1BNN5+TXcDhAqRrpvF5wTvmK9JDVm60HtNjkYKqKm80IigcSca
 /YvP2oO6Gim+NLBWSwATmd2AeedUHUE8iCa7U0+XZ0v7EtLPUmYYnjKYeBbAS0Q2BDij DA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg148ewj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:45 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 17:59:45 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 2BBFFA5F282; Thu, 15 Dec 2022 17:59:37 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <kernel-team@meta.com>, <song@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: create new processes repeatedly in the background.
Date:   Thu, 15 Dec 2022 17:59:12 -0800
Message-ID: <20221216015912.991616-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216015912.991616-1-kuifeng@meta.com>
References: <20221216015912.991616-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nuVKNlMjjeGc3wTGL_cYYMFRb2GWRNR1
X-Proofpoint-GUID: nuVKNlMjjeGc3wTGL_cYYMFRb2GWRNR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

According to a report, the system may crash when a task iterator
travels vma(s).  The investigation shows it takes place if the
visiting task dies during the visit.

This test case creates iterators repeatedly and forks short-lived
processes in the background to detect this bug.  The test will last
for 3 seconds to get the chance to trigger the issue.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 6f8ed61fc4b4..df13350d615a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1465,6 +1465,83 @@ static void test_task_vma_common(struct bpf_iter_a=
ttach_opts *opts)
 	bpf_iter_task_vma__destroy(skel);
 }
=20
+static void test_task_vma_dead_task(void)
+{
+	int err, iter_fd =3D -1;
+	struct bpf_iter_task_vma *skel;
+	int wstatus, child_pid =3D -1;
+	time_t start_tm, cur_tm;
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
+	if (start_tm < 0)
+		goto out;
+	cur_tm =3D start_tm;
+
+	child_pid =3D fork();
+	if (child_pid =3D=3D 0) {
+		/* Fork short-lived processes in the background. */
+		while (cur_tm < start_tm + wait_sec) {
+			system("echo > /dev/null");
+			cur_tm =3D time(NULL);
+			if (cur_tm < 0)
+				exit(1);
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
+			if (cur_tm < 0)
+				goto out;
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
@@ -1586,6 +1663,8 @@ void test_bpf_iter(void)
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


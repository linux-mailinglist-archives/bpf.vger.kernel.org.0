Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299725540C
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 07:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgH1FiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 01:38:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgH1FiT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Aug 2020 01:38:19 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S5ZADF018717
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 22:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lWhyUqCAMrh3WNjXI8GGSxZ/gB+B24TZajA1aV3gpV8=;
 b=apEnu2a1RAWMU1/WETaeLkwtzNF0oGZBmMiZVHwwUra/LJjcHxB+U4kFe6wn8WuZQ1sp
 vqVwwD10seU9qBwHZA7TsJ5il3xgAVsexHT6RGOHkx2HgBqE+jLkFdtnBKvwj4s31IHD
 k4HZkEbSPDZylrQNdhd/47HzVCQ/spOAqF4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 335up7sd48-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 22:38:19 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 22:38:18 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 23A9C370541B; Thu, 27 Aug 2020 22:38:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test task_file iterator without visiting pthreads
Date:   Thu, 27 Aug 2020 22:38:17 -0700
Message-ID: <20200828053817.817890-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200828053815.817726-1-yhs@fb.com>
References: <20200828053815.817726-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_03:2020-08-27,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 suspectscore=8 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008280046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Modified existing bpf_iter_test_file.c program to check whether
all accessed files from the main thread or not.

Modified existing bpf_iter_test_file program to check
whether all accessed files from the main thread or not.
  $ ./test_progs -n 4
  ...
  #4/7 task_file:OK
  ...
  #4 bpf_iter:OK
  Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 21 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_task_file.c  | 10 ++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 7375d9a6d242..375ffaf85d78 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -132,17 +132,38 @@ static void test_task_stack(void)
 	bpf_iter_task_stack__destroy(skel);
 }
=20
+static void *do_nothing(void *arg)
+{
+	pthread_exit(arg);
+}
+
 static void test_task_file(void)
 {
 	struct bpf_iter_task_file *skel;
+	pthread_t thread_id;
+	void *ret;
=20
 	skel =3D bpf_iter_task_file__open_and_load();
 	if (CHECK(!skel, "bpf_iter_task_file__open_and_load",
 		  "skeleton open_and_load failed\n"))
 		return;
=20
+	skel->bss->tgid =3D getpid();
+
+	if (CHECK(pthread_create(&thread_id, NULL, &do_nothing, NULL),
+		  "pthread_create", "pthread_create failed\n"))
+		goto done;
+
 	do_dummy_read(skel->progs.dump_task_file);
=20
+	if (CHECK(pthread_join(thread_id, &ret) || ret !=3D NULL,
+		  "pthread_join", "pthread_join failed\n"))
+		goto done;
+
+	CHECK(skel->bss->count !=3D 0, "",
+	      "invalid non pthread file visit %d\n", skel->bss->count);
+
+done:
 	bpf_iter_task_file__destroy(skel);
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/too=
ls/testing/selftests/bpf/progs/bpf_iter_task_file.c
index 8b787baa2654..b2f7c7c5f952 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
@@ -6,6 +6,9 @@
=20
 char _license[] SEC("license") =3D "GPL";
=20
+int count =3D 0;
+int tgid =3D 0;
+
 SEC("iter/task_file")
 int dump_task_file(struct bpf_iter__task_file *ctx)
 {
@@ -17,8 +20,13 @@ int dump_task_file(struct bpf_iter__task_file *ctx)
 	if (task =3D=3D (void *)0 || file =3D=3D (void *)0)
 		return 0;
=20
-	if (ctx->meta->seq_num =3D=3D 0)
+	if (ctx->meta->seq_num =3D=3D 0) {
+		count =3D 0;
 		BPF_SEQ_PRINTF(seq, "    tgid      gid       fd      file\n");
+	}
+
+	if (tgid =3D=3D task->tgid && task->tgid !=3D task->pid)
+		count++;
=20
 	BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
 		       (long)file->f_op);
--=20
2.24.1


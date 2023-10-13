Return-Path: <bpf+bounces-12167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD47C8E70
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BE0B20B51
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1512B7F;
	Fri, 13 Oct 2023 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Y5FR+5va"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E897489
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 20:44:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB60BB
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:44:34 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39DGsdEW006626
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:44:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1gbIbqfez1X5ZbQpbaZtGKxHgi6jI3fOrSOwBK6unSs=;
 b=Y5FR+5vaxhVUqYt7jvneAB5yssQZUbeZ8RcQ6V7E9bsvPniYVamDHmVbjtK1+0ZjGBcU
 cyJg+S5eATeNnjbbN+EjjTxTkxa5xKkRmXNTKzrpBDhpsm20+H+Ml5Ga8Io4q1w93ajZ
 dZkFUtO+OsU7J0YyF17oHqyh4iPHKCFucsU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tq8g8347b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:44:33 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 13 Oct 2023 13:44:32 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 6934225B0E835; Fri, 13 Oct 2023 13:44:29 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v7 bpf-next 2/5] selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
Date: Fri, 13 Oct 2023 13:44:23 -0700
Message-ID: <20231013204426.1074286-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013204426.1074286-1-davemarchevsky@fb.com>
References: <20231013204426.1074286-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -kY8KD1dEQ3HHrbbJo_rme3CUE2CvK71
X-Proofpoint-ORIG-GUID: -kY8KD1dEQ3HHrbbJo_rme3CUE2CvK71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Further patches in this series will add a struct bpf_iter_task_vma,
which will result in a name collision with the selftest prog renamed in
this patch. Rename the selftest to avoid the collision.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++++++++----------
 ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
 2 files changed, 13 insertions(+), 13 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_i=
ter_task_vmas.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..41aba139b20b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -10,7 +10,7 @@
 #include "bpf_iter_task.skel.h"
 #include "bpf_iter_task_stack.skel.h"
 #include "bpf_iter_task_file.skel.h"
-#include "bpf_iter_task_vma.skel.h"
+#include "bpf_iter_task_vmas.skel.h"
 #include "bpf_iter_task_btf.skel.h"
 #include "bpf_iter_tcp4.skel.h"
 #include "bpf_iter_tcp6.skel.h"
@@ -1399,19 +1399,19 @@ static void str_strip_first_line(char *str)
 static void test_task_vma_common(struct bpf_iter_attach_opts *opts)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
-	struct bpf_iter_task_vma *skel;
+	struct bpf_iter_task_vmas *skel;
 	int len, read_size =3D 4;
 	char maps_path[64];
=20
-	skel =3D bpf_iter_task_vma__open();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
+	skel =3D bpf_iter_task_vmas__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vmas__open"))
 		return;
=20
 	skel->bss->pid =3D getpid();
 	skel->bss->one_task =3D opts ? 1 : 0;
=20
-	err =3D bpf_iter_task_vma__load(skel);
-	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
+	err =3D bpf_iter_task_vmas__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_task_vmas__load"))
 		goto out;
=20
 	skel->links.proc_maps =3D bpf_program__attach_iter(
@@ -1462,25 +1462,25 @@ static void test_task_vma_common(struct bpf_iter_=
attach_opts *opts)
 out:
 	close(proc_maps_fd);
 	close(iter_fd);
-	bpf_iter_task_vma__destroy(skel);
+	bpf_iter_task_vmas__destroy(skel);
 }
=20
 static void test_task_vma_dead_task(void)
 {
-	struct bpf_iter_task_vma *skel;
+	struct bpf_iter_task_vmas *skel;
 	int wstatus, child_pid =3D -1;
 	time_t start_tm, cur_tm;
 	int err, iter_fd =3D -1;
 	int wait_sec =3D 3;
=20
-	skel =3D bpf_iter_task_vma__open();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
+	skel =3D bpf_iter_task_vmas__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vmas__open"))
 		return;
=20
 	skel->bss->pid =3D getpid();
=20
-	err =3D bpf_iter_task_vma__load(skel);
-	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
+	err =3D bpf_iter_task_vmas__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_task_vmas__load"))
 		goto out;
=20
 	skel->links.proc_maps =3D bpf_program__attach_iter(
@@ -1533,7 +1533,7 @@ static void test_task_vma_dead_task(void)
 out:
 	waitpid(child_pid, &wstatus, 0);
 	close(iter_fd);
-	bpf_iter_task_vma__destroy(skel);
+	bpf_iter_task_vmas__destroy(skel);
 }
=20
 void test_bpf_sockmap_map_iter_fd(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tool=
s/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
rename to tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
--=20
2.34.1



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E757310106
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhBDXtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35870 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbhBDXtU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:20 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114NjwSm032498
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DlcxHxCSY+yMmXFPuzhHpZQ76SorlJCUd/oaO9ZoDb8=;
 b=QypkuC3AANYPbBb37I5tdP1xQl0eun+8Q5ANeW6hKUjP0+gYrnoJx7SOiRD65Y2QYIaX
 FRAIfpSOB/9Dvmm5f9Fs1yt9fx2+lU7cpwjv/dop4D7xATc85mxf23/Ix5gItVfp+8fa
 eSP9Ij545B+q8oGAgYG4L/i+nmanTYTqBOU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36gqfkh5me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:39 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:38 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CC5D83704E75; Thu,  4 Feb 2021 15:48:36 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 8/8] selftests/bpf: add arraymap test for bpf_for_each_map_elem() helper
Date:   Thu, 4 Feb 2021 15:48:36 -0800
Message-ID: <20210204234836.1629791-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210204234827.1628857-1-yhs@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=919 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A test is added for arraymap and percpu arraymap. The test also
exercises the early return for the helper which does not
traverse all elements.
    $ ./test_progs -n 44
    #44/1 hash_map:OK
    #44/2 array_map:OK
    #44 for_each:OK
    Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/for_each.c       | 54 ++++++++++++++
 .../bpf/progs/for_each_array_map_elem.c       | 71 +++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_=
elem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
index 7a399fbc89a4..58074212875b 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
 #include "for_each_hash_map_elem.skel.h"
+#include "for_each_array_map_elem.skel.h"
=20
 static int duration;
=20
@@ -84,8 +85,61 @@ static void test_hash_map(void)
 	for_each_hash_map_elem__destroy(skel);
 }
=20
+static void test_array_map(void)
+{
+	int i, arraymap_fd, percpu_map_fd, err;
+	struct for_each_array_map_elem *skel;
+	__u32 key, num_cpus, max_entries;
+	__u64 *percpu_valbuf =3D NULL;
+	__u64 val, expected_total;
+
+	skel =3D for_each_array_map_elem__open_and_load();
+	if (CHECK(!skel, "for_each_array_map_elem__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	arraymap_fd =3D bpf_map__fd(skel->maps.arraymap);
+	expected_total =3D 0;
+	max_entries =3D bpf_map__max_entries(skel->maps.arraymap);
+	for (i =3D 0; i < max_entries; i++) {
+		key =3D i;
+		val =3D i + 1;
+		/* skip the last iteration for expected total */
+		if (i !=3D max_entries - 1)
+			expected_total +=3D val;
+		err =3D bpf_map_update_elem(arraymap_fd, &key, &val, BPF_ANY);
+		if (CHECK(err, "map_update", "map_update failed\n"))
+			goto out;
+	}
+
+	num_cpus =3D bpf_num_possible_cpus();
+        percpu_map_fd =3D bpf_map__fd(skel->maps.percpu_map);
+        percpu_valbuf =3D malloc(sizeof(__u64) * num_cpus);
+        if (CHECK_FAIL(!percpu_valbuf))
+                goto out;
+
+	key =3D 0;
+        for (i =3D 0; i < num_cpus; i++)
+                percpu_valbuf[i] =3D i + 1;
+	err =3D bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY=
);
+	if (CHECK(err, "percpu_map_update", "map_update failed\n"))
+		goto out;
+
+	do_dummy_read(skel->progs.dump_task);
+
+	ASSERT_EQ(skel->bss->called, 1, "called");
+	ASSERT_EQ(skel->bss->arraymap_output, expected_total, "array_output");
+	ASSERT_EQ(skel->bss->cpu + 1, skel->bss->percpu_val, "percpu_val");
+
+out:
+	free(percpu_valbuf);
+	for_each_array_map_elem__destroy(skel);
+}
+
 void test_for_each(void)
 {
 	if (test__start_subtest("hash_map"))
 		test_hash_map();
+	if (test__start_subtest("array_map"))
+		test_array_map();
 }
diff --git a/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c =
b/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
new file mode 100644
index 000000000000..f1f14dcd6e68
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} arraymap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} percpu_map SEC(".maps");
+
+struct callback_ctx {
+	int output;
+};
+
+static __u64
+check_array_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		 struct callback_ctx *data)
+{
+	data->output +=3D *val;
+	if (*key =3D=3D 1)
+		return 1; /* stop the iteration */
+	return 0;
+}
+
+__u32 cpu =3D 0;
+__u64 percpu_val =3D 0;
+
+static __u64
+check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		  struct callback_ctx *data)
+{
+	cpu =3D bpf_get_smp_processor_id();
+	percpu_val =3D *val;
+	return 0;
+}
+
+u32 called =3D 0;
+u32 arraymap_output =3D 0;
+
+SEC("iter/task")
+int dump_task(struct bpf_iter__task *ctx)
+{
+	struct seq_file *seq =3D  ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+	struct callback_ctx data;
+
+	/* only call once */
+	if (called > 0)
+		return 0;
+
+	called++;
+
+	data.output =3D 0;
+	bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
+	arraymap_output =3D data.output;
+
+	bpf_for_each_map_elem(&percpu_map, check_percpu_elem, 0, 0);
+
+	return 0;
+}
--=20
2.24.1


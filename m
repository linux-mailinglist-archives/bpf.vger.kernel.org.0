Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3B310101
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBDXtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231205AbhBDXtU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:20 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114NkXtS011697
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5hSLTNVuQ9g5ABX3TYAcMxesfUMxcsxtdhLS4F53g2A=;
 b=R4DlTdrvuT1z1NbRaRdX3BDvZLS59mN01ZRCro79ygiiX7ohqZGi4wuCIxGvcCk8JdU7
 ePTh172mMZua6YNk2oPitq//MsLziEVU0TXlksTnUiKrY00vXAkdNujM/Aa9DDagaM/L
 8/RUchUg9RjirSrynFuNp0n+L87nHf2djks= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fx4nsdfj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:39 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:37 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 937283704E75; Thu,  4 Feb 2021 15:48:35 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 7/8] selftests/bpf: add hashmap test for bpf_for_each_map_elem() helper
Date:   Thu, 4 Feb 2021 15:48:35 -0800
Message-ID: <20210204234835.1629656-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210204234827.1628857-1-yhs@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=996
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A test case is added for hashmap and percpu hashmap. The test
also exercises nested bpf_for_each_map_elem() calls like
    bpf_prog:
      bpf_for_each_map_elem(func1)
    func1:
      bpf_for_each_map_elem(func2)
    func2:

  $ ./test_progs -n 44
  #44/1 hash_map:OK
  #44 for_each:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/for_each.c       |  91 ++++++++++++++++
 .../bpf/progs/for_each_hash_map_elem.c        | 103 ++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_e=
lem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
new file mode 100644
index 000000000000..7a399fbc89a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "for_each_hash_map_elem.skel.h"
+
+static int duration;
+
+static void do_dummy_read(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+	char buf[16] =3D {};
+	int iter_fd, len;
+
+	link =3D bpf_program__attach_iter(prog, NULL);
+	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
+		return;
+
+	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
+	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+		goto free_link;
+
+	/* not check contents, but ensure read() ends without error */
+	while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+}
+
+static void test_hash_map(void)
+{
+	int i, hashmap_fd, percpu_map_fd, err;
+	struct for_each_hash_map_elem *skel;
+	__u64 *percpu_valbuf =3D NULL;
+	__u32 key, num_cpus;
+	__u64 val;
+
+	skel =3D for_each_hash_map_elem__open_and_load();
+	if (CHECK(!skel, "for_each_hash_map_elem__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	hashmap_fd =3D bpf_map__fd(skel->maps.hashmap);
+	for (i =3D 0; i < bpf_map__max_entries(skel->maps.hashmap); i++) {
+		key =3D i;
+		val =3D i + 1;
+		err =3D bpf_map_update_elem(hashmap_fd, &key, &val, BPF_ANY);
+		if (CHECK(err, "map_update", "map_update failed\n"))
+			goto out;
+	}
+
+	num_cpus =3D bpf_num_possible_cpus();
+	percpu_map_fd =3D bpf_map__fd(skel->maps.percpu_map);
+	percpu_valbuf =3D malloc(sizeof(__u64) * num_cpus);
+	if (CHECK_FAIL(!percpu_valbuf))
+		goto out;
+
+	key =3D 1;
+	for (i =3D 0; i < num_cpus; i++)
+		percpu_valbuf[i] =3D i + 1;
+	err =3D bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY=
);
+	if (CHECK(err, "percpu_map_update", "map_update failed\n"))
+		goto out;
+
+	do_dummy_read(skel->progs.dump_task);
+
+	ASSERT_EQ(skel->bss->called, 1, "called");
+	ASSERT_EQ(skel->bss->hashmap_output, 4, "output_val");
+
+	key =3D 1;
+	err =3D bpf_map_lookup_elem(hashmap_fd, &key, &val);
+	ASSERT_ERR(err, "hashmap_lookup");
+
+	ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
+	CHECK_FAIL(skel->bss->cpu >=3D num_cpus);
+	ASSERT_EQ(skel->bss->percpu_key, 1, "percpu_key");
+	ASSERT_EQ(skel->bss->percpu_val, skel->bss->cpu + 1, "percpu_val");
+	ASSERT_EQ(skel->bss->percpu_output, 100, "percpu_output");
+out:
+	free(percpu_valbuf);
+	for_each_hash_map_elem__destroy(skel);
+}
+
+void test_for_each(void)
+{
+	if (test__start_subtest("hash_map"))
+		test_hash_map();
+}
diff --git a/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c b=
/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
new file mode 100644
index 000000000000..7808a5aa75e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} percpu_map SEC(".maps");
+
+struct callback_ctx {
+	struct bpf_iter__task *ctx;
+	int input;
+	int output;
+};
+
+static __u64
+check_hash_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		struct callback_ctx *data)
+{
+	struct bpf_iter__task *ctx =3D data->ctx;
+	__u32 k;
+	__u64 v;
+
+	if (ctx) {
+		k =3D *key;
+		v =3D *val;
+		if (ctx->meta->seq_num =3D=3D 10 && k =3D=3D 10 && v =3D=3D 10)
+			data->output =3D 3; /* impossible path */
+		else
+			data->output =3D 4;
+	} else {
+		data->output =3D data->input;
+		bpf_map_delete_elem(map, key);
+	}
+
+	return 0;
+}
+
+__u32 cpu =3D 0;
+__u32 percpu_called =3D 0;
+__u32 percpu_key =3D 0;
+__u64 percpu_val =3D 0;
+
+static __u64
+check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		  struct callback_ctx *data)
+{
+	percpu_called++;
+	cpu =3D bpf_get_smp_processor_id();
+	percpu_key =3D *key;
+	percpu_val =3D *val;
+
+	bpf_for_each_map_elem(&hashmap, check_hash_elem, data, 0);
+	return 0;
+}
+
+int called =3D 0;
+int hashmap_output =3D 0;
+int percpu_output =3D 0;
+
+SEC("iter/task")
+int dump_task(struct bpf_iter__task *ctx)
+{
+	struct seq_file *seq =3D  ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+	struct callback_ctx data;
+	int ret;
+
+	/* only call once since we will delete map elements */
+	if (task =3D=3D (void *)0 || called > 0)
+		return 0;
+
+	called++;
+
+	data.ctx =3D ctx;
+	data.input =3D task->tgid;
+	data.output =3D 0;
+	ret =3D bpf_for_each_map_elem(&hashmap, check_hash_elem, &data, 0);
+	if (ret)
+		return 0;
+
+	hashmap_output =3D data.output;
+
+	data.ctx =3D 0;
+	data.input =3D 100;
+	data.output =3D 0;
+	bpf_for_each_map_elem(&percpu_map, check_percpu_elem, &data, 0);
+	percpu_output =3D data.output;
+
+	return 0;
+}
--=20
2.24.1


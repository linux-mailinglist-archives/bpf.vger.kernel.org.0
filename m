Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8606A324B4F
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 08:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhBYHe1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 02:34:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35690 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234153AbhBYHeZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 02:34:25 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P7Rpws002109
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NG1GwJFT4YID5/84GSoZXqEWeKgFgO9pZHJcGqcBJI4=;
 b=eM1ZEO4clGVZlWwxEPoPXIRzpE2ca+aFk08CfvAjIHKJLGfFhVGYhFmak3Ik5ZepVmEG
 Zzlf1pFCr4oPvVbK9Sxs4QPxtnrjnEyH7PGIwW1TgAPO1vk8crWZTCCUy1QPBevruSit
 oQJaSbqS21cq0LYRxwUbqRP+xmxBojooNsw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7avuyj-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:44 -0800
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 23:33:22 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B9FCC3705D0E; Wed, 24 Feb 2021 23:33:20 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 10/11] selftests/bpf: add hashmap test for bpf_for_each_map_elem() helper
Date:   Wed, 24 Feb 2021 23:33:20 -0800
Message-ID: <20210225073320.4121679-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225073309.4119708-1-yhs@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250062
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

  $ ./test_progs -n 45
  #45/1 hash_map:OK
  #45 for_each:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/for_each.c       | 74 +++++++++++++++
 .../bpf/progs/for_each_hash_map_elem.c        | 95 +++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_e=
lem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
new file mode 100644
index 000000000000..aa0c23e83ab8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "for_each_hash_map_elem.skel.h"
+
+static unsigned int duration;
+
+static void test_hash_map(void)
+{
+	int i, err, hashmap_fd, max_entries, percpu_map_fd;
+	struct for_each_hash_map_elem *skel;
+	__u64 *percpu_valbuf =3D NULL;
+	__u32 key, num_cpus, retval;
+	__u64 val;
+
+	skel =3D for_each_hash_map_elem__open_and_load();
+	if (CHECK(!skel, "for_each_hash_map_elem__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	hashmap_fd =3D bpf_map__fd(skel->maps.hashmap);
+	max_entries =3D bpf_map__max_entries(skel->maps.hashmap);
+	for (i =3D 0; i < max_entries; i++) {
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
+	if (!ASSERT_OK_PTR(percpu_valbuf, "percpu_valbuf"))
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
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_pkt_access),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (CHECK(err || retval, "ipv4", "err %d errno %d retval %d\n",
+		  err, errno, retval))
+		goto out;
+
+	ASSERT_EQ(skel->bss->hashmap_output, 4, "hashmap_output");
+	ASSERT_EQ(skel->bss->hashmap_elems, max_entries, "hashmap_elems");
+
+	key =3D 1;
+	err =3D bpf_map_lookup_elem(hashmap_fd, &key, &val);
+	ASSERT_ERR(err, "hashmap_lookup");
+
+	ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
+	ASSERT_EQ(skel->bss->cpu < num_cpus, 1, "num_cpus");
+	ASSERT_EQ(skel->bss->percpu_map_elems, 1, "percpu_map_elems");
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
index 000000000000..e47e68d7a769
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
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
+	struct __sk_buff *ctx;
+	int input;
+	int output;
+};
+
+static __u64
+check_hash_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		struct callback_ctx *data)
+{
+	struct __sk_buff *skb =3D data->ctx;
+	__u32 k;
+	__u64 v;
+
+	if (skb) {
+		k =3D *key;
+		v =3D *val;
+		if (skb->len =3D=3D 10000 && k =3D=3D 10 && v =3D=3D 10)
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
+int percpu_output =3D 0;
+
+static __u64
+check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+		  struct callback_ctx *unused)
+{
+	struct callback_ctx data;
+
+	percpu_called++;
+	cpu =3D bpf_get_smp_processor_id();
+	percpu_key =3D *key;
+	percpu_val =3D *val;
+
+	data.ctx =3D 0;
+	data.input =3D 100;
+	data.output =3D 0;
+	bpf_for_each_map_elem(&hashmap, check_hash_elem, &data, 0);
+	percpu_output =3D data.output;
+
+	return 0;
+}
+
+int hashmap_output =3D 0;
+int hashmap_elems =3D 0;
+int percpu_map_elems =3D 0;
+
+SEC("classifier/")
+int test_pkt_access(struct __sk_buff *skb)
+{
+	struct callback_ctx data;
+
+	data.ctx =3D skb;
+	data.input =3D 10;
+	data.output =3D 0;
+	hashmap_elems =3D bpf_for_each_map_elem(&hashmap, check_hash_elem, &dat=
a, 0);
+	hashmap_output =3D data.output;
+
+	percpu_map_elems =3D bpf_for_each_map_elem(&percpu_map, check_percpu_el=
em,
+						 (void *)0, 0);
+	return 0;
+}
--=20
2.24.1


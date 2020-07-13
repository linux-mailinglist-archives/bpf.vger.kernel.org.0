Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AD21DB7F
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgGMQR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 12:17:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730235AbgGMQR6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jul 2020 12:17:58 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06DFwoc0014924
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 09:17:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Sn0Z8NMUpQBMTwQu0vS2ifMTdfEF4ZK4XQkOBhcAofo=;
 b=IH3gQ6co4p+ZAs3MV0gT+IrgD7x0VmLYzEi0QU17OKRXN/UIbeNJiCYoSSZuHhUKbe90
 5ObUZtdcZeitPXWO9YKjdCHDFp3TWHYPLnIxTlATgEpUlFX523GrJRyhiGFHWiJhsS7x
 Cz5eDNhu4IffvP9n93gilZQkNh1+H0mYCZI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 32793m0u0c-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 09:17:56 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 09:17:56 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7C7243702065; Mon, 13 Jul 2020 09:17:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 11/13] selftests/bpf: add test for bpf array map iterators
Date:   Mon, 13 Jul 2020 09:17:52 -0700
Message-ID: <20200713161752.3077790-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200713161739.3076283-1-yhs@fb.com>
References: <20200713161739.3076283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_15:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=25
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two subtests are added.
  $ ./test_progs -n 4
  ...
  #4/20 bpf_array_map:OK
  #4/21 bpf_percpu_array_map:OK
  ...

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 139 ++++++++++++++++++
 .../bpf/progs/bpf_iter_bpf_array_map.c        |  38 +++++
 .../bpf/progs/bpf_iter_bpf_percpu_array_map.c |  48 ++++++
 3 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_=
map.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu=
_array_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 0433a181c6c8..926ae5b62e3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -17,6 +17,8 @@
 #include "bpf_iter_test_kern4.skel.h"
 #include "bpf_iter_bpf_hash_map.skel.h"
 #include "bpf_iter_bpf_percpu_hash_map.skel.h"
+#include "bpf_iter_bpf_array_map.skel.h"
+#include "bpf_iter_bpf_percpu_array_map.skel.h"
=20
 static int duration;
=20
@@ -640,6 +642,139 @@ static void test_bpf_percpu_hash_map(void)
 	bpf_iter_bpf_percpu_hash_map__destroy(skel);
 }
=20
+static void test_bpf_array_map(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_array_map *skel;
+	int err, i, map_fd, iter_fd;
+	struct bpf_link *link;
+	__u32 expected_key =3D 0;
+	__u64 val, expected_val =3D 0;
+	char buf[64];
+	int len;
+
+	skel =3D bpf_iter_bpf_array_map__open_and_load();
+	if (CHECK(!skel, "bpf_iter_bpf_array_map__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	map_fd =3D bpf_map__fd(skel->maps.arraymap1);
+	for (i =3D 0; i < bpf_map__max_entries(skel->maps.arraymap1); i++) {
+		val =3D i + 4;
+		expected_key +=3D i;
+		expected_val +=3D val;
+
+		err =3D bpf_map_update_elem(map_fd, &i, &val, BPF_ANY);
+		if (CHECK(err, "map_update", "map_update failed\n"))
+			goto out;
+	}
+
+	opts.map_fd =3D map_fd;
+	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_array_map, &opts=
);
+	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
+		goto out;
+
+	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
+	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+		goto free_link;
+
+	/* do some tests */
+	while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+		goto close_iter;
+
+	/* test results */
+	if (CHECK(skel->bss->key_sum !=3D expected_key,
+		  "key_sum", "got %u expected %u\n",
+		  skel->bss->key_sum, expected_key))
+		goto close_iter;
+	if (CHECK(skel->bss->val_sum !=3D expected_val,
+		  "val_sum", "got %llu expected %llu\n",
+		  skel->bss->val_sum, expected_val))
+		goto close_iter;
+
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+out:
+	bpf_iter_bpf_array_map__destroy(skel);
+}
+
+static void test_bpf_percpu_array_map(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_percpu_array_map *skel;
+	int err, i, j, map_fd, iter_fd;
+	struct bpf_link *link;
+	__u32 expected_key =3D 0, expected_val =3D 0;
+	char buf[64];
+	void *val;
+	int len;
+
+	val =3D malloc(8 * bpf_num_possible_cpus());
+
+	skel =3D bpf_iter_bpf_percpu_array_map__open();
+	if (CHECK(!skel, "bpf_iter_bpf_percpu_array_map__open",
+		  "skeleton open failed\n"))
+		return;
+
+	skel->rodata->num_cpus =3D bpf_num_possible_cpus();
+
+	err =3D bpf_iter_bpf_percpu_array_map__load(skel);
+	if (CHECK(!skel, "bpf_iter_bpf_percpu_array_map__load",
+		  "skeleton load failed\n"))
+		goto out;
+
+	/* update map values here */
+	map_fd =3D bpf_map__fd(skel->maps.arraymap1);
+	for (i =3D 0; i < bpf_map__max_entries(skel->maps.arraymap1); i++) {
+		expected_key +=3D i;
+
+		for (j =3D 0; j < bpf_num_possible_cpus(); j++) {
+			*(__u32 *)(val + j * 8) =3D i + j;
+			expected_val +=3D i + j;
+		}
+
+		err =3D bpf_map_update_elem(map_fd, &i, val, BPF_ANY);
+		if (CHECK(err, "map_update", "map_update failed\n"))
+			goto out;
+	}
+
+	opts.map_fd =3D map_fd;
+	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_percpu_array_map=
, &opts);
+	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
+		goto out;
+
+	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
+	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+		goto free_link;
+
+	/* do some tests */
+	while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+		goto close_iter;
+
+	/* test results */
+	if (CHECK(skel->bss->key_sum !=3D expected_key,
+		  "key_sum", "got %u expected %u\n",
+		  skel->bss->key_sum, expected_key))
+		goto close_iter;
+	if (CHECK(skel->bss->val_sum !=3D expected_val,
+		  "val_sum", "got %u expected %u\n",
+		  skel->bss->val_sum, expected_val))
+		goto close_iter;
+
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+out:
+	bpf_iter_bpf_percpu_array_map__destroy(skel);
+}
+
 void test_bpf_iter(void)
 {
 	if (test__start_subtest("btf_id_or_null"))
@@ -680,4 +815,8 @@ void test_bpf_iter(void)
 		test_bpf_hash_map();
 	if (test__start_subtest("bpf_percpu_hash_map"))
 		test_bpf_percpu_hash_map();
+	if (test__start_subtest("bpf_array_map"))
+		test_bpf_array_map();
+	if (test__start_subtest("bpf_percpu_array_map"))
+		test_bpf_percpu_array_map();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c b=
/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
new file mode 100644
index 000000000000..26adc4175e96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct key_t {
+	int a;
+	int b;
+	int c;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} arraymap1 SEC(".maps");
+
+__u32 key_sum =3D 0;
+__u64 val_sum =3D 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_array_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct bpf_map *map =3D ctx->map;
+	__u32 *key =3D ctx->key;
+	__u64 *val =3D ctx->value;
+
+	if (key =3D=3D (void *)0 || val =3D=3D (void *)0)
+		return 0;
+
+	key_sum +=3D *key;
+	val_sum +=3D *val;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_=
map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
new file mode 100644
index 000000000000..598a461844ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct key_t {
+	int a;
+	int b;
+	int c;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u32);
+} arraymap1 SEC(".maps");
+
+/* will set before prog run */
+volatile const __u32 num_cpus =3D 0;
+
+__u32 key_sum =3D 0, val_sum =3D 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_percpu_array_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u32 seq_num =3D ctx->meta->seq_num;
+	struct bpf_map *map =3D ctx->map;
+	__u32 *key =3D ctx->key;
+	void *pptr =3D ctx->value;
+	__u32 step;
+	int i;
+
+	if (key =3D=3D (void *)0 || pptr =3D=3D (void *)0)
+		return 0;
+
+	key_sum +=3D *key;
+
+	step =3D 8;
+	for (i =3D 0; i < num_cpus; i++) {
+		val_sum +=3D *(__u32 *)pptr;
+		pptr +=3D step;
+	}
+	return 0;
+}
--=20
2.24.1


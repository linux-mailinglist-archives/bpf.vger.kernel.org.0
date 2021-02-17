Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8457E31DF03
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhBQSTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:19:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35964 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234246AbhBQSTE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:19:04 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11HI87gb009363
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NLQxpQzlzV5kQ6R2aeORlRlOVgo8FhH7dEQTk60pTxc=;
 b=RcMW38JIxL/CYfAPrl56R5a4pMYh3agLHw0c6URz8hadBnrM25bgZPWREcFB5LTeV8j5
 B4t+ID71rY1HesARqkGCnLnkOFxHF9K6sOVik1ZFpIk8NflRAfj0twyNQl9DNN6y7scB
 I6zCUINyVi5vqozMYWqsDzWV1JqjVhRrp5s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36rrd8de44-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:22 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 10:18:21 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 45E703704F7A; Wed, 17 Feb 2021 10:18:16 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: add arraymap test for bpf_for_each_map_elem() helper
Date:   Wed, 17 Feb 2021 10:18:16 -0800
Message-ID: <20210217181816.3192041-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210217181803.3189437-1-yhs@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102170133
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
 .../selftests/bpf/prog_tests/for_each.c       | 58 ++++++++++++++++++
 .../bpf/progs/for_each_array_map_elem.c       | 61 +++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_=
elem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
index aa0c23e83ab8..157abc721cab 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "for_each_hash_map_elem.skel.h"
+#include "for_each_array_map_elem.skel.h"
=20
 static unsigned int duration;
=20
@@ -67,8 +68,65 @@ static void test_hash_map(void)
 	for_each_hash_map_elem__destroy(skel);
 }
=20
+static void test_array_map(void)
+{
+	__u32 key, num_cpus, max_entries, retval;
+	int i, arraymap_fd, percpu_map_fd, err;
+	struct for_each_array_map_elem *skel;
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
+	percpu_map_fd =3D bpf_map__fd(skel->maps.percpu_map);
+	percpu_valbuf =3D malloc(sizeof(__u64) * num_cpus);
+	if (!ASSERT_OK_PTR(percpu_valbuf, "percpu_valbuf"))
+		goto out;
+
+	key =3D 0;
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
index 000000000000..1488bc50468f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
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
+u32 arraymap_output =3D 0;
+
+SEC("classifier/")
+int test_pkt_access(struct __sk_buff *skb)
+{
+	struct callback_ctx data;
+
+	data.output =3D 0;
+	bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
+	arraymap_output =3D data.output;
+
+	bpf_for_each_map_elem(&percpu_map, check_percpu_elem, (void *)0, 0);
+	return 0;
+}
--=20
2.24.1


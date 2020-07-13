Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504AA21DB80
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgGMQSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 12:18:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49958 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729027AbgGMQSA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jul 2020 12:18:00 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DFxx2e031280
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 09:18:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bF3EDemVYSdNnxB+5L78YmMeqdS9bJjs3UfI/mcZKnM=;
 b=Q9wxdEQfmwsca05ixEWQek6IsHqk2D+y9ehlEJqC0e8SKkKZQJGa4i2CE0ILo/juWJ2E
 8GMdpQleaP9BkYi89s/2N7PboDgUbqiO28ZPp8/pc+S8tn1OfVDUttgeTYzeE19Rh8Lu
 HEaII+WPB7bMuE9zq3qP0Mu7pM+hkNyn/Wk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 327wdrdch2-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 09:17:59 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 09:17:56 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B56B13702065; Mon, 13 Jul 2020 09:17:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 12/13] selftests/bpf: add a test for bpf sk_storage_map iterator
Date:   Mon, 13 Jul 2020 09:17:53 -0700
Message-ID: <20200713161753.3077855-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200713161739.3076283-1-yhs@fb.com>
References: <20200713161739.3076283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_15:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=25
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added one test for bpf sk_storage_map_iterator.
  $ ./test_progs -n 4
  ...
  #4/22 bpf_sk_storage_map:OK
  ...

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 72 +++++++++++++++++++
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   | 35 +++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_sto=
rage_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 926ae5b62e3a..ecee834a7f60 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -19,6 +19,7 @@
 #include "bpf_iter_bpf_percpu_hash_map.skel.h"
 #include "bpf_iter_bpf_array_map.skel.h"
 #include "bpf_iter_bpf_percpu_array_map.skel.h"
+#include "bpf_iter_bpf_sk_storage_map.skel.h"
=20
 static int duration;
=20
@@ -775,6 +776,75 @@ static void test_bpf_percpu_array_map(void)
 	bpf_iter_bpf_percpu_array_map__destroy(skel);
 }
=20
+static void test_bpf_sk_storage_map(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int err, i, len, map_fd, iter_fd, num_sockets;
+	struct bpf_iter_bpf_sk_storage_map *skel;
+	int sock_fd[3] =3D {-1, -1, -1};
+	struct bpf_link *link;
+	__u32 val, expected_val =3D 0;
+	char buf[64];
+
+	skel =3D bpf_iter_bpf_sk_storage_map__open_and_load();
+	if (CHECK(!skel, "bpf_iter_bpf_sk_storage_map__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	map_fd =3D bpf_map__fd(skel->maps.sk_stg_map);
+	num_sockets =3D ARRAY_SIZE(sock_fd);
+	for (i =3D 0; i < num_sockets; i++) {
+		sock_fd[i] =3D socket(AF_INET6, SOCK_STREAM, 0);
+		if (CHECK(sock_fd[i] < 0, "socket", "errno: %d\n", errno))
+			goto out;
+
+		val =3D i + 1;
+		expected_val +=3D val;
+
+		err =3D bpf_map_update_elem(map_fd, &sock_fd[i], &val,
+					  BPF_NOEXIST);
+		if (CHECK(err, "map_update", "map_update failed\n"))
+			goto out;
+	}
+
+	opts.map_fd =3D map_fd;
+	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_sk_storage_map, =
&opts);
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
+	if (CHECK(skel->bss->ipv6_sk_count !=3D num_sockets,
+		  "ipv6_sk_count", "got %u expected %u\n",
+		  skel->bss->ipv6_sk_count, num_sockets))
+		goto close_iter;
+
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
+	for (i =3D 0; i < num_sockets; i++) {
+		if (sock_fd[i] >=3D 0)
+			close(sock_fd[i]);
+	}
+	bpf_iter_bpf_sk_storage_map__destroy(skel);
+}
+
 void test_bpf_iter(void)
 {
 	if (test__start_subtest("btf_id_or_null"))
@@ -819,4 +889,6 @@ void test_bpf_iter(void)
 		test_bpf_array_map();
 	if (test__start_subtest("bpf_percpu_array_map"))
 		test_bpf_percpu_array_map();
+	if (test__start_subtest("bpf_sk_storage_map"))
+		test_bpf_sk_storage_map();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_ma=
p.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
new file mode 100644
index 000000000000..2f8aff5ff38c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "bpf_iter.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} sk_stg_map SEC(".maps");
+
+__u32 val_sum =3D 0;
+__u32 ipv6_sk_count =3D 0;
+
+SEC("iter/bpf_sk_storage_map")
+int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	struct sock *sk =3D ctx->sk;
+	struct bpf_map *map =3D ctx->map;
+	__u32 *val =3D ctx->value;
+
+	if (sk =3D=3D (void *)0 || val =3D=3D (void *)0)
+		return 0;
+
+	if (sk->sk_family =3D=3D AF_INET6)
+		ipv6_sk_count++;
+
+	val_sum +=3D *val;
+	return 0;
+}
--=20
2.24.1


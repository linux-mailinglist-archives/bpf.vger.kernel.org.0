Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8199B1BD0E6
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2AQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 20:16:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54286 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbgD2AQg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 20:16:36 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T0ERpj025657
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 17:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sYPi8uiXsekAR0nWWFIzcKLEspURHanOATvek3L93mI=;
 b=ORBmOFmcXKcfqk16x2XsB/MCChmGR0/LW71yeS/ClMhOTOKWdaVLlL1dpmgZxkK9M3B2
 WgsJ4Jp6a03aN4/KcuURuCBhJODAOGdngh7ZGkczKLPQ+JX1X0jWyWe/EAMDNY5tmEe1
 lVfEWczLac+Zn08IUGTKu6HFJLIzgHSLA50= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30n54ejwjt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 17:16:36 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 28 Apr 2020 17:16:33 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5F0DD2EC309B; Tue, 28 Apr 2020 17:16:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 06/10] selftests/bpf: test bpf_link's get_next_id, get_fd_by_id, and get_obj_info
Date:   Tue, 28 Apr 2020 17:16:10 -0700
Message-ID: <20200429001614.1544-7-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200429001614.1544-1-andriin@fb.com>
References: <20200429001614.1544-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_15:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 suspectscore=8 spamscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004290000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend bpf_obj_id selftest to verify bpf_link's observability APIs.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 110 ++++++++++++++++--
 .../testing/selftests/bpf/progs/test_obj_id.c |  14 +--
 2 files changed, 104 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_obj_id.c
index f10029821e16..7afa4160416f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -1,26 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
=20
+#define nr_iters 2
+
 void test_bpf_obj_id(void)
 {
 	const __u64 array_magic_value =3D 0xfaceb00c;
 	const __u32 array_key =3D 0;
-	const int nr_iters =3D 2;
 	const char *file =3D "./test_obj_id.o";
 	const char *expected_prog_name =3D "test_obj_id";
 	const char *expected_map_name =3D "test_map_id";
 	const __u64 nsec_per_sec =3D 1000000000;
=20
-	struct bpf_object *objs[nr_iters];
+	struct bpf_object *objs[nr_iters] =3D {};
+	struct bpf_link *links[nr_iters] =3D {};
+	struct bpf_program *prog;
 	int prog_fds[nr_iters], map_fds[nr_iters];
 	/* +1 to test for the info_len returned by kernel */
 	struct bpf_prog_info prog_infos[nr_iters + 1];
 	struct bpf_map_info map_infos[nr_iters + 1];
+	struct bpf_link_info link_infos[nr_iters + 1];
 	/* Each prog only uses one map. +1 to test nr_map_ids
 	 * returned by kernel.
 	 */
 	__u32 map_ids[nr_iters + 1];
-	char jited_insns[128], xlated_insns[128], zeros[128];
+	char jited_insns[128], xlated_insns[128], zeros[128], tp_name[128];
 	__u32 i, next_id, info_len, nr_id_found, duration =3D 0;
 	struct timespec real_time_ts, boot_time_ts;
 	int err =3D 0;
@@ -36,14 +40,15 @@ void test_bpf_obj_id(void)
 	CHECK(err >=3D 0 || errno !=3D ENOENT,
 	      "get-fd-by-notexist-map-id", "err %d errno %d\n", err, errno);
=20
-	for (i =3D 0; i < nr_iters; i++)
-		objs[i] =3D NULL;
+	err =3D bpf_link_get_fd_by_id(0);
+	CHECK(err >=3D 0 || errno !=3D ENOENT,
+	      "get-fd-by-notexist-link-id", "err %d errno %d\n", err, errno);
=20
 	/* Check bpf_obj_get_info_by_fd() */
 	bzero(zeros, sizeof(zeros));
 	for (i =3D 0; i < nr_iters; i++) {
 		now =3D time(NULL);
-		err =3D bpf_prog_load(file, BPF_PROG_TYPE_SOCKET_FILTER,
+		err =3D bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT,
 				    &objs[i], &prog_fds[i]);
 		/* test_obj_id.o is a dumb prog. It should never fail
 		 * to load.
@@ -60,6 +65,17 @@ void test_bpf_obj_id(void)
 		if (CHECK_FAIL(err))
 			goto done;
=20
+		prog =3D bpf_object__find_program_by_title(objs[i],
+							 "raw_tp/sys_enter");
+		if (CHECK_FAIL(!prog))
+			goto done;
+		links[i] =3D bpf_program__attach(prog);
+		err =3D libbpf_get_error(links[i]);
+		if (CHECK(err, "prog_attach", "prog #%d, err %d\n", i, err)) {
+			links[i] =3D NULL;
+			goto done;
+		}
+
 		/* Check getting map info */
 		info_len =3D sizeof(struct bpf_map_info) * 2;
 		bzero(&map_infos[i], info_len);
@@ -107,7 +123,7 @@ void test_bpf_obj_id(void)
 		load_time =3D (real_time_ts.tv_sec - boot_time_ts.tv_sec)
 			+ (prog_infos[i].load_time / nsec_per_sec);
 		if (CHECK(err ||
-			  prog_infos[i].type !=3D BPF_PROG_TYPE_SOCKET_FILTER ||
+			  prog_infos[i].type !=3D BPF_PROG_TYPE_RAW_TRACEPOINT ||
 			  info_len !=3D sizeof(struct bpf_prog_info) ||
 			  (env.jit_enabled && !prog_infos[i].jited_prog_len) ||
 			  (env.jit_enabled &&
@@ -120,7 +136,11 @@ void test_bpf_obj_id(void)
 			  *(int *)(long)prog_infos[i].map_ids !=3D map_infos[i].id ||
 			  strcmp((char *)prog_infos[i].name, expected_prog_name),
 			  "get-prog-info(fd)",
-			  "err %d errno %d i %d type %d(%d) info_len %u(%zu) jit_enabled %d j=
ited_prog_len %u xlated_prog_len %u jited_prog %d xlated_prog %d load_tim=
e %lu(%lu) uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) name %s(%s)\n",
+			  "err %d errno %d i %d type %d(%d) info_len %u(%zu) "
+			  "jit_enabled %d jited_prog_len %u xlated_prog_len %u "
+			  "jited_prog %d xlated_prog %d load_time %lu(%lu) "
+			  "uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) "
+			  "name %s(%s)\n",
 			  err, errno, i,
 			  prog_infos[i].type, BPF_PROG_TYPE_SOCKET_FILTER,
 			  info_len, sizeof(struct bpf_prog_info),
@@ -135,6 +155,33 @@ void test_bpf_obj_id(void)
 			  *(int *)(long)prog_infos[i].map_ids, map_infos[i].id,
 			  prog_infos[i].name, expected_prog_name))
 			goto done;
+
+		/* Check getting link info */
+		info_len =3D sizeof(struct bpf_link_info) * 2;
+		bzero(&link_infos[i], info_len);
+		link_infos[i].raw_tracepoint.tp_name =3D (__u64)&tp_name;
+		link_infos[i].raw_tracepoint.tp_name_len =3D sizeof(tp_name);
+		err =3D bpf_obj_get_info_by_fd(bpf_link__fd(links[i]),
+					     &link_infos[i], &info_len);
+		if (CHECK(err ||
+			  link_infos[i].type !=3D BPF_LINK_TYPE_RAW_TRACEPOINT ||
+			  link_infos[i].prog_id !=3D prog_infos[i].id ||
+			  link_infos[i].raw_tracepoint.tp_name !=3D (__u64)&tp_name ||
+			  strcmp((char *)link_infos[i].raw_tracepoint.tp_name,
+				 "sys_enter") ||
+			  info_len !=3D sizeof(struct bpf_link_info),
+			  "get-link-info(fd)",
+			  "err %d errno %d info_len %u(%zu) type %d(%d) id %d "
+			  "prog_id %d (%d) tp_name %s(%s)\n",
+			  err, errno,
+			  info_len, sizeof(struct bpf_link_info),
+			  link_infos[i].type, BPF_LINK_TYPE_RAW_TRACEPOINT,
+			  link_infos[i].id,
+			  link_infos[i].prog_id, prog_infos[i].id,
+			  (char *)link_infos[i].raw_tracepoint.tp_name,
+			  "sys_enter"))
+			goto done;
+
 	}
=20
 	/* Check bpf_prog_get_next_id() */
@@ -247,7 +294,52 @@ void test_bpf_obj_id(void)
 	      "nr_id_found %u(%u)\n",
 	      nr_id_found, nr_iters);
=20
+	/* Check bpf_link_get_next_id() */
+	nr_id_found =3D 0;
+	next_id =3D 0;
+	while (!bpf_link_get_next_id(next_id, &next_id)) {
+		struct bpf_link_info link_info;
+		int link_fd, cmp_res;
+
+		info_len =3D sizeof(link_info);
+		memset(&link_info, 0, info_len);
+
+		link_fd =3D bpf_link_get_fd_by_id(next_id);
+		if (link_fd < 0 && errno =3D=3D ENOENT)
+			/* The bpf_link is in the dead row */
+			continue;
+		if (CHECK(link_fd < 0, "get-link-fd(next_id)",
+			  "link_fd %d next_id %u errno %d\n",
+			  link_fd, next_id, errno))
+			break;
+
+		for (i =3D 0; i < nr_iters; i++)
+			if (link_infos[i].id =3D=3D next_id)
+				break;
+
+		if (i =3D=3D nr_iters)
+			continue;
+
+		nr_id_found++;
+
+		err =3D bpf_obj_get_info_by_fd(link_fd, &link_info, &info_len);
+		cmp_res =3D memcmp(&link_info, &link_infos[i],
+				offsetof(struct bpf_link_info, raw_tracepoint));
+		CHECK(err || info_len !=3D sizeof(link_info) || cmp_res,
+		      "check get-link-info(next_id->fd)",
+		      "err %d errno %d info_len %u(%zu) memcmp %d\n",
+		      err, errno, info_len, sizeof(struct bpf_link_info),
+		      cmp_res);
+
+		close(link_fd);
+	}
+	CHECK(nr_id_found !=3D nr_iters,
+	      "check total link id found by get_next_id",
+	      "nr_id_found %u(%u)\n", nr_id_found, nr_iters);
+
 done:
-	for (i =3D 0; i < nr_iters; i++)
+	for (i =3D 0; i < nr_iters; i++) {
+		bpf_link__destroy(links[i]);
 		bpf_object__close(objs[i]);
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_obj_id.c b/tools/test=
ing/selftests/bpf/progs/test_obj_id.c
index 98b9de2fafd0..ded71b3ff6b4 100644
--- a/tools/testing/selftests/bpf/progs/test_obj_id.c
+++ b/tools/testing/selftests/bpf/progs/test_obj_id.c
@@ -3,16 +3,8 @@
  */
 #include <stddef.h>
 #include <linux/bpf.h>
-#include <linux/pkt_cls.h>
 #include <bpf/bpf_helpers.h>
=20
-/* It is a dumb bpf program such that it must have no
- * issue to be loaded since testing the verifier is
- * not the focus here.
- */
-
-int _version SEC("version") =3D 1;
-
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__uint(max_entries, 1);
@@ -20,13 +12,13 @@ struct {
 	__type(value, __u64);
 } test_map_id SEC(".maps");
=20
-SEC("test_obj_id_dummy")
-int test_obj_id(struct __sk_buff *skb)
+SEC("raw_tp/sys_enter")
+int test_obj_id(void *ctx)
 {
 	__u32 key =3D 0;
 	__u64 *value;
=20
 	value =3D bpf_map_lookup_elem(&test_map_id, &key);
=20
-	return TC_ACT_OK;
+	return 0;
 }
--=20
2.24.1


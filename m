Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AE023A05D
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgHCHdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 03:33:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgHCHdi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Aug 2020 03:33:38 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0737SbrX022755
        for <bpf@vger.kernel.org>; Mon, 3 Aug 2020 00:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+fX74fn9PQCm+dAXFfaIS+q4404gwTnWWEdbVXMEW0k=;
 b=bxr6htTeoFqg31elfTmFoXZ0R+kBrsmRWUbjSlIILvbEY+NXOdFyn4kReO6CvBUYOnfx
 eCDo4ObWaDLk+VRFeOwkRaqAdwRxwvH0P5aFaTKg6OyVKgEd//h8vZMtaHEC8lACZHFi
 k0gfQtshGRCise6vqGykOeizrPisuBr3mdg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32n80t5pmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 00:33:35 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 00:33:34 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 733BE37052EE; Mon,  3 Aug 2020 00:33:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 2/2] tools/bpf: support new uapi for map element bpf iterator
Date:   Mon, 3 Aug 2020 00:33:28 -0700
Message-ID: <20200803073328.3745265-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200803073326.3745149-1-yhs@fb.com>
References: <20200803073326.3745149-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_07:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=8 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030052
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous commit adjusted kernel uapi for map
element bpf iterator. This patch adjusted libbpf API
due to uapi change. bpftool and bpf_iter selftests
are also changed accordingly.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/iter.c                      |  8 +++--
 tools/include/uapi/linux/bpf.h                | 15 ++++----
 tools/lib/bpf/bpf.c                           |  3 ++
 tools/lib/bpf/bpf.h                           |  4 ++-
 tools/lib/bpf/libbpf.c                        |  6 ++--
 tools/lib/bpf/libbpf.h                        |  4 +--
 .../selftests/bpf/prog_tests/bpf_iter.c       | 34 ++++++++++++++-----
 7 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index c9dba7543dba..6e25b4236a4f 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -11,6 +11,7 @@
 static int do_pin(int argc, char **argv)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, iter_opts);
+	union bpf_iter_link_info linfo;
 	const char *objfile, *path;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
@@ -36,6 +37,10 @@ static int do_pin(int argc, char **argv)
 			map_fd =3D map_parse_fd(&argc, &argv);
 			if (map_fd < 0)
 				return -1;
+
+			memset(&linfo, 0, sizeof(linfo));
+			linfo.map.map_fd =3D map_fd;
+			iter_opts.link_info =3D &linfo;
 		}
 	}
=20
@@ -57,9 +62,6 @@ static int do_pin(int argc, char **argv)
 		goto close_obj;
 	}
=20
-	if (map_fd >=3D 0)
-		iter_opts.map_fd =3D map_fd;
-
 	link =3D bpf_program__attach_iter(prog, &iter_opts);
 	if (IS_ERR(link)) {
 		err =3D PTR_ERR(link);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index b134e679e9db..0480f893facd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -81,6 +81,12 @@ struct bpf_cgroup_storage_key {
 	__u32	attach_type;		/* program attach type */
 };
=20
+union bpf_iter_link_info {
+	struct {
+		__u32	map_fd;
+	} map;
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -249,13 +255,6 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
=20
-enum bpf_iter_link_info {
-	BPF_ITER_LINK_UNSPEC =3D 0,
-	BPF_ITER_LINK_MAP_FD =3D 1,
-
-	MAX_BPF_ITER_LINK_INFO,
-};
-
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -623,6 +622,8 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
+		__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
+		__u32		iter_info_len;	/* iter_info length */
 	} link_create;
=20
 	struct { /* struct used by BPF_LINK_UPDATE command */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index eab14c97c15d..0750681057c2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -599,6 +599,9 @@ int bpf_link_create(int prog_fd, int target_fd,
 	attr.link_create.target_fd =3D target_fd;
 	attr.link_create.attach_type =3D attach_type;
 	attr.link_create.flags =3D OPTS_GET(opts, flags, 0);
+	attr.link_create.iter_info =3D
+		ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
+	attr.link_create.iter_info_len =3D OPTS_GET(opts, iter_info_len, 0);
=20
 	return sys_bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 28855fd5b5f4..832c7615af80 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -171,8 +171,10 @@ LIBBPF_API int bpf_prog_detach2(int prog_fd, int att=
achable_fd,
 struct bpf_link_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 flags;
+	union bpf_iter_link_info *iter_info;
+	__u32 iter_info_len;
 };
-#define bpf_link_create_opts__last_field flags
+#define bpf_link_create_opts__last_field iter_info_len
=20
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7be04e45d29c..22cc051d1b66 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8306,9 +8306,9 @@ bpf_program__attach_iter(struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_iter_attach_opts))
 		return ERR_PTR(-EINVAL);
=20
-	if (OPTS_HAS(opts, map_fd)) {
-		target_fd =3D opts->map_fd;
-		link_create_opts.flags =3D BPF_ITER_LINK_MAP_FD;
+	if (OPTS_HAS(opts, link_info)) {
+		link_create_opts.iter_info =3D opts->link_info;
+		link_create_opts.iter_info_len =3D sizeof(*opts->link_info);
 	}
=20
 	prog_fd =3D bpf_program__fd(prog);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3ed1399bfbbc..4263e2682c9d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -267,9 +267,9 @@ LIBBPF_API struct bpf_link *bpf_map__attach_struct_op=
s(struct bpf_map *map);
=20
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
-	__u32 map_fd;
+	union bpf_iter_link_info *link_info;
 };
-#define bpf_iter_attach_opts__last_field map_fd
+#define bpf_iter_attach_opts__last_field link_info
=20
 LIBBPF_API struct bpf_link *
 bpf_program__attach_iter(struct bpf_program *prog,
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 4ffefdc1130f..cabc1f90c94b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -468,6 +468,7 @@ static void test_bpf_hash_map(void)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_bpf_hash_map *skel;
 	int err, i, len, map_fd, iter_fd;
+	union bpf_iter_link_info linfo;
 	__u64 val, expected_val =3D 0;
 	struct bpf_link *link;
 	struct key_t {
@@ -490,13 +491,15 @@ static void test_bpf_hash_map(void)
 		goto out;
=20
 	/* iterator with hashmap2 and hashmap3 should fail */
-	opts.map_fd =3D bpf_map__fd(skel->maps.hashmap2);
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd =3D bpf_map__fd(skel->maps.hashmap2);
+	opts.link_info =3D &linfo;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_hash_map, &opts)=
;
 	if (CHECK(!IS_ERR(link), "attach_iter",
 		  "attach_iter for hashmap2 unexpected succeeded\n"))
 		goto out;
=20
-	opts.map_fd =3D bpf_map__fd(skel->maps.hashmap3);
+	linfo.map.map_fd =3D bpf_map__fd(skel->maps.hashmap3);
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_hash_map, &opts)=
;
 	if (CHECK(!IS_ERR(link), "attach_iter",
 		  "attach_iter for hashmap3 unexpected succeeded\n"))
@@ -519,7 +522,7 @@ static void test_bpf_hash_map(void)
 			goto out;
 	}
=20
-	opts.map_fd =3D map_fd;
+	linfo.map.map_fd =3D map_fd;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_hash_map, &opts)=
;
 	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
 		goto out;
@@ -562,6 +565,7 @@ static void test_bpf_percpu_hash_map(void)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_bpf_percpu_hash_map *skel;
 	int err, i, j, len, map_fd, iter_fd;
+	union bpf_iter_link_info linfo;
 	__u32 expected_val =3D 0;
 	struct bpf_link *link;
 	struct key_t {
@@ -606,7 +610,9 @@ static void test_bpf_percpu_hash_map(void)
 			goto out;
 	}
=20
-	opts.map_fd =3D map_fd;
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd =3D map_fd;
+	opts.link_info =3D &linfo;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_percpu_hash_map,=
 &opts);
 	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
 		goto out;
@@ -649,6 +655,7 @@ static void test_bpf_array_map(void)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	__u32 expected_key =3D 0, res_first_key;
 	struct bpf_iter_bpf_array_map *skel;
+	union bpf_iter_link_info linfo;
 	int err, i, map_fd, iter_fd;
 	struct bpf_link *link;
 	char buf[64] =3D {};
@@ -673,7 +680,9 @@ static void test_bpf_array_map(void)
 			goto out;
 	}
=20
-	opts.map_fd =3D map_fd;
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd =3D map_fd;
+	opts.link_info =3D &linfo;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_array_map, &opts=
);
 	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
 		goto out;
@@ -730,6 +739,7 @@ static void test_bpf_percpu_array_map(void)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_bpf_percpu_array_map *skel;
 	__u32 expected_key =3D 0, expected_val =3D 0;
+	union bpf_iter_link_info linfo;
 	int err, i, j, map_fd, iter_fd;
 	struct bpf_link *link;
 	char buf[64];
@@ -765,7 +775,9 @@ static void test_bpf_percpu_array_map(void)
 			goto out;
 	}
=20
-	opts.map_fd =3D map_fd;
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd =3D map_fd;
+	opts.link_info =3D &linfo;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_percpu_array_map=
, &opts);
 	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
 		goto out;
@@ -803,6 +815,7 @@ static void test_bpf_sk_storage_map(void)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	int err, i, len, map_fd, iter_fd, num_sockets;
 	struct bpf_iter_bpf_sk_storage_map *skel;
+	union bpf_iter_link_info linfo;
 	int sock_fd[3] =3D {-1, -1, -1};
 	__u32 val, expected_val =3D 0;
 	struct bpf_link *link;
@@ -829,7 +842,9 @@ static void test_bpf_sk_storage_map(void)
 			goto out;
 	}
=20
-	opts.map_fd =3D map_fd;
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd =3D map_fd;
+	opts.link_info =3D &linfo;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_sk_storage_map, =
&opts);
 	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
 		goto out;
@@ -871,6 +886,7 @@ static void test_rdonly_buf_out_of_bound(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_test_kern5 *skel;
+	union bpf_iter_link_info linfo;
 	struct bpf_link *link;
=20
 	skel =3D bpf_iter_test_kern5__open_and_load();
@@ -878,7 +894,9 @@ static void test_rdonly_buf_out_of_bound(void)
 		  "skeleton open_and_load failed\n"))
 		return;
=20
-	opts.map_fd =3D bpf_map__fd(skel->maps.hashmap1);
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd =3D bpf_map__fd(skel->maps.hashmap1);
+	opts.link_info =3D &linfo;
 	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_hash_map, &opts)=
;
 	if (CHECK(!IS_ERR(link), "attach_iter", "unexpected success\n"))
 		bpf_link__destroy(link);
--=20
2.24.1


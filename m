Return-Path: <bpf+bounces-2072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E472738B
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E942280F89
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB31DCBA;
	Wed,  7 Jun 2023 23:57:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457D3B415
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:57:10 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EC1BE2
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:57:06 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357ISSfe003862
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:57:05 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2qbsdqv1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:57:05 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:57:04 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:57:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id CD41A32857DDE; Wed,  7 Jun 2023 16:54:08 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 07/18] bpf: add BPF token support to BPF_MAP_CREATE command
Date: Wed, 7 Jun 2023 16:53:41 -0700
Message-ID: <20230607235352.1723243-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: o2XI09L21RzaLC52tR2ikzOa6uEBmr6H
X-Proofpoint-GUID: o2XI09L21RzaLC52tR2ikzOa6uEBmr6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow providing token_fd for BPF_MAP_CREATE command to allow controlled
BPF map creation from unprivileged process through delegated BPF token.

Further, add a filter of allowed BPF map types to BPF token, specified
at BPF token creation time. This, in combination with allowed_cmds
allows to create a narrowly-focused BPF token (controlled by privileged
agent) with a restrictive set of BPF maps that application can attempt
to create.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  3 +
 include/uapi/linux/bpf.h                      |  6 ++
 kernel/bpf/syscall.c                          | 69 +++++++++++++++----
 kernel/bpf/token.c                            |  8 +++
 tools/include/uapi/linux/bpf.h                | 10 ++-
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 6 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5f3944352c26..e0c7eb5b0bd7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -251,6 +251,7 @@ struct bpf_map {
 	u32 btf_value_type_id;
 	u32 btf_vmlinux_value_type_id;
 	struct btf *btf;
+	struct bpf_token *token;
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
 #endif
@@ -1538,6 +1539,7 @@ struct bpf_token {
 	struct work_struct work;
 	atomic64_t refcnt;
 	u64 allowed_cmds;
+	u64 allowed_map_types;
 };
=20
 struct bpf_struct_ops_value;
@@ -2096,6 +2098,7 @@ int bpf_token_new_fd(struct bpf_token *token);
 struct bpf_token *bpf_token_get_from_fd(u32 ufd);
=20
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type);
=20
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3e7e8d8cbe90..7ee499a440a3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -954,6 +954,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
=20
 /* Note that tracing related programs such as
@@ -1359,6 +1360,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -1641,6 +1643,10 @@ union bpf_attr {
 		 * programs
 		 */
 		__u64		allowed_cmds;
+		/* similarly to allowed_cmds, a bit set of BPF map types that
+		 * are allowed to be created by requested BPF token;
+		 */
+		__u64		allowed_map_types;
 	} token_create;
=20
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 093472ac40f7..cba7235d48da 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -691,6 +691,7 @@ static void bpf_map_free_deferred(struct work_struct =
*work)
 {
 	struct bpf_map *map =3D container_of(work, struct bpf_map, work);
 	struct btf_record *rec =3D map->record;
+	struct bpf_token *token =3D map->token;
=20
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
@@ -706,6 +707,7 @@ static void bpf_map_free_deferred(struct work_struct =
*work)
 	 * template bpf_map struct used during verification.
 	 */
 	btf_record_free(rec);
+	bpf_token_put(token);
 }
=20
 static void bpf_map_put_uref(struct bpf_map *map)
@@ -1010,7 +1012,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
=20
-		if (!bpf_capable()) {
+		if (!bpf_token_capable(map->token, CAP_BPF)) {
 			ret =3D -EPERM;
 			goto free_map_tab;
 		}
@@ -1092,11 +1094,12 @@ static int map_check_btf(struct bpf_map *map, con=
st struct btf *btf,
 	return ret;
 }
=20
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	struct bpf_token *token =3D NULL;
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	u32 map_type =3D attr->map_type;
 	struct bpf_map *map;
@@ -1147,14 +1150,32 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
=20
+	if (attr->map_token_fd) {
+		token =3D bpf_token_get_from_fd(attr->map_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+
+		/* if current token doesn't grant map creation permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
+		    !bpf_token_allow_map_type(token, attr->map_type)) {
+			bpf_token_put(token);
+			token =3D NULL;
+		}
+	}
+
+	err =3D -EPERM;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
 	 * object creation success. Even with unprivileged BPF disabled,
 	 * capability checks are still carried out.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token, CAP_B=
PF))
+		goto put_token;
=20
 	/* check privileged map type permissions */
 	switch (map_type) {
@@ -1187,28 +1208,36 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
-		if (!bpf_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_BPF))
+			goto put_token;
 		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_NET_ADMIN))
+			goto put_token;
 		break;
 	default:
 		WARN(1, "unsupported map type %d", map_type);
-		return -EPERM;
+		goto put_token;
 	}
=20
 	map =3D ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	if (IS_ERR(map)) {
+		err =3D PTR_ERR(map);
+		goto put_token;
+	}
 	map->ops =3D ops;
 	map->map_type =3D map_type;
=20
+	if (token) {
+		/* move token reference into map->token, reuse our refcnt */
+		map->token =3D token;
+		token =3D NULL;
+	}
+
 	err =3D bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
 	if (err < 0)
@@ -1281,8 +1310,11 @@ static int map_create(union bpf_attr *attr)
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
+	bpf_token_put(map->token);
 	btf_put(map->btf);
 	map->ops->map_free(map);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
=20
@@ -5086,9 +5118,11 @@ static bool is_bit_subset_of(u32 subset, u32 super=
set)
 	return (superset & subset) =3D=3D subset;
 }
=20
-#define BPF_TOKEN_CMDS_MASK ((1ULL << BPF_TOKEN_CREATE))
-
-#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_cmds
+#define BPF_TOKEN_CMDS_MASK (			\
+	(1ULL << BPF_TOKEN_CREATE)		\
+	| (1ULL << BPF_MAP_CREATE)		\
+)
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_map_types
=20
 static int token_create(union bpf_attr *attr)
 {
@@ -5124,6 +5158,12 @@ static int token_create(union bpf_attr *attr)
 		err =3D -EPERM;
 		goto err_out;
 	}
+	/* requested map types should be a subset of associated token's set */
+	if (token && !is_bit_subset_of(attr->token_create.allowed_map_types,
+				       token->allowed_map_types)) {
+		err =3D -EPERM;
+		goto err_out;
+	}
=20
 	new_token =3D bpf_token_alloc();
 	if (!new_token) {
@@ -5132,6 +5172,7 @@ static int token_create(union bpf_attr *attr)
 	}
=20
 	new_token->allowed_cmds =3D attr->token_create.allowed_cmds;
+	new_token->allowed_map_types =3D attr->token_create.allowed_map_types;
=20
 	fd =3D bpf_token_new_fd(new_token);
 	if (fd < 0) {
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 4257281ca1ec..0abb1fa4f181 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -115,3 +115,11 @@ bool bpf_token_allow_cmd(const struct bpf_token *tok=
en, enum bpf_cmd cmd)
=20
 	return token->allowed_cmds & (1ULL << cmd);
 }
+
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type)
+{
+	if (!token || type >=3D __MAX_BPF_MAP_TYPE)
+		return false;
+
+	return token->allowed_map_types & (1ULL << type);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 3e7e8d8cbe90..0722d42b55ea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -954,6 +954,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
=20
 /* Note that tracing related programs such as
@@ -1359,6 +1360,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -1638,9 +1640,15 @@ union bpf_attr {
 		/* a bit set of allowed bpf() syscall commands,
 		 * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_LOAD)
 		 * will allow creating derived BPF tokens and loading new BPF
-		 * programs
+		 * programs;
+		 * see also BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS for its effect on
+		 * validity checking of this set
 		 */
 		__u64		allowed_cmds;
+		/* similarly to allowed_cmds, a bit set of BPF map types that
+		 * are allowed to be created by requested BPF token;
+		 */
+		__u64		allowed_map_types;
 	} token_create;
=20
 } __attribute__((aligned(8)));
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/=
testing/selftests/bpf/prog_tests/libbpf_str.c
index efb8bd43653c..e677c0435cec 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -132,6 +132,9 @@ static void test_libbpf_bpf_map_type_str(void)
 		const char *map_type_str;
 		char buf[256];
=20
+		if (map_type =3D=3D __MAX_BPF_MAP_TYPE)
+			continue;
+
 		map_type_name =3D btf__str_by_offset(btf, e->name_off);
 		map_type_str =3D libbpf_bpf_map_type_str(map_type);
 		ASSERT_OK_PTR(map_type_str, map_type_name);
--=20
2.34.1



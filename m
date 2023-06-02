Return-Path: <bpf+bounces-1695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201DD720529
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE642818A3
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770319E49;
	Fri,  2 Jun 2023 15:00:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA502258F
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:00:47 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6EE6E
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:00:41 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3528jUo0021577
	for <bpf@vger.kernel.org>; Fri, 2 Jun 2023 08:00:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qyd6ptcbp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 08:00:40 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6DA0231E048C5; Fri,  2 Jun 2023 08:00:26 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 07/18] bpf: add BPF token support to BPF_MAP_CREATE command
Date: Fri, 2 Jun 2023 08:00:00 -0700
Message-ID: <20230602150011.1657856-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YiNzEmc98eSaFc9-4AhZyTOLbIpNsZxW
X-Proofpoint-ORIG-GUID: YiNzEmc98eSaFc9-4AhZyTOLbIpNsZxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow providing token_fd for BPF_MAP_CREATE command to allow controlled
BPF map creation from unprivileged process through delegated BPF token.

Further, add a filter of allowed BPF map types to BPF token, specified
at BPF token creation time. This, in combination with allowed_cmds
allows to create a narrowly-focused BPF token (controlled by privileged
agent) with a restrictive set of BPF maps that application can attempt
to create.

BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES flag allows application to express
"any supported BPF map type" without having to do an elaborate feature
detection of each supported BPF map. This is a very untrivial process,
especially as some BPF maps have special requirements just to be able to
instantiate a minimal instance (e.g., custom BTF). Allowing application
to just specify ~0 as a bit set makes writing application much simple
without degrading any of kernel's safety of backwards compatibility
concerns.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  3 +
 include/uapi/linux/bpf.h                      | 12 +++
 kernel/bpf/syscall.c                          | 82 +++++++++++++++----
 kernel/bpf/token.c                            |  8 ++
 tools/include/uapi/linux/bpf.h                | 16 +++-
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 6 files changed, 108 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fe6d51c3a5b1..657bec546351 100644
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
@@ -2092,6 +2094,7 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd);
=20
 bool bpf_token_capable(const struct bpf_token *token, int cap);
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type);
=20
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 01ab79f2ad9f..7cfaa2da84ee 100644
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
@@ -1196,6 +1197,10 @@ enum {
 	 * token-enabled.
 	 */
 	BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS		  =3D 1U << 0,
+	/* Similar to BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag, but for
+	 * token_create.allowed_map_types bit set.
+	 */
+	BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES	  =3D 1U << 1,
 };
=20
 /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
@@ -1377,6 +1382,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -1661,6 +1667,12 @@ union bpf_attr {
 		 * validity checking of this set
 		 */
 		__u64		allowed_cmds;
+		/* similarly to allowed_cmds, a bit set of BPF map types that
+		 * are allowed to be created by requested BPF token;
+		 * see also BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES for its
+		 * effect on validity checking of this set
+		 */
+		__u64		allowed_map_types;
 	} token_create;
=20
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6e7ccbd54524..eb77ba71fbcf 100644
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
@@ -5081,15 +5113,23 @@ static int bpf_prog_bind_map(union bpf_attr *attr=
)
 	return ret;
 }
=20
-#define BPF_TOKEN_FLAGS_MASK (BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS)
-#define BPF_TOKEN_CMDS_MASK ((1ULL << BPF_TOKEN_CREATE))
+#define BPF_TOKEN_FLAGS_MASK (			\
+	BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS		\
+	| BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES	\
+)
+#define BPF_TOKEN_CMDS_MASK (			\
+	(1ULL << BPF_TOKEN_CREATE)		\
+	| (1ULL << BPF_MAP_CREATE)		\
+)
+#define BPF_TOKEN_MAP_TYPES_MASK \
+	((BIT_ULL(__MAX_BPF_MAP_TYPE) - 1) & ~BIT_ULL(BPF_MAP_TYPE_UNSPEC))
=20
-#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_cmds
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_map_types
=20
 static int token_create(union bpf_attr *attr)
 {
 	struct bpf_token *new_token, *token =3D NULL;
-	u64 allowed_cmds;
+	u64 allowed_cmds, allowed_map_types;
 	int fd, err;
=20
 	if (CHECK_ATTR(BPF_TOKEN_CREATE))
@@ -5117,6 +5157,12 @@ static int token_create(union bpf_attr *attr)
 		err =3D -ENOTSUPP;
 		goto err_out;
 	}
+	allowed_map_types =3D attr->token_create.allowed_map_types;
+	if (!(attr->token_create.flags & BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES) =
&&
+	    allowed_map_types & ~BPF_TOKEN_MAP_TYPES_MASK) {
+		err =3D -ENOTSUPP;
+		goto err_out;
+	}
=20
 	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
 		err =3D -EPERM;
@@ -5128,6 +5174,11 @@ static int token_create(union bpf_attr *attr)
 		err =3D -EPERM;
 		goto err_out;
 	}
+	/* requested map types should be a subset of associated token's set */
+	if (token && (token->allowed_map_types & allowed_map_types) !=3D allowe=
d_map_types) {
+		err =3D -EPERM;
+		goto err_out;
+	}
=20
 	new_token =3D bpf_token_alloc();
 	if (!new_token) {
@@ -5136,6 +5187,7 @@ static int token_create(union bpf_attr *attr)
 	}
=20
 	new_token->allowed_cmds =3D allowed_cmds & BPF_TOKEN_CMDS_MASK;
+	new_token->allowed_map_types =3D allowed_map_types & BPF_TOKEN_MAP_TYPE=
S_MASK;
=20
 	fd =3D bpf_token_new_fd(new_token);
 	if (fd < 0) {
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 7e989b25fa06..ef053c48d7db 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -116,6 +116,14 @@ bool bpf_token_allow_cmd(const struct bpf_token *tok=
en, enum bpf_cmd cmd)
 	return token->allowed_cmds & (1ULL << cmd);
 }
=20
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type)
+{
+	if (!token || type >=3D __MAX_BPF_MAP_TYPE)
+		return false;
+
+	return token->allowed_map_types & (1ULL << type);
+}
+
 bool bpf_token_capable(const struct bpf_token *token, int cap)
 {
 	return token || capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_=
SYS_ADMIN));
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index d1d7ca71756f..7cfaa2da84ee 100644
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
@@ -1196,6 +1197,10 @@ enum {
 	 * token-enabled.
 	 */
 	BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS		  =3D 1U << 0,
+	/* Similar to BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag, but for
+	 * token_create.allowed_map_types bit set.
+	 */
+	BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES	  =3D 1U << 1,
 };
=20
 /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
@@ -1377,6 +1382,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -1656,9 +1662,17 @@ union bpf_attr {
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
+		 * see also BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES for its
+		 * effect on validity checking of this set
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



Return-Path: <bpf+bounces-12319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3FA7CB1E2
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF52818EE
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2C1347B8;
	Mon, 16 Oct 2023 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A02339AD
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 18:02:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D538106
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:02:44 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GFeFXp029300
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:02:44 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts80vs73r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:02:44 -0700
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:02:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AB72439D9C2A2; Mon, 16 Oct 2023 11:02:33 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v8 bpf-next 06/18] bpf: add BPF token support to BPF_PROG_LOAD command
Date: Mon, 16 Oct 2023 11:02:08 -0700
Message-ID: <20231016180220.3866105-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
References: <20231016180220.3866105-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BhhChu-ZGNuKYNFLeqVTZyVOnI64VFjw
X-Proofpoint-ORIG-GUID: BhhChu-ZGNuKYNFLeqVTZyVOnI64VFjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add basic support of BPF token to BPF_PROG_LOAD. Wire through a set of
allowed BPF program types and attach types, derived from BPF FS at BPF
token creation time. Then make sure we perform bpf_token_capable()
checks everywhere where it's relevant.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  6 ++
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/core.c                             |  1 +
 kernel/bpf/inode.c                            |  6 +-
 kernel/bpf/syscall.c                          | 87 ++++++++++++++-----
 kernel/bpf/token.c                            | 27 ++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 9 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ce5f6d6feb09..5971fa0a4257 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1442,6 +1442,7 @@ struct bpf_prog_aux {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+	struct bpf_token *token;
 	struct bpf_prog_offload *offload;
 	struct btf *btf;
 	struct bpf_func_info *func_info;
@@ -1582,6 +1583,8 @@ struct bpf_token {
 	struct user_namespace *userns;
 	u64 allowed_cmds;
 	u64 allowed_maps;
+	u64 allowed_progs;
+	u64 allowed_attachs;
 };
=20
 struct bpf_struct_ops_value;
@@ -2218,6 +2221,9 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd);
=20
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type);
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type);
=20
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6d35086152b..45ac44f03530 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1029,6 +1029,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
=20
 enum bpf_attach_type {
@@ -1499,6 +1500,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 08626b519ce2..fc8de25b7948 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2747,6 +2747,7 @@ void bpf_prog_free(struct bpf_prog *fp)
=20
 	if (aux->dst_prog)
 		bpf_prog_put(aux->dst_prog);
+	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
 	schedule_work(&aux->work);
 }
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index e30f0821a35e..0dfcc85593ee 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -620,12 +620,14 @@ static int bpf_show_options(struct seq_file *m, str=
uct dentry *root)
 	else if (opts->delegate_maps)
 		seq_printf(m, ",delegate_maps=3D0x%llx", opts->delegate_maps);
=20
-	if (opts->delegate_progs =3D=3D ~0ULL)
+	mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+	if ((opts->delegate_progs & mask) =3D=3D mask)
 		seq_printf(m, ",delegate_progs=3Dany");
 	else if (opts->delegate_progs)
 		seq_printf(m, ",delegate_progs=3D0x%llx", opts->delegate_progs);
=20
-	if (opts->delegate_attachs =3D=3D ~0ULL)
+	mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+	if ((opts->delegate_attachs & mask) =3D=3D mask)
 		seq_printf(m, ",delegate_attachs=3Dany");
 	else if (opts->delegate_attachs)
 		seq_printf(m, ",delegate_attachs=3D0x%llx", opts->delegate_attachs);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2c9edcbcd77..c6b00aee3b62 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2584,13 +2584,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_ty=
pe prog_type)
 }
=20
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
+#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
=20
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_size)
 {
 	enum bpf_prog_type type =3D attr->prog_type;
 	struct bpf_prog *prog, *dst_prog =3D NULL;
 	struct btf *attach_btf =3D NULL;
+	struct bpf_token *token =3D NULL;
+	bool bpf_cap;
 	int err;
 	char license[128];
=20
@@ -2606,10 +2608,31 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
=20
+	bpf_prog_load_fixup_attach_type(attr);
+
+	if (attr->prog_token_fd) {
+		token =3D bpf_token_get_from_fd(attr->prog_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		/* if current token doesn't grant prog loading permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
+		    !bpf_token_allow_prog_type(token, attr->prog_type,
+					       attr->expected_attach_type)) {
+			bpf_token_put(token);
+			token =3D NULL;
+		}
+	}
+
+	bpf_cap =3D bpf_token_capable(token, CAP_BPF);
+	err =3D -EPERM;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
=20
 	/* Intent here is for unprivileged_bpf_disabled to block BPF program
 	 * creation for unprivileged users; other actions depend
@@ -2618,21 +2641,23 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 	 * capability checks are still carried out for these
 	 * and other operations.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
+		goto put_token;
=20
 	if (attr->insn_cnt =3D=3D 0 ||
-	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_=
MAXINSNS))
-		return -E2BIG;
+	    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINS=
NS)) {
+		err =3D -E2BIG;
+		goto put_token;
+	}
 	if (type !=3D BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type !=3D BPF_PROG_TYPE_CGROUP_SKB &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
=20
-	if (is_net_admin_prog_type(type) && !bpf_net_capable())
-		return -EPERM;
-	if (is_perfmon_prog_type(type) && !perfmon_capable())
-		return -EPERM;
+	if (is_net_admin_prog_type(type) && !bpf_token_capable(token, CAP_NET_A=
DMIN))
+		goto put_token;
+	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON=
))
+		goto put_token;
=20
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
@@ -2642,27 +2667,33 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 		if (IS_ERR(dst_prog)) {
 			dst_prog =3D NULL;
 			attach_btf =3D btf_get_by_fd(attr->attach_btf_obj_fd);
-			if (IS_ERR(attach_btf))
-				return -EINVAL;
+			if (IS_ERR(attach_btf)) {
+				err =3D -EINVAL;
+				goto put_token;
+			}
 			if (!btf_is_kernel(attach_btf)) {
 				/* attaching through specifying bpf_prog's BTF
 				 * objects directly might be supported eventually
 				 */
 				btf_put(attach_btf);
-				return -ENOTSUPP;
+				err =3D -ENOTSUPP;
+				goto put_token;
 			}
 		}
 	} else if (attr->attach_btf_id) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf =3D bpf_get_btf_vmlinux();
-		if (IS_ERR(attach_btf))
-			return PTR_ERR(attach_btf);
-		if (!attach_btf)
-			return -EINVAL;
+		if (IS_ERR(attach_btf)) {
+			err =3D PTR_ERR(attach_btf);
+			goto put_token;
+		}
+		if (!attach_btf) {
+			err =3D -EINVAL;
+			goto put_token;
+		}
 		btf_get(attach_btf);
 	}
=20
-	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
 				       dst_prog)) {
@@ -2670,7 +2701,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -EINVAL;
+		err =3D -EINVAL;
+		goto put_token;
 	}
=20
 	/* plain bpf_prog allocation */
@@ -2680,7 +2712,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -ENOMEM;
+		err =3D -EINVAL;
+		goto put_token;
 	}
=20
 	prog->expected_attach_type =3D attr->expected_attach_type;
@@ -2691,6 +2724,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
 	prog->aux->sleepable =3D attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags =3D attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
=20
+	/* move token into prog->aux, reuse taken refcnt */
+	prog->aux->token =3D token;
+	token =3D NULL;
+
 	err =3D security_bpf_prog_alloc(prog->aux);
 	if (err)
 		goto free_prog;
@@ -2792,6 +2829,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
=20
@@ -3779,7 +3818,7 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type =3D=3D prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!bpf_net_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index c6eb25fcc308..35e6f55c2a41 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -77,6 +77,20 @@ static void bpf_token_show_fdinfo(struct seq_file *m, =
struct file *filp)
 		seq_printf(m, "allowed_maps:\tany\n");
 	else
 		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
+
+	BUILD_BUG_ON(__MAX_BPF_PROG_TYPE >=3D 64);
+	mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+	if ((token->allowed_progs & mask) =3D=3D mask)
+		seq_printf(m, "allowed_progs:\tany\n");
+	else
+		seq_printf(m, "allowed_progs:\t0x%llx\n", token->allowed_progs);
+
+	BUILD_BUG_ON(__MAX_BPF_ATTACH_TYPE >=3D 64);
+	mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+	if ((token->allowed_attachs & mask) =3D=3D mask)
+		seq_printf(m, "allowed_attachs:\tany\n");
+	else
+		seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowed_attachs);
 }
=20
 #define BPF_TOKEN_INODE_NAME "bpf-token"
@@ -155,6 +169,8 @@ int bpf_token_create(union bpf_attr *attr)
 	mnt_opts =3D path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds =3D mnt_opts->delegate_cmds;
 	token->allowed_maps =3D mnt_opts->delegate_maps;
+	token->allowed_progs =3D mnt_opts->delegate_progs;
+	token->allowed_attachs =3D mnt_opts->delegate_attachs;
=20
 	fd =3D get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
@@ -211,3 +227,14 @@ bool bpf_token_allow_map_type(const struct bpf_token=
 *token, enum bpf_map_type t
=20
 	return token->allowed_maps & (1ULL << type);
 }
+
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type)
+{
+	if (!token || prog_type >=3D __MAX_BPF_PROG_TYPE || attach_type >=3D __=
MAX_BPF_ATTACH_TYPE)
+		return false;
+
+	return (token->allowed_progs & (1ULL << prog_type)) &&
+	       (token->allowed_attachs & (1ULL << attach_type));
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index e6d35086152b..45ac44f03530 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1029,6 +1029,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
=20
 enum bpf_attach_type {
@@ -1499,6 +1500,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/too=
ls/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 573249a2814d..4ed46ed58a7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -30,6 +30,8 @@ void test_libbpf_probe_prog_types(void)
=20
 		if (prog_type =3D=3D BPF_PROG_TYPE_UNSPEC)
 			continue;
+		if (strcmp(prog_type_name, "__MAX_BPF_PROG_TYPE") =3D=3D 0)
+			continue;
=20
 		if (!test__start_subtest(prog_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/=
testing/selftests/bpf/prog_tests/libbpf_str.c
index 2a0633f43c73..384bc1f7a65e 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -189,6 +189,9 @@ static void test_libbpf_bpf_prog_type_str(void)
 		const char *prog_type_str;
 		char buf[256];
=20
+		if (prog_type =3D=3D __MAX_BPF_PROG_TYPE)
+			continue;
+
 		prog_type_name =3D btf__str_by_offset(btf, e->name_off);
 		prog_type_str =3D libbpf_bpf_prog_type_str(prog_type);
 		ASSERT_OK_PTR(prog_type_str, prog_type_name);
--=20
2.34.1



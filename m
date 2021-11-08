Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA96447A60
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhKHGQP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237685AbhKHGQP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:15 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A799lq2001267
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:31 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c6atd53e2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:31 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9C46984C4990; Sun,  7 Nov 2021 22:13:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 05/11] libbpf: turn btf_dedup_opts into OPTS-based struct
Date:   Sun, 7 Nov 2021 22:13:10 -0800
Message-ID: <20211108061316.203217-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: qRiA0PKc_3K-X1N1SbctzilZdUrqTGwC
X-Proofpoint-ORIG-GUID: qRiA0PKc_3K-X1N1SbctzilZdUrqTGwC
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1034
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf__dedup() and struct btf_dedup_opts were added before we figured out
OPTS mechanism. As such, btf_dedup_opts is non-extensible without
breaking an ABI and potentially crashing user application.

Unfortunately, btf__dedup() and btf_dedup_opts are short and succinct
names that would be great to preserve and use going forward. So we use
___libbpf_override() macro approach, used previously for bpf_prog_load()
API, to define a new btf__dedup() variant that accepts only struct btf *
and struct btf_dedup_opts * arguments, and rename the old btf__dedup()
implementation into btf__dedup_deprecated(). This keeps both source and
binary compatibility with old and new applications.

The biggest problem was struct btf_dedup_opts, which wasn't OPTS-based,
and as such doesn't have `size_t sz;` as a first field. But btf__dedup()
is a pretty rarely used API and I believe that the only currently known
users (besides selftests) are libbpf's own bpf_linker and pahole.
Neither use case actually uses options and just passes NULL. So instead
of doing extra hacks, just rewrite struct btf_dedup_opts into OPTS-based
one, move btf_ext argument into those opts (only bpf_linker needs to
dedup btf_ext, so it's not a typical thing to specify), and drop never
used `dont_resolve_fwds` option (it was never used anywhere, AFAIK, it
makes BTF dedup much less useful and efficient).

Just in case, for old implementation, btf__dedup_deprecated(), detect
non-NULL options and error out with helpful message, to help users
migrate, if there are any user playing with btf__dedup().

The last remaining piece is dedup_table_size, which is another
anachronism from very early days of BTF dedup. Since then it has been
reduced to the only valid value, 1, to request forced hash collisions.
This is only used during testing. So instead introduce a bool flag to
force collisions explicitly.

This patch also adapts selftests to new btf__dedup() and btf_dedup_opts
use to avoid selftests breakage.

  [0] Closes: https://github.com/libbpf/libbpf/issues/281

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c                           | 46 +++++++++++--------
 tools/lib/bpf/btf.h                           | 20 ++++++--
 tools/lib/bpf/libbpf.map                      |  2 +
 tools/lib/bpf/linker.c                        |  4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 46 +++----------------
 .../bpf/prog_tests/btf_dedup_split.c          |  6 +--
 6 files changed, 58 insertions(+), 66 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7e4c5586bd87..fcec27622e7a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2846,8 +2846,7 @@ __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext)
 
 struct btf_dedup;
 
-static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
-				       const struct btf_dedup_opts *opts);
+static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts);
 static void btf_dedup_free(struct btf_dedup *d);
 static int btf_dedup_prep(struct btf_dedup *d);
 static int btf_dedup_strings(struct btf_dedup *d);
@@ -2994,12 +2993,17 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * deduplicating structs/unions is described in greater details in comments for
  * `btf_dedup_is_equiv` function.
  */
-int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
-	       const struct btf_dedup_opts *opts)
+
+DEFAULT_VERSION(btf__dedup_v0_6_0, btf__dedup, LIBBPF_0.6.0)
+int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts)
 {
-	struct btf_dedup *d = btf_dedup_new(btf, btf_ext, opts);
+	struct btf_dedup *d;
 	int err;
 
+	if (!OPTS_VALID(opts, btf_dedup_opts))
+		return libbpf_err(-EINVAL);
+
+	d = btf_dedup_new(btf, opts);
 	if (IS_ERR(d)) {
 		pr_debug("btf_dedup_new failed: %ld", PTR_ERR(d));
 		return libbpf_err(-EINVAL);
@@ -3051,6 +3055,19 @@ int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
 	return libbpf_err(err);
 }
 
+COMPAT_VERSION(bpf__dedup_deprecated, btf__dedup, LIBBPF_0.0.2)
+int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, const void *unused_opts)
+{
+	LIBBPF_OPTS(btf_dedup_opts, opts, .btf_ext = btf_ext);
+
+	if (unused_opts) {
+		pr_warn("please use new version of btf__dedup() that supports options\n");
+		return libbpf_err(-ENOTSUP);
+	}
+
+	return btf__dedup(btf, &opts);
+}
+
 #define BTF_UNPROCESSED_ID ((__u32)-1)
 #define BTF_IN_PROGRESS_ID ((__u32)-2)
 
@@ -3163,8 +3180,7 @@ static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx)
 	return k1 == k2;
 }
 
-static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
-				       const struct btf_dedup_opts *opts)
+static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts)
 {
 	struct btf_dedup *d = calloc(1, sizeof(struct btf_dedup));
 	hashmap_hash_fn hash_fn = btf_dedup_identity_hash_fn;
@@ -3173,13 +3189,11 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 	if (!d)
 		return ERR_PTR(-ENOMEM);
 
-	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
-	/* dedup_table_size is now used only to force collisions in tests */
-	if (opts && opts->dedup_table_size == 1)
+	if (OPTS_GET(opts, force_collisions, false))
 		hash_fn = btf_dedup_collision_hash_fn;
 
 	d->btf = btf;
-	d->btf_ext = btf_ext;
+	d->btf_ext = OPTS_GET(opts, btf_ext, NULL);
 
 	d->dedup_table = hashmap__new(hash_fn, btf_dedup_equal_fn, NULL);
 	if (IS_ERR(d->dedup_table)) {
@@ -3708,8 +3722,6 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 				new_id = cand_id;
 				break;
 			}
-			if (d->opts.dont_resolve_fwds)
-				continue;
 			if (btf_compat_enum(t, cand)) {
 				if (btf_is_enum_fwd(t)) {
 					/* resolve fwd to full enum */
@@ -3952,8 +3964,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return 0;
 
 	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
-	if (!d->opts.dont_resolve_fwds
-	    && (cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
+	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
 	    && cand_kind != canon_kind) {
 		__u16 real_kind;
 		__u16 fwd_kind;
@@ -3979,10 +3990,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return btf_equal_int_tag(cand_type, canon_type);
 
 	case BTF_KIND_ENUM:
-		if (d->opts.dont_resolve_fwds)
-			return btf_equal_enum(cand_type, canon_type);
-		else
-			return btf_compat_enum(cand_type, canon_type);
+		return btf_compat_enum(cand_type, canon_type);
 
 	case BTF_KIND_FWD:
 	case BTF_KIND_FLOAT:
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index bc005ba3ceec..6aae4f62ee0b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -245,12 +245,24 @@ LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_typ
 			    int component_idx);
 
 struct btf_dedup_opts {
-	unsigned int dedup_table_size;
-	bool dont_resolve_fwds;
+	size_t sz;
+	/* optional .BTF.ext info to dedup along the main BTF info */
+	struct btf_ext *btf_ext;
+	/* force hash collisions (used for testing) */
+	bool force_collisions;
+	size_t :0;
 };
+#define btf_dedup_opts__last_field force_collisions
+
+LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
+
+LIBBPF_API int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts);
 
-LIBBPF_API int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
-			  const struct btf_dedup_opts *opts);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__dedup() instead")
+LIBBPF_API int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, const void *opts);
+#define btf__dedup(...) ___libbpf_overload(___btf_dedup, __VA_ARGS__)
+#define ___btf_dedup3(btf, btf_ext, opts) btf__dedup_deprecated(btf, btf_ext, opts)
+#define ___btf_dedup2(btf, opts) btf__dedup(btf, opts)
 
 struct btf_dump;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b895861a13c0..edc40bc16f19 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,6 +401,8 @@ LIBBPF_0.6.0 {
 		bpf_program__insns;
 		btf__add_btf;
 		btf__add_decl_tag;
+		btf__dedup;
+		btf__dedup_deprecated;
 		btf__raw_data;
 		btf__type_cnt;
 } LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f677dccdeae4..594b206fa674 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2650,6 +2650,7 @@ static int emit_elf_data_sec(struct bpf_linker *linker, const char *sec_name,
 
 static int finalize_btf(struct bpf_linker *linker)
 {
+	LIBBPF_OPTS(btf_dedup_opts, opts);
 	struct btf *btf = linker->btf;
 	const void *raw_data;
 	int i, j, id, err;
@@ -2686,7 +2687,8 @@ static int finalize_btf(struct bpf_linker *linker)
 		return err;
 	}
 
-	err = btf__dedup(linker->btf, linker->btf_ext, NULL);
+	opts.btf_ext = linker->btf_ext;
+	err = btf__dedup(linker->btf, &opts);
 	if (err) {
 		pr_warn("BTF dedup failed: %d\n", err);
 		return err;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index ebd1aa4d09d6..1e8b36d74df2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6627,7 +6627,7 @@ struct btf_dedup_test {
 	struct btf_dedup_opts opts;
 };
 
-const struct btf_dedup_test dedup_tests[] = {
+static struct btf_dedup_test dedup_tests[] = {
 
 {
 	.descr = "dedup: unused strings filtering",
@@ -6647,9 +6647,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0int\0long"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: strings deduplication",
@@ -6672,9 +6669,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0int\0long int"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: struct example #1",
@@ -6755,9 +6749,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0a\0b\0c\0d\0int\0float\0next\0s"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: struct <-> fwd resolution w/ hash collision",
@@ -6800,8 +6791,7 @@ const struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0s\0x"),
 	},
 	.opts = {
-		.dont_resolve_fwds = false,
-		.dedup_table_size = 1, /* force hash collisions */
+		.force_collisions = true, /* force hash collisions */
 	},
 },
 {
@@ -6847,8 +6837,7 @@ const struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0s\0x"),
 	},
 	.opts = {
-		.dont_resolve_fwds = false,
-		.dedup_table_size = 1, /* force hash collisions */
+		.force_collisions = true, /* force hash collisions */
 	},
 },
 {
@@ -6911,9 +6900,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: no int/float duplicates",
@@ -6965,9 +6951,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0int\0some other int\0float"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: enum fwd resolution",
@@ -7009,9 +6992,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0e1\0e1_val\0e2\0e2_val"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: datasec and vars pass-through",
@@ -7054,8 +7034,7 @@ const struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0.bss\0t"),
 	},
 	.opts = {
-		.dont_resolve_fwds = false,
-		.dedup_table_size = 1
+		.force_collisions = true
 	},
 },
 {
@@ -7099,9 +7078,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: func/func_param tags",
@@ -7152,9 +7128,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: struct/struct_member tags",
@@ -7200,9 +7173,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 {
 	.descr = "dedup: typedef tags",
@@ -7233,9 +7203,6 @@ const struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
 	},
-	.opts = {
-		.dont_resolve_fwds = false,
-	},
 },
 
 };
@@ -7293,7 +7260,7 @@ static void dump_btf_strings(const char *strs, __u32 len)
 
 static void do_test_dedup(unsigned int test_num)
 {
-	const struct btf_dedup_test *test = &dedup_tests[test_num - 1];
+	struct btf_dedup_test *test = &dedup_tests[test_num - 1];
 	__u32 test_nr_types, expect_nr_types, test_btf_size, expect_btf_size;
 	const struct btf_header *test_hdr, *expect_hdr;
 	struct btf *test_btf = NULL, *expect_btf = NULL;
@@ -7337,7 +7304,8 @@ static void do_test_dedup(unsigned int test_num)
 		goto done;
 	}
 
-	err = btf__dedup(test_btf, NULL, &test->opts);
+	test->opts.sz = sizeof(test->opts);
+	err = btf__dedup(test_btf, &test->opts);
 	if (CHECK(err, "btf_dedup failed errno:%d", err)) {
 		err = -1;
 		goto done;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 64554fd33547..9d3b8d7a1537 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -92,7 +92,7 @@ struct s2 {\n\
 	int *f3;\n\
 };\n\n", "c_dump");
 
-	err = btf__dedup(btf2, NULL, NULL);
+	err = btf__dedup(btf2, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
 		goto cleanup;
 
@@ -186,7 +186,7 @@ static void test_split_fwd_resolve() {
 		"\t'f1' type_id=7 bits_offset=0\n"
 		"\t'f2' type_id=9 bits_offset=64");
 
-	err = btf__dedup(btf2, NULL, NULL);
+	err = btf__dedup(btf2, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
 		goto cleanup;
 
@@ -283,7 +283,7 @@ static void test_split_struct_duped() {
 		"[13] STRUCT 's3' size=8 vlen=1\n"
 		"\t'f1' type_id=12 bits_offset=0");
 
-	err = btf__dedup(btf2, NULL, NULL);
+	err = btf__dedup(btf2, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
 		goto cleanup;
 
-- 
2.30.2


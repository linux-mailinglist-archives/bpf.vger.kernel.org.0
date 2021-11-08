Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86A447A61
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhKHGQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38096 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237687AbhKHGQU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:20 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A7EAeGZ031728
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:36 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c695twmrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:36 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A8AC784C499A; Sun,  7 Nov 2021 22:13:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 06/11] libbpf: ensure btf_dump__new() and btf_dump_opts are future-proof
Date:   Sun, 7 Nov 2021 22:13:11 -0800
Message-ID: <20211108061316.203217-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: NClRGfONoLKT8BcNCSFMLhaeg2_Ny6rT
X-Proofpoint-ORIG-GUID: NClRGfONoLKT8BcNCSFMLhaeg2_Ny6rT
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change btf_dump__new() and corresponding struct btf_dump_ops structure
to be extensible by using OPTS "framework" ([0]). Given we don't change
the names, we use a similar approach as with bpf_prog_load(), but this
time we ended up with two APIs with the same name and same number of
arguments, so overloading based on number of arguments with
___libbpf_override() doesn't work.

Instead, use "overloading" based on types. In this particular case,
print callback has to be specified, so we detect which argument is
a callback. If it's 4th (last) argument, old implementation of API is
used by user code. If not, it must be 2nd, and thus new implementation
is selected. The rest is handled by the same symbol versioning approach.

btf_ext argument is dropped as it was never used and isn't necessary
either. If in the future we'll need btf_ext, that will be added into
OPTS-based struct btf_dump_opts.

struct btf_dump_opts is reused for both old API and new APIs. ctx field
is marked deprecated in v0.7+ and it's put at the same memory location
as OPTS's sz field. Any user of new-style btf_dump__new() will have to
set sz field and doesn't/shouldn't use ctx, as ctx is now passed along
the callback as mandatory input argument, following the other APIs in
libbpf that accept callbacks consistently.

Again, this is quite ugly in implementation, but is done in the name of
backwards compatibility and uniform and extensible future APIs (at the
same time, sigh). And it will be gone in libbpf 1.0.

  [0] Closes: https://github.com/libbpf/libbpf/issues/283

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.h      | 52 ++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/btf_dump.c | 26 +++++++++++++-------
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 6aae4f62ee0b..a6e528faebf9 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -267,15 +267,59 @@ LIBBPF_API int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, c
 struct btf_dump;
 
 struct btf_dump_opts {
-	void *ctx;
+	union {
+		size_t sz;
+		void *ctx; /* DEPRECATED: will be gone in v1.0 */
+	};
 };
 
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
 
 LIBBPF_API struct btf_dump *btf_dump__new(const struct btf *btf,
-					  const struct btf_ext *btf_ext,
-					  const struct btf_dump_opts *opts,
-					  btf_dump_printf_fn_t printf_fn);
+					  btf_dump_printf_fn_t printf_fn,
+					  void *ctx,
+					  const struct btf_dump_opts *opts);
+
+LIBBPF_API struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
+						 btf_dump_printf_fn_t printf_fn,
+						 void *ctx,
+						 const struct btf_dump_opts *opts);
+
+LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
+						     const struct btf_ext *btf_ext,
+						     const struct btf_dump_opts *opts,
+						     btf_dump_printf_fn_t printf_fn);
+
+/* Choose either btf_dump__new() or btf_dump__new_deprecated() based on the
+ * type of 4th argument. If it's btf_dump's print callback, use deprecated
+ * API; otherwise, choose the new btf_dump__new(). ___libbpf_override()
+ * doesn't work here because both variants have 4 input arguments.
+ *
+ * (void *) casts are necessary to avoid compilation warnings about type
+ * mismatches, because even though __builtin_choose_expr() only ever evaluates
+ * one side the other side still has to satisfy type constraints (this is
+ * compiler implementation limitation which might be lifted eventually,
+ * according to the documentation). So passing struct btf_ext in place of
+ * btf_dump_printf_fn_t would be generating compilation warning.  Casting to
+ * void * avoids this issue.
+ *
+ * Also, two type compatibility checks for a function and function pointer are
+ * required because passing function reference into btf_dump__new() as
+ * btf_dump__new(..., my_callback, ...) and as btf_dump__new(...,
+ * &my_callback, ...) (not explicit ampersand in the latter case) actually
+ * differs as far as __builtin_types_compatible_p() is concerned. Thus two
+ * checks are combined to detect callback argument.
+ *
+ * The rest works just like in case of ___libbpf_override() usage with symbol
+ * versioning.
+ */
+#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(		      \
+	__builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) +      \
+	__builtin_types_compatible_p(typeof(a4),			      \
+				     void(void *, const char *, va_list)),    \
+	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),\
+	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
+
 LIBBPF_API void btf_dump__free(struct btf_dump *d);
 
 LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 17db62b5002e..0ed9c2f93322 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -77,9 +77,8 @@ struct btf_dump_data {
 
 struct btf_dump {
 	const struct btf *btf;
-	const struct btf_ext *btf_ext;
 	btf_dump_printf_fn_t printf_fn;
-	struct btf_dump_opts opts;
+	void *cb_ctx;
 	int ptr_sz;
 	bool strip_mods;
 	bool skip_anon_defs;
@@ -138,17 +137,18 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	d->printf_fn(d->opts.ctx, fmt, args);
+	d->printf_fn(d->cb_ctx, fmt, args);
 	va_end(args);
 }
 
 static int btf_dump_mark_referenced(struct btf_dump *d);
 static int btf_dump_resize(struct btf_dump *d);
 
-struct btf_dump *btf_dump__new(const struct btf *btf,
-			       const struct btf_ext *btf_ext,
-			       const struct btf_dump_opts *opts,
-			       btf_dump_printf_fn_t printf_fn)
+DEFAULT_VERSION(btf_dump__new_v0_6_0, btf_dump__new, LIBBPF_0.6.0)
+struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
+				      btf_dump_printf_fn_t printf_fn,
+				      void *ctx,
+				      const struct btf_dump_opts *opts)
 {
 	struct btf_dump *d;
 	int err;
@@ -158,9 +158,8 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 		return libbpf_err_ptr(-ENOMEM);
 
 	d->btf = btf;
-	d->btf_ext = btf_ext;
 	d->printf_fn = printf_fn;
-	d->opts.ctx = opts ? opts->ctx : NULL;
+	d->cb_ctx = ctx;
 	d->ptr_sz = btf__pointer_size(btf) ? : sizeof(void *);
 
 	d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
@@ -186,6 +185,15 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	return libbpf_err_ptr(err);
 }
 
+COMPAT_VERSION(btf_dump__new_deprecated, btf_dump__new, LIBBPF_0.0.4)
+struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
+					  const struct btf_ext *btf_ext,
+					  const struct btf_dump_opts *opts,
+					  btf_dump_printf_fn_t printf_fn)
+{
+	return btf_dump__new_v0_6_0(btf, printf_fn, opts ? opts->ctx : NULL, opts);
+}
+
 static int btf_dump_resize(struct btf_dump *d)
 {
 	int err, last_id = btf__type_cnt(d->btf) - 1;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index edc40bc16f19..c51411d46c9e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -405,4 +405,6 @@ LIBBPF_0.6.0 {
 		btf__dedup_deprecated;
 		btf__raw_data;
 		btf__type_cnt;
+		btf_dump__new;
+		btf_dump__new_deprecated;
 } LIBBPF_0.5.0;
-- 
2.30.2


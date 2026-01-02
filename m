Return-Path: <bpf+bounces-77703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7DBCEF223
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 199AC3053F98
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA63009C8;
	Fri,  2 Jan 2026 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM2FLw5N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374632C236B
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376895; cv=none; b=bD/clDOOZZJ3tYYVT/qa4/0WfKtxZ2fAy5Lo0Qtg9VK+F68mU9mAhEbDrXLXKPDr2w0rVJfrIzrGIovNEBqN28BVQGRVJRx4Hkmh9+yj9K6SvHnxYlrwQC0jO2IVoQEqSN6A2L4B9QkOClODPmK+XeogAAGt0GUNJEwIqXsgUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376895; c=relaxed/simple;
	bh=1RuIZX7gkMFbNokT1u6GcCpfD4LW85zOTk3H1MxVRnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd5rlM7jLEmk0+0b1OIhVTkB3FrfWk/s57pY6c+g7DYWcUP8xWm0b/44N662gZMpfKa0VpHb0LnVnfXeNf+6WnOIu5U4gNfJqiX0wQ9vDX7vc3haYDBX3T907LiF6XCijcMj8c+Kh4pmJ3irxpZ4GXpNIhBawj89aH7+UkdLSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM2FLw5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A1EC116B1;
	Fri,  2 Jan 2026 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376894;
	bh=1RuIZX7gkMFbNokT1u6GcCpfD4LW85zOTk3H1MxVRnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EM2FLw5NjcgITOYHNZITOyBIPNTeqE2s6v0t5Ira3PYHywwEVh9VSzeY1ybxbiHrh
	 duvHRgnvNGtHaJVPgafe0vLogSk/SLWAP/TzJIuRmCsi/MsvuRAWMlEIPNgCqB+X1H
	 iiypRVMuyYhSmQhR3QlcgoIoRnyHVqqB15vKURRIR+1TBToIEP0uyuWzU9c52koc9y
	 UpQrjjZE/q/Z46tmPSmixUD7U/QUgeBtFRA4AprlPJhnJm3r1UERFAV+gXAMjFl/6m
	 MmCVmUUz8kQvVyPNckcuHo5BersPIrc/lxJ3aakKFEOZwDSgilVXmjDBXC9fqVGrB8
	 lWvjpkN3FLQaw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/10] selftests: bpf: Fix test_bpf_nf for trusted args becoming default
Date: Fri,  2 Jan 2026 10:00:36 -0800
Message-ID: <20260102180038.2708325-11-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With trusted args now being the default, passing NULL to kfunc
parameters that are pointers causes verifier rejection rather than a
runtime error. The test_bpf_nf test was failing because it attempted to
pass NULL to bpf_xdp_ct_lookup() to verify runtime error handling.

Since the NULL check now happens at verification time, remove the
runtime test case that passed NULL to the bpf_tuple parameter and
instead add verification-time tests to ensure the verifier correctly
rejects programs that pass NULL to trusted arguments.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  5 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  7 ---
 .../selftests/bpf/progs/test_bpf_nf_fail.c    | 57 +++++++++++++++++++
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index dd6512fa652b..215878ea04de 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -19,6 +19,10 @@ struct {
 	{ "change_timeout_after_alloc", "kernel function bpf_ct_change_timeout args#0 expected pointer to STRUCT nf_conn but" },
 	{ "change_status_after_alloc", "kernel function bpf_ct_change_status args#0 expected pointer to STRUCT nf_conn but" },
 	{ "write_not_allowlisted_field", "no write support to nf_conn at off" },
+	{ "lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg1" },
+	{ "lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3" },
+	{ "xdp_lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg1" },
+	{ "xdp_lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3" },
 };
 
 enum {
@@ -111,7 +115,6 @@ static void test_bpf_nf_ct(int mode)
 	if (!ASSERT_OK(err, "bpf_prog_test_run"))
 		goto end;
 
-	ASSERT_EQ(skel->bss->test_einval_bpf_tuple, -EINVAL, "Test EINVAL for NULL bpf_tuple");
 	ASSERT_EQ(skel->bss->test_einval_reserved, -EINVAL, "Test EINVAL for reserved not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_reserved_new, -EINVAL, "Test EINVAL for reserved in new struct not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for netns_id < -1");
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index f7b330ddd007..076fbf03a126 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -15,7 +15,6 @@
 
 extern unsigned long CONFIG_HZ __kconfig;
 
-int test_einval_bpf_tuple = 0;
 int test_einval_reserved = 0;
 int test_einval_reserved_new = 0;
 int test_einval_netns_id = 0;
@@ -99,12 +98,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 
 	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
 
-	ct = lookup_fn(ctx, NULL, 0, &opts_def, sizeof(opts_def));
-	if (ct)
-		bpf_ct_release(ct);
-	else
-		test_einval_bpf_tuple = opts_def.error;
-
 	opts_def.reserved[0] = 1;
 	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
 		       sizeof(opts_def));
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
index a586f087ffeb..2c156cd166af 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 struct nf_conn;
 
@@ -18,6 +19,10 @@ struct nf_conn *bpf_skb_ct_alloc(struct __sk_buff *, struct bpf_sock_tuple *, u3
 				 struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *, struct bpf_sock_tuple *, u32,
 				  struct bpf_ct_opts___local *, u32) __ksym;
+struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
+				 struct bpf_ct_opts___local *, u32) __ksym;
+struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
+				  struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_ct_insert_entry(struct nf_conn *) __ksym;
 void bpf_ct_release(struct nf_conn *) __ksym;
 void bpf_ct_set_timeout(struct nf_conn *, u32) __ksym;
@@ -146,4 +151,56 @@ int change_status_after_alloc(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int lookup_null_bpf_tuple(struct __sk_buff *ctx)
+{
+	struct bpf_ct_opts___local opts = {};
+	struct nf_conn *ct;
+
+	ct = bpf_skb_ct_lookup(ctx, NULL, 0, &opts, sizeof(opts));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg3")
+int lookup_null_bpf_opts(struct __sk_buff *ctx)
+{
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+
+	ct = bpf_skb_ct_lookup(ctx, &tup, sizeof(tup.ipv4), NULL, sizeof(struct bpf_ct_opts___local));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?xdp")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int xdp_lookup_null_bpf_tuple(struct xdp_md *ctx)
+{
+	struct bpf_ct_opts___local opts = {};
+	struct nf_conn *ct;
+
+	ct = bpf_xdp_ct_lookup(ctx, NULL, 0, &opts, sizeof(opts));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?xdp")
+__failure __msg("Possibly NULL pointer passed to trusted arg3")
+int xdp_lookup_null_bpf_opts(struct xdp_md *ctx)
+{
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+
+	ct = bpf_xdp_ct_lookup(ctx, &tup, sizeof(tup.ipv4), NULL, sizeof(struct bpf_ct_opts___local));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3



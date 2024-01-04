Return-Path: <bpf+bounces-19076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B89B824B09
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C011F236F6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D42D050;
	Thu,  4 Jan 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmyeJwHe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB42D60C
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 22:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE670C433C8;
	Thu,  4 Jan 2024 22:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704407976;
	bh=jSnfrgwM69/2QhhDz1O5UuGERUTCuainrRYDYN0Q7no=;
	h=From:To:Cc:Subject:Date:From;
	b=XmyeJwHe3L6JrBXa0XVkQyAtZWF3D101pqt1XGHi3LAN3g99X3ZnlkgWZ6tCLQZNg
	 uaYc13kxlMXP7c0IdjDB+tR+3p3XQaJfqQgRDPw71qrINSliPJNo8mfg1en/wFqrTM
	 J5HgvnsPHdc0aGMfR/gQVNrcQIKP1ufld/qZzb9AzUZFL8Zfy+iLmQuBybLFzIx7sr
	 OwQw/My0IetHpZk1zqQan5xa7hP2Ah7jXvaVv2jCggSEoQePaE9Mvk4460OvZKHt5a
	 vdvRjK6rvTqIzKTy571ywzH2hhNLjsqzbrJQksyVgcJeVFtUjoC6k9HU9XI5yMCSiM
	 KDO2DF1TC3uew==
From: andrii@kernel.org
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: detect testing prog flags support
Date: Thu,  4 Jan 2024 14:39:32 -0800
Message-Id: <20240104223932.1971645-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

Various tests specify extra testing prog_flags when loading BPF
programs, like BPF_F_TEST_RND_HI32, and more recently also
BPF_F_TEST_REG_INVARIANTS. While BPF_F_TEST_RND_HI32 is old enough to
not cause much problem on older kernels, BPF_F_TEST_REG_INVARIANTS is
very fresh and unconditionally specifying it causes selftests to fail on
even slightly outdated kernels.

This breaks libbpf CI test against 4.9 and 5.15 kernels, it can break
some local development (done outside of VM), etc.

To prevent this, and guard against similar problems in the future, do
runtime detection of supported "testing flags", and only provide those
that host kernel recognizes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |  2 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 tools/testing/selftests/bpf/test_loader.c     |  2 +-
 tools/testing/selftests/bpf/test_sock_addr.c  |  3 +-
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/testing_helpers.c | 32 +++++++++++++++++--
 tools/testing/selftests/bpf/testing_helpers.h |  2 ++
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index e770912fc1d2..4c6ada5b270b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_type type)
 	}
 
 	bpf_program__set_type(prog, type);
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS);
+	bpf_program__set_flags(prog, testing_prog_flags());
 	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
 
 	err = bpf_object__load(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 820d0bcfc474..eb74363f9f70 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -840,7 +840,7 @@ static int load_range_cmp_prog(struct range x, struct range y, enum op op,
 		.log_level = 2,
 		.log_buf = log_buf,
 		.log_size = log_sz,
-		.prog_flags = BPF_F_TEST_REG_INVARIANTS,
+		.prog_flags = testing_prog_flags(),
 	);
 
 	/* ; skip exit block below
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 74ceb7877ae2..941778ac2691 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -181,7 +181,7 @@ static int parse_test_spec(struct test_loader *tester,
 	memset(spec, 0, sizeof(*spec));
 
 	spec->prog_name = bpf_program__name(prog);
-	spec->prog_flags = BPF_F_TEST_REG_INVARIANTS; /* by default be strict */
+	spec->prog_flags = testing_prog_flags();
 
 	btf = bpf_object__btf(obj);
 	if (!btf) {
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index b0068a9d2cfe..80c42583f597 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -19,6 +19,7 @@
 #include <bpf/libbpf.h>
 
 #include "cgroup_helpers.h"
+#include "testing_helpers.h"
 #include "bpf_util.h"
 
 #ifndef ENOTSUPP
@@ -679,7 +680,7 @@ static int load_path(const struct sock_addr_test *test, const char *path)
 
 	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
 	bpf_program__set_expected_attach_type(prog, test->expected_attach_type);
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS);
+	bpf_program__set_flags(prog, testing_prog_flags());
 
 	err = bpf_object__load(obj);
 	if (err) {
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index f36e41435be7..50fdc1100a4b 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1588,7 +1588,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (fixup_skips != skips)
 		return;
 
-	pflags = BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS;
+	pflags = testing_prog_flags();
 	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
 		pflags |= BPF_F_STRICT_ALIGNMENT;
 	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d2458c1b1671..e1f797c5c501 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -251,6 +251,34 @@ __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
 }
 
 int extra_prog_load_log_flags = 0;
+static int prog_test_flags = -1;
+
+int testing_prog_flags(void)
+{
+	static int prog_flags[] = { BPF_F_TEST_RND_HI32, BPF_F_TEST_REG_INVARIANTS };
+	static struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int insn_cnt = ARRAY_SIZE(insns), i, fd, flags = 0;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+
+	if (prog_test_flags >= 0)
+		return prog_test_flags;
+
+	for (i = 0; i < ARRAY_SIZE(prog_flags); i++) {
+		opts.prog_flags = prog_flags[i];
+		fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "flag-test", "GPL",
+				   insns, insn_cnt, &opts);
+		if (fd >= 0) {
+			flags |= prog_flags[i];
+			close(fd);
+		}
+	}
+
+	prog_test_flags = flags;
+	return prog_test_flags;
+}
 
 int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 		       struct bpf_object **pobj, int *prog_fd)
@@ -276,7 +304,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	if (type != BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) != type)
 		bpf_program__set_type(prog, type);
 
-	flags = bpf_program__flags(prog) | BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS;
+	flags = bpf_program__flags(prog) | testing_prog_flags();
 	bpf_program__set_flags(prog, flags);
 
 	err = bpf_object__load(obj);
@@ -299,7 +327,7 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.kern_version = kern_version,
-		.prog_flags = BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS,
+		.prog_flags = testing_prog_flags(),
 		.log_level = extra_prog_load_log_flags,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 35284faff4f2..1caa16f5096c 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -46,4 +46,6 @@ static inline __u64 get_time_ns(void)
 	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
 }
 
+int testing_prog_flags(void);
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.34.1



Return-Path: <bpf+bounces-63357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7FEB06665
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0921AA2518
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B092BE7B5;
	Tue, 15 Jul 2025 18:59:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23725B2E3
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605966; cv=none; b=mhBTTsJNDFRQkFM+4hdDW+aZ7QBt593xyj5gcz6vNGvzSzFKdYKNL6a5v9VbLTtfxXKr1bownDGrptgkhlGQ/VZ9T1l7bdLkNGUACrUfDPBhcSC8w5QFWGNZhC6PznjUstny3jvhUrnedpjyA6vm/owEtXaMVBLd875VTfVNqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605966; c=relaxed/simple;
	bh=nZQBLYfKDG9GsElUXPpPbD3PsvbeqN9j4WdgtnBHo5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqajP6Gi3qZNHy5Pqm8Lpm4PvusXUcxE/ArLIPjigNk4YyLoqzm8wB0fLGqXGieMrESOhSg4cYKXUyO+XZIg6mAXuh/2tZ4zsgWonxpMto4Gr39tfMZvAsnyV3VVtSma4irlBsD0yvV2pYkuihJ+iNSGgw+kwlAUgE5bF2qbI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9E3DAB958408; Tue, 15 Jul 2025 11:59:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix build error due to certain uninitialized variables
Date: Tue, 15 Jul 2025 11:59:10 -0700
Message-ID: <20250715185910.3659447-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the latest llvm21 compiler, I hit several errors when building bpf
selftests. Some of errors look like below:

  test_maps.c:565:40: error: variable 'val' is uninitialized when passed =
as a
      const pointer argument here [-Werror,-Wuninitialized-const-pointer]
    565 |         assert(bpf_map_update_elem(fd, NULL, &val, 0) < 0 &&
        |                                               ^~~

  prog_tests/bpf_iter.c:400:25: error: variable 'c' is uninitialized when=
 passed
      as a const pointer argument here [-Werror,-Wuninitialized-const-poi=
nter]
  400 |         write(finish_pipe[1], &c, 1);
      |                                ^

Some other errors have similar the pattern as the above.

These errors are fixed by initializing those variables properly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c | 2 +-
 tools/testing/selftests/bpf/test_maps.c                   | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index 67557cda2208..42b49870e520 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -13,7 +13,7 @@
 static void test_fail_cases(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
-	__u32 value;
+	__u32 value =3D 0;
 	int fd, err;
=20
 	/* Invalid key size */
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index add4a18c33bd..5225d69bf79b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -323,7 +323,7 @@ static void test_task_pidfd(void)
 static void test_task_sleepable(void)
 {
 	struct bpf_iter_tasks *skel;
-	int pid, status, err, data_pipe[2], finish_pipe[2], c;
+	int pid, status, err, data_pipe[2], finish_pipe[2], c =3D 0;
 	char *test_data =3D NULL;
 	char *test_data_long =3D NULL;
 	char *data[2];
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c397336fe1ed..b17dc39a23db 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -251,7 +251,7 @@ static void test_uretprobe_syscall_call(void)
 		.retprobe =3D true,
 	);
 	struct uprobe_syscall_executed *skel;
-	int pid, status, err, go[2], c;
+	int pid, status, err, go[2], c =3D 0;
=20
 	if (!ASSERT_OK(pipe(go), "pipe"))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/=
tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index ab0f02faa80c..4d69d9d55e17 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -268,7 +268,7 @@ static void test_verify_pkcs7_sig_from_map(void)
 	char *tmp_dir;
 	struct test_verify_pkcs7_sig *skel =3D NULL;
 	struct bpf_map *map;
-	struct data data;
+	struct data data =3D {};
 	int ret, zero =3D 0;
=20
 	/* Trigger creation of session keyring. */
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
index 986ce32b113a..3fae9ce46ca9 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -535,7 +535,7 @@ static void test_devmap_hash(unsigned int task, void =
*data)
 static void test_queuemap(unsigned int task, void *data)
 {
 	const int MAP_SIZE =3D 32;
-	__u32 vals[MAP_SIZE + MAP_SIZE/2], val;
+	__u32 vals[MAP_SIZE + MAP_SIZE/2], val =3D 0;
 	int fd, i;
=20
 	/* Fill test values to be used */
@@ -591,7 +591,7 @@ static void test_queuemap(unsigned int task, void *da=
ta)
 static void test_stackmap(unsigned int task, void *data)
 {
 	const int MAP_SIZE =3D 32;
-	__u32 vals[MAP_SIZE + MAP_SIZE/2], val;
+	__u32 vals[MAP_SIZE + MAP_SIZE/2], val =3D 0;
 	int fd, i;
=20
 	/* Fill test values to be used */
--=20
2.47.1



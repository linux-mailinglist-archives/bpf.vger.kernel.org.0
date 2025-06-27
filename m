Return-Path: <bpf+bounces-61760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7BAEBDED
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43CA1898F32
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64F2EA488;
	Fri, 27 Jun 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcovTR2Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495EEEDE
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043519; cv=none; b=f3EAgvbuadkqeRTbTnwuIVDNy1Z6GsNkkeDx0k6MyNgqV3yzDSucWRsV2tcfNyelm1IorAmIdu9xLu8uEO1AeZCuLRjvoum551ZKLQ/3a0wGuJrbISKyNDp1/2MBPqThnsbWW8HY+2IvF8YWUtMba2TJJBulUkcJmiwadUbFVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043519; c=relaxed/simple;
	bh=0iwqblCGIfFggTGGP6v4cy8UpyRfDCCIIHoTJka0QP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1Wa6uhxG3T/2QHP7YJhA4Gn4l+9eyCSAC0fjILTIR53H69z5dB/rJCkQGO5jSyLQszjRPxobICvLaFcrGs8Vh062WpZm98okiQkvqZprrpyWts/4O2aUfNk2HZwElEVnwvRxZMKhWPvIz5DsMfz3eBzHaAybL8RtwlepkwBqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcovTR2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1110BC4CEE3;
	Fri, 27 Jun 2025 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751043518;
	bh=0iwqblCGIfFggTGGP6v4cy8UpyRfDCCIIHoTJka0QP8=;
	h=From:To:Cc:Subject:Date:From;
	b=JcovTR2ZpfGHjfoxY/Np5UwLtl5S5ceCWX3Way5QzTM4KIoZDaXE05v2C608YSpp+
	 DE4FjoHcfHi6ePFQdsKxgotJkA4eVhLGEKA48eLHqplW7/uL5tqkZPy0n4inPlECdM
	 +fYp2zqVGZicQCNpb6b6Pcab2womgTde3D//hqCGBGgeR1d2T4NphcyAYL0RSuz5ln
	 EgtgKHTcuIQhH3JX7fgCxDY0he1xA5KPnpOXCcCbt9bT3nmiw7+ttrcAtCQrqX5OiH
	 ZBdF1cSnpRNJa8+hivmocmZJWqnius8ewUSxG6MQiFWfW9BUojBQI9EE+OVmIPMtSa
	 wdqPvH1AAqV5w==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr
Date: Fri, 27 Jun 2025 09:58:31 -0700
Message-ID: <20250627165831.2979022-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a netns
first. This causes issue with other tests. Fix this by using a different
hook (lsm.s/file_open) and not messing with lo.

Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_xattr")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com/
Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/cgroup_xattr.c   | 46 +++++--------------
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  4 +-
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
index 87978a0f7eb7..b32fae02b5ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
@@ -17,6 +17,7 @@
 #define CGROUP_FS_ROOT "/sys/fs/cgroup/"
 #define CGROUP_FS_PARENT CGROUP_FS_ROOT "foo/"
 #define CGROUP_FS_CHILD CGROUP_FS_PARENT "bar/"
+#define TMP_FILE "/tmp/selftests_cgroup_xattr"
 
 static int move_pid_to_cgroup(const char *cgroup_folder, pid_t pid)
 {
@@ -39,19 +40,18 @@ static int move_pid_to_cgroup(const char *cgroup_folder, pid_t pid)
 	return 0;
 }
 
-static void reset_cgroups_and_lo(void)
+static void cleanup(void)
 {
 	rmdir(CGROUP_FS_CHILD);
 	rmdir(CGROUP_FS_PARENT);
-	system("ip addr del 1.1.1.1/32 dev lo");
-	system("ip link set dev lo down");
+	unlink(TMP_FILE);
 }
 
 static const char xattr_value_a[] = "bpf_selftest_value_a";
 static const char xattr_value_b[] = "bpf_selftest_value_b";
 static const char xattr_name[] = "user.bpf_test";
 
-static int setup_cgroups_and_lo(void)
+static int setup(void)
 {
 	int err;
 
@@ -72,36 +72,19 @@ static int setup_cgroups_and_lo(void)
 	if (!ASSERT_OK(err, "setxattr 2"))
 		goto error;
 
-	err = system("ip link set dev lo up");
-	if (!ASSERT_OK(err, "lo up"))
-		goto error;
-
-	err = system("ip addr add 1.1.1.1 dev lo");
-	if (!ASSERT_OK(err, "lo addr v4"))
-		goto error;
-
-	err = write_sysctl("/proc/sys/net/ipv4/ping_group_range", "0 0");
-	if (!ASSERT_OK(err, "write_sysctl"))
-		goto error;
-
 	return 0;
 error:
-	reset_cgroups_and_lo();
+	cleanup();
 	return err;
 }
 
 static void test_read_cgroup_xattr(void)
 {
-	struct sockaddr_in sa4 = {
-		.sin_family = AF_INET,
-		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
-	};
 	struct read_cgroupfs_xattr *skel = NULL;
 	pid_t pid = gettid();
-	int sock_fd = -1;
-	int connect_fd = -1;
+	int tmp_fd;
 
-	if (!ASSERT_OK(setup_cgroups_and_lo(), "setup_cgroups_and_lo"))
+	if (!ASSERT_OK(setup(), "setup"))
 		return;
 	if (!ASSERT_OK(move_pid_to_cgroup(CGROUP_FS_CHILD, pid),
 		       "move_pid_to_cgroup"))
@@ -116,24 +99,17 @@ static void test_read_cgroup_xattr(void)
 	if (!ASSERT_OK(read_cgroupfs_xattr__attach(skel), "read_cgroupfs_xattr__attach"))
 		goto out;
 
-	sock_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
-	if (!ASSERT_OK_FD(sock_fd, "sock create"))
-		goto out;
-
-	connect_fd = connect(sock_fd, &sa4, sizeof(sa4));
-	if (!ASSERT_OK_FD(connect_fd, "connect 1"))
-		goto out;
-	close(connect_fd);
+	tmp_fd = open(TMP_FILE, O_RDONLY | O_CREAT);
+	ASSERT_OK_FD(tmp_fd, "open tmp file");
+	close(tmp_fd);
 
 	ASSERT_TRUE(skel->bss->found_value_a, "found_value_a");
 	ASSERT_TRUE(skel->bss->found_value_b, "found_value_b");
 
 out:
-	close(connect_fd);
-	close(sock_fd);
 	read_cgroupfs_xattr__destroy(skel);
 	move_pid_to_cgroup(CGROUP_FS_ROOT, pid);
-	reset_cgroups_and_lo();
+	cleanup();
 }
 
 void test_cgroup_xattr(void)
diff --git a/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
index 855f85fc5522..405adbe5e8b0 100644
--- a/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
+++ b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
@@ -17,8 +17,8 @@ static const char expected_value_b[] = "bpf_selftest_value_b";
 bool found_value_a;
 bool found_value_b;
 
-SEC("lsm.s/socket_connect")
-int BPF_PROG(test_socket_connect)
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open)
 {
 	u64 cgrp_id = bpf_get_current_cgroup_id();
 	struct cgroup_subsys_state *css, *tmp;
-- 
2.47.1



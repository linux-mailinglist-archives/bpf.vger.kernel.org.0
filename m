Return-Path: <bpf+bounces-76034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA08CA2B04
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 08:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B32630C12B5
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2930276C;
	Thu,  4 Dec 2025 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7dSRs1t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B412FFDE8
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834438; cv=none; b=aD6aHLOiYGfYX1EIhweu6g5uSfQR+0/CstVe654FdmWQinzcTcxHACJeas7D/93KPkCbeFYfeUqVov2z0KevT56Nr7NeQh2BMkUHvJkE5obkAmwwvxFM84cm2nbuoEVZzg0E0RdXTzIyiqvnhHqYK2ktzP/azhBAObVZWg5ya3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834438; c=relaxed/simple;
	bh=qdhWcqd9hT93rtUBAlBAvb3lgGVFKACqYB4PFwedTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwlaAfGTBYnLi3AMkL3qJB47RGvfUs/DmICeN28pt2MjpI6bDTLJZA/Q5FzaHFvwNaA6eR0tQxNbnGla0r8ibrQyHXaQqgVAKLkmRWgRbUvYg5pbASNbrgJIsCQtKAITFL8aZp/c6ccx2KnQ8GB8Umkq9NmNeRrz76YV1nh+V78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7dSRs1t; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso476639d50.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 23:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834435; x=1765439235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIKIbTcJdT1eJhgdOyO7DT2bXa3Lo/jwod4ftd3kt6E=;
        b=W7dSRs1teUFKL6dJVz8GhSZuMsoI1xlV46siXhpcARXWRoubEmIEXdyhg5ggSbje+b
         lzSdTrYNkFOcxDJlEGNWjyZrRaQtsM4KmdyRpOW2pheoJcCKG/A2E59biy46CULBL/tW
         tN+0+h9KuFATru5N2suLpJQsyAYeGuzRjUPoFLrvCVry0E3kMRUk4cT6AS7DpyL5CvMA
         9RtTAUXFNHJ/8/WKZeicwAVd9+I9D2PCxmqTKj1+/s2HZt8p+r+qvCySkdrH39MiCCZN
         5T0i5ybKV73D32dA0Scb3W+49EaEOW6WM43675FJR/spdtz4drDsXJPVOKK7+dFIckIK
         ktsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834435; x=1765439235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gIKIbTcJdT1eJhgdOyO7DT2bXa3Lo/jwod4ftd3kt6E=;
        b=j75aw6JOhINvLnAPpteef6coR1i9gGuYRT8/zOWqnrPXsmarlJ73lBwFqflLYQz4HT
         PSAlIq0rIVYCZ9Qa3DuoztavV/5aeqbpXswd52d8IVkIKuThkw3qbOgN3jQ+5TwrjJI+
         zonlFRPELYPqirR1w5DVIEijt+1jeZc+UQFKhaMWy24qcw9JJGhiEK8rpYC3Epa1qeID
         5O2POyuWdR7WL+iZyJOr/ZHGrQVr4E6pXXLGnh5x9rNbTMnV7PQbqjLC95+RukelPxaj
         NXVSGsIaKlIunE8OMAaL/VeXbW/BykQYLxCMj9iJOttWtHfaRWHCg2fslM3y3t+Va1gu
         7+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe7swoCxEeE65S1iJLWTAhk1B2VegI+h8xV/S5+OsrX6DGfE9luo2h97VUvR8YpSrhkho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4bUU9cZJI71FAvISsMv5NTfDGNAkmxvrZrqH/CIqHfOJQHu1
	+xSOweaqovACmixqY0lis/La++X5qZjiQyFglueoWaihzrPDArQRnN65
X-Gm-Gg: ASbGncvlMQ/fmxSp6uk2CwkNbzIsVfuo9OHHptSsNOyFrRTRgRkkCTL9uqWLNv0NptC
	cocJwnyqpR4AOjcAp8zkgZy4PkzpxGn4xEFxKq/Bi6Q9El6efsjlM2DZvz8WNBuS+TmRYWhNzl3
	A4cGyffjrftTasmigZGSOTQ+Wuhg0jGzTVPPxzIm1QuM3ScFmnaSOjyx/+J3erp0XHaTB6IcjW/
	Lu4Qlapi/QWDWWwD+QgVf3eG6FvzWdQVw0264eJvG9paspfIE9VMjE9NESQmsvqXQxb7RaSB4ci
	/VR+sYRTxYYAWvEV9eS+bUsph10l2hg1nDK0diiU11Gb1ngrtlWpkUArjOFISw7mMRFwHyCMb1f
	WAncGXsJ+Vl7eoXMQnqkFQ0xK5ZqsthNMLsPEvarf/BsmqZAk2pLTbJB7nu+zshL+ssykzXVwcB
	x/KCZ+5Gc8qG80j0bOPDyrNyXDyzS5BYUJ7Rbx85CJf/Fj9/DDCOs=
X-Google-Smtp-Source: AGHT+IFirMTbIE/Mz7SxmZusKuVHpn4JgrMCYE3NcUS/x+ulC6+n3iKo4YojdR5CaekHTbK8K19xlQ==
X-Received: by 2002:a05:690e:16a0:b0:641:f5bc:68d5 with SMTP id 956f58d0204a3-6443d961614mr1540601d50.82.1764834435301;
        Wed, 03 Dec 2025 23:47:15 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.47.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:47:15 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Thu,  4 Dec 2025 15:46:32 +0800
Message-ID: <20251204074632.8562-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-1-electronlsr@gmail.com>
References: <20251204074632.8562-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for bpf_d_path() to cover incorrect verifier
assumptions caused by an incorrect function prototype. The test
attaches to the fallocate hook, calls bpf_d_path() and verifies that
a simple prefix comparison on the returned pathname behaves correctly
after the fix in patch 1. It ensures the verifier does not assume
the buffer remains unwritten.

Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 90 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 2 files changed, 95 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..c725d5258e65 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -38,6 +38,14 @@ static int set_pathname(int fd, pid_t pid)
 	return readlink(buf, src.paths[src.cnt++], MAX_PATH_LEN);
 }
 
+static inline long syscall_close(int fd)
+{
+	return syscall(__NR_close_range,
+			(unsigned int)fd,
+			(unsigned int)fd,
+			0u);
+}
+
 static int trigger_fstat_events(pid_t pid)
 {
 	int sockfd = -1, procfd = -1, devfd = -1;
@@ -104,36 +112,47 @@ static int trigger_fstat_events(pid_t pid)
 	/* sys_close no longer triggers filp_close, but we can
 	 * call sys_close_range instead which still does
 	 */
-#define close(fd) syscall(__NR_close_range, fd, fd, 0)
-
-	close(pipefd[0]);
-	close(pipefd[1]);
-	close(sockfd);
-	close(procfd);
-	close(devfd);
-	close(localfd);
-	close(indicatorfd);
-
-#undef close
+	syscall_close(pipefd[0]);
+	syscall_close(pipefd[1]);
+	syscall_close(sockfd);
+	syscall_close(procfd);
+	syscall_close(devfd);
+	syscall_close(localfd);
+	syscall_close(indicatorfd);
 	return ret;
 }
 
+static void attach_and_load(struct test_d_path **skel)
+{
+	int err;
+
+	*skel = test_d_path__open_and_load();
+	if (CHECK(!*skel, "setup", "d_path skeleton failed\n"))
+		goto cleanup;
+
+	err = test_d_path__attach(*skel);
+	if (CHECK(err, "setup", "attach failed: %d\n", err))
+		goto cleanup;
+
+	(*skel)->bss->my_pid = getpid();
+	return;
+
+cleanup:
+	test_d_path__destroy(*skel);
+	*skel = NULL;
+}
+
 static void test_d_path_basic(void)
 {
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
 	int err;
 
-	skel = test_d_path__open_and_load();
-	if (CHECK(!skel, "setup", "d_path skeleton failed\n"))
-		goto cleanup;
-
-	err = test_d_path__attach(skel);
-	if (CHECK(err, "setup", "attach failed: %d\n", err))
+	attach_and_load(&skel);
+	if (!skel)
 		goto cleanup;
 
 	bss = skel->bss;
-	bss->my_pid = getpid();
 
 	err = trigger_fstat_events(bss->my_pid);
 	if (err < 0)
@@ -195,6 +214,38 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+/* Check if the verifier correctly generates code for
+ * accessing the memory modified by d_path helper.
+ */
+static void test_d_path_mem_access(void)
+{
+	int localfd = -1;
+	struct test_d_path__bss *bss;
+	struct test_d_path *skel;
+
+	attach_and_load(&skel);
+	if (!skel)
+		goto cleanup;
+
+	bss = skel->bss;
+
+	localfd = open("/tmp/d_path_loadgen.txt", O_CREAT | O_RDWR, 0644);
+	if (CHECK(localfd < 0, "trigger", "open /tmp/d_path_loadgen.txt failed\n"))
+		goto cleanup;
+
+	if (CHECK(fallocate(localfd, 0, 0, 1024) < 0, "trigger", "fallocate failed\n"))
+		goto cleanup;
+	remove("/tmp/d_path_loadgen.txt");
+
+	if (CHECK(!bss->path_match_fallocate, "check",
+		  "failed to match actual opened path"))
+		goto cleanup;
+
+cleanup:
+	syscall_close(localfd);
+	test_d_path__destroy(skel);
+}
+
 void test_d_path(void)
 {
 	if (test__start_subtest("basic"))
@@ -205,4 +256,7 @@ void test_d_path(void)
 
 	if (test__start_subtest("check_alloc_mem"))
 		test_d_path_check_types();
+
+	if (test__start_subtest("check_mem_access"))
+		test_d_path_mem_access();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..2f9b4cb67931 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -17,6 +17,7 @@ int rets_close[MAX_FILES] = {};
 
 int called_stat = 0;
 int called_close = 0;
+int path_match_fallocate = 0;
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
@@ -62,4 +63,26 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	return 0;
 }
 
+SEC("fentry/vfs_fallocate")
+int BPF_PROG(prog_fallocate, struct file *file, int mode, loff_t offset, loff_t len)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	int ret = 0;
+	char path_fallocate[MAX_PATH_LEN] = {};
+
+	if (pid != my_pid)
+		return 0;
+
+	ret = bpf_d_path(&file->f_path,
+			 path_fallocate, MAX_PATH_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (path_fallocate[0] != '/')
+		return 0;
+
+	path_match_fallocate = 1;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0



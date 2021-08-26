Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDC3F892B
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbhHZNkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242729AbhHZNkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 09:40:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F646C0613C1;
        Thu, 26 Aug 2021 06:39:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q68so3086780pga.9;
        Thu, 26 Aug 2021 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8c9lrpCKZVIEoULfCkMLxjbpFUBnHy4bk+T/AkBcIc=;
        b=jAPiDgshWMpOHSg6EN++Cev3uHTjYwphDwTJMm1abmxQ4at6XgZcdAVyt0fhKp9HQQ
         vmHh+D6V7tSBlpTKE44FnG1in3yt0ngizChoM/e6FCgUE0tGPgxetFhxCf4+t9bNirD5
         k4qRDWwY53eQtU8tox1CD/ALIxeLtZSBXg+iXMIsRjeH97M1GKiPfKxAIx64AOXjaiRV
         slWc+1+qGW3bGoxdbFpCQhbz5WLBa5w+3uL3d6/Qe9moYeIUxrR1rtHVqMphMQcjDI8l
         s7A+NJqktkeGWBLBcjIDYzxdhe7hcbBQTXptGBZpVY78Zo5hybxrfBIJlq946UGEJQ8e
         T25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8c9lrpCKZVIEoULfCkMLxjbpFUBnHy4bk+T/AkBcIc=;
        b=BhRMFwVmYKrQCcLfyx9gp47Nzs9x0sjAVDPS1qwfxyrdOnhYrzxZug3UcH0urPupX0
         7p5dyAovWrTQBhJMbfrTR6Wx1myJ72TCIkCPk+D91g9Q8+VoFBXplNDvTT7eaMClIbL7
         LXgmHsFYGcF8H1M8Dvbte9klvphafr7gyfB2M1buv5kqk+sCiriSVZMRz0YqD998gPPn
         z1DBeO17kAIFZZjqAzl5FhneKHShk+hFmIpomGOjrLqBD4Y25do+h+ysiRaVb/S4paO6
         +VKr1eKfWOeszoosWjRmI3BMs8fZUtvRKI8ZZs2jLGJdASfqtTHyEouHaqlDujIDBP/y
         q9WQ==
X-Gm-Message-State: AOAM531Toq+BLZC/r20Nfj9OyShXcnTBMW+O60cioEh5glkDeaZpfIWT
        50NxV8mjaRruYk0JkkAQx76q4t7RJkA=
X-Google-Smtp-Source: ABdhPJy2FGs/APflTNPf08vG4Qq0nJiCdzQHVK83ntfv6S238gT3M/t8glh0I6PcT1xWbfojYFMCgw==
X-Received: by 2002:a65:5686:: with SMTP id v6mr3464931pgs.174.1629985173576;
        Thu, 26 Aug 2021 06:39:33 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id g20sm3127158pfo.20.2021.08.26.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:39:33 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 5/5] tools: testing: Add selftest for file local storage map
Date:   Thu, 26 Aug 2021 19:09:13 +0530
Message-Id: <20210826133913.627361-6-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826133913.627361-1-memxor@gmail.com>
References: <20210826133913.627361-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a test case for verifying that file local storage map works as
intended. It also tests map value with bpf_spin_lock.

It also demonstrates how this map is supposed to function in a security
context, by e.g. restricting an operation on a single fd. This could be
used to filter ioctls, fcntls, bpf ops, etc. on a per-fd basis.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_local_storage.c       | 55 +++++++++++++++++++
 .../selftests/bpf/progs/local_storage.c       | 43 +++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index d2c16eaae367..a0df0d4cdc34 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -24,6 +24,7 @@ static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 static unsigned int duration;
 
 #define TEST_STORAGE_VALUE 0xbeefdead
+#define DUMMY_STORAGE_VALUE 0xdeadbeef
 
 struct storage {
 	void *inode;
@@ -111,6 +112,55 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 	return true;
 }
 
+int test_file_local_storage(struct bpf_map *map)
+{
+	struct storage ls;
+	int fd, ret;
+
+	fd = open("/dev/null", O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open(/dev/null)"))
+		return -errno;
+
+	ret = fcntl(fd, F_DUPFD, 42);
+	if (!ASSERT_EQ(errno, EPERM, "fcntl should return EPERM"))
+		goto end;
+
+	ret = bpf_map_lookup_elem_flags(bpf_map__fd(map), &fd, &ls, BPF_F_LOCK);
+	if (!ASSERT_OK(ret, "bpf_map_lookup_elem for file local storage"))
+		goto end;
+
+	ASSERT_EQ(ls.value, DUMMY_STORAGE_VALUE, "file local value match");
+
+	ret = bpf_map_delete_elem(bpf_map__fd(map), &fd);
+	if (!ASSERT_OK(ret, "bpf_map_delete_elem for file local storage"))
+		goto end;
+
+	ret = bpf_map_lookup_elem_flags(bpf_map__fd(map), &fd, &ls, BPF_F_LOCK);
+	if (!ASSERT_EQ(ret, -ENOENT, "bpf_map_lookup_elem should fail"))
+		goto end;
+
+	memset(&ls, 0, sizeof(ls));
+	ls.value = DUMMY_STORAGE_VALUE;
+	ret = bpf_map_update_elem(bpf_map__fd(map), &fd, &ls, BPF_NOEXIST | BPF_F_LOCK);
+	if (!ASSERT_OK(ret, "bpf_map_update_elem for file local storage"))
+		goto end;
+
+	ret = bpf_map_lookup_elem_flags(bpf_map__fd(map), &fd, &ls, BPF_F_LOCK);
+	if (!ASSERT_OK(ret, "bpf_map_lookup_elem for file local storage"))
+		goto end;
+
+	close(fd);
+
+	ret = bpf_map_lookup_elem_flags(bpf_map__fd(map), &fd, &ls, BPF_F_LOCK);
+	if (!ASSERT_EQ(ret, -EBADF, "bpf_map_lookup_elem should fail"))
+		return -EINVAL;
+
+	return 0;
+end:
+	close(fd);
+	return ret;
+}
+
 void test_test_local_storage(void)
 {
 	char tmp_dir_path[] = "/tmp/local_storageXXXXXX";
@@ -167,6 +217,11 @@ void test_test_local_storage(void)
 	/* Set the process being monitored to be the current process */
 	skel->bss->monitored_pid = getpid();
 
+	/* Test file local storage */
+	err = test_file_local_storage(skel->maps.file_storage_map);
+	if (!ASSERT_OK(err, "test_file_local_storage"))
+		goto close_prog_rmdir;
+
 	/* Move copy_of_rm to a new location so that it triggers the
 	 * inode_rename LSM hook with a new_dentry that has a NULL inode ptr.
 	 */
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 95868bc7ada9..0ea04bd803f1 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -44,6 +44,13 @@ struct {
 	__type(value, struct local_storage);
 } task_storage_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_FILE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct local_storage);
+} file_storage_map SEC(".maps");
+
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
@@ -181,3 +188,39 @@ void BPF_PROG(exec, struct linux_binprm *bprm)
 	storage->value = DUMMY_STORAGE_VALUE;
 	bpf_spin_unlock(&storage->lock);
 }
+
+SEC("lsm/file_open")
+int BPF_PROG(file_open, struct file *file)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct local_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	storage = bpf_file_storage_get(&file_storage_map, file, 0,
+				       BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+	bpf_spin_lock(&storage->lock);
+	storage->value = DUMMY_STORAGE_VALUE;
+	bpf_spin_unlock(&storage->lock);
+
+	return 0;
+}
+
+SEC("lsm/file_fcntl")
+int BPF_PROG(file_fcntl, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct local_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	storage = bpf_file_storage_get(&file_storage_map, file, 0,
+				       BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (storage)
+		return -EPERM;
+	return 0;
+}
-- 
2.33.0


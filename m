Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079463F3C30
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhHUStY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Aug 2021 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhHUStX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Aug 2021 14:49:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BDDC061764;
        Sat, 21 Aug 2021 11:48:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so16029357pjr.1;
        Sat, 21 Aug 2021 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3yT1j4pbUZknzUyxpuqzNzLJ0XV1FOv6P3LRPoFRb8=;
        b=kjYLTwX502hDBTrCam1tUMaCd/Kz8wuaC+UnL76keURQYfvliHzN4gYDwfxSwe+6gq
         hJ8TAFliZFaj1kvBEa8XB0EAM+lTgR1wqDNK/w0rfXZxCdOY9MWPde+J2E6/wmOqeZRS
         46KfTZcvHZ7PvL+i+xTWiEOgGUNDWOkyi+u4EODAowqYned0wvQoSwnpgT7/e6/Va0Rp
         YCmDuHMYIJpHk1ONRUc67E0S/vdkFklbgrXnr8g27wMVg8EGiRQifOUnoCAfCsXeO4xN
         30NAHXK/frPXF1XgN4o7EmBqH69mxcwfLu+fhnBl/zTc8GFPZ1OxBkBOLoGaFbdfAXpx
         wzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3yT1j4pbUZknzUyxpuqzNzLJ0XV1FOv6P3LRPoFRb8=;
        b=oPdvM8hnmnIB2sBF9ooA7YlMwogMRrVkykhKNOAL36167wy637LqTRcx8o2fm7phYN
         MTZZLdRpjI/L0mpXyucKI0aefIlKVxQBzBI8Bb+va/QLiXNVw+/GRentDBoeCwEBXLch
         vJa4I8NB3I92zN0gPymq0PXp4aN+KCP0oNNquHbcz5hmGYYovU0uqP37mifD24F5gK19
         6RAL1XxZ7qVetMa5AIRiBC1p7OqSMA2EeS8ufgiMOGvRK5z0IyeFV5ORcEod0bGGE0Hk
         3qfS5FiuqpNQBv4RK6tz2S09cIHmYykRPjU8H1H0KpwnIvQEkqNK58JLvoO7qu0o97Oq
         RsvA==
X-Gm-Message-State: AOAM531eCbgoEjy76WrJ2WPIq/d2j0K/dzW1GsHX3GaBdCvyDfXtGf2b
        Zi6GZ0oMTRKAinYfsWIRdGZouf6aSPs=
X-Google-Smtp-Source: ABdhPJwaadqsaDwiJ3bj/J+WXvcrD0kg+M6rGpLk2rVA+Ar8Q2vk1q4kN7CmCJvzCp3RnC9Fe1W/EA==
X-Received: by 2002:a17:903:20c4:b0:12d:c7de:3401 with SMTP id i4-20020a17090320c400b0012dc7de3401mr21782084plb.40.1629571722416;
        Sat, 21 Aug 2021 11:48:42 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id m28sm13462557pgl.9.2021.08.21.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 11:48:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next RFC v1 5/5] tools: testing: Add selftest for file local storage map
Date:   Sun, 22 Aug 2021 00:18:24 +0530
Message-Id: <20210821184824.2052643-6-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821184824.2052643-1-memxor@gmail.com>
References: <20210821184824.2052643-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a test case for verifying that file local storage map works as
intended.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_local_storage.c       | 51 +++++++++++++++++++
 .../selftests/bpf/progs/local_storage.c       | 23 +++++++++
 2 files changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index d2c16eaae367..154dee32320c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -24,6 +24,7 @@ static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 static unsigned int duration;
 
 #define TEST_STORAGE_VALUE 0xbeefdead
+#define DUMMY_STORAGE_VALUE 0xdeadbeef
 
 struct storage {
 	void *inode;
@@ -111,6 +112,51 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
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
+	ret = bpf_map_lookup_elem(bpf_map__fd(map), &fd, &ls);
+	if (!ASSERT_OK(ret, "bpf_map_lookup_elem for file local storage"))
+		goto end;
+
+	ASSERT_EQ(ls.value, DUMMY_STORAGE_VALUE, "file local value match");
+
+	ret = bpf_map_delete_elem(bpf_map__fd(map), &fd);
+	if (!ASSERT_OK(ret, "bpf_map_delete_elem for file local storage"))
+		goto end;
+
+	ret = bpf_map_lookup_elem(bpf_map__fd(map), &fd, &ls);
+	if (!ASSERT_EQ(ret, -ENOENT, "bpf_map_lookup_elem should fail"))
+		goto end;
+
+	memset(&ls, 0, sizeof(ls));
+	ls.value = DUMMY_STORAGE_VALUE;
+	ret = bpf_map_update_elem(bpf_map__fd(map), &fd, &ls, BPF_NOEXIST);
+	if (!ASSERT_OK(ret, "bpf_map_update_elem for file local storage"))
+		goto end;
+
+	ret = bpf_map_lookup_elem(bpf_map__fd(map), &fd, &ls);
+	if (!ASSERT_OK(ret, "bpf_map_lookup_elem for file local storage"))
+		goto end;
+
+	close(fd);
+
+	ret = bpf_map_lookup_elem(bpf_map__fd(map), &fd, &ls);
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
@@ -167,6 +213,11 @@ void test_test_local_storage(void)
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
index 95868bc7ada9..68561812f454 100644
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
@@ -181,3 +188,19 @@ void BPF_PROG(exec, struct linux_binprm *bprm)
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
+	if (storage)
+		storage->value = DUMMY_STORAGE_VALUE;
+	return 0;
+}
-- 
2.33.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A692BAAF0
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgKTNRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 08:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgKTNRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 08:17:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0083C0617A7
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 05:17:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so10023596wrt.4
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KobsDfLvvwwoQBJaQpY6EUfIO/NscqTe50uGy1eW/88=;
        b=XkdruCUCJy0vVXiI0GdwzPsjTOtz+tLforHPSGq48dki799F2HBzUYbMZEaoQGkyz8
         NyLIqjENSc/9cf89Uo7YA/4fY7/UCK6qyp7hCF1l9+4whOJmqJrj2iOR7teHYo98Eb9i
         IJ3UiZWpp1zl/QGGMJ3snJvt4i9Q0ShVd9O0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KobsDfLvvwwoQBJaQpY6EUfIO/NscqTe50uGy1eW/88=;
        b=rB8bKXFL7JVHkTwS3mTNiLswyiwahc5yOJF/9DZ2JtSxgRb1V9ssTpJkj8mHIHn8ju
         eaIXnbTjo6dzjvGjgFU/SZNlsFn3l80KUjT+JO1aUCqax2d95+UL4k3dwbRtMM1Xfrkx
         PK6uzEEQuNf3rWniKjg/bCOOzP8SQLarBgi05tQNQavWtV1JyQaohlNTVXLljkz3AL+F
         eKnkcK6vEraZbPWuUu7CoBnSUUaOk61vk258lm2zAxEIkpU8UBgyM/ZJn87buJNgaJ4O
         U8XqDuBtp9tsbZWwLteq9pyMqSoLP6EHDa1q1Q+oaBWRmBVacbPbTmlzVT1zk7vuCh+0
         ZvMA==
X-Gm-Message-State: AOAM530b7d/hHohd1CjyX42Fc+8BLiPCoNdgaXUdboD5J9y03kAjCEAH
        /2A4VpwkKVa5K1Q2RvslK/ZFSw==
X-Google-Smtp-Source: ABdhPJzUiKdrYOVWCnJTxkk/+DH44xU6PKfkwEBAAvSc9pFneQYoKimqm1y1FMfpgOt5H2pwz7MT3A==
X-Received: by 2002:adf:f246:: with SMTP id b6mr15269927wrp.238.1605878232682;
        Fri, 20 Nov 2020 05:17:12 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id u203sm4260197wme.32.2020.11.20.05.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 05:17:12 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
Date:   Fri, 20 Nov 2020 13:17:08 +0000
Message-Id: <20201120131708.3237864-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120131708.3237864-1-kpsingh@chromium.org>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

- Update the IMA policy before executing the test binary (this is not an
  override of the policy, just an append that ensures that hashes are
  calculated on executions).

- Call the bpf_ima_inode_hash in the bprm_committed_creds hook and check
  if the call succeeded and a hash was calculated.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/config            |  3 ++
 .../selftests/bpf/prog_tests/test_lsm.c       | 32 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |  7 +++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2118e23ac07a..4b5764031368 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -39,3 +39,6 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
 CONFIG_LIRC=y
+CONFIG_IMA=y
+CONFIG_IMA_WRITE_POLICY=y
+CONFIG_IMA_READ_POLICY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 6ab29226c99b..3f5d64adb233 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -52,6 +52,28 @@ int exec_cmd(int *monitored_pid)
 	return -EINVAL;
 }
 
+#define IMA_POLICY "measure func=BPRM_CHECK"
+
+/* This does not override the policy, IMA policy updates are
+ * append only, so this just ensures that "measure func=BPRM_CHECK"
+ * is in the policy. IMA does not allow us to remove this line once
+ * it is added.
+ */
+static int update_ima_policy(void)
+{
+	int fd, ret = 0;
+
+	fd = open("/sys/kernel/security/ima/policy", O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (write(fd, IMA_POLICY, sizeof(IMA_POLICY)) == -1)
+		ret = -errno;
+
+	close(fd);
+	return ret;
+}
+
 void test_test_lsm(void)
 {
 	struct lsm *skel = NULL;
@@ -66,6 +88,10 @@ void test_test_lsm(void)
 	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
 		goto close_prog;
 
+	err = update_ima_policy();
+	if (CHECK(err != 0, "update_ima_policy", "error = %d\n", err))
+		goto close_prog;
+
 	err = exec_cmd(&skel->bss->monitored_pid);
 	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
 		goto close_prog;
@@ -83,6 +109,12 @@ void test_test_lsm(void)
 	CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
 	      "mprotect_count = %d\n", skel->bss->mprotect_count);
 
+	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
+	      "ima_hash_ret = %d\n", skel->data->ima_hash_ret);
+
+	CHECK(skel->bss->ima_hash == 0, "ima_hash",
+	      "ima_hash = %lu\n", skel->bss->ima_hash);
+
 	syscall(__NR_setdomainname, &buf, -2L);
 	syscall(__NR_setdomainname, 0, -3L);
 	syscall(__NR_setdomainname, ~0L, -4L);
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index ff4d343b94b5..b0f9639e4b0a 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -35,6 +35,8 @@ char _license[] SEC("license") = "GPL";
 int monitored_pid = 0;
 int mprotect_count = 0;
 int bprm_count = 0;
+int ima_hash_ret = -1;
+u64 ima_hash = 0;
 
 SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
@@ -65,8 +67,11 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 	__u32 key = 0;
 	__u64 *value;
 
-	if (monitored_pid == pid)
+	if (monitored_pid == pid) {
 		bprm_count++;
+		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
+						  &ima_hash, sizeof(ima_hash));
+	}
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
-- 
2.29.2.454.gaff20da3a2-goog


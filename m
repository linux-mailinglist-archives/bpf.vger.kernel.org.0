Return-Path: <bpf+bounces-11776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A877BF094
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 04:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803CD281AD4
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F210FF;
	Tue, 10 Oct 2023 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3aE0jdN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F8EB8
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 02:02:25 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562DB6;
	Mon,  9 Oct 2023 19:02:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6934202b8bdso4219756b3a.1;
        Mon, 09 Oct 2023 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696903343; x=1697508143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VxS46BYkOtM3n7DPKOT+7jWKqjJz3x5dhTSs9Wey/A=;
        b=T3aE0jdN0XsYgzr+jcXWVJveECX4F7A76p4QA6JIhAwkRtd0LzCo1wRDRykdYaShGI
         dATLylqxruhu5yMRJ9FizUYNVkZm2V2QoTFbHxK4y/e2gH4qQUH+mUMbg7b9bkuYO3JO
         JRGr9zT0r1vQPETYgk5s5uDL166C9vgN7wogjxDguf/dfGNNfbkCdZTRYLrUuPBrOpR/
         VAucJ7/qsYJIuTQgh98bgF1QKadsNrXfizP74hExYuxosOilsQUOVptZPnGFPOqxfbP9
         n1L5e3O8jhodkykyOKUFYo6WVN0iQHM2S27EPseqTv2LH5SzeLxTA9F6XhRV6ruhCOxW
         fPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903343; x=1697508143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VxS46BYkOtM3n7DPKOT+7jWKqjJz3x5dhTSs9Wey/A=;
        b=EUjPIA3vTNKd6n4GpEnuvUgHxyLnlSradLZ9djngXGWnL1cO3sYFhCM46u4s8ofE39
         pEAMf7CZ4Bz8DVmvVMVzmMUn6azzsa82oZ+fuqyRp4/SLvZ334KRd2DmEZ/14lEr3qMF
         /yCqWINGcTIcbEhsWazgREd+ISQP6dE4Vs3DYarkCMMCYbvI8Cp5zPodTk5zJeQVviV5
         V7pa3fX/KEl/j1zmyU+Oe33AnO2pwilGcIzdT51umySVkFq6XbNpfaO/R3XUpeIHDpxC
         C+w87MRhQmZpq2xnHrTdEKQB7i6euf3ZLpebD12kCOCSA6tbv3MlKXlVnIXgZINH2z1L
         44Xw==
X-Gm-Message-State: AOJu0YwwggTIrCd7QCOKyBxnUNx4z+IwhJEPAU74bM8Rp0iRxa4DUU5f
	2M6xo6VYvCyneAOsfet2bIOkpyS+X3TIAA==
X-Google-Smtp-Source: AGHT+IG4jABoJ4Ft8AFqTRnHmyQQfN+6eFolPGMFVeidOVxbh/8KpVMbWjpTkWAnc/afrBwh9Ldiug==
X-Received: by 2002:a05:6a00:1390:b0:693:3d55:2ba6 with SMTP id t16-20020a056a00139000b006933d552ba6mr21377676pfg.9.1696903342657;
        Mon, 09 Oct 2023 19:02:22 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.112])
        by smtp.googlemail.com with ESMTPSA id t28-20020aa7939c000000b0068a46cd4120sm7044809pfe.199.2023.10.09.19.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 19:02:22 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH 1/4] seccomp: Refactor filter copy/create for reuse
Date: Mon,  9 Oct 2023 12:40:43 +0000
Message-Id: <20231009124046.74710-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009124046.74710-1-hengqi.chen@gmail.com>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This extracts two helpers for reuse in subsequent additions.
No functional change intended, just a prep work.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/seccomp.c | 76 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..37490497f687 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -640,14 +640,14 @@ static inline void seccomp_sync_threads(unsigned long flags)
 }
 
 /**
- * seccomp_prepare_filter: Prepares a seccomp filter for use.
- * @fprog: BPF program to install
+ * seccomp_prepare_prog - prepares a JITed BPF filter for use.
+ * @pfp: the unattached filter that is created
+ * @fprog: the filter program
  *
- * Returns filter on success or an ERR_PTR on failure.
+ * Returns 0 on success and non-zero otherwise.
  */
-static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
+static int seccomp_prepare_prog(struct bpf_prog **pfp, struct sock_fprog *fprog)
 {
-	struct seccomp_filter *sfilter;
 	int ret;
 	const bool save_orig =
 #if defined(CONFIG_CHECKPOINT_RESTORE) || defined(SECCOMP_ARCH_NATIVE)
@@ -657,10 +657,28 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 #endif
 
 	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	BUG_ON(INT_MAX / fprog->len < sizeof(struct sock_filter));
 
+	ret = bpf_prog_create_from_user(pfp, fprog, seccomp_check_filter, save_orig);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * seccomp_prepare_filter: Prepares a seccomp filter for use.
+ * @fprog: BPF program to install
+ *
+ * Returns filter on success or an ERR_PTR on failure.
+ */
+static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
+{
+	struct seccomp_filter *sfilter;
+	int ret;
+
 	/*
 	 * Installing a seccomp filter requires that the task has
 	 * CAP_SYS_ADMIN in its namespace or be running with no_new_privs.
@@ -677,8 +695,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&sfilter->notify_lock);
-	ret = bpf_prog_create_from_user(&sfilter->prog, fprog,
-					seccomp_check_filter, save_orig);
+	ret = seccomp_prepare_prog(&sfilter->prog, fprog);
 	if (ret < 0) {
 		kfree(sfilter);
 		return ERR_PTR(ret);
@@ -692,31 +709,46 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 }
 
 /**
- * seccomp_prepare_user_filter - prepares a user-supplied sock_fprog
+ * seccomp_copy_user_filter - copies a user-supplied sock_fprog
  * @user_filter: pointer to the user data containing a sock_fprog.
+ * @fprog: pointer to store the copied BPF program
  *
  * Returns 0 on success and non-zero otherwise.
  */
-static struct seccomp_filter *
-seccomp_prepare_user_filter(const char __user *user_filter)
+static int seccomp_copy_user_filter(const char __user *user_filter, struct sock_fprog *fprog)
 {
-	struct sock_fprog fprog;
-	struct seccomp_filter *filter = ERR_PTR(-EFAULT);
-
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall()) {
 		struct compat_sock_fprog fprog32;
 		if (copy_from_user(&fprog32, user_filter, sizeof(fprog32)))
-			goto out;
-		fprog.len = fprog32.len;
-		fprog.filter = compat_ptr(fprog32.filter);
+			return -EFAULT;
+		fprog->len = fprog32.len;
+		fprog->filter = compat_ptr(fprog32.filter);
 	} else /* falls through to the if below. */
 #endif
-	if (copy_from_user(&fprog, user_filter, sizeof(fprog)))
-		goto out;
-	filter = seccomp_prepare_filter(&fprog);
-out:
-	return filter;
+	if (copy_from_user(fprog, user_filter, sizeof(*fprog)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * seccomp_prepare_user_filter - prepares a user-supplied sock_fprog
+ * @user_filter: pointer to the user data containing a sock_fprog.
+ *
+ * Returns filter on success or an ERR_PTR on failure.
+ */
+static struct seccomp_filter *
+seccomp_prepare_user_filter(const char __user *user_filter)
+{
+	struct sock_fprog fprog;
+	int ret;
+
+	ret = seccomp_copy_user_filter(user_filter, &fprog);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return seccomp_prepare_filter(&fprog);
 }
 
 #ifdef SECCOMP_ARCH_NATIVE
-- 
2.34.1



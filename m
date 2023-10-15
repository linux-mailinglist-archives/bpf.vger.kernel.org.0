Return-Path: <bpf+bounces-12242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C37C9D03
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5463EB20C76
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D017C6;
	Mon, 16 Oct 2023 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0PzweRp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534D17EC
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 01:47:32 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC9DA;
	Sun, 15 Oct 2023 18:47:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so2343601a91.2;
        Sun, 15 Oct 2023 18:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420849; x=1698025649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHaBMootb9r45Igd+ylGLOd17RhwzfVYT0h/J8CZlqY=;
        b=O0PzweRpR+kxxWGKmR/pLQN3DpwPHvNwjesLnWZqY3pZ6wtIJqr4OUgsr3tCH4WS5M
         G1L6d2cSsVijzffs1GL8VCYld0pg0JAEPOehz02HKnCpgkCc28SIgDISgPUTHUnlHvIn
         BKoxMyjMX3IHb563bqRh1MPO79otOhOucTNAL/i+esTuaoMpoc+G78+JsVeNIVLhLgDF
         z1NcBiCF007Ql1jLIyFhto8djmLJnc4IhrJ9n8cDeYx1BVJppiRBCIEM9kBMCvnt6Lm9
         bwgcvsSkPSR3RzGDrxL3Za8fwrlvR0k/hzWoNl00SlKjudZQhdfDZ5Cd4Kak04FpNXCy
         V3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420849; x=1698025649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHaBMootb9r45Igd+ylGLOd17RhwzfVYT0h/J8CZlqY=;
        b=H2SnO6nHjrS77ri6tRXSLNTOmRBENHs+jfZwS+9txrV8g3q9fFe0ob2wCd5LXemesk
         d/RhtXsgkFThoAvVZ+CRATadhVCrcleXJ5OsiPYiwG7GO/DhaczSsgcmPcOLT5+tSV9M
         UQhiBXkgjOQWHyW4nkdRcBuzg+52gzDnm+R89EzMSfQeuhlBF6gvWrR9KSX3b/PUQCf6
         fjjrXsdXH1KpV9Iq3Rb+42T8MjCkofriH/ClyWzOmF36ANyQX1quxDZF0hY/qhF0skET
         BphlIxRLeFaCfYRQ6ujXb0elZQ+zvtFjrXVW/j7nsoJNIw1s+pYOKjPjaqqw1WsnZJ56
         51dw==
X-Gm-Message-State: AOJu0YzjdG05RbZKNwQexe1b4jsEd3teWrlAv0QRoD25jHSiwOw5/8Zd
	tc9zJdkPf4bQ1grUJEjDVtYYxyrsze50Ng==
X-Google-Smtp-Source: AGHT+IFAKFHmQYAOf76BYbrnl1hhfG4j1GW2+kyERdCml+yqXk1xm0DSkD2zzaKE0j0kcQguIqsqaw==
X-Received: by 2002:a17:90b:1b4b:b0:27d:3290:dee3 with SMTP id nv11-20020a17090b1b4b00b0027d3290dee3mr5965226pjb.2.1697420849567;
        Sun, 15 Oct 2023 18:47:29 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:28 -0700 (PDT)
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
Subject: [PATCH v2 1/5] seccomp: Refactor filter copy/create for reuse
Date: Sun, 15 Oct 2023 23:29:49 +0000
Message-Id: <20231015232953.84836-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015232953.84836-1-hengqi.chen@gmail.com>
References: <20231015232953.84836-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This extracts two helpers for reuse in subsequent additions.
No functional change intended, just a prep work.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/seccomp.c | 90 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 27 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..faf84fc892eb 100644
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
@@ -657,10 +657,27 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
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
+ * @prog: BPF program to install
+ *
+ * Returns filter on success or an ERR_PTR on failure.
+ */
+static struct seccomp_filter *seccomp_prepare_filter(struct bpf_prog *prog)
+{
+	struct seccomp_filter *sfilter;
+
 	/*
 	 * Installing a seccomp filter requires that the task has
 	 * CAP_SYS_ADMIN in its namespace or be running with no_new_privs.
@@ -677,13 +694,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&sfilter->notify_lock);
-	ret = bpf_prog_create_from_user(&sfilter->prog, fprog,
-					seccomp_check_filter, save_orig);
-	if (ret < 0) {
-		kfree(sfilter);
-		return ERR_PTR(ret);
-	}
-
+	sfilter->prog = prog;
 	refcount_set(&sfilter->refs, 1);
 	refcount_set(&sfilter->users, 1);
 	init_waitqueue_head(&sfilter->wqh);
@@ -692,31 +703,56 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
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
+	struct seccomp_filter *sfilter;
+	struct sock_fprog fprog;
+	struct bpf_prog *prog;
+	int ret;
+
+	ret = seccomp_copy_user_filter(user_filter, &fprog);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = seccomp_prepare_prog(&prog, &fprog);
+	if (ret)
+		return ERR_PTR(ret);
+
+	sfilter = seccomp_prepare_filter(prog);
+	if (IS_ERR(sfilter))
+		bpf_prog_destroy(prog);
+
+	return sfilter;
 }
 
 #ifdef SECCOMP_ARCH_NATIVE
-- 
2.34.1



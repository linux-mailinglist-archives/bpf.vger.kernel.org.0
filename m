Return-Path: <bpf+bounces-13683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AB7DC669
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262C51C20BB3
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5210A16;
	Tue, 31 Oct 2023 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeVtV7dy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DEE101FA
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:50 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B4C1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:08:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41e1974783cso34264831cf.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732492; x=1699337292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUS+urLlc3l5lMxBmDrHF/GhNDqUeMARNzj5fIJEJlY=;
        b=JeVtV7dyjU0Bi3WhvlUK/pUXmXUZNauUBtuZmiHkB0zluH229dIhbHRGqKs0ytICL2
         xNXmsWp7q7AmPek2Dg64XaZmjNjJsvezMUqnZ0cL+mNuYT5DHrRn5AtjeDrk4j0tu4WI
         RoJKFLRen42xYze32pTsI2TIeeTzfDy4VXYpppvpg4v01srIX4WoaEIx6lNr+rf2uNQ5
         HoKXJDu6RtbYKGwexBgHThoDYKqkhDm6ji5SEeGh981as5Kl6Ji4lp+07p2/FKrUdevF
         tUQ1LmGevTmvPRIZ6dj6pdkosI1CmmHQe2OEWaZYuUBqc4ESABc/HM4wi4YldiQ5na+O
         yQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732492; x=1699337292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUS+urLlc3l5lMxBmDrHF/GhNDqUeMARNzj5fIJEJlY=;
        b=SSj6ZFicXK3xKrxDJMwvZONWrqOsE46GuzGek7K8Rjipkyo+L14SL6MJ3S8EIkKtAY
         8MGz/uZwD6DdycEz56gTYFq0iFKeafEOzfzIV1aF+iDQQ/+P4VXvH0jTMnX6RlSMnzBc
         /HSsecJyYewpG6o5dcwog8i6PcUFWJLF3/wQl8kqZy7VySpO3pxrNeoxqA0xvcjV7sEj
         vFaj+mc3mcSE9wgmpzhSsPENkn8H2FqDtB6MMZ/qntfaV7TsQcZg1c8oxifAf1RmdWmo
         KlonHipz93XLAlNI5ObcnnmmOpT6KS1g4wiQ2BHYXuP8ktNybEa2QNIPJO4t30x138nJ
         y9xg==
X-Gm-Message-State: AOJu0YzPWrcqQ5hN2F62sX3nkMmoBOIzEPoxo3c2yTyyha62a2JrrX/v
	IsnYsUnAcNVqDHsKfq30Kwbg6hCFXF8ZOg==
X-Google-Smtp-Source: AGHT+IEMarcjHGbYarFj4G2ffbj28C5zjWId8cBBqSRV233XWfBRGcC7JYUo1+b9SW+iwY9DKnA0sw==
X-Received: by 2002:a05:6a20:d90b:b0:180:f8c2:633c with SMTP id jd11-20020a056a20d90b00b00180f8c2633cmr732820pzb.53.1698732038967;
        Mon, 30 Oct 2023 23:00:38 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:38 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 3/6] seccomp: Refactor filter copy/create for reuse
Date: Tue, 31 Oct 2023 01:24:04 +0000
Message-Id: <20231031012407.51371-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031012407.51371-1-hengqi.chen@gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactors seccomp_prepare_filter() for reuse in
subsequent additions. No functional change intended.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/seccomp.c | 50 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1fa2312654a5..2a724690a627 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -641,14 +641,14 @@ static inline void seccomp_sync_threads(unsigned long flags)
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
@@ -658,10 +658,27 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
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
@@ -678,13 +695,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
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
@@ -701,8 +712,10 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 static struct seccomp_filter *
 seccomp_prepare_user_filter(const char __user *user_filter)
 {
-	struct sock_fprog fprog;
 	struct seccomp_filter *filter = ERR_PTR(-EFAULT);
+	struct sock_fprog fprog;
+	struct bpf_prog *prog;
+	int ret;
 
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall()) {
@@ -715,7 +728,14 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 #endif
 	if (copy_from_user(&fprog, user_filter, sizeof(fprog)))
 		goto out;
-	filter = seccomp_prepare_filter(&fprog);
+
+	ret = seccomp_prepare_prog(&prog, &fprog);
+	if (ret)
+		return ERR_PTR(ret);
+
+	filter = seccomp_prepare_filter(prog);
+	if (IS_ERR(filter))
+		bpf_prog_destroy(prog);
 out:
 	return filter;
 }
-- 
2.34.1



Return-Path: <bpf+bounces-12244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFD7C9D05
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481201C208F0
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF4417FC;
	Mon, 16 Oct 2023 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIp7kBIS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC017EC
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 01:47:44 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D3E1;
	Sun, 15 Oct 2023 18:47:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso3049568a91.0;
        Sun, 15 Oct 2023 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420861; x=1698025661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG+9X4nVV+pHbrjt1Lng7ohViJzwy8aDHAaR38B9wtI=;
        b=MIp7kBIS/yoSBdepUlPZldhNS4fP9f2bcdz/X3aSp88nbnKW4JY+QrGkLhYnIN6i9T
         J9ZKQSnrU9kA/bYDQXruwMwnSJC0L7WZlAJ5R16fk4qSTQmhtaLGu5yRrMMix0WaLZr/
         nphYUbcb9DLzHDdouR4KcQBWCvXNM1Qjvhcjk0Fx/+DLMCb2CSCTfA+vVi8Rb2ERKuOz
         wS4csYMY0AXmkVEvMWm0W1iPFa0coOc1TuEIg8kKZm0WLCLJR8Re15qYyj7aXGBZZGxF
         9iU4YtG1CA5fW6pnpkBhy0WKl+BhZHPYa8m9Ykzh+rWuNZ98CuTz0vTl0yeXQBDz4yrB
         wIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420861; x=1698025661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG+9X4nVV+pHbrjt1Lng7ohViJzwy8aDHAaR38B9wtI=;
        b=ljhJPdCidai855p1YaLQOaxK6UTiLdlOMm6kc1HSgvOLx/pCUF7Ypg4dZm0pIvPKco
         UFBZ9Bso/fdxf3/j22silrvR/Boa3iLCwyhRNd1YKknqmEeyCAH6EpuedllyDDXbw1qd
         Qciy5Z58DvTPWDLaIjLhuF7Z9ROh2PuU4Pesc/5tj4iOjcj6wYX9VjeJ4YB5g9pZ/3Ig
         wUsJH0naLvsqAyk3uKFterJFhBiOVQYRCUD9f+IITIpZHgNJSHzMdlDl8AOGUC27dJPX
         U0XHVd0y+MBysrDylK8Xwz9jzCxsx9PbvqMmt0i7Sl6HOEp6lFWhjG7jgM7ojylIKY5w
         0oAQ==
X-Gm-Message-State: AOJu0Yx08+8cEwzFGf7UtIiPQQA7I9NHBj9EMI9rWM4P7OL+qVMUgv6s
	P9D5osmvnqnG1Bxai8W8Y9gRFukllr8QMQ==
X-Google-Smtp-Source: AGHT+IF8TmvH+rCTiJz05lotuOhS65iIxERZMt65PvK3N3oyr+1FHrG3S0m6kngh7s73+mzPFOc/Jw==
X-Received: by 2002:a17:90b:1bcf:b0:27d:5568:e867 with SMTP id oa15-20020a17090b1bcf00b0027d5568e867mr8500687pjb.9.1697420861504;
        Sun, 15 Oct 2023 18:47:41 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:40 -0700 (PDT)
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
Subject: [PATCH v2 3/5] seccomp: Introduce new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD
Date: Sun, 15 Oct 2023 23:29:51 +0000
Message-Id: <20231015232953.84836-4-hengqi.chen@gmail.com>
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

Add a new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD for
SECCOMP_SET_MODE_FILTER. This indicates the seccomp filter
is a seccomp bpf prog fd, not a sock_fprog. This allows
us to attach the seccomp filter that is previously loaded
via SECCOMP_LOAD_FILTER.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/seccomp.h      |  3 ++-
 include/uapi/linux/seccomp.h |  2 ++
 kernel/seccomp.c             | 37 ++++++++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 175079552f68..7caa53b629d9 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -9,7 +9,8 @@
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
 					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
 					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH | \
-					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
+					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV | \
+					 SECCOMP_FILTER_FLAG_BPF_PROG_FD)
 
 /* sizeof() the first published struct seccomp_notif_addfd */
 #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index ee2c83697810..d6b243d1b4d5 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -26,6 +26,8 @@
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+/* Indicates that the filter is in form of bpf prog fd */
+#define SECCOMP_FILTER_FLAG_BPF_PROG_FD		(1UL << 6)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index c9f6a19f7a4e..3a977e5932a4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -525,7 +525,10 @@ static inline pid_t seccomp_can_sync_threads(void)
 static inline void seccomp_filter_free(struct seccomp_filter *filter)
 {
 	if (filter) {
-		bpf_prog_destroy(filter->prog);
+		if (filter->prog->type == BPF_PROG_TYPE_SECCOMP)
+			bpf_prog_put(filter->prog);
+		else
+			bpf_prog_destroy(filter->prog);
 		kfree(filter);
 	}
 }
@@ -757,6 +760,33 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return sfilter;
 }
 
+/**
+ * seccomp_prepare_filter_from_fd - prepares filter from a user-supplied fd
+ * @ufd: pointer to fd that refers to a seccomp bpf prog.
+ *
+ * Returns filter on success or an ERR_PTR on failure.
+ */
+static struct seccomp_filter *
+seccomp_prepare_filter_from_fd(const char __user *ufd)
+{
+	struct seccomp_filter *sfilter;
+	struct bpf_prog *prog;
+	int fd;
+
+	if (copy_from_user(&fd, ufd, sizeof(fd)))
+		return ERR_PTR(-EFAULT);
+
+	prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SECCOMP);
+	if (IS_ERR(prog))
+		return ERR_PTR(-EBADF);
+
+	sfilter = seccomp_prepare_filter(prog);
+	if (IS_ERR(sfilter))
+		bpf_prog_put(prog);
+
+	return sfilter;
+}
+
 #ifdef SECCOMP_ARCH_NATIVE
 /**
  * seccomp_is_const_allow - check if filter is constant allow with given data
@@ -1970,7 +2000,10 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		return -EINVAL;
 
 	/* Prepare the new filter before holding any locks. */
-	prepared = seccomp_prepare_user_filter(filter);
+	if (flags & SECCOMP_FILTER_FLAG_BPF_PROG_FD)
+		prepared = seccomp_prepare_filter_from_fd(filter);
+	else
+		prepared = seccomp_prepare_user_filter(filter);
 	if (IS_ERR(prepared))
 		return PTR_ERR(prepared);
 
-- 
2.34.1



Return-Path: <bpf+bounces-13687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA307DC66D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1A2281790
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB61107AC;
	Tue, 31 Oct 2023 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HspflBVX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709E107A7
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:53 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B2119
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:07:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a92727934eso185733039f.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732457; x=1699337257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06zNutXrrHXE6Yd7yKwHsB6kGwBWRko0H6rYozsLVnE=;
        b=HspflBVXWdk6zVb1xhhmdJCOSptLb9pwaZp3Q38+js8jVkmDcCLwNP154z4Sm0rwGb
         t6hOtZomv6Vcl8MG/5LjYS2pD3vlWNBWfa75ekqHzJZh810xLfTQiNjCzMbS9lP9buJe
         D3cQWMghkwfLOnY40CrxbqoUsx3nqvv3ezJbihYrNdaVhUqxHR+WbqFD9584Dra9+m22
         +1qnif7bmtZeoNV/hbzJHKUj+09W3FNgzVE5t7LThrvqRxE6VwFRNbg4xDOzPRxhgXTJ
         Y5rUCKfpT7grhNG7NOtwyMk0XqBECx1ud5VvpjX1y0oj9Fc/1WLLm50iBRZHY0an4fzO
         GrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732457; x=1699337257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06zNutXrrHXE6Yd7yKwHsB6kGwBWRko0H6rYozsLVnE=;
        b=jcov/AHRFdo4lbeGbr/GDuxuSVXwPr8sIuNoMCCCSI9YjrdlN8aY5m5qpVBaVfI3FG
         hoRnVhHcXXu1lTJBFqBkag2jsRXl8hcNUjEmyf7dbi9KXeEtFBUKS3ZW7WTpoBwWvQR2
         4zrY/BOIiEiZSG+1nzxrmuTV8zUlAnIVQC7dOtJQAwvY482qD2gh+CMLX2bLsS216Hg9
         1s8stSHDPptZLGKMvhbwxYJANYFiwG+ZaQo6jdyyscBjvZ7OQ0UDZVa+k11R0fsZ3u8I
         YYkAeNmDoVFFsqPIrndL3qA8ZDPGDSYU8cS3ESJy9NMED7/Sqy31Aj5NO/0C50t0tGEv
         PU6Q==
X-Gm-Message-State: AOJu0Yz1UQ/Oo+0C3VUQ+DbuhgjXJkLEFUvd6P6uS4veFkf+QaGEbRnH
	6cxIjRI0jNinWJ9DIPGN6wjk3SZISBFrAQ==
X-Google-Smtp-Source: AGHT+IFetsls8FzjWSp5KLTzfxSTL3T5JEQPLM0/AwMnI9lENO9M6v6BjwIZrUGTesqpLC6hw1ICqA==
X-Received: by 2002:a05:6a21:a594:b0:163:9f1d:b464 with SMTP id gd20-20020a056a21a59400b001639f1db464mr12771389pzc.5.1698732042485;
        Mon, 30 Oct 2023 23:00:42 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:42 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 4/6] seccomp: Support attaching BPF_PROG_TYPE_SECCOMP progs
Date: Tue, 31 Oct 2023 01:24:05 +0000
Message-Id: <20231031012407.51371-5-hengqi.chen@gmail.com>
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

Add a new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD for
SECCOMP_SET_MODE_FILTER, which indicates the seccomp filter
is a seccomp bpf prog fd, not a sock_fprog. This allows
us to attach seccomp filter that is previously loaded via
bpf syscall.

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
index dbfc9b37fcae..db792dc96b5a 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -25,6 +25,8 @@
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+/* Indicates that the filter is in form of bpf prog fd */
+#define SECCOMP_FILTER_FLAG_BPF_PROG_FD		(1UL << 6)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 2a724690a627..f88dc7880cfa 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -524,7 +524,10 @@ static inline pid_t seccomp_can_sync_threads(void)
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
@@ -740,6 +743,33 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return filter;
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
@@ -1953,7 +1983,10 @@ static long seccomp_set_mode_filter(unsigned int flags,
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



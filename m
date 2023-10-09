Return-Path: <bpf+bounces-11778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506D7BF097
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 04:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564161C20A4A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7B81E;
	Tue, 10 Oct 2023 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsk2prxx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48538E
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 02:02:36 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E6A8F;
	Mon,  9 Oct 2023 19:02:34 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1dcfe9cd337so2543082fac.2;
        Mon, 09 Oct 2023 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696903353; x=1697508153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd0Jd8fTbfkR1Wny5FqeiXspnLvfaqfYN+8ZoWdzer8=;
        b=Zsk2prxxot7oIGdcv3NB4/x50HPhIfAhtKsh7rCXcxN98zhuLALVW2w4YgOHPX0+lj
         3OeYEMhijcCvpm5ESii97grFFGxE0I0RbQ+k5L0VrFi5YsTwUAIo6XVsqaeY6+IfQ7dB
         NNS0aQtSeZEf0jFMM1olGw8ShYKvcr+ZQ2zAenoQsN+8XiXqrhrmQ32tVdUgG7I9RshN
         qjDEgSxDf9OUz5bw7/3OfwcfmRlA3M4DYAhYfSUjKeAtvgxgcfcVC3ny4haeUagPWF7i
         tZHMoutZkrPmMsHbzDJbQ2SPx6I7YItVYIdLxOkm+efIm55bnTXRlEcW64/0lWOjmdFU
         3jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903353; x=1697508153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd0Jd8fTbfkR1Wny5FqeiXspnLvfaqfYN+8ZoWdzer8=;
        b=c9uHg0LpDaO4jCg/lQvvawiOpyWNjwxe65V4bMrEMB+Vw3UwNEzqXJm0h7Ou/kAH56
         iykRVX/PaUD3nM9FBNiM2uQWP4QLSJybEHW3dYbWp9ebu78zZcUrQ+cg08eDvvDjKQ22
         qn10mavLsC8GWyr/AmqjSHRr4+H1+Z+idXEVnDPZ9XhbzhQhzWdWMYcFJ7wIYVhyYg42
         WangoX76uTKEyCeJXhrcroB5+ACBpaPwjDgyJjrCmreAxs6EvZA1W3gZ5tUGvqQX82Ms
         q55Tjt4eSOYJAqo1IQEeuyEdAQnEnPDnXBubK/O4Tbr2SEUi1OzyxkH8jK58OdcCKLRY
         BbPw==
X-Gm-Message-State: AOJu0YxAnW9gICbGHoyXRBSBL8uDYnJlH/M/91KyI9/NNoNYy/IcguMf
	MN53ZwgWmjYJh2HN1eGoJNkVywlsTdqtTQ==
X-Google-Smtp-Source: AGHT+IHa3ztTr4LysKNQ5kf92fjrKoWeTv7z3kKrWrZo7E1gbohjbHDtypavQ2PblTSE0y7AdUQWPg==
X-Received: by 2002:a05:6870:c0c5:b0:1e0:eb36:a7ed with SMTP id e5-20020a056870c0c500b001e0eb36a7edmr16247567oad.29.1696903353597;
        Mon, 09 Oct 2023 19:02:33 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.112])
        by smtp.googlemail.com with ESMTPSA id t28-20020aa7939c000000b0068a46cd4120sm7044809pfe.199.2023.10.09.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 19:02:33 -0700 (PDT)
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
Subject: [PATCH 3/4] seccomp: Introduce SECCOMP_ATTACH_FILTER operation
Date: Mon,  9 Oct 2023 12:40:45 +0000
Message-Id: <20231009124046.74710-4-hengqi.chen@gmail.com>
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

The SECCOMP_ATTACH_FILTER operation is used to attach
a loaded filter to the current process. The loaded filter
is represented by a fd which is either returned by the
SECCOMP_LOAD_FILTER operation or obtained from bpffs using
bpf syscall.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 68 +++++++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index ee2c83697810..fbe30262fdfc 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -17,6 +17,7 @@
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
 #define SECCOMP_LOAD_FILTER		4
+#define SECCOMP_ATTACH_FILTER		5
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ae43db3b642..9f9d8a7a1d6e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -523,7 +523,10 @@ static inline pid_t seccomp_can_sync_threads(void)
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
@@ -894,7 +897,7 @@ static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
 #endif /* SECCOMP_ARCH_NATIVE */
 
 /**
- * seccomp_attach_filter: validate and attach filter
+ * seccomp_do_attach_filter: validate and attach filter
  * @flags:  flags to change filter behavior
  * @filter: seccomp filter to add to the current process
  *
@@ -905,8 +908,8 @@ static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
  *     seccomp mode or did not have an ancestral seccomp filter
  *   - in NEW_LISTENER mode: the fd of the new listener
  */
-static long seccomp_attach_filter(unsigned int flags,
-				  struct seccomp_filter *filter)
+static long seccomp_do_attach_filter(unsigned int flags,
+				     struct seccomp_filter *filter)
 {
 	unsigned long total_insns;
 	struct seccomp_filter *walker;
@@ -2001,7 +2004,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		goto out;
 	}
 
-	ret = seccomp_attach_filter(flags, prepared);
+	ret = seccomp_do_attach_filter(flags, prepared);
 	if (ret)
 		goto out;
 	/* Do not free the successfully attached filter. */
@@ -2058,6 +2061,51 @@ static long seccomp_load_filter(const char __user *filter)
 		bpf_prog_put(prog);
 	return ret;
 }
+
+static long seccomp_attach_filter(const char __user *ufd)
+{
+	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
+	struct seccomp_filter *sfilter;
+	struct bpf_prog *prog;
+	int flags = 0;
+	int fd, ret;
+
+	if (copy_from_user(&fd, ufd, sizeof(fd)))
+		return -EFAULT;
+
+	prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SECCOMP);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	sfilter = kzalloc(sizeof(*sfilter), GFP_KERNEL | __GFP_NOWARN);
+	if (!sfilter) {
+		bpf_prog_put(prog);
+		return -ENOMEM;
+	}
+
+	sfilter->prog = prog;
+	refcount_set(&sfilter->refs, 1);
+	refcount_set(&sfilter->users, 1);
+	mutex_init(&sfilter->notify_lock);
+	init_waitqueue_head(&sfilter->wqh);
+
+	spin_lock_irq(&current->sighand->siglock);
+
+	ret = -EINVAL;
+	if (!seccomp_may_assign_mode(seccomp_mode))
+		goto out;
+
+	ret = seccomp_do_attach_filter(flags, sfilter);
+	if (ret)
+		goto out;
+
+	sfilter = NULL;
+	seccomp_assign_mode(current, seccomp_mode, flags);
+out:
+	spin_unlock_irq(&current->sighand->siglock);
+	seccomp_filter_free(sfilter);
+	return ret;
+}
 #else
 static inline long seccomp_set_mode_filter(unsigned int flags,
 					   const char __user *filter)
@@ -2069,6 +2117,11 @@ static inline long seccomp_load_filter(const char __user *filter)
 {
 	return -EINVAL;
 }
+
+static inline long seccomp_attach_filter(const char __user *ufd)
+{
+	return -EINVAL;
+}
 #endif
 
 static long seccomp_get_action_avail(const char __user *uaction)
@@ -2135,6 +2188,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_load_filter(uargs);
+	case SECCOMP_ATTACH_FILTER:
+		if (flags != 0)
+			return -EINVAL;
+
+		return seccomp_attach_filter(uargs);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1



Return-Path: <bpf+bounces-4505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984674BBB3
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 06:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355E9281A06
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBB23D9;
	Sat,  8 Jul 2023 04:08:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986715C4;
	Sat,  8 Jul 2023 04:08:18 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234D2115;
	Fri,  7 Jul 2023 21:08:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579d5d89b41so31190577b3.2;
        Fri, 07 Jul 2023 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688789295; x=1691381295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/1ppc1+fQOwKtdkvy2jg3fPFdLjpoPEZefNDxsHMnI=;
        b=amywClrnsUFfS63X28sRzb6/e/tWGVSej8NBmom7ND1us44qjuX7WVF3gstVAg9KXq
         1xj2zigFAEECUvY6wCTp1tEazUM1x37QbJL1OSPhLUC8YHP1Yx13ZIrtIqU72Owf99K5
         MMRxRZrn4LJQq5xi16obDfu4L7bAeGJlnPZOcG2vQ19SjiBurmhTf/GFTYdxCGSO5NWL
         k9lYj0x4hm9pl4m1QmwCd4a3w9NK9G+DxIRFMhDhdyyR0vHaBfx6PVeetIjUkXcHQxrF
         hHH+eaknzDlKRtLVGXaLmwDddTGgsbAGX2XRcJWrBjcwi+SmiAAH8rMuSIVCSjgb9oMk
         AavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688789295; x=1691381295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/1ppc1+fQOwKtdkvy2jg3fPFdLjpoPEZefNDxsHMnI=;
        b=hZdJwPTwtQnAebVFAv4eAEOLvnHdq2MpblQXkpNErQiLAWYe0oh4QQiVV4Pg39qcad
         p559Vf+Xg8gLLEUlHqgyPD63oYTE6tb8+ADdaOeFsW+2IBgKUCxDJpCrze++5e9d79ia
         Kh3/J5XGQ3mY3hFskuVhcY+bcslgoyyfDduWCoYvmIzII7bJ/ZvhyrzXaCeEfG55roVr
         cFyZ+a53KaKQ3ThcFonZGz2OD/MxvJlaPmOF+ps2wGXW40NTc78uo/gHJcMG+q1jZvvA
         2XkWXuQFWTDSR6nuV6rPubJl9/4Zd1GtJCk0RNtJ0nmepkG3ZbJ1tpYifTi2RPq2BZNH
         pW9w==
X-Gm-Message-State: ABy/qLZkOdh6pO59Gzs9NWrn9ixzJm7DmyQes5fJ7sf1dof+8gTG538F
	8TCo58IvIV24sHEUvSorLMk=
X-Google-Smtp-Source: APBJJlHRCVMVxdZ84OZZgUFndYKeVLUHyQhOF0C6yJk1vRxgpNdFz55+HkFGXqBWRuINYt6C1o+Qjg==
X-Received: by 2002:a0d:d50b:0:b0:56d:1528:c56f with SMTP id x11-20020a0dd50b000000b0056d1528c56fmr6788851ywd.16.1688789295113;
        Fri, 07 Jul 2023 21:08:15 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id v12-20020a62a50c000000b00640f51801e6sm3507814pfm.159.2023.07.07.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 21:08:14 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] bpf: Introduce bpf user log
Date: Sat,  8 Jul 2023 12:07:50 +0800
Message-ID: <20230708040750.72570-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708040750.72570-1-hffilwlqm@gmail.com>
References: <20230708040750.72570-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 42c4e63ef36ea9b5ae50 (bpf: Introduce bpf generic log) is
introduced to back propagate the error message in dev_xdp_attach() to
user space when users provide buffer to receive the error message.
But it breaks uapi and exposes many log details in header file.

To overcome the shortcomings, a) make the struct bpf_generic_user_log
as one field of the union in link_create of struct bpf_attr, b) hide
log details in log_ulog_once() and let its declaration in header file.

Furthermore, it's not a good idea to reuse bpf_verifier_log infra. Or, a
warning comes up:

net/core/dev.c: In function 'bpf_xdp_link_log.isra.0':
net/core/dev.c:9093:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
 9093 | }
      |

As a result, a small kernel buffer, like 256 bytes, is preferred to
cache error message, then copy_to_user().

Then, unlike verifier to provide more and more error details, bpf user
log is only able to provide a simple error message limit 255 chars for
every time.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/bpf.h            | 31 ++-------------------------
 include/uapi/linux/bpf.h       |  4 +++-
 kernel/bpf/log.c               | 39 +++++++++++++++++++++++++---------
 net/core/dev.c                 |  9 +-------
 tools/include/uapi/linux/bpf.h |  4 +++-
 5 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7d2124a537943..36af7cc89cafc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3107,34 +3107,7 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
-#define BPF_GENERIC_TMP_LOG_SIZE	256
-
-struct bpf_generic_log {
-	char		kbuf[BPF_GENERIC_TMP_LOG_SIZE];
-	char __user	*ubuf;
-	u32		len_used;
-	u32		len_total;
-};
-
-__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
-			const char *fmt, ...);
-static inline void bpf_generic_log_init(struct bpf_generic_log *log,
-			const struct bpf_generic_user_log *ulog)
-{
-	log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
-	log->len_total = ulog->log_size;
-	log->len_used = 0;
-}
-
-#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)	do {	\
-	const char *____fmt = (fmt);				\
-	bpf_generic_log_init(log, ulog);			\
-	bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);	\
-} while (0)
-
-#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)	do {			\
-	struct bpf_generic_log ____log;					\
-	BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);	\
-} while (0)
+__printf(2, 3) void bpf_ulog_once(const struct bpf_generic_user_log *ulog,
+				  const char *fmt, ...);
 
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 34fa334938ba5..8a458cfcd91bd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1549,7 +1549,6 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
-		struct bpf_generic_user_log log; /* user log */
 		union {
 			__u32		target_btf_id;	/* btf_id of target to attach to */
 			struct {
@@ -1585,6 +1584,9 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				struct bpf_generic_user_log ulog; /* user log */
+			} xdp;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index be56b153bbf0b..4d197b52ea207 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -326,15 +326,32 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 }
 EXPORT_SYMBOL_GPL(bpf_log);
 
-static inline void __bpf_generic_log_write(struct bpf_generic_log *log, const char *fmt,
-				      va_list args)
+#define BPF_USER_TMP_LOG_SIZE	256
+
+struct bpf_user_log {
+	char		kbuf[BPF_USER_TMP_LOG_SIZE];
+	char __user	*ubuf;
+	u32		len_used;
+	u32		len_total;
+};
+
+static inline void bpf_ulog_init(struct bpf_user_log *log,
+				 const struct bpf_generic_user_log *ulog)
+{
+	log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
+	log->len_total = ulog->log_size;
+	log->len_used = 0;
+}
+
+static inline void bpf_ulog_write(struct bpf_user_log *log,
+				  const char *fmt, va_list args)
 {
 	unsigned int n;
 
-	n = vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
+	n = vscnprintf(log->kbuf, BPF_USER_TMP_LOG_SIZE, fmt, args);
 
-	WARN_ONCE(n >= BPF_GENERIC_TMP_LOG_SIZE - 1,
-		  "bpf generic log truncated - local buffer too short\n");
+	WARN_ONCE(n >= BPF_USER_TMP_LOG_SIZE - 1,
+		  "bpf user log line truncated - local buffer too short\n");
 
 	n = min(log->len_total - log->len_used - 1, n);
 	log->kbuf[n] = '\0';
@@ -345,16 +362,18 @@ static inline void __bpf_generic_log_write(struct bpf_generic_log *log, const ch
 		log->ubuf = NULL;
 }
 
-__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
-				     const char *fmt, ...)
+__printf(2, 3) void bpf_ulog_once(const struct bpf_generic_user_log *ulog,
+				  const char *fmt, ...)
 {
+	struct bpf_user_log log;
 	va_list args;
 
-	if (!log->ubuf || !log->len_total)
+	if (!ulog->log_buf || !ulog->log_size)
 		return;
 
+	bpf_ulog_init(&log, ulog);
 	va_start(args, fmt);
-	__bpf_generic_log_write(log, fmt, args);
+	bpf_ulog_write(&log, fmt, args);
 	va_end(args);
 }
-EXPORT_SYMBOL_GPL(bpf_generic_log_write);
+EXPORT_SYMBOL_GPL(bpf_ulog_once);
diff --git a/net/core/dev.c b/net/core/dev.c
index e933809c0a72f..311d3f3bc11b6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9409,13 +9409,6 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };
 
-static inline void bpf_xdp_link_log(const union bpf_attr *attr, struct netlink_ext_ack *extack)
-{
-	const struct bpf_generic_user_log *ulog = &attr->link_create.log;
-
-	BPF_GENERIC_ULOG_WRITE(ulog, extack->_msg);
-}
-
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -9454,7 +9447,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
-		bpf_xdp_link_log(attr, &extack);
+		bpf_ulog_once(&attr->link_create.xdp.ulog, extack._msg);
 		goto out_put_dev;
 	}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 34fa334938ba5..b81508bf758fa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1549,7 +1549,6 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
-		struct bpf_generic_user_log log; /* user log */
 		union {
 			__u32		target_btf_id;	/* btf_id of target to attach to */
 			struct {
@@ -1585,6 +1584,9 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				struct bpf_generic_user_log ulog;  /* user log */
+			} xdp;
 		};
 	} link_create;
 
-- 
2.41.0



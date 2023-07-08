Return-Path: <bpf+bounces-4504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692D74BBB1
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 06:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671C01C21123
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C91FAD;
	Sat,  8 Jul 2023 04:08:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E91C07;
	Sat,  8 Jul 2023 04:08:11 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17619B2;
	Fri,  7 Jul 2023 21:08:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ed230c81so2067628b3a.0;
        Fri, 07 Jul 2023 21:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688789289; x=1691381289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+ldNdA6+obO0I/B0GkfPM7nI7kCzFpDBIKc57cG97U=;
        b=BEXD75AF2J5nYvTpitflqXVlbmQhk7Ptm12ZYmBNfygoKZi64BcA92g/tp5nJC1rm/
         Cb6IXEfq9JvnFcwWBJ3149071TGsTtbcvJFVpA68K62YnOs+cEmoDWuzXWY5T8flyzH1
         lnKQrw08KH3FB3dVxvi23VcO8vnjNMTFFeH/a/glgcwIsat4+GK5tacwrg0QHrFnyNz/
         mC1J6LEOSyPatTBF9l5sjgZWTuQ8SZ5wuvC3MWi5VgtGrTTVYzihJJSEsR0Vmk1X35Wr
         biQIA6w2oOyk7SZGQiGSFsYU5iiC2Y3cVL+lC7lVmEQTRxPc73+9T5aJksaNgdXWxpZW
         ltPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688789289; x=1691381289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+ldNdA6+obO0I/B0GkfPM7nI7kCzFpDBIKc57cG97U=;
        b=gHZZN2myAOtH+03yu+QDQP95UPP52kMhAe5VKpiVzUHVSwglzEyBFNOH3fN8PAA2IW
         oci6b4FlM3jEpq8UU5UAlit3J6LxMtO8mgbuftt29SyNQKIxGqy4AUwHss9XzrYjw+w8
         Fe3ZALRlsApH+8m26Bdj4bg2Wg/8G6Fndl4cUownHe9bZtAGLH09D4SuV2nhMlqR3v1b
         1IXTLluU2EojIteA1pR9Ox1VXIaEr0ON9Sb9UKYusCxUAJggeQ/nT2j5dmQRZaVbZAnI
         rSnXNYMYDjS3JiJt8NqxA+H5jKVRxmRbjzszTAuXpTTL9uNhjj476NvCdbI3ZNPxopEZ
         JQfA==
X-Gm-Message-State: ABy/qLa6DkPFk0Da5qAf3pxE5OkN7aDxMAt3HGSvzBSKAgq9zX0VZzgY
	kYWNxJQM9r+Vpm7OecQAXhs=
X-Google-Smtp-Source: APBJJlFlT+VTUdMBGrqbJg6AhXk08tXb8LCSpOcA6gZ1198dnipYUPWwcjqQYve6mTvTXEAnMogM0w==
X-Received: by 2002:a05:6a00:1803:b0:666:ae6b:c484 with SMTP id y3-20020a056a00180300b00666ae6bc484mr9067626pfa.13.1688789289202;
        Fri, 07 Jul 2023 21:08:09 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id v12-20020a62a50c000000b00640f51801e6sm3507814pfm.159.2023.07.07.21.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 21:08:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Introduce bpf generic log
Date: Sat,  8 Jul 2023 12:07:49 +0800
Message-ID: <20230708040750.72570-2-hffilwlqm@gmail.com>
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

Currently, excluding verifier, users are unable to obtain detailed error
information when issues occur in BPF syscall.

To overcome this limitation, bpf generic log is introduced to provide
error details similar to the verifier. This enhancement will enable the
reporting of error details along with the corresponding errno in BPF
syscall.

Essentially, bpf generic log functions as a mechanism similar to netlink,
enabling the transmission of error messages to user space. This
mechanism greatly enhances the usability of BPF syscall by allowing
users to access comprehensive error messages instead of relying solely
on errno.

This patch specifically addresses the error reporting in dev_xdp_attach()
. With this patch, the error messages will be transferred to user space
like the netlink approach. Hence, users will be able to check the error
message along with the errno.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 ++++++
 kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
 net/core/dev.c                 | 11 ++++++++++-
 tools/include/uapi/linux/bpf.h |  6 ++++++
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 360433f14496a..7d2124a537943 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3107,4 +3107,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+#define BPF_GENERIC_TMP_LOG_SIZE	256
+
+struct bpf_generic_log {
+	char		kbuf[BPF_GENERIC_TMP_LOG_SIZE];
+	char __user	*ubuf;
+	u32		len_used;
+	u32		len_total;
+};
+
+__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
+			const char *fmt, ...);
+static inline void bpf_generic_log_init(struct bpf_generic_log *log,
+			const struct bpf_generic_user_log *ulog)
+{
+	log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
+	log->len_total = ulog->log_size;
+	log->len_used = 0;
+}
+
+#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)	do {	\
+	const char *____fmt = (fmt);				\
+	bpf_generic_log_init(log, ulog);			\
+	bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)	do {			\
+	struct bpf_generic_log ____log;					\
+	BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeabb..34fa334938ba5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_generic_user_log {
+	__aligned_u64	log_buf;    /* user supplied buffer */
+	__u32		log_size;   /* size of user buffer */
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 union bpf_attr {
@@ -1544,6 +1549,7 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
+		struct bpf_generic_user_log log; /* user log */
 		union {
 			__u32		target_btf_id;	/* btf_id of target to attach to */
 			struct {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 850494423530e..be56b153bbf0b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -325,3 +325,36 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 	va_end(args);
 }
 EXPORT_SYMBOL_GPL(bpf_log);
+
+static inline void __bpf_generic_log_write(struct bpf_generic_log *log, const char *fmt,
+				      va_list args)
+{
+	unsigned int n;
+
+	n = vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
+
+	WARN_ONCE(n >= BPF_GENERIC_TMP_LOG_SIZE - 1,
+		  "bpf generic log truncated - local buffer too short\n");
+
+	n = min(log->len_total - log->len_used - 1, n);
+	log->kbuf[n] = '\0';
+
+	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
+		log->len_used += n;
+	else
+		log->ubuf = NULL;
+}
+
+__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
+				     const char *fmt, ...)
+{
+	va_list args;
+
+	if (!log->ubuf || !log->len_total)
+		return;
+
+	va_start(args, fmt);
+	__bpf_generic_log_write(log, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(bpf_generic_log_write);
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c4..e933809c0a72f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9409,12 +9409,20 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };
 
+static inline void bpf_xdp_link_log(const union bpf_attr *attr, struct netlink_ext_ack *extack)
+{
+	const struct bpf_generic_user_log *ulog = &attr->link_create.log;
+
+	BPF_GENERIC_ULOG_WRITE(ulog, extack->_msg);
+}
+
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
+	struct netlink_ext_ack extack;
 	int err, fd;
 
 	rtnl_lock();
@@ -9440,12 +9448,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	err = dev_xdp_attach_link(dev, NULL, link);
+	err = dev_xdp_attach_link(dev, &extack, link);
 	rtnl_unlock();
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
+		bpf_xdp_link_log(attr, &extack);
 		goto out_put_dev;
 	}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeabb..34fa334938ba5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_generic_user_log {
+	__aligned_u64	log_buf;    /* user supplied buffer */
+	__u32		log_size;   /* size of user buffer */
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 union bpf_attr {
@@ -1544,6 +1549,7 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
+		struct bpf_generic_user_log log; /* user log */
 		union {
 			__u32		target_btf_id;	/* btf_id of target to attach to */
 			struct {
-- 
2.41.0



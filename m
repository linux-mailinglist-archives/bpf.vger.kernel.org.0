Return-Path: <bpf+bounces-73455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E6C32065
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B146A18C40EE
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751C3321DC;
	Tue,  4 Nov 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KP7zvD0O"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B43314CD
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273329; cv=none; b=d7u1ssjiDKWCPZfoxMle9HN+xMpGRtgTew7W5HguzKX1R+6Ajbm23oew3XCFrRCE7akRsgeyeLKqmTCtuX+dn8RnMRRsTK6NiWLURohrkS2urbqNZBfcwvvI9De8piRlAX4p8hiqamJRqzrn1o+9S2i16IcARzQTh25Sfq7z6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273329; c=relaxed/simple;
	bh=s3/L7hOPRT6LdQxQWdJmRjyKi6srJdbmS50OF+DX2Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7bW/fL39hdLT94D889JWy7jcLsDs/ssYex0vdHchE5LLsSspRNdBbMGpuwM8ccg/HVKgBTG173BZzsZlxE/+/eJXon1YZnTpPpEF1OSTtxNWqyQnlDnIxRLHmxETR57ZdG3TXIFss+gOMnGeyUq1VFsJTFn+/HVKt9NPjONA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KP7zvD0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762273323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evMKz5qC9XLINgDgg1BWI440E28hVWWZmi3b/nQwb48=;
	b=KP7zvD0OJtLuDGdYYoKrEHSzvSIq0hdQyS2ZEHJ8qQMBXWUDrY87GIwUhDp5k3FZBmYwyk
	QVwInyQtNsPDuk9Mw8ZKk/fdKR+wrj9QQ/nr4uBpu6pPNJtmb0ZljRUum17Wm7HBh+gTqH
	JUE1edBT3PTbp8RAgwn8k3hLHr/SZxs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-7G9Rav0EMNysQS6PQ5bltQ-1; Tue,
 04 Nov 2025 11:21:59 -0500
X-MC-Unique: 7G9Rav0EMNysQS6PQ5bltQ-1
X-Mimecast-MFC-AGG-ID: 7G9Rav0EMNysQS6PQ5bltQ_1762273318
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 941351954B00;
	Tue,  4 Nov 2025 16:21:58 +0000 (UTC)
Received: from localhost (unknown [10.72.120.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58FB2300019F;
	Tue,  4 Nov 2025 16:21:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] io_uring: bpf: add io_uring_ctx setup for BPF into one list
Date: Wed,  5 Nov 2025 00:21:17 +0800
Message-ID: <20251104162123.1086035-3-ming.lei@redhat.com>
In-Reply-To: <20251104162123.1086035-1-ming.lei@redhat.com>
References: <20251104162123.1086035-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add io_uring_ctx setup for BPF into one list, and prepare for syncing
bpf struct_ops register and un-register.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring_types.h |  5 +++++
 include/uapi/linux/io_uring.h  |  5 +++++
 io_uring/bpf.c                 | 15 +++++++++++++++
 io_uring/io_uring.c            |  7 +++++++
 io_uring/io_uring.h            |  3 ++-
 io_uring/uring_bpf.h           | 11 +++++++++++
 6 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 92780764d5fa..d2e098c3fd2c 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -465,6 +465,11 @@ struct io_ring_ctx {
 	struct io_mapped_region		ring_region;
 	/* used for optimised request parameter and wait argument passing  */
 	struct io_mapped_region		param_region;
+
+#ifdef CONFIG_IO_URING_BPF
+	/* added to uring_bpf_ctx_list */
+	struct list_head		bpf_node;
+#endif
 };
 
 /*
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b167c1d4ce6e..b8c49813b4e5 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -237,6 +237,11 @@ enum io_uring_sqe_flags_bit {
  */
 #define IORING_SETUP_SQE_MIXED		(1U << 19)
 
+/*
+ * Allow to submit bpf IO
+ */
+#define IORING_SETUP_BPF		(1U << 20)
+
 enum io_uring_op {
 	IORING_OP_NOP,
 	IORING_OP_READV,
diff --git a/io_uring/bpf.c b/io_uring/bpf.c
index 8c47df13c7b5..bb1e37d1e804 100644
--- a/io_uring/bpf.c
+++ b/io_uring/bpf.c
@@ -7,6 +7,9 @@
 #include "io_uring.h"
 #include "uring_bpf.h"
 
+static DEFINE_MUTEX(uring_bpf_ctx_lock);
+static LIST_HEAD(uring_bpf_ctx_list);
+
 int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -ECANCELED;
@@ -24,3 +27,15 @@ void io_uring_bpf_fail(struct io_kiocb *req)
 void io_uring_bpf_cleanup(struct io_kiocb *req)
 {
 }
+
+void uring_bpf_add_ctx(struct io_ring_ctx *ctx)
+{
+	guard(mutex)(&uring_bpf_ctx_lock);
+	list_add(&ctx->bpf_node, &uring_bpf_ctx_list);
+}
+
+void uring_bpf_del_ctx(struct io_ring_ctx *ctx)
+{
+	guard(mutex)(&uring_bpf_ctx_lock);
+	list_del(&ctx->bpf_node);
+}
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3f0489261d11..38f03f6c28cb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -105,6 +105,7 @@
 #include "rw.h"
 #include "alloc_cache.h"
 #include "eventfd.h"
+#include "uring_bpf.h"
 
 #define SQE_COMMON_FLAGS (IOSQE_FIXED_FILE | IOSQE_IO_LINK | \
 			  IOSQE_IO_HARDLINK | IOSQE_ASYNC)
@@ -352,6 +353,9 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	io_napi_init(ctx);
 	mutex_init(&ctx->mmap_lock);
 
+	if (ctx->flags & IORING_SETUP_BPF)
+		uring_bpf_add_ctx(ctx);
+
 	return ctx;
 
 free_ref:
@@ -2855,6 +2859,9 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	if (!(ctx->flags & IORING_SETUP_NO_SQARRAY))
 		static_branch_dec(&io_key_has_sqarray);
 
+	if (ctx->flags & IORING_SETUP_BPF)
+		uring_bpf_del_ctx(ctx);
+
 	percpu_ref_exit(&ctx->refs);
 	free_uid(ctx->user);
 	io_req_caches_free(ctx);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 23c268ab1c8f..4baf21a9e1ee 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -55,7 +55,8 @@
 			IORING_SETUP_NO_SQARRAY |\
 			IORING_SETUP_HYBRID_IOPOLL |\
 			IORING_SETUP_CQE_MIXED |\
-			IORING_SETUP_SQE_MIXED)
+			IORING_SETUP_SQE_MIXED |\
+			IORING_SETUP_BPF)
 
 #define IORING_ENTER_FLAGS (IORING_ENTER_GETEVENTS |\
 			IORING_ENTER_SQ_WAKEUP |\
diff --git a/io_uring/uring_bpf.h b/io_uring/uring_bpf.h
index bde774ce6ac0..b6cda6df99b1 100644
--- a/io_uring/uring_bpf.h
+++ b/io_uring/uring_bpf.h
@@ -7,6 +7,10 @@ int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 void io_uring_bpf_fail(struct io_kiocb *req);
 void io_uring_bpf_cleanup(struct io_kiocb *req);
+
+void uring_bpf_add_ctx(struct io_ring_ctx *ctx);
+void uring_bpf_del_ctx(struct io_ring_ctx *ctx);
+
 #else
 static inline int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags)
 {
@@ -22,5 +26,12 @@ static inline void io_uring_bpf_fail(struct io_kiocb *req)
 static inline void io_uring_bpf_cleanup(struct io_kiocb *req)
 {
 }
+
+static inline void uring_bpf_add_ctx(struct io_ring_ctx *ctx)
+{
+}
+static inline void uring_bpf_del_ctx(struct io_ring_ctx *ctx)
+{
+}
 #endif
 #endif
-- 
2.47.0



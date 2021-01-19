Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E079B2FBBE3
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbhASQCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 11:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391657AbhASQAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 11:00:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7FC0613CF
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 08:00:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so20234929wrb.12
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ot9CUP1ymhBCu8386W9qmQ0NwDwxyv0SyXxltUHXBgI=;
        b=Sj0iIG08ajo9fKdvvsgHy+IzD/vnectYExDwo9m1n5a7PzvC3sozWhx45xer6h4SfA
         l2V/45GJml7nZ2gp6Inn8rAnsipVldPJfFUfBun1hwzegUqFXkgIfecQNEwLHy6Cv+dl
         5nqMJVmdKwvmS1v9v+Gd/7TEdjmDULloVxCQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ot9CUP1ymhBCu8386W9qmQ0NwDwxyv0SyXxltUHXBgI=;
        b=Z9gGHgUUz0eJxOlSseMZuRn4acxEiZZHUNl1KZFltu9s6htOq7KzY6KVG0/0wa40PG
         UVaa2otUxC4v7kVSkw4gsQdif58XpJHqCBGNoYelgY9Ak75udZkFJVJ8DMVtZf9q3pRq
         JJT4/jNrFuzjkdYUixsx/LVWueDZF4a4FSqliKrGT0kt6cXlwOKTV33CAU4qKkyHNWCB
         XvrjoOJU/10TtZ4XpCxI5zgEZ6rPglLpNcANuS2LbAGYINNIs7aqZTbOlHTPgVuOBUu4
         znQBZEn6BHUt43PBPvvxvyzAoLQF6BuKoO0+unQRcL+WYJCjjdvWTYKUqGUDqRfxO5Cs
         VjAg==
X-Gm-Message-State: AOAM532Hn3TrWjVcM8iTZqR4m/PAvnhnfliqNH8PsiPV9h18ZSx492jo
        j3sPJ0ILON5khjf/hjOwiq+glT6qnTZ5xQ==
X-Google-Smtp-Source: ABdhPJxjtexve1pYCvls389OEXZEGBr3Zg2E3Va5xnIaEtxh4LERJorQ6OhDzpuEycUtNPFpNKf73g==
X-Received: by 2002:adf:9427:: with SMTP id 36mr5045027wrq.271.1611072007046;
        Tue, 19 Jan 2021 08:00:07 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:81f8:2ac6:58bf:7d7a])
        by smtp.gmail.com with ESMTPSA id n11sm41454944wra.9.2021.01.19.08.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:00:06 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 2/4] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Tue, 19 Jan 2021 16:59:51 +0100
Message-Id: <20210119155953.803818-2-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119155953.803818-1-revest@chromium.org>
References: <20210119155953.803818-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This needs a new helper that:
- can work in a sleepable context (using sock_gen_cookie)
- takes a struct sock pointer and checks that it's not NULL

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 12 ++++++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 5 files changed, 31 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1aac2af12fed..26219465e1f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1874,6 +1874,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
+extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0b735c2729b2..5855c398d685 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1673,6 +1673,14 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**. This helper
+ * 		also works for sleepable programs.
+ * 	Return
+ * 		A 8-byte long unique number or 0 if *sk* is NULL.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6c0018abe68a..845b2168e006 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1760,6 +1760,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_delete_tracing_proto;
 	case BPF_FUNC_sock_from_file:
 		return &bpf_sock_from_file_proto;
+	case BPF_FUNC_get_socket_cookie:
+		return &bpf_get_socket_ptr_cookie_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 9ab94e90d660..606e2b6115ed 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4631,6 +4631,18 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
+{
+	return sk ? sock_gen_cookie(sk) : 0;
+}
+
+const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
+	.func		= bpf_get_socket_ptr_cookie,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+};
+
 BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
 {
 	return __sock_gen_cookie(ctx->sk);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0b735c2729b2..5855c398d685 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1673,6 +1673,14 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**. This helper
+ * 		also works for sleepable programs.
+ * 	Return
+ * 		A 8-byte long unique number or 0 if *sk* is NULL.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
-- 
2.30.0.284.gd98b1dd5eaa7-goog


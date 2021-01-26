Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A232305BFD
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 13:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313994AbhAZWxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391503AbhAZSii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1DC061351
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j18so3331302wmi.3
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xe88bJuZRHaIbqN+XIl5v5yCRgmB1nsis6SWYY4CKbs=;
        b=RAPatrXv53+JvGthxYIDxaElzER2OTsc7nueyvk9ajCHTLSHljnPMsj9IO8iNUswnc
         hupUO9xC7rNONu4oSY981zHn1o38snKecvxE5cWEENguoKYh8gjbB4lQr8u/1vPiEPDC
         V+dNxT1Wrcdt+Ujr9zWTI6nIrsb8DZsYTzpFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xe88bJuZRHaIbqN+XIl5v5yCRgmB1nsis6SWYY4CKbs=;
        b=DQgeT2mSc2UxiBzn/Gf8uK7svB2BPlyHKDr+6T/O9OOzxSW3cpxAiRQQsaTM7eewnH
         k6n5GE1CwPIigRgOAsO7XQ1vmbI7R3xcdFAsu2EBiiDbU/XLaFuHQ9wCbCTiBga70Kur
         acNTDJlmTywJxgvO4SIVJ1VfCej1Ipr4v1++o/tI/IsqQKnuaRGZ9lqB7zpofIN3pmwO
         EVfAtSgwHyF+Sci5YySLwE2v6AyMg/YnS18zjDdsYqqVxdJNfUkrJ9to0olzc+2oelV7
         8OOHzY14AinV4mDx/ZlGb4RwGO05fi+/uBY5M5DnZakyPZ01YVvja8jj9eQM8ymyAoRm
         OQsQ==
X-Gm-Message-State: AOAM533vR/OUC9e8t/0oDV+hHm1/yzGbF8oBZbamYz7d+0Az5U8Y5YXa
        XQ941viKEii3Qlf20skU+6Yt7kvbz45I2w==
X-Google-Smtp-Source: ABdhPJx56rHHJuTMeL0o2IcKPI0yMrS6PaWuANnUKIsLRwG6nKAyoFJpYx0Nt6h9Dh1aOmjpLoAxKA==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr934336wme.76.1611686167915;
        Tue, 26 Jan 2021 10:36:07 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:deb:d0ec:3143:2380])
        by smtp.gmail.com with ESMTPSA id d13sm28339354wrx.93.2021.01.26.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:36:07 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v6 2/5] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Tue, 26 Jan 2021 19:35:56 +0100
Message-Id: <20210126183559.1302406-2-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126183559.1302406-1-revest@chromium.org>
References: <20210126183559.1302406-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This needs a new helper that:
- can work in a sleepable context (using sock_gen_cookie)
- takes a struct sock pointer and checks that it's not NULL

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: KP Singh <kpsingh@kernel.org>
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
2.30.0.280.ga3ce27912f-goog


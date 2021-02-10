Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235BA3164FC
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBJLSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 06:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhBJLQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 06:16:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B041C061222
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:14:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so2029102wrx.4
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aEkhdihSwfhxGxg05o1OOrjqP2aU9xjhYWHyFiwC/aU=;
        b=hN8KzzcSb2zddgiPUqOecwx8mVFF8Zn4rKQsXnDt/0C4pEOaPaNZ56n6SvgTgt0GAj
         0LHyzzWRFwAcy/IST+jUQ4RXrWHHL4P9Yg0jvDYkkUNpoF9hyehKAkJ3LC7jKMpTgqfW
         CsiPdxq0NiXPzdWdi72wYbPbc6x5BCvoe+RtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEkhdihSwfhxGxg05o1OOrjqP2aU9xjhYWHyFiwC/aU=;
        b=dBwf2DVpgX08Og5W/Cn9VdnyZuFHg7sV8ws0f0J2zT6Xly+ZCsC8x/6i5yvjRZ9yLV
         qwQMwySkebUrCeqwmu3BTKahUpcMWPdMndSWO/IXX9yv0rfSGDlNCVzw7oLlWiDKfQB7
         inodVKdhy9BPDUbBBRrHo8VxDybYrKKPafwRuE5MUuJRMleylxg1t91KG94VOdWxnLx7
         98it6B3dBv6qFHYn9U3W+eYOJY/ouy9jnAiZL2tZAOtOLqRZ7ssfEobUg2Ibsem6/EGT
         y0tmMW1htJ0exZ9CLiR4pKKLuc4g0xTLSpF2Wtmozjz4WFdVzK0tvd8aWe91NrY+zyk0
         wang==
X-Gm-Message-State: AOAM532xQNFT0D/g+8+i+BqmEk0Rf6eXHQiAYIFLNrY2njU2FAEkzlSS
        PjZ4mt0mcIHMKF9ZZkKHGE23mXvjRKVkoQ==
X-Google-Smtp-Source: ABdhPJzj3HQGXP7H0JsVQ7vEj5VaWyUhXpwolnLdpHKqbkF6AW1u1OV5fywDVX0eDEp/aAm9Knvevw==
X-Received: by 2002:a05:6000:1816:: with SMTP id m22mr2995427wrh.91.1612955675051;
        Wed, 10 Feb 2021 03:14:35 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:31ae:b3c8:8fe:5f4d])
        by smtp.gmail.com with ESMTPSA id u10sm1907633wmj.40.2021.02.10.03.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:14:34 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v7 2/5] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Wed, 10 Feb 2021 12:14:03 +0100
Message-Id: <20210210111406.785541-2-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210111406.785541-1-revest@chromium.org>
References: <20210210111406.785541-1-revest@chromium.org>
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
index 321966fc35db..d212ae7d9731 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1888,6 +1888,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
+extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0b735c2729b2..a8d9ad543300 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1673,6 +1673,14 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(struct sock *sk)
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
index e15d4741719a..57aaed478362 100644
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
index 0b735c2729b2..a8d9ad543300 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1673,6 +1673,14 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(struct sock *sk)
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
2.30.0.478.g8a0d178c01-goog


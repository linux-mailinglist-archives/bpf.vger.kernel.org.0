Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A92D3386
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgLHUUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgLHURx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 15:17:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83985C0611CE
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 12:17:23 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so3047565wml.1
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 12:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNo7zSocoGfrZcMTh73Kz+apVzkA0NpS7eQRHdoNXJw=;
        b=Qm6efZliPq8rtauv/WGa7f4m/RdhsgMknqz2WV9mMA3T0oxkj58+y8a1519dXQ1pyo
         p/Wxcd95kaWomCg5e7tvJY+roQF8czFaAdYcanUInV04JddNXRUDWcOukiHCZD0BxPBz
         CKdSFgtxOC6q7+BLF7ItkhV69ntY7rA9XeCGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNo7zSocoGfrZcMTh73Kz+apVzkA0NpS7eQRHdoNXJw=;
        b=LpUZTlspa8BBTkD5PuQ6vPyv/mRFXFrR07LjsDwqpOfUFL7mwZ0HvmBTMGEllu44Hj
         NjKIUSxmppsuSoDCQT+i3WlbjY5RGw5jViFRbuFhckDm46h2LZF38T84zH7y03OKEUTf
         +PbiX+Ue9sJA8PZHdkNLDQ88MIEnO0ZX4x4p7dslKMB9VPV2AyNQjB81MRIxDdtMU8GK
         Le5hZcB7WhJtbe4N2/z0aVZ9wqc1nQFbHnOIMU7uEEmSmahqpZuQ/AEl0TS2d+NCI+9c
         dTdBpmwNTQSX7T6Da6dQ6zMoya5TTrRNU45DL5IPSFs6slsZftF+3KLfd3XpXT4B+BEU
         rZKg==
X-Gm-Message-State: AOAM532Pmxj0NPDYMEDM8OATzuPEc/PmMp3xtLVdtYrWADr6+vK9tCPb
        aMDoG85SxqoKe0Rwv1C7PkT3hDjNciP4hA==
X-Google-Smtp-Source: ABdhPJxYoLcf0WXxNz91qV3oIq5cOlSBIvpULe2nZXTigw1jNKZNt39+RfX/vk06M/adR6GGK7uwbg==
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr5421820wmd.91.1607458641965;
        Tue, 08 Dec 2020 12:17:21 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id v189sm5312049wmg.14.2020.12.08.12.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:17:21 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 2/4] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Tue,  8 Dec 2020 21:15:31 +0100
Message-Id: <20201208201533.1312057-2-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208201533.1312057-1-revest@chromium.org>
References: <20201208201533.1312057-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This needs two new helpers, one that works in a sleepable context (using
sock_gen_cookie which disables/enables preemption) and one that does not
(for performance reasons). Both take a struct sock pointer and need to
check it for NULLness.

This helper could also be useful to other BPF program types such as LSM.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/trace/bpf_trace.c       |  4 ++++
 net/core/filter.c              | 24 ++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 5 files changed, 44 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d05e75ed8c1b..2ecda549b773 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1859,6 +1859,8 @@ extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
+extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_sleepable_proto;
+extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba59309f4d18..9ac66cf25959 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1667,6 +1667,13 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**.
+ * 	Return
+ * 		A 8-byte long unique number.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0cf0a6331482..99accc2146bc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1778,6 +1778,10 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_tracing_proto;
+	case BPF_FUNC_get_socket_cookie:
+		return prog->aux->sleepable ?
+		       &bpf_get_socket_ptr_cookie_sleepable_proto :
+		       &bpf_get_socket_ptr_cookie_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 77001a35768f..34877796ab5b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4631,6 +4631,30 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_socket_ptr_cookie_sleepable, struct sock *, sk)
+{
+	return sk ? sock_gen_cookie(sk) : 0;
+}
+
+const struct bpf_func_proto bpf_get_socket_ptr_cookie_sleepable_proto = {
+	.func		= bpf_get_socket_ptr_cookie_sleepable,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+};
+
+BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
+{
+	return sk ? __sock_gen_cookie(sk) : 0;
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
index ba59309f4d18..9ac66cf25959 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1667,6 +1667,13 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**.
+ * 	Return
+ * 		A 8-byte long unique number.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
-- 
2.29.2.576.ga3fc446d84-goog


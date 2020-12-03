Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893652CE0CD
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgLCVec (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgLCVeY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 16:34:24 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A2C061A51
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 13:33:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so3331003wrr.12
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfJQii/CpgAN73aaGK4RbpTh+MNBum2Tvaak24gPmNs=;
        b=RQCEVaxGJ3wraERVHRYy0hdiDqkphCWB1voN8JEuXFA0VzS2akRYiusaJ/C+ceMn6E
         CjdfbQ2OE6BDi0KS1iNJLWS+oSuRGzYIBqbZqgSXYeMpOnDgXpsa/f0CxbUYq59uoJ88
         NI+LkI+Ad+jVZzHoCV0Y6U1pmkHHk1zH26iLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfJQii/CpgAN73aaGK4RbpTh+MNBum2Tvaak24gPmNs=;
        b=TEwxhjwwfCVYDryWxW8ZVRTwpM9en9aJvTkmNEbSOPbSHpssDM5I2QpwMwxUEt25qW
         8gVexnqrJNsmOTxZcllDdYux3FSTHXYdVLk9lurUckvLrvN5+6LyG3SBsrFGfk24YTNP
         D4uNr7308JWzp5bCOL8FuZdpBWAo2v+q2M5FdA6waleRXF/g7ZC6GpHirP+L3yP1VKBi
         Fv/iLdXLD73h8/zwEDy34fdXndpNF8KuDyhsHnCnC8agIPT1vXBkrpRPkXEpTnr4Wxq1
         cNzXiR0DQFnF24pVyJsB1YVe4uAA99JQnwoFtuMKAGBB2xoxMKSM8iqLW1dirp0mNk3Y
         VnLg==
X-Gm-Message-State: AOAM532/EnrInRYOaSQRuWUPyaGEQHF9drEOxfwqx5dUQp5Ji5g/SQZo
        X54rrZxJfGayIcKxxKrBkz3PWm+AmVG4hA==
X-Google-Smtp-Source: ABdhPJwFFrFKrzBn+ca/l9RuJ9j+w38NFolqOQnWevDe1neeP6kkh7I2nlQND/Dp+BAZIfjXPatt3A==
X-Received: by 2002:adf:fd52:: with SMTP id h18mr1301891wrs.90.1607031222222;
        Thu, 03 Dec 2020 13:33:42 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id h83sm754013wmf.9.2020.12.03.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:33:41 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Thu,  3 Dec 2020 22:33:28 +0100
Message-Id: <20201203213330.1657666-1-revest@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This creates a new helper proto because the existing
bpf_get_socket_cookie_sock_proto has a ARG_PTR_TO_CTX argument and only
works for BPF programs where the context is a sock.

This helper could also be useful to other BPF program types such as LSM.

Signed-off-by: Florent Revest <revest@google.com>
---
 include/uapi/linux/bpf.h       | 7 +++++++
 kernel/trace/bpf_trace.c       | 4 ++++
 net/core/filter.c              | 7 +++++++
 tools/include/uapi/linux/bpf.h | 7 +++++++
 4 files changed, 25 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c3458ec1f30a..3e0e33c43998 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1662,6 +1662,13 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long non-decreasing number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**.
+ * 	Return
+ * 		A 8-byte long non-decreasing number.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d255bc9b2bfa..14ad96579813 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1725,6 +1725,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+extern const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto;
+
 const struct bpf_func_proto *
 tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1748,6 +1750,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_tracing_proto;
+	case BPF_FUNC_get_socket_cookie:
+		return &bpf_get_socket_cookie_sock_tracing_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ca5eecebacf..177c4e5e529d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4631,6 +4631,13 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto = {
+	.func		= bpf_get_socket_cookie_sock,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+};
+
 BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
 {
 	return __sock_gen_cookie(ctx->sk);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c3458ec1f30a..3e0e33c43998 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1662,6 +1662,13 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long non-decreasing number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**.
+ * 	Return
+ * 		A 8-byte long non-decreasing number.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
-- 
2.29.2.576.ga3fc446d84-goog


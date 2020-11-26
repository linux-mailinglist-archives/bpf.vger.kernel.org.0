Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653942C59EB
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbgKZRCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 12:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404240AbgKZRCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 12:02:17 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE715C0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 09:02:16 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so2749840wmg.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WF3H28fEoYL2LDdOhRT3Ab9ca5suerjl3gza57entlg=;
        b=VVRHBAlzq5rkqrbiekPZUESvERwFucIUzv2eeGQBwSkqCFP9VEod2rsWKAMo7CpXnq
         M4ovNfj5d9R8C7OS6Rllff0lyf7HdFCtC/Y5S/bwP0KusvH2ho2/HqKsyZQNX1D+U11B
         KWSpNujKPhshnpbIbAriyhEIYDN7KsrFYRpG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WF3H28fEoYL2LDdOhRT3Ab9ca5suerjl3gza57entlg=;
        b=GtwIDO1hM3wpkTc4VHX1Xe/V+7OP5krxYcc5GZoD74FKxQRT8WvOMM/oJTJzbjDme4
         XRavNlKpaS+OWl1L3HnpZV+PGsu52WATEeVjqSZHS/MXE22qAzUR0OAxLuo2BX8gj1CE
         Se0jfOnu75sgIGaeYcGFAnWex06h9wbbdAVizXv45aa1T7gmiG/TgoAZu/SkRDa0bJET
         237TVOBRkoEWv0kOixUSzqVNnw1fKlmhAyYbTKAYoX1FdUhYxo02DA1pX425G9uVt/Kb
         QNN1b7Qo+AW0aws2lJ5wA7ibZzEoJVtE1mCqiNWNljd2KC6DvCx458MeDHtPMbwFLJtY
         4Fng==
X-Gm-Message-State: AOAM533d1tXnJSL+ZEf3gH6cH0od1svKJfAi9jh3dqIEb3yeoW2Er3vS
        Y1XunJwG1y5wbq0BXnv6fzSLYzhmRZwHuIr+
X-Google-Smtp-Source: ABdhPJwh6iMKsGrUw8a4IAsQW1+EEqQOxevWJtxF7h4yHKME9ETvMrIsQZLMAjm6sCqvrDzLJvNOPA==
X-Received: by 2002:a05:600c:58e:: with SMTP id o14mr4431504wmd.47.1606410135376;
        Thu, 26 Nov 2020 09:02:15 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d17sm9373192wro.62.2020.11.26.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:02:14 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Thu, 26 Nov 2020 18:02:11 +0100
Message-Id: <20201126170212.1749137-1-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
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
 kernel/trace/bpf_trace.c | 4 ++++
 net/core/filter.c        | 7 +++++++
 2 files changed, 11 insertions(+)

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
-- 
2.29.2.454.gaff20da3a2-goog


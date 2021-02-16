Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1A31C942
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBPLCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 06:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBPLAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 06:00:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C94C061793
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v62so4493966wmg.4
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=736Q/Aggc5c2j08pkKQ+AVlMQY2/agbGbM41sgkyMCQ=;
        b=DXkTnFe2p1olBkyELWf8N7H6Srh7WFWzpQ1O4u3zHUjEjbhcf63dMgBdpnBb7CT9tK
         tmfeMBQqkzBKAcKa33NOAYOUo7tSr4KpPJ4xQfXehNbqIP/Lg1BBY1qWQXV4wz5sDeR+
         iESfJC1EUgwoY9WBf6JqLnqPZrLSaO9Cy/h0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=736Q/Aggc5c2j08pkKQ+AVlMQY2/agbGbM41sgkyMCQ=;
        b=cHpIKs0ShFpseOmJxmiUX6sbxCdSnECKOKg/uDcvIlgWVAsDaxiF2FKjsO99tHYbZd
         Tt67QRY3I2Iz7cBZN3uKfKCTrvz/4YdowkWTyz4eKgxhnSDfy/HASet1lHAS1k+5g5iF
         8f2vWQBL7EVgQQsJL0GLMlW8Pj9F9WU6+A+9j4EcyiyXkLlQQQ2gCHbMX5mggwa+l0nq
         tlEoRwBYqOblgryLvulTOxakzKZ1J7+g9zv2+2DY1CPnWw7kQw3mqf4IWB77hntlnq3z
         PiAgUVJCQzViXvtTJ6u2R5IHOvaTY3tVVwS0RK+v7ReA5TZdjKdxvhZONlHwF5dfKepx
         cqMQ==
X-Gm-Message-State: AOAM533aPh4OeBRcVVbatFehhtmFrB7+oH8pR5aYrctLBEcRn96Qobbv
        1ovR0M8WTOVr+iQUEb1fpQCkxQ==
X-Google-Smtp-Source: ABdhPJxJz7QAeIKGWCRlwIme7qHMRmtZipIeHW0+zq/zcZip7SrSaq0q3ZKcrHYIfi9frcpy0+0Ydg==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr2863068wmo.30.1613473098956;
        Tue, 16 Feb 2021 02:58:18 -0800 (PST)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l1sm2820238wmi.48.2021.02.16.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 02:58:18 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jakub@cloudflare.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 4/8] bpf: add PROG_TEST_RUN support for sk_lookup programs
Date:   Tue, 16 Feb 2021 10:57:09 +0000
Message-Id: <20210216105713.45052-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210216105713.45052-1-lmb@cloudflare.com>
References: <20210216105713.45052-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow to pass (multiple) sk_lookup programs to PROG_TEST_RUN.
User space provides the full bpf_sk_lookup struct as context.
Since the context includes a socket pointer that can't be exposed
to user space we define that PROG_TEST_RUN returns the cookie
of the selected socket or zero in place of the socket pointer.

We don't support testing programs that select a reuseport socket,
since this would mean running another (unrelated) BPF program
from the sk_lookup test handler.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h            | 10 ++++
 include/uapi/linux/bpf.h       |  5 +-
 net/bpf/test_run.c             | 93 ++++++++++++++++++++++++++++++++++
 net/core/filter.c              |  1 +
 tools/include/uapi/linux/bpf.h |  5 +-
 5 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 67c21c8ba7cc..d251db1354ec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1472,6 +1472,9 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 			     const union bpf_attr *kattr,
 			     union bpf_attr __user *uattr);
+int bpf_prog_test_run_sk_lookup(struct bpf_prog_array *progs,
+				const union bpf_attr *kattr,
+				union bpf_attr __user *uattr);
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info);
@@ -1672,6 +1675,13 @@ static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	return -ENOTSUPP;
 }
 
+static inline int bpf_prog_test_run_sk_lookup(struct bpf_prog_array *progs,
+					      const union bpf_attr *kattr,
+					      union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
+
 static inline void bpf_map_put(struct bpf_map *map)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b37a0f39b95f..078ad0b8d1a7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5210,7 +5210,10 @@ struct bpf_pidns_info {
 
 /* User accessible data for SK_LOOKUP programs. Add new fields at the end. */
 struct bpf_sk_lookup {
-	__bpf_md_ptr(struct bpf_sock *, sk); /* Selected socket */
+	union {
+		__bpf_md_ptr(struct bpf_sock *, sk); /* Selected socket */
+		__u64 cookie; /* Non-zero if socket was selected in PROG_TEST_RUN */
+	};
 
 	__u32 family;		/* Protocol family (AF_INET, AF_INET6) */
 	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 33bd2f67e259..932c8e036b0a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -10,8 +10,10 @@
 #include <net/bpf_sk_storage.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/net_namespace.h>
 #include <linux/error-injection.h>
 #include <linux/smp.h>
+#include <linux/sock_diag.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
@@ -781,3 +783,94 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	kfree(data);
 	return ret;
 }
+
+int bpf_prog_test_run_sk_lookup(struct bpf_prog_array *progs, const union bpf_attr *kattr,
+				union bpf_attr __user *uattr)
+{
+	struct test_timer t = { NO_PREEMPT };
+	struct bpf_sk_lookup_kern ctx = {};
+	u32 repeat = kattr->test.repeat;
+	struct bpf_sk_lookup *user_ctx;
+	u32 retval, duration;
+	int ret = -EINVAL;
+
+	if (bpf_prog_array_length(progs) >= BPF_SK_LOOKUP_MAX_PROGS)
+		return -E2BIG;
+
+	if (kattr->test.flags || kattr->test.cpu)
+		return -EINVAL;
+
+	if (kattr->test.data_in || kattr->test.data_size_in || kattr->test.data_out ||
+	    kattr->test.data_size_out)
+		return -EINVAL;
+
+	if (!repeat)
+		repeat = 1;
+
+	user_ctx = bpf_ctx_init(kattr, sizeof(*user_ctx));
+	if (IS_ERR(user_ctx))
+		return PTR_ERR(user_ctx);
+
+	if (!user_ctx)
+		return -EINVAL;
+
+	if (user_ctx->sk)
+		goto out;
+
+	if (!range_is_zero(user_ctx, offsetofend(typeof(*user_ctx), local_port), sizeof(*user_ctx)))
+		goto out;
+
+	if (user_ctx->local_port > U16_MAX || user_ctx->remote_port > U16_MAX) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	ctx.family = user_ctx->family;
+	ctx.protocol = user_ctx->protocol;
+	ctx.dport = user_ctx->local_port;
+	ctx.sport = user_ctx->remote_port;
+
+	switch (ctx.family) {
+	case AF_INET:
+		ctx.v4.daddr = user_ctx->local_ip4;
+		ctx.v4.saddr = user_ctx->remote_ip4;
+		break;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		ctx.v6.daddr = (struct in6_addr *)user_ctx->local_ip6;
+		ctx.v6.saddr = (struct in6_addr *)user_ctx->remote_ip6;
+		break;
+#endif
+
+	default:
+		ret = -EAFNOSUPPORT;
+		goto out;
+	}
+
+	while (t_check(&t, repeat, &ret, &duration)) {
+		ctx.selected_sk = NULL;
+		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, BPF_PROG_RUN);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	user_ctx->cookie = 0;
+	if (ctx.selected_sk) {
+		if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
+	}
+
+	ret = bpf_test_finish(kattr, uattr, NULL, 0, retval, duration);
+	if (!ret)
+		ret = bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*user_ctx));
+
+out:
+	kfree(user_ctx);
+	return ret;
+}
diff --git a/net/core/filter.c b/net/core/filter.c
index 7059cf604d94..978cea941268 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10451,6 +10451,7 @@ static u32 sk_lookup_convert_ctx_access(enum bpf_access_type type,
 }
 
 const struct bpf_prog_ops sk_lookup_prog_ops = {
+	.test_run_array = bpf_prog_test_run_sk_lookup,
 };
 
 const struct bpf_verifier_ops sk_lookup_verifier_ops = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b37a0f39b95f..078ad0b8d1a7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5210,7 +5210,10 @@ struct bpf_pidns_info {
 
 /* User accessible data for SK_LOOKUP programs. Add new fields at the end. */
 struct bpf_sk_lookup {
-	__bpf_md_ptr(struct bpf_sock *, sk); /* Selected socket */
+	union {
+		__bpf_md_ptr(struct bpf_sock *, sk); /* Selected socket */
+		__u64 cookie; /* Non-zero if socket was selected in PROG_TEST_RUN */
+	};
 
 	__u32 family;		/* Protocol family (AF_INET, AF_INET6) */
 	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
-- 
2.27.0


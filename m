Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBD326154
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 11:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhBZKcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 05:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhBZKcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 05:32:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B15C06178B
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 02:31:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n4so8087750wrx.1
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 02:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AozLi9RSFVkS4GYErhw/fB9ATTiq/V22hdHPb1aK994=;
        b=WhNxkR+m6aI75HYfAU1HS78TemeFF9DdMrvaK2yEo0gyIaeBIRXOUabCSHzF7hd2IU
         LbsFrzc4XsZJMLTKIO5ZDREjINlrE58wLKGQ58BSp0/+bscJxNuMDGcaurcE9ASfREdL
         e9ya0gUXIdHueRSbszt+tKyrEYhS/bbjolNOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AozLi9RSFVkS4GYErhw/fB9ATTiq/V22hdHPb1aK994=;
        b=dYKAg0kj6/vIl1rpyjZn/7YD9RJ+4RL/zBi9440g43PlgNG1nYIDE+nH9PvpW5O3xI
         bGPB6+hbQAO02yS1Tg7ITM+RXhGEVSYmICAu2i5vR5wdnKj9np3zBfBpaBadPrAM0fme
         zsvnkCMpOLOPwIELnIbcWdV/0BjaGlzISjeswTNwyN3lpX0b3y4QhsExUP3ehjgYWFXM
         VY6IrGrlJ3LwnZivEccPbjTVvpSpGKkfN1kcjpMMoSxd4RgPEx7YjYZ/IgwqvVB0iPhM
         W15jW6i8Uo+42g3qERrcwYf5dgjPIXe19qvnZuMw3US1tfa2F0RDcbyI4FTpZgRaSEXp
         V4JA==
X-Gm-Message-State: AOAM533bsOWbu6opvPhjV2YYppqLizsNhzIOH5v7sXbsouvsFS+PVsGg
        ryJQ78LX45ILPufPjLU050GYpg==
X-Google-Smtp-Source: ABdhPJwzUjvefo010yYgqaOTU0SY/RA2IJUNwsezWYynCjlNlHT8qH4C+xGZZ5o3kNe5vhhByRjEYA==
X-Received: by 2002:adf:f484:: with SMTP id l4mr2524073wro.409.1614335479991;
        Fri, 26 Feb 2021 02:31:19 -0800 (PST)
Received: from localhost.localdomain (d.4.3.e.3.5.0.6.8.1.5.9.3.d.9.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:69d3:9518:6053:e34d])
        by smtp.gmail.com with ESMTPSA id a21sm12448744wmb.5.2021.02.26.02.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 02:31:19 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 2/4] bpf: add PROG_TEST_RUN support for sk_lookup programs
Date:   Fri, 26 Feb 2021 10:31:01 +0000
Message-Id: <20210226103103.131210-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210226103103.131210-1-lmb@cloudflare.com>
References: <20210226103103.131210-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow to pass sk_lookup programs to PROG_TEST_RUN. User space
provides the full bpf_sk_lookup struct as context. Since the
context includes a socket pointer that can't be exposed
to user space we define that PROG_TEST_RUN returns the cookie
of the selected socket or zero in place of the socket pointer.

We don't support testing programs that select a reuseport socket,
since this would mean running another (unrelated) BPF program
from the sk_lookup test handler.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h            |  10 ++++
 include/uapi/linux/bpf.h       |   5 +-
 net/bpf/test_run.c             | 105 +++++++++++++++++++++++++++++++++
 net/core/filter.c              |   1 +
 tools/include/uapi/linux/bpf.h |   5 +-
 5 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cccaef1088ea..6f9a27b839da 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1470,6 +1470,9 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 			     const union bpf_attr *kattr,
 			     union bpf_attr __user *uattr);
+int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
+				const union bpf_attr *kattr,
+				union bpf_attr __user *uattr);
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info);
@@ -1670,6 +1673,13 @@ static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	return -ENOTSUPP;
 }
 
+static inline int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
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
index 4c24daa43bac..e10e2a1e5e2e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5206,7 +5206,10 @@ struct bpf_pidns_info {
 
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
index ac8ee36d60cc..0ec6b920484a 100644
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
@@ -781,3 +783,106 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	kfree(data);
 	return ret;
 }
+
+int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
+				union bpf_attr __user *uattr)
+{
+	struct test_timer t = { NO_PREEMPT };
+	struct bpf_prog_array *progs = NULL;
+	struct bpf_sk_lookup_kern ctx = {};
+	u32 repeat = kattr->test.repeat;
+	struct bpf_sk_lookup *user_ctx;
+	u32 retval, duration;
+	int ret = -EINVAL;
+
+	if (prog->type != BPF_PROG_TYPE_SK_LOOKUP)
+		return -EINVAL;
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
+	ctx.family = (u16)user_ctx->family;
+	ctx.protocol = (u16)user_ctx->protocol;
+	ctx.dport = (u16)user_ctx->local_port;
+	ctx.sport = (__force __be16)user_ctx->remote_port;
+
+	switch (ctx.family) {
+	case AF_INET:
+		ctx.v4.daddr = (__force __be32)user_ctx->local_ip4;
+		ctx.v4.saddr = (__force __be32)user_ctx->remote_ip4;
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
+	progs = bpf_prog_array_alloc(1, GFP_KERNEL);
+	if (!progs) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	progs->items[0].prog = prog;
+
+	t_enter(&t);
+	do {
+		ctx.selected_sk = NULL;
+		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, BPF_PROG_RUN);
+	} while (t_continue(&t, repeat, &ret, &duration));
+	t_leave(&t);
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
+	bpf_prog_array_free(progs);
+	kfree(user_ctx);
+	return ret;
+}
diff --git a/net/core/filter.c b/net/core/filter.c
index adfdad234674..5003037765eb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10449,6 +10449,7 @@ static u32 sk_lookup_convert_ctx_access(enum bpf_access_type type,
 }
 
 const struct bpf_prog_ops sk_lookup_prog_ops = {
+	.test_run = bpf_prog_test_run_sk_lookup,
 };
 
 const struct bpf_verifier_ops sk_lookup_verifier_ops = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4c24daa43bac..e10e2a1e5e2e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5206,7 +5206,10 @@ struct bpf_pidns_info {
 
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


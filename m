Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A012F80E7
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbhAOQfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jan 2021 11:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbhAOQfu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 11:35:50 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D347C061794
        for <bpf@vger.kernel.org>; Fri, 15 Jan 2021 08:35:09 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b206so8501151qkc.14
        for <bpf@vger.kernel.org>; Fri, 15 Jan 2021 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6pc4IE1QgS9pRysCl3q7K9qT5M8Tvd9Do5NXOChbxuI=;
        b=If15L3UmRbX5GeG1JMJSnqzWpnRFtWlCc8EmPC0Po6dd23Ey/zsqh957tVHhbICOYw
         +pfMlJ3c3z0RtoIVyuZXLMXbl6jaCsNzK+JS87Y7Svm3JWDfDF9d4r3EXEZAz1jQQSQz
         krFe+iOxEl6iUQJUtBN/1Xyo/dWvlRhKtZ98OuTbJPTMOed4M/znAiR4xyN+CIpttqfJ
         1/nSSRvh56D5200KTfj/dr//ro76wqDCZ5LhJwMsYnWICrNDHmSbIsPLikGt9y1UBdI7
         fbf6bFyehrjfeP1YcTQp5RVPy4/4dFj2TD4tIIdV2yIlLYBgwpp1Ul/02M5Dbq9Pku8Q
         QmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6pc4IE1QgS9pRysCl3q7K9qT5M8Tvd9Do5NXOChbxuI=;
        b=p2jQRCQh4x+TNt8GdJiq4eSXwdvJ+bQ4fSaP5IJMKRgS9O3FsK2II8Had8KBOh6quH
         ZLEJ5ojDH+Z9EeUJm9+maFbkLUuyDmY9Y5xj11pD2wnQby21zxjLde3gLSoHRPUSSt2b
         R+bgwYujGYCfdh/SY/JTofdZrXDg71whytWIiRNyt/n4K95//qHzh7iD3l8/v7p/zXAX
         fSy7o+WWVWlsAVI5+4t7cpRkSxb3LS57qs+iJoeGLw4gIDJpcKaTL0zgkw3Oc0m/Tx3w
         kLRQJvWibR8ChBS/705U59rDNXYwPH7ReWgm1Yazgkh4iRRWpbYrpLLwdGeTlqkjBrYA
         AbWg==
X-Gm-Message-State: AOAM533hmEQUQuDOzZXTucgKGGbRjptzzR7nWL7LjmVkcK/6f7GbswJ9
        laodHXjjHHjhb/QMXNDQ3MSYZ9I=
X-Google-Smtp-Source: ABdhPJxmEbXjnIQR2c7Jud8cUks3JWTg7wEjoOKJ0bM26AanYS+p2/8l1hJD+mkbTR7WEXD4L7bZ57M=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:6a1:: with SMTP id
 s1mr12968000qvz.20.1610728508632; Fri, 15 Jan 2021 08:35:08 -0800 (PST)
Date:   Fri, 15 Jan 2021 08:35:00 -0800
In-Reply-To: <20210115163501.805133-1-sdf@google.com>
Message-Id: <20210115163501.805133-3-sdf@google.com>
Mime-Version: 1.0
References: <20210115163501.805133-1-sdf@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v9 2/3] bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When we attach a bpf program to cgroup/getsockopt any other getsockopt()
syscall starts incurring kzalloc/kfree cost.

Let add a small buffer on the stack and use it for small (majority)
{s,g}etsockopt values. The buffer is small enough to fit into
the cache line and cover the majority of simple options (most
of them are 4 byte ints).

It seems natural to do the same for setsockopt, but it's a bit more
involved when the BPF program modifies the data (where we have to
kmalloc). The assumption is that for the majority of setsockopt
calls (which are doing pure BPF options or apply policy) this
will bring some benefit as well.

Without this patch (we remove about 1% __kmalloc):
     3.38%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
            |
             --3.30%--__cgroup_bpf_run_filter_getsockopt
                       |
                        --0.81%--__kmalloc

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/filter.h |  5 ++++
 kernel/bpf/cgroup.c    | 52 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7fdce5407214..5b3137d7b690 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1298,6 +1298,11 @@ struct bpf_sysctl_kern {
 	u64 tmp_reg;
 };
 
+#define BPF_SOCKOPT_KERN_BUF_SIZE	32
+struct bpf_sockopt_buf {
+	u8		data[BPF_SOCKOPT_KERN_BUF_SIZE];
+};
+
 struct bpf_sockopt_kern {
 	struct sock	*sk;
 	u8		*optval;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 416e7738981b..ba8a1199d0ba 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1298,7 +1298,8 @@ static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
 	return empty;
 }
 
-static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
+static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
+			     struct bpf_sockopt_buf *buf)
 {
 	if (unlikely(max_optlen < 0))
 		return -EINVAL;
@@ -1310,6 +1311,15 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 		max_optlen = PAGE_SIZE;
 	}
 
+	if (max_optlen <= sizeof(buf->data)) {
+		/* When the optval fits into BPF_SOCKOPT_KERN_BUF_SIZE
+		 * bytes avoid the cost of kzalloc.
+		 */
+		ctx->optval = buf->data;
+		ctx->optval_end = ctx->optval + max_optlen;
+		return max_optlen;
+	}
+
 	ctx->optval = kzalloc(max_optlen, GFP_USER);
 	if (!ctx->optval)
 		return -ENOMEM;
@@ -1319,16 +1329,26 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 	return max_optlen;
 }
 
-static void sockopt_free_buf(struct bpf_sockopt_kern *ctx)
+static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
+			     struct bpf_sockopt_buf *buf)
 {
+	if (ctx->optval == buf->data)
+		return;
 	kfree(ctx->optval);
 }
 
+static bool sockopt_buf_allocated(struct bpf_sockopt_kern *ctx,
+				  struct bpf_sockopt_buf *buf)
+{
+	return ctx->optval != buf->data;
+}
+
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 				       int *optname, char __user *optval,
 				       int *optlen, char **kernel_optval)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
+	struct bpf_sockopt_buf buf = {};
 	struct bpf_sockopt_kern ctx = {
 		.sk = sk,
 		.level = *level,
@@ -1350,7 +1370,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	 */
 	max_optlen = max_t(int, 16, *optlen);
 
-	max_optlen = sockopt_alloc_buf(&ctx, max_optlen);
+	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
 	if (max_optlen < 0)
 		return max_optlen;
 
@@ -1390,14 +1410,31 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		 */
 		if (ctx.optlen != 0) {
 			*optlen = ctx.optlen;
-			*kernel_optval = ctx.optval;
+			/* We've used bpf_sockopt_kern->buf as an intermediary
+			 * storage, but the BPF program indicates that we need
+			 * to pass this data to the kernel setsockopt handler.
+			 * No way to export on-stack buf, have to allocate a
+			 * new buffer.
+			 */
+			if (!sockopt_buf_allocated(&ctx, &buf)) {
+				void *p = kmalloc(ctx.optlen, GFP_USER);
+
+				if (!p) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				memcpy(p, ctx.optval, ctx.optlen);
+				*kernel_optval = p;
+			} else {
+				*kernel_optval = ctx.optval;
+			}
 			/* export and don't free sockopt buf */
 			return 0;
 		}
 	}
 
 out:
-	sockopt_free_buf(&ctx);
+	sockopt_free_buf(&ctx, &buf);
 	return ret;
 }
 
@@ -1407,6 +1444,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 				       int retval)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
+	struct bpf_sockopt_buf buf = {};
 	struct bpf_sockopt_kern ctx = {
 		.sk = sk,
 		.level = level,
@@ -1425,7 +1463,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 
 	ctx.optlen = max_optlen;
 
-	max_optlen = sockopt_alloc_buf(&ctx, max_optlen);
+	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
 	if (max_optlen < 0)
 		return max_optlen;
 
@@ -1483,7 +1521,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	ret = ctx.retval;
 
 out:
-	sockopt_free_buf(&ctx);
+	sockopt_free_buf(&ctx, &buf);
 	return ret;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog


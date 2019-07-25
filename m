Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD99752B1
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2019 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbfGYPdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 11:33:55 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34442 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389122AbfGYPdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 11:33:54 -0400
Received: by mail-pg1-f201.google.com with SMTP id x19so30930358pgx.1
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S1+omtFhB5U2AC0M72Cgb2Rfr2Z1sSSuVrmqGgYoHrg=;
        b=jl3szocqEJUCetiE659NxMaqklSY3xL8ZKF5CbFoHMfykoBnWbSy8OFUjJeL+Njp/d
         FqeaRWuFT8/VKctrEdDPP31DgpH1h9u9lWWEoeRvfzDFP5GhgKNDka/vFdX4EYnpGZD4
         oYGhgp7KZ+V6wL/KkJ8VlQbFOZ/XD60wThJEqYmWjE656Heq4aKInq4kdcRsn4B3vff7
         jGKK2ma7Ome5u44JyA/5vhRh7MAzrwAwqEDjU3waENwhbxZG1SlQW2uaBZ3+nHpnTt5/
         sJD3pUHe1zCY/izcEVmEcqeKafHkA7lOCPnp78DzTQoxzxhoquWmVZGY7Bx+AmMYuX06
         NQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S1+omtFhB5U2AC0M72Cgb2Rfr2Z1sSSuVrmqGgYoHrg=;
        b=LSHOhg8ZuBvu3T2FtBDHdEnMLGLqF+lfdilnv6Fs8WoCti3zGEFQfssJgyE6HH+NeV
         Md3ngoAYqhYHid3PDKsAA1EtVxdzXTM36gsyqrbxK3KYOrDv7NwUUju0TDB7gigPo5eG
         R6MiXMFXx4EXH2y7A7EJZ0iy6YmDqnKWrEuRuZBW5r5ssJuEcjNvYBkgbSEoBCA4TT0c
         cSBKljjf+/5LHoyf7kK9Yhyyc9Cv3dm4kqGfrOjk8f19VzQn7JktvE+ho8b+73HilARq
         Bl+XaQjqINV8PRs7445Gu3woCIzv6UsoJO0g23UuNdIxj+opO1SzUFf2vcc3mOw4Ubv1
         ZiYA==
X-Gm-Message-State: APjAAAXDJsSuoO3ick+1pl6taCO1mSDD0ehUKUrN6sQqGgnu0Fm6xDIO
        hRVLMZV/sp+hndRLXOKWVbtdDNA=
X-Google-Smtp-Source: APXvYqw+gRO4DnDKQ9dB+oET5Ty/v93oX4oX1kww4Iuqa/RxnKRSrvRhwh/qT8flh+pfy9a0o4PzVmU=
X-Received: by 2002:a65:62d7:: with SMTP id m23mr86905598pgv.358.1564068833223;
 Thu, 25 Jul 2019 08:33:53 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:33:38 -0700
In-Reply-To: <20190725153342.3571-1-sdf@google.com>
Message-Id: <20190725153342.3571-4-sdf@google.com>
Mime-Version: 1.0
References: <20190725153342.3571-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next v2 3/7] bpf/flow_dissector: support flags in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Song Liu <songliubraving@fb.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will allow us to write tests for those flags.

v2:
* Swap kfree(data) and kfree(user_ctx) (Song Liu)

Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4e41d15a1098..1153bbcdff72 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -377,6 +377,22 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	return ret;
 }
 
+static int verify_user_bpf_flow_keys(struct bpf_flow_keys *ctx)
+{
+	/* make sure the fields we don't use are zeroed */
+	if (!range_is_zero(ctx, 0, offsetof(struct bpf_flow_keys, flags)))
+		return -EINVAL;
+
+	/* flags is allowed */
+
+	if (!range_is_zero(ctx, offsetof(struct bpf_flow_keys, flags) +
+			   FIELD_SIZEOF(struct bpf_flow_keys, flags),
+			   sizeof(struct bpf_flow_keys)))
+		return -EINVAL;
+
+	return 0;
+}
+
 int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
@@ -384,9 +400,11 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
+	struct bpf_flow_keys *user_ctx;
 	struct bpf_flow_keys flow_keys;
 	u64 time_start, time_spent = 0;
 	const struct ethhdr *eth;
+	unsigned int flags = 0;
 	u32 retval, duration;
 	void *data;
 	int ret;
@@ -395,9 +413,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (prog->type != BPF_PROG_TYPE_FLOW_DISSECTOR)
 		return -EINVAL;
 
-	if (kattr->test.ctx_in || kattr->test.ctx_out)
-		return -EINVAL;
-
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
@@ -410,6 +425,18 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (!repeat)
 		repeat = 1;
 
+	user_ctx = bpf_ctx_init(kattr, sizeof(struct bpf_flow_keys));
+	if (IS_ERR(user_ctx)) {
+		kfree(data);
+		return PTR_ERR(user_ctx);
+	}
+	if (user_ctx) {
+		ret = verify_user_bpf_flow_keys(user_ctx);
+		if (ret)
+			goto out;
+		flags = user_ctx->flags;
+	}
+
 	ctx.flow_keys = &flow_keys;
 	ctx.data = data;
 	ctx.data_end = (__u8 *)data + size;
@@ -419,7 +446,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
 		retval = bpf_flow_dissect(prog, &ctx, eth->h_proto, ETH_HLEN,
-					  size, 0);
+					  size, flags);
 
 		if (signal_pending(current)) {
 			preempt_enable();
@@ -450,8 +477,12 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 
 	ret = bpf_test_finish(kattr, uattr, &flow_keys, sizeof(flow_keys),
 			      retval, duration);
+	if (!ret)
+		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
+				     sizeof(struct bpf_flow_keys));
 
 out:
+	kfree(user_ctx);
 	kfree(data);
 	return ret;
 }
-- 
2.22.0.657.g960e92d24f-goog


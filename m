Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6B73475
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGXRA3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 13:00:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49201 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfGXRA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 13:00:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id 30so28667191pgk.16
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6ld3c/snjLG2m54lTG5RUnO37rwyBY0HMvP7Ki2mWFA=;
        b=uk0Uqa59DlPB3JTGLrnurnvaVEoOSZzGiCD/vTu/RceRZ/eNQ4HVeK5ch3LbztI6M2
         Sh4KHR8FE7Wt23KHGossa6U0f7/1EXjQTErCTrBTv5hkPdSyBwuvx5ApoCFk0V7RVg3K
         2Za/f9zwV0Upx9xGCUA4d7F8vKX+AB8eqRipEuDvltE24tMKv20KV1EFg6TYYwbczrvn
         Fg6ehfONdT1eEfvShgDqtYqIAKOqu8ZiuRywdHeDJVSfbXG/lIllhsVWUpoJXeOTbzBb
         F2k/yu0Z5c0m5x+HXEyWp9RuFPbTg379jc+7mc+koBbhtLqlCnc1e4+/0FwHllH6wjvj
         1kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6ld3c/snjLG2m54lTG5RUnO37rwyBY0HMvP7Ki2mWFA=;
        b=e4JrP5x3DR1TYEgj+tlaErFbAtvtR1p1UDXTVCOQUWktzIjueltcGENtUwJsnT1Vpw
         AOivFQriLD+5gdSikdYLb8cBdEMNKcr5sYakommin2dYWn4tOMrF07eOb7pno8UylY/x
         9qchUXMuhXjE8SDeHbGoexz4qGlO9cW3wkCm5QtHYFRr0KNXnaqqVa/AAF3XDpCG6hvL
         p3E0v2nxMRPg9B3NIbaHRPZSIFs2sn8vBlw0lAecsBT20WzUR9nVom8qXM44YO5k6j1M
         QGZ8aDuGB6cLOpUdMat7nhcABLb41a3+UfmI4R/sYAHLr5OL1IBP6hzzwCTNYjiJ7nUY
         0PyQ==
X-Gm-Message-State: APjAAAUir2+eHJemUAX+0s3cQlY3TRIeshqsHBeLnDjuUdy1yNkT2sK4
        2A/o+C1o+6WQN4hDe1dN5bV117w=
X-Google-Smtp-Source: APXvYqxKX6jt4jiH3SzovabK1tbiMDvYXSWvp3QqwKQLy1ZCVNQze/W0RKcA7CJ3QZAQQAQTeeCNgKo=
X-Received: by 2002:a63:2006:: with SMTP id g6mr81008358pgg.287.1563987628267;
 Wed, 24 Jul 2019 10:00:28 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:00:14 -0700
In-Reply-To: <20190724170018.96659-1-sdf@google.com>
Message-Id: <20190724170018.96659-4-sdf@google.com>
Mime-Version: 1.0
References: <20190724170018.96659-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 3/7] bpf/flow_dissector: support flags in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will allow us to write tests for those flags.

Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4e41d15a1098..444a7baed791 100644
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
 	kfree(data);
+	kfree(user_ctx);
 	return ret;
 }
-- 
2.22.0.657.g960e92d24f-goog


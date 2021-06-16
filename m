Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB07E3AA6C4
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 00:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhFPWuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 18:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhFPWuA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 18:50:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B0C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o10-20020a17090aac0ab029016e92770073so2673911pjq.5
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yqd2+TGlNCTaTOesLNWXqVsKjy5vPLLzil4CutQO7ks=;
        b=JyjqoYv+Oc0/aY0fgss8+neMGuvX/ceqNlrVBenkZwmcLP2HQZoNktsX7jBMcvcG6I
         pK/JpQS7L0JWlSAv4UfqFNJuVZeyJzOIfMshaOH3BipDX4XXcoIuBFJkxLpml94UI+WJ
         NMLhq/e9si1mtwef4OQJFVt+b3jG2NPsPp2Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yqd2+TGlNCTaTOesLNWXqVsKjy5vPLLzil4CutQO7ks=;
        b=FsxtVdXgmIaDnwEZPm4ijtc6OE+cCTEYoiWcbBclhp618Yfbut8dsqGobFF8clHpB3
         42thxipVi3VsLn4bOwnw+v+yg/nmPqRFXHyOxPCkJePiOMP4LNxJYW7U2ikrIAxbSjbi
         h1X9TV6svOyM6hwYgr98Qwl1eHwYMAXoZd8wxGUFSSc4jaqFiNwRlppARVD+3KzbWH8Y
         1V6Wv15bvYJVIsUo9pk/xCHnpCY06YuESb/q9U/L2UbkRyOyiAEjqa4Xj4I2wHZc9NJ6
         mHb6nGNpnQSjWfzWMtyVvay2om4v1ISmRM/LnzdJOIDW0aS6nDWbqhsX+yDum/DBtyBO
         8x/Q==
X-Gm-Message-State: AOAM532go19RjV1dLqIqWsBWrYZ9YtI/llw5EM8cWmlrubjrKms10w5d
        UZKeVE1JwnnCoEO4XvwAmNsiKNFP+72nFQ==
X-Google-Smtp-Source: ABdhPJw15B+cApHEpRbXQzjLSnUMSRm9MoPMw3Ppm8E9Z2shz85y16bdKruxxJ+6rfFLkt8TyL8L0A==
X-Received: by 2002:a17:90a:fe18:: with SMTP id ck24mr13756281pjb.158.1623883673475;
        Wed, 16 Jun 2021 15:47:53 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id p6sm6278672pjk.34.2021.06.16.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 15:47:52 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v5 2/4] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed, 16 Jun 2021 22:47:10 +0000
Message-Id: <20210616224712.3243-3-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616224712.3243-1-zeffron@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support passing a xdp_md via ctx_in/ctx_out in bpf_attr for
BPF_PROG_TEST_RUN.

The intended use case is to pass some XDP meta data to the test runs of
XDP programs that are used as tail calls.

For programs that use bpf_prog_test_run_xdp, support xdp_md input and
output. Unlike with an actual xdp_md during a non-test run, data_meta must
be 0 because it must point to the start of the provided user data. From
the initial xdp_md, use data and data_end to adjust the pointers in the
generated xdp_buff. All other non-zero fields are prohibited (with
EINVAL). If the user has set ctx_out/ctx_size_out, copy the (potentially
different) xdp_md back to the userspace.

We require all fields of input xdp_md except the ones we explicitly
support to be set to zero. The expectation is that in the future we might
add support for more fields and we want to fail explicitly if the user
runs the program on the kernel where we don't yet support them.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
---
 include/uapi/linux/bpf.h |  3 --
 net/bpf/test_run.c       | 68 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bf9252c7381e..b46a383e8db7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -324,9 +324,6 @@ union bpf_iter_link_info {
  *		**BPF_PROG_TYPE_SK_LOOKUP**
  *			*data_in* and *data_out* must be NULL.
  *
- *		**BPF_PROG_TYPE_XDP**
- *			*ctx_in* and *ctx_out* must be NULL.
- *
  *		**BPF_PROG_TYPE_RAW_TRACEPOINT**,
  *		**BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE**
  *
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index aa47af349ba8..f3054f25409c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -15,6 +15,7 @@
 #include <linux/error-injection.h>
 #include <linux/smp.h>
 #include <linux/sock_diag.h>
+#include <net/xdp.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
@@ -687,6 +688,22 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	return ret;
 }
 
+static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
+{
+	if (!xdp_md)
+		return 0;
+
+	if (xdp_md->egress_ifindex != 0)
+		return -EINVAL;
+
+	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
+		return -EINVAL;
+
+	xdp->data = xdp->data_meta + xdp_md->data;
+
+	return 0;
+}
+
 int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
@@ -697,35 +714,74 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	struct netdev_rx_queue *rxqueue;
 	struct xdp_buff xdp = {};
 	u32 retval, duration;
+	struct xdp_md *ctx;
 	u32 max_data_sz;
 	void *data;
 	int ret;
 
-	if (kattr->test.ctx_in || kattr->test.ctx_out)
-		return -EINVAL;
+	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	if (ctx) {
+		/* There can't be user provided data before the meta data */
+		if (ctx->data_meta)
+			return -EINVAL;
+		if (ctx->data_end != size)
+			return -EINVAL;
+		if (ctx->data > ctx->data_end)
+			return -EINVAL;
+		if (unlikely(xdp_metalen_valid(ctx->data)))
+			return -EINVAL;
+		/* Meta data is allocated from the headroom */
+		headroom -= ctx->data;
+	}
 
 	/* XDP have extra tailroom as (most) drivers use full page */
 	max_data_sz = 4096 - headroom - tailroom;
 
 	data = bpf_test_init(kattr, max_data_sz, headroom, tailroom);
-	if (IS_ERR(data))
+	if (IS_ERR(data)) {
+		kfree(ctx);
 		return PTR_ERR(data);
+	}
 
 	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
 	xdp_init_buff(&xdp, headroom + max_data_sz + tailroom,
 		      &rxqueue->xdp_rxq);
 	xdp_prepare_buff(&xdp, data, headroom, size, true);
 
+	ret = xdp_convert_md_to_buff(ctx, &xdp);
+	if (ret) {
+		kfree(data);
+		kfree(ctx);
+		return ret;
+	}
+
 	bpf_prog_change_xdp(NULL, prog);
 	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
 	if (ret)
 		goto out;
-	if (xdp.data != data + headroom || xdp.data_end != xdp.data + size)
-		size = xdp.data_end - xdp.data;
-	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
+
+	if (xdp.data_meta != data + headroom ||
+	    xdp.data_end != xdp.data_meta + size)
+		size = xdp.data_end - xdp.data_meta;
+
+	if (ctx) {
+		ctx->data = xdp.data - xdp.data_meta;
+		ctx->data_end = xdp.data_end - xdp.data_meta;
+	}
+
+	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval,
+			      duration);
+	if (!ret)
+		ret = bpf_ctx_finish(kattr, uattr, ctx,
+				     sizeof(struct xdp_md));
+
 out:
 	bpf_prog_change_xdp(prog, NULL);
 	kfree(data);
+	kfree(ctx);
 	return ret;
 }
 
-- 
2.31.1


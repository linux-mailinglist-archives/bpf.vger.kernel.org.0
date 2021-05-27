Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4C3936E3
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhE0UPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhE0UPf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 16:15:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9958C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:14:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r1so781571pgk.8
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEC3u7WqCAAg+EhWK/9uXjp7zZVSRqNtYwLo8QVPRoc=;
        b=VyRb81ACOnn++bGC5JRrvEiOZyx9W2JBu4lurrDaNVnoRj5B9+ULKhHkcysz6jPibE
         NJjfeJfRtHXjQfG2kr/pjfl3WuXD6CBY3tE0jlBwCVNqonjE/YGeG5chUYIAiTmU/1lu
         v1E3q7ZIESx9lDH7VnAPuBh4PrqyAtnGsJfDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEC3u7WqCAAg+EhWK/9uXjp7zZVSRqNtYwLo8QVPRoc=;
        b=pvrsPuenq7aTNv8rTxqR3k5ldzs6MLO4kg28nzDBgVBXexdNVjZFZhxLM5dfkwfnXd
         Qb+hF9Jgdy3oa2iSjr4isvKHxsFHgl9H4myIMhkg+Po2wqTg/cVIwwZK4hLQlvK90nXp
         iSK/Va5Jj8p8hnQqFn0xfeg7tsvsb/CpLXZof7n3bBGsPCVp/Nm2XiG4HuTnxMSfr6jU
         rj9VTaVkzhp0B7hyQRrauML4gCTqjI7+BwjBfNXU7vPPLefSsWAJpoh6emADPCF658o2
         rYo7HD6SEiwxL1riwu9WTJ4M0mKORXDUjFeanIBtw2jEE+fncfDq3H9l9ABpqjZwDcyf
         iOIw==
X-Gm-Message-State: AOAM5330xz/yMW9S7OsV13e8pnMX1QRHUHtUE+lPveyzj39PqOv10rj6
        l8lZQO3pCM8FI2vRnQn8TaieEVovbbb/QA==
X-Google-Smtp-Source: ABdhPJwyc4I75Ae3kixacGjz+bAbJk3GfWt1dioNo+ovRmb1f+yfMm4fGit8Wr+pA5Bpqft+O5TtQQ==
X-Received: by 2002:a63:8c55:: with SMTP id q21mr5260281pgn.96.1622146440931;
        Thu, 27 May 2021 13:14:00 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id 4sm2462456pgn.31.2021.05.27.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:14:00 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v2 1/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 27 May 2021 20:13:39 +0000
Message-Id: <20210527201341.7128-2-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201341.7128-1-zeffron@riotgames.com>
References: <20210527201341.7128-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c       | 84 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2c1ba70abbf1..a9dcf3d8c85a 100644
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
index aa47af349ba8..3718c8a331dc 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -687,6 +687,45 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	return ret;
 }
 
+static int convert_xdpmd_to_xdpb(struct xdp_buff *xdp, struct xdp_md *xdp_md)
+{
+	void *data;
+	u32 metalen;
+	struct net_device *device;
+	struct netdev_rx_queue *rxqueue;
+
+	if (!xdp_md)
+		return 0;
+
+	if (xdp_md->egress_ifindex != 0)
+		return -EINVAL;
+
+	metalen = xdp_md->data - xdp_md->data_meta;
+	data = xdp->data_meta + metalen;
+	if (data > xdp->data_end)
+		return -EINVAL;
+	xdp->data = data;
+
+	if (xdp_md->data_end - xdp_md->data != xdp->data_end - xdp->data)
+		return -EINVAL;
+
+	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void convert_xdpb_to_xdpmd(struct xdp_buff *xdp, struct xdp_md *xdp_md)
+{
+	if (!xdp_md)
+		return;
+
+	/* xdp_md->data_meta must always point to the start of the out buffer */
+	xdp_md->data_meta = 0;
+	xdp_md->data = xdp->data - xdp->data_meta;
+	xdp_md->data_end = xdp->data_end - xdp->data_meta;
+}
+
 int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
@@ -696,36 +735,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
 	struct xdp_buff xdp = {};
+	struct xdp_md *ctx = NULL;
 	u32 retval, duration;
 	u32 max_data_sz;
+	u32 metalen;
 	void *data;
 	int ret;
 
-	if (kattr->test.ctx_in || kattr->test.ctx_out)
-		return -EINVAL;
+	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	/* There can't be user provided data before the metadata */
+	if (ctx) {
+		if (ctx->data_meta != 0)
+			return -EINVAL;
+		metalen = ctx->data - ctx->data_meta;
+		if (unlikely((metalen & (sizeof(__u32) - 1)) ||
+			     metalen > 32))
+			return -EINVAL;
+		/* Metadata is allocated from the headroom */
+		headroom -= metalen;
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
 
+	ret = convert_xdpmd_to_xdpb(&xdp, ctx);
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
+	if (xdp.data_meta != data + headroom || xdp.data_end != xdp.data_meta + size)
+		size = xdp.data_end - xdp.data_meta;
+
+	convert_xdpb_to_xdpmd(&xdp, ctx);
+
+	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval, duration);
+	if (!ret)
+		ret = bpf_ctx_finish(kattr, uattr, ctx,
+				     sizeof(struct xdp_md));
 out:
 	bpf_prog_change_xdp(prog, NULL);
 	kfree(data);
+	kfree(ctx);
 	return ret;
 }
 
@@ -809,7 +880,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
 				     sizeof(struct bpf_flow_keys));
-
 out:
 	kfree(user_ctx);
 	kfree(data);
-- 
2.31.1


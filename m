Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDA39C32D
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 00:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFDWGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 18:06:01 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33737 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDWGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 18:06:00 -0400
Received: by mail-pl1-f172.google.com with SMTP id c13so5384074plz.0
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8QuzYpV7HBVWhenhITBsvNqnVypxG8h6rQTuyk2e6Q=;
        b=Xr6LctfbkYwpaTGqiAKsGRefPP7DPoyhOvU4MI5C5zApD1cuPH87yp6agDaAoMzcpV
         Xds77vCE8KO8mmkuotcY5MZ2KMMLhTN7gS1glbiiHo/ipOImVV85dc5b3RdASsghb9UQ
         sT2Et7+bEb4Z4BNYbBeYsGWq00R3aOpgDl0Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8QuzYpV7HBVWhenhITBsvNqnVypxG8h6rQTuyk2e6Q=;
        b=bwHkv2wzavMkiaceQyVXt+Cb43sQNdgqQBB8W1r9wxnL04CjKqNCcEYyb/qnDw3vdm
         SsYN+6aMsHsfoSaoe2l+v7AMq9GPTHS8pgqivsjRngZBOsRtYJJu8RHGCAA7Vg5DEKY2
         7V4lYJm2Fwm7CNIu385JUeXzH1Y1P3EFB+MOeUzhcaY11LNvWV791Ag/zpcaZ/OeipP3
         r3hri/MAwdkft4QQK1WmFDEUcLfzqgQL3FWlA6fqtgxeFch6QHl7hUq2WppqPAMs2G5w
         QDBlGuGIiQ5YRmaAOWHtb8a9uaMDzNc8K0KRWwsfbSezJQtbEJucPd3+bsVWwKZChAYR
         9EBQ==
X-Gm-Message-State: AOAM533TvFVxexzR++FolJ4czQ1uIMSr6mR66qyCd/55+SwdScG39wSB
        cIxarEtBJUA+ZobyWTVTBYwb5a22iEEGGg==
X-Google-Smtp-Source: ABdhPJzBTSqubyWkq4F3d9dMK6w9U5geTIxeX43yekJi+mxg1BZFdWwIJgJXDUUrWZgM9dpPnzaMeA==
X-Received: by 2002:a17:902:bd0b:b029:ef:8970:281c with SMTP id p11-20020a170902bd0bb02900ef8970281cmr6358800pls.35.1622844179289;
        Fri, 04 Jun 2021 15:02:59 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id bo14sm5435374pjb.40.2021.06.04.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 15:02:58 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v4 1/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Fri,  4 Jun 2021 22:02:33 +0000
Message-Id: <20210604220235.6758-2-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604220235.6758-1-zeffron@riotgames.com>
References: <20210604220235.6758-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c       | 77 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 10 deletions(-)

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
index aa47af349ba8..698618f2b27e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -687,6 +687,38 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	return ret;
 }
 
+static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
+{
+	void *data;
+
+	if (!xdp_md)
+		return 0;
+
+	if (xdp_md->egress_ifindex != 0)
+		return -EINVAL;
+
+	if (xdp_md->data > xdp_md->data_end)
+		return -EINVAL;
+
+	xdp->data = xdp->data_meta + xdp_md->data;
+
+	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md *xdp_md)
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
@@ -696,36 +728,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
 	struct xdp_buff xdp = {};
+	struct xdp_md *ctx;
 	u32 retval, duration;
 	u32 max_data_sz;
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
+		if (ctx->data_meta)
+			return -EINVAL;
+		if (ctx->data_end != size)
+			return -EINVAL;
+		if (unlikely((ctx->data & (sizeof(__u32) - 1)) ||
+			     ctx->data > 32))
+			return -EINVAL;
+		/* Metadata is allocated from the headroom */
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
 
+	ret = xdp_convert_md_to_buff(&xdp, ctx);
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
+	xdp_convert_buff_to_md(&xdp, ctx);
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
 
@@ -809,7 +873,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
 				     sizeof(struct bpf_flow_keys));
-
 out:
 	kfree(user_ctx);
 	kfree(data);
-- 
2.31.1


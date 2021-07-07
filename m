Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A400E3BF1EE
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 00:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhGGWTv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhGGWTu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 18:19:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630EC061760
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 15:17:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso4655762pjc.0
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQT4RJzyl4mGAjwl0rEQHtOnquH245B6mvc8hjvLOVA=;
        b=PhXr5yXvvxGS0Bo3Dz4L5vTYEpAr/oV6ytsQ6KvcRaSmWGyuFQ2nPhTsQLZmNABbZ+
         gFEMrFBNcLpggs1XYy9SlCbmXgVWWf6nGpEnOf2f1p6Amex0VTV8Qs5wPbRYCbG0jWiA
         uOWod386QDFiVRltJjJtHQXdPHncvYwT05MtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQT4RJzyl4mGAjwl0rEQHtOnquH245B6mvc8hjvLOVA=;
        b=tmfOQuEcYpY4lHUBCWGLPcc7iSQp5WiXEH8yg1cWK8YTRyBTy/zxp/NOiSHcrzjTUv
         A8H+bJYR76qrb2irciduqaaEsbpBaMwST6UJAUDFRFqd/KfKK8RFXk9CUMvUPkwWkpTJ
         81PFHDYaISXVY8LxPo4Mfb9GGwCwBlHZdTOfjFFJeZ2e03M/ccdML0T3iBg0KL53s55w
         3S5668fxLal96ejAqg+k43wH7x5A6C+j7jwcCZ5KzuJqnvc8ogjTrd0UJPdHGLRpj55N
         wdTz3JQslMnA+AaHZ5NETnQq5xkifKCCPh4Ubw8kuxwzGmxLUyOVfQm5btXAX4TWsqzE
         YNHQ==
X-Gm-Message-State: AOAM533vJKpOh4x0qvxLW7MhbM7Rf0vtDRTHlYxxSUpMIQQtEcLRqslw
        rDZ6SI+s34EyIzQ9yOjRnxRR12aeojQyNZku
X-Google-Smtp-Source: ABdhPJxfBhBydi4uE/Lm6z0anE41YcUW6jFggVrslYGGbDneSlLEnIL5G8oAgipKgjct6RvHDv2xCQ==
X-Received: by 2002:a17:90a:474f:: with SMTP id y15mr6572288pjg.2.1625696229401;
        Wed, 07 Jul 2021 15:17:09 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id 75sm203748pfx.71.2021.07.07.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 15:17:08 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v8 3/4] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed,  7 Jul 2021 22:16:56 +0000
Message-Id: <20210707221657.3985075-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707221657.3985075-1-zeffron@riotgames.com>
References: <20210707221657.3985075-1-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support specifying the ingress_ifindex and rx_queue_index of xdp_md
contexts for BPF_PROG_TEST_RUN.

The intended use case is to allow testing XDP programs that make decisions
based on the ingress interface or RX queue.

If ingress_ifindex is specified, look up the device by the provided index
in the current namespace and use its xdp_rxq for the xdp_buff. If the
rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
0, return -EINVAL.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
---
 net/bpf/test_run.c | 56 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 229c5deb813c..cda8375bbbaf 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -690,18 +690,60 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
 {
+	unsigned int ingress_ifindex, rx_queue_index;
+	struct netdev_rx_queue *rxqueue;
+	struct net_device *device;
+
 	if (!xdp_md)
 		return 0;
 
 	if (xdp_md->egress_ifindex != 0)
 		return -EINVAL;
 
-	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
+	ingress_ifindex = xdp_md->ingress_ifindex;
+	rx_queue_index = xdp_md->rx_queue_index;
+
+	if (!ingress_ifindex && rx_queue_index)
 		return -EINVAL;
 
-	xdp->data = xdp->data_meta + xdp_md->data;
+	if (ingress_ifindex) {
+		device = dev_get_by_index(current->nsproxy->net_ns,
+					  ingress_ifindex);
+		if (!device)
+			return -ENODEV;
+
+		if (rx_queue_index >= device->real_num_rx_queues)
+			goto free_dev;
+
+		rxqueue = __netif_get_rx_queue(device, rx_queue_index);
 
+		if (!xdp_rxq_info_is_reg(&rxqueue->xdp_rxq))
+			goto free_dev;
+
+		xdp->rxq = &rxqueue->xdp_rxq;
+		/* The device is now tracked in the xdp->rxq for later
+		 * dev_put()
+		 */
+	}
+
+	xdp->data = xdp->data_meta + xdp_md->data;
 	return 0;
+
+free_dev:
+	dev_put(device);
+	return -EINVAL;
+}
+
+static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md *xdp_md)
+{
+	if (!xdp_md)
+		return;
+
+	xdp_md->data = xdp->data - xdp->data_meta;
+	xdp_md->data_end = xdp->data_end - xdp->data_meta;
+
+	if (xdp_md->ingress_ifindex)
+		dev_put(xdp->rxq->dev);
 }
 
 int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
@@ -753,6 +795,11 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	bpf_prog_change_xdp(NULL, prog);
 	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
+	/* We convert the xdp_buff back to an xdp_md before checking the return
+	 * code so the reference count of any held netdevice will be decremented
+	 * even if the test run failed.
+	 */
+	xdp_convert_buff_to_md(&xdp, ctx);
 	if (ret)
 		goto out;
 
@@ -760,11 +807,6 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	    xdp.data_end != xdp.data_meta + size)
 		size = xdp.data_end - xdp.data_meta;
 
-	if (ctx) {
-		ctx->data = xdp.data - xdp.data_meta;
-		ctx->data_end = xdp.data_end - xdp.data_meta;
-	}
-
 	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval,
 			      duration);
 	if (!ret)
-- 
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34953B3867
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFXVPf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhFXVPe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 17:15:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34968C061756
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w71so6293426pfd.4
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2oyGbnv4aKmoaUdSONfGQ4n1QXcyTD2iBZeIIQjJPo=;
        b=hel1LkaR4TZ/AJEYsOTNi3md5/5dwfl4LTGhH6la8egqCekzxaoElNj4Mcgbknpbmu
         cNKf2k0EcXd19+8+w8VLeNpfQtLduMzdPlPaKrAMZOaBSqqj9QUit2GS6N3aGKra65Xr
         9y+ma8yodVuNqedj9/xQIyDRdPVuuIywwYLxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2oyGbnv4aKmoaUdSONfGQ4n1QXcyTD2iBZeIIQjJPo=;
        b=eIzJgijw5aVkmmTxO6yphyHww/c+kJrBkl3ptPXBwUJttnA0C7vWVt6KRNdiR6g3MY
         /74o6k1FQCDW1VUI4ep2ajNmPXDbDekfdFoULAd4tlBR/lFwCjfaDzvZx721E3SbzL0H
         o8Ce+UA105Xf75jjm8GFSa1O3SSNenChcoD1kJMaKkuIlJIywH3rJc84WNCid53c9kg8
         tgqhS+jiO7N0iTxhusWB49wG/q9RANdSaGhXJx+9+EtSikrWAZ42lk50vXdNq02BeatG
         T3qIXhR1xasAEuMKJkLNVTC2stDFcxDi/dpusNlq9kWmMF4xHkCcitpB3j2ubWIWpKsA
         W2VA==
X-Gm-Message-State: AOAM530RF1sJwecVHQwqmOSl20GSGCeEEiOW6mD9PAvPd4CLunUPHX7u
        5bIkDjRY2yxG7D7XwKOjmZ0s6BYRUizhdLeE
X-Google-Smtp-Source: ABdhPJwyfZf6qyAG1P/XIYNWomORtnak91blwkLT8QXR6h5SyXDXln2eegntdkM9xbZxlsfstI2MlA==
X-Received: by 2002:a63:4e4d:: with SMTP id o13mr6362901pgl.361.1624569194375;
        Thu, 24 Jun 2021 14:13:14 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id d13sm3615394pfn.136.2021.06.24.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:13:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/4] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 24 Jun 2021 21:13:03 +0000
Message-Id: <20210624211304.90807-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624211304.90807-1-zeffron@riotgames.com>
References: <20210624211304.90807-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c | 54 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 229c5deb813c..f61f9e41ecaa 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -690,18 +690,58 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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
+		/* The device is now tracked in the xdp->rxq for later dev_put() */
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
@@ -753,6 +793,11 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	bpf_prog_change_xdp(NULL, prog);
 	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
+	/* We convert the xdp_buff back to an xdp_md before checking the return
+	 * code so the reference count of any held netdevice will be decremented
+	 * even if the test run failed.
+	 */
+	xdp_convert_buff_to_md(&xdp, ctx);
 	if (ret)
 		goto out;
 
@@ -760,11 +805,6 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
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


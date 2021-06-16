Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6F3AA6C5
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhFPWuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhFPWuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 18:50:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6217C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a127so3373312pfa.10
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vm1rgkGYVhn5FNENBNBrdvQi/uPkb+1AYTaDLPKVBsQ=;
        b=lP8XCu2U6xN4XTNDasxK7u0oYbQeTomU7lXQLxrqSOHq3tctcs6eSVbiUaCSApBI8E
         psE0sol+HsxyWmGaJZh07P3PQjOWIRdgu4/vYLz5tYHVxnaOkMuINW+Ir8Rm74LjahQB
         CJnY42UqlTSyz8Ipg0iwwzGaLKX7gMETtPZ84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vm1rgkGYVhn5FNENBNBrdvQi/uPkb+1AYTaDLPKVBsQ=;
        b=BgeMdTm7PQJLDLYB2bHQKHv82FQltkEiPaXZeHhW5mR1lKz+KJn1ED4t2yK0QHfEAk
         +dq7y9DpIf0A25ZF0QuTTPggJlss6IdtthncqTzEvdHmGbkSoUwKqe8AviAPIVFDcZec
         Zz8+HdONYuxSpLrgyuDNnSbGihUOXCERz0V1VzsmI04M1BfMLU0yxmTOpjkDuWEahU4i
         /x5tdy4hre4zhCzOuB6C9smQWKiQFq0sol47/wjWY5nog+MmOEBzds9bOw5D1I/kU2On
         psWwytl14C2KGnJQcTLxjmsCYh9T3caQwOi/N7iG28kd4z0LpF8exI/thzXwtNUrk+qu
         32Sw==
X-Gm-Message-State: AOAM533zKM6deVMoHz0Z1PYn+u5rkNM1jwI6QY/a9vXTtgXV0CL8znJY
        2BbpH481jy218bvdedWirMIM3kqe/GcC6g==
X-Google-Smtp-Source: ABdhPJxXAt1YfkUrHZNwC4hf9yPppQfrLhNAPuRvaV20MKbBI7bZz9jiLQ6bO/XflVPzNtaGTQT4DQ==
X-Received: by 2002:a65:6a12:: with SMTP id m18mr1890730pgu.229.1623883677999;
        Wed, 16 Jun 2021 15:47:57 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id p6sm6278672pjk.34.2021.06.16.15.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 15:47:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/4] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed, 16 Jun 2021 22:47:11 +0000
Message-Id: <20210616224712.3243-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616224712.3243-1-zeffron@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
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
0, return EINVAL.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
---
 net/bpf/test_run.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f3054f25409c..0183fefd165c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -690,15 +690,36 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
 {
+	unsigned int ingress_ifindex;
+	unsigned int rx_queue_index;
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
 
+	if (ingress_ifindex) {
+		device = dev_get_by_index(current->nsproxy->net_ns,
+					  ingress_ifindex);
+		if (!device)
+			return -EINVAL;
+
+		if (rx_queue_index >= device->real_num_rx_queues)
+			return -EINVAL;
+
+		rxqueue = __netif_get_rx_queue(device, rx_queue_index);
+		xdp->rxq = &rxqueue->xdp_rxq;
+	}
+
 	xdp->data = xdp->data_meta + xdp_md->data;
 
 	return 0;
-- 
2.31.1


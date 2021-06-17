Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83203ABF64
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhFQXbd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhFQXbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 19:31:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFECC061574
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 16:29:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h16so4691788pjv.2
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7g3i1IqAr0/dMa5B6qI4JmB64MJpjUEjJxft3fhpn/k=;
        b=QfGdwmjJAc3faWLUF0uPu/kZP9gNnCXEwC+/pp2PFV0BWBHPhH262MOe2pgMz9GuzN
         gKb7mii8DvxuMoK4NFmyjHohhkg8xXH8yd7C8jNKGHnPiXgGRwEs+0yTIIuylXEB3bPh
         1ccNnVMC4hXNaA2glmrvp/zm09Xuz7BWytQFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g3i1IqAr0/dMa5B6qI4JmB64MJpjUEjJxft3fhpn/k=;
        b=t8B/UhXlmPPr5h78Tc+W5+aMK4ysDZMRpRK0uFgTm2kh43QQYe/k5S8LKu+MmldQy4
         g7XduXQZGMHyyF3xDdlEBlpYjDoW0QeTCrWAa5FSNUhM3oIZQb5NKtHinQyVBHeEZqQq
         ea1QwBn6UjVdq1F359YdQVFHAgn1S4DRnEeEzJZ9lCvG7OTG0ZmKSuhrtS6CEm8B2lJc
         7OTx0mQ27D/n/dK1nJDugRQwTjxpVLmSrLjEJUMW42CzfNf5qttgURSGuAYlG1f6ORs0
         PBTUvT63pc8cyM8tmBIAI3nJ8bx5GEKxHaEiGJ0hFlj6Yl9Abxlc5Cuj3VQAAloWuHA7
         jdSw==
X-Gm-Message-State: AOAM530Z8k6g7pqTi5hePjkZTfZ5+6+YCb1E3+qwZHtaDHSXTmm60tMc
        uiPWBKKYGJgAuXKd10mZkLJukBQfJdlAyQ==
X-Google-Smtp-Source: ABdhPJzWsHT0MUBk0ooDYK54n1sp48IDhMX5GYZ1i5qFkorqJ948mhifY3wJ387DyZUnCNbCibpHiw==
X-Received: by 2002:a17:902:e546:b029:114:6677:ec2d with SMTP id n6-20020a170902e546b02901146677ec2dmr1989199plf.72.1623972561919;
        Thu, 17 Jun 2021 16:29:21 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id a21sm6217241pfg.188.2021.06.17.16.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:29:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/4] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 17 Jun 2021 23:29:03 +0000
Message-Id: <20210617232904.1899-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617232904.1899-1-zeffron@riotgames.com>
References: <20210617232904.1899-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 229c5deb813c..1ba15c741517 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -690,15 +690,35 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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


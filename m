Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5E3936E4
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhE0UPj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhE0UPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 16:15:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81AC061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:14:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1168251pji.0
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zABw6PbftX8+J2J+e9RuSfP1aEk29gspY6MJ1vjcFZ4=;
        b=ZWE6LFavU52z4S3kRvrGHxZAlhEz8yNjOF7c1Sv51f6KfUcEHe0KydWB7JhY0p0EPW
         bQHnu0ECWwzHem1WcpyxomFntobQLpLVH2iRQ76/YfuIHmbSF7s92yp9bB3CRe8H7bvT
         /qf52E6ur3/ETNjcgrc9iC9RT+zJbTAoQlZvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zABw6PbftX8+J2J+e9RuSfP1aEk29gspY6MJ1vjcFZ4=;
        b=Bh+EtJIOBI9TSEO0vy+TVHD0Bw1d4tMwsMAlk8SfgYhEAM3ln/YUazPhP8w/FQfSB2
         YxyVzcnBo7TPywUizpM0a5d52w6AyoDstjksJ7BvH8hzd1mKS68ScNMuVkglG2UMn6QD
         0EffgYBAhuSHeZWNgPdAW+HxqahqI5RDScnM71c8ctaxPrz1uqwGJKGYc1DUfjZu7o5V
         i7Cjn+0YFQQyGILFyxa4jY95hbcZ60tTqBt503/02V4WRYXXkIeVIZiksc7DQkDwUcn4
         qDcg5X5T86kOKV3I21O6Y4p+yb0F10ueirvagwdJeE9XRKg4q5/crSCn77OqTH88524y
         S5Sg==
X-Gm-Message-State: AOAM531Yowf5eILyKfXgT6uwBLzFwBSnEf30UHG45su6f0xk6X7uaMtn
        gSM9+8vCYapHEVC9Bn2bQa6/In/Q582nDA==
X-Google-Smtp-Source: ABdhPJwG3ubaMNyzC6ptKcgow1fcFwlGt/U+G8HhtyZ9h44+YkS99ASPBfmNHRNYPuEJQIX/ZtRD5g==
X-Received: by 2002:a17:902:d90e:b029:fe:5139:898d with SMTP id c14-20020a170902d90eb02900fe5139898dmr4835761plz.61.1622146444276;
        Thu, 27 May 2021 13:14:04 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id 4sm2462456pgn.31.2021.05.27.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:14:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/3] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 27 May 2021 20:13:40 +0000
Message-Id: <20210527201341.7128-3-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201341.7128-1-zeffron@riotgames.com>
References: <20210527201341.7128-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3718c8a331dc..e14797eb1e14 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -709,9 +709,21 @@ static int convert_xdpmd_to_xdpb(struct xdp_buff *xdp, struct xdp_md *xdp_md)
 	if (xdp_md->data_end - xdp_md->data != xdp->data_end - xdp->data)
 		return -EINVAL;
 
-	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
+	if (!xdp_md->ingress_ifindex && xdp_md->rx_queue_index)
 		return -EINVAL;
 
+	if (xdp_md->ingress_ifindex) {
+		device = dev_get_by_index(current->nsproxy->net_ns, xdp_md->ingress_ifindex);
+		if (!device)
+			return -EINVAL;
+
+		if (xdp_md->rx_queue_index >= device->real_num_rx_queues)
+			return -EINVAL;
+
+		rxqueue = __netif_get_rx_queue(device, xdp_md->rx_queue_index);
+		xdp->rxq = &rxqueue->xdp_rxq;
+	}
+
 	return 0;
 }
 
-- 
2.31.1


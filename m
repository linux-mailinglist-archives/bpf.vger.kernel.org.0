Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C039C327
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFDWEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 18:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFDWEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 18:04:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCF6C061766
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 15:03:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u9so5284544plr.1
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E10jhwQ+zGteZTrclvo5hDD0LPhpRiSihTR8Bydn7YI=;
        b=YQDkElPsg5KqUtUMQtSmZRKCiRVZf8r2d5mqjZ4ios+qicYsNY6wJdfQAV6Y+zGsUx
         B45iTCjM0ukeTBbeBI6D/yn17YSp3dcSo4AwI5qD90y0qoU8anJbiOv7jUmwtiS4OTTt
         PL4QfuOktyymCKAMpgArFyrkI2fJqg6Ktija4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E10jhwQ+zGteZTrclvo5hDD0LPhpRiSihTR8Bydn7YI=;
        b=s6Cie7eYxCiAy4jgxvMXCB+KxU4SS75vZ+kNHDZLD0e0zDBl09cyCVnOmhDrAFUoeh
         ogKXaSF7+s1fo/RPoy86JGDn/ah7xlqTNTH2ExU/l6lIryi2aJ3DacQ4DEyG8SQHOj8e
         t7Lwl8mIisXDvJ51wBrajUJTpgXpqAYxRTTOw1dQbm3l5LZnONmw7xi6YqH4d1USUC/L
         CcI9cLjiEA7M1hLQ31AltoD+zh+NENeLNmBHIpNjkUMq8zz1egZcklKrs5hAR312aCNg
         oVZfzRiWDTkTKTbP8GxQoObYuFbGHUfDcegpKdPLGLY1r5ycgcdwfX1Qj2q0VfAkCmei
         egqA==
X-Gm-Message-State: AOAM531W8zUapRDM+GJOg0Yfa0/EY+NHlFauGWR7iorheAAk0l2hqVZO
        t+CnyOKTTnIeLdzGbYGCdLKK6unzDw4RSQ==
X-Google-Smtp-Source: ABdhPJy8gJ+TVrk4wE7FM6Fym838hORO+LSMTASrD4PgY48p869pCH2WH2XcraJhFOGsSt6aKC7haQ==
X-Received: by 2002:a17:90b:882:: with SMTP id bj2mr6952861pjb.167.1622844181333;
        Fri, 04 Jun 2021 15:03:01 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id bo14sm5435374pjb.40.2021.06.04.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 15:03:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/3] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Fri,  4 Jun 2021 22:02:34 +0000
Message-Id: <20210604220235.6758-3-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604220235.6758-1-zeffron@riotgames.com>
References: <20210604220235.6758-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 698618f2b27e..3916205fc3d4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -690,6 +690,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
 {
 	void *data;
+	struct net_device *device;
+	struct netdev_rx_queue *rxqueue;
 
 	if (!xdp_md)
 		return 0;
@@ -702,9 +704,21 @@ static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
 
 	xdp->data = xdp->data_meta + xdp_md->data;
 
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


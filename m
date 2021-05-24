Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE98338F55E
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhEXWIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXWIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 18:08:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B71C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:07:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so695507pjr.0
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jz8DJ79IeD0bBmW1K0X2g1fKWdajXX13diKnZt2JK1w=;
        b=Ft//+sjiNzQnAAw6Lo9Q2fyiGB4WZ1DmyoeGozIw1r26JDsxmpW9pt4kBFv3yeAT0b
         Js+DXn3P6ivBbCifEeB7q9XmJtF6K+Ai0GiZojUc9i7NUkN2JUYxlfqSSlDREhGHlKwH
         MaLfTLys6x0Gi2r1rvQDbjRBH8WrLJfB2yvcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jz8DJ79IeD0bBmW1K0X2g1fKWdajXX13diKnZt2JK1w=;
        b=cH6SnkJMd53BhYTDMOwmfkS3ewzII3V5OZwXxNHGEfyvZPFWMin/AStaE55bbNj5lD
         8drblOhiQ/w06qyoxUiJFh/sBPHp86KThhuBYdISR4zs61mrAFL931GdmK6D7fbZosuM
         RkQ0zgsnChmVDGPdMSZRBqAgH84z8FfS1JkrwwgFEgJziCy+3PpKwRQKknSeRmVmA6/V
         7dsrIC6MT3C7m5KNwkfbpO/LYBXYf/9xMTOhC/KJz3NoPrPR/bgvP9PGSfMBBFcX0kW0
         AilRoMlXc85VPyLKWBXDDG96qLV6kTU8OgvybB36MxWlbc78xya57J0l6MJ1tn5JtEvc
         cnLw==
X-Gm-Message-State: AOAM5314x/SEIUc4/XE2az9WO/GOyU1Q67joTdg2y8pNttwTgp4WGlta
        +JaTKXDZrdpxnlqYv9X6SKaCs6Y0B8AgfsbQ
X-Google-Smtp-Source: ABdhPJymBCqTatN9vo1zU0WkxV0lbQ5juq8Y9lU8wOJxOz50XL2WWjyk8RzkQM+p2l1sK6Pg74OKNQ==
X-Received: by 2002:a17:90a:4092:: with SMTP id l18mr1341177pjg.35.1621894029453;
        Mon, 24 May 2021 15:07:09 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id k15sm12133338pfi.0.2021.05.24.15.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:07:09 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next 2/3] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Mon, 24 May 2021 22:05:54 +0000
Message-Id: <20210524220555.251473-3-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524220555.251473-1-zeffron@riotgames.com>
References: <20210524220555.251473-1-zeffron@riotgames.com>
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
index 1eaa0959b03a..d882a4831c18 100644
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


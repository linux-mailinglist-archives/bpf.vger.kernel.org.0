Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BE399340
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFBTMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 15:12:01 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:46945 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBTMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 15:12:00 -0400
Received: by mail-pg1-f179.google.com with SMTP id n12so3032486pgs.13
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pg1gl8wAGETBw3StSSmWY+F9bYcItGwT/d+uAkBZmJo=;
        b=e7WRuoUYUzZgFu+xXiFmv1XwR+oxD2X1rBCn77JOMsBaS89gOfgWqAa0WIUf2rIC6G
         d5KUIjyOPhV1F0+dkRkHKqwDO00GZtLo3YlANkmztPr39tHkQIUyNnBWTTUuO66r0S7z
         UfhxghhMulCoYhaZaHNT5kP46jvDwFtdZCUzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pg1gl8wAGETBw3StSSmWY+F9bYcItGwT/d+uAkBZmJo=;
        b=ag056oA67fCy2RVM8b5twBzQ7cN/XkNwOqCUd6gU0qsXFIhKyBrahVCs1mnS1TSDMa
         nWFVhofKjSMAIl3QiBIjJrmXKZvN8eDiL+26Aev2rvnuxdlFAt3lw9mP9api6O3bCPKR
         JxJ2mK2gmrrNqtNLNH1QQi+VrdoYf7Wu36br+hSFdVjMDpZ2PQyUsm2kI/Z9DxUQfE4z
         e6EBHDVuE127RSpnUOfJE1jxwdnvEB8s3vnOZIPxt/GWl+McbI6/czQYP7mu6ossvoU3
         uDMffytK7KvMVcuAYKsTCu53ic852uHtTvhhhbG7DrI6gYQTomd5EgBl6ffSGpJmeksj
         LyYg==
X-Gm-Message-State: AOAM533tNAom2agqhtNiDxwYmzmqWK+0b0lV0N1PJ0cVNFW7wgget/I0
        1PvS8+ubAOx+uXWyqFzqdIhKrIV2KgecDg==
X-Google-Smtp-Source: ABdhPJzyO7dY92HQWzX14NiRRh4FAhkWVcgZNpj6CEOR8dRQah7MESgGTUIRwEyxLnBIfFd/i7Fysg==
X-Received: by 2002:a65:60c5:: with SMTP id r5mr15749388pgv.79.1622660944178;
        Wed, 02 Jun 2021 12:09:04 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id j12sm458036pgs.83.2021.06.02.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:09:03 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v3 2/3] bpf: support specifying ingress via xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed,  2 Jun 2021 19:08:14 +0000
Message-Id: <20210602190815.8096-3-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602190815.8096-1-zeffron@riotgames.com>
References: <20210602190815.8096-1-zeffron@riotgames.com>
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
index ae8741dd2a54..f139b4ca420f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -691,6 +691,8 @@ static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
 {
 	void *data;
 	u32 metalen;
+	struct net_device *device;
+	struct netdev_rx_queue *rxqueue;
 
 	if (!xdp_md)
 		return 0;
@@ -707,9 +709,21 @@ static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
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


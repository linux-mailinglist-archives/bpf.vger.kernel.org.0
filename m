Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8A1BF698
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD3LVz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 07:21:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbgD3LVy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 07:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588245713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lcm/SFLtz33dZ2kaMLmjswPDyn0b4V2Shn7nozNXSFM=;
        b=UElSTWT4WTZehZ5RczXkN9tB+4CSs87IKhS6vC7MnIwnRP3I8aEYr67fTQHVwL4ubohLMY
        Tlm5g2b+eiG45YrB7/GpzFbTQy8KM8zbUDReU/SOQpmaxqtzEkl9AXpuN80rBDyHrhwUOB
        bL6CPxILzS9LC+Oqeb9Zh5DsLisi89Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Gi8xfAeDNmeV8W8XvGemcQ-1; Thu, 30 Apr 2020 07:21:51 -0400
X-MC-Unique: Gi8xfAeDNmeV8W8XvGemcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7920E80B713;
        Thu, 30 Apr 2020 11:21:49 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C819866070;
        Thu, 30 Apr 2020 11:21:43 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id C7F6C324DB2C0;
        Thu, 30 Apr 2020 13:21:42 +0200 (CEST)
Subject: [PATCH net-next v2 16/33] mlx4: add XDP frame size and adjust max XDP
 MTU
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Date:   Thu, 30 Apr 2020 13:21:42 +0200
Message-ID: <158824570274.2172139.9444284897110977921.stgit@firesoul>
In-Reply-To: <158824557985.2172139.4173570969543904434.stgit@firesoul>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The mlx4 drivers size of memory backing the RX packet is stored in
frag_stride. For XDP mode this will be PAGE_SIZE (normally 4096).
For normal mode frag_stride is 2048.

Also adjust MLX4_EN_MAX_XDP_MTU to take tailroom into account.

Cc: Tariq Toukan <tariqt@mellanox.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |    3 ++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c     |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 43dcbd8214c6..5bd3cd37d50f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -51,7 +51,8 @@
 #include "en_port.h"
 
 #define MLX4_EN_MAX_XDP_MTU ((int)(PAGE_SIZE - ETH_HLEN - (2 * VLAN_HLEN) - \
-				   XDP_PACKET_HEADROOM))
+				XDP_PACKET_HEADROOM -			    \
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info))))
 
 int mlx4_en_setup_tc(struct net_device *dev, u8 up)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 787139219813..8a10285b0e10 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -683,6 +683,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(ring->xdp_prog);
 	xdp.rxq = &ring->xdp_rxq;
+	xdp.frame_sz = priv->frag_info[0].frag_stride;
 	doorbell_pending = 0;
 
 	/* We assume a 1:1 mapping between CQEs and Rx descriptors, so Rx



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912E73A114E
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhFIKkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238420AbhFIKkl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13osPXmV51CM+evqtQb1PXhLMNKO0hGWYKSryosHfNU=;
        b=ZckBBsN8EEH1lVMCcmMP9ssBsvDkUOU5znsVLjx3IdcPuNIDTfZBVOnE9AoH7U0s/5MFUU
        tORN8gsb527FTJTzgxHIaTNwowkeXzzUO/6Qms8dO1wz3ksmSMIjHIyfrGeNUIVDP8Shpl
        AD9BSbQIRLrd1sVZgctQJOO8WaoLsI8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-1_AKk2zTPjangPKW3UPxQQ-1; Wed, 09 Jun 2021 06:38:45 -0400
X-MC-Unique: 1_AKk2zTPjangPKW3UPxQQ-1
Received: by mail-ej1-f72.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso7876696ejc.7
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13osPXmV51CM+evqtQb1PXhLMNKO0hGWYKSryosHfNU=;
        b=ZGsY1Fq36qlm0DLWMt1cVScttsEGnwEyFmw2DOo4jlHLCoKkLKnvFTeML08PAYN9W/
         lVeaqw+EklnjKZhpDYOPqKoSMUevuJvUKlGXjZ6iHiqoZx95GvFeU2uot1VUN1P4INsJ
         1KR7Ud+u+vf35459BA1Xg4ZFOp3kxAh53O7XjixMFFW+rUQgD7WlILmc25+hM5dZXPWc
         3uvCq6yvUpfY0y1r15w+oTeHgAXUWnWuPb81ykrRh/ApfNafgIDj9ZetHLm8hiPC2KYD
         kOgCUjPP5dgc6R+o9nYQq+gWk08/ksWXbI+LhTkasAOzHwRX3tE/VHdYRXiyDOc400bm
         KWvg==
X-Gm-Message-State: AOAM531aqB1JxvhkxVwCJgx9iA09xAyv81yXdzlkUTd+QQiIIZCXVD3p
        okaL9Us2DI+rtZths0LH7TmFE3r6wzK7N5I7oh+mhYKx5H12v1Q+ch46m3Es2pL7ffwjo57y5UH
        hRzKxgUjtCDcl
X-Received: by 2002:a17:907:270c:: with SMTP id w12mr28462791ejk.175.1623235124379;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9e5nyoFDDTAOzGAf14fh0+8uA9uZPhafO8NuCa6RdoAIPeTeu87RD7Wd8bQzzXvdc4Qhuag==
X-Received: by 2002:a17:907:270c:: with SMTP id w12mr28462775ejk.175.1623235124029;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dh18sm966980edb.92.2021.06.09.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:38:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFE8A18072F; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH bpf-next 11/17] mlx4: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:20 +0200
Message-Id: <20210609103326.278782-12-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The mlx4 driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
program invocations. However, the actual lifetime of the objects referred
by the XDP program invocation is longer, all the way through to the call to
xdp_do_flush(), making the scope of the rcu_read_lock() too small. This
turns out to be harmless because it all happens in a single NAPI poll
cycle (and thus under local_bh_disable()), but it makes the rcu_read_lock()
misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around. Also switch the RCU
dereferences in the driver loop itself to the _bh variants.

Cc: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index e35e4d7ef4d1..3f08c14d0441 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -679,9 +679,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 
 	ring = priv->rx_ring[cq_ring];
 
-	/* Protect accesses to: ring->xdp_prog, priv->mac_hash list */
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(ring->xdp_prog);
+	xdp_prog = rcu_dereference_bh(ring->xdp_prog);
 	xdp_init_buff(&xdp, priv->frag_info[0].frag_stride, &ring->xdp_rxq);
 	doorbell_pending = false;
 
@@ -744,7 +742,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 				/* Drop the packet, since HW loopback-ed it */
 				mac_hash = ethh->h_source[MLX4_EN_MAC_HASH_IDX];
 				bucket = &priv->mac_hash[mac_hash];
-				hlist_for_each_entry_rcu(entry, bucket, hlist) {
+				hlist_for_each_entry_rcu_bh(entry, bucket, hlist) {
 					if (ether_addr_equal_64bits(entry->mac,
 								    ethh->h_source))
 						goto next;
@@ -899,8 +897,6 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 			break;
 	}
 
-	rcu_read_unlock();
-
 	if (likely(polled)) {
 		if (doorbell_pending) {
 			priv->tx_cq[TX_XDP][cq_ring]->xdp_busy = true;
-- 
2.31.1


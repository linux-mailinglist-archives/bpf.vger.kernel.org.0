Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812E3A114D
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhFIKkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238070AbhFIKkl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jk02ESooGWTSdBozEufWm00wwV1iSla6r5tCLEhagY4=;
        b=XzH+xWCCJYVDHpbJ/uAwC4CxfvVpGLxC4SiDmGk5xjEAcCY7L9htvmbBj7H6BFW+Fx6TXC
        j0HXw9UqG4t82cXW7qaCqXgP/OMWV+/WSqdkGkafTcrTKczBbUJPdqIAWFDjJ1c8TSf/fN
        3VEyk6ki6Z5m71BRDCBvRkA0Qkh4fjc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-eu9WBf9lMz67C8k4IzRQZQ-1; Wed, 09 Jun 2021 06:38:45 -0400
X-MC-Unique: eu9WBf9lMz67C8k4IzRQZQ-1
Received: by mail-ed1-f69.google.com with SMTP id y7-20020aa7ce870000b029038fd7cdcf3bso12176695edv.15
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jk02ESooGWTSdBozEufWm00wwV1iSla6r5tCLEhagY4=;
        b=tnObGcMfAn8K8RuNLCHr4fj010UUgtq+U8gobhfE6GMXaoE4KCN4SASWqKEtj490UQ
         zvukU0T66Hl9HYyh+a9x0q/wTqRX/l4xSULeXDxZaHKFFga6X3uM2wYeJq6QA6I8WoPb
         yaCj9hgA5vHfsSZF6dYBW9GO0v0LD1n3twpMh63dH+p4k9iBEJ+5E2plNcqFPX+e5cbk
         8/vxNYuiuMwUpDstQQkXeNLkw8CwfIPZMHg7jcjKZwgc4iUt3XAAs3LPD6lM+KyCzlGq
         bav1eexzSDMl7N0PKQW3PnhPsb1TiSYRI0x8CtunrPOxmiFK+IUQDLRaMW8vnRrtsnwz
         ZTxA==
X-Gm-Message-State: AOAM531STR3p3Dxa/t46oJ0qUge/hS3QDf243pDNhl2Z+gXD5KqNqrMv
        L+pIilFm4Flw5lXj9wlqSV5n3O8xr5/rqZNrEPHOEKhhZWZAtbVnxBGHezxowf2Zb1JuRTqL/tB
        iqZLWRdX6Z0sM
X-Received: by 2002:a17:906:8a55:: with SMTP id gx21mr28306410ejc.179.1623235124152;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8vD1ubOmif6w/i6ZswfYgm1TfNtkHvLNWlj29pRDEzzgimzt9ncLfA52oAlvj9EOHKV8cXw==
X-Received: by 2002:a17:906:8a55:: with SMTP id gx21mr28306386ejc.179.1623235123797;
        Wed, 09 Jun 2021 03:38:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id br21sm925884ejb.124.2021.06.09.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:38:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE3D7180732; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>
Subject: [PATCH bpf-next 14/17] sfc: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:23 +0200
Message-Id: <20210609103326.278782-15-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sfc driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
program invocations. However, the actual lifetime of the objects referred
by the XDP program invocation is longer, all the way through to the call to
xdp_do_flush(), making the scope of the rcu_read_lock() too small. This
turns out to be harmless because it all happens in a single NAPI poll
cycle (and thus under local_bh_disable()), but it makes the rcu_read_lock()
misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around.

Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/sfc/rx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 17b8119c48e5..606750938b89 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -260,18 +260,14 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	s16 offset;
 	int err;
 
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(efx->xdp_prog);
-	if (!xdp_prog) {
-		rcu_read_unlock();
+	xdp_prog = rcu_dereference_bh(efx->xdp_prog);
+	if (!xdp_prog)
 		return true;
-	}
 
 	rx_queue = efx_channel_get_rx_queue(channel);
 
 	if (unlikely(channel->rx_pkt_n_frags > 1)) {
 		/* We can't do XDP on fragmented packets - drop. */
-		rcu_read_unlock();
 		efx_free_rx_buffers(rx_queue, rx_buf,
 				    channel->rx_pkt_n_frags);
 		if (net_ratelimit())
@@ -296,7 +292,6 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 			 rx_buf->len, false);
 
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
-	rcu_read_unlock();
 
 	offset = (u8 *)xdp.data - *ehp;
 
-- 
2.31.1


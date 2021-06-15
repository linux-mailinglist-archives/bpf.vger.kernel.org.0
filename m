Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8D3A838F
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhFOPGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 11:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231433AbhFOPGe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 11:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623769469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZyBRJPoB1j5/g6EWUWSPPNl7ozTkFFFt8p6irUhI/M=;
        b=bOgrqMspaxbKC5/kD7qfWMq0ym6BlEhLWZGoDiNXz7yAd75taJGDnwgw2K0ekXV8VTP3Vg
        LWhECBZ79HOYk2ZH/dde8QGeBJ7b6TKlnYoVT6hqDm8JSVao4NH/qGfzj7C6qbgV6N1kMY
        5VRY4Q3Iirfdzi6ueeKFqqMcvigOlB0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-FXJYciJEOQWoRI6ahd944w-1; Tue, 15 Jun 2021 11:04:25 -0400
X-MC-Unique: FXJYciJEOQWoRI6ahd944w-1
Received: by mail-ej1-f69.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso4679640ejc.7
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZyBRJPoB1j5/g6EWUWSPPNl7ozTkFFFt8p6irUhI/M=;
        b=TF/B1lGBzpvgR94oJCPPW7qcyhy34RSZspjFYsET0gsr+5ZDg2m0qYf3BVc2cyNXAz
         e62VNEk9mPGQWAdAJp7hmF8R2NYLPh0P9YHtYne9qiE/j9hzz1JSVY8H8DfYeeMgJOyY
         N3oB2V9RNgLxptRE+rSpy7j8u1INx/sfBWhVn5MoCugqwfddCzuVKTaPr+vcEd72d5xn
         +wxPZl2ftC2V1pecjFyhBZNTOYwNS4BU1lbZGKUzd2vU97gA4xtxr9crhKMUL3J+UzMT
         N1RXwmOzIJ9BZmSAf1jrgEq+TVoehgBTNW3XCie451gTcMdchjbfBgeGS9qiUd8VGBn7
         5nlA==
X-Gm-Message-State: AOAM53386reQ5z5ReE7g6eHi2NRcCuVQCUjJTEF3PyTJqdt3sNJNJmEn
        7vRSSiYKl/zIK1V7X5BJClgjE33AXMIejog/U8hGq9z1gWoQsccu4qB+q7yVa6xeY6ZKj/xGYle
        P6wP37RLpzaLe
X-Received: by 2002:a50:fb8f:: with SMTP id e15mr23315226edq.46.1623769464510;
        Tue, 15 Jun 2021 08:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytWmHoc5NSv2Ml6IB/zXKszT4ABcEjPhTM0+V3qJGdbm2cn7dpYji1+8/ONPwzQWZqoX25Dg==
X-Received: by 2002:a50:fb8f:: with SMTP id e15mr23315193edq.46.1623769464293;
        Tue, 15 Jun 2021 08:04:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u21sm7514919eja.59.2021.06.15.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:04:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1744F180736; Tue, 15 Jun 2021 16:54:59 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>
Subject: [PATCH bpf-next v2 13/16] sfc: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:52 +0200
Message-Id: <20210615145455.564037-14-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/sfc/rx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 17b8119c48e5..3e5b88ab42db 100644
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
@@ -295,8 +291,10 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
 			 rx_buf->len, false);
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
-	rcu_read_unlock();
 
 	offset = (u8 *)xdp.data - *ehp;
 
-- 
2.31.1


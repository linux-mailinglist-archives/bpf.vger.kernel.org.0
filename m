Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC313B189B
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFWLQD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhFWLQC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmhJ1VlINXTEKM3djohmsywIadv1r5SFbuahHAWTyD8=;
        b=K3tgma1Mz+MO509rH/2n+uikGc/fjdA9A/JmOerMdSt2bTY/tolNhMRrbHv16oRvpelUvi
        WR603V9VUY34w/O9eMmYGYx2+VChUr7ZA1R4wFa1/pkQ20Rc2F7oYcKYgiBqfBHIIpFbZ5
        CLkJnYpALlUEFe7sLdfWhBw2gJw/Or0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-5ueRdsoDNxGZaGYKekMJ8w-1; Wed, 23 Jun 2021 07:13:43 -0400
X-MC-Unique: 5ueRdsoDNxGZaGYKekMJ8w-1
Received: by mail-ej1-f70.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso845301ejo.13
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmhJ1VlINXTEKM3djohmsywIadv1r5SFbuahHAWTyD8=;
        b=qxIXusm59kQlYmY4oMNSXNR1AYDs9pkvIV6qRWMvksxRS0SFTd60aqLr6iBagcPI2G
         NmLwWHLHdiItrimkb3+QCZ5qjMhpCTytObThpCULDXN+uypCiEEqujevfoSYP2HB35Yn
         f5jjNB7uZZhCjc7P5o7ft2hV5P5v4ZMkSrM6xIQw3NaS6sAOmyS6+IXiQViG6KOPb346
         hCiG7CLGjQkedKJYwi+8Q9L/GRkeAN0ft3YHexL1lhw1NvfyS6AQROWN8gJIRoS9VCBK
         5MjnsPEB/PfpPn5hqk4B45KckfByAFr6q+/2ieOrVpNz6vaenI6Im9uWhzb80LZtb1xy
         eSXA==
X-Gm-Message-State: AOAM532BZ7snIktZAGXsplk0eZU1BQUIs+N0HkLJkPUywxNolCsDK3k8
        BLnndwtIRjsbe6Hb5kBO5Ay8PqTNMY1MXrNNN4B28f1grJezJLj+HDYyxw5DLv79e8bScrnPp5M
        Zdxft4bsq8xvI
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr9481667ejb.551.1624446822286;
        Wed, 23 Jun 2021 04:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdQSSJcE+91z72FaynqtRNDzaWX4zKiT+FfIm+2jhIEcgvH1gQT2AERfxu2ILllE2rf+WhJA==
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr9481629ejb.551.1624446821923;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id aq21sm7624726ejc.83.2021.06.23.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:13:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4C25318073C; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH bpf-next v4 12/19] marvell: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:20 +0200
Message-Id: <20210623110727.221922-13-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The mvneta and mvpp2 drivers have rcu_read_lock()/rcu_read_unlock() pairs
around XDP program invocations. However, the actual lifetime of the objects
referred by the XDP program invocation is longer, all the way through to
the call to xdp_do_flush(), making the scope of the rcu_read_lock() too
small. This turns out to be harmless because it all happens in a single
NAPI poll cycle (and thus under local_bh_disable()), but it makes the
rcu_read_lock() misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around.

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/marvell/mvneta.c           | 2 --
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 7d5cd9bc6c99..b9e5875b20bc 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2370,7 +2370,6 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 	/* Get number of received packets */
 	rx_todo = mvneta_rxq_busy_desc_num_get(pp, rxq);
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(pp->xdp_prog);
 
 	/* Fairness NAPI loop */
@@ -2448,7 +2447,6 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		xdp_buf.data_hard_start = NULL;
 		sinfo.nr_frags = 0;
 	}
-	rcu_read_unlock();
 
 	if (xdp_buf.data_hard_start)
 		mvneta_xdp_put_buff(pp, rxq, &xdp_buf, &sinfo, -1);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b2259bf1d299..521ed3c1cfe9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3852,8 +3852,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 	int rx_done = 0;
 	u32 xdp_ret = 0;
 
-	rcu_read_lock();
-
 	xdp_prog = READ_ONCE(port->xdp_prog);
 
 	/* Get number of received packets and clamp the to-do */
@@ -3988,8 +3986,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
 	}
 
-	rcu_read_unlock();
-
 	if (xdp_ret & MVPP2_XDP_REDIR)
 		xdp_do_flush_map();
 
-- 
2.32.0


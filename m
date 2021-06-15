Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982C13A835A
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFOO5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 10:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhFOO5Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 10:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623768911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rY2VfBWw6NJ0/51nfkfzpQbN8Kg/IiRrFOK+qEg2pA4=;
        b=fJGgf0fmYBJ/yu0/oXh4QqvwosS682jmUbvzFLAYILs+04z/ZSo+vIWOx3rQRiOnxmQiHj
        CVePXs21ZwsBkDr+QwU1sRz+RlvDxV8gv0kGFi65fwRtybe/n/qr34v4Mwz7yX8WadHDHb
        GtryHSWYT6U9TJ8tzaEaDSsBnZqB6lQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-8zKBDl0tOK6AsJpNoCqA5w-1; Tue, 15 Jun 2021 10:55:09 -0400
X-MC-Unique: 8zKBDl0tOK6AsJpNoCqA5w-1
Received: by mail-ed1-f69.google.com with SMTP id a16-20020aa7cf100000b0290391819a774aso20495642edy.8
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 07:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rY2VfBWw6NJ0/51nfkfzpQbN8Kg/IiRrFOK+qEg2pA4=;
        b=hdosVOHw8548CBxk14xXhCGMzgE2kuzUlhjOJpf8Zf/zj7ZrpO3vq9g09E4kEr+x6m
         sgXrz6YURykc7E3PqF8KeUpuq8EDb4BruTJvQZtEIPqH7J+931+W4If4iUYjUmYoZcsf
         5xa52utboTrofplPUZqTGtPMMWonOTSo+JgraePHe0ZRGZImtdHElxGxvs2+arjn+FvM
         zcZgfjkk1U8qVDMzrJKSly5/hBJim9BPbbyY6waVVZsThQokU1Gqvo4w+XI2UJpGjKfD
         NWMtJbvJXVnT4UaGY244Lk1jBVairtl5m95jVtzVt317JkLW0CYgJuGufTfmD/KC7lNi
         ix4g==
X-Gm-Message-State: AOAM531oSkLIU5NJNyUPW+VwCJgdcY28+2ex/0m5yEiK7guQDyMz4U1/
        isnyG9eRAmJ4Xl5V+XbTIsjVOhM6sOdVzNv7T33pdsplKksa5xMRUZDHq8fK2P3uwiOFt492ceT
        INAjt4F2mBe1f
X-Received: by 2002:a17:906:dfd1:: with SMTP id jt17mr21253055ejc.486.1623768908511;
        Tue, 15 Jun 2021 07:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUc77COnG0WIdO1tAjDrhLpnKaKhnq5sFxyuzHGltCcw1hnUBlYA0poEo+mX++Ywz8VM61xg==
X-Received: by 2002:a17:906:dfd1:: with SMTP id jt17mr21253020ejc.486.1623768908212;
        Tue, 15 Jun 2021 07:55:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id cf26sm10281358ejb.38.2021.06.15.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:55:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6CA1180732; Tue, 15 Jun 2021 16:54:58 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 09/16] marvell: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:48 +0200
Message-Id: <20210615145455.564037-10-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
 drivers/net/ethernet/marvell/mvneta.c           | 6 ++++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 7d5cd9bc6c99..c2e9cbebc8d1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2370,7 +2370,6 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 	/* Get number of received packets */
 	rx_todo = mvneta_rxq_busy_desc_num_get(pp, rxq);
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(pp->xdp_prog);
 
 	/* Fairness NAPI loop */
@@ -2421,6 +2420,10 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 			goto next;
 		}
 
+		/* This code is invoked within a single NAPI poll cycle and thus
+		 * under local_bh_disable(), which provides the needed RCU
+		 * protection.
+		 */
 		if (xdp_prog &&
 		    mvneta_run_xdp(pp, rxq, xdp_prog, &xdp_buf, frame_sz, &ps))
 			goto next;
@@ -2448,7 +2451,6 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		xdp_buf.data_hard_start = NULL;
 		sinfo.nr_frags = 0;
 	}
-	rcu_read_unlock();
 
 	if (xdp_buf.data_hard_start)
 		mvneta_xdp_put_buff(pp, rxq, &xdp_buf, &sinfo, -1);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b2259bf1d299..658db1720826 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3852,8 +3852,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 	int rx_done = 0;
 	u32 xdp_ret = 0;
 
-	rcu_read_lock();
-
 	xdp_prog = READ_ONCE(port->xdp_prog);
 
 	/* Get number of received packets and clamp the to-do */
@@ -3925,6 +3923,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
 					 rx_bytes, false);
 
+			/* This code is invoked within a single NAPI poll cycle
+			 * and thus under local_bh_disable(), which provides the
+			 * needed RCU protection.
+			 */
 			ret = mvpp2_run_xdp(port, xdp_prog, &xdp, pp, &ps);
 
 			if (ret) {
@@ -3988,8 +3990,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
 	}
 
-	rcu_read_unlock();
-
 	if (xdp_ret & MVPP2_XDP_REDIR)
 		xdp_do_flush_map();
 
-- 
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA23ABE3C
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFQVjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231203AbhFQVjf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/T3H4vaV8F+Q+x5m1dW8YU/RP90nVjw+/NyR+B0cto=;
        b=RwTWpJxetiam5oVIzIWEXQj8BpTAo/DJPK3GC2CVlO/TNGpHrrJOpk3q9z6DDuRKf0WlCN
        kKf1cy7PlGzVvqnDIZGxgXLViga0IE47kFpyqOu2Eebvva5aE/MqyKmQHH3BAhr5YU8Zsy
        ul6BfmvcRzQ39ndPuGV02O20b48FIMs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Q3AHFvRwMYe_l1hsPDJb1g-1; Thu, 17 Jun 2021 17:37:25 -0400
X-MC-Unique: Q3AHFvRwMYe_l1hsPDJb1g-1
Received: by mail-ej1-f72.google.com with SMTP id n19-20020a1709067253b029043b446e4a03so3035499ejk.23
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/T3H4vaV8F+Q+x5m1dW8YU/RP90nVjw+/NyR+B0cto=;
        b=UHC7cHtRpRu2FIFMPxqpl5fgu5BmcC9U/ukP1MGe91GUz1Prx+GNsLnbRElpn1jxiZ
         YDNMBqCUdjt0yLWu0O89syVUjiYh9S2YPnYPwQRM/dkw7ffxmL0L/x4uzq5uESUbY/j9
         EHFUjuxHnOknCLWfAy7cOAXcAiD8xTNja1HNufUzjKdUgRs2hu+GrLyNG29gq1Mh4dc3
         Lcw/pFEk9NPfxtEbX36HGN8MwOMa++X03e7dLNiYJK//T2Zf6WXUPa9lEq9ExgMxs+fR
         zZazTy8op2zNlyPcObHcPqVsVbt160xdGr/mlcpYWRXitkXAlZwdBeVDIph0HLxg88Qn
         7EYg==
X-Gm-Message-State: AOAM530VCrCzI5/9397lZBHVaEOZhNQSmyI/I6qB4uxQjq9JyZeOLhQo
        O9Ki7Bb59cJfebKl2Lix+IHBbkXMmt8bN0OaazQNJ8lJD5P5TbzQzNjxWCrSCIOwxyp+2r72DZ4
        7ssUVvp6oS+eP
X-Received: by 2002:a05:6402:b5a:: with SMTP id bx26mr493956edb.81.1623965844135;
        Thu, 17 Jun 2021 14:37:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRYMJ1okfOU42zzGSz1z3QdJrJk3hRHhSFfun2L1fNVGPvJLVoSQn8Ec15Jt6SRMeYoFq9xQ==
X-Received: by 2002:a05:6402:b5a:: with SMTP id bx26mr493935edb.81.1623965843903;
        Thu, 17 Jun 2021 14:37:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i10sm123544eja.3.2021.06.17.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:37:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AF9FF180732; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 09/16] marvell: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:41 +0200
Message-Id: <20210617212748.32456-10-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
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
2.32.0


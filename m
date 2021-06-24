Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E971B3B3386
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFXQI5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhFXQIr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RneWJJLq4syfEmR6mKrQCiPS0LPskxbjtJMl3vI+wY=;
        b=J3HDHzJTO0rrFmvFL/HxJuI91Kf3xNexxX7uHSLx/7SpEpkCUcwk6XcWcrBL3oVipj4Hfz
        6ld2vXLga9TWyqnrsbl7S6T6Iq88OcOBGAjmxf+mURhBydV48PVmqxZv3Ncyk50AZp8K1x
        lSfwVCbjqMeMQynzsbflQ1alZ9lPYxM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-TYYNzIusPXG08pQb4PsPig-1; Thu, 24 Jun 2021 12:06:25 -0400
X-MC-Unique: TYYNzIusPXG08pQb4PsPig-1
Received: by mail-ed1-f72.google.com with SMTP id v12-20020aa7dbcc0000b029038fc8e57037so3623556edt.0
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RneWJJLq4syfEmR6mKrQCiPS0LPskxbjtJMl3vI+wY=;
        b=MYVhAitxUke0JDPb06qCUlL4MLv0JWy9aZRoujf3TLSY5jugduwFpS8BP6JiMb5C/M
         mjCZxkh53oSW4HegEHXACC5kZ8Y5CSUe9mKMtnORACuU0Dz/tZQeQkZ8np3Sfy7jPN3t
         dWMFBPhH+7T8PIg2TiZ7Hh0nbr+B/uE40rU+cPrng2QXTBzUNJrpfzuh6lSPC52y5NL8
         klesOlUjxRmdaIRwN6xNSfMwr5BlCd+/GhcbSjelKpTDdZiNgZnhsjt2PzMugCKXC9YO
         aizk9srsQ2mjvBo1zDpKX5ccdQ6tMNs9nRLs2fYvvEOaat2cSxbsa3HWQ3eLnUx8Y68f
         Cu4A==
X-Gm-Message-State: AOAM530G+z3ONqiNwrvqiuSuBfwTXsUz1N6vhoyT5GLPkjAdp/nFxEH6
        B5wynOsmahdemAT7gq4NKMSP99TNKYNJ5b+MOuPacDtplDlMCSw78Ef6J3Clnef5Iw+PHufG173
        EfeLjzd8tl1bU
X-Received: by 2002:a05:6402:1c1a:: with SMTP id ck26mr8090746edb.230.1624550783311;
        Thu, 24 Jun 2021 09:06:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsnVsDAn+RfC06sxjMqbpeG3bGOhaMNmAiQdvprfLfKdKQ+jGnt0sMSwNSCElGhaGOQmVlHg==
X-Received: by 2002:a05:6402:1c1a:: with SMTP id ck26mr8090699edb.230.1624550782981;
        Thu, 24 Jun 2021 09:06:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e6sm1460005ejm.35.2021.06.24.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 82C1E18073D; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
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
Subject: [PATCH bpf-next v5 12/19] marvell: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:06:02 +0200
Message-Id: <20210624160609.292325-13-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
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
index c15ce06427d0..ada4e26a5492 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2373,7 +2373,6 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 	/* Get number of received packets */
 	rx_todo = mvneta_rxq_busy_desc_num_get(pp, rxq);
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(pp->xdp_prog);
 
 	/* Fairness NAPI loop */
@@ -2451,7 +2450,6 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		xdp_buf.data_hard_start = NULL;
 		sinfo.nr_frags = 0;
 	}
-	rcu_read_unlock();
 
 	if (xdp_buf.data_hard_start)
 		mvneta_xdp_put_buff(pp, rxq, &xdp_buf, &sinfo, -1);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9bca8c8f9f8d..c31677527a02 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3881,8 +3881,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 	int rx_done = 0;
 	u32 xdp_ret = 0;
 
-	rcu_read_lock();
-
 	xdp_prog = READ_ONCE(port->xdp_prog);
 
 	/* Get number of received packets and clamp the to-do */
@@ -4028,8 +4026,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
 	}
 
-	rcu_read_unlock();
-
 	if (xdp_ret & MVPP2_XDP_REDIR)
 		xdp_do_flush_map();
 
-- 
2.32.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32CC3A1155
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhFIKkr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238985AbhFIKkn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVpjMkk8Gj+sNRZ7mlrzY9T8oghFils6hen5lUAvCOo=;
        b=VgiG2Y5bo0z0g/O3irNoy7OGc3mzhtH4aE1Jq5kDw/j3MaepBWYeWQqtRrAcErqM+mPbqi
        ls+eiqIioPPWR3CU+Jm0opYkVQtvnsf7osXQhoDtx+6K7FDRMxSJWhGOBOAdBJJjwIDr/B
        49o8EubSKIeXR0kqSvwKE0rDErmaF6g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-wwozpe7xMzmYO1AegZ_Dow-1; Wed, 09 Jun 2021 06:38:45 -0400
X-MC-Unique: wwozpe7xMzmYO1AegZ_Dow-1
Received: by mail-ej1-f70.google.com with SMTP id p18-20020a1709067852b02903dab2a3e1easo7860092ejm.17
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVpjMkk8Gj+sNRZ7mlrzY9T8oghFils6hen5lUAvCOo=;
        b=Ua7euNbYubG9xvGdXsVCBGIlqJtg8MEaOk3zOjMWycSSF2dTtQPZpoXoRiqSSqXYk2
         iGGXTkFTo3pUeFAgDnfewaAgp5hckB9ydGdbkE0BZSHTPhQexBsFseMkh8vv36zB5qld
         Kw/DI8YOkh8Pws5YzYQsfm+s96OrHeaAJdQMYeL6nVDibx89L6vfbNjNfF9hEGh0lDV3
         wzuSUfecXb6WoWfDHvqWuXsmcr7glGF45rXFdE4Ho+ZvSWcOIbFJqdZnWnmHoW0eWneA
         z4F3jH1/1Xy9+lF0ZdJNIWWCOYbHHMOcPdxhn4AoAIES424Bw5h5GqtS9atdQQQ8D0+i
         Bvjw==
X-Gm-Message-State: AOAM533o9wS0CgIAnwdcvm09DuVGgfqPMg8caZevPqYNUuffh/KL6Pad
        WSjkQ2TOGww71pXF1sNnGaTJNSvU9YqmwXGaspchfVMDr2swJcUKFxqJhdQtroGfXoOSeIiM5nd
        o0Yu1wSPdnuCY
X-Received: by 2002:a05:6402:175b:: with SMTP id v27mr29875917edx.61.1623235124603;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeg8YZkdSRKAD9U94TGCLmHyCR0FZopyRpYHvGYd6V6x/Dm2yQwQ70S9kEXmHvlcWDOFO/Dw==
X-Received: by 2002:a05:6402:175b:: with SMTP id v27mr29875895edx.61.1623235124234;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p10sm927332ejc.14.2021.06.09.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:38:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B757318072E; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH bpf-next 10/17] marvell: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:19 +0200
Message-Id: <20210609103326.278782-11-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
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
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089973ABE0F
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhFQVaQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233090AbhFQVaN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HHxZ70enPSVJrHvmI2lNUfsNsQ5hyZDG+eWNYytmQM=;
        b=PMT4XWzUBZDWG2f+2uMkyfZd5fEyla64cz85KHk9bNYJ45s1rCJVt6ZVhd2SLNDSGOAQyC
        +JNoHEPL8QCsnMpVOcUuE8fH8HZ/cOF780EmEPhNQsKN8XhXS6Cq3bqMbw1oD6x8gOzxVj
        YabyHRcShouDE6Gk9l/nZR9sWvE7I3Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-6hoGTueMPtufSuP8ieEn3g-1; Thu, 17 Jun 2021 17:28:03 -0400
X-MC-Unique: 6hoGTueMPtufSuP8ieEn3g-1
Received: by mail-ed1-f70.google.com with SMTP id y16-20020a0564024410b0290394293f6816so2362379eda.20
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HHxZ70enPSVJrHvmI2lNUfsNsQ5hyZDG+eWNYytmQM=;
        b=eoRU+EQoOn3scy9J39cPUZUOIG3DZv1TJS2xRx5XNnfaYh2gBXqN9GGYhmH1OMzoI2
         wP8Jb63feOlUOv9XgvMFYV88Xg1aSn4ajHv+erFp1HbAR94h3T+ab4MNNV3gG26H+SD9
         l/UplF2JRfSBuXiOCmh3mStAhwTl03REjGbTaYvTd/TCX1XclxraQjyLddPCfcWBtinY
         HqM8MSw7N1Im6IJHlCxy9EKgl4LITHKLrp9hkHl8N/GE48vCdHFYlLHd2lmuLuG0Po9i
         7ijWuzUd0rFScR0VAzxwFVp21ZyVijllqsYIK8O2v08lhXdW/JwaEhiCA/HdzWldB3GR
         na7w==
X-Gm-Message-State: AOAM5327rru9eNAgTeBqvTLhCvni5nOQhOIQny1xD0HR/jCuC1heqoMp
        NgMhAi+ricLjEOYULTMioQwMkyGuO+UQGIPslWlD0dNYI/JlExizHu3U9b6Yk1w3LlVxe9n9HJJ
        67QwvNCzpdlTb
X-Received: by 2002:a05:6402:27d0:: with SMTP id c16mr475910ede.60.1623965282046;
        Thu, 17 Jun 2021 14:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo+0no19/AfrC5WVLy9yZXt8Bo09UqWLQ/taswl5RGBhcCnNAeCwZslfDXtE9wkSElMgquYg==
X-Received: by 2002:a05:6402:27d0:: with SMTP id c16mr475898ede.60.1623965281944;
        Thu, 17 Jun 2021 14:28:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q15sm5324872edr.84.2021.06.17.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:28:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D5B79180737; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH bpf-next v3 14/16] netsec: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:46 +0200
Message-Id: <20210617212748.32456-15-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The netsec driver has a rcu_read_lock()/rcu_read_unlock() pair around the
full RX loop, covering everything up to and including xdp_do_flush(). This
is actually the correct behaviour, but because it all happens in a single
NAPI poll cycle (and thus under local_bh_disable()), it is also technically
redundant.

With the addition of RCU annotations to the XDP_REDIRECT map types that
take bh execution into account, lockdep even understands this to be safe,
so there's really no reason to keep the rcu_read_lock() around anymore, so
let's just remove it.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/socionext/netsec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index dfc85cc68173..e07b7c870046 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -958,7 +958,6 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 
 	xdp_init_buff(&xdp, PAGE_SIZE, &dring->xdp_rxq);
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(priv->xdp_prog);
 	dma_dir = page_pool_get_dma_dir(dring->page_pool);
 
@@ -1019,6 +1018,10 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 				 pkt_len, false);
 
 		if (xdp_prog) {
+			/* This code is invoked within a single NAPI poll cycle
+			 * and thus under local_bh_disable(), which provides the
+			 * needed RCU protection.
+			 */
 			xdp_result = netsec_run_xdp(priv, xdp_prog, &xdp);
 			if (xdp_result != NETSEC_XDP_PASS) {
 				xdp_act |= xdp_result;
@@ -1069,8 +1072,6 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 	}
 	netsec_finalize_xdp_rx(priv, xdp_act, xdp_xmit);
 
-	rcu_read_unlock();
-
 	return done;
 }
 
-- 
2.32.0


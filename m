Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA25B3A8393
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFOPHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 11:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhFOPHD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 11:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623769498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfPOjpqs+xPPviaak2ogNv+B986oj5TZMO/NC3oJo44=;
        b=h3+DttZKcpaUYsQQyVgmb/rg5bsBQHy8XyWMU7rc3orU8RoFf+FNng0TVh4c/o/l8ok3OC
        Tuux2lLiMl1wy5YWc6yR1+LTrhuiIYr6TknkiycdLd3euz0Ox908J4eeS+CnunmW6wiuXh
        pp8OJocAOEZO+6CwiByU4vXDhvBNWKA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-Ox5nhFSGNeuDvEBIWNxQFA-1; Tue, 15 Jun 2021 11:04:26 -0400
X-MC-Unique: Ox5nhFSGNeuDvEBIWNxQFA-1
Received: by mail-ed1-f71.google.com with SMTP id f12-20020a056402150cb029038fdcfb6ea2so22376454edw.14
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 08:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfPOjpqs+xPPviaak2ogNv+B986oj5TZMO/NC3oJo44=;
        b=GXO+tPvbbNV4CYAHxnLFOqRVP3IWVUIjFinT7+dlFZDAmRgb3ZR7UeBi4jJEHyLuUD
         3cfG4DC1+zCnOCNapPO0jamgmrKlzGlM6tfw2EB4AD6ZGDOcsQZ68nXMGlTgEvxnCL8S
         w5XncZ2bphZdchamxCPwdK3mQ/GVadpYsmwGPPJNFoaUHVnj4sQ1L5b8Msj3ruzVfm+A
         q1orAPAeW5dSVJlqXPHz+KKkq1NBurWfZWGYxQYLOJyANTkNgSRCwYmLS74A3aosM+iE
         RBO5buQF8lYwgHp8eqlFY1cN6SY4l/V75fWj2UXEJolBa4gaZRBsawAfTiVAeYebEwlp
         zEmw==
X-Gm-Message-State: AOAM5335fu4okTFdSGyW4SDS4CsHN08MRCkYHXHf0B3tQLrVTJN6QGx4
        KzWfQu7yTlhJ3cOlXwc/fg8pzoqxG8IQZbzsXFGyi2lvQfGawq2o41AO1SnV4G3a8/p7xaywGL/
        FM2aJSJmRGzG6
X-Received: by 2002:a50:fc9a:: with SMTP id f26mr23484753edq.216.1623769465617;
        Tue, 15 Jun 2021 08:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy8TVWB3Ab3G+Ed06XwW3QccJKn8HJhXMLG8fARccSuyWGMMDysWF3YtrcYvvSs+y6ZDLVcw==
X-Received: by 2002:a50:fc9a:: with SMTP id f26mr23484707edq.216.1623769465281;
        Tue, 15 Jun 2021 08:04:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k21sm12184299edo.41.2021.06.15.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:04:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 21558180737; Tue, 15 Jun 2021 16:54:59 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 14/16] netsec: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:53 +0200
Message-Id: <20210615145455.564037-15-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
2.31.1


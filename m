Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3855D3B1898
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFWLQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhFWLQB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=436OaxB7FEvDC8Cj4cGRRV7bgo1JzvFAvSGPF+E5hVA=;
        b=WYqNt7VrfMPudHS4vOBEDIOeKp9b+FM95dU/6Gtg2iiIPcgw68GcN7NTZFwZOjKuuvmlwz
        twaVR222m8MIXnlcJ54wzOsY68X0vicZDZw349Igm+QpCvw8W1O03TBYEdfkobcefPso4w
        UgQs4Emc5sLBdm6q9RTR/P9n+WYZNL4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-X33T-IpTN-W1aOJRWfFOPQ-1; Wed, 23 Jun 2021 07:13:42 -0400
X-MC-Unique: X33T-IpTN-W1aOJRWfFOPQ-1
Received: by mail-ej1-f72.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so857527ejz.5
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=436OaxB7FEvDC8Cj4cGRRV7bgo1JzvFAvSGPF+E5hVA=;
        b=D2hVwbNkjpzmTdF71VwXncqTDvJYmlq5piaxG9cuI+rvjwte4CodVeD12KcMa9eHc+
         E1zJYvP5Kz5udm9zsGh+JlA5lZ83P0vcnH8Gv79+focw8tmvJHtanDyUPLEWqhSucToP
         5v+XYLHUHATig03CbVKU+EVMyG8hsJLo6IdORmrwgtkoS2/JcnGhjbeRL6FnyknDnngl
         qyB4VeRbu/LL3BFcjY0QSUjcYY0LjTN6wjrpjFvDVq52+9e1MUXhQtdhKHhjxBAbGDGu
         LfQLYotpKHQTDzRL7LDP5ZTydhQDiggg5w3pRgKTnGy75cLKtzKC1S0qQnmMZ1pst/rI
         NJ2g==
X-Gm-Message-State: AOAM532N40ewja3wiACl17Ow67wi/aQzkIV6CQQu+OoskONHnmWaBq87
        3qz7OGqUt9Z8zS1wFy++OD8ptszXAJ4JAhU2q12dLd7SFGde8jkmqtTHfvqQt8B3gpw5G86RgWL
        v17n0iqtbY52R
X-Received: by 2002:a17:907:628d:: with SMTP id nd13mr9065697ejc.299.1624446821447;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaB0sFOK4WAUNgBrAcENVFdpPOx4htt22G+HZurPvZsTao6jHLM32s7B6T27sxtDVUXTa1cg==
X-Received: by 2002:a17:907:628d:: with SMTP id nd13mr9065675ejc.299.1624446821251;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d7sm4046175edy.6.2021.06.23.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:13:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8C7E0180743; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH bpf-next v4 19/19] net: ti: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:27 +0200
Message-Id: <20210623110727.221922-20-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cpsw driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/ti/cpsw_priv.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 5862f0a4a975..ecc2a6b7e28f 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1328,13 +1328,9 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
 	struct bpf_prog *prog;
 	u32 act;
 
-	rcu_read_lock();
-
 	prog = READ_ONCE(priv->xdp_prog);
-	if (!prog) {
-		ret = CPSW_XDP_PASS;
-		goto out;
-	}
+	if (!prog)
+		return CPSW_XDP_PASS;
 
 	act = bpf_prog_run_xdp(prog, xdp);
 	/* XDP prog might have changed packet data and boundaries */
@@ -1378,10 +1374,8 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
 	ndev->stats.rx_bytes += *len;
 	ndev->stats.rx_packets++;
 out:
-	rcu_read_unlock();
 	return ret;
 drop:
-	rcu_read_unlock();
 	page_pool_recycle_direct(cpsw->page_pool[ch], page);
 	return ret;
 }
-- 
2.32.0


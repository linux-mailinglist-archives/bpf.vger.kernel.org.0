Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0723A1124
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhFIKff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238846AbhFIKfc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLi6aGzthW1V7ZnrfDoybEkcdwTKHnTji0dPASh8hrc=;
        b=eCXQGVMUesU2+3TDZrxbhv/NVMe4NUdAsqA8qrn1s4XCxsgmXIgpCryyJImWKKjd1YFLis
        AO7st/g5SPJ8ETiA0wPCxyqcNzJAEribWmrNd230iDxfrqmrFI3YSlQJzz/kIkBCmj7poS
        QnnvWAK8NpH2hspf7fw1nPQG6BUsSVc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-LWHHm37uM_a8GMp4NXdWFQ-1; Wed, 09 Jun 2021 06:33:37 -0400
X-MC-Unique: LWHHm37uM_a8GMp4NXdWFQ-1
Received: by mail-ej1-f71.google.com with SMTP id gv42-20020a1709072beab02903eab8e33118so7828406ejc.19
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLi6aGzthW1V7ZnrfDoybEkcdwTKHnTji0dPASh8hrc=;
        b=BjgU34Eb6KGKFeEPJ3HtEnh/a4LedQWmBr5r9nDDI6SH2UuWOcGSh5p9oLzHcmoVXI
         9LqPT0e3G/wS/u7aujIQHXE7VDKfVpxR9VM3MGzx4s/jk9A6XM0F4hzvgUtDh3Pbi/Lt
         8cHspb+ArEUqmgoaOm2XhkHvgO+WxAyNdtARscgJqnOJ+s1IUYyphF0qTS5pKCLC6Nfa
         2i41yarBYqCsaJvcAFNz3XFwQjUVIgi8q5uQqfhgsbd5z0PXg3kWyJzYTRWzeS/M30tA
         hDiPFypBiaem1jnesgKVw0tZiBNr3XS40UgkWQOZ5ePbV7dEykIdyd0FJqteueR8w7My
         n+fQ==
X-Gm-Message-State: AOAM5334585liaDJyYC6fqGrh/ZLmcykKfWXuGGs1FYBeZmmWomMgZA3
        HYmyZnbN6tLn5dIRRlgpCx7MF6FgJa/k8/8c/dxxjze6XlM9Y4pWCzuU4KFU+pnUPC6RFKXg4Z+
        Quu0k9hZn/2PK
X-Received: by 2002:a05:6402:1d38:: with SMTP id dh24mr30493423edb.18.1623234816098;
        Wed, 09 Jun 2021 03:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYCDMsQSZ9Dlij0MXgtUcDtV0HyvIjlYbVvq1Bssh7pKSh/y6kbcDB+aG4fWOwL/laWQyutw==
X-Received: by 2002:a05:6402:1d38:: with SMTP id dh24mr30493408edb.18.1623234815929;
        Wed, 09 Jun 2021 03:33:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m15sm926518eji.39.2021.06.09.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AB08318072D; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH bpf-next 09/17] net: intel: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:18 +0200
Message-Id: <20210609103326.278782-10-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The Intel drivers all have rcu_read_lock()/rcu_read_unlock() pairs around
XDP program invocations. However, the actual lifetime of the objects
referred by the XDP program invocation is longer, all the way through to
the call to xdp_do_flush(), making the scope of the rcu_read_lock() too
small. This turns out to be harmless because it all happens in a single
NAPI poll cycle (and thus under local_bh_disable()), but it makes the
rcu_read_lock() misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Tested-by: Jesper Dangaard Brouer <brouer@redhat.com> # i40e
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 2 --
 drivers/net/ethernet/intel/i40e/i40e_xsk.c        | 6 +-----
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 6 +-----
 drivers/net/ethernet/intel/ice/ice_xsk.c          | 6 +-----
 drivers/net/ethernet/intel/igb/igb_main.c         | 2 --
 drivers/net/ethernet/intel/igc/igc_main.c         | 7 ++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c      | 6 +-----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 --
 9 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index de70c16ef619..ae3a64b6f5f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2298,7 +2298,6 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -2329,7 +2328,6 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return result;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 46d884417c63..8dca53b7daff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -153,7 +153,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	/* NB! xdp_prog will always be !NULL, due to the fact that
 	 * this path is enabled by setting an XDP program.
 	 */
@@ -162,9 +161,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 
 	if (likely(act == XDP_REDIRECT)) {
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
-		rcu_read_unlock();
-		return result;
+		return !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
 	}
 
 	switch (act) {
@@ -184,7 +181,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		result = I40E_XDP_CONSUMED;
 		break;
 	}
-	rcu_read_unlock();
 	return result;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index e2b4b29ea207..1a311e91fb6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1129,15 +1129,11 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		xdp.frame_sz = ice_rx_frame_truesize(rx_ring, size);
 #endif
 
-		rcu_read_lock();
 		xdp_prog = READ_ONCE(rx_ring->xdp_prog);
-		if (!xdp_prog) {
-			rcu_read_unlock();
+		if (!xdp_prog)
 			goto construct_skb;
-		}
 
 		xdp_res = ice_run_xdp(rx_ring, &xdp, xdp_prog);
-		rcu_read_unlock();
 		if (!xdp_res)
 			goto construct_skb;
 		if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index faa7b8d96adb..d6da377f5ac3 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -463,7 +463,6 @@ ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp)
 	struct ice_ring *xdp_ring;
 	u32 act;
 
-	rcu_read_lock();
 	/* ZC patch is enabled only when XDP program is set,
 	 * so here it can not be NULL
 	 */
@@ -473,9 +472,7 @@ ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp)
 
 	if (likely(act == XDP_REDIRECT)) {
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? ICE_XDP_REDIR : ICE_XDP_CONSUMED;
-		rcu_read_unlock();
-		return result;
+		return !err ? ICE_XDP_REDIR : ICE_XDP_CONSUMED;
 	}
 
 	switch (act) {
@@ -496,7 +493,6 @@ ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp)
 		break;
 	}
 
-	rcu_read_unlock();
 	return result;
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 038a9fd1af44..8a11b7e55326 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8387,7 +8387,6 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -8420,7 +8419,6 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ea998d2defa4..2b666a6ec989 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2175,18 +2175,15 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 	struct bpf_prog *prog;
 	int res;
 
-	rcu_read_lock();
-
 	prog = READ_ONCE(adapter->xdp_prog);
 	if (!prog) {
 		res = IGC_XDP_PASS;
-		goto unlock;
+		goto out;
 	}
 
 	res = __igc_xdp_run_prog(adapter, prog, xdp);
 
-unlock:
-	rcu_read_unlock();
+out:
 	return ERR_PTR(-res);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c5ec17d19c59..27d7467534e0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2199,7 +2199,6 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 	struct xdp_frame *xdpf;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -2237,7 +2236,6 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 91ad5b902673..ffbf8a694362 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -100,15 +100,12 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 	struct xdp_frame *xdpf;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	if (likely(act == XDP_REDIRECT)) {
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? IXGBE_XDP_REDIR : IXGBE_XDP_CONSUMED;
-		rcu_read_unlock();
-		return result;
+		return !err ? IXGBE_XDP_REDIR : IXGBE_XDP_CONSUMED;
 	}
 
 	switch (act) {
@@ -132,7 +129,6 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 		result = IXGBE_XDP_CONSUMED;
 		break;
 	}
-	rcu_read_unlock();
 	return result;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ba2ed8a43d2d..fabada4ce315 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1054,7 +1054,6 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -1079,7 +1078,6 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
-- 
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC51E3A8365
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhFOO53 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 10:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231417AbhFOO5S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 10:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623768913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/1dUDyNZZrs33xk0mFJ4m/UiP5685UlgffhChjEESM=;
        b=XUjhBSex2bj3aFF5phvGCUQbwWmtngxz5PAduXoFPO3xAdNRPckm0/8lkZwSVpsjx/etD5
        c2ha4fAX5xjwoDg8oABr5+8xaAIkZUlmeO08ehKVzgvMFbAlZgeu9PT9bqmGPptFuDih7z
        X+oZqFgnwynP/tScy8P8MxEch2B1Gzk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-7Eh65TXKM-uvXRPSISJUeg-1; Tue, 15 Jun 2021 10:55:11 -0400
X-MC-Unique: 7Eh65TXKM-uvXRPSISJUeg-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso22544713edd.12
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 07:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/1dUDyNZZrs33xk0mFJ4m/UiP5685UlgffhChjEESM=;
        b=hQg9mCcU7QBRATK3LJ+FynY18m63ny8m0az5u/MfPMlIqjGcWz2BDte+W3o1C15/ou
         DDa0sdm4Vxf4m3obsjY6YsM6CUV+OIULzUok01QPzDPYYHt1TFlPCdt/K2/OhlvNJWk7
         JMeK/2lPyyjhxSbKW6le9b2stiAbfmobEGS5Ob9cAVa4YSb9m+Or7TNmbXOxGXanjsT4
         AC16ell3d2ikCFzPV2uXWIWxE0WwwKU0/lpFwTDgher74dARES1J4jF0NT+IfAGyyC4p
         CzulmaGnSLpzkMn7gxXgNgiONUHkQBrP7cSpcfmaZWccMnFSD7qXofWh6TdiHEEOleTA
         GozQ==
X-Gm-Message-State: AOAM531oiJ/gRrgFx3IUAuLb/6MV4ARZP9daOCS4FKaucW4L+7GYjyiz
        PzcWXBS240lOqpdGyPMcmSVgFx80MVdlW5Om+6zHuoRvIOTjYVTte9HiGKhyMPOCqr/Op+WHh/p
        iPM2J8IGWOPu+
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr24062070edv.38.1623768910448;
        Tue, 15 Jun 2021 07:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCDxZA5428OnKpa9GZb7yrE5vaWiO0ZAS3v/w0w55ygu8BMKcn1QLYrEOPu83LXEhSAk3gSw==
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr24062041edv.38.1623768910200;
        Tue, 15 Jun 2021 07:55:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w24sm8609477eju.73.2021.06.15.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:55:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E1C88180731; Tue, 15 Jun 2021 16:54:58 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH bpf-next v2 08/16] net: intel: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:47 +0200
Message-Id: <20210615145455.564037-9-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |  5 +++--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c        | 11 +++++------
 drivers/net/ethernet/intel/ice/ice_txrx.c         |  6 +-----
 drivers/net/ethernet/intel/ice/ice_xsk.c          |  6 +-----
 drivers/net/ethernet/intel/igb/igb_main.c         |  5 +++--
 drivers/net/ethernet/intel/igc/igc_main.c         | 10 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c      |  9 ++++-----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  5 +++--
 9 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index de70c16ef619..7fc5bdb5cd9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2298,7 +2298,6 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -2306,6 +2305,9 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -2329,7 +2331,6 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return result;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 46d884417c63..a5982cd112be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -153,8 +153,10 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
-	/* NB! xdp_prog will always be !NULL, due to the fact that
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 *
+	 * NB! xdp_prog will always be !NULL, due to the fact that
 	 * this path is enabled by setting an XDP program.
 	 */
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
@@ -162,9 +164,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 
 	if (likely(act == XDP_REDIRECT)) {
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
-		rcu_read_unlock();
-		return result;
+		return !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
 	}
 
 	switch (act) {
@@ -184,7 +184,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
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
index 038a9fd1af44..0b68d589218a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8387,7 +8387,6 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -8395,6 +8394,9 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -8420,7 +8422,6 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ea998d2defa4..333057ce60c7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2175,18 +2175,18 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
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
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	res = __igc_xdp_run_prog(adapter, prog, xdp);
 
-unlock:
-	rcu_read_unlock();
+out:
 	return ERR_PTR(-res);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c5ec17d19c59..9cebe7894111 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2199,7 +2199,6 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 	struct xdp_frame *xdpf;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -2207,6 +2206,9 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -2237,7 +2239,6 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 91ad5b902673..4a075e667082 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -100,15 +100,15 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 	struct xdp_frame *xdpf;
 	u32 act;
 
-	rcu_read_lock();
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
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
@@ -132,7 +132,6 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 		result = IXGBE_XDP_CONSUMED;
 		break;
 	}
-	rcu_read_unlock();
 	return result;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ba2ed8a43d2d..ab05ebc3d350 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1054,12 +1054,14 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
 		goto xdp_out;
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -1079,7 +1081,6 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
-- 
2.31.1


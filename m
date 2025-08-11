Return-Path: <bpf+bounces-65393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDEB217B7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491EB7AE243
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF62D94B0;
	Mon, 11 Aug 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv6+zdZC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3527D771;
	Mon, 11 Aug 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949331; cv=none; b=oF+TWA5+CSgDqQUMiK/JQn39Y4OQEumRz7A51Jrrl7RJa9aV8+RRG8CAL5FaGgE/PtLPEWLtc/QqJvGcw8cxmm4aAVJennv5gO9L7qUJcELLU5w75z2t6sv17ejs8i8HsBmxR61y3PyOLMO3IhlbRiVLa/TVpLi0mBHQX77IFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949331; c=relaxed/simple;
	bh=ZADvWkJnUSIZuio9qbsuIWwbT0Baeqbh3m9Alrshoi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O21SLwAVz0jBm7gLFzP1o5EYKecuxSs1s+WwIJSkb+NAUyRsRAtBNfbWyDtNE6UAp3XiltRLXYpHPafmTf+bOeFXwNmAPx29tZFH9+nTA9+kESZBmo8iD2LE44SDOa9YlCB/fX63bOTF94aM/ga8l/h9pwLJau+CQDvm4Kq/0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv6+zdZC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so24451875e9.2;
        Mon, 11 Aug 2025 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949327; x=1755554127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qiFHKd+OfogKmUQIYyJHth3nBhQhhTCdYUzvhzIeDg=;
        b=Rv6+zdZCr456LvsOf+0VUw2Qvv91E/ItLafBn+tRjVkcyfLS9WGa0hTl4kErk/6Hlz
         iZjLPnAHM+EigX67xjY49Vzvmu9Rc01duWBpQvTAqOfZt52KIeHHgCnjflz1/muHTozq
         7VP0Ilj9SXs3CJjJyRyuzoybnI0i0411IHvlpmdge7+pTNuby0K+aY4+Axo2TXZ2YKFw
         diCYHNxH3vfG2sS4xOYwxZNOSy/sgF47Qr+vSugAOIgXhSc9om0rOcSwOd9O3zUnJyR/
         TVucdK2x4nvniSkbcaT+pbLP4phQuqqoP6RoLxEPkKXuIiFag57NMaCKyLjzaUbyAwas
         OyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949327; x=1755554127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qiFHKd+OfogKmUQIYyJHth3nBhQhhTCdYUzvhzIeDg=;
        b=HzAmkbxGQl324mGFgZl19/gyKved88L7jrcFB+OqMOLdNItuZlg0D7osy7tFM/bob7
         ryOa/yh1uu/Vk5GmY5u3DpIVpVhkZR/3sc5EsFKgZn3/gyD9NwQoq89XPgCqMr8hh5bs
         7TwsTPkIM95iRYgMEnTsXPFtRnheXZqa062SJvV85WPh9mEHc0frX5C0/23HXYuIXtip
         hjrrxTAe9v/3wTVqvP5qBWwWMUAe3ENxNzqazKHuTjk6EOT4Pp553XUC8mi5JcafMNH0
         SzaUfDGzsWoKgAw+jI3zL+lL1W5s0ixOirXUHV/AMBwd6rfNLDNmBJl6GM/XxUkjqpWG
         sn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/HS5PJoEQ0cbZUQW5LVrNLdOCCe05fgWDFFoAjmS4pukjydOxp0314OkScsg+Iiq6WY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXYv+XREWNohZdE+bdqQ/Yvgoz9DUDEdy5oaQeaelLDWMIOx2
	U8SlByUIr9bkFmzjebKFsyL6CIiqxI+rUnzAR+SMeZrOeZpPAF96NOpR2uruKISX
X-Gm-Gg: ASbGncvWJtx2Mh1uIFKRuvsG/gAKSPQpKNWADY4gO6aPFxP5Or41KqQPeEmiWXs2kko
	+8++Dju8ucP3gJ7sN2VY7RFxYXGXtRZPJYn/vbMz2Ga7KRlhhlKaGhUj/MhG1BZ9XY6hxaUuMo5
	ifoEIZTs5eMGzBYevnRhjuSHkNMGIk8dj1Zdu59DeJ6hXAYcXEt6s9+LbNuZz9I5DPeTJ++LXxY
	26LWKIg6EPwYSW4zdbPeo5if6IxH+YI+TCHygm2zZErJCgH0Gy5+8MvkrMHaDlfKEtBzMrrnszT
	MAdNBYqWNIbQtpYy38i1kbg0Cv/qCJCgC87smgNumXrFOoESkDE2ILFL5viVxdqDJ/YhewRjpIe
	WDS+HqdUepV27hXuV339+7wGnL8RShn5jv1k=
X-Google-Smtp-Source: AGHT+IEqZWn3tsEGOSvcFEhmHRCRGhfvu5EEU6zg3i1lypDZCbODjNF3uHYQW2G3R2DHCHS595NhrQ==
X-Received: by 2002:a05:6000:310d:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3b911007a82mr1047242f8f.28.1754949326717;
        Mon, 11 Aug 2025 14:55:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm41789322f8f.37.2025.08.11.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:55:25 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 5/9] eth: fbnic: Add XDP pass, drop, abort support
Date: Mon, 11 Aug 2025 14:55:21 -0700
Message-ID: <20250811215521.1055991-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for attaching an XDP program to the device and support
for PASS/DROP/ABORT actions. In fbnic, buffers are always mapped as
DMA_BIDIRECTIONAL.

The BPF program pointer can be read either on a per-packet basis or on a
per-NAPI poll basis. Both approaches are functionally equivalent, in the
current code. Stick to per-packet as it limits number of arguments we need
to pass around.

On the XDP hot path, check that packets with fragments are only allowed
when multi-buffer support is enabled for the XDP program. Ideally, this
check should not be necessary because ndo_bpf verifies that for XDP
programs without multi-buff support, MTU is less than the hds_thresh.
However, the MTU currently does not enforce the receive size which would
require cleaning up the data path and bouncing the link. For practical
reasons, prioritize the ability to enter and exit BPF mode with different
MTU sizes without requiring a full reconfig.

Testing:

Hook a simple XDP program that passes all the packets destined for a
specific port

iperf3 -c 192.168.1.10 -P 5 -p 12345
Connecting to host 192.168.1.10, port 12345
[  5] local 192.168.1.9 port 46702 connected to 192.168.1.10 port 12345
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
- - - - - - - - - - - - - - - - - - - - - - - - -
[SUM]   1.00-2.00   sec  3.86 GBytes  33.2 Gbits/sec    0

XDP_DROP:
Hook an XDP program that drops packets destined for a specific port

 iperf3 -c 192.168.1.10 -P 5 -p 12345
^C- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec    0       sender
[SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec            receiver
iperf3: interrupt - the client has terminated

XDP with HDS:

- Validate XDP attachment failure when HDS is low
   ~] ethtool -G eth0 hds-thresh 512
   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
   ~] Error: fbnic: MTU too high, or HDS threshold is too low for single
      buffer XDP.

- Validate successful XDP attachment when HDS threshold is appropriate
  ~] ethtool -G eth0 hds-thresh 1536
  ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp

- Validate when the XDP program is attached, changing HDS thresh to a
  lower value fails
  ~] ethtool -G eth0 hds-thresh 512
  ~] netlink error: fbnic: Use higher HDS threshold or multi-buf capable
     program

- Validate HDS thresh does not matter when xdp frags support is
  available
  ~] ethtool -G eth0 hds-thresh 512
  ~] sudo ip link set eth0 xdpdrv obj xdp_pass_mb_12345.o sec xdp.frags

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 11 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 35 +++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 96 +++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  2 +
 5 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 8ae2ecbae06c..742b557d0e56 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -329,6 +329,17 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	/* If an XDP program is attached, we should check for potential frame
+	 * splitting. If the new HDS threshold can cause splitting, we should
+	 * only allow if the attached XDP program can handle frags.
+	 */
+	if (fbnic_check_split_frames(fbn->xdp_prog, netdev->mtu,
+				     kernel_ring->hds_thresh)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Use higher HDS threshold or multi-buf capable program");
+		return -EINVAL;
+	}
+
 	if (!netif_running(netdev)) {
 		fbnic_set_rings(fbn, ring, kernel_ring);
 		return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index a7eb7a367b98..fb81d1a7bc51 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -508,6 +508,40 @@ static void fbnic_get_stats64(struct net_device *dev,
 	}
 }
 
+bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
+			      u32 hds_thresh)
+{
+	if (!prog)
+		return false;
+
+	if (prog->aux->xdp_has_frags)
+		return false;
+
+	return mtu + ETH_HLEN > hds_thresh;
+}
+
+static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
+{
+	struct bpf_prog *prog = bpf->prog, *prev_prog;
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (bpf->command != XDP_SETUP_PROG)
+		return -EINVAL;
+
+	if (fbnic_check_split_frames(prog, netdev->mtu,
+				     fbn->hds_thresh)) {
+		NL_SET_ERR_MSG_MOD(bpf->extack,
+				   "MTU too high, or HDS threshold is too low for single buffer XDP");
+		return -EOPNOTSUPP;
+	}
+
+	prev_prog = xchg(&fbn->xdp_prog, prog);
+	if (prev_prog)
+		bpf_prog_put(prev_prog);
+
+	return 0;
+}
+
 static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_open		= fbnic_open,
 	.ndo_stop		= fbnic_stop,
@@ -517,6 +551,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_set_mac_address	= fbnic_set_mac,
 	.ndo_set_rx_mode	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
+	.ndo_bpf		= fbnic_bpf,
 	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
 	.ndo_hwtstamp_set	= fbnic_hwtstamp_set,
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 04c5c7ed6c3a..bfa79ea910d8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -18,6 +18,8 @@
 #define FBNIC_TUN_GSO_FEATURES		NETIF_F_GSO_IPXIP6
 
 struct fbnic_net {
+	struct bpf_prog *xdp_prog;
+
 	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
 	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
 
@@ -104,4 +106,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
 int fbnic_phylink_init(struct net_device *netdev);
+
+bool fbnic_check_split_frames(struct bpf_prog *prog,
+			      unsigned int mtu, u32 hds_threshold);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7945f695b6f2..63e64bfb6f0f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2,17 +2,26 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bitfield.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
+#include <net/xdp.h>
 
 #include "fbnic.h"
 #include "fbnic_csr.h"
 #include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
+enum {
+	FBNIC_XDP_PASS = 0,
+	FBNIC_XDP_CONSUME,
+	FBNIC_XDP_LEN_ERR,
+};
+
 enum {
 	FBNIC_XMIT_CB_TS	= 0x01,
 };
@@ -877,7 +886,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
-	xdp_init_buff(&pkt->buff, frame_sz, NULL);
+	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
 	hdr_pg_start += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
 			FBNIC_BD_FRAG_SIZE;
 
@@ -967,6 +976,39 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 	return skb;
 }
 
+static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
+				     struct fbnic_pkt_buff *pkt)
+{
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
+	struct bpf_prog *xdp_prog;
+	int act;
+
+	xdp_prog = READ_ONCE(fbn->xdp_prog);
+	if (!xdp_prog)
+		goto xdp_pass;
+
+	/* Should never happen, config paths enforce HDS threshold > MTU */
+	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
+		return ERR_PTR(-FBNIC_XDP_LEN_ERR);
+
+	act = bpf_prog_run_xdp(xdp_prog, &pkt->buff);
+	switch (act) {
+	case XDP_PASS:
+xdp_pass:
+		return fbnic_build_skb(nv, pkt);
+	default:
+		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(nv->napi.dev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	return ERR_PTR(-FBNIC_XDP_CONSUME);
+}
+
 static enum pkt_hash_types fbnic_skb_hash_type(u64 rcd)
 {
 	return (FBNIC_RCD_META_L4_TYPE_MASK & rcd) ? PKT_HASH_TYPE_L4 :
@@ -1065,7 +1107,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			if (unlikely(pkt->add_frag_failed))
 				skb = NULL;
 			else if (likely(!fbnic_rcd_metadata_err(rcd)))
-				skb = fbnic_build_skb(nv, pkt);
+				skb = fbnic_run_xdp(nv, pkt);
 
 			/* Populate skb and invalidate XDP */
 			if (!IS_ERR_OR_NULL(skb)) {
@@ -1251,6 +1293,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	for (j = 0; j < nv->rxt_count; j++, i++) {
+		xdp_rxq_info_unreg(&nv->qt[i].xdp_rxq);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
@@ -1423,6 +1466,11 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
 		fbn->rx[rxq_idx] = &qt->cmpl;
 
+		err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, rxq_idx,
+				       nv->napi.napi_id);
+		if (err)
+			goto free_ring_cur_qt;
+
 		/* Update Rx queue index */
 		rxt_count--;
 		rxq_idx += v_count;
@@ -1433,6 +1481,25 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	return 0;
 
+	while (rxt_count < nv->rxt_count) {
+		qt--;
+
+		xdp_rxq_info_unreg(&qt->xdp_rxq);
+free_ring_cur_qt:
+		fbnic_remove_rx_ring(fbn, &qt->sub0);
+		fbnic_remove_rx_ring(fbn, &qt->sub1);
+		fbnic_remove_rx_ring(fbn, &qt->cmpl);
+		rxt_count++;
+	}
+	while (txt_count < nv->txt_count) {
+		qt--;
+
+		fbnic_remove_tx_ring(fbn, &qt->sub0);
+		fbnic_remove_tx_ring(fbn, &qt->cmpl);
+
+		txt_count++;
+	}
+	fbnic_napi_free_irq(fbd, nv);
 pp_destroy:
 	page_pool_destroy(nv->page_pool);
 napi_del:
@@ -1709,8 +1776,10 @@ static void fbnic_free_nv_resources(struct fbnic_net *fbn,
 	for (i = 0; i < nv->txt_count; i++)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
 
-	for (j = 0; j < nv->rxt_count; j++, i++)
+	for (j = 0; j < nv->rxt_count; j++, i++) {
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
+	}
 }
 
 static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
@@ -1722,19 +1791,32 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 	for (i = 0; i < nv->txt_count; i++) {
 		err = fbnic_alloc_tx_qt_resources(fbn, &nv->qt[i]);
 		if (err)
-			goto free_resources;
+			goto free_qt_resources;
 	}
 
 	/* Allocate Rx Resources */
 	for (j = 0; j < nv->rxt_count; j++, i++) {
+		/* Register XDP memory model for completion queue */
+		err = xdp_reg_mem_model(&nv->qt[i].xdp_rxq.mem,
+					MEM_TYPE_PAGE_POOL,
+					nv->page_pool);
+		if (err)
+			goto xdp_unreg_mem_model;
+
 		err = fbnic_alloc_rx_qt_resources(fbn, &nv->qt[i]);
 		if (err)
-			goto free_resources;
+			goto xdp_unreg_cur_model;
 	}
 
 	return 0;
 
-free_resources:
+xdp_unreg_mem_model:
+	while (j-- && i--) {
+		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+xdp_unreg_cur_model:
+		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
+	}
+free_qt_resources:
 	while (i--)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
 	return err;
@@ -2026,7 +2108,7 @@ void fbnic_flush(struct fbnic_net *fbn)
 			memset(qt->cmpl.desc, 0, qt->cmpl.size);
 
 			fbnic_put_pkt_buff(nv, qt->cmpl.pkt, 0);
-			qt->cmpl.pkt->buff.data_hard_start = NULL;
+			memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
 		}
 	}
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 0260d4ccb96b..5536f72a1c85 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -65,6 +65,7 @@ struct fbnic_net;
 	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
 #define FBNIC_HDS_THRESH_DEFAULT \
 	(1536 - FBNIC_RX_PAD)
+#define FBNIC_HDR_BYTES_MIN		128
 
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
@@ -127,6 +128,7 @@ struct fbnic_ring {
 
 struct fbnic_q_triad {
 	struct fbnic_ring sub0, sub1, cmpl;
+	struct xdp_rxq_info xdp_rxq;
 };
 
 struct fbnic_napi_vector {
-- 
2.47.3



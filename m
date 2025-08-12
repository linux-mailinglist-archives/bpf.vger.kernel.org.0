Return-Path: <bpf+bounces-65463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD93B23B97
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC347A847C
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9E2E54C4;
	Tue, 12 Aug 2025 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJDkGoSX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AD2DF3F8;
	Tue, 12 Aug 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036141; cv=none; b=l42r+kVHy5yU5o/ozlnnLvXFHRHCQqvW9Vn1GPzBLkHOwZcmKUJzLXtUxxWpZSHcdlgAMkZvSSOauv9xnWL/RkfDYKtOnAYXihbW/nsySL8NPHxf41X0Cc2Xt1LU3ha3bptOtZRttGTR4XG5t3nAgcSf0X6y4fNTJ4XocJhwGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036141; c=relaxed/simple;
	bh=Q7X/McOJROt+1O6Y5U1wLNV8omQfXEQSD7+POEqQA+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXGxTue/J12rn3f7S2ciN2hA5kwgXabb0wmEo+DZ/P8HuKUTqeNNiwnhOQ4/nVi9/ncSLATRkAY/R+NZKurZMKa8CoxhoJqpLl2MeHk7bNLon3wWfl+wY88tFEFC+tXadB9AlVeuVa3U3cVDG932v++yef9ho5lr9LOzkwh4jgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJDkGoSX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b780bdda21so4817764f8f.3;
        Tue, 12 Aug 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036136; x=1755640936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKu1YHWyZI2rIL/UlujNk1oC14mLmUdFcb6Re9G/vMs=;
        b=NJDkGoSXu47n0aCtV0Dh6ssEANiDZrx4AlE1VNT/Kwkp2Qy68LM48HWkpFdiXwMx6s
         Vk7chSQZXr/2pEwwR0ICOixbdWLndPf+neUIjP0MX0CSrI2tUPICOInA3DG62jqT5KHy
         3+3gwO6ZVTco+biMQHWra2nnFDBZbQdH0MFdwkgbuqF/FBw6rcx9cVt1VxI1rWbuDg48
         UKCNKcw8jvnCXAhylDETqZ/gI1L8E2obuzVmF6VXUvyGTA2rtS9ZlMpTDCBJ+W2JqP1h
         fHesIS5E/LVkQMX6U0m3aFEv/iaCdmwSAYM1vGz2aWvo1tlmHwZXoY7fVy5rMUpOe1PX
         BcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036136; x=1755640936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKu1YHWyZI2rIL/UlujNk1oC14mLmUdFcb6Re9G/vMs=;
        b=dAKY+f5kxRryLmFt/8NdYouhWhZNc5hMuvJuX46HUnfb5oj3LM4i79ykwJm1Ev8RG5
         dkhpTzDxPYHNLzmgblcrzi92wek3qNGgfBaixkhWv60bYgP8VRek4k8zgtdBZlTFbMk0
         /9/KgcgFoKzMxuE2ApFp69FMNCM0j1qQM+2EjiTm4O4mSf7+65BT8Zm2NTw0HQ/5l3nu
         hXp3zY8MIFJPMZUpPs2xzrkgMi/H+qfkUfaTvjVP6E9L7nX0CAOH66nbEMDkKHJ9QodZ
         gTBoaa7gFKddV09SeV25y3vLQSISxro00tEn8clHCC3P0SLMeDwP+TuvdyckaPd6qJ64
         75pw==
X-Forwarded-Encrypted: i=1; AJvYcCVNV+Onlnipr3gImFsCtDcEWRDwPEXDNmbGBRf+7F/e7zDCawWTW5zGr/tlwBn22QD0i0vi0FrpPQ9Rc9iv@vger.kernel.org, AJvYcCVfR/jeMUqG3049UIRm90qPqyJ1mpBpUtKa84vTGVj5p55kfSO6JH3FjaALes8SFbieW3I=@vger.kernel.org, AJvYcCXvJGWr7j+YLzlLrh0LgbqP9m5SNChRW5SHJvuLyWdLTfsJ4ljAt4P4l/fXQ7cyeU3o6D1kPUOaBpLx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrzlb/BybxE+hHOQNOlF94S3D5Ei2BdKSmoBF73IgQ2gb/h+Vm
	gEiw5W+QY8IXY6/pDvdiRC6LkRcHhaWct7bDjn2rCTB/C8d4Vo21f2eLImLy6H1L
X-Gm-Gg: ASbGncvbMe8x2+bMM/jIos0QnekW+8YPjkLfX2IoivBIi0/qRICdjYspN1hLWnoo/bs
	azxfDOd2AdufZQOSPqxPExxmvycwXSMuLCo+C6FqKgFsklMk3GPudLcpFMJcWIHtCZU7YmPkSW1
	K1IaRk0FhUf4JQNXxVjCF6UpWHoT6SDMr30N44DH13JTH58S/MYTTro9env4wWkJdVs911NW5K6
	ecnYSUNNbpiAxNI2K40/3VAaI3jVC7L166sxSjT8iMI3GcGtor4Lt7gO+q2zqp8WSh91Lakrzlg
	3RvqBg++JLjiBtWQzhtYTJfSo22z6vbjsKTLycWzgpWHhetFoLrFeIR4y9gXLJ/PHzuhIW7UHaJ
	hwQ+53FTTRr5vl+w9GIwgivGJS/svFA==
X-Google-Smtp-Source: AGHT+IFKJiZDBqpkSZHykuJ4Mvd5/B39ZZf0Cw5i5e0Kn1bw9vCnbT8NvBadU2RnVbM+Cd9CCOauLA==
X-Received: by 2002:a05:6000:2882:b0:3b5:e084:283b with SMTP id ffacd0b85a97d-3b917d30e4amr413845f8f.17.1755036135326;
        Tue, 12 Aug 2025 15:02:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm45960044f8f.42.2025.08.12.15.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:02:14 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
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
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V3 5/9] eth: fbnic: Add XDP pass, drop, abort support
Date: Tue, 12 Aug 2025 15:01:46 -0700
Message-ID: <20250812220150.161848-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
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
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 5 files changed, 141 insertions(+), 7 deletions(-)

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
index 65d1e40addec..a669e169e3ad 100644
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
index d236152bbaaa..5536f72a1c85 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -128,6 +128,7 @@ struct fbnic_ring {
 
 struct fbnic_q_triad {
 	struct fbnic_ring sub0, sub1, cmpl;
+	struct xdp_rxq_info xdp_rxq;
 };
 
 struct fbnic_napi_vector {
-- 
2.47.3



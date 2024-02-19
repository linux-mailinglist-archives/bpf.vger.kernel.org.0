Return-Path: <bpf+bounces-22238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E109859F4C
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324901C21021
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A852261B;
	Mon, 19 Feb 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZBiokTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cEu3F6wK"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7222309;
	Mon, 19 Feb 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333737; cv=none; b=gF69JPBpbvVEeI8lwciac4cNBXDAxmFGlD3Yl/ccQfhYYKlVq5dPsNK3raWEuYtlVJi211l0iO3ZUtlpUuoL9hqTJBrvlFQsWpHw9/k9UQzU+Iemvi3tmTSoXsVlx+AaOwWfpdoB+hjqRaZrRTrOpxue6xY5qCoeKXqFMKiwxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333737; c=relaxed/simple;
	bh=+ZMPIvIwkppldENup3GEYut/raXsv5r8fa0cHqLSbv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1CHWdp4/kG6C5k4KKQtAgWAYc9B/BEVd/VYEv/HgabxydiXp1M1TJ4xv7VgJCTdrUalaTNgKq0nqOJVjdKN4VS7xL2c3pAwJD1eRFerAzkdtv5b4VlMkwQElfWy3wD61K6hjNxGk0fZMThKHDvQjsgQcWF4eMMwcuW8SRwNWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZBiokTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cEu3F6wK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708333733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CyuTyEUacN3pepSBJWL72y/0RunhnYpq37IXOd+sUdI=;
	b=DZBiokTQDlOdztrlEBO0BdhvIfliISfFM5K/4igbF+EX0M5Mp/S53BDNd5VvTXiEMasiC+
	1pefmKJK+6CZMS6Y0jjI5fLAfoPYLIdlKbqc239RxTpshpEr3JiGjXvtxKnO1gdNNuiFeN
	/4rHIuIH/vToEnRmlN1KCZI94VpP8qeqK5W3rUcSGMFzlPiVDcl8XGqY6UyLuX8Rq/Vd6Y
	NOSzYyxXxP2QooXTb1qGagaeOP6WCtrKISM/skhN1DwZudviNR5dtMOavYKqUZCbHLWGNf
	4qUaTzsJOhkEJqTTtlCweMo+zOQAJRxQ/mR6D4FaFyyY3FobjVLEQdIRRcp1dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708333733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CyuTyEUacN3pepSBJWL72y/0RunhnYpq37IXOd+sUdI=;
	b=cEu3F6wKVZE3xIS+G90z7VEP0pbOGI6Cah5j92ZjIX8P7r+WNCPCb+EsBK0mtFje58an/p
	G0lCqcsKHNsJqlDA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Andre Guedes <andre.guedes@intel.com>,
	Vedang Patel <vedang.patel@intel.com>
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	kurt@linutronix.de,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/1] igc: avoid returning frame twice in XDP_REDIRECT
Date: Mon, 19 Feb 2024 10:08:43 +0100
Message-Id: <20240219090843.9307-1-florian.kauer@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a frame can not be transmitted in XDP_REDIRECT
(e.g. due to a full queue), it is necessary to free
it by calling xdp_return_frame_rx_napi.

However, this is the reponsibility of the caller of
the ndo_xdp_xmit (see for example bq_xmit_all in
kernel/bpf/devmap.c) and thus calling it inside
igc_xdp_xmit (which is the ndo_xdp_xmit of the igc
driver) as well will lead to memory corruption.

In fact, bq_xmit_all expects that it can return all
frames after the last successfully transmitted one.
Therefore, break for the first not transmitted frame,
but do not call xdp_return_frame_rx_napi in igc_xdp_xmit.
This is equally implemented in other Intel drivers
such as the igb.

There are two alternatives to this that were rejected:
1. Return num_frames as all the frames would have been
   transmitted and release them inside igc_xdp_xmit.
   While it might work technically, it is not what
   the return value is meant to repesent (i.e. the
   number of SUCCESSFULLY transmitted packets).
2. Rework kernel/bpf/devmap.c and all drivers to
   support non-consecutively dropped packets.
   Besides being complex, it likely has a negative
   performance impact without a significant gain
   since it is anyway unlikely that the next frame
   can be transmitted if the previous one was dropped.

The memory corruption can be reproduced with
the following script which leads to a kernel panic
after a few seconds.  It basically generates more
traffic than a i225 NIC can transmit and pushes it
via XDP_REDIRECT from a virtual interface to the
physical interface where frames get dropped.

   #!/bin/bash
   INTERFACE=enp4s0
   INTERFACE_IDX=`cat /sys/class/net/$INTERFACE/ifindex`

   sudo ip link add dev veth1 type veth peer name veth2
   sudo ip link set up $INTERFACE
   sudo ip link set up veth1
   sudo ip link set up veth2

   cat << EOF > redirect.bpf.c

   SEC("prog")
   int redirect(struct xdp_md *ctx)
   {
       return bpf_redirect($INTERFACE_IDX, 0);
   }

   char _license[] SEC("license") = "GPL";
   EOF
   clang -O2 -g -Wall -target bpf -c redirect.bpf.c -o redirect.bpf.o
   sudo ip link set veth2 xdp obj redirect.bpf.o

   cat << EOF > pass.bpf.c

   SEC("prog")
   int pass(struct xdp_md *ctx)
   {
       return XDP_PASS;
   }

   char _license[] SEC("license") = "GPL";
   EOF
   clang -O2 -g -Wall -target bpf -c pass.bpf.c -o pass.bpf.o
   sudo ip link set $INTERFACE xdp obj pass.bpf.o

   cat << EOF > trafgen.cfg

   {
     /* Ethernet Header */
     0xe8, 0x6a, 0x64, 0x41, 0xbf, 0x46,
     0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
     const16(ETH_P_IP),

     /* IPv4 Header */
     0b01000101, 0,   # IPv4 version, IHL, TOS
     const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
     const16(2),      # IPv4 ident
     0b01000000, 0,   # IPv4 flags, fragmentation off
     64,              # IPv4 TTL
     17,              # Protocol UDP
     csumip(14, 33),  # IPv4 checksum

     /* UDP Header */
     10,  0, 1, 1,    # IP Src - adapt as needed
     10,  0, 1, 2,    # IP Dest - adapt as needed
     const16(6666),   # UDP Src Port
     const16(6666),   # UDP Dest Port
     const16(1008),   # UDP length (UDP header 8 bytes + payload length)
     csumudp(14, 34), # UDP checksum

     /* Payload */
     fill('W', 1000),
   }
   EOF

   sudo trafgen -i trafgen.cfg -b3000MB -o veth1 --cpp

Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba8d3fe186ae..81c21a893ede 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6487,7 +6487,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	struct igc_ring *ring;
-	int i, drops;
+	int i, nxmit;
 
 	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
@@ -6503,16 +6503,15 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	txq_trans_cond_update(nq);
 
-	drops = 0;
+	nxmit = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
 		struct xdp_frame *xdpf = frames[i];
 
 		err = igc_xdp_init_tx_descriptor(ring, xdpf);
-		if (err) {
-			xdp_return_frame_rx_napi(xdpf);
-			drops++;
-		}
+		if (err)
+			break;
+		nxmit++;
 	}
 
 	if (flags & XDP_XMIT_FLUSH)
@@ -6520,7 +6519,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames - drops;
+	return nxmit;
 }
 
 static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
-- 
2.39.2



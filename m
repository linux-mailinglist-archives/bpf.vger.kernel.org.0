Return-Path: <bpf+bounces-70690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83DBCAB3E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 21:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95FF3B12BE
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89925A32E;
	Thu,  9 Oct 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="jI1uSYYJ"
X-Original-To: bpf@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D334257448
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038144; cv=none; b=maGKim8t0aIQj7IqR2OiM9jDT2mZDQ8jHnHdnPFc/dlGlNSmH6G9yuNV5a7dN6LlJHZHsuLRynTxcsqlaogNYY1Tx2mxy4uXQRXZBijTfatBeGMLTovjRmkuTP+yznBZ6T9Vx87O65Yl3akj9lmUL9bNZMVMsAbypcgB9gaaftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038144; c=relaxed/simple;
	bh=jxHNPvtonKIh6HD+twGlbhC/21NmPGMHzw7NpLnXoas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2BA0o/M8/BzzO76H7UPhj1FwRgMw+8QFznQYVMpz2gsxUP+QF2iB0072AS3lF3X28GfHo4qfsGMtImpmVw6+jCr8G9BtrV2rPOq+qg8X1VVNs/l+5XJp7tg8SjbXxI+v+jOhEPjuvpwgFt0w5T2vVmgtsas/2RoG5L2vL8AbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=jI1uSYYJ; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1760038143; x=1762630143;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=K09yGhuPuz5y5DBtOYrDuFkQOt0DZmwIm4f7CMtsXxA=;
	b=jI1uSYYJSVZH0NcuSo8XkWCgvLUhmUtvvcOS84LQCISm1S0oSrMvrr1fdlVMYLGgwwUGLDwdDXNDvWIIhZamz/Ir18trJemLEbU/0H9xZNslE8840E9aU6uaz9fjLhWrbCnE9TO8zv3Dv5iDVsueZVLufR9TxmbbnyE7NFjh7O8=
X-Thread-Info: NDUwNC4xMi42YjZmMTAwMDBiMDgxNmYuYnBmPXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id 0F1382CE01B3;
	Thu,  9 Oct 2025 15:28:41 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	lishujin@kuaishou.com,
	xingwanli@kuaishou.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	team-kernel@fastly.com,
	khubert@fastly.com,
	nalramli@fastly.com,
	dev@nalramli.com
Subject: [RFC ixgbe 1/2] ixgbe: Implement support for ndo_xdp_xmit in skb mode
Date: Thu,  9 Oct 2025 15:28:30 -0400
Message-ID: <20251009192831.3333763-2-dev@nalramli.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009192831.3333763-1-dev@nalramli.com>
References: <20251009192831.3333763-1-dev@nalramli.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit adds support for `ndo_xdp_xmit` in skb mode in the ixgbe
ethernet driver, by allowing the call to continue to transmit the packets
using `dev_direct_xmit`.

Previously, the driver did not support the operation in skb mode. The
handler `ixgbe_xdp_xmit` had the following condition:

```
	ring =3D adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) : NULL;
	if (unlikely(!ring))
		return -ENXIO;
```

That only works in native mode. In skb mode, `adapter->xdp_prog =3D=3D NU=
LL` so
the call returned an error, which prevented the ability to send packets
using `bpf_prog_test_run_opts` with the `BPF_F_TEST_XDP_LIVE_FRAMES` flag=
.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 43 +++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ether=
net/intel/ixgbe/ixgbe.h
index e6a380d4929b..26c378853755 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -846,6 +846,14 @@ struct ixgbe_ring *ixgbe_determine_xdp_ring(struct i=
xgbe_adapter *adapter)
 	return adapter->xdp_ring[index];
 }
=20
+static inline
+struct ixgbe_ring *ixgbe_determine_tx_ring(struct ixgbe_adapter *adapter=
)
+{
+	int index =3D ixgbe_determine_xdp_q_idx(smp_processor_id());
+
+	return adapter->tx_ring[index];
+}
+
 static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
 {
 	switch (adapter->hw.mac.type) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/=
ethernet/intel/ixgbe/ixgbe_main.c
index 467f81239e12..fed70cbdb1b2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10748,7 +10748,8 @@ static int ixgbe_xdp_xmit(struct net_device *dev,=
 int n,
 	/* During program transitions its possible adapter->xdp_prog is assigne=
d
 	 * but ring has not been configured yet. In this case simply abort xmit=
.
 	 */
-	ring =3D adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) : NULL;
+	ring =3D adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) :
+		ixgbe_determine_tx_ring(adapter);
 	if (unlikely(!ring))
 		return -ENXIO;
=20
@@ -10762,9 +10763,43 @@ static int ixgbe_xdp_xmit(struct net_device *dev=
, int n,
 		struct xdp_frame *xdpf =3D frames[i];
 		int err;
=20
-		err =3D ixgbe_xmit_xdp_ring(ring, xdpf);
-		if (err !=3D IXGBE_XDP_TX)
-			break;
+		if (adapter->xdp_prog) {
+			err =3D ixgbe_xmit_xdp_ring(ring, xdpf);
+			if (err !=3D IXGBE_XDP_TX)
+				break;
+		} else {
+			struct xdp_buff xdp =3D {0};
+			unsigned int metasize =3D 0;
+			unsigned int size =3D 0;
+			unsigned int truesize =3D 0;
+			struct sk_buff *skb =3D NULL;
+
+			xdp_convert_frame_to_buff(xdpf, &xdp);
+			size =3D xdp.data_end - xdp.data;
+			metasize =3D xdp.data - xdp.data_meta;
+			truesize =3D SKB_DATA_ALIGN(xdp.data_end - xdp.data_hard_start) +
+				   SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+			skb =3D napi_alloc_skb(&ring->q_vector->napi, truesize);
+			if (likely(skb)) {
+				skb_reserve(skb, xdp.data - xdp.data_hard_start);
+				skb_put_data(skb, xdp.data, size);
+				build_skb_around(skb, skb->data, truesize);
+				if (metasize)
+					skb_metadata_set(skb, metasize);
+				skb->dev =3D dev;
+				skb->queue_mapping =3D ring->queue_index;
+
+				err =3D dev_direct_xmit(skb, ring->queue_index);
+				if (!dev_xmit_complete(err))
+					break;
+			} else {
+				break;
+			}
+
+			xdp_return_frame_rx_napi(xdpf);
+		}
+
 		nxmit++;
 	}
=20
--=20
2.43.0



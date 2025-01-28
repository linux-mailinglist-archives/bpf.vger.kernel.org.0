Return-Path: <bpf+bounces-49964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C6A20A8B
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 13:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC68C3A71DE
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B91A08A0;
	Tue, 28 Jan 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b="hQqdfVBP"
X-Original-To: bpf@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C13290F
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067246; cv=none; b=LDuaQF7lGZltOJ8K5GP5qS+OLyUAHBEz7qn4x4RdSFoPUlEFqnSy/HnjY/7cNiEZtwgk2iRW/gDKcn+ciXVhChJqQJAIcZJ8WprFR7NCgmcr3DOwmOCYRrdQlx5ce0Bxw5ED1lLSBMmrcfX7jxZndXWE677RnERbuashNDfl/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067246; c=relaxed/simple;
	bh=1gWtyaI+egDjezQYz9OVoseWuHwXlTKaft5yT0HP2UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CBAgqxlNx3p4x4J4webAOv33gNrwITynl5OcN7+8tmg6Dmy48XY4GUjcbawH7+LoUFrFLPlLukwC5DItofJNSvoeJncuY1/xrxRS3+hOGfWEYdMpYfspOPQWnLEtQ7ADjkUOhQVdUhzCzimug9Hsm3Og6i8U4oa+LCio0qm2BJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b=hQqdfVBP; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202501281227158a6a30e6b0a1806762
        for <bpf@vger.kernel.org>;
        Tue, 28 Jan 2025 13:27:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=zdenek.bouska@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=p4ixpKONXaTxPgBnMeyq9hz7nD1mrYbVaBMo2Q6Zl2w=;
 b=hQqdfVBP3AM7WaZHqHi1myUev0D3MsOvJpsfORbVHsl8HkRZx6Rzx1cU+7jTaPu/kHngdL
 oEi6uxyZSpu3Av4Rq3WjG+O5rDPrtU4OzJLw73iw47usrcTl6SjrRQKRtt6yPRBIDRNHyNwZ
 fFxzKjH3oyYZBh/3R1h01hGluE4XVGYQlZ9CQdeYjIMNHjbInQSVEpxdOprKSAdNkUMhM1i7
 tzrLfGplmbAfDHzMi2iCkBl1nhQAGllXJ0rbdoCd9XnZLR73MckcFyM/DyzlpEhA/FMBoiSY
 WTDjA87pns/piTcjqm7HU+LifhzLcSUCcNGlnWTNHfWeJHh98DpuDbMQ==;
From: Zdenek Bouska <zdenek.bouska@siemens.com>
Date: Tue, 28 Jan 2025 13:26:48 +0100
Subject: [PATCH] igc: Fix HW RX timestamp when passed by ZC XDP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
X-B4-Tracking: v=1; b=H4sIAAfNmGcC/x2NwQ7CIBAFf6XZsy+BxibqrxgPCEvZQ5GwjUWb/
 rvE4xxmZiflKqx0G3aq/BaVV+5gTwP55PLMkNCZRjNOxo4XyOwRpSFtqA2rLKyrWwq2xBnFqXL
 A84OvRwsF1ymwM9bEaM/Um6Vyl/+/++M4fhyn/7t/AAAA
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Song Yoong Siang <yoong.siang.song@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Zdenek Bouska <zdenek.bouska@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328595:519-21489:flowmailer

Fixes HW RX timestamp in the following scenario:
- AF_PACKET socket with enabled HW RX timestamps is created
- AF_XDP socket with enabled zero copy is created
- frame is forwarded to the BPF program, where the timestamp should
  still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
  behind bpf_xdp_metadata_rx_timestamp())
- the frame got XDP_PASS from BPF program, redirecting to the stack
- AF_PACKET socket receives the frame with HW RX timestamp

Moves the skb timestamp setting from igc_dispatch_skb_zc() to
igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
igc_construct_skb().

This issue can also be reproduced by running:
 # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
When a frame with the wrong port 9092 (instead of 9091) is used:
 # echo -n xdp | nc -u -q1 192.168.10.9 9092
then the RX timestamp is missing and xdp_hw_metadata prints:
 skb hwtstamp is not found!

With this fix or when copy mode is used:
 # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
then RX timestamp is found and xdp_hw_metadata prints:
 found skb hwtstamp = 1736509937.852786132

Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..d6c3147725b7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2707,8 +2707,9 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 }
 
 static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
-					    struct xdp_buff *xdp)
+					    struct igc_xdp_buff *ctx)
 {
+	struct xdp_buff *xdp = &ctx->xdp;
 	unsigned int totalsize = xdp->data_end - xdp->data_meta;
 	unsigned int metasize = xdp->data - xdp->data_meta;
 	struct sk_buff *skb;
@@ -2727,27 +2728,28 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 		__skb_pull(skb, metasize);
 	}
 
+	if (ctx->rx_ts) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+	}
+
 	return skb;
 }
 
 static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 				union igc_adv_rx_desc *desc,
-				struct xdp_buff *xdp,
-				ktime_t timestamp)
+				struct igc_xdp_buff *ctx)
 {
 	struct igc_ring *ring = q_vector->rx.ring;
 	struct sk_buff *skb;
 
-	skb = igc_construct_skb_zc(ring, xdp);
+	skb = igc_construct_skb_zc(ring, ctx);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
 		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
 		return;
 	}
 
-	if (timestamp)
-		skb_hwtstamps(skb)->hwtstamp = timestamp;
-
 	if (igc_cleanup_headers(ring, desc, skb))
 		return;
 
@@ -2783,7 +2785,6 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		union igc_adv_rx_desc *desc;
 		struct igc_rx_buffer *bi;
 		struct igc_xdp_buff *ctx;
-		ktime_t timestamp = 0;
 		unsigned int size;
 		int res;
 
@@ -2813,6 +2814,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 			 */
 			bi->xdp->data_meta += IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
+		} else {
+			ctx->rx_ts = NULL;
 		}
 
 		bi->xdp->data_end = bi->xdp->data + size;
@@ -2821,7 +2824,7 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		res = __igc_xdp_run_prog(adapter, prog, bi->xdp);
 		switch (res) {
 		case IGC_XDP_PASS:
-			igc_dispatch_skb_zc(q_vector, desc, bi->xdp, timestamp);
+			igc_dispatch_skb_zc(q_vector, desc, ctx);
 			fallthrough;
 		case IGC_XDP_CONSUMED:
 			xsk_buff_free(bi->xdp);

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-95dea010ff14

Best regards,
-- 
Zdenek Bouska

Siemens, s.r.o.
Foundational Technologies



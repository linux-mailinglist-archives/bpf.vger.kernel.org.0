Return-Path: <bpf+bounces-20872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767688448D9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930991C21741
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EF12F583;
	Wed, 31 Jan 2024 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="NhMxobQ5"
X-Original-To: bpf@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3D3EA72;
	Wed, 31 Jan 2024 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732776; cv=none; b=boqi7o7RLP6npWp3pvca02i9qpw6MdHfUMFEUCkNQ2qYqDE9ACUGQ6QDPnNkGWjorZdLeIgLcEhhHrEDplYe2HF33RFGUuUsr7u1V/ZUpquY81Nulwk6fKDAwwIk6NP1FVQ/TjtIw42Kgxdp4TqtQzhKIy94SIET2xRyvGGIl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732776; c=relaxed/simple;
	bh=bXFH58hccCQthBdDnE/o7/jUHbg7xeYj4csPrs31JnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dz774RN6/WVNCOmAqAAvsIoLDllJJ0TZteDwZXT6ls+4TYcwdk2ynXaJ27i9D3QiZZVdAGVXYCPC3a7rBKNmaXeTXsom+ekBXSL3vkzrk9+pzxXvlIo43XpE/7vialewpKXVZijgQ73IZ9Ar3NRfDjnfdsoi5k7WcN8O8yUvf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=NhMxobQ5; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Nh62DlraMPCXXICxJ5ak5SxVge59yrIgn/t2QJMIn/4=; b=NhMxobQ5teSvF8PprPZ0x13vcp
	1T64O9AS3sLBaqhf1kz71oc4McxuuJLIJOWCmVsnWQI3LDoiaoBiNMbfkE2JI/sA0ObxZdYQmDbEe
	4yziqpzzo93sG09cLOmroHwYoIJRghKZAQKHp4e2U8UHTvZhzvA2jmPBg9sHj53QezW8=;
Received: from [88.117.59.234] (helo=hornet.engleder.at)
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rVGyS-0002mG-1c;
	Wed, 31 Jan 2024 21:14:20 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net] tsnep: Fix mapping for zero copy XDP_TX action
Date: Wed, 31 Jan 2024 21:14:13 +0100
Message-Id: <20240131201413.18805-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

For XDP_TX action xdp_buff is converted to xdp_frame. The conversion is
done by xdp_convert_buff_to_frame(). The memory type of the resulting
xdp_frame depends on the memory type of the xdp_buff. For page pool
based xdp_buff it produces xdp_frame with memory type
MEM_TYPE_PAGE_POOL. For zero copy XSK pool based xdp_buff it produces
xdp_frame with memory type MEM_TYPE_PAGE_ORDER0.

tsnep_xdp_xmit_back() is not prepared for that and uses always the page
pool buffer type TSNEP_TX_TYPE_XDP_TX. This leads to invalid mappings
and the transmission of undefined data.

Improve tsnep_xdp_xmit_back() to use the generic buffer type
TSNEP_TX_TYPE_XDP_NDO for zero copy XDP_TX.

Fixes: 3fc2333933fd ("tsnep: Add XDP socket zero-copy RX support")
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index eb64118f5b18..f019a097f1ab 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -721,17 +721,25 @@ static void tsnep_xdp_xmit_flush(struct tsnep_tx *tx)
 
 static bool tsnep_xdp_xmit_back(struct tsnep_adapter *adapter,
 				struct xdp_buff *xdp,
-				struct netdev_queue *tx_nq, struct tsnep_tx *tx)
+				struct netdev_queue *tx_nq, struct tsnep_tx *tx,
+				bool zc)
 {
 	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
 	bool xmit;
+	u32 type;
 
 	if (unlikely(!xdpf))
 		return false;
 
+	/* no page pool for zero copy */
+	if (zc)
+		type = TSNEP_TX_TYPE_XDP_NDO;
+	else
+		type = TSNEP_TX_TYPE_XDP_TX;
+
 	__netif_tx_lock(tx_nq, smp_processor_id());
 
-	xmit = tsnep_xdp_xmit_frame_ring(xdpf, tx, TSNEP_TX_TYPE_XDP_TX);
+	xmit = tsnep_xdp_xmit_frame_ring(xdpf, tx, type);
 
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	if (xmit)
@@ -1275,7 +1283,7 @@ static bool tsnep_xdp_run_prog(struct tsnep_rx *rx, struct bpf_prog *prog,
 	case XDP_PASS:
 		return false;
 	case XDP_TX:
-		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx))
+		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx, false))
 			goto out_failure;
 		*status |= TSNEP_XDP_TX;
 		return true;
@@ -1325,7 +1333,7 @@ static bool tsnep_xdp_run_prog_zc(struct tsnep_rx *rx, struct bpf_prog *prog,
 	case XDP_PASS:
 		return false;
 	case XDP_TX:
-		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx))
+		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx, true))
 			goto out_failure;
 		*status |= TSNEP_XDP_TX;
 		return true;
-- 
2.39.2



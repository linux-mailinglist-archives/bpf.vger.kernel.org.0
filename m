Return-Path: <bpf+bounces-70698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F6BCACEA
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F448331E
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C312737E8;
	Thu,  9 Oct 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="JIoAowX0"
X-Original-To: bpf@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF65271440
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041753; cv=none; b=eab1XngEe4YTRzR+bnD0VY00VgnMH38O3+8ksCsp1t0SZ7u6VVF4XoViCwSw/CLK23FX/aBM0U5dgtLyzPJsg7NUXdwl4FUaAQ6ThPnA65os9SuhXyOQbAlTGezqndZQP0cgK7ve0g/skOymJf4aGfl61Bt9YZYsn/IZQQDbuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041753; c=relaxed/simple;
	bh=RX1K5KPSFGA72/LrpHxaAbZJRQpoejZVuU8GJ1Oylko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA/Hx3zWNSyKr6PXXWZyFxQFl/eg2eELP9P+W3DPZpIe2r4BJAtf2pSpv0fhqqfIkNXh7ihQ0hDNAe5E9MLw3RwULiA/56mfHDx1rkbERzfnrthnymINZziAZe5cdIt0DRdqIkWge+bOYhR19o7wfZbLttL1QhH9ChukBFLLigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=JIoAowX0; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1760041752; x=1762633752;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=ofx1rW2+30KvORCW7saFUEf3E1N+8nsWWjpSDi6TtgA=;
	b=JIoAowX0+u6HnepSQykeV6sU4m98QjTaFIjNilulit2woNAVfwa5F7rsTWOIg+nW1EE4PFna2xpN58Au7ey64mtkYwFqjQTmU4simmEILctoVNkDIIo6Wdi1E1paLPWo7Zi47KnWgl06Be+oJHyr9L20WBXhp65PtpyZzUeoHIA=
X-Thread-Info: NDUwNC4xMi43MGEyMTAwMDBiMDc0NjYuYnBmPXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id 2AA012CE05A3;
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
Subject: [RFC ixgbe 2/2] ixgbe: Fix CPU to ring assignment
Date: Thu,  9 Oct 2025 15:28:31 -0400
Message-ID: <20251009192831.3333763-3-dev@nalramli.com>
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

The ixgbe driver uses ixgbe_determine_*_ring to determine the CPU mapping
of transmit rings. Those helper functions have a hard-coded number of
rings equal to IXGBE_MAX_XDP_QS, which is set to 64. However, this does
not take into account the number of actual rings configured, which could
be lower. This results in NULL being returned, if the modulus operation
falls into a ring that is not configured. Instead, use the actual number
of configured rings.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Fixes: 4fe815850bdc ("ixgbe: let the xdpdrv work with more than 64 cpus")
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ether=
net/intel/ixgbe/ixgbe.h
index 26c378853755..e2c09545bad1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -830,18 +830,10 @@ struct ixgbe_adapter {
 	spinlock_t vfs_lock;
 };
=20
-static inline int ixgbe_determine_xdp_q_idx(int cpu)
-{
-	if (static_key_enabled(&ixgbe_xdp_locking_key))
-		return cpu % IXGBE_MAX_XDP_QS;
-	else
-		return cpu;
-}
-
 static inline
 struct ixgbe_ring *ixgbe_determine_xdp_ring(struct ixgbe_adapter *adapte=
r)
 {
-	int index =3D ixgbe_determine_xdp_q_idx(smp_processor_id());
+	int index =3D smp_processor_id() % adapter->num_xdp_queues;
=20
 	return adapter->xdp_ring[index];
 }
@@ -849,7 +841,7 @@ struct ixgbe_ring *ixgbe_determine_xdp_ring(struct ix=
gbe_adapter *adapter)
 static inline
 struct ixgbe_ring *ixgbe_determine_tx_ring(struct ixgbe_adapter *adapter=
)
 {
-	int index =3D ixgbe_determine_xdp_q_idx(smp_processor_id());
+	int index =3D smp_processor_id() % adapter->num_tx_queues;
=20
 	return adapter->tx_ring[index];
 }
--=20
2.43.0



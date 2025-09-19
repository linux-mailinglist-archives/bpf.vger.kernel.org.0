Return-Path: <bpf+bounces-68985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0BAB8B598
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6445C042C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF72D9494;
	Fri, 19 Sep 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VsP/rTlA"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707C2D4B7C;
	Fri, 19 Sep 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317532; cv=none; b=ahgo9DH4mShZB19zMXx5hYcqmAdphWKzTMhZghwQoiuTaj0nEliRI+Kj+j6vah5HKnMZfKzyAWuAxJNUoFVWh40FxqWIQhNwfEZVcOhwcWe8mAJ6wsKALvX3MnhWG7NxAtUyZ9Vis+U8Ns/QURXQMCcVa9yhdoxYPUf1kubRy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317532; c=relaxed/simple;
	bh=R8aiLOYeNL/h5cx2U0ga2tp2KtzPu7DqAlXH117v3/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODj1G8IJtNSKREGO0nuV248Vln8wgceqwvIMoJsZFX2sKi36cQ5bP37pfsIdFVg2X6Odj3hJFmU+QXxfw04MSZK5e/vXZdBLiJp7ScqCbJqJpa/zJBj96LzN8s0XFrQlgo9IRBtjqp+4CwGkkgiJLMjzVKBOq09ulVnn9D4s+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VsP/rTlA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TxnsToPeELm1rQ6uE9aXNYDEsYc9L9TF1br3cHSrCOM=; b=VsP/rTlABk1vmvL5bgl61Il/O5
	ZFGvnO/XJG++TErxC5hFca0sTFgij5HZz74O2g6itQXcMLLXaAP1V2wSnFLuMjbbGoK4gayrcr19P
	05DZ61hE7LmhDr/28cDYIAoZz6KHEPrb+ox5o8QcsvyxEHU9EU/Yfrs+afxaZuHCR5pqNQE0GKKDL
	q1VUEIAVxi+/J3pUIgZSfnPYk6M5+OW0R9sc3xs1olpGa7dX7NTAzAfFxCZg80yPG2GdRrN/Dl/EL
	unHZxybSS1y5qcilszkzSAN2KD0APAFmBqEC4Hyy789Bskjx3d1EdwG+uGbBkFO43BUntSzmb9zA/
	nh3/K3Yw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii3-000Nqv-1z;
	Fri, 19 Sep 2025 23:32:03 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 09/20] xsk: Move NETDEV_XDP_ACT_ZC into generic header
Date: Fri, 19 Sep 2025 23:31:42 +0200
Message-ID: <20250919213153.103606-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

Move NETDEV_XDP_ACT_ZC into xdp_sock_drv.h header such that external code
can reuse it, and rename it into more generic NETDEV_XDP_ACT_XSK.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/xdp_sock_drv.h | 4 ++++
 net/xdp/xsk_buff_pool.c    | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 513c8e9704f6..47120666d8d6 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -12,6 +12,10 @@
 #define XDP_UMEM_MIN_CHUNK_SHIFT 11
 #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
 
+#define NETDEV_XDP_ACT_XSK	(NETDEV_XDP_ACT_BASIC |		\
+				 NETDEV_XDP_ACT_REDIRECT |	\
+				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
+
 struct xsk_cb_desc {
 	void *src;
 	u8 off;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..26165baf99f4 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -158,10 +158,6 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 	}
 }
 
-#define NETDEV_XDP_ACT_ZC	(NETDEV_XDP_ACT_BASIC |		\
-				 NETDEV_XDP_ACT_REDIRECT |	\
-				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
-
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
@@ -203,7 +199,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		/* For copy-mode, we are done. */
 		return 0;
 
-	if ((netdev->xdp_features & NETDEV_XDP_ACT_ZC) != NETDEV_XDP_ACT_ZC) {
+	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-- 
2.43.0



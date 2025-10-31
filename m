Return-Path: <bpf+bounces-73197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C64C27058
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A9818951D9
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDE32BF25;
	Fri, 31 Oct 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iTNMGTce"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7DD30F556;
	Fri, 31 Oct 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945695; cv=none; b=UpxbdL4RaNccLw7YANVF4w7akEjVQQOQaIh248+WrgN7qRLbNLygo1QQjleVLqEMHvijlwbv/qmy8DtHnuu4LaoQhoEzqs+JjmjZ2wsx6vHyWtrjiwlv8p9JY+N0RKb3xu8uqroyL04u3t3eYAa8yukmke+orHDf2uysBi8h368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945695; c=relaxed/simple;
	bh=EpgPg/p5cc7ht4GSCm2wnjnQJutNxY2Ggb26NMyeREc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzJbUts3bu43+yNPVXXkELGA+iGSqv2xE/zezuMobyFTojdgWFqe+e7SrSD3/wz4epF+CSMWEdWOfOjWZmXWlr38gK6E1moper+UU+ECZTYbJPFh9h/lk8OdI3CCH1s5ABAdLRLH+PzgH2OZOBbm3gAUy0rZ6dlQTJl1G6/dupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iTNMGTce; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FKG4KtMnKWAZQiQUkIl012zrdhpKJ6kNdgrkPnRr/L0=; b=iTNMGTceyKRj4GJ7k863aJuw5S
	+wFvIc7m7ntcglMciilwi/qQXSojwIMGuYP0OO9AlfBWgQSP1sZ1Ox7hKCiIO9hoCswCsLF9cV7+O
	AmxH7omXGX9JaxXoFBSgdxyKxwG6OtQRMR4o0h2cSotcZH9o+LFhxsWsWAaQGpLkfuUd+R3sfs5H4
	UwRbXmX0n+w0bf8AiuknrLUObg8SHb3SguCrQrp1B9BRmAu2sw1vFiIzXiYYSYBlzXFNM6omKU0bA
	TgJfIru0nde/4xOdT0uwppfQbvfKPRoWf5SjgSOT+w6o7XNntFkSEnQHA5q4YDDJ0KxYJHjjpJTpV
	Yflt843g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYa-0005cn-0n;
	Fri, 31 Oct 2025 22:21:12 +0100
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
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v4 06/14] xsk: Move NETDEV_XDP_ACT_ZC into generic header
Date: Fri, 31 Oct 2025 22:20:55 +0100
Message-ID: <20251031212103.310683-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

Move NETDEV_XDP_ACT_ZC into xdp_sock_drv.h header such that external code
can reuse it, and rename it into more generic NETDEV_XDP_ACT_XSK.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/xdp_sock_drv.h | 4 ++++
 net/xdp/xsk_buff_pool.c    | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 4f2d3268a676..242e34f771cc 100644
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



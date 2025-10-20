Return-Path: <bpf+bounces-71413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2773ABF263B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4145D4F87D1
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593D287504;
	Mon, 20 Oct 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="I7oMbKQb"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833A2853F3;
	Mon, 20 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977459; cv=none; b=IgmuCzfvYdsLdpo6lYMyZaBbP+dPupky81Ymdbdz4sh3SadFrIQQ3ULdN3rQalO/qu267vcrJorE7xDqs0Q9gV9MtQfWsEdGbdUK/o5AEaJY7YY6xvzyS9ETuhgrtcvOuaTnl5PGdE8+396Z1l9iRAkuEa9YraXE8eMvirZYRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977459; c=relaxed/simple;
	bh=fUD9ghDt4E3CEY6u4Tmxn9Op8aRkIiPkLfL752IM0E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2+G9qqnBOH1/WcvRUGvaEbOhAw6blkUbi1OeyF3F/eD+oSF8UDdrBkO9iUZAlZbjzfRHPjd46z2hGmNH1SXn1eFLrpV7L320IL6aimbQlu0bRPpRf/FXsNbkSgHhSM047iVEvvohS6UDLDh7VgnLrqwmoq7O7LUexZNkwiU1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=I7oMbKQb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kKYd+5PbpyQi++/hDhcsCgmhorksnRLXjYa/FFHfW0Y=; b=I7oMbKQbQ4He9ShjhqyKFBqMjo
	wR2DvXKEEX82S7F0g8IPR04z5Nvr8/DmPct87W3qxH1sPGbJnpWnGlPUJncG7ew/PkU3mKhwv3aKd
	HjNvP7ZQ22mANWZ096zX5whHrSuC/utiG4x5kCvU/cQlV5jyWeMMAyDblfsbiKgL/0cmsXmnVrb5K
	DDVEmJq+Coukyn60/QIJGsbwFxxW37lKUn1hTPSU2ky1CMoLwxGWJIBMzWAQY93lBymmIh9AbjfNI
	XtpgvcdGIpLG/9KW7BGXtGGyQiC8kdJralVbQCRfUtagUfqdcaJaJSjwCtruWsNqfydJ1RpwP/voo
	OD+9Rq/g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsfz-000JkK-26;
	Mon, 20 Oct 2025 18:24:03 +0200
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
Subject: [PATCH net-next v3 06/15] xsk: Move NETDEV_XDP_ACT_ZC into generic header
Date: Mon, 20 Oct 2025 18:23:46 +0200
Message-ID: <20251020162355.136118-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020162355.136118-1-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

Move NETDEV_XDP_ACT_ZC into xdp_sock_drv.h header such that external code
can reuse it, and rename it into more generic NETDEV_XDP_ACT_XSK.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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



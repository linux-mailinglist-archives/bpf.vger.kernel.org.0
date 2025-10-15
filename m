Return-Path: <bpf+bounces-70990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF5BDEE74
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3620424FC6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979C266582;
	Wed, 15 Oct 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XqPaZN8o"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5423AB8D;
	Wed, 15 Oct 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536931; cv=none; b=Frb6nAIRqnNZ+P1nwoDMLV51jESY5SB6iKbaTy0o57so2RpgS+V0zar5nrW08r2Q6d6gJ20vImRRSQgQ33xgZVgQXkfzi5OhM9xClTf/AqvYxGkeJKJABJXUnO3cvcIWxdu0jE89x1HS1WMd9ItXUA6iojDRrx2FcuasgmvGoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536931; c=relaxed/simple;
	bh=fUD9ghDt4E3CEY6u4Tmxn9Op8aRkIiPkLfL752IM0E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlPIzLZsLBXudVB5IxKFf5gFid/c4mpxdwNgOu2ixMM733LtuHJ+z3KNm6Ri3seqEwLfNZOfwd8isZwR4y+hsk8HtyQGrHnzBjbi2JbGhKEtSsUzPhulPya6hYYDYHXQqm/FSY7V4vavyBrFgX9LU3rS5n77f1tlnHd3yWuQowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XqPaZN8o; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kKYd+5PbpyQi++/hDhcsCgmhorksnRLXjYa/FFHfW0Y=; b=XqPaZN8o4llmMWce1Xgjz7IhTX
	C/uqwsax1sq4dweqCTPGtXjDROmDiyce9kYlvUmF3TK3Hq+EABXZCX0hm6IQWsyQZHi5nYETPfCk1
	YCAAeJQwVLl9r9/6wYuS1MHdrDYEDnErNC78JAsIKPZP42go8NLfgHVuZu5FAgciy7oBFemcD4f3d
	ufFa8hbT7aYlHEFK4jG1OEp3WKAvSFC4mnQ0TZEbGEZQ4b0dhZmqBgxi6ZfL3larrf4j12jPTDgKx
	OR0yjVC8ZSu9UdKy5wSb0gRYkod2uQPMXjJY4Cp6io8DtEKghJCRmNc3agB1g4PYXgH5W4+avUkpc
	p7brGo6A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924a-000H7K-2r;
	Wed, 15 Oct 2025 16:01:48 +0200
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
Subject: [PATCH net-next v2 06/15] xsk: Move NETDEV_XDP_ACT_ZC into generic header
Date: Wed, 15 Oct 2025 16:01:31 +0200
Message-ID: <20251015140140.62273-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015140140.62273-1-daniel@iogearbox.net>
References: <20251015140140.62273-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27793/Wed Oct 15 11:29:40 2025)

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



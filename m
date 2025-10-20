Return-Path: <bpf+bounces-71416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ABFBF265C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F8D423B94
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2927286D7B;
	Mon, 20 Oct 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XzOd/AWT"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3842868BD;
	Mon, 20 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977459; cv=none; b=eNbYEuar6GKfoD9LCETdEfwewhctD7rSxcFJOdDyMLX2WgLyLGQJo9j/j084NJ3y/zpRQ1sJAs+lS5t6F6xq82uLZluwLV7LNYbUeKAIy5WDdUEGE/TaLvsy62042sp/hywj5Xmph0S2vQSfdbMHiiMS3KaY2TlxNZTuOfAYdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977459; c=relaxed/simple;
	bh=v//9FhWfw6qyKrGEtF9u5BanJY7egLJ+MpBOb4qEkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+aPILKWkfdRxkk3Or5O8txjYU8t65gYc74z6Vs9l6y/6zurMotk27hlG5fOE8zsRkiGAmWMIqq1NJXo6HpVMFlwB4yurgvrztlDtEqByeYDrSKyGj+SMGnBbHer5dIRU8dN0qFz4aLwn97dkpPqExFBzNQtL5Sg1PqlnbJcN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XzOd/AWT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ioqZ5xXI5MymnaQTGznv4dmvRm+JadJ0INiqrmzTJTY=; b=XzOd/AWT4fhdprcRpD8wCMYl28
	UcvwbEWk5Xvzgnj/eh030ksVh1dPKVvu7skBG37IkVsJVMYRlzYXE6qIZ2EEwp4hu3a43JpOno9Ec
	I7dc/hiJkoWSckgU6VeXTmtovgsXOJJSmFGgqHngRj92fPwUutm2B7vlZHHfKPErHnyoiKRiye8fR
	cR+h/ndFPqT7AGoVLyXvUFoA5I/cAN0HBSRovBI299/boAkUg26iCVcy4Pn04BACKCxmuOqgaQP+P
	R2vqkLEc/n+mZo87ECAzdvCK7w3Z8OskgfxW0I3RPfwtEqemPsmzesEB0khi4hjZJZzU4uW4M7R4/
	56ATxJPQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsg1-000Jkh-2R;
	Mon, 20 Oct 2025 18:24:05 +0200
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
Subject: [PATCH net-next v3 08/15] xsk: Add small helper xp_pool_bindable
Date: Mon, 20 Oct 2025 18:23:48 +0200
Message-ID: <20251020162355.136118-9-daniel@iogearbox.net>
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

Add another small helper called xp_pool_bindable and move the current
dev_get_min_mp_channel_count test into this helper. Pass in the pool
object, such that we derive the netdev from the prior registered pool.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk_buff_pool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 62a176996f02..701be6a5b074 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -54,6 +54,11 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 	return 0;
 }
 
+static bool xp_pool_bindable(struct xsk_buff_pool *pool)
+{
+	return dev_get_min_mp_channel_count(pool->netdev) == 0;
+}
+
 struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 						struct xdp_umem *umem)
 {
@@ -204,7 +209,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (dev_get_min_mp_channel_count(netdev)) {
+	if (!xp_pool_bindable(pool)) {
 		err = -EBUSY;
 		goto err_unreg_pool;
 	}
-- 
2.43.0



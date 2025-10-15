Return-Path: <bpf+bounces-70998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABC2BDEE8C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AB119C77D6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4AA284894;
	Wed, 15 Oct 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BN2q6xKG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50427A91D;
	Wed, 15 Oct 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536938; cv=none; b=GjQDSRH2zxY01UzclG/wde0GQtsPV9l5OegANY1AWPDjCYG/l5/w6S2KjopYIzn4pRC+b8pDS/QUO5t1pTA64idkZas+md418Q2+Fv+uGKbyLLAm7E30YEwV8SsFbei+8BwAa5LHAgWINBdAsLMDmKcSLbawxA9dS2ZoiLouFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536938; c=relaxed/simple;
	bh=v//9FhWfw6qyKrGEtF9u5BanJY7egLJ+MpBOb4qEkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVsdmuyS1DwQ3BRytsWtlJCCNWrLwXIqy2cIi1Vd0CXSzGyuaJbqETUdoNPLwtetUKOSJ2ZxpjDVfRrAQIcBaLLIQe8UDuyq0YlXAopO9Ca7tXDqN95QsbrHgFGF8PmYE7RTFAI0u1xURk8rUavvYCcsYmjdRQUegix+DeXCKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BN2q6xKG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ioqZ5xXI5MymnaQTGznv4dmvRm+JadJ0INiqrmzTJTY=; b=BN2q6xKGHZdGQhsDAX922M92zI
	a3J5yZvTvu8eL2PEewg6iLVjTeSNXVdYS4qqza9dB91EFygjBJMDZhFMvKi7cgLtj1RcfAWYTIKth
	ck5pjZjGjU9OJEE82NcojqvB5dKMLn0Q9VaGSBp0xEJSjuKlJXzZ9Y0WXBzxYzIjnG+/4eYiCAx2u
	cIEPO63Tqh3ssbIEQnzPqCZvtbyEEExpPWQAwXW3Tll6DcXCS/NQy6xcQrPhrbHwMsg8SqTSg70if
	8BwLnBmBFMSx2fWxW+GTtc1RzJB1dS9weeJlTSTyV2pC8GsDUUhOIhmG3Z05yX3lLN0i+J+xMp9PP
	Bdx9nTvw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924d-000H7a-0k;
	Wed, 15 Oct 2025 16:01:51 +0200
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
Subject: [PATCH net-next v2 08/15] xsk: Add small helper xp_pool_bindable
Date: Wed, 15 Oct 2025 16:01:33 +0200
Message-ID: <20251015140140.62273-9-daniel@iogearbox.net>
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



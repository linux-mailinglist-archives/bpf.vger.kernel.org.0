Return-Path: <bpf+bounces-70994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4619BDEE93
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51990484891
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE68B275864;
	Wed, 15 Oct 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BffDpNCP"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677326CE06;
	Wed, 15 Oct 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536935; cv=none; b=CGjZbPFRd6psuxdsSnxtx0v3ZxBYpN4rFifRlmfTgdB31KxwOjUXHtETDdSautDnz5GOJ/ESVCALeGmo9fxM82lYjXinT6DSLLQsOx5Qxm/5o6NVahCZHmpN/Co2Ch9xPpQFxFfBTpVg2mBgtGapdMToKFhN2+/IdxB8ujh4ISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536935; c=relaxed/simple;
	bh=gr8O0VsCfYfZALirpf7AUd+XpB1bCSYsnvjxnsxxtFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6dUYV2HC4sTkvX4j94mjIpedM2aXpnuVfBFqVHiaNDTZ3yRkAHGFBNamWQfaIXzKQNXRT6i9kTr2b2FYd8RHL/MYyZdCVEIpscgo18xCnVPrBGdEl/eGkBNY9S7tff3gMhLJ05cgcqLAljQUmA8NpRmhjQxh5a5zW9CcQdngAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BffDpNCP; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HNnxENWGqBSWT9FDD0dF29tJGPlXNMRMa5HKFPBDmOY=; b=BffDpNCPLdk2KJO8iwdJOAI3xL
	kCMyYUubTmXxt+SoJ7uNGXYjErQ8bvMTo6xRZ66FgB9Znt4TFPO6eyGxqvc8r1Bm4v9+iT+vX2sCP
	JSWEJ2RKxC8vkilPhyMny3sHTD9HKJLwHJ47zlGmeL424WpOjBedMf04a031s5Pf7FTI8uMVq0s0O
	IXDVEjqyOlRMigvG+2Hvv0T1c2RYpRHAy+EISbFNTS6on/IS6s7dBhU7aPI/CuOwk//ZP1EA9hi1A
	EYl5neuFrnCNdESWKm/KcbHEdJrzsBEh+qMHyikqxjfS0mruBK3N8Ky4KkTGQMSmRbOXs1f1vsb1U
	40BUXeIQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924h-000H8Q-2R;
	Wed, 15 Oct 2025 16:01:55 +0200
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
Subject: [PATCH net-next v2 12/15] netkit: Document fast vs slowpath members via macros
Date: Wed, 15 Oct 2025 16:01:37 +0200
Message-ID: <20251015140140.62273-13-daniel@iogearbox.net>
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

Instead of a comment, just use two cachline groups to document the intent
for members often accessed in fast or slow path.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netkit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index e3a2445d83fc..96734828bfb8 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -16,18 +16,20 @@
 #define DRV_NAME "netkit"
 
 struct netkit {
-	/* Needed in fast-path */
+	__cacheline_group_begin(netkit_fastpath);
 	struct net_device __rcu *peer;
 	struct bpf_mprog_entry __rcu *active;
 	enum netkit_action policy;
 	enum netkit_scrub scrub;
 	struct bpf_mprog_bundle	bundle;
+	__cacheline_group_end(netkit_fastpath);
 
-	/* Needed in slow-path */
+	__cacheline_group_begin(netkit_slowpath);
 	enum netkit_mode mode;
 	enum netkit_pairing pair;
 	bool primary;
 	u32 headroom;
+	__cacheline_group_end(netkit_slowpath);
 };
 
 struct netkit_link {
-- 
2.43.0



Return-Path: <bpf+bounces-68991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3CB8B67A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773BE7BF364
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A8209F43;
	Fri, 19 Sep 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LNs1bA84"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B123FC54;
	Fri, 19 Sep 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318666; cv=none; b=b+eGgbs3gx11j2ZQ2TfCSjvbCA1d7LeBSVOrXiniSAUoLUz0rFdZL93bJFJKPdXjguKEf7o/3jta/NalXt2a92qH1AIHOVS+NURMwsNG89dOyoU6uLvKRPbVNjz/xUpImefVa+Jf4SeyxBCXtiqM3n4jpn61X/lkwcsrYueBA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318666; c=relaxed/simple;
	bh=z8XeIdrrRmM1H0R62nrSnz5OSNXgLnXskkJEIGjEl4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYqMhwFKcm1/yU10Sn6yBdSSyUon7nSVSZk7DZvlO5pgqVvJdc/V93nHL0pLDQ1AOIo0RmLtG3QJnbbhFoN4IqsFbC6WShgiopyWeBQOXtSlgoK+82DqUVQJ/8Pnr2cuXFCdjn3pJdDprSNnA483toaenoO/CFa+f9MB6kzwwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LNs1bA84; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nTtoHR7riK2xNDsA9e2DgSSN4FRJV6ssAZKtts2YHc0=; b=LNs1bA84bwYEJMnpDrnC+mvIhG
	nFaQQQoBBd+pGt8GGccekcvbw1+czx9y9jL9d3+0k3j/qKfPfadP6bwX+7BnZ86h3POFJbOsnwRhz
	J2QX68WfmjbXVFmCH8djSxK0uP/012XAd5Xd8Js43SNrNydmAQO0GGC1/4fH9FfOMaeMLqcrLAFzF
	fy3ibS2Z1WGOU+D76HIxNZuDmBQpQx0rhzYLUNlE/6a+cdkzzpl/RJK2IaXKPiX+W0Gl/Dq/W/8iq
	KEjYDoKgdfugKkGPass4N6qNY7BN1EjLVEg+HWEKbDVNmqMPtLppR5HkSuO0ecj5s094R6h4s/wN6
	mQ8PI9/Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii9-000Nsl-06;
	Fri, 19 Sep 2025 23:32:09 +0200
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
Subject: [PATCH net-next 15/20] netkit: Document fast vs slowpath members via macros
Date: Fri, 19 Sep 2025 23:31:48 +0200
Message-ID: <20250919213153.103606-16-daniel@iogearbox.net>
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

Instead of a comment, just use two cachline groups to document the intent
for members often accessed in fast or slow path.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netkit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index ceb1393ee599..8f1285513d82 100644
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



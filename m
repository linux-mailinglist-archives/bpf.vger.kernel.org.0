Return-Path: <bpf+bounces-71434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29CBF284D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABC784EFC40
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9E32F757;
	Mon, 20 Oct 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hgRNutOR"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96261F2B88;
	Mon, 20 Oct 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979049; cv=none; b=B2jsa6Ppy+N9Q0G7JsHCzz9aWB1A077enSvybhaTP5FzH7hA5kWc6DXzEtv57Tlj9jDyNGqvzIS8bVLAS0UCuZejC+VG/FBTIXtWn08DJ7aLafcc7WweFGJ3j1s71qWUGgO8nKtPSOvUbbi91Igij/k/kVDwODbUPempbmob27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979049; c=relaxed/simple;
	bh=gr8O0VsCfYfZALirpf7AUd+XpB1bCSYsnvjxnsxxtFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ib0PK85wImSb1v2r6kJ/ouHnLafNOhQHq+/BSGyxD0WS2J9/vqMi6Z0YGcldXR1jrCTsfHe49S2oC8P7QafQsydrpB0Hcet+rAA3/q4CY1x4rOrAOgM893dg4pe1j8eRqm21lTcx61DuY9CSxLrTV7x5r+FNhZejwmsO4Imj9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hgRNutOR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HNnxENWGqBSWT9FDD0dF29tJGPlXNMRMa5HKFPBDmOY=; b=hgRNutORs2S9vXYwsMkdeykK8e
	73WSnhzcbK04o6rlCLTvcIvZcraqIrknSIXwaMqerBeBnsJGj/PY58Ns8lhpNVbVZ8pcZX3JzNe3p
	33Jy55Nyb6PzhbrMz+JAHBXbBcVuNKz9vgd6/b5BEr7uHC+tmqbZ/zsVuABaafMUM/I/Qp8h9Ee3e
	tzeCSOJIKAXFRui60uRjvfzVmj0uFUhsmN1RVvnO89SLVrLm2bwXCWp+sTNGVWApx7hWj0Na0ZDWf
	ODz96IMa74YrnI+OIbrGfgSMFMlwuUK9/2lapPzSv3Hhl+vKmOSP0gCYYkkH4lSAhW7EL9QApsONt
	Lk8T7ViQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsg6-000JlL-00;
	Mon, 20 Oct 2025 18:24:10 +0200
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
Subject: [PATCH net-next v3 12/15] netkit: Document fast vs slowpath members via macros
Date: Mon, 20 Oct 2025 18:23:52 +0200
Message-ID: <20251020162355.136118-13-daniel@iogearbox.net>
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



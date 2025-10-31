Return-Path: <bpf+bounces-73202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF6C2703D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BE434F4090
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D43319843;
	Fri, 31 Oct 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nkl9d2lB"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FB32C92A;
	Fri, 31 Oct 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945697; cv=none; b=FVXRxYlPQoU2EPLzKiqZ5mJOaQGQSdDI3IRuy72A2XKQt8YEhi1J4KqmrWF1spnCF7jdGXltCNzAv54wbdVxmpWHme/pGEE1BSlzpFTHVv7MQsbXAnSfvlxUekdE2AczuZYJByG8X4vpmpMaaVQDuzdR5JaiU7hwlXudf89q/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945697; c=relaxed/simple;
	bh=+JuqsAz0Twl8D1iHnEUyb8SzIrW6+dkjlB5iWfE3Dss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZCl6bQP9pUOmUC3m03S16UxgcNxFglqYddUTLZpLQskAVfNBGENceJsKC8AXZ5Un430qg9taf86uYwiIYSCgdUvsKz/l9r3K5Qw6f3a1vA7EOb/ePxrz0TLoyQqMUK2Ozm10vlU4X/1/F8NxVyB4jIhQa+zUb8gdzQY589wEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nkl9d2lB; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=N7JNf9C5zO/4DbjO4jFQ66NqJNlPII2y1ehnCMTQ4/A=; b=nkl9d2lBNmekAoYn+fMNiJddQ+
	g9N1isZAilEh8qdtajYFy17/T3BMlwvpig9mKOFlPcypoZ+RW8zttnCBNwPB6nbxWxYyi4ctBffqh
	Duhf6xS+oazKGcOt4ohDFFVYieBWYYLbzaKTQVPsMP4Zorj8e+1rY/TcW5o2j9xucRe1pRQ2Me7m4
	qIcumnEkAp4a7110wC8k24hu3tZkWiXcqoKI8QHiuNQrO7Rz3KkQjrcZp8jVRbpI2cZqQa5+WtRpv
	Pp3QsdcoU07WXYpr+UPgvlvJ0ePmxGmflrTJ8bAReEAGqUghr61pstOim9u4r7Ez+bfce26ui3I+d
	KWGK/v4A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYe-0005dw-1q;
	Fri, 31 Oct 2025 22:21:16 +0100
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
Subject: [PATCH net-next v4 10/14] netkit: Document fast vs slowpath members via macros
Date: Fri, 31 Oct 2025 22:20:59 +0100
Message-ID: <20251031212103.310683-11-daniel@iogearbox.net>
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

Instead of a comment, just use two cachline groups to document the intent
for members often accessed in fast or slow path.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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



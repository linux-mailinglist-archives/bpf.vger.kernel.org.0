Return-Path: <bpf+bounces-45895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28BA9DED7B
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A3C163858
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128201A2C3A;
	Fri, 29 Nov 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVru4Jdu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFC15667B;
	Fri, 29 Nov 2024 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921889; cv=none; b=giZFMEgtklPWLdEoDJUb3rOYoOBb0XfO7FlQ3kp423T5gt0KqEe+ieFeVNTalHduQmRvvDxk9oksFk4VFrnIA9f8IufEUXBJwCmjmQVn05h9y8rKk2+0y5uD14yEOunn/CVANVltBy74sHZrlqsjSohS7EwXB9mrs1KYzUARn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921889; c=relaxed/simple;
	bh=q0xs1xNZyR0JFS7FbDGUEm9qGyNZc7xxcL0yd2kz6f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUh4BwRZhms12MDFm6Dx8nYEdrrX1BQ9BwgDItb0j6Bo0q2PG+5k/vc6kCsYolXapW2rBAiC0iiKRWVospYc4xjXOvflf/clnyRiTTS+k0hKkg9Eynz/Vi5tzQcdVxPx+6nQsD0Vvu0NaWaMxzFrP5gUS4nYhuWYYw0IGj9Go04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVru4Jdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94111C4CECF;
	Fri, 29 Nov 2024 23:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732921889;
	bh=q0xs1xNZyR0JFS7FbDGUEm9qGyNZc7xxcL0yd2kz6f0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lVru4JducHndNsRTjyruDiAot4TOO/fteaxZNOzgiNFs0cUp5wFsI8Br3LPERpgqy
	 BBq4z19mKTaWu4rOBu6h1At557W4kE4zd7gvTXct5adun6q5iItW7hAY5tUTFUvFIU
	 iSVeuL0jiL6LqkHTqF701S2FTlrJtOvkGY2cxQ5kec4Txj82hEknn6mVUfG87AdNEm
	 D+A6JnhMPK5HJh+KNWalLMj+QDk0rfLE67mnsbmzq4wz4cZKrhWqHdfcf/xlqaIgWX
	 BZxUFhtaImavw0t9Hs+aatFR+JI3qP3Y6sx9jImQ9MTdYoQb5fEOzzRdONiUX9ornK
	 Svl1b1Vte/kPQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:10:58 +0100
Subject: [PATCH bpf-next 1/3] net: Add napi_init_for_gro utility routine
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-cpumap-gro-v1-1-c1180b1b5758@kernel.org>
References: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
In-Reply-To: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce napi_init_for_gro utility routine to initialize napi struct
subfields not dependent by net_device pointer.
This is a preliminary patch to enable GRO support to cpumap codebase
without introducing net_device dependency in the cpumap_entry struct.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ecc686409161ea8684926434a9dcb233e065dd6c..9f083314fc4bc97059b02c6ee6d919bedb4e046d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2677,6 +2677,8 @@ static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
  */
 #define NAPI_POLL_WEIGHT 64
 
+int napi_init_for_gro(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int), int weight);
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55998077cb643a2f6e3c171974589d..20d531a54214e9ecf1128a668cf3763433e1989b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6723,13 +6723,14 @@ static void napi_save_config(struct napi_struct *n)
 	napi_hash_del(n);
 }
 
-void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-			   int (*poll)(struct napi_struct *, int), int weight)
+int napi_init_for_gro(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int), int weight)
 {
 	if (WARN_ON(test_and_set_bit(NAPI_STATE_LISTED, &napi->state)))
-		return;
+		return -EBUSY;
 
 	INIT_LIST_HEAD(&napi->poll_list);
+	INIT_LIST_HEAD(&napi->dev_list);
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
@@ -6747,6 +6748,16 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	napi->poll_owner = -1;
 #endif
 	napi->list_owner = -1;
+
+	return 0;
+}
+
+void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
+			   int (*poll)(struct napi_struct *, int), int weight)
+{
+	if (napi_init_for_gro(dev, napi, poll, weight))
+		return;
+
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	list_add_rcu(&napi->dev_list, &dev->napi_list);

-- 
2.47.0



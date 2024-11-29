Return-Path: <bpf+bounces-45896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846B9DED7C
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC16281815
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B41A7066;
	Fri, 29 Nov 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxLY6IV0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3215667B;
	Fri, 29 Nov 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921892; cv=none; b=oGAIEFLOyiY41G7cJ5Di+aPmgZyzYklH+/z2BAMKa1jCL3v8E3MRPXJ1z7QtLygRpCWAiZaje+f3+sp6VJUuXBcpng8dNtQ+ia7ebr8KqNeO4QUSNPyRaV9ywmh62N/UuNg0gsEdybLRXyc9la9327i8cOslK7Z1hlJ5hhgnZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921892; c=relaxed/simple;
	bh=o3emxOzM9BnKEYBobtqwMlUS5phwWmEom+xa8+ajkQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rw5pw7PTXXN+ZE2eJlKxOqC2hdVcDytdemc1iDsE0FBMyybhuRduJMvJRhrO0zJIhQS8900NCCXVdxoN+fBfampy36IAdez6Txl9dSJtSUFpaRsrZ2Iwl+CCPffNnaJXYyLKCUVPJOECNKaN2GvA1zXIrStTg0vBHCiLVPD/2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxLY6IV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC9DC4CECF;
	Fri, 29 Nov 2024 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732921891;
	bh=o3emxOzM9BnKEYBobtqwMlUS5phwWmEom+xa8+ajkQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MxLY6IV08Qyldx0ksXBGC1XaPVb/2tSswZPA96so6HH68Pr4IYBB9p+pPaDyzgitH
	 xqPcGPfgpjxdIxnwgp/DayWIyNxa8lVbOjQNoYR+9VCE5bX/mmaTOjco6wrJemyrFc
	 tUamiFPoVFKCZG6JDuYbkHyxCg7doAx/iCG+vtnHl5r7p5kld/WDXPVGmdAKHtbFdI
	 hNvH5Mp7l4xYdeIt2mtkoayVXZZ6SP1iQc8LC5pm0R4dlxkHLN4hFD/g0Y2Tq9XsNY
	 9BcBDF0tCEdrppt+ODRtMXHiD0iWF0LQjnbshX33XM59MhdTcCHHOvv39Te7CYRjGX
	 OM1zCEF/oLipA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:10:59 +0100
Subject: [PATCH bpf-next 2/3] net: add napi_threaded_poll to netdevice.h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-cpumap-gro-v1-2-c1180b1b5758@kernel.org>
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

Move napi_threaded_poll routine declaration in netdevice.h and remove
static keyword in order to reuse it in cpumap codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h | 1 +
 net/core/dev.c            | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9f083314fc4bc97059b02c6ee6d919bedb4e046d..a73315c0f2849aee141f11e4c970b233590a0dfa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2677,6 +2677,7 @@ static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
  */
 #define NAPI_POLL_WEIGHT 64
 
+int napi_threaded_poll(void *data);
 int napi_init_for_gro(struct net_device *dev, struct napi_struct *napi,
 		      int (*poll)(struct napi_struct *, int), int weight);
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
diff --git a/net/core/dev.c b/net/core/dev.c
index 20d531a54214e9ecf1128a668cf3763433e1989b..cf09a0c6abe50ebb95b22fe06705be95f46a7c6d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1419,8 +1419,6 @@ void netdev_notify_peers(struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_notify_peers);
 
-static int napi_threaded_poll(void *data);
-
 static int napi_kthread_create(struct napi_struct *n)
 {
 	int err = 0;
@@ -7027,7 +7025,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 	}
 }
 
-static int napi_threaded_poll(void *data)
+int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
 

-- 
2.47.0



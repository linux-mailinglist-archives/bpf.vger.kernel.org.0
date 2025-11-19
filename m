Return-Path: <bpf+bounces-75092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C8CC70316
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 934A2508039
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B7365A09;
	Wed, 19 Nov 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xoz4rTHa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430502E7BA7;
	Wed, 19 Nov 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569723; cv=none; b=qZgDFXrBPmpSqGsomoBpDqbR4ixGwV8esVt4Wgg2YaGn8nU55ynn96WCG+z0h+lctma6tljaiHxC1GPNIiKYrW/EITDfb/dvKko26XXOTE0oYI4SS2SmaQuYU1TYVrytdgtxvW7DWvzakJF1m/GTPl011+azEyClrtj2eDGEAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569723; c=relaxed/simple;
	bh=C57F31zzc3ewD09Pvf2UYOIYTYCT8ektyUBIj8rEEbk=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=uyyY9BWK/FszqDclNEABcnV96hRlNeTBFQtf1qIxyYxyq4gLTR3H9+lGNojaejlPTD0nrMfttiXxVrJX21ymqhhMpif8ig3p6f0z4CFGKvIHQlKgHFTXQZVgZzvWc68dA21G5h5Tw1QQaH1hC3Q9dmUtUlh2mDReFu3VgX5fJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xoz4rTHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE66C4CEF5;
	Wed, 19 Nov 2025 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763569722;
	bh=C57F31zzc3ewD09Pvf2UYOIYTYCT8ektyUBIj8rEEbk=;
	h=Subject:From:To:Cc:Date:From;
	b=Xoz4rTHaoiD/bDcCUStG2EhisTAyku8EBhRxet5tVNo3nGs64jTKfmC6ZKg7lX6Mh
	 yJvfNrb+tS8wADFSzzLwUcV3JJEv89bX+1v7AyN9nLh/JZ8Tjw6QFb4SRQ3Uu5lfi7
	 8QJlu+pgphz7CFgoMkW4wrKioBvsWMoi8KOT5Dgd1AdgkKS5Qu8aZaXDxR9a9UXT7w
	 oJwvSBblxfeZUOhH4DoGHfKdnpRAhzIJiY+Du3cdYe6D4i//lTcjy/SUuHbfOCOz7g
	 odVPPRnUqOcSV7DqSWc2keQVRQ9TYN9k4BFKA0I7eLZnTIGE4LBnHNdRNT0st14jXb
	 jlqvXeKDd+C0g==
Subject: [PATCH net V1] veth: reduce XDP no_direct return section to fix race
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, bigeasy@linutronix.de
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 toshiaki.makita1@gmail.com, kernel-team@cloudflare.com,
 mfleming@cloudflare.com, maciej.fijalkowski@intel.com, dtatulea@nvidia.com,
 edumazet@google.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Date: Wed, 19 Nov 2025 17:28:36 +0100
Message-ID: <176356963888.337072.4805242001928705046.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

As explain in commit fa349e396e48 ("veth: Fix race with AF_XDP exposing
old or uninitialized descriptors") for veth there is a chance after
napi_complete_done() that another CPU can manage start another NAPI
instance running veth_pool(). For NAPI this is correctly handled as the
napi_schedule_prep() check will prevent multiple instances from getting
scheduled, but for the remaining code in veth_pool() this can run
concurrent with the newly started NAPI instance.

The problem/race is that xdp_clear_return_frame_no_direct() isn't
designed to be nested.

Prior to commit 401cb7dae813 ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT.") the temporary BPF net context
bpf_redirect_info was stored per CPU, where this wasn't an issue. Since
this commit the BPF context is stored in 'current' task_struct. When
running veth in threaded-NAPI mode, then the kthread becomes the storage
area. Now a race exists between two concurrent veth_pool() function calls
one exiting NAPI and one running new NAPI, both using the same BPF net
context.

Race is when another CPU gets within the xdp_set_return_frame_no_direct()
section before exiting veth_pool() calls the clear-function
xdp_clear_return_frame_no_direct().

Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
We are seeing crashes that looks like UAF in production for an AF_XDP
application running on veth devices in threaded-NAPI mode.

This patch have already been deployed to production and we are anxiously
waiting to see if it resolves those crashes.

We believe this is a variation over fix in commit fa349e396e48
described in great details in Cloudflare blogpost:
 https://blog.cloudflare.com/a-debugging-story-corrupt-packets-in-af_xdp-kernel-bug-or-user-error/
---
 drivers/net/veth.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 35dd89aff4a9..cc502bf022d5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -975,6 +975,9 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
+	if (stats.xdp_tx > 0)
+		veth_xdp_flush(rq, &bq);
+	xdp_clear_return_frame_no_direct();
 
 	if (done < budget && napi_complete_done(napi, done)) {
 		/* Write rx_notify_masked before reading ptr_ring */
@@ -987,10 +990,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	if (stats.xdp_tx > 0)
-		veth_xdp_flush(rq, &bq);
-	xdp_clear_return_frame_no_direct();
-
 	/* Release backpressure per NAPI poll */
 	smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
 	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {




Return-Path: <bpf+bounces-60316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E4AD55C9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F480172818
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE922820D7;
	Wed, 11 Jun 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM/zWhpM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABA27FB27;
	Wed, 11 Jun 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645609; cv=none; b=nqWX6WUHRQDHZVCxpLVzhli5RvPgxC7jYL4AuQuA8G9gmuoJDd2TkLl/XJIQG4XCL5UQJaD2kWTHEGzVb338hkXTmfO1SUHFEtfcak+aTx84ZUFIa7Ct9XkwBypxo2sj/XurVerwtdnP/0F4jchQemhMcuZdNP8CjZhf/+R+ZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645609; c=relaxed/simple;
	bh=QMz39jfjPK2ufabsT8w+kRc6MrabZprer18jWGDdHJQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJF7gLFYRF/I7ahiF5HnkcWUkzF6rm4L41T7g219/oJ8vu6IPlhkAPm8wGh0KIM1mzFdURvdCrEF4qJ0qoAvy4nuo3/Esaa1VcxDSahEe85brgj/nluclp0XQ2k/1WsRZWJCx/ZcNwVrSSNlgO5WhNdhabhfVNWRcfzV057rjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM/zWhpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E5C4CEEE;
	Wed, 11 Jun 2025 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645609;
	bh=QMz39jfjPK2ufabsT8w+kRc6MrabZprer18jWGDdHJQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oM/zWhpMXKBBeGMVtlS6JO0dal+aeKnYIcfhUuTdZrf+RMTSSsiqljLtG0tlpBZsl
	 MApzGlFq6lGU2aCaj75sYW9/hP7PeXoFkWnURRL7rG0evIcddUbRwl0dG3kMDhYsl/
	 roF/9EOXbUJvn2Whzv336o1VoEPrqcOxnqFghLe0ja8ioiY0SW6zWyag0ZEQarD95e
	 UsUDvRb4mDWDpc2Ty3COpSFQ41aS7VsuF+GmyzmoipQxyroCvs8FRHRWaGkQrTlVS8
	 KgdKnt7wVT2odTelhy4f73dhWXJs+GgQLy+BbFMDIWq4golgr3HHIHHTjT737QEXzG
	 1qc4WWUCt64hw==
Subject: [PATCH net V1] veth: prevent NULL pointer dereference in veth_xdp_rcv
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, ihor.solodrai@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Wed, 11 Jun 2025 14:40:04 +0200
Message-ID: <174964557873.519608.10855046105237280978.stgit@firesoul>
In-Reply-To: <da1f2506-5cb0-446c-b623-dc8f74c53462@kernel.org>
References: <da1f2506-5cb0-446c-b623-dc8f74c53462@kernel.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The veth peer device is RCU protected, but when the peer device gets
deleted (veth_dellink) then the pointer is assigned NULL (via
RCU_INIT_POINTER).

This patch adds a necessary NULL check in veth_xdp_rcv when accessing
the veth peer net_device.

This fixes a bug introduced in commit dc82a33297fc ("veth: apply qdisc
backpressure on full ptr_ring to reduce TX drops"). The bug is a race
and only triggers when having inflight packets on a veth that is being
deleted.

Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Closes: https://lore.kernel.org/all/fecfcad0-7a16-42b8-bff2-66ee83a6e5c4@linux.dev/
Reported-by: syzbot+c4c7bf27f6b0c4bd97fe@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/683da55e.a00a0220.d8eae.0052.GAE@google.com/
Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
Commit dc82a33297fc have reached Linus'es tree in v6.16-rc1~132^2~208^2.
Thus, we can correct this before the release of v6.16.

 drivers/net/veth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e58a0f1b5c5b..a3046142cb8e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -909,7 +909,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 
 	/* NAPI functions as RCU section */
 	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
-	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
+	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	for (i = 0; i < budget; i++) {
 		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
@@ -959,7 +959,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 	rq->stats.vs.xdp_packets += done;
 	u64_stats_update_end(&rq->stats.syncp);
 
-	if (unlikely(netif_tx_queue_stopped(peer_txq)))
+	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
 		netif_tx_wake_queue(peer_txq);
 
 	return done;




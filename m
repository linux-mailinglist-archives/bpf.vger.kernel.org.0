Return-Path: <bpf+bounces-21062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C738474CD
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742491C2243E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17985276;
	Fri,  2 Feb 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3tVt0peE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kj6EpPeC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB117748
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891551; cv=none; b=PT4oSZqFbNoNHnU+1zdL1iI6v+I/wJ+8e4JgxtLRhkWmzuEzkX+qaTwFboJsrR31tUp/7OaWukCUbQqmC6/p8mQz+2w217T8+0D07UczWi/7cKC/Rl/MGO/d1/oG/tFJ056w3HCS5Foc/sIC/Ikx29d/qj6bJcXVyUObQFR7A5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891551; c=relaxed/simple;
	bh=/9upudc6Mn1B1zL826zknkwAfB47PeYpOGWapLRuVQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xplopx6fBaBF99LhHCwqS/N7+hlq24ifIiilZPYAM1BCRwB/XgomU2dQLieSx2WaOT2kJyFRF1//57rP06EbzS6goQEsiXCRdgof75D5g0aQ+ankBsclJ7Z02WpyxIurGXh/mVQjNsTS15Vq6ehwEP9SgKRDivCEJP9GBHC5gTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3tVt0peE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kj6EpPeC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706891547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kvAdUJa3uqeeqw0BrOc4nljVIOzEkmRbld6yu6uNOo=;
	b=3tVt0peE0ny0qkBiSU8rBZmxOm6+IVOD7Go8OKSYysEU26EvKWXxqKtBk/0EyT4dfzPV6H
	OpOZwy21D8QTugVCG2IPntD9LgpCa4UPG9gCRq3AYqGJ/d2qTnvuHNs+6BneI/lsv3M2Rx
	tr/+vnUwPWGQrQ5Mo8YOJ5mvCblFAYDTHBxowPhbmbo7RRDllzJ98P3hbfEGpdPwbweJF8
	i1G8B4tNciNFSbZP0GbXqMOPqaUpB2BdkXoG20fC6rcgrs9NuQdwEGS75vv7LvVjSdZNrj
	i4i0MFCGEhhvhR0kPIxi3xthp8eOXJ1RcNGYGo83dcrtSMVgPK4qyBQepFeuSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706891547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kvAdUJa3uqeeqw0BrOc4nljVIOzEkmRbld6yu6uNOo=;
	b=kj6EpPeCSlmoigF6W9kXqCREd0iDgIp7OVHmL/TRQNgmArW1oL2sj1MGHQZYFya9g79zoO
	uWbwoIIn1aOBtWBA==
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH bpf] xsk: Add truesize to skb_add_rx_frag().
Date: Fri,  2 Feb 2024 17:32:20 +0100
Message-ID: <20240202163221.2488589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

xsk_build_skb() allocates a page and adds it to the skb via
skb_add_rx_frag() and specifies 0 for truesize. This leads to a warning
in skb_add_rx_frag() with CONFIG_DEBUG_NET enabled because size is
larger than truesize.

Increasing truesize requires to add the same amount to socket's
sk_wmem_alloc counter in order not to underflow the counter during
release in the destructor (sock_wfree()).

Pass the size of the allocated page as truesize to skb_add_rx_frag().
Add this mount to socket's sk_wmem_alloc counter.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Noticed by running test_xsk.sh

 net/xdp/xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 0348e4bde23b2..3050739cfe1e0 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -744,7 +744,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *x=
s,
 			memcpy(vaddr, buffer, len);
 			kunmap_local(vaddr);
=20
-			skb_add_rx_frag(skb, nr_frags, page, 0, len, 0);
+			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
+			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
 		}
=20
 		if (first_frag && desc->options & XDP_TX_METADATA) {
--=20
2.43.0



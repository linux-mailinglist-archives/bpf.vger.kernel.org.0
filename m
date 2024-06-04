Return-Path: <bpf+bounces-31342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7378FB7C9
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782E628475C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C69149C47;
	Tue,  4 Jun 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYT7j3u9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/BQgWl+s"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE514882D;
	Tue,  4 Jun 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515893; cv=none; b=jiQw2J+bKFh7aKx4vQKiIuzo3mi9Yw/WjDunv/bEJAArr3CJkmjkRP2WrAuWjninQmdW+oI3MEXmJu36KSPH6eauqPCFLC88YQpLjXWbvdy0zhE47hCpFrSmzYOP2DeTysC5ehsQgzCm65KOBG4lX27a5jNRRgx7USDfM4GskEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515893; c=relaxed/simple;
	bh=DjKGXeuA0iicBNAujBOCeL9L9FyYM7749w3HflY304w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtSI4UAHQGX7SWBqbMwxJ9QLcBIzkoWd9d8gahj5EYv90NaZI5d8BPLf68tw94wqqi0T4yJZI74rnWCT4iPm3/sHb+UsNshGa6s7KluxA+nGAZFXWgzdeeWLPVQADrhyv/G7wFYHy4Fonk3POZCm8RopWloJ9Q4DhWe/3dAT0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYT7j3u9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/BQgWl+s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=FYT7j3u92/i/8Sx5Il3T/W0XVW6jIWM1wYgSXZ7mfNf/BJeMypkehw315AjK10/XSPcIB1
	ZZB5C3R6hfSBVYNTGWXArPhobIrd2gYlZiGBpGiIBagon3+ZeWhcXgkdKLWZxS7iT444DN
	vJtPwzzu+GdkB6EMW2eyP/sQoSRb0d6QO6glh9K2D2xUBxXCvnLYYEdP4BJ7wIWgdCGcVL
	rvfXz94a7kbctm+6UeGLIeMb5rqzODKK7hAmyRdc3BB9A/WXJJk1XRGBYkwMLW0oXWWgzL
	y6HXaLlp5FBRvYPWK/R7SMPkVboQX6s8aByaIxZ47m7DCH2paiPs1OWZeKgBfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=/BQgWl+suUnNiTzeLCG70TbsQSCwhuBBw2P8hNvXUUE/1I9+NEsbcLVf7A0AZWgHhCIJ0h
	cOuMvLJB4TyKgnAA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 10/14] lwt: Don't disable migration prio invoking BPF.
Date: Tue,  4 Jun 2024 17:24:17 +0200
Message-ID: <20240604154425.878636-11-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no need to explicitly disable migration if bottom halves are
also disabled. Disabling BH implies disabling migration.

Remove migrate_disable() and rely solely on disabling BH to remain on
the same CPU.

Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/lwt_bpf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 4a0797f0a154b..a94943681e5aa 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -40,10 +40,9 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_l=
wt_prog *lwt,
 {
 	int ret;
=20
-	/* Migration disable and BH disable are needed to protect per-cpu
-	 * redirect_info between BPF prog and skb_do_redirect().
+	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
+	 * BPF prog and skb_do_redirect().
 	 */
-	migrate_disable();
 	local_bh_disable();
 	bpf_compute_data_pointers(skb);
 	ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
@@ -78,7 +77,6 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lw=
t_prog *lwt,
 	}
=20
 	local_bh_enable();
-	migrate_enable();
=20
 	return ret;
 }
--=20
2.45.1



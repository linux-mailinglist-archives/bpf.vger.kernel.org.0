Return-Path: <bpf+bounces-31959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2C905980
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624921C2193E
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3424186E21;
	Wed, 12 Jun 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlz2kndY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qGMkRatw"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C231836D3;
	Wed, 12 Jun 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211807; cv=none; b=E06DfrINn7Z3g1GQPIfYqF6lknJlY/n7HC7EQ21iwsw6hOLY374wxOn/mjrkF95jbS3eUIIA8Yo4FDRMKmkEioHP8exP3yp9raunT6fWs7Yvm9orNHJSt7FipTFv1pwY1Bj1AVc3QWErkCGzPqLQHifgx1Q0SI9ywO86Q3gCFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211807; c=relaxed/simple;
	bh=DjKGXeuA0iicBNAujBOCeL9L9FyYM7749w3HflY304w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmVWCaW7qXxwD5aMLeXN66/HFkiQzN44G3ZFPbWs9oLlxANtNBKCmeCED4bEi588uQSyOwK+L71dBtz9fwcq8lwYHe2BOpPtQhfzkl1bSktUcnvabKyM59Jd3MC+FLoXc3OwTkAtLMjXtXf8+1J0qGNlQD3O5oP6x+HAZerl4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlz2kndY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qGMkRatw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=zlz2kndYk0cGnExFiLFFFsJfFORTVTEtlYosk/JAK+4+91hHTHsnPxTLQWzcFkK23KYBek
	jwIn0g/bsPc1ykU+Dq06BLtPbVpXnRfve4JOm4ENbLk1IzkSkfwk5jTvW139MTiqMeKfUz
	H8g6ZAW94ku3jM2YqXz1MjqneHMq3tSSH8R2M8uWCFKQijYWrBwKgrQ0u/9xNoqyhviqyd
	eCTb3AfRG1mO5YJNqt7WF9nloFHHNcYhMMYv1mIEIwd2KT9ssBmexsrP/XNG+iGLQfbAU7
	2ft2cNVBifhygb36V9GGh+kTVPyi+Rykjoyjkp763ZAMAO3Zj/lMqWbLOkj6Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=qGMkRatwWIFvk1SlmnTOLN21KY5kH34Sa2+TEbKYeLZBf9lCfui2gfJJoD1I+GMSB5TUd/
	w3B3OYroyowYw3Aw==
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
Subject: [PATCH v6 net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Wed, 12 Jun 2024 18:44:37 +0200
Message-ID: <20240612170303.3896084-12-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
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



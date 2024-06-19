Return-Path: <bpf+bounces-32496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BA490E459
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEB51F250F3
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 07:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478380024;
	Wed, 19 Jun 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qn5h86ZR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/o642bx"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E27D3E0;
	Wed, 19 Jun 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781808; cv=none; b=kxAfB4sGuSHpgerVwEYsUEYB1cueThduy01FVbQsHPK+rNVker/FwvNQs0ZQ0QfxH8MeXpo/S5FT7H5Jl8ZTjqCnRG84PagT7FR40YoZ5dB/K7++xXbV9fxWByiMt0KrkUSY/Qbz8d5coZdbKM9QbSNliJqXQc3DM/wQ3upyhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781808; c=relaxed/simple;
	bh=D7MV1ZUt0ja+VOQ5jBTqWT/rFam6BZA9NpCFJ3oOycU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwE2sS+ruBfYBPYSkUZDlSpGJ8Z5aPPcfMx5RZ8e9pHnaAuzgqzhhK72cA05M2UWPUWtbeFkL50XsIIpN2mFn0OwQlRvfcrgimh3/SFQB20KJpuUmdwPppIC+SQ2smSpGXCtSKeNiMS9grDkOtcTODrHZyQaa5qQ9/+0YUP0O7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qn5h86ZR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/o642bx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718781805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu8VD8DpLJkf2Hl3sxqZhIhEWbSf2IpwfXlNNAn3MjU=;
	b=qn5h86ZRDgmpC3mE8p0gAt3jHUrjCLGHxoQWit679UpRST+HfJKWLxoG1rX1YhMVSBACN2
	iKUH1Z++7z3VICYSpv5YSmi2rxH9RG+Aa1t/8QAlpFaBYUfRuNbeGKdALUSSZ0PeumogRy
	6bg+vFBNLG2MBOiLf0l5+KkC2VQJ3NdZafzz/YCebvAoDt1/DjCUa7n2xeObU4nmscEzAq
	A20qJMiD9mt8ik/Cqm2v5BTTxHjWUZHnZgXUpLTgyusYBb4n7QTRUhgbuPNOOwsMWT0GXU
	IIxckPBqHgZrD37gHxVw1cK9qHGZbS3waqDvkRIWjrUq62FvrhVrF2GSxAZY1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718781805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu8VD8DpLJkf2Hl3sxqZhIhEWbSf2IpwfXlNNAn3MjU=;
	b=C/o642bxCy98UYux+LM4sb1JUDfoyI4kpwZHEcmAv9etWFJQonIaTGwFw4pn6XL8i/tlnX
	9HnJg6ImyRilOiAQ==
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
Subject: [PATCH v8 net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Wed, 19 Jun 2024 09:17:02 +0200
Message-ID: <20240619072253.504963-12-bigeasy@linutronix.de>
In-Reply-To: <20240619072253.504963-1-bigeasy@linutronix.de>
References: <20240619072253.504963-1-bigeasy@linutronix.de>
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
2.45.2



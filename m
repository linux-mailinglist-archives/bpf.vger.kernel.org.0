Return-Path: <bpf+bounces-28534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D328BB330
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2E1F21C06
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E51598E4;
	Fri,  3 May 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frSEDg5/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIyYwDGY"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B23158D8B;
	Fri,  3 May 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761013; cv=none; b=IGGyVzpqArLeJ7wJtsAbRreuZHqP4ioh/HLPew+v6G0ASQsm8BsdavcOaQj2zYk/7OYJP5Nto+UJXhd1ThQr3lArr4iFokpcyX/6HV9VVFmj5JTDRIqgt+CbBgUdOliICVxVZMJVoPY7AzWiymalZV5Lk0zq3yl7zTdSfkqUCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761013; c=relaxed/simple;
	bh=LVVqnyIbiCKyUaRvfyLa95e+IMRUFI5GejbEI60O2Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxO88jCPoAthvv9rC1oiQ/f3s6SYN1kY9u7pVdws6G6L83/0lTwD2bK6neJcnoiq/eMs7dlJvWeotjk2pluDHeGCJAq7Cj33bTo/CLoL0cgFYKvas76lH5yVIzd2js4qVbzUoXDgSIcSnrmuC15FmvB+iu9+fDzxrZm5SOrCW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frSEDg5/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIyYwDGY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hccXJ/tMSuJL/qI6XmVbVx3Yyp9L6BDQI7DM1y19Tvc=;
	b=frSEDg5/LwZG4mYodLbulmlP7vse6VIu+qtvGfppw5wQHXI2+dXANmQqF2YLLh90DwCDEH
	yItXWq4EC8E2Z1UZ5uHHk7iVkoX1sI8QiQfXVgVJAbabJ2ULyyLW9s2eilAdQAXEsq2BjO
	AL60RWkWNxvm1hIJzx5mLJUnqysH0WEebz4pqEz6cUJMarwRC1N+SB6oecpJpBKFqB20uv
	AzlTA8PxjkGs7q33UFsD3j0jm/LOVUzMQwaanf/DwoVAUJUYD/PnY5zgX2A0AJDTHuhD9a
	oTcSa5WHVfbyRapeJuv3GD4uQaP3WIoCC77sKscKjVe+rV/jF0SNxObMHezfqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hccXJ/tMSuJL/qI6XmVbVx3Yyp9L6BDQI7DM1y19Tvc=;
	b=rIyYwDGYOcqOApqkUA/imNmArMjG8d3+vT+Qdv/NJKsa+q0JpOVsFBCOJk1CtfQ7XoNIpX
	/lEBZB6Cdj3KaeDQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Fri,  3 May 2024 20:25:15 +0200
Message-ID: <20240503182957.1042122-12-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
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
2.43.0



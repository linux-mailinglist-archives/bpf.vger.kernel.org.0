Return-Path: <bpf+bounces-32594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EB91060B
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2531B28AC6D
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA261AC420;
	Thu, 20 Jun 2024 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoLqBBdU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EdsIP3ML"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D21B14E6;
	Thu, 20 Jun 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890058; cv=none; b=EEps0fMjjFq4pmMXkyOaaWEkc+op96EnoJJHFZiJ+P6Zq9FtaBGE2oApUAET3yJSyZnY1y4O5ESTZCWhIIZEXeRppUcnLYIAewpV22/P7VkFM3Maqb+gVbcQQiYOhGMPe+WioiajFQ/Z64eHE8r4hQIENkcgHaNJunI4rvml3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890058; c=relaxed/simple;
	bh=D7MV1ZUt0ja+VOQ5jBTqWT/rFam6BZA9NpCFJ3oOycU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsPFeBJNTjyzPJmd6roJW1wAKw4rSOlsaVb9IoilTBnN8MAvIY9Ay5PdhxtR1x5gDjU/qwaiXPJtFu3gvto/11LyQ3diXv/MCwgjqE5L1vXdmRnbyEsuulbroOcCh5fEiZ0/LBche4DdWr4xLa8RV79HX09tL52uOyVW+uiHJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoLqBBdU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EdsIP3ML; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718890054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu8VD8DpLJkf2Hl3sxqZhIhEWbSf2IpwfXlNNAn3MjU=;
	b=FoLqBBdU5f4B9uTYEDnz0oq8uIBcmyUo5YX+L9SONwEsoV9oWtzDpFwBlGJKBLnHWwldF8
	YZGFyNCD48GXXP/CVNFsl/oGXTVncFOzR1vhIVX5luQkELHnSzt8BaJL9Yz30AIb+A6zzQ
	CCu0SI6/fXD2UaPVv+u8IlmyeZUwFFnFuLv6qam/Vs2uWCmgjec5IH526TQqBoZfeHMJw+
	u61uLuwdmYhMCOagkNfeMPnj9HSuA8Ek5Mt5CA9QMnKWiuWpZ6Sokx0evONPNqBzmXNjB4
	tKlrwy0PxPkVp7nIoea+3k2MLB+/ao11MpnRbUnjUei+rPGiT/rABjqQmNgCjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718890054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu8VD8DpLJkf2Hl3sxqZhIhEWbSf2IpwfXlNNAn3MjU=;
	b=EdsIP3MLTmAVQ6a3AMqd3x9KvxqabvWih23pBfOMCuBdFHFunADFLSZKfaJ9VkxcSIVfFo
	Fkt+NK5mgEs36mCw==
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
Subject: [PATCH v9 net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Thu, 20 Jun 2024 15:22:01 +0200
Message-ID: <20240620132727.660738-12-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
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



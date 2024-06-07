Return-Path: <bpf+bounces-31567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B7E8FFCA1
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 09:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9761F291A1
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFC155C9F;
	Fri,  7 Jun 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5HLJwEv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="++wmqx7Y"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985B155342;
	Fri,  7 Jun 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743878; cv=none; b=obyL9p65U4tn6xp+hT/Ma02Feqcp9N8tnadOVf2+4S4SXG3dUOzcklc3lWCjqt80RCW6s3cWK1qmSJveyJQsHqpijDkq1V9+Cdfw9YRMJ6gubIV+d37dEHC6ni87waXK03Fpi7iFHPm3Si5mwgveH+d3agATRdLqXHoMBtGj5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743878; c=relaxed/simple;
	bh=DjKGXeuA0iicBNAujBOCeL9L9FyYM7749w3HflY304w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEWp0C9JJDSrPPqtIip1ulj7FrZvUPLhFcSrxME/iUzxI2F7C5DSkpZcE6mjLXBYCTAf2DokyZTmcDhnba5yTyhbUiqTsNr54LiLZiKC4x1H8lmAVtjdAhOu6x+gbVQ0chglFFx++sY38WsOizcFfkHIRfJ5UOezCcSRB84hzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5HLJwEv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=++wmqx7Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717743875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=B5HLJwEvbdDL67cuRIMH83NhrazvRRXf+GheNgAmOm55GFKplqHb+BbUEsCBGCDzSoB6Er
	QydhiOZLFgZ3Hipkfky6VhwXvko44Hx6c+wPRT4pkn2ncJLL9ohv9N11zECApg8ASZbS0e
	b68/B+285+0wlsvcsfTMRH8kL7I5WNeyfayOAn4U1lX9/uXVOv9W5qz7Z5hEiC5EjkcQQi
	/GjqOWYbiHBXYuq0qDXhnH6laZh1kJQGmgmt9Ngc9yX103XQ7slpJn8xHyeULjMdWiRxKb
	CBLL01qb8GSsWpr+c3jCQo0SvOA7PLTLYVuE7E2iOHIqI2P8q45Jfq+jEGIJZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717743875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=++wmqx7YYOcpm43Q2FciC5wWxVvP11ecY2irqKPWzmX6ZuP6Ox+DFcX/JvxKtrmnP43oSi
	befjcvacY4waRuCw==
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
Subject: [PATCH v5 net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Fri,  7 Jun 2024 08:53:14 +0200
Message-ID: <20240607070427.1379327-12-bigeasy@linutronix.de>
In-Reply-To: <20240607070427.1379327-1-bigeasy@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
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



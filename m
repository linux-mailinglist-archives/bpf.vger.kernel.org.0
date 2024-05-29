Return-Path: <bpf+bounces-30852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45CF8D3C89
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6025A287837
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA71A2C10;
	Wed, 29 May 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdCObOG+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VE8oE+W4"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CA194C86;
	Wed, 29 May 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000181; cv=none; b=NjJn7wQe7OkVYqRK6wdye1JGMxqOfkkxVFCjAn+yfzS/Giczbu+VPDVyDSlsWkmZl3Wa5aQfpRFd9CtC/IWjfX+VjQ5MMIIG0qXQoQwoMKcOwBmD+sgPuHmFcrWs3zRYfaMGLQ0WLA2tBHLhqA3l5Rxdp6wF+FGPC3F+a4TAjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000181; c=relaxed/simple;
	bh=DjKGXeuA0iicBNAujBOCeL9L9FyYM7749w3HflY304w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxd7E0HYBtmf9H2gYM1fKDEfbBaZawhBvy+t/QP4DaHA0wVlnIQQCos5jI1lnx5VZd3EdXOXej6StHStPti0byS8bJj0+JNLoOFSjFcV3vheP4khG7WDi3mgklfGYf0UXBsGlAiLB9cABSE1GetXqD3UR1btJa7o5T3w/nKuRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdCObOG+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VE8oE+W4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=MdCObOG+J/GpwjR5rYtHkSzuz41aPalaWZJm0fU7js6GXsmPRbpXmUklx5l6mOPMFDFDDY
	4f+vJsxRV+DmTHakYeiWMC8MNjtWyJD24+VJPSvxUmUPA+9iMMhTmIZBHcH8fchS13X9w9
	mnikWbVIvpVYdR504JtlV4abVPhkMyxV15IOdz7QqREAILK7PilW+s4/sTNWq2r1FxiTF3
	9GfrYSEVqeaF8mjVR3SB8gr79MpP96YcV0jzNtcZ7R2ylEoCO8PK+VJxJYtIRSU5nTxvvh
	Dv2W6tG8PSiQ2G31lgjVtDBnFNmkTBcmIbGr9E7cJ/1xMvkaAeJcltBzhi1oEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rw/2cnJ+Iso5XuGakDzbFuKdfRtLkLToskmRVbIvD0=;
	b=VE8oE+W46TJ0618sV/A6MaCiq4c3qaPd5tApxKGvROyTXUFd5PmqpDNPnDukaYDZPQmdwm
	2DbYUyP/8Rop+bCQ==
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
Subject: [PATCH v3 net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Wed, 29 May 2024 18:02:34 +0200
Message-ID: <20240529162927.403425-12-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
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



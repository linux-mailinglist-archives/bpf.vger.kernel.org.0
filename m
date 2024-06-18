Return-Path: <bpf+bounces-32380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE090C55C
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6727AB214CE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744B158206;
	Tue, 18 Jun 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvyrSJRI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1OhpbkHE"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F626156C66;
	Tue, 18 Jun 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695540; cv=none; b=qcPtTpH24fvkosZhHFI06hTLfk+VSzJp+2QZNUl/wbY65lWzVk4PcbwOhCwxwvaLqyxkVf6k4SBIFZn/n6/AgFwjcUYh09JEgh66RMGXIRz+jiI0sitGahmzIXzvT9fvGtpr+0rxhBp29FON5sMIed/6Tlirj6z5ycTSSfVXScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695540; c=relaxed/simple;
	bh=D7MV1ZUt0ja+VOQ5jBTqWT/rFam6BZA9NpCFJ3oOycU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI0eiwNwOnlbsTujaWsGoZQnqh2zzK2yEBW8Ga0ltaP7tcFk9OX2GIFysDSGT5QWDOAsZMIeZwIIraVNd/M5BPywZ/9+9nlu7MmoSntMh4fE0T+opE37gPXoYPvDnR+hnE8oGnGnMsEKhC98T6n6cjDxzfEJq+3vIHs0Cx+v95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvyrSJRI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1OhpbkHE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718695535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu8VD8DpLJkf2Hl3sxqZhIhEWbSf2IpwfXlNNAn3MjU=;
	b=IvyrSJRIlUpVCen8OpwVwFqcWGTiqySuV/xg6iNITzYkwN6yr++XYZsVGD4BnodeIFgTTZ
	/gxn0T0wgX0ZHUtr3UaqeXHZdjrz/PWj5txIXRIYMwdrqFgBlbQf5RH/5Xk6GJDxzmytix
	zmi+I+RZ91c1xXbzrxCu7uuM6tYJllYbOYrdvGik7Ci/bl8JEpjgfdElECrhoU+JV8tO+8
	JsY7fs0Qr1rcjp4bs7BSINs9uNmYtQUo86UmZZVn2YiJTdGF1uBUdCjirbxdgvN5KZY61O
	DQjMvPwyyH4cye5MXh/MuwD12xd/uZBV2vgfK6vFR2/7yWckNlOn7jerFhviNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718695535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu8VD8DpLJkf2Hl3sxqZhIhEWbSf2IpwfXlNNAn3MjU=;
	b=1OhpbkHEXvZZNPXzEUVAZOmSLzeMVXoyTA8SqGHJYZqYyOq7XDSovl6kyax3bPgxGfj6z8
	VXM1VMI0MWgIgECA==
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
Subject: [PATCH v7 net-next 11/15] lwt: Don't disable migration prio invoking BPF.
Date: Tue, 18 Jun 2024 09:13:27 +0200
Message-ID: <20240618072526.379909-12-bigeasy@linutronix.de>
In-Reply-To: <20240618072526.379909-1-bigeasy@linutronix.de>
References: <20240618072526.379909-1-bigeasy@linutronix.de>
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



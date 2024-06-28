Return-Path: <bpf+bounces-33357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA0991BCA3
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 12:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E822EB22E3E
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09A515575D;
	Fri, 28 Jun 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J2hIUufw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04UafvJF"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6445BF0;
	Fri, 28 Jun 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570628; cv=none; b=mDvtGNJEHc33q9ay8UU56k6I7ZBnOV4NmQZLtXYyWzhgOoMY2Bkdn1R/yYLld52m6K8FVEEn4yd/GoR6zO6Jdwiy+uh+DfOdx+s1effSa2Sk//xGmGvheFHqoUqNTUTw019W/WqDloxDewaqzRtxTMpX1wyTbceX9td8tyu4b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570628; c=relaxed/simple;
	bh=Nd7lj5zpLp5Wm/BQfhEA1JONaGhGAlaVvionw6tkjtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3SjXjQtrthDXcE1opbr2uU7BHoEKmQi4uafx/IzaHRThqs4mmy5SyUiWHspUo1tfh9uo80crTC2OoNnxGa6SOhFkkdUEn/OCUyTqhqdRd92hu+vEapQ3o9e76IMvzwVbLtPpxPzIHY5BMS5wssBA4bHPmXpjyjvAIgCOjJMY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2hIUufw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04UafvJF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719570625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zC0TaukZg9Fg/V9logHHo1S0xjzvEiaQMKuvkY0M30k=;
	b=J2hIUufwNWIFCrSLodZCleefJ1tNhuhj7gG0Y7GDsitfIUz0fZxBq0ljTI3ykBl9U3qdYV
	4GJkJrUrkZPOEy663+6DXFWe56/W+v8TsNQZL4JuaYGkpO/7bc0mAnksThuDgBraNAT2YT
	Fy5hXbF6Jt3DMCISs/UfP9sf5wzLSanMnpzqK4Xwbilc8yh5w2E0hutsR1riUasuzaKd0g
	zyC4Q9MPUexbhTnquqtUpnG1GHNLJ94T3WsV97WB09/FFUsiEAbyTohzGZayGj5WCu/yj+
	Ab6x81kyDWjKOahGXVXHUNR59OJvVbkZYGxBFyv+L4+MY54LgalPQSNIjITVRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719570625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zC0TaukZg9Fg/V9logHHo1S0xjzvEiaQMKuvkY0M30k=;
	b=04UafvJFO1Gb/tbDVKJS3d/HTs8XO7DF1eMgRIArj84ErTpt6DrQCr/2pO14jVcCcSwwA0
	XkfqCaZxLYIELBCw==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 1/3] net: Remove task_struct::bpf_net_context init on fork.
Date: Fri, 28 Jun 2024 12:18:54 +0200
Message-ID: <20240628103020.1766241-2-bigeasy@linutronix.de>
In-Reply-To: <20240628103020.1766241-1-bigeasy@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

There is no clone() invocation within a bpf_net_ctx_=E2=80=A6() block. Ther=
efore
the task_struct::bpf_net_context has always to be NULL and an explicit
initialisation is not required.

Remove the NULL assignment in the clone() path.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f314bdd7e6108..99076dbe27d83 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2355,7 +2355,6 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx =3D NULL;
 #endif
-	p->bpf_net_context =3D  NULL;
=20
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval =3D sched_fork(clone_flags, p);
--=20
2.45.2



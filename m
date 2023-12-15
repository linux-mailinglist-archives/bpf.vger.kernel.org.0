Return-Path: <bpf+bounces-18025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661A814E46
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318FD285BF8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B86D1AA;
	Fri, 15 Dec 2023 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nh4vzk05";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="roNUcQ3I"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB5675AE;
	Fri, 15 Dec 2023 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5e+RJtEB4QE08KKZsUA35+KJH98yIUgL+9mMUjgvNI=;
	b=Nh4vzk05UBCwB1CUj6f51oueaIgsBsTvxOYK6NKH13SE2KYU3x9v2KYq+qnd5EZlhngWC3
	hB3ML3BTRAZimojQ1/fb25dF0EGX8LUpT/em9vtvhSVqxRBOu5IAs1SJyeF+QZn85OnF11
	6ap33KhbA2zAvHg1Xw09C1AUhqYipAMAMG/alXrSoAEcktiilnf2pR1YPjbCKpvM+Ojwhj
	A2CmjrudLB7y6yWijv3IcZbou/XqxD0mvUko35t5+kkPByLJfiTPbSIypDNNQNsmdXPgcz
	BJshvpSMzQxVuuYhPIgA5mcZIeZWhVYflCDmIZ+ai/Twf087vm4EyL2bpqz6QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5e+RJtEB4QE08KKZsUA35+KJH98yIUgL+9mMUjgvNI=;
	b=roNUcQ3IAN0GribgixBXQrhWf69moqnLZoY35pCy6QQ57aBDHST2l5JfA+eIb9BvgWuar5
	bTAHF6rvXFZU6oBA==
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
	Alexei Starovoitov <ast@kernel.org>,
	Geetha sowjanya <gakula@marvell.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Russell King <linux@armlinux.org.uk>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	hariprasad <hkelam@marvell.com>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 21/24] net: marvell: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:40 +0100
Message-ID: <20231215171020.687342-22-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The per-CPU variables used during bpf_prog_run_xdp() invocation and
later during xdp_do_redirect() rely on disabled BH for their protection.
Without locking in local_bh_disable() on PREEMPT_RT these data structure
require explicit locking.

This is a follow-up on the previous change which introduced
bpf_run_lock.redirect_lock and uses it now within drivers.

The simple way is to acquire the lock before bpf_prog_run_xdp() is
invoked and hold it until the end of function.
This does not always work because some drivers (cpsw, atlantic) invoke
xdp_do_flush() in the same context.
Acquiring the lock in bpf_prog_run_xdp() and dropping in
xdp_do_redirect() (without touching drivers) does not work because not
all driver, which use bpf_prog_run_xdp(), do support XDP_REDIRECT (and
invoke xdp_do_redirect()).

Ideally the minimal locking scope would be bpf_prog_run_xdp() +
xdp_do_redirect() and everything else (error recovery, DMA unmapping,
free/ alloc of memory, =E2=80=A6) would happen outside of the locked sectio=
n.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: hariprasad <hkelam@marvell.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/marvell/mvneta.c                  | 2 ++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index 29aac327574d6..9c7aacd73b590 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2263,6 +2263,8 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_=
rx_queue *rxq,
=20
 	len =3D xdp->data_end - xdp->data_hard_start - pp->rx_offset_correction;
 	data_len =3D xdp->data_end - xdp->data;
+
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
=20
 	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 93137606869e2..3a5524ffaba68 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3793,6 +3793,7 @@ mvpp2_run_xdp(struct mvpp2_port *port, struct bpf_pro=
g *prog,
 	u32 ret, act;
=20
 	len =3D xdp->data_end - xdp->data_hard_start - MVPP2_SKB_HEADROOM;
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
=20
 	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 4d519ea833b2c..e48e84d6159bc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1422,6 +1422,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic =
*pfvf,
 	xdp_prepare_buff(&xdp, hard_start, data - hard_start,
 			 cqe->sg.seg_size, false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, &xdp);
=20
 	switch (act) {
--=20
2.43.0



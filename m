Return-Path: <bpf+bounces-18026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E4814E4C
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BAB2857D4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC26E2AA;
	Fri, 15 Dec 2023 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUResC8P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FII+fmLC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5F6A009;
	Fri, 15 Dec 2023 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Recusd+7IXvA5TirXIVteFQz/CPKIdbiblHLxPiaZxI=;
	b=aUResC8P3BrfQM2X1JaMPOmerJ/fL+xFTgQ0h+PlYjy/+qzzA8IU4zA12Gt2DftI4dwg90
	vDVGZp90lgsRPLWIJaLqvlEIAu3kxfLymGyseqWwuXB9632aXbrkR38hpACqjJj1/riXUX
	0A/iuTlDhmkjhXwe1/7n280Ofy2fi2ViRE/SW5jv94TBqf6cioyCWs5oOhSTXAtqekLn/b
	bTWJbtbdM79zG5ankAAQEbXwm0xwcIXGQ/y6S8d8nP3PKyPNn0u2aoQVKwjPX3nep3lcjd
	dwFzEnrDiJye3KkRP9dGlHYEWCA71AVfUu/NFmTSzaFF4Y417CqofwsVhqnbXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Recusd+7IXvA5TirXIVteFQz/CPKIdbiblHLxPiaZxI=;
	b=FII+fmLCYFU6/PJPm9PIVesU9ltySEE2RUfVan+2Gga/GlGuHcVIKzoQbPaWAZ6rho2K+9
	cvS7J2jl2aks+ACw==
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Ariel Elior <aelior@marvell.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	bpf@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 23/24] net: qlogic, socionext, stmmac, cpsw: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:42 +0100
Message-ID: <20231215171020.687342-24-bigeasy@linutronix.de>
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

Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Ariel Elior <aelior@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: Manish Chopra <manishc@marvell.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bpf@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c        |  1 +
 drivers/net/ethernet/socionext/netsec.c           |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  1 +
 drivers/net/ethernet/ti/cpsw_priv.c               | 15 +++++++++------
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ether=
net/qlogic/qede/qede_fp.c
index cb1746bc0e0c5..ce5af094fb817 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1091,6 +1091,7 @@ static bool qede_rx_xdp(struct qede_dev *edev,
 	xdp_prepare_buff(&xdp, page_address(bd->data), *data_offset,
 			 *len, false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, &xdp);
=20
 	/* Recalculate, as XDP might have changed the headers */
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet=
/socionext/netsec.c
index 0891e9e49ecb5..47e314338f3f3 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -905,6 +905,7 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, str=
uct bpf_prog *prog,
 	int err;
 	u32 act;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
=20
 	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 37e64283f9107..9e92affc8c22c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4893,6 +4893,7 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *=
priv,
 	u32 act;
 	int res;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/=
cpsw_priv.c
index 764ed298b5708..f38c49f9fab35 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1335,9 +1335,15 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, str=
uct xdp_buff *xdp,
 	if (!prog)
 		return CPSW_XDP_PASS;
=20
-	act =3D bpf_prog_run_xdp(prog, xdp);
-	/* XDP prog might have changed packet data and boundaries */
-	*len =3D xdp->data_end - xdp->data;
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
+		act =3D bpf_prog_run_xdp(prog, xdp);
+		/* XDP prog might have changed packet data and boundaries */
+		*len =3D xdp->data_end - xdp->data;
+		if (act =3D=3D XDP_REDIRECT) {
+			if (xdp_do_redirect(ndev, xdp, prog))
+				goto drop;
+		}
+	}
=20
 	switch (act) {
 	case XDP_PASS:
@@ -1352,9 +1358,6 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, stru=
ct xdp_buff *xdp,
 			xdp_return_frame_rx_napi(xdpf);
 		break;
 	case XDP_REDIRECT:
-		if (xdp_do_redirect(ndev, xdp, prog))
-			goto drop;
-
 		/*  Have to flush here, per packet, instead of doing it in bulk
 		 *  at the end of the napi handler. The RX devices on this
 		 *  particular hardware is sharing a common queue, so the
--=20
2.43.0



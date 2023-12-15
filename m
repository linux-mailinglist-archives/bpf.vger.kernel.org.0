Return-Path: <bpf+bounces-18021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF5814E37
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B5B1C2399D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39B6A026;
	Fri, 15 Dec 2023 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBbpW7sF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kx2HJ8gu"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086D56381;
	Fri, 15 Dec 2023 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7c3Sac8dmyVQ4hqle9rQ/Ik/z8HPOaNJezqWJL8Lx4=;
	b=EBbpW7sFFbB1fi7zZJOMAUqG0fNWpdhwl+36f6JGSng5DX9KJ7mc98Fyk438SZJrVm4iUZ
	E+SHLTy48qAfEBKBD1d9wXOsK8FbeZGL2mbWbt6SdXjnxo2n691PJM1JgDNyR/jJbP+cq+
	YSDqoeMtMqK07aMmirlvGm+ltUZdcDVte8qc0vM6fZlFkXvCyTdEWMA5Vm4bit+yg0OSbc
	Np9oF9XObiwHU0wKk6QMUBgINODSjQiQcLH/5NLDf9MccsV3WqkfDY65FNxafa5nczHAR2
	5IH2apHHbikJJ8gIPoCcQlDFV8KsJeq+AZ1wJ3FKwH1cLLO+nT6TrUikc7nbfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7c3Sac8dmyVQ4hqle9rQ/Ik/z8HPOaNJezqWJL8Lx4=;
	b=Kx2HJ8guXixJQvIThAGi9sONmjTWLdYavjuJOXtz876lDz/n34peXGd9z+zsaDJwBf/tv4
	Uvg8tcNSC4J+MYCA==
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
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 18/24] net: Freescale: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:37 +0100
Message-ID: <20231215171020.687342-19-bigeasy@linutronix.de>
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
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-xsk.c  | 30 ++++++++++---------
 drivers/net/ethernet/freescale/enetc/enetc.c  |  1 +
 drivers/net/ethernet/freescale/fec_main.c     |  1 +
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/e=
thernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6c..8adc766282fde 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2597,6 +2597,7 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struc=
t qm_fd *fd, void *vaddr,
 	}
 #endif
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	xdp_act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 	/* Update the length and the offset of the FD */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net=
/ethernet/freescale/dpaa2/dpaa2-eth.c
index 888509cf1f210..08be35a3e3de7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -442,6 +442,7 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *pri=
v,
 	xdp_prepare_buff(&xdp, vaddr + offset, XDP_PACKET_HEADROOM,
 			 dpaa2_fd_get_len(fd), false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	xdp_act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 	/* xdp.data pointer may have changed */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c b/drivers/net=
/ethernet/freescale/dpaa2/dpaa2-xsk.c
index 051748b997f3f..e3ae9de6b0a34 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
@@ -56,23 +56,25 @@ static u32 dpaa2_xsk_run_xdp(struct dpaa2_eth_priv *pri=
v,
 	xdp_buff->rxq =3D &ch->xdp_rxq;
=20
 	xsk_buff_dma_sync_for_cpu(xdp_buff, ch->xsk_pool);
-	xdp_act =3D bpf_prog_run_xdp(xdp_prog, xdp_buff);
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
+		xdp_act =3D bpf_prog_run_xdp(xdp_prog, xdp_buff);
=20
-	/* xdp.data pointer may have changed */
-	dpaa2_fd_set_offset(fd, xdp_buff->data - vaddr);
-	dpaa2_fd_set_len(fd, xdp_buff->data_end - xdp_buff->data);
+		/* xdp.data pointer may have changed */
+		dpaa2_fd_set_offset(fd, xdp_buff->data - vaddr);
+		dpaa2_fd_set_len(fd, xdp_buff->data_end - xdp_buff->data);
=20
-	if (likely(xdp_act =3D=3D XDP_REDIRECT)) {
-		err =3D xdp_do_redirect(priv->net_dev, xdp_buff, xdp_prog);
-		if (unlikely(err)) {
-			ch->stats.xdp_drop++;
-			dpaa2_eth_recycle_buf(priv, ch, addr);
-		} else {
-			ch->buf_count--;
-			ch->stats.xdp_redirect++;
+		if (likely(xdp_act =3D=3D XDP_REDIRECT)) {
+			err =3D xdp_do_redirect(priv->net_dev, xdp_buff, xdp_prog);
+			if (unlikely(err)) {
+				ch->stats.xdp_drop++;
+				dpaa2_eth_recycle_buf(priv, ch, addr);
+			} else {
+				ch->buf_count--;
+				ch->stats.xdp_redirect++;
+			}
+
+			goto xdp_redir;
 		}
-
-		goto xdp_redir;
 	}
=20
 	switch (xdp_act) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/eth=
ernet/freescale/enetc/enetc.c
index cffbf27c4656b..d516b28815af4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1578,6 +1578,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *=
rx_ring,
 			rx_byte_cnt +=3D VLAN_HLEN;
 		rx_byte_cnt +=3D xdp_get_buff_len(&xdp_buff);
=20
+		guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 		xdp_act =3D bpf_prog_run_xdp(prog, &xdp_buff);
=20
 		switch (xdp_act) {
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index c3b7694a74851..335b1e307d468 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1587,6 +1587,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct=
 bpf_prog *prog,
 	int err;
 	u32 act;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
=20
 	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
--=20
2.43.0



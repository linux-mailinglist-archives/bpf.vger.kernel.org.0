Return-Path: <bpf+bounces-18023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5A814E3F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA501C24042
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCBB6ABB5;
	Fri, 15 Dec 2023 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JtWcWrlR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NzCo4hAy"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1B59E59;
	Fri, 15 Dec 2023 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zae3m1cO9fSJoSwUDjCnhvMwaD0Cp7wkXYtacLoccYI=;
	b=JtWcWrlRr/Yw4kQ1UWySiE1WnFklIBcg9wCnilSSfcJDNnaXHknsfFQ2hm3Wg/ONikWDB+
	WRxCE/Tc1oj8/5Vra+uDd80anJKj5JKArhylRiQWeqOiu9dGS2spg5Z1FiJFb7PYir9ZLl
	YgPOBKKzrgsCa96PnNswic05kIQ/rUSbCdeqFC5thljdEb55zV5ywwfj1sceBkMTCRU0p4
	y7xHwZ+cy0+IUt7MuLeHRIi5cN42VqdLlD8SLMT0QybC5HYV7wrPuUzJG43qDI9Xt9mesD
	1NDCCGSXDR+g3yntLA8aFfivSR8gLveMOz0FQOgX4TMdKDdRnyy3zgJi+xJuvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zae3m1cO9fSJoSwUDjCnhvMwaD0Cp7wkXYtacLoccYI=;
	b=NzCo4hAyNx+4VtNSo05p7oXiKzL7azy7XiXo4Ljk4IPRdRDvvQB9bLy3+o8Xz+b/cRIMks
	tfLo+tJk/hEPGUCQ==
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
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Alexei Starovoitov <ast@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dexuan Cui <decui@microsoft.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Felix Fietkau <nbd@nbd.name>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Crispin <john@phrozen.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shailend Chand <shailend@google.com>,
	UNGLinuxDriver@microchip.com,
	Wei Liu <wei.liu@kernel.org>,
	bpf@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 19/24] net: fungible, gve, mtk, microchip, mana: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:38 +0100
Message-ID: <20231215171020.687342-20-bigeasy@linutronix.de>
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

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Dimitris Michailidis <dmichail@fungible.com>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jeroen de Borst <jeroendb@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Crispin <john@phrozen.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Mark Lee <Mark-MC.Lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Shailend Chand <shailend@google.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Wei Liu <wei.liu@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/fungible/funeth/funeth_rx.c     |  1 +
 drivers/net/ethernet/google/gve/gve_rx.c             | 12 +++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c          |  1 +
 drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c |  1 +
 drivers/net/ethernet/microsoft/mana/mana_bpf.c       |  1 +
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funeth/funeth_rx.c b/drivers/net=
/ethernet/fungible/funeth/funeth_rx.c
index 7e2584895de39..e7b1382545908 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_rx.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_rx.c
@@ -152,6 +152,7 @@ static void *fun_run_xdp(struct funeth_rxq *q, skb_frag=
_t *frags, void *buf_va,
 	xdp_prepare_buff(&xdp, buf_va, FUN_XDP_HEADROOM, skb_frag_size(frags) -
 			 (FUN_RX_TAILROOM + FUN_XDP_HEADROOM), false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	xdp_prog =3D READ_ONCE(q->xdp_prog);
 	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/etherne=
t/google/gve/gve_rx.c
index 73655347902d2..504c8ef761a33 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -779,11 +779,13 @@ static void gve_rx(struct gve_rx_ring *rx, netdev_fea=
tures_t feat,
 				 page_info->page_offset, GVE_RX_PAD,
 				 len, false);
 		old_data =3D xdp.data;
-		xdp_act =3D bpf_prog_run_xdp(xprog, &xdp);
-		if (xdp_act !=3D XDP_PASS) {
-			gve_xdp_done(priv, rx, &xdp, xprog, xdp_act);
-			ctx->total_size +=3D frag_size;
-			goto finish_ok_pkt;
+		scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
+			xdp_act =3D bpf_prog_run_xdp(xprog, &xdp);
+			if (xdp_act !=3D XDP_PASS) {
+				gve_xdp_done(priv, rx, &xdp, xprog, xdp_act);
+				ctx->total_size +=3D frag_size;
+				goto finish_ok_pkt;
+			}
 		}
=20
 		page_info->pad +=3D xdp.data - old_data;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index 3cf6589cfdacf..477a74ee18c0a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1946,6 +1946,7 @@ static u32 mtk_xdp_run(struct mtk_eth *eth, struct mt=
k_rx_ring *ring,
 	if (!prog)
 		goto out;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers=
/net/ethernet/microchip/lan966x/lan966x_xdp.c
index 9ee61db8690b4..026311af07f9e 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
@@ -84,6 +84,7 @@ int lan966x_xdp_run(struct lan966x_port *port, struct pag=
e *page, u32 data_len)
 	xdp_prepare_buff(&xdp, page_address(page),
 			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
 			 data_len - IFH_LEN_BYTES, false);
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/e=
thernet/microsoft/mana/mana_bpf.c
index 23b1521c0df96..d465b1dd9fca0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -93,6 +93,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq=
 *rxq,
 	xdp_init_buff(xdp, PAGE_SIZE, &rxq->xdp_rxq);
 	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
=20
 	rx_stats =3D &rxq->stats;
--=20
2.43.0



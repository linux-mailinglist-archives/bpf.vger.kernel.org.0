Return-Path: <bpf+bounces-33359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0A991BCA7
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8851C20920
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D328156644;
	Fri, 28 Jun 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xaF4QCfx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJhhgPT6"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC015443D;
	Fri, 28 Jun 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570629; cv=none; b=ix8cZqOs9mdJSfcGQcoYY84nPJu0k8CL83oUpioo3dqaYOg15Z59f9hMtJGaQvopqt8RJha33Q7ra3305oScyf9sdmoqECsuyv0u4Yv7T3KcXrv2fuvdM4LrEzB2psqhcYfAfzp7JHBiQwViUyn814pyxp5bLuMBuuy2GI2Kcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570629; c=relaxed/simple;
	bh=2ORN60EApRJBy45tT+PirMZVIYjsUkUikSJ513Tgnrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBkoPrVAkqnoaMig0+8pHN3b0Ue4fgYuHKOZjQS4Bl1+BAkleLbzxPIXafNwusa7p0UXt+LeiemEfbcO82vpFXTzkfl/uf2GOQcMnnVKJ8AkCxF0FP6Ws6CUxl5XxWV/TNLL9NTeDOCQe+k/vqVyTAYhzK/TqpTioU9qcPGdyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xaF4QCfx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJhhgPT6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719570626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMfpWOUIyyihkiEssQDFaZGxRJihfI6kO1l2dxoQQOY=;
	b=xaF4QCfxYDqyVAYwIm4S7Yl03lSVpt0k2QZWRBo+0/Szhqp/5UreeoP8z7V9MV45yiQhSr
	xozvRyKQRlaeJNF0V3C7xjFCGg/TH4RJUPdL8OwFtL2xEYplyO37leIju79J0wljpm8oAy
	B9k5dSDFulFOEcmJw1dQRfEIZTIFTecTqGYmtx+uWz1I+gKUINPJEZ3BV0ljr+Vn44vNYS
	RpOV05EFqa32OzzsHby5uUJBAkpOXrt7lDJbuBw3ca65f5YCW/VddfixcPMjiiDgMto/KP
	ww6mLnH036PI9yFCL7pr4BJoSIeWt3ssvzqb7mR0jaS/urRIIqG0O49wcZeqWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719570626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMfpWOUIyyihkiEssQDFaZGxRJihfI6kO1l2dxoQQOY=;
	b=bJhhgPT6TB6NK8WogcC1KjX2hxaVqMWN04vaLHaPwcpj+zI/asPWh+AbX/ggUq2SifvTtf
	6YjY5+0OOZmS8ZBg==
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
Subject: [PATCH net-next 3/3] net: Move flush list retrieval to where it is used.
Date: Fri, 28 Jun 2024 12:18:56 +0200
Message-ID: <20240628103020.1766241-4-bigeasy@linutronix.de>
In-Reply-To: <20240628103020.1766241-1-bigeasy@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bpf_net_ctx_get_.*_flush_list() are used at the top of the function.
This means the variable is always assigned even if unused. By moving the
function to where it is used, it is possible to delay the initialisation
until it is unavoidable.
Not sure how much this gains in reality but by looking at bq_enqueue()
(in devmap.c) gcc pushes one register less to the stack. \o/.

 Move flush list retrieval to where it is used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/cpumap.c | 6 ++++--
 kernel/bpf/devmap.c | 3 ++-
 net/xdp/xsk.c       | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 4acf90cd79eb4..fbdf5a1aabfe4 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -707,7 +707,6 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *x=
dpf)
 {
-	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq =3D this_cpu_ptr(rcpu->bulkq);
=20
 	if (unlikely(bq->count =3D=3D CPU_MAP_BULK_SIZE))
@@ -724,8 +723,11 @@ static void bq_enqueue(struct bpf_cpu_map_entry *rcpu,=
 struct xdp_frame *xdpf)
 	 */
 	bq->q[bq->count++] =3D xdpf;
=20
-	if (!bq->flush_node.prev)
+	if (!bq->flush_node.prev) {
+		struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
+
 		list_add(&bq->flush_node, flush_list);
+	}
 }
=20
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9ca47eaacdd5e..b18d4a14a0a70 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -448,7 +448,6 @@ static void *__dev_map_lookup_elem(struct bpf_map *map,=
 u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq =3D this_cpu_ptr(dev->xdp_bulkq);
=20
 	if (unlikely(bq->count =3D=3D DEV_MAP_BULK_SIZE))
@@ -462,6 +461,8 @@ static void bq_enqueue(struct net_device *dev, struct x=
dp_frame *xdpf,
 	 * are only ever modified together.
 	 */
 	if (!bq->dev_rx) {
+		struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
+
 		bq->dev_rx =3D dev_rx;
 		bq->xdp_prog =3D xdp_prog;
 		list_add(&bq->flush_node, flush_list);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index de9c0322bc294..7e16336044b2d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -370,15 +370,17 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_bu=
ff *xdp)
=20
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	int err;
=20
 	err =3D xsk_rcv(xs, xdp);
 	if (err)
 		return err;
=20
-	if (!xs->flush_node.prev)
+	if (!xs->flush_node.prev) {
+		struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
+
 		list_add(&xs->flush_node, flush_list);
+	}
=20
 	return 0;
 }
--=20
2.45.2



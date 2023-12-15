Return-Path: <bpf+bounces-18028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B812D814E50
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1B51C240A6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3BA6E598;
	Fri, 15 Dec 2023 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYv7u/T4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lf1fVdIK"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581A68EA5;
	Fri, 15 Dec 2023 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BAPa61nrUkvF9kin2QlytisOZ8fHoxcWneIX+0cXsk=;
	b=TYv7u/T4NUdVyr2Zgb8Yhqj2raw2Fd69uqS3OekrLnSTm+ac88enFS+j3yRgRUIfgED46N
	MqEWqW1ql/22EbvsSQMma9oZWOpk3zL46jcOsnY1Zi4OpqqHtZxNOCjnQVCneb0kOvZJWl
	kv5OZ+NXxjQtTphUKIfvGfMXRsklQ1839OFgDyetf4foAsjLHyfWPVgqQCteQeO3KEkwVG
	0MtXUNhB2w3kqH8FUvycRlikaVobLDW15Ev3xJDyBgncu8+WSwv4IGvmGhUcBA1LwaXKWR
	XDDRxC68yYYTneuQgD72rYifAGKX2eBuFhKf63YtwCYbfOM6Zp5YqmN8CdP8Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BAPa61nrUkvF9kin2QlytisOZ8fHoxcWneIX+0cXsk=;
	b=lf1fVdIK+nJARYZChG8KwxA0xcBHX3Z/QPi8BIqVM2uTB4jFpq4H/uMpDzoDB9LTVW7JRP
	9x9KbsNjnlGsjZDg==
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
	Edward Cree <ecree.xilinx@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	bpf@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 22/24] net: mellanox, nfp, sfc: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:41 +0100
Message-ID: <20231215171020.687342-23-bigeasy@linutronix.de>
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
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>
Cc: Martin Habets <habetsm.xilinx@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: bpf@vger.kernel.org
Cc: linux-net-drivers@amd.com
Cc: linux-rdma@vger.kernel.org
Cc: oss-drivers@corigine.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c       | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 1 +
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c     | 3 ++-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c    | 1 +
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c     | 3 ++-
 drivers/net/ethernet/sfc/rx.c                    | 1 +
 drivers/net/ethernet/sfc/siena/rx.c              | 1 +
 7 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ether=
net/mellanox/mlx4/en_rx.c
index a09b6e05337d9..c0a3ac3405bc5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -833,6 +833,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struc=
t mlx4_en_cq *cq, int bud
 			mxbuf.ring =3D ring;
 			mxbuf.dev =3D dev;
=20
+			guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 			act =3D bpf_prog_run_xdp(xdp_prog, &mxbuf.xdp);
=20
 			length =3D mxbuf.xdp.data_end - mxbuf.xdp.data;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net=
/ethernet/mellanox/mlx5/core/en/xdp.c
index 7decc81ed33a9..b4e3c6a5a6da6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -269,6 +269,7 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq,
 	u32 act;
 	int err;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/eth=
ernet/netronome/nfp/nfd3/dp.c
index 17381bfc15d72..a041b55514aa3 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
@@ -1011,7 +1011,8 @@ static int nfp_nfd3_rx(struct nfp_net_rx_ring *rx_rin=
g, int budget)
 					 pkt_off - NFP_NET_RX_BUF_HEADROOM,
 					 pkt_len, true);
=20
-			act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
+			scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock)
+				act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 			pkt_len =3D xdp.data_end - xdp.data;
 			pkt_off +=3D xdp.data - orig_data;
diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c b/drivers/net/et=
hernet/netronome/nfp/nfd3/xsk.c
index 45be6954d5aae..38f2d4c2b5b7c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
@@ -216,6 +216,7 @@ nfp_nfd3_xsk_rx(struct nfp_net_rx_ring *rx_ring, int bu=
dget,
 			}
 		}
=20
+		guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 		act =3D bpf_prog_run_xdp(xdp_prog, xrxbuf->xdp);
=20
 		pkt_len =3D xrxbuf->xdp->data_end - xrxbuf->xdp->data;
diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/eth=
ernet/netronome/nfp/nfdk/dp.c
index 8d78c6faefa8a..af0a36c4fb018 100644
--- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
@@ -1130,7 +1130,8 @@ static int nfp_nfdk_rx(struct nfp_net_rx_ring *rx_rin=
g, int budget)
 					 pkt_off - NFP_NET_RX_BUF_HEADROOM,
 					 pkt_len, true);
=20
-			act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
+			scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock)
+				act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 			pkt_len =3D xdp.data_end - xdp.data;
 			pkt_off +=3D xdp.data - orig_data;
diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index f77a2d3ef37ec..3712d29150af5 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -291,6 +291,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_=
channel *channel,
 	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
 			 rx_buf->len, false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	xdp_act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 	offset =3D (u8 *)xdp.data - *ehp;
diff --git a/drivers/net/ethernet/sfc/siena/rx.c b/drivers/net/ethernet/sfc=
/siena/rx.c
index 98d3c0743c0f5..6bfc4cd1c83e0 100644
--- a/drivers/net/ethernet/sfc/siena/rx.c
+++ b/drivers/net/ethernet/sfc/siena/rx.c
@@ -291,6 +291,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_=
channel *channel,
 	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
 			 rx_buf->len, false);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	xdp_act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 	offset =3D (u8 *)xdp.data - *ehp;
--=20
2.43.0



Return-Path: <bpf+bounces-18024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD33814E40
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECE21C23F87
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F06BB2A;
	Fri, 15 Dec 2023 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2frKVfBu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDtMmiv9"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1261FD1;
	Fri, 15 Dec 2023 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJvqfL6kfGkcyInYfR34Y5EU2FsYBJr4oMNF68chbko=;
	b=2frKVfBuTxNCn/YOdDqPDYZ2sctcTtOlZNN7VRsSx5KBQpwgvXQwFEfPLw6meL5XGoMXyu
	odJ2LoMSj808d8L7BQNEdFJ8NhzX5yli372pUzzryRbWBt4dSR30SMD+us3HkuOsZNtGVl
	7SRpX7+5b88RAWlQlXDnwKuY/Zj0drS4EEoNxIUi7s2x65k0c4nlfqbXq5mDT7SzgIUWEe
	NrokjDvzRvF7PWAG18JNo/ICJZZUWcxpaAbRvrHklPDCkiwtsK3iSqWaTibdYV0L28kr2Q
	xO7eKDxi7kmQetOaekHkCvzw5cICCTFsegmZRKB+5Q8GsqSAUsK/VJpQkBpBSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJvqfL6kfGkcyInYfR34Y5EU2FsYBJr4oMNF68chbko=;
	b=XDtMmiv9Gk7YQYNN+15d696JweHCRkGPHH6mhMrQi75BId2aTtnMH7bXiiai8t3OnICdC7
	mpD1I/ZZkX+/hzDQ==
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 20/24] net: intel: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:39 +0100
Message-ID: <20231215171020.687342-21-bigeasy@linutronix.de>
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
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: bpf@vger.kernel.org (open list:XDP
Cc: intel-wired-lan@lists.osuosl.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 22 +++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 21 ++++++++--------
 drivers/net/ethernet/intel/igb/igb_main.c     |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c     |  5 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 24 ++++++++++---------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  3 ++-
 9 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_txrx.c
index dd410b15000f7..76e069ae2183a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2326,6 +2326,7 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, st=
ruct xdp_buff *xdp, struct
=20
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ether=
net/intel/i40e/i40e_xsk.c
index e99fa854d17f1..2b0c0c1f3ddc8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -201,17 +201,19 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring,=
 struct xdp_buff *xdp,
 	struct i40e_ring *xdp_ring;
 	u32 act;
=20
-	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
+		act =3D bpf_prog_run_xdp(xdp_prog, xdp);
=20
-	if (likely(act =3D=3D XDP_REDIRECT)) {
-		err =3D xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		if (!err)
-			return I40E_XDP_REDIR;
-		if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err =3D=3D -ENOBUFS)
-			result =3D I40E_XDP_EXIT;
-		else
-			result =3D I40E_XDP_CONSUMED;
-		goto out_failure;
+		if (likely(act =3D=3D XDP_REDIRECT)) {
+			err =3D xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+			if (!err)
+				return I40E_XDP_REDIR;
+			if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err =3D=3D -ENOBUFS)
+				result =3D I40E_XDP_EXIT;
+			else
+				result =3D I40E_XDP_CONSUMED;
+			goto out_failure;
+		}
 	}
=20
 	switch (act) {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethern=
et/intel/ice/ice_txrx.c
index 9e97ea8630686..5d4cfa3455b37 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -571,6 +571,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buf=
f *xdp,
 	if (!xdp_prog)
 		goto exit;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/etherne=
t/intel/ice/ice_xsk.c
index 99954508184f9..02f89c22d19e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -762,17 +762,18 @@ ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xd=
p_buff *xdp,
 	int err, result =3D ICE_XDP_PASS;
 	u32 act;
=20
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
 	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
-
-	if (likely(act =3D=3D XDP_REDIRECT)) {
-		err =3D xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		if (!err)
-			return ICE_XDP_REDIR;
-		if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err =3D=3D -ENOBUFS)
-			result =3D ICE_XDP_EXIT;
-		else
-			result =3D ICE_XDP_CONSUMED;
-		goto out_failure;
+		if (likely(act =3D=3D XDP_REDIRECT)) {
+			err =3D xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+			if (!err)
+				return ICE_XDP_REDIR;
+			if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err =3D=3D -ENOBUFS)
+				result =3D ICE_XDP_EXIT;
+			else
+				result =3D ICE_XDP_CONSUMED;
+			goto out_failure;
+		}
 	}
=20
 	switch (act) {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index b2295caa2f0ab..e01be809d030e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8621,6 +8621,7 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter=
 *adapter,
=20
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index e9bb403bbacf9..8321419b3a307 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2485,7 +2485,10 @@ static int __igc_xdp_run_prog(struct igc_adapter *ad=
apter,
 			      struct bpf_prog *prog,
 			      struct xdp_buff *xdp)
 {
-	u32 act =3D bpf_prog_run_xdp(prog, xdp);
+	u32 act;
+
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
+	act =3D bpf_prog_run_xdp(prog, xdp);
=20
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index 94bde2cad0f47..de564e8b83be2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2203,6 +2203,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_ada=
pter *adapter,
=20
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/eth=
ernet/intel/ixgbe/ixgbe_xsk.c
index 59798bc33298f..b988f758aad49 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -104,18 +104,20 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *ada=
pter,
 	struct xdp_frame *xdpf;
 	u32 act;
=20
-	xdp_prog =3D READ_ONCE(rx_ring->xdp_prog);
-	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
+		xdp_prog =3D READ_ONCE(rx_ring->xdp_prog);
+		act =3D bpf_prog_run_xdp(xdp_prog, xdp);
=20
-	if (likely(act =3D=3D XDP_REDIRECT)) {
-		err =3D xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		if (!err)
-			return IXGBE_XDP_REDIR;
-		if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err =3D=3D -ENOBUFS)
-			result =3D IXGBE_XDP_EXIT;
-		else
-			result =3D IXGBE_XDP_CONSUMED;
-		goto out_failure;
+		if (likely(act =3D=3D XDP_REDIRECT)) {
+			err =3D xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+			if (!err)
+				return IXGBE_XDP_REDIR;
+			if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err =3D=3D -ENOBUFS)
+				result =3D IXGBE_XDP_EXIT;
+			else
+				result =3D IXGBE_XDP_CONSUMED;
+			goto out_failure;
+		}
 	}
=20
 	switch (act) {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/ne=
t/ethernet/intel/ixgbevf/ixgbevf_main.c
index a44e4bd561421..1c58c08aa15ff 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1059,7 +1059,8 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf=
_adapter *adapter,
 	if (!xdp_prog)
 		goto xdp_out;
=20
-	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock)
+		act =3D bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
 		break;
--=20
2.43.0



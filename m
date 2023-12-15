Return-Path: <bpf+bounces-18020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFE814E30
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CDFB233E8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1636720F;
	Fri, 15 Dec 2023 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxpWYJqX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ONn61AS"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733347F70;
	Fri, 15 Dec 2023 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68SK6EotaqjMnRph5nBAaqz3Anc2eC7HqiBtHzcWqsI=;
	b=kxpWYJqXc+JexNk4+1gG07K3aKtXIaBxWZT8hQxb8qabTV1hHvbxQN1NvlD6oCkgKJmojI
	Ff39JeNPX68PV4KP1XCMG4apuGbIhq0eQwEd3cgrC2X6wdDo5TqDSQlV+e72oBQSppabUE
	2P1lowUHo+2AW8ymIncIxQ0dicnF3T+LfNIqlu/mdkeInfOuVkV5OS54uDG7y7krQk5T8g
	k3P8WQdLNnnPsoMNQ7Q5zYHusXXC8tETpZ89r1ghuu7i4Xj2UzIWV3B7SUatnqrFCNWJRK
	10sc4OFrCP4ud9LW9o49OHgA7kXGf82t+g+uc9lkZVMlY+4rn7og2eJRqZlNBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68SK6EotaqjMnRph5nBAaqz3Anc2eC7HqiBtHzcWqsI=;
	b=4ONn61ASttN9N3mS72Y00QjbBGAkjiduZ/+5Yn3pkVdxQqe1fitnHIMeMzEi4DvsASU3ez
	aeVXFCXLaAQwS6DQ==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Ronak Doshi <doshir@vmware.com>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 15/24] net: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:34 +0100
Message-ID: <20231215171020.687342-16-bigeasy@linutronix.de>
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
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Ronak Doshi <doshir@vmware.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c |  1 +
 kernel/bpf/cpumap.c               |  2 ++
 net/bpf/test_run.c                | 11 ++++++++---
 net/core/dev.c                    |  3 +++
 net/core/filter.c                 |  1 +
 net/core/lwt_bpf.c                |  2 ++
 net/sched/cls_api.c               |  2 ++
 7 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet=
3_xdp.c
index 80ddaff759d47..18bce98fd2e31 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -257,6 +257,7 @@ vmxnet3_run_xdp(struct vmxnet3_rx_queue *rq, struct xdp=
_buff *xdp,
 	u32 act;
=20
 	rq->stats.xdp_packets++;
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
 	page =3D virt_to_page(xdp->data_hard_start);
=20
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8a0bb80fe48a3..c26d49bb78679 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -144,6 +144,7 @@ static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map=
_entry *rcpu,
 	int err;
=20
 	list_for_each_entry_safe(skb, tmp, listp, list) {
+		guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 		act =3D bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog);
 		switch (act) {
 		case XDP_PASS:
@@ -182,6 +183,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_=
entry *rcpu,
 	struct xdp_buff xdp;
 	int i, nframes =3D 0;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	xdp_set_return_frame_no_direct();
 	xdp.rxq =3D &rxq;
=20
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9fdcc5cdce10..db8f7eb35c6ca 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -293,6 +293,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp=
, struct bpf_prog *prog,
 	batch_sz =3D min_t(u32, repeat, xdp->batch_size);
=20
 	local_bh_disable();
+	local_lock_nested_bh(&bpf_run_lock.redirect_lock);
 	xdp_set_return_frame_no_direct();
=20
 	for (i =3D 0; i < batch_sz; i++) {
@@ -348,6 +349,9 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp=
, struct bpf_prog *prog,
 	}
=20
 out:
+	xdp_clear_return_frame_no_direct();
+	local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
+
 	if (redirect)
 		xdp_do_flush();
 	if (nframes) {
@@ -356,7 +360,6 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp=
, struct bpf_prog *prog,
 			err =3D ret;
 	}
=20
-	xdp_clear_return_frame_no_direct();
 	local_bh_enable();
 	return err;
 }
@@ -417,10 +420,12 @@ static int bpf_test_run(struct bpf_prog *prog, void *=
ctx, u32 repeat,
 	do {
 		run_ctx.prog_item =3D &item;
 		local_bh_disable();
-		if (xdp)
+		if (xdp) {
+			guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 			*retval =3D bpf_prog_run_xdp(prog, ctx);
-		else
+		} else {
 			*retval =3D bpf_prog_run(prog, ctx);
+		}
 		local_bh_enable();
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5a0f6da7b3ae5..5ba7509e88752 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3993,6 +3993,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet=
_type **pt_prev, int *ret,
 		*pt_prev =3D NULL;
 	}
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	qdisc_skb_cb(skb)->pkt_len =3D skb->len;
 	tcx_set_ingress(skb, true);
=20
@@ -4045,6 +4046,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, stru=
ct net_device *dev)
 	if (!entry)
 		return skb;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -5008,6 +5010,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct =
sk_buff *skb)
 		u32 act;
 		int err;
=20
+		guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 		act =3D netif_receive_generic_xdp(skb, &xdp, xdp_prog);
 		if (act !=3D XDP_PASS) {
 			switch (act) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 7c9653734fb60..72a7812f933a1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4241,6 +4241,7 @@ static const struct bpf_func_proto bpf_xdp_adjust_met=
a_proto =3D {
  */
 void xdp_do_flush(void)
 {
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	__dev_flush();
 	__cpu_map_flush();
 	__xsk_map_flush();
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index a94943681e5aa..74b88e897a7e3 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -44,6 +44,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lw=
t_prog *lwt,
 	 * BPF prog and skb_do_redirect().
 	 */
 	local_bh_disable();
+	local_lock_nested_bh(&bpf_run_lock.redirect_lock);
 	bpf_compute_data_pointers(skb);
 	ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
=20
@@ -76,6 +77,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lw=
t_prog *lwt,
 		break;
 	}
=20
+	local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
 	local_bh_enable();
=20
 	return ret;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd1639863..da61b99bc558f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -23,6 +23,7 @@
 #include <linux/jhash.h>
 #include <linux/rculist.h>
 #include <linux/rhashtable.h>
+#include <linux/bpf.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -3925,6 +3926,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *=
qe, struct Qdisc *sch, stru
=20
 	fl =3D rcu_dereference_bh(qe->filter_chain);
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
--=20
2.43.0



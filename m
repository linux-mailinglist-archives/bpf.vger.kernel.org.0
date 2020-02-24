Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878D316A941
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2020 16:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgBXPEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Feb 2020 10:04:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50217 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgBXPDY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 10:03:24 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6FFx-0004th-LJ; Mon, 24 Feb 2020 16:02:49 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E73EF104094;
        Mon, 24 Feb 2020 16:02:42 +0100 (CET)
Message-Id: <20200224145643.691493094@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 15:01:43 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [patch V3 12/22] bpf: Use bpf_prog_run_pin_on_cpu() at simple call sites.
References: <20200224140131.461979697@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Miller <davem@davemloft.net>

All of these cases are strictly of the form:

	preempt_disable();
	BPF_PROG_RUN(...);
	preempt_enable();

Replace this with bpf_prog_run_pin_on_cpu() which wraps BPF_PROG_RUN()
with:

	migrate_disable();
	BPF_PROG_RUN(...);
	migrate_enable();

On non RT enabled kernels this maps to preempt_disable/enable() and on RT
enabled kernels this solely prevents migration, which is sufficient as
there is no requirement to prevent reentrancy to any BPF program from a
preempting task. The only requirement is that the program stays on the same
CPU.

Therefore, this is a trivially correct transformation.

The seccomp loop does not need protection over the loop. It only needs
protection per BPF filter program

[ tglx: Converted to bpf_prog_run_pin_on_cpu() ]

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: No change. Amended changelog vs. seccomp
---
 include/linux/filter.h    |    4 +---
 kernel/seccomp.c          |    4 +---
 net/core/flow_dissector.c |    4 +---
 net/core/skmsg.c          |    8 ++------
 net/kcm/kcmsock.c         |    4 +---
 5 files changed, 6 insertions(+), 18 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -717,9 +717,7 @@ static inline u32 bpf_prog_run_clear_cb(
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	preempt_disable();
-	res = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	res = bpf_prog_run_pin_on_cpu(prog, skb);
 	return res;
 }
 
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -268,16 +268,14 @@ static u32 seccomp_run_filters(const str
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
 	 */
-	preempt_disable();
 	for (; f; f = f->prev) {
-		u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
+		u32 cur_ret = bpf_prog_run_pin_on_cpu(f->prog, sd);
 
 		if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
 			ret = cur_ret;
 			*match = f;
 		}
 	}
-	preempt_enable();
 	return ret;
 }
 #endif /* CONFIG_SECCOMP_FILTER */
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -920,9 +920,7 @@ bool bpf_flow_dissect(struct bpf_prog *p
 		     (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
 	flow_keys->flags = flags;
 
-	preempt_disable();
-	result = BPF_PROG_RUN(prog, ctx);
-	preempt_enable();
+	result = bpf_prog_run_pin_on_cpu(prog, ctx);
 
 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -628,7 +628,6 @@ int sk_psock_msg_verdict(struct sock *sk
 	struct bpf_prog *prog;
 	int ret;
 
-	preempt_disable();
 	rcu_read_lock();
 	prog = READ_ONCE(psock->progs.msg_parser);
 	if (unlikely(!prog)) {
@@ -638,7 +637,7 @@ int sk_psock_msg_verdict(struct sock *sk
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
-	ret = BPF_PROG_RUN(prog, msg);
+	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
@@ -653,7 +652,6 @@ int sk_psock_msg_verdict(struct sock *sk
 	}
 out:
 	rcu_read_unlock();
-	preempt_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sk_psock_msg_verdict);
@@ -665,9 +663,7 @@ static int sk_psock_bpf_run(struct sk_ps
 
 	skb->sk = psock->sk;
 	bpf_compute_data_end_sk_skb(skb);
-	preempt_disable();
-	ret = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	ret = bpf_prog_run_pin_on_cpu(prog, skb);
 	/* strparser clones the skb before handing it to a upper layer,
 	 * meaning skb_orphan has been called. We NULL sk on the way out
 	 * to ensure we don't trigger a BUG_ON() in skb/sk operations
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -380,9 +380,7 @@ static int kcm_parse_func_strparser(stru
 	struct bpf_prog *prog = psock->bpf_prog;
 	int res;
 
-	preempt_disable();
-	res = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	res = bpf_prog_run_pin_on_cpu(prog, skb);
 	return res;
 }
 


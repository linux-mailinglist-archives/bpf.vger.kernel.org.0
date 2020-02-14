Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEC15E5E8
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390590AbgBNQob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 11:44:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393022AbgBNQVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:37 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2diI-0003IN-Oo; Fri, 14 Feb 2020 17:21:10 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7E77C1004EC;
        Fri, 14 Feb 2020 17:21:05 +0100 (CET)
Message-Id: <20200214161503.804093748@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Feb 2020 14:39:26 +0100
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
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC patch 09/19] bpf: Use BPF_PROG_RUN_PIN_ON_CPU() at simple call sites.
References: <20200214133917.304937432@linutronix.de>
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

Replace this with BPF_PROG_RUN_PIN_ON_CPU() which wraps BPF_PROG_RUN()
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

[ tglx: Converted to BPF_PROG_RUN_PIN_ON_CPU() ]

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/filter.h    |    4 +---
 kernel/seccomp.c          |    4 +---
 net/core/flow_dissector.c |    4 +---
 net/core/skmsg.c          |    8 ++------
 net/kcm/kcmsock.c         |    4 +---
 5 files changed, 6 insertions(+), 18 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -713,9 +713,7 @@ static inline u32 bpf_prog_run_clear_cb(
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	preempt_disable();
-	res = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
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
+		u32 cur_ret = BPF_PROG_RUN_PIN_ON_CPU(f->prog, sd);
 
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
+	result = BPF_PROG_RUN_PIN_ON_CPU(prog, ctx);
 
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
+	ret = BPF_PROG_RUN_PIN_ON_CPU(prog, msg);
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
+	ret = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
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
+	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
 	return res;
 }
 


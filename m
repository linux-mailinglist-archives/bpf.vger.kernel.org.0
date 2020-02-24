Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6016A961
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2020 16:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBXPFR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Feb 2020 10:05:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgBXPDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 10:03:20 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6FFq-0004sT-Qt; Mon, 24 Feb 2020 16:02:42 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7D244104090;
        Mon, 24 Feb 2020 16:02:42 +0100 (CET)
Message-Id: <20200224145643.474592620@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 15:01:41 +0100
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
Subject: [patch V3 10/22] bpf: Provide bpf_prog_run_pin_on_cpu() helper
References: <20200224140131.461979697@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF programs require to run on one CPU to completion as they use per CPU
storage, but according to Alexei they don't need reentrancy protection as
obviously BPF programs running in thread context can always be 'preempted'
by hard and soft interrupts and instrumentation and the same program can
run concurrently on a different CPU.

The currently used mechanism to ensure CPUness is to wrap the invocation
into a preempt_disable/enable() pair. Disabling preemption is also
disabling migration for a task.

preempt_disable/enable() is used because there is no explicit way to
reliably disable only migration.

Provide a separate macro to invoke a BPF program which can be used in
migrateable task context.

It wraps BPF_PROG_RUN() in a migrate_disable/enable() pair which maps on
non RT enabled kernels to preempt_disable/enable(). On RT enabled kernels
this merely disables migration. Both methods ensure that the invoked BPF
program runs on one CPU to completion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Make the 'ctx' argument const to unbreak the build
V2: Use an inline function (Mathieu)
---
 include/linux/filter.h |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -576,8 +576,30 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabl
 	}								\
 	ret; })
 
-#define BPF_PROG_RUN(prog, ctx) __BPF_PROG_RUN(prog, ctx,		\
-					       bpf_dispatcher_nopfunc)
+#define BPF_PROG_RUN(prog, ctx)						\
+	__BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nopfunc)
+
+/*
+ * Use in preemptible and therefore migratable context to make sure that
+ * the execution of the BPF program runs on one CPU.
+ *
+ * This uses migrate_disable/enable() explicitly to document that the
+ * invocation of a BPF program does not require reentrancy protection
+ * against a BPF program which is invoked from a preempting task.
+ *
+ * For non RT enabled kernels migrate_disable/enable() maps to
+ * preempt_disable/enable(), i.e. it disables also preemption.
+ */
+static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
+					  void *ctx)
+{
+	u32 ret;
+
+	migrate_disable();
+	ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nopfunc);
+	migrate_enable();
+	return ret;
+}
 
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 


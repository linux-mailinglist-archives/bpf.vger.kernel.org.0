Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB28115E5F8
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392695AbgBNQom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 11:44:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393002AbgBNQVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:35 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2diI-0003MC-Mg; Fri, 14 Feb 2020 17:21:10 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 91086103065;
        Fri, 14 Feb 2020 17:21:06 +0100 (CET)
Message-Id: <20200214161504.325142160@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Feb 2020 14:39:31 +0100
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
Subject: [RFC patch 14/19] bpf: Use migrate_disable() in hashtab code
References: <20200214133917.304937432@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The required protection is that the caller cannot be migrated to a
different CPU as these places take either a hash bucket lock or might
trigger a kprobe inside the memory allocator. Both scenarios can lead to
deadlocks. The deadlock prevention is per CPU by incrementing a per CPU
variable which temporarily blocks the invocation of BPF programs from perf
and kprobes.

Replace the preempt_disable/enable() pairs with migrate_disable/enable()
pairs to prepare BPF to work on PREEMPT_RT enabled kernels. On a non-RT
kernel this maps to preempt_disable/enable(), i.e. no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/bpf/hashtab.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -698,11 +698,11 @@ static void htab_elem_free_rcu(struct rc
 	 * we're calling kfree, otherwise deadlock is possible if kprobes
 	 * are placed somewhere inside of slub
 	 */
-	preempt_disable();
+	migrate_disable();
 	__this_cpu_inc(bpf_prog_active);
 	htab_elem_free(htab, l);
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 }
 
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
@@ -1327,7 +1327,7 @@ static int
 	}
 
 again:
-	preempt_disable();
+	migrate_disable();
 	this_cpu_inc(bpf_prog_active);
 	rcu_read_lock();
 again_nocopy:
@@ -1347,7 +1347,7 @@ static int
 		raw_spin_unlock_irqrestore(&b->lock, flags);
 		rcu_read_unlock();
 		this_cpu_dec(bpf_prog_active);
-		preempt_enable();
+		migrate_enable();
 		goto after_loop;
 	}
 
@@ -1356,7 +1356,7 @@ static int
 		raw_spin_unlock_irqrestore(&b->lock, flags);
 		rcu_read_unlock();
 		this_cpu_dec(bpf_prog_active);
-		preempt_enable();
+		migrate_enable();
 		kvfree(keys);
 		kvfree(values);
 		goto alloc;
@@ -1406,7 +1406,7 @@ static int
 
 	rcu_read_unlock();
 	this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
 	    key_size * bucket_cnt) ||
 	    copy_to_user(uvalues + total * value_size, values,


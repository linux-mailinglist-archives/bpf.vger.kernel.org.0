Return-Path: <bpf+bounces-54582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E4A6CE47
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3284E7A5B80
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411220127A;
	Sun, 23 Mar 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HX2sVng8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF47B3E1
	for <bpf@vger.kernel.org>; Sun, 23 Mar 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714719; cv=none; b=IEb06YEqtIgsKgZEbtSQZYpBrZxjhA6pRFIgD08LqTLDn8+TfQ0IXBSfBUCtZFF3ThIhdGTrJTq26bzlPfc2+FUljwXQ+3Ug34ndfpqKzHtacxn3sPX9+1n4SyeVo5L2muNlXXYi8sfKjajbWZYw/yygQUVA8sRyeuNbwtJNfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714719; c=relaxed/simple;
	bh=pjEHBPzfvEeYJItimRBKQTAk73orwkt8aka59h1vjNs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SjsTbU5enyxoldyHHG47WIN76Sp8NwDdtraKL2L3W3TQB/VQnrnwMSJYLHjYBrS48njBVOY7653CszEDbsn3sHsQkQKgaoVMiKxsDkXfe1pn0nxtGv6b8+8CEK7RNnQ6np3oWw2KAC6d6sZPhuoajlw9nsg+ZPMGo7X8O0b34fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HX2sVng8; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7bb849aa5fbso890486485a.0
        for <bpf@vger.kernel.org>; Sun, 23 Mar 2025 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742714715; x=1743319515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ocoek1h3wHR+5f+ll4cNEMjKwfXiGgCdyPNt9yxsz0c=;
        b=HX2sVng8oXl2aqg2rbx0PNA7lDuIc47L6wG6gSjRyO8nsjUdj+0iwvhbm/+Ny/umJ0
         eHvfYsbYT6YV0AGhnOuzeXZDmcE5BY2tq/TZlqfnMm/Rqrr78ly4LgNLYXUQWh2PKQoZ
         HGT0v+67IoLQUBiOYeQ9dzX6h7jAzVhYP4ProZVQyZ4F7RX0alC3f4M4l4oszPztg6PM
         I6u/6kyGglQHYnKCXW22LruWXLXqowOAdKVrWO8FhIZKzaslkQUEsNCRzft6zW3Ze+Vi
         AcB3v0FtKy//FwnniewPOCUyKI7YuMnHdxLDlMcygZ3HNEN5HMjAMizTBUnfJd5aaCg+
         sivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742714715; x=1743319515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocoek1h3wHR+5f+ll4cNEMjKwfXiGgCdyPNt9yxsz0c=;
        b=qix83V/il3kGRrGEJii49wdYJkB9nbEJt9SF6C/aQxQGIV0EPX0yI+7LfsJqqK5r1e
         xigl8+1yYHN9qWixyoMRxFJfInlgpm5RkN+mRz6q8PsOEjfNhqRzdFjTgvHH0MUfFcU9
         Mhj+6xF8GLjPg7gmeBvlkYqx4PEGvO7f/DGYhwaaal4VTdqqJCNz6IYEUhN6ud/W7uSy
         8keojXYcnW+MYRhhtn2lphvjy/s3JU9B532BP4O67SHz+8azh+7oOfOnauFk6Kr4Qyzg
         o/mz1gwCzOvyXCZjTpSVqLJCmlBgozf92iuorNvW/zxiefO75/ib+Y4N8EXCsBf/pO6o
         BMVw==
X-Forwarded-Encrypted: i=1; AJvYcCVzmoCeLBqUeRVnNUM3v6CIGgJw34zn4Zqn5+uCiiN64ff4rwPCyK9Ov3S8b+3c5RznZUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCobAo0d/zt8wY/sp0qTz58c5zoFK+NYAX5ueNJIzJIvMxlgj
	ryfCKvqHdLyf7r4ukiDn7R1h5D7o3zeJznSFtEqc5CunwepcPM1ymOJlN+SgIwy1GNmMz+PMuKx
	UVLpTs2VK4g==
X-Google-Smtp-Source: AGHT+IEWgWZF6N/oTjsn9wQHDrFwRXFS8i6IktZJ+/0O2oyPVZJ2yRW/Ir7R6ApD3ALqTYnYnIF5efzt6GHTfQ==
X-Received: from qkbdp6.prod.google.com ([2002:a05:620a:2b46:b0:7c5:3ce0:bd3e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4720:b0:7c5:4c49:76a6 with SMTP id af79cd13be357-7c5ba12d9bemr1402211385a.8.1742714715634;
 Sun, 23 Mar 2025 00:25:15 -0700 (PDT)
Date: Sun, 23 Mar 2025 07:25:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250323072511.2353342-1-edumazet@google.com>
Subject: [PATCH] x86/alternatives: remove false sharing in poke_int3_handler()
From: Eric Dumazet <edumazet@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

eBPF programs can be run 20,000,000+ times per second on busy servers.

Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
hundreds of calls sites are patched from text_poke_bp_batch()
and we see a critical loss of performance due to false sharing
on bp_desc.refs lasting up to three seconds.

   51.30%  server_bin       [kernel.kallsyms]           [k] poke_int3_handler
            |
            |--46.45%--poke_int3_handler
            |          exc_int3
            |          asm_exc_int3
            |          |
            |          |--24.26%--cls_bpf_classify
            |          |          tcf_classify
            |          |          __dev_queue_xmit
            |          |          ip6_finish_output2
            |          |          ip6_output
            |          |          ip6_xmit
            |          |          inet6_csk_xmit
            |          |          __tcp_transmit_skb
            |          |          |
            |          |          |--9.00%--tcp_v6_do_rcv
            |          |          |          tcp_v6_rcv
            |          |          |          ip6_protocol_deliver_rcu
            |          |          |          ip6_rcv_finish
            |          |          |          ipv6_rcv
            |          |          |          __netif_receive_skb
            |          |          |          process_backlog
            |          |          |          __napi_poll
            |          |          |          net_rx_action
            |          |          |          __softirqentry_text_start
            |          |          |          asm_call_sysvec_on_stack
            |          |          |          do_softirq_own_stack

Fix this by replacing bp_desc.refs with a per-cpu bp_refs.

Before the patch, on a host with 240 cpus (480 threads):

echo 0 >/proc/sys/kernel/bpf_stats_enabled
text_poke_bp_batch(nr_entries=2)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 324 usec

text_poke_bp_batch(nr_entries=164)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 2655300 usec

After this patch:

echo 0 >/proc/sys/kernecho 0 >/proc/sys/kernel/bpf_stats_enabled
text_poke_bp_batch(nr_entries=2)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 519 usec

text_poke_bp_batch(nr_entries=164)
        text_poke_bp_batch+1
        text_poke_finish+27
        arch_jump_label_transform_apply+22
        jump_label_update+98
        __static_key_slow_dec_cpuslocked+64
        static_key_slow_dec+31
        bpf_stats_handler+236
        proc_sys_call_handler+396
        vfs_write+761
        ksys_write+102
        do_syscall_64+107
        entry_SYSCALL_64_after_hwframe+103
Took 702 usec

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/x86/kernel/alternative.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c71b575bf229..d7afbf822c45 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2137,28 +2137,29 @@ struct text_poke_loc {
 struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
-	atomic_t refs;
 };
 
+static DEFINE_PER_CPU(atomic_t, bp_refs);
+
 static struct bp_patching_desc bp_desc;
 
 static __always_inline
 struct bp_patching_desc *try_get_desc(void)
 {
-	struct bp_patching_desc *desc = &bp_desc;
+	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
-	if (!raw_atomic_inc_not_zero(&desc->refs))
+	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
 
-	return desc;
+	return &bp_desc;
 }
 
 static __always_inline void put_desc(void)
 {
-	struct bp_patching_desc *desc = &bp_desc;
+	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
 	smp_mb__before_atomic();
-	raw_atomic_dec(&desc->refs);
+	raw_atomic_dec(refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
@@ -2191,9 +2192,9 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_desc with non-zero refcount:
 	 *
-	 *	bp_desc.refs = 1		INT3
-	 *	WMB				RMB
-	 *	write INT3			if (bp_desc.refs != 0)
+	 *	bp_refs = 1		INT3
+	 *	WMB			RMB
+	 *	write INT3		if (bp_refs != 0)
 	 */
 	smp_rmb();
 
@@ -2299,7 +2300,8 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Corresponds to the implicit memory barrier in try_get_desc() to
 	 * ensure reading a non-zero refcount provides up to date bp_desc data.
 	 */
-	atomic_set_release(&bp_desc.refs, 1);
+	for_each_possible_cpu(i)
+		atomic_set_release(per_cpu_ptr(&bp_refs, i), 1);
 
 	/*
 	 * Function tracing can enable thousands of places that need to be
@@ -2413,8 +2415,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * Remove and wait for refs to be zero.
 	 */
-	if (!atomic_dec_and_test(&bp_desc.refs))
-		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
+	for_each_possible_cpu(i) {
+		atomic_t *refs = per_cpu_ptr(&bp_refs, i);
+
+		if (!atomic_dec_and_test(refs))
+			atomic_cond_read_acquire(refs, !VAL);
+	}
 }
 
 static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-- 
2.49.0.395.g12beb8f557-goog



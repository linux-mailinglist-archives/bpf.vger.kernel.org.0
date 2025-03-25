Return-Path: <bpf+bounces-54620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B42A6E8E0
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 05:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692A41702BE
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86D1A5BB9;
	Tue, 25 Mar 2025 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHS14jGP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19500273FD
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742877202; cv=none; b=g9+P1eYEZaLbrmrtjyJH/tmjahgxRTtSBEc8KuUYftosGuGch1Mojk/KxFfWFSm0fh12jicAJQPNodscI7hPDKL1DKqQrzCVg1QCaw3LBJAHlH2pNS8v20MBsxPzt9I9k7X/DYfj6XFItUvPKA1dwVfbpu9h07Ac5/oG9YLXdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742877202; c=relaxed/simple;
	bh=1/WsQmT81GA5GOyiKNySyRtps6yWrHFsx3f9ljDeG/E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I8kSpnf9nw/Eh9MUBM+/lXS0K+FiNGLD0DO5RN4KSrIeJ+fMOLpradjnX6Y6Mt79QL1t8pU8mMARPYyOi+3OdDp2uKBY2EH3e+2anS8ybAhq/ALofZUu39nRNMaqYyQRcJGtJjMnNeiL3oa340Ft4FGXUuuS7Z3QQpOIbgVXvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHS14jGP; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e90788e2a7so81343946d6.0
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742877199; x=1743481999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOulYq2NHr2PymZtB9unHgSxEBSMQr0JlxQYUR3VGOg=;
        b=wHS14jGPRREAIk+NzoYhnRIWmK2AUcjWeYSosj3cGiXgWeGbuMY/2htTNckKj7TmKS
         EIcgjyZlfkTf2kdhgNmarRHV+HxLcd0AhRoNe6EKAn7C35U4im5WVDp8fv7CGxoSEp5y
         qx/g9DrjG6S9F5D/CAPaZfCv+RuLk1VkdCXaxcM4IOnKtWzYOerrkwAjzIIRpjksuWD+
         Snskw7Cf60jNUFfWML7T0AhJ1i++NFPUTCIZQy/OhRg+an801lUxQrTMPMP+EOBIuFwp
         DT+gt3O8LwC6ipKtbvoy00UsIZin8/Sf2Vph/GYBnIGj3wKhSXlgZji7jm6cnIh9PoYQ
         zQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742877199; x=1743481999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOulYq2NHr2PymZtB9unHgSxEBSMQr0JlxQYUR3VGOg=;
        b=RRk9irEdcnycRNGJMOEf0aw9xFH6sjaTDGg+RlAcKFjkg1bgFW+6A2tiar2eveYBwk
         Y+K/5N6ZueiO8+WToXKuiun1fjsMEYDDOeZmeynleIsrbXYL9vrAMRvRARDu1+eGxrXe
         ieffYVRIW+KizQF4Dl43kTrrmb2rIwYzIKOusiAdZc5XdA1+IF5biM/9ORyVKmomms/x
         QusSYkPXyVQ/GhXNTcY3K7F6xrEX9HXYuspV92frUBAOL1LbxgRgHKKR9H7BQ3d8pN+h
         OPswksIGNStOK5YtsWtWjIVv6TWibtUlvFkcPsFtXYQLl2lVhubgVC34oEDgyLQ9hqra
         QS0w==
X-Forwarded-Encrypted: i=1; AJvYcCVvAO5ok7hDCtp2KBAzBFSZ385jKett78AT2Qwbj9NoB3TswUG+c52vEM3mTpA2dNg6PFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KxrmjgSTMp7zi6MYUu+KuNcDxqg8sZauRdZkBZ9NjPPVIgv2
	ZvjvdtS9vGhdDbl507+cV0AAo44DYbx4ZOtQlLgx81Y4Ay7a7BeZyswq46sgeD+2xWOCNnpoze0
	8DL4XE4qoOA==
X-Google-Smtp-Source: AGHT+IHBDywK4vJdMDik6Gb5h6hLtA44ETSf25RUCCSkPYMy/dnXKh1KuyzD5S2/qD1WsD/KiePrSdYGrJ8ePw==
X-Received: from qvbny15.prod.google.com ([2002:a05:6214:398f:b0:6e4:5aee:a1ca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f0c:b0:6e4:5317:64a0 with SMTP id 6a1803df08f44-6eb34997bc4mr283791036d6.13.1742877199458;
 Mon, 24 Mar 2025 21:33:19 -0700 (PDT)
Date: Tue, 25 Mar 2025 04:33:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325043316.874518-1-edumazet@google.com>
Subject: [PATCH v3] x86/alternatives: remove false sharing in poke_int3_handler()
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

eBPF programs can be run 50,000,000 times per second on busy servers.

Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
hundreds of calls sites are patched from text_poke_bp_batch()
and we see a huge loss of performance due to false sharing
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

Fix this by replacing bp_desc.refs with a per-cpu bp_refs.

Before the patch, on a host with 240 cores (480 threads):

sysctl -wq kernel.bpf_stats_enabled=0

text_poke_bp_batch(nr_entries=164) : Took 2655300 usec

bpftool prog | grep run_time_ns
...
105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
3009063719 run_cnt 82757845 : average cost is 36 nsec per call

After this patch:

sysctl -wq kernel.bpf_stats_enabled=0

text_poke_bp_batch(nr_entries=164) : Took 702 usec

$ bpftool prog | grep run_time_ns
...
105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
1928223019 run_cnt 67682728 : average cost is 28 nsec per call

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/x86/kernel/alternative.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c71b575bf229..5d364e990055 100644
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
+		if (unlikely(!atomic_dec_and_test(refs)))
+			atomic_cond_read_acquire(refs, !VAL);
+	}
 }
 
 static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-- 
2.49.0.395.g12beb8f557-goog



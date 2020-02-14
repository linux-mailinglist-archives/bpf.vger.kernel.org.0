Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4A15E618
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406127AbgBNQpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 11:45:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55559 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392978AbgBNQVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:32 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2diI-0003IK-IW; Fri, 14 Feb 2020 17:21:10 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4A130101DF6;
        Fri, 14 Feb 2020 17:21:05 +0100 (CET)
Message-Id: <20200214161503.702891999@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Feb 2020 14:39:25 +0100
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
Subject: [RFC patch 08/19] bpf: Replace cant_sleep() with cant_migrate()
References: <20200214133917.304937432@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As already discussed in the previous change which introduced
BPF_RUN_PROG_PIN_ON_CPU() BPF only requires to disable migration to
guarantee per CPUness.

If RT substitutes the preempt disable based migration protection then the
cant_sleep() check will obviously trigger as preemption is not disabled.

Replace it by cant_migrate() which maps to cant_sleep() on a non RT kernel
and will verify that migration is disabled on a full RT kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/filter.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -561,7 +561,7 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabl
 
 #define __BPF_PROG_RUN(prog, ctx, dfunc)	({			\
 	u32 ret;							\
-	cant_sleep();							\
+	cant_migrate();							\
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {		\
 		struct bpf_prog_stats *stats;				\
 		u64 start = sched_clock();				\


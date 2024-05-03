Return-Path: <bpf+bounces-28526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB08BB199
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DC9B227CC
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B7158202;
	Fri,  3 May 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI3izxXw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319521581F5;
	Fri,  3 May 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756746; cv=none; b=p8H8/zTEUETqdKlNWOq1zFL1N21JKRhcGmxf4HELGmWEurDRoVuTEzA9vZ2fv+QNOuD+W9C8A/zXC39oMOHuPL40IrWCbKRtz/Prx/NLAqD+PsbloCYgcLIUuK39ac1m6f2Uuh3zJaOgpiAZDOJ45uK+T+bf71IstplGmBkfd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756746; c=relaxed/simple;
	bh=SKPGGFh3wFauCRM9bosYEwSGbWHR5tDTuYSe2kSfmNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbyDP6sIJ7jXWQu/Rz/S6jSzCKZ8avRFoa39pEGIPQgtJk81iJeUQRcY6QHYUyRTwsoxWPz4L02mqfTJRIXHIzfPwHD4s4TT3Hd8TDn5wDOQqn2C0sa0CLlSYWU0S43D8GvrDJqEsV4JyoyFUsZlZK4m5eaMrhHR46M10d/VW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI3izxXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A30C116B1;
	Fri,  3 May 2024 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714756745;
	bh=SKPGGFh3wFauCRM9bosYEwSGbWHR5tDTuYSe2kSfmNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qI3izxXwFqNX4HpMhaKsfqCMLJdgy+IySCBeCY29ifhaPt902Hca20463lWJ3VH+/
	 Tqj338XIPGTpolG8s+ut9LJWxjNZKPNtbZ7qfwPvVyDqp9Tm9l5CC+TGRSeLs0r/QA
	 ewaJpUaDScg/uFwSOxlI+GFyhHYZwV4o7542q9DdMg/vBiQ9SZB0CpY4vWp1IZJht2
	 4niqwjcIgnYWZcD6HeGFMplquUnrQfLLUXW9bFHPtKBSqQ0rYQX9UzsLwYiksBYGUI
	 0SPKxpx7bWmyoPsuMjCLj3VLJYC9MmZnIzb3GXAktmb+3T1ESmuPd/PmgEjakJ4E2E
	 8n4c87SVmbp6g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH v3 2/2] arm64: implement raw_smp_processor_id() using thread_info
Date: Fri,  3 May 2024 17:18:47 +0000
Message-Id: <20240503171847.68267-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503171847.68267-1-puranjay@kernel.org>
References: <20240503171847.68267-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, arm64 implemented raw_smp_processor_id() as a read of
current_thread_info()->cpu. This changed when arm64 moved thread_info into
task struct, as at the time CONFIG_THREAD_INFO_IN_TASK made core code use
thread_struct::cpu for the cpu number, and due to header dependencies
prevented using this in raw_smp_processor_id(). As a workaround, we moved to
using a percpu variable in commit:

  57c82954e77fa12c ("arm64: make cpu number a percpu variable")

Since then, thread_info::cpu was reintroduced, and core code was made to use
this in commits:

  001430c1910df65a ("arm64: add CPU field to struct thread_info")
  bcf9033e5449bdca ("sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y")

Consequently it is possible to use current_thread_info()->cpu again.

This decreases the number of emitted instructions like in the following
example:

Dump of assembler code for function bpf_get_smp_processor_id:
   0xffff8000802cd608 <+0>:     nop
   0xffff8000802cd60c <+4>:     nop
   0xffff8000802cd610 <+8>:     adrp    x0, 0xffff800082138000
   0xffff8000802cd614 <+12>:    mrs     x1, tpidr_el1
   0xffff8000802cd618 <+16>:    add     x0, x0, #0x8
   0xffff8000802cd61c <+20>:    ldrsw   x0, [x0, x1]
   0xffff8000802cd620 <+24>:    ret

After this patch:

Dump of assembler code for function bpf_get_smp_processor_id:
   0xffff8000802c9130 <+0>:     nop
   0xffff8000802c9134 <+4>:     nop
   0xffff8000802c9138 <+8>:     mrs     x0, sp_el0
   0xffff8000802c913c <+12>:    ldr     w0, [x0, #24]
   0xffff8000802c9140 <+16>:    ret

A microbenchmark[1] was built to measure the performance improvement
provided by this change. It calls the following function given number of
times and finds the runtime overhead:

static noinline int get_cpu_id(void)
{
	return smp_processor_id();
}

Run the benchmark like:
 modprobe smp_processor_id nr_function_calls=1000000000

      +--------------------------+------------------------+
      |        | Number of Calls |    Time taken          |
      +--------+-----------------+------------------------+
      | Before |   1000000000    |   1602888401ns         |
      +--------+-----------------+------------------------+
      | After  |   1000000000    |   1206212658ns         |
      +--------+-----------------+------------------------+
      |  Difference (decrease)   |   396675743ns (24.74%) |
      +---------------------------------------------------+

Remove the percpu variable cpu_number as it is used only in
set_smp_ipi_range() as a dummy variable to be passed to ipi_handler().
Use irq_stat in place of cpu_number here like arm32.

[1] https://github.com/puranjaymohan/linux/commit/77d3fdd

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/smp.h | 13 +------------
 arch/arm64/kernel/smp.c      |  9 ++-------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index efb13112b408..2510eec026f7 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -25,22 +25,11 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/percpu.h>
-
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
-
-/*
- * We don't use this_cpu_read(cpu_number) as that has implicit writes to
- * preempt_count, and associated (compiler) barriers, that we'd like to avoid
- * the expense of. If we're preemptible, the value can be stale at use anyway.
- * And we can't use this_cpu_ptr() either, as that winds up recursing back
- * here under CONFIG_DEBUG_PREEMPT=y.
- */
-#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 /*
  * Logical CPU mapping.
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4ced34f62dab..98d4e352c3d0 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -55,9 +55,6 @@
 
 #include <trace/events/ipi.h>
 
-DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
-EXPORT_PER_CPU_SYMBOL(cpu_number);
-
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -742,8 +739,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	for_each_possible_cpu(cpu) {
 
-		per_cpu(cpu_number, cpu) = cpu;
-
 		if (cpu == smp_processor_id())
 			continue;
 
@@ -1021,12 +1016,12 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 
 		if (ipi_should_be_nmi(i)) {
 			err = request_percpu_nmi(ipi_base + i, ipi_handler,
-						 "IPI", &cpu_number);
+						 "IPI", &irq_stat);
 			WARN(err, "Could not request IPI %d as NMI, err=%d\n",
 			     i, err);
 		} else {
 			err = request_percpu_irq(ipi_base + i, ipi_handler,
-						 "IPI", &cpu_number);
+						 "IPI", &irq_stat);
 			WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
 			     i, err);
 		}
-- 
2.40.1



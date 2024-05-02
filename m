Return-Path: <bpf+bounces-28441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647C68B9AF6
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2075E281EAB
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D443E47E;
	Thu,  2 May 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0oA7urD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCA1EA8D;
	Thu,  2 May 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653332; cv=none; b=XRYkzOAhsQd61saFEilv8qc5AoEpTxWGene+/mgQ9gR8/yuKwYcJx8PKk/sn+Me1h9u9UBFTGLMgAtrUka3WXJy7jRqoCRu82Yjy+ZfFUeMJezpiywAZnI0TAh3V3HKkSyRMkcASCSBeik6FpEfY5PxZDtROPsgg8sxyLpSxQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653332; c=relaxed/simple;
	bh=1iCPxTYI/pWQqAi8vVdqGnub1dSEJs9IuaXYhwyCwuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+HywJWOKlpTUXVRaTANxroG/wGVju5BHpvXW7BxNZQ/40rBiwNLi4FXtFFITNQzzQ3IMhc3Nj3ds7joMA1Bsy3/9HCruzSW8D38dM/kSH46juFk6gjcv8AVDcRRwoTeTCVFbbjjWW8zzgybRpe+p4zxzqgc0vOH8sky39xn1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0oA7urD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7696C4AF1A;
	Thu,  2 May 2024 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714653332;
	bh=1iCPxTYI/pWQqAi8vVdqGnub1dSEJs9IuaXYhwyCwuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0oA7urDCD13K1L0cCU8HeM+7YcjiTjuyh+c7i/+Td/1fhozuvdP/0d9ryRRMIlGh
	 Fxnwe7dUXuAZSkCRGPojYpvJtAqj2goIyyNIoKAg5s7N7LegK+Q0ig0yTzXidmoOMA
	 u9VPCndHJ4wPVDdV6WP+64NtQTNgV05kLXr94d+XZQ//2xD5N9B9z1wpz8fJLgYfSt
	 oZTyFYstifkOarSaNm57faFrAHZnmIDyCXYJxAf02Ht6H1FxJvk8HrfhVCjKo9bhlD
	 wILsHliajdkrMhQnycBmDqOyEFW7wMGKLAYbztTTZd8hoaFAOFEr1KLQMqc98ebK8I
	 /8vnC+E3XaceQ==
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
Subject: [PATCH v2 2/2] arm64: implement raw_smp_processor_id() using thread_info
Date: Thu,  2 May 2024 12:34:49 +0000
Message-Id: <20240502123449.2690-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240502123449.2690-1-puranjay@kernel.org>
References: <20240502123449.2690-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, arm64 implemented raw_smp_processor_id() as a read of
current_thread_info()->cpu. This changed when arm64 moved thread_info
into task struct, as at the time CONFIG_THREAD_INFO_IN_TASK made core
code use thread_struct::cpu for the cpu number, and due to header
dependencies prevented using this in raw_smp_processor_id(). As a
workaround, we moved to using a percpu variable in commit:

commit 57c82954e77f ("arm64: make cpu number a percpu variable")

Since then, thread_info::cpu was reintroduced, and core code was made to
use this in commits:

commit 001430c1910d ("arm64: add CPU field to struct thread_info")
commit bcf9033e5449 ("sched: move CPU field back into thread_info if
THREAD_INFO_IN_TASK=y")

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
Use irq_stat in place of cpu_number here.

[1] https://github.com/puranjaymohan/linux/commit/77d3fdd

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
Changes in v1 -> v2:
v1: https://lore.kernel.org/all/20240501154236.10236-1-puranjay@kernel.org/
- Remove the percpu variable cpu_number
- Add more information to the commit message.
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



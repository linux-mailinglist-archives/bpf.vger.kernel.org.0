Return-Path: <bpf+bounces-28370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBF8B8D62
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075741C20F3C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574712FF9B;
	Wed,  1 May 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th6c1+mm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748312FF78;
	Wed,  1 May 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578204; cv=none; b=FEKb1HAUfk2fXpnyox1NHPoOvVbvRZg31JDL5RLrmsri3VKhj7z/UT3VaaoPtqH+RGm7eNPVdgotBjWH2JCcLcrcFvW0AznyI/XEZ6XE8bVxrTAQjJK5lA95JzN59ZTEgC9aU6U75/8nfDjWbtdYGeQ6z5HktY4JtKj7782IuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578204; c=relaxed/simple;
	bh=KALlXTVUTaG7KIY4xfSeGKWZAwSJ5/dytvx09z4PAuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNahXCpZnbDLqOh90aD5nZEn8GAZkbKVwVVY1nsH6vTBYOHQoC4yLZJQypfyD9dulGJa8Y7MMS7inW3OO78ROfwwQhW+7ui+VTyjb7JuVGkGR6nOwRpmIf2+knCjVunFyk+ueD0qH2V/Bh/cCT+GoFxIQKi2SdXtNLgaKPEtCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th6c1+mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5EFC072AA;
	Wed,  1 May 2024 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714578203;
	bh=KALlXTVUTaG7KIY4xfSeGKWZAwSJ5/dytvx09z4PAuA=;
	h=From:To:Cc:Subject:Date:From;
	b=th6c1+mm5tEOQDCQZKB6/0pXmDxMTXaBzvR1lpXEFQJPkq9GJSEKcwTW2jyNHYjr7
	 TfGDpwsO2mcdGdRbuwZigx9Qvocz20fn2W+ubLTx30PXku5RilOYMB2Pm2QSC6NIK8
	 W/P0Cd93k5yfwdAzOyNsRifq291WpbE2ZPbL7m+Fp44F+Q4gcMs+qhHNtAzUdnSsN+
	 WBTDTW0CerAW/OQ1YH4uUi43tiRvR/8jNPJ8S3A6q84o/5GXHwi6/sliWmj/b1HgT2
	 TlLIyU76GEGF6bQNrV9tHqkhDRtg6xiA7qsYh2XZynGE1eOyxQe0xEgGqwOzMhFrR2
	 +y4cw2FaaZ90A==
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
Subject: [PATCH] arm64: implement raw_smp_processor_id() using thread_info
Date: Wed,  1 May 2024 15:42:36 +0000
Message-Id: <20240501154236.10236-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM64 defines THREAD_INFO_IN_TASK which means the cpu id can be found
from current_thread_info()->cpu.

Implement raw_smp_processor_id() using the above. This decreases the
number of emitted instructions like in the following example:

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

This improvement is in this very specific microbenchmark but it proves
the point.

The percpu variable cpu_number is left as it is because it is used in
set_smp_ipi_range()

[1] https://github.com/puranjaymohan/linux/commit/77d3fdd

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/include/asm/smp.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index efb13112b408..88fd2ab805ec 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -34,13 +34,9 @@
 DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
 /*
- * We don't use this_cpu_read(cpu_number) as that has implicit writes to
- * preempt_count, and associated (compiler) barriers, that we'd like to avoid
- * the expense of. If we're preemptible, the value can be stale at use anyway.
- * And we can't use this_cpu_ptr() either, as that winds up recursing back
- * here under CONFIG_DEBUG_PREEMPT=y.
+ * This relies on THREAD_INFO_IN_TASK, but arm64 defines that unconditionally.
  */
-#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 /*
  * Logical CPU mapping.
-- 
2.40.1



Return-Path: <bpf+bounces-76411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955CCB2FA7
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9EF3055B8C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6A3254A9;
	Wed, 10 Dec 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqieqOVP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BE3246F1;
	Wed, 10 Dec 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372370; cv=none; b=brN7L7qFb2L8FKT23fV60Lk80vOduUd+EkCb1woMdRjHiZF/ohyO2aPkfSnrtgFKPr0BfWF8VDYV/2ahRX+U7YVrFU81Fy1ful0SOgK9ry/7pSi4sBETy9z8il+MUpoxT0t1YNKtGfv4n5GM32SXksT4FO/FU3xZ20nXMBTQMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372370; c=relaxed/simple;
	bh=A2OpIuFGFpKWyDe1O3Got3OnGW4sMeJIXHZ8phfTvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ad5WdM0rVJmagoxxqiv2WjMM05X1n6YkXYdZ2FsbBlT3nhQ4Ck95j3ZXvwQa/clP45NH/B4goMkoBSarlDVomN8SW+7v+i7omw1L7SesgrTTcVGpWfaXPUNfTsRpEd5HcE8JEVyCvUvE0RS0gzQk1YRHX1f4RW2syWWiIYhvXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqieqOVP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765372369; x=1796908369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A2OpIuFGFpKWyDe1O3Got3OnGW4sMeJIXHZ8phfTvZA=;
  b=nqieqOVPa6ZTjzbcqXRjZvWLEPWcwMRp9j5zig74Zy6OUn7bSRbgBX5G
   lZBY6y7HeVmwRymM50G7939CArvc8ECnC9bq4bB80x+rDDpFYqD45aVat
   Xk6vGN3tkP9eZyPeeEl9pAMQKUDzPKGYWRCavgMBaRupfsuWH1Wq60hES
   gx9ceWt/1mp/rxiCeadVBn0P54OZycS7d7jByuAxUhsZz/RcViePcj+3c
   wb+t4CzOx8TBwGT6GPM7PkqLqUgDNUHWdi9CZux3/fkHPvQjRgIJzbPVD
   jE8kU49CSfPoxLJ7lMOgJrFZ8P4LG8LE2BnGhBr6/fpKsh20yBm1ws2H6
   w==;
X-CSE-ConnectionGUID: 2uRdi6P8TzaTlcZ+ReuyYQ==
X-CSE-MsgGUID: p5klfkq7S8WEN8IzK7EENQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67514954"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="67514954"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 05:12:47 -0800
X-CSE-ConnectionGUID: Ae+lifnVRMmXIsU2AERptw==
X-CSE-MsgGUID: LxOK7cDgTtCsuSqa5mNX6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="196419613"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 10 Dec 2025 05:12:43 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 80CFA93; Wed, 10 Dec 2025 14:12:42 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
Date: Wed, 10 Dec 2025 14:12:34 +0100
Message-ID: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The printing functions in BPF code are using printf() type of format,
and compiler is not happy about them as is:

kernel/bpf/helpers.c:1069:9: error: function ‘____bpf_snprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
 1069 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
      |         ^~~

kernel/bpf/stream.c:241:9: error: function ‘bpf_stream_vprintk_impl’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  241 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
      |         ^~~

kernel/trace/bpf_trace.c:377:9: error: function ‘____bpf_trace_printk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
      |         ^~~

kernel/trace/bpf_trace.c:433:9: error: function ‘____bpf_trace_vprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  433 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
      |         ^~~

kernel/trace/bpf_trace.c:475:9: error: function ‘____bpf_seq_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  475 |         seq_bprintf(m, fmt, data.bin_args);
      |         ^~~~~~~~~~~

Fix the compilation errors by disabling that warning since the code is
generated and warning is not so useful in this case — it can't check
the parameters for now.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512061425.x0qTt9ww-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512081321.2h9ThWTg-lkp@intel.com/
Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Fixes: 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper")
Fixes: 7b15523a989b ("bpf: Add a bpf_snprintf helper")
Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
Fixes: f3694e001238 ("bpf: add BPF_CALL_x macros for declaring helpers")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/bpf/Makefile   | 11 +++++++++--
 kernel/trace/Makefile |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 232cbc97434d..cf7e8a972f98 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,14 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o tnum.o log.o token.o liveness.o
+
+obj-$(CONFIG_BPF_SYSCALL) += helpers.o stream.o
+# The ____bpf_snprintf() uses the format string that triggers a compiler warning.
+CFLAGS_helpers.o += -Wno-suggest-attribute=format
+# The bpf_stream_vprintk_impl() uses the format string that triggers a compiler warning.
+CFLAGS_stream.o += -Wno-suggest-attribute=format
+
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
@@ -14,7 +21,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
-obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o
+obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index fc5dcc888e13..1673b395c14c 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -104,7 +104,13 @@ obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
 obj-$(CONFIG_USER_EVENTS) += trace_events_user.o
+
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
+# The BPF printing functions use the format string that triggers a compiler warning.
+# Since the code is generated and warning is not so useful in this case (it can't
+# check the parameters for now) disable the warning.
+CFLAGS_bpf_trace.o += -Wno-suggest-attribute=format
+
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
 obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
 obj-$(CONFIG_TRACEPOINTS) += power-traces.o
-- 
2.50.1



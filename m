Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C85424546
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJFRxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 13:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239190AbhJFRx2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 13:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633542695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/N9y4vbY9mTEc3gAbJzMQKzbPFxDnkdy6flYmPlO6Rg=;
        b=clhLoh9F84aF19/Dps7LcshRbflCAHnnN1rL2Crg4gI8Y7XVxFYbdFMVZjjTVeGkIDeWCC
        umBiIH3xwIzFT8VJ2C4wDlcnGbPfICW9y+GHqQZPuV2ofpfuq4G5TFXPHmC0sFkfvcnmEx
        aTvHW7TjCsfap/tM2WAdjEVOirbLzd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-hgaayYSAOROo3EVoRcDg_Q-1; Wed, 06 Oct 2021 13:51:34 -0400
X-MC-Unique: hgaayYSAOROo3EVoRcDg_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A15D884A5E3;
        Wed,  6 Oct 2021 17:51:33 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FB439AA20;
        Wed,  6 Oct 2021 17:51:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 707124172EEF; Wed,  6 Oct 2021 14:51:06 -0300 (-03)
Date:   Wed, 6 Oct 2021 14:51:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpf: introduce helper bpf_raw_read_cpu_clock
Message-ID: <20211006175106.GA295227@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Add bpf_raw_read_cpu_clock helper, to read architecture specific 
CPU clock. In x86's case, this is the TSC.

This is necessary to synchronize bpf traces from host and guest bpf-programs
(after subtracting guest tsc-offset from guest timestamps).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22d274e..832bb1f65f28 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -95,6 +95,7 @@ config X86
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
+	select ARCH_HAS_BPF_RAW_CPU_CLOCK
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/include/asm/bpf_raw_cpu_clock.h b/arch/x86/include/asm/bpf_raw_cpu_clock.h
new file mode 100644
index 000000000000..6951c399819e
--- /dev/null
+++ b/arch/x86/include/asm/bpf_raw_cpu_clock.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_BPF_RAW_CPU_CLOCK_H_
+#define _ASM_X86_BPF_RAW_CPU_CLOCK_H_
+
+static inline unsigned long long read_raw_cpu_clock(void)
+{
+	return rdtsc_ordered();
+}
+
+#endif /* _ASM_X86_BPF_RAW_CPU_CLOCK_H_ */
diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 3eff08d7b8e5..844a44ff508d 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -105,6 +105,8 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_ktime_get_boot_ns:
 		return &bpf_ktime_get_boot_ns_proto;
+	case BPF_FUNC_read_raw_cpu_clock:
+		return &bpf_read_raw_cpu_clock_proto;
 	case BPF_FUNC_tail_call:
 		return &bpf_tail_call_proto;
 	case BPF_FUNC_get_prandom_u32:
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d604c8251d88..b6cb426085fb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2058,6 +2058,7 @@ extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
 extern const struct bpf_func_proto bpf_tail_call_proto;
 extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
 extern const struct bpf_func_proto bpf_ktime_get_boot_ns_proto;
+extern const struct bpf_func_proto bpf_read_raw_cpu_clock_proto;
 extern const struct bpf_func_proto bpf_get_current_pid_tgid_proto;
 extern const struct bpf_func_proto bpf_get_current_uid_gid_proto;
 extern const struct bpf_func_proto bpf_get_current_comm_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fc59d61937a..52191791b089 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4037,6 +4037,13 @@ union bpf_attr {
  * 	Return
  * 		Current *ktime*.
  *
+ * u64 bpf_read_raw_cpu_clock(void)
+ * 	Description
+ * 		Return the architecture specific CPU clock value.
+ * 		For x86, this is the TSC clock.
+ * 	Return
+ * 		*CPU clock value*
+ *
  * long bpf_seq_printf(struct seq_file *m, const char *fmt, u32 fmt_size, const void *data, u32 data_len)
  * 	Description
  * 		**bpf_seq_printf**\ () uses seq_file **seq_printf**\ () to print
@@ -5089,6 +5096,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(read_raw_cpu_clock),         \
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index a82d6de86522..5815db157220 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -21,6 +21,10 @@ config HAVE_EBPF_JIT
 config ARCH_WANT_DEFAULT_BPF_JIT
 	bool
 
+# Used by archs to tell they support reading raw CPU clock
+config ARCH_HAS_BPF_RAW_CPU_CLOCK
+	bool
+
 menu "BPF subsystem"
 
 config BPF_SYSCALL
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b6c72af64d5d..8e2359dfd582 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2345,6 +2345,8 @@ const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto __weak;
+const struct bpf_func_proto bpf_read_raw_cpu_clock_proto __weak;
+
 
 const struct bpf_func_proto bpf_get_current_pid_tgid_proto __weak;
 const struct bpf_func_proto bpf_get_current_uid_gid_proto __weak;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1ffd469c217f..90b9e5efaf65 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -18,6 +18,10 @@
 
 #include "../../lib/kstrtox.h"
 
+#ifdef CONFIG_ARCH_HAS_BPF_RAW_CPU_CLOCK
+#include <asm/bpf_raw_cpu_clock.h>
+#endif
+
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should return
  * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments
@@ -168,6 +172,21 @@ const struct bpf_func_proto bpf_ktime_get_boot_ns_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
+BPF_CALL_0(bpf_read_raw_cpu_clock)
+{
+#ifdef CONFIG_ARCH_HAS_BPF_RAW_CPU_CLOCK
+	return read_raw_cpu_clock();
+#else
+	return sched_clock();
+#endif
+}
+
+const struct bpf_func_proto bpf_read_raw_cpu_clock_proto = {
+	.func		= bpf_read_raw_cpu_clock,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
 BPF_CALL_0(bpf_ktime_get_coarse_ns)
 {
 	return ktime_get_coarse_ns();
@@ -1366,6 +1385,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ktime_get_boot_ns_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_read_raw_cpu_clock:
+		return &bpf_read_raw_cpu_clock_proto;
 	case BPF_FUNC_ringbuf_output:
 		return &bpf_ringbuf_output_proto;
 	case BPF_FUNC_ringbuf_reserve:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6b3153841a33..047ca7c1d57a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1113,6 +1113,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_ktime_get_boot_ns_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_read_raw_cpu_clock:
+		return &bpf_read_raw_cpu_clock_proto;
 	case BPF_FUNC_tail_call:
 		return &bpf_tail_call_proto;
 	case BPF_FUNC_get_current_pid_tgid:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6fc59d61937a..52191791b089 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4037,6 +4037,13 @@ union bpf_attr {
  * 	Return
  * 		Current *ktime*.
  *
+ * u64 bpf_read_raw_cpu_clock(void)
+ * 	Description
+ * 		Return the architecture specific CPU clock value.
+ * 		For x86, this is the TSC clock.
+ * 	Return
+ * 		*CPU clock value*
+ *
  * long bpf_seq_printf(struct seq_file *m, const char *fmt, u32 fmt_size, const void *data, u32 data_len)
  * 	Description
  * 		**bpf_seq_printf**\ () uses seq_file **seq_printf**\ () to print
@@ -5089,6 +5096,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(read_raw_cpu_clock),         \
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper


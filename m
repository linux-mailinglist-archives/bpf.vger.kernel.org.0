Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB4D2255
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfJJINO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 04:13:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbfJJINO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 04:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mf764AdfZwnie4a40/S03SR1BO+wuVvW4KkBz9Ae3Ak=; b=KoIGkvzrOqRBQybp5YMzHwehN
        pTgVc6riV0bao+s26drY2H4Fvr/7bie91IerrISfRw6rPwx2g8vLxb04Dd0b97RJpn7LLyR6AkyI/
        hRX6HP0MFFoRq9L+11YPASIDFLc9xl7yt0Pd1g6XCUNayYDe78zfuPoiHjSyLg06XPVCxLlG8A8zq
        0OpQezjxw6TprtHyM6m30UPL6oRg/Ly+qXsmlSr/ZW567cv9qre5ubl1ksDpzcJUJMvO6oW5YJTuU
        OZscaHfrofSO13mkfQG8ZCWNcv1DPjEbDkj/Tz5duBK9CvBJI6VTXJUz5Cr4VjtjMcdY18cQbCwA6
        kfZgVCiNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iITZ8-0001dw-Bj; Thu, 10 Oct 2019 08:12:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20D193013A4;
        Thu, 10 Oct 2019 10:11:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D97A213C6CDD; Thu, 10 Oct 2019 10:12:51 +0200 (CEST)
Date:   Thu, 10 Oct 2019 10:12:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191010081251.GP2311@hirez.programming.kicks-ass.net>
References: <20191009203657.6070-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009203657.6070-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 09, 2019 at 04:36:57PM -0400, Joel Fernandes (Google) wrote:
> In currentl mainline, the degree of access to perf_event_open(2) system
> call depends on the perf_event_paranoid sysctl.  This has a number of
> limitations:
> 
> 1. The sysctl is only a single value. Many types of accesses are controlled
>    based on the single value thus making the control very limited and
>    coarse grained.
> 2. The sysctl is global, so if the sysctl is changed, then that means
>    all processes get access to perf_event_open(2) opening the door to
>    security issues.
> 
> This patch adds LSM and SELinux access checking which will be used in
> Android to access perf_event_open(2) for the purposes of attaching BPF
> programs to tracepoints, perf profiling and other operations from
> userspace. These operations are intended for production systems.
> 
> 5 new LSM hooks are added:
> 1. perf_event_open: This controls access during the perf_event_open(2)
>    syscall itself. The hook is called from all the places that the
>    perf_event_paranoid sysctl is checked to keep it consistent with the
>    systctl. The hook gets passed a 'type' argument which controls CPU,
>    kernel and tracepoint accesses (in this context, CPU, kernel and
>    tracepoint have the same semantics as the perf_event_paranoid sysctl).
>    Additionally, I added an 'open' type which is similar to
>    perf_event_paranoid sysctl == 3 patch carried in Android and several other
>    distros but was rejected in mainline [1] in 2016.
> 
> 2. perf_event_alloc: This allocates a new security object for the event
>    which stores the current SID within the event. It will be useful when
>    the perf event's FD is passed through IPC to another process which may
>    try to read the FD. Appropriate security checks will limit access.
> 
> 3. perf_event_free: Called when the event is closed.
> 
> 4. perf_event_read: Called from the read(2) system call path for the event.

	+ mmap()
> 
> 5. perf_event_write: Called from the read(2) system call path for the event.

	- read() + ioctl()

fresh from the keyboard.. but maybe consoldate things a little.

---
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -14,7 +14,6 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/coredump.h>
-#include <linux/security.h>
 
 #include <linux/sizes.h>
 #include <asm/perf_event.h>
@@ -550,13 +549,11 @@ static int bts_event_init(struct perf_ev
 	 * Note that the default paranoia setting permits unprivileged
 	 * users to profile the kernel.
 	 */
-	if (event->attr.exclude_kernel && perf_paranoid_kernel() &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	ret = security_perf_event_open(&event->attr, PERF_SECURITY_KERNEL);
-	if (ret)
-		return ret;
+	if (event->attr.exclude_kernel) {
+		ret = perf_allow_kernel(&event->attr);
+		if (ret)
+			return ret;
+	}
 
 	if (x86_add_exclusive(x86_lbr_exclusive_bts))
 		return -EBUSY;
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -11,7 +11,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/nmi.h>
@@ -3316,10 +3315,7 @@ static int intel_pmu_hw_config(struct pe
 	if (x86_pmu.version < 3)
 		return -EINVAL;
 
-	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	ret = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
+	ret = perf_allow_cpu(&event->attr);
 	if (ret)
 		return ret;
 
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/perf_event.h>
-#include <linux/security.h>
 
 #include <asm/perf_event_p4.h>
 #include <asm/hardirq.h>
@@ -777,10 +776,7 @@ static int p4_validate_raw_event(struct
 	 * the user needs special permissions to be able to use it
 	 */
 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
-
-		v = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
+		v = perf_allow_cpu(&event->attr);
 		if (v)
 			return v;
 	}
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -56,6 +56,7 @@ struct perf_guest_info_callbacks {
 #include <linux/perf_regs.h>
 #include <linux/cgroup.h>
 #include <linux/refcount.h>
+#include <linux/security.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -1244,19 +1245,28 @@ extern int perf_cpu_time_max_percent_han
 int perf_event_max_stack_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp, loff_t *ppos);
 
-static inline bool perf_paranoid_tracepoint_raw(void)
+static inline int perf_allow_kernel(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > -1;
+	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
 }
 
-static inline bool perf_paranoid_cpu(void)
+static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > 0;
+	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_CPU);
 }
 
-static inline bool perf_paranoid_kernel(void)
+static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > 1;
+	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
 extern void perf_event_init(void);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4229,10 +4229,7 @@ find_get_context(struct pmu *pmu, struct
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-			return ERR_PTR(-EACCES);
-
-		err = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
+		err = perf_allow_cpu(&event->attr);
 		if (err)
 			return ERR_PTR(err);
 
@@ -5862,14 +5859,8 @@ static int perf_mmap(struct file *file,
 	lock_limit >>= PAGE_SHIFT;
 	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
 
-	if (locked > lock_limit) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_IPC_LOCK)) {
-			ret = -EPERM;
-			goto unlock;
-		}
-
-		ret = security_perf_event_open(&event->attr,
-					       PERF_SECURITY_TRACEPOINT);
+	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
+		ret = perf_allow_tracepoint(&event->attr);
 		if (ret)
 			goto unlock;
 	}
@@ -10702,11 +10693,7 @@ static int perf_copy_attr(struct perf_ev
 		}
 		/* privileged levels capture (kernel, hv): check permissions */
 		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
-			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-				return -EACCES;
-
-			ret = security_perf_event_open(attr,
-						       PERF_SECURITY_KERNEL);
+			ret = perf_allow_kernel(attr);
 			if (ret)
 				return ret;
 		}
@@ -10932,10 +10919,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel) {
-		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
-
-		err = security_perf_event_open(&attr, PERF_SECURITY_KERNEL);
+		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
 	}
@@ -10954,9 +10938,11 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	/* Only privileged users can get physical addresses */
-	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
+		err = perf_allow_kernel(&attr);
+		if (err)
+			return err;
+	}
 
 	err = security_locked_down(LOCKDOWN_PERF);
 	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -49,11 +49,7 @@ static int perf_trace_event_perm(struct
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
-
-		ret = security_perf_event_open(&p_event->attr,
-					       PERF_SECURITY_TRACEPOINT);
+		ret = perf_allow_tracepoint(&p->event->attr);
 		if (ret)
 			return ret;
 
@@ -90,11 +86,7 @@ static int perf_trace_event_perm(struct
 	 * ...otherwise raw tracepoint data can be a severe data leak,
 	 * only allow root to have these.
 	 */
-	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	ret = security_perf_event_open(&p_event->attr,
-				       PERF_SECURITY_TRACEPOINT);
+	ret = perf_allow_tracepoint(&p_event->attr);
 	if (ret)
 		return ret;
 

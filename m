Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE33D67E6
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfJNRDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Oct 2019 13:03:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36746 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJNRDi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 13:03:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so10739143pfr.3
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2019 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO0c6tYSmPUBT3y+kN9xZya/V3TEdwqnhg1zyevEw7w=;
        b=ycrS+zAsD+Smxe+p8V2ttZ4i+E1VVtSzKmKcGHs91x7Zgp1AVOBFTsJUjpw0qkaQow
         NuJbL1FSwmLZABwEoGPQy77PMhydvuc/NAp3BTWkZ5/klB+S8Bk6on/qv0xXvcXuJzQV
         gc4P5kk5F3rsWBPmSJVhZWy7mh/rPGr9yvEaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO0c6tYSmPUBT3y+kN9xZya/V3TEdwqnhg1zyevEw7w=;
        b=iMLxGQGqfWeY62B16pSeXiZSZLRdX594CiY/FiwyecZCkfJoPmXPUwrkkmJ0V1emSB
         3I2qhEA9KO70jhSbyiZkp5dt72em4flti4a7xuD2h12uruzFk2WRXErJD4rTGGxBPufh
         adCuyrNWNPjPNMNBb+/55kBqFc9Cfm7lMk5sjXD21g6RivPk5JwXi9tAxIm1f6SFOzpi
         g8mp1jX5JQLr4fPIV8X3IHWHfupe21rWS1DrR3WUsynN3Y3M3fwwE8NftPWwBVjmBDWo
         qr6D74/xVCxBzcixzVpJpYPvuH6B2T6OpwNlbXU61h0Jpo+RvBTD9AZ1E76mbOpfmPCg
         c88w==
X-Gm-Message-State: APjAAAV/V1qVScIZlq5f5wThdTdyFQI4IT+3+rEq2hzW5Mz0rQ4AxXJg
        KpgjcCht0HO+G2IvlOZDrK3dqQ==
X-Google-Smtp-Source: APXvYqx3t+Xh37zik6smtmY4wPkFCDFHCdcm8kaVNjn90OrYzOPo8KZnTY7RqMR9XxrC3WaacKyubA==
X-Received: by 2002:a17:90a:8d06:: with SMTP id c6mr35472544pjo.141.1571072617468;
        Mon, 14 Oct 2019 10:03:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z20sm20070148pfj.156.2019.10.14.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:03:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, James Morris <jmorris@namei.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2] perf_event: Add support for LSM and SELinux checks
Date:   Mon, 14 Oct 2019 13:03:08 -0400
Message-Id: <20191014170308.70668-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In current mainline, the degree of access to perf_event_open(2) system
call depends on the perf_event_paranoid sysctl.  This has a number of
limitations:

1. The sysctl is only a single value. Many types of accesses are controlled
   based on the single value thus making the control very limited and
   coarse grained.
2. The sysctl is global, so if the sysctl is changed, then that means
   all processes get access to perf_event_open(2) opening the door to
   security issues.

This patch adds LSM and SELinux access checking which will be used in
Android to access perf_event_open(2) for the purposes of attaching BPF
programs to tracepoints, perf profiling and other operations from
userspace. These operations are intended for production systems.

5 new LSM hooks are added:
1. perf_event_open: This controls access during the perf_event_open(2)
   syscall itself. The hook is called from all the places that the
   perf_event_paranoid sysctl is checked to keep it consistent with the
   systctl. The hook gets passed a 'type' argument which controls CPU,
   kernel and tracepoint accesses (in this context, CPU, kernel and
   tracepoint have the same semantics as the perf_event_paranoid sysctl).
   Additionally, I added an 'open' type which is similar to
   perf_event_paranoid sysctl == 3 patch carried in Android and several other
   distros but was rejected in mainline [1] in 2016.

2. perf_event_alloc: This allocates a new security object for the event
   which stores the current SID within the event. It will be useful when
   the perf event's FD is passed through IPC to another process which may
   try to read the FD. Appropriate security checks will limit access.

3. perf_event_free: Called when the event is closed.

4. perf_event_read: Called from the read(2) and mmap(2) syscalls for the event.

5. perf_event_write: Called from the ioctl(2) syscalls for the event.

[1] https://lwn.net/Articles/696240/

Since Peter had suggest LSM hooks in 2016 [1], I am adding his
Suggested-by tag below.

To use this patch, we set the perf_event_paranoid sysctl to -1 and then
apply selinux checking as appropriate (default deny everything, and then
add policy rules to give access to domains that need it). In the future
we can remove the perf_event_paranoid sysctl altogether.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org
Cc: primiano@google.com
Cc: rsavitski@google.com
Cc: jeffv@google.com
Cc: kernel-team@android.com
Acked-by: James Morris <jmorris@namei.org>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---

Changes since v1:
 o Fixes from Peter Ziljstra.
 o Added Ack from James Morris and Co-developed-by tag for Peter.
Changes since RFC:
 o Small nits, style changes (James Morris).
 o Consolidation of code (Peter Zijlstra).


 arch/x86/events/intel/bts.c         |  8 ++--
 arch/x86/events/intel/core.c        |  5 ++-
 arch/x86/events/intel/p4.c          |  5 ++-
 include/linux/lsm_hooks.h           | 15 +++++++
 include/linux/perf_event.h          | 28 +++++++++---
 include/linux/security.h            | 39 +++++++++++++++-
 include/uapi/linux/perf_event.h     |  9 ++++
 kernel/events/core.c                | 57 +++++++++++++++++++-----
 kernel/trace/trace_event_perf.c     | 15 ++++---
 security/security.c                 | 27 +++++++++++
 security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 security/selinux/include/objsec.h   |  6 ++-
 13 files changed, 255 insertions(+), 30 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 5ee3fed881d3..38de4a7f6752 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -549,9 +549,11 @@ static int bts_event_init(struct perf_event *event)
 	 * Note that the default paranoia setting permits unprivileged
 	 * users to profile the kernel.
 	 */
-	if (event->attr.exclude_kernel && perf_paranoid_kernel() &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	if (event->attr.exclude_kernel) {
+		ret = perf_allow_kernel(&event->attr);
+		if (ret)
+			return ret;
+	}
 
 	if (x86_add_exclusive(x86_lbr_exclusive_bts))
 		return -EBUSY;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 27ee47a7be66..32967a9e9962 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3315,8 +3315,9 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (x86_pmu.version < 3)
 		return -EINVAL;
 
-	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	ret = perf_allow_cpu(&event->attr);
+	if (ret)
+		return ret;
 
 	event->hw.config |= ARCH_PERFMON_EVENTSEL_ANY;
 
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index dee579efb2b2..a4cc66005ce8 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -776,8 +776,9 @@ static int p4_validate_raw_event(struct perf_event *event)
 	 * the user needs special permissions to be able to use it
 	 */
 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
+		v = perf_allow_cpu(&event->attr);
+		if (v)
+			return v;
 	}
 
 	/* ESCR EventMask bits may be invalid */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a3763247547c..20d8cf194fb7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1818,6 +1818,14 @@ union security_list_options {
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
 	int (*locked_down)(enum lockdown_reason what);
+#ifdef CONFIG_PERF_EVENTS
+	int (*perf_event_open)(struct perf_event_attr *attr, int type);
+	int (*perf_event_alloc)(struct perf_event *event);
+	void (*perf_event_free)(struct perf_event *event);
+	int (*perf_event_read)(struct perf_event *event);
+	int (*perf_event_write)(struct perf_event *event);
+
+#endif
 };
 
 struct security_hook_heads {
@@ -2060,6 +2068,13 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
 	struct hlist_head locked_down;
+#ifdef CONFIG_PERF_EVENTS
+	struct hlist_head perf_event_open;
+	struct hlist_head perf_event_alloc;
+	struct hlist_head perf_event_free;
+	struct hlist_head perf_event_read;
+	struct hlist_head perf_event_write;
+#endif
 } __randomize_layout;
 
 /*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..664bb7f99c46 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -56,6 +56,7 @@ struct perf_guest_info_callbacks {
 #include <linux/perf_regs.h>
 #include <linux/cgroup.h>
 #include <linux/refcount.h>
+#include <linux/security.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -721,6 +722,9 @@ struct perf_event {
 	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
 #endif
 
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 	struct list_head		sb_list;
 #endif /* CONFIG_PERF_EVENTS */
 };
@@ -1241,19 +1245,33 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 int perf_event_max_stack_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp, loff_t *ppos);
 
-static inline bool perf_paranoid_tracepoint_raw(void)
+static inline int perf_is_paranoid(void)
 {
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline bool perf_paranoid_cpu(void)
+static inline int perf_allow_kernel(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > 0;
+	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
 }
 
-static inline bool perf_paranoid_kernel(void)
+static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > 1;
+	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_CPU);
+}
+
+static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
 extern void perf_event_init(void);
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..273e11c66ed7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1894,5 +1894,42 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
-#endif /* ! __LINUX_SECURITY_H */
+#ifdef CONFIG_PERF_EVENTS
+struct perf_event_attr;
+
+#ifdef CONFIG_SECURITY
+extern int security_perf_event_open(struct perf_event_attr *attr, int type);
+extern int security_perf_event_alloc(struct perf_event *event);
+extern void security_perf_event_free(struct perf_event *event);
+extern int security_perf_event_read(struct perf_event *event);
+extern int security_perf_event_write(struct perf_event *event);
+#else
+static inline int security_perf_event_open(struct perf_event_attr *attr,
+					   int type)
+{
+	return 0;
+}
 
+static inline int security_perf_event_alloc(struct perf_event *event)
+{
+	return 0;
+}
+
+static inline void security_perf_event_free(struct perf_event *event)
+{
+	return 0;
+}
+
+static inline int security_perf_event_read(struct perf_event *event)
+{
+	return 0;
+}
+
+static inline int security_perf_event_write(struct perf_event *event)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_PERF_EVENTS */
+
+#endif /* ! __LINUX_SECURITY_H */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..2af95f937a5b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -427,6 +427,15 @@ struct perf_event_attr {
 	__u16	__reserved_2;	/* align to __u64 */
 };
 
+
+/* Access to perf_event_open(2) syscall. */
+#define PERF_SECURITY_OPEN		0
+
+/* Finer grained perf_event_open(2) access control. */
+#define PERF_SECURITY_CPU		1
+#define PERF_SECURITY_KERNEL		2
+#define PERF_SECURITY_TRACEPOINT	3
+
 /*
  * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
  * to query bpf programs attached to the same perf tracepoint
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4655adbbae10..8ad597fae5f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4217,8 +4217,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-			return ERR_PTR(-EACCES);
+		err = perf_allow_cpu(&event->attr);
+		if (err)
+			return ERR_PTR(err);
 
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		ctx = &cpuctx->ctx;
@@ -4527,6 +4528,8 @@ static void _free_event(struct perf_event *event)
 
 	unaccount_event(event);
 
+	security_perf_event_free(event);
+
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.
@@ -4980,6 +4983,10 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct perf_event_context *ctx;
 	int ret;
 
+	ret = security_perf_event_read(event);
+	if (ret)
+		return ret;
+
 	ctx = perf_event_ctx_lock(event);
 	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
@@ -5244,6 +5251,11 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct perf_event_context *ctx;
 	long ret;
 
+	/* Treat ioctl like writes as it is likely a mutating operation. */
+	ret = security_perf_event_write(event);
+	if (ret)
+		return ret;
+
 	ctx = perf_event_ctx_lock(event);
 	ret = _perf_ioctl(event, cmd, arg);
 	perf_event_ctx_unlock(event, ctx);
@@ -5706,6 +5718,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
+	ret = security_perf_event_read(event);
+	if (ret)
+		return ret;
+
 	vma_size = vma->vm_end - vma->vm_start;
 
 	if (vma->vm_pgoff == 0) {
@@ -5819,7 +5835,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	lock_limit >>= PAGE_SHIFT;
 	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
 
-	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
+	if ((locked > lock_limit) && perf_is_paranoid() &&
 		!capable(CAP_IPC_LOCK)) {
 		ret = -EPERM;
 		goto unlock;
@@ -10553,11 +10569,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		}
 	}
 
+	err = security_perf_event_alloc(event);
+	if (err)
+		goto err_callchain_buffer;
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
+err_callchain_buffer:
+	if (!event->parent) {
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+			put_callchain_buffers();
+	}
 err_addr_filters:
 	kfree(event->addr_filter_ranges);
 
@@ -10675,9 +10700,11 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			attr->branch_sample_type = mask;
 		}
 		/* privileged levels capture (kernel, hv): check permissions */
-		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
-		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
+		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
+			ret = perf_allow_kernel(attr);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
@@ -10890,13 +10917,19 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & ~PERF_FLAG_ALL)
 		return -EINVAL;
 
+	/* Do we allow access to perf_event_open(2) ? */
+	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
+	if (err)
+		return err;
+
 	err = perf_copy_attr(attr_uptr, &attr);
 	if (err)
 		return err;
 
 	if (!attr.exclude_kernel) {
-		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
+		err = perf_allow_kernel(&attr);
+		if (err)
+			return err;
 	}
 
 	if (attr.namespaces) {
@@ -10913,9 +10946,11 @@ SYSCALL_DEFINE5(perf_event_open,
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
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 0892e38ed6fb..0917fee6ee7c 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/security.h>
 #include "trace.h"
 #include "trace_probe.h"
 
@@ -26,8 +27,10 @@ static int	total_ref_count;
 static int perf_trace_event_perm(struct trace_event_call *tp_event,
 				 struct perf_event *p_event)
 {
+	int ret;
+
 	if (tp_event->perf_perm) {
-		int ret = tp_event->perf_perm(tp_event, p_event);
+		ret = tp_event->perf_perm(tp_event, p_event);
 		if (ret)
 			return ret;
 	}
@@ -46,8 +49,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		ret = perf_allow_tracepoint(&p_event->attr);
+		if (ret)
+			return ret;
 
 		if (!is_sampling_event(p_event))
 			return 0;
@@ -82,8 +86,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	 * ...otherwise raw tracepoint data can be a severe data leak,
 	 * only allow root to have these.
 	 */
-	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	ret = perf_allow_tracepoint(&p_event->attr);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..cd2d18d2d279 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2404,3 +2404,30 @@ int security_locked_down(enum lockdown_reason what)
 	return call_int_hook(locked_down, 0, what);
 }
 EXPORT_SYMBOL(security_locked_down);
+
+#ifdef CONFIG_PERF_EVENTS
+int security_perf_event_open(struct perf_event_attr *attr, int type)
+{
+	return call_int_hook(perf_event_open, 0, attr, type);
+}
+
+int security_perf_event_alloc(struct perf_event *event)
+{
+	return call_int_hook(perf_event_alloc, 0, event);
+}
+
+void security_perf_event_free(struct perf_event *event)
+{
+	call_void_hook(perf_event_free, event);
+}
+
+int security_perf_event_read(struct perf_event *event)
+{
+	return call_int_hook(perf_event_read, 0, event);
+}
+
+int security_perf_event_write(struct perf_event *event)
+{
+	return call_int_hook(perf_event_write, 0, event);
+}
+#endif /* CONFIG_PERF_EVENTS */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99e677f..28eb05490d59 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6795,6 +6795,67 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 };
 
+#ifdef CONFIG_PERF_EVENTS
+static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
+{
+	u32 requested, sid = current_sid();
+
+	if (type == PERF_SECURITY_OPEN)
+		requested = PERF_EVENT__OPEN;
+	else if (type == PERF_SECURITY_CPU)
+		requested = PERF_EVENT__CPU;
+	else if (type == PERF_SECURITY_KERNEL)
+		requested = PERF_EVENT__KERNEL;
+	else if (type == PERF_SECURITY_TRACEPOINT)
+		requested = PERF_EVENT__TRACEPOINT;
+	else
+		return -EINVAL;
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_PERF_EVENT,
+			    requested, NULL);
+}
+
+static int selinux_perf_event_alloc(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec;
+
+	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
+	if (!perfsec)
+		return -ENOMEM;
+
+	perfsec->sid = current_sid();
+	event->security = perfsec;
+
+	return 0;
+}
+
+static void selinux_perf_event_free(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec = event->security;
+
+	event->security = NULL;
+	kfree(perfsec);
+}
+
+static int selinux_perf_event_read(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec = event->security;
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
+}
+
+static int selinux_perf_event_write(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec = event->security;
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
+}
+#endif
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -7030,6 +7091,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
+
+#ifdef CONFIG_PERF_EVENTS
+	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
+	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
+	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
+	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
+	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
+#endif
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..7db24855e12d 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "perf_event",
+	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ NULL }
   };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 586b7abd0aa7..a4a86cbcfb0a 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -141,7 +141,11 @@ struct pkey_security_struct {
 };
 
 struct bpf_security_struct {
-	u32 sid;  /*SID of bpf obj creater*/
+	u32 sid;  /* SID of bpf obj creator */
+};
+
+struct perf_event_security_struct {
+	u32 sid;  /* SID of perf_event obj creator */
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-- 
2.23.0.700.g56cf767bdb-goog

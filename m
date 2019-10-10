Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727A2D21B1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfJJHiI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 03:38:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:25120 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733100AbfJJHXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 03:23:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 00:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="193915765"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2019 00:23:40 -0700
Received: from [10.252.18.237] (abudanko-mobl.ccr.corp.intel.com [10.252.18.237])
        by linux.intel.com (Postfix) with ESMTP id E88BB5802BC;
        Thu, 10 Oct 2019 00:23:33 -0700 (PDT)
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
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
        Yonghong Song <yhs@fb.com>, elena.reshetova@intel.com,
        Andi Kleen <ak@linux.intel.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2c2f8666-b757-2c5b-1fcc-b6c9b061f870@linux.intel.com>
Date:   Thu, 10 Oct 2019 10:23:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009203657.6070-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joel,

Thanks for the patch.

On 09.10.2019 23:36, Joel Fernandes (Google) wrote:
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

Please also see considerations here: Documentation/admin-guide/perf-security.rst
According to the document Perf based monitoring can be configured for usage 
by Perf user groups. This option extends perf_event access control beyond 
perf_event_paranoid kernel setting.

One of the possible future steps from that could be to move perf_events
monitoring from under overloaded CAP_SYS_ADMIN to a dedicated CAP_SYS_PERFMON.

It would be appreciated if Perf user groups approach continue be applicable 
as currently documented. Existing Perf tool implementation already relies on it.

It would be also beneficial to augment the document with related information 
regarding Perf extensions related to kernel security.

Thanks,
Alexey

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
> 
> 5. perf_event_write: Called from the read(2) system call path for the event.
> 
> [1] https://lwn.net/Articles/696240/
> 
> Since Peter had suggest LSM hooks in 2016 [1], I am adding his
> Suggested-by tag below.
> 
> To use this patch, we set the perf_event_paranoid sysctl to -1 and then
> apply selinux checking as appropriate (default deny everything, and then
> add policy rules to give access to domains that need it). In the future
> we can remove the perf_event_paranoid sysctl altogether.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: rostedt@goodmis.org
> Cc: primiano@google.com
> Cc: rsavitski@google.com
> Cc: jeffv@google.com
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  arch/x86/events/intel/bts.c         |  5 +++
>  arch/x86/events/intel/core.c        |  5 +++
>  arch/x86/events/intel/p4.c          |  5 +++
>  include/linux/lsm_hooks.h           | 15 +++++++
>  include/linux/perf_event.h          |  3 ++
>  include/linux/security.h            | 39 +++++++++++++++-
>  include/uapi/linux/perf_event.h     | 13 ++++++
>  kernel/events/core.c                | 59 +++++++++++++++++++++---
>  kernel/trace/trace_event_perf.c     | 15 ++++++-
>  security/security.c                 | 33 ++++++++++++++
>  security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 +
>  security/selinux/include/objsec.h   |  6 ++-
>  13 files changed, 259 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 5ee3fed881d3..9796fc094dad 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -14,6 +14,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/coredump.h>
> +#include <linux/security.h>
>  
>  #include <linux/sizes.h>
>  #include <asm/perf_event.h>
> @@ -553,6 +554,10 @@ static int bts_event_init(struct perf_event *event)
>  	    !capable(CAP_SYS_ADMIN))
>  		return -EACCES;
>  
> +	ret = security_perf_event_open(&event->attr, PERF_SECURITY_KERNEL);
> +	if (ret)
> +		return ret;
> +
>  	if (x86_add_exclusive(x86_lbr_exclusive_bts))
>  		return -EBUSY;
>  
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 27ee47a7be66..75b6b9b239ae 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -11,6 +11,7 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/nmi.h>
> @@ -3318,6 +3319,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
>  		return -EACCES;
>  
> +	ret = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +	if (ret)
> +		return ret;
> +
>  	event->hw.config |= ARCH_PERFMON_EVENTSEL_ANY;
>  
>  	return 0;
> diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> index dee579efb2b2..6ac1a0328710 100644
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/perf_event.h>
> +#include <linux/security.h>
>  
>  #include <asm/perf_event_p4.h>
>  #include <asm/hardirq.h>
> @@ -778,6 +779,10 @@ static int p4_validate_raw_event(struct perf_event *event)
>  	if (p4_ht_active() && p4_event_bind_map[v].shared) {
>  		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
>  			return -EACCES;
> +
> +		v = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +		if (v)
> +			return v;
>  	}
>  
>  	/* ESCR EventMask bits may be invalid */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a3763247547c..20d8cf194fb7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1818,6 +1818,14 @@ union security_list_options {
>  	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
>  #endif /* CONFIG_BPF_SYSCALL */
>  	int (*locked_down)(enum lockdown_reason what);
> +#ifdef CONFIG_PERF_EVENTS
> +	int (*perf_event_open)(struct perf_event_attr *attr, int type);
> +	int (*perf_event_alloc)(struct perf_event *event);
> +	void (*perf_event_free)(struct perf_event *event);
> +	int (*perf_event_read)(struct perf_event *event);
> +	int (*perf_event_write)(struct perf_event *event);
> +
> +#endif
>  };
>  
>  struct security_hook_heads {
> @@ -2060,6 +2068,13 @@ struct security_hook_heads {
>  	struct hlist_head bpf_prog_free_security;
>  #endif /* CONFIG_BPF_SYSCALL */
>  	struct hlist_head locked_down;
> +#ifdef CONFIG_PERF_EVENTS
> +	struct hlist_head perf_event_open;
> +	struct hlist_head perf_event_alloc;
> +	struct hlist_head perf_event_free;
> +	struct hlist_head perf_event_read;
> +	struct hlist_head perf_event_write;
> +#endif
>  } __randomize_layout;
>  
>  /*
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..f074bb937800 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -721,6 +721,9 @@ struct perf_event {
>  	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
>  #endif
>  
> +#ifdef CONFIG_SECURITY
> +	void *security;
> +#endif
>  	struct list_head		sb_list;
>  #endif /* CONFIG_PERF_EVENTS */
>  };
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a8d59d612d27..273e11c66ed7 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1894,5 +1894,42 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_BPF_SYSCALL */
>  
> -#endif /* ! __LINUX_SECURITY_H */
> +#ifdef CONFIG_PERF_EVENTS
> +struct perf_event_attr;
> +
> +#ifdef CONFIG_SECURITY
> +extern int security_perf_event_open(struct perf_event_attr *attr, int type);
> +extern int security_perf_event_alloc(struct perf_event *event);
> +extern void security_perf_event_free(struct perf_event *event);
> +extern int security_perf_event_read(struct perf_event *event);
> +extern int security_perf_event_write(struct perf_event *event);
> +#else
> +static inline int security_perf_event_open(struct perf_event_attr *attr,
> +					   int type)
> +{
> +	return 0;
> +}
>  
> +static inline int security_perf_event_alloc(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline void security_perf_event_free(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline int security_perf_event_read(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline int security_perf_event_write(struct perf_event *event)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY */
> +#endif /* CONFIG_PERF_EVENTS */
> +
> +#endif /* ! __LINUX_SECURITY_H */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..5fc904c17dd8 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -427,6 +427,19 @@ struct perf_event_attr {
>  	__u16	__reserved_2;	/* align to __u64 */
>  };
>  
> +
> +/* Access to perf_event_open(2) syscall. */
> +#define PERF_SECURITY_OPEN		0
> +
> +/* Finer grained perf_event_open(2) access control. */
> +#define PERF_SECURITY_CPU		1
> +#define PERF_SECURITY_KERNEL		2
> +#define PERF_SECURITY_TRACEPOINT	3
> +
> +/* VFS access. */
> +#define PERF_SECURITY_READ		4
> +#define PERF_SECURITY_WRITE		5
> +
>  /*
>   * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
>   * to query bpf programs attached to the same perf tracepoint
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4655adbbae10..05915af9d215 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4220,6 +4220,10 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
>  		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
>  			return ERR_PTR(-EACCES);
>  
> +		err = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +		if (err)
> +			return ERR_PTR(err);
> +
>  		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
>  		ctx = &cpuctx->ctx;
>  		get_ctx(ctx);
> @@ -4761,6 +4765,7 @@ int perf_event_release_kernel(struct perf_event *event)
>  	}
>  
>  no_ctx:
> +	security_perf_event_free(event);
>  	put_event(event); /* Must be the 'last' reference */
>  	return 0;
>  }
> @@ -4980,6 +4985,10 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  	struct perf_event_context *ctx;
>  	int ret;
>  
> +	ret = security_perf_event_read(event);
> +	if (ret)
> +		return ret;
> +
>  	ctx = perf_event_ctx_lock(event);
>  	ret = __perf_read(event, buf, count);
>  	perf_event_ctx_unlock(event, ctx);
> @@ -5244,6 +5253,11 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	struct perf_event_context *ctx;
>  	long ret;
>  
> +	/* Treat ioctl like writes as it is likely a mutating operation. */
> +	ret = security_perf_event_write(event);
> +	if (ret)
> +		return ret;
> +
>  	ctx = perf_event_ctx_lock(event);
>  	ret = _perf_ioctl(event, cmd, arg);
>  	perf_event_ctx_unlock(event, ctx);
> @@ -5706,6 +5720,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!(vma->vm_flags & VM_SHARED))
>  		return -EINVAL;
>  
> +	ret = security_perf_event_read(event);
> +	if (ret)
> +		return ret;
> +
>  	vma_size = vma->vm_end - vma->vm_start;
>  
>  	if (vma->vm_pgoff == 0) {
> @@ -5819,10 +5837,16 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  	lock_limit >>= PAGE_SHIFT;
>  	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
>  
> -	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
> -		!capable(CAP_IPC_LOCK)) {
> -		ret = -EPERM;
> -		goto unlock;
> +	if (locked > lock_limit) {
> +		if (perf_paranoid_tracepoint_raw() && !capable(CAP_IPC_LOCK)) {
> +			ret = -EPERM;
> +			goto unlock;
> +		}
> +
> +		ret = security_perf_event_open(&event->attr,
> +					       PERF_SECURITY_TRACEPOINT);
> +		if (ret)
> +			goto unlock;
>  	}
>  
>  	WARN_ON(!rb && event->rb);
> @@ -10553,11 +10577,17 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		}
>  	}
>  
> +#ifdef CONFIG_SECURITY
> +	err = security_perf_event_alloc(event);
> +	if (err)
> +		goto err_security;
> +#endif
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  
>  	return event;
>  
> +err_security:
>  err_addr_filters:
>  	kfree(event->addr_filter_ranges);
>  
> @@ -10675,9 +10705,15 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  			attr->branch_sample_type = mask;
>  		}
>  		/* privileged levels capture (kernel, hv): check permissions */
> -		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
> -		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> +		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
> +			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> +				return -EACCES;
> +
> +			ret = security_perf_event_open(attr,
> +						       PERF_SECURITY_KERNEL);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
> @@ -10890,6 +10926,11 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (flags & ~PERF_FLAG_ALL)
>  		return -EINVAL;
>  
> +	/* Do we allow access to perf_event_open(2) ? */
> +	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
> +	if (err)
> +		return err;
> +
>  	err = perf_copy_attr(attr_uptr, &attr);
>  	if (err)
>  		return err;
> @@ -10897,6 +10938,10 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (!attr.exclude_kernel) {
>  		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>  			return -EACCES;
> +
> +		err = security_perf_event_open(&attr, PERF_SECURITY_KERNEL);
> +		if (err)
> +			return err;
>  	}
>  
>  	if (attr.namespaces) {
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 0892e38ed6fb..7053a47ba344 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
> +#include <linux/security.h>
>  #include "trace.h"
>  #include "trace_probe.h"
>  
> @@ -26,8 +27,10 @@ static int	total_ref_count;
>  static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  				 struct perf_event *p_event)
>  {
> +	int ret;
> +
>  	if (tp_event->perf_perm) {
> -		int ret = tp_event->perf_perm(tp_event, p_event);
> +		ret = tp_event->perf_perm(tp_event, p_event);
>  		if (ret)
>  			return ret;
>  	}
> @@ -49,6 +52,11 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
>  			return -EPERM;
>  
> +		ret = security_perf_event_open(&p_event->attr,
> +					       PERF_SECURITY_TRACEPOINT);
> +		if (ret)
> +			return ret;
> +
>  		if (!is_sampling_event(p_event))
>  			return 0;
>  
> @@ -85,6 +93,11 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	ret = security_perf_event_open(&p_event->attr,
> +				       PERF_SECURITY_TRACEPOINT);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index 1bc000f834e2..7639bca1db59 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2373,26 +2373,32 @@ int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>  {
>  	return call_int_hook(bpf, 0, cmd, attr, size);
>  }
> +
>  int security_bpf_map(struct bpf_map *map, fmode_t fmode)
>  {
>  	return call_int_hook(bpf_map, 0, map, fmode);
>  }
> +
>  int security_bpf_prog(struct bpf_prog *prog)
>  {
>  	return call_int_hook(bpf_prog, 0, prog);
>  }
> +
>  int security_bpf_map_alloc(struct bpf_map *map)
>  {
>  	return call_int_hook(bpf_map_alloc_security, 0, map);
>  }
> +
>  int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
>  {
>  	return call_int_hook(bpf_prog_alloc_security, 0, aux);
>  }
> +
>  void security_bpf_map_free(struct bpf_map *map)
>  {
>  	call_void_hook(bpf_map_free_security, map);
>  }
> +
>  void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  {
>  	call_void_hook(bpf_prog_free_security, aux);
> @@ -2404,3 +2410,30 @@ int security_locked_down(enum lockdown_reason what)
>  	return call_int_hook(locked_down, 0, what);
>  }
>  EXPORT_SYMBOL(security_locked_down);
> +
> +#ifdef CONFIG_PERF_EVENTS
> +int security_perf_event_open(struct perf_event_attr *attr, int type)
> +{
> +	return call_int_hook(perf_event_open, 0, attr, type);
> +}
> +
> +int security_perf_event_alloc(struct perf_event *event)
> +{
> +	return call_int_hook(perf_event_alloc, 0, event);
> +}
> +
> +void security_perf_event_free(struct perf_event *event)
> +{
> +	call_void_hook(perf_event_free, event);
> +}
> +
> +int security_perf_event_read(struct perf_event *event)
> +{
> +	return call_int_hook(perf_event_read, 0, event);
> +}
> +
> +int security_perf_event_write(struct perf_event *event)
> +{
> +	return call_int_hook(perf_event_write, 0, event);
> +}
> +#endif /* CONFIG_PERF_EVENTS */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9625b99e677f..28eb05490d59 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6795,6 +6795,67 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  	.lbs_msg_msg = sizeof(struct msg_security_struct),
>  };
>  
> +#ifdef CONFIG_PERF_EVENTS
> +static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
> +{
> +	u32 requested, sid = current_sid();
> +
> +	if (type == PERF_SECURITY_OPEN)
> +		requested = PERF_EVENT__OPEN;
> +	else if (type == PERF_SECURITY_CPU)
> +		requested = PERF_EVENT__CPU;
> +	else if (type == PERF_SECURITY_KERNEL)
> +		requested = PERF_EVENT__KERNEL;
> +	else if (type == PERF_SECURITY_TRACEPOINT)
> +		requested = PERF_EVENT__TRACEPOINT;
> +	else
> +		return -EINVAL;
> +
> +	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_PERF_EVENT,
> +			    requested, NULL);
> +}
> +
> +static int selinux_perf_event_alloc(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec;
> +
> +	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
> +	if (!perfsec)
> +		return -ENOMEM;
> +
> +	perfsec->sid = current_sid();
> +	event->security = perfsec;
> +
> +	return 0;
> +}
> +
> +static void selinux_perf_event_free(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec = event->security;
> +
> +	event->security = NULL;
> +	kfree(perfsec);
> +}
> +
> +static int selinux_perf_event_read(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec = event->security;
> +	u32 sid = current_sid();
> +
> +	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
> +}
> +
> +static int selinux_perf_event_write(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec = event->security;
> +	u32 sid = current_sid();
> +
> +	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
> +}
> +#endif
> +
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -7030,6 +7091,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>  	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>  #endif
> +
> +#ifdef CONFIG_PERF_EVENTS
> +	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
> +	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> +	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
> +	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
> +	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
> +#endif
>  };
>  
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 32e9b03be3dd..7db24855e12d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
>  	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
>  	{ "xdp_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "perf_event",
> +	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
>  	{ NULL }
>    };
>  
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 586b7abd0aa7..a4a86cbcfb0a 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -141,7 +141,11 @@ struct pkey_security_struct {
>  };
>  
>  struct bpf_security_struct {
> -	u32 sid;  /*SID of bpf obj creater*/
> +	u32 sid;  /* SID of bpf obj creator */
> +};
> +
> +struct perf_event_security_struct {
> +	u32 sid;  /* SID of perf_event obj creator */
>  };
>  
>  extern struct lsm_blob_sizes selinux_blob_sizes;
> 

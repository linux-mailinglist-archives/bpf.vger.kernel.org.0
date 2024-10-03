Return-Path: <bpf+bounces-40820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154798EC7F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933F5B23699
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8228148316;
	Thu,  3 Oct 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxNYKdIC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23B1465B1;
	Thu,  3 Oct 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949091; cv=none; b=l2+gP9rdhUB7MZOkEOwhjiSYGfIJSOqZMFcwuq63+8InOjGiXl5z5kVjc5CaCRHg6vt0UEciC0S4GChwiZUdD/2A/tXKLiP6s7gMVaRcrfvM4uLat+1oEC5J0GG9LwqHQ1pckn81w+Kr35flwUtuYPW6rSlLbOkqgwkziDWJVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949091; c=relaxed/simple;
	bh=Si4AO8bmr5zh0crwOJyiSyOVE4e7YZtZNzoKn6v/baU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yrlnx8me47Ym5Zq/Sx5bgL2ftgOZ95+HbA2TbIqjcyHADMz9d69lWzf8q2TvDhhLWCFXPRaFIgo4R4ha/e6sIhrUYgU7HdCocJItctwEzaROU/tFmS7vTWWD1xrhWBtcUm9mTn1coV8tSSeVAQUOkkCV90+u/hfNocUlya3vx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxNYKdIC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727949089; x=1759485089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Si4AO8bmr5zh0crwOJyiSyOVE4e7YZtZNzoKn6v/baU=;
  b=bxNYKdICdjFNcYyIStxCfXUoYg5EhBxwdwNcaHjhAC9Y5xYUXDI/raqW
   TBp5CTxJt1s5l68emYHn8cV4OH59b4GkzkkR/qddMELFFy3q9VwukLyn5
   WwYQ31hP9kMPQO0yf32oKdI8fGF4zLr4Jp00Q2mhA8nC/CONxc5X7o2/F
   4dXfWiZUuXaHohx9C7SZoPI/guxOV5TkNcVfzfT0XRQoSeOSlPWaw2MMn
   G44LtDgj73U8y3JBPYLlecOxzxdJEoFbmz9EqywfpDFU01gH73TMlNEXZ
   ZfqofL7DccLyHEwbRvYMZTz2r+1gkFU4uv62zL9fuC6AWyojF+HmIrHno
   g==;
X-CSE-ConnectionGUID: QJNQrVRATm2a7+5ANbiFAA==
X-CSE-MsgGUID: 7gEnsr2uSPeOnDRuPMU7Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26943322"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="26943322"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:51:28 -0700
X-CSE-ConnectionGUID: vG1DlwenSeSooZeRAscPxw==
X-CSE-MsgGUID: c6VKx68URv6QboloIHNNYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74547793"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Oct 2024 02:51:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swIUS-0000Fe-2L;
	Thu, 03 Oct 2024 09:51:20 +0000
Date: Thu, 3 Oct 2024 17:51:03 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH resend 1/8] tracing: Declare system call tracepoints with
 TRACE_EVENT_SYSCALL
Message-ID: <202410031716.sTBC2OLt-lkp@intel.com>
References: <20240930192357.1154417-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930192357.1154417-2-mathieu.desnoyers@efficios.com>

Hi Mathieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on peterz-queue/sched/core]
[also build test ERROR on linus/master v6.12-rc1 next-20241003]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/tracing-Declare-system-call-tracepoints-with-TRACE_EVENT_SYSCALL/20241001-032827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
patch link:    https://lore.kernel.org/r/20240930192357.1154417-2-mathieu.desnoyers%40efficios.com
patch subject: [PATCH resend 1/8] tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20241003/202410031716.sTBC2OLt-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031716.sTBC2OLt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031716.sTBC2OLt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:93,
                    from include/linux/entry-common.h:7,
                    from kernel/entry/common.c:4:
   include/trace/events/syscalls.h:20:18: error: expected ')' before 'struct'
      20 |         TP_PROTO(struct pt_regs *regs, long id),
         |                  ^~~~~~
   include/linux/tracepoint.h:106:25: note: in definition of macro 'PARAMS'
     106 | #define PARAMS(args...) args
         |                         ^~~~
   include/linux/tracepoint.h:614:9: note: in expansion of macro 'DECLARE_TRACE_SYSCALL'
     614 |         DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:614:37: note: in expansion of macro 'PARAMS'
     614 |         DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
         |                                     ^~~~~~
   include/trace/events/syscalls.h:18:1: note: in expansion of macro 'TRACE_EVENT_SYSCALL'
      18 | TRACE_EVENT_SYSCALL(sys_enter,
         | ^~~~~~~~~~~~~~~~~~~
   include/trace/events/syscalls.h:20:9: note: in expansion of macro 'TP_PROTO'
      20 |         TP_PROTO(struct pt_regs *regs, long id),
         |         ^~~~~~~~
   include/trace/events/syscalls.h:46:18: error: expected ')' before 'struct'
      46 |         TP_PROTO(struct pt_regs *regs, long ret),
         |                  ^~~~~~
   include/linux/tracepoint.h:106:25: note: in definition of macro 'PARAMS'
     106 | #define PARAMS(args...) args
         |                         ^~~~
   include/linux/tracepoint.h:614:9: note: in expansion of macro 'DECLARE_TRACE_SYSCALL'
     614 |         DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:614:37: note: in expansion of macro 'PARAMS'
     614 |         DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
         |                                     ^~~~~~
   include/trace/events/syscalls.h:44:1: note: in expansion of macro 'TRACE_EVENT_SYSCALL'
      44 | TRACE_EVENT_SYSCALL(sys_exit,
         | ^~~~~~~~~~~~~~~~~~~
   include/trace/events/syscalls.h:46:9: note: in expansion of macro 'TP_PROTO'
      46 |         TP_PROTO(struct pt_regs *regs, long ret),
         |         ^~~~~~~~
   kernel/entry/common.c: In function 'syscall_trace_enter':
>> kernel/entry/common.c:61:17: error: implicit declaration of function 'trace_syscall_sys_enter' [-Wimplicit-function-declaration]
      61 |                 trace_syscall_sys_enter(regs, syscall);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/entry/common.c: In function 'syscall_exit_work':
>> kernel/entry/common.c:169:17: error: implicit declaration of function 'trace_syscall_sys_exit' [-Wimplicit-function-declaration]
     169 |                 trace_syscall_sys_exit(regs, syscall_get_return_value(current, regs));
         |                 ^~~~~~~~~~~~~~~~~~~~~~


vim +/trace_syscall_sys_enter +61 kernel/entry/common.c

    27	
    28	long syscall_trace_enter(struct pt_regs *regs, long syscall,
    29					unsigned long work)
    30	{
    31		long ret = 0;
    32	
    33		/*
    34		 * Handle Syscall User Dispatch.  This must comes first, since
    35		 * the ABI here can be something that doesn't make sense for
    36		 * other syscall_work features.
    37		 */
    38		if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
    39			if (syscall_user_dispatch(regs))
    40				return -1L;
    41		}
    42	
    43		/* Handle ptrace */
    44		if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
    45			ret = ptrace_report_syscall_entry(regs);
    46			if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
    47				return -1L;
    48		}
    49	
    50		/* Do seccomp after ptrace, to catch any tracer changes. */
    51		if (work & SYSCALL_WORK_SECCOMP) {
    52			ret = __secure_computing(NULL);
    53			if (ret == -1L)
    54				return ret;
    55		}
    56	
    57		/* Either of the above might have changed the syscall number */
    58		syscall = syscall_get_nr(current, regs);
    59	
    60		if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
  > 61			trace_syscall_sys_enter(regs, syscall);
    62			/*
    63			 * Probes or BPF hooks in the tracepoint may have changed the
    64			 * system call number as well.
    65			 */
    66			syscall = syscall_get_nr(current, regs);
    67		}
    68	
    69		syscall_enter_audit(regs, syscall);
    70	
    71		return ret ? : syscall;
    72	}
    73	
    74	noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
    75	{
    76		enter_from_user_mode(regs);
    77		instrumentation_begin();
    78		local_irq_enable();
    79		instrumentation_end();
    80	}
    81	
    82	/* Workaround to allow gradual conversion of architecture code */
    83	void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
    84	
    85	/**
    86	 * exit_to_user_mode_loop - do any pending work before leaving to user space
    87	 * @regs:	Pointer to pt_regs on entry stack
    88	 * @ti_work:	TIF work flags as read by the caller
    89	 */
    90	__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
    91							     unsigned long ti_work)
    92	{
    93		/*
    94		 * Before returning to user space ensure that all pending work
    95		 * items have been completed.
    96		 */
    97		while (ti_work & EXIT_TO_USER_MODE_WORK) {
    98	
    99			local_irq_enable_exit_to_user(ti_work);
   100	
   101			if (ti_work & _TIF_NEED_RESCHED)
   102				schedule();
   103	
   104			if (ti_work & _TIF_UPROBE)
   105				uprobe_notify_resume(regs);
   106	
   107			if (ti_work & _TIF_PATCH_PENDING)
   108				klp_update_patch_state(current);
   109	
   110			if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
   111				arch_do_signal_or_restart(regs);
   112	
   113			if (ti_work & _TIF_NOTIFY_RESUME)
   114				resume_user_mode_work(regs);
   115	
   116			/* Architecture specific TIF work */
   117			arch_exit_to_user_mode_work(regs, ti_work);
   118	
   119			/*
   120			 * Disable interrupts and reevaluate the work flags as they
   121			 * might have changed while interrupts and preemption was
   122			 * enabled above.
   123			 */
   124			local_irq_disable_exit_to_user();
   125	
   126			/* Check if any of the above work has queued a deferred wakeup */
   127			tick_nohz_user_enter_prepare();
   128	
   129			ti_work = read_thread_flags();
   130		}
   131	
   132		/* Return the latest work state for arch_exit_to_user_mode() */
   133		return ti_work;
   134	}
   135	
   136	/*
   137	 * If SYSCALL_EMU is set, then the only reason to report is when
   138	 * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
   139	 * instruction has been already reported in syscall_enter_from_user_mode().
   140	 */
   141	static inline bool report_single_step(unsigned long work)
   142	{
   143		if (work & SYSCALL_WORK_SYSCALL_EMU)
   144			return false;
   145	
   146		return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
   147	}
   148	
   149	static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
   150	{
   151		bool step;
   152	
   153		/*
   154		 * If the syscall was rolled back due to syscall user dispatching,
   155		 * then the tracers below are not invoked for the same reason as
   156		 * the entry side was not invoked in syscall_trace_enter(): The ABI
   157		 * of these syscalls is unknown.
   158		 */
   159		if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
   160			if (unlikely(current->syscall_dispatch.on_dispatch)) {
   161				current->syscall_dispatch.on_dispatch = false;
   162				return;
   163			}
   164		}
   165	
   166		audit_syscall_exit(regs);
   167	
   168		if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 > 169			trace_syscall_sys_exit(regs, syscall_get_return_value(current, regs));
   170	
   171		step = report_single_step(work);
   172		if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
   173			ptrace_report_syscall_exit(regs, step);
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


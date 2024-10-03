Return-Path: <bpf+bounces-40821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4598EC80
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C25D1F22B5A
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2455149C4A;
	Thu,  3 Oct 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngxFSt/D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1D1482F3;
	Thu,  3 Oct 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949093; cv=none; b=TcXiXmFC5eVGp/36zu/YrdquWfXgTwW6WuFORD0qsXOBByo5lRMenwIh6Yb2FqkwtLab1DH7Rex8hywcbiu6BD7k8ap7zWjpOin6NuSohukRTwxnh31yqD9QnaMdds5ajBtL+FQFPrVfe6HRuRLqmlJpXmGgChuQTzdF+IM5+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949093; c=relaxed/simple;
	bh=xizrXnGov7AAOVQuDbwecEI19TyCL4hiyjAWT7N7dyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE6mEr/5aMVu0KtNIkixf1gdyEEVQqEohCuZmA6iLwpaNaQZA9/R7lnAV4fwumGCE3jz144IZ3Zh1sJ61FQ4hmjx58PQy6wN9GDEuo3RP47qlX9Q8lqTsEG/IAjGDoSYLKqxYlupG8hRu1Mloy8vLDygsxd+g8gvG8jI8hcU4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngxFSt/D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727949092; x=1759485092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xizrXnGov7AAOVQuDbwecEI19TyCL4hiyjAWT7N7dyI=;
  b=ngxFSt/DNrlZyRW+zREGp+6XBJn5bF6T+5Zb/odQfg4T0vSgXhKMDiOa
   KmJjovZ1q9vyupWBy8dnGEGc1/5ZRApKKaJRQJmS8IJwz+F/6scV5egcW
   7AM2VR/SwL1Kdc6Y0tziNgRZHpfNE9kkYgYyieEhCgth29GdSdGkF9AcB
   aYycYwPMmQe2ovHey7NfJvZAMKNohS3QRMxLiEOLCagRIVCsF06Oh/+kT
   LK4Bg4Di6DRLGw+aWVYSOGhqPZ8Xq3GQRdyAL3SuZoy2lkwWrKprYNJrZ
   +Rwi/xU3dAwYSVgMSSertEkGEpd4clRb0CJb6Ca9jRi0vG+UAQ4veIo9o
   Q==;
X-CSE-ConnectionGUID: d9yJv+2mQj6edybDDWuh+w==
X-CSE-MsgGUID: c3ao4idzS5GP+s/ONr+cuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26943332"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="26943332"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:51:28 -0700
X-CSE-ConnectionGUID: 2W2P7847Th2tA56LK5cXmw==
X-CSE-MsgGUID: CJbxo7dFRvC6Fqlo0rQvrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74547792"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Oct 2024 02:51:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swIUS-0000Fg-2P;
	Thu, 03 Oct 2024 09:51:20 +0000
Date: Thu, 3 Oct 2024 17:51:10 +0800
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
Message-ID: <202410031750.cFIt2Rmx-lkp@intel.com>
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
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20241003/202410031750.cFIt2Rmx-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031750.cFIt2Rmx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031750.cFIt2Rmx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:93,
                    from arch/powerpc/kernel/ptrace/ptrace.c:19:
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
   arch/powerpc/kernel/ptrace/ptrace.c: In function 'do_syscall_trace_enter':
>> arch/powerpc/kernel/ptrace/ptrace.c:298:17: error: implicit declaration of function 'trace_sys_enter'; did you mean 'ftrace_nmi_enter'? [-Wimplicit-function-declaration]
     298 |                 trace_sys_enter(regs, regs->gpr[0]);
         |                 ^~~~~~~~~~~~~~~
         |                 ftrace_nmi_enter
   arch/powerpc/kernel/ptrace/ptrace.c: In function 'do_syscall_trace_leave':
>> arch/powerpc/kernel/ptrace/ptrace.c:329:17: error: implicit declaration of function 'trace_sys_exit'; did you mean 'ftrace_nmi_exit'? [-Wimplicit-function-declaration]
     329 |                 trace_sys_exit(regs, regs->result);
         |                 ^~~~~~~~~~~~~~
         |                 ftrace_nmi_exit


vim +298 arch/powerpc/kernel/ptrace/ptrace.c

2449acc5348b94 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  235  
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  236  /**
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  237   * do_syscall_trace_enter() - Do syscall tracing on kernel entry.
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  238   * @regs: the pt_regs of the task to trace (current)
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  239   *
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  240   * Performs various types of tracing on syscall entry. This includes seccomp,
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  241   * ptrace, syscall tracepoints and audit.
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  242   *
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  243   * The pt_regs are potentially visible to userspace via ptrace, so their
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  244   * contents is ABI.
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  245   *
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  246   * One or more of the tracers may modify the contents of pt_regs, in particular
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  247   * to modify arguments or even the syscall number itself.
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  248   *
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  249   * It's also possible that a tracer can choose to reject the system call. In
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  250   * that case this function will return an illegal syscall number, and will put
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  251   * an appropriate return value in regs->r3.
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  252   *
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  253   * Return: the (possibly changed) syscall number.
^1da177e4c3f41 arch/ppc/kernel/ptrace.c            Linus Torvalds    2005-04-16  254   */
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  255  long do_syscall_trace_enter(struct pt_regs *regs)
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  256  {
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  257  	u32 flags;
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  258  
985faa78687de6 arch/powerpc/kernel/ptrace/ptrace.c Mark Rutland      2021-11-29  259  	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  260  
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  261  	if (flags) {
153474ba1a4aed arch/powerpc/kernel/ptrace/ptrace.c Eric W. Biederman 2022-01-27  262  		int rc = ptrace_report_syscall_entry(regs);
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  263  
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  264  		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
5521eb4bca2db7 arch/powerpc/kernel/ptrace.c        Breno Leitao      2018-09-20  265  			/*
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  266  			 * A nonzero return code from
153474ba1a4aed arch/powerpc/kernel/ptrace/ptrace.c Eric W. Biederman 2022-01-27  267  			 * ptrace_report_syscall_entry() tells us to prevent
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  268  			 * the syscall execution, but we are not going to
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  269  			 * execute it anyway.
a225f156740555 arch/powerpc/kernel/ptrace.c        Elvira Khabirova  2018-12-07  270  			 *
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  271  			 * Returning -1 will skip the syscall execution. We want
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  272  			 * to avoid clobbering any registers, so we don't goto
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  273  			 * the skip label below.
5521eb4bca2db7 arch/powerpc/kernel/ptrace.c        Breno Leitao      2018-09-20  274  			 */
5521eb4bca2db7 arch/powerpc/kernel/ptrace.c        Breno Leitao      2018-09-20  275  			return -1;
5521eb4bca2db7 arch/powerpc/kernel/ptrace.c        Breno Leitao      2018-09-20  276  		}
5521eb4bca2db7 arch/powerpc/kernel/ptrace.c        Breno Leitao      2018-09-20  277  
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  278  		if (rc) {
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  279  			/*
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  280  			 * The tracer decided to abort the syscall. Note that
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  281  			 * the tracer may also just change regs->gpr[0] to an
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  282  			 * invalid syscall number, that is handled below on the
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  283  			 * exit path.
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  284  			 */
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  285  			goto skip;
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  286  		}
8dbdec0bcb416d arch/powerpc/kernel/ptrace.c        Dmitry V. Levin   2018-12-16  287  	}
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  288  
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  289  	/* Run seccomp after ptrace; allow it to set gpr[3]. */
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  290  	if (do_seccomp(regs))
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  291  		return -1;
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  292  
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  293  	/* Avoid trace and audit when syscall is invalid. */
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  294  	if (regs->gpr[0] >= NR_syscalls)
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  295  		goto skip;
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  296  
02424d8966d803 arch/powerpc/kernel/ptrace.c        Ian Munsie        2011-02-02  297  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
02424d8966d803 arch/powerpc/kernel/ptrace.c        Ian Munsie        2011-02-02 @298  		trace_sys_enter(regs, regs->gpr[0]);
02424d8966d803 arch/powerpc/kernel/ptrace.c        Ian Munsie        2011-02-02  299  
cab175f9fa2973 arch/powerpc/kernel/ptrace.c        Denis Kirjanov    2010-08-27  300  	if (!is_32bit_task())
91397401bb5072 arch/powerpc/kernel/ptrace.c        Eric Paris        2014-03-11  301  		audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  302  				    regs->gpr[5], regs->gpr[6]);
cfcd1705b61ecc arch/powerpc/kernel/ptrace.c        David Woodhouse   2007-01-14  303  	else
91397401bb5072 arch/powerpc/kernel/ptrace.c        Eric Paris        2014-03-11  304  		audit_syscall_entry(regs->gpr[0],
cfcd1705b61ecc arch/powerpc/kernel/ptrace.c        David Woodhouse   2007-01-14  305  				    regs->gpr[3] & 0xffffffff,
cfcd1705b61ecc arch/powerpc/kernel/ptrace.c        David Woodhouse   2007-01-14  306  				    regs->gpr[4] & 0xffffffff,
cfcd1705b61ecc arch/powerpc/kernel/ptrace.c        David Woodhouse   2007-01-14  307  				    regs->gpr[5] & 0xffffffff,
cfcd1705b61ecc arch/powerpc/kernel/ptrace.c        David Woodhouse   2007-01-14  308  				    regs->gpr[6] & 0xffffffff);
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  309  
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  310  	/* Return the possibly modified but valid syscall number */
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  311  	return regs->gpr[0];
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  312  
1addc57e111b92 arch/powerpc/kernel/ptrace.c        Kees Cook         2016-06-02  313  skip:
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  314  	/*
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  315  	 * If we are aborting explicitly, or if the syscall number is
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  316  	 * now invalid, set the return value to -ENOSYS.
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  317  	 */
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  318  	regs->gpr[3] = -ENOSYS;
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  319  	return -1;
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  320  }
d38374142b2560 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2015-07-23  321  
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  322  void do_syscall_trace_leave(struct pt_regs *regs)
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  323  {
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  324  	int step;
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  325  
d7e7528bcd456f arch/powerpc/kernel/ptrace.c        Eric Paris        2012-01-03  326  	audit_syscall_exit(regs);
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  327  
02424d8966d803 arch/powerpc/kernel/ptrace.c        Ian Munsie        2011-02-02  328  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
02424d8966d803 arch/powerpc/kernel/ptrace.c        Ian Munsie        2011-02-02 @329  		trace_sys_exit(regs, regs->result);
02424d8966d803 arch/powerpc/kernel/ptrace.c        Ian Munsie        2011-02-02  330  
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  331  	step = test_thread_flag(TIF_SINGLESTEP);
4f72c4279eab1e arch/powerpc/kernel/ptrace.c        Roland McGrath    2008-07-27  332  	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
153474ba1a4aed arch/powerpc/kernel/ptrace/ptrace.c Eric W. Biederman 2022-01-27  333  		ptrace_report_syscall_exit(regs, step);
ea9c102cb0a796 arch/ppc/kernel/ptrace.c            David Woodhouse   2005-05-08  334  }
002af9391bfbe8 arch/powerpc/kernel/ptrace.c        Michael Ellerman  2018-10-12  335  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


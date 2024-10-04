Return-Path: <bpf+bounces-40929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA099016E
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CAA1F213B1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E8156644;
	Fri,  4 Oct 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTzVqcgi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55193155C98;
	Fri,  4 Oct 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038122; cv=none; b=e/nHo16SroFhYhjsKsKC9BCb00B3NlKzGVEjFDSjNbNv3tycYIrxfIBA661mX3kKzw2ohGutjyp4LJwndfHFOhsx8dKeeyvKBaBG5IbQCO8Rmd+lNZK+nnGwlQD+WoIyyZIcJuZWfl7ycRrkp+bx4IPTBND94ManaCnD8xNfN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038122; c=relaxed/simple;
	bh=eCX4FHv21F1UmXbzAcke3XRP+BTSB2fq8+NGQdMcpuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szq4vaGdANYxHf5s+xXChjK0xzC51M8fgkq+4OMhfRVtDQgIpTSavPzDl4dTQxrENBxJdSSmhHwOC43epqT497ojtBAEai8sfxm65wYqm6EdL7qPRVNV3NuBH6+GBH1c1zzDePjfsK85F/yhyKgmobKgr4CFrW+SCR7nCLwh/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTzVqcgi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728038120; x=1759574120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eCX4FHv21F1UmXbzAcke3XRP+BTSB2fq8+NGQdMcpuI=;
  b=FTzVqcgi3nij3bPKFHKne9XtXpQUSis3dUPrhtVnfvdSa1c+oI75si20
   g5f4PPNyRxvf5q5p11l32a+ZMHsDMKATOzCX0G3tOfNOgSarQcBT/9i2r
   95POICDyeQkSEYXn5a8wVqArxuCeDAaOylOJufnq9rFCH6dIntqjTRRlH
   fPiFgcREWTWOWnphang+/fQ8GTxl4sNOJehOmGtIoC6/Pib2fPEGNNUsy
   TaAbaBn2mWqPhiUltFTczIV4bpdusRP75OqesDqYanAQoqnGURlP4Bir6
   GCt2d2eiG3sr0g7BYHzPJcI+7ChQEf8Eb2lAL6jfbTTJGZtQ4OOdp22uu
   Q==;
X-CSE-ConnectionGUID: wKqU3NOIT0O3Rx9jMfcyRQ==
X-CSE-MsgGUID: uLNqej0ETF+09abN/FO4kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30963942"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="30963942"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:35:18 -0700
X-CSE-ConnectionGUID: 5p8A3KL0Sia6ey7VuKWtCA==
X-CSE-MsgGUID: oQePmqGWQpulC3Rr1s1WeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74992841"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Oct 2024 03:35:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swfeQ-0001Ui-26;
	Fri, 04 Oct 2024 10:35:10 +0000
Date: Fri, 4 Oct 2024 18:34:39 +0800
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
Subject: Re: [PATCH v1 1/8] tracing: Declare system call tracepoints with
 TRACE_EVENT_SYSCALL
Message-ID: <202410041838.pOZuOGTX-lkp@intel.com>
References: <20241003151638.1608537-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003151638.1608537-2-mathieu.desnoyers@efficios.com>

Hi Mathieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on peterz-queue/sched/core]
[also build test ERROR on linus/master tip/core/entry v6.12-rc1 next-20241004]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/tracing-Declare-system-call-tracepoints-with-TRACE_EVENT_SYSCALL/20241003-232114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
patch link:    https://lore.kernel.org/r/20241003151638.1608537-2-mathieu.desnoyers%40efficios.com
patch subject: [PATCH v1 1/8] tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
config: powerpc-randconfig-r071-20241004 (https://download.01.org/0day-ci/archive/20241004/202410041838.pOZuOGTX-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041838.pOZuOGTX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041838.pOZuOGTX-lkp@intel.com/

All errors (new ones prefixed by >>):

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

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


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


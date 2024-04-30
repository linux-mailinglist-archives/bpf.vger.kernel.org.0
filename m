Return-Path: <bpf+bounces-28270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853318B7AA3
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D8C1F22183
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349D7710B;
	Tue, 30 Apr 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cznx0vjH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98A770FC;
	Tue, 30 Apr 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488854; cv=none; b=jFgs4Nxs/uUuv3z/iPuQDivBHeTVkiYV/jRuDFWAsf8Ou8iMqeAjoj1suvba1q0+Q4WyVSNWiTl78KXjnzycbs2x5LK16L0xc3NWt/1ycBnZ4+pZMI9aNTsokpCW+IY3ekTcmVK40napaWPw5qMUsUey5Tl0+HEz3U7nzovcJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488854; c=relaxed/simple;
	bh=zuncjSyTfcytMULigEblM0/EMGTaP0zuv5ek6d9/qUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0E6c1mlOj8/7BXbO7rfwJNDu1nH+SnLcCHSdV6VR0pfjE0N/aFeriZrZSKy7IhkKHFJiwVo4IethYxXfsrJ8tEx9O384JibKw/dcE+WQEOunqEF0zsaZNT/uK3uz716UdnrHJonJFd33mOlHxM4GifpGJk9Oxps9Dy0JP4lArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cznx0vjH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714488853; x=1746024853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zuncjSyTfcytMULigEblM0/EMGTaP0zuv5ek6d9/qUU=;
  b=cznx0vjHjC5+9Wumcr1Lo8fN7RjZcldC7sUVheN7CPEHeqIOKohaGx+G
   30vGgLNqNo5Et/7wMV0obPxK8jUMvY1ZXXgdKqE12D0PDYrjhObTcCg2s
   LU5A/tc9RU+R+/a7bQS6rzG0PSVoxsRxODoRJeDxqDjB6mkxTIfCHfUjp
   Flg8TZpGezv3++GXJtri0oMD0kMLDqqAgHgCX6E6RXupXD42NW1ciIP+L
   upna8b7FC4K+ZCXo7PWqzgMc/+VcIhxfDivHGmMG6PbaI4q7Xyyr3ecPw
   E5JW4YOb9B+MXE1AL1x103Dsn7ZcTBGaxUpu+MEnXNmQd+PYy+K/SnwdW
   Q==;
X-CSE-ConnectionGUID: TfxuxxlmTDiJElYw/oB25w==
X-CSE-MsgGUID: 8C+eIr75S1KoU5wjF2Ta5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14026723"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="14026723"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:54:03 -0700
X-CSE-ConnectionGUID: 7r3ZTzCCRCW/YrxOcixkTw==
X-CSE-MsgGUID: 2JGdtH8iTIKOToXMh7bimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26571482"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Apr 2024 07:53:59 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1orl-0008EY-02;
	Tue, 30 Apr 2024 14:53:57 +0000
Date: Tue, 30 Apr 2024 22:53:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Hillf Danton <hdanton@sina.com>,
	Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>,
	Adrian Bunk <bunk@kernel.org>,
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	andrii@kernel.org, bpf@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
Message-ID: <202404302220.EkdfEBSB-lkp@intel.com>
References: <Zi9Ts1HcqiKzy9GX@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi9Ts1HcqiKzy9GX@gmail.com>

Hi Ingo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linux/master]
[also build test WARNING on tip/x86/mm linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/x86-mm-Remove-broken-vsyscall-emulation-code-from-the-page-fault-code/20240430-135258
base:   linux/master
patch link:    https://lore.kernel.org/r/Zi9Ts1HcqiKzy9GX%40gmail.com
patch subject: [PATCH] x86/mm: Remove broken vsyscall emulation code from the page fault code
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240430/202404302220.EkdfEBSB-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404302220.EkdfEBSB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404302220.EkdfEBSB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/entry/vsyscall/vsyscall_64.c: In function 'emulate_vsyscall':
>> arch/x86/entry/vsyscall/vsyscall_64.c:118:29: warning: variable 'tsk' set but not used [-Wunused-but-set-variable]
     118 |         struct task_struct *tsk;
         |                             ^~~


vim +/tsk +118 arch/x86/entry/vsyscall/vsyscall_64.c

4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  114  
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  115  bool emulate_vsyscall(unsigned long error_code,
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  116  		      struct pt_regs *regs, unsigned long address)
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  117  {
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05 @118  	struct task_struct *tsk;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  119  	unsigned long caller;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  120  	int vsyscall_nr, syscall_nr, tmp;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  121  	long ret;
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  122  	unsigned long orig_dx;
7460ed2844ffad arch/x86_64/kernel/vsyscall.c         John Stultz           2007-02-16  123  
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  124  	/* Write faults or kernel-privilege faults never get fixed up. */
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  125  	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  126  		return false;
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  127  
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  128  	if (!(error_code & X86_PF_INSTR)) {
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  129  		/* Failed vsyscall read */
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  130  		if (vsyscall_mode == EMULATE)
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  131  			return false;
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  132  
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  133  		/*
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  134  		 * User code tried and failed to read the vsyscall page.
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  135  		 */
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  136  		warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  137  		return false;
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  138  	}
918ce325098a4e arch/x86/entry/vsyscall/vsyscall_64.c Andy Lutomirski       2019-06-26  139  
c9712944b2a123 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-07-13  140  	/*
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  141  	 * No point in checking CS -- the only way to get here is a user mode
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  142  	 * trap to a high address, which means that we're in 64-bit user code.
c9712944b2a123 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-07-13  143  	 */
7460ed2844ffad arch/x86_64/kernel/vsyscall.c         John Stultz           2007-02-16  144  
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  145  	WARN_ON_ONCE(address != regs->ip);
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  146  
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  147  	if (vsyscall_mode == NONE) {
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  148  		warn_bad_vsyscall(KERN_INFO, regs,
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  149  				  "vsyscall attempted with vsyscall=none");
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  150  		return false;
c9712944b2a123 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-07-13  151  	}
7460ed2844ffad arch/x86_64/kernel/vsyscall.c         John Stultz           2007-02-16  152  
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  153  	vsyscall_nr = addr_to_vsyscall_nr(address);
c149a665ac488e arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-03  154  
c149a665ac488e arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-03  155  	trace_emulate_vsyscall(vsyscall_nr);
c149a665ac488e arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-03  156  
c9712944b2a123 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-07-13  157  	if (vsyscall_nr < 0) {
c9712944b2a123 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-07-13  158  		warn_bad_vsyscall(KERN_WARNING, regs,
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  159  				  "misaligned vsyscall (exploit attempt or buggy program) -- look up the vsyscall kernel parameter if you need a workaround");
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  160  		goto sigsegv;
7460ed2844ffad arch/x86_64/kernel/vsyscall.c         John Stultz           2007-02-16  161  	}
7460ed2844ffad arch/x86_64/kernel/vsyscall.c         John Stultz           2007-02-16  162  
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  163  	if (get_user(caller, (unsigned long __user *)regs->sp) != 0) {
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  164  		warn_bad_vsyscall(KERN_WARNING, regs,
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  165  				  "vsyscall with bad stack (exploit attempt?)");
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  166  		goto sigsegv;
^1da177e4c3f41 arch/x86_64/kernel/vsyscall.c         Linus Torvalds        2005-04-16  167  	}
^1da177e4c3f41 arch/x86_64/kernel/vsyscall.c         Linus Torvalds        2005-04-16  168  
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  169  	tsk = current;
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  170  
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  171  	/*
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  172  	 * Check for access_ok violations and find the syscall nr.
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  173  	 *
46ed99d1b7c929 arch/x86/kernel/vsyscall_64.c         Emil Goode            2012-04-01  174  	 * NULL is a valid user pointer (in the access_ok sense) on 32-bit and
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  175  	 * 64-bit, so we don't need to special-case it here.  For all the
46ed99d1b7c929 arch/x86/kernel/vsyscall_64.c         Emil Goode            2012-04-01  176  	 * vsyscalls, NULL means "don't write anything" not "write it at
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  177  	 * address 0".
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  178  	 */
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  179  	switch (vsyscall_nr) {
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  180  	case 0:
ddccf40fe82b7a arch/x86/entry/vsyscall/vsyscall_64.c Arnd Bergmann         2017-11-23  181  		if (!write_ok_or_segv(regs->di, sizeof(struct __kernel_old_timeval)) ||
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  182  		    !write_ok_or_segv(regs->si, sizeof(struct timezone))) {
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  183  			ret = -EFAULT;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  184  			goto check_fault;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  185  		}
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  186  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  187  		syscall_nr = __NR_gettimeofday;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  188  		break;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  189  
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  190  	case 1:
21346564ccad17 arch/x86/entry/vsyscall/vsyscall_64.c Arnd Bergmann         2019-11-05  191  		if (!write_ok_or_segv(regs->di, sizeof(__kernel_old_time_t))) {
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  192  			ret = -EFAULT;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  193  			goto check_fault;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  194  		}
5651721edec25b arch/x86/kernel/vsyscall_64.c         Will Drewry           2012-07-13  195  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  196  		syscall_nr = __NR_time;
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  197  		break;
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  198  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  199  	case 2:
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  200  		if (!write_ok_or_segv(regs->di, sizeof(unsigned)) ||
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  201  		    !write_ok_or_segv(regs->si, sizeof(unsigned))) {
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  202  			ret = -EFAULT;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  203  			goto check_fault;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  204  		}
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  205  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  206  		syscall_nr = __NR_getcpu;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  207  		break;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  208  	}
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  209  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  210  	/*
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  211  	 * Handle seccomp.  regs->ip must be the original value.
5fb94e9ca333f0 arch/x86/entry/vsyscall/vsyscall_64.c Mauro Carvalho Chehab 2018-05-08  212  	 * See seccomp_send_sigsys and Documentation/userspace-api/seccomp_filter.rst.
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  213  	 *
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  214  	 * We could optimize the seccomp disabled case, but performance
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  215  	 * here doesn't matter.
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  216  	 */
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  217  	regs->orig_ax = syscall_nr;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  218  	regs->ax = -ENOSYS;
fefad9ef58ffc2 arch/x86/entry/vsyscall/vsyscall_64.c Christian Brauner     2019-09-24  219  	tmp = secure_computing();
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  220  	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  221  		warn_bad_vsyscall(KERN_DEBUG, regs,
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  222  				  "seccomp tried to change syscall nr or ip");
fcb116bc43c8c3 arch/x86/entry/vsyscall/vsyscall_64.c Eric W. Biederman     2021-11-18  223  		force_exit_sig(SIGSYS);
695dd0d634df89 arch/x86/entry/vsyscall/vsyscall_64.c Eric W. Biederman     2021-10-20  224  		return true;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  225  	}
26893107aa717c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2014-11-04  226  	regs->orig_ax = -1;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  227  	if (tmp)
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  228  		goto do_ret;  /* skip requested */
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  229  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  230  	/*
198d72414c92c7 arch/x86/entry/vsyscall/vsyscall_64.c Ingo Molnar           2024-04-29  231  	 * With a real vsyscall, page faults cause SIGSEGV.
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  232  	 */
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  233  	ret = -EFAULT;
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  234  	switch (vsyscall_nr) {
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  235  	case 0:
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  236  		/* this decodes regs->di and regs->si on its own */
d5a00528b58cdb arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-09  237  		ret = __x64_sys_gettimeofday(regs);
5651721edec25b arch/x86/kernel/vsyscall_64.c         Will Drewry           2012-07-13  238  		break;
5651721edec25b arch/x86/kernel/vsyscall_64.c         Will Drewry           2012-07-13  239  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  240  	case 1:
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  241  		/* this decodes regs->di on its own */
d5a00528b58cdb arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-09  242  		ret = __x64_sys_time(regs);
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  243  		break;
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  244  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  245  	case 2:
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  246  		/* while we could clobber regs->dx, we didn't in the past... */
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  247  		orig_dx = regs->dx;
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  248  		regs->dx = 0;
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  249  		/* this decodes regs->di, regs->si and regs->dx on its own */
d5a00528b58cdb arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-09  250  		ret = __x64_sys_getcpu(regs);
fa697140f9a201 arch/x86/entry/vsyscall/vsyscall_64.c Dominik Brodowski     2018-04-05  251  		regs->dx = orig_dx;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  252  		break;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  253  	}
8c73626ab28527 arch/x86/kernel/vsyscall_64.c         John Stultz           2010-07-13  254  
87b526d349b04c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2012-10-01  255  check_fault:
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  256  	if (ret == -EFAULT) {
4fc3490114bb15 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-11-07  257  		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  258  		warn_bad_vsyscall(KERN_INFO, regs,
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  259  				  "vsyscall fault (exploit attempt?)");
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  260  		goto sigsegv;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  261  	}
8c73626ab28527 arch/x86/kernel/vsyscall_64.c         John Stultz           2010-07-13  262  
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  263  	regs->ax = ret;
8c73626ab28527 arch/x86/kernel/vsyscall_64.c         John Stultz           2010-07-13  264  
5651721edec25b arch/x86/kernel/vsyscall_64.c         Will Drewry           2012-07-13  265  do_ret:
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  266  	/* Emulate a ret instruction. */
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  267  	regs->ip = caller;
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  268  	regs->sp += 8;
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  269  	return true;
c08c820508233b arch/x86_64/kernel/vsyscall.c         Vojtech Pavlik        2006-09-26  270  
5cec93c216db77 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-06-05  271  sigsegv:
3cf5d076fb4d48 arch/x86/entry/vsyscall/vsyscall_64.c Eric W. Biederman     2019-05-23  272  	force_sig(SIGSEGV);
3ae36655b97a03 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski       2011-08-10  273  	return true;
^1da177e4c3f41 arch/x86_64/kernel/vsyscall.c         Linus Torvalds        2005-04-16  274  }
^1da177e4c3f41 arch/x86_64/kernel/vsyscall.c         Linus Torvalds        2005-04-16  275  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


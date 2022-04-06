Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA94F6B6F
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 22:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiDFUaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 16:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiDFUag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 16:30:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477F71A2C;
        Wed,  6 Apr 2022 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649271214; x=1680807214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDjbw3xHp1tpEP1vfxMQjIQaEu6sE5eZy4txLa+bhfQ=;
  b=JuS9y2IF3JVyOmAPpLMJ2YDrBcF/jKWWGJRWAm5KUMesac0BKhxhfLZ8
   2ZZlYVs3hRBVJ40GL2pwNfClW/6EhB/MuQoS+aLCndpPSfF6DuZJ6AJAA
   JJaG043hnhD2UiAqsnVCI6F8segBNSw1l21gli6von+lrQwe+xjonY7Kd
   57tstRnpTmW29l3D2RPklrhL83KVc8fTikAdWb5zf5Dx6Qb3WmeuOH7fR
   TapitGv1UnYUehbKID5SrwPv7hHNQ85J/uEy6bon2uJXCSFpymZ6NivyG
   CQUje1bqcvE0HmnOPxJ8E8GDWtoAfWwVpWsiDNJxqRfUonHax4gALOG7R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="259964631"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="259964631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="642174203"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2022 11:53:28 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncAmW-0004ev-5s;
        Wed, 06 Apr 2022 18:53:28 +0000
Date:   Thu, 7 Apr 2022 02:53:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf 1/4] ARM: unwind: Initialize the lr_addr field of
 unwind_ctrl_block
Message-ID: <202204070204.g3wpjuJi-lkp@intel.com>
References: <164915122721.982637.1510683757540074397.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164915122721.982637.1510683757540074397.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu/kprobes-rethook-ARM-arm64-Replace-kretprobe-trampoline-with-rethook/20220405-195153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: arm-randconfig-s032-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070204.g3wpjuJi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/99971b0c57ce1501eda858656ed06758bbd4e376
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masami-Hiramatsu/kprobes-rethook-ARM-arm64-Replace-kretprobe-trampoline-with-rethook/20220405-195153
        git checkout 99971b0c57ce1501eda858656ed06758bbd4e376
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/kernel/unwind.c:407:24: sparse: sparse: Using plain integer as NULL pointer

vim +407 arch/arm/kernel/unwind.c

   377	
   378	/*
   379	 * Unwind a single frame starting with *sp for the symbol at *pc. It
   380	 * updates the *pc and *sp with the new values.
   381	 */
   382	int unwind_frame(struct stackframe *frame)
   383	{
   384		const struct unwind_idx *idx;
   385		struct unwind_ctrl_block ctrl;
   386		unsigned long sp_low;
   387	
   388		/* store the highest address on the stack to avoid crossing it*/
   389		sp_low = frame->sp;
   390		ctrl.sp_high = ALIGN(sp_low - THREAD_SIZE, THREAD_ALIGN)
   391			       + THREAD_SIZE;
   392	
   393		pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
   394			 frame->pc, frame->lr, frame->sp);
   395	
   396		idx = unwind_find_idx(frame->pc);
   397		if (!idx) {
   398			if (frame->pc && kernel_text_address(frame->pc))
   399				pr_warn("unwind: Index not found %08lx\n", frame->pc);
   400			return -URC_FAILURE;
   401		}
   402	
   403		ctrl.vrs[FP] = frame->fp;
   404		ctrl.vrs[SP] = frame->sp;
   405		ctrl.vrs[LR] = frame->lr;
   406		ctrl.vrs[PC] = 0;
 > 407		ctrl.lr_addr = 0;
   408	
   409		if (idx->insn == 1)
   410			/* can't unwind */
   411			return -URC_FAILURE;
   412		else if (frame->pc == prel31_to_addr(&idx->addr_offset)) {
   413			/*
   414			 * Unwinding is tricky when we're halfway through the prologue,
   415			 * since the stack frame that the unwinder expects may not be
   416			 * fully set up yet. However, one thing we do know for sure is
   417			 * that if we are unwinding from the very first instruction of
   418			 * a function, we are still effectively in the stack frame of
   419			 * the caller, and the unwind info has no relevance yet.
   420			 */
   421			if (frame->pc == frame->lr)
   422				return -URC_FAILURE;
   423			frame->pc = frame->lr;
   424			return URC_OK;
   425		} else if ((idx->insn & 0x80000000) == 0)
   426			/* prel31 to the unwind table */
   427			ctrl.insn = (unsigned long *)prel31_to_addr(&idx->insn);
   428		else if ((idx->insn & 0xff000000) == 0x80000000)
   429			/* only personality routine 0 supported in the index */
   430			ctrl.insn = &idx->insn;
   431		else {
   432			pr_warn("unwind: Unsupported personality routine %08lx in the index at %p\n",
   433				idx->insn, idx);
   434			return -URC_FAILURE;
   435		}
   436	
   437		/* check the personality routine */
   438		if ((*ctrl.insn & 0xff000000) == 0x80000000) {
   439			ctrl.byte = 2;
   440			ctrl.entries = 1;
   441		} else if ((*ctrl.insn & 0xff000000) == 0x81000000) {
   442			ctrl.byte = 1;
   443			ctrl.entries = 1 + ((*ctrl.insn & 0x00ff0000) >> 16);
   444		} else {
   445			pr_warn("unwind: Unsupported personality routine %08lx at %p\n",
   446				*ctrl.insn, ctrl.insn);
   447			return -URC_FAILURE;
   448		}
   449	
   450		ctrl.check_each_pop = 0;
   451	
   452		if (prel31_to_addr(&idx->addr_offset) == (u32)&call_with_stack) {
   453			/*
   454			 * call_with_stack() is the only place where we permit SP to
   455			 * jump from one stack to another, and since we know it is
   456			 * guaranteed to happen, set up the SP bounds accordingly.
   457			 */
   458			sp_low = frame->fp;
   459			ctrl.sp_high = ALIGN(frame->fp, THREAD_SIZE);
   460		}
   461	
   462		while (ctrl.entries > 0) {
   463			int urc;
   464			if ((ctrl.sp_high - ctrl.vrs[SP]) < sizeof(ctrl.vrs))
   465				ctrl.check_each_pop = 1;
   466			urc = unwind_exec_insn(&ctrl);
   467			if (urc < 0)
   468				return urc;
   469			if (ctrl.vrs[SP] < sp_low || ctrl.vrs[SP] > ctrl.sp_high)
   470				return -URC_FAILURE;
   471		}
   472	
   473		if (ctrl.vrs[PC] == 0)
   474			ctrl.vrs[PC] = ctrl.vrs[LR];
   475	
   476		/* check for infinite loop */
   477		if (frame->pc == ctrl.vrs[PC] && frame->sp == ctrl.vrs[SP])
   478			return -URC_FAILURE;
   479	
   480		frame->fp = ctrl.vrs[FP];
   481		frame->sp = ctrl.vrs[SP];
   482		frame->lr = ctrl.vrs[LR];
   483		frame->pc = ctrl.vrs[PC];
   484		frame->lr_addr = ctrl.lr_addr;
   485	
   486		return URC_OK;
   487	}
   488	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

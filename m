Return-Path: <bpf+bounces-11868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413067C4B91
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DF61C20D36
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3918E14;
	Wed, 11 Oct 2023 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNoW/9pZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C818C2D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 07:17:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD0090;
	Wed, 11 Oct 2023 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697008656; x=1728544656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXg2wEQCreA5bYXJyzy3HRYJ0Jes4DTVCpbQGgIvo8w=;
  b=TNoW/9pZI6wxJ4+E59pshqtWudaxIiXF6T4533d7l0VNuXfrAjpyUq6o
   GrMFYX0mfQzJrA7GESKRxmfPbUh2Ngqc6rc6y0wdF/bk2rLqdi2Pxdnpg
   UxWxMuwqbf18UL/Sx97wQBDHmcIn9WPN1MKuL02fzZQFXQ3FcrFxAVQL3
   NOVaXtuRYunNCvDnBi2AiwLhFv5ob1LSR23t1wXSUTdPAq0W0DSauTRFV
   DWtxmXBb7WWcmJFq6kBNnzRRT4bnvVnggiPQ6OdMqGYQ1NwOnMue91BPh
   Hk6Q5EoRK9bhrm2J50MSLoRYHJG5/56a2lCIcNjCLvVQXykNDIx43OTWy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3190302"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3190302"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747350894"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="747350894"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2023 00:17:32 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqTTF-0001u5-3B;
	Wed, 11 Oct 2023 07:17:29 +0000
Date: Wed, 11 Oct 2023 15:16:41 +0800
From: kernel test robot <lkp@intel.com>
To: Hengqi Chen <hengqi.chen@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	keescook@chromium.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, luto@amacapital.net, wad@chromium.org,
	alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: Re: [PATCH 2/4] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
Message-ID: <202310111556.DzEDzt3Z-lkp@intel.com>
References: <20231009124046.74710-3-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-3-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Hengqi,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/seccomp]
[also build test ERROR on bpf-next/master bpf/master kees/for-next/pstore kees/for-next/kspp linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hengqi-Chen/seccomp-Refactor-filter-copy-create-for-reuse/20231010-100354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/seccomp
patch link:    https://lore.kernel.org/r/20231009124046.74710-3-hengqi.chen%40gmail.com
patch subject: [PATCH 2/4] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310111556.DzEDzt3Z-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310111556.DzEDzt3Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111556.DzEDzt3Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/seccomp.c:29:
   In file included from include/linux/syscalls.h:90:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/seccomp.c:29:
   In file included from include/linux/syscalls.h:90:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/seccomp.c:29:
   In file included from include/linux/syscalls.h:90:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> kernel/seccomp.c:2046:8: error: implicit declaration of function 'security_bpf_prog_alloc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           ret = security_bpf_prog_alloc(prog->aux);
                 ^
   kernel/seccomp.c:2046:8: note: did you mean 'security_msg_msg_alloc'?
   include/linux/security.h:1245:19: note: 'security_msg_msg_alloc' declared here
   static inline int security_msg_msg_alloc(struct msg_msg *msg)
                     ^
>> kernel/seccomp.c:2056:8: error: implicit declaration of function 'bpf_prog_new_fd' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           ret = bpf_prog_new_fd(prog);
                 ^
   12 warnings and 2 errors generated.


vim +/security_bpf_prog_alloc +2046 kernel/seccomp.c

  2031	
  2032	static long seccomp_load_filter(const char __user *filter)
  2033	{
  2034		struct sock_fprog fprog;
  2035		struct bpf_prog *prog;
  2036		int ret;
  2037	
  2038		ret = seccomp_copy_user_filter(filter, &fprog);
  2039		if (ret)
  2040			return ret;
  2041	
  2042		ret = seccomp_prepare_prog(&prog, &fprog);
  2043		if (ret)
  2044			return ret;
  2045	
> 2046		ret = security_bpf_prog_alloc(prog->aux);
  2047		if (ret) {
  2048			bpf_prog_free(prog);
  2049			return ret;
  2050		}
  2051	
  2052		prog->aux->user = get_current_user();
  2053		atomic64_set(&prog->aux->refcnt, 1);
  2054		prog->type = BPF_PROG_TYPE_SECCOMP;
  2055	
> 2056		ret = bpf_prog_new_fd(prog);
  2057		if (ret < 0)
  2058			bpf_prog_put(prog);
  2059		return ret;
  2060	}
  2061	#else
  2062	static inline long seccomp_set_mode_filter(unsigned int flags,
  2063						   const char __user *filter)
  2064	{
  2065		return -EINVAL;
  2066	}
  2067	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


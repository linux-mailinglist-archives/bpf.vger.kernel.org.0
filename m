Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC9518014
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiECIxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiECIxS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 04:53:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C736332
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651567784; x=1683103784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0xp0nnIya6SZHB35HRYNszZ1txj5JbqsqqLbxHJ3iI=;
  b=bpSV2cSp2jkoFN4Q00dEfdldV+tugwuBdfg5/Nr3+U27VrvQZHgn6K0v
   5dKXUxKpE39PhKCF2lVsVFv5RvZxXpZHjVIdBCTdt9LI7xEAVc685IjDt
   +hwiWhU08vyW+Wi0G4eTRZ+PylZce3n0f07GvegEjqaPHBawl/7LbFsJ8
   vDv6EPpza/avD7Im7BksWgH1p8MIHpeQ7sZ5jhnQ7SMNHV46qmHbGMPap
   ILZx80jduO4a1z0R+6TH/cEyVJjO3aeB9rPZ/fsCGjB/PBjULx0NzYyO+
   Y7oI9oiYnRYG9ucV/N6mA7R0XMjXKTDEslCg5MhsDPKJsOvPlA0GZga8M
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267023058"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267023058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 01:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="733831904"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 01:49:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nloDp-000AIz-2d;
        Tue, 03 May 2022 08:49:29 +0000
Date:   Tue, 3 May 2022 16:48:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Message-ID: <202205031643.UGYirnXb-lkp@intel.com>
References: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Delyan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: s390-randconfig-r003-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031643.UGYirnXb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/cfa0f114829902b579da16d7520a39317905c502
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
        git checkout cfa0f114829902b579da16d7520a39317905c502
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_uprobe.c:10:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/trace/trace_uprobe.c:10:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/trace/trace_uprobe.c:10:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> kernel/trace/trace_uprobe.c:1349:9: error: call to undeclared function 'uprobe_call_bpf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = uprobe_call_bpf(call, regs);
                         ^
   kernel/trace/trace_uprobe.c:1349:9: note: did you mean 'trace_call_bpf'?
   include/linux/trace_events.h:752:28: note: 'trace_call_bpf' declared here
   static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
                              ^
   12 warnings and 1 error generated.


vim +/uprobe_call_bpf +1349 kernel/trace/trace_uprobe.c

  1334	
  1335	static void __uprobe_perf_func(struct trace_uprobe *tu,
  1336				       unsigned long func, struct pt_regs *regs,
  1337				       struct uprobe_cpu_buffer *ucb, int dsize)
  1338	{
  1339		struct trace_event_call *call = trace_probe_event_call(&tu->tp);
  1340		struct uprobe_trace_entry_head *entry;
  1341		struct hlist_head *head;
  1342		void *data;
  1343		int size, esize;
  1344		int rctx;
  1345	
  1346		if (bpf_prog_array_valid(call)) {
  1347			u32 ret;
  1348	
> 1349			ret = uprobe_call_bpf(call, regs);
  1350			if (!ret)
  1351				return;
  1352		}
  1353	
  1354		esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
  1355	
  1356		size = esize + tu->tp.size + dsize;
  1357		size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
  1358		if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
  1359			return;
  1360	
  1361		preempt_disable();
  1362		head = this_cpu_ptr(call->perf_events);
  1363		if (hlist_empty(head))
  1364			goto out;
  1365	
  1366		entry = perf_trace_buf_alloc(size, NULL, &rctx);
  1367		if (!entry)
  1368			goto out;
  1369	
  1370		if (is_ret_probe(tu)) {
  1371			entry->vaddr[0] = func;
  1372			entry->vaddr[1] = instruction_pointer(regs);
  1373			data = DATAOF_TRACE_ENTRY(entry, true);
  1374		} else {
  1375			entry->vaddr[0] = instruction_pointer(regs);
  1376			data = DATAOF_TRACE_ENTRY(entry, false);
  1377		}
  1378	
  1379		memcpy(data, ucb->buf, tu->tp.size + dsize);
  1380	
  1381		if (size - esize > tu->tp.size + dsize) {
  1382			int len = tu->tp.size + dsize;
  1383	
  1384			memset(data + len, 0, size - esize - len);
  1385		}
  1386	
  1387		perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
  1388				      head, NULL);
  1389	 out:
  1390		preempt_enable();
  1391	}
  1392	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4775C6C228D
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCTUZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCTUZE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 16:25:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F09E;
        Mon, 20 Mar 2023 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679343902; x=1710879902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KIVDdjsYnIsbLZQqcW5ppQQ9NCMVMlN1ylEKQ8oyZGY=;
  b=bEos6USIPfLZey4HmrhykyJR/CT9apRb/9eOx8BbgbFqk5bkwAL6h51b
   nSGdvp0lqjlzqyqz6+9vnzrcTWALfk0iWr11wVDMCHP8r+YnY760nb5H4
   sBV8s/YxWCQ3abC45CFdaGaGyBoX2HchPjFjP94xAV6bGAzIbDGwN7fWK
   uvmSRe05EsF0CNe8S0Mka91OZ76jl+RLCrwXHyk43RmjZ/gBoYkdA6BCi
   dyRP832eB+4IN+L2qUm5D8YHL1VbaSrUvU2m3BEs5tE9xbt47oFi5+MJr
   BU0JfKpLGlH1qvrI8R2iTLiW8vnUzyBgac08GDp2NkTN75u49VqqLnicX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319170103"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="319170103"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674546518"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="674546518"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 13:24:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peM3r-000BI6-2k;
        Mon, 20 Mar 2023 20:24:55 +0000
Date:   Tue, 21 Mar 2023 04:24:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?Gon=E7alves?= <nunog@fr24.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org,
        Nuno =?iso-8859-1?Q?Gon=E7alves?= <nunog@fr24.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] xsk: allow remap of fill and/or completion rings
Message-ID: <202303210417.mv8mDIaV-lkp@intel.com>
References: <20230320105323.187307-1-nunog@fr24.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320105323.187307-1-nunog@fr24.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Nuno,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Gon-alves/xsk-allow-remap-of-fill-and-or-completion-rings/20230320-190022
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230320105323.187307-1-nunog%40fr24.com
patch subject: [PATCH bpf-next] xsk: allow remap of fill and/or completion rings
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20230321/202303210417.mv8mDIaV-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/56f6a0c68dd5f4419fd7685cc83ceee2c70f3f2e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nuno-Gon-alves/xsk-allow-remap-of-fill-and-or-completion-rings/20230320-190022
        git checkout 56f6a0c68dd5f4419fd7685cc83ceee2c70f3f2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210417.mv8mDIaV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
           int state = READ_ONCE(xs->state);
                                 ^
>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
>> net/xdp/xsk.c:1303:24: error: use of undeclared identifier 'xs'
>> net/xdp/xsk.c:1303:6: error: initializing 'int' with an expression of incompatible type 'void'
           int state = READ_ONCE(xs->state);
               ^       ~~~~~~~~~~~~~~~~~~~~
>> net/xdp/xsk.c:1318:8: error: cannot take the address of an rvalue of type 'struct xsk_queue *'
                           q = READ_ONCE(state == XSK_READY ? xs->fq_tmp :
                               ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
           ^           ~
   include/asm-generic/rwonce.h:44:70: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                                                                         ^ ~
   net/xdp/xsk.c:1321:8: error: cannot take the address of an rvalue of type 'struct xsk_queue *'
                           q = READ_ONCE(state == XSK_READY ? xs->cq_tmp :
                               ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
           ^           ~
   include/asm-generic/rwonce.h:44:70: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                                                                         ^ ~
   10 errors generated.


vim +/xs +1303 net/xdp/xsk.c

  1297	
  1298	static int xsk_mmap(struct file *file, struct socket *sock,
  1299			    struct vm_area_struct *vma)
  1300	{
  1301		loff_t offset = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
  1302		unsigned long size = vma->vm_end - vma->vm_start;
> 1303		int state = READ_ONCE(xs->state);
  1304		struct xdp_sock *xs = xdp_sk(sock->sk);
  1305		struct xsk_queue *q = NULL;
  1306	
  1307		if (!(state == XSK_READY || state == XSK_BOUND))
  1308			return -EBUSY;
  1309	
  1310		if (offset == XDP_PGOFF_RX_RING) {
  1311			q = READ_ONCE(xs->rx);
  1312		} else if (offset == XDP_PGOFF_TX_RING) {
  1313			q = READ_ONCE(xs->tx);
  1314		} else {
  1315			/* Matches the smp_wmb() in XDP_UMEM_REG */
  1316			smp_rmb();
  1317			if (offset == XDP_UMEM_PGOFF_FILL_RING)
> 1318				q = READ_ONCE(state == XSK_READY ? xs->fq_tmp :
  1319								   xs->pool->fq);
  1320			else if (offset == XDP_UMEM_PGOFF_COMPLETION_RING)
  1321				q = READ_ONCE(state == XSK_READY ? xs->cq_tmp :
  1322								   xs->pool->cq);
  1323		}
  1324	
  1325		if (!q)
  1326			return -EINVAL;
  1327	
  1328		/* Matches the smp_wmb() in xsk_init_queue */
  1329		smp_rmb();
  1330		if (size > q->ring_vmalloc_size)
  1331			return -EINVAL;
  1332	
  1333		return remap_vmalloc_range(vma, q->ring, 0);
  1334	}
  1335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

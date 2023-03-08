Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE76B0E22
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCHQGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 11:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjCHQGU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 11:06:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AEC659E
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 08:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678291503; x=1709827503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BpFetAArDcCPBr/nMaSDYetLHZ8h17rjsD15eRLfVDE=;
  b=naRaBZrrrSatOZXhpDGOYlktpsSKp/Q3bdO+vg362NTSXSAvt8JnPeXS
   hbKbpuKPcMnQjb3O6OsPxw51t4IMBHbQKMWxKMrV/GuUqbMzfTEvnKRex
   aaSUQsN/pvbjXIWM2poBoj2RnXsTjAcQZDJhdHYObs/6S3i16OUR3QuP4
   O9hlfVjhI6UwTTY14jsRiO+zPyhLjXrdmWsxJ99EiAJVDJAwzGWO/urWG
   8IDXWFP/taw6QePgIXZGwdhfHdzvHCmLaPYFxtZTCCLGM+EEIUOM1Eq9/
   LFgizmNjbpNN8fQCzfwisW2RPgeVI3KTkKU6sl8wDWlnQNbTw53FRv0oj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398773091"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="398773091"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 08:03:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="820278713"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="820278713"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2023 08:03:50 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZwGb-0002FB-0b;
        Wed, 08 Mar 2023 16:03:49 +0000
Date:   Thu, 9 Mar 2023 00:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
Cc:     oe-kbuild-all@lists.linux.dev, Kui-Feng Lee <kuifeng@meta.com>
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops
 maps.
Message-ID: <202303082340.qYFHo45I-lkp@intel.com>
References: <20230308005050.255859-4-kuifeng@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308005050.255859-4-kuifeng@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kui-Feng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kui-Feng-Lee/bpf-Retire-the-struct_ops-map-kvalue-refcnt/20230308-085434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230308005050.255859-4-kuifeng%40meta.com
patch subject: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops maps.
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230308/202303082340.qYFHo45I-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/de9e43a5ac82dde718d80d8347e867a8fc935e0a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kui-Feng-Lee/bpf-Retire-the-struct_ops-map-kvalue-refcnt/20230308-085434
        git checkout de9e43a5ac82dde718d80d8347e867a8fc935e0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082340.qYFHo45I-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/virtio_net.c:13:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:35,
                    from net/ipv4/netfilter/nf_reject_ipv4.c:8:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv4/netfilter/nf_reject_ipv4.c: In function 'nf_send_reset':
   net/ipv4/netfilter/nf_reject_ipv4.c:244:23: warning: variable 'niph' set but not used [-Wunused-but-set-variable]
     244 |         struct iphdr *niph;
         |                       ^~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/bpf/core.c:21:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:1632:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1632 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2069:6: warning: no previous prototype for 'bpf_patch_call_args' [-Wmissing-prototypes]
    2069 | void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
         |      ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/kallsyms.c:25:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kallsyms.c:663:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     663 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/bpf-cgroup.h:5,
                    from net/socket.c:55:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/socket.c: In function '__sys_getsockopt':
   net/socket.c:2300:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
    2300 |         int max_optlen;
         |             ^~~~~~~~~~
--
   In file included from net/ipv6/ip6_fib.c:18:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv6/ip6_fib.c: In function 'fib6_add':
   net/ipv6/ip6_fib.c:1378:32: warning: variable 'pn' set but not used [-Wunused-but-set-variable]
    1378 |         struct fib6_node *fn, *pn = NULL;
         |                                ^~
--
   In file included from include/linux/filter.h:9,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:35,
                    from include/linux/netfilter_ipv6.h:11,
                    from net/ipv6/netfilter/nf_reject_ipv6.c:12:
>> include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv6/netfilter/nf_reject_ipv6.c: In function 'nf_send_reset6':
   net/ipv6/netfilter/nf_reject_ipv6.c:287:25: warning: variable 'ip6h' set but not used [-Wunused-but-set-variable]
     287 |         struct ipv6hdr *ip6h;
         |                         ^~~~


vim +/bpf_struct_ops_link_create +2388 include/linux/bpf.h

  2387	
> 2388	static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
  2389	{
  2390		return -EOPNOTSUPP;
  2391	}
  2392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

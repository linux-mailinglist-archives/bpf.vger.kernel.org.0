Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6916A00BB
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjBWBm4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjBWBmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:42:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7143468
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677116565; x=1708652565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4j55WDXCuWKUARN8kIWvlDDEKRrIl/pHrzQzHzInfbA=;
  b=OSssY9OFkCUi9p/rc9OQJi+R4KbvvJhPwLkbYFvQurRzmzkxPwPo71l2
   EYGVw+XSOUolAhJLUZuSxsXze8TEn2OpFa+QILKWyWRBkehIdXqm0uZ6u
   wvsejuiqdBvn644egCrHYowsnFEGkRrONg/KAJankvLV2FmQAzkdDKaZ8
   GRuzKmdXzLa3qItDPPqDaMBkt+hMIHkNivn7IeEqKoi88lEwXguAF/leg
   aiNqJk8nl72heOKZV9+kRKzUUzJFX140Wsq3oHj5Wdv46gIGsSa9JXw9+
   nGaZNg8hizxj7wDCX5lUHYBla2dy+Ai/kOSNppSsrjGypaE+Vt+morcl0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="333092586"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="333092586"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 17:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="815146627"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="815146627"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2023 17:42:40 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV0d6-0000tN-0y;
        Thu, 23 Feb 2023 01:42:40 +0000
Date:   Thu, 23 Feb 2023 09:42:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v8 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <202302230931.vNIpXwzB-lkp@intel.com>
References: <56870b3b449a20872dcff09541967a5a46284c0e.1677075137.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56870b3b449a20872dcff09541967a5a46284c0e.1677075137.git.vmalik@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Viktor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230222-234249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/56870b3b449a20872dcff09541967a5a46284c0e.1677075137.git.vmalik%40redhat.com
patch subject: [PATCH bpf-next v8 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
config: s390-randconfig-r044-20230222 (https://download.01.org/0day-ci/archive/20230223/202302230931.vNIpXwzB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/4c466a8ec9e92ae2a14d722fc6a704a7bec5a1c4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230222-234249
        git checkout 4c466a8ec9e92ae2a14d722fc6a704a7bec5a1c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302230931.vNIpXwzB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
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
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:391:13: note: expanded from macro 'list_for_each_entry_rcu'
                pos = list_entry_rcu((head)->next, typeof(*pos), member);  \
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:2: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:47: note: expanded from macro 'container_of'
           static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: offsetof of incomplete type 'typeof (*mod)' (aka 'struct module')
           list_for_each_entry_rcu(mod, &modules, list,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:391:13: note: expanded from macro 'list_for_each_entry_rcu'
                pos = list_entry_rcu((head)->next, typeof(*pos), member);  \
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:2: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:21: note: expanded from macro 'container_of'
           ((type *)(__mptr - offsetof(type, member))); })
                              ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
   #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
                                   ^                  ~~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: assigning to 'struct module *' from incompatible type 'void'
           list_for_each_entry_rcu(mod, &modules, list,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:391:11: note: expanded from macro 'list_for_each_entry_rcu'
                pos = list_entry_rcu((head)->next, typeof(*pos), member);  \
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:392:7: note: expanded from macro 'list_for_each_entry_rcu'
                   &pos->member != (head);                                 \
                    ~~~^
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:387:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:379:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:387:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:379:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:387:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:379:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:387:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:379:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:387:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:379:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
                       ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                                                                    ^
   include/linux/compiler_types.h:355:13: note: expanded from macro '__unqual_scalar_typeof'
                   _Generic((x),                                           \
                             ^
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
                       ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                                                                    ^
   include/linux/compiler_types.h:362:15: note: expanded from macro '__unqual_scalar_typeof'
                            default: (x)))
                                      ^
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
                       ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                                                                           ^
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: operand of type 'void' where arithmetic or pointer type is required
           list_for_each_entry_rcu(mod, &modules, list,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:9: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:2: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:25: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                  ^~~~~
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                                    ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                                    ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                                    ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                                    ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                                    ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:212:2: error: incomplete definition of type 'struct module'
           list_for_each_entry_rcu(mod, &modules, list,
           ^                       ~~~
   include/linux/rculist.h:393:27: note: expanded from macro 'list_for_each_entry_rcu'
                   pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                        ~~~^
   include/linux/rculist.h:307:25: note: expanded from macro 'list_entry_rcu'
           container_of(READ_ONCE(ptr), type, member)
                                  ^~~
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
                       ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                                    ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   include/linux/jump_label.h:196:8: note: forward declaration of 'struct module'
   struct module;
          ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   12 warnings and 20 errors generated.


vim +212 kernel/bpf/../module/internal.h

58d208de3e8d87 Aaron Tomlin     2022-03-22  204  
58d208de3e8d87 Aaron Tomlin     2022-03-22  205  static inline void mod_tree_insert(struct module *mod) { }
58d208de3e8d87 Aaron Tomlin     2022-03-22  206  static inline void mod_tree_remove_init(struct module *mod) { }
58d208de3e8d87 Aaron Tomlin     2022-03-22  207  static inline void mod_tree_remove(struct module *mod) { }
446d55666d5599 Christophe Leroy 2022-02-23  208  static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *tree)
58d208de3e8d87 Aaron Tomlin     2022-03-22  209  {
58d208de3e8d87 Aaron Tomlin     2022-03-22  210  	struct module *mod;
58d208de3e8d87 Aaron Tomlin     2022-03-22  211  
58d208de3e8d87 Aaron Tomlin     2022-03-22 @212  	list_for_each_entry_rcu(mod, &modules, list,
58d208de3e8d87 Aaron Tomlin     2022-03-22  213  				lockdep_is_held(&module_mutex)) {
58d208de3e8d87 Aaron Tomlin     2022-03-22  214  		if (within_module(addr, mod))
58d208de3e8d87 Aaron Tomlin     2022-03-22  215  			return mod;
58d208de3e8d87 Aaron Tomlin     2022-03-22  216  	}
58d208de3e8d87 Aaron Tomlin     2022-03-22  217  
58d208de3e8d87 Aaron Tomlin     2022-03-22  218  	return NULL;
58d208de3e8d87 Aaron Tomlin     2022-03-22  219  }
58d208de3e8d87 Aaron Tomlin     2022-03-22  220  #endif /* CONFIG_MODULES_TREE_LOOKUP */
b33465fe9c52a3 Aaron Tomlin     2022-03-22  221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

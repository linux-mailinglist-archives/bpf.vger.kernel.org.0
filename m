Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963BF698B76
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 05:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBPEuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 23:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPEuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 23:50:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438D30EA6
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 20:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676523021; x=1708059021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lcszLOk4VDgbu6OWIPG2GRnidptZ6OMvUGF0DcVh9do=;
  b=goyQFMQ1rFoGt8fJyDGTxQWM7Ah8C2oNwBug88g7u+BhH5Mwdv52UXX/
   CgxHFocKsJa+qIeZph6FOcbL5beTsr9hS2dXZSCznpahDeZ7rqDPKdoOO
   3dWpTtPHhxdc8LCozqUpshdCg+EwvvKJglBKbKLra/hdqdsQEX6GALneB
   JQQi0sL5oIGxBUrDc2p4mR+sWEVZZiGwdH65V+DzAy/n8CZOmU5pbPHCU
   HJLUYwJpi/52vArwcDhEtkbAvyF623SeJzPVbn25k9MtqK8Hzbpx80npn
   dJMX5lBDn3F1oUQoT+Ucn+1YNqjV6ht+fhEJdaABSkMbFoGbA1HbGJAX5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311992300"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="311992300"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 20:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="844005709"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="844005709"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2023 20:50:16 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSWDn-000A1H-2C;
        Thu, 16 Feb 2023 04:50:15 +0000
Date:   Thu, 16 Feb 2023 12:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <202302161237.VATmhmIP-lkp@intel.com>
References: <14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik@redhat.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230214-012627
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik%40redhat.com
patch subject: [PATCH bpf-next v5 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
config: arm-randconfig-r005-20230213 (https://download.01.org/0day-ci/archive/20230216/202302161237.VATmhmIP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ae726649987118f58eb95cd056acd6a5f0619a0f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230214-012627
        git checkout ae726649987118f58eb95cd056acd6a5f0619a0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/bpf/ kernel/module/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302161237.VATmhmIP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from include/linux/bpf-cgroup.h:5,
                    from kernel/bpf/verifier.c:7:
   kernel/bpf/../module/internal.h: In function 'mod_find':
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct module'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/rculist.h:391:20: note: in expansion of macro 'list_entry_rcu'
     391 |              pos = list_entry_rcu((head)->next, typeof(*pos), member);  \
         |                    ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:299:27: error: expression in static assertion is not an integer
     299 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/rculist.h:391:20: note: in expansion of macro 'list_entry_rcu'
     391 |              pos = list_entry_rcu((head)->next, typeof(*pos), member);  \
         |                    ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/uapi/linux/btf.h:6,
                    from kernel/bpf/verifier.c:6:
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct module'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/rculist.h:391:20: note: in expansion of macro 'list_entry_rcu'
     391 |              pos = list_entry_rcu((head)->next, typeof(*pos), member);  \
         |                    ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/sched/mm.h:7,
                    from include/linux/xarray.h:19,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/module.h:21,
                    from include/linux/bpf.h:20:
>> include/linux/rculist.h:392:21: error: invalid use of undefined type 'struct module'
     392 |                 &pos->member != (head);                                 \
         |                     ^~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
--
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/asm-generic/rwonce.h:44:43: note: in expansion of macro '__unqual_scalar_typeof'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct module'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '__compiletime_assert'
     346 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:307:22: note: in expansion of macro 'READ_ONCE'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |                      ^~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rculist.h:393:41: error: invalid use of undefined type 'struct module'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
..


vim +20 include/linux/container_of.h

d2a8ebbf8192b8 Andy Shevchenko  2021-11-08   9  
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  10  /**
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  11   * container_of - cast a member of a structure out to the containing structure
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  12   * @ptr:	the pointer to the member.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  13   * @type:	the type of the container struct this is embedded in.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  14   * @member:	the name of the member within the struct.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  15   *
7376e561fd2e01 Sakari Ailus     2022-10-24  16   * WARNING: any const qualifier of @ptr is lost.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  17   */
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  18  #define container_of(ptr, type, member) ({				\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  19  	void *__mptr = (void *)(ptr);					\
e1edc277e6f6df Rasmus Villemoes 2021-11-08 @20  	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
e1edc277e6f6df Rasmus Villemoes 2021-11-08  21  		      __same_type(*(ptr), void),			\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  22  		      "pointer type mismatch in container_of()");	\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  23  	((type *)(__mptr - offsetof(type, member))); })
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  24  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FCA69D5C6
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 22:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBTV0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 16:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBTV0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 16:26:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E91C584
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676928394; x=1708464394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hEQx8h7lDez2tvRGKjhfPXgZNk/iOz0CkJA7OPXzqr8=;
  b=l+sOzKEoRcT2Q4SZ+8uD/VFyf1qK+bdagaw4MJ7WPhAOcRT8R14hf+TH
   esSQpxpr5VNkH48+stv13t1fhkqbMu2Q5JC2o2B7ouxtsL2c3iaqzprq7
   Z0MVdezeK9q/8ICLyNTnI4Alo+3+yjvMF6UkghpAyNXDN7dnR7Eu2nRnP
   EZEnlKvdSBDovwi+mNz+I8+5Y9bzOTSNEZEKer6pWasJ8hTYZV4Pxvz/x
   ERHyHJgwT1MG4TNHUf6QjsU3lEyS6NoWpmtDRgsZMVi0fVSvtrS7Ud0X3
   Wig9kiKX1RDdDUapCBmDwbVCIP7fd14Ne64HWT+CgaUrK/gxoRbV5SuHr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331156901"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="331156901"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 13:26:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="673468199"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="673468199"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2023 13:26:29 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUDg5-000EBB-0x;
        Mon, 20 Feb 2023 21:26:29 +0000
Date:   Tue, 21 Feb 2023 05:26:01 +0800
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
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <202302210531.0XDwgdm6-lkp@intel.com>
References: <ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik@redhat.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230220-184424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik%40redhat.com
patch subject: [PATCH bpf-next v7 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
config: mips-randconfig-r032-20230219 (https://download.01.org/0day-ci/archive/20230221/202302210531.0XDwgdm6-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bd30688a4a403d5e51f5698cfe65bc2012b7cd54
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230220-184424
        git checkout bd30688a4a403d5e51f5698cfe65bc2012b7cd54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302210531.0XDwgdm6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from include/linux/bpf-cgroup.h:5,
                    from kernel/bpf/verifier.c:7:
   kernel/bpf/../module/internal.h: In function 'mod_find':
   include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct module'
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
>> include/linux/compiler_types.h:299:27: error: expression in static assertion is not an integer
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
   In file included from include/linux/dcache.h:8,
                    from include/linux/fs.h:8,
                    from arch/mips/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/bpf.h:20:
   include/linux/rculist.h:392:21: error: invalid use of undefined type 'struct module'
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
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
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
>> include/linux/compiler_types.h:299:27: error: expression in static assertion is not an integer
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
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct module'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/rculist.h:307:9: note: in expansion of macro 'container_of'
     307 |         container_of(READ_ONCE(ptr), type, member)
         |         ^~~~~~~~~~~~
   include/linux/rculist.h:393:23: note: in expansion of macro 'list_entry_rcu'
     393 |                 pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
         |                       ^~~~~~~~~~~~~~
   kernel/bpf/../module/internal.h:212:9: note: in expansion of macro 'list_for_each_entry_rcu'
     212 |         list_for_each_entry_rcu(mod, &modules, list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~


vim +299 include/linux/compiler_types.h

eb111869301e15 Rasmus Villemoes 2019-09-13  297  
d15155824c5014 Will Deacon      2017-10-24  298  /* Are two types/vars the same type (ignoring qualifiers)? */
d15155824c5014 Will Deacon      2017-10-24 @299  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
d15155824c5014 Will Deacon      2017-10-24  300  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

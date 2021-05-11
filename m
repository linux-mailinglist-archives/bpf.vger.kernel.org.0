Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21236379C5A
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 03:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEKB7p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 21:59:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:35726 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhEKB7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 21:59:45 -0400
IronPort-SDR: dVjp+itYLmjt+aLS5qSi/mqzq+PQPk5yumu5Cf6y7WllT/qV0l+TTRVb7RTHS8h7UqCw6VXUNN
 kXIc9VGds4Ug==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284820017"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="gz'50?scan'50,208,50";a="284820017"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 18:58:39 -0700
IronPort-SDR: WGX6rKqaTZnO4jAAdAHAWXlU+cqPykRR6MSZkIsFC2qwGjToEKfHKQlaJLDXkbRZSC6fyu0+oM
 qX+f0ZLHe+2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="gz'50?scan'50,208,50";a="470975897"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 18:58:11 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgHey-0000Te-Cj; Tue, 11 May 2021 01:58:08 +0000
Date:   Tue, 11 May 2021 09:57:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf] bpf: Fix nested bpf_bprintf_prepare with more
 per-cpu buffers
Message-ID: <202105110911.f084GH7J-lkp@intel.com>
References: <20210510213709.2004366-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20210510213709.2004366-1-revest@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florent,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf/master]

url:    https://github.com/0day-ci/linux/commits/Florent-Revest/bpf-Fix-nested-bpf_bprintf_prepare-with-more-per-cpu-buffers/20210511-053835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: s390-randconfig-r013-20210510 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a0fed635fe1701470062495a6ffee1c608f3f1bc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/1f5d45d9243d8ca8ece81e778579fc46a1946887
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florent-Revest/bpf-Fix-nested-bpf_bprintf_prepare-with-more-per-cpu-buffers/20210511-053835
        git checkout 1f5d45d9243d8ca8ece81e778579fc46a1946887
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/percpu-defs.h:252:27: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                             ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:241:2: note: expanded from macro 'raw_cpu_ptr'
           __verify_pcpu_ptr(ptr);                                         \
           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:52: note: expanded from macro '__verify_pcpu_ptr'
           const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
                                                       ~~~~~ ^
   kernel/bpf/helpers.c:703:30: note: forward declaration of 'struct bpf_bprintf_bufs'
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                ^
   kernel/bpf/helpers.c:718:23: error: use of undeclared identifier 'bpf_bprintf_buf'; did you mean 'bpf_bprintf_bufs'?
           bufs = this_cpu_ptr(&bpf_bprintf_buf);
                                ^~~~~~~~~~~~~~~
                                bpf_bprintf_bufs
   include/linux/percpu-defs.h:252:39: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                                         ^
   include/linux/percpu-defs.h:242:19: note: expanded from macro 'raw_cpu_ptr'
           arch_raw_cpu_ptr(ptr);                                          \
                            ^
   include/asm-generic/percpu.h:44:48: note: expanded from macro 'arch_raw_cpu_ptr'
   #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                                  ^
   include/linux/percpu-defs.h:231:23: note: expanded from macro 'SHIFT_PERCPU_PTR'
           RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
                                ^
   include/linux/compiler.h:181:31: note: expanded from macro 'RELOC_HIDE'
        __ptr = (unsigned long) (ptr);                             \
                                 ^
   kernel/bpf/helpers.c:703:48: note: 'bpf_bprintf_bufs' declared here
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                                  ^
   kernel/bpf/helpers.c:718:23: error: use of undeclared identifier 'bpf_bprintf_buf'; did you mean 'bpf_bprintf_bufs'?
           bufs = this_cpu_ptr(&bpf_bprintf_buf);
                                ^~~~~~~~~~~~~~~
                                bpf_bprintf_bufs
   include/linux/percpu-defs.h:252:39: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                                         ^
   include/linux/percpu-defs.h:242:19: note: expanded from macro 'raw_cpu_ptr'
           arch_raw_cpu_ptr(ptr);                                          \
                            ^
   include/asm-generic/percpu.h:44:48: note: expanded from macro 'arch_raw_cpu_ptr'
   #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                                  ^
   include/linux/percpu-defs.h:231:49: note: expanded from macro 'SHIFT_PERCPU_PTR'
           RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
                                                          ^
   include/linux/compiler.h:181:31: note: expanded from macro 'RELOC_HIDE'
        __ptr = (unsigned long) (ptr);                             \
                                 ^
   kernel/bpf/helpers.c:703:48: note: 'bpf_bprintf_bufs' declared here
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                                  ^
   kernel/bpf/helpers.c:718:23: error: use of undeclared identifier 'bpf_bprintf_buf'; did you mean 'bpf_bprintf_bufs'?
           bufs = this_cpu_ptr(&bpf_bprintf_buf);
                                ^~~~~~~~~~~~~~~
                                bpf_bprintf_bufs
   include/linux/percpu-defs.h:252:39: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                                         ^
   include/linux/percpu-defs.h:242:19: note: expanded from macro 'raw_cpu_ptr'
           arch_raw_cpu_ptr(ptr);                                          \
                            ^
   include/asm-generic/percpu.h:44:48: note: expanded from macro 'arch_raw_cpu_ptr'
   #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                                  ^
   include/linux/percpu-defs.h:231:23: note: expanded from macro 'SHIFT_PERCPU_PTR'
           RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
                                ^
   include/linux/compiler.h:182:13: note: expanded from macro 'RELOC_HIDE'
       (typeof(ptr)) (__ptr + (off)); })
               ^
   kernel/bpf/helpers.c:703:48: note: 'bpf_bprintf_bufs' declared here
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                                  ^
   kernel/bpf/helpers.c:718:23: error: use of undeclared identifier 'bpf_bprintf_buf'; did you mean 'bpf_bprintf_bufs'?
           bufs = this_cpu_ptr(&bpf_bprintf_buf);
                                ^~~~~~~~~~~~~~~
                                bpf_bprintf_bufs
   include/linux/percpu-defs.h:252:39: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                                         ^
   include/linux/percpu-defs.h:242:19: note: expanded from macro 'raw_cpu_ptr'
           arch_raw_cpu_ptr(ptr);                                          \
                            ^
   include/asm-generic/percpu.h:44:48: note: expanded from macro 'arch_raw_cpu_ptr'
   #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                                  ^
   include/linux/percpu-defs.h:231:49: note: expanded from macro 'SHIFT_PERCPU_PTR'
           RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
                                                          ^
   include/linux/compiler.h:182:13: note: expanded from macro 'RELOC_HIDE'
       (typeof(ptr)) (__ptr + (off)); })
               ^
   kernel/bpf/helpers.c:703:48: note: 'bpf_bprintf_bufs' declared here
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                                  ^
>> kernel/bpf/helpers.c:718:7: error: incompatible pointer types assigning to 'struct bpf_bprintf_buffers *' from 'typeof ((typeof (*(&bpf_bprintf_bufs)) *)(&bpf_bprintf_bufs))' (aka 'struct bpf_bprintf_bufs *') [-Werror,-Wincompatible-pointer-types]
           bufs = this_cpu_ptr(&bpf_bprintf_buf);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:703:48: error: tentative definition has type 'typeof(struct bpf_bprintf_bufs)' (aka 'struct bpf_bprintf_bufs') that is never completed
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                                  ^
   kernel/bpf/helpers.c:703:30: note: forward declaration of 'struct bpf_bprintf_bufs'
   static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
                                ^
   12 warnings and 8 errors generated.


vim +718 kernel/bpf/helpers.c

   705	
   706	static int try_get_fmt_tmp_buf(char **tmp_buf)
   707	{
   708		struct bpf_bprintf_buffers *bufs;
   709		int nest_level;
   710	
   711		preempt_disable();
   712		nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
   713		if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
   714			this_cpu_dec(bpf_bprintf_nest_level);
   715			preempt_enable();
   716			return -EBUSY;
   717		}
 > 718		bufs = this_cpu_ptr(&bpf_bprintf_buf);
   719		*tmp_buf = bufs->tmp_bufs[nest_level - 1];
   720	
   721		return 0;
   722	}
   723	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
KeJA/UmN5+y9EjmH8Xvr/wHUH7mxNOEAAA==

--huq684BweRXVnRxX--

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1368743C
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 05:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBBECQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 23:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBBECN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 23:02:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817417BBDE;
        Wed,  1 Feb 2023 20:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675310531; x=1706846531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q6pt76n3GNc0XQSh5sHwG6/T5JVBFQK0A82aR9qxwdg=;
  b=RiXIFgaidd7mguTArhHjE4iB/oeChdOuwQlDrfWgXhSN0FH3QhsiTDBv
   hUwAFmUpDc8EK7zqTEO2RFJUJ2sGt/rH5DNL6Q6eWVKhv3gIruRafeEkx
   GpJuZIFokTeLO3fQxtijrovIeFN9As/idnYTM8k4WIHL+iFiVVi/3zMWW
   YWhCAfZQNWlL8h6P7CTMpsAusTqT3Nq6AxBW4Vn7s1q7cxaj/W0p4NGVQ
   eZHQZ/mPc6EzwJ4bV8DBd0TtM2jPilD8H1FYulPQWESHIIm2uQa+otYYJ
   xYV0u6aExXvXn9Kvs/w6WskhJncFh7kekVSnC4Ti3R37cLNwGdAyCZVCj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="392926396"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="392926396"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 20:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="789139053"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="789139053"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2023 20:02:08 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNQnX-00067S-2Z;
        Thu, 02 Feb 2023 04:02:07 +0000
Date:   Thu, 2 Feb 2023 12:01:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/4] bpf: treewide: Clean up BPF_ALU and BPF_JMP
Message-ID: <202302021105.HU4McFMJ-lkp@intel.com>
References: <1675254998-4951-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675254998-4951-3-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tiezhu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/bpf-Add-new-macro-BPF_ALU32-and-BPF_JMP64/20230201-203836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/1675254998-4951-3-git-send-email-yangtiezhu%40loongson.cn
patch subject: [PATCH bpf-next 2/4] bpf: treewide: Clean up BPF_ALU and BPF_JMP
config: i386-randconfig-a016-20230130 (https://download.01.org/0day-ci/archive/20230202/202302021105.HU4McFMJ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9955f957cb218f711161ac710656be1164eaa3a3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tiezhu-Yang/bpf-Add-new-macro-BPF_ALU32-and-BPF_JMP64/20230201-203836
        git checkout 9955f957cb218f711161ac710656be1164eaa3a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash samples/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> samples/seccomp/bpf-fancy.c:38:3: error: use of undeclared identifier 'BPF_JMP64'
                   SYSCALL(__NR_exit, ALLOW),
                   ^
   samples/seccomp/bpf-helper.h:56:11: note: expanded from macro 'SYSCALL'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (nr), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:39:3: error: use of undeclared identifier 'BPF_JMP64'
                   SYSCALL(__NR_exit_group, ALLOW),
                   ^
   samples/seccomp/bpf-helper.h:56:11: note: expanded from macro 'SYSCALL'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (nr), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:40:3: error: use of undeclared identifier 'BPF_JMP64'
                   SYSCALL(__NR_write, JUMP(&l, write_fd)),
                   ^
   samples/seccomp/bpf-helper.h:56:11: note: expanded from macro 'SYSCALL'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (nr), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:40:23: error: use of undeclared identifier 'BPF_JMP64'
                   SYSCALL(__NR_write, JUMP(&l, write_fd)),
                                       ^
   samples/seccomp/bpf-helper.h:50:11: note: expanded from macro 'JUMP'
           BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
                    ^
   samples/seccomp/bpf-fancy.c:41:3: error: use of undeclared identifier 'BPF_JMP64'
                   SYSCALL(__NR_read, JUMP(&l, read)),
                   ^
   samples/seccomp/bpf-helper.h:56:11: note: expanded from macro 'SYSCALL'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (nr), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:41:22: error: use of undeclared identifier 'BPF_JMP64'
                   SYSCALL(__NR_read, JUMP(&l, read)),
                                      ^
   samples/seccomp/bpf-helper.h:50:11: note: expanded from macro 'JUMP'
           BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
                    ^
   samples/seccomp/bpf-fancy.c:44:3: error: use of undeclared identifier 'BPF_JMP64'
                   LABEL(&l, read),
                   ^
   samples/seccomp/bpf-helper.h:53:11: note: expanded from macro 'LABEL'
           BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
                    ^
   samples/seccomp/bpf-fancy.c:46:3: error: use of undeclared identifier 'BPF_JMP64'
                   JNE(STDIN_FILENO, DENY),
                   ^
   samples/seccomp/bpf-helper.h:77:20: note: expanded from macro 'JNE'
   #define JNE(x, jt) JNE32(x, EXPAND(jt))
                      ^
   samples/seccomp/bpf-helper.h:154:11: note: expanded from macro 'JNE32'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (value), 1, 0), \
                    ^
   samples/seccomp/bpf-fancy.c:48:3: error: use of undeclared identifier 'BPF_JMP64'
                   JNE((unsigned long)buf, DENY),
                   ^
   samples/seccomp/bpf-helper.h:77:20: note: expanded from macro 'JNE'
   #define JNE(x, jt) JNE32(x, EXPAND(jt))
                      ^
   samples/seccomp/bpf-helper.h:154:11: note: expanded from macro 'JNE32'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (value), 1, 0), \
                    ^
   samples/seccomp/bpf-fancy.c:50:3: error: use of undeclared identifier 'BPF_JMP64'
                   JGE(sizeof(buf), DENY),
                   ^
   samples/seccomp/bpf-helper.h:80:20: note: expanded from macro 'JGE'
   #define JGE(x, jt) JGE32(x, EXPAND(jt))
                      ^
   samples/seccomp/bpf-helper.h:162:11: note: expanded from macro 'JGE32'
           BPF_JUMP(BPF_JMP64+BPF_JGE+BPF_K, (value), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:53:3: error: use of undeclared identifier 'BPF_JMP64'
                   LABEL(&l, write_fd),
                   ^
   samples/seccomp/bpf-helper.h:53:11: note: expanded from macro 'LABEL'
           BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
                    ^
   samples/seccomp/bpf-fancy.c:55:3: error: use of undeclared identifier 'BPF_JMP64'
                   JEQ(STDOUT_FILENO, JUMP(&l, write_buf)),
                   ^
   samples/seccomp/bpf-helper.h:76:20: note: expanded from macro 'JEQ'
   #define JEQ(x, jt) JEQ32(x, EXPAND(jt))
                      ^
   samples/seccomp/bpf-helper.h:150:11: note: expanded from macro 'JEQ32'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (value), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:55:22: error: use of undeclared identifier 'BPF_JMP64'
                   JEQ(STDOUT_FILENO, JUMP(&l, write_buf)),
                                      ^
   samples/seccomp/bpf-helper.h:50:11: note: expanded from macro 'JUMP'
           BPF_JUMP(BPF_JMP64+BPF_JA, FIND_LABEL((labels), (label)), \
                    ^
   samples/seccomp/bpf-fancy.c:56:3: error: use of undeclared identifier 'BPF_JMP64'
                   JEQ(STDERR_FILENO, JUMP(&l, write_buf)),
                   ^
   samples/seccomp/bpf-helper.h:76:20: note: expanded from macro 'JEQ'
   #define JEQ(x, jt) JEQ32(x, EXPAND(jt))
                      ^
   samples/seccomp/bpf-helper.h:150:11: note: expanded from macro 'JEQ32'
           BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, (value), 0, 1), \
                    ^
   samples/seccomp/bpf-fancy.c:56:22: error: use of undeclared identifier 'BPF_JMP64'
                   JEQ(STDERR_FILENO, JUMP(&l, write_buf)),
--
>> samples/seccomp/bpf-helper.c:33:23: error: use of undeclared identifier 'BPF_JMP64'
                   if (instr->code != (BPF_JMP64+BPF_JA))
                                       ^
   1 error generated.
--
>> samples/seccomp/dropper.c:33:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, arch, 0, 3),
                            ^
   samples/seccomp/dropper.c:36:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, nr, 0, 1),
                            ^
>> samples/seccomp/dropper.c:42:33: error: invalid application of 'sizeof' to an incomplete type 'struct sock_filter[]'
                   .len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
                                                 ^~~~~~~~
   3 errors generated.
--
>> samples/seccomp/bpf-direct.c:117:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_rt_sigreturn, 0, 1),
                            ^
   samples/seccomp/bpf-direct.c:120:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_sigreturn, 0, 1),
                            ^
   samples/seccomp/bpf-direct.c:123:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_exit_group, 0, 1),
                            ^
   samples/seccomp/bpf-direct.c:125:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_exit, 0, 1),
                            ^
   samples/seccomp/bpf-direct.c:127:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_read, 1, 0),
                            ^
   samples/seccomp/bpf-direct.c:128:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, __NR_write, 3, 2),
                            ^
   samples/seccomp/bpf-direct.c:132:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, STDIN_FILENO, 4, 0),
                            ^
   samples/seccomp/bpf-direct.c:137:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, STDOUT_FILENO, 1, 0),
                            ^
   samples/seccomp/bpf-direct.c:139:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, STDERR_FILENO, 1, 2),
                            ^
>> samples/seccomp/bpf-direct.c:146:33: error: invalid application of 'sizeof' to an incomplete type 'struct sock_filter[]'
                   .len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
                                                 ^~~~~~~~
   10 errors generated.
--
>> samples/seccomp/user-trap.c:91:12: error: use of undeclared identifier 'BPF_JMP64'
                   BPF_JUMP(BPF_JMP64+BPF_JEQ+BPF_K, nr, 0, 1),
                            ^
>> samples/seccomp/user-trap.c:97:26: error: invalid application of 'sizeof' to an incomplete type 'struct sock_filter[]'
                   .len = (unsigned short)ARRAY_SIZE(filter),
                                          ^~~~~~~~~~~~~~~~~~
   samples/seccomp/user-trap.c:24:30: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
                                ^~~
   2 errors generated.


vim +/BPF_JMP64 +38 samples/seccomp/bpf-fancy.c

8ac270d1e29f042 Will Drewry 2012-04-12  26  
8ac270d1e29f042 Will Drewry 2012-04-12  27  int main(int argc, char **argv)
8ac270d1e29f042 Will Drewry 2012-04-12  28  {
3a9af0bd34410a2 Kees Cook   2015-02-17  29  	struct bpf_labels l = {
3a9af0bd34410a2 Kees Cook   2015-02-17  30  		.count = 0,
3a9af0bd34410a2 Kees Cook   2015-02-17  31  	};
8ac270d1e29f042 Will Drewry 2012-04-12  32  	static const char msg1[] = "Please type something: ";
8ac270d1e29f042 Will Drewry 2012-04-12  33  	static const char msg2[] = "You typed: ";
8ac270d1e29f042 Will Drewry 2012-04-12  34  	char buf[256];
8ac270d1e29f042 Will Drewry 2012-04-12  35  	struct sock_filter filter[] = {
8ac270d1e29f042 Will Drewry 2012-04-12  36  		/* TODO: LOAD_SYSCALL_NR(arch) and enforce an arch */
8ac270d1e29f042 Will Drewry 2012-04-12  37  		LOAD_SYSCALL_NR,
8ac270d1e29f042 Will Drewry 2012-04-12 @38  		SYSCALL(__NR_exit, ALLOW),

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

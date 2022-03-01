Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED63D4C8AFF
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 12:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCALmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 06:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiCALmI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 06:42:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41792939F2
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646134886; x=1677670886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bKQlIa9uXc/OOviJ8WIly+xFX9eD8z4gW619aDurWLY=;
  b=fJX2nfs/UThJINWRZWtz4Uixj/N83fTYo8f8CPyXNe5T+HJIoXbuqUZY
   WgB5jKahWywqKPxDCBsocAv/ikCddSbebqigQpq3r7BbzltPzLIWGgvc7
   1pPbTPTjDAfJwTsEO4A9wxq0xPMEAA+KEZwJB6xcEpxoAg12zo0P28EcH
   UGV5jkaOlPk2q9rrgZLZ/75FQ2OVEwTnvdXD2lb/UOMqjzjb7clcN09or
   diduSLHXyL5e2Yq7JCw2MxLQ9Ibksu5dKbTKBt2vJrlW4+yVFhiAcOe3Z
   vEEs2NH6e6mTkWT/eSrV3X8Rq+bTnfTEDQg2REeZVkYsxyxiLAWxOOXZv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316328016"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="316328016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 03:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="575671548"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2022 03:41:23 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP0sd-0000ML-69; Tue, 01 Mar 2022 11:41:23 +0000
Date:   Tue, 1 Mar 2022 19:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc
 register offset checks
Message-ID: <202203011937.wMLpkfU3-lkp@intel.com>
References: <20220301065745.1634848-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301065745.1634848-7-memxor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/37a0d686bce3b71b14a17ae57364ec45d1405b9e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
        git checkout 37a0d686bce3b71b14a17ae57364ec45d1405b9e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash net/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   net/bpf/test_run.c:201:14: warning: no previous prototype for function 'bpf_fentry_test1' [-Wmissing-prototypes]
   int noinline bpf_fentry_test1(int a)
                ^
   net/bpf/test_run.c:201:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test1(int a)
   ^
   static 
   net/bpf/test_run.c:208:14: warning: no previous prototype for function 'bpf_fentry_test2' [-Wmissing-prototypes]
   int noinline bpf_fentry_test2(int a, u64 b)
                ^
   net/bpf/test_run.c:208:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test2(int a, u64 b)
   ^
   static 
   net/bpf/test_run.c:213:14: warning: no previous prototype for function 'bpf_fentry_test3' [-Wmissing-prototypes]
   int noinline bpf_fentry_test3(char a, int b, u64 c)
                ^
   net/bpf/test_run.c:213:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test3(char a, int b, u64 c)
   ^
   static 
   net/bpf/test_run.c:218:14: warning: no previous prototype for function 'bpf_fentry_test4' [-Wmissing-prototypes]
   int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
                ^
   net/bpf/test_run.c:218:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
   ^
   static 
   net/bpf/test_run.c:223:14: warning: no previous prototype for function 'bpf_fentry_test5' [-Wmissing-prototypes]
   int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
                ^
   net/bpf/test_run.c:223:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
   ^
   static 
   net/bpf/test_run.c:228:14: warning: no previous prototype for function 'bpf_fentry_test6' [-Wmissing-prototypes]
   int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
                ^
   net/bpf/test_run.c:228:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
   ^
   static 
   net/bpf/test_run.c:237:14: warning: no previous prototype for function 'bpf_fentry_test7' [-Wmissing-prototypes]
   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
                ^
   net/bpf/test_run.c:237:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
   ^
   static 
   net/bpf/test_run.c:242:14: warning: no previous prototype for function 'bpf_fentry_test8' [-Wmissing-prototypes]
   int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
                ^
   net/bpf/test_run.c:242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
   ^
   static 
   net/bpf/test_run.c:247:14: warning: no previous prototype for function 'bpf_modify_return_test' [-Wmissing-prototypes]
   int noinline bpf_modify_return_test(int a, int *b)
                ^
   net/bpf/test_run.c:247:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_modify_return_test(int a, int *b)
   ^
   static 
   net/bpf/test_run.c:253:14: warning: no previous prototype for function 'bpf_kfunc_call_test1' [-Wmissing-prototypes]
   u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
                ^
   net/bpf/test_run.c:253:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
   ^
   static 
   net/bpf/test_run.c:258:14: warning: no previous prototype for function 'bpf_kfunc_call_test2' [-Wmissing-prototypes]
   int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
                ^
   net/bpf/test_run.c:258:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
   ^
   static 
   net/bpf/test_run.c:263:24: warning: no previous prototype for function 'bpf_kfunc_call_test3' [-Wmissing-prototypes]
   struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
                          ^
   net/bpf/test_run.c:263:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
   ^
   static 
   net/bpf/test_run.c:286:1: warning: no previous prototype for function 'bpf_kfunc_call_test_acquire' [-Wmissing-prototypes]
   bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
   ^
   net/bpf/test_run.c:285:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline struct prog_test_ref_kfunc *
            ^
            static 
   net/bpf/test_run.c:294:15: warning: no previous prototype for function 'bpf_kfunc_call_test_release' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
                 ^
   net/bpf/test_run.c:294:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
            ^
            static 
>> net/bpf/test_run.c:298:15: warning: no previous prototype for function 'bpf_kfunc_call_memb_release' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
                 ^
   net/bpf/test_run.c:298:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
            ^
            static 
   net/bpf/test_run.c:340:15: warning: no previous prototype for function 'bpf_kfunc_call_test_pass_ctx' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
                 ^
   net/bpf/test_run.c:340:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
            ^
            static 
   net/bpf/test_run.c:344:15: warning: no previous prototype for function 'bpf_kfunc_call_test_pass1' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
                 ^
   net/bpf/test_run.c:344:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
            ^
            static 
   net/bpf/test_run.c:348:15: warning: no previous prototype for function 'bpf_kfunc_call_test_pass2' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
                 ^
   net/bpf/test_run.c:348:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
            ^
            static 
   net/bpf/test_run.c:352:15: warning: no previous prototype for function 'bpf_kfunc_call_test_fail1' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
                 ^
   net/bpf/test_run.c:352:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
            ^
            static 
   net/bpf/test_run.c:356:15: warning: no previous prototype for function 'bpf_kfunc_call_test_fail2' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
                 ^
   net/bpf/test_run.c:356:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
            ^
            static 
   net/bpf/test_run.c:360:15: warning: no previous prototype for function 'bpf_kfunc_call_test_fail3' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
                 ^
   net/bpf/test_run.c:360:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
            ^
            static 
   net/bpf/test_run.c:364:15: warning: no previous prototype for function 'bpf_kfunc_call_test_mem_len_pass1' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
                 ^
   net/bpf/test_run.c:364:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
            ^
            static 
   net/bpf/test_run.c:368:15: warning: no previous prototype for function 'bpf_kfunc_call_test_mem_len_fail1' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
                 ^
   net/bpf/test_run.c:368:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
            ^
            static 
   net/bpf/test_run.c:372:15: warning: no previous prototype for function 'bpf_kfunc_call_test_mem_len_fail2' [-Wmissing-prototypes]
   noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
                 ^
   net/bpf/test_run.c:372:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
            ^
            static 
   36 warnings generated.


vim +/bpf_kfunc_call_memb_release +298 net/bpf/test_run.c

   297	
 > 298	noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
   299	{
   300	}
   301	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

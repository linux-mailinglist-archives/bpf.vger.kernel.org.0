Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4595B2D53
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 06:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIIETz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 00:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIIETw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 00:19:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777F2A709
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 21:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662697190; x=1694233190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VGYZxDtSW+zm4ub5w+hpt4s6GdSARv5ugnqzhFp1DiU=;
  b=VM/K+cI1Lr/smXGLueWK8S8cVIUhVq4EshJNcAiCPnnq/DXVUx8sncSl
   LA3fuUA9pe/NxAZrasDt3Xp1euk0s+nRy4jsrFjimPvaKmzPIBPgYh7WH
   mke8r+uctME7wmCu5/N0FPszXJewEJOT/IiGOt2+jL1qEadFAeJcr2ABI
   l7KtJnAgdGJ6Tc7GkBoXmsNVFYZgk70gKksvUKIPFJwCaJ3LXHPHsK1U8
   xc9t/lR0qwiJcdRHmjAPF2zAawaAk2inVPue3j0W9pkc7YQPLHeiiRaNr
   6qC8dyrPapuWOZRwxxW3JNnVnIsF7lxMmWSiEaYWckLXYezC6EQrIkBZB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297391861"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="297391861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 21:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="566230379"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 21:19:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWVUY-0000i5-1J;
        Fri, 09 Sep 2022 04:19:46 +0000
Date:   Fri, 9 Sep 2022 12:19:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kbuild-all@lists.01.org,
        syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Prevent bpf program recursion for raw
 tracepoint probes
Message-ID: <202209091236.avgRKOSj-lkp@intel.com>
References: <20220908114659.102775-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908114659.102775-1-jolsa@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/bpf-Prevent-bpf-program-recursion-for-raw-tracepoint-probes/20220908-194832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: arm64-buildonly-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220909/202209091236.avgRKOSj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f68b567cfb6572c20e431242a440cc5f01452485
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiri-Olsa/bpf-Prevent-bpf-program-recursion-for-raw-tracepoint-probes/20220908-194832
        git checkout f68b567cfb6572c20e431242a440cc5f01452485
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: kernel/trace/bpf_trace.o: in function `__bpf_trace_run':
>> kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> aarch64-linux-ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> aarch64-linux-ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> aarch64-linux-ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> aarch64-linux-ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
   aarch64-linux-ld: kernel/trace/bpf_trace.o:kernel/trace/bpf_trace.c:2046: more undefined references to `bpf_prog_inc_misses_counter' follow


vim +2046 kernel/trace/bpf_trace.c

  2040	
  2041	static __always_inline
  2042	void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
  2043	{
  2044		cant_sleep();
  2045		if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> 2046			bpf_prog_inc_misses_counter(prog);
  2047			goto out;
  2048		}
  2049		rcu_read_lock();
  2050		(void) bpf_prog_run(prog, args);
  2051		rcu_read_unlock();
  2052	out:
  2053		this_cpu_dec(*(prog->active));
  2054	}
  2055	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

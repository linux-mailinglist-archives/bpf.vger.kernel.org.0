Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B04C5363
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 03:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiBZCeQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 21:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiBZCeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 21:34:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E5A888C;
        Fri, 25 Feb 2022 18:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645842818; x=1677378818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndh/jkI1XtwDxNoyYmmqsxDsmXB4aGt6ifZ7RJx3YYo=;
  b=O09SxArxW5jbTBwF2O4rpnic6Fee5Ke0mrxW/SSD8tJryK26RkDKUfi6
   Pp3rOgx2xnflfovvE4KeeCMedqO1o1qj8VdlyCaelvwI77vR/maZFgyHy
   uSul6CvI8o+RGRZnz8vGPCE+PisLHxeIp80EliaILeu4dug9WG0tBXlNS
   prBHTXJOX8twfzvg+cfoLvntDnkJwp4vqD2Ux92tAmY45N3Uc/+kJYqC+
   fP1fhzwQCWYN8cfhLEojqk3Wa+Eu+reVQ3+eQDwzllJ7nd0W80+kIDryF
   GQ6WIiSZlyzLORi7WzOWy3MVyKXaAOH4Bvnnw70z/ERMWHsGsPsj82Kig
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252817270"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="252817270"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 18:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="549517480"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 18:33:33 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNmto-0004yD-Of; Sat, 26 Feb 2022 02:33:32 +0000
Date:   Sat, 26 Feb 2022 10:32:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Message-ID: <202202261001.PWCTwlQp-lkp@intel.com>
References: <20220225234339.2386398-9-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-9-haoluo@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Hao-Luo/Extend-cgroup-interface-with-bpf/20220226-074615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220226/202202261001.PWCTwlQp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ee74423719e2efb4efa7a4491920c78b60024ec7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hao-Luo/Extend-cgroup-interface-with-bpf/20220226-074615
        git checkout ee74423719e2efb4efa7a4491920c78b60024ec7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/cgroup_iter.c: In function 'cgroup_iter_seq_stop':
>> kernel/bpf/cgroup_iter.c:60:17: error: implicit declaration of function 'cgroup_put'; did you mean 'cgroup_psi'? [-Werror=implicit-function-declaration]
      60 |                 cgroup_put(v);
         |                 ^~~~~~~~~~
         |                 cgroup_psi
   kernel/bpf/cgroup_iter.c: At top level:
   kernel/bpf/cgroup_iter.c:101:6: warning: no previous prototype for 'bpf_iter_cgroup_show_fdinfo' [-Wmissing-prototypes]
     101 | void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cgroup_iter.c: In function 'bpf_iter_cgroup_show_fdinfo':
   kernel/bpf/cgroup_iter.c:107:40: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     107 |         seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
         |                                      ~~^     ~~~~~~~~~~~~~~
         |                                        |        |
         |                                        |        u64 {aka long long unsigned int}
         |                                        long unsigned int
         |                                      %llu
   kernel/bpf/cgroup_iter.c: At top level:
   kernel/bpf/cgroup_iter.c:111:5: warning: no previous prototype for 'bpf_iter_cgroup_fill_link_info' [-Wmissing-prototypes]
     111 | int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +60 kernel/bpf/cgroup_iter.c

    56	
    57	static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
    58	{
    59		if (v)
  > 60			cgroup_put(v);
    61	}
    62	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

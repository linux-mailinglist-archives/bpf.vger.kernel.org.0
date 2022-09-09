Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD205B2FCA
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIIH3V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIIH3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 03:29:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346EB11EA5A
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662708559; x=1694244559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pu51tEy4/PIJD5Ecb4usui0DQoruWr34Fyrm8KTKhvY=;
  b=DepnDB1VipDfFDXawC3Nv+6wgMAoKVeyKqvAxdy7XWCCol84sGm6TrXQ
   2+JgnCKYlJ4UuF5ZzMgGDKYd4D8zAA/EDCf/1yNpWlm8L0WtWSZZQ0P0y
   RXp3oLGE7eanOxTyqOr678ReklnnKavvIqfwkPeh25A9obe/h0MKmjnex
   5nk7SysR6UcScLPf5oRRFnP7XRV+5hfKtKKsHtaSVpg6yQ3DwlValCPS8
   tYFy4weR+QEMlXJWAjHG99goHFpCsG+iHpW9gnHfiKie9/FCdWV/jy7wG
   jBo/HW7rpsrhYPBgnWwq5bzcf35a9qd98LH5GKSxEKFVpjKLrhMaTKEgE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359143073"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="359143073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 00:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="740965787"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2022 00:28:56 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWYRb-0000rJ-2H;
        Fri, 09 Sep 2022 07:28:55 +0000
Date:   Fri, 9 Sep 2022 15:27:57 +0800
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
Message-ID: <202209091544.TU8KWEUM-lkp@intel.com>
References: <20220908114659.102775-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908114659.102775-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220909/202209091544.TU8KWEUM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f68b567cfb6572c20e431242a440cc5f01452485
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiri-Olsa/bpf-Prevent-bpf-program-recursion-for-raw-tracepoint-probes/20220908-194832
        git checkout f68b567cfb6572c20e431242a440cc5f01452485
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: kernel/trace/bpf_trace.o: in function `__bpf_trace_run':
   kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
   ld: kernel/trace/bpf_trace.o:kernel/trace/bpf_trace.c:2046: more undefined references to `bpf_prog_inc_misses_counter' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

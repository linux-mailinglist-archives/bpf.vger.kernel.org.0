Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E356D49D63E
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 00:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiAZXi2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 18:38:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:35925 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbiAZXi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 18:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643240308; x=1674776308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QofndZE4dqqc9k8fIVlrjpWk4keaHkjoT/z0yldgmu4=;
  b=lj9ePwPULtUCRmFSWxstSh2w9/iSy/8FVmkeO+l+dG5HsJd0B7pIImop
   jFW/0A+/UaFQaCXnXcsJoBfXRgiWWglqEVRSBXhNo/FjRrYc2uvEc2xXg
   c7FvhvruT4nrg1kygG3dspONa57jDH7rFSs2ra+YsFzqWDyZ14NjKgd0+
   TXZbZIWQpTyyPH6YD12WdAZ7BZwOax3qs19VtS9WsP/2Y0JktDJyoq1vQ
   B2qFy3waiJGLGJBxidZre0tNvjoEleCLiRSFkdRrH/kxbDMiUxfcKBF7+
   IWhRpe1g0woS2nrCVMijSRSKEP4gFfOGqY0TvCjp58Z7gSlXOGAzQHFIA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226665035"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="226665035"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 15:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="480068914"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 15:38:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCrrs-000Lni-Sn; Wed, 26 Jan 2022 23:38:24 +0000
Date:   Thu, 27 Jan 2022 07:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kbuild-all@lists.01.org, Kui-Feng Lee <kuifeng@fb.com>
Subject: Re: [PATCH bpf-next 5/5] bpf: Implement bpf_get_attach_cookie() for
 tracing programs.
Message-ID: <202201270704.kcMiWFUK-lkp@intel.com>
References: <20220126214809.3868787-6-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126214809.3868787-6-kuifeng@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kui-Feng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Kui-Feng-Lee/Attach-a-cookie-to-a-tracing-program/20220127-054929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270704.kcMiWFUK-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6dffffc1fe68f386715b4ee396fb6a5c738fb065
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kui-Feng-Lee/Attach-a-cookie-to-a-tracing-program/20220127-054929
        git checkout 6dffffc1fe68f386715b4ee396fb6a5c738fb065
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function '____bpf_get_attach_cookie_tracing':
>> kernel/trace/bpf_trace.c:1095:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1095 |         prog = (const struct bpf_prog *)((u64 *)ctx)[-off];
         |                ^


vim +1095 kernel/trace/bpf_trace.c

  1086	
  1087	BPF_CALL_1(bpf_get_attach_cookie_tracing, void *, ctx)
  1088	{
  1089		const struct bpf_prog *prog;
  1090		int off = get_trampo_var_off(ctx, BPF_TRAMP_F_PROG_ID);
  1091	
  1092		if (off < 0)
  1093			return 0;
  1094	
> 1095		prog = (const struct bpf_prog *)((u64 *)ctx)[-off];
  1096	
  1097		return prog->aux->cookie;
  1098	}
  1099	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

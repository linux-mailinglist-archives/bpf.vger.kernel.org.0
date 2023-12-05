Return-Path: <bpf+bounces-16718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF9D804D26
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 10:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4B1F21486
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454153D970;
	Tue,  5 Dec 2023 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHj3iZc3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7556134
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 01:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701767072; x=1733303072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwJ/1yzGcUn98OKfx1bwlkwjcTxsSdQBbUnz3IRBTIk=;
  b=EHj3iZc3u/CsdLkfJsdh7ZKZW+kGWFE2WYnpJSusR9cuxEAYzPoZSoxX
   QWI6CNcUBLIyB+JNDAPNLCHhtjiG/ous10StGxhYr4g812ClulWmucQKJ
   YXc5PE9uqqghbURXEi2RyH4/jIBMLQKvT93sd+Av6ELdpYy74jfT1N5Z7
   9sUG5tPxN+ARToYJPVWeB1+Vwu4rebpBSQaNk5qaqljvnrQGSqh3O1XW2
   mqtXz33++nZ57JtS2NIOJWcLszbknJmejIxEYuHcC/6jVJrEK+W9oy3GQ
   tbsp8l0O1WVuT9eGnPoNGq/ow4H2KPEjyEWLa3dWjf7xYb8IbYSVrsAkH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="926496"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="926496"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="799894385"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="799894385"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2023 01:04:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rARLu-0008cO-24;
	Tue, 05 Dec 2023 09:04:26 +0000
Date: Tue, 5 Dec 2023 17:04:12 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 08/13] bpf: move subprog call logic back to
 verifier.c
Message-ID: <202312051638.g1zvtUmv-lkp@intel.com>
References: <20231204233931.49758-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204233931.49758-9-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-log-PTR_TO_MEM-memory-size-in-verifier-log/20231205-074451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231204233931.49758-9-andrii%40kernel.org
patch subject: [PATCH bpf-next 08/13] bpf: move subprog call logic back to verifier.c
config: alpha-randconfig-r122-20231205 (https://download.01.org/0day-ci/archive/20231205/202312051638.g1zvtUmv-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051638.g1zvtUmv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051638.g1zvtUmv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/verifier.c:5083:5: sparse: sparse: symbol 'check_ptr_off_reg' was not declared. Should it be static?
>> kernel/bpf/verifier.c:7268:5: sparse: sparse: symbol 'check_mem_reg' was not declared. Should it be static?
>> kernel/bpf/verifier.c:8254:5: sparse: sparse: symbol 'check_func_arg_reg_off' was not declared. Should it be static?
   kernel/bpf/verifier.c:19770:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +/check_ptr_off_reg +5083 kernel/bpf/verifier.c

e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5082  
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15 @5083  int check_ptr_off_reg(struct bpf_verifier_env *env,
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5084  		      const struct bpf_reg_state *reg, int regno)
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5085  {
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5086  	return __check_ptr_off_reg(env, reg, regno, false);
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5087  }
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5088  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


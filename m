Return-Path: <bpf+bounces-3852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E5E745180
	for <lists+bpf@lfdr.de>; Sun,  2 Jul 2023 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A91C203AB
	for <lists+bpf@lfdr.de>; Sun,  2 Jul 2023 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B13FE6;
	Sun,  2 Jul 2023 19:47:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615463C2A
	for <bpf@vger.kernel.org>; Sun,  2 Jul 2023 19:47:19 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FC7EEC
	for <bpf@vger.kernel.org>; Sun,  2 Jul 2023 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688327219; x=1719863219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjkZcrlCYzUk4zYchWcObPkc5bbNOF9ptg5FMavZJA8=;
  b=A4Anf7wuLlc9t28QbagGoHGDMUZGtfq4ZkSSGJU54qKkDBr2gUwsy1p5
   Q6eDrEtTo7zGCfHUrPUx1+vyZmzhBajzs+G+jskp5bVbo3MfoHCf+9r2f
   gRqPO+qbTcDvT6UtMCo+OGBJ+0LzUA1Ms+3YWtlWXGO0zAV/LYvqVO1pB
   +dmGYI2MiVWkl9dLXDpxqtSy+XJqqkrNg+pKiu74F+DWWRq/nDTa5yo67
   +awzAx7D01Jc1Hja1lrdyPrM09NBOKVl9YDrlDplS2TeS1Ef36UR/a8kr
   7oKa8J3tTKcN1yfywXFwaOZElh9eUchXtPzlMt71nnDt7p1pJL9ZP8C3D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="426416409"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="426416409"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 12:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="718395415"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="718395415"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Jul 2023 12:46:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qG31y-000Gr5-1i;
	Sun, 02 Jul 2023 19:46:46 +0000
Date: Mon, 3 Jul 2023 03:45:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jackie Liu <liu.yun@linux.dev>, olsajiri@gmail.com, andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	bpf@vger.kernel.org, liuyun01@kylinos.cn
Subject: Re: [PATCH v2 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
Message-ID: <202307030355.TdXOHklM-lkp@intel.com>
References: <20230701080817.1768865-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701080817.1768865-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jackie,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master linus/master v6.4 next-20230630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jackie-Liu/libbpf-kprobe-multi-Filter-with-available_filter_functions_addrs/20230701-161010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230701080817.1768865-1-liu.yun%40linux.dev
patch subject: [PATCH v2 1/2] libbpf: kprobe.multi: cross filter using available_filter_functions and kallsyms
config: x86_64-buildonly-randconfig-r001-20230702 (https://download.01.org/0day-ci/archive/20230703/202307030355.TdXOHklM-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307030355.TdXOHklM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307030355.TdXOHklM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> libbpf.c:10626:57: error: 'fscanf' may overflow; destination buffer in argument 4 has size 256, but the corresponding specifier may require size 500 [-Werror,-Wfortify-source]
                   ret = fscanf(f, "%llx %*c %499s%*[^\n]\n", &sym_addr, sym_name);
                                                                         ^
   1 error generated.
   make[5]: *** [tools/build/Makefile.build:97: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile:157: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
   make[3]: *** [Makefile:63: tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
   make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2 shuffle=967315254
   make[1]: *** [Makefile:1446: tools/bpf/resolve_btfids] Error 2 shuffle=967315254
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2 shuffle=967315254
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


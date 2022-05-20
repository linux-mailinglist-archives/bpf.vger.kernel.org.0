Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838B52E2B6
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 04:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbiETCx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiETCx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 22:53:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFCCB41E2;
        Thu, 19 May 2022 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653015236; x=1684551236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+kF11TKdf/Yw7gXtARSc8OVLWJ0w+qZ62oJVBw1bK8=;
  b=e5uc8AdSAtQ18MESRR214S75RviNsMBIocyL5Nex/IN45v+Eyb7DNL5J
   Gy6+Nco6v9ivPqNqtKjCnYkBShTBp7bFxu5T/bcdefAG79NeBdW0KPCvj
   TfFa2T1G1XXBHvpGy2EaHWhSOUOSoDc8fCngO55OwbJGbdfyfXFF0XkwS
   Zz1BSe8gd9mnqZ5pU2MauAoobywyCEFoFMukfkYBr6TdtGW8+SytlBUID
   k8X85w3qb7vBOvXVlqx0IPWUhoaOYexi4JGjuF1eWYVn+1faIJXSmYF8J
   jqb0D9xpykMyeZHVZt2QXw+zb6FdiPtcq1PLNIEHYvwaHW+vJmvreM2ZU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297771234"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="297771234"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 19:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="524426313"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2022 19:53:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrsm0-0004DH-2n;
        Fri, 20 May 2022 02:53:52 +0000
Date:   Fri, 20 May 2022 10:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, ast@kernel.org,
        daniel@iogearbox.net, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 bpf-next 8/8] bpf: simplify select_bpf_prog_pack_size
Message-ID: <202205201001.kKBulowq-lkp@intel.com>
References: <20220519202037.2401584-9-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519202037.2401584-9-song@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf_prog_pack-followup/20220520-043417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220520/202205201001.kKBulowq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2d5d4beb45be09f3130b694f49ab1b1fd1aa4470
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Song-Liu/bpf_prog_pack-followup/20220520-043417
        git checkout 2d5d4beb45be09f3130b694f49ab1b1fd1aa4470
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:857:8: warning: unused variable 'ptr' [-Wunused-variable]
           void *ptr;
                 ^
   kernel/bpf/core.c:1656:12: warning: no previous prototype for function 'bpf_probe_read_kernel' [-Wmissing-prototypes]
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
              ^
   kernel/bpf/core.c:1656:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
   ^
   static 
   kernel/bpf/core.c:2099:6: warning: no previous prototype for function 'bpf_patch_call_args' [-Wmissing-prototypes]
   void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
        ^
   kernel/bpf/core.c:2099:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
   ^
   static 
   3 warnings generated.


vim +/ptr +857 kernel/bpf/core.c

e581094167beb6 Song Liu 2022-03-21  853  
ef078600eec20f Song Liu 2022-03-11  854  static size_t select_bpf_prog_pack_size(void)
ef078600eec20f Song Liu 2022-03-11  855  {
ef078600eec20f Song Liu 2022-03-11  856  	size_t size;
ef078600eec20f Song Liu 2022-03-11 @857  	void *ptr;
ef078600eec20f Song Liu 2022-03-11  858  
2d5d4beb45be09 Song Liu 2022-05-19  859  	if (huge_vmalloc_supported()) {
e581094167beb6 Song Liu 2022-03-21  860  		size = BPF_HPAGE_SIZE * num_online_nodes();
2d5d4beb45be09 Song Liu 2022-05-19  861  		bpf_prog_pack_mask = BPF_HPAGE_MASK;
2d5d4beb45be09 Song Liu 2022-05-19  862  	} else {
ef078600eec20f Song Liu 2022-03-11  863  		size = PAGE_SIZE;
96805674e5624b Song Liu 2022-03-21  864  		bpf_prog_pack_mask = PAGE_MASK;
96805674e5624b Song Liu 2022-03-21  865  	}
ef078600eec20f Song Liu 2022-03-11  866  
ef078600eec20f Song Liu 2022-03-11  867  	return size;
ef078600eec20f Song Liu 2022-03-11  868  }
ef078600eec20f Song Liu 2022-03-11  869  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

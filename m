Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3EF674CF2
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjATGCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjATGCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:02:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8311E84;
        Thu, 19 Jan 2023 22:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674194572; x=1705730572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qM+DFnnvJkoyvR1H6whsmmQlNslV3KwkAOtUcsz+XpQ=;
  b=B3CpRZK6Xi3awaN+fyeL9HYibhQsJKnpJAn5Rl/fOXLcvgl2gojUDvQd
   WiWlgxrKa+mlay9c4aX6TAZl0OE9ecMyj29smiEseNv890C1zsDiNYMHk
   syMuSqmpjOV+RIjvyWsy6O1vmBKeUv+23Zr6Ox23pXmnJ726AUiudIGGh
   uiPDT6Dg7wt4oDt8KtpFuVxBxZ4pnwZwfXJps5inGK2rHJrQo/XVs4qOH
   /h9eUVCsDQmiKbPLfhOKH3yabuHS4g9PyZqHiOJ7gRsE/BPqyC1bNcU/e
   4PZ6oK74qdireKT0352pdHrSjOOEPMnjWTZO8eIFSS03yTxyb57m/yXE7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305879815"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="305879815"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 22:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610365725"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="610365725"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 22:02:43 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIkU5-0002FI-34;
        Fri, 20 Jan 2023 06:02:41 +0000
Date:   Fri, 20 Jan 2023 14:01:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 1/8] bpf: Enable annotating trusted nested
 pointers
Message-ID: <202301201328.KZrjrJXf-lkp@intel.com>
References: <20230119235833.2948341-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-2-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230119235833.2948341-2-void%40manifault.com
patch subject: [PATCH bpf-next 1/8] bpf: Enable annotating trusted nested pointers
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230120/202301201328.KZrjrJXf-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8f6df14342b1be3516f8e21037edf771df851427
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
        git checkout 8f6df14342b1be3516f8e21037edf771df851427
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/btf.c:533:5: warning: no previous prototype for function 'bpf_find_btf_id' [-Wmissing-prototypes]
   s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
       ^
   kernel/bpf/btf.c:533:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
   ^
   static 
   1 warning generated.


vim +/bpf_find_btf_id +533 kernel/bpf/btf.c

   532	
 > 533	s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
   534	{
   535		struct btf *btf;
   536		s32 ret;
   537		int id;
   538	
   539		btf = bpf_get_btf_vmlinux();
   540		if (IS_ERR(btf))
   541			return PTR_ERR(btf);
   542		if (!btf)
   543			return -EINVAL;
   544	
   545		ret = btf_find_by_name_kind(btf, name, kind);
   546		/* ret is never zero, since btf_find_by_name_kind returns
   547		 * positive btf_id or negative error.
   548		 */
   549		if (ret > 0) {
   550			btf_get(btf);
   551			*btf_p = btf;
   552			return ret;
   553		}
   554	
   555		/* If name is not found in vmlinux's BTF then search in module's BTFs */
   556		spin_lock_bh(&btf_idr_lock);
   557		idr_for_each_entry(&btf_idr, btf, id) {
   558			if (!btf_is_module(btf))
   559				continue;
   560			/* linear search could be slow hence unlock/lock
   561			 * the IDR to avoiding holding it for too long
   562			 */
   563			btf_get(btf);
   564			spin_unlock_bh(&btf_idr_lock);
   565			ret = btf_find_by_name_kind(btf, name, kind);
   566			if (ret > 0) {
   567				*btf_p = btf;
   568				return ret;
   569			}
   570			spin_lock_bh(&btf_idr_lock);
   571			btf_put(btf);
   572		}
   573		spin_unlock_bh(&btf_idr_lock);
   574		return ret;
   575	}
   576	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

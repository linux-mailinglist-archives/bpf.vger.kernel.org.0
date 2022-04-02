Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268C4EFF31
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 08:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiDBGmd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Apr 2022 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGmd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Apr 2022 02:42:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B094F212E
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648881642; x=1680417642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sBpRmVdgWdcxybq2ixbnIP81AS1BneBJcnmLbx+IxuE=;
  b=mIUrE0ILoMSDliP7tYYaRpnawH+rg0ywQZJlm4gxZPqUFfC8hKUw2xhj
   vBuofSqaSVVwxqA5qQCZV8DCVfMwPBvKLivTI7TKGveRJ2KScOfk01ee2
   sIAipTSazrAm/WvOMxgf5JZBIeecJow4Vdi/JKQ+LdMOARgjEUxNlYDWD
   a6IwGeYtXoHeeTEPlC8U1c7GfSNhAmnpua3ygT1xjEyzYHD+iEmZl2Cv2
   EJ85+DF54B05NwUiQgdRAv4KiRPet9JhYOSFW5RTAj9mvKrUb/cveLa4g
   l14O5o5edRqA5PwlnRfRWSx0oFhycL8TOE749keFqy3BBWYJSoDdOJ/ch
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259110242"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259110242"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 23:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="656292572"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2022 23:40:39 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naXR9-0001o3-4J;
        Sat, 02 Apr 2022 06:40:39 +0000
Date:   Sat, 2 Apr 2022 14:40:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/7] bpf: Dynptr support for ring buffers
Message-ID: <202204021459.6f2G1oTF-lkp@intel.com>
References: <20220402015826.3941317-7-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402015826.3941317-7-joannekoong@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/Dynamic-pointers/20220402-100110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220402/202204021459.6f2G1oTF-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/64c5b9e2d2df7ff61dd8bd2e36a29ffff264e2ff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joanne-Koong/Dynamic-pointers/20220402-100110
        git checkout 64c5b9e2d2df7ff61dd8bd2e36a29ffff264e2ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/ringbuf.c: In function '____bpf_ringbuf_reserve_dynptr':
>> kernel/bpf/ringbuf.c:491:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     491 |         sample = (void *)____bpf_ringbuf_reserve(map, size, flags);
         |                  ^


vim +491 kernel/bpf/ringbuf.c

   478	
   479	BPF_CALL_4(bpf_ringbuf_reserve_dynptr, struct bpf_map *, map, u32, size, u64, flags,
   480		   struct bpf_dynptr_kern *, ptr)
   481	{
   482		void *sample;
   483		int err;
   484	
   485		err = bpf_dynptr_check_size(size);
   486		if (err) {
   487			bpf_dynptr_set_null(ptr);
   488			return err;
   489		}
   490	
 > 491		sample = (void *)____bpf_ringbuf_reserve(map, size, flags);
   492	
   493		if (!sample) {
   494			bpf_dynptr_set_null(ptr);
   495			return -EINVAL;
   496		}
   497	
   498		bpf_dynptr_init(ptr, sample, BPF_DYNPTR_TYPE_RINGBUF, 0, size);
   499	
   500		return 0;
   501	}
   502	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D386D0E1C
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC3SwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjC3SwU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:52:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE1DBF7
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680202328; x=1711738328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGVvbTSTSllsWzUf3VAifeGyEjQUaxhqlzVmZb4zA70=;
  b=UBTM5pK38Vn7EFW3MXqOo1SlrseWR0s8RdNCX6ntDc3Y3PDmDY1hfuHR
   lyngRxG8S55Il8HgrI9ObKWXoAIDmLia9vgqqywC9/W2W69Xgy7mFomGC
   u+B4ru6ct23RdPjyxAyF0BwNuCyyKnbTBvpEgrATH4COsy/vqoYoZBJdC
   IEg8GO+OeUW5XrzHmRPqKfDqKVmYSb/+z3eWDgMKpfoIOFhYwYtNmoQd7
   hFDCrCXhwXnVsVvczAKnSgPwjsc2yWH1p3mnRGKi6JiD67RSRwQwAsazo
   1ca30i+8qhTSR8645DMjAD3U5/Sbp6lcOzXoLvMxX3EAjuAsdjV25c3my
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="403954576"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="403954576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="687367957"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="687367957"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2023 11:52:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phxNV-000L76-27;
        Thu, 30 Mar 2023 18:52:05 +0000
Date:   Fri, 31 Mar 2023 02:51:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kafai@fb.com, sdf@google.com,
        edumazet@google.com, aditi.ghag@isovalent.com
Subject: Re: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match
 socket attributes
Message-ID: <202303310242.QYEDFSaE-lkp@intel.com>
References: <20230330151758.531170-4-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330151758.531170-4-aditi.ghag@isovalent.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Aditi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditi-Ghag/bpf-tcp-Avoid-taking-fast-sock-lock-in-iterator/20230330-232137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230330151758.531170-4-aditi.ghag%40isovalent.com
patch subject: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match socket attributes
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20230331/202303310242.QYEDFSaE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/66cc617bebf6cb3d2162587d6e248d86bc59c1c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aditi-Ghag/bpf-tcp-Avoid-taking-fast-sock-lock-in-iterator/20230330-232137
        git checkout 66cc617bebf6cb3d2162587d6e248d86bc59c1c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310242.QYEDFSaE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/ipv4/udp.c:2986:20: warning: 'seq_sk_match' used but never defined
    2986 | static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk);
         |                    ^~~~~~~~~~~~
--
   hppa-linux-ld: net/ipv4/udp.o: in function `udp_get_first':
>> (.text+0x11b0): undefined reference to `seq_sk_match'
   hppa-linux-ld: net/ipv4/udp.o: in function `udp_get_next':
   (.text+0x123c): undefined reference to `seq_sk_match'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

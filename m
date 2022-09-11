Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56D5B4DA5
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIKLD5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIKLD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 07:03:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506D02B61B
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662894235; x=1694430235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0odAtVHMNF7FQEe+eTbElArWamk4jhZ7iWPQa7wX2A=;
  b=WUethYTKEAnrYgKOQOXjjS4cSUVZJTGhwtCgajmj6851UyGuYmKGu0yx
   0wZl6S3OWI7SWiheMcrw5ZGL5omzfmSGrgOHnvgWCBIZ82UMJa3XFlk7K
   7vfVNTgcD4QvG2Cb63C1vRKFu8WjxRfy/eE7E/0rIdBsCPFkmOUhMbz++
   WDdEYxBrjtUn21gTkJNlimN7Qp5PzKlrk3INsha60IwtDRkkPN4YS97qp
   fkr9tjrmcV2CAtdUeamNdCo8E3wihohYPYF+WKR6zqRT3apzn/yR0yNpF
   z8/tEAcUktQbNwtwcwSAe6ZOEb5pWA7gdmvaGr6w5yPQ4WPDJvQRABlo2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="280733748"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="280733748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 04:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="860871377"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2022 04:03:51 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXKkg-0001Mo-1y;
        Sun, 11 Sep 2022 11:03:50 +0000
Date:   Sun, 11 Sep 2022 19:03:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
Message-ID: <202209111856.i93jzyMu-lkp@intel.com>
References: <20220911084609.102519-3-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911084609.102519-3-shmulik.ladkani@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Shmulik,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Shmulik-Ladkani/bpf-Support-setting-variable-length-tunnel-options/20220911-164822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: hexagon-randconfig-r026-20220911 (https://download.01.org/0day-ci/archive/20220911/202209111856.i93jzyMu-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/caa3b97e327a79cad590d53687cc0e9eb07ecd4b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shmulik-Ladkani/bpf-Support-setting-variable-length-tunnel-options/20220911-164822
        git checkout caa3b97e327a79cad590d53687cc0e9eb07ecd4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_dynptr_get_size
   >>> referenced by filter.c
   >>>               core/filter.o:(bpf_skb_set_tunnel_opt_dynptr) in archive net/built-in.a
   >>> referenced by filter.c
   >>>               core/filter.o:(bpf_skb_set_tunnel_opt_dynptr) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C55B4DA4
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 13:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiIKLDz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIKLDz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 07:03:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768E2B60F
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662894234; x=1694430234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1MtO28anc7uNUVGi1jIu2XWb/fBZng3fUvzn9nJDj4=;
  b=GGjFdSVQCnrh/iARFOpQh24dDZApP1hcVrr2H1nJkh7XjWvMDkLwNXWX
   7SCw3nmgWPQQW3dCdhqfFsz0rGwVzqYkKgFjFItR7R+d4RHgmGK4tOpOm
   0ieDG0MnowQMex66suip/L8t/PsPAfbY6srue2PRhFqX/VMBUnVguFQsz
   L1gFp3IyQtPkJ4YrTMFf3ichUi2RAuvc8AhpspfUzgS1noHfb+u304S4G
   TbC9111ILBLQZeJZHWMYes5aE4HlN1ujrzmbLXxMbdLCaUOseorXfOVrM
   QRD+7TGoHXcBCPEbZBlgeaN/SieBQi4aNsC48Cc3eNfrMe8EW2ndgyogT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="280733747"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="280733747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 04:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="860871376"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2022 04:03:51 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXKkg-0001Ml-1d;
        Sun, 11 Sep 2022 11:03:50 +0000
Date:   Sun, 11 Sep 2022 19:03:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
Message-ID: <202209111828.Bns8KP2S-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220911/202209111828.Bns8KP2S-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/caa3b97e327a79cad590d53687cc0e9eb07ecd4b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shmulik-Ladkani/bpf-Support-setting-variable-length-tunnel-options/20220911-164822
        git checkout caa3b97e327a79cad590d53687cc0e9eb07ecd4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/core/filter.o: in function `bpf_skb_set_tunnel_opt_dynptr':
>> filter.c:(.text+0xdedc): undefined reference to `bpf_dynptr_get_size'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

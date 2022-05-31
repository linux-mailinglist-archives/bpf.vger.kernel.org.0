Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB95393B9
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbiEaPOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345560AbiEaPOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 11:14:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A437996AB;
        Tue, 31 May 2022 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010090; x=1685546090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9HNXnFqK1mPAYH35aD8FyV60Dy2hQJUS48IQmcwuYrM=;
  b=VC6BnQQ41JjytGhjoICkRZ6RHAjfLXM00kSoY30XP6PKpbVbuE+fF/yX
   RMU3r3GQ/dyv4bqk5jRCMApmjZIztm16/94fGt869GPTLc8WrthCOxJq8
   X8OXZvKPNqV2B+SoWRfNXboV0oQDxxeJFtqAQXFzguuHW4o3nY+QqCoMK
   SDpqRia+c5GYsAv59l2xcrAUK2oH00UTZVxkMgxTkXhIAt7Tw0T6I+ICs
   bRCbYx6lHmSS1NxvclspAC2h8/CrOsT/fAYvo+7BS1/MZb7rKnSHF00+y
   gh7zYyMoZF0xX+aAfjBu8zch6IiBc43KbFF/ZFMp3bURbwcPD5MES6mS6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="262918125"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="262918125"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="706618270"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2022 08:13:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw3YZ-0002oU-5U;
        Tue, 31 May 2022 15:13:15 +0000
Date:   Tue, 31 May 2022 23:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kbuild-all@lists.01.org, Daniel Xu <dxu@dxuuu.xyz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Add PROG_TEST_RUN support to
 kprobe
Message-ID: <202205312315.3VC5jz4T-lkp@intel.com>
References: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Xu/Add-PROG_TEST_RUN-support-to-BPF_PROG_TYPE_KPROBE/20220530-060742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: s390-randconfig-r026-20220531 (https://download.01.org/0day-ci/archive/20220531/202205312315.3VC5jz4T-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a547a4c795103fd002d3bbb5ee4d7141113716c0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Xu/Add-PROG_TEST_RUN-support-to-BPF_PROG_TYPE_KPROBE/20220530-060742
        git checkout a547a4c795103fd002d3bbb5ee4d7141113716c0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> s390-linux-ld: kernel/trace/bpf_trace.o:(.data.rel.ro+0x100): undefined reference to `bpf_prog_test_run_kprobe'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x313e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x3192): undefined reference to `devm_ioremap_resource'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BC53A2C8
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiFAKhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiFAKhI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 06:37:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC556FA4;
        Wed,  1 Jun 2022 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654079826; x=1685615826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRzXRhmweAXGfPI0innNsyhnWdgFvifkjj5F+obP+I4=;
  b=aps6OuqhIRFBNAS1IZS7ztBmKH3sJ3szfc9HIia7Az+AKHyd/NKTUCmC
   x21alCb21Awf6ux4NKPMhrk7U57tBa7u+Ub7s9hFu7ImADqhruM3Oj0ow
   Rw85vQbjv3OCKpgEEIlQMM1/4OaBMgmh9ujniyGqia+BiHIVUCE4x/78o
   7e1OBXtvDF1zBTh7umPElRI99iGWSWCjmfUht1KSg8sqls7xd7cpsyL/F
   L9wwjKMH+L1otH4aWdlnK3T9gpVdMgrSqmr4kLlSYoPFP9YcuqxN9NyI3
   uVMOgVmrIHUKtpB+xyl+P/MIJMwEE0Gwhernm0ZgYk1uphVpnO2Ow5yWL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="273109712"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="273109712"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="612264968"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2022 03:36:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwLih-0003rO-OH;
        Wed, 01 Jun 2022 10:36:55 +0000
Date:   Wed, 1 Jun 2022 18:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Add PROG_TEST_RUN support to
 kprobe
Message-ID: <202206011814.9lsKlbB0-lkp@intel.com>
References: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: s390-randconfig-r002-20220531 (https://download.01.org/0day-ci/archive/20220601/202206011814.9lsKlbB0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a547a4c795103fd002d3bbb5ee4d7141113716c0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Xu/Add-PROG_TEST_RUN-support-to-BPF_PROG_TYPE_KPROBE/20220530-060742
        git checkout a547a4c795103fd002d3bbb5ee4d7141113716c0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/trace/bpf_trace.o:kernel/trace/bpf_trace.c:1365: undefined reference to `bpf_prog_test_run_kprobe'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

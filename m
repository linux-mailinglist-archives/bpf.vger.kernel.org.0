Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0605529B5
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 05:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiFUDUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 23:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUDUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 23:20:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC4A1FCD0
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 20:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655781632; x=1687317632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HtGtyOAw3EPbRlSQyh87PysGHjoA34yWeBWU6S1lLj0=;
  b=F02sLDRg5SP+AMCTVSEUn7/j68wwfAyudLI+75CPIb46+ZdmfdysBiIR
   WyqiptuXc79b2rrU6J/t01pmF6ltHjmL5UmwaGpwC+SWVtn1L86PmnXeS
   LQCWz8yOmPTBqwr+10j28mOjWgoA0bxOUO1gNwsRE73IoihvBpW24LuUZ
   is66XD16CYAK4MBfXI2Oioy5YxK+47SivdatqceDDsY68BW9hWKJ8MQse
   HmShFodEEoFYeaIXaTpU0vy+82+8tCkCk5ApnxN52j9qa0yI9kG6MFqEH
   NWGbGrz7mL5APEUOiLOufuk7rbGl9LjlUIu6CgQa9LPmUyO4KYJ1MTL6A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="260448703"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="260448703"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 20:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="676805905"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2022 20:20:30 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3URJ-000Y57-ER;
        Tue, 21 Jun 2022 03:20:29 +0000
Date:   Tue, 21 Jun 2022 11:20:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Message-ID: <202206211035.p3LxbVfK-lkp@intel.com>
References: <20220621012811.2683313-5-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621012811.2683313-5-kpsingh@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi KP,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/Add-bpf_getxattr/20220621-093013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: x86_64-randconfig-a015-20220620 (https://download.01.org/0day-ci/archive/20220621/202206211035.p3LxbVfK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dd49d2ffb18adceafa98bd517008f59aa9bc910b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review KP-Singh/Add-bpf_getxattr/20220621-093013
        git checkout dd49d2ffb18adceafa98bd517008f59aa9bc910b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1185:25: warning: no previous prototype for function 'bpf_getxattr' [-Wmissing-prototypes]
   noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
                           ^
   kernel/trace/bpf_trace.c:1185:17: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
                   ^
                   static 
   1 warning generated.


vim +/bpf_getxattr +1185 kernel/trace/bpf_trace.c

  1184	
> 1185	noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
  1186					     const char *name, void *value, int size)
  1187	{
  1188		return __vfs_getxattr(dentry, inode, name, value, size);
  1189	}
  1190	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

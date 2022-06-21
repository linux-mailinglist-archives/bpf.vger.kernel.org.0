Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2080552975
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 04:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiFUCjm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 22:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbiFUCjm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 22:39:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB4B1F624
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655779181; x=1687315181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wwp9Htz/wYVWEmv9B3xnCku3l3dsGelb8zxzjQHDCEE=;
  b=MBwnTDv0J/bDxaRAM+Fnkr8N0F2FIpgTdoKJuDJwlB3OTf54NtPKhkLn
   Tr0ZHZ+SAlhZ/tNRT9/llR4lHiCqRUbfjx3ZrgZn5YdZSXsxEc233sk7X
   /eOyO467X9s5ZdYPOxKn5OGTKYnoCf3Y3a/jlhSOv8PPqMTsDHKoVCXQA
   4UjUWvTDdDGDHCMIUiN/7xTfPYsrZhGUOCwtq/5QjBDTOQiRWtDDupPDw
   El9Yk3yG2JmC4iUqINnZmIkaOfRrTYkH3OSgIqrHovhtHxgLcbctqYW5j
   mSbK/Y3/gUyMDaBah4oxczA5gLtgOj0gSjFPlSq48Ja4R7r2BL7UXN4rb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280740292"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280740292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 19:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="585097300"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 19:39:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Tna-000Xuy-Ct;
        Tue, 21 Jun 2022 02:39:26 +0000
Date:   Tue, 21 Jun 2022 10:38:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Message-ID: <202206211053.VsuVPf7q-lkp@intel.com>
References: <20220621012811.2683313-5-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621012811.2683313-5-kpsingh@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220621/202206211053.VsuVPf7q-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dd49d2ffb18adceafa98bd517008f59aa9bc910b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review KP-Singh/Add-bpf_getxattr/20220621-093013
        git checkout dd49d2ffb18adceafa98bd517008f59aa9bc910b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1185:25: warning: no previous prototype for 'bpf_getxattr' [-Wmissing-prototypes]
    1185 | noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
         |                         ^~~~~~~~~~~~


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

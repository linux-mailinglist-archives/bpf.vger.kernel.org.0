Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E96674E2D
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjATHeF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjATHeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:34:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6397798C4;
        Thu, 19 Jan 2023 23:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674200036; x=1705736036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyp1q4NF+AQWsmdJvGVKlDdz6pk0bNQYLVT4YSlYHhM=;
  b=fH97re6BFIIoWj7t22iBINds/MAPWMHRJmpaQbioJUGfX10bHqCNrfCT
   ipR7hVOGVbB2FcO5aKbFRs6k17IyILjYE8hXOFyH8LQF+0Lf8Ve/+1LLI
   s5t2/80b4I8uIZad3dgxcG9TCVhRceDMdBpdCyYJdTkiVII/0DzLDxjTB
   +R03cTESwgq2v4fAxJSwG4+6qVadLQA3gr/iPS/b4NynaCBnKVWq9sChu
   Uw8J+/Fj/dmc7itfcHdYm3UbwqRQsSzSEt6sBIfkLMPKiiYn3dIudXDS2
   dFQq1STFdbVVl/sQphPJxfJX9rczKJmlA0bJylDlrO1gAh6hBWd0He8Zm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327616484"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="327616484"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 23:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989319597"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="989319597"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 23:33:52 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIluE-0002KY-38;
        Fri, 20 Jan 2023 07:33:46 +0000
Date:   Fri, 20 Jan 2023 15:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, jackmanb@google.com, renauld@google.com,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH RESEND bpf-next 2/4] security: Generate a header with the
 count of enabled LSMs
Message-ID: <202301201525.vZDnlpJ2-lkp@intel.com>
References: <20230120000818.1324170-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi KP,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230120-133309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230120000818.1324170-3-kpsingh%40kernel.org
patch subject: [PATCH RESEND bpf-next 2/4] security: Generate a header with the count of enabled LSMs
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230120/202301201525.vZDnlpJ2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/831b06220bb29c6db171467b13903dac0ef2faa5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230120-133309
        git checkout 831b06220bb29c6db171467b13903dac0ef2faa5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> /bin/bash: line 1: scripts/security/gen_lsm_count: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

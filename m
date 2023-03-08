Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169296B0D68
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCHPxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 10:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCHPw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 10:52:58 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4223E636
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678290772; x=1709826772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ksZy6yBgs1wq/8pT/Ohy0X8X8VT76kvpenT/22U/R6U=;
  b=DhkUNBXdcBkC+y/sbUGOho+1bbj/3NEZqlk9BmG52PfyT3N35ax/Dsq5
   +Uh9pvWYESAOwXzdhSwgxq3u8kOBIJJWLltM5F2lnLm7aH/14NchA2NQr
   J1hdnz7pjZ2UOec5TQ5mfWnqUnQK+vnWNbSCVbYCrLnd1fGNLjEDx5trt
   rHmLoS1dS9RLMotd/9hxzJxWyqWutg1nVLX97F+PDqyaRusOT8GVXiGoP
   5ri3rVgZiUBVnahISE0TXq8xq22b8zzo1ypjgDlOu8AnSTE+NwTDlGOSl
   wXWNA9ECLH0rWPlwzb+9QSYVDvci+Dyu8hQkN3fkwH0Hcde3MCHlmUfer
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336207672"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="336207672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="766029013"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766029013"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 07:52:49 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZw5w-0002Ej-2u;
        Wed, 08 Mar 2023 15:52:48 +0000
Date:   Wed, 8 Mar 2023 23:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        andrii@kernel.org, kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 4/8] bpf: implement number iterator
Message-ID: <202303082315.foifky6G-lkp@intel.com>
References: <20230308035416.2591326-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308035416.2591326-5-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-factor-out-fetching-basic-kfunc-metadata/20230308-115539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230308035416.2591326-5-andrii%40kernel.org
patch subject: [PATCH v4 bpf-next 4/8] bpf: implement number iterator
config: i386-randconfig-a015-20230306 (https://download.01.org/0day-ci/archive/20230308/202303082315.foifky6G-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/19acf9ca01e2927a29d3235b3aa73598430dcb70
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/bpf-factor-out-fetching-basic-kfunc-metadata/20230308-115539
        git checkout 19acf9ca01e2927a29d3235b3aa73598430dcb70
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082315.foifky6G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/bpf_iter.c:794:2: error: call to __compiletime_assert_395 declared with 'error' attribute: BUILD_BUG_ON failed: __alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter_num)
           BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter_num));
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:399:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:387:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:380:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:74:1: note: expanded from here
   __compiletime_assert_395
   ^
   1 error generated.


vim +/error +794 kernel/bpf/bpf_iter.c

   784	
   785	__diag_push();
   786	__diag_ignore_all("-Wmissing-prototypes",
   787			  "Global functions as their definitions will be in vmlinux BTF");
   788	
   789	__bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
   790	{
   791		struct bpf_iter_num_kern *s = (void *)it;
   792	
   793		BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) != sizeof(struct bpf_iter_num));
 > 794		BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter_num));
   795	
   796		BTF_TYPE_EMIT(struct btf_iter_num);
   797	
   798		/* start == end is legit, it's an empty range and we'll just get NULL
   799		 * on first (and any subsequent) bpf_iter_num_next() call
   800		 */
   801		if (start > end) {
   802			s->cur = s->end = 0;
   803			return -EINVAL;
   804		}
   805	
   806		/* avoid overflows, e.g., if start == INT_MIN and end == INT_MAX */
   807		if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
   808			s->cur = s->end = 0;
   809			return -E2BIG;
   810		}
   811	
   812		/* user will call bpf_iter_num_next() first,
   813		 * which will set s->cur to exactly start value;
   814		 * underflow shouldn't matter
   815		 */
   816		s->cur = start - 1;
   817		s->end = end;
   818	
   819		return 0;
   820	}
   821	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

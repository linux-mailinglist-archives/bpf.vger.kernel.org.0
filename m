Return-Path: <bpf+bounces-1746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB62A720A7D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B73281B00
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84E8493;
	Fri,  2 Jun 2023 20:42:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB33846B
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:42:04 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FBE44;
	Fri,  2 Jun 2023 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685738523; x=1717274523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DNGbOdRYD8XuQTnt+XBn8XRgskTE1kEgAMW34LP/Cs8=;
  b=N8g+Eq5YSk1vDDGCDzmWim1C0bUQ1z+LZWsssXHKfXPYh6DUWLnwZAgO
   u9Yqkl2iZc4tVI6H5zWay0QmEBv140y85EAlfnaKI7ib5W8ITSnwRVHbj
   TLzCIRtEhxPZDT+PD/3BdbPvJfM9yQnh5VjLsbH/JIhKJbyK2rVLt8BaF
   4w3dphvqSm1A34sffghchGqEzqESQow39acFhmUdIpReM2fLaiD+LiBX/
   cgQxiVAiUnBfWMRvVx4f7ynSblOApFfqoUwnxYqreOr+iQCNEqjhJaKg3
   FRDgr5kWuXZYz3k51YNELQIEu2khJ5F/74PGZ8RBtg5ffP3RiMrw7hIsv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335580438"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="335580438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 13:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852274695"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="852274695"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2023 13:42:01 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q5Bay-0000wR-1R;
	Fri, 02 Jun 2023 20:42:00 +0000
Date: Sat, 3 Jun 2023 04:41:16 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
	cyphar@cyphar.com, luto@kernel.org
Subject: Re: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
Message-ID: <202306030402.Nn38A6qD-lkp@intel.com>
References: <20230602150011.1657856-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602150011.1657856-2-andrii@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-introduce-BPF-token-object/20230602-230448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230602150011.1657856-2-andrii%40kernel.org
patch subject: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
config: sparc-randconfig-r022-20230531 (https://download.01.org/0day-ci/archive/20230603/202306030402.Nn38A6qD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/59e6ef2000a056ce3386db8481e477e5abfbbe15
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/bpf-introduce-BPF-token-object/20230602-230448
        git checkout 59e6ef2000a056ce3386db8481e477e5abfbbe15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030402.Nn38A6qD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/filter.h:9,
                    from arch/sparc/kernel/sys_sparc32.c:29:
   include/linux/bpf.h: In function 'bpf_token_new_fd':
>> include/linux/bpf.h:2465:16: error: returning 'int' from a function with return type 'struct bpf_token *' makes pointer from integer without a cast [-Werror=int-conversion]
    2465 |         return -EOPNOTSUPP;
         |                ^
   cc1: all warnings being treated as errors


vim +2465 include/linux/bpf.h

  2462	
  2463	static inline struct bpf_token *bpf_token_new_fd(struct bpf_token *token)
  2464	{
> 2465		return -EOPNOTSUPP;
  2466	}
  2467	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


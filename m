Return-Path: <bpf+bounces-1558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07524718FAB
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C8281665
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 00:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD015A0;
	Thu,  1 Jun 2023 00:45:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF391114
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 00:45:16 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18A211F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685580313; x=1717116313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RiFnUNlsnq/3I5td0/M8EalsN+fmDjuZTEsFh4zgPZI=;
  b=irHlqM2TDKz5kORDsJJGmOvtyGR0cnkWH3ui+fVOOcCd4qO4W0sktsBj
   5hHt+b/ZMlBVOon9XfA5OtmOS5h0niRciWIv21tIxAdxpiJHBFMBv2ONP
   0yOehyOsG8jNde3PBteKTfr2vyAqiZFtmdy+Z4Sqs3Ez+dcoSLx4I8NY0
   MLuRN0rTnTzJfY3Pi8l3rXQqr3H5cGeVy2hVGBAdiogglPJev12gEi3HR
   eBvRM8azx8KKNH+IsNFNeg0fqR2k1xr0sFPw9RDycwUAfZTncw37B+BoG
   /zJ2O3S065p3UXFFAy+4sbYHGNaP0U5/xiGhHGKuhPfFvkAO2ciQ9YUYN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="383676433"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="383676433"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 17:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="710273448"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="710273448"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 May 2023 17:44:46 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q4WQn-0001il-2i;
	Thu, 01 Jun 2023 00:44:45 +0000
Date: Thu, 1 Jun 2023 08:44:24 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Anton Protopopov <aspsk@isovalent.com>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <202306010837.mGhA199K-lkp@intel.com>
References: <20230531110511.64612-2-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531110511.64612-2-aspsk@isovalent.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Anton,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-add-new-map-ops-map_pressure/20230531-190704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230531110511.64612-2-aspsk%40isovalent.com
patch subject: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230601/202306010837.mGhA199K-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/025cc7c86c6c7e108ba5b9946a0f50e0cc082f9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anton-Protopopov/bpf-add-new-map-ops-map_pressure/20230531-190704
        git checkout 025cc7c86c6c7e108ba5b9946a0f50e0cc082f9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306010837.mGhA199K-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/hashtab.c: In function 'htab_map_pressure':
>> kernel/bpf/hashtab.c:189:24: error: implicit declaration of function '__percpu_counter_sum'; did you mean 'percpu_counter_sum'? [-Werror=implicit-function-declaration]
     189 |                 return __percpu_counter_sum(&htab->pcount);
         |                        ^~~~~~~~~~~~~~~~~~~~
         |                        percpu_counter_sum
   cc1: some warnings being treated as errors


vim +189 kernel/bpf/hashtab.c

   183	
   184	static u32 htab_map_pressure(const struct bpf_map *map)
   185	{
   186		struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
   187	
   188		if (htab->use_percpu_counter)
 > 189			return __percpu_counter_sum(&htab->pcount);
   190		return atomic_read(&htab->count);
   191	}
   192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


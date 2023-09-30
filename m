Return-Path: <bpf+bounces-11157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086C7B417D
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C758F2831E0
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD89168C4;
	Sat, 30 Sep 2023 15:10:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A78168B1;
	Sat, 30 Sep 2023 15:10:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70232E5;
	Sat, 30 Sep 2023 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696086607; x=1727622607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dfa5zhFqBrsiQ9Qbmxgu5xsEKd3PuybE9tpo/A0ZtPE=;
  b=UdW4aWGRAmjlvqxFg6V5oB2ow+KL6jfobIV1+INbKSSGq74d++ZK5tc8
   ikLHaxsInRv2GsioxWpkssks6OABq+w/3zARjN++knGDt0QrJWYNdZAKm
   ehIdL0kewr0Whm5wtmpuHhsC6eSVeRqRekJuv4/tUyqed0Ger/a+QOnUb
   YIWVO0vwQhuNgyBhAEUgm06uBWI4G2kDGb/AKQ3uBDx9iq5DMQm5E3ziQ
   x531kupuvhOY8EdZ2VKiOsrWpHRIDYReuLg7X/8DMkp2GikyjbbwEZ4Lg
   Euk9gU3LcqZGE/Y3tOk2u/aNoiiSdeVk4dBYvfCf4Om5Y41tLBnmgM43C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="361834848"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="361834848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 08:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="815864041"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="815864041"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2023 08:10:04 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmbbW-0004E9-1y;
	Sat, 30 Sep 2023 15:10:02 +0000
Date: Sat, 30 Sep 2023 23:09:20 +0800
From: kernel test robot <lkp@intel.com>
To: Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCH bpf 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Message-ID: <202309302249.FeC1Gbp9-lkp@intel.com>
References: <20230929150717.120463-2-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929150717.120463-2-m@lambda.lt>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Martynas,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Martynas-Pumputis/bpf-Derive-source-IP-addr-via-bpf_-_fib_lookup/20230929-231536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20230929150717.120463-2-m%40lambda.lt
patch subject: [PATCH bpf 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
config: i386-buildonly-randconfig-006-20230930 (https://download.01.org/0day-ci/archive/20230930/202309302249.FeC1Gbp9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302249.FeC1Gbp9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302249.FeC1Gbp9-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/core/filter.o: in function `ip6_route_get_saddr.constprop.0':
>> filter.c:(.text+0xaebe): undefined reference to `ipv6_dev_get_saddr'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-11170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECB7B46AE
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 12:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 18112282782
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5821548D;
	Sun,  1 Oct 2023 10:08:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B014F92;
	Sun,  1 Oct 2023 10:08:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD99BF;
	Sun,  1 Oct 2023 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696154882; x=1727690882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyMaQ6ChrCDTHHiJO3QvgaQ/x0Uc+ByAZaSMKQ5gVW8=;
  b=dKr8I2XHAMiv76Eo4CkVLbYApsp3xEY0ujskpiB/5gCUITl3OsB3oZc+
   OOqWRs+PAXMOXmsaoUiQIW/CLOMoWVLrWWWTftYBrEkC/NfeG44wibvYM
   U2glGUjj4dSo8gvPs3UasfVRSPbi7cbRh8O9yAPejduL5bT+lnHDbT7o+
   MbFnreqQM/ON13nu7iK9qt1YcJr7P1f7DiafUktsQY6dvFVg6a53Vf5Xe
   race4UVQ7xC0gM6cum72JknX0YHSy4MtUZIRvaTKcOBHGcv1pWG5JDLNq
   NPz1F73INZGgQLeXUk2Ihv7MrkW+eQxKquXo3k47ONI65aa1CNIyR0v1A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="385342010"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="385342010"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 03:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="820621707"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="820621707"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2023 03:08:00 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmtMj-0004y1-1L;
	Sun, 01 Oct 2023 10:07:57 +0000
Date: Sun, 1 Oct 2023 18:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCH bpf 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Message-ID: <202310011747.2WjYkVa8-lkp@intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20231001/202310011747.2WjYkVa8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310011747.2WjYkVa8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310011747.2WjYkVa8-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: net/core/filter.o: in function `ip6_route_get_saddr.constprop.0':
   filter.c:(.text+0x7594): undefined reference to `ipv6_dev_get_saddr'
>> csky-linux-ld: filter.c:(.text+0x75c0): undefined reference to `ipv6_dev_get_saddr'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


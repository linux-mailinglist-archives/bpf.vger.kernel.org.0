Return-Path: <bpf+bounces-17594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC180F9CE
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397D21F21854
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9264CD6;
	Tue, 12 Dec 2023 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8X6Dwca"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16733B7;
	Tue, 12 Dec 2023 13:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702418231; x=1733954231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cR/SZi/CQM7AqNyWws8Tpn6BYvRNvG5YcWdlZDDZfOg=;
  b=m8X6DwcaQghDqX9wk61v729PfU12zm5BfAZVdHsAi/R0L6M0d6i+KKU5
   jKjAsI8B4//F+yaa384ndf6Uq2sKw8MDzV1+jjZrInVtMrg8ZLAKRImPd
   OzzTTgS1a21OFx43vli/sE+eGEWAVfEhzEYbbGFxMTPLYqf4EJiPMct2A
   dCmyAUl9/nN00/0sdIPsMTFqQvWyw7LzG/JeMY8RJl6L4OdawPbXEkIZW
   7Qv2v/WrtEIZctyM1MDsx0yM1ddWhVLIiHfEz4BlaZsx2+2gJHVw5cVCQ
   o4ts9AUrmHNpf3rH+f+++DzgwuULG2Wjp3H705xAMF0+m21s/MlmWA+S1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461350451"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461350451"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="15177903"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Dec 2023 13:57:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDAkS-000Jlj-1W;
	Tue, 12 Dec 2023 21:57:04 +0000
Date: Wed, 13 Dec 2023 05:56:47 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v4 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
Message-ID: <202312130531.EIYsEYp0-lkp@intel.com>
References: <2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-introduce-page_pool-pointer-in-softnet_data-percpu-struct/20231212-181103
base:   net-next/main
patch link:    https://lore.kernel.org/r/2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo%40kernel.org
patch subject: [PATCH v4 net-next 1/3] net: introduce page_pool pointer in softnet_data percpu struct
config: arc-defconfig (https://download.01.org/0day-ci/archive/20231213/202312130531.EIYsEYp0-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130531.EIYsEYp0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130531.EIYsEYp0-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-elf-ld: net/core/dev.o: in function `net_dev_init':
>> dev.c:(.init.text+0x180): undefined reference to `page_pool_create'
>> arc-elf-ld: dev.c:(.init.text+0x180): undefined reference to `page_pool_create'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


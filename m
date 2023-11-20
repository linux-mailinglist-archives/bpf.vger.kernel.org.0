Return-Path: <bpf+bounces-15434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12807F2057
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0772827D8
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2DF3A29A;
	Mon, 20 Nov 2023 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAxovLpn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8AA2;
	Mon, 20 Nov 2023 14:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700519337; x=1732055337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJl9q4jn+eJFFWC10gr3xenQfzJWicSqrFJJ6Jl4wD0=;
  b=hAxovLpnEFPxxlbLMcHhtad06HahIRen1dhlsyZAAN/ev/5oG4xvUqP1
   ePzEwkoNHfymqhOcOzVWXLDChtniRZ7NjF8dIP0HGRHsjhJoOQ0XtgAZb
   QROWQRPq3LCovY/BH/1PcqefSz4kdQlfgBc3Q5O1FHAWa8rsvyZNj0S8h
   v3/fbikRel3IWhA+eaRWmQddcRe4yEfwLI4G9hLX3UZrtW7xztS+AicEr
   1+ZZXKmHjBFKxie/amTSCiCaqzlSc/2Jae6oGLUijxYBvjribrbwBeLfd
   FawRrcGJw4nVjeNNmt9PzSO9KgW53Y6yiNIyhUKIT8vDlAABCspC4oO5m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10390860"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="10390860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:28:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="759909051"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="759909051"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2023 14:28:47 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5Cl3-00070Q-1M;
	Mon, 20 Nov 2023 22:28:45 +0000
Date: Tue, 21 Nov 2023 06:28:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, jiri@resnulli.us,
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
	horms@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 13/15] p4tc: add set of P4TC table kfuncs
Message-ID: <202311210628.2LXSAYiy-lkp@intel.com>
References: <20231116145948.203001-14-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116145948.203001-14-jhs@mojatatu.com>

Hi Jamal,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jamal-Hadi-Salim/net-sched-act_api-Introduce-dynamic-actions-list/20231116-230427
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231116145948.203001-14-jhs%40mojatatu.com
patch subject: [PATCH net-next v8 13/15] p4tc: add set of P4TC table kfuncs
config: i386-randconfig-r113-20231120 (https://download.01.org/0day-ci/archive/20231121/202311210628.2LXSAYiy-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210628.2LXSAYiy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210628.2LXSAYiy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: register_p4tc_tbl_bpf
   >>> referenced by p4tc_tmpl_api.c:602 (net/sched/p4tc/p4tc_tmpl_api.c:602)
   >>>               net/sched/p4tc/p4tc_tmpl_api.o:(p4tc_template_init) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


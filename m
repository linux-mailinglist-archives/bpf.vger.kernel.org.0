Return-Path: <bpf+bounces-15327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FFD7F04F1
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 10:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7386B20984
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A26FBA;
	Sun, 19 Nov 2023 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahgoZenA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDEA129;
	Sun, 19 Nov 2023 01:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700385333; x=1731921333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j6DquUxB0ba+bsvgNZ+qh/zcBdPlPI6Nucv2UnglaFY=;
  b=ahgoZenA6nv0sOEL6GOFOIJ9e2iEUO+Ls5kbAurYAKt0hNoVRT8qI5YQ
   W20lwQqYb7dFA82gkOokbs433CgKXqaamN4CrT/nWwpiUmanu5tk1OY1N
   apmA5MoAQgno/uPvNgZB41l+2zn26DWVKO/3qdoUjO+fWMe1IqQr9lqWG
   +gqaH06SnK/tiTDFkIBHg2U7OzK/0w17GYVHNLlVahRgqnSluCVtnx40H
   8/jKTGRkO9/qWn9HJEdRapwockkUUahBS5p4pcnDYMs2draMFrnxkyErp
   dO7Df82GbbNDPpXUNiRv4bd7gKKEd4TJ543DCpU6o+RTscVoGhEHgKeWt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="422572725"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="422572725"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 01:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="889641186"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="889641186"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2023 01:15:27 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r4dtl-0004tb-1i;
	Sun, 19 Nov 2023 09:15:25 +0000
Date: Sun, 19 Nov 2023 17:14:46 +0800
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
Message-ID: <202311191752.mYGymxfv-lkp@intel.com>
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
config: um-randconfig-r132-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191752.mYGymxfv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191752.mYGymxfv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191752.mYGymxfv-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: net/sched/p4tc/p4tc_tmpl_api.o: in function `p4tc_template_init':
>> p4tc_tmpl_api.c:(.init.text+0x71): undefined reference to `register_p4tc_tbl_bpf'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


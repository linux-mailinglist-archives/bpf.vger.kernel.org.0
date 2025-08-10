Return-Path: <bpf+bounces-65308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC3B1F868
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 06:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DFE189B52F
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41261C7013;
	Sun, 10 Aug 2025 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxJbrZCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61ACA4E;
	Sun, 10 Aug 2025 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801624; cv=none; b=VtYnAxzjLcZkpoy4B3Pez/9pk+kWy+vMxz851ohSSBcFR8Hg68L8rs9+qfcodOji/FlkyHG8Oka0z994fd0ByGffRjqXCbrAvQR3Lu91F1SMf84UDSOJG4uZ+8DqNiTdsIRH6IrWzR2uuKcra1Mo6z+7ziLXmRDy0BkH/5xefrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801624; c=relaxed/simple;
	bh=3lGbStlu8yMmhRhoMabgr57jQSN1KJvUT8IV+PChT00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiYkyUHjWAn5cBkTvYlXbxRH2ExPQS4r4ax2GBhwpGXa4grXG0qxYG8HS1G4h52IwuJkd3kmjmsZizeNIuVORfovuq8zbZwCdplVlV7wmVf7ySHoPAA3Evt/9GqM3voCEYJblCMfWjLggrmDcjbm4mqb4cv/Qpg4FrNYytEkans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxJbrZCJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754801623; x=1786337623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3lGbStlu8yMmhRhoMabgr57jQSN1KJvUT8IV+PChT00=;
  b=DxJbrZCJNoIha3IyR0U8bOA2cMgQi5/o+suVNqj7bihpsE1KunKv3NjS
   qU8aOlA07+iVQ3bZ/DEUzpVREd8IpWmheyhwE5R/H0buzOSUu4YOX4wf6
   g/O+zqu4nTYPN1yJ6F3kHciCnwIOu7NeCFYYx9Up6M5wm/eOOLBXT1e8w
   dBBizs9qKWvNLWzG+igrgEIW2dy7Ok8BtHVWfuZESD4GFKjH5zg+B9DSP
   ehL+1XwGtEyBe4cxJxkZQNqYsxB8HjevE94jzGOn/drdOYjTSUXEELIIp
   yRdYOpyvb/2GfVvqavyN8dn+FJScXgmhhgtLwJtT1kxjh1BqYFb4zbyVo
   Q==;
X-CSE-ConnectionGUID: fEZUPJmBQp6q8VV9WY7XgA==
X-CSE-MsgGUID: xywdxMidS2a94nq+K0FSVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="60937692"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60937692"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 21:53:42 -0700
X-CSE-ConnectionGUID: x47SEqisQNKcU/UXGw+X3w==
X-CSE-MsgGUID: vN/EfR04RhGvXrtVCgkhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169862035"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 09 Aug 2025 21:53:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uky3p-0005AC-2A;
	Sun, 10 Aug 2025 04:53:33 +0000
Date: Sun, 10 Aug 2025 12:52:43 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jani.nikula@intel.com, simona.vetter@ffwll.ch,
	tzimmermann@suse.de, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH tip 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <202508101230.2KBZa0Ql-lkp@intel.com>
References: <20250810030442.246974-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810030442.246974-3-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/arch-add-the-macro-COMPILE_OFFSETS-to-all-the-asm-offsets-c/20250810-110846
base:   tip/master
patch link:    https://lore.kernel.org/r/20250810030442.246974-3-dongml2%40chinatelecom.cn
patch subject: [PATCH tip 2/3] sched: make migrate_enable/migrate_disable inline
config: arc-randconfig-001-20250810 (https://download.01.org/0day-ci/archive/20250810/202508101230.2KBZa0Ql-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508101230.2KBZa0Ql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508101230.2KBZa0Ql-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:2385:6: warning: no previous prototype for '__migrate_enable' [-Wmissing-prototypes]
    void __migrate_enable(void)
         ^~~~~~~~~~~~~~~~


vim +/__migrate_enable +2385 kernel/sched/core.c

  2384	
> 2385	void __migrate_enable(void)
  2386	{
  2387		struct task_struct *p = current;
  2388		struct affinity_context ac = {
  2389			.new_mask  = &p->cpus_mask,
  2390			.flags     = SCA_MIGRATE_ENABLE,
  2391		};
  2392	
  2393		__set_cpus_allowed_ptr(p, &ac);
  2394	}
  2395	EXPORT_SYMBOL_GPL(__migrate_enable);
  2396	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


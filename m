Return-Path: <bpf+bounces-66370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A304B32C8A
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 01:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F2A5873F2
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356AF2E8E1D;
	Sat, 23 Aug 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT8ITdbP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790A21D5B3;
	Sat, 23 Aug 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755991042; cv=none; b=msLe/rDi/nVuLJSZzLcb34JKrXJD7vYYpFz8DaqBgmzkRNg4mT53pMb5V+ZnFOv3PC2KkEEnQWGj3B7O0wWr7jk0cUWLJccNRRBa86euBw9JvjjIzpdO+awmIh6KiUoMojk2x8mmm15grleifugnBZMkRPEbhOug4+2tr+zg7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755991042; c=relaxed/simple;
	bh=5XgjPckc4HN3AGI2QCeHwGUL1qex5fbc9P55Xl/SwpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbf9U/t7v55T2MQJpV/HudHsJQbVBduIuEToC5xMixbtC1qLeNPiB+TXc0hYW36zj0epyxQ6lx3SWS/U8XFvxfYlSzbHI6UtJtYfALATFdTKR7aj1zhyGcQGTV+G9KPElQIpdXC7lO5ofytxV30aYBe9cWQL7TP9SoRCjJjucuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT8ITdbP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755991041; x=1787527041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5XgjPckc4HN3AGI2QCeHwGUL1qex5fbc9P55Xl/SwpY=;
  b=ZT8ITdbPo5ZYf9KNx5RQtkLrW6eSzuTlEZGYDNmLPtE3wsZrihQku/zQ
   PjJZqBIQgX7ipDWPazEvZEeoW439/g1cqOeEvsegGDjAtD79SZv8e0x34
   7IKKZBeQn0vaJ3rYh45uyvt3Qvw+u70Z6fZWm2EiryKJCHCr4IZ6nwClS
   1zc0+7WqFZ4WGfDJIp0UH8htcNzEQBpcxtr604rjQEXdsrDCHdtZ1Ffkq
   AuEk+0w+R3ooNw/FqwYaqSqFuIjNeFDa0lDM2WGT5CH9ujuemUZ8YN0c3
   WWZE+hqYnygUDtFtvi2EI5bl1S4yJS1wMjYDQMhUNucCjTJKSjtI2GKMw
   w==;
X-CSE-ConnectionGUID: luzLh+w7RJeg6IDH5llkjw==
X-CSE-MsgGUID: 14qS8E9oQ82PP077NUNdeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58115518"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58115518"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 16:17:20 -0700
X-CSE-ConnectionGUID: lsj8eNKZRY+e6vcV9yzrAA==
X-CSE-MsgGUID: sySn3Nh+RcyTJNUhc9FmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168887192"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Aug 2025 16:17:18 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upxU3-000MeB-2G;
	Sat, 23 Aug 2025 23:17:15 +0000
Date: Sun, 24 Aug 2025 07:16:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Hutchings <bwh@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ben Hutchings <bwh@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>, linux-openrisc@vger.kernel.org,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] nios2, openrisc, xtensa: Fix definitions of
 bpf_user_pt_regs_t
Message-ID: <202508240726.GADEDNYH-lkp@intel.com>
References: <20250822135848.1922288-1-ben.hutchings@mind.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822135848.1922288-1-ben.hutchings@mind.be>

Hi Ben,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on openrisc/for-next jcmvbkbc-xtensa/xtensa-for-next v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Hutchings/nios2-openrisc-xtensa-Fix-definitions-of-bpf_user_pt_regs_t/20250822-220742
base:   linus/master
patch link:    https://lore.kernel.org/r/20250822135848.1922288-1-ben.hutchings%40mind.be
patch subject: [PATCH] nios2, openrisc, xtensa: Fix definitions of bpf_user_pt_regs_t
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20250824/202508240726.GADEDNYH-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250824/202508240726.GADEDNYH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508240726.GADEDNYH-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/events/core.c: In function 'bpf_overflow_handler':
>> kernel/events/core.c:10208:18: error: assignment to 'bpf_user_pt_regs_t *' {aka 'struct user_pt_regs *'} from incompatible pointer type 'struct pt_regs *' [-Wincompatible-pointer-types]
   10208 |         ctx.regs = perf_arch_bpf_user_pt_regs(regs);
         |                  ^


vim +10208 kernel/events/core.c

030a976efae83f Peter Zijlstra 2022-11-19  10195  
4c03fe11b96bda Kyle Huey      2024-04-11  10196  #ifdef CONFIG_BPF_SYSCALL
f11f10bfa1ca23 Kyle Huey      2024-04-11  10197  static int bpf_overflow_handler(struct perf_event *event,
4c03fe11b96bda Kyle Huey      2024-04-11  10198  				struct perf_sample_data *data,
4c03fe11b96bda Kyle Huey      2024-04-11  10199  				struct pt_regs *regs)
4c03fe11b96bda Kyle Huey      2024-04-11  10200  {
4c03fe11b96bda Kyle Huey      2024-04-11  10201  	struct bpf_perf_event_data_kern ctx = {
4c03fe11b96bda Kyle Huey      2024-04-11  10202  		.data = data,
4c03fe11b96bda Kyle Huey      2024-04-11  10203  		.event = event,
4c03fe11b96bda Kyle Huey      2024-04-11  10204  	};
4c03fe11b96bda Kyle Huey      2024-04-11  10205  	struct bpf_prog *prog;
4c03fe11b96bda Kyle Huey      2024-04-11  10206  	int ret = 0;
4c03fe11b96bda Kyle Huey      2024-04-11  10207  
4c03fe11b96bda Kyle Huey      2024-04-11 @10208  	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
4c03fe11b96bda Kyle Huey      2024-04-11  10209  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
4c03fe11b96bda Kyle Huey      2024-04-11  10210  		goto out;
4c03fe11b96bda Kyle Huey      2024-04-11  10211  	rcu_read_lock();
4c03fe11b96bda Kyle Huey      2024-04-11  10212  	prog = READ_ONCE(event->prog);
4c03fe11b96bda Kyle Huey      2024-04-11  10213  	if (prog) {
4c03fe11b96bda Kyle Huey      2024-04-11  10214  		perf_prepare_sample(data, event, regs);
4c03fe11b96bda Kyle Huey      2024-04-11  10215  		ret = bpf_prog_run(prog, &ctx);
4c03fe11b96bda Kyle Huey      2024-04-11  10216  	}
4c03fe11b96bda Kyle Huey      2024-04-11  10217  	rcu_read_unlock();
4c03fe11b96bda Kyle Huey      2024-04-11  10218  out:
4c03fe11b96bda Kyle Huey      2024-04-11  10219  	__this_cpu_dec(bpf_prog_active);
4c03fe11b96bda Kyle Huey      2024-04-11  10220  
f11f10bfa1ca23 Kyle Huey      2024-04-11  10221  	return ret;
4c03fe11b96bda Kyle Huey      2024-04-11  10222  }
4c03fe11b96bda Kyle Huey      2024-04-11  10223  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


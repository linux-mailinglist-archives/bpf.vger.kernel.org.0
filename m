Return-Path: <bpf+bounces-38599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF9966AB8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CF5284B0B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95C1BF814;
	Fri, 30 Aug 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLAbsINd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAB1BF7E8;
	Fri, 30 Aug 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050202; cv=none; b=U5HjOqyEBtoN3XjN1VhPdaxar3Uhrs4n4usodYZ79nOx7RlL7lvhGPB8Pqq2c83bFphlHF3KwkDQ9r+/Lj9mYjfF6JqL605GX1pIfLfOVg5Znca3v2Et/uGTph2wvocRMMTSitMjoHc/zkg/hB8PPew/AeOYZxGCbLilh8P3u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050202; c=relaxed/simple;
	bh=ETSRAW7vFqmCFUdTSFn8eCzAOkaRVh4EbjrJKG2YVJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7HpC71g7ym0P98tUaBqj5eBQaoiu6DfG6Tt5xxJqLpZT68yXU//EgYKIYSXx443avyfwdmIQzxk9ULZghrWS2bItUhpoylTHoeFsDo290FQdvngpRtbTgpRV3c6fxehl0FAal2P/1IuotzKjS64pG4h14fr7XxIEIBF1Vn2DnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLAbsINd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725050201; x=1756586201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETSRAW7vFqmCFUdTSFn8eCzAOkaRVh4EbjrJKG2YVJE=;
  b=mLAbsINdE5g4fU+bjVmsD43vXjhrKiroW1KjbT8trUflokFOAoSictU/
   +or6oC+epQ1doyJagak2stqsNO1vM5dhtJUkAOcNmfh9dfTfD57o4ZXFy
   WmvX1DQ18vIC05WGkOvoOmXpWZ7fvvyjZLvqCDLHykJUsGqvgDGKiO1/0
   CTvJQfcEp2UAEjQQpJCobyM7cyZr4bpKzP1GighCkgc0lxA66a7oFqfHs
   YLdjEs+/VXjJzwbRqYN3Nq+Us537XsBC6nPrwe8RmxSRBBCQdhXN+YrYn
   yz7lZ8YJ4TNbqRzszkOO/ZFGxKcNOpvNltjLVH3qVlboJPuwHYI2bjo9n
   Q==;
X-CSE-ConnectionGUID: bR76hx1QT4SgQoX4t/WNKQ==
X-CSE-MsgGUID: nf6s4LVzTT68bCV4WH5HPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23842781"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23842781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 13:36:40 -0700
X-CSE-ConnectionGUID: URl1aozoRTW2utyAKTDM7Q==
X-CSE-MsgGUID: Zw3/5HLeSCGvQt6RVWSIvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64754724"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Aug 2024 13:36:37 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk8ME-00025I-2u;
	Fri, 30 Aug 2024 20:36:34 +0000
Date: Sat, 31 Aug 2024 04:36:13 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, oleg@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v4 8/8] uprobes: switch to RCU Tasks Trace flavor for
 better performance
Message-ID: <202408310111.2dkrylJ9-lkp@intel.com>
References: <20240829183741.3331213-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829183741.3331213-9-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on next-20240830]
[cannot apply to perf-tools-next/perf-tools-next perf-tools/perf-tools linus/master acme/perf/core v6.11-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/uprobes-revamp-uprobe-refcounting-and-lifetime-management/20240830-024135
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20240829183741.3331213-9-andrii%40kernel.org
patch subject: [PATCH v4 8/8] uprobes: switch to RCU Tasks Trace flavor for better performance
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240831/202408310111.2dkrylJ9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310111.2dkrylJ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310111.2dkrylJ9-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/events/uprobes.c: In function 'uprobe_unregister_sync':
>> kernel/events/uprobes.c:1157:9: error: implicit declaration of function 'synchronize_rcu_tasks_trace'; did you mean 'synchronize_rcu_tasks'? [-Werror=implicit-function-declaration]
    1157 |         synchronize_rcu_tasks_trace();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         synchronize_rcu_tasks
   cc1: some warnings being treated as errors


vim +1157 kernel/events/uprobes.c

  1145	
  1146	void uprobe_unregister_sync(void)
  1147	{
  1148		/*
  1149		 * Now that handler_chain() and handle_uretprobe_chain() iterate over
  1150		 * uprobe->consumers list under RCU protection without holding
  1151		 * uprobe->register_rwsem, we need to wait for RCU grace period to
  1152		 * make sure that we can't call into just unregistered
  1153		 * uprobe_consumer's callbacks anymore. If we don't do that, fast and
  1154		 * unlucky enough caller can free consumer's memory and cause
  1155		 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
  1156		 */
> 1157		synchronize_rcu_tasks_trace();
  1158	}
  1159	EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
  1160	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


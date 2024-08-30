Return-Path: <bpf+bounces-38583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A930C966837
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B01F2403F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471941BB6B5;
	Fri, 30 Aug 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pvb4Bpnq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC691C6A5;
	Fri, 30 Aug 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039749; cv=none; b=HBQBqJBISFKo9CYVM9Nl1MRWFK3OHm9VkpdPAe6kGvZsNJe+6lwNFMV5tjBcYSd7MZv8vlwQO98XI2br6/ocYw6kd9MlLQs+e6GsdbJF0D/tFmTKhIc3DIk0ZbadcN1DYrH5jjRGLAOTLvyO7tqibTBI2gvz5hMUIyCXZV/Z2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039749; c=relaxed/simple;
	bh=3MNP2MVv4HH9Xr02GOYFXzqt2aY5RaJ54paa0p/6Q1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nox78iV+aammd1nvZ4MsZjVv6nKkmoSLfifkEcNGza3oExwaxO60t5RojAQoqAC2IS/a2ESY+0H4xy9QKwUhy1NGRj+RSJRN5capuUOGLKRbrvN55RwzLbVqcjToclftfJTNi1wjfZugdAFNHlrJIzeR0mxeS8GogqaeH2TuQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pvb4Bpnq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725039748; x=1756575748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3MNP2MVv4HH9Xr02GOYFXzqt2aY5RaJ54paa0p/6Q1Y=;
  b=Pvb4BpnqSsVRrkhSYubL21dNSOhUY+fekyMfkcd63mgh+GhJvSrcp442
   iDvfd9fzNhK0xXN3gO+0fL9dog+OZFqdnoWlgJKhLu+aGyn+iLLcfJ9cI
   qZSM4jYXjGs8nsmyCE/zb9gFUMGDNymMOidSV5jaITgg4sAQ9upIzZa2R
   5qHOKbKZgXXvRsUkVsIoYsBAP4Oh+lphdBqEPIrvdLi1gOzso1PftWvLp
   +bH6b04p1DofJLPREtQafpcDhNxd3Gyn4JzNa0yFunGkJRv764ly12sgj
   oveGCirlDuoW3T8hNroR1vMEq9yoeRXtd80KSPs/NSLxpPqUp9fOoKQo2
   w==;
X-CSE-ConnectionGUID: O2QWvHxJTx+I8sJ7HlGjDg==
X-CSE-MsgGUID: TNeu7S6pRieSnvubk+eUwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26588824"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="26588824"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 10:42:27 -0700
X-CSE-ConnectionGUID: Qrn7kCy4TTmPY7lfTIiV5Q==
X-CSE-MsgGUID: hveFh9znS2aLYY//6xr4tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64713167"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Aug 2024 10:42:23 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk5dc-0001la-2H;
	Fri, 30 Aug 2024 17:42:20 +0000
Date: Sat, 31 Aug 2024 01:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, oleg@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v4 8/8] uprobes: switch to RCU Tasks Trace flavor for
 better performance
Message-ID: <202408310130.t9EBKteQ-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310130.t9EBKteQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310130.t9EBKteQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310130.t9EBKteQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/events/uprobes.c:1157:2: error: call to undeclared function 'synchronize_rcu_tasks_trace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1157 |         synchronize_rcu_tasks_trace();
         |         ^
   kernel/events/uprobes.c:1157:2: note: did you mean 'synchronize_rcu_tasks_rude'?
   include/linux/rcupdate.h:206:6: note: 'synchronize_rcu_tasks_rude' declared here
     206 | void synchronize_rcu_tasks_rude(void);
         |      ^
   1 error generated.


vim +/synchronize_rcu_tasks_trace +1157 kernel/events/uprobes.c

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


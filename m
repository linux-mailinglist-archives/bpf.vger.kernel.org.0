Return-Path: <bpf+bounces-33127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB9917876
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD71C21C6D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39BD14D6EB;
	Wed, 26 Jun 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu6CtSy0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C914B957;
	Wed, 26 Jun 2024 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381781; cv=none; b=GFbnVYepI9+P+5TmPxx34IXjpxxxy2N2KMAibF34jlwdbqmnclcgMQd6409JbnTlJKyjaga43XkSsyJg2f5USItmec5IzrjBU87TeV9zOJoWz1LYqnhWpQWoP6qeVmFALFHxpLEQLsYVsuAFgaYqkSysVs8me/eSqUkHIZB7/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381781; c=relaxed/simple;
	bh=+IrAu2tGyYGt+Jo1t4WYi42rdgy5RAFSZck2uvVRV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTJ+DlgMuKDXiaO800fUpWDVN5XT7ZH1d9D8Bh9uqyh6BlZKg+s1kdERZx4awNAU5hgfg733YYeUEtaMneh6xTg0cXxTXpzy5kAiLHnECBgj18iV5jAU8n+t5i2BMi2lic0xrzikVA3wBJ6HjPfq0UmLUf+mOk009mCe12xFCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu6CtSy0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719381779; x=1750917779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IrAu2tGyYGt+Jo1t4WYi42rdgy5RAFSZck2uvVRV1Q=;
  b=Gu6CtSy0g1+TMKtlOMwtM/hxXDxIwVnnveReULJ5XOKU6soWoWeDJ5xf
   fBKNDCy/sddY1n2nbeirELFroD0DiUbon5G8jU6nCQ43NEosP8tyn9YO/
   QG0ZuObZcRsqrVZ5RHKIoR94E30dg6+BT+m503Kp4IZxyDKuth71uNqq7
   rA/GVA0uTrsaIYX/L/2jZ+r7uxSUTujCvKNKd+5GhvGzaiAeYWOMiIOwG
   xat4jhodjY2zLjLk+Ejn0u07Y9q8WtbFmw3Iw3teC2B4Uw6aFRwjQe+RS
   iyc/HeKdPdJ9LhyPqGFl4bTxjyG6O4Lq+ivT4EWTxmULsmnvRTdhZB7/l
   w==;
X-CSE-ConnectionGUID: hdOhmY7ZQkmEnz9voYkrLA==
X-CSE-MsgGUID: 54yfSJvSR1Wg3T4pZyFUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16580358"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16580358"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 23:02:53 -0700
X-CSE-ConnectionGUID: gtjuWBIQSYmikv9XyhIf2w==
X-CSE-MsgGUID: KDf4yq2NTSamT5KSmRK+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48868500"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2024 23:02:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMLjz-000F2N-1g;
	Wed, 26 Jun 2024 06:02:47 +0000
Date: Wed, 26 Jun 2024 14:02:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <202406261300.ebbfM0XJ-lkp@intel.com>
References: <20240625002144.3485799-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625002144.3485799-5-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240624]
[also build test WARNING on v6.10-rc5]
[cannot apply to perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.10-rc5 v6.10-rc4 v6.10-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/uprobes-update-outdated-comment/20240626-001728
base:   next-20240624
patch link:    https://lore.kernel.org/r/20240625002144.3485799-5-andrii%40kernel.org
patch subject: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime management
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240626/202406261300.ebbfM0XJ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261300.ebbfM0XJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261300.ebbfM0XJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/events/uprobes.c:638: warning: Function parameter or struct member 'uprobe' not described in '__get_uprobe'
>> kernel/events/uprobes.c:638: warning: expecting prototype for Caller has to make sure that(). Prototype was for __get_uprobe() instead


vim +638 kernel/events/uprobes.c

b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  625  
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  626  /**
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  627   * Caller has to make sure that:
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  628   *   a) either uprobe's refcnt is positive before this call;
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  629   *   b) or uprobes_treelock is held (doesn't matter if for read or write),
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  630   *      preventing uprobe's destructor from removing it from uprobes_tree.
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  631   *
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  632   * In the latter case, uprobe's destructor will "resurrect" uprobe instance if
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  633   * it detects that its refcount went back to being positive again inbetween it
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  634   * dropping to zero at some point and (potentially delayed) destructor
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  635   * callback actually running.
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  636   */
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  637  static struct uprobe *__get_uprobe(struct uprobe *uprobe)
f231722a2b27ee Oleg Nesterov   2015-07-21 @638  {
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  639  	s64 v;
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  640  
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  641  	v = atomic64_add_return(UPROBE_REFCNT_GET, &uprobe->ref);
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  642  
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  643  	/*
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  644  	 * If the highest bit is set, we need to clear it. If cmpxchg() fails,
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  645  	 * we don't retry because there is another CPU that just managed to
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  646  	 * update refcnt and will attempt the same "fix up". Eventually one of
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  647  	 * them will succeed to clear highset bit.
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  648  	 */
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  649  	if (unlikely(v < 0))
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  650  		(void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
b9adadbcb8dfc8 Andrii Nakryiko 2024-06-24  651  
f231722a2b27ee Oleg Nesterov   2015-07-21  652  	return uprobe;
f231722a2b27ee Oleg Nesterov   2015-07-21  653  }
f231722a2b27ee Oleg Nesterov   2015-07-21  654  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


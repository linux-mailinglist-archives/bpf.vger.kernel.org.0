Return-Path: <bpf+bounces-45906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0EF9DF266
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 18:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31C7B20A77
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846901A76B4;
	Sat, 30 Nov 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9YJN6nE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CA43AA1
	for <bpf@vger.kernel.org>; Sat, 30 Nov 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989272; cv=none; b=bK/wI4BQxzSXcDryjCBPUSKKy+vr/42PzyFYRu9WCxVESr/VhAg848kXG7zTW4n1c2K4tPrtVB5I1h0Ccr6bKHdzppoXoa9Tk9WrSvlNqUE1DgxFQvR1boGOtXkzwKoislhh/bjFzK0pvZXd/vGdfzdYRxNEpnGgoXiQCWfixMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989272; c=relaxed/simple;
	bh=rbXYpOJKDPeAlSh9kRAlmXC6swlI1qy+eiAxmzaRgj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el/1akoWVpCGwQ8n7K0IS0jJ7iHNklo5xV3+SqAI5gV/ySZ6Z4mlBpnbQmUw7Q1Dv04bCy3w2PcKGnXHpMQXz7G6IDM/lAe7hGxWY9b6VhKR7kQ1M+UgTj6UI8lmwODhhjc1sDUfaWH/Cf5yMZVsujEmwI9tOynrdy8FxjVG7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9YJN6nE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732989271; x=1764525271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbXYpOJKDPeAlSh9kRAlmXC6swlI1qy+eiAxmzaRgj0=;
  b=Y9YJN6nE74t1i0sS5+e0tMWfaE3LmFp9cO4gKExDL0fDjNKlUXtQQnZs
   lscj+7gPaU1WpjNLgco4KL/dGyGHUKsDsXQSCCRa6u4iBe2YNiS9bz8Fj
   Eqt0BhCdYG24DpU6K6CsqQJ2m9pj4Er12FLT1JRnhwWlhiIgxKcsG1mhy
   U9fG8dJrvcZbKxfNzDK2tSg0BwJmShoRq35EnkcHaSkKr/pPnspo3Ty3c
   6M7zCFnzJJay4AeuNjJ3gJJnuNPv9o+Pt61TNkEhCzS5udWjNRH71XzR/
   FKuskR6M1DrHEFgLxEkLOh+Q9iZ++RGhC79TE3SeRsZdO035xpLiPKDO4
   w==;
X-CSE-ConnectionGUID: U/GtimScREudOD/NadmEUQ==
X-CSE-MsgGUID: YtZRpXsfTYyja3jDgLVc0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33118785"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="33118785"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 09:54:30 -0800
X-CSE-ConnectionGUID: K+xZ/KcSSESxdxTmID9zQA==
X-CSE-MsgGUID: tCBA+8bqSLiCd8Es4kVyRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="93547383"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 30 Nov 2024 09:54:28 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHRfl-0000sZ-1U;
	Sat, 30 Nov 2024 17:54:25 +0000
Date: Sun, 1 Dec 2024 01:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc: oe-kbuild-all@lists.linux.dev, ryantimwilson@meta.com
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
Message-ID: <202412010119.qyfY5hLk-lkp@intel.com>
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114170721.3939099-1-ryantimwilson@gmail.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Wilson/bpf-Add-multi-prog-support-for-XDP-BPF-programs/20241115-015104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241114170721.3939099-1-ryantimwilson%40gmail.com
patch subject: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
config: x86_64-randconfig-122-20241117 (https://download.01.org/0day-ci/archive/20241201/202412010119.qyfY5hLk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412010119.qyfY5hLk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412010119.qyfY5hLk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3387:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3387:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3387:23: sparse:     got unsigned int
   net/core/dev.c:3387:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:9416:76: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_mprog_entry *entry @@     got struct bpf_mprog_entry [noderef] __rcu * @@
   net/core/dev.c:9416:76: sparse:     expected struct bpf_mprog_entry *entry
   net/core/dev.c:9416:76: sparse:     got struct bpf_mprog_entry [noderef] __rcu *
   net/core/dev.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   net/core/dev.c:3837:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:4800:9: sparse: sparse: context imbalance in 'kick_defer_list_purge' - different lock contexts for basic block
   net/core/dev.c:4901:19: sparse: sparse: context imbalance in 'enqueue_to_backlog' - different lock contexts for basic block
   net/core/dev.c:5315:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
   net/core/dev.c:5996:9: sparse: sparse: context imbalance in 'flush_backlog' - different lock contexts for basic block
   net/core/dev.c:6123:9: sparse: sparse: context imbalance in 'process_backlog' - different lock contexts for basic block

vim +9416 net/core/dev.c

  9409	
  9410	u8 dev_xdp_prog_count(struct net_device *dev)
  9411	{
  9412		u8 count = 0;
  9413		int i;
  9414	
  9415		for (i = 0; i < __MAX_XDP_MODE; i++)
> 9416			if (dev->xdp_state[i] && xdp_entry_is_active(dev->xdp_state[i]))
  9417				count++;
  9418		return count;
  9419	}
  9420	EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
  9421	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


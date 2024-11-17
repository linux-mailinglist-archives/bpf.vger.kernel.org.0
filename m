Return-Path: <bpf+bounces-45049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C199D041F
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 14:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1B8B2192F
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D428C1CBE98;
	Sun, 17 Nov 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvuCIQXU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9E1CBE8E
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731851082; cv=none; b=rzadd6TEYUeFJKv4fd5piYYth8G1eDxxQqlBsJjVicik2hXlRLz25+VFkz9SivHhvshPKDwCf4PTMBl+ZvfAyNeCtYC4nmgNK4xdyJq70/GkUINLAFoCkNBjFA+0f86p0MeQ+LJ8BFIOYIljVfDw7BG+8jbzCwEQd7yGiXxfTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731851082; c=relaxed/simple;
	bh=bzudhJQ6DLerwXyo13kvSCjAxnVApP3ZVF8C/ZXDAYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEsvpz5xMXCuJnQ+a/roG+/SR/G3ljB6chM+ix5p0iMUMj7L8Gkd76dOFD1D/b01gOVaKXQLAQZxti2OrRqxZplmjBOxORLeRqQIeDkgKK5Vrrkk5WICeqBmGu+NcnLLK5ri21BwIFhJZbe436V/PghsepxPc4cx9tx8v0/pb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvuCIQXU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731851080; x=1763387080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzudhJQ6DLerwXyo13kvSCjAxnVApP3ZVF8C/ZXDAYM=;
  b=FvuCIQXUw6AlSPyThJ73V2xXANjbhI8+yUyQHVZqT97LHzGl9lE6oolm
   LBhkW78xfOI8zWioSzfeJLlXB/w/Sk3VT3dwm5PDCw+lUdln6EBR/t92e
   WDKJOPX0ENDA6pP15Xi2WEvB9W3h4S1hrBrk6Sz5Hm5zXz4OhXMBFgwHd
   I6Ir2PxXJMsK7wqq34RraHXU7hLTxsnKwwsd7Sit48jvMg8SbcKgSxK+7
   ilaPXB/E/EJZkfW6nF3wSXQ6SsuQhOtOePGGunW61idRXaM+0oclWi/h9
   LixzwcMJnW7YbO8HlZ913mgFnetxnVmUTfT4q+EqDy4OXNg7Bnk591DAS
   Q==;
X-CSE-ConnectionGUID: vfeh+aHXTguZEyY1cuXngQ==
X-CSE-MsgGUID: EjlrGS0lTV2SpliKXuFPNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42333469"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="42333469"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 05:44:39 -0800
X-CSE-ConnectionGUID: daUKfGchSWW2k7D27BkxTw==
X-CSE-MsgGUID: yL/A4YVMTm6KYnbJx1UIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="112283922"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2024 05:44:37 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCfZr-0001mD-0m;
	Sun, 17 Nov 2024 13:44:35 +0000
Date: Sun, 17 Nov 2024 21:44:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc: oe-kbuild-all@lists.linux.dev, ryantimwilson@meta.com
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
Message-ID: <202411172107.yHI94Ps2-lkp@intel.com>
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
config: x86_64-randconfig-122-20241117 (https://download.01.org/0day-ci/archive/20241117/202411172107.yHI94Ps2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411172107.yHI94Ps2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411172107.yHI94Ps2-lkp@intel.com/

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


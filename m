Return-Path: <bpf+bounces-62556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC1AFBC7C
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACFC4A645A
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C721D00D;
	Mon,  7 Jul 2025 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFSMiyjW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820A214A6A;
	Mon,  7 Jul 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919931; cv=none; b=FTEkW8OeDHJ46dwaIOox74akeLV2NHqKHgqf+kmK7jo8pq3AqdZxl9pBatz1XCkvXxUVo8gCGohgXpdER44acgyrR5TEttzQMQ04viG7KTesoHbN49+zeEmPUTCAwRsEb7ZSqTsia60ZfmaI+nmEhJCqeCJb6JbpW496MnK1qTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919931; c=relaxed/simple;
	bh=EskchuAk3wqYLaXr8x1fF4HhW/cyWSRnnGTXvtWRQDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltgskE3pEP7QA+wLOga8313ATJ8caoNi5/Q6m68Hk+vx3RTeDENsyMzXx01jWY8yEitokoUziXXec1DCHHqCLg2eFcNl1yjjfP76DSpuFFKcUIpd9W/LPvWCBUIMO8Glf6hv5FbqYBa0l0c/8jwM61EnYQb/j6Wgijv0j716QO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFSMiyjW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919930; x=1783455930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EskchuAk3wqYLaXr8x1fF4HhW/cyWSRnnGTXvtWRQDk=;
  b=PFSMiyjWxSENYTsXW7yK27IvUOBPlM/K6TjAR8PKDCExpKrEOS3hXnkb
   V/tLnq5bnOgyCom0y7aHCy4HHqvbenw+hLd51xvtOceje5nE7wExHUCsp
   c2q86ydUzVZ/EOr+NGbMKOmkjL8v6wqemctSSKyNlnkC9QqBQNucSYvfJ
   HOWBtPX8N6IG0XYnbdTMI68YUZsDm5ZmBpoPjz/Y5b5+bGfagEDNaIYNg
   OD5oCqNz9TPpCrEHsQsIUdKE7d00rZXNw1i6f9E1AadMfys3gPrXGkBuc
   qGTFxMkJVusmyekwRI2SgAzEJaUG3GjPKyS7mbSKZd6/BdoYpq4HN6efk
   A==;
X-CSE-ConnectionGUID: JgTTlzHETPKM9/VM2GWBLQ==
X-CSE-MsgGUID: mSWLWoqaTraxcIIarE6xGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53362603"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53362603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:25:29 -0700
X-CSE-ConnectionGUID: AVK4PUxOTGWdv6LR1Tocbw==
X-CSE-MsgGUID: wULjMUCrS7qxIoDnvtRdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159344412"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:25:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYsOw-0000iv-2p;
	Mon, 07 Jul 2025 20:25:22 +0000
Date: Tue, 8 Jul 2025 04:25:09 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next] bpf: make the attach target more accurate
Message-ID: <202507080452.fCL471ap-lkp@intel.com>
References: <20250707113528.378303-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707113528.378303-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-make-the-attach-target-more-accurate/20250707-194159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250707113528.378303-1-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next] bpf: make the attach target more accurate
config: i386-buildonly-randconfig-003-20250708 (https://download.01.org/0day-ci/archive/20250708/202507080452.fCL471ap-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250708/202507080452.fCL471ap-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507080452.fCL471ap-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/verifier.c:23491:43: error: incomplete definition of type 'const struct module'
    23491 |                 err = module_kallsyms_on_each_symbol(mod->name, symbol_mod_callback,
          |                                                      ~~~^
   include/linux/printk.h:400:8: note: forward declaration of 'struct module'
     400 | struct module;
         |        ^
   1 error generated.


vim +23491 kernel/bpf/verifier.c

 23466	
 23467	/**
 23468	 * bpf_lookup_attach_addr: Lookup address for a symbol
 23469	 *
 23470	 * @mod: kernel module to lookup the symbol, NULL means to lookup the kernel
 23471	 * symbols
 23472	 * @sym: the symbol to resolve
 23473	 * @addr: pointer to store the result
 23474	 *
 23475	 * Lookup the address of the symbol @sym, and the address should has
 23476	 * corresponding ftrace location. If multiple symbols with the name @sym
 23477	 * exist, the one that has ftrace location will be returned. If more than
 23478	 * 1 has ftrace location, -EADDRNOTAVAIL will be returned.
 23479	 *
 23480	 * Returns: 0 on success, -errno otherwise.
 23481	 */
 23482	static int bpf_lookup_attach_addr(const struct module *mod, const char *sym,
 23483					  unsigned long *addr)
 23484	{
 23485		struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
 23486		int err;
 23487	
 23488		if (!mod)
 23489			err = kallsyms_on_each_match_symbol(symbol_callback, sym, &ctx);
 23490		else
 23491			err = module_kallsyms_on_each_symbol(mod->name, symbol_mod_callback,
 23492							     &ctx);
 23493	
 23494		if (!ctx.addr)
 23495			return -ENOENT;
 23496	
 23497		if (err)
 23498			return err;
 23499	
 23500		*addr = ctx.addr;
 23501	
 23502		return 0;
 23503	}
 23504	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


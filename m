Return-Path: <bpf+bounces-59171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C8AAC698A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EBF1BC8157
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFC286404;
	Wed, 28 May 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJSHP0KY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8272857FA;
	Wed, 28 May 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435887; cv=none; b=UYYqQsvjLsAp+gHsievBNTzOtHxTvdUwPzBkoBuMOv7AoekLJCyQXTVGK+6FM/j2giYxgnhpQZnqK6iIzbQlxAJaiHdhFl3BHvo0Ox5vuxSt8uSH4aFr6E6t8+7qTTU7hNtTFiKvyK7raKxVdzz8omTiJr0FHcGS/42GPcUqCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435887; c=relaxed/simple;
	bh=Q6eFNenEbUSMPvsXNE7r/lVO7A6gafRRqlJCsQalJhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucgleSmKTzT+sFDPiLjKNrqji97MxTjffQgv5AbHtEfYH6PKPO4NPfEm5JtmSw0HJFkzjplDG0vkLESaXvhtX5GJUdgazDC8CmMEVYXRG36LIK9i7cLVxgRQ9r4AlARn6F03dNkWK40zOcf9Y7UpuShGiXWPZFPNMRorfDmhHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJSHP0KY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748435885; x=1779971885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q6eFNenEbUSMPvsXNE7r/lVO7A6gafRRqlJCsQalJhI=;
  b=FJSHP0KYYC9bV61WLG8uDOhvlRY3rj27A/d5HUvIqyJGrqnZNX63fsDL
   wuQR6OLQHh5F0HVh0gnKEeGOPa/yP4ptAfr6bD/CitXiFEnmygdBf1hap
   rp4S4Cw8yKgwWOSFMbNgPMTh8D/agPJ2c/2IYbIIHb/lS6ZSJDbztwsZb
   OG6l85YO2njFOQ1aUDWkUQ4xgiBScZlHncKSvW38dgTQ7ZyDYtLLA7aiU
   hHtuEyceNZBm6jdL96l/5EmiTjlHyjkwZgvMMuLgtNQXAjWiHHiYnb9wu
   pxII4T7rECPKLo+eXXmJwm1Syen7lfpNMe1T9qEyYgTUFbOMe6sL2ZsnA
   Q==;
X-CSE-ConnectionGUID: qpvmPytQScyxFWFGYeeIBw==
X-CSE-MsgGUID: CzmMgmKEQkeaZfYA4URbFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61515072"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61515072"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 05:38:05 -0700
X-CSE-ConnectionGUID: dWG2Y8gcR9qAt78LRWW/gg==
X-CSE-MsgGUID: EblxoR5XTA+d0Mjfjr1QFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="147988445"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2025 05:38:03 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKG2i-000Vem-2d;
	Wed, 28 May 2025 12:38:00 +0000
Date: Wed, 28 May 2025 20:37:58 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 15/25] ftrace: factor out
 __unregister_ftrace_direct
Message-ID: <202505282037.xt8RiXkG-lkp@intel.com>
References: <20250528034712.138701-16-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528034712.138701-16-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-per-function-metadata-storage-support/20250528-115819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250528034712.138701-16-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next 15/25] ftrace: factor out __unregister_ftrace_direct
config: sparc-randconfig-001-20250528 (https://download.01.org/0day-ci/archive/20250528/202505282037.xt8RiXkG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505282037.xt8RiXkG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505282037.xt8RiXkG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace.c:116:12: warning: '__unregister_ftrace_direct' declared 'static' but never defined [-Wunused-function]
     116 | static int __unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> kernel/trace/ftrace.c:6053: warning: expecting prototype for unregister_ftrace_direct(). Prototype was for __unregister_ftrace_direct() instead


vim +116 kernel/trace/ftrace.c

   114	
   115	static void ftrace_update_trampoline(struct ftrace_ops *ops);
 > 116	static int __unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
   117					      bool free_filters);
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


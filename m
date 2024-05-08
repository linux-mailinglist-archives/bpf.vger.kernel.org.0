Return-Path: <bpf+bounces-29109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F68C03E9
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE244B258BC
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278112BF20;
	Wed,  8 May 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCQvLHFd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749220309;
	Wed,  8 May 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191011; cv=none; b=s4t5WgtalFnO1+C9YGGQ4b+6BF3uWclt3YdgHWHAIFXjcV73zYEP7PsKedQSrYbUKDAPvaGeMzPA4lOr/Kkdc6UhXEKciHKg2DiMBRqTMCkzqKyj17T4bHDIrOk7Noe/6JJ2MSfe90eiYmnznHnyRpNUeslmDAoLKS340SOEc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191011; c=relaxed/simple;
	bh=8GWvJFhjz+4IneZTgTdmlJNfYB6EqWQuwqKdICsfABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRp7lrfTfPTXHPK2EqxQx1k02d52d7O2ZAK3sbJcDPmGlk771uuYfEJiTxMCrkpMpiZbHZsr6ropSuw3C7kaPQoNAZZA9usvQTkVSwwvDNiixPiB2ljkbOQqRoQUEyDRbZzY6YhPSIdL/Hah3I0ltU/HI8y50s5mwnQ5CvMw46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCQvLHFd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715191011; x=1746727011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8GWvJFhjz+4IneZTgTdmlJNfYB6EqWQuwqKdICsfABI=;
  b=OCQvLHFdf8KJYg1Bbl3/bh2T8bDu7CCYnw2axSlSYem3xbU8+F4lv0R9
   KShUb66NB9eYFTI1jKAWdpyB910dmDff1sMoCC+MSIMOvnjcjt8QmHoQs
   HE4EhsvaZthmkXt17dq6+qWTbmR97n/lr7wSbL8FsKGHlCn30O+yx97sJ
   jPuEyQmtKeQkebyoCFIr3tLKCRZCOsChxkiXOSqr/CYYrtDaoeYtJf1N3
   7NIousA3nbLUj4dNphL184G7YeeRnoyK1j9zfZwkrWKCG66pboPO/cbtF
   0ZoXzXq170eMZKoTTY4EgZWo4Yt8JSRuahQpoR3Si+Qg8yxb8C6BAZiM4
   g==;
X-CSE-ConnectionGUID: TdDvloZsSOecmPwVCltgyQ==
X-CSE-MsgGUID: 9K51f540ShSGdMWZvmMf+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14866370"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14866370"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:56:50 -0700
X-CSE-ConnectionGUID: zxobd8YET5uEesz/RMcfsg==
X-CSE-MsgGUID: mnsBKCwgQry3x8FmPaCH5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33661787"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:56:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4lWz-00000005Wxk-3Bor;
	Wed, 08 May 2024 20:56:41 +0300
Date: Wed, 8 May 2024 20:56:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
Message-ID: <Zju82TRJ8EwJh8is@smile.fi.intel.com>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
 <202405090110.rS1cBZES-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405090110.rS1cBZES-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 09, 2024 at 01:28:19AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-intel-Use-y-instead-of-objs-in-Makefile/20240508-212446
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240508132315.1121086-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in Makefile
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240509/202405090110.rS1cBZES-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405090110.rS1cBZES-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405090110.rS1cBZES-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):

> >> ERROR: modpost: "igc_led_free" [drivers/net/ethernet/intel/igc/igc.ko] undefined!
> >> ERROR: modpost: "igc_led_setup" [drivers/net/ethernet/intel/igc/igc.ko] undefined!

Sure, misplaced line. I'll fix this in the next version.

-- 
With Best Regards,
Andy Shevchenko




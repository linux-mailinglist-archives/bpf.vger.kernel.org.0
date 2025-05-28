Return-Path: <bpf+bounces-59169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F46AC6873
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 13:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50D53B6EB7
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBBE2836AF;
	Wed, 28 May 2025 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULHOQ+80"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EC1E8854;
	Wed, 28 May 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432097; cv=none; b=px0Cz0aLE+dYZhgdHKPtWIzRHdfUzEt+i1KU3OhhXOn6sUBPtIKkLAx6T903YdSdIhrHAsdKqMlxbn4ACdIcM5/RESjuxYHa2SNwZuIiJ1qAVp+JAxzEZG5z62SysVicjrC4AMKvjP0OWV8XQEnKWkKLyh57r1xHygRNseeJxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432097; c=relaxed/simple;
	bh=HSxCbgRLZhJCIcQQOJEc5MtOOGLMy3xGR4PMKG3DHvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIc8kAKys4DXy9AXqqHkBcgq0zw3shGPknULi3XCsEBX8BcrO/grfb24D9XTjo39y7HB2OJ9gy+Sheaolsygu3UNM2pDLnGR7fwJWcUcF6BmscddR3pgSSUXgNW7MpQcVZeOr2t/TIlFUZMtdX8ejsO19bfOqU+1u5jRrq0yp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULHOQ+80; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748432096; x=1779968096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSxCbgRLZhJCIcQQOJEc5MtOOGLMy3xGR4PMKG3DHvg=;
  b=ULHOQ+80tetHTnpZPtjnLc0M30Ar3/v/USsIGMgo3zdgJ75ofW9x+y8w
   VZLhEWHCOE8UN440lRtGQy3xtjjz1qXd2ZFjnt91hLd7Z7IuXrqAOzfaH
   uezoU1u8rqpGqTv+WGjRvvFbAsn7ck4yeTV40xfa9VeytSLFXvq/AMhlv
   ljvcah/vKyTLKFKzHDPr7l1nTfh1eukMKz9nxlbut7URh36odIc5HVLuq
   lCRRiskDrR+/aPHL4hL5l4HdHGtiVunMeMWc+MEupxlaRoQMiGVNOqVNC
   n4jwzGqfSL0lMBh9ALccQ/MSN4iWFk5xxbjHs7LZwAn1dmt+xaiQkzXyg
   A==;
X-CSE-ConnectionGUID: ckVO1Q45RGC0fjt+8iHR6A==
X-CSE-MsgGUID: 49Yjd5RfRt25dWQzZIqinw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50152786"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50152786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:34:56 -0700
X-CSE-ConnectionGUID: gOecNs2RRlqmVkcs8m6llw==
X-CSE-MsgGUID: BHUyzIPHSy6OcTM3fSV+GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="174209022"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 May 2025 04:34:53 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKF3a-000VcS-22;
	Wed, 28 May 2025 11:34:50 +0000
Date: Wed, 28 May 2025 19:34:35 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, jolsa@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 14/25] bpf: tracing: add multi-link support
Message-ID: <202505281947.qIShGsJU-lkp@intel.com>
References: <20250528034712.138701-15-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528034712.138701-15-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-per-function-metadata-storage-support/20250528-115819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250528034712.138701-15-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next 14/25] bpf: tracing: add multi-link support
config: arm-randconfig-002-20250528 (https://download.01.org/0day-ci/archive/20250528/202505281947.qIShGsJU-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505281947.qIShGsJU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505281947.qIShGsJU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/syscall.c:3727:2: error: call to undeclared function 'bpf_gtrampoline_unlink_prog'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3727 |         bpf_gtrampoline_unlink_prog(&multi_link->link);
         |         ^
   kernel/bpf/syscall.c:3727:2: note: did you mean 'bpf_trampoline_unlink_prog'?
   include/linux/bpf.h:1492:19: note: 'bpf_trampoline_unlink_prog' declared here
    1492 | static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
         |                   ^
>> kernel/bpf/syscall.c:3995:8: error: call to undeclared function 'bpf_gtrampoline_link_prog'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3995 |         err = bpf_gtrampoline_link_prog(&link->link);
         |               ^
   kernel/bpf/syscall.c:3995:8: note: did you mean 'bpf_trampoline_link_prog'?
   include/linux/bpf.h:1486:19: note: 'bpf_trampoline_link_prog' declared here
    1486 | static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
         |                   ^
   kernel/bpf/syscall.c:4001:3: error: call to undeclared function 'bpf_gtrampoline_unlink_prog'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4001 |                 bpf_gtrampoline_unlink_prog(&link->link);
         |                 ^
   3 errors generated.


vim +/bpf_gtrampoline_unlink_prog +3727 kernel/bpf/syscall.c

  3721	
  3722	static void bpf_tracing_multi_link_release(struct bpf_link *link)
  3723	{
  3724		struct bpf_tracing_multi_link *multi_link =
  3725			container_of(link, struct bpf_tracing_multi_link, link.link);
  3726	
> 3727		bpf_gtrampoline_unlink_prog(&multi_link->link);
  3728		__bpf_tracing_multi_link_release(multi_link);
  3729	}
  3730	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


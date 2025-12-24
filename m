Return-Path: <bpf+bounces-77418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714ACDCB59
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF1433025E36
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05D255F28;
	Wed, 24 Dec 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgAjqJ5J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B52D8DBB
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766590290; cv=none; b=rjVczZVrfbuHvDSqqFZTG8V6WZUZmJtqshOjOqRHENpkwn7yoraw0GSfC8m75cCqVMu5LU/HXa0OafcJ01TfSMq3AykZbva+14ak5E4XM2r6PYucnnIGhnm2cVFNOy+Hjt6x3tThZd3ac8IKm5/4sTB5Ik1o2Xmtl50rAKuy0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766590290; c=relaxed/simple;
	bh=SRV7CV4Dr5bIqdS1TeXk5Bjumt8BIkEwldzGJDp6FJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDSIalTqEutHG5LKGESNI1zKOPNXmmhHfuYdP7QReJfJjyZYRwPlhxMEWykKu+CmKTWFI+3wgNVijIALAAzay9wi0kyWH/gLYWBTUC+J+yiF9ZurTHMdxBpImRKRl8nMdQWuIyNlpwQr6ENQ/Xh5+oQGUDv4yuQ3pX9wY2asUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgAjqJ5J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766590285; x=1798126285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SRV7CV4Dr5bIqdS1TeXk5Bjumt8BIkEwldzGJDp6FJU=;
  b=OgAjqJ5JsV91dnPxTlPVeglmQb8H5yi7Oj2hGFOabxzERVLaoxr6Tvvp
   uMlYynvUb9zAPO++J1Zq13tbT8tyz2eMfOqYWB0SaK5QMhO5xFDZQGfLA
   vvNimkCKxsp386cj0WMcwUH84HNb215sXF42iKZpUAmEUZ3QN8wtzgow/
   hoDLWrGVG4jbz4WnSZb7UP32cdfkS4s0pgPSBAPzIbvw8WUtuGY71Wh5S
   3vHteZdQMH3H1cpT4CNjpN7R+WFOjLmLIAB+BDDY11PsVYuwA9dK47QUq
   VVwp/AHZZEu2TVpFxIGcJqlCtDsrWX1W5MhcCElYYyXmh4ycHJjZaT2vC
   A==;
X-CSE-ConnectionGUID: 6gcxJe1SSeiyFrrAQIkscQ==
X-CSE-MsgGUID: TyYFx1RiRq2xDpvRbvJwgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68320999"
X-IronPort-AV: E=Sophos;i="6.21,174,1763452800"; 
   d="scan'208";a="68320999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 07:31:20 -0800
X-CSE-ConnectionGUID: NKMeCWRgTZChJYcusXWGbg==
X-CSE-MsgGUID: lFMya9Z5RRW5ZK8z7vYhHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,174,1763452800"; 
   d="scan'208";a="199688756"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 24 Dec 2025 07:31:16 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYQpW-000000003C5-0zx2;
	Wed, 24 Dec 2025 15:31:14 +0000
Date: Wed, 24 Dec 2025 23:30:37 +0800
From: kernel test robot <lkp@intel.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com, ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for
 signed and unsigned BPF_DIV
Message-ID: <202512242332.vFPARGR1-lkp@intel.com>
References: <20251223091120.2413435-2-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223091120.2413435-2-tangyazhou@zju.edu.cn>

Hi Yazhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/bpf-Add-interval-and-tnum-analysis-for-signed-and-unsigned-BPF_DIV/20251223-171652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251223091120.2413435-2-tangyazhou%40zju.edu.cn
patch subject: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
config: i386-buildonly-randconfig-002-20251224 (https://download.01.org/0day-ci/archive/20251224/202512242332.vFPARGR1-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512242332.vFPARGR1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512242332.vFPARGR1-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/verifier.o: in function `__bpf_sdiv':
   verifier.c:(.text+0x10b8): undefined reference to `__divdi3'
   ld: kernel/bpf/verifier.o: in function `adjust_scalar_min_max_vals':
   verifier.c:(.text+0x1195b): undefined reference to `__udivdi3'
>> ld: verifier.c:(.text+0x11974): undefined reference to `__udivdi3'
   ld: kernel/bpf/tnum.o: in function `tnum_udiv':
   tnum.c:(.text+0x63f): undefined reference to `__udivdi3'
>> ld: tnum.c:(.text+0x66c): undefined reference to `__udivdi3'
   ld: kernel/bpf/tnum.o: in function `tnum_sdiv':
   tnum.c:(.text+0xccd): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


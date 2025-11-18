Return-Path: <bpf+bounces-74937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D5C68C5A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72181382867
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913433C50B;
	Tue, 18 Nov 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br/migN1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360E337B86;
	Tue, 18 Nov 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460737; cv=none; b=tgU+QsZjG9CUTlCLS+DtghUfm7gtzkbCv6yCBpSvc/qwbY/d+doHcYOSOwUWxFWilbSuPxpa2gAfIsxR04RJIAQoneI//eh2YuoAaX9khQp4DeS9yy08oNQ9epMvcT8JXLcnRaSut70PDI0a9SAFcmFtmmJWUjVe2mssDvhaGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460737; c=relaxed/simple;
	bh=nl7pmGt8CjVlZAWWmPXGrOGwVFNg8prR1eUshaeTMmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEpc5rdgMBVdL3Dn8SkFIFCg3qV/khhtVq8F6+Zy9zLeob/C2xXBz+Em5ncV42dwag2Whj85R22V//NTCVneTTEH56GjcCJlbzckOQpDXCIl4eaETCInKJI07m18cuF2ELTndUSTv8vwMhuJvVrITt95OCbPHi7Gz/HWYlUIhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br/migN1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763460735; x=1794996735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nl7pmGt8CjVlZAWWmPXGrOGwVFNg8prR1eUshaeTMmo=;
  b=Br/migN1+AwyfqfcfSiYp2ljSktBS16oeNFM9DF1/+tD6SYZxdoM/ll6
   61okvpsjjoZ0qLmPbFO9LNzEiuB/bRogEgBwYwDtkAC3/EGL3Bvk9lgb2
   rAoQVhVU5U/OQSM/QRBXmjphpAOCvBhjX1pCpnvnJrpgJ0LkXdUz9nKcH
   ZjEjxVHFkGuTKFkRiwdQE0WMVYYU6lAmkJrPSGelJKxSXrrez+5alVoAs
   fZgSvbexOs55DFu6gA324UedzBS1WHD7lj823W+6TucVORDvkaxmfJCqW
   hJQD+FHcV2sh3+c7EhvgkgH+zhXPsweWhKkDgq7vZdZ0pju6tYNhnKbCw
   w==;
X-CSE-ConnectionGUID: 6HBwi8EYSKOb+vqUXINZCA==
X-CSE-MsgGUID: HoovTqNJS/eULFeuYD6+xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65358560"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65358560"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:12:14 -0800
X-CSE-ConnectionGUID: xPGIwTZrQQqn+TtBb2ocTw==
X-CSE-MsgGUID: aDzpKKoYR7uBPxdb2THN0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191157958"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Nov 2025 02:12:12 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLIgz-0001bI-2b;
	Tue, 18 Nov 2025 10:12:09 +0000
Date: Tue, 18 Nov 2025 18:12:00 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
	ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
Message-ID: <202511181716.vzqU1M8A-lkp@intel.com>
References: <20251117191515.2934026-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117191515.2934026-1-ameryhung@gmail.com>

Hi Amery,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Amery-Hung/bpf-Annotate-rqspinlock-lock-acquiring-functions-with-__must_check/20251118-031838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251117191515.2934026-1-ameryhung%40gmail.com
patch subject: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring functions with __must_check
config: i386-randconfig-002-20251118 (https://download.01.org/0day-ci/archive/20251118/202511181716.vzqU1M8A-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511181716.vzqU1M8A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511181716.vzqU1M8A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/locktorture.c:372:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     372 |         raw_res_spin_lock(&rqspinlock);
         |         ^~~~~~~~~~~~~~~~~ ~~~~~~~~~~~
   kernel/locking/locktorture.c:396:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     396 |         raw_res_spin_lock_irqsave(&rqspinlock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rqspinlock.h:255:48: note: expanded from macro 'raw_res_spin_lock_irqsave'
     255 | #define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~
   2 warnings generated.


vim +/warn_unused_result +372 kernel/locking/locktorture.c

a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15  369  
a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15  370  static int torture_raw_res_spin_write_lock(int tid __maybe_unused)
a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15  371  {
a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15 @372  	raw_res_spin_lock(&rqspinlock);
a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15  373  	return 0;
a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15  374  }
a6884f6f1dd565 Kumar Kartikeya Dwivedi 2025-03-15  375  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


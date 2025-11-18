Return-Path: <bpf+bounces-74936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A5C68BE7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD444EAA4D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB43396F8;
	Tue, 18 Nov 2025 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7PtrbVs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5A337690;
	Tue, 18 Nov 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460736; cv=none; b=cS4LaH8ZKJgiwF4VVT4mYqNRrz33AxEpc/DacnmLSGilAMkHmVpdMrkyatJPxYFqL43frNcpQIs5+CzE2mE2Xh290icv9LE7Bmw2pmFKFbwv406dCGghSu5M3POJN58sZmg5J9wxFc0ljNnzAVrWekzHmiC6D6QDepFAgriVPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460736; c=relaxed/simple;
	bh=gk0h5FpCXE+PG+HTwVWGDvvFZruVVCeqEVAMOfYDads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+4M8W5coYJS3nod6Wyd0V8pTI3r/4TtlvvUqq6KYGetqoXNOCTcBMkON0HTPNh5neuAVy4BcioHSmckG4cSQLLSwb7PxfZAOUakkSaz4K2OSziPxx59y/LcwWkHnJKTzdnnniNYKytIf4AEtsPB3JPqm9XFRX5WmXHlVesHZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7PtrbVs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763460734; x=1794996734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gk0h5FpCXE+PG+HTwVWGDvvFZruVVCeqEVAMOfYDads=;
  b=d7PtrbVs7dvDW/ombpruBbVb2j30Gm/YvP2S1sQTshedETTRNV+CjMaH
   dU+xXgA6jdMiMaEiHI45cAKs4O83L6SpunJpf0Cc3Z6MPMoM3PdJl6Zjc
   nAol98vDKFMBfe8u+n3rJh8FoUdNChspa/bd79jgWbJxZ5AZUDq/114Ht
   uI9ysBEnYPPE4f1khu2gWjxNr7/OiNwSdIpLIhRd3s0Oc4FS/AbQehp72
   4UCFnezptf2BlhNMf6WeXSatbNeavplA05aXePh+DTaApvULUQrWzGWd2
   x5q6sAbmSotnxL6XbCGUu0UhAVEni+UdHzZ/9wZzkr8s+bxL6jDjoaru6
   Q==;
X-CSE-ConnectionGUID: zCWN1WVnQhivcWWaAtGtpQ==
X-CSE-MsgGUID: /iXH6yVTQyS0jClL+0rtWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65358554"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65358554"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:12:14 -0800
X-CSE-ConnectionGUID: C96R7XknTHWwLz8vIsNeig==
X-CSE-MsgGUID: v4jF1IhnTPW+WmL8geMZvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191157959"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Nov 2025 02:12:12 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLIgz-0001bF-2W;
	Tue, 18 Nov 2025 10:12:09 +0000
Date: Tue, 18 Nov 2025 18:11:58 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, ameryhung@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
Message-ID: <202511181704.SFwhGJOb-lkp@intel.com>
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
config: arm-randconfig-002-20251118 (https://download.01.org/0day-ci/archive/20251118/202511181704.SFwhGJOb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511181704.SFwhGJOb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511181704.SFwhGJOb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ./arch/arm/include/generated/asm/rqspinlock.h:1,
                    from kernel/locking/locktorture.c:367:
   kernel/locking/locktorture.c: In function 'torture_raw_res_spin_write_lock_irq':
>> include/asm-generic/rqspinlock.h:255:48: warning: ignoring return value of '__raw_res_spin_lock_irqsave' declared with attribute 'warn_unused_result' [-Wunused-result]
     255 | #define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/locktorture.c:396:2: note: in expansion of macro 'raw_res_spin_lock_irqsave'
     396 |  raw_res_spin_lock_irqsave(&rqspinlock, flags);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/locktorture.c: In function 'torture_raw_res_spin_write_lock':
>> kernel/locking/locktorture.c:372:2: warning: ignoring return value of 'raw_res_spin_lock' declared with attribute 'warn_unused_result' [-Wunused-result]
     372 |  raw_res_spin_lock(&rqspinlock);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/arm/include/generated/asm/rqspinlock.h:1,
                    from locktorture.c:367:
   locktorture.c: In function 'torture_raw_res_spin_write_lock_irq':
>> include/asm-generic/rqspinlock.h:255:48: warning: ignoring return value of '__raw_res_spin_lock_irqsave' declared with attribute 'warn_unused_result' [-Wunused-result]
     255 | #define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   locktorture.c:396:2: note: in expansion of macro 'raw_res_spin_lock_irqsave'
     396 |  raw_res_spin_lock_irqsave(&rqspinlock, flags);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   locktorture.c: In function 'torture_raw_res_spin_write_lock':
   locktorture.c:372:2: warning: ignoring return value of 'raw_res_spin_lock' declared with attribute 'warn_unused_result' [-Wunused-result]
     372 |  raw_res_spin_lock(&rqspinlock);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +255 include/asm-generic/rqspinlock.h

   254	
 > 255	#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
   256	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


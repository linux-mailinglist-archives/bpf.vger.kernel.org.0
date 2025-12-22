Return-Path: <bpf+bounces-77328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D7CD76A9
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 00:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AD93053297
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930D327208;
	Mon, 22 Dec 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UnHbT6NE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F742FF158
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444480; cv=none; b=OaWqM9Kb+jggQNXDR91rjpxv98po1bH+fLxv5EdJCOLWgyQauZoJuylaew8xzic9LxFRwptXPZGL84SaTCmjZGlNZXhHzIb8eshJelzO2ZCewYU9gEfpxxCyT1o5Qpyf6liblCWP9MJApJle+Wil5lm9XS6KhubVgbInRM/adAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444480; c=relaxed/simple;
	bh=05p4Tp+gu+fhVyibBbHaUOoQ6I9T8B2eAtPNoEd+5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n376pH0GrRSUFuXPYZeata/ItXySUVFkivy/tuLvRNIjq05Hbf0It7JDoOWhFDDsZIdXeXWv4ajOWAAnSMIgMRln7SHeOqPlQ8NEitxZ4NyBWJjamP1h+SckAxf/mpIhrQCGHU+vVv6KB/kp2/vIVcppRF5cLqXz7hGY6ERSpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UnHbT6NE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766444478; x=1797980478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05p4Tp+gu+fhVyibBbHaUOoQ6I9T8B2eAtPNoEd+5Pk=;
  b=UnHbT6NEVyExqdkKjDfjno0zygH4sLXY+scR6elKYNBNWLcD/1Pht4Pa
   DC+ahs5oyRzYa+CPn/XtvmPkqqOY1oROSGEL9gddUM75iVJvTn+5iWnrr
   YeyogK5NZyrxhQRcd5sUuevecrqOGTO6T/na0UW2+OEv/17b35VYVTDfA
   zOEo/gD2td+X/AVbMIP0mqN8t0qOnbV/Bq7dgtMeId2lsAI7Ea1zfuG4z
   Hf33kzkh4sdHq4Ud3EPBZuhfMUGlP4Xn+yvQVsHlOx2MI3IQW9Ey9d1ei
   9HNPJCGzv/4piB1AUuijTm5+U9gG0Sn7ByK3+ykT4tEkHyNt9O+NYhmZT
   A==;
X-CSE-ConnectionGUID: IxF/nS1mTlqzAylMRzKIMQ==
X-CSE-MsgGUID: U1ANO/XaRmSsXjn9wwfwgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68456543"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68456543"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 15:01:18 -0800
X-CSE-ConnectionGUID: 2Tellb5MSmKvCv0DxiRQjA==
X-CSE-MsgGUID: 3yrSWpcFRDiP7q3owI+ECg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="237037195"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2025 15:01:14 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXotr-000000001CF-1sZU;
	Mon, 22 Dec 2025 23:01:11 +0000
Date: Tue, 23 Dec 2025 07:00:22 +0800
From: kernel test robot <lkp@intel.com>
To: Yazhou Tang <yazhoutang@foxmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com, ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next 1/2] bpf: Add interval and tnum analysis for
 signed and unsigned BPF_DIV
Message-ID: <202512230626.fsj1GsdX-lkp@intel.com>
References: <tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com>

Hi Yazhou,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/selftests-bpf-Add-tests-for-BPF_DIV-analysis/20251221-174300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_7C98FAECA40C98489ACF4515CE346F031509%40qq.com
patch subject: [PATCH bpf-next 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
config: i386-randconfig-061-20251222 (https://download.01.org/0day-ci/archive/20251223/202512230626.fsj1GsdX-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230626.fsj1GsdX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230626.fsj1GsdX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/tnum.c:16:19: sparse: sparse: symbol 'tnum_bottom' was not declared. Should it be static?
--
   kernel/bpf/verifier.c:23659:38: sparse: sparse: subtraction of functions? Share your drugs
>> kernel/bpf/verifier.c:15184:42: sparse: sparse: unsigned value that used to be signed checked against zero?
   kernel/bpf/verifier.c:15181:24: sparse: signed value source
   kernel/bpf/verifier.c:15191:32: sparse: sparse: unsigned value that used to be signed checked against zero?
   kernel/bpf/verifier.c:15180:24: sparse: signed value source
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +/tnum_bottom +16 kernel/bpf/tnum.c

    11	
    12	#define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
    13	/* A completely unknown value */
    14	const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
    15	/* Tnum bottom */
  > 16	const struct tnum tnum_bottom = { .value = -1, .mask = -1 };
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


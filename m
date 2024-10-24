Return-Path: <bpf+bounces-43054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64C9AEB5B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94381C226C2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7041F6697;
	Thu, 24 Oct 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8PVm1Pr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777019DFB4
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785848; cv=none; b=Fc1ggUYNCcNJ4ry5IoLjt/621I7+GkzdTGHVe9XEgJqXjvt2CjoH7qXMNt73z5W+KXZ+7CnnaFqt6jMkf8Jvs5V6Uyhq8QndxXVQ/uRA2ZtlXFX9u1m9cahopwx0QetU7MfMrDU5ASvdS2KZGauaWfA8nhIFzszq3d4CZ4yuhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785848; c=relaxed/simple;
	bh=DshxdLui4UCMqNIfKtfQInF+osEboBLrgMhfmBDtSfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv2ilSdaOB/Zjfi+Io71vn8H87RkR2iVLdW1jtulWwUyV16mnF4pnuaveflEN32D8h031laxWDlkR4QOdA197DdjEvmOLuoZd++uK1jtMHmdm8KFiz1T2vNcHEsjn3wTJ0+0xe9szKYnUCDhsJKejNoS8SWd2AAnuYQmwOQI8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8PVm1Pr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729785846; x=1761321846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DshxdLui4UCMqNIfKtfQInF+osEboBLrgMhfmBDtSfo=;
  b=P8PVm1Pr6wUAQttemRnf7ODXHalwN5FPdxZ3Y28HFhhXS++P+UrHMD2n
   kXX5OqcTb8mg6Isqo9tx3hHc/MpcH2sCO70pNPhlhaUb4M4oe9iJujx2F
   bU1HYzwI65oS1JFRCuabNgQFLbuGTReEw6rN8+RtjJryCPIj0RsSNSmn9
   qSoag5HsDvH0HiD8lVS8LTdaho5u7hA4gD4P3xtcH3maFkF1gP/H0ehLv
   YShuyySCJ1q095MEK8pbasXgJKKXIwuuspwDnZFbu0++HGLLsJSFU0I4R
   A3WZPQZMqpQUMH8xBKI8c3ofTDCOJiWM3DFl9KjbGPg69f2nUFgLCWScM
   A==;
X-CSE-ConnectionGUID: wSIyxR6SQ3OLm1qUQ8XRMA==
X-CSE-MsgGUID: iNjmI5uiS7me99kRtAdviQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40538833"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40538833"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:04:05 -0700
X-CSE-ConnectionGUID: B0+VuX2iQoGxoHOiRqwLyw==
X-CSE-MsgGUID: aCmnxg6HRUihFP5sZIm/9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80285946"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 09:04:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t40Jc-000Wdb-34;
	Thu, 24 Oct 2024 16:04:00 +0000
Date: Fri, 25 Oct 2024 00:03:01 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
Message-ID: <202410242353.krjd8d6t-lkp@intel.com>
References: <20241023210437.2266063-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023210437.2266063-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-bpf-add-selftest-to-check-rdtsc-jit/20241024-050747
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241023210437.2266063-1-vadfed%40meta.com
patch subject: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20241024/202410242353.krjd8d6t-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410242353.krjd8d6t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242353.krjd8d6t-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/helpers.c:26:
>> arch/powerpc/include/asm/vdso/gettimeofday.h:97:63: warning: 'struct vdso_data' declared inside parameter list will not be visible outside of this definition or declaration
      97 |                                                  const struct vdso_data *vd)
         |                                                               ^~~~~~~~~


vim +97 arch/powerpc/include/asm/vdso/gettimeofday.h

ce7d8056e38b77 Christophe Leroy 2020-11-27   95  
ce7d8056e38b77 Christophe Leroy 2020-11-27   96  static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
ce7d8056e38b77 Christophe Leroy 2020-11-27  @97  						 const struct vdso_data *vd)
ce7d8056e38b77 Christophe Leroy 2020-11-27   98  {
ce7d8056e38b77 Christophe Leroy 2020-11-27   99  	return get_tb();
ce7d8056e38b77 Christophe Leroy 2020-11-27  100  }
ce7d8056e38b77 Christophe Leroy 2020-11-27  101  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


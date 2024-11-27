Return-Path: <bpf+bounces-45708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7019DA759
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 13:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783AC1611C0
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058881FA270;
	Wed, 27 Nov 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1FbfeNf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3C1FA256
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709078; cv=none; b=CZCH6jI0CEMvTIH2OZwHNt4akILGRxQm8h5bhndS77DjMS3DaQ67tsOYYDYHou/KeAesOgGrJzJagSHUumSKUdwxxtm8scM47t5Q6SyydspTtQ2oDutXwECeje6mKExtRrHzURg87nBbMrfcQaekYN6UzXoCCuuvHn57ClHAGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709078; c=relaxed/simple;
	bh=PYReNgI+KEQ/lGy4xLj6TwLZrDKWu4t3mY5Ce4VWoRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCJz3I6v7ZzohVvsODRzmc7rWBdLN9/P85aeDoJjjtRqAguNowHpks3W/ZLiR0JhFnRBdx/xkcwp9c1FxCSgtDViQesmFxkveP2sMYwc58E8Jj+ZtnnPeL2cSY8rHI8i10A/mONnaDakDscWEuCdVsPJ5lOfwbDsgb9UMVIsR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1FbfeNf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732709076; x=1764245076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PYReNgI+KEQ/lGy4xLj6TwLZrDKWu4t3mY5Ce4VWoRw=;
  b=Z1FbfeNfzJr+i/Jl7KDDvBnNRP5xxmTODa1VIFBeI9AHU5pGRqGsl855
   YBrowC/Du1Z/lg1HoaItwRCFQr4TUDaJYoOFw6TwhOZe0O2DEhGZqUdk4
   kSo0pG3sFcEzereDUtpvRTEuj1c+eWkjnO7HJ+6T58CsTSlAt9fUNCec2
   ZO0PijBf3Cl8odG7uA9d/TiOmWLDWz1lJ52v/lrCM1ch+Zd1YkJB2EB1p
   cwDipdFGnGo7TKaGEZJbrzHw0KH2YszlA6YSVDl8Z5EWkmTZ9lQToJIP7
   GeJbyq8SVmbWNQ7meMeCCyx77RBY7h7nkWbQUoyqcn4PLGeugZL2WU7Lt
   A==;
X-CSE-ConnectionGUID: E+krmR6URkONSNFQoT1TJw==
X-CSE-MsgGUID: uIgoo6cETkuPIxXrlPebjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36697935"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="36697935"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 04:04:35 -0800
X-CSE-ConnectionGUID: HwSHgPtQS0mKVwJbMc+tig==
X-CSE-MsgGUID: MclnzkCMRraG2+II+v2Ykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92390502"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Nov 2024 04:04:32 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGGmU-0007y7-13;
	Wed, 27 Nov 2024 12:04:30 +0000
Date: Wed, 27 Nov 2024 20:03:52 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, bpf@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v9 1/4] bpf: add bpf_get_cpu_time_counter kfunc
Message-ID: <202411271903.OUFqQ7FP-lkp@intel.com>
References: <20241123005833.810044-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123005833.810044-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-add-bpf_get_cpu_time_counter-kfunc/20241125-122255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241123005833.810044-2-vadfed%40meta.com
patch subject: [PATCH bpf-next v9 1/4] bpf: add bpf_get_cpu_time_counter kfunc
config: x86_64-randconfig-104-20241127 (https://download.01.org/0day-ci/archive/20241127/202411271903.OUFqQ7FP-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241127/202411271903.OUFqQ7FP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411271903.OUFqQ7FP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_get_cpu_time_counter
   >>> referenced by bpf_jit_comp.c:0 (arch/x86/net/bpf_jit_comp.c:0)
   >>>               vmlinux.o:(do_jit)
   >>> referenced by bpf_jit_comp.c:3829 (arch/x86/net/bpf_jit_comp.c:3829)
   >>>               vmlinux.o:(bpf_jit_inlines_kfunc_call)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


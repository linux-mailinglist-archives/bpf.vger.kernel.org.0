Return-Path: <bpf+bounces-45744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322149DAD95
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7976C163D84
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25645201254;
	Wed, 27 Nov 2024 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2ClR7TM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4D200B95
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734503; cv=none; b=ZYVbebQLfzHHo5CnFuxKubuWkU98M8IQYScUhzArPTzA0tSjxNM1FIauiMaOqzXZ47hZoP8bZU9YfPdEgPc+7KA1vgwYNJ2wXcYJNL1HmZYANreVQpfiR0yHwu77yPv5jI8lto+ik1aEQm941FCK77SWxn5PZYo+70KsS2uuK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734503; c=relaxed/simple;
	bh=5LwZDPSlSkSsmNY/E2BsYUbQLFmDNktBZoMBMy5tXqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCyC29rnwH+YfKffAFtu03yc6ud2+KGL1kd6DniuqLZfdyAqi+x50ZrTQsegD/OY2HnF9T62DeKuL/gKJjV3pEYBFrLz40aAHOqd+58RdVERkH+JoPDNaZMXewU6i67ssyu5qNuJsVVS0hDMlXQgNCsZHkXmRsTcsGsFiF/PUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2ClR7TM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732734502; x=1764270502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5LwZDPSlSkSsmNY/E2BsYUbQLFmDNktBZoMBMy5tXqA=;
  b=n2ClR7TM19XdG2/kKJ5nvE0I56YXQ22W/WiX3A5P4nWSKcf/mggeZDWv
   qFgd83n9+TLrrzFnj026orlTKA80WJw9JASNpHuEadY4GVihyAKDpAoNI
   DfxamUbcvps3lUAELV6i+1O7KK4P3JJKbML6rXGH0jzKoIZiwtgPZPURU
   /08M9Xqu08LdGwfXj7rnbbx4rJnThbYGztiVXPNhAtX5T461gYskhELzo
   SIdHEE5wyt5Akbup+aWsKx4FqCZhOMHYluOw+Od5srUoWiBbXlin0M4+/
   4ZFLssupGXJ/XxLhNxnqzx3buQAhNPbRxG3z6aZp9DOUNzvhm+P+i/FBO
   A==;
X-CSE-ConnectionGUID: LmG5hG13T+mRb0Q4AOQ8Ag==
X-CSE-MsgGUID: Tz5Ev83oR6mY4vORpThbiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44014986"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="44014986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:08:22 -0800
X-CSE-ConnectionGUID: SxsoylPkTFiNCAfiadqRmg==
X-CSE-MsgGUID: BHjxgVYpQX6noeZoD0le9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="97104013"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Nov 2024 11:08:19 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGNOa-0008HH-0h;
	Wed, 27 Nov 2024 19:08:16 +0000
Date: Thu, 28 Nov 2024 03:07:49 +0800
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
Subject: Re: [PATCH bpf-next v9 2/4] bpf: add bpf_cpu_time_counter_to_ns
 helper
Message-ID: <202411280258.urOdkuWz-lkp@intel.com>
References: <20241123005833.810044-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123005833.810044-3-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-add-bpf_get_cpu_time_counter-kfunc/20241125-122255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241123005833.810044-3-vadfed%40meta.com
patch subject: [PATCH bpf-next v9 2/4] bpf: add bpf_cpu_time_counter_to_ns helper
config: x86_64-randconfig-104-20241127 (https://download.01.org/0day-ci/archive/20241128/202411280258.urOdkuWz-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411280258.urOdkuWz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411280258.urOdkuWz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_cpu_time_counter_to_ns
   >>> referenced by bpf_jit_comp.c:0 (arch/x86/net/bpf_jit_comp.c:0)
   >>>               vmlinux.o:(do_jit)
   >>> referenced by bpf_jit_comp.c:3855 (arch/x86/net/bpf_jit_comp.c:3855)
   >>>               vmlinux.o:(bpf_jit_inlines_kfunc_call)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


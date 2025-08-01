Return-Path: <bpf+bounces-64870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 146DAB17F53
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3271C81342
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13A2288EA;
	Fri,  1 Aug 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAUcvvZ9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B721FF3C;
	Fri,  1 Aug 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040713; cv=none; b=UJ9Lcgi+Qmeyq32mG8jnaNDVlSE2y+kANkit56rekSj8C9OgVsXY1g4DCP7bM+bF64uqPCT1nX5UqeQUAqjpOuHZJOb0f2AW4hPTqesMNJBaInm95iwM0rFf/+PYXkAyxTDNljTGWRR19mkjWJ26PDckMH864p2rw+yzpFEiGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040713; c=relaxed/simple;
	bh=1Iro+YdK5Txdv943h5gMTFUwluk76Rpp3LTw6wMf19A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPJ404iRtSdFlk9TgdBN2w3EciNqfYDCokf/TYeRHVyeW+g09Llf6jcQX3FT1Gs9C7+mcdiHjRojMVu/Y5oFtzK++J95mVBnWzJxYYfheNbYQPSDL2+1imgP0JX6q1q7/CBnnOhdcQFG3GafAj7ygTvL4Ht+bYFuYpj2q+sbH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAUcvvZ9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754040712; x=1785576712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Iro+YdK5Txdv943h5gMTFUwluk76Rpp3LTw6wMf19A=;
  b=FAUcvvZ9ekBYe0yPaNDZiZisPe8TbVP3Yk/91DMrUcW9kIyMpnh/S2Gg
   FTeBwDU6L2qlTf4wF/r6iOpAUctfcwT49ZN/3XfiMH140VnLVtA6g3cn1
   is9yjtOMDAxuoOtzLgQ5ZbU/vsYM+gz9sNiqrnhVMHDucuGqYXVEeYoy6
   AluQzCWIJ+6jTENFha/Cwu91EJecViSlBFQTBamcSLw//MQ5bU+zXSioQ
   qRsB1iVgwGPTKLDtWZl3jhpKQ2fBt8HL9OMUgXgqJn+IcVnYxLQvzUEma
   56oj1kSYbOU9yX6pSKCulXJHkaw6XFrtLFQUXZ3zfxsRTYTq9xWy7wGRH
   A==;
X-CSE-ConnectionGUID: iH++tBPRSde/WLP9Rma2kA==
X-CSE-MsgGUID: sxZg4T1HSnyHOhyGG0c88w==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56528427"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56528427"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 02:31:51 -0700
X-CSE-ConnectionGUID: pL6i1BpQRoiy7QRK1+yaHA==
X-CSE-MsgGUID: oail3CG7TkmfKAShLEI/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167732428"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Aug 2025 02:31:47 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhm76-0004Um-2x;
	Fri, 01 Aug 2025 09:31:44 +0000
Date: Fri, 1 Aug 2025 17:31:18 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org,
	memxor@gmail.com, martin.lau@kernel.org, ameryhung@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Allow getting bpf_map from
 struct_ops kdata
Message-ID: <202508011701.e7Owy62s-lkp@intel.com>
References: <20250731210950.3927649-2-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731210950.3927649-2-ameryhung@gmail.com>

Hi Amery,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Amery-Hung/bpf-Allow-getting-bpf_map-from-struct_ops-kdata/20250801-051108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250731210950.3927649-2-ameryhung%40gmail.com
patch subject: [PATCH bpf-next v1 1/3] bpf: Allow getting bpf_map from struct_ops kdata
config: arm-randconfig-001-20250801 (https://download.01.org/0day-ci/archive/20250801/202508011701.e7Owy62s-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508011701.e7Owy62s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508011701.e7Owy62s-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/bpf_struct_ops.c:1157:18: warning: unused variable 'map' [-Wunused-variable]
    1157 |         struct bpf_map *map;
         |                         ^~~
   1 warning generated.


vim +/map +1157 kernel/bpf/bpf_struct_ops.c

85d33df357b634 Martin KaFai Lau 2020-01-08  1149  
85d33df357b634 Martin KaFai Lau 2020-01-08  1150  /* "const void *" because some subsystem is
85d33df357b634 Martin KaFai Lau 2020-01-08  1151   * passing a const (e.g. const struct tcp_congestion_ops *)
85d33df357b634 Martin KaFai Lau 2020-01-08  1152   */
eab8366be0bf63 Amery Hung       2025-07-31  1153  struct bpf_map *bpf_struct_ops_get(const void *kdata)
85d33df357b634 Martin KaFai Lau 2020-01-08  1154  {
85d33df357b634 Martin KaFai Lau 2020-01-08  1155  	struct bpf_struct_ops_value *kvalue;
b671c2067a04c0 Kui-Feng Lee     2023-03-22  1156  	struct bpf_struct_ops_map *st_map;
b671c2067a04c0 Kui-Feng Lee     2023-03-22 @1157  	struct bpf_map *map;
85d33df357b634 Martin KaFai Lau 2020-01-08  1158  
85d33df357b634 Martin KaFai Lau 2020-01-08  1159  	kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
b671c2067a04c0 Kui-Feng Lee     2023-03-22  1160  	st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
85d33df357b634 Martin KaFai Lau 2020-01-08  1161  
eab8366be0bf63 Amery Hung       2025-07-31  1162  	return __bpf_map_inc_not_zero(&st_map->map, false);
eb18b49ea758ec Martin KaFai Lau 2021-08-24  1163  }
eab8366be0bf63 Amery Hung       2025-07-31  1164  EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
eb18b49ea758ec Martin KaFai Lau 2021-08-24  1165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


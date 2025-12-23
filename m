Return-Path: <bpf+bounces-77383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA9CDA70F
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 21:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B5D300387E
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BD343D60;
	Tue, 23 Dec 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwLRmPj6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC343346B2
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766520861; cv=none; b=SbEHcVoGcETAOi4y1a/qsjRfXzVSewID7WOQXVk3uSlt51aBj6z4bqRuM2aYRTAGrZVHZh0pq56R1lei1a5vbQH3NyCPCwec8UGRnv9zOIM2KIeBLuh+y5w+C3+p1SL+srs8ggAmuJ/p97ofTHSTAhmyMc8MHKsu8xgGlQ7I4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766520861; c=relaxed/simple;
	bh=Po9BbirDa3YTHSKsAt9tghCK1Co6ygNGQCN7uWbffqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUBCPwdLCVg9NhoDcxpOa6XdvoT6XezgGBF64yAnKD54zrerHss914jTkcbASvjrOjLtdOSE7HdFjkC1+8mPkoc1w8rykmgRU8J4QpUesVP5FeyMm4HQs8bYe2U8mXbbH5YJoEBJq6RgSgLE5LyUFbdMK9CehUH2h4twEJGT4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwLRmPj6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766520860; x=1798056860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Po9BbirDa3YTHSKsAt9tghCK1Co6ygNGQCN7uWbffqc=;
  b=DwLRmPj6QHzij0b/rdo0XN9N9oPY4JG7qOuDwFLVdAoVSmoC+uOBqb0i
   MtiwRaABEodNlKQX00P1ZL5Vxdzk6qL3OLakMMMAeHBPY3W+8AjmEn8zM
   iK+p0TRaYg9X3OXHKDI3X/go+z08Qimc0Ev58TN0xZ8IaB4dGi5zn620I
   R657jCseKMLp4FCpyBqu/eTzLkQF0uWv8ACWKeJVn/WSs9V8KNL8K78os
   oDuZC2JzNjY6VRA6roWW7GFeW/9zMq5k9d4tdf3vivnqN+YIXz28J03Xm
   4mUJAqL+3E1Z3ry1sNw115grRJcKvqlg/B/vj0vaOXA3/7BxGqfo6PcT0
   g==;
X-CSE-ConnectionGUID: cvHybH2QSLSbm85NgjI7Hw==
X-CSE-MsgGUID: vanDsug7RCKKEiOoMpT2Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68413717"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="68413717"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 12:14:20 -0800
X-CSE-ConnectionGUID: QnJWK2WtT4uPJI+Be+Edfg==
X-CSE-MsgGUID: f2FXaJM6TJqSc9UYVenP+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="204361881"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Dec 2025 12:14:16 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY8lp-000000002Kl-3Rvp;
	Tue, 23 Dec 2025 20:14:13 +0000
Date: Wed, 24 Dec 2025 04:14:09 +0800
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
Message-ID: <202512240306.FBKF27IL-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/selftests-bpf-Add-tests-for-BPF_DIV-analysis/20251221-174300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_7C98FAECA40C98489ACF4515CE346F031509%40qq.com
patch subject: [PATCH bpf-next 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
config: i386-randconfig-051-20251222 (https://download.01.org/0day-ci/archive/20251224/202512240306.FBKF27IL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240306.FBKF27IL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240306.FBKF27IL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __divdi3
   >>> referenced by tnum.c:300 (kernel/bpf/tnum.c:300)
   >>>               kernel/bpf/tnum.o:(tnum_sdiv) in archive vmlinux.a
   >>> referenced by verifier.c:15227 (kernel/bpf/verifier.c:15227)
   >>>               kernel/bpf/verifier.o:(scalar_min_max_sdiv) in archive vmlinux.a
   >>> referenced by verifier.c:15227 (kernel/bpf/verifier.c:15227)
   >>>               kernel/bpf/verifier.o:(scalar_min_max_sdiv) in archive vmlinux.a
   >>> referenced 6 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-37432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA795597E
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 22:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456501C20BA7
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290BA13D516;
	Sat, 17 Aug 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THnxm15z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43761646
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723925396; cv=none; b=NfMZ27tIhZ6/AIcgX79lHXX/ytxhrWA1oO4o+8iDCQx3SK/y0J9B9+CRLypx6ZfSyYu0bMJZ96OaOA1mWCdBb8bg09nkC/fMfDEkX2AawMoa5xgUjnCaseZed7juwz3hbZ77zfnYXrHHmxcLo/0135xJhJX2BMmKUAQqutpyxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723925396; c=relaxed/simple;
	bh=WFtEUODj8PbZ2oTIKu1U+wu/zed8iqotcDMj8CdV4hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTa+DqlXFEZ6ZngRVc8Tt/mtwxzPI5ClxMFor5eDXbE4/PPgEnwiK6HQ24H4BJ8TLOGREPmT0nTflgseU5E7Lh4ApkoAFK/zN/dbNlteqDc34JGEqbiyyD6ngiDTCIy/E5eVihN4qxMOpjHGowPKQxa7sEUM+EYLwni7JLP6HrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THnxm15z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723925394; x=1755461394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFtEUODj8PbZ2oTIKu1U+wu/zed8iqotcDMj8CdV4hA=;
  b=THnxm15zil5F6pH+ylWZBIJgcYDhH2qN9QUCuUC8pSkqtsw+iOcPoMdR
   FIjLi5pxzPElpBTrIyMfKMk1CaQyjtNRbUbxK1DmkCCZsW2sROd+B/+yg
   aoQfacar/9kaUTj8H1rCtBrdUSUwO1dnH7Q/XLXrlom5RNPaWSJffSTzS
   Ar7trZBD0q3fLinHSDXLurNRScEQNuziOfHEbobVBHSrEPR8VQAdWs1+a
   xR6+VlcuUbqZci5dXNJAsFI/aCxZshZrPvR9DXEX7clE0W8otr3ewb2HH
   uJmfLFjh/jlCAVs3dWNbBqrbGGj/iZ0SUi+XlPLrgs8ZVLP/RGP+uQQtr
   Q==;
X-CSE-ConnectionGUID: FoN8iEvOS5eZZZmJUKFETQ==
X-CSE-MsgGUID: S1NK2aPWQl2fg/G/cCPefw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="33347073"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="33347073"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 13:09:53 -0700
X-CSE-ConnectionGUID: vHHqQNq3So6yP70lgkDZQQ==
X-CSE-MsgGUID: 1UunQegZQVqpY0OHEyAkaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="64377673"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Aug 2024 13:09:51 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfPkD-0007mw-0p;
	Sat, 17 Aug 2024 20:09:49 +0000
Date: Sun, 18 Aug 2024 04:09:26 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev,
	jose.marchesi@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: support bpf_fastcall patterns for
 kfuncs
Message-ID: <202408180356.YZnBVEv3-lkp@intel.com>
References: <20240817015140.1039351-4-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817015140.1039351-4-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-rename-nocsr-bpf_fastcall-in-verifier/20240817-095340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240817015140.1039351-4-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v2 3/5] bpf: support bpf_fastcall patterns for kfuncs
config: arc-randconfig-002-20240817 (https://download.01.org/0day-ci/archive/20240818/202408180356.YZnBVEv3-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240818/202408180356.YZnBVEv3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408180356.YZnBVEv3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'kfunc_fastcall_clobber_mask':
>> kernel/bpf/verifier.c:16146:33: warning: variable 'params' set but not used [-Wunused-but-set-variable]
   16146 |         const struct btf_param *params;
         |                                 ^~~~~~


vim +/params +16146 kernel/bpf/verifier.c

 16142	
 16143	/* Same as helper_fastcall_clobber_mask() but for kfuncs, see comment above */
 16144	static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
 16145	{
 16146		const struct btf_param *params;
 16147		u32 vlen, i, mask;
 16148	
 16149		params = btf_params(meta->func_proto);
 16150		vlen = btf_type_vlen(meta->func_proto);
 16151		mask = 0;
 16152		if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
 16153			mask |= BIT(BPF_REG_0);
 16154		for (i = 0; i < vlen; ++i)
 16155			mask |= BIT(BPF_REG_1 + i);
 16156		return mask;
 16157	}
 16158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


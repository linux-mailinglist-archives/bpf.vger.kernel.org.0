Return-Path: <bpf+bounces-72999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68002C1FE83
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4D81A641BB
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9831A055;
	Thu, 30 Oct 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UB963+tm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF4311C2F;
	Thu, 30 Oct 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825616; cv=none; b=XkJaaFVzcOjJ8GvtkTySTtDRawDmPH2fNcDnsnSn5ytxRxsJafEc/SUI9ph3q8I1NYj7rxukW/2YGhU+GaQy23cjXb77WZtSBk+grdwZnU8FBaTyUdonNCpPsIajTV9SPzKwelOt6a9xSTu854sEyASvVoIuCQJAG5CSBHpRFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825616; c=relaxed/simple;
	bh=FgV4wFL7RIyVMuHd2krRmw1+dcEWv50XBDao6pnaQgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZhOpMUnPPtYjYBXpMTZUdqn01z6VwmuJysrNSs0A/puk9RJoBIQr7N9/hbNd37Mjlh/RVVflzDZkLVW2CiOrSoE9ZhlLNRoJCak+JfqPz6GfKOWYtqCLO4O/qXGfco5sPllNSyAQNTGCBuDDUW+odghKXB3QwQDoxuEyj1Hnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UB963+tm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761825614; x=1793361614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FgV4wFL7RIyVMuHd2krRmw1+dcEWv50XBDao6pnaQgA=;
  b=UB963+tmdYWevP3vHltGmEiLKqtW2N5s4qnAib7fMDl9mNZ0PhYg670r
   YJwasq3En4Kz6Jnv2bqHhMoBnrt3PTFtNEa6raqeQvFpOWZ6mac3E4llg
   jtAQb+4FcCXvfYAvUdyZRdaNuIEVvWK0FFSycBfqSGNpRnOch3k7p43Tp
   YUHT0uPpzc+0Hml6kETZqYNh3ly8wRK4V+pjAhqnUuAz0EHfhL0iGikhY
   8I9yUoonVwe/fPCG+21mgWNOLgw0HQhNWzlSWHwgI3pMrjJdT8xbYZbs7
   roqbvknHlHJlY6Vwt37l77sb+yj4riTAF68VSOd9+hPbfQBI9tyFkFpHK
   Q==;
X-CSE-ConnectionGUID: QYdH7DXcSuGwLT/zo1lhAg==
X-CSE-MsgGUID: Wj2JmXUzTieCca50THsIlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86590831"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="86590831"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:00:11 -0700
X-CSE-ConnectionGUID: uEUM9zFyTg2e4P71HynKWQ==
X-CSE-MsgGUID: g1iRUpYJRGGzPycGYo1zyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185817927"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 Oct 2025 05:00:08 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vERJ1-000Lwm-0I;
	Thu, 30 Oct 2025 11:59:26 +0000
Date: Thu, 30 Oct 2025 19:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	andrii@kernel.org, ast@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
	eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
Message-ID: <202510301923.XmrKra1o-lkp@intel.com>
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029190113.3323406-4-ihor.solodrai@linux.dev>

Hi Ihor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ihor-Solodrai/bpf-Add-BTF_ID_LIST_END-and-BTF_ID_LIST_SIZE-macros/20251030-030608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251029190113.3323406-4-ihor.solodrai%40linux.dev
patch subject: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with KF_MAGIC_ARGS
config: s390-randconfig-001-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301923.XmrKra1o-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301923.XmrKra1o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301923.XmrKra1o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c:3273:1: error: invalid storage class specifier in function declarator
    3273 | static s32 magic_kfunc_by_impl(s32 impl_func_id)
         | ^
   kernel/bpf/verifier.c:3273:12: error: parameter named 'magic_kfunc_by_impl' is missing
    3273 | static s32 magic_kfunc_by_impl(s32 impl_func_id)
         |            ^
   kernel/bpf/verifier.c:3273:49: error: expected ';' at end of declaration
    3273 | static s32 magic_kfunc_by_impl(s32 impl_func_id)
         |                                                 ^
         |                                                 ;
   kernel/bpf/verifier.c:3271:17: error: parameter 'magic_kfuncs' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    3271 | BTF_ID_LIST_END(magic_kfuncs)
         |                 ^
    3272 | 
    3273 | static s32 magic_kfunc_by_impl(s32 impl_func_id)
    3274 | {
   kernel/bpf/verifier.c:3271:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    3271 | BTF_ID_LIST_END(magic_kfuncs)
         | ^
         | int
   kernel/bpf/verifier.c:3277:18: error: call to undeclared function 'BTF_ID_LIST_SIZE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3277 |         for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
         |                         ^
   kernel/bpf/verifier.c:3277:18: note: did you mean 'BTF_ID_LIST_END'?
   kernel/bpf/verifier.c:3271:1: note: 'BTF_ID_LIST_END' declared here
    3271 | BTF_ID_LIST_END(magic_kfuncs)
         | ^
    3272 | 
    3273 | static s32 magic_kfunc_by_impl(s32 impl_func_id)
    3274 | {
    3275 |         int i;
    3276 | 
    3277 |         for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
         |                         ~~~~~~~~~~~~~~~~
         |                         BTF_ID_LIST_END
   kernel/bpf/verifier.c:3278:19: error: subscripted value is not an array, pointer, or vector
    3278 |                 if (magic_kfuncs[i] == impl_func_id)
         |                     ~~~~~~~~~~~~^~
   kernel/bpf/verifier.c:3278:26: error: use of undeclared identifier 'impl_func_id'
    3278 |                 if (magic_kfuncs[i] == impl_func_id)
         |                                        ^
   kernel/bpf/verifier.c:3279:23: error: subscripted value is not an array, pointer, or vector
    3279 |                         return magic_kfuncs[i - 1];
         |                                ~~~~~~~~~~~~^~~~~~
>> kernel/bpf/verifier.c:3271:1: warning: no previous prototype for function 'BTF_ID_LIST_END' [-Wmissing-prototypes]
    3271 | BTF_ID_LIST_END(magic_kfuncs)
         | ^
   kernel/bpf/verifier.c:3271:16: note: declare 'static' if the function is not intended to be used outside of this translation unit
    3271 | BTF_ID_LIST_END(magic_kfuncs)
         |                ^
         |                static 
   kernel/bpf/verifier.c:3271:1: error: a function definition without a prototype is deprecated in all versions of C and is not supported in C2x [-Werror,-Wdeprecated-non-prototype]
    3271 | BTF_ID_LIST_END(magic_kfuncs)
         | ^
   kernel/bpf/verifier.c:3288:18: error: call to undeclared function 'BTF_ID_LIST_SIZE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3288 |         for (i = 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
         |                         ^
   kernel/bpf/verifier.c:3409:17: error: call to undeclared function 'magic_kfunc_by_impl'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3409 |                 tmp_func_id = magic_kfunc_by_impl(func_id);
         |                               ^
   kernel/bpf/verifier.c:13726:17: error: call to undeclared function 'magic_kfunc_by_impl'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    13726 |                 tmp_func_id = magic_kfunc_by_impl(func_id);
          |                               ^
   1 warning and 13 errors generated.


vim +/BTF_ID_LIST_END +3271 kernel/bpf/verifier.c

  3265	
  3266	/*
  3267	 * magic_kfuncs is used as a list of (foo, foo_impl) pairs
  3268	 */
  3269	BTF_ID_LIST(magic_kfuncs)
  3270	BTF_ID_UNUSED
> 3271	BTF_ID_LIST_END(magic_kfuncs)
  3272	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


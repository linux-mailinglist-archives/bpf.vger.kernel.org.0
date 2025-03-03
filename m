Return-Path: <bpf+bounces-53032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01ECA4BA0E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 09:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D6116DB3C
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148F1F03C8;
	Mon,  3 Mar 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djcHB5pk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B21F03D5
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992124; cv=none; b=UN/zJClGueakL+mXayz8zIveNeqqfpnD9uKT3K3zSWrIbLT2elQnAI1+pQjIf7EeuSrSvIw6KbcARGu8+BBv3xI1dRsgRZFKdSvF1VzCF09FLSEGSHuwFGARMOEjADnK46FjFnnHi7OCBTbE6TXkN/yyUzFCjOuGlnior1aHzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992124; c=relaxed/simple;
	bh=qHRcyUI3/hi2BGAUKUDSudJssxHgKVCe/F4h7QO/AU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix7XvHCskwd/zZQ9DQkK8I/Nh2nJko/LPbTFyZEpWdn6BRTAvYcVTNlRWmyaRt/VS4UEGSQRun5WCmNXF0QnjjxKsKwp+YrJ7KIzm2QUcMf7hjLDpLakFEq+7Lb0PBQfJpshvsMrL+huDBXyDiN2t2D+uoFYDgnvQxKs8EX5sj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djcHB5pk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740992122; x=1772528122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qHRcyUI3/hi2BGAUKUDSudJssxHgKVCe/F4h7QO/AU8=;
  b=djcHB5pkHUkv5irudZLbazaVEWqfPGjglRYxqgAaOUOOdKz+44aWPBok
   8DDPDfS94hBsH6iZp6ty1+TcRG3cnZ8hUKFDfRP6WipY2wo+0CdNG6iXG
   dCokSoq+GIFhsFPpJqQZkst2C1C8SS/9hSbrYZuveUXThsHIplIfc4eA+
   0jtG9i06HZn1pPfZWynGzsBba0aQiSkdaHypN06nLOqxgZiQ+7Vc/S/sy
   zS2EROR1IDHnurFGRfA9tRChHcfNvWBj5UQn+iFJjJd4Bz7gYf5NHOtJH
   xeErtRvO5nLTxMim/PPZuktZKcZeUkkNUZZiTSLfIhDcnoMG+FYLvlAWD
   Q==;
X-CSE-ConnectionGUID: vl0HTEfTTAyS3AesqvbBNw==
X-CSE-MsgGUID: EouhfmR+TSGj2r4sFO/2mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41744994"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41744994"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:55:21 -0800
X-CSE-ConnectionGUID: y+w4sugQRWKpajzmYyVbLA==
X-CSE-MsgGUID: jEP1RSSlThqTB8fpBFAwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123095271"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 03 Mar 2025 00:55:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tp1Zv-000IES-2O;
	Mon, 03 Mar 2025 08:55:11 +0000
Date: Mon, 3 Mar 2025 16:55:03 +0800
From: kernel test robot <lkp@intel.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Peilin Ye <yepeilin@google.com>,
	bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 04/10] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <202503031631.OeUhVRHz-lkp@intel.com>
References: <2c82b29f3530b961b41f94a4942e490ab35a31c8.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c82b29f3530b961b41f94a4942e490ab35a31c8.1740978603.git.yepeilin@google.com>

Hi Peilin,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Peilin-Ye/bpf-verifier-Factor-out-atomic_ptr_type_ok/20250303-134110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/2c82b29f3530b961b41f94a4942e490ab35a31c8.1740978603.git.yepeilin%40google.com
patch subject: [PATCH bpf-next v4 04/10] bpf: Introduce load-acquire and store-release instructions
config: arc-randconfig-002-20250303 (https://download.01.org/0day-ci/archive/20250303/202503031631.OeUhVRHz-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503031631.OeUhVRHz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503031631.OeUhVRHz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   kernel/bpf/core.c: In function '___bpf_prog_run':
>> include/linux/compiler_types.h:542:45: error: call to '__compiletime_assert_459' declared with attribute error: Need native word sized stores/loads for atomicity.
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:523:25: note: in definition of macro '__compiletime_assert'
     523 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:9: note: in expansion of macro 'compiletime_assert'
     545 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:151:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     151 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2222:45: note: in expansion of macro 'smp_load_acquire'
    2222 |                                 DST = (SIZE)smp_load_acquire(   \
         |                                             ^~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2228:25: note: in expansion of macro 'LOAD_ACQUIRE'
    2228 |                         LOAD_ACQUIRE(DW, u64)
         |                         ^~~~~~~~~~~~
   include/linux/compiler_types.h:542:45: error: call to '__compiletime_assert_466' declared with attribute error: Need native word sized stores/loads for atomicity.
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:523:25: note: in definition of macro '__compiletime_assert'
     523 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:9: note: in expansion of macro 'compiletime_assert'
     545 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:141:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     141 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2238:33: note: in expansion of macro 'smp_store_release'
    2238 |                                 smp_store_release(      \
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2244:25: note: in expansion of macro 'STORE_RELEASE'
    2244 |                         STORE_RELEASE(DW, u64)
         |                         ^~~~~~~~~~~~~


vim +/__compiletime_assert_459 +542 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  528  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  529  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  530  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  531  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  532  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  533   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  534   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  535   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  536   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  537   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  538   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  539   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  540   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  541  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @542  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  543  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


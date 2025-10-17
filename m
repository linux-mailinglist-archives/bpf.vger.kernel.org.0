Return-Path: <bpf+bounces-71206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6624BE92C9
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF3D35678AF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E10339718;
	Fri, 17 Oct 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVk30zMH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D83396F2;
	Fri, 17 Oct 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710746; cv=none; b=ZskXosZvmi5Sr+9T77jcrHeNvaW4dGD8W20ggQHkmTeqFQUgZfg6F/YiYdFJ4PgURzBBeaaUeARbakVPwpkkxQWAL7M1ZHQ9JPs/qFp4yRsEiHuyuhseaseIdqyXWezuB8QChUIXXAyJOh4Kl4AT4cdKDIe6MxX7BTkdcy2MjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710746; c=relaxed/simple;
	bh=dS3H2BszcPyjXxTOMoARMa6IIdLRr87QG3FqfTPUkWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtpD277LgbGas9J5+enEyisC6Wgd9F8oPcM6uoidPyZAojx6e4Ha3UoeWflnBE9TSUh4GywaDYvLsIFNiwbkQMVeB50PN4x7aD1GBEp2lhcVbpP+s0T5Kg/yEdJERQyYf3cNT76Q9jcsXqBr+195MDx02a5VW1ZlzBcE1LFCOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVk30zMH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760710743; x=1792246743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dS3H2BszcPyjXxTOMoARMa6IIdLRr87QG3FqfTPUkWg=;
  b=NVk30zMHv9uY+lfhWmNtS5SJ70npokA/H1FsQBNziioBJYywXq39MTfo
   CJRy44QL0cxfv1bxa/FdQOBKwpXYvAHv8Im4SKGGU1qqAcQXvn4urhhDb
   HiCwRzOm1DRdKekb5tG18pLPkvGJHJquoO8TFJ39Wmm/Hjzg0M3w5CX57
   ASa1oRsbLUgFgHgAwxAye7OLqJqgcX9a+8ynSz+kRgFuYqpJeEpuytJsN
   iGXb9ovqqYe/BqVaG7bEq6DVdbTJ8IBBpK/KUF/L+Jsf+uks8HJhcoXc2
   ME/7YaM/yUy32m1eRDO1jMAeaHPLtV7bkVW6Sa8TeNPTjdBEZdrQ//dDX
   g==;
X-CSE-ConnectionGUID: OL1PGb54R7+DWqxdXjjkhA==
X-CSE-MsgGUID: IvS69FE6QYqMmnEm33YTIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63068249"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63068249"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:18:53 -0700
X-CSE-ConnectionGUID: E7MZLNxZQAGtX0NAsL7lhA==
X-CSE-MsgGUID: jriKbGgcQJK1fPAkCyr7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="187003969"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 17 Oct 2025 07:18:49 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9lI7-00063n-0X;
	Fri, 17 Oct 2025 14:18:47 +0000
Date: Fri, 17 Oct 2025 22:18:44 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org,
	martin.lau@kernel.org, ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
Message-ID: <202510172107.6Yh2tFCb-lkp@intel.com>
References: <20251016204503.3203690-3-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016204503.3203690-3-ameryhung@gmail.com>

Hi Amery,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Amery-Hung/bpf-Allow-verifier-to-fixup-kernel-module-kfuncs/20251017-044703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251016204503.3203690-3-ameryhung%40gmail.com
patch subject: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20251017/202510172107.6Yh2tFCb-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172107.6Yh2tFCb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510172107.6Yh2tFCb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/core.c:2881:3: error: call to undeclared function 'bpf_struct_ops_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2881 |                 bpf_struct_ops_put(aux->st_ops_assoc);
         |                 ^
   kernel/bpf/core.c:2881:3: note: did you mean 'bpf_struct_ops_find'?
   include/linux/btf.h:538:49: note: 'bpf_struct_ops_find' declared here
     538 | static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
         |                                                 ^
   In file included from kernel/bpf/core.c:3240:
   In file included from include/linux/bpf_trace.h:5:
   In file included from include/trace/events/xdp.h:384:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:7:
>> include/linux/poll.h:134:27: warning: division by zero is undefined [-Wdivision-by-zero]
     134 |                 M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
         |                                         ^~~~~~~~~
   include/linux/poll.h:132:32: note: expanded from macro 'M'
     132 | #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:118:51: note: expanded from macro '__MAP'
     118 |         (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
         |                                                          ^ ~~~~~~~~~
   include/linux/poll.h:134:39: warning: division by zero is undefined [-Wdivision-by-zero]
     134 |                 M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
         |                                                     ^~~~~~~~~
   include/linux/poll.h:132:32: note: expanded from macro 'M'
     132 | #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:118:51: note: expanded from macro '__MAP'
     118 |         (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
         |                                                          ^ ~~~~~~~~~
   include/linux/poll.h:135:12: warning: division by zero is undefined [-Wdivision-by-zero]
     135 |                 M(HUP) | M(RDHUP) | M(MSG);
         |                          ^~~~~~~~
   include/linux/poll.h:132:32: note: expanded from macro 'M'
     132 | #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:118:51: note: expanded from macro '__MAP'
     118 |         (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
         |                                                          ^ ~~~~~~~~~
   include/linux/poll.h:135:23: warning: division by zero is undefined [-Wdivision-by-zero]
     135 |                 M(HUP) | M(RDHUP) | M(MSG);
         |                                     ^~~~~~
   include/linux/poll.h:132:32: note: expanded from macro 'M'
     132 | #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:118:51: note: expanded from macro '__MAP'
     118 |         (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
         |                                                          ^ ~~~~~~~~~
   4 warnings and 1 error generated.


vim +134 include/linux/poll.h

7a163b2195cda0c Al Viro 2018-02-01  129  
7a163b2195cda0c Al Viro 2018-02-01  130  static inline __poll_t demangle_poll(u16 val)
7a163b2195cda0c Al Viro 2018-02-01  131  {
7a163b2195cda0c Al Viro 2018-02-01  132  #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
7a163b2195cda0c Al Viro 2018-02-01  133  	return M(IN) | M(OUT) | M(PRI) | M(ERR) | M(NVAL) |
7a163b2195cda0c Al Viro 2018-02-01 @134  		M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
7a163b2195cda0c Al Viro 2018-02-01  135  		M(HUP) | M(RDHUP) | M(MSG);
7a163b2195cda0c Al Viro 2018-02-01  136  #undef M
7a163b2195cda0c Al Viro 2018-02-01  137  }
7a163b2195cda0c Al Viro 2018-02-01  138  #undef __MAP
7a163b2195cda0c Al Viro 2018-02-01  139  
7a163b2195cda0c Al Viro 2018-02-01  140  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


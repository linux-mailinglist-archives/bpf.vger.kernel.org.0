Return-Path: <bpf+bounces-64847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B55B1790A
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E171C80BE5
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7F2277C95;
	Thu, 31 Jul 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DP1UQMC0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46942270542;
	Thu, 31 Jul 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000323; cv=none; b=HhucIwIMInnfiuLhxD4N+WwMPfv4O++lhTWc6HDjN32z3Dl40wO/ifI40PTlk3Ilt9MdEg6eVi9KmvIM4KsGUT6WePV6CARCT1gXVmg+dp2w6id7kbG/gBJSo13GtH2kkVuzZUUU8gqGz9WUiRzAf9vcwJbkgGXs4C3lFszwiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000323; c=relaxed/simple;
	bh=YW533d/N8+mABcQxI8sTQIIuyK3oOk+1xYE15uanYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXR5+4Tq6uF285wpDexZBoZ59Dq1xnZkYMte/pzVMbpxDtxj96IldvnoOM7BZCsjVtGwv7zT9Uz7zjfM7dqAvDr+8Joi8Abo14nj2y5VGOp1xeW5eLem5vdNIIn4MSjdO4TMgqZlxYfnMkhcsim7frgRwlRmh09r1Foe6LEt46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DP1UQMC0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754000323; x=1785536323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YW533d/N8+mABcQxI8sTQIIuyK3oOk+1xYE15uanYMk=;
  b=DP1UQMC0CEELuRAKUtduN1AOsr+jiKDFXWAtfHAMq/0st4kwevMvtEiO
   mpx7JlKyyrCDunCYUvDlKQF6ZjXGPVTB3ZSrLfLxcS3ann6bHtdZlAQB/
   X5CGy9khIMoNYVaKSArqfJMdDobqomEZo7ednMw0YMgzBYNmCD2EVfspQ
   ec9nhdjp1e/+K4JGhI5h4g2CoTjR5JSu85qjWWaycJDAbmh1hj/75nZmZ
   Qmvr99AUKDVCcua40CAHlzWw26rW+hdvFQkY72zmmK7FdfnuOwQRgPk/P
   eyIsWO02+LtX+grNqyWq5NT2mX6gXzuJcG5elfq32uFVZwpw3rBM/016e
   A==;
X-CSE-ConnectionGUID: ubh+KIjITEe4ZSlVmb5nUA==
X-CSE-MsgGUID: cc04Pao/T5GzbxjETWSn0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="66909733"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="66909733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 15:18:42 -0700
X-CSE-ConnectionGUID: 7lC2KfvkR1KFs60qL+HXTA==
X-CSE-MsgGUID: Tgvd36kHSHWKQ+2Y62KqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163731560"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Jul 2025 15:18:37 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhbbe-00048Q-14;
	Thu, 31 Jul 2025 22:18:34 +0000
Date: Fri, 1 Aug 2025 06:18:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arthur Fabre <arthur@arthurfabre.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
	Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Enable read/write access to skb
 metadata through a dynptr
Message-ID: <202508010501.YGP8iOar-lkp@intel.com>
References: <20250731-skb-metadata-thru-dynptr-v5-2-f02f6b5688dc@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-2-f02f6b5688dc@cloudflare.com>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/bpf-Add-dynptr-type-for-skb-metadata/20250731-183157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250731-skb-metadata-thru-dynptr-v5-2-f02f6b5688dc%40cloudflare.com
patch subject: [PATCH bpf-next v5 2/9] bpf: Enable read/write access to skb metadata through a dynptr
config: i386-buildonly-randconfig-005-20250801 (https://download.01.org/0day-ci/archive/20250801/202508010501.YGP8iOar-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010501.YGP8iOar-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508010501.YGP8iOar-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c: In function '____bpf_snprintf':
   kernel/bpf/helpers.c:1069:9: warning: function '____bpf_snprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1069 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
         |         ^~~
   In file included from include/linux/string.h:382,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/jiffies.h:10,
                    from include/linux/ktime.h:25,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from kernel/bpf/helpers.c:4:
   kernel/bpf/helpers.c: In function '__bpf_dynptr_read':
>> include/linux/fortify-string.h:115:33: warning: argument 2 null where non-null expected [-Wnonnull]
     115 | #define __underlying_memmove    __builtin_memmove
         |                                 ^
   include/linux/fortify-string.h:645:9: note: in expansion of macro '__underlying_memmove'
     645 |         __underlying_##op(p, q, __copy_size);                           \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:694:27: note: in expansion of macro '__fortify_memcpy_chk'
     694 | #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
         |                           ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1784:17: note: in expansion of macro 'memmove'
    1784 |                 memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
         |                 ^~~~~~~
   include/linux/fortify-string.h:115:33: note: in a call to built-in function '__builtin_memmove'
     115 | #define __underlying_memmove    __builtin_memmove
         |                                 ^
   include/linux/fortify-string.h:645:9: note: in expansion of macro '__underlying_memmove'
     645 |         __underlying_##op(p, q, __copy_size);                           \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:694:27: note: in expansion of macro '__fortify_memcpy_chk'
     694 | #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
         |                           ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1784:17: note: in expansion of macro 'memmove'
    1784 |                 memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
         |                 ^~~~~~~
   kernel/bpf/helpers.c: In function '__bpf_dynptr_write':
   include/linux/fortify-string.h:115:33: warning: argument 1 null where non-null expected [-Wnonnull]
     115 | #define __underlying_memmove    __builtin_memmove
         |                                 ^
   include/linux/fortify-string.h:645:9: note: in expansion of macro '__underlying_memmove'
     645 |         __underlying_##op(p, q, __copy_size);                           \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:694:27: note: in expansion of macro '__fortify_memcpy_chk'
     694 | #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
         |                           ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1845:17: note: in expansion of macro 'memmove'
    1845 |                 memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
         |                 ^~~~~~~
   include/linux/fortify-string.h:115:33: note: in a call to built-in function '__builtin_memmove'
     115 | #define __underlying_memmove    __builtin_memmove
         |                                 ^
   include/linux/fortify-string.h:645:9: note: in expansion of macro '__underlying_memmove'
     645 |         __underlying_##op(p, q, __copy_size);                           \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:694:27: note: in expansion of macro '__fortify_memcpy_chk'
     694 | #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
         |                           ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1845:17: note: in expansion of macro 'memmove'
    1845 |                 memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
         |                 ^~~~~~~


vim +115 include/linux/fortify-string.h

78a498c3a227f2 Alexander Potapenko 2022-10-24  103  
78a498c3a227f2 Alexander Potapenko 2022-10-24  104  #if defined(__SANITIZE_MEMORY__)
78a498c3a227f2 Alexander Potapenko 2022-10-24  105  /*
78a498c3a227f2 Alexander Potapenko 2022-10-24  106   * For KMSAN builds all memcpy/memset/memmove calls should be replaced by the
78a498c3a227f2 Alexander Potapenko 2022-10-24  107   * corresponding __msan_XXX functions.
78a498c3a227f2 Alexander Potapenko 2022-10-24  108   */
78a498c3a227f2 Alexander Potapenko 2022-10-24  109  #include <linux/kmsan_string.h>
78a498c3a227f2 Alexander Potapenko 2022-10-24  110  #define __underlying_memcpy	__msan_memcpy
78a498c3a227f2 Alexander Potapenko 2022-10-24  111  #define __underlying_memmove	__msan_memmove
78a498c3a227f2 Alexander Potapenko 2022-10-24  112  #define __underlying_memset	__msan_memset
78a498c3a227f2 Alexander Potapenko 2022-10-24  113  #else
a28a6e860c6cf2 Francis Laniel      2021-02-25  114  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel      2021-02-25 @115  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel      2021-02-25  116  #define __underlying_memset	__builtin_memset
78a498c3a227f2 Alexander Potapenko 2022-10-24  117  #endif
78a498c3a227f2 Alexander Potapenko 2022-10-24  118  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


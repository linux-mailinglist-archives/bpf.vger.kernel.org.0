Return-Path: <bpf+bounces-61928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDCAAEEC4D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A000417589E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43C15B0EF;
	Tue,  1 Jul 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nc/jsYtw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FFFC0A;
	Tue,  1 Jul 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335450; cv=none; b=de6TcYodmIJE/rNg5LQI+qtE/PZigPRP+IB5Vdhux2xAFt8np/6skbgf5aiyvB1zu38iZ+elX3UPqkNQox2i/mKO9EQnqJcdW50iCU52fYC+dpHTKo3FlKfu1EFjZzNhvRWsxRUbH9it86kAGkuXZVAPdOgM+EEMoShidNtn9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335450; c=relaxed/simple;
	bh=/inhb27RaibR1LB4C56Pt3j+PRVXuCNwSkRPWvlKho0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvbaXG4VviuZ/krDVKG1WHzKIQgiqexqk4Ptsj9iJg227hXUeqBSD+Fr0CzKSg+LORx55r1f6kI5j4RA+Op8oLplDtZjEWa2zC9LIhF0+qMFY8yk5hjlrlc4i73/ph28D2jI9DEcsTu9VRXQJFMg0ojjl+fH7WOfg2DNUPSBaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nc/jsYtw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751335448; x=1782871448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/inhb27RaibR1LB4C56Pt3j+PRVXuCNwSkRPWvlKho0=;
  b=nc/jsYtwb88SN8YWbu/4qEniLVcPCxqxt+AK5jfBql5aOyDi5uV6uQLF
   Al2/yXi96AdqmqZ5/5hH61lD92E9GLslP0hIP5h//c80tNLYM2JlHMuZW
   UrlGpu8dwYewRmbOkrZCTYPOkCjAbCBTgamn8rAtiZMGh9gy0dUysfC4N
   UDAgCCdHQD4qvg0iFQEZDHvKVuln+MPuuRWbS1JbchXPbjGudnYo/6n4s
   4kf0m9P+rQYcyhghmvKeKsPx5u64RXdnihuSDimU1U4VBN5Co8AR1Dptw
   xeDR2nlMYlKqMCguzMDbyiVaoi8tWPiWhYtdzV/pCAzMFS+Xzqa3hXmRc
   g==;
X-CSE-ConnectionGUID: 2FzIvv1uSGWtZlFNUvKnww==
X-CSE-MsgGUID: Iqmj7Kc6TNq3ZW+Em8218g==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64180135"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64180135"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 19:04:08 -0700
X-CSE-ConnectionGUID: Bk9HNqJsTi6+CrQbGiZ3gg==
X-CSE-MsgGUID: TZd3gKpARxu3v+tGc3MzXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184557647"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jun 2025 19:04:04 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWQLq-000ZWg-0T;
	Tue, 01 Jul 2025 02:04:02 +0000
Date: Tue, 1 Jul 2025 10:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Arthur Fabre <arthur@arthurfabre.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr
 read/write/slice
Message-ID: <202507010904.MkxDYPdY-lkp@intel.com>
References: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/bpf-Ignore-dynptr-offset-in-skb-data-access/20250630-225941
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8%40cloudflare.com
patch subject: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr read/write/slice
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20250701/202507010904.MkxDYPdY-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507010904.MkxDYPdY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507010904.MkxDYPdY-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/sysctl.c:29:
>> include/linux/filter.h:1788:1: error: expected identifier or '(' before '{' token
    1788 | {
         | ^
   include/linux/filter.h:1795:1: error: expected identifier or '(' before '{' token
    1795 | {
         | ^
>> include/linux/filter.h:1785:19: warning: 'bpf_dynptr_skb_write' declared 'static' but never defined [-Wunused-function]
    1785 | static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
         |                   ^~~~~~~~~~~~~~~~~~~~
>> include/linux/filter.h:1792:21: warning: 'bpf_dynptr_skb_slice' declared 'static' but never defined [-Wunused-function]
    1792 | static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
         |                     ^~~~~~~~~~~~~~~~~~~~


vim +1788 include/linux/filter.h

b5964b968ac64c Joanne Koong   2023-03-01  1784  
e8b34e67737d71 Jakub Sitnicki 2025-06-30 @1785  static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
e8b34e67737d71 Jakub Sitnicki 2025-06-30  1786  				       u32 offset, const void *src, u32 len,
e8b34e67737d71 Jakub Sitnicki 2025-06-30  1787  				       u64 flags);
b5964b968ac64c Joanne Koong   2023-03-01 @1788  {
b5964b968ac64c Joanne Koong   2023-03-01  1789  	return -EOPNOTSUPP;
b5964b968ac64c Joanne Koong   2023-03-01  1790  }
05421aecd4ed65 Joanne Koong   2023-03-01  1791  
e8b34e67737d71 Jakub Sitnicki 2025-06-30 @1792  static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
e8b34e67737d71 Jakub Sitnicki 2025-06-30  1793  					 u32 offset, void *buf, u32 len);
e8b34e67737d71 Jakub Sitnicki 2025-06-30  1794  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


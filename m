Return-Path: <bpf+bounces-14212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342967E124E
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 06:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577B3B20EE7
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 05:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07441FA8;
	Sun,  5 Nov 2023 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9nOmANY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6D8BEB;
	Sun,  5 Nov 2023 05:16:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD811BF;
	Sat,  4 Nov 2023 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699161395; x=1730697395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QH266okKJWb309c2VT71zlCNS1DZsylF0IqchazjelU=;
  b=X9nOmANYV4V9FSEM+++uAX9gMQSZZKfF8eeGtSNwm+4g5R7f4iXDxf00
   uN28MNuaKzgKl0LB+RN0VA3nT4pLLeqVX082JSKJrAUhFh4sK6whgCKvk
   9RHBNRwVv+aMifSWArjfVwHEWwB3+jtUJ5WNxW6eeu6NzwuUcNagiG3I4
   jbp+rYnZreNSMpqzidytfYzdG+vrvD1Nd8yNIVyn4xwIdkTlGGm6ROwiB
   EkfEi0ezPXSZ0WMyuqw+Fwuz4CvddIk96MFuMHxdpH0KYBkiXWGSLIee4
   61warIEryijuFV7rDwuDs+H+vOqmjB0WTjAA2DY8vcl+dE0Gm8htdqmiq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="379517602"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="379517602"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 22:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="832413278"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="832413278"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2023 22:16:30 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzVUr-00053o-2q;
	Sun, 05 Nov 2023 05:16:29 +0000
Date: Sun, 5 Nov 2023 13:16:09 +0800
From: kernel test robot <lkp@intel.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
	andrii@kernel.org, drosen@google.com
Cc: oe-kbuild-all@lists.linux.dev, sinquersw@gmail.com, kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v10 10/13] bpf, net: switch to dynamic
 registration
Message-ID: <202311051202.DeubcWTl-lkp@intel.com>
References: <20231103232202.3664407-11-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103232202.3664407-11-thinker.li@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/thinker-li-gmail-com/bpf-refactory-struct_ops-type-initialization-to-a-function/20231104-072528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231103232202.3664407-11-thinker.li%40gmail.com
patch subject: [PATCH bpf-next v10 10/13] bpf, net: switch to dynamic registration
config: riscv-randconfig-002-20231105 (https://download.01.org/0day-ci/archive/20231105/202311051202.DeubcWTl-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051202.DeubcWTl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051202.DeubcWTl-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/bpf/btf.o: in function `btf_array_show':
>> kernel/bpf/btf.c:3044:(.text+0x6c38): undefined reference to `bpf_struct_ops_desc_init'


vim +3044 kernel/bpf/btf.c

31d0bc81637d8d Alan Maguire     2020-09-28  3032  
31d0bc81637d8d Alan Maguire     2020-09-28  3033  static void btf_array_show(const struct btf *btf, const struct btf_type *t,
31d0bc81637d8d Alan Maguire     2020-09-28  3034  			   u32 type_id, void *data, u8 bits_offset,
31d0bc81637d8d Alan Maguire     2020-09-28  3035  			   struct btf_show *show)
31d0bc81637d8d Alan Maguire     2020-09-28  3036  {
31d0bc81637d8d Alan Maguire     2020-09-28  3037  	const struct btf_member *m = show->state.member;
31d0bc81637d8d Alan Maguire     2020-09-28  3038  
31d0bc81637d8d Alan Maguire     2020-09-28  3039  	/*
31d0bc81637d8d Alan Maguire     2020-09-28  3040  	 * First check if any members would be shown (are non-zero).
31d0bc81637d8d Alan Maguire     2020-09-28  3041  	 * See comments above "struct btf_show" definition for more
31d0bc81637d8d Alan Maguire     2020-09-28  3042  	 * details on how this works at a high-level.
31d0bc81637d8d Alan Maguire     2020-09-28  3043  	 */
31d0bc81637d8d Alan Maguire     2020-09-28 @3044  	if (show->state.depth > 0 && !(show->flags & BTF_SHOW_ZERO)) {
31d0bc81637d8d Alan Maguire     2020-09-28  3045  		if (!show->state.depth_check) {
31d0bc81637d8d Alan Maguire     2020-09-28  3046  			show->state.depth_check = show->state.depth + 1;
31d0bc81637d8d Alan Maguire     2020-09-28  3047  			show->state.depth_to_show = 0;
31d0bc81637d8d Alan Maguire     2020-09-28  3048  		}
31d0bc81637d8d Alan Maguire     2020-09-28  3049  		__btf_array_show(btf, t, type_id, data, bits_offset, show);
31d0bc81637d8d Alan Maguire     2020-09-28  3050  		show->state.member = m;
31d0bc81637d8d Alan Maguire     2020-09-28  3051  
31d0bc81637d8d Alan Maguire     2020-09-28  3052  		if (show->state.depth_check != show->state.depth + 1)
31d0bc81637d8d Alan Maguire     2020-09-28  3053  			return;
31d0bc81637d8d Alan Maguire     2020-09-28  3054  		show->state.depth_check = 0;
31d0bc81637d8d Alan Maguire     2020-09-28  3055  
31d0bc81637d8d Alan Maguire     2020-09-28  3056  		if (show->state.depth_to_show <= show->state.depth)
31d0bc81637d8d Alan Maguire     2020-09-28  3057  			return;
31d0bc81637d8d Alan Maguire     2020-09-28  3058  		/*
31d0bc81637d8d Alan Maguire     2020-09-28  3059  		 * Reaching here indicates we have recursed and found
31d0bc81637d8d Alan Maguire     2020-09-28  3060  		 * non-zero array member(s).
31d0bc81637d8d Alan Maguire     2020-09-28  3061  		 */
31d0bc81637d8d Alan Maguire     2020-09-28  3062  	}
31d0bc81637d8d Alan Maguire     2020-09-28  3063  	__btf_array_show(btf, t, type_id, data, bits_offset, show);
b00b8daec828dd Martin KaFai Lau 2018-04-18  3064  }
b00b8daec828dd Martin KaFai Lau 2018-04-18  3065  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


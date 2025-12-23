Return-Path: <bpf+bounces-77330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B739BCD77BB
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 01:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C078B301C3FC
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 00:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6677118A6A7;
	Tue, 23 Dec 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zq+FpF57"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880915B135
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766449191; cv=none; b=E6Skn9W8q2b5wa8I/mbHTgKIamvVeCbfWmaSallKBh7soK0cwDtFMu2fDgZCwLgj/g6cpq70lBI6H6PCl/HFZqbkASjVPZl5ul2fG7ZQCazqeo+KzC8+N1qEaey58cy0IZHnCWBLTkeDm3cbp8hHGKQwwKeti94qTqK7X83jMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766449191; c=relaxed/simple;
	bh=MYDbdyXM9tc0jKuTCmqBbzVS66Wa1/+2HYH29cdFIIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diFtuo5uwYHH5LVmFB9mxPlGmhH8vz9l3reWHXjfa5o3kRARveqGX27yM+WhlR6fH108l4XfKvrSYN2ke+NWHDvHBgT7Bv6A/nNOsu/aTy9dn+cYRqXHxFjM7UeZfl5wRSa1DxuWItoe52LCJeasCOIwlv1lntVXhRrey9jnZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zq+FpF57; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766449191; x=1797985191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYDbdyXM9tc0jKuTCmqBbzVS66Wa1/+2HYH29cdFIIw=;
  b=Zq+FpF57FfCzTr2EoX2ejy2zn+XtSeoiSBZs94dM2bXI8DSBRb6UakL4
   GK2TDuZjPvQ44EEI0ynMlsxkKacNP1QaljAFYri6GL4lPPPI07yV9qEpV
   KJJLNLol8/ChGxbNggFTV5xVzLcDIUJ7b9sGASETw56OFB3kbm+sy48dr
   B/trHhguRhSDQjKWxl+gTAQhAy9kw9Do8YI4iyGZmPx2U4TTtMa9e3BvX
   voHy83hJ7DQLK5la3fBK5AsK+TDehnGRq91SivFgocJKKOgwDc3k1l6Kj
   2HipjLMFapI/sxH7OpjmX69juhLuDayeYeUWfJPoKrYqLSQp1v62By1Hr
   w==;
X-CSE-ConnectionGUID: v3XVmzhyQSmUwxdAMljzfg==
X-CSE-MsgGUID: H1IbK1GwRLiO6OJ61PwEQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79755405"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="79755405"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 16:19:50 -0800
X-CSE-ConnectionGUID: IBycN3GhS62ndaPYp+70hw==
X-CSE-MsgGUID: WnBRouCSRh28LdrnWYNu4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199302145"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Dec 2025 16:19:46 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXq7r-000000001Fd-194D;
	Tue, 23 Dec 2025 00:19:43 +0000
Date: Tue, 23 Dec 2025 08:19:18 +0800
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
Message-ID: <202512230859.IsGUdbZS-lkp@intel.com>
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
config: i386-randconfig-053-20251222 (https://download.01.org/0day-ci/archive/20251223/202512230859.IsGUdbZS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230859.IsGUdbZS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230859.IsGUdbZS-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/verifier.o: in function `__bpf_sdiv':
>> kernel/bpf/verifier.c:15227:(.text+0xfcb2): undefined reference to `__divdi3'
>> ld: kernel/bpf/verifier.c:15227:(.text+0xfd37): undefined reference to `__divdi3'
   ld: kernel/bpf/verifier.c:15227:(.text+0xfdae): undefined reference to `__divdi3'
   ld: kernel/bpf/verifier.c:15227:(.text+0xfe0c): undefined reference to `__divdi3'
   ld: kernel/bpf/verifier.c:15227:(.text+0xff7c): undefined reference to `__divdi3'
   ld: kernel/bpf/verifier.o: in function `scalar_min_max_udiv':
>> kernel/bpf/verifier.c:15138:(.text+0x1b9bb): undefined reference to `__udivdi3'
>> ld: kernel/bpf/verifier.c:15139:(.text+0x1b9dc): undefined reference to `__udivdi3'
   ld: kernel/bpf/tnum.o: in function `tnum_udiv':
>> kernel/bpf/tnum.c:227:(.text+0x1b3): undefined reference to `__udivdi3'
>> ld: kernel/bpf/tnum.c:219:(.text+0x28d): undefined reference to `__udivdi3'
   ld: kernel/bpf/tnum.c:227:(.text+0xb05): undefined reference to `__udivdi3'
   ld: kernel/bpf/tnum.o:kernel/bpf/tnum.c:219: more undefined references to `__udivdi3' follow
   ld: kernel/bpf/tnum.o: in function `tnum_sdiv':
>> kernel/bpf/tnum.c:300:(.text+0x131d): undefined reference to `__divdi3'


vim +15227 kernel/bpf/verifier.c

 15118	
 15119	static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
 15120					struct bpf_reg_state *src_reg)
 15121	{
 15122		u64 *dst_umin = &dst_reg->umin_value;
 15123		u64 *dst_umax = &dst_reg->umax_value;
 15124		u64 umin_val = src_reg->umin_value;
 15125		u64 umax_val = src_reg->umax_value;
 15126	
 15127		if (umin_val == 0) {
 15128			/* BPF div specification: x / 0 = 0
 15129			 * 1. If umin_val == umax_val == 0, i.e. divisor is certainly 0,
 15130			 * then the result must be 0, [a,b] / [0,0] = [0,0].
 15131			 * 2. If umin_val == 0 && umax_val != 0, then dst_umin = x / 0 = 0,
 15132			 * dst_umax = dst_umax / 1, remains unchanged, [a,b] / [0,x] = [0,b].
 15133			 */
 15134			*dst_umin = 0;
 15135			if (umax_val == 0)
 15136				*dst_umax = 0;
 15137		} else {
 15138			*dst_umin = *dst_umin / umax_val;
 15139			*dst_umax = *dst_umax / umin_val;
 15140		}
 15141	
 15142		/* Reset signed interval to TOP. */
 15143		dst_reg->smin_value = S64_MIN;
 15144		dst_reg->smax_value = S64_MAX;
 15145	}
 15146	
 15147	static s32 __bpf_sdiv32(s32 a, s32 b)
 15148	{
 15149		/* BPF div specification: x / 0 = 0 */
 15150		if (unlikely(b == 0))
 15151			return 0;
 15152		/* BPF mod specification: S32_MIN / -1 = S32_MIN */
 15153		if (unlikely(a == S32_MIN && b == -1))
 15154			return S32_MIN;
 15155		return a / b;
 15156	}
 15157	
 15158	/* The divisor interval does not cross 0,
 15159	 * i.e. src_min and src_max have same sign.
 15160	 */
 15161	static void __sdiv32_range(s32 dst_min, s32 dst_max, s32 src_min, s32 src_max,
 15162					s32 *res_min, s32 *res_max)
 15163	{
 15164		s32 tmp_res[4] = {
 15165			__bpf_sdiv32(dst_min, src_min),
 15166			__bpf_sdiv32(dst_min, src_max),
 15167			__bpf_sdiv32(dst_max, src_min),
 15168			__bpf_sdiv32(dst_max, src_max)
 15169		};
 15170	
 15171		*res_min = min_array(tmp_res, 4);
 15172		*res_max = max_array(tmp_res, 4);
 15173	}
 15174	
 15175	static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
 15176					struct bpf_reg_state *src_reg)
 15177	{
 15178		u32 *dst_smin = &dst_reg->s32_min_value;
 15179		u32 *dst_smax = &dst_reg->s32_max_value;
 15180		u32 smin_val = src_reg->s32_min_value;
 15181		u32 smax_val = src_reg->s32_max_value;
 15182		s32 res_min, res_max, tmp_min, tmp_max;
 15183	
 15184		if (smin_val <= 0 && smax_val >= 0) {
 15185			/* BPF div specification: x / 0 = 0
 15186			 * Set initial result to 0, as 0 is in divisor interval.
 15187			 */
 15188			res_min = 0;
 15189			res_max = 0;
 15190			/* negative divisor interval: [a_min,a_max] / [b_min,-1] */
 15191			if (smin_val < 0) {
 15192				__sdiv32_range(*dst_smin, *dst_smax, smin_val, -1,
 15193						&tmp_min, &tmp_max);
 15194				__scalar32_min_max_join(&res_min, &res_max, tmp_min, tmp_max);
 15195			}
 15196			/* positive divisor interval: [a_min,a_max] / [1,b_max] */
 15197			if (smax_val > 0) {
 15198				__sdiv32_range(*dst_smin, *dst_smax, 1, smax_val,
 15199						&tmp_min, &tmp_max);
 15200				__scalar32_min_max_join(&res_min, &res_max, tmp_min, tmp_max);
 15201			}
 15202		} else {
 15203			__sdiv32_range(*dst_smin, *dst_smax, smin_val, smax_val,
 15204				&res_min, &res_max);
 15205		}
 15206	
 15207		/* BPF mod specification: S32_MIN / -1 = S32_MIN */
 15208		if (*dst_smin == S32_MIN && smin_val <= -1 && smax_val >= -1)
 15209			res_min = S32_MIN;
 15210	
 15211		*dst_smin = res_min;
 15212		*dst_smax = res_max;
 15213	
 15214		/* Reset unsigned interval to TOP. */
 15215		dst_reg->u32_min_value = 0;
 15216		dst_reg->u32_max_value = U32_MAX;
 15217	}
 15218	
 15219	static s64 __bpf_sdiv(s64 a, s64 b)
 15220	{
 15221		/* BPF div specification: x / 0 = 0 */
 15222		if (unlikely(b == 0))
 15223			return 0;
 15224		/* BPF div specification: S64_MIN / -1 = S64_MIN */
 15225		if (unlikely(a == S64_MIN && b == -1))
 15226			return S64_MIN;
 15227		return a / b;
 15228	}
 15229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


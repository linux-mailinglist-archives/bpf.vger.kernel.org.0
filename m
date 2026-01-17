Return-Path: <bpf+bounces-79375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F96D3903C
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 19:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 573A63011B25
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21729ACFD;
	Sat, 17 Jan 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqlaHcs9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632F1DED57
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672818; cv=none; b=kzaeWIeciJjuQ8z/l6geHjbH7Oc0RwcQgMgw0r2eyDS1ORx7iduqLLYdwbL/diuPhJj5WUtcF4WKknNp03JnR6GqvLwYvutfLOX/Hc3+hsVN7Eeq27cgE7aA6C0QVmu6KBKiwNED81oMlkCb3DmA0FNSt6Cd2hA0GrB3hmIEk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672818; c=relaxed/simple;
	bh=8DVsPitu1vqZzZSudf3Y0VSNwi0U3VGjOZeP2CzewJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbMI3P9i0hirmkQNcLCnABT86hIRLv/kAeMqqjRCxulBVe56rW+Rivic0m+lUf3HTtSX3sVDf2QtMssMpDJVWk4QN85CYaL6GzmGYOG2dmict/Ymqzz40+R5ugyypdWql1fadhhBmo+4SP6NThTW4l9WzxPOwpDyMsQfx/NFvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqlaHcs9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768672817; x=1800208817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DVsPitu1vqZzZSudf3Y0VSNwi0U3VGjOZeP2CzewJo=;
  b=GqlaHcs9VxY7Lgs0FGrOpZaqmLHECuj9bAtllawLpw2jw8aczMDKpeH3
   adsnlvgQ6gxerykvL6gO7ZQQbZ4+J4BcEuoKgeKDlDTWDHOfvcA5RpcCh
   U/4WIWKk2fKl4irSM9I46F2fUAqd1jnhTXaMWNeoiWqZdLvF/IT/aDqQB
   TcTHZfQsR9SLLMok3OS/Gg2nkfJu4QTZJyqD+9aGeJVLHKQy8BKSIdaf/
   sw1DdhPKXh/LoZXoVddG9HNWdxqrqVfpCi7MKWZpt9uv725eaXSF1Smz4
   2r56fBHQCdzyypOjkc5qnfUOnUCfCms1lu9iXP7bQYupBL0srNupBOMA+
   Q==;
X-CSE-ConnectionGUID: aN+DxBTEQyi55fBfEO4IDQ==
X-CSE-MsgGUID: FY0jgNAwSvO21bdCaZQBPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="81067193"
X-IronPort-AV: E=Sophos;i="6.21,234,1763452800"; 
   d="scan'208";a="81067193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 10:00:17 -0800
X-CSE-ConnectionGUID: xpfjltURS++a5M8ekhCSlw==
X-CSE-MsgGUID: sJOtdKwkR3iXoL10wHA8nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,234,1763452800"; 
   d="scan'208";a="205538171"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Jan 2026 10:00:11 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhAam-00000000M6u-3EhE;
	Sat, 17 Jan 2026 18:00:08 +0000
Date: Sun, 18 Jan 2026 01:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com, ziye@zju.edu.cn,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
Message-ID: <202601180148.c0CJQxhM-lkp@intel.com>
References: <20260116103246.2477635-2-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116103246.2477635-2-tangyazhou@zju.edu.cn>

Hi Yazhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/bpf-Add-range-tracking-for-BPF_DIV-and-BPF_MOD/20260116-183743
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260116103246.2477635-2-tangyazhou%40zju.edu.cn
patch subject: [PATCH bpf-next v4 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
config: microblaze-randconfig-r112-20260117 (https://download.01.org/0day-ci/archive/20260118/202601180148.c0CJQxhM-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260118/202601180148.c0CJQxhM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601180148.c0CJQxhM-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: kernel/bpf/verifier.o: in function `scalar_min_max_udiv':
>> kernel/bpf/verifier.c:15128: undefined reference to `__udivdi3'
>> microblaze-linux-ld: kernel/bpf/verifier.c:15129: undefined reference to `__udivdi3'
   microblaze-linux-ld: kernel/bpf/verifier.o: in function `scalar_min_max_sdiv':
>> kernel/bpf/verifier.c:15199: undefined reference to `__divdi3'
>> microblaze-linux-ld: kernel/bpf/verifier.c:15200: undefined reference to `__divdi3'


vim +15128 kernel/bpf/verifier.c

 15120	
 15121	static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
 15122					struct bpf_reg_state *src_reg)
 15123	{
 15124		u64 *dst_umin = &dst_reg->umin_value;
 15125		u64 *dst_umax = &dst_reg->umax_value;
 15126		u64 src_val = src_reg->umin_value; /* non-zero, const divisor */
 15127	
 15128		*dst_umin = *dst_umin / src_val;
 15129		*dst_umax = *dst_umax / src_val;
 15130	
 15131		/* Reset other ranges/tnum to unbounded/unknown. */
 15132		dst_reg->smin_value = S64_MIN;
 15133		dst_reg->smax_value = S64_MAX;
 15134		__reset_reg32_and_tnum(dst_reg);
 15135	}
 15136	
 15137	static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
 15138					  struct bpf_reg_state *src_reg)
 15139	{
 15140		s32 *dst_smin = &dst_reg->s32_min_value;
 15141		s32 *dst_smax = &dst_reg->s32_max_value;
 15142		s32 src_val = src_reg->s32_min_value; /* non-zero, const divisor */
 15143		s32 res1, res2;
 15144	
 15145		/* BPF div specification: S32_MIN / -1 = S32_MIN */
 15146		if (*dst_smin == S32_MIN && src_val == -1) {
 15147			/*
 15148			 * If the dividend range contains more than just S32_MIN,
 15149			 * we cannot precisely track the result, so it becomes unbounded.
 15150			 * e.g., [S32_MIN, S32_MIN+10]/(-1),
 15151			 *     = {S32_MIN} U [-(S32_MIN+10), -(S32_MIN+1)]
 15152			 *     = {S32_MIN} U [S32_MAX-9, S32_MAX] = [S32_MIN, S32_MAX]
 15153			 * Otherwise (if dividend is exactly S32_MIN), result remains S32_MIN.
 15154			 */
 15155			if (*dst_smax != S32_MIN) {
 15156				*dst_smin = S32_MIN;
 15157				*dst_smax = S32_MAX;
 15158			}
 15159			goto reset;
 15160		}
 15161	
 15162		res1 = *dst_smin / src_val;
 15163		res2 = *dst_smax / src_val;
 15164		*dst_smin = min(res1, res2);
 15165		*dst_smax = max(res1, res2);
 15166	
 15167	reset:
 15168		/* Reset other ranges/tnum to unbounded/unknown. */
 15169		dst_reg->u32_min_value = 0;
 15170		dst_reg->u32_max_value = U32_MAX;
 15171		__reset_reg64_and_tnum(dst_reg);
 15172	}
 15173	
 15174	static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
 15175					struct bpf_reg_state *src_reg)
 15176	{
 15177		s64 *dst_smin = &dst_reg->smin_value;
 15178		s64 *dst_smax = &dst_reg->smax_value;
 15179		s64 src_val = src_reg->smin_value; /* non-zero, const divisor */
 15180		s64 res1, res2;
 15181	
 15182		/* BPF div specification: S64_MIN / -1 = S64_MIN */
 15183		if (*dst_smin == S64_MIN && src_val == -1) {
 15184			/*
 15185			 * If the dividend range contains more than just S64_MIN,
 15186			 * we cannot precisely track the result, so it becomes unbounded.
 15187			 * e.g., [S64_MIN, S64_MIN+10]/(-1),
 15188			 *     = {S64_MIN} U [-(S64_MIN+10), -(S64_MIN+1)]
 15189			 *     = {S64_MIN} U [S64_MAX-9, S64_MAX] = [S64_MIN, S64_MAX]
 15190			 * Otherwise (if dividend is exactly S64_MIN), result remains S64_MIN.
 15191			 */
 15192			if (*dst_smax != S64_MIN) {
 15193				*dst_smin = S64_MIN;
 15194				*dst_smax = S64_MAX;
 15195			}
 15196			goto reset;
 15197		}
 15198	
 15199		res1 = *dst_smin / src_val;
 15200		res2 = *dst_smax / src_val;
 15201		*dst_smin = min(res1, res2);
 15202		*dst_smax = max(res1, res2);
 15203	
 15204	reset:
 15205		/* Reset other ranges/tnum to unbounded/unknown. */
 15206		dst_reg->umin_value = 0;
 15207		dst_reg->umax_value = U64_MAX;
 15208		__reset_reg32_and_tnum(dst_reg);
 15209	}
 15210	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-65781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FBFB28580
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE0B014E6
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EBE317704;
	Fri, 15 Aug 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViD2mEWq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B43176E8
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281198; cv=none; b=MrpD+yWc/L5fBRpoikDCnsRlAOJ5VtAvBP4oe6efVB5mSnBr+cFuGLNeu1EbZS8K88LecbRIQpyjNFkEaJV8iuUBca4UEuqwG4x16PwpwbOPAfr+LkafOnrQiGtildDNjJiOJV/8h4N3g6J5/CHG+EM6D4cCJgegna56nePuX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281198; c=relaxed/simple;
	bh=o7UBMqfzDFywgYxzrjrHuGzCJdhs4C4WEmdj59BvIZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5OcKE3FHEVm858uVr3OeZSNx++720U8gYX3ulf2U2lVmmLoWTNITwZlAOtDXlFRcp7e83zWP9Xobf9dahgu7yLyWgdLQlW2jPkuUFPsElfz0Aa4UKFQVgVA4UyRctK+wG24Vom1iPdoZAZSz3nE5YYUsBfSwIaEYtaI4da9hOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViD2mEWq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755281197; x=1786817197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7UBMqfzDFywgYxzrjrHuGzCJdhs4C4WEmdj59BvIZU=;
  b=ViD2mEWqZau2VqfSgl7JX62zAnW7vpdUuQhQy5BMls1I13ZyPrDPU6/9
   WYKKyYxDzmYkU+R61KUJtuULSmvgZdFgpqLYCg9LZg5IjJOpBi977mY6K
   uneVeipRrfKxkfGCdJep84r3EC83CcXOQwi+kUlLihNetcD3GyLVAaMas
   8PM9bpDDJFFE2qGxQ55FGUdY01XDMmzwMFORLrnnxQtYqeYO3hD4eYfZA
   EUTUl8fL5uoHhJQz3zbl/NEQU8vIu8cw03A3931fwINxwh4pPUTyvNgi/
   wiIKEp3clFDFd3yVeTIZtcxQ05sc1uUGt6pvvd0vzUTfxEnYCNYqsvg7Z
   Q==;
X-CSE-ConnectionGUID: wwOxKhd/TSywI79LgzSMxQ==
X-CSE-MsgGUID: 3QY/34zVQBa6hi9SjaB69g==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="69053534"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69053534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 11:06:35 -0700
X-CSE-ConnectionGUID: hiheKD3fQ6G4YzfpvYacPQ==
X-CSE-MsgGUID: 67Eyn7ZyR8C5HSwY3H3Lzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167448075"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 15 Aug 2025 11:06:31 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umyou-000CDM-1z;
	Fri, 15 Aug 2025 18:06:28 +0000
Date: Sat, 16 Aug 2025 02:06:05 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Report arena faults to BPF stderr
Message-ID: <202508160152.El7IYy94-lkp@intel.com>
References: <20250811111828.13836-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811111828.13836-3-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arm64-simplify-exception-table-handling/20250811-192218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250811111828.13836-3-puranjay%40kernel.org
patch subject: [PATCH bpf-next v2 2/3] bpf: Report arena faults to BPF stderr
config: x86_64-randconfig-122-20250815 (https://download.01.org/0day-ci/archive/20250816/202508160152.El7IYy94-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160152.El7IYy94-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160152.El7IYy94-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `ex_handler_bpf':
>> arch/x86/net/bpf_jit_comp.c:1450: undefined reference to `bpf_prog_report_arena_violation'


vim +1450 arch/x86/net/bpf_jit_comp.c

  1430	
  1431	bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
  1432	{
  1433		u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
  1434		u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
  1435		bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
  1436		bool is_write = (reg == DONT_CLEAR);
  1437		unsigned long addr;
  1438		s16 off;
  1439		u32 arena_reg;
  1440	
  1441		/* jump over faulting load and clear dest register */
  1442		if (reg != DONT_CLEAR)
  1443			*(unsigned long *)((void *)regs + reg) = 0;
  1444		regs->ip += insn_len;
  1445	
  1446		if (is_arena) {
  1447			arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->data);
  1448			off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
  1449			addr = *(unsigned long *)((void *)regs + arena_reg) + off;
> 1450			bpf_prog_report_arena_violation(is_write, addr);
  1451		}
  1452	
  1453		return true;
  1454	}
  1455	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


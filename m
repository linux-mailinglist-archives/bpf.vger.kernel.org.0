Return-Path: <bpf+bounces-67165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87080B40104
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F4A7B6B23
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7972BE63F;
	Tue,  2 Sep 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpzTCy/V"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807729BD8E
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817076; cv=none; b=ViPryQS+fttPZsBVVQ5eabscjVhCzvdkHwLDWzkCPXupEvSuLsbDGqThwQU2nRT6KZ7+l8SlP3tbj+xxOmAq/v80bSqKy4PwDVu7tfMUcGGGc0QY0MJXx+yb4vL1OrmaXn0G1PqWdDUoPo1WBVSGKvr3IS4XOGUGUNEdIHaavNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817076; c=relaxed/simple;
	bh=R2RCICYQh0bmGfUwJGJV4T9ruKuRJOqTjWj8SrJJkQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3K8wvLwx8sAgIb9NKUYmJSEoC78rYvC5I5eETe2YmV6YdbH25oflFxP+lmiGyCarCUrG6BuZGbZn6Pi706qofrbJL0CRQ2AM4JUONAzMS7rz5gesbGtMdPZmpg8eaZunoorUGU8IoXN8yJkUqVvGgdjMUSc1+ryX/wIBDQPfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpzTCy/V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756817073; x=1788353073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R2RCICYQh0bmGfUwJGJV4T9ruKuRJOqTjWj8SrJJkQk=;
  b=UpzTCy/VEWYoxMVNqrI9U//JHtWDDDH9M/1AnZ9oYtNZmQbJiW5RNNZY
   obRxzznPjs3K1+JActM8tVgbLOmKzwF49Fzt6c9LyZZavt8segw+mvi1C
   5RNALp2qrqQ21mUlW/1+gL7nP2FqLciHO1hr+/b1+Qt7fCGiWlTCSX9wt
   D6Vx0q7izV4VwO844XvDc8r2E5vhwF2gnjhTIpgylWvMPzRmViGoI6DAi
   fwUCUV6NHUxXrTWEupebBwGfu4hd4mIacYAVja4HSQhGSGjPp8rGn479K
   IC/adZ9EOoaWjRaLW/Ko5puoN2pejOxpYZaAmFNTuvu/IIxw2YhVFFStL
   Q==;
X-CSE-ConnectionGUID: vvf32viSQcCCoBnD+1MVAA==
X-CSE-MsgGUID: yYPSMESPSnyKaUgge7blnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62920303"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62920303"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:44:32 -0700
X-CSE-ConnectionGUID: 95i9zhkrQMiNJ1vBeJSU9A==
X-CSE-MsgGUID: 5taccYprTmSVxwPWqg+u6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171233054"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2025 05:44:28 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utQMF-00020J-32;
	Tue, 02 Sep 2025 12:43:42 +0000
Date: Tue, 2 Sep 2025 20:42:29 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v5 3/4] bpf: Report arena faults to BPF stderr
Message-ID: <202509022034.z1178h4W-lkp@intel.com>
References: <20250901193730.43543-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901193730.43543-4-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arm64-simplify-exception-table-handling/20250902-033833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250901193730.43543-4-puranjay%40kernel.org
patch subject: [PATCH bpf-next v5 3/4] bpf: Report arena faults to BPF stderr
config: x86_64-buildonly-randconfig-002-20250902 (https://download.01.org/0day-ci/archive/20250902/202509022034.z1178h4W-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250902/202509022034.z1178h4W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509022034.z1178h4W-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/arena.c:637:6: error: redefinition of 'bpf_prog_report_arena_violation'
     637 | void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip)
         |      ^
   include/linux/bpf.h:2050:20: note: previous definition is here
    2050 | static inline void bpf_prog_report_arena_violation(bool write, unsigned long addr,
         |                    ^
   1 error generated.


vim +/bpf_prog_report_arena_violation +637 kernel/bpf/arena.c

   636	
 > 637	void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-40179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B564697E308
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 21:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7324C281241
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 19:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07858ABC;
	Sun, 22 Sep 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjQI8F5w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C054BD8;
	Sun, 22 Sep 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727033838; cv=none; b=RZW/zwQRD8emgRifmIHnXB/Fb9VGTcMi1G6r8PCoPLejzd0oIDvV+SN9qJrFR2umMP1q/sSoyGREjOLwoyw6M1VoUP43GykVsqonGCM1qaN87TMnFzyfxyFw8zox4VSPA5vItLBCP3hlyjmch4RKqN0sN9eKwMUMhZCr87wTG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727033838; c=relaxed/simple;
	bh=6OLw3KQ9Id+36Of4MyqNEVVuMKmyZVb/xQStwECSFYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J26X0/QB55VrhsscFoRnQqCk3KCe1Nz/+fAVSThqmmbDctvfMjNimYqJKxlrZZSHZ1630KFd3q+E138OYJ63Fo3sH/2qDL/cKGIxLB9mmQvTT5exg4Yu3NFWk9bJhFd2tth71uaCDboAcH1Dv8zRKmXy7x/TuS+g9t16ouoGJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjQI8F5w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727033837; x=1758569837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6OLw3KQ9Id+36Of4MyqNEVVuMKmyZVb/xQStwECSFYs=;
  b=IjQI8F5w6QyUR38AkdqeiIXxKc0S9HP/H0UujMvYKshS02p+QaMe7E6C
   5CTnjRYEJRa3EB2Nr0smtXJVq9Gzto6hxVBDm9QZFiIi00MgXmw2gUEJQ
   I3YpKvj/A7+9sDsYMeAHZWuUrZbp5/G9hDtE37EndJl59ZHY1vARz1cST
   WQAHJ3gu3bLOge7c0E1rCEZlVLXN30HqGAqjXtUvMWw9VzOTAYxQT+0ny
   a7JLWEDbWv5wfYRKUBiugjpjMBHveD9u5iOSDRtxjavwfaRg2Z8enZF6J
   0TrBufIIaTbLGVmoQiH3q3NU/R+Kq5SiunVGoCR+h3tkMFRsCEwx9LbgD
   A==;
X-CSE-ConnectionGUID: xiL/W/oRRYCP5Q5V/r+Xpw==
X-CSE-MsgGUID: vEEM7xwJTLCOEPNnuNSebQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26165479"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26165479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 12:37:13 -0700
X-CSE-ConnectionGUID: aowQNLVzSmG3LDQPSyDrtw==
X-CSE-MsgGUID: uH31ZW4XSq+pLndr8kHZvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75243054"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Sep 2024 12:37:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssSOI-000GcU-0Y;
	Sun, 22 Sep 2024 19:37:06 +0000
Date: Mon, 23 Sep 2024 03:36:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, Tao Chen <chen.dylane@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
Message-ID: <202409230306.7OGURpiH-lkp@intel.com>
References: <20240920153706.919154-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920153706.919154-1-chen.dylane@gmail.com>

Hi Tao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Chen/bpf-Add-BPF_CALL_FUNC-to-simplify-code/20240920-233936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240920153706.919154-1-chen.dylane%40gmail.com
patch subject: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20240923/202409230306.7OGURpiH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409230306.7OGURpiH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409230306.7OGURpiH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/core.c:2010:36: error: called object type 'u8 *' (aka 'unsigned char *') is not a function or function pointer
                   BPF_R0 = BPF_CALL_FUNC(insn->imm)(BPF_R1, BPF_R2, BPF_R3,
                            ~~~~~~~~~~~~~~~~~~~~~~~~^
   kernel/bpf/core.c:2015:41: error: called object type 'u8 *' (aka 'unsigned char *') is not a function or function pointer
                   BPF_R0 = BPF_CALL_FUNC_ARGS(insn->imm)(BPF_R1, BPF_R2,
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/bpf/core.c:3079:
   In file included from include/linux/bpf_trace.h:5:
   In file included from include/trace/events/xdp.h:427:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:7:
>> include/linux/poll.h:136:27: warning: division by zero is undefined [-Wdivision-by-zero]
                   M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
                                           ^~~~~~~~~
   include/linux/poll.h:134:32: note: expanded from macro 'M'
   #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:120:51: note: expanded from macro '__MAP'
           (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
                                                            ^ ~~~~~~~~~
   include/linux/poll.h:136:39: warning: division by zero is undefined [-Wdivision-by-zero]
                   M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
                                                       ^~~~~~~~~
   include/linux/poll.h:134:32: note: expanded from macro 'M'
   #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:120:51: note: expanded from macro '__MAP'
           (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
                                                            ^ ~~~~~~~~~
   2 warnings and 2 errors generated.


vim +136 include/linux/poll.h

7a163b2195cda0 Al Viro 2018-02-01  131  
7a163b2195cda0 Al Viro 2018-02-01  132  static inline __poll_t demangle_poll(u16 val)
7a163b2195cda0 Al Viro 2018-02-01  133  {
7a163b2195cda0 Al Viro 2018-02-01  134  #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
7a163b2195cda0 Al Viro 2018-02-01  135  	return M(IN) | M(OUT) | M(PRI) | M(ERR) | M(NVAL) |
7a163b2195cda0 Al Viro 2018-02-01 @136  		M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
7a163b2195cda0 Al Viro 2018-02-01  137  		M(HUP) | M(RDHUP) | M(MSG);
7a163b2195cda0 Al Viro 2018-02-01  138  #undef M
7a163b2195cda0 Al Viro 2018-02-01  139  }
7a163b2195cda0 Al Viro 2018-02-01  140  #undef __MAP
7a163b2195cda0 Al Viro 2018-02-01  141  
7a163b2195cda0 Al Viro 2018-02-01  142  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


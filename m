Return-Path: <bpf+bounces-72293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32072C0BB40
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 03:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E589D3A9DAB
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 02:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E412D3A60;
	Mon, 27 Oct 2025 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOqoxVOW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08062D29CF;
	Mon, 27 Oct 2025 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533096; cv=none; b=ZuwDpZyIeAOZobN5+P0v4ImifBwzfQQbMsNK5rckAf+gIHGV0DHdtpVCsLfc0EoTn8G0FqAa02UZZ+dFM42XMIid+gprDxgGyKD5zfV/Z2uHGDsuLU56Lq4rIpNFbcr019jxnn7H/zvVmv30u2i7UyhvmP4+YLU95ElTaiMy//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533096; c=relaxed/simple;
	bh=I4/28CIASlVF1RVtFs3YmpM9lnmWITQDZRqQedU2Gwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPAc+WOuS0IZoQOGJh3ereEcNMuzyunfg5rCh6WMxZESSAUG8nBaDDJwOUwBeiqh2EhgOyJDhCBpdNbdkKVJ1Ya/u8ZAt300femnBTJrLXHIvUKTUyYoXk9gWwI8Vh4wWH32T+EyegjZufuyK6+rYMzHDFLx2m6zE8lsCMW5+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOqoxVOW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761533095; x=1793069095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4/28CIASlVF1RVtFs3YmpM9lnmWITQDZRqQedU2Gwk=;
  b=LOqoxVOW6jKk4LlZlsHNiACb7zo4MxjBgWDg5pBgKDzxSE/pfGuCV5uX
   E4GvIBMRnDtfgJkIKegklhbXokYqb5fEj14j6cbYdstHiYucDdx+9lgUF
   Q1R1SXFc1ZQC/4sRJqI6+JvzBMcu8iHDu+JBBblqc/BXf8H3Zbsg62dv+
   /q/Ebidl+SC6+n1R6dvN3GjSHtvOmwNdNlB7LYPB+Il3MlLjxp9JYgyhW
   kdVB/rE0wO/0NZ2FrwgtjOZkI7CC42eR2fRhpsFHUyKwZDnd8UVY0eex7
   BBj+SMATnYZVurQKNwx89n+oK6s7WmmF+z4yAooSduH2SuncXXWn1y48s
   w==;
X-CSE-ConnectionGUID: uX5DDFOgSGWnXTTOZ8yE2w==
X-CSE-MsgGUID: vsEtVKUbTC6ROcKCLX529g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74285879"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="74285879"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 19:44:54 -0700
X-CSE-ConnectionGUID: HlzfkQqbSTGFPsG03Ui8lQ==
X-CSE-MsgGUID: dsY0bqw5SGqOnb5Ykzf3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184824253"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Oct 2025 19:44:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDDDx-000GTN-2p;
	Mon, 27 Oct 2025 02:44:45 +0000
Date: Mon, 27 Oct 2025 10:44:19 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
	jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	leon.hwang@linux.dev, jiang.biao@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
Message-ID: <202510270955.mbxODFvZ-lkp@intel.com>
References: <20251026030143.23807-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026030143.23807-3-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-add-tracing-session-support/20251026-110720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251026030143.23807-3-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
config: i386-randconfig-061-20251027 (https://download.01.org/0day-ci/archive/20251027/202510270955.mbxODFvZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510270955.mbxODFvZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510270955.mbxODFvZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/bpf_trace.c:833:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr @@     got void * @@
   kernel/trace/bpf_trace.c:833:41: sparse:     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr
   kernel/trace/bpf_trace.c:833:41: sparse:     got void *
   kernel/trace/bpf_trace.c:3573:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3587:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3601:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3608:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3616:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3624:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:895:9: sparse: sparse: context imbalance in 'uprobe_prog_run' - unexpected unlock
>> kernel/trace/bpf_trace.c:3379:35: sparse: sparse: non size-preserving integer to pointer cast

vim +3379 kernel/trace/bpf_trace.c

  3372	
  3373	__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
  3374	{
  3375		/* This helper call is inlined by verifier. */
  3376		u64 nr_args = ((u64 *)ctx)[-1];
  3377	
  3378		/* ctx[nr_args + 2] is the session cookie address */
> 3379		return (u64 *)((u64 *)ctx)[nr_args + 2];
  3380	}
  3381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


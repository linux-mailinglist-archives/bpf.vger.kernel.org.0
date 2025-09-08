Return-Path: <bpf+bounces-67696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF414B484DC
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 09:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533B43AB8D9
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C72E3B15;
	Mon,  8 Sep 2025 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOALOs93"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A061547F2
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315712; cv=none; b=eyQvrnTruBDw/9qOOyJA/kVTXuTTxdkYhbmtMfAJlAv8elqFvrNH1wCeDXxXx7N5jANBkJBTeo3ao315gPDi2KdN/wG8Uj5kSbKpVPOJUUAz3JiF6zmrOrmc93XjABWxYP1+BN3Lz6D2LU4RieasfebFpO1o+BDsaw0jmA6P+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315712; c=relaxed/simple;
	bh=RYE2RVLWJPgkzL6TNpcgLWwtELPk2nT2TKu9RyZYI4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef2fWrM1s5QpqJHjm8F+lQo0/1AgUTtX4wIFHUKMLivMS92khbkdJ/ueC+a/H4M8EoXLCwK4n2UnrzbjD9E1DL/60rUQkgB/L+dAovSkrEo3CZY4Aidl37woxyWy1YE41C37zFBHBPWtfdPqUjHk9GgzKn9yThxmKpDvgaYeuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOALOs93; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757315710; x=1788851710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYE2RVLWJPgkzL6TNpcgLWwtELPk2nT2TKu9RyZYI4w=;
  b=iOALOs93uxX5LkttxeC75c4w6P7zfTWOnmMScGcpjAbhAkrRJK4Mc1bL
   tAqmgftE9v4598rO8S1f6Pj8WwTBzAOsr9mqxveNnqHM5ZS8Oh5nOF/kF
   5UxuaEitcBZhaBwnLA/vHvpDNQ92sXnpD3ivu9/FbzkVlnh/stoNwleXV
   g4llXFNyljVngrjBFqCBQ2WpUEegEqZcVzBI5cicQ3AyO7HlDHsykvPeN
   /P71XGJW+c4etkx5e+3YXPtoi/FnvPH9BVvgXrhVsubBxvQZRDzpdBdYg
   OiAoT7cP/ob5IseSyDrB3+zQ6HOpPAhkS+Coah45Oif5kflOzgHbI49Ls
   Q==;
X-CSE-ConnectionGUID: qxt1rj5sSN+vg9l3hhF9OA==
X-CSE-MsgGUID: B2a/sF+3Qoyw5CM28nYw2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="58779307"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="58779307"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:15:08 -0700
X-CSE-ConnectionGUID: ScFNDBXkRXS0mDxxN1zmBA==
X-CSE-MsgGUID: +am4mPH0Qvy8IkzcHnQB3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="172832137"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Sep 2025 00:15:03 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvW5c-0003cV-0F;
	Mon, 08 Sep 2025 07:15:00 +0000
Date: Mon, 8 Sep 2025 15:14:18 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, djwillia@vt.edu, miloc@vt.edu, ericts@vt.edu,
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu,
	jinghao7@illinois.edu, sidchintamaneni@gmail.com, memxor@gmail.com,
	egor@vt.edu, sairoop10@gmail.com, rjsu26@gmail.com
Subject: Re: [PATCH 3/4] bpf: runtime part of fast-path termination approach
Message-ID: <202509081431.PcY1azAC-lkp@intel.com>
References: <20250907230415.289327-4-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907230415.289327-4-sidchintamaneni@gmail.com>

Hi Siddharth,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.17-rc5 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Chintamaneni/bpf-Introduce-new-structs-and-struct-fields-for-fast-path-termination/20250908-070655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250907230415.289327-4-sidchintamaneni%40gmail.com
patch subject: [PATCH 3/4] bpf: runtime part of fast-path termination approach
config: sh-randconfig-001-20250908 (https://download.01.org/0day-ci/archive/20250908/202509081431.PcY1azAC-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250908/202509081431.PcY1azAC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509081431.PcY1azAC-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/watchdog.c: In function 'is_softlockup':
>> kernel/watchdog.c:709:25: error: implicit declaration of function 'bpf_softlockup'; did you mean 'is_softlockup'? [-Wimplicit-function-declaration]
     709 |                         bpf_softlockup(now - touch_ts);
         |                         ^~~~~~~~~~~~~~
         |                         is_softlockup


vim +709 kernel/watchdog.c

   678	
   679	static int is_softlockup(unsigned long touch_ts,
   680				 unsigned long period_ts,
   681				 unsigned long now)
   682	{
   683		if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
   684			/*
   685			 * If period_ts has not been updated during a sample_period, then
   686			 * in the subsequent few sample_periods, period_ts might also not
   687			 * be updated, which could indicate a potential softlockup. In
   688			 * this case, if we suspect the cause of the potential softlockup
   689			 * might be interrupt storm, then we need to count the interrupts
   690			 * to find which interrupt is storming.
   691			 */
   692			if (time_after_eq(now, period_ts + get_softlockup_thresh() / NUM_SAMPLE_PERIODS) &&
   693			    need_counting_irqs())
   694				start_counting_irqs();
   695	
   696			/*
   697			 * A poorly behaving BPF scheduler can live-lock the system into
   698			 * soft lockups. Tell sched_ext to try ejecting the BPF
   699			 * scheduler when close to a soft lockup.
   700			 */
   701			if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
   702				scx_softlockup(now - touch_ts);
   703	
   704			/*
   705			 * Long running BPF programs can cause CPU's to stall.
   706			 * So trigger fast path termination to terminate such BPF programs.
   707			 */
   708			if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
 > 709				bpf_softlockup(now - touch_ts);
   710	
   711			/* Warn about unreasonable delays. */
   712			if (time_after(now, period_ts + get_softlockup_thresh()))
   713				return now - touch_ts;
   714		}
   715		return 0;
   716	}
   717	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


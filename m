Return-Path: <bpf+bounces-43705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA49B8A56
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 06:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177032825F0
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 05:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3214D2AC;
	Fri,  1 Nov 2024 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaOATas0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9A14A0BC;
	Fri,  1 Nov 2024 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730437701; cv=none; b=Xwzzb2zi4kmFTGGeDPgfEAi2NJTtVijwWMerCnHEgp+RqMCIIpXeYfadeuK02Eiwt+vvX3H1BY/iomKQJkVmv0H8jfdHBjoHRMvU6Xs7E2O0pA5HuD/cZcTlEJovenGuCNL9lr2nak2oqAXjFGYacZ83kLv2MXU0m2huNenmQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730437701; c=relaxed/simple;
	bh=8SH462tRl1ZiRba7df8oxrR+WHg6RradtW1LrPlpN5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okjaPaotKelQMuyA873tNWL4LdfhjLT2ZxHCefxYRbw8sQodO17fb8DyeLGsrkpLvnOeUyml0cmH2lKVQpl2BeumaXXM7VEtdf4bCV0Wt05C/2+Fi+Vjjq2YtSHmHWXpTO98NYo5x0qcJjbpI6dQegfUUl7RrGtiQKAwfaDbdgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaOATas0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730437696; x=1761973696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8SH462tRl1ZiRba7df8oxrR+WHg6RradtW1LrPlpN5g=;
  b=iaOATas0GJ55cEdaEEWL8Ilz4ISwqsIkInhKb6z5mVcda+hvi35v+Ze4
   x5vfVY3TL9XAH8eZmK547++ZAQA8YJgr4Qq35d8MkSRISwj5GuIeQJ3R7
   uKpHUOOJZ9PErWC60qrq/XGG2Y6whNdMaQodOoSMGewoG9O5FaHpuZDKj
   p2edpr6TW2SA2o5Y44t6kE34rhrz0HOm42YhLGlMZfftB6vieqj18dOBX
   S01dD1BkSySsoSUGax18cPC0b9BvE9Ca1H66UPyssRskN9UiHHqUg919a
   sGsw4lBWpUyPn17ljCDElyypmgP3P4VHkdADB3VDYz+txS9DugDGX3KYv
   w==;
X-CSE-ConnectionGUID: Y2TYe3xWSCWD0H1VmttsYA==
X-CSE-MsgGUID: f7srbjvJQSewRklnJaPOYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30091594"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="30091594"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 22:08:12 -0700
X-CSE-ConnectionGUID: YNeG/ygnRBKH4IH17vYYxA==
X-CSE-MsgGUID: vgt1ChFDSCW5UHlS1VUnLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="120315136"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2024 22:08:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6jtF-000h9p-2p;
	Fri, 01 Nov 2024 05:08:05 +0000
Date: Fri, 1 Nov 2024 13:07:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, paulmck@kernel.org,
	jrife@google.com, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for
 sleepable raw tracepoint BPF links
Message-ID: <202411011258.IemsLYSp-lkp@intel.com>
References: <20241031210938.1696639-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031210938.1696639-3-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-decouple-BPF-link-attach-hook-and-BPF-program-sleepable-semantics/20241101-051131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20241031210938.1696639-3-andrii%40kernel.org
patch subject: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for sleepable raw tracepoint BPF links
config: i386-buildonly-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241101/202411011258.IemsLYSp-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411011258.IemsLYSp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411011258.IemsLYSp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/syscall.c:4:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/bpf/syscall.c:3866:5: error: call to undeclared function 'tracepoint_is_faultable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3866 |                                 tracepoint_is_faultable(btp->tp));
         |                                 ^
   kernel/bpf/syscall.c:5876:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5876 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/syscall.c:5926:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5926 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   3 warnings and 1 error generated.


vim +/tracepoint_is_faultable +3866 kernel/bpf/syscall.c

  3818	
  3819	static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
  3820					  const char __user *user_tp_name, u64 cookie)
  3821	{
  3822		struct bpf_link_primer link_primer;
  3823		struct bpf_raw_tp_link *link;
  3824		struct bpf_raw_event_map *btp;
  3825		const char *tp_name;
  3826		char buf[128];
  3827		int err;
  3828	
  3829		switch (prog->type) {
  3830		case BPF_PROG_TYPE_TRACING:
  3831		case BPF_PROG_TYPE_EXT:
  3832		case BPF_PROG_TYPE_LSM:
  3833			if (user_tp_name)
  3834				/* The attach point for this category of programs
  3835				 * should be specified via btf_id during program load.
  3836				 */
  3837				return -EINVAL;
  3838			if (prog->type == BPF_PROG_TYPE_TRACING &&
  3839			    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
  3840				tp_name = prog->aux->attach_func_name;
  3841				break;
  3842			}
  3843			return bpf_tracing_prog_attach(prog, 0, 0, 0);
  3844		case BPF_PROG_TYPE_RAW_TRACEPOINT:
  3845		case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
  3846			if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
  3847				return -EFAULT;
  3848			buf[sizeof(buf) - 1] = 0;
  3849			tp_name = buf;
  3850			break;
  3851		default:
  3852			return -EINVAL;
  3853		}
  3854	
  3855		btp = bpf_get_raw_tracepoint(tp_name);
  3856		if (!btp)
  3857			return -ENOENT;
  3858	
  3859		link = kzalloc(sizeof(*link), GFP_USER);
  3860		if (!link) {
  3861			err = -ENOMEM;
  3862			goto out_put_btp;
  3863		}
  3864		bpf_link_init_sleepable(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
  3865					&bpf_raw_tp_link_lops, prog,
> 3866					tracepoint_is_faultable(btp->tp));
  3867		link->btp = btp;
  3868		link->cookie = cookie;
  3869	
  3870		err = bpf_link_prime(&link->link, &link_primer);
  3871		if (err) {
  3872			kfree(link);
  3873			goto out_put_btp;
  3874		}
  3875	
  3876		err = bpf_probe_register(link->btp, link);
  3877		if (err) {
  3878			bpf_link_cleanup(&link_primer);
  3879			goto out_put_btp;
  3880		}
  3881	
  3882		return bpf_link_settle(&link_primer);
  3883	
  3884	out_put_btp:
  3885		bpf_put_raw_tracepoint(btp);
  3886		return err;
  3887	}
  3888	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


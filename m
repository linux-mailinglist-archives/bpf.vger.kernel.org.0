Return-Path: <bpf+bounces-43703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0079B8A51
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 06:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2122282609
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119514A098;
	Fri,  1 Nov 2024 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pna30I00"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772A13DDB5;
	Fri,  1 Nov 2024 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730437695; cv=none; b=QMIYvMXzymYB1NYZU9TinSqBwmEccHmZu2+al/jCFks40AQXOcnbegEUksDfiz0hV4O9vxG7xhsw1mOuLMYEWP9Vq1gj0NjmVbOf/EjhqjSY1CVL0lUwtGDlzOJEw3ouaIUMW7hZKYqPk/jn6NkuxzYf4OLPSFAhRFnALUGBFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730437695; c=relaxed/simple;
	bh=gHCvEzqGz5HrCXCX8obbMOpf4rX8W8+whNsK2k2oVnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbUdOaM6lczdv1OGcpGvSbOf0DT8sIjz9Kg+HULZ3tcmQivXIIpVPKQurfzn/gOwyrQyqnG4bIQmkMy5WHOb4vB/UBCaQ5DhXXzLgO+TiMHt4Kt4vtuQv9Vja6E6YQRRJsEUL5BKyWRzz8kuaEU3bkZkS+XOHkgoYQfrMkK3yGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pna30I00; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730437693; x=1761973693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gHCvEzqGz5HrCXCX8obbMOpf4rX8W8+whNsK2k2oVnA=;
  b=Pna30I00qwvxsgjCJ2ZGBz+MG/NgTSVx3NohWr0yOeYSsdXLVKujurCF
   k3l2lfYt0v8FvanclCFF8xULDL7g5MBcKvaRgNzZIxYppy3MezPmb0Yhv
   w3+8Xh9gm1BoFrgvthipX1tjO2rjxSCeeaVQdVkxU0MI+DYsmSqF/LeB9
   Rpx2p4tlsCaHas8PB1v3dq9XUOcGVF9DYJxgzdLcLlZ5uk/TdKN+gLh2r
   Ndopcg7M5v8b4SzPdG19+ZjarX338RepY9ScYbv5DgO7wa/B0RGu/ue6z
   ec1SispCpggw83Q7sfVw8qjb8y9wDCZy8QyL8Fy/aROtXZl3FWz7xJsVK
   Q==;
X-CSE-ConnectionGUID: PXeyCiwUTDqCysut5AJ0sQ==
X-CSE-MsgGUID: ZSxb6Eq1TAeezMRaooTtgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30091580"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="30091580"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 22:08:12 -0700
X-CSE-ConnectionGUID: VVyBlTPCQpCKxcFXEHZ3sw==
X-CSE-MsgGUID: kOLQEgr2QummUPom66znnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="120315134"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2024 22:08:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6jtF-000h9t-30;
	Fri, 01 Nov 2024 05:08:05 +0000
Date: Fri, 1 Nov 2024 13:07:08 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, paulmck@kernel.org, jrife@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for
 sleepable raw tracepoint BPF links
Message-ID: <202411011255.GYntOfN5-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241101/202411011255.GYntOfN5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411011255.GYntOfN5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411011255.GYntOfN5-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_raw_tp_link_attach':
>> kernel/bpf/syscall.c:3866:33: error: implicit declaration of function 'tracepoint_is_faultable' [-Werror=implicit-function-declaration]
    3866 |                                 tracepoint_is_faultable(btp->tp));
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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


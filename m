Return-Path: <bpf+bounces-57722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0EAAF12F
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 04:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7843D4A4232
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 02:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13A1DE3D2;
	Thu,  8 May 2025 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAwWNS7s"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A41F94A;
	Thu,  8 May 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671838; cv=none; b=pfpF83fWYl9rWliJSmd8D2PE6Z+9FD4odh4kwplXENRBSd+qxf+y6tKyUBEAAgr2GXYXhxOPPCl01/HIYA0IMat22ZaZwE85nbZ3OM6wsVXo3X74CPFKSmkwR/N6kSpyQZjy0c84uWYda0WyQ6JBXg0qwr2hxfABRNsEi7ZG478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671838; c=relaxed/simple;
	bh=lbcruhGKAWZRzOTb1H0zOgqukDxfRer4cbf00zWqjV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue97GE+NtTyMND6h4w8laZOFldOap7nBloK3dgN4+SzC9ZpiC3NqSyACSXqiKmH/rasDxou9LRzCLbQ+wjYcXhN+AWCin9CbujsP7yBSjbLjdjXM7od9DzsVHu3Y6wuxL0KMUZBkJHr4KIyDfloR63aLyeYYb9DWLCoD7RqSeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAwWNS7s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746671833; x=1778207833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbcruhGKAWZRzOTb1H0zOgqukDxfRer4cbf00zWqjV0=;
  b=LAwWNS7sIUaNQ7Rgko+Lmn7IPxbOgNCzUD8BvavfY/zLkKsZh/vT87jl
   Ui4MRXvZSi4Vf1i4pw3RfbBBw5Cextq1ZMCBvYw8pt+TeoFiaokh86VlX
   IP4E3XJ5krHnbTujTaziypAkxl96tfi1qB0wxnsxaqJZXrBtf9lkfBFSQ
   OMOKh9bEqIna5rvFWLERzo6tMOmkr3rw4IuhTx5O8vfe3UOJUXP3KkDbY
   aUJniCIE4BgB7TcjmMrx2COF0Jf78KRRq9a1zpCNUtkN0pFdQM96l4O3B
   tUJxYTVQfoNAFy2RZ+pXM3dpKEGig6Whb9RnyojI67b4QzH5hylILSk6m
   Q==;
X-CSE-ConnectionGUID: wADH9SPRQPqzikYFC3nOEA==
X-CSE-MsgGUID: PHkSmGpCTSmZ+FalOkg7og==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59095160"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59095160"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:37:12 -0700
X-CSE-ConnectionGUID: I+QNqCn1Sf+Wre8qqSyiGA==
X-CSE-MsgGUID: L40G57OYRHOWr/ji854nug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136084715"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2025 19:37:06 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCr8C-0009Sh-08;
	Thu, 08 May 2025 02:37:04 +0000
Date: Thu, 8 May 2025 10:36:59 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
	vger.kernel.org@web.codeaurora.org
Cc: oe-kbuild-all@lists.linux.dev, Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH bpf-next v4 2/2] bpf: Move the BPF net tracepoint
 definitions to net directory
Message-ID: <202505081003.T2Tv4puD-lkp@intel.com>
References: <20250506025131.136929-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506025131.136929-2-jiayuan.chen@linux.dev>

Hi Jiayuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiayuan-Chen/bpf-Move-the-BPF-net-tracepoint-definitions-to-net-directory/20250506-150437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250506025131.136929-2-jiayuan.chen%40linux.dev
patch subject: [RESEND PATCH bpf-next v4 2/2] bpf: Move the BPF net tracepoint definitions to net directory
config: arc-defconfig (https://download.01.org/0day-ci/archive/20250508/202505081003.T2Tv4puD-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081003.T2Tv4puD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081003.T2Tv4puD-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-linux-ld: net/core/dev.o: in function `netif_receive_generic_xdp':
>> dev.c:(.text+0xb3b4): undefined reference to `__tracepoint_xdp_exception'
>> arc-linux-ld: dev.c:(.text+0xb3b4): undefined reference to `__tracepoint_xdp_exception'
>> arc-linux-ld: dev.c:(.text+0xb3e8): undefined reference to `__traceiter_xdp_exception'
>> arc-linux-ld: dev.c:(.text+0xb3e8): undefined reference to `__traceiter_xdp_exception'
   arc-linux-ld: net/core/dev.o: in function `generic_xdp_tx':
   dev.c:(.text+0xb488): undefined reference to `__tracepoint_xdp_exception'
   arc-linux-ld: dev.c:(.text+0xb488): undefined reference to `__tracepoint_xdp_exception'
   arc-linux-ld: dev.c:(.text+0xb4c4): undefined reference to `__tracepoint_xdp_exception'
   arc-linux-ld: dev.c:(.text+0xb4c4): undefined reference to `__tracepoint_xdp_exception'
   arc-linux-ld: dev.c:(.text+0xb594): undefined reference to `__traceiter_xdp_exception'
   arc-linux-ld: dev.c:(.text+0xb594): undefined reference to `__traceiter_xdp_exception'
   arc-linux-ld: net/core/filter.o: in function `__do_trace_xdp_redirect_err':
>> filter.c:(.text+0x6f88): undefined reference to `__traceiter_xdp_redirect_err'
>> arc-linux-ld: filter.c:(.text+0x6f88): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: net/core/filter.o: in function `xdp_do_redirect_frame':
>> filter.c:(.text+0xc45e): undefined reference to `__tracepoint_xdp_redirect_err'
>> arc-linux-ld: filter.c:(.text+0xc45e): undefined reference to `__tracepoint_xdp_redirect_err'
>> arc-linux-ld: filter.c:(.text+0xc490): undefined reference to `__tracepoint_xdp_redirect'
>> arc-linux-ld: filter.c:(.text+0xc490): undefined reference to `__tracepoint_xdp_redirect'
>> arc-linux-ld: filter.c:(.text+0xc500): undefined reference to `__traceiter_xdp_redirect'
>> arc-linux-ld: filter.c:(.text+0xc500): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xc55a): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc55a): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc594): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc594): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: net/core/filter.o: in function `xdp_do_redirect':
   filter.c:(.text+0xc682): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc682): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc6ba): undefined reference to `__tracepoint_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xc6ba): undefined reference to `__tracepoint_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xc734): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xc734): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xc7d6): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc7d6): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc810): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xc810): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: net/core/filter.o: in function `xdp_do_generic_redirect':
   filter.c:(.text+0xd326): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd326): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd3a4): undefined reference to `__tracepoint_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd3a4): undefined reference to `__tracepoint_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd3ea): undefined reference to `__tracepoint_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd3ea): undefined reference to `__tracepoint_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd454): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd454): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd4b2): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd4b2): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd4ec): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd4ec): undefined reference to `__tracepoint_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd532): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd532): undefined reference to `__traceiter_xdp_redirect_err'
   arc-linux-ld: filter.c:(.text+0xd594): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: filter.c:(.text+0xd594): undefined reference to `__traceiter_xdp_redirect'
   arc-linux-ld: net/core/xdp.o: in function `xdp_rxq_info_reg_mem_model':
>> xdp.c:(.text+0x58e): undefined reference to `__tracepoint_mem_connect'
>> arc-linux-ld: xdp.c:(.text+0x58e): undefined reference to `__tracepoint_mem_connect'
>> arc-linux-ld: xdp.c:(.text+0x5d2): undefined reference to `__traceiter_mem_connect'
>> arc-linux-ld: xdp.c:(.text+0x5d2): undefined reference to `__traceiter_mem_connect'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


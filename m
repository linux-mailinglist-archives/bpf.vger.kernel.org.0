Return-Path: <bpf+bounces-37351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189595414D
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 07:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE6A285969
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 05:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8078005B;
	Fri, 16 Aug 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAAvv3vA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14903C24;
	Fri, 16 Aug 2024 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787152; cv=none; b=GbYZckejMck9Iwo0ZIpeWhUlpRjli49DQ84f3Xqr4h5l/JXCmMFzojrBaGJl68H9GJIyElApvUBgUeH54jPaV32lzNAqHGBgKB8l6y8n2JJX7hKVPqZljrMYs2FaIN00+4xVIVYHAqr0Z/tVf6H8LJxyC+ONpbjbPJgvAEP08wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787152; c=relaxed/simple;
	bh=5seieGYLmbA90NpyoiI/UcDh1TfyaAxPOaZ9VCPNLLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9hIovEBIcw2rddLDTQDBSc4xg3W68XgwDokqdkxgsEJ9/tg/CUZlWLtSrfQbVgFWd4652N5LUEm7OVh3FfC2ZCfm/wGc9/OfVSltTDybcyNEwExuZ0z5V7Ts572N4VkUrjch7zG5n8HbAOj/6Ed3A4PW+RwyyrtcxgDo78ex2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAAvv3vA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723787150; x=1755323150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5seieGYLmbA90NpyoiI/UcDh1TfyaAxPOaZ9VCPNLLQ=;
  b=DAAvv3vAPm3CXnPJjG7Avnr7ahB/YPlerXw4jC1Kiohc5lzJMXIsV2zS
   B7xUEV78/0s1VxkEuYCX7HLqdEhXbaiowF2ljq+pGfHgu3I5NXrfTy3Vb
   kOZvjUeNQEgVqAbSPpBgyxuR1N9bdRis2j1oSC4QrCOa7sM8tyCNlvyu8
   Pp5wU9iDPJ/eCPKb32Ooj9a8Mcid+wZaCLSM+QxLRnw/j+ahKShhRhJkt
   0B2os4ge9fSlE1yc+XWvQjlyWuJrF8YuORnt2zyXfDkWJxcUmjtpDUjYO
   gfXNuVNAv3/VAuBar0IEwDOJC5rYW6qtHGaHvwtz1ESy429SjnYLkxJVX
   Q==;
X-CSE-ConnectionGUID: ZViWfc1fS7Sp/BK7IL9luA==
X-CSE-MsgGUID: 9J9sZzQsTv6gW5MMEbdvvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25872745"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="25872745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:45:49 -0700
X-CSE-ConnectionGUID: lfSsCFwWRk2AQj11KnsSuQ==
X-CSE-MsgGUID: eyAXFNBhRPmlaKlfnpYbag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64251228"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2024 22:45:46 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sepmR-00063K-32;
	Fri, 16 Aug 2024 05:45:43 +0000
Date: Fri, 16 Aug 2024 13:45:36 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Croce <technoboy85@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: allow
 bpf_current_task_under_cgroup() with BPF_CGROUP_*
Message-ID: <202408161356.OvFB1jZi-lkp@intel.com>
References: <20240813132831.184362-3-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813132831.184362-3-technoboy85@gmail.com>

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Croce/bpf-enable-generic-kfuncs-for-BPF_CGROUP_-programs/20240815-000517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240813132831.184362-3-technoboy85%40gmail.com
patch subject: [PATCH bpf-next v5 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
config: i386-buildonly-randconfig-002-20240816 (https://download.01.org/0day-ci/archive/20240816/202408161356.OvFB1jZi-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408161356.OvFB1jZi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408161356.OvFB1jZi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_current_task_under_cgroup_proto
   >>> referenced by bpf_trace.c
   >>>               kernel/trace/bpf_trace.o:(bpf_tracing_func_proto) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


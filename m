Return-Path: <bpf+bounces-51581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA4A364EA
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1BF1704C2
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9326869A;
	Fri, 14 Feb 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9ZJ/z3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F5264A80;
	Fri, 14 Feb 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555097; cv=none; b=gxl2c5Ts90yk/t22ixDGMHPtVuE9j3IBEFmqVqyhahEifcXghhWGWRNYHE9/1HQJvd2yZYu02d5rdZpVrilVJdAu6Ms5z1m2g/dI8FOQ3Zi3X+ej+ZTNMo5cU0FBou8JXVREYWP6yFd7heo736mGws1gOqPTcU48EZQV5DeG2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555097; c=relaxed/simple;
	bh=6Eca5RyitApw05FUFqqK/KWjakVHSZsOTM1AmVXS3d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7i7jEQVidbXF3CmGZa1liYuJr3w48c/2CPch914qsMi+aHIlonwGOQoMkVk8Vus4kwVbBNuZyVW8I83NHpRQK+Ex9P0oVx0LbZ4pFK7NHo71X/l10gdHFoISsJRG6t5nGNQCU6iJYbvzkgwJfHaT4r45tzGwwE++9Q2xTAsDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9ZJ/z3Y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739555096; x=1771091096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Eca5RyitApw05FUFqqK/KWjakVHSZsOTM1AmVXS3d8=;
  b=P9ZJ/z3YbZsgNvy/BS7qJUk7iKj6NfNZdZA7Lxc4lsMn7j/qRx8LbXoO
   IfWxjIDGD0w+w2gQeDKKTMEKgBMxP2T4CcRBkhYe7SDm94nsHJ/yesKA8
   F57ASlopWnm4allFKfI23ahoL1IZodkHQQ7Ip/w9a2oCoXi3SSAJ1iGPp
   pClvAnKK84ppoaPp0NmpqpUPHK7lK/pLI9huGVCM9jwF4gscjFZtCNEqg
   Vqi0UquZ1oZaDMMvZ5H8C3n+Uo9B3Kbo1cjNvkcjg+gV0ayNYnLKhdl7/
   uuysONniyjDRDzmxad+L78bdMcAG3z0uYE9kMwaZntk9XLWtm/9kTd9Bk
   Q==;
X-CSE-ConnectionGUID: n5iFMGgSRny+AKcF4oNOxA==
X-CSE-MsgGUID: N9oa5BvaQZuhn3F0I+9+kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40436460"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40436460"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:44:56 -0800
X-CSE-ConnectionGUID: KbW0p+xJQIqTIKcUKoDtlA==
X-CSE-MsgGUID: ErbVLeP0RVi7Qm1a7RvF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118720615"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2025 09:44:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tizk8-0019yJ-1X;
	Fri, 14 Feb 2025 17:44:48 +0000
Date: Sat, 15 Feb 2025 01:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: zhangmingyi <zhangmingyi5@huawei.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com,
	wuchangye@huawei.com, xiesongyang@huawei.com, liuxin350@huawei.com,
	liwei883@huawei.com, tianmuyang@huawei.com, zhangmingyi5@huawei.com
Subject: Re: [PATCH v2 2/2] bpf-next: selftest for TCP_ULP in bpf_setsockopt
Message-ID: <202502150104.1LKDPqiq-lkp@intel.com>
References: <20250210134550.3189616-3-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210134550.3189616-3-zhangmingyi5@huawei.com>

Hi zhangmingyi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master mptcp/export mptcp/export-net linus/master v6.14-rc2 next-20250214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhangmingyi/bpf-next-Introduced-to-support-the-ULP-to-get-or-set-sockets/20250210-215203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250210134550.3189616-3-zhangmingyi5%40huawei.com
patch subject: [PATCH v2 2/2] bpf-next: selftest for TCP_ULP in bpf_setsockopt
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502150104.1LKDPqiq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502150104.1LKDPqiq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/setget_sockopt_tcp_ulp.c:18:42: error: use of undeclared identifier 'TCP_ULP'; did you mean 'MCP_UC'?
      18 |                 if (bpf_setsockopt(skops, IPPROTO_TCP, TCP_ULP, (void *)target_ulp,
         |                                                        ^~~~~~~
         |                                                        MCP_UC
   tools/testing/selftests/bpf/tools/include/vmlinux.h:18434:2: note: 'MCP_UC' declared here
    18434 |         MCP_UC = 2,
          |         ^
   progs/setget_sockopt_tcp_ulp.c:22:42: error: use of undeclared identifier 'TCP_ULP'; did you mean 'MCP_UC'?
      22 |                 if (bpf_getsockopt(skops, IPPROTO_TCP, TCP_ULP, verify_ulp,
         |                                                        ^~~~~~~
         |                                                        MCP_UC
   tools/testing/selftests/bpf/tools/include/vmlinux.h:18434:2: note: 'MCP_UC' declared here
    18434 |         MCP_UC = 2,
          |         ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


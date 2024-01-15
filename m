Return-Path: <bpf+bounces-19517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE882D304
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 02:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC7281383
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 01:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7215D2;
	Mon, 15 Jan 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGBFKL/H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8A15BB
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705283584; x=1736819584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYSJF6uKXxWA485j7DE4t04OoFie020Ucfz+jr82W7A=;
  b=HGBFKL/HojqiryNPYkpl2Q9PBy53IwRrdbaPFKfZiW9+6NETQ07aEIvX
   rIsYV5q7nA1wLq6tA9C4UC7l/5Wa2optVFrhfhygtAZYBp6ocuMhK/mKN
   edubCSjVYwZY0fKxsDOFO6c7Bfhtd8kukzcU035N2iakkhIjYRzUvhCve
   FR9FWjMbPKKoeLG3y2HL9J/fvKnjl+9s3yttLEZJpPB121jfqgPvQGotH
   R9YPcDYtTfqEZtWisxlUA7so4mXYR0df1kkQsTpDBF21Pe4NcVw8wpvYN
   3jvgxMyyxWsD3PwNVn8ncOtm1MLTfsEofhe7t0A3do5XtYpw1/aZejymo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6234615"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6234615"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="956690704"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="956690704"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2024 17:52:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPC9g-000Bzu-1q;
	Mon, 15 Jan 2024 01:52:51 +0000
Date: Mon, 15 Jan 2024 09:52:17 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tj@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpumask
 iter
Message-ID: <202401150914.Rcl50Ct9-lkp@intel.com>
References: <20240110060037.4202-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110060037.4202-3-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-Add-bpf_iter_cpumask-kfuncs/20240110-140322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240110060037.4202-3-laoar.shao%40gmail.com
patch subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpumask iter
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240115/202401150914.Rcl50Ct9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401150914.Rcl50Ct9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/test_cpumask_iter.c:20:21: error: use of undeclared identifier 'NR_PSI_TASK_COUNTS'
      20 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
         |                            ^
>> progs/test_cpumask_iter.c:41:2: error: assigning to 'u32 *' (aka 'unsigned int *') from 'int *' converts between pointers to integer types with different sign [-Werror,-Wpointer-sign]
      41 |         bpf_for_each(cpumask, cpu, &mask->cpumask) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tools/include/bpf/bpf_helpers.h:348:10: note: expanded from macro 'bpf_for_each'
     348 |         (((cur) = bpf_iter_##type##_next(&___it)));                                             \
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> progs/test_cpumask_iter.c:51:55: error: incomplete definition of type 'struct psi_group_cpu'
      51 |                 bpf_probe_read_kernel(&tasks, sizeof(tasks), &groupc->tasks);
         |                                                               ~~~~~~^
   progs/test_cpumask_iter.c:11:21: note: forward declaration of 'struct psi_group_cpu'
      11 | extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
         |                     ^
>> progs/test_cpumask_iter.c:52:27: error: use of undeclared identifier 'NR_RUNNING'; did you mean 'T_RUNNING'?
      52 |                 psi_nr_running += tasks[NR_RUNNING];
         |                                         ^~~~~~~~~~
         |                                         T_RUNNING
   /tools/include/vmlinux.h:11216:3: note: 'T_RUNNING' declared here
    11216 |                 T_RUNNING = 0,
          |                 ^
   4 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


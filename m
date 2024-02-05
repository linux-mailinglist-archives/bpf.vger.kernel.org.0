Return-Path: <bpf+bounces-21193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC98492A9
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 04:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FB1C21F1C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BC79D8;
	Mon,  5 Feb 2024 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VF8+4Ndm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBD8F51
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102555; cv=none; b=qYaFQ8Wb+uq+CHQeq+eGJheoW7FLZ2Okg5geJYcAds+99Isij9PzGy7xFwQVloWj2PGRYYORNAAAmNdezMTCOwIPMlrDvwfJoE6Su0aJEZ6QN6YrOyQbntn7z+wDgyTGvRDx66NC/ByrquVUTU5JBaSPTpIJ2aN2TUeXRHRZ1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102555; c=relaxed/simple;
	bh=SZyMPSgOZ56GBwOPXTzYASZ88ieNjvabixYu2gwArKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip8O3T1oZj14C8ThdZ1F/+6V/Hu1gCln4ydpUFy8wMfU1AII/MT82rb8Fs2Wvmug6o4mZa8NzNNWn7ipwVgsXvUvOPU70HPHrKq7uc4aHfduhIA7uBRA9EO1Oq0j3twcnfHsUg1UHz8lWZwc6qvmxL3qzPTW1WeCtzf4Ozcrp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VF8+4Ndm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707102554; x=1738638554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SZyMPSgOZ56GBwOPXTzYASZ88ieNjvabixYu2gwArKk=;
  b=VF8+4NdmAKsZxqipvNXPwm24/GtlsSfDipfWLuePTFxgOUaWGdfXUfj6
   t3JHKTP8FEAsOTJ5JIgB50WGS70EZk1VCdLsSI22dpVkXGtM5Hxf8nacN
   LNvtV4LA89m+Tqb9gi8/OpTg91Lt8CtfL/6LmOiDUN6kFAd1fT9Mtc26v
   p50JuLv6ph2jrh5MlnAOF/+XsuwBmabpWa1qFVUvNQHTmbs2Wvs+ulMD+
   jRydXcGIbQ2Sq92xcET8xt9m/x3t+Do6yuPGgmYTTh446cJtTtNa4H3WZ
   7QBlNBpVL/b67A/qJA3gwSvPkJdkx5H92x7cKymxXLDwb1kvDMBQjF3Lu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="594811"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="594811"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 19:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="895179"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Feb 2024 19:09:10 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWpM3-00006K-2p;
	Mon, 05 Feb 2024 03:09:07 +0000
Date: Mon, 5 Feb 2024 11:08:39 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tj@kernel.org, void@manifault.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask
 iter
Message-ID: <202402051121.y4w06atm-lkp@intel.com>
References: <20240131145454.86990-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131145454.86990-5-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-Add-bpf_iter_cpumask-kfuncs/20240131-232406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240131145454.86990-5-laoar.shao%40gmail.com
patch subject: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240205/202402051121.y4w06atm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402051121.y4w06atm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/cpumask_iter_success.c:61:2: error: incomplete definition of type 'struct psi_group_cpu'
      61 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   progs/cpumask_iter_success.c:39:27: note: expanded from macro 'READ_PERCPU_DATA'
      39 |                 psi_nr_running += groupc->tasks[NR_RUNNING];                                    \
         |                                   ~~~~~~^
   progs/cpumask_iter_success.c:13:21: note: forward declaration of 'struct psi_group_cpu'
      13 | extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
         |                     ^
>> progs/cpumask_iter_success.c:61:2: error: use of undeclared identifier 'NR_RUNNING'; did you mean 'T_RUNNING'?
      61 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
         |         ^
   progs/cpumask_iter_success.c:39:35: note: expanded from macro 'READ_PERCPU_DATA'
      39 |                 psi_nr_running += groupc->tasks[NR_RUNNING];                                    \
         |                                                 ^
   /tools/include/vmlinux.h:28263:3: note: 'T_RUNNING' declared here
    28263 |                 T_RUNNING = 0,
          |                 ^
   progs/cpumask_iter_success.c:80:2: error: incomplete definition of type 'struct psi_group_cpu'
      80 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   progs/cpumask_iter_success.c:39:27: note: expanded from macro 'READ_PERCPU_DATA'
      39 |                 psi_nr_running += groupc->tasks[NR_RUNNING];                                    \
         |                                   ~~~~~~^
   progs/cpumask_iter_success.c:13:21: note: forward declaration of 'struct psi_group_cpu'
      13 | extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
         |                     ^
   progs/cpumask_iter_success.c:80:2: error: use of undeclared identifier 'NR_RUNNING'; did you mean 'T_RUNNING'?
      80 |         READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
         |         ^
   progs/cpumask_iter_success.c:39:35: note: expanded from macro 'READ_PERCPU_DATA'
      39 |                 psi_nr_running += groupc->tasks[NR_RUNNING];                                    \
         |                                                 ^
   /tools/include/vmlinux.h:28263:3: note: 'T_RUNNING' declared here
    28263 |                 T_RUNNING = 0,
          |                 ^
   4 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


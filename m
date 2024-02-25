Return-Path: <bpf+bounces-22707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE643862C97
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6082819B4
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94818E28;
	Sun, 25 Feb 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="at1nw81u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77318641
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708889995; cv=none; b=dqtzGHP7KNohWtAfuQbmFm+kTCckt3n50w/NyVeEF/NcmnbHJxYPduCBx0FWY7M3KMcDdFwBAlyHKS6MSxSOJr/m7vnRZ9sIolOPhalfSJYWKaTethVXRl2vj8rdRY5lWvC1YLQdMH4WaM8fNKmEjHlVp6o7bZzkp7DRQv4+P+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708889995; c=relaxed/simple;
	bh=iwgj8CbM5Z2kld7rY8UqobfhKsLHk9nnUp00/wLa1Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqSBlx8H9WXbveUf8mIbl4chaAC09t+40iQa/wqT6IWVyZjXDRK/OvkCmO9z4YGEEAhxfEU6hoffhNtXdxC3geFjV2Ut+8IgMDqCWbfOy0tvKeze8qspJgvMM7R6VuSepZuTtRSzLpNz7nYoeoqHhWBmlM8oTu25D1z6qESiuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=at1nw81u; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708889992; x=1740425992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwgj8CbM5Z2kld7rY8UqobfhKsLHk9nnUp00/wLa1Rg=;
  b=at1nw81uzDiAyoB91ZRm70qLBE/l2mgQGoNOwhGDbdEAjif9s7TFiXaM
   2IshTM7Gswi5wIZGhqU3IxAUVMzZ6ONJIdRrdMV2AJRl6GdUyP/1MAo0O
   nAr05gR1v4xlg0SM5s5JQuP/O70HlqsDlVD1Gl/NGWRBWIH1h8qzaAnuk
   pDxNNWfO/CFHmLcSQGbL/meiq3ILryG3mMHjM3vAAVwfMN5WMK1Do887O
   XZPIwPMQRUcOfyySLUjL9U4PgqzxZQ7lExicieNp73L2qtdA64b9/9J8f
   V1gALrratkc9N6HS/SQWMOrP6ewYuSuI6M9Um3M0N2DwN+GKcB3jbHkMi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3706344"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3706344"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 11:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11022350"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2024 11:39:48 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reKL0-0009ky-1y;
	Sun, 25 Feb 2024 19:39:15 +0000
Date: Mon, 26 Feb 2024 03:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
Message-ID: <202402260354.rwSw5NBc-lkp@intel.com>
References: <20240218114818.13585-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218114818.13585-3-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-Add-bits-iterator/20240218-195123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240218114818.13585-3-laoar.shao%40gmail.com
patch subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240226/202402260354.rwSw5NBc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402260354.rwSw5NBc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/test_bits_iter_success.c:55:27: error: incomplete definition of type 'struct psi_group_cpu'
      55 |                 psi_nr_running += groupc->tasks[NR_RUNNING];
         |                                   ~~~~~~^
   progs/test_bits_iter_success.c:13:21: note: forward declaration of 'struct psi_group_cpu'
      13 | extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
         |                     ^
>> progs/test_bits_iter_success.c:55:35: error: use of undeclared identifier 'NR_RUNNING'; did you mean 'T_RUNNING'?
      55 |                 psi_nr_running += groupc->tasks[NR_RUNNING];
         |                                                 ^~~~~~~~~~
         |                                                 T_RUNNING
   /tools/include/vmlinux.h:48349:3: note: 'T_RUNNING' declared here
    48349 |                 T_RUNNING = 0,
          |                 ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


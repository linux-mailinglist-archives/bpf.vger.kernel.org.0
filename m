Return-Path: <bpf+bounces-48496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B34A0842A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEB0168B49
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC61262BE;
	Fri, 10 Jan 2025 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ4GZHJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11A1773A
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470155; cv=none; b=nbGtI58IfctuW0nBq0PlJ4R26Ey/UBQnRqGBCDa3ITyTLig7kIa72vJ5l9FooctbtIBUi8NBjK8w4s6z94Ik9ohIArttNOObGjfi9o5ZWoU4Pw1H9UjmFiBWETUzIh2LaKX4BMKRqmfRGDVwDVz/dQ5D3lGy3e8BCOGwmX0meQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470155; c=relaxed/simple;
	bh=Vffrh23ZZUziRB67YPk/dZ1aGzx5qmfnOOe7PCgSUuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtHor8XQYLkIxhx6zl4Y7lFNM+kKpAsaOGl6uUm4DKDJjysy2n9bm3rZpzWPkG6rSygRwqd3krwlS6KB8B27vo3eAKr5xRfiHy0UfqKon8Sv8hxD5f6QBG0gM+VwGCiScKIP3QZmvtgWIyVfFwKAePugNFcCXrbUFNFIvzuAFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ4GZHJZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736470154; x=1768006154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vffrh23ZZUziRB67YPk/dZ1aGzx5qmfnOOe7PCgSUuM=;
  b=jQ4GZHJZySg5DbbHOjco1s+pfehdgGON2Mx8dbZKmzmMz5bxWaDDFY4b
   ZV/SUk3KjVrkNUh9j8HPjx0f6FJbMKFL/6NF57F0hksb9rknpi7kefsB3
   SWm5PL44cQ7jpuzKL5KvTk5r+dZbyVrS3KZ7h8Y/PxMXRFXhHddcUynsJ
   oBhc74m6V0NSyjhG0dAGi98KYtOM+gbt4+cVUqj25Hp2yKcz4bJypmC1Y
   73iNV/t5OUYYNCLSivqf9+adAIxgxNkWjqCPRlnLS4LHX5beQgklVZhjj
   cvGhcKZDEiO2YooqsB3/SZRhYCpw6ggi+piAzxBobyp/HXWVaFWgk00ZL
   Q==;
X-CSE-ConnectionGUID: z/Ai9404TCujsUvqNy3MCw==
X-CSE-MsgGUID: 70gZv45gTWe1NhQyWBcTDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="35974626"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="35974626"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:49:13 -0800
X-CSE-ConnectionGUID: g2cev9StRSO0fMA37Z0ywQ==
X-CSE-MsgGUID: oGdCeUv0RUGAbchqu8iIFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103378795"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Jan 2025 16:49:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW3D3-000ILD-09;
	Fri, 10 Jan 2025 00:49:09 +0000
Date: Fri, 10 Jan 2025 08:48:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
Message-ID: <202501100833.R0PJXI6s-lkp@intel.com>
References: <20250107020632.170883-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107020632.170883-1-linux@jordanrome.com>

Hi Jordan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rome/selftests-bpf-Add-tests-for-bpf_copy_from_user_task_str/20250107-100850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250107020632.170883-1-linux%40jordanrome.com
patch subject: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
config: m68k-randconfig-r133-20250109 (https://download.01.org/0day-ci/archive/20250110/202501100833.R0PJXI6s-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250110/202501100833.R0PJXI6s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100833.R0PJXI6s-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: kernel/bpf/helpers.o: in function `bpf_copy_from_user_task_str':
>> helpers.c:(.text+0x2a3a): undefined reference to `copy_str_from_process_vm'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-48324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EEEA06A21
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FBB7A1A47
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31879F5;
	Thu,  9 Jan 2025 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWdPzb4j"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1633C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736385261; cv=none; b=GT75hpFZf8AqUBBViJpeMAbyU9o3Vh4ddu9FsjSf+DgdwqRgc/OibW0XQwkfJ7qN1ua0sWws7cDMCARTlH30EMjDdXFwmSP4Jm5eg1IKyxpM9RMhSSQJ7hB4hYvYPFRK0wVJUn/vI0b1fNqmzR+tZYQ61vx7adDblTQIfEc21X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736385261; c=relaxed/simple;
	bh=Jjx8Sl6uok1Sjd+8yBqJp5h/vfbbP0dceHRrIWEWMJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBY6NIO5mgrNM1jaa3GHpu7KgaPPgpP110DFNRiv8EHG6oV4WuPenTwG/LNSi/t3ekgG+Ja77c9TTW7rLjkDdTns7DlXeDU5ZU3VuEJD20T52Q+dTOhI4A5ZprTJSZ7SSkKndy9Yg/j5d0Q5n/W0ahCxamRlT8vHG4v+1mRlxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWdPzb4j; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736385260; x=1767921260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jjx8Sl6uok1Sjd+8yBqJp5h/vfbbP0dceHRrIWEWMJA=;
  b=eWdPzb4jP2iOwYE5x1Z7zx5U5G5arrKUBP3lOdZq398oaQrLY9TLjuaE
   I2VgQO+EKPNl2+EftTl4JnB828bQlGdV5PmQZVJ+eCazHeas0rZp+1FCL
   f2HFGYxkyV+NW2nTCE2qdna6/SYguv2ElPnOk84PiREYB7g6njUWcpa6M
   Ood1DAtPXWP91s4/K9cj+ky02Tv8ybaJqk06q02CNVcHf8AzePT33qZOE
   SNHEgWAayJp07SW5LS1qWoMAGoP7ZAdHew1OQrPoqRnosvvntQjnhWCpj
   uNcB55SGrhiQV2/UgPbyYC5k3AhvBbq8u8MGYqHOkv0Gjum505sTxmIzM
   g==;
X-CSE-ConnectionGUID: opMJEs1HSBmUm3T0BodtEQ==
X-CSE-MsgGUID: 3Iu0OwQyQe6bAA1I/B/H9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47991202"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="47991202"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 17:14:19 -0800
X-CSE-ConnectionGUID: m/4T04jgRaie/8eMj3mGQQ==
X-CSE-MsgGUID: Y5vsaKkuSHWSBHm7JxpFvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="103217659"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Jan 2025 17:14:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVh7m-000Gsp-1I;
	Thu, 09 Jan 2025 01:14:14 +0000
Date: Thu, 9 Jan 2025 09:13:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
Message-ID: <202501090817.0Uikg2ka-lkp@intel.com>
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
config: arm-imxrt_defconfig (https://download.01.org/0day-ci/archive/20250109/202501090817.0Uikg2ka-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090817.0Uikg2ka-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501090817.0Uikg2ka-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: copy_str_from_process_vm
   >>> referenced by helpers.c
   >>>               kernel/bpf/helpers.o:(bpf_copy_from_user_task_str) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


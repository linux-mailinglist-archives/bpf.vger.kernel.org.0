Return-Path: <bpf+bounces-64437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ED4B12A62
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65E27AA5F5
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738CA24503C;
	Sat, 26 Jul 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK5UswoX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFC244690;
	Sat, 26 Jul 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531601; cv=none; b=hCKtjLXfGOSeK/EY1B7igfSiGScDnqo+ICWit5t6K0i+Pt+UA2uberwSDw5/9e4Y+RhiIWRrfeIGDYB3MxCfTy6p4Kdjm//UJRSdSpX3IhkOauZuLPFB1Nyf5xfmM1U/UWVacOco1q4bHmthwhbuYYUKb0b83j+p59HiaXBYCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531601; c=relaxed/simple;
	bh=KeZHG/hprp0Bsq1uf1r+YqWVMWzeAJK4jTUPizApUhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG9nQxuwbX5YfkJpUUvtwtXG7NruhL1nB0K6QzIGGp41+Q9tBwJEe1vQ/5/l6gInHVQ7SibBk7yvEbpMtqfitp/7U4CblZTG+nHHMVK09iIdbzJRcxXrdAMy9VttzWjFDIYuFjstfMOF0M14zJkYEoPciWLn8LsG7M/EihpVOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK5UswoX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753531600; x=1785067600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KeZHG/hprp0Bsq1uf1r+YqWVMWzeAJK4jTUPizApUhs=;
  b=mK5UswoXOIOkPUU9SsytjlNvAOx4nIhMzxqDmgOa5Hh5vo9IWIWgi1Ev
   fYcJPEEUo0bxfOtlA3eMmFyDlujDg0zFJHxOqJfzc/UxK3FlmK4J8Vp/z
   PxH9fL/NsjpBycQx4Y1OkPga51P+NG3u5w6Bt48cjalsgKskAFDp83d/F
   DsS2p4i0apxjhAB2Pp/wRdpR1/b2QLqvIecVnZfKzD+BJMbq7pySaiqmY
   BkVyVbGYnPsn89HkcfmPqWrOcYiEvmeqhUvj3Rzr+hcSQPI6phLNYaxHO
   SV7PQnugrcZv16LPHXUPvM73mftZv5d74V/UkmXctduMmtLXfRM1KnHvQ
   A==;
X-CSE-ConnectionGUID: Y8WJfnBlQNaUaveWmM1CpA==
X-CSE-MsgGUID: +Kx1Hh4UTM+zvZiT4aJSZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55996490"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55996490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 05:06:39 -0700
X-CSE-ConnectionGUID: RECxPv7sRR6OJ6zQV6942w==
X-CSE-MsgGUID: /hvYLPQeQJS0pTzYjN6FiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161139361"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jul 2025 05:06:37 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufdff-000Lxx-01;
	Sat, 26 Jul 2025 12:06:35 +0000
Date: Sat, 26 Jul 2025 20:06:09 +0800
From: kernel test robot <lkp@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 2/3] bpf: remove bpf_key reference
Message-ID: <202507261944.7ub6moae-lkp@intel.com>
References: <20250724143428.4416-3-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724143428.4416-3-James.Bottomley@HansenPartnership.com>

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.16-rc7 next-20250725]
[cannot apply to bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/bpf-make-bpf_key-an-opaque-type/20250724-224304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250724143428.4416-3-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH 2/3] bpf: remove bpf_key reference
config: i386-randconfig-063-20250725 (https://download.01.org/0day-ci/archive/20250726/202507261944.7ub6moae-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261944.7ub6moae-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261944.7ub6moae-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/bpf_trace.c:834:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr @@     got void * @@
   kernel/trace/bpf_trace.c:834:41: sparse:     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr
   kernel/trace/bpf_trace.c:834:41: sparse:     got void *
   kernel/trace/bpf_trace.c:3695:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3709:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3723:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3730:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3738:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3746:56: sparse: sparse: cast removes address space '__user' of expression
>> kernel/trace/bpf_trace.c:1349:42: sparse: sparse: non size-preserving pointer to integer cast
   kernel/trace/bpf_trace.c:1377:42: sparse: sparse: non size-preserving pointer to integer cast
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:871:25: sparse: sparse: context imbalance in 'uprobe_prog_run' - unexpected unlock

vim +1349 kernel/trace/bpf_trace.c

  1339	
  1340	/**
  1341	 * bpf_key_put - decrement key reference count if key is valid and free bpf_key
  1342	 * @bkey: bpf_key structure
  1343	 *
  1344	 * Decrement the reference count of the key inside *bkey*, if the pointer
  1345	 * is valid, and free *bkey*.
  1346	 */
  1347	__bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
  1348	{
> 1349		if (system_keyring_id_check((u64)bkey->key) < 0)
  1350			key_put(bkey->key);
  1351	
  1352		kfree(bkey);
  1353	}
  1354	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-67440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638EB43C65
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522C01890F9E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB902FE04F;
	Thu,  4 Sep 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LC1s1u0+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E922EA468;
	Thu,  4 Sep 2025 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990966; cv=none; b=mh9/W3fdv8lgDE2M/urq2iTGQm26jmMqsbtkeZUWQByEKuFbUWLGKS0bACQisvQdGSzDZyOw/XeiQz2sxIK4fL18NZdeX7QyaV30Bv9EGDPsFBQSAl5w0VZiwNYWjUpsw6/kFYsmQ/7E8u43liHIATjHRhY2h8UbyeJiPYhTT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990966; c=relaxed/simple;
	bh=ZeqVrEHeEE82CwedCgaY6aPUXavAZ7JXEvQ/3KQzbdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZEFgk3QiZMXplRfsTlAUHHYaFgClsHuUYwgrJht2C4a1W6eLg6Qj/3bpWfkbAjlfw3juWtxK4XN9q2+z7JGsUtpCe7mvDUo7RhOVNlPW/uotivAOb3fYVYyJgKI8Y0O45F2dSOSzS9EFoTreCZImXNhv9nMNhayQ0s/nyj9nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LC1s1u0+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756990965; x=1788526965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZeqVrEHeEE82CwedCgaY6aPUXavAZ7JXEvQ/3KQzbdA=;
  b=LC1s1u0+1I6CR0VPhC3vAvuqa66/HFsq9EVnFJSNjDkZHL0Th/c3xoHc
   27XPV5AxJpnweyT/RN0c59WBoXnKbriEIoZ5jZcn1yew/t8H+YLpr5w8O
   K5WVBPcTXh4+K9JFL1ACgVm2HW5jLUnNagTlGlTa/lHbD9yo8YuujFX7G
   c7b4NgjZCUylgGtYlWPDwjUAiYXW3Wdm0+VFMkW4zl/OsvxcjUl4eS6F7
   TFc3jHgA6VlEarmzVcjLl0owcnQnzp8lyH8su9ojUf4J7v++2jN+7MEK7
   QBJkgAc6O0fx5VMgmv80L2dqeEeqZS9n8dOscRf9th4TRrrQsFYeASum7
   g==;
X-CSE-ConnectionGUID: dMb1Ys6FTAS5LoHbLwByhA==
X-CSE-MsgGUID: Ecpg98hnQmimOAe+J4UiPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59279315"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59279315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:02:44 -0700
X-CSE-ConnectionGUID: wjKjug+ISjiV38csdt2oaA==
X-CSE-MsgGUID: z27HVbMAQjWCfKoOC/ObJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="209064790"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 06:02:40 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu9ar-0005JX-0v;
	Thu, 04 Sep 2025 13:01:54 +0000
Date: Thu, 4 Sep 2025 21:00:33 +0800
From: kernel test robot <lkp@intel.com>
To: David Windsor <dave@nullcore.net>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, dwindsor@gmail.com
Subject: Re: [PATCH 1/2] kernel/bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type
 and kfuncs
Message-ID: <202509042029.W1pcuqjU-lkp@intel.com>
References: <20250903175841.232537-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903175841.232537-1-dwindsor@gmail.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Windsor/selftests-bpf-Add-cred-local-storage-tests/20250904-015935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250903175841.232537-1-dwindsor%40gmail.com
patch subject: [PATCH 1/2] kernel/bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
config: nios2-randconfig-001-20250904 (https://download.01.org/0day-ci/archive/20250904/202509042029.W1pcuqjU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509042029.W1pcuqjU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509042029.W1pcuqjU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> nios2-linux-ld: kernel/bpf/syscall.o:(.rodata+0x734): undefined reference to `cred_storage_map_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


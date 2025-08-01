Return-Path: <bpf+bounces-64866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD45B17B0B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 04:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CCF3AE277
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2F156F45;
	Fri,  1 Aug 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrDp2rk8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22513AD05;
	Fri,  1 Aug 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754013602; cv=none; b=ePkQOjVVrVZBVEhrJgMsvLuKmrzheq8m3/ui519Z2ZvlIROF9Sesx8mpbuH987eDYPrh7B+yyNn5/6CrP/Bw8vKi7VSUtsKC/eGz0sp33iFtuZBHQYbjHGb020UOlS+EWojZKyAPe8G06JS1r9Sf411vuOjsklnP6fZjKKhJ6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754013602; c=relaxed/simple;
	bh=R9A4+rH+cYaErrSVMznYpDaXYvsReGCOR0hex+PkQ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXqBKi1T2Pa6avEgnRUR8e7lwRPN5sk/glqHzSyHGaYBHDDy1iK1r9FZG4UeINR4eTmVQ1vMCUxQEESNhGa4fcGR1s4xTXWizJ80iHrNASrYL+CjqIrFuYFef5a5BxU3GS+hnB3ZnuJN9Oa++8dkFvLqQ/Pk600QOpNuEUW6x48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrDp2rk8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754013601; x=1785549601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R9A4+rH+cYaErrSVMznYpDaXYvsReGCOR0hex+PkQ9k=;
  b=OrDp2rk85J4ZVBum5N/VAoNBgiN0p3568AXdeFlExWJZYkH7mWadkWau
   oeitovcCjQczPOeuxNcWuSoUKhV2Yze80S/SYt2wApL8mOykaz0bFvPwJ
   BjoJfmueo92S40yTPrWuWrso8H6ragnIkevw5bRf8tKsI/G6hzsA3mZxf
   l4xOovHlfZMN0ACJcYBD3MPPe4NTXW5zZZluUmCeWOL5UOANJwgCUO800
   NKeJwlfnox/KVIIIOyYH/YDz1EZ6jrf/+ExFPxlWpZgq72Kz3MMLKyjli
   Hm9x4KoGRydCcDm8e4pIjS+JAM0jgLoGAcRDvvrvowH3B+R8qEPUnTYj/
   Q==;
X-CSE-ConnectionGUID: b5jXsekHTESA7g5gK3NfkA==
X-CSE-MsgGUID: 34hUskw+TEe08L/Qc/0Z/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56499911"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56499911"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 19:00:00 -0700
X-CSE-ConnectionGUID: u9Nj1x+uSXenhvfEBM97+w==
X-CSE-MsgGUID: iXiqFlJfRB6QGRbn9nIcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="164218468"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 31 Jul 2025 18:59:59 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhf3s-0004Hs-0m;
	Fri, 01 Aug 2025 01:59:56 +0000
Date: Fri, 1 Aug 2025 09:59:07 +0800
From: kernel test robot <lkp@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate
 struct bpf_key
Message-ID: <202508010906.eulQ24IN-lkp@intel.com>
References: <20250730172745.8480-4-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730172745.8480-4-James.Bottomley@HansenPartnership.com>

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.16 next-20250731]
[cannot apply to bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/bpf-make-bpf_key-an-opaque-type/20250731-013040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250730172745.8480-4-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate struct bpf_key
config: i386-randconfig-r133-20250801 (https://download.01.org/0day-ci/archive/20250801/202508010906.eulQ24IN-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010906.eulQ24IN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508010906.eulQ24IN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/bpf_trace.c:834:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr @@     got void * @@
   kernel/trace/bpf_trace.c:834:41: sparse:     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr
   kernel/trace/bpf_trace.c:834:41: sparse:     got void *
>> kernel/trace/bpf_trace.c:1249:11: sparse: sparse: symbol 'BUILTIN_KEY' was not declared. Should it be static?
   kernel/trace/bpf_trace.c:3684:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3698:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3712:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3719:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3727:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3735:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:871:25: sparse: sparse: context imbalance in 'uprobe_prog_run' - unexpected unlock

vim +/BUILTIN_KEY +1249 kernel/trace/bpf_trace.c

  1243	
  1244	#ifdef CONFIG_KEYS
  1245	/* BTF requires this even if it serves no purpose */
  1246	struct bpf_key {
  1247	};
  1248	/* conventional value to replace zero return which would become NULL */
> 1249	const u64 BUILTIN_KEY = -1LL;
  1250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


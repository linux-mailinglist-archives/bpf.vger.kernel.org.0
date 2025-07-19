Return-Path: <bpf+bounces-63810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E7B0B2C5
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 01:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F83189C1E3
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80228983E;
	Sat, 19 Jul 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwXh5p6G"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEF223702;
	Sat, 19 Jul 2025 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752967997; cv=none; b=Crj/OW466s0dEIoFNEqPVHdzGzNyPAavOdqFtScbXAp1g5z1P7yjcEw6fSxcFIphp1GIhmO51X0FbpoOrdmv4xLtCPvxG10PF3HNjMdGpxcPxwjI/4MCRLP/9c44cDEI/OFdIoQq2cIsut9sXA6zm/mG34Nz/dQ3RB3b0c7aZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752967997; c=relaxed/simple;
	bh=Hkcfo0IKkyD5A7QFzFl7rBu/pNqfb8/o8DBVlpAhK4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcxeP8BXA7decJVClKv1qDG4/K9mYiwlY4pg6WEYccIMkqqIaOcbxAGuVsEXIGEzr051qd6VLmeYXVgfRMHVofbNSmKa7bwtdASilDMrBcpZsiQgm6A0fyWZU1sX+nx/jPLfaLygyOVvH1ZN5GPV1gtd7KgPE1ZBqG38PYBCJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwXh5p6G; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752967995; x=1784503995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hkcfo0IKkyD5A7QFzFl7rBu/pNqfb8/o8DBVlpAhK4c=;
  b=VwXh5p6Gf11uVssyt3AbCohwJ9wVrILkC0lWJYwcj4g1LEOOaGuvRyyA
   4LpkJYWhNa2Gzv8iq3PJvtQVzEy5uxQ06O5OJh6SpQ2SW2Bi7Htk0xdO6
   zZ+5wc4XDW6h6aEcXP2EZzlER9Ernnh0R8OrJn18fCFkxEHkX8RjAegsl
   uZk4NHn00q25QXEytI1ZVCzmXsKW0LSVFdAUZt9GZUl5pg7jCz0nhcAvG
   psF0Dm64UkQTdh6ZeJQce8RCqDKRADBqlb7oNzbjo7+szbSTTkSyJV5eX
   BoY5CU5j9Xf9X7/7v45zkIti/J8B1sXQlAVMLN/zdMuYdxFc8z3mKTI1Z
   A==;
X-CSE-ConnectionGUID: p821G+sWSZKRAsRyBWKhzg==
X-CSE-MsgGUID: 5Dim8XBGSu+7qmDz6/SCJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="59012760"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="59012760"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 16:33:15 -0700
X-CSE-ConnectionGUID: RGBL5xe5TVKBQO3eztAvDQ==
X-CSE-MsgGUID: Dvsz0yNITWe2Jfo3X1qbxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="159210283"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2025 16:33:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udH3F-000FqD-2t;
	Sat, 19 Jul 2025 23:33:09 +0000
Date: Sun, 20 Jul 2025 07:32:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxwell Bland <mbland@motorola.com>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH bpf-next v11 2/3] cfi: Move BPF CFI types and helpers to
 generic code
Message-ID: <202507200719.dWqamnJW-lkp@intel.com>
References: <20250718223345.1075521-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718223345.1075521-7-samitolvanen@google.com>

Hi Sami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0ee30d937c147fc14c4b49535181d437cd2fde7a]

url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/cfi-add-C-CFI-type-macro/20250719-063535
base:   0ee30d937c147fc14c4b49535181d437cd2fde7a
patch link:    https://lore.kernel.org/r/20250718223345.1075521-7-samitolvanen%40google.com
patch subject: [PATCH bpf-next v11 2/3] cfi: Move BPF CFI types and helpers to generic code
config: x86_64-randconfig-123-20250719 (https://download.01.org/0day-ci/archive/20250720/202507200719.dWqamnJW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250720/202507200719.dWqamnJW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507200719.dWqamnJW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/cfi.c:39:24: sparse: sparse: symbol '__bpf_prog_runX' was not declared. Should it be static?
>> kernel/cfi.c:42:28: sparse: sparse: symbol '__bpf_callback_fn' was not declared. Should it be static?

vim +/__bpf_prog_runX +39 kernel/cfi.c

    31	
    32	/*
    33	 * Declare two non-existent functions with types that match bpf_func_t and
    34	 * bpf_callback_t pointers, and use DEFINE_CFI_TYPE to define type hash
    35	 * variables for each function type. The cfi_bpf_* variables are used by
    36	 * arch-specific BPF JIT implementations to ensure indirectly callable JIT
    37	 * code has matching CFI type hashes.
    38	 */
  > 39	typeof(*(bpf_func_t)0) __bpf_prog_runX;
    40	DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
    41	
  > 42	typeof(*(bpf_callback_t)0) __bpf_callback_fn;
    43	DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


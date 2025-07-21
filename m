Return-Path: <bpf+bounces-63865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D28EB0B9C2
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 03:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A81734DE
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 01:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E5185E7F;
	Mon, 21 Jul 2025 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M46I+PSO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C131369B4;
	Mon, 21 Jul 2025 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753061178; cv=none; b=peOTN512kt9aJGiKlx8hXXo55CNcBk7IGa0Urnb0zgmC/oCqfXcGpv1QB6G1/cUw15oUCpl+QKRRajBIsZr/GkefWwsByV9WFiFFYAdDixvFB7pG9xjzqpNRgt3SVXVZl+b4MN+94xcxYGZyLUHQDogD1FJRCcwQk0cwX3TFMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753061178; c=relaxed/simple;
	bh=pvhRCHGIucYdujSap+8QzPuzACWS4wsHi36ZbyRIfzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6NEHfH1lxjo2i+TazUQhorRI0KN7kvwUt7I+CpOV8LiM+RtKLWWJ9O3DVLLxLDZikl7vndxDTnGragow3HDAApXIVddzNVnDSUgL0d3HtLIoi5J9tAjQ7FKhbRFuNcni5p+nNZ6/Nec9d7aoLQYoEk2nFojpI5OTtRKoj/qQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M46I+PSO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753061177; x=1784597177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvhRCHGIucYdujSap+8QzPuzACWS4wsHi36ZbyRIfzU=;
  b=M46I+PSOBL/MqgHhmUBcV496KG4+8xnNOLygDvVqnzNuFddfpUz4yQEP
   /nM41GlPe7JNHIHpKKsnkihr/oJkG0B+DTEIgBBprvBFzM1zMTp+ppruP
   BXaSIGf4h/knBmRy1DfqYS+FBny70JTVIVfbipEKwAXeaQ245dmJ3YsIF
   K05LMFyAzumoodR+n+pj/FnM0vCgSP+MXQjLlqH1nMuh+TDdeJDupMcBC
   TXlGR53YGhnay+StexCR+KfcIsRz6U4b64FhDrMYKXa2C0f2B9Ql02XXd
   KISeMqS1VhIflDFrCfMXFz2YNf1qNwfQxMyrCUX30PiWbfNOF7cWTzGwZ
   w==;
X-CSE-ConnectionGUID: jlIOHFYxTNGpucPVMFtheg==
X-CSE-MsgGUID: N9PlXQmWSHieTWsGPZWnJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="72838318"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="72838318"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 18:26:16 -0700
X-CSE-ConnectionGUID: yx9QBkAFRLO48bxGjUoV0A==
X-CSE-MsgGUID: cBbe1sc/RRGUKZYvF5ur8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="162920814"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 20 Jul 2025 18:26:13 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udfIA-000GOD-0D;
	Mon, 21 Jul 2025 01:26:10 +0000
Date: Mon, 21 Jul 2025 09:25:53 +0800
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
Message-ID: <202507210919.wPRFLcKb-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 0ee30d937c147fc14c4b49535181d437cd2fde7a]

url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/cfi-add-C-CFI-type-macro/20250719-063535
base:   0ee30d937c147fc14c4b49535181d437cd2fde7a
patch link:    https://lore.kernel.org/r/20250718223345.1075521-7-samitolvanen%40google.com
patch subject: [PATCH bpf-next v11 2/3] cfi: Move BPF CFI types and helpers to generic code
config: arm-randconfig-r072-20250721 (https://download.01.org/0day-ci/archive/20250721/202507210919.wPRFLcKb-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507210919.wPRFLcKb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507210919.wPRFLcKb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <inline asm>:2:41: error: expected '%<type>' or "<type>"
       2 |         .pushsection    .data..ro_after_init,"aw",@progbits     
         |                                                   ^
>> <inline asm>:3:21: error: expected STT_<TYPE_IN_UPPER_CASE>, '#<type>', '%<type>' or "<type>"
       3 |         .type   cfi_bpf_hash,@object                            
         |                              ^
>> <inline asm>:9:19: error: .popsection without corresponding .pushsection
       9 |         .popsection                                             
         |                                                                 ^
   <inline asm>:10:41: error: expected '%<type>' or "<type>"
      10 |         .pushsection    .data..ro_after_init,"aw",@progbits     
         |                                                   ^
   <inline asm>:11:29: error: expected STT_<TYPE_IN_UPPER_CASE>, '#<type>', '%<type>' or "<type>"
      11 |         .type   cfi_bpf_subprog_hash,@object                            
         |                                      ^
   <inline asm>:17:19: error: .popsection without corresponding .pushsection
      17 |         .popsection                                             
         |                                                                 ^
   6 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-79428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E850D3A182
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1062302DB25
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764A33CEA2;
	Mon, 19 Jan 2026 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXpFxVlm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09A33D508;
	Mon, 19 Jan 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811073; cv=none; b=YJAe+IXwCdrSqbHS8gwmY/jQ5Tc35YDlEIOIBn+qXvkMUS/nftYAh/+f37ZOKft7akA3FC+Z6xafI7+uJ9kP6Zjw+BWFKLr84YczA7jbqPWX2iPNGE677GLoAt8WC3jQuugIJugHPbWBABC8RG7EHgtpBPoyemmo1zwtN6MTFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811073; c=relaxed/simple;
	bh=3UoClJcJDW2uoWng1yw1//FZOmo69ZVnggpsjcysDfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh7Amc/Gd5niocgF67iZ4Rs6zOzx6Ua13HWdQru7zOoBQ4dlkE0sK/V0N5LWsTtxPUYdwZZqXb8ogotKNXhX/Gp02yN5RUo+BjzB4Ilyb5LLOyfjnZRwVsdqPFVSLwWEFNRvlKWgutmy1kruIj4XN84uBs2E+Z8JhsM2j4Eo5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXpFxVlm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768811066; x=1800347066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3UoClJcJDW2uoWng1yw1//FZOmo69ZVnggpsjcysDfk=;
  b=JXpFxVlmrHFRF/kKLUqumlV1JyaDGVdhTWYl5Wb/3NHNmaQ24Xa3nEwm
   2pX0qtxGfRUBO3s4jXCS37MP+QfjY25DKDyHAG+UKka0yeV6mibF6o5J1
   IIKsVuY3Zeb+xuD/f2TpMZbQ9q9VSImsFCqNT2GioQY4wfA0ppSR6dTG2
   2s38QGce35fdJ3PzMBQ6gcixTVnoojAXB/FpYJagAGK6mrgTiVrE6vLVl
   nleHynfO3fdXUjrblwqRZAiHVLderemweVi6poz+LNh9cjlwsjX2JBqae
   jqKt7tAtX95POLKdC5UCUvRn9QTxCa6kpO2q5MeoOW/6AdTkDn+/l1a4n
   w==;
X-CSE-ConnectionGUID: +Nido9asQM+7c6euE+h3zQ==
X-CSE-MsgGUID: oNy8MPopQPGeh1Pq7UYLrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69217480"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69217480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:24:25 -0800
X-CSE-ConnectionGUID: 6JrKYD8FQiOuYUMvH+ySjQ==
X-CSE-MsgGUID: qEu6BI5JSmWE3xRAdt9Yxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="228742759"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2026 00:24:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhkYa-00000000Naz-080r;
	Mon, 19 Jan 2026 08:24:16 +0000
Date: Mon, 19 Jan 2026 16:23:31 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pingfan Liu <piliu@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support
 UEFI-style kernel image
Message-ID: <202601191626.CUD61tIS-lkp@intel.com>
References: <20260119032424.10781-12-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119032424.10781-12-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master akpm-mm/mm-nonmm-unstable linus/master v6.19-rc6 next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/bpf-Introduce-kfuncs-to-parser-buffer-content/20260119-112939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260119032424.10781-12-piliu%40redhat.com
patch subject: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
config: arm64-randconfig-004-20260119 (https://download.01.org/0day-ci/archive/20260119/202601191626.CUD61tIS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601191626.CUD61tIS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601191626.CUD61tIS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_bpf_loader.c:103:22: warning: unknown attribute 'optimize' ignored [-Wunknown-attributes]
     103 | __attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
         |                      ^~~~~~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for KEXEC_BPF
   Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=y] && BPF_SYSCALL [=y] && KEEP_DECOMPRESSOR [=n]
   Selected by [y]:
   - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y] && DEBUG_INFO_BTF [=y] && BPF_SYSCALL [=y]


vim +/optimize +103 kernel/kexec_bpf_loader.c

e683ae405ea0458 Pingfan Liu 2026-01-19   93  
e683ae405ea0458 Pingfan Liu 2026-01-19   94  void kexec_image_parser_anchor(struct kexec_context *context,
e683ae405ea0458 Pingfan Liu 2026-01-19   95  		unsigned long parser_id);
e683ae405ea0458 Pingfan Liu 2026-01-19   96  
e683ae405ea0458 Pingfan Liu 2026-01-19   97  /*
e683ae405ea0458 Pingfan Liu 2026-01-19   98   * optimize("O0") prevents inline, compiler constant propagation
e683ae405ea0458 Pingfan Liu 2026-01-19   99   *
e683ae405ea0458 Pingfan Liu 2026-01-19  100   * Let bpf be the program context pointer so that it will not be spilled into
e683ae405ea0458 Pingfan Liu 2026-01-19  101   * stack.
e683ae405ea0458 Pingfan Liu 2026-01-19  102   */
e683ae405ea0458 Pingfan Liu 2026-01-19 @103  __attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
e683ae405ea0458 Pingfan Liu 2026-01-19  104  		struct kexec_context *context,
e683ae405ea0458 Pingfan Liu 2026-01-19  105  		unsigned long parser_id)
e683ae405ea0458 Pingfan Liu 2026-01-19  106  {
e683ae405ea0458 Pingfan Liu 2026-01-19  107  	/*
e683ae405ea0458 Pingfan Liu 2026-01-19  108  	 * To prevent linker from Identical Code Folding (ICF) with kexec_image_parser_anchor,
e683ae405ea0458 Pingfan Liu 2026-01-19  109  	 * making them have different code.
e683ae405ea0458 Pingfan Liu 2026-01-19  110  	 */
e683ae405ea0458 Pingfan Liu 2026-01-19  111  	volatile int dummy = 0;
e683ae405ea0458 Pingfan Liu 2026-01-19  112  
e683ae405ea0458 Pingfan Liu 2026-01-19  113  	dummy += 1;
e683ae405ea0458 Pingfan Liu 2026-01-19  114  }
e683ae405ea0458 Pingfan Liu 2026-01-19  115  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


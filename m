Return-Path: <bpf+bounces-64132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3866FB0E7A8
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DD01C2815F
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D915442C;
	Wed, 23 Jul 2025 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNOO8GF1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD71494C2
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231512; cv=none; b=jkpTzJplOw8Wz4zxBTf23E2fTiTl7sryacyUqT/wYsoFPqXVMnc2WDTIZ9Yp7a0Xp8VEfd72qqAAxu3CzTdqhV9GhfPmCwLRJlXTffMOyJD9e/A5Axi6Y3rdMKurNqiHppUwEytx5gdxs0U1IzziFkL0Ol0/XdmuoqyF3Ea/RbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231512; c=relaxed/simple;
	bh=m426WV1lDKEaPLng1dxGfobPDwFUytLJjSu785UlQ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK/e6886iQxRJwfkWacNx1pCzmJG8gLB0hOki7zsFqaor1wfEfMMqJKUFKhUNIvmbrzvosbQOLTgJbVDABq2WzhBMIqr1Tvl1+cK+ZzHvpPNX6Q8GA3/XfPCaSTQAWU9D/ukEoVUw0IZZqH4ZPJvwMpfuw0NLV0ICbMRSa80zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNOO8GF1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753231512; x=1784767512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m426WV1lDKEaPLng1dxGfobPDwFUytLJjSu785UlQ7E=;
  b=LNOO8GF144a1JMuZvM0sZGfyO9IxBmGGtC2WBzQ04VZamJzsfd+WYjbR
   ysDoyPnUyk5EP6FYlLz+PB+YUV+EEoTKwdW7l1qoOETlwCyI3CF4xUwEz
   xvAocY8K+Xbd1jQr5Jq2PoghZu22xCMkoref4XNUsYSA+CGgwGLIJDrua
   WXhdYtaee/di9RSkVAROWcmrOmNPQmrpGCoiPdYw2pQGm57U+S9Fzi5QF
   zBoq4MlmtwOZSOxEvYVoRFb3bBdPg2urllVxEX98LW6R8u9YVnZZ7cDa8
   nqOyIPtAAJRLsDOlcLHKQb0Oe9z0l+aCtPgyuj9AnvaCUS0VWbdukNndC
   w==;
X-CSE-ConnectionGUID: tZWx7SMTQhieTD/Di+tA3Q==
X-CSE-MsgGUID: NXs1htX0RnieV9z2oTzXtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55348816"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55348816"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:45:11 -0700
X-CSE-ConnectionGUID: 706r2HHuRv625sILRACQ3Q==
X-CSE-MsgGUID: Uv2GzgKdTpedaycps3ofeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159038253"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 22 Jul 2025 17:45:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueNbR-000IpT-1V;
	Wed, 23 Jul 2025 00:45:01 +0000
Date: Wed, 23 Jul 2025 08:44:58 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, bpf@vger.kernel.org
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
	kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCHv4 04/12] bpf: Introduce decompressor kfunc
Message-ID: <202507230813.M1tmyREU-lkp@intel.com>
References: <20250722020319.5837-5-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722020319.5837-5-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf/master arm64/for-next/core linus/master v6.16-rc7]
[cannot apply to bpf-next/master next-20250722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250722-100843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250722020319.5837-5-piliu%40redhat.com
patch subject: [PATCHv4 04/12] bpf: Introduce decompressor kfunc
config: arm-randconfig-004-20250723 (https://download.01.org/0day-ci/archive/20250723/202507230813.M1tmyREU-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230813.M1tmyREU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230813.M1tmyREU-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: bpf_decompress+0xbc (section: .text.bpf_decompress) -> decompress_method (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


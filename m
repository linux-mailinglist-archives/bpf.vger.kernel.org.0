Return-Path: <bpf+bounces-59296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E846CAC805D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35DA4A4FD5
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98A22CBEE;
	Thu, 29 May 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iff+x7lC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F633E4
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532945; cv=none; b=NXsQaLVq0C8nCbFCExjMJSzv9y47uFpCuq8o1xlg9NWvae2f33ZgkuCpWPR2oSHxy2UxWgYLciU5AZc5fMVl0psUpvhpdBHRE9t8nDk52ySLC4R2bM1dmE4TKyq7dJMPd2IjxIE/SBbaQSsOKyFi6UNacknpy9Z/FCdiA6KoD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532945; c=relaxed/simple;
	bh=GPdqafqU2tPrO3Kwr1heLn8rpZD1wUwbKicBkAIdz60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4QFkKJ7zWRkSkWSwWPOHvW1HEFnNdXdZY5/n5rDF3YNE/aRUw7gdwqikQo/iYXTUlQMXIMNH7im4Qt70jCsKaDthZug5NkYu1Wcgctr/CDbjOzVy8EKi9QwzNiUAAdsjMVlA3IgZfFNLQb+Yr/0/d4+L/W+dfRDG7mOq9UWAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iff+x7lC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532944; x=1780068944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPdqafqU2tPrO3Kwr1heLn8rpZD1wUwbKicBkAIdz60=;
  b=Iff+x7lCRcu5hXXtGD5wmwv3PqP+RcEH7iGyQM8u9hAKP9dyTUjVYUBb
   925vxPuPI3y58hHAzgPW42brNO4Dj0t69AeZyN/dxemhp9He1CRClnTFP
   Lr1+YKWrsEYRzPIguSh5K14JYl7av7rd2od5oOT1BCYbHuzT0CRjL4kvl
   5u+1S9nm5yBOSVt1ekbUfGnssfiVCQNWQ24UrBHONd4ztHSR+o1Ukb77d
   1TzE7Gjs10eHxpFsU2FjtKPQ3fcPL5N0WE3mxBtMC3HZpqk0x4HA9/haK
   bzy6esi2GIF6vwV643u85kxUu5G48Hj0daVZs7fou9Nm10kiaa7szWL+7
   Q==;
X-CSE-ConnectionGUID: vGJ5mYT2RyKydOpYqTdlEw==
X-CSE-MsgGUID: kOXLXffiQVeBskFdBlcpfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50302769"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50302769"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:35:32 -0700
X-CSE-ConnectionGUID: W1hnYaAwS2CKSIOXxah0vw==
X-CSE-MsgGUID: Hz/Y3PS0ShSJB8EDBEqtNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148887384"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2025 08:35:26 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKfHv-000WpE-2L;
	Thu, 29 May 2025 15:35:23 +0000
Date: Thu, 29 May 2025 23:34:48 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	kexec@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCHv3 9/9] arm64/kexec: Add PE image format support
Message-ID: <202505292305.zHTx5StD-lkp@intel.com>
References: <20250529041744.16458-10-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529041744.16458-10-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master arm64/for-next/core v6.15]
[cannot apply to bpf-next/master linus/master next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250529-122124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250529041744.16458-10-piliu%40redhat.com
patch subject: [PATCHv3 9/9] arm64/kexec: Add PE image format support
config: arm64-randconfig-004-20250529 (https://download.01.org/0day-ci/archive/20250529/202505292305.zHTx5StD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505292305.zHTx5StD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505292305.zHTx5StD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h:6,
                    from kernel/kexec_pe_image.c:25:
   tools/lib/bpf/skel_internal.h: In function 'skel_finalize_map_data':
   tools/lib/bpf/skel_internal.h:155:15: error: implicit declaration of function 'bpf_map_get'; did you mean 'bpf_map_put'? [-Werror=implicit-function-declaration]
     155 |         map = bpf_map_get(fd);
         |               ^~~~~~~~~~~
         |               bpf_map_put
   tools/lib/bpf/skel_internal.h:155:13: warning: assignment to 'struct bpf_map *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     155 |         map = bpf_map_get(fd);
         |             ^
   kernel/kexec_pe_image.c: In function 'kexec_bpf_prog_run_init':
>> kernel/kexec_pe_image.c:283:16: error: implicit declaration of function 'register_btf_fmodret_id_set'; did you mean 'register_btf_kfunc_id_set'? [-Werror=implicit-function-declaration]
     283 |         return register_btf_fmodret_id_set(&kexec_modify_return_set);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                register_btf_kfunc_id_set
   kernel/kexec_pe_image.c: In function 'pe_image_load':
   kernel/kexec_pe_image.c:325:44: warning: variable 'cmdline_sz' set but not used [-Wunused-but-set-variable]
     325 |         unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
         |                                            ^~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE
   Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=n] && BPF_SYSCALL [=n]
   Selected by [y]:
   - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y]


vim +283 kernel/kexec_pe_image.c

536de0ba3b982c Pingfan Liu 2025-05-29  280  
536de0ba3b982c Pingfan Liu 2025-05-29  281  static int __init kexec_bpf_prog_run_init(void)
536de0ba3b982c Pingfan Liu 2025-05-29  282  {
536de0ba3b982c Pingfan Liu 2025-05-29 @283  	return register_btf_fmodret_id_set(&kexec_modify_return_set);
536de0ba3b982c Pingfan Liu 2025-05-29  284  }
536de0ba3b982c Pingfan Liu 2025-05-29  285  late_initcall(kexec_bpf_prog_run_init);
536de0ba3b982c Pingfan Liu 2025-05-29  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


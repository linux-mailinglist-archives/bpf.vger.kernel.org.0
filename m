Return-Path: <bpf+bounces-64084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19360B0E285
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E0AA0405
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566627FB3A;
	Tue, 22 Jul 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8o2mR+a"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDB27FB21
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205006; cv=none; b=c7p93hEqGsCWVIlWEQH13xa/D3y3kxGAExIzBcnzJBSME2CitwhzYsxSwk0yk5da5aGMJp0xklPUbgpezs9vUBgPsBcwp4l8acSwpHajUeQErlgXgtxH02r9H5hh5NZw02wo4gDIcdFqzTynoitN/AFvHLBFcH+4TuMdkRDu//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205006; c=relaxed/simple;
	bh=8tLBsgDMoKYn/cmEEtG36C5Re6c2A8hBzfa0rJS9qf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxL1QSzZt46pLNC4+p8y400OrzldA6lVJ1yXPHhfZMjxw7dwYnpvDlSkCD41mADePnRX1EWiq6OKiyN/gyrgMXT6gNeXTstgHf/Nmz1uDmRhS9EbB7oqQ+sBxZoFiw/pnYgXzOpQxHS2eUP7WTxt2s8/guRFHByDb08VQpG4EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8o2mR+a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753205004; x=1784741004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tLBsgDMoKYn/cmEEtG36C5Re6c2A8hBzfa0rJS9qf8=;
  b=N8o2mR+a9KjgfRSNpYdrYfIQBSuJt07o18tIrUgIPMUIjrsrOi3R2I0K
   4ylewetzFSwCcxBu7y+dL74JJL/s1wcOctk5bDgtbeOOhJaVFZw0NQyCr
   dueVEg2xCxFivuzGEK7NY2Ild8CdESix5NvO6yP6xBJKdbjQj4ACsFpsw
   Y4BSjYsi6AAh48qVw+n/qYstfOP9DGKvzXZ039jCVUE1X53O8VzcKK9tj
   2ZcFSRqA2h/r9LLM86nc+DjXO7DAOce/F6Xtrs03GBmipK0umnTqWYUpp
   q29trTo4puswfe4E+0kWlSykhzT19nhqzK1Hp6CtQUY+CnD5AQq/qXaPL
   Q==;
X-CSE-ConnectionGUID: p3xOGf+ERK68CzVPg5zJjg==
X-CSE-MsgGUID: GNP1jpavTz2fjIPFwCPNIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55617287"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55617287"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:23:23 -0700
X-CSE-ConnectionGUID: T62YgRhbStu03UHmIKqpvQ==
X-CSE-MsgGUID: vlVplxbJSAyI/3mxscLURw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158503142"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 22 Jul 2025 10:23:17 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueGhv-000IaD-1j;
	Tue, 22 Jul 2025 17:23:15 +0000
Date: Wed, 23 Jul 2025 01:22:56 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
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
	bpf@vger.kernel.org
Subject: Re: [PATCHv4 08/12] kexec: Factor out routine to find a symbol in ELF
Message-ID: <202507230016.NQ1WXqwG-lkp@intel.com>
References: <20250722020319.5837-9-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722020319.5837-9-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master arm64/for-next/core linus/master v6.16-rc7]
[cannot apply to bpf-next/master next-20250722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250722-100843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250722020319.5837-9-piliu%40redhat.com
patch subject: [PATCHv4 08/12] kexec: Factor out routine to find a symbol in ELF
config: x86_64-buildonly-randconfig-006-20250722 (https://download.01.org/0day-ci/archive/20250723/202507230016.NQ1WXqwG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230016.NQ1WXqwG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230016.NQ1WXqwG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/crash_dump.h:5,
                    from drivers/of/fdt.c:11:
>> include/linux/kexec.h:544:7: error: unknown type name 'Elf_Sym'
     544 | const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
         |       ^~~~~~~
>> include/linux/kexec.h:544:38: error: unknown type name 'Elf_Ehdr'
     544 | const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
         |                                      ^~~~~~~~


vim +/Elf_Sym +544 include/linux/kexec.h

   542	
   543	#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
 > 544	const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
   545	#endif
   546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


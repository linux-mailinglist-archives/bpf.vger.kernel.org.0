Return-Path: <bpf+bounces-41162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A24D9939CA
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 00:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A33B2278C
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCE818C921;
	Mon,  7 Oct 2024 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjcvcs5K"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950218A6DC
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338724; cv=none; b=a5Y6DAXVoyfh6SszO2eVRRPdhCIuBByD8rUVs+IX6funbtHOTMQYIPuFYROM6u2MGOWzvfGeKy4x7VTA3ZoNsx+jsJ+6+8IUzdTXowSA+P6opPtCimGXhdubB9dctqX6xC4XbmToNcU4zeG3JUj2Z8OReuCq0+5uhgBAaHjRib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338724; c=relaxed/simple;
	bh=oIj3C0UNERAkSq7dsNIls8egQg4SVPQoiy+1eSGZ+kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ6lhUmFHr3Q4ghpSjFiD0J8PIE8A73f1lT08bI3IbtDO1dmCwboDm5GfLLvXw9Xewrdh+1zPkU/zt5UW3HwEUb2/zbuo37N5lMFdKmSnNgJOvSSY+i7HawyLh4g9Oi7Xe+xY811wUHepr4fweQug1Gn/m2CINHQhjI6N6rxU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjcvcs5K; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728338721; x=1759874721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oIj3C0UNERAkSq7dsNIls8egQg4SVPQoiy+1eSGZ+kg=;
  b=gjcvcs5KwUQhnTMBmDmYPA0l8vxxkwbfX82fTmVNthUdZADoIUK1GzQJ
   cYyS4nG/VPiU5OLWtmFKZg9wPQ0FMcNF6QXo2Me1+MHBK99YCUB09CU5Z
   dSnu2Oy9Wjh3wofplM8wcJipDC15nkJRzxNw9KVudgw5RBX7Rb8lNiBaG
   S/CROXiDwL9A3ziq+jO/cqkEEksxxnBXlCUHgXSNwSVn2Z+BlkscRlTTy
   th5QUW9wbii5eKnlNJa1TcEWWIZgjRgbGatoNcOf0J4JWqdEPIOS1IpeO
   W5ZehoZdDAh/2vlyBlg1h5uPq8F/vLJwSWX3bMSHHrdtPZPc3iTgsokZf
   A==;
X-CSE-ConnectionGUID: iylVNtSsRBWD4aebmqeNQQ==
X-CSE-MsgGUID: bKy8Bog1QRy/6c2KqhlN9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="31206137"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="31206137"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 15:05:20 -0700
X-CSE-ConnectionGUID: nLMR5d2VTqyouUNDcAFRvQ==
X-CSE-MsgGUID: WeiY/PSfQD6pXisMILBWMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80233247"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Oct 2024 15:05:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxvqt-0005ac-0X;
	Mon, 07 Oct 2024 22:05:15 +0000
Date: Tue, 8 Oct 2024 06:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, toke@redhat.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, puranjay@kernel.org,
	xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
	leon.hwang@linux.dev, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
Message-ID: <202410080554.slh2FEXJ-lkp@intel.com>
References: <20241006130130.77125-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006130130.77125-2-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Prevent-tailcall-infinite-loop-caused-by-freplace/20241006-210309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241006130130.77125-2-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop caused by freplace
config: arc-nsimosci_hs_defconfig (https://download.01.org/0day-ci/archive/20241008/202410080554.slh2FEXJ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080554.slh2FEXJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410080554.slh2FEXJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-elf-ld: init/do_mounts.o: in function `bpf_extension_link_prog':
>> do_mounts.c:(.text+0x14): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: init/do_mounts.o: in function `bpf_extension_unlink_prog':
>> do_mounts.c:(.text+0x1c): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: init/do_mounts_initrd.o: in function `bpf_extension_link_prog':
   do_mounts_initrd.c:(.text+0x0): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: init/do_mounts_initrd.o: in function `bpf_extension_unlink_prog':
   do_mounts_initrd.c:(.text+0x8): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: init/initramfs.o: in function `bpf_extension_link_prog':
   initramfs.c:(.text+0x44): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: init/initramfs.o: in function `bpf_extension_unlink_prog':
   initramfs.c:(.text+0x4c): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/kernel/ptrace.o: in function `bpf_extension_link_prog':
   ptrace.c:(.text+0x13f4): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/kernel/ptrace.o: in function `bpf_extension_unlink_prog':
   ptrace.c:(.text+0x13fc): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/kernel/process.o: in function `bpf_extension_link_prog':
   process.c:(.text+0x174): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/kernel/process.o: in function `bpf_extension_unlink_prog':
   process.c:(.text+0x17c): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/kernel/signal.o: in function `bpf_extension_link_prog':
   signal.c:(.text+0x45c): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/kernel/signal.o: in function `bpf_extension_unlink_prog':
   signal.c:(.text+0x464): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/kernel/sys.o: in function `bpf_extension_link_prog':
   sys.c:(.text+0x0): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/kernel/sys.o: in function `bpf_extension_unlink_prog':
   sys.c:(.text+0x8): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/kernel/perf_event.o: in function `bpf_extension_link_prog':
   perf_event.c:(.text+0xbb4): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/kernel/perf_event.o: in function `bpf_extension_unlink_prog':
   perf_event.c:(.text+0xbbc): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/mm/fault.o: in function `bpf_extension_link_prog':
   fault.c:(.text+0x28): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/mm/fault.o: in function `bpf_extension_unlink_prog':
   fault.c:(.text+0x30): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: arch/arc/mm/cache.o: in function `bpf_extension_link_prog':
   cache.c:(.text+0x2f4): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: arch/arc/mm/cache.o: in function `bpf_extension_unlink_prog':
   cache.c:(.text+0x2fc): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/fork.o: in function `bpf_extension_link_prog':
   fork.c:(.text+0x1090): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/fork.o: in function `bpf_extension_unlink_prog':
   fork.c:(.text+0x1098): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/exec_domain.o: in function `bpf_extension_link_prog':
   exec_domain.c:(.text+0x14): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/exec_domain.o: in function `bpf_extension_unlink_prog':
   exec_domain.c:(.text+0x1c): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/cpu.o: in function `bpf_extension_link_prog':
   cpu.c:(.text+0xbec): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/cpu.o: in function `bpf_extension_unlink_prog':
   cpu.c:(.text+0xbf4): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/exit.o: in function `bpf_extension_link_prog':
   exit.c:(.text+0x6b4): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/exit.o: in function `bpf_extension_unlink_prog':
   exit.c:(.text+0x6bc): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/softirq.o: in function `bpf_extension_link_prog':
   softirq.c:(.text+0xe88): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/softirq.o: in function `bpf_extension_unlink_prog':
   softirq.c:(.text+0xe90): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/resource.o: in function `bpf_extension_link_prog':
   resource.c:(.text+0xb68): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/resource.o: in function `bpf_extension_unlink_prog':
   resource.c:(.text+0xb70): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/sysctl.o: in function `bpf_extension_link_prog':
   sysctl.c:(.text+0x14f4): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/sysctl.o: in function `bpf_extension_unlink_prog':
   sysctl.c:(.text+0x14fc): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/capability.o: in function `bpf_extension_link_prog':
   capability.c:(.text+0x718): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/capability.o: in function `bpf_extension_unlink_prog':
   capability.c:(.text+0x720): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/ptrace.o: in function `bpf_extension_link_prog':
   ptrace.c:(.text+0x580): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/ptrace.o: in function `bpf_extension_unlink_prog':
   ptrace.c:(.text+0x588): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/signal.o: in function `bpf_extension_link_prog':
   signal.c:(.text+0x1118): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/signal.o: in function `bpf_extension_unlink_prog':
   signal.c:(.text+0x1120): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/sys.o: in function `bpf_extension_link_prog':
   sys.c:(.text+0xf70): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/sys.o: in function `bpf_extension_unlink_prog':
   sys.c:(.text+0xf78): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/umh.o: in function `bpf_extension_link_prog':
   umh.c:(.text+0x5c0): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/umh.o: in function `bpf_extension_unlink_prog':
   umh.c:(.text+0x5c8): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/workqueue.o: in function `bpf_extension_link_prog':
   workqueue.c:(.text+0x55a8): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/workqueue.o: in function `bpf_extension_unlink_prog':
   workqueue.c:(.text+0x55b0): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/pid.o: in function `bpf_extension_link_prog':
   pid.c:(.text+0x308): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/pid.o: in function `bpf_extension_unlink_prog':
   pid.c:(.text+0x310): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/extable.o: in function `bpf_extension_link_prog':
   extable.c:(.text+0x0): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/extable.o: in function `bpf_extension_unlink_prog':
   extable.c:(.text+0x8): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here
   arc-elf-ld: kernel/params.o: in function `bpf_extension_link_prog':
   params.c:(.text+0x918): multiple definition of `bpf_extension_link_prog'; init/main.o:main.c:(.text+0x5dc): first defined here
   arc-elf-ld: kernel/params.o: in function `bpf_extension_unlink_prog':
   params.c:(.text+0x920): multiple definition of `bpf_extension_unlink_prog'; init/main.o:main.c:(.text+0x5e4): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


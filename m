Return-Path: <bpf+bounces-64083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCCB0E215
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34B51C84353
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B67248F60;
	Tue, 22 Jul 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihS9mnO/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8719309C
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202541; cv=none; b=ZuAcBOL85rnODokVpDK/xvUi7fYDMXgFn8+l65b8GRyqaE8SmVWSxq0dhhmajp2XNzBoxt/mlBCdmf4cBuai+8uoldPSwYP5TLK9Wku3K35+jr5iY+PukAU3NNQqhmdTDXKp59g7EjgwiMa99QClr25HagJRvqjnUcVTJs2iI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202541; c=relaxed/simple;
	bh=RaJ+Jpxw4Z1gkEyO0AntIYQXlU/FNtY01F1LH3AHnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBBhQIlwTB334Hm6jIVNCUuC+H0HrxAZeSenAjL7BPGRqoEK1LTL+R8WS+IDLIKPPmSOIJqmJdt8WqKrXNsggzbftaF+EpAkvBJQSmiTGtyWa9Oo40jnbM6rJLRCX562GzAAeT7lUnyIuL41Otzd3JX+nLikgTWn4iCeABgKTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihS9mnO/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753202541; x=1784738541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RaJ+Jpxw4Z1gkEyO0AntIYQXlU/FNtY01F1LH3AHnLs=;
  b=ihS9mnO//BPmrALLZ+4O8qbyVB6QKIIo7rsZRamN0B0SePN5jMxmkBHE
   8kzyZxtd3NpApNO06CRYpmymWLVrUr35e/WdGJsCxczKsfKp7TyPImAj5
   0pkKFnp3nvqOoi0QxDhjimv6ongeMYwq4w8rdJmX3fAa6JlrBXcazgqnR
   hDJeLg2O8G3Usq2Jr68g92WeKFSnn7K2SMjIkjukymxA2T9LiW+zuYfKN
   7iWYnvzilw+WiP9XYJflu4AveP90l7IbzRLlBBh4xS0sfR/L+x/Gk5Bze
   0xRtZcKrE6cVfqIPCxBiQiWo8k3LRjvnf2s9bdiTGV+u8lNffNb/6NEu2
   w==;
X-CSE-ConnectionGUID: jsdiqXqER6yLZcNS2d9fLg==
X-CSE-MsgGUID: /SMmmjt0TxSd05kLspGFnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55611989"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55611989"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:42:20 -0700
X-CSE-ConnectionGUID: QdnwgSZkTSWNugI+qCkkpw==
X-CSE-MsgGUID: OnyzoUzLQze6vfH2jpY8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163430987"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Jul 2025 09:42:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueG49-000IXj-0d;
	Tue, 22 Jul 2025 16:42:09 +0000
Date: Wed, 23 Jul 2025 00:42:08 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, bpf@vger.kernel.org
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
	kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCHv4 03/12] bpf: Introduce bpf_copy_to_kernel() to buffer
 the content from bpf-prog
Message-ID: <202507230035.9xLXz9Js-lkp@intel.com>
References: <20250722020319.5837-4-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722020319.5837-4-piliu@redhat.com>

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
patch link:    https://lore.kernel.org/r/20250722020319.5837-4-piliu%40redhat.com
patch subject: [PATCHv4 03/12] bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
config: x86_64-buildonly-randconfig-003-20250722 (https://download.01.org/0day-ci/archive/20250723/202507230035.9xLXz9Js-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230035.9xLXz9Js-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230035.9xLXz9Js-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/bpf/helpers_carrier.c:84:17: warning: no previous prototype for 'bpf_mem_range_result_put' [-Wmissing-prototypes]
      84 | __bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers_carrier.c:93:17: warning: no previous prototype for 'bpf_copy_to_kernel' [-Wmissing-prototypes]
      93 | __bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
         |                 ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers_carrier.c: In function 'bpf_copy_to_kernel':
>> kernel/bpf/helpers_carrier.c:124:9: warning: enumeration value 'TYPE_VMAP' not handled in switch [-Wswitch]
     124 |         switch (alloc_type) {
         |         ^~~~~~
--
>> ld: mm/mmu_notifier.o:mm/mmu_notifier.c:25: multiple definition of `__pcpu_unique_srcu_srcu_data'; kernel/bpf/helpers_carrier.o:kernel/bpf/helpers_carrier.c:13: first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


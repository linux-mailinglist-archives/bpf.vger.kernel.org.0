Return-Path: <bpf+bounces-16710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA35804AC2
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 07:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9291C20EAC
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C8B1426A;
	Tue,  5 Dec 2023 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPKQy4ro"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D05FF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701759431; x=1733295431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNMOu/BOQarVCNtXuCbvjvKot05Y6DVsiWZ/fLy6Z18=;
  b=fPKQy4roog3sUIh/vP5BFZKZ2WHqODuMa7sTpvTUtqbbEJ4ALHTbnn4r
   LscmdjO5s1UXS51YmHXbvWS1bSBUXAJJpwl0Tcikr5aJKkCwlni+uAOHT
   8BoUNxeQtKyZH++a3699PaEufuAXD8o71tJDmWU1t+O6N3nJleeoM4zPJ
   DIyIEHV91LnDAgJAOO7S/Ueo/GTuSBVHRFbWKi+xeNBY8OuJs1BFtpGGa
   GZ4jH0GhmTftNKz+q7xRl+joV5NeycvN6AqhVpzpKTRr73z2wPIZiZqTK
   KluuEGqy0V91lvIW1kK7m9DtSAvdk8aycZbZs4X+oe5ZqAjUUqee7+JEH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="393588170"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="393588170"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888822395"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="888822395"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2023 22:57:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAPMe-0008TS-22;
	Tue, 05 Dec 2023 06:57:04 +0000
Date: Tue, 5 Dec 2023 14:56:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf 1/2] bpf: Fix prog_array_map_poke_run map poke
 update
Message-ID: <202312051420.clYpN744-lkp@intel.com>
References: <20231203204851.388654-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203204851.388654-2-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/bpf-Fix-prog_array_map_poke_run-map-poke-update/20231204-045204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20231203204851.388654-2-jolsa%40kernel.org
patch subject: [PATCHv3 bpf 1/2] bpf: Fix prog_array_map_poke_run map poke update
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051420.clYpN744-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051420.clYpN744-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051420.clYpN744-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/arraymap.c:1015:13: warning: no previous prototype for 'bpf_arch_poke_desc_update' [-Wmissing-prototypes]
    1015 | void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_arch_poke_desc_update +1015 kernel/bpf/arraymap.c

  1014	
> 1015	void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
  1016					      struct bpf_prog *new, struct bpf_prog *old)
  1017	{
  1018		WARN_ON_ONCE(1);
  1019	}
  1020	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


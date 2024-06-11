Return-Path: <bpf+bounces-31797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F29903857
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA9B21C27
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA577178367;
	Tue, 11 Jun 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhGNiTFi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0FE57E;
	Tue, 11 Jun 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100320; cv=none; b=k5xieUGz/V32mT2+1Vy91vEF6G9OZYCQR/ApJhKMXQzQ6SOO1g6/45M3408A1Qfjw4QeIcJ7h1BdXGMtszURvsp9KVMTgoXxlM3jCaLwAy7rekKbS5SUgRGEWj/wLJnD0DZkrg8Pe967JpBUPpFmtShqNIwUwCh6OJSKB+fLp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100320; c=relaxed/simple;
	bh=z7xGmJO7rnhCGOUXwfuTKI3+a9YP3yCgBsSXkvQaVaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvDjhntNOXplnI2zfW1hMOCV7Wuzaiqe/y9fGPrBmP4hMRYhfSb+raKY/41ayd7AWKPc6SKrg9gBE7+Z8Jf79Zn14F/qmZv42D6UCtEucIQOsKueySl0k7kMX69jSyHIGRI4h6TFqsZ33frppJUPOQx9JpkYjINPxwrhgRp7kUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhGNiTFi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718100319; x=1749636319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z7xGmJO7rnhCGOUXwfuTKI3+a9YP3yCgBsSXkvQaVaY=;
  b=YhGNiTFicONEy0kjzU2FfrwnB82Y5t2mIoQ4TmHRTatD9XbA3bxZ8GH3
   Boz/zZgGEk+/Y+chRx8ycGC4AfJSaAOeH1sHqaXsIO9o6X8DvYbiu/zBf
   TOpuseQAqmVfmWCHslmQI64DvrhghkjxO4VPNxqGRqKjbJdxLUTLUIWvY
   Bh1zBP2OxeCmVK4tDZ1yz+SuFa58x3tdcxOoTx+LQ2KcaN4jw6YyJkuNO
   yUob0//sZOnrHpwPh+LlsVG23ZEjXiimchCLMDKeN16eJL25f5ltE5GmW
   C8vVmA6m6kmmnLiv6qljo4n9+/8WY7Khpk9L99xFWvgGFiQJfkEO1n+qB
   g==;
X-CSE-ConnectionGUID: DhkG1XLEQZirbEh/jkR7mQ==
X-CSE-MsgGUID: zcHgPH2LQaqnLcnIy7iKoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14594746"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14594746"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 03:05:18 -0700
X-CSE-ConnectionGUID: 5bvUzqKTTQ+bpYeibA3XFA==
X-CSE-MsgGUID: SSE3ON8XRCGqRRkpNt+zsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="43782832"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2024 03:05:13 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGyNK-0000IE-2Y;
	Tue, 11 Jun 2024 10:05:10 +0000
Date: Tue, 11 Jun 2024 18:05:02 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Bland <mbland@motorola.com>,
	"open list:BPF (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] cfi: add C CFI type macro
Message-ID: <202406111716.SluzXu9X-lkp@intel.com>
References: <cwhnmpn5yvg6ma7mvjviy4p7z6gdoba57daeprpc4zcokfhpv2@44gvdmcfuspt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cwhnmpn5yvg6ma7mvjviy4p7z6gdoba57daeprpc4zcokfhpv2@44gvdmcfuspt>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Bland/arm64-cfi-bpf-Support-kCFI-BPF-on-arm64/20240611-021203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/cwhnmpn5yvg6ma7mvjviy4p7z6gdoba57daeprpc4zcokfhpv2%4044gvdmcfuspt
patch subject: [PATCH bpf-next v5 1/3] cfi: add C CFI type macro
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240611/202406111716.SluzXu9X-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4403cdbaf01379de96f8d0d6ea4f51a085e37766)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111716.SluzXu9X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111716.SluzXu9X-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/cfi.c:85:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      85 | DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
         | ^
         | int
>> arch/riscv/kernel/cfi.c:85:17: error: a parameter list without types is only allowed in a function definition
      85 | DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
         |                 ^
   arch/riscv/kernel/cfi.c:89:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      89 | DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
         | ^
         | int
   arch/riscv/kernel/cfi.c:89:17: error: a parameter list without types is only allowed in a function definition
      89 | DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
         |                 ^
   4 errors generated.


vim +/int +85 arch/riscv/kernel/cfi.c

    81	
    82	/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
    83	extern unsigned int __bpf_prog_runX(const void *ctx,
    84					    const struct bpf_insn *insn);
  > 85	DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


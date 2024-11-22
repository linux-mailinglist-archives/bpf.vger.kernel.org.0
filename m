Return-Path: <bpf+bounces-45441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69889D57CF
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 02:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E6283736
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D5159583;
	Fri, 22 Nov 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyZyMEgV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DC70838
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239993; cv=none; b=hw/U1Rr1+VR5wGQVWcIkpZFp1KvZhzZBUKWlHtDs268C6dXxxsaGtSwWyi3ZiMpPRSMwAm2lv7UsFc+kS0R7vaSvdj+DcOa9yBf+RhDm5hiPeZfyMIO4/EKNtCxmhb0u7QrarXA8krXngStvd8Pgdc0EDwFhI9tSDRikZf2czZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239993; c=relaxed/simple;
	bh=HBiZ5A3cf4idLSmkrO0MAZGOss+NWf0g5r+k3J1LpbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX34QkM2EZZVdM3I7oyj5VVvls/Y2UYpW8JEhVjCT1rOk5ngm5wKGZWZOrTy5KvjGTUZK3aLIPeleeUl5js68qYao4pcozUBv5L2iRneN/ULoSw6RWWjpBqFCRxPTo/1/BP5N8EdIHMlGR0gYymXP+YbHTqxhrwLZQ9AAxxet7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyZyMEgV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732239989; x=1763775989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HBiZ5A3cf4idLSmkrO0MAZGOss+NWf0g5r+k3J1LpbY=;
  b=nyZyMEgVsi1wWPDdGz5FM16Bbp0cWf6cLN11BVV+nPbd5iYVcZJfzH+q
   ZNZq0aUHfmad9nEL22SZuIKBxFRmsus3cMQjdOSEKfwN8Sa/c3Zsy/VuA
   RYfP7LBwR2KwOfugJSIrLIyTggFDDKElQDQjHXHno3cpRX/rXNJJDjTbG
   xPBrD+7thMj0PcF1n23+2SIMC4DLiXSxdBRcpV7llp4NhQWCEigkOmMgM
   AuYO+2ksvGmperf8DrNZ1t4EurUlcN/f6wwYgdNBHsdNbGSHhU79dlnXY
   6vKAzSfvrSfvjSngAaQFkjfgLKFPYsOp1t0/f0a89grbz8E44pIyWb6hS
   g==;
X-CSE-ConnectionGUID: upkYNRzfRmG78vsqcDJkXQ==
X-CSE-MsgGUID: HLKVhjGyQmKO912YzBSzXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43447921"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="43447921"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 17:46:28 -0800
X-CSE-ConnectionGUID: 8l0BhaZlQ6KSQXy2r/2OkQ==
X-CSE-MsgGUID: KDVZrKewQnGOlzGfPTguBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="113716353"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2024 17:46:26 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEIka-0003Yr-1a;
	Fri, 22 Nov 2024 01:46:24 +0000
Date: Fri, 22 Nov 2024 09:46:07 +0800
From: kernel test robot <lkp@intel.com>
To: Alastair Robertson <ajor@meta.com>, bpf@vger.kernel.org,
	andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alastair Robertson <ajor@meta.com>
Subject: Re: [PATCH bpf-next] libbpf: Extend linker API to support in-memory
 ELF files
Message-ID: <202411220938.1TZjtSM3-lkp@intel.com>
References: <20241120170206.2592931-1-ajor@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120170206.2592931-1-ajor@meta.com>

Hi Alastair,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alastair-Robertson/libbpf-Extend-linker-API-to-support-in-memory-ELF-files/20241121-152231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241120170206.2592931-1-ajor%40meta.com
patch subject: [PATCH bpf-next] libbpf: Extend linker API to support in-memory ELF files
config: sparc-randconfig-002-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220938.1TZjtSM3-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220938.1TZjtSM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220938.1TZjtSM3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> linker.c:2733:5: error: no previous prototype for 'linker_finalize_common' [-Werror=missing-prototypes]
    2733 | int linker_finalize_common(struct bpf_linker *linker)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:105: tools/bpf/resolve_btfids/libbpf/staticobjs/linker.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
   make[5]: *** [Makefile:165: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
   make[4]: *** [Makefile:63: tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
   make[3]: *** [Makefile:76: bpf/resolve_btfids] Error 2 shuffle=1440844219
   make[2]: *** [Makefile:1370: tools/bpf/resolve_btfids] Error 2 shuffle=1440844219
   <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2 shuffle=1440844219
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2 shuffle=1440844219
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


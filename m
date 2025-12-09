Return-Path: <bpf+bounces-76377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8566ACB0CAA
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F19C30F2392
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE272E92BC;
	Tue,  9 Dec 2025 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWXXC3mc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC92D879F;
	Tue,  9 Dec 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303568; cv=none; b=RyXPBCxQTIZTIhANP0Ie0Klv7EGCkwrkam/2/qHC7M7vMVW4HBZLi8O52QlIfP4SiUlCc6v6R58ukRsUp00sLDJKWMsLa4u2toiZ7cOPThNCqAN3rhuyWMHunwbMGrnbM6dSf2nyNVIeDGUPumm2HZUhmlhu8D7re/O8vGKPVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303568; c=relaxed/simple;
	bh=07h+7iBXoZF2/As0GV/qDmBkKOgLQ1vyvDX4HcfGzyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDLmAfaZ0CS4JBEGWp5ZroxiJk4HCV6IIEaMr5Z3JzcAz30igZrJDL7wKeq0lZvLY10IH76K7qbNp2XeOoMooivDs35ZS3kNMY/t+XZiqxXMducvNm97HvEvTkO8Ql5cGUEuI/y1Mqd4sm4gZcE5AOMcGbfzCBNezY1XZgJwQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWXXC3mc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765303567; x=1796839567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=07h+7iBXoZF2/As0GV/qDmBkKOgLQ1vyvDX4HcfGzyM=;
  b=XWXXC3mc2wmw8DUjiQrzZwHnEY0i80WZdq6+BfXeTQWY8J69DUE6jx9L
   eeJYAx9+eMqft95qSOhU29t2BLGYlJn3ani0aAhZYUWqzSc7T/EBAGLIw
   SXkfwZebThzo3N6Ivy29Vifi95y/BZ4IbFYd7DMs8zfnDwsS/s3c4myI1
   Ya7kDRbPcTSHw9X9PzfXF4boZmj4Xjg8LCXiGvdvYFpxZ1Nkf+JGctF3m
   G96e2ZsgEhY/SbWqi1XPnUIpTtm3SNvoTJ5db5g/UrQNegv0QHUVBpuL1
   Ibs7GZFEjEzEzjVciDto5LrcGXBhvHNEWP4b2pf8l+FxI0WTZdu9OhEX0
   Q==;
X-CSE-ConnectionGUID: sV+0WTshSBy8BqA5D4I6OQ==
X-CSE-MsgGUID: Fhn/4Q5vQkSG++LUP4VBDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="84680292"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="84680292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:06:06 -0800
X-CSE-ConnectionGUID: xx2RS3ENS1mxbMIde3HKOQ==
X-CSE-MsgGUID: Q8HV4iIJR0mlQaeYpVEStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="227325758"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Dec 2025 10:05:59 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT261-0000000028F-1sZw;
	Tue, 09 Dec 2025 18:05:57 +0000
Date: Wed, 10 Dec 2025 02:05:05 +0800
From: kernel test robot <lkp@intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>, aou@eecs.berkeley.edu,
	alex@ghiti.fr, andii@kernel.org, andybnac@gmail.com,
	apatel@ventanamicro.com, ast@kernel.org, ben.dooks@codethink.co.uk,
	bjorn@kernel.org, bpf@vger.kernel.org, charlie@rivosinc.com,
	cl@gentwo.org, conor.dooley@microchip.com, cyrilbur@tenstorrent.com,
	daniel@iogearbox.net, debug@rivosinc.com, dennis@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk, martin.lau@linux.dev, palmer@dabbelt.com,
	pjw@kernel.org, puranjay@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
Message-ID: <202512100134.TRTNjFGL-lkp@intel.com>
References: <20251208034944.73113-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208034944.73113-3-cuiyunhui@bytedance.com>

Hi Yunhui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.18 next-20251209]
[cannot apply to bpf-next/net bpf-next/master bpf/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/riscv-remove-irqflags-h-inclusion-in-asm-bitops-h/20251208-115407
base:   linus/master
patch link:    https://lore.kernel.org/r/20251208034944.73113-3-cuiyunhui%40bytedance.com
patch subject: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
config: riscv-randconfig-r132-20251209 (https://download.01.org/0day-ci/archive/20251210/202512100134.TRTNjFGL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100134.TRTNjFGL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512100134.TRTNjFGL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/gfs2/file.c: note: in included file (through include/linux/irqflags.h, include/linux/spinlock.h, include/linux/mmzone.h, ...):
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
--
   fs/gfs2/trans.c: note: in included file (through include/linux/irqflags.h, include/linux/spinlock.h, include/linux/sched.h):
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/riscv/include/asm/percpu.h:113:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)

vim +113 arch/riscv/include/asm/percpu.h

   108	
   109	#define PERCPU_OP_8_16(op_name, op, expr, final_op)			\
   110		PERCPU_8_16_OP(op_name, op, 8, .b, u8, expr, final_op);		\
   111		PERCPU_8_16_OP(op_name, op, 16, .h, u16, expr, final_op)
   112	
 > 113	PERCPU_OP_8_16(add, add, val, add)
   114	PERCPU_OP_8_16(andnot, and, ~val, and)
   115	PERCPU_OP_8_16(or, or, val, or)
   116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


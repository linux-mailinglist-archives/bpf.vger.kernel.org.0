Return-Path: <bpf+bounces-62813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA4AFEFB0
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692E25873AB
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A4225A24;
	Wed,  9 Jul 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bF6Pag4R"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D81E5B6A;
	Wed,  9 Jul 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081604; cv=none; b=utb+Imh05mXod1uswMnZSHmCJtIUq/VMIz3bBEs9Ykoszx4nojIypIeYpNqdPCiUxqV2BT5q+gCs2tEuMz8u1x/mDNWK5WNZEgv4AbHyryUB8jHxoElJWaFUprRPDv3IlQc2mEhEV1/IB7NHZkWMkbqaaWu2CpfP+xEL9BqvFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081604; c=relaxed/simple;
	bh=K15coVbUq4k5YO1LhyiQD1STXDhuD3lAUmzmXi1CD3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtsineCb+DQpI08acFPfXrvSyZK5Mj1JhblwqFJJGqRcFGt5V58TEjhbmlDUL6owMti5q5QEb3OtuN1Cy9g8VQLfnxsoONWsXGiclnEWzBcBwnR0ZH/O1WmWRV6l7o4I/G6obYOpIKUQUxcFqaJxTp+fBCUOYG7PJyuyYUSZlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bF6Pag4R; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752081602; x=1783617602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K15coVbUq4k5YO1LhyiQD1STXDhuD3lAUmzmXi1CD3M=;
  b=bF6Pag4RTL60ghrRKnIhz/BPr9zPOdmQ6ttfrM/FZY6B5DustvkMsHcu
   ytf3ppCAj6EbwvWDKBEH5CGaH14vdOxLwL3409AIVwmtc+iK4kwzNx3Ad
   iZYgI68c324Jfqjm+wbeiVXsoiCenDH9Scy7et1X4FlBamLnRqe9gsqnO
   L5mmVsTYd7f5LmXOoAcHqqVA8Ho+kE8BWerRKgkECIT4TvDZqJJqgWgiu
   1QkPe3Oxafhtz8PxRUad5QSktWBgkm21O+kH1Y7rpu2F6lgYqfk9yD3fK
   JLw0nTcOwe1blAre8rcKNmaYNiUTxlTUxIte8G7z29en2cOr5ipISerz+
   A==;
X-CSE-ConnectionGUID: thitIZd4SRWNva4ziec21Q==
X-CSE-MsgGUID: S5OhqQbyQ9KO6G35NhR+xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65804717"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65804717"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 10:20:02 -0700
X-CSE-ConnectionGUID: vSW8DNRFTWGF6nHkoYHjIw==
X-CSE-MsgGUID: HrO1BL03TfOGbKFygymHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155247055"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2025 10:19:56 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZYSX-0003oJ-2m;
	Wed, 09 Jul 2025 17:19:53 +0000
Date: Thu, 10 Jul 2025 01:19:26 +0800
From: kernel test robot <lkp@intel.com>
To: Chenghao Duan <duanchenghao@kylinos.cn>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com, chenhuacai@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, kernel@xen0n.name, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, bpf@vger.kernel.org,
	guodongtai@kylinos.cn, duanchenghao@kylinos.cn,
	youling.tang@linux.dev, jianghaoran@kylinos.cn
Subject: Re: [PATCH v3 5/5] LoongArch: BPF: Add bpf trampoline support for
 Loongarch
Message-ID: <202507100034.wXofj6VX-lkp@intel.com>
References: <20250709055029.723243-6-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709055029.723243-6-duanchenghao@kylinos.cn>

Hi Chenghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master linus/master v6.16-rc5 next-20250709]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chenghao-Duan/LoongArch-Add-the-function-to-generate-the-beq-and-bne-assembly-instructions/20250709-135350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250709055029.723243-6-duanchenghao%40kylinos.cn
patch subject: [PATCH v3 5/5] LoongArch: BPF: Add bpf trampoline support for Loongarch
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250710/202507100034.wXofj6VX-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250710/202507100034.wXofj6VX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507100034.wXofj6VX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/loongarch/net/bpf_jit.c:1411:6: warning: variable 'ip' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1411 |         if (addr && ctx->image && ctx->ro_image)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/net/bpf_jit.c:1414:51: note: uninitialized use occurs here
    1414 |         return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, ip, addr);
         |                                                          ^~
   arch/loongarch/net/bpf_jit.c:1411:2: note: remove the 'if' if its condition is always true
    1411 |         if (addr && ctx->image && ctx->ro_image)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1412 |                 ip = (u64)(ctx->image + ctx->idx);
>> arch/loongarch/net/bpf_jit.c:1411:6: warning: variable 'ip' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
    1411 |         if (addr && ctx->image && ctx->ro_image)
         |             ^~~~~~~~~~~~~~~~~~
   arch/loongarch/net/bpf_jit.c:1414:51: note: uninitialized use occurs here
    1414 |         return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, ip, addr);
         |                                                          ^~
   arch/loongarch/net/bpf_jit.c:1411:6: note: remove the '&&' if its condition is always true
    1411 |         if (addr && ctx->image && ctx->ro_image)
         |             ^~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/net/bpf_jit.c:1411:6: warning: variable 'ip' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
    1411 |         if (addr && ctx->image && ctx->ro_image)
         |             ^~~~
   arch/loongarch/net/bpf_jit.c:1414:51: note: uninitialized use occurs here
    1414 |         return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, ip, addr);
         |                                                          ^~
   arch/loongarch/net/bpf_jit.c:1411:6: note: remove the '&&' if its condition is always true
    1411 |         if (addr && ctx->image && ctx->ro_image)
         |             ^~~~~~~
   arch/loongarch/net/bpf_jit.c:1409:8: note: initialize the variable 'ip' to silence this warning
    1409 |         u64 ip;
         |               ^
         |                = 0
   3 warnings generated.


vim +1411 arch/loongarch/net/bpf_jit.c

  1406	
  1407	static int emit_call(struct jit_ctx *ctx, u64 addr)
  1408	{
  1409		u64 ip;
  1410	
> 1411		if (addr && ctx->image && ctx->ro_image)
  1412			ip = (u64)(ctx->image + ctx->idx);
  1413	
  1414		return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, ip, addr);
  1415	}
  1416	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-37273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5E953651
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091651F223CA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B01A2570;
	Thu, 15 Aug 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keJtk+kj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8C29CE6;
	Thu, 15 Aug 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733674; cv=none; b=sudSH4qgQYhqXoG5IQuoFDPgxQBVPrz+swxJgOcbqa599+vtNtrrKadNkF463DkibPXlxfoi61L6M92DmHqUv3w/Lo4ruRfGVn6hY3GZNMAQoFqiEQdRLdrSOQwLluy0mlrDDpTLvgmXYRXSIOCYAO0VCodsVwOdpeqUevBqTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733674; c=relaxed/simple;
	bh=Y80oca1WAw5Erb23orjNO5DhhZNJNaQybRxhxYwGcRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtKpnObh4mJvPvCBCIbu9JRbU449MSqItZnd3QNokAbgET8U4g3K3qP0n3MyWeGZT87vfZoP/tLcXZMGY8FtDyRoMmw2ExddgRz4dfUcffyHZZ27WQaE/XqAUpy/DstMrxXSkf+pYKySO/pd6POt76AzX5qU4bgD+hP554oTrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keJtk+kj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723733672; x=1755269672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y80oca1WAw5Erb23orjNO5DhhZNJNaQybRxhxYwGcRo=;
  b=keJtk+kja8CX7iV6c1X++5Jc9Pu1N4Z1CgW2O+R4jYT+O1Vx3e/Etym2
   SRArrcK8EoxIBewWZM+zKafrTzAS1lkyuZfO6cNgt7Ota47AQDJnMZYaC
   e3yP7/G22AFgxFiPbN/ShqKWqRxVMLH+wqgIZsJDutB/T4DUqR7RWbXE6
   Pc3SZfWFisqR+KyLyHf7sCZ2qVOHl99U5e//pucyfpY8pxjZWyFjq9X2L
   2aUWQRERBjgpH6Y/mHNDy219Xk8VkI8g1SfKy/wChXq9Fu4bXoX5wOKST
   imLejtvJGITRJAULcl1q3PPBEfMGZc93sXmZvXqZy4a0K56nop7WuUH6H
   A==;
X-CSE-ConnectionGUID: T6ToLK4JQfGu9YgVuPmPiw==
X-CSE-MsgGUID: zBnZ+k0JSf2zOo3d4I/DXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21964130"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="21964130"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 07:54:32 -0700
X-CSE-ConnectionGUID: VReWhAggTk2ijNw8Rz8qsQ==
X-CSE-MsgGUID: 7qaWQcjyQ5GOF/idup3UqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59220785"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2024 07:54:27 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sebrs-0003hy-1A;
	Thu, 15 Aug 2024 14:54:24 +0000
Date: Thu, 15 Aug 2024 22:53:47 +0800
From: kernel test robot <lkp@intel.com>
To: Feng zhou <zhoufeng.zf@bytedance.com>, edumazet@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, dsahern@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: Re: [PATCH] bpf: Fix bpf_get/setsockopt to tos not take effect when
 TCP over IPv4 via INET6 API
Message-ID: <202408152058.YXAnhLgZ-lkp@intel.com>
References: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>

Hi Feng,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master net-next/main net/main linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-zhou/bpf-Fix-bpf_get-setsockopt-to-tos-not-take-effect-when-TCP-over-IPv4-via-INET6-API/20240814-231142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240814084504.22172-1-zhoufeng.zf%40bytedance.com
patch subject: [PATCH] bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240815/202408152058.YXAnhLgZ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408152058.YXAnhLgZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408152058.YXAnhLgZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: net/core/filter.o: in function `__bpf_getsockopt':
>> filter.c:(.text+0xa69c): undefined reference to `is_tcp_sock_ipv6_mapped'
>> filter.c:(.text+0xa69c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `is_tcp_sock_ipv6_mapped'
   or1k-linux-ld: net/core/filter.o: in function `__bpf_setsockopt':
   filter.c:(.text+0xd660): undefined reference to `is_tcp_sock_ipv6_mapped'
   filter.c:(.text+0xd660): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `is_tcp_sock_ipv6_mapped'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


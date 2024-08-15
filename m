Return-Path: <bpf+bounces-37265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99024952E2F
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057DBB27302
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49717C7DA;
	Thu, 15 Aug 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCzo2QrO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E917BEBC;
	Thu, 15 Aug 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724485; cv=none; b=q71rRKdCAiE5S5nDQhHe6T3ErFua2S0O7j5OJet6nVsszOrLld3kF2MyjTDrTuGWWWvaImZA4ERRQe9b8rJZjjjdv5yaB8F7rfFRJc7vQdZE9Be44svGZEsQnUhjzj5dJ12qYLIpYIo8shxwudsj43SW44FDwGM7qwtWZsnoViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724485; c=relaxed/simple;
	bh=kLINGGZfiGZJKTJM8m3ioz0N0Jh+G2wChbSE1siUMpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVhk485sdjDiW6uRJpJEATHx/5OrvmpkiRr6FyGq5HEdfms0eSmP70je1+oTnWnZvUznYeyimkTKHuSaZq9CxSgQJSzMmAafsKESQ8gN9bzy9bM8cWJ3NpCsM2O83xR/xEJug8wyMQ/u00A5T2nx4arCwaYZMOOq8dx+bL77bPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCzo2QrO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724482; x=1755260482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLINGGZfiGZJKTJM8m3ioz0N0Jh+G2wChbSE1siUMpY=;
  b=hCzo2QrOYBoqN5n05uXGQFNuLvt/vc1+rRCTZBph0YlOB3g+w6AoRgf8
   NyICglxC+BLhzFcpniktMzLK6gib6PlY+hQugP6v7qd5z5H9yi4aKrwAQ
   304nyNsqS09YNno1V2zkoMfvqYS/RZlAzvigzmcCZgHM4fcHdsN0hXGeH
   42BdznzXlyd7lUmH3v5qfivHrJ/ZaBInWTcgK9tzEtQpb+SjKGzczuEFa
   RqXbnZvcbMDONGP96erMyQk/yqtT8LmbbnJ0MfZz9zYNZwT+AbZzYRHqk
   Vc9BfMJUzAo4zpTgSqZUHOsn8mFjyaowMu2GWHT2RSogogb+oZn6roYL5
   w==;
X-CSE-ConnectionGUID: hy3XdD24QtGvTXap6iAWIg==
X-CSE-MsgGUID: GDv7ACJ0SfKBmeNiRj1m0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22118297"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22118297"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:21:21 -0700
X-CSE-ConnectionGUID: BujiYMx6RLGItZoks5C5pA==
X-CSE-MsgGUID: aebKlseYQsq4GJ5WUdlVbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59362073"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Aug 2024 05:21:16 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seZTd-0003Z8-3C;
	Thu, 15 Aug 2024 12:21:14 +0000
Date: Thu, 15 Aug 2024 20:20:26 +0800
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
Message-ID: <202408152034.lw9Ilsj6-lkp@intel.com>
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
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240815/202408152034.lw9Ilsj6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408152034.lw9Ilsj6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: net/core/filter.o: in function `sol_ip_sockopt':
>> net/core/filter.c:5402:(.text+0x8acc): undefined reference to `is_tcp_sock_ipv6_mapped'
>> alpha-linux-ld: net/core/filter.c:5402:(.text+0x8ad4): undefined reference to `is_tcp_sock_ipv6_mapped'
   alpha-linux-ld: net/core/filter.c:5402:(.text+0xc84c): undefined reference to `is_tcp_sock_ipv6_mapped'
   alpha-linux-ld: net/core/filter.c:5402:(.text+0xc858): undefined reference to `is_tcp_sock_ipv6_mapped'


vim +5402 net/core/filter.c

  5397	
  5398	static int sol_ip_sockopt(struct sock *sk, int optname,
  5399				  char *optval, int *optlen,
  5400				  bool getopt)
  5401	{
> 5402		if (sk->sk_family != AF_INET && !is_tcp_sock_ipv6_mapped(sk))
  5403			return -EINVAL;
  5404	
  5405		switch (optname) {
  5406		case IP_TOS:
  5407			if (*optlen != sizeof(int))
  5408				return -EINVAL;
  5409			break;
  5410		default:
  5411			return -EINVAL;
  5412		}
  5413	
  5414		if (getopt)
  5415			return do_ip_getsockopt(sk, SOL_IP, optname,
  5416						KERNEL_SOCKPTR(optval),
  5417						KERNEL_SOCKPTR(optlen));
  5418	
  5419		return do_ip_setsockopt(sk, SOL_IP, optname,
  5420					KERNEL_SOCKPTR(optval), *optlen);
  5421	}
  5422	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


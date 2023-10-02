Return-Path: <bpf+bounces-11206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77657B5462
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 90771282EDB
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8519BAD;
	Mon,  2 Oct 2023 13:57:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA521944C;
	Mon,  2 Oct 2023 13:57:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A407EE5;
	Mon,  2 Oct 2023 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696255071; x=1727791071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+G5ATAb6PDeUCMFiytt+qhbsV+Jl1Pjo9it2Deijho=;
  b=HNr47t/jvHunFJLmyKm7+BdDwsepmJiS6W81UtWs57cjYnc+iQwzBOoi
   zgb7UXkbjbvwOgawYAqgVYpYLjgbx1+AyCra65JLEqhve1NhGGpa5aaMP
   uci2mjiXYbX6D4yiXUv7AN6o8sAbt8gl/bAhcWrASTVN8Ng927uFuQeYM
   S+YAVb969yVgrxDK2y0x+6Wo19NU3uhrwOD5zAea52fAeUWahUCxpqMZZ
   h9n6pHOebJOIyT2VjucWKQ8ENph/VIiCR/+747AI10eCEV11f6KQnXxcT
   igbcuF4Gyrv52FvA+9WKjamm7+ZBHN94c2u5uxNzH92ifi+rJ1qvwqUYF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="413557280"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413557280"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1546437"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 02 Oct 2023 06:57:51 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qnJQg-00066D-1U;
	Mon, 02 Oct 2023 13:57:46 +0000
Date: Mon, 2 Oct 2023 21:57:37 +0800
From: kernel test robot <lkp@intel.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
Message-ID: <202310022113.1H3kTKXX-lkp@intel.com>
References: <20231002122756.323591-3-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002122756.323591-3-daan.j.demeyer@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Daan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Daan-De-Meyer/selftests-bpf-Add-missing-section-name-tests-for-getpeername-getsockname/20231002-203646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231002122756.323591-3-daan.j.demeyer%40gmail.com
patch subject: [PATCH bpf-next v7 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231002/202310022113.1H3kTKXX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310022113.1H3kTKXX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310022113.1H3kTKXX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/cgroup.c:1454: warning: bad line:               read-only for AF_INET[6] uaddr but can be modified for AF_UNIX
>> kernel/bpf/cgroup.c:1455: warning: bad line:               uaddr.


vim +1454 kernel/bpf/cgroup.c

  1447	
  1448	/**
  1449	 * __cgroup_bpf_run_filter_sock_addr() - Run a program on a sock and
  1450	 *                                       provided by user sockaddr
  1451	 * @sk: sock struct that will use sockaddr
  1452	 * @uaddr: sockaddr struct provided by user
  1453	 * @uaddrlen: Pointer to the size of the sockaddr struct provided by user. It is
> 1454		      read-only for AF_INET[6] uaddr but can be modified for AF_UNIX
> 1455		      uaddr.
  1456	 * @atype: The type of program to be executed
  1457	 * @t_ctx: Pointer to attach type specific context
  1458	 * @flags: Pointer to u32 which contains higher bits of BPF program
  1459	 *         return value (OR'ed together).
  1460	 *
  1461	 * socket is expected to be of type INET or INET6.
  1462	 *
  1463	 * This function will return %-EPERM if an attached program is found and
  1464	 * returned value != 1 during execution. In all other cases, 0 is returned.
  1465	 */
  1466	int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
  1467					      struct sockaddr *uaddr,
  1468					      int *uaddrlen,
  1469					      enum cgroup_bpf_attach_type atype,
  1470					      void *t_ctx,
  1471					      u32 *flags)
  1472	{
  1473		struct bpf_sock_addr_kern ctx = {
  1474			.sk = sk,
  1475			.uaddr = uaddr,
  1476			.t_ctx = t_ctx,
  1477		};
  1478		struct sockaddr_storage unspec;
  1479		struct cgroup *cgrp;
  1480		int ret;
  1481	
  1482		/* Check socket family since not all sockets represent network
  1483		 * endpoint (e.g. AF_UNIX).
  1484		 */
  1485		if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
  1486			return 0;
  1487	
  1488		if (!ctx.uaddr) {
  1489			memset(&unspec, 0, sizeof(unspec));
  1490			ctx.uaddr = (struct sockaddr *)&unspec;
  1491			ctx.uaddrlen = 0;
  1492		} else if (uaddrlen)
  1493			ctx.uaddrlen = *uaddrlen;
  1494		else
  1495			return -EINVAL;
  1496	
  1497		cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
  1498		ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
  1499					    0, flags);
  1500	
  1501		if (!ret && uaddrlen)
  1502			*uaddrlen = ctx.uaddrlen;
  1503	
  1504		return ret;
  1505	}
  1506	EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
  1507	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


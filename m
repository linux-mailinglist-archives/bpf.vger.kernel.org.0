Return-Path: <bpf+bounces-10663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DA7ABDD6
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3062C282232
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2631C2F;
	Sat, 23 Sep 2023 05:19:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785E812;
	Sat, 23 Sep 2023 05:19:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917461A1;
	Fri, 22 Sep 2023 22:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695446390; x=1726982390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oeSfJWIUUrRWxph6JxnVgbY4VpoIdZPv5FmaqOJOxYQ=;
  b=f4EIfUQGHbvJHnPRZgXOR2m5Uu0RZk7YKo3/uEg5L2tvQ7dFPsTs4cZl
   /Svs88psSVN6i497YpSoJ7lUCupqaM7K//avky9sNOrMN6ztGhkETE6Sr
   6fipSFsPi3ncKLnXcWDwA8fv84Q0pRLMlSPIFBr+J18QoohmPLT0DjlqB
   +WmFQsrL0cZLSikGisqNwDrID8fqJtB/bysgbe+EszVYoyWnbPvug3pGl
   wzpgfj9Bb/gjDKeYhNQjYqITGRUOGVaMTHi0rKv/QNROGEEWiFJ+GFhkI
   kIjW2TMS6CScjUCEOB8U3xuFOeYli214cD5G/OZ8Hkqft5jcO6fxr6ei2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447476181"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447476181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 22:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="724414449"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="724414449"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2023 22:19:47 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qjv3Q-0001oL-2t;
	Sat, 23 Sep 2023 05:19:44 +0000
Date: Sat, 23 Sep 2023 13:19:42 +0800
From: kernel test robot <lkp@intel.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/9] bpf: Add bpf_sock_addr_set_unix_addr()
 to allow writing unix sockaddr from bpf
Message-ID: <202309231339.L2O0CrMU-lkp@intel.com>
References: <20230921120913.566702-4-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921120913.566702-4-daan.j.demeyer@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Daan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Daan-De-Meyer/selftests-bpf-Add-missing-section-name-tests-for-getpeername-getsockname/20230922-032515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230921120913.566702-4-daan.j.demeyer%40gmail.com
patch subject: [PATCH bpf-next v5 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr from bpf
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230923/202309231339.L2O0CrMU-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309231339.L2O0CrMU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309231339.L2O0CrMU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/filter.c:11731:17: warning: no previous declaration for 'bpf_dynptr_from_skb' [-Wmissing-declarations]
    __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
   net/core/filter.c:11744:17: warning: no previous declaration for 'bpf_dynptr_from_xdp' [-Wmissing-declarations]
    __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:11757:17: warning: no previous declaration for 'bpf_sock_addr_set_unix_addr' [-Wmissing-declarations]
    __bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:11860:17: warning: no previous declaration for 'bpf_sock_destroy' [-Wmissing-declarations]
    __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
                    ^~~~~~~~~~~~~~~~


vim +/bpf_sock_addr_set_unix_addr +11757 net/core/filter.c

 11756	
 11757	__bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
 11758						    const u8 *addr, u32 addrlen__sz)
 11759	{
 11760		struct sockaddr *sa = sa_kern->uaddr;
 11761		struct sockaddr_un *un;
 11762	
 11763		if (sa_kern->sk->sk_family != AF_UNIX)
 11764			return -EINVAL;
 11765	
 11766		/* We do not allow changing the address of unnamed unix sockets. */
 11767		if (addrlen__sz == 0 || addrlen__sz > UNIX_PATH_MAX)
 11768			return -EINVAL;
 11769	
 11770		un = (struct sockaddr_un *)sa;
 11771		memcpy(un->sun_path, addr, addrlen__sz);
 11772		sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + addrlen__sz;
 11773	
 11774		return 0;
 11775	}
 11776	__diag_pop();
 11777	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


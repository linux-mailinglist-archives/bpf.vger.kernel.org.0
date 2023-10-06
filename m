Return-Path: <bpf+bounces-11547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746057BBDA4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAE32823A4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409130FB1;
	Fri,  6 Oct 2023 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/pV6Ixj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413642E624;
	Fri,  6 Oct 2023 17:22:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06DC2;
	Fri,  6 Oct 2023 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696612972; x=1728148972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kjjkqAvDUUE79c02Z9GctG9biEdnrD/qQT+SEoiCCtc=;
  b=e/pV6Ixj+lryoafZdKczFOkjJxZZxfEkBDFj3FIEMJULfVYaPp3qTqUm
   VySXvaMx+zOQGLHJrOC5s3OQxR5ejQoStyxRG8GPZr0DKMbm+eNycX8gU
   1seLk7WEnh/le7XMCM7gMKJU7/7F+Frc8gBhIrfmsoNZ6SWI9BGns5PlF
   Yl7iKywlkElFgdtDF8b6h1qBEkMTdfsBffEBVktVUFb+7iWNtgqMX8une
   08dzWlOmKKMUnwDsYWcGRVF3Yf0pCVQh5PAzAUackMPVtbYXFVKZj1IjU
   MvvxEiCpzyNfAagOetHVHdBA3cqjtJ+k1AOihq98xK9/y0Jk6bJa2xkQD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5348275"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="5348275"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="755921845"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="755921845"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2023 10:22:23 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qooWr-0003T1-2L;
	Fri, 06 Oct 2023 17:22:21 +0000
Date: Sat, 7 Oct 2023 01:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] net: Add a warning if NAPI cb missed
 xdp_do_flush().
Message-ID: <202310070134.JX5try68-lkp@intel.com>
References: <20231006154933.mQgxQHHt@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006154933.mQgxQHHt@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/net-Add-a-warning-if-NAPI-cb-missed-xdp_do_flush/20231006-235117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231006154933.mQgxQHHt%40linutronix.de
patch subject: [PATCH bpf-next v2] net: Add a warning if NAPI cb missed xdp_do_flush().
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310070134.JX5try68-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070134.JX5try68-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070134.JX5try68-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/filter.c:4211:6: warning: no previous prototype for 'xdp_do_check_flushed' [-Wmissing-prototypes]
    4211 | void xdp_do_check_flushed(struct napi_struct *napi)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/xdp_do_check_flushed +4211 net/core/filter.c

  4209	
  4210	#if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
> 4211	void xdp_do_check_flushed(struct napi_struct *napi)
  4212	{
  4213		bool ret;
  4214	
  4215		ret = dev_check_flush();
  4216		ret |= cpu_map_check_flush();
  4217		ret |= xsk_map_check_flush();
  4218	
  4219		WARN_ONCE(ret, "Missing xdp_do_flush() invocation after NAPI by %ps\n",
  4220			  napi->poll);
  4221	}
  4222	#endif
  4223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


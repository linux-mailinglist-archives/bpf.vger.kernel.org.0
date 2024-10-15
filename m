Return-Path: <bpf+bounces-41980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9B99E161
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30689281F79
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394D1CDA36;
	Tue, 15 Oct 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpBKG8Bv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0D1CC892;
	Tue, 15 Oct 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981706; cv=none; b=eoq7L84rfyoZ5/RNacbpJQfEMYYuYfPPvvkqLTYu95GbcG2h59/Wpipr5xcfXxGcMyU2eaKAUeiTvohNIKN3sCd5nFjZDC6CdNpwDWcwB8YS/Qr204yrvH738E0GNpt+AuYBLIBSIoPVM1nBuFlS54+JmKSUHz09AQs3Abgia4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981706; c=relaxed/simple;
	bh=tkYKT0qhNdopo59+kDatOz0m4wIspOb4offytMS21BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u09ae0qtViQWXScgyTVlSvAbRUpYxML5pKH6hUlGdt6XFKRCNSMXziNUAR8ysgWZC4xzICWItqaI8aEDJ4mTu/DdeWmv8EZyo1wpJrgt1dNARStlrIyFk7ESedFCNb8KyMJuQ3D4C/hHrLhGsffDvw7xlxmkK777BTGwOsPONDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpBKG8Bv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728981705; x=1760517705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tkYKT0qhNdopo59+kDatOz0m4wIspOb4offytMS21BU=;
  b=hpBKG8Bv+ZpojP6AzOweMFQzqQVAoLQVALop+mrxfvugTVysUeAkf7rh
   1YDHRmJxsPmh66iYfZbxZ+6swPKN2dVdLuXGdz0JjtiyImmb7GbkLbAbx
   hyJFlR8q5mTlKd2pl9DHf2vc8RizF5S2Om7miOKxgCOjTovX5dmVrWpna
   v4jjsNfwELFr3dsCWGuc3hToPyH37RMQf6tX7X589NN3BrYUQVSHEWExG
   aeW/KU1PNnU9OAI6/4Upgfg5EjqsmkcFexT4kAHR+/ykKZXz5I9cdJgDt
   nbSuyPx+KdlOLqjZJRlMD4sBZNDGYK3/T3O2U6XJKfPO9d3QVPzuJvkmK
   w==;
X-CSE-ConnectionGUID: I67/VAneTW2KWbm59fPGKQ==
X-CSE-MsgGUID: AmyB1Ol3TguoCW7e7BjGDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32053720"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32053720"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:41:45 -0700
X-CSE-ConnectionGUID: ENqzNlPYRZSc4hqbKUM2hA==
X-CSE-MsgGUID: fLhfj7PxSvakv22HHtyA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81805941"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2024 01:41:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0d7Y-000Hpr-2Z;
	Tue, 15 Oct 2024 08:41:36 +0000
Date: Tue, 15 Oct 2024 16:40:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP
 support for bpf case
Message-ID: <202410151628.hcAdeahi-lkp@intel.com>
References: <20241012040651.95616-10-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012040651.95616-10-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-introduce-socket-tsflag-requestors/20241012-121010
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241012040651.95616-10-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP support for bpf case
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241015/202410151628.hcAdeahi-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410151628.hcAdeahi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410151628.hcAdeahi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/sock.c:926:2: warning: variable 'tsflags' is uninitialized when used here [-Wuninitialized]
     926 |         tsflags |= (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
         |         ^~~~~~~
   net/core/sock.c:920:13: note: initialize the variable 'tsflags' to silence this warning
     920 |         u32 tsflags;
         |                    ^
         |                     = 0
   1 warning generated.


vim +/tsflags +926 net/core/sock.c

   917	
   918	int sock_set_tskey(struct sock *sk, int val, int type)
   919	{
   920		u32 tsflags;
   921	
   922		if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
   923		    !(val & SOF_TIMESTAMPING_OPT_ID))
   924			return -EINVAL;
   925	
 > 926		tsflags |= (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
   927			    sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
   928		if (val & SOF_TIMESTAMPING_OPT_ID &&
   929		    !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
   930			if (sk_is_tcp(sk)) {
   931				if ((1 << sk->sk_state) &
   932				    (TCPF_CLOSE | TCPF_LISTEN))
   933					return -EINVAL;
   934				if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
   935					atomic_set(&sk->sk_tskey, tcp_sk(sk)->write_seq);
   936				else
   937					atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd_una);
   938			} else {
   939				atomic_set(&sk->sk_tskey, 0);
   940			}
   941		}
   942	
   943		return 0;
   944	}
   945	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


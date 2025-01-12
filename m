Return-Path: <bpf+bounces-48656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151BA0AA34
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 15:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85990166EA3
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8861B87F1;
	Sun, 12 Jan 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhXhiDgS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F41B0414;
	Sun, 12 Jan 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693410; cv=none; b=LU6tqwVbobGXZqDU4bMpVbdoplXfe204kfXBICLrha13q6QMpPLDJZqVjgDVSl8RiGTcH6hb2EONLt9AsX0gmkfVYkkA/Ft8viLBCc8iKyZbOboUU0XJlBaQDHU2WVpcR08Q/1rIMf/6eiUdhasgeW+uPjVPneoRZiDJCetPIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693410; c=relaxed/simple;
	bh=gACOLiFzWNipPffLJ3/zC+4pRSURndVKKZ+ih0PxkbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIDGK8Wx7pVJsFPqVb0QwOe5c3OHjDjVwNhT20SyLnhVta9ypsM8KJypy8FhNpoVoHRhtm6eCOrf8mDk6r/avMH2WZa/mPf4bcafe/EQjoE5JweJkqepxPqHJ/cEW5x2M6sCBzT37Zxyb0xqIyQ0zBazYj8VXAmoM/I5UK24kR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhXhiDgS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736693408; x=1768229408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gACOLiFzWNipPffLJ3/zC+4pRSURndVKKZ+ih0PxkbU=;
  b=mhXhiDgSPDNgUPCJ17y2rvWG3EhHAkOw5xbeudVjz3FldcaS/XgzYJmP
   kbnQoI3BFA+UkHx8AafufGsjZcD+ovYO7Q2RLhB6xPGNgIHbLtkd3LOKp
   Z3SsiU5vhwk219pNugVWraDFpicxmGfaQhqNPGW4WD9xvL2pIwDo/3jJ3
   GdVEyBfGir0PGEhBLe+G95P81v712BmIAajB0yTcMIty+3myIy/xHLejO
   LmaG/Y3Fm4zs7z5fR6tP34LvXjhBhugu4w7/6O+VqBcO9ohKZWCmrgE6h
   gI029qLzzj/r9EStfW6k4JN0IHjTh5RP+/WLKYW35WCgNp7o2OoYx2uGJ
   w==;
X-CSE-ConnectionGUID: 1g6Xp4/2Q2uW6Ub1E4tuTQ==
X-CSE-MsgGUID: 0lmyN9vkQYmOy15Nyn5mPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37086274"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="37086274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 06:50:07 -0800
X-CSE-ConnectionGUID: KfxVYOCsRtGAnd6zFd1ZiA==
X-CSE-MsgGUID: 9i2r6u3cQqCHAJM2xUlBcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="135012395"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Jan 2025 06:50:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWzHr-000M4V-2Q;
	Sun, 12 Jan 2025 14:49:59 +0000
Date: Sun, 12 Jan 2025 22:49:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5 01/15] net-timestamp: add support for
 bpf_setsockopt()
Message-ID: <202501122252.dqEPb1Wd-lkp@intel.com>
References: <20250112113748.73504-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112113748.73504-2-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-add-support-for-bpf_setsockopt/20250112-194115
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250112113748.73504-2-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v5 01/15] net-timestamp: add support for bpf_setsockopt()
config: i386-buildonly-randconfig-005-20250112 (https://download.01.org/0day-ci/archive/20250112/202501122252.dqEPb1Wd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501122252.dqEPb1Wd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501122252.dqEPb1Wd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/filter.c: In function 'sk_bpf_set_cb_flags':
   net/core/filter.c:5237:11: error: 'struct sock' has no member named 'sk_bpf_cb_flags'
    5237 |         sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
         |           ^~
   net/core/filter.c: At top level:
>> net/core/filter.c:5225:12: warning: 'sk_bpf_set_cb_flags' defined but not used [-Wunused-function]
    5225 | static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, bool getopt)
         |            ^~~~~~~~~~~~~~~~~~~


vim +/sk_bpf_set_cb_flags +5225 net/core/filter.c

  5224	
> 5225	static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, bool getopt)
  5226	{
  5227		u32 sk_bpf_cb_flags;
  5228	
  5229		if (getopt)
  5230			return -EINVAL;
  5231	
  5232		sk_bpf_cb_flags = *(u32 *)optval;
  5233	
  5234		if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
  5235			return -EINVAL;
  5236	
> 5237		sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
  5238	
  5239		return 0;
  5240	}
  5241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


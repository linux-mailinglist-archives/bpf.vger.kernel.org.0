Return-Path: <bpf+bounces-46368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1A9E8A4A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 05:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CE18853E0
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 04:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEE19004B;
	Mon,  9 Dec 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U++crwKH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161615958A;
	Mon,  9 Dec 2024 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718562; cv=none; b=LcNK4ItNH9dmJlgvdO0RTb2CBmXdp1c4eawCdYlqqTuXa4QxaUkfgTSzw0TR8G7r3Z1sRSFQoz2Ha1ZNM0SjQLiHj5/EzXjbqKlXyrfaS5L9N3NTGoImfw04nzjH3wVUXKCS13LVWAjTUkoKYbNyS7QqgTayT5bNmUBvJkY3xaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718562; c=relaxed/simple;
	bh=p3hzRKd9PlTdOMaycvQjC6I16A5v3NnmxZlH4tjvlXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRGZNH1hx/OrRfAAXUdHX+/rViReBcDsisGNduhRbexabWsi1aAjOhQctjm5uVJ/PmcQ3LU2fdDcItg+PWZ2gC9LaWnSdnKwzk4e+Mo5kIM3ptagdrBvYZNg6XkxQ1BpwPk+nK3GfofwynekSOxb79U2e9gEbVO1WVmbOZqi0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U++crwKH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718561; x=1765254561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3hzRKd9PlTdOMaycvQjC6I16A5v3NnmxZlH4tjvlXk=;
  b=U++crwKHekPdxcT55IWhxe/O2b4hB4buhj5wcoWYnuObuq+yaU/YghXy
   OL2KkdWRbNat4Z43TIBwfTLxiowObXu2PVHhHHkQeIx4pNeOQR/T8v5mh
   NadlFCrp7Xztuuyijqk2Fa0e7JsVeHzdZvefXpp0a7K51HnOmMe0lFijy
   bJbVWt+ItFj9Md9Nfo2PQrZ5KrexpIm6m6RYAJp92bZCMGSmczyHVMe/O
   vVRfkWxQc/EMHu/ugVyaZhuVDQ/Pe0kVKOLHPP8VPdkKYTgbbUhG1Rzhr
   qtdMutgovT1LRDiViD3EzDKs4naw4qvnQlY+g2zwQly+76hte5NgWmg9b
   w==;
X-CSE-ConnectionGUID: tiuY4oUgQ/az1S4X82eFaw==
X-CSE-MsgGUID: y2KeVUSOQ1GNY9oBay65jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34122925"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34122925"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:29:20 -0800
X-CSE-ConnectionGUID: IaxzBbOlRQ+PKoF7WG+nqQ==
X-CSE-MsgGUID: o9NcqU3GR6ScBNY6oo6xig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99404803"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Dec 2024 20:29:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVOS-0003r7-2t;
	Mon, 09 Dec 2024 04:29:12 +0000
Date: Mon, 9 Dec 2024 12:28:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 01/11] net-timestamp: add support for
 bpf_setsockopt()
Message-ID: <202412080315.koZqiF0Y-lkp@intel.com>
References: <20241207173803.90744-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207173803.90744-2-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-add-support-for-bpf_setsockopt/20241208-014111
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241207173803.90744-2-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v4 01/11] net-timestamp: add support for bpf_setsockopt()
config: i386-buildonly-randconfig-001-20241208 (https://download.01.org/0day-ci/archive/20241208/202412080315.koZqiF0Y-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412080315.koZqiF0Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080315.koZqiF0Y-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c: In function 'sk_bpf_set_cb_flags':
>> net/core/filter.c:5232:11: error: 'struct sock' has no member named 'sk_bpf_cb_flags'
    5232 |         sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
         |           ^~


vim +5232 net/core/filter.c

  5218	
  5219	static int sk_bpf_set_cb_flags(struct sock *sk, sockptr_t optval, bool getopt)
  5220	{
  5221		int sk_bpf_cb_flags;
  5222	
  5223		if (getopt)
  5224			return -EINVAL;
  5225	
  5226		if (copy_from_sockptr(&sk_bpf_cb_flags, optval, sizeof(sk_bpf_cb_flags)))
  5227			return -EFAULT;
  5228	
  5229		if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
  5230			return -EINVAL;
  5231	
> 5232		sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
  5233	
  5234		return 0;
  5235	}
  5236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


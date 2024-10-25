Return-Path: <bpf+bounces-43141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A09AFB43
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E27C1C22577
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA901C07DA;
	Fri, 25 Oct 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbuIIGYW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5231BC9E6;
	Fri, 25 Oct 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842004; cv=none; b=T2w0V/20AvnImW6ZDNJdcM5TNaDnQZlDQ7Jz08vzA2uyjlfUgBhawN/QVEdFc8MMheAKmqCrfxRU6JAsgUN1vzk7tMn0RAfk6Ydtq7Dlu7WcfMNv/4bQOi+CEeJB9KoPS3AsK3oQNdy0QfUxdqcYIggFnHz7t4ZHla1r1x+9W08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842004; c=relaxed/simple;
	bh=yBbBH9p6aqtBMVil5u+tl7Fqa8eFLhohsl5YWvv6Zaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln9wWztVXhRPfDWxpLv5pBVGWst1PdUgfTx52C9QVFglCvFmq8yDFyLsjLEvin1TaihNr7Bc79UnVLZKF1Pqhikk8iaOPy9L9lF84WPkTk4/U2bNNoQp2CuDgJAs+p39nL5GBOAKhnlBtq30okGfcl9odoPvn828+9VzORfK/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbuIIGYW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729842003; x=1761378003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yBbBH9p6aqtBMVil5u+tl7Fqa8eFLhohsl5YWvv6Zaw=;
  b=BbuIIGYWwc7TKbIyB5Yj6y9+CSa1D1VWajTcwNymHKOCpPRDk9SGZK4o
   /mWfy7ryuM4xHjeLtVcsGNZEfPg+2Q5nuemb+5S0Z6jkxO57dVkWsPwfR
   UqCF57MFireOUBFCSmWYvm5njQq9jny61xN4EOnGvWU3ZDYELpc1jUTtv
   3HN1DiPgNL3spIlZ5N+jr7VZDzFAEkSww9GULm5G5M+ZGLOWCwbZX/D7A
   9ARgoxKCBazxzMBZ//LU0YuSESNsxStmsJrw/6vML+yU747MNyZE1WTWa
   qCVIwsZTo/4YijfN+e9ANYPOfUHc019vyD7s2lKDCirX+B/kuCjdcQsbH
   w==;
X-CSE-ConnectionGUID: SSMEOhRgSt2GHSYCHRz4tg==
X-CSE-MsgGUID: a/gFFDT8TQunwyLBc1gJxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40610793"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40610793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 00:40:01 -0700
X-CSE-ConnectionGUID: +EtDZenqS3uQRCXmiEZu3w==
X-CSE-MsgGUID: NtENei+HSruYwJ95nzTfEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85632621"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Oct 2024 00:39:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4EvB-000Xmi-1n;
	Fri, 25 Oct 2024 07:39:45 +0000
Date: Fri, 25 Oct 2024 15:38:57 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: bpf_csum_diff: optimize and
 homogenize for all archs
Message-ID: <202410251552.LR73LP4V-lkp@intel.com>
References: <20241023153922.86909-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023153922.86909-3-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/net-checksum-move-from32to16-to-generic-header/20241023-234347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241023153922.86909-3-puranjay%40kernel.org
patch subject: [PATCH bpf-next v2 2/4] bpf: bpf_csum_diff: optimize and homogenize for all archs
config: i386-randconfig-061-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251552.LR73LP4V-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251552.LR73LP4V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251552.LR73LP4V-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/filter.c:1423:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1423:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1423:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:1501:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1501:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1501:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:2321:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] daddr @@     got unsigned int [usertype] ipv4_nh @@
   net/core/filter.c:2321:45: sparse:     expected restricted __be32 [usertype] daddr
   net/core/filter.c:2321:45: sparse:     got unsigned int [usertype] ipv4_nh
   net/core/filter.c:10993:31: sparse: sparse: symbol 'sk_filter_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11000:27: sparse: sparse: symbol 'sk_filter_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11004:31: sparse: sparse: symbol 'tc_cls_act_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11013:27: sparse: sparse: symbol 'tc_cls_act_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11017:31: sparse: sparse: symbol 'xdp_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11029:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11035:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11039:31: sparse: sparse: symbol 'lwt_in_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11045:27: sparse: sparse: symbol 'lwt_in_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11049:31: sparse: sparse: symbol 'lwt_out_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11055:27: sparse: sparse: symbol 'lwt_out_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11059:31: sparse: sparse: symbol 'lwt_xmit_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11066:27: sparse: sparse: symbol 'lwt_xmit_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11070:31: sparse: sparse: symbol 'lwt_seg6local_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11076:27: sparse: sparse: symbol 'lwt_seg6local_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11079:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11085:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11088:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11094:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11097:31: sparse: sparse: symbol 'sock_ops_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11103:27: sparse: sparse: symbol 'sock_ops_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11106:31: sparse: sparse: symbol 'sk_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11113:27: sparse: sparse: symbol 'sk_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11116:31: sparse: sparse: symbol 'sk_msg_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11123:27: sparse: sparse: symbol 'sk_msg_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11126:31: sparse: sparse: symbol 'flow_dissector_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11132:27: sparse: sparse: symbol 'flow_dissector_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11460:31: sparse: sparse: symbol 'sk_reuseport_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11466:27: sparse: sparse: symbol 'sk_reuseport_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11668:27: sparse: sparse: symbol 'sk_lookup_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11672:31: sparse: sparse: symbol 'sk_lookup_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:1931:43: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1931:43: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1931:43: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1934:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be16 [usertype] old @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1934:36: sparse:     expected restricted __be16 [usertype] old
   net/core/filter.c:1934:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1934:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] new @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1934:42: sparse:     expected restricted __be16 [usertype] new
   net/core/filter.c:1934:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1937:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1937:36: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1937:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1937:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1937:42: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1937:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1982:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1982:59: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1982:59: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1985:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1985:52: sparse:     expected restricted __be16 [usertype] from
   net/core/filter.c:1985:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1985:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be16 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1985:58: sparse:     expected restricted __be16 [usertype] to
   net/core/filter.c:1985:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1988:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1988:52: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1988:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1988:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1988:58: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1988:58: sparse:     got unsigned long long [usertype] to
>> net/core/filter.c:2023:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int sum @@     got restricted __wsum @@
   net/core/filter.c:2023:48: sparse:     expected unsigned int sum
   net/core/filter.c:2023:48: sparse:     got restricted __wsum
   net/core/filter.c:2026:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int sum @@     got restricted __wsum @@
   net/core/filter.c:2026:52: sparse:     expected unsigned int sum
   net/core/filter.c:2026:52: sparse:     got restricted __wsum
   net/core/filter.c:2029:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int sum @@     got restricted __wsum @@
   net/core/filter.c:2029:40: sparse:     expected unsigned int sum
   net/core/filter.c:2029:40: sparse:     got restricted __wsum
   net/core/filter.c:2031:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] seed @@
   net/core/filter.c:2031:16: sparse:     expected unsigned long long
   net/core/filter.c:2031:16: sparse:     got restricted __wsum [usertype] seed
   net/core/filter.c:2053:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
   net/core/filter.c:2053:35: sparse:     expected unsigned long long
   net/core/filter.c:2053:35: sparse:     got restricted __wsum [usertype] csum

vim +2023 net/core/filter.c

  2009	
  2010	BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
  2011		   __be32 *, to, u32, to_size, __wsum, seed)
  2012	{
  2013		/* This is quite flexible, some examples:
  2014		 *
  2015		 * from_size == 0, to_size > 0,  seed := csum --> pushing data
  2016		 * from_size > 0,  to_size == 0, seed := csum --> pulling data
  2017		 * from_size > 0,  to_size > 0,  seed := 0    --> diffing data
  2018		 *
  2019		 * Even for diffing, from_size and to_size don't need to be equal.
  2020		 */
  2021	
  2022		if (from_size && to_size)
> 2023			return csum_from32to16(csum_sub(csum_partial(to, to_size, seed),
  2024							csum_partial(from, from_size, 0)));
  2025		if (to_size)
  2026			return csum_from32to16(csum_partial(to, to_size, seed));
  2027	
  2028		if (from_size)
  2029			return csum_from32to16(~csum_partial(from, from_size, ~seed));
  2030	
  2031		return seed;
  2032	}
  2033	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


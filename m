Return-Path: <bpf+bounces-42812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E69AB5C6
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F1D1C230A6
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9FF1C9EC4;
	Tue, 22 Oct 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKCnXBZt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E81C9DFA;
	Tue, 22 Oct 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620604; cv=none; b=PH/UfDnJKLwk4wNHHsI2w7YUO1XwM9QXLzCqpbvHZ5HbiPe6JpBbv/dUqqxNSnp3OQCd1eHq2EQWslmgfDI5HnRkcrz/qWeBG6vD0evkopHkzVhcWR/TUz8SiaRBiNNNrtUYShrsU+6kUGGi2M6gULv4Q7dHe9QPeNnu1kOa9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620604; c=relaxed/simple;
	bh=Nq8Jdmiwq7WCGmATlFb2otP/fjTsQuLclZaTiLGwKYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC1L+B01LYYB92I1BE9khhGUaMK3OYPDUWmtl2Zkuoiy7eDtKviFKRJHpG3NQAKPkvBXoChgDVtr1zrHREh4YD2auX1lzWpmo2nkc5KcrwyzbKSbLqdtJK3c02IQKbXNQwlLEaSqNSglI56o9s6g47PRsg+hNDnBHw6DfC8yRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKCnXBZt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729620601; x=1761156601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nq8Jdmiwq7WCGmATlFb2otP/fjTsQuLclZaTiLGwKYY=;
  b=XKCnXBZtpLTHZT8jq+00LbbLAWqqk2rI9fJycfUj1G+ez+6Wsb9Uhgkr
   yWH17FvdI8cYE8556sjVdk67z3JOp74LPin2beUgfF1+hyuikIiP8NNQO
   ovkr4uGZTsyP2LPsAOwQZipnSiyWMzy7nABCOFzhOUwVUP8Rl5oSJvRSa
   qbLUxTMTd3Riz3ybGJtTN0otvKkSE7EkUljc1GdIaN3J4RUAOVGz52PO/
   kcJPOL5kLyI1QlHjnDkZ/JKsTHXKGnWz8N0NMbUXiNIr7tIhAJOSXKa7f
   xTdk4O0fSjRALpR8TO5W8mnx1gdAbV3hhVB+ZbQSAuTf4jGeM+Hmi9qyK
   w==;
X-CSE-ConnectionGUID: Udw4PVERQVygKmYsM6hPFg==
X-CSE-MsgGUID: wcAYjCzlS+SVS10yQyNl4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32869503"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32869503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 11:10:01 -0700
X-CSE-ConnectionGUID: GwlngA8XStyXbJqz5y0+2w==
X-CSE-MsgGUID: Ol9EXL3fTwC9YvdVrBc0Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80363724"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Oct 2024 11:09:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3JKJ-000TvD-1K;
	Tue, 22 Oct 2024 18:09:51 +0000
Date: Wed, 23 Oct 2024 02:09:06 +0800
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
Subject: Re: [PATCH bpf-next 2/5] bpf: bpf_csum_diff: optimize and homogenize
 for all archs
Message-ID: <202410230122.BYZLEUHz-lkp@intel.com>
References: <20241021122112.101513-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021122112.101513-3-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/net-checksum-move-from32to16-to-generic-header/20241021-202707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241021122112.101513-3-puranjay%40kernel.org
patch subject: [PATCH bpf-next 2/5] bpf: bpf_csum_diff: optimize and homogenize for all archs
config: x86_64-randconfig-122-20241022 (https://download.01.org/0day-ci/archive/20241023/202410230122.BYZLEUHz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230122.BYZLEUHz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230122.BYZLEUHz-lkp@intel.com/

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
>> net/core/filter.c:2023:39: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __sum16 @@
   net/core/filter.c:2023:39: sparse:     expected unsigned long long
   net/core/filter.c:2023:39: sparse:     got restricted __sum16
   net/core/filter.c:2026:39: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __sum16 @@
   net/core/filter.c:2026:39: sparse:     expected unsigned long long
   net/core/filter.c:2026:39: sparse:     got restricted __sum16
   net/core/filter.c:2029:39: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __sum16 @@
   net/core/filter.c:2029:39: sparse:     expected unsigned long long
   net/core/filter.c:2029:39: sparse:     got restricted __sum16
>> net/core/filter.c:2031:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] seed @@
   net/core/filter.c:2031:16: sparse:     expected unsigned long long
   net/core/filter.c:2031:16: sparse:     got restricted __wsum [usertype] seed
   net/core/filter.c:2053:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
   net/core/filter.c:2053:35: sparse:     expected unsigned long long
   net/core/filter.c:2053:35: sparse:     got restricted __wsum [usertype] csum

vim +2023 net/core/filter.c

  1956	
  1957	BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
  1958		   u64, from, u64, to, u64, flags)
  1959	{
  1960		bool is_pseudo = flags & BPF_F_PSEUDO_HDR;
  1961		bool is_mmzero = flags & BPF_F_MARK_MANGLED_0;
  1962		bool do_mforce = flags & BPF_F_MARK_ENFORCE;
  1963		__sum16 *ptr;
  1964	
  1965		if (unlikely(flags & ~(BPF_F_MARK_MANGLED_0 | BPF_F_MARK_ENFORCE |
  1966				       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK)))
  1967			return -EINVAL;
  1968		if (unlikely(offset > 0xffff || offset & 1))
  1969			return -EFAULT;
  1970		if (unlikely(bpf_try_make_writable(skb, offset + sizeof(*ptr))))
  1971			return -EFAULT;
  1972	
  1973		ptr = (__sum16 *)(skb->data + offset);
  1974		if (is_mmzero && !do_mforce && !*ptr)
  1975			return 0;
  1976	
  1977		switch (flags & BPF_F_HDR_FIELD_MASK) {
  1978		case 0:
  1979			if (unlikely(from != 0))
  1980				return -EINVAL;
  1981	
  1982			inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
  1983			break;
  1984		case 2:
> 1985			inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
  1986			break;
  1987		case 4:
  1988			inet_proto_csum_replace4(ptr, skb, from, to, is_pseudo);
  1989			break;
  1990		default:
  1991			return -EINVAL;
  1992		}
  1993	
  1994		if (is_mmzero && !*ptr)
  1995			*ptr = CSUM_MANGLED_0;
  1996		return 0;
  1997	}
  1998	
  1999	static const struct bpf_func_proto bpf_l4_csum_replace_proto = {
  2000		.func		= bpf_l4_csum_replace,
  2001		.gpl_only	= false,
  2002		.ret_type	= RET_INTEGER,
  2003		.arg1_type	= ARG_PTR_TO_CTX,
  2004		.arg2_type	= ARG_ANYTHING,
  2005		.arg3_type	= ARG_ANYTHING,
  2006		.arg4_type	= ARG_ANYTHING,
  2007		.arg5_type	= ARG_ANYTHING,
  2008	};
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
> 2031		return seed;
  2032	}
  2033	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


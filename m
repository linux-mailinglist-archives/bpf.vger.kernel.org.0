Return-Path: <bpf+bounces-52261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851EA40BEE
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 23:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA533AE5CD
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681082045B7;
	Sat, 22 Feb 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxzJT5Xq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6CA18EB0;
	Sat, 22 Feb 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740264753; cv=none; b=LXUwpq7LkAMO+2Ow1Mlpe+1qAMk5ZRDaP0r8Q0+3ld+yCiIUcNp4yABs0RTCrLSYYjy6ny2QImNPkda8zNIpslsdMBeiaWbZ3vXe74HuOILiTESK59tOeftRldrUGQESkHaLcRKK5QxTLB6Q10CNnO2DYO1MOQF8qyj2Tw7HSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740264753; c=relaxed/simple;
	bh=Nd6QA6/cYeZst96/ye9TyeT7k2VCgW2t+UlxpiR8J9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozRmJ26p9YQOxb+d2EYQFDKFmGeR1JziKvXPeYp4E2QspX/8zojwX4rzWzPbOzWA3BfplnXrKoqnlzlSFB4z0E9vyC2GRpypBCt6AeRZvMfLdjnLYkQmKPQAWx6NzG29MFAYUSjRyGKCkyKGiXVPOyVs7OqW/oYmJMqjGWZnAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxzJT5Xq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740264752; x=1771800752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nd6QA6/cYeZst96/ye9TyeT7k2VCgW2t+UlxpiR8J9Y=;
  b=OxzJT5XqBk6WnPKUzPmFHVO2TU1lsmZ9RJW+c5qMjwJVLPzEVrQo742e
   0sMykq6oUtzRuPW9DeMptTAcNWWXcgMPPTnEM5aPJY2sqAOtvXDOWkvo+
   BKZpGcisZdUt44abzZnKq+fERGiCWzim9c2/q31NnxVLedO6PKsRHiUrQ
   13F7eqaIO2kEFKer3dgZtaE2dPJFrWUju6hI6RlAewHpJrF4L3ajR7JB9
   3TlfQxNhYrG7jj78lWPxTtfZmjDUhSsqQIYcu7BaHCa6pAuOu+UVkMkoH
   BYRAgMroGKmwtbd5Rh2ykXDxZ+vPFhoCIuVBX2tACXmQD0HUDuI+qdFgq
   g==;
X-CSE-ConnectionGUID: CTQC0RWFQ2ey/QSXDtWhEw==
X-CSE-MsgGUID: mth7HNrnShC97oqGGUA/WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44708768"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="44708768"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 14:52:32 -0800
X-CSE-ConnectionGUID: LQxw2WKxTcGTo6alwSGThA==
X-CSE-MsgGUID: KgyCal27QVKdc/FqrjGA4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="115720660"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Feb 2025 14:52:25 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlyMB-0006xr-0W;
	Sat, 22 Feb 2025 22:52:23 +0000
Date: Sun, 23 Feb 2025 06:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
	ykolal@fb.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for
 bpf_setsockopt
Message-ID: <202502230656.sZc7duhR-lkp@intel.com>
References: <20250219081333.56378-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219081333.56378-2-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/bpf-support-TCP_RTO_MAX_MS-for-bpf_setsockopt/20250219-161637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250219081333.56378-2-kerneljasonxing%40gmail.com
patch subject: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
config: i386-buildonly-randconfig-004-20250220 (https://download.01.org/0day-ci/archive/20250223/202502230656.sZc7duhR-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502230656.sZc7duhR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502230656.sZc7duhR-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c:1726:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1726 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:2041:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2041 |         .arg1_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:2043:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2043 |         .arg3_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:2580:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2580 |         .arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:4649:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4649 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4663:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4663 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4863:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4863 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4891:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4891 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5063:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5063 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5077:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5077 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5126:45: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5126 |         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
>> net/core/filter.c:5385:7: error: use of undeclared identifier 'TCP_RTO_MAX_MS'; did you mean 'TCA_RED_MAX_P'?
    5385 |         case TCP_RTO_MAX_MS:
         |              ^~~~~~~~~~~~~~
         |              TCA_RED_MAX_P
   include/uapi/linux/pkt_sched.h:258:2: note: 'TCA_RED_MAX_P' declared here
     258 |         TCA_RED_MAX_P,
         |         ^
   net/core/filter.c:5562:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5562 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5596:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5596 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5630:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5630 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5664:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5664 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5839:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5839 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6376:46: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6376 |         .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
   net/core/filter.c:6388:46: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6388 |         .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
   net/core/filter.c:6474:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6474 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6484:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6484 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   20 warnings and 1 error generated.


vim +5385 net/core/filter.c

  5365	
  5366	static int sol_tcp_sockopt(struct sock *sk, int optname,
  5367				   char *optval, int *optlen,
  5368				   bool getopt)
  5369	{
  5370		if (sk->sk_protocol != IPPROTO_TCP)
  5371			return -EINVAL;
  5372	
  5373		switch (optname) {
  5374		case TCP_NODELAY:
  5375		case TCP_MAXSEG:
  5376		case TCP_KEEPIDLE:
  5377		case TCP_KEEPINTVL:
  5378		case TCP_KEEPCNT:
  5379		case TCP_SYNCNT:
  5380		case TCP_WINDOW_CLAMP:
  5381		case TCP_THIN_LINEAR_TIMEOUTS:
  5382		case TCP_USER_TIMEOUT:
  5383		case TCP_NOTSENT_LOWAT:
  5384		case TCP_SAVE_SYN:
> 5385		case TCP_RTO_MAX_MS:
  5386			if (*optlen != sizeof(int))
  5387				return -EINVAL;
  5388			break;
  5389		case TCP_CONGESTION:
  5390			return sol_tcp_sockopt_congestion(sk, optval, optlen, getopt);
  5391		case TCP_SAVED_SYN:
  5392			if (*optlen < 1)
  5393				return -EINVAL;
  5394			break;
  5395		case TCP_BPF_SOCK_OPS_CB_FLAGS:
  5396			if (*optlen != sizeof(int))
  5397				return -EINVAL;
  5398			if (getopt) {
  5399				struct tcp_sock *tp = tcp_sk(sk);
  5400				int cb_flags = tp->bpf_sock_ops_cb_flags;
  5401	
  5402				memcpy(optval, &cb_flags, *optlen);
  5403				return 0;
  5404			}
  5405			return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
  5406		default:
  5407			if (getopt)
  5408				return -EINVAL;
  5409			return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
  5410		}
  5411	
  5412		if (getopt) {
  5413			if (optname == TCP_SAVED_SYN) {
  5414				struct tcp_sock *tp = tcp_sk(sk);
  5415	
  5416				if (!tp->saved_syn ||
  5417				    *optlen > tcp_saved_syn_len(tp->saved_syn))
  5418					return -EINVAL;
  5419				memcpy(optval, tp->saved_syn->data, *optlen);
  5420				/* It cannot free tp->saved_syn here because it
  5421				 * does not know if the user space still needs it.
  5422				 */
  5423				return 0;
  5424			}
  5425	
  5426			return do_tcp_getsockopt(sk, SOL_TCP, optname,
  5427						 KERNEL_SOCKPTR(optval),
  5428						 KERNEL_SOCKPTR(optlen));
  5429		}
  5430	
  5431		return do_tcp_setsockopt(sk, SOL_TCP, optname,
  5432					 KERNEL_SOCKPTR(optval), *optlen);
  5433	}
  5434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-52062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49AAA3D3BB
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92333189E1F1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB71EBFE0;
	Thu, 20 Feb 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeLRyDfY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B91B4254;
	Thu, 20 Feb 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041572; cv=none; b=Q+h+jNTFFaZSSBcKSfLhj0pnXGonDzwItyOlFg3Ff3s00QRzzks3VOzKzwTK3ZPg2mrlLl6Fa3NMgYplk67578b+it4V4u6rbn78mMbIqq3q/6cVNMng0ae58IJZGiMQ1On6xnKKRels7r0oSal6cY9j6hXAXpRk2JwUojhv2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041572; c=relaxed/simple;
	bh=+br6iE4Vm2zLYMuk2Se6o3kG57xO5aJM3NrDH6ex87Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM98h0lkZbfjckEh7cKCOXu6xllWulfR+ewhVCGciLCjwixDcXNqdUIKCZWWd9DAw1s7h+vfWKARxabK0P6MXhtCMTmieVIYmJvEeUCZop1ZQG/wPcyVGVxErdOxDiwkY+gQo0a+y+nHopAY7dUCFzUGpqfjoHzikIvyN4u2WXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeLRyDfY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740041569; x=1771577569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+br6iE4Vm2zLYMuk2Se6o3kG57xO5aJM3NrDH6ex87Y=;
  b=NeLRyDfYnvks7WlSIfTyatOe2vDpKloAiZLSqW9qNHOY0PREf61ULdmt
   8aoPnykzsdbUBaQqjxz34hzycHhcKQIJ0xqnK212EPdl2JVcomcdQtZYr
   3T6SRaFdf5CuKqrorcLKgiAqC7dhuguQSdd9PJRDO92VTWzvroDWtzmIo
   UjKY+2aCoK4UiUOVoCkuBI7KhWQpqzBs/9qgSkhrL9EShLZRDyxTsHAQM
   inBa5BBoeEHbOWpT+PANT9lOxJkW0cpl3A1/NzKdKHGg7UYTORrzY3XU+
   vPeew4Lry3C0JgzH2PP0S7rXFLlfpgGDQlFaZVJ3d3zmupfHLKdMmM8hM
   Q==;
X-CSE-ConnectionGUID: MNzMK68dSt64ST6l1B1Nyg==
X-CSE-MsgGUID: JIPcBvJIS6S5WrY5HhtbDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44459453"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44459453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:52:48 -0800
X-CSE-ConnectionGUID: GvnFFMPaQiW1XG2/wfzTeg==
X-CSE-MsgGUID: C0/02rgzRa2GdL8q7axQcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="119956100"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Feb 2025 00:52:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl2IS-00043f-2s;
	Thu, 20 Feb 2025 08:52:40 +0000
Date: Thu, 20 Feb 2025 16:51:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
	ykolal@fb.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for
 bpf_setsockopt
Message-ID: <202502201843.xA1qZbKX-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-002-20250220 (https://download.01.org/0day-ci/archive/20250220/202502201843.xA1qZbKX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502201843.xA1qZbKX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502201843.xA1qZbKX-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c: In function 'sol_tcp_sockopt':
>> net/core/filter.c:5385:14: error: 'TCP_RTO_MAX_MS' undeclared (first use in this function); did you mean 'TCP_RTO_MAX'?
    5385 |         case TCP_RTO_MAX_MS:
         |              ^~~~~~~~~~~~~~
         |              TCP_RTO_MAX
   net/core/filter.c:5385:14: note: each undeclared identifier is reported only once for each function it appears in


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


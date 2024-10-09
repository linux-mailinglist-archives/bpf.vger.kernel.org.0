Return-Path: <bpf+bounces-41346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC45A995E86
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C521289946
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0D154BE4;
	Wed,  9 Oct 2024 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgQWZsBq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290E137C37;
	Wed,  9 Oct 2024 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447514; cv=none; b=Uis30Jw7N1AXM5bOunmUqszHjVsbOyb5e3AuI/FcJH7wAOgqWcjOlsiieb+1fCQVK0LcR1nswIzeDFzyTisCLt7zVczeTdGU4+8gYOwkRVo189oR/o33gMSs1Boh5TNqU2qVwV1vDim17k3OU6u9HiBqb6MjjcxVPULDGjd2IL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447514; c=relaxed/simple;
	bh=AKaXIGUq/gkVNVDuKPwjXu1V75U9w/7vzRSecrXUglw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVXIQFFDM2TSZlREN49qiXuHuSEVKsxbw/Z03WCXZu+DwxaOxLCzvyzQr4my1DoiSASjO0Gn0d0WDQNKj7d2jmkr0dneKro2NV4jc5hNLIupTKH1lBHO2Dbl6WNvlsOMoZwXt/TXcLpiw8QJeLRY2jtJ3Z/LZxfhXoPs6kSf6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgQWZsBq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728447512; x=1759983512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKaXIGUq/gkVNVDuKPwjXu1V75U9w/7vzRSecrXUglw=;
  b=SgQWZsBq2y5ZkO4w1GPfY97jpKR6/PEb2hEa17OaGAHTDEqBKH9jn+IX
   RqMDRTBw3/7JlZEuSj547biBz7HZKhLEZPe8u60HiiZTVNeFxdo6hWPxT
   RcNGbJhqGDSVcz+zCs59dyqO8ji4lN/8i6ouDZOD+y5YJW1Ba0LQ2Q0rk
   9wxecNg8PRdRsQcXugMezMuptg4yB/F5p2NYnb6A81mdemnMGjqCLJ0So
   QhMhDhHH7aeXDQ+jvU/PzWu/VPfSFIZeQ5PHn9DhZT01s6/L7PnhSDXs1
   TYqVfPX85BUWYM5xmY8IsHXBZr2Ln+YS4za5CTa7OpkE1C8/WutYd6vtR
   g==;
X-CSE-ConnectionGUID: RqjTh2O6RzGueaY6CqQecw==
X-CSE-MsgGUID: So4LVsvaQ5uKnUJhF7M7lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31614658"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31614658"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:18:32 -0700
X-CSE-ConnectionGUID: i08YfiTcT0qzLw5FkrKvig==
X-CSE-MsgGUID: RcYqUqsqTeurXpxaAGqJmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76077035"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Oct 2024 21:18:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syO9Y-0008iD-1i;
	Wed, 09 Oct 2024 04:18:24 +0000
Date: Wed, 9 Oct 2024 12:17:34 +0800
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
Subject: Re: [PATCH net-next 8/9] net-timestamp: add bpf framework for rx
 timestamps
Message-ID: <202410091146.2OM6QWPq-lkp@intel.com>
References: <20241008095109.99918-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008095109.99918-9-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-add-bpf-infrastructure-to-allow-exposing-more-information-later/20241008-175458
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241008095109.99918-9-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next 8/9] net-timestamp: add bpf framework for rx timestamps
config: arm-exynos_defconfig (https://download.01.org/0day-ci/archive/20241009/202410091146.2OM6QWPq-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091146.2OM6QWPq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091146.2OM6QWPq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/tcp.c:2297:29: error: passing 'const struct sock *' to parameter of type 'struct sock *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    2297 |         if (tcp_bpf_recv_timestamp(sk, tss))
         |                                    ^~
   net/ipv4/tcp.c:2279:49: note: passing argument to parameter 'sk' here
    2279 | static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
         |                                                 ^
   1 error generated.


vim +2297 net/ipv4/tcp.c

  2288	
  2289	/* Similar to __sock_recv_timestamp, but does not require an skb */
  2290	void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
  2291				struct scm_timestamping_internal *tss)
  2292	{
  2293		int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
  2294		u32 tsflags = READ_ONCE(sk->sk_tsflags);
  2295		bool has_timestamping = false;
  2296	
> 2297		if (tcp_bpf_recv_timestamp(sk, tss))
  2298			return;
  2299	
  2300		if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
  2301			if (sock_flag(sk, SOCK_RCVTSTAMP)) {
  2302				if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
  2303					if (new_tstamp) {
  2304						struct __kernel_timespec kts = {
  2305							.tv_sec = tss->ts[0].tv_sec,
  2306							.tv_nsec = tss->ts[0].tv_nsec,
  2307						};
  2308						put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
  2309							 sizeof(kts), &kts);
  2310					} else {
  2311						struct __kernel_old_timespec ts_old = {
  2312							.tv_sec = tss->ts[0].tv_sec,
  2313							.tv_nsec = tss->ts[0].tv_nsec,
  2314						};
  2315						put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
  2316							 sizeof(ts_old), &ts_old);
  2317					}
  2318				} else {
  2319					if (new_tstamp) {
  2320						struct __kernel_sock_timeval stv = {
  2321							.tv_sec = tss->ts[0].tv_sec,
  2322							.tv_usec = tss->ts[0].tv_nsec / 1000,
  2323						};
  2324						put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
  2325							 sizeof(stv), &stv);
  2326					} else {
  2327						struct __kernel_old_timeval tv = {
  2328							.tv_sec = tss->ts[0].tv_sec,
  2329							.tv_usec = tss->ts[0].tv_nsec / 1000,
  2330						};
  2331						put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
  2332							 sizeof(tv), &tv);
  2333					}
  2334				}
  2335			}
  2336	
  2337			if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
  2338			    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
  2339			     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
  2340				has_timestamping = true;
  2341			else
  2342				tss->ts[0] = (struct timespec64) {0};
  2343		}
  2344	
  2345		if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
  2346			if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
  2347			    (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
  2348			     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
  2349				has_timestamping = true;
  2350			else
  2351				tss->ts[2] = (struct timespec64) {0};
  2352		}
  2353	
  2354		if (has_timestamping) {
  2355			tss->ts[1] = (struct timespec64) {0};
  2356			if (sock_flag(sk, SOCK_TSTAMP_NEW))
  2357				put_cmsg_scm_timestamping64(msg, tss);
  2358			else
  2359				put_cmsg_scm_timestamping(msg, tss);
  2360		}
  2361	}
  2362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


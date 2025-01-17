Return-Path: <bpf+bounces-49175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B55A14D71
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C63A1A03
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBAA1FCCEF;
	Fri, 17 Jan 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5SDUN6V"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02B1F941F;
	Fri, 17 Jan 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109171; cv=none; b=DYV/5hc7f+XS7BMLk9Ok26ZtVUfQRe86NousmFSJAR7f9JHUBK0sReHPfUz1uq3m7/UizZ8XlmewvqoBBhRMONIhseusWgdZdSxN6T81dDGoEgG/jVyRuzp5Nng9N+R9WPUl4R5oZ9PZ7I83wokQDcIPtTmtf+UhH6GpnASjIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109171; c=relaxed/simple;
	bh=trBebw4L+wNpFVxLvcQsr5wqD59SAiHduvT3EkoHqPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Nc3HP/D5hbHTV7N/zxvs6jhYFIDq0fAHx3XaVcbplGPDWPLWwyioBg02L0yDPgDYCu9TUbmxM8yfe2AiHBOVOXTEiUm9Rrz6OLLQwRikEsvEQESbt0M9mNr2Guybimhr6K+Ewmh0DDjVpnTpDSPcTtqRHJ4MShmwTPHiXOJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5SDUN6V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737109168; x=1768645168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=trBebw4L+wNpFVxLvcQsr5wqD59SAiHduvT3EkoHqPM=;
  b=l5SDUN6VfWJSu4qikU3H5yjmgNX8j68yR+qvQn1aBJrqAPrTRILSPc+k
   JBmpFwsUs/81NdZg2nPK3Q9oBpShpWdTYdOm7zwx1+XaOMPQxYwJm+IPj
   FU/AI4zJEXoclnHCVhuydAjLa6/gEaacOSXWqgr49ILJ9ZtCSpaicDjhY
   vs/TCkP+HQYA1cEyXVblE1BckSPpJiib+TMNInmqc7Hkgn9sGWUGoPc0e
   RZMRmdCPvBZLuRVYONGZs+UOxr5dXsqyloT20UPW9uC0uT7P+sdsKXzcu
   Rmrs/kILlc4Sset1vp4gYg16V/rLe98hjPwGyztr49S1wwX+qw/Z04dSA
   A==;
X-CSE-ConnectionGUID: oNZYXsEhQbeWSi4RoRK5+A==
X-CSE-MsgGUID: q/KVQwGdTtqgSEaQ0FW0sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="36746391"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="36746391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 02:19:28 -0800
X-CSE-ConnectionGUID: UZprYXwuTHyYRjiGhNSEpw==
X-CSE-MsgGUID: qd9KN/6WS+mbUq2ieYCq9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="105827619"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Jan 2025 02:19:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYjRf-000T3r-2A;
	Fri, 17 Jan 2025 10:19:19 +0000
Date: Fri, 17 Jan 2025 18:18:51 +0800
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
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in
 some BPF calls
Message-ID: <202501171802.CSquHTL3-lkp@intel.com>
References: <20250112113748.73504-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112113748.73504-6-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-add-support-for-bpf_setsockopt/20250112-194115
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250112113748.73504-6-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v5 05/15] net-timestamp: add strict check in some BPF calls
config: arm-randconfig-r071-20250117 (https://download.01.org/0day-ci/archive/20250117/202501171802.CSquHTL3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501171802.CSquHTL3-lkp@intel.com/

smatch warnings:
net/core/filter.c:7631 ____bpf_sock_ops_load_hdr_opt() warn: always true condition '(bpf_sock->op != 1009) => (0-255 != 1009)'

vim +7631 net/core/filter.c

  7622	
  7623	BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
  7624		   void *, search_res, u32, len, u64, flags)
  7625	{
  7626		bool eol, load_syn = flags & BPF_LOAD_HDR_OPT_TCP_SYN;
  7627		const u8 *op, *opend, *magic, *search = search_res;
  7628		u8 search_kind, search_len, copy_len, magic_len;
  7629		int ret;
  7630	
> 7631		if (bpf_sock->op != SK_BPF_CB_FLAGS)
  7632			return -EINVAL;
  7633	
  7634		/* 2 byte is the minimal option len except TCPOPT_NOP and
  7635		 * TCPOPT_EOL which are useless for the bpf prog to learn
  7636		 * and this helper disallow loading them also.
  7637		 */
  7638		if (len < 2 || flags & ~BPF_LOAD_HDR_OPT_TCP_SYN)
  7639			return -EINVAL;
  7640	
  7641		search_kind = search[0];
  7642		search_len = search[1];
  7643	
  7644		if (search_len > len || search_kind == TCPOPT_NOP ||
  7645		    search_kind == TCPOPT_EOL)
  7646			return -EINVAL;
  7647	
  7648		if (search_kind == TCPOPT_EXP || search_kind == 253) {
  7649			/* 16 or 32 bit magic.  +2 for kind and kind length */
  7650			if (search_len != 4 && search_len != 6)
  7651				return -EINVAL;
  7652			magic = &search[2];
  7653			magic_len = search_len - 2;
  7654		} else {
  7655			if (search_len)
  7656				return -EINVAL;
  7657			magic = NULL;
  7658			magic_len = 0;
  7659		}
  7660	
  7661		if (load_syn) {
  7662			ret = bpf_sock_ops_get_syn(bpf_sock, TCP_BPF_SYN, &op);
  7663			if (ret < 0)
  7664				return ret;
  7665	
  7666			opend = op + ret;
  7667			op += sizeof(struct tcphdr);
  7668		} else {
  7669			if (!bpf_sock->skb ||
  7670			    bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB)
  7671				/* This bpf_sock->op cannot call this helper */
  7672				return -EPERM;
  7673	
  7674			opend = bpf_sock->skb_data_end;
  7675			op = bpf_sock->skb->data + sizeof(struct tcphdr);
  7676		}
  7677	
  7678		op = bpf_search_tcp_opt(op, opend, search_kind, magic, magic_len,
  7679					&eol);
  7680		if (IS_ERR(op))
  7681			return PTR_ERR(op);
  7682	
  7683		copy_len = op[1];
  7684		ret = copy_len;
  7685		if (copy_len > len) {
  7686			ret = -ENOSPC;
  7687			copy_len = len;
  7688		}
  7689	
  7690		memcpy(search_res, op, copy_len);
  7691		return ret;
  7692	}
  7693	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


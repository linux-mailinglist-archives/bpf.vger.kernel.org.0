Return-Path: <bpf+bounces-27021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB18A7C3E
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 08:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DD71C21FE2
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300A15811E;
	Wed, 17 Apr 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sh5mrPfe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75393C68C;
	Wed, 17 Apr 2024 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334670; cv=none; b=I1bP0w1/mZ5SxaxOExuI86vsdH/OTNA63+fIIrruijLgNgXu/4M9+f3zzYqd96BdfxzW3gJ07pTHoikdhl/i+DKcvzmEdkn5rMN+8vU+fJc3YbLmcBvttYdQXtFGOTIo9lY+UwLk3oKfClq0wsawJOu3Zs68LwxVCoCmTIChQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334670; c=relaxed/simple;
	bh=w42aKlhS0gcP36dJaMyx5AB9fm5TuxlheUjjF+LgHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEcL3ZvckghlP48UYyHaJiF8PuEAVe70dBTvF8EQ2HznXrxa1QrX6ZGDQdRj8/NeAMkIiG473SCRPE7gcmrObK0yz9xEYP+ATzdvxWB0xwLmKX6LMhbbL54Sh8OqKGo66KmT1jIbYPbUTRn57r4/qP1e1nCz9ZXUUz2qy1jC5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sh5mrPfe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713334669; x=1744870669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w42aKlhS0gcP36dJaMyx5AB9fm5TuxlheUjjF+LgHsc=;
  b=Sh5mrPfeCWT32U7qkUmejNiFjdwdHvipftj3wZi+Rbro6WCDE9gXCiHy
   4hbd8Yc+69zw7pmLOy+kS8Qfho5BvtFfVSYPIGTczfdR/YEPPnZIDY5cL
   gjFQIrd65Os/Q6AsAFStbOFnvqQvkxU9pUhVrdquUzbd39L3ENrkS8I3y
   H/cnL1xvkNFQJLmGR7Lor8A/h9DFXMlwpvGa4qIWTf4QiRlx3KQ8kmzQL
   C/IA8kqLzAGPLzLSmfYxvfyQjta+e5SXMnCWy+1k1RKy3wyXd+KDfioh8
   GCnPz4FwMGbpGitQ2L5BIyX61RmjdLO9nv0NhAQf4a7rOM9XN57tz4KyD
   g==;
X-CSE-ConnectionGUID: sdX4RHwQQCK3iuVmSoDe+w==
X-CSE-MsgGUID: 1Obv11YjR4iDWQ/Yc0ul/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11750873"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="11750873"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:17:48 -0700
X-CSE-ConnectionGUID: imgM1LG1QZyQQQFDxbqDqA==
X-CSE-MsgGUID: VdZm10H+T8Ok8H03lXuMzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="23109144"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 16 Apr 2024 23:17:44 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwyc2-0006Cc-1J;
	Wed, 17 Apr 2024 06:17:42 +0000
Date: Wed, 17 Apr 2024 14:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 1/4] bpf: make common crypto API for TC/XDP
 programs
Message-ID: <202404171409.EgchVGya-lkp@intel.com>
References: <20240416204004.3942393-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416204004.3942393-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-make-common-crypto-API-for-TC-XDP-programs/20240417-044349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240416204004.3942393-2-vadfed%40meta.com
patch subject: [PATCH bpf-next v9 1/4] bpf: make common crypto API for TC/XDP programs
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240417/202404171409.EgchVGya-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404171409.EgchVGya-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171409.EgchVGya-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/crypto.c:53: warning: Function parameter or struct member 'siv_len' not described in 'bpf_crypto_ctx'


vim +53 kernel/bpf/crypto.c

    37	
    38	/**
    39	 * struct bpf_crypto_ctx - refcounted BPF crypto context structure
    40	 * @type:	The pointer to bpf crypto type
    41	 * @tfm:	The pointer to instance of crypto API struct.
    42	 * @rcu:	The RCU head used to free the crypto context with RCU safety.
    43	 * @usage:	Object reference counter. When the refcount goes to 0, the
    44	 *		memory is released back to the BPF allocator, which provides
    45	 *		RCU safety.
    46	 */
    47	struct bpf_crypto_ctx {
    48		const struct bpf_crypto_type *type;
    49		void *tfm;
    50		u32 siv_len;
    51		struct rcu_head rcu;
    52		refcount_t usage;
  > 53	};
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


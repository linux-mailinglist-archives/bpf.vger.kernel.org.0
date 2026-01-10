Return-Path: <bpf+bounces-78478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E032BD0DA97
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9F3B3009D5B
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D72652B0;
	Sat, 10 Jan 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtaIAtAL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF71A262D;
	Sat, 10 Jan 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768071022; cv=none; b=TZYdqq9suGpxlOWlg0LQV8BFMdfjVIcZlUCi0owS0a1QMficD+4X/cClN63Tzt/v3/SXGsJ74RuL4CmtPkg0QDsJKPiNmUk1F8ibcxzYHyOxKEMxBfeirvp4NMj3xH9M+YwtoBZW2aM7sAzZYaIyO1jbTHD6GH3LGwYAcdz32uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768071022; c=relaxed/simple;
	bh=KP/JVl3r6x4FSvM+KLvDJWnpRJEv9h9Ro9E1qTkua1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enBV38ldLk7VSMr1oIZU9R1i40OPYdgYhy+s5SODC0HB1U0p6/bSB8rLs7VqLGqJxrjnkcL9sfsf03m4F5voeMrY8h+eEOdkqI085FFbR0VPjxE7YXBjxtlVV8KJuk90Fe57gVbcv/n/cRqpT1B5jn8fviWpsTLPyVQaBz8U8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtaIAtAL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768071020; x=1799607020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KP/JVl3r6x4FSvM+KLvDJWnpRJEv9h9Ro9E1qTkua1Y=;
  b=HtaIAtALfdGqkAG8QSlitGFN1RAo5rsvmeA9yuYNZDTJobTgsKoreo/v
   085EwYaUmrACAUH/7eFreTIMmbNC7gwKxy5jfNttVyO6v45sYhBpLOYLt
   nayIYMhpioIbnxYy8/aSI5Xqdb/JpOndQGJ+1e5PuNEElPGS4PswxV6RI
   JqYhDpufMkoo2x890j1xFQYrGqRh6FZ4vGcNYfvPbbw5PliC2sgn4yM05
   N5ktCobSqPDHckuWX6xFHqN8n8lwZikV1w/e5FRl+L8KqNrcmcZIWV6iE
   2qVmpPOOrp/g6CmP4tLdjsuFW9Pi+5nOQ5GvruunFKhFeDvaoR05XOhrR
   w==;
X-CSE-ConnectionGUID: Zo7oEdWgTBaEdXp9qtSkVg==
X-CSE-MsgGUID: 6coV/XWnTjquwhu19HMs7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11667"; a="80868136"
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="80868136"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 10:50:19 -0800
X-CSE-ConnectionGUID: 1rdwCJ5VRAy4L9/WBEmnXg==
X-CSE-MsgGUID: RNOoCIBaTsSlgbSGdrgbpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="208216482"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jan 2026 10:50:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vee2O-0000000091g-3Iq1;
	Sat, 10 Jan 2026 18:50:12 +0000
Date: Sun, 11 Jan 2026 02:49:17 +0800
From: kernel test robot <lkp@intel.com>
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: crypto: Use the correct destructor
 kfunc type
Message-ID: <202601110205.4dwPV9eI-lkp@intel.com>
References: <20260110082548.113748-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110082548.113748-7-samitolvanen@google.com>

Hi Sami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5714ca8cba5ed736f3733663c446cbee63a10a64]

url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/bpf-crypto-Use-the-correct-destructor-kfunc-type/20260110-162850
base:   5714ca8cba5ed736f3733663c446cbee63a10a64
patch link:    https://lore.kernel.org/r/20260110082548.113748-7-samitolvanen%40google.com
patch subject: [PATCH bpf-next v5 1/4] bpf: crypto: Use the correct destructor kfunc type
config: sh-randconfig-r133-20260110 (https://download.01.org/0day-ci/archive/20260111/202601110205.4dwPV9eI-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260111/202601110205.4dwPV9eI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601110205.4dwPV9eI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/crypto.c:264:18: sparse: sparse: symbol 'bpf_crypto_ctx_release_dtor' was not declared. Should it be static?

vim +/bpf_crypto_ctx_release_dtor +264 kernel/bpf/crypto.c

   263	
 > 264	__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
   265	{
   266		bpf_crypto_ctx_release(ctx);
   267	}
   268	CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
   269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-62371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99760AF885B
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 09:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B39586375
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EA9271442;
	Fri,  4 Jul 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEbLZ+qf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B325DAFC;
	Fri,  4 Jul 2025 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612484; cv=none; b=G+rhsx5l9R2gaHAa79rEDYcnFFe0KFNcRC4j8fwRe+cslcd5DCmbrM1ewk9qLCq6Dfj2Q5/Sp0OHl5iWUVYrHJ64uYWgibJI97vclt9nFe1QhUB5ViPUvZn81YKz/ElkkcCgehn3+9bitPZipb2o3y2uXhmByoNUAXAGaPJja0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612484; c=relaxed/simple;
	bh=4khF2ydaRh9P9gvEopkfzH9p52OvKGZ1cKP/qrbnxms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn/lEWScY9t40wwiSV1XxvjOkgGDJFDVZqxHgnb+xFzJeuLaUOFUoonwWKVex8QKwGXlTXfyrQxolb/v4vw9NXEJkiGGhsSJAl8ZQqXeH74U1dp5O/pnvRFtQG4y7vOYx3k8xPkdLb7rZLlKffImJF7uZ7nTZDnvVpYWocrQVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEbLZ+qf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751612483; x=1783148483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4khF2ydaRh9P9gvEopkfzH9p52OvKGZ1cKP/qrbnxms=;
  b=cEbLZ+qfxsIwciv4EOrczgRrlJGQGjlx2bfG4g7CiAuSPwNsJq+ohRL8
   NJmkyB9uqEkrsmUjCGnljSfOChVNDgxEOhS0ugkfN+k+ZDM4/SM7m8JC7
   uDUGfg09dKBHzhszPtPmS4x5fRI7QuGUXqcVBIeByCjaz1ZUqvlmHtAzm
   K+7EuPaKosJbIpfpmys2sO/00OTWrSIxA92KC4MzUx3g8t3JGOiIqtqkE
   NELLu1icLhXhJSscDd2rIOmWRh2fnq2NPrY5se0dWorNYWNxQXpogREYy
   n9nAoaig+Ps6IE4CpC0eKj/spk+cBbE9S6+r1zLpSc9dmnND0GWdGXe7v
   Q==;
X-CSE-ConnectionGUID: Sz7GDxEIQnaZdvn3+b0SBA==
X-CSE-MsgGUID: r8qMeue6QiavlAB3ocEySQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57752431"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="57752431"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:01:22 -0700
X-CSE-ConnectionGUID: QQtpBEeXRGmTeBW803Rtow==
X-CSE-MsgGUID: 5ZVZO86jTKeCuxY1TkW0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154655596"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jul 2025 00:01:18 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXaQ8-0003QZ-26;
	Fri, 04 Jul 2025 07:01:16 +0000
Date: Fri, 4 Jul 2025 15:00:27 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 05/18] bpf: introduce bpf_gtramp_link
Message-ID: <202507041433.Taj70BHu-lkp@intel.com>
References: <20250703121521.1874196-6-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703121521.1874196-6-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-add-function-hash-table-for-tracing-multi/20250703-203035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250703121521.1874196-6-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2 05/18] bpf: introduce bpf_gtramp_link
config: x86_64-buildonly-randconfig-002-20250704 (https://download.01.org/0day-ci/archive/20250704/202507041433.Taj70BHu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041433.Taj70BHu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041433.Taj70BHu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:36:34: warning: 'bpf_shim_tramp_link_lops' defined but not used [-Wunused-const-variable=]
      36 | static const struct bpf_link_ops bpf_shim_tramp_link_lops;
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_shim_tramp_link_lops +36 kernel/bpf/trampoline.c

    33	
    34	static struct bpf_global_trampoline global_tr_array[MAX_BPF_FUNC_ARGS + 1];
    35	static DEFINE_MUTEX(global_tr_lock);
  > 36	static const struct bpf_link_ops bpf_shim_tramp_link_lops;
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


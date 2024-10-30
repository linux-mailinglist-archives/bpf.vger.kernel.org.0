Return-Path: <bpf+bounces-43605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607D9B6FAB
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDCE284BCF
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8F21730A;
	Wed, 30 Oct 2024 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rq5koNej"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6431D172C;
	Wed, 30 Oct 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326062; cv=none; b=FOEq98UaVhQtX+XymqhK96ZbhLOlyewoRUaUoNWpeiNjWpDidJrFviK+xBMtCwutcNgLMSzwPZFC02/5kj8x87RQ6+TjJCqBXSMpFVS6rTCmANcAhvCYKXQkCLq8IJM4P1xUTdcKQNVjR76531tomv3QPyd09Ty5hbUuNz+my1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326062; c=relaxed/simple;
	bh=H4ffWR0CSb3nEgwT13IaFtyC9EUaVL1JNHYQs8glEbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFMqmcdxZyo2sOiVbhH+TaS1/xAZpUA5TwAmUOoZfLUkNldEdBS/VaWVE2RbfeBMPSwDzj28mMwpygpnOayIEHkG373ob/qV/si2qjVlJD7R5pViF5NVAY9SeU4GT5VGEBlFmRWnSACaegx/64IL2beDMNh3WA1t/fWc0Gex2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rq5koNej; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730326060; x=1761862060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H4ffWR0CSb3nEgwT13IaFtyC9EUaVL1JNHYQs8glEbs=;
  b=Rq5koNejstznFvpGtE4ftD8dIQLX5ZXy5oD8J9vov3lJ8JntsAakTT4R
   J0D71gFtS76hAzaeTmPUIPo1gmCPRJW33tAmcNcv3wcKchFcox85QqCJp
   Db1uhgo2OfoUvIRXeG6P1IeSZo61OvyEuKL88iWsJR9Mkh92euVpCsqEy
   sAK8xmgLllirNgGJnFGak2A/cRxWYjYfQvFMGUF6K9Ghcv2HmR9bCDqmJ
   ymu0umRvSJLqynwjd/NP07jwgZRvOlI+N18kOQ7ifYWIVd2cM6itHwNHI
   Bj0YCyBggeEBhQyQ8HY4LEUsFHKNEkTYsA/5+RUDxlWlVJdmPSYBtwSC0
   w==;
X-CSE-ConnectionGUID: yklDU8jJT9+TvARFDFxIOg==
X-CSE-MsgGUID: Rf3VFMifQRiJkgZIx6bQGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29948153"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="29948153"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 15:07:40 -0700
X-CSE-ConnectionGUID: yd3xnpfcT724hfzFZ+z5Hg==
X-CSE-MsgGUID: gwk6556VT/28ChCtkm8LHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="87049121"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2024 15:07:37 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Gql-000fMf-09;
	Wed, 30 Oct 2024 22:07:35 +0000
Date: Thu, 31 Oct 2024 06:07:07 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kernel symbol for struct_ops trampoline
Message-ID: <202410310549.6S1px0jq-lkp@intel.com>
References: <20241030111533.907289-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030111533.907289-1-xukuohai@huaweicloud.com>

Hi Xu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Add-kernel-symbol-for-struct_ops-trampoline/20241030-190704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241030111533.907289-1-xukuohai%40huaweicloud.com
patch subject: [PATCH bpf-next] bpf: Add kernel symbol for struct_ops trampoline
config: arm-randconfig-004-20241031 (https://download.01.org/0day-ci/archive/20241031/202410310549.6S1px0jq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410310549.6S1px0jq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410310549.6S1px0jq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/bpf_struct_ops.c: In function 'bpf_struct_ops_map_update_elem':
>> kernel/bpf/bpf_struct_ops.c:596:61: warning: '%s' directive output may be truncated writing up to 511 bytes into a region of size 497 [-Wformat-truncation=]
     596 |         snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%s",
         |                                                             ^~
   In function 'bpf_struct_ops_ksym_init',
       inlined from 'bpf_struct_ops_map_update_elem' at kernel/bpf/bpf_struct_ops.c:772:3:
   kernel/bpf/bpf_struct_ops.c:596:9: note: 'snprintf' output between 16 and 527 bytes into a destination of size 512
     596 |         snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%s",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     597 |                  prog->aux->ksym.name);
         |                  ~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +596 kernel/bpf/bpf_struct_ops.c

   591	
   592	static void bpf_struct_ops_ksym_init(struct bpf_prog *prog, void *image,
   593					     unsigned int size, struct bpf_ksym *ksym)
   594	{
   595		INIT_LIST_HEAD_RCU(&ksym->lnode);
 > 596		snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%s",
   597			 prog->aux->ksym.name);
   598		bpf_image_ksym_init(image, size, ksym);
   599	}
   600	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


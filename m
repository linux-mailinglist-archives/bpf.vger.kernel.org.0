Return-Path: <bpf+bounces-13288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2937D7A17
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 03:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95AC281E4E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959A4695;
	Thu, 26 Oct 2023 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Us0VQLr2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3A440B
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 01:24:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37934BD
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698283492; x=1729819492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UtNFOekasspKvSGlYBfxSJgeD5Z3RPVX4i0r+0MZT8o=;
  b=Us0VQLr2asZ8jeUbb03+pN470Sr4QrZV7zxssEGegencxHLH6JRYXJ1M
   seOfRb/zH3MJgueqxmq/RrZiKV3lgO6rMhbw2TJI1gboVRlt3dzUm1xHA
   H176spb30w1P18Afb40kypZhFADsBy06xNBHke75tZ78v0Htr3dEAKBUE
   CSrCDVOSO9dD2KvJuiK7BAyWltYRJ0BNo3/G9zI7V4/NaACUkmXiwk1Sk
   65OUMb7t6HmWDwiVSGKaYnZeaDvlwdKUhc+XVk1AyBE71unWXaBiMJJQj
   vI0WC99hVowMlOtcpmF+D7dPRBqTD+dYMmJQ9dD11NBD1XhCl9NHCs/D5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372483564"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="372483564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 18:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="759033354"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="759033354"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Oct 2023 18:24:48 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qvp77-0009K6-0L;
	Thu, 26 Oct 2023 01:24:45 +0000
Date: Thu, 26 Oct 2023 09:24:34 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH v1 bpf-next 3/4] btf: Descend into structs and arrays
 during special field search
Message-ID: <202310260952.C9Gb9Avi-lkp@intel.com>
References: <20231023220030.2556229-4-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023220030.2556229-4-davemarchevsky@fb.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Fix-btf_get_field_type-to-fail-for-multiple-bpf_refcount-fields/20231024-060227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231023220030.2556229-4-davemarchevsky%40fb.com
patch subject: [PATCH v1 bpf-next 3/4] btf: Descend into structs and arrays during special field search
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231026/202310260952.C9Gb9Avi-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260952.C9Gb9Avi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260952.C9Gb9Avi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/btf.c:3634:70: warning: variable 'off' is uninitialized when used here [-Wuninitialized]
           ret = btf_find_struct_field(btf, elem_type, srch, array_field_off + off, rec);
                                                                               ^~~
   kernel/bpf/btf.c:3625:15: note: initialize the variable 'off' to silence this warning
           u32 i, j, off, nelems;
                        ^
                         = 0
   1 warning generated.


vim +/off +3634 kernel/bpf/btf.c

  3616	
  3617	static int btf_flatten_array_field(const struct btf *btf,
  3618					   const struct btf_type *t,
  3619					   struct btf_field_info_search *srch,
  3620					   int array_field_off, int rec)
  3621	{
  3622		int ret, start_idx, elem_field_cnt;
  3623		const struct btf_type *elem_type;
  3624		struct btf_field_info *info;
  3625		u32 i, j, off, nelems;
  3626	
  3627		if (!btf_type_is_array(t))
  3628			return -EINVAL;
  3629		nelems = __multi_dim_elem_type_nelems(btf, t, &elem_type);
  3630		if (!nelems || !__btf_type_is_struct(elem_type))
  3631			return srch->idx;
  3632	
  3633		start_idx = srch->idx;
> 3634		ret = btf_find_struct_field(btf, elem_type, srch, array_field_off + off, rec);
  3635		if (ret < 0)
  3636			return ret;
  3637	
  3638		/* No btf_field_info's added */
  3639		if (srch->idx == start_idx)
  3640			return srch->idx;
  3641	
  3642		elem_field_cnt = srch->idx - start_idx;
  3643		info = __next_field_infos(srch, elem_field_cnt * (nelems - 1));
  3644		if (IS_ERR_OR_NULL(info))
  3645			return PTR_ERR(info);
  3646	
  3647		/* Array elems after the first can copy first elem's btf_field_infos
  3648		 * and adjust offset
  3649		 */
  3650		for (i = 1; i < nelems; i++) {
  3651			memcpy(info, &srch->infos[start_idx],
  3652			       elem_field_cnt * sizeof(struct btf_field_info));
  3653			for (j = 0; j < elem_field_cnt; j++) {
  3654				info->off += (i * elem_type->size);
  3655				info++;
  3656			}
  3657		}
  3658		return srch->idx;
  3659	}
  3660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


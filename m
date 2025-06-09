Return-Path: <bpf+bounces-60042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3AAD1AA3
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41743A9417
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A82D24E4AD;
	Mon,  9 Jun 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4kEyCLT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62ED165F1A;
	Mon,  9 Jun 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461568; cv=none; b=RlKBQCSfXYdkihosmIQ+hk1NiS3Zt+zM85PIle+aEcfkMNvj+htYLG0gEOyzjjtz7/OC+H43YsuGcokEE53W+OXwzT6yWW8HENdSr0eM3wiE1Os6nJFopo14YQa9BpZGyEk5hLBFQVQ+/G+UgNKfHrXxLt5HWLGsiLyCNN4JsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461568; c=relaxed/simple;
	bh=kwrjQqsi+KQR1DGixXAcKKCvfe+g1x3sFeUhZbp3Qlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URQxRgIvbjQ/5sDI0qm5JUREiukc7wKnzcdPvEB+aSGk3KmFJmYnczMb4I0pP84KP5+VkT63fwwjUdbgFTyARWTxJycr7f86aNKDiNwTKMqwDgThbn9GKh/MuKlL7xsqcR3t1EhEjDl0s4JZabWNEN0wNu7ZeUdBrLebYHHQgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4kEyCLT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749461567; x=1780997567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwrjQqsi+KQR1DGixXAcKKCvfe+g1x3sFeUhZbp3Qlg=;
  b=K4kEyCLTpGew/5ZHkkU214TAtGkjYQU0qZMES/j3dqd7wWF2G25pwZ7d
   aFQeQn2wd8sDkySHibKWDUoVW1/N3Zmcn252b+39WhRmvXEidGE+LJCop
   LHoG1xA6grp6zwgorg79URt64s1PhFblMcjoVf7NG5vKwKYc4alPTLenm
   dRgJ1xhWW2UTbz1smex6fHu2kBgjAyDMsilch0V7C0OOEp4VkhxSDX5og
   iXkeAFvJghSS5CaH3IBE79tZqmIvMdkid7UtZow5Kg09Rd5CYH197DOwr
   NCC/9OWFSCrM8j+N+vns673vUCR98MI17RfG6mHN41ZB6U4WMaqUeSbx0
   A==;
X-CSE-ConnectionGUID: v5QYnaZhTO2sXm5Wd0g4NQ==
X-CSE-MsgGUID: e209d9EURHOGn2LaJorqpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="50642361"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="50642361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 02:32:46 -0700
X-CSE-ConnectionGUID: 8Y/TJhGYSjWVSpISYKSo4A==
X-CSE-MsgGUID: /+hp/DF6TFmrUAqMvEhgAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="151278853"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Jun 2025 02:32:43 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOYrw-0006ub-2O;
	Mon, 09 Jun 2025 09:32:40 +0000
Date: Mon, 9 Jun 2025 17:31:41 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bboscaccy@linux.microsoft.com,
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 01/12] bpf: Implement an internal helper for SHA256
 hashing
Message-ID: <202506091719.RN2qjs3P-lkp@intel.com>
References: <20250606232914.317094-2-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606232914.317094-2-kpsingh@kernel.org>

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.16-rc1 next-20250606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/bpf-Implement-an-internal-helper-for-SHA256-hashing/20250607-073052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250606232914.317094-2-kpsingh%40kernel.org
patch subject: [PATCH 01/12] bpf: Implement an internal helper for SHA256 hashing
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20250609/202506091719.RN2qjs3P-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250609/202506091719.RN2qjs3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506091719.RN2qjs3P-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: kernel/bpf/core.o: in function `bpf_sha256':
>> kernel/bpf/core.c:298:(.text+0x502c): undefined reference to `crypto_alloc_shash'
>> alpha-linux-ld: kernel/bpf/core.c:298:(.text+0x5058): undefined reference to `crypto_alloc_shash'
>> alpha-linux-ld: kernel/bpf/core.c:311:(.text+0x50a4): undefined reference to `crypto_shash_init'
   alpha-linux-ld: kernel/bpf/core.c:311:(.text+0x50b0): undefined reference to `crypto_shash_init'
   alpha-linux-ld: kernel/bpf/core.o: in function `crypto_free_shash':
>> include/crypto/hash.h:765:(.text+0x50e0): undefined reference to `crypto_destroy_tfm'
>> alpha-linux-ld: include/crypto/hash.h:765:(.text+0x50e4): undefined reference to `crypto_destroy_tfm'
   alpha-linux-ld: kernel/bpf/core.o: in function `crypto_shash_update':
>> include/crypto/hash.h:992:(.text+0x5120): undefined reference to `crypto_shash_finup'
>> alpha-linux-ld: include/crypto/hash.h:992:(.text+0x5124): undefined reference to `crypto_shash_finup'
   alpha-linux-ld: kernel/bpf/core.o: in function `crypto_shash_final':
   include/crypto/hash.h:1011:(.text+0x5138): undefined reference to `crypto_shash_finup'
   alpha-linux-ld: include/crypto/hash.h:1011:(.text+0x5148): undefined reference to `crypto_shash_finup'
   alpha-linux-ld: kernel/bpf/core.o: in function `crypto_free_shash':
   include/crypto/hash.h:765:(.text+0x5158): undefined reference to `crypto_destroy_tfm'
   alpha-linux-ld: include/crypto/hash.h:765:(.text+0x5164): undefined reference to `crypto_destroy_tfm'


vim +298 kernel/bpf/core.c

   290	
   291	int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest)
   292	{
   293		struct crypto_shash *tfm;
   294		struct shash_desc *shash_desc;
   295		size_t desc_size;
   296		int ret = 0;
   297	
 > 298		tfm = crypto_alloc_shash("sha256", 0, 0);
   299		if (IS_ERR(tfm))
   300			return PTR_ERR(tfm);
   301	
   302	
   303		desc_size = crypto_shash_descsize(tfm) + sizeof(*shash_desc);
   304		shash_desc = kmalloc(desc_size, GFP_KERNEL);
   305		if (!shash_desc) {
   306			crypto_free_shash(tfm);
   307			return -ENOMEM;
   308		}
   309	
   310		shash_desc->tfm = tfm;
 > 311		ret = crypto_shash_init(shash_desc);
   312		if (ret)
   313			goto out_free_desc;
   314	
   315		ret = crypto_shash_update(shash_desc, data, data_size);
   316		if (ret)
   317			goto out_free_desc;
   318	
   319		ret = crypto_shash_final(shash_desc, output_digest);
   320		if (ret)
   321			goto out_free_desc;
   322	
   323	out_free_desc:
   324		kfree(shash_desc);
   325		crypto_free_shash(tfm);
   326		return ret;
   327	}
   328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


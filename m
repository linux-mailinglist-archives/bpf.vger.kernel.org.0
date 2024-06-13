Return-Path: <bpf+bounces-32123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60327907C8F
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A161C222B3
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9814B976;
	Thu, 13 Jun 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCZ8wsIC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E46130487
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306745; cv=none; b=lQrXnN6g/Jlv+mqroXmGRDKGtASK1HHsylVIIRRG+PWL2xnCsFY4oSO3JgpqwNzI2DUbWYDcWrmUEs0tDzMerfqWFOJn7CjXcCIUThacT0P3A76e3MkJOLSJ9qqzIVQp8l8zqyVfXV6V3A9YmezHeaDwRvEZ80nhbu0YyX6GU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306745; c=relaxed/simple;
	bh=VC0WTxQ8xaHvRuADJJ8NAKDpVXa/w+q7KdgTGGsjC6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/LsVUVZK2NpHK2GzQbvH8cvkxeBeu1+8IivGJmEaz5gFZ8pG6jwItwQSoRSwY6Uy0Fdhfu7hHpySmhkzwF3f+bkHhQzIf3Fj9B1rYmTTJ7DOL++1yWIIGK9/cMDiI7qHpig1zABPAuJ/0D/nB6nc2XVdNauBPlETB8p29J0RX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCZ8wsIC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718306744; x=1749842744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VC0WTxQ8xaHvRuADJJ8NAKDpVXa/w+q7KdgTGGsjC6g=;
  b=oCZ8wsICgizSPqDmsW3KH0uKBdmq+rJpqsA0wv/p8LOf9DpisIrD+IEf
   2JjN1tee12/Q8reBgSAOLwvr3PN+ZOd139dm71idris6kN10OpZvEZlkp
   ytRO6yAhq0nJuyRoGMGnPAOMqWnkBGwCa2BNMr3QHavP5sfifav5TPV4O
   gRp2Wn0I947KraVwSrg5lE/AWomCOVXfqQb3wAibq2rBIFfPEP/5ZXSWk
   /15YhAtmiz5qUrKaY0aPTcSbL9eOtong8t3Fg6zsBA2/KDPgiRHP0kerN
   d2TPLKo5MImDdwE4/zrkC7p+wCsa1h+JeIW4X4W42SiwMTjx64PcbW9gH
   Q==;
X-CSE-ConnectionGUID: rdRQr8DiT2SQSiir3U+qhg==
X-CSE-MsgGUID: uWBCkUFjQQSMkMkf+UO2lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14894777"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="14894777"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:25:14 -0700
X-CSE-ConnectionGUID: NlDkBrA0Rlq0BQ28IFIQsQ==
X-CSE-MsgGUID: PXFJewhRQcybd0z83ZvCoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="45369318"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jun 2024 12:25:12 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHq4L-0000KK-0A;
	Thu, 13 Jun 2024 19:25:09 +0000
Date: Fri, 14 Jun 2024 03:24:45 +0800
From: kernel test robot <lkp@intel.com>
To: Rafael Passos <rafael@rcpassos.me>, davem@davemloft.net,
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, Rafael Passos <rafael@rcpassos.me>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: remove unused parameter in
 bpf_jit_binary_pack_finalize
Message-ID: <202406140304.4Rf0F9mg-lkp@intel.com>
References: <7eaed3dc-28e5-409f-8f73-a1bf8acc2937@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eaed3dc-28e5-409f-8f73-a1bf8acc2937@smtp-relay.sendinblue.com>

Hi Rafael,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-Passos/bpf-remove-unused-parameter-in-__bpf_free_used_btfs/20240613-110048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/7eaed3dc-28e5-409f-8f73-a1bf8acc2937%40smtp-relay.sendinblue.com
patch subject: [PATCH bpf-next 1/3] bpf: remove unused parameter in bpf_jit_binary_pack_finalize
config: powerpc-mpc885_ads_defconfig (https://download.01.org/0day-ci/archive/20240614/202406140304.4Rf0F9mg-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406140304.4Rf0F9mg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406140304.4Rf0F9mg-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
>> arch/powerpc/net/bpf_jit_comp.c:228:50: error: passing argument 1 of 'bpf_jit_binary_pack_finalize' from incompatible pointer type [-Werror=incompatible-pointer-types]
     228 |                 if (bpf_jit_binary_pack_finalize(fp, fhdr, hdr)) {
         |                                                  ^~
         |                                                  |
         |                                                  struct bpf_prog *
   In file included from arch/powerpc/net/bpf_jit_comp.c:14:
   include/linux/filter.h:1132:60: note: expected 'struct bpf_binary_header *' but argument is of type 'struct bpf_prog *'
    1132 | int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>> arch/powerpc/net/bpf_jit_comp.c:228:21: error: too many arguments to function 'bpf_jit_binary_pack_finalize'
     228 |                 if (bpf_jit_binary_pack_finalize(fp, fhdr, hdr)) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/filter.h:1132:5: note: declared here
    1132 | int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_jit_free':
   arch/powerpc/net/bpf_jit_comp.c:351:54: error: passing argument 1 of 'bpf_jit_binary_pack_finalize' from incompatible pointer type [-Werror=incompatible-pointer-types]
     351 |                         bpf_jit_binary_pack_finalize(fp, jit_data->fhdr, jit_data->hdr);
         |                                                      ^~
         |                                                      |
         |                                                      struct bpf_prog *
   include/linux/filter.h:1132:60: note: expected 'struct bpf_binary_header *' but argument is of type 'struct bpf_prog *'
    1132 | int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
   arch/powerpc/net/bpf_jit_comp.c:351:25: error: too many arguments to function 'bpf_jit_binary_pack_finalize'
     351 |                         bpf_jit_binary_pack_finalize(fp, jit_data->fhdr, jit_data->hdr);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/filter.h:1132:5: note: declared here
    1132 | int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bpf_jit_binary_pack_finalize +228 arch/powerpc/net/bpf_jit_comp.c

4ea76e90a97d22 Christophe Leroy 2021-03-22  222  
90d862f370b6e9 Hari Bathini     2023-10-20  223  	fp->bpf_func = (void *)fimage;
4ea76e90a97d22 Christophe Leroy 2021-03-22  224  	fp->jited = 1;
983bdc0245a29c Ravi Bangoria    2021-10-12  225  	fp->jited_len = proglen + FUNCTION_DESCR_SIZE;
4ea76e90a97d22 Christophe Leroy 2021-03-22  226  
4ea76e90a97d22 Christophe Leroy 2021-03-22  227  	if (!fp->is_func || extra_pass) {
90d862f370b6e9 Hari Bathini     2023-10-20 @228  		if (bpf_jit_binary_pack_finalize(fp, fhdr, hdr)) {
90d862f370b6e9 Hari Bathini     2023-10-20  229  			fp = org_fp;
90d862f370b6e9 Hari Bathini     2023-10-20  230  			goto out_addrs;
90d862f370b6e9 Hari Bathini     2023-10-20  231  		}
4ea76e90a97d22 Christophe Leroy 2021-03-22  232  		bpf_prog_fill_jited_linfo(fp, addrs);
4ea76e90a97d22 Christophe Leroy 2021-03-22  233  out_addrs:
4ea76e90a97d22 Christophe Leroy 2021-03-22  234  		kfree(addrs);
4ea76e90a97d22 Christophe Leroy 2021-03-22  235  		kfree(jit_data);
4ea76e90a97d22 Christophe Leroy 2021-03-22  236  		fp->aux->jit_data = NULL;
4ea76e90a97d22 Christophe Leroy 2021-03-22  237  	} else {
4ea76e90a97d22 Christophe Leroy 2021-03-22  238  		jit_data->addrs = addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  239  		jit_data->ctx = cgctx;
4ea76e90a97d22 Christophe Leroy 2021-03-22  240  		jit_data->proglen = proglen;
90d862f370b6e9 Hari Bathini     2023-10-20  241  		jit_data->fimage = fimage;
90d862f370b6e9 Hari Bathini     2023-10-20  242  		jit_data->fhdr = fhdr;
90d862f370b6e9 Hari Bathini     2023-10-20  243  		jit_data->hdr = hdr;
4ea76e90a97d22 Christophe Leroy 2021-03-22  244  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  245  
4ea76e90a97d22 Christophe Leroy 2021-03-22  246  out:
4ea76e90a97d22 Christophe Leroy 2021-03-22  247  	if (bpf_blinded)
4ea76e90a97d22 Christophe Leroy 2021-03-22  248  		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
4ea76e90a97d22 Christophe Leroy 2021-03-22  249  
4ea76e90a97d22 Christophe Leroy 2021-03-22  250  	return fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  251  }
983bdc0245a29c Ravi Bangoria    2021-10-12  252  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


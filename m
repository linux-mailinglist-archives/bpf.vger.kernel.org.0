Return-Path: <bpf+bounces-27540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09CB8AE568
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768EF1F24394
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108C12EBF7;
	Tue, 23 Apr 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l70ZxMLC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FF7EEE1;
	Tue, 23 Apr 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873396; cv=none; b=h9jKYHiacrwmt6Ry3dnH1SxsSws/deFf5JiDsRsLw/Zr3J9r5qr7oLj48sD7kYTxPJgKB5iFelEPifPCwGZ5dlYVGEXTilAKEf1moDJWL+kBi+4/lA9NFrbD6tV35TJ7wIcUbKqD5FwNoX1I1RydHkuXSxwnOC8c0gKXREySIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873396; c=relaxed/simple;
	bh=p/uf6VYgCKT6JxvSBrFmzJpBlF+YiW1WjAHp1el+N5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRefhtASDKr2mEtCS9loH8pgtQWYN18D53HyMy1whrzoBECHPWqDZdm2D18Q0UaZHdG6UYl/X308kqKJ0JuXaMIt+BPHsTa+N1IQ00Q9DWpIhDl8jwiz4ZI4DOsgb4yZpomF3evbWPuNx+aMLylSTPDbc7T8UZPbyo6Y8R3Krdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l70ZxMLC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713873394; x=1745409394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p/uf6VYgCKT6JxvSBrFmzJpBlF+YiW1WjAHp1el+N5I=;
  b=l70ZxMLCwCNRoVpPZ+6C1OJXBW1NP6oY2Pq1YTRMDENlzci8CzzE9n8N
   DVB7iUAfVhYTMyBCMcbCRBP2Al10uk6cDKYL+AeT8UXV4Co24b3kVDB9z
   bCK8HKX8iq0hJVlF5XJ1eR38SbiiZIWFr9i/ySPa4vbcuEec4FcYQsuZr
   lNMxhmjkoygZdNhANOZj1AgV9LINxiRChBKksICUsmZ0ung2UuyMV8osl
   zt1BW10YJjFVD0OUqkDGaWHS60qPnNvhz4rNiYVwHGS/+I222MgYruUBU
   4IemIm7ObGEJNGl1F4AEyGwK4K9F/9ph3Sg0cGbgxTncTduIKHLlPxKUm
   g==;
X-CSE-ConnectionGUID: aWWkIAmwT5yF6caDE4I5tw==
X-CSE-MsgGUID: +5RLew28Sn6Zlr3xt0ZJFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9305408"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9305408"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:56:33 -0700
X-CSE-ConnectionGUID: hWAL2QWzRY67+bfCqqupIA==
X-CSE-MsgGUID: nyaBbhdCQVKOIqKg29TI3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55297699"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Apr 2024 04:56:30 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzEl9-0000A4-0p;
	Tue, 23 Apr 2024 11:56:27 +0000
Date: Tue, 23 Apr 2024 19:56:10 +0800
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
Subject: Re: [PATCH bpf-next v10 1/4] bpf: make common crypto API for TC/XDP
 programs
Message-ID: <202404231955.qUkSEasH-lkp@intel.com>
References: <20240422225024.2847039-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422225024.2847039-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-make-common-crypto-API-for-TC-XDP-programs/20240423-070416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240422225024.2847039-2-vadfed%40meta.com
patch subject: [PATCH bpf-next v10 1/4] bpf: make common crypto API for TC/XDP programs
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240423/202404231955.qUkSEasH-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 5ef5eb66fb428aaf61fb51b709f065c069c11242)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240423/202404231955.qUkSEasH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404231955.qUkSEasH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/crypto.c:34: warning: Function parameter or struct member 'reserved' not described in 'bpf_crypto_params'
   kernel/bpf/crypto.c:55: warning: Function parameter or struct member 'siv_len' not described in 'bpf_crypto_ctx'


vim +34 kernel/bpf/crypto.c

    17	
    18	/* BPF crypto initialization parameters struct */
    19	/**
    20	 * struct bpf_crypto_params - BPF crypto initialization parameters structure
    21	 * @type:	The string of crypto operation type.
    22	 * @algo:	The string of algorithm to initialize.
    23	 * @key:	The cipher key used to init crypto algorithm.
    24	 * @key_len:	The length of cipher key.
    25	 * @authsize:	The length of authentication tag used by algorithm.
    26	 */
    27	struct bpf_crypto_params {
    28		char type[14];
    29		u8 reserved[2];
    30		char algo[128];
    31		u8 key[256];
    32		u32 key_len;
    33		u32 authsize;
  > 34	};
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <bpf+bounces-29432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066548C1CC7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 05:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F31F21429
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70902148859;
	Fri, 10 May 2024 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P11mSzpO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB4148840
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310467; cv=none; b=fGYASFgqh5HpZ9hpsAOvOtre8VFRMaXD98e6lH7cWpv3JJet18Xv+a7f4MY3ID1Yo8KJXinkCbtsW191n8R3rE269Ia4tWf97kw6OgdWjeUWu1ClVPhlvf6hmuqLBhXy9TBVRCB+cf4DfN6LRYxm2eyLDadLlBtBzQUOJi86BaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310467; c=relaxed/simple;
	bh=dPH6kqDpeaeBXR2NBCEu1O/kZ4gXvXSAUQZnXU7j9Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyZGG5yCdwMkqRtPrK45jSzMPvgOYrFhB0koQ8CSZR4cEwRsbjYnXuWmTTuL/9/l5j+09wMViM3fmP8RBfbSYbt9n2NMUNtQqP2KSLWHLbogfk9xJOUo5glibEllYmMBV0Zd6/KNeQqlUhzfaDikOWpxkXSR1aRkO2mkFe7xfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P11mSzpO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715310465; x=1746846465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dPH6kqDpeaeBXR2NBCEu1O/kZ4gXvXSAUQZnXU7j9Lc=;
  b=P11mSzpOcQAY52ahZy+N3zEusuhKA7Q+1t4B6rU3Eb9ORtW3ipUv/O8M
   Cv86OUXHwz37H+Pk374WRBQbVOPgD2zeGrREf8KeZqGgMzChneUruDhT+
   xX4gyhVYv9bErt44LdKuLDW23DWGmTGAENofqZT+vmxYq2WG3+Oh9gb9W
   EsvcWij1/jab8fbwIKxBOBnC+DsOB8cmHwsFdfyMRkVNSjqm+JBfws47j
   rUT/iGF3XB7yqypkwzoQyct2C3HNUH1qLa/5Dk+VFxBNqhvORah17S8vR
   YFJZDj7QTwdoTSJFVTiT0Ot7kHtHOevDieXqTTI3mNGO0p1mu6SxqCVLi
   Q==;
X-CSE-ConnectionGUID: ZJWfnxXCRvGCSv8AfOTFkg==
X-CSE-MsgGUID: rM2WvXGKSQiNNXOBxDI76w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15107356"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="15107356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:07:45 -0700
X-CSE-ConnectionGUID: +dD9JHRBTF6nDBh//nmNqA==
X-CSE-MsgGUID: naGFnkWzQ52ckeAjBn/F5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="33982807"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2024 20:07:42 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5Gbk-0005ez-1A;
	Fri, 10 May 2024 03:07:40 +0000
Date: Fri, 10 May 2024 11:07:27 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/4] bpf: crypto: make state and IV dynptr
 nullable
Message-ID: <202405101026.4PbHjNBN-lkp@intel.com>
References: <20240509134023.1289303-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509134023.1289303-3-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-verifier-make-kfuncs-args-nullalble/20240509-214252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240509134023.1289303-3-vadfed%40meta.com
patch subject: [PATCH bpf-next 2/4] bpf: crypto: make state and IV dynptr nullable
config: x86_64-randconfig-102-20240510 (https://download.01.org/0day-ci/archive/20240510/202405101026.4PbHjNBN-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101026.4PbHjNBN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101026.4PbHjNBN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/crypto.c:317: warning: Function parameter or struct member 'siv__nullable' not described in 'bpf_crypto_decrypt'
>> kernel/bpf/crypto.c:317: warning: Excess function parameter 'siv' description in 'bpf_crypto_decrypt'
>> kernel/bpf/crypto.c:334: warning: Function parameter or struct member 'siv__nullable' not described in 'bpf_crypto_encrypt'
>> kernel/bpf/crypto.c:334: warning: Excess function parameter 'siv' description in 'bpf_crypto_encrypt'


vim +317 kernel/bpf/crypto.c

3e1c6f35409f9e Vadim Fedorenko 2024-04-22  303  
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  304  /**
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  305   * bpf_crypto_decrypt() - Decrypt buffer using configured context and IV provided.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  306   * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  307   * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  308   * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  309   * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  310   *
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  311   * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  312   */
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  313  __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  314  				   const struct bpf_dynptr_kern *src,
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  315  				   const struct bpf_dynptr_kern *dst,
9ce5fb6f36b954 Vadim Fedorenko 2024-05-09  316  				   const struct bpf_dynptr_kern *siv__nullable)
3e1c6f35409f9e Vadim Fedorenko 2024-04-22 @317  {
9ce5fb6f36b954 Vadim Fedorenko 2024-05-09  318  	return bpf_crypto_crypt(ctx, src, dst, siv__nullable, true);
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  319  }
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  320  
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  321  /**
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  322   * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV provided.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  323   * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  324   * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  325   * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  326   * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  327   *
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  328   * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  329   */
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  330  __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  331  				   const struct bpf_dynptr_kern *src,
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  332  				   const struct bpf_dynptr_kern *dst,
9ce5fb6f36b954 Vadim Fedorenko 2024-05-09  333  				   const struct bpf_dynptr_kern *siv__nullable)
3e1c6f35409f9e Vadim Fedorenko 2024-04-22 @334  {
9ce5fb6f36b954 Vadim Fedorenko 2024-05-09  335  	return bpf_crypto_crypt(ctx, src, dst, siv__nullable, false);
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  336  }
3e1c6f35409f9e Vadim Fedorenko 2024-04-22  337  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


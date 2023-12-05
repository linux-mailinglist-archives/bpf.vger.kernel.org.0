Return-Path: <bpf+bounces-16810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D10806085
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4B0281BBC
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B296E5A2;
	Tue,  5 Dec 2023 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeGSaUz9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7836A5;
	Tue,  5 Dec 2023 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810956; x=1733346956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogrbkej1C6j1SgmkqoFwO0g7oaDZworPVFJs/PMsK4g=;
  b=OeGSaUz9KxnJLQD1yZRC5ArNTsUWe3iISI5TPLMhL3KiHHc8IZj0RvlI
   nYdEEypZXXlyrGb7YPHI4+Amjs5X33Iv8pnOCExaoCE8s+IARSONWo3xV
   jSDlld9MkUV4XtjoiMj5shTfcqX/ZFWwK0LcutT0SY8+3F+Utp+nXP+kG
   +95RtDEDOQ+Jc8RgvXqAJVieS8cUP+VrCLckqer2Pc2gQUwEcvR8DUive
   XsDgPV5EK3jaNSNgBeMZsP1clAQqiqxeaNGJmcsDZS9YTlRsZ67R20/6j
   8fECnl6TFV+pLkpgDFcB9AK0Ke9YxsGnxRgREwD6YPvY7t6DhVzlUEUw3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391127124"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="391127124"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944407746"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="944407746"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 13:15:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAcli-0009kO-1u;
	Tue, 05 Dec 2023 21:15:50 +0000
Date: Wed, 6 Dec 2023 05:15:02 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Message-ID: <202312060500.uMJaMydz-lkp@intel.com>
References: <20231202010604.1877561-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202010604.1877561-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-crypto-add-skcipher-to-bpf-crypto/20231202-091254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231202010604.1877561-1-vadfed%40meta.com
patch subject: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP programs
config: m68k-randconfig-r081-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060500.uMJaMydz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060500.uMJaMydz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060500.uMJaMydz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/crypto.c:126: warning: Function parameter or member 'authsize' not described in 'bpf_crypto_ctx_create'


vim +126 kernel/bpf/crypto.c

   105	
   106	/**
   107	 * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
   108	 *
   109	 * Allocates a crypto context that can be used, acquired, and released by
   110	 * a BPF program. The crypto context returned by this function must either
   111	 * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
   112	 * As crypto API functions use GFP_KERNEL allocations, this function can
   113	 * only be used in sleepable BPF programs.
   114	 *
   115	 * bpf_crypto_ctx_create() allocates memory for crypto context.
   116	 * It may return NULL if no memory is available.
   117	 * @type__str: pointer to string representation of crypto type.
   118	 * @algo__str: pointer to string representation of algorithm.
   119	 * @pkey:      bpf_dynptr which holds cipher key to do crypto.
   120	 * @err:       integer to store error code when NULL is returned
   121	 */
   122	__bpf_kfunc struct bpf_crypto_ctx *
   123	bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
   124			      const struct bpf_dynptr_kern *pkey,
   125			      unsigned int authsize, int *err)
 > 126	{
   127		const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
   128		struct bpf_crypto_ctx *ctx;
   129		const u8 *key;
   130		u32 key_len;
   131	
   132		type = bpf_crypto_get_type(type__str);
   133		if (IS_ERR(type)) {
   134			*err = PTR_ERR(type);
   135			return NULL;
   136		}
   137	
   138		if (!type->has_algo(algo__str)) {
   139			*err = -EOPNOTSUPP;
   140			goto err;
   141		}
   142	
   143		if (!authsize && type->setauthsize) {
   144			*err = -EOPNOTSUPP;
   145			goto err;
   146		}
   147	
   148		if (authsize && !type->setauthsize) {
   149			*err = -EOPNOTSUPP;
   150			goto err;
   151		}
   152	
   153		key_len = __bpf_dynptr_size(pkey);
   154		if (!key_len) {
   155			*err = -EINVAL;
   156			goto err;
   157		}
   158		key = __bpf_dynptr_data(pkey, key_len);
   159		if (!key) {
   160			*err = -EINVAL;
   161			goto err;
   162		}
   163	
   164		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
   165		if (!ctx) {
   166			*err = -ENOMEM;
   167			goto err;
   168		}
   169	
   170		ctx->type = type;
   171		ctx->tfm = type->alloc_tfm(algo__str);
   172		if (IS_ERR(ctx->tfm)) {
   173			*err = PTR_ERR(ctx->tfm);
   174			ctx->tfm = NULL;
   175			goto err;
   176		}
   177	
   178		if (authsize) {
   179			*err = type->setauthsize(ctx->tfm, authsize);
   180			if (*err)
   181				goto err;
   182		}
   183	
   184		*err = type->setkey(ctx->tfm, key, key_len);
   185		if (*err)
   186			goto err;
   187	
   188		refcount_set(&ctx->usage, 1);
   189	
   190		return ctx;
   191	err:
   192		if (ctx->tfm)
   193			type->free_tfm(ctx->tfm);
   194		kfree(ctx);
   195		module_put(type->owner);
   196	
   197		return NULL;
   198	}
   199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


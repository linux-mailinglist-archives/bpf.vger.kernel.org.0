Return-Path: <bpf+bounces-13579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3455D7DABE0
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 10:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB92328174C
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A88F7E;
	Sun, 29 Oct 2023 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPhcMnvy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352B320A;
	Sun, 29 Oct 2023 09:33:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B050BD;
	Sun, 29 Oct 2023 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698571980; x=1730107980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EB6AXOCzM0UMKHUfSK5sQFRebDnHx2JnAx0qwYWuJyQ=;
  b=VPhcMnvyGW6DweSmc/AxMW6vLGIRf8JHztWeKtz+ABZbAI+v+LkXImr2
   j19J1f7lEWOf/xGfPuKYByTJ+B44+oEAmIQ620O/6xl9gq8+BgM2F4JPU
   r6nriLrliBv61uLN+zHHNEL/xo+VfiSxS21ELbolyBJRW7Kh8uD2XOMya
   rdW08Z+S3E1V71b+ndcRI3pbiVHZCnkiLbY30RNqNWbJISZ+q3V2lxSrZ
   5f9xYC507kLYpUUyaRSHu8twh8BOvpGdGm4FgJKdRQ82JPt2XzH59dLGK
   2ILqFRkEzHaTerXgiTwcWubToZgOMy0X5/5MjDHtnf28X0cs2iZwUK3+p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="763520"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="763520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 02:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="789203497"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="789203497"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2023 02:32:56 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qx2A9-000CSp-2K;
	Sun, 29 Oct 2023 09:32:53 +0000
Date: Sun, 29 Oct 2023 17:32:19 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>
Cc: oe-kbuild-all@lists.linux.dev, Vadim Fedorenko <vadfed@meta.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add skcipher API support to TC/XDP
 programs
Message-ID: <202310291759.z9P4QJvI-lkp@intel.com>
References: <20231027172039.1365917-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027172039.1365917-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-bpf-crypto-skcipher-algo-selftests/20231028-020332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231027172039.1365917-1-vadfed%40meta.com
patch subject: [PATCH bpf-next v2 1/2] bpf: add skcipher API support to TC/XDP programs
config: x86_64-randconfig-001-20231029 (https://download.01.org/0day-ci/archive/20231029/202310291759.z9P4QJvI-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310291759.z9P4QJvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310291759.z9P4QJvI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/crypto.c:72:1: warning: no previous declaration for 'bpf_crypto_skcipher_ctx_create' [-Wmissing-declarations]
    bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/crypto.c:140:1: warning: no previous declaration for 'bpf_crypto_skcipher_ctx_acquire' [-Wmissing-declarations]
    bpf_crypto_skcipher_ctx_acquire(struct bpf_crypto_skcipher_ctx *ctx)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/crypto.c:154:18: warning: no previous declaration for 'bpf_crypto_skcipher_ctx_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/crypto.c:208:17: warning: no previous declaration for 'bpf_crypto_skcipher_decrypt' [-Wmissing-declarations]
    __bpf_kfunc int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/crypto.c:225:17: warning: no previous declaration for 'bpf_crypto_skcipher_encrypt' [-Wmissing-declarations]
    __bpf_kfunc int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_crypto_skcipher_ctx_create +72 kernel/bpf/crypto.c

    58	
    59	/**
    60	 * bpf_crypto_skcipher_ctx_create() - Create a mutable BPF crypto context.
    61	 *
    62	 * Allocates a crypto context that can be used, acquired, and released by
    63	 * a BPF program. The crypto context returned by this function must either
    64	 * be embedded in a map as a kptr, or freed with bpf_crypto_skcipher_ctx_release().
    65	 *
    66	 * bpf_crypto_skcipher_ctx_create() allocates memory using the BPF memory
    67	 * allocator, and will not block. It may return NULL if no memory is available.
    68	 * @algo: bpf_dynptr which holds string representation of algorithm.
    69	 * @key:  bpf_dynptr which holds cipher key to do crypto.
    70	 */
    71	__bpf_kfunc struct bpf_crypto_skcipher_ctx *
  > 72	bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,
    73				       const struct bpf_dynptr_kern *pkey, int *err)
    74	{
    75		struct bpf_crypto_skcipher_ctx *ctx;
    76		char *algo;
    77	
    78		if (__bpf_dynptr_size(palgo) > CRYPTO_MAX_ALG_NAME) {
    79			*err = -EINVAL;
    80			return NULL;
    81		}
    82	
    83		algo = __bpf_dynptr_data_ptr(palgo);
    84	
    85		if (!crypto_has_skcipher(algo, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
    86			*err = -EOPNOTSUPP;
    87			return NULL;
    88		}
    89	
    90		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
    91		if (!ctx) {
    92			*err = -ENOMEM;
    93			return NULL;
    94		}
    95	
    96		memset(ctx, 0, sizeof(*ctx));
    97	
    98		ctx->tfm = crypto_alloc_sync_skcipher(algo, 0, 0);
    99		if (IS_ERR(ctx->tfm)) {
   100			*err = PTR_ERR(ctx->tfm);
   101			ctx->tfm = NULL;
   102			goto err;
   103		}
   104	
   105		*err = crypto_sync_skcipher_setkey(ctx->tfm, __bpf_dynptr_data_ptr(pkey),
   106						   __bpf_dynptr_size(pkey));
   107		if (*err)
   108			goto err;
   109	
   110		refcount_set(&ctx->usage, 1);
   111	
   112		return ctx;
   113	err:
   114		if (ctx->tfm)
   115			crypto_free_sync_skcipher(ctx->tfm);
   116		kfree(ctx);
   117	
   118		return NULL;
   119	}
   120	
   121	static void crypto_free_sync_skcipher_cb(struct rcu_head *head)
   122	{
   123		struct bpf_crypto_skcipher_ctx *ctx;
   124	
   125		ctx = container_of(head, struct bpf_crypto_skcipher_ctx, rcu);
   126		crypto_free_sync_skcipher(ctx->tfm);
   127		kfree(ctx);
   128	}
   129	
   130	/**
   131	 * bpf_crypto_skcipher_ctx_acquire() - Acquire a reference to a BPF crypto context.
   132	 * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
   133	 *	     pointer.
   134	 *
   135	 * Acquires a reference to a BPF crypto context. The context returned by this function
   136	 * must either be embedded in a map as a kptr, or freed with
   137	 * bpf_crypto_skcipher_ctx_release().
   138	 */
   139	__bpf_kfunc struct bpf_crypto_skcipher_ctx *
 > 140	bpf_crypto_skcipher_ctx_acquire(struct bpf_crypto_skcipher_ctx *ctx)
   141	{
   142		refcount_inc(&ctx->usage);
   143		return ctx;
   144	}
   145	
   146	/**
   147	 * bpf_crypto_skcipher_ctx_release() - Release a previously acquired BPF crypto context.
   148	 * @ctx: The crypto context being released.
   149	 *
   150	 * Releases a previously acquired reference to a BPF cpumask. When the final
   151	 * reference of the BPF cpumask has been released, it is subsequently freed in
   152	 * an RCU callback in the BPF memory allocator.
   153	 */
 > 154	__bpf_kfunc void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx)
   155	{
   156		if (refcount_dec_and_test(&ctx->usage))
   157			call_rcu(&ctx->rcu, crypto_free_sync_skcipher_cb);
   158	}
   159	
   160	static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
   161					     const struct bpf_dynptr_kern *src,
   162					     struct bpf_dynptr_kern *dst,
   163					     const struct bpf_dynptr_kern *iv,
   164					     bool decrypt)
   165	{
   166		struct skcipher_request *req = NULL;
   167		struct scatterlist sgin, sgout;
   168		int err;
   169	
   170		if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
   171			return -EINVAL;
   172	
   173		if (__bpf_dynptr_is_rdonly(dst))
   174			return -EINVAL;
   175	
   176		if (!__bpf_dynptr_size(dst) || !__bpf_dynptr_size(src))
   177			return -EINVAL;
   178	
   179		if (__bpf_dynptr_size(iv) != crypto_sync_skcipher_ivsize(tfm))
   180			return -EINVAL;
   181	
   182		req = skcipher_request_alloc(&tfm->base, GFP_ATOMIC);
   183		if (!req)
   184			return -ENOMEM;
   185	
   186		sg_init_one(&sgin, __bpf_dynptr_data_ptr(src), __bpf_dynptr_size(src));
   187		sg_init_one(&sgout, __bpf_dynptr_data_ptr(dst), __bpf_dynptr_size(dst));
   188	
   189		skcipher_request_set_crypt(req, &sgin, &sgout, __bpf_dynptr_size(src),
   190					   __bpf_dynptr_data_ptr(iv));
   191	
   192		err = decrypt ? crypto_skcipher_decrypt(req) : crypto_skcipher_encrypt(req);
   193	
   194		skcipher_request_free(req);
   195	
   196		return err;
   197	}
   198	
   199	/**
   200	 * bpf_crypto_skcipher_decrypt() - Decrypt buffer using configured context and IV provided.
   201	 * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
   202	 * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
   203	 * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
   204	 * @iv:		bpf_dynptr to IV data to be used by decryptor.
   205	 *
   206	 * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
   207	 */
 > 208	__bpf_kfunc int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
   209						    const struct bpf_dynptr_kern *src,
   210						    struct bpf_dynptr_kern *dst,
   211						    const struct bpf_dynptr_kern *iv)
   212	{
   213		return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, true);
   214	}
   215	
   216	/**
   217	 * bpf_crypto_skcipher_encrypt() - Encrypt buffer using configured context and IV provided.
   218	 * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
   219	 * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
   220	 * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
   221	 * @iv:		bpf_dynptr to IV data to be used by decryptor.
   222	 *
   223	 * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
   224	 */
 > 225	__bpf_kfunc int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
   226						    const struct bpf_dynptr_kern *src,
   227						    struct bpf_dynptr_kern *dst,
   228						    const struct bpf_dynptr_kern *iv)
   229	{
   230		return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, false);
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


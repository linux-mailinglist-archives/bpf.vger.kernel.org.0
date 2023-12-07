Return-Path: <bpf+bounces-17003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8F80876F
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2601C21FA8
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DF3A8C1;
	Thu,  7 Dec 2023 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VIVOQTWA"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2CCA
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 04:14:15 -0800 (PST)
Message-ID: <098fb386-0309-4313-866a-38e12b54c02a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701951254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q1/cOmiqlDFPL84WQ9WoJ1IT+DT2CrNs/gCEPEtEv4=;
	b=VIVOQTWAU4NIxnQdCOjTRIEYjC1BShDUHfLdnQZsDg0AUq91SXdUAaSpfZcA3Y4W4GVtka
	IzAh/rS+P/cK+dJOKowDjjN4dtHvx66gDcG0tdTPct2uXWm44qQRvtKrWvq1kx4mpcZ+7+
	YkJuflOs0LmR+uaK/FL/I893PEjjgnc=
Date: Thu, 7 Dec 2023 12:14:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <dc0e2f8e-f82b-4439-b61a-9ab0be9f4e6b@suswa.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <dc0e2f8e-f82b-4439-b61a-9ab0be9f4e6b@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/12/2023 21:56, Dan Carpenter wrote:
> Hi Vadim,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-crypto-add-skcipher-to-bpf-crypto/20231202-091254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20231202010604.1877561-1-vadfed%40meta.com
> patch subject: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP programs
> config: x86_64-randconfig-161-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060647.2JfAE3rk-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060647.2JfAE3rk-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312060647.2JfAE3rk-lkp@intel.com/
> 
> smatch warnings:
> kernel/bpf/crypto.c:192 bpf_crypto_ctx_create() error: we previously assumed 'ctx' could be null (see line 165)
> kernel/bpf/crypto.c:192 bpf_crypto_ctx_create() error: potentially dereferencing uninitialized 'ctx'.
> 
> vim +/ctx +192 kernel/bpf/crypto.c
> 
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  122  __bpf_kfunc struct bpf_crypto_ctx *
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  123  bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  124  		      const struct bpf_dynptr_kern *pkey,
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  125  		      unsigned int authsize, int *err)
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  126  {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  127  	const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
> 
> Delete this assignment.  (Duplicated).
> 

Ah, yeah, will remove it.

> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  128  	struct bpf_crypto_ctx *ctx;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  129  	const u8 *key;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  130  	u32 key_len;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  131
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  132  	type = bpf_crypto_get_type(type__str);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  133  	if (IS_ERR(type)) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  134  		*err = PTR_ERR(type);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  135  		return NULL;
> 
> Why doesn't this function just return error pointers?

bpf_kfuncs cannot return error pointers, it makes BPF verifier very unhappy.

> 
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  136  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  137
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  138  	if (!type->has_algo(algo__str)) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  139  		*err = -EOPNOTSUPP;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  140  		goto err;
> 
> ctx is uninitialized on this path.
> 
Yep, it was already highlighted in the feedback, thanks.

> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  141  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  142
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  143  	if (!authsize && type->setauthsize) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  144  		*err = -EOPNOTSUPP;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  145  		goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  146  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  147
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  148  	if (authsize && !type->setauthsize) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  149  		*err = -EOPNOTSUPP;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  150  		goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  151  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  152
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  153  	key_len = __bpf_dynptr_size(pkey);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  154  	if (!key_len) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  155  		*err = -EINVAL;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  156  		goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  157  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  158  	key = __bpf_dynptr_data(pkey, key_len);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  159  	if (!key) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  160  		*err = -EINVAL;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  161  		goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  162  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  163
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  164  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01 @165  	if (!ctx) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  166  		*err = -ENOMEM;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  167  		goto err;
> 
> ctx is NULL here.
> 
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  168  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  169
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  170  	ctx->type = type;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  171  	ctx->tfm = type->alloc_tfm(algo__str);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  172  	if (IS_ERR(ctx->tfm)) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  173  		*err = PTR_ERR(ctx->tfm);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  174  		ctx->tfm = NULL;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  175  		goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  176  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  177
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  178  	if (authsize) {
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  179  		*err = type->setauthsize(ctx->tfm, authsize);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  180  		if (*err)
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  181  			goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  182  	}
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  183
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  184  	*err = type->setkey(ctx->tfm, key, key_len);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  185  	if (*err)
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  186  		goto err;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  187
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  188  	refcount_set(&ctx->usage, 1);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  189
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  190  	return ctx;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  191  err:
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01 @192  	if (ctx->tfm)
>                                                              ^^^^^^^^
> NULL dereference.  These two error handling bugs in three lines of code
> are canonical One Err Label type bugs.  Better to do a ladder where each
> error label frees the last thing that was allocated.  Easier to review.
> Then you could delete the "ctx->tfm = NULL;" assignment on line 174.
> 
> 	return ctx;
> 
> err_free_tfm:
> 	type->free_tfm(ctx->tfm);
> err_free_ctx:
> 	kfree(ctx);
> err_module_put:
> 	module_put(type->owner);
> 
> 	return NULL;
> 
> I have written about this at length on my blog:
> https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

Thanks, very good blog post, I'll follow this way in the next version.

> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  193  		type->free_tfm(ctx->tfm);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  194  	kfree(ctx);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  195  	module_put(type->owner);
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  196
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  197  	return NULL;
> 0c47cb96ac404e Vadim Fedorenko 2023-12-01  198  }
> 



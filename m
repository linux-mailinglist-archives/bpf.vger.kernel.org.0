Return-Path: <bpf+bounces-16851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEFD8066CB
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 06:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A0F281E82
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 05:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C610978;
	Wed,  6 Dec 2023 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYZn90gG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1183D44
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 21:56:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33334480eb4so477223f8f.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 21:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701842170; x=1702446970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YX4MAqN/nDup4qMOCc0EzTmKzTOsFfxIwVqJEAFEG5A=;
        b=eYZn90gGb5jE3i8EoAGo8TxzxZD18cZ2Cjp7tpqEy89liY2VdXEw6AnDuUw9NNoUyH
         KU2nnNwP+hOFAIMDsTNyksxZLevmMhf7WRB50WZX8rl/MEZoRSVnZoAMl2u9WtbOMxKM
         r+jO/t6v89WmLKmAt1a+GNpauXFYOtIk3Vqd2ndto0QAbCd+eycPN95TyI6sx2zSwKW4
         YYbZrCCsh1OF5cZ4FkI2XuIAkmjKYrdSre67XuSUtkHKuhHNzWjR7YQIQF6/rHXIXLtm
         fRlP6FJ4tNwcFRRrZ4U9kDh27/mXjkZu4meviuRkhWxq+gT6BQJWO5OXez9uJzAXs9H8
         7GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842170; x=1702446970;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX4MAqN/nDup4qMOCc0EzTmKzTOsFfxIwVqJEAFEG5A=;
        b=La0sYJXbiBAHAbJK1pQSR0VBQk0khr3VRo5i5IVyiD8627ySudTEMYfnogYo/BfWhD
         JnEn50BVUh63JQRzB9prLdlF61v2qPNEeVp/GL4QTmtEkBsBfoD29F+ikYKEdhzk1SjZ
         PPYLkftgDnmXbuG0BnaH/g1L0ruTiyOvZvNqLsXdQ1vZtCLzHNiH1gqs9AceIePL9EkJ
         o7Iz2jjF7gzaKos5KDnOJyqC7ayl+5Uig8WdtXWSnXlu7lcSpue4fv/QhG2svF4/Hsn0
         8K8phnCfGo1RS7MgUSHHbRluzfuxQcnwyir5uxEvVw1285a1b1nOYDbDcQiCd3S1WNRS
         Vjrg==
X-Gm-Message-State: AOJu0YztZhZGIyG0ZYTpPy2lR30gMlYZrkrYY3v0Elb8m+vAM2AVRArW
	wt7mF4exWE2LnAk0QPJrIkRveQ==
X-Google-Smtp-Source: AGHT+IHFQh+8y+KuZlMbCBdzapy61giA82q8qO6dwkp1UqO1DqLHlNlScuxD+uGU1Zzj3WZhPzOYjA==
X-Received: by 2002:a05:6000:c4:b0:333:3ead:54c3 with SMTP id q4-20020a05600000c400b003333ead54c3mr147557wrx.97.1701842170341;
        Tue, 05 Dec 2023 21:56:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e2-20020adf9bc2000000b003332fa77a0fsm13990491wrc.21.2023.12.05.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 21:56:10 -0800 (PST)
Date: Wed, 6 Dec 2023 08:56:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Message-ID: <dc0e2f8e-f82b-4439-b61a-9ab0be9f4e6b@suswa.mountain>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-crypto-add-skcipher-to-bpf-crypto/20231202-091254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231202010604.1877561-1-vadfed%40meta.com
patch subject: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP programs
config: x86_64-randconfig-161-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060647.2JfAE3rk-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060647.2JfAE3rk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312060647.2JfAE3rk-lkp@intel.com/

smatch warnings:
kernel/bpf/crypto.c:192 bpf_crypto_ctx_create() error: we previously assumed 'ctx' could be null (see line 165)
kernel/bpf/crypto.c:192 bpf_crypto_ctx_create() error: potentially dereferencing uninitialized 'ctx'.

vim +/ctx +192 kernel/bpf/crypto.c

0c47cb96ac404e Vadim Fedorenko 2023-12-01  122  __bpf_kfunc struct bpf_crypto_ctx *
0c47cb96ac404e Vadim Fedorenko 2023-12-01  123  bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
0c47cb96ac404e Vadim Fedorenko 2023-12-01  124  		      const struct bpf_dynptr_kern *pkey,
0c47cb96ac404e Vadim Fedorenko 2023-12-01  125  		      unsigned int authsize, int *err)
0c47cb96ac404e Vadim Fedorenko 2023-12-01  126  {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  127  	const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);

Delete this assignment.  (Duplicated).

0c47cb96ac404e Vadim Fedorenko 2023-12-01  128  	struct bpf_crypto_ctx *ctx;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  129  	const u8 *key;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  130  	u32 key_len;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  131  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  132  	type = bpf_crypto_get_type(type__str);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  133  	if (IS_ERR(type)) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  134  		*err = PTR_ERR(type);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  135  		return NULL;

Why doesn't this function just return error pointers?

0c47cb96ac404e Vadim Fedorenko 2023-12-01  136  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  137  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  138  	if (!type->has_algo(algo__str)) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  139  		*err = -EOPNOTSUPP;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  140  		goto err;

ctx is uninitialized on this path.

0c47cb96ac404e Vadim Fedorenko 2023-12-01  141  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  142  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  143  	if (!authsize && type->setauthsize) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  144  		*err = -EOPNOTSUPP;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  145  		goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  146  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  147  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  148  	if (authsize && !type->setauthsize) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  149  		*err = -EOPNOTSUPP;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  150  		goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  151  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  152  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  153  	key_len = __bpf_dynptr_size(pkey);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  154  	if (!key_len) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  155  		*err = -EINVAL;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  156  		goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  157  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  158  	key = __bpf_dynptr_data(pkey, key_len);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  159  	if (!key) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  160  		*err = -EINVAL;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  161  		goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  162  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  163  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  164  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
0c47cb96ac404e Vadim Fedorenko 2023-12-01 @165  	if (!ctx) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  166  		*err = -ENOMEM;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  167  		goto err;

ctx is NULL here.

0c47cb96ac404e Vadim Fedorenko 2023-12-01  168  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  169  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  170  	ctx->type = type;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  171  	ctx->tfm = type->alloc_tfm(algo__str);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  172  	if (IS_ERR(ctx->tfm)) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  173  		*err = PTR_ERR(ctx->tfm);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  174  		ctx->tfm = NULL;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  175  		goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  176  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  177  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  178  	if (authsize) {
0c47cb96ac404e Vadim Fedorenko 2023-12-01  179  		*err = type->setauthsize(ctx->tfm, authsize);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  180  		if (*err)
0c47cb96ac404e Vadim Fedorenko 2023-12-01  181  			goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  182  	}
0c47cb96ac404e Vadim Fedorenko 2023-12-01  183  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  184  	*err = type->setkey(ctx->tfm, key, key_len);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  185  	if (*err)
0c47cb96ac404e Vadim Fedorenko 2023-12-01  186  		goto err;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  187  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  188  	refcount_set(&ctx->usage, 1);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  189  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  190  	return ctx;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  191  err:
0c47cb96ac404e Vadim Fedorenko 2023-12-01 @192  	if (ctx->tfm)
                                                            ^^^^^^^^
NULL dereference.  These two error handling bugs in three lines of code
are canonical One Err Label type bugs.  Better to do a ladder where each
error label frees the last thing that was allocated.  Easier to review.
Then you could delete the "ctx->tfm = NULL;" assignment on line 174.

	return ctx;

err_free_tfm:
	type->free_tfm(ctx->tfm);
err_free_ctx:
	kfree(ctx);
err_module_put:
	module_put(type->owner);

	return NULL;

I have written about this at length on my blog:
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

0c47cb96ac404e Vadim Fedorenko 2023-12-01  193  		type->free_tfm(ctx->tfm);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  194  	kfree(ctx);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  195  	module_put(type->owner);
0c47cb96ac404e Vadim Fedorenko 2023-12-01  196  
0c47cb96ac404e Vadim Fedorenko 2023-12-01  197  	return NULL;
0c47cb96ac404e Vadim Fedorenko 2023-12-01  198  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



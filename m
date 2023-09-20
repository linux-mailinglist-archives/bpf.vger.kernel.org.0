Return-Path: <bpf+bounces-10456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02327A8902
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF0281397
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CB23C6A1;
	Wed, 20 Sep 2023 15:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619141428E
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:54:28 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28FEC9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:54:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-274dacb5d18so760784a91.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695225266; x=1695830066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvzJPQO/bADTYnKAw8CDtr04xbcONw8HjKLsAZQM774=;
        b=QdmQFYlf8kJ5ERGCY6MN5OwJC8rcuoNumDIOpHBk3/gUr+DyHaHgWJndKqmLmZZvim
         WdbLzHs44mTFFRFsj/4FfJihZy9IEIZSqWQRbdgfWVN5GZUCnRxRsfmZ9dv9GvKd5A2U
         Bs2klVY2CFvLt4TwP+0KaTL1Yth83rPyA0IdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225266; x=1695830066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvzJPQO/bADTYnKAw8CDtr04xbcONw8HjKLsAZQM774=;
        b=Tn1eNIZ5J03eo9NZkix4IaZVP/dsToz6moQfV7hpePfT0nSlIxCPKInw722t6souO1
         3mOou5lpmxKrMMJo/fs0wtwDLROalXOP2f+YqT0lTxIWSegug9Jxs73e6OFLsXoNcaWg
         8O16TcoRn+pJCQxQGP97Yh47jowZFVM2V3GjOA48lsoHnoZPKkMLqyNduMvNhyz3H0Tb
         uKj5AOFgQmvxni4jgRdnsMOAvKmYFf8mSAdTwzzbSZsd1cwLW8H9wSsAKJHjI8YXv++e
         1mX3J/BZZUnJ2mSxorlmRz/OgAlEeOnW4KB/OKpvQG/952ehQnOiAw+01p/3uBMd9AAh
         Rw+w==
X-Gm-Message-State: AOJu0Yz7KO7pi/9LdDFJilyS9OZHr8QBQXSUWR3wjA9vJm5S4YRNJU8R
	tVFZYgyCn+m4fkrlkCHGKwC+JA==
X-Google-Smtp-Source: AGHT+IG4/LCvBOh0cOC4pD2Z/5P+TJilImO7/jqJyK2O5LkDYpzfajqXXpz5jfN2q0iv2SzN27CkkA==
X-Received: by 2002:a17:90a:db82:b0:26b:513a:30b0 with SMTP id h2-20020a17090adb8200b0026b513a30b0mr4468518pjv.10.1695225257588;
        Wed, 20 Sep 2023 08:54:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s62-20020a17090a69c400b002682523653asm1599254pjj.49.2023.09.20.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:54:16 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:54:16 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202309200848.7099DFF1B@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 11:24:57PM +0200, KP Singh wrote:
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:

I feel like the performance details in the cover letter should be
repeated in this patch, since it's the one doing the heavy lifting.

> [...]
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Regardless, this is a nice improvement on execution time and one of the
more complex cases for static calls.

> -struct security_hook_heads {
> -	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> -	#include "lsm_hook_defs.h"
> +/*
> + * @key: static call key as defined by STATIC_CALL_KEY
> + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> + * @hl: The security_hook_list as initialized by the owning LSM.
> + * @active: Enabled when the static call has an LSM hook associated.
> + */
> +struct lsm_static_call {
> +	struct static_call_key *key;
> +	void *trampoline;
> +	struct security_hook_list *hl;
> +	/* this needs to be true or false based on what the key defaults to */
> +	struct static_key_false *active;
> +};

Can this be marked __randomize_layout too?

Everything else looks good to me. I actually find the result more
readable that before. But then I do love a good macro. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


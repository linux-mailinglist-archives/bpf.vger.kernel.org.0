Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7325B6D8D8E
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 04:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjDFCic (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjDFCi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 22:38:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6AB900E
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 19:38:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 185so11777863pgc.10
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680748692; x=1683340692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2z5djl8yfqEWItHw+eyjZTY3s6jQlRhlJ81Q1eQELo=;
        b=iNgByrJy9o/0N0Q7jSDRlcjhBhoV5zpBv0dUgRwDpcUNmDAMakjtLxgQoM16LNFuAF
         1KjNVoX5KfbAOE2TKmCq2spXqz2GOJK0fqXHAa3JYd+RHgxv2GK9n+1zkzXVs7zHdZeP
         PiCT8Hk0ghQ1vuwufx0DudJGEjXFNp+Oe14HmgIPr3JPhxoS1t4LTtfmkxFBtuV2bYnR
         nsScu8Hqhebf2TKLNvQGMj0OMq3VUVG76U/VSRJL3GYMYlZFhexd3QVAUGwZOmDH2xR0
         2qYqEayw08oEVDBGpM2PKASF9FHosI/d+KD0cV/IHGmn0iufmX+xVSJb/rr35vY4LZlk
         gZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748692; x=1683340692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2z5djl8yfqEWItHw+eyjZTY3s6jQlRhlJ81Q1eQELo=;
        b=C/Ldl/zGMXK9nZyIBdmnhY9nnREJeR3XaTeNIBZbj7QzK2prUCnDXWTJv0RiSsrQYb
         2vDUNkHt7G67+XSU+jBDlbaSeogoR05Q2bdiDZxe5UmGSd9QZYFxKwUgQdZqc6mmbTQs
         FR8SLw6Et5SaViSMIlrN6UHG7ST0WQGF1/hdJAXnXTjWIH6JUc/IeD5IW4Sw5ApkvGA6
         ww8o/bsW4nVoqIYTGtlfhWMnl7EDAEG2n7HlAhgRXMdAW9zthAHUK184r6baGY15kJfc
         G3GEdWmW77xeGG99/i9hXmhg5AftlvAvI8lYbQyjUvwG81VA+9bXzHfydSvAkfXPdDCL
         ycIw==
X-Gm-Message-State: AAQBX9czJWcW3AQq3z9zP/TmFPKOCTOhvQNCUqU5Q3zvOipbLGX0DqkZ
        aM3P5huA+qFpg8CPqv8ly9E=
X-Google-Smtp-Source: AKy350YAaeVw5hYbYBYAq03Aqr2XTJfsqMkYmCoHI++p5M3LdjKCiclWS07dc6ODjIxSGIYEtd6CgQ==
X-Received: by 2002:aa7:9505:0:b0:62a:4503:53a8 with SMTP id b5-20020aa79505000000b0062a450353a8mr4901918pfp.12.1680748692459;
        Wed, 05 Apr 2023 19:38:12 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7820a000000b0062db3444281sm84047pfi.125.2023.04.05.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:38:11 -0700 (PDT)
Date:   Wed, 5 Apr 2023 19:38:09 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 9/9] selftests/bpf: Add tests for BPF
 exceptions
Message-ID: <20230406023809.jffvgx5r7eyjw24g@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405004239.1375399-10-memxor@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 02:42:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> +static __noinline int throwing_subprog(struct __sk_buff *ctx)
> +{
> +	if (ctx)
> +		bpf_throw();
> +	return 0;
> +}
> +
> +__noinline int global_subprog(struct __sk_buff *ctx)
> +{
> +	return subprog(ctx) + 1;
> +}
> +
> +__noinline int throwing_global_subprog(struct __sk_buff *ctx)
> +{
> +	if (ctx)
> +		bpf_throw();
> +	return 0;
> +}
> +
> +static __noinline int exception_cb(void)
> +{
> +	return 16;
> +}
> +
> +SEC("tc")
> +int exception_throw_subprog(struct __sk_buff *ctx)
> +{
> +	volatile int i;
> +
> +	exception_cb();
> +	bpf_set_exception_callback(exception_cb);
> +	i = subprog(ctx);
> +	i += global_subprog(ctx) - 1;
> +	if (!i)
> +		return throwing_global_subprog(ctx);
> +	else
> +		return throwing_subprog(ctx);
> +	bpf_throw();
> +	return 0;
> +}
> +
> +__noinline int throwing_gfunc(volatile int i)
> +{
> +	bpf_assert_eq(i, 0);
> +	return 1;
> +}
> +
> +__noinline static int throwing_func(volatile int i)
> +{
> +	bpf_assert_lt(i, 1);
> +	return 1;
> +}

exception_cb() has no way of knowning which assert statement threw the exception.
How about extending a macro:
bpf_assert_eq(i, 0, MY_INT_ERR);
or
bpf_assert_eq(i, 0) {bpf_throw(MY_INT_ERR);}

bpf_throw can store it in prog->aux->exception pass the address to cb.

Also I think we shouldn't complicate the verifier with auto release of resources.
If the user really wants to assert when spin_lock is held it should be user's
job to specify what resources should be released.
Can we make it look like:

bpf_spin_lock(&lock);
bpf_assert_eq(i, 0) {
  bpf_spin_unlock(&lock);
  bpf_throw(MY_INT_ERR);
}

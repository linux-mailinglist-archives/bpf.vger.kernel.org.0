Return-Path: <bpf+bounces-10318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677977A50A7
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD42814D6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8836262AF;
	Mon, 18 Sep 2023 17:09:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE322F15
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 17:09:40 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D999
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:09:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso54301955e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695056976; x=1695661776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DIq65qJaEv/xPIRYUZ1vbRLTfRLIjzoQlmDhqEKB/E=;
        b=6ViGDZj51S5Fuaun2rjtmVWXHEBsqPYlZsDpmJz9wb4Y0EiK5zxkY/2cuTZTE9FSOr
         37LfeczU4Rq5kXiVt+i/zdNScHVT5ijFZmuKSoDbNb0h9uryhFh/X97ZvnHO4dz8zqzo
         +vCRaO5u4ayb6c/MSUnChdfkRrj6HUWwgORX2nx6i4MDcRmy+4tOw4oL2u0ElCzC5AeL
         lpPbhl2GkepQqxd8rBIo9XF8ZzWwt+T2t0HtptByDPfDlE2whEa0V2O4SCmBfJBtOAR+
         pOauoeGHVLjetp07JBksNG85Jh80j1sBmA8VWjahoOyPdgn2o0mCgaSQ0VVx5aSR64hg
         jXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056976; x=1695661776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DIq65qJaEv/xPIRYUZ1vbRLTfRLIjzoQlmDhqEKB/E=;
        b=UGWwM9nmtvq+sau/SWaD89Ii/nHwhs1gZYcTsZ7uxlyEyb8igUDM+S4KY7R82WB2qT
         jjxhtx8pTTnXoEXQPeeV8Ga23osalgH7VTPCsq4WJdecsveYD13UGXy4MKd8WMtp708T
         R7pVT91MCOridCKdsFRuBKke3t4mmWBku1aNtlMWVao5swd+V10f0vOVj/Y9eKG+EWVb
         eyRltonSozW7UBc+5I8vzprN70VLlXos3QhXsavbj1kxMd235aa2KnELtOXCHUJxyJEX
         KXg4UyL/XAsF7swiU5usxuZp0Sp4/0EVgBELXNdicbFsJ192kVuC0evjQa2ZL1hMSWdB
         uGgw==
X-Gm-Message-State: AOJu0YzjNRLq+8ciGxVQ6kgpCI89JT86Kdw/HNpr9eI+fpjWSNoTpGUz
	71DU67Ll2//1TkejnpOpcrFjHsB27rEV/EuLAtvYwA==
X-Google-Smtp-Source: AGHT+IFNCNmsrRfrDNZJklUjq5AA9KKxY6BV87CbfFUVmoof7mvAHeK9kQ+lFYCUQQOA/gnRrVp9Og==
X-Received: by 2002:a05:600c:285:b0:3fe:dcd0:2e32 with SMTP id 5-20020a05600c028500b003fedcd02e32mr7932628wmk.19.1695056976276;
        Mon, 18 Sep 2023 10:09:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c4f3:6b1c:8a00:a8fb? ([2a02:578:8593:1200:c4f3:6b1c:8a00:a8fb])
        by smtp.gmail.com with ESMTPSA id x12-20020adfdd8c000000b0031912c0ffebsm13166115wrl.23.2023.09.18.10.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:09:36 -0700 (PDT)
Message-ID: <b74e5f1e-d054-42ea-ab69-91c92278a82a@tessares.net>
Date: Mon, 18 Sep 2023 19:09:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix bpf_throw warning on 32-bit arch
Content-Language: en-GB, fr-BE
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <20230918155233.297024-1-memxor@gmail.com>
 <20230918155233.297024-3-memxor@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230918155233.297024-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kumar,

On 18/09/2023 17:52, Kumar Kartikeya Dwivedi wrote:
> On 32-bit architectures, the pointer width is 32-bit, while we try to
> cast from a u64 down to it, the compiler complains on mismatch in
> integer size. Fix this by first casting to long which should match
> the pointer width on targets supported by Linux.

Thank you for the patch, it fixes the issue on our side!

(Not sure you need a tested by tag but just in case: )

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

> Fixes: ec5290a178b7 ("bpf: Prevent KASAN false positive with bpf_throw")
> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 7ff2a42f1996..dd1c69ee3375 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2488,7 +2488,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
>  	 * which skips compiler generated instrumentation to do the same.
>  	 */
> -	kasan_unpoison_task_stack_below((void *)ctx.sp);
> +	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
I never know what's the recommended way to fix such issues: casting it
to 'long' or 'unsigned long'? But it looks like both are used in the
kernel and 'long' is more often used than the other one so all good I
suppose.

>  	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net


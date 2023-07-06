Return-Path: <bpf+bounces-4294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8F74A3A1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EBA1C20DB7
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087CC156;
	Thu,  6 Jul 2023 18:16:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C28C18
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:16:30 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962791BEC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:16:29 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-66a4c89bbb1so1544322b3a.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688667389; x=1691259389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7bcGKfqy3IhA8j+aFZQMe/R+wBoGTcL9Apo1o/U2h0=;
        b=I7RGLB0uTkALR8qWTmrtGHlWVVgMld9o1QUAQ3tS1bqbk5UjIwpmXfYdf3FLWKl0lk
         R8B4ltEjgeARF1XkSlCqOCmBTIfA8+mwlZ2ODD4LLJC/O/RN5jrCmqQ2yJkRHJiWLZzB
         mKjgscm1aQsVWLyyQ6hv8TMGY4tEOEZQ0Cnj20AXL5zgOXmoCUZmBjGHpyUs38KuFP02
         5NrHsJq4RQ9I31NEG3dRYpfzCC4AaLjN6jlKd1e0KIAr5S0RIaepfyrD1gxeJH44Ep1L
         fV+mjTz4YI+GLe7/hC85lcP4opBE8ZuOnyr0xgMQkpWcAri5koVY6mHp58mG9sbVNMrM
         JBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667389; x=1691259389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7bcGKfqy3IhA8j+aFZQMe/R+wBoGTcL9Apo1o/U2h0=;
        b=Eq4Mqj+nHlJbikvwfz/OP2FtjvUQQ8QtDny/u+PYykkusNAIqk7Rf5EaiGT6dEWY3K
         iwEZMw9rtBim4gDdj/e6RZF1vB92qNHw4Y9enPSbcolbJPGcTvP8XVoRCXYu7ZllFcjI
         +Cv4UmhQaDFg5IXB3/sQAYCFB9SuRui64t+1sUtOzUh+XgewmzO5WkFQmkNVTV4LxcCF
         SgY2o59J9lZ2liB7oIkok71KAQ2owKtousySlq2oQbM0zqNhf7+68fWlFL2P87rydX9h
         grJ8Mzf9z/4FCw/uacLR/TSPNp4apyvSavARUmHEKuH5KCL2CqPvsPJNiA0pZrK9qUy2
         YTmg==
X-Gm-Message-State: ABy/qLbupDIE17qL/RvKsW/u1Wt4wuNOIdR74goVrKMXcyW09TXBoqL3
	lCFAK/uJv5kAyZwGfcec1SgIYao=
X-Google-Smtp-Source: APBJJlFaBwwxr4fY3i/lCrJiyW37Yf3g8v6biv1f6tLtm/C1dz1mPpymUT8bzPmG6Zq4RDKPDTISh60=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1a94:b0:676:ba7f:7906 with SMTP id
 e20-20020a056a001a9400b00676ba7f7906mr3263742pfv.3.1688667389054; Thu, 06 Jul
 2023 11:16:29 -0700 (PDT)
Date: Thu, 6 Jul 2023 11:16:27 -0700
In-Reply-To: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
Message-ID: <ZKcE+wMWGdVFSBX2@google.com>
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
From: Stanislav Fomichev <sdf@google.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/06, Anh Tuan Phan wrote:
> Update the Documentation to mention that some samples require pahole
> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  samples/bpf/README.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> index 57f93edd1957..631592b83d60 100644
> --- a/samples/bpf/README.rst
> +++ b/samples/bpf/README.rst
> @@ -14,6 +14,9 @@ Compiling requires having installed:
>  Note that LLVM's tool 'llc' must support target 'bpf', list version
>  and supported targets with command: ``llc --version``
> 
> +Some samples require pahole version 1.16 as a dependency. See
> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
> +

Any reason no to add pahole 1.16 to this section above?

Compiling requires having installed:
 * clang >= version 3.4.0
 * llvm >= version 3.7.1
 * pahole >= version 1.16

Although clang 3.4 probably won't get you anywhere these days. The
whole README seems a bit outdated :-)

>  Clean and configuration
>  -----------------------
> 
> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
> 
>   make defconfig
> 
> +Some samples require support for BPF Type Format (BTF). To enable it,
> open the
> +generated config file, or use menuconfig (by "make menuconfig") to
> enable the
> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
> +

This is usually enabled by default, so why special case it here?
Maybe, if you want some hints about the config, we should add
a reference to tools/testing/selftests/bpf/config ?

>  Kernel headers
>  --------------
> 
> -- 
> 2.34.1


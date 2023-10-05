Return-Path: <bpf+bounces-11454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714157BA357
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5A13D1C208F8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9530D04;
	Thu,  5 Oct 2023 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="RdPs6bZC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34330D05
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 15:54:31 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC25EC86
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 08:54:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3231dff4343so750031f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1696521246; x=1697126046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9jgX1V/4Lt7reawNBa64mpmNNW6z5NJmtuZCopzjTg=;
        b=RdPs6bZCzTnzBDxtlGbBLZYrAXpWrVAqfCJrQjL459cvkqcCFqNtPhHtRBAwn5I8kH
         nfQAuZhDmuHS1+nDaiCuiLbJR2h1BieddU2ZSBvOt67/EnEtUp3zHl6333g5L3aRABeI
         c84o55OR0SNgsy338YXtivt4XS5bwzlDpJA5FfaRnPufkbpPg3bOgAdOvCKXtnTihsMj
         RXxgmzCCTuwjZ1aJD/7JkbJuC6sN/RMEnf3E9Uf/CUT2/2GplY8b1XT8JZFgF/20KZim
         hBAxChOohMgtPD7eTpDlABCwibgKK+0BuXdrGfpW9kfJNuxzQRyR9eN9OXuBq0WWzjvX
         J0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521246; x=1697126046;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9jgX1V/4Lt7reawNBa64mpmNNW6z5NJmtuZCopzjTg=;
        b=WuCp1GfffXzkMq7gPVoq7kHTyo+xpwda9obUnq4aMgNXH4BdXlTGs6KJ9Q291oiYgB
         EgqWAlYbveizQfeWTO6+CREPoJQKWFEQ7ESBCnEFxZBS1XDwPkdvAgShpvrt3gEqiMHM
         mNQAqi2ZCUfQ8tJaTDCWd+VgFoReSNYPd1w89DHebcFBgSfL6hlIlY4A5lsXX1wbTV+6
         DcQppC0hM3Eh5YgvFmVzR3u1Yaka8RVKG8bi7Ip5gReq2hUq1w2eSc6H5cAGO7na8/3B
         ovjgmKMZzOg/firWbIIzCeTcelff1Y+UlAzzvArSjXqnm6T6AQ0KD6zVjuvxv9avUFDv
         YQKQ==
X-Gm-Message-State: AOJu0YxaSpJ73LE2P94CCoHAhyXHQeQu0EIzSfHnD3O56dKmPWXpeKDI
	gCMxCsHhoh2iaDn3visiztjpfw==
X-Google-Smtp-Source: AGHT+IH2BebPRq+/LzX2/VVJ5f5eYcre8Nkr1mAjsJbh/Lmum/1uCIr+dEfwSuRrKcNBSRmGFfuaog==
X-Received: by 2002:a5d:4e42:0:b0:313:f75b:c552 with SMTP id r2-20020a5d4e42000000b00313f75bc552mr2619252wrt.15.1696521246096;
        Thu, 05 Oct 2023 08:54:06 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:4a49:8ee5:5e5c:cfd5? ([2a02:8011:e80c:0:4a49:8ee5:5e5c:cfd5])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4583000000b0032008f99216sm2070696wrq.96.2023.10.05.08.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 08:54:05 -0700 (PDT)
Message-ID: <173829f3-817e-4937-808f-7f9bfc22207f@isovalent.com>
Date: Thu, 5 Oct 2023 16:54:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] bpftool: Align bpf_load_and_run_opts insns and
 data
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231004222323.3503030-1-irogers@google.com>
 <20231004222323.3503030-2-irogers@google.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231004222323.3503030-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/10/2023 23:23, Ian Rogers wrote:
> A C string lacks alignment so use aligned arrays to avoid potential
> alignment problems. Switch to using sizeof (less 1 for the \0
> terminator) rather than a hardcode size constant.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/bpf/bpftool/gen.c | 47 ++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index b8ebcee9bc56..7a545dcabe38 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -408,8 +408,8 @@ static void codegen(const char *template, ...)
>  		/* skip baseline indentation tabs */
>  		for (n = skip_tabs; n > 0; n--, src++) {
>  			if (*src != '\t') {
> -				p_err("not enough tabs at pos %td in template '%s'",
> -				      src - template - 1, template);
> +				p_err("not enough tabs at pos %td in template '%s'\n'%s'",
> +					src - template - 1, template, src);

Nit: This line is no longer aligned with the opening parenthesis.

Other than that:

Acked-by: Quentin Monnet <quenti@isovalent.com>


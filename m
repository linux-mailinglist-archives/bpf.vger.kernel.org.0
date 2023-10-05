Return-Path: <bpf+bounces-11453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328637BA322
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B632A281D6F
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8E30D16;
	Thu,  5 Oct 2023 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Pl3cN9Ms"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7330CEC
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 15:52:04 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A177645
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 08:52:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so10913065e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1696521119; x=1697125919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdR507v84ynzbbbrnyTkvWO66sR0xlxPmXVVX+8i0QI=;
        b=Pl3cN9MsVGNPLiFbR6w/iDRe6xEr0TaKdpDoRwtzDM47zYsic+d162dnoyLygfzoBQ
         UuTE7NpONEKK+uZ6F/guLHQh3GnoB8ffErFFyZF2K0JfDP7cLeHicSgAcOnsOXxS7Kw9
         8n/SL1c/tRtwvructt41JQ/A4snjQ3CGPs0BlZ1MMOLNNF9NhAaKHD6UBYUb78NJ/IHu
         zlLOcytmHgcg1XRLVeD+usBbXKVgEmlgFwGZ9nar6SV2uhwNwzhkdDY+yY6yrUBQsEbX
         +xP1MN6w8uW1r4gFQnAA7iTwwArIpi5jhi2ylj8j42H2DHvYwayo53SKd/AGNWyHhePy
         vv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521119; x=1697125919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdR507v84ynzbbbrnyTkvWO66sR0xlxPmXVVX+8i0QI=;
        b=bZyX5Z9jBBKl2enrVdPXMkjrpqWLpZcLb+W45m3WHW+J2Ge3jCYbZAg//3yf0PBTZ1
         7aI/OswB9gybFkT5JqDb4SExpgqdD/9kYvuQNk6l9t/BT2vSgEr+baFvytHRMHSYZ/nX
         7exSx+JEh7RULGq8c1nI2lTsRoIrkhjY77Qh7CUvZGf8mFGLvXtQuU7R18fmzGnjzqmm
         A1A+OIuzLPu+otkvvEmnp1CfPjPCYZ7O+dA63JTCP2KLepYr6R0eWlOfebx+iZF8N42y
         N/m/zjUVXbJkRTaDQexzFRRwc8+XBGYlq9y9dQLMiyObCnxCqG6vpgwyLPWVqcyPgrt/
         r8oQ==
X-Gm-Message-State: AOJu0Yx+XLKI1yqL9x9KAtoE4OkDn0S/KKraKsykMerbQEc+zkBICAmu
	0ouwc8qpPizVpKBYt1c7x8WECQ==
X-Google-Smtp-Source: AGHT+IGnEnri9Nw/YTtsWQie4mWourjTILQ6w6qzEQFVo4XB/HXDHw8IvL0i/DCmKK3shoH1ejDHJA==
X-Received: by 2002:a05:600c:214f:b0:405:4002:825a with SMTP id v15-20020a05600c214f00b004054002825amr5211051wml.13.1696521119378;
        Thu, 05 Oct 2023 08:51:59 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:4a49:8ee5:5e5c:cfd5? ([2a02:8011:e80c:0:4a49:8ee5:5e5c:cfd5])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b004013797efb6sm4070767wme.9.2023.10.05.08.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 08:51:59 -0700 (PDT)
Message-ID: <888bde30-a61f-4b19-bb6f-0aec69f23415@isovalent.com>
Date: Thu, 5 Oct 2023 16:51:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] bpftool: Align output skeleton ELF code
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
References: <20231004222323.3503030-1-irogers@google.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231004222323.3503030-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/10/2023 23:23, Ian Rogers wrote:
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array. Use sizeof
> on the array, less one for the \0 terminator, rather than generating a
> constant.
> 
> Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skeleton's embedded ELF data")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks


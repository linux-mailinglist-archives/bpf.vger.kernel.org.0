Return-Path: <bpf+bounces-17551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B041680F1DA
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AC21F2165D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E27764B;
	Tue, 12 Dec 2023 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ILm2uuYd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25D5AA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 08:07:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so35512025e9.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 08:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702397224; x=1703002024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNBdgSBUPUQssfehoK1mwXsPZc+pPBG1WEH3YsOI1PM=;
        b=ILm2uuYdmSzMClzO5lE1Ge0kR0ZoVYuxbFENV2trh9yxH46ry4oXKBsQwbJuhRTMOA
         ZWMN5nHxso/SxjOpTt49d9QBwVrq4c86Du5kTu8MT4R0KkK8oFrpQkdo16HlPvFRRFco
         uaTU/ufslNPpIjXKp1CsHoJyGNaXRuLVjcVJnsLXmY8fi++MC80hORCLsuO+mQ/irZI+
         Zne3HmVlrCX04A37osT6KW/fiW+HGx4JlaYfOXYdlZOJhrB8wiShyBdAB4pYzGubRMnw
         QV/6POQQdLYqEpi1diy34MsNg5gtY9GAZjzw+RVrAgzD31limbCwDUvubTsFF6oGK7LV
         PQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397224; x=1703002024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNBdgSBUPUQssfehoK1mwXsPZc+pPBG1WEH3YsOI1PM=;
        b=uQcQlBqBrxx/DNoPzI0+iKbCoF2oGA+6rjy1U6kAphOLzULayf4RHVatyCJxyhTxA4
         8At147O4Jmi9yxL8WCuJn1+xPAM8c8ax42O4AhMuEayWycCkCN4AFRpTaN3j5JFhJI4x
         n16F7KXZi4+vAPNCoGMykdZg2HJ1DPj347t3AKsSPwjlcOasLo6GjT6TXw2ivs55LhbP
         HNYIZPSGLq1+EDkb+AZfxzqdfiQKZIPY7qDgl9tvt0VJGUL5OYoVPEM2myL5D397cK/7
         N2U00NhmkPd16sDsvxMa0k6LTyJVJw8DCdLiLJzUmeRRnOMCmizp317vRm0WewRlimz8
         E9zg==
X-Gm-Message-State: AOJu0YxfghStZ+6LWJSs4j/ZpEFpZeFQV3uOp1+whsq7kfYYA19fpWb3
	fhNvM55gThwgFPyZUuaoWmmGKQ==
X-Google-Smtp-Source: AGHT+IELMzTdHSDNXvfRtDEUI4x8PK+V4yAVc+zCdjPo/P232JMgvFmFyQ54JIjFwqGK+UGkJud+Pg==
X-Received: by 2002:a7b:c4d4:0:b0:40c:32e8:e253 with SMTP id g20-20020a7bc4d4000000b0040c32e8e253mr1507022wmk.363.1702397223544;
        Tue, 12 Dec 2023 08:07:03 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:dd4d:f876:85f4:3d21? ([2a02:8011:e80c:0:dd4d:f876:85f4:3d21])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0040c4acaa4bfsm6105534wmo.19.2023.12.12.08.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:07:03 -0800 (PST)
Message-ID: <fce6188a-6ccc-4b92-9aa7-9ee18b2f2fa1@isovalent.com>
Date: Tue, 12 Dec 2023 16:07:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/3] bpftool: add attribute preserve_static_offset for
 context types
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, alan.maguire@oracle.com
References: <20231212023136.7021-1-eddyz87@gmail.com>
 <20231212023136.7021-3-eddyz87@gmail.com>
 <baee9fb4-7559-4ba2-a254-7388bb6caa63@isovalent.com>
 <90dd9462984be5cfce9db23eda53df44f39a8687.camel@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <90dd9462984be5cfce9db23eda53df44f39a8687.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-12-12 15:58 UTC+0000 ~ Eduard Zingerman <eddyz87@gmail.com>
> On Tue, 2023-12-12 at 11:39 +0000, Quentin Monnet wrote:
> [...]
>> Hi, and thanks for this!
>>
>> Apologies for missing the discussion on v1. Reading through the previous
>> thread I see that they were votes in favour of the hard-coded approach,
>> but I would ask folks to please reconsider.
>>
>> I'm not keen on taking this list in bpftool, it doesn't seem to be the
>> right place for that. I understand there's no plan to add new mirror
>> context structs, but if we change policy for whatever reason, we're sure
>> to miss the update in this list and that's a bug in bpftool. If bpftool
>> ever gets ported to Windows and Windows needs support for new structs,
>> that's more juggling to do to support multiple platforms. And if any
>> tool other than bpftool needs to generate vmlinux.h headers in the
>> future, it's back to square one - although by then there might be extra
>> pushback for changing the BTF, if bpftool already does the work.
>>
>> Like Alan, I rather share your own inclination towards the more generic
>> declaration tags approach, if you don't mind the additional work.
> 
> Understood, thank you for feedback.
> The second option is to:
> 
> 1. Define __bpf_ctx macro in linux headers as follows:
> 
>     #if __has_attribute(preserve_static_offset) && defined(__bpf__)
>     #define __bpf_ctx __attribute__((preserve_static_offset)) \
>                       __attribute__((btf_decl_tag(preserve_static_offset)))
>     #else
>     #define __bpf_ctx
>     #endif
> 
> 2a. Update libbpf to emit __attribute__((preserve_static_offset)) when
>     corresponding decl tag is present in the BTF.
> 
> 2b. Update bpftool to emit __attribute__((preserve_static_offset)) for
>     types with corresponding decl tag. (Like in this patch but check
>     for decl tag instead of name).

I don't have a strong opinion on that part, so...

> I think that 2b is better, because emitting
> BPF_NO_PRESERVE_STATIC_OFFSET from the same place where
> BPF_NO_PRESERVE_ACCESS_INDEX makes more sense,
> libbpf does not emit any macro definitions at the moment.

... the above makes sense, I'd say let's go for this if nobody else
objects (or wants it in libbpf instead - but bpftool is fine as far as
I'm concerned).

Thanks,
Quentin


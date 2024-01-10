Return-Path: <bpf+bounces-19296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6CE829151
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E901F265D2
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DD39F;
	Wed, 10 Jan 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAmpRe8P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF0383
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-429985e952bso10729671cf.3
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704846390; x=1705451190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hriQJykUGbCZHrp0p8WR5gw3Nx0Y5gCOyCGd42caIQ=;
        b=GAmpRe8PtfzRR6/eKLcRSf+xpey/uzdv13NWI4nh/j6b2JxCDGsYFf/jN8quGamZt5
         0CNErSx8OoTH/LH+lqa8avR0HDbJ+aPrW1Qh+oKQus7GV2O8RLCBrFCWK+tozTZF8th4
         mmwt2oeabagXzr3RjjrYjqYKO9kQhJ5tgW3YfLiW8JjT4wM88yqjvD3agjSzf0kLYWYF
         6fwvNQz8UVjTOUjCovas/uaBRHSzvwhyV4AVe3RlZWrKabCI0W6cEXKYUHDTaEJINd8+
         puv64ia/Q0HhOOygkKpwnboLOyFAJFrtVDhvuaLaJ2WBdD/m3ZJw3gQd0V7VMT6eIIV8
         ZlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704846390; x=1705451190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hriQJykUGbCZHrp0p8WR5gw3Nx0Y5gCOyCGd42caIQ=;
        b=GGYp28yNrJTwr47SC1uCoYLbzeg8mlQbOK2PysAPWWkcQTo298fqIqdajGN/hVickN
         v73LUa/ZnAmmJnskycg01cOA0CM3enTKGDLjh7bTjRfjJJT8avsxmM0pdngnA37sZhS4
         97M7enXb7MF5uRnWbnCFI1gmhPK6mADC54XEZ5SfV1vCnd53xYPCxYB/OlFK1IvY61hp
         DOh7qNXfah/QKJ3TvG1BP+RLbLNfjm+ou/iZ/lFpSMEdzyvILMb3vgtJG7Lz2F8vK5nG
         z8nWSH3UEHg9XM/hEOgCEfDp/NTc8/KF/juNOYbuihljOlbksYhbK9FK22V+7A/k0nvz
         VuQw==
X-Gm-Message-State: AOJu0Yzm8uCkwcpAzGWFcmNXMF+CnHNpwVhe+Gk9knyvPVQ87TPZcSuW
	Owy+7RE7Q51BFSeGSgT92iLkpfaxIaYA
X-Google-Smtp-Source: AGHT+IF+52nsDiokOz506BLJb9c/T/9dxaWvDrKk5j2HauIr3W+OqiBD/UsEQ8ZMZ4bptGTMmV9eRA==
X-Received: by 2002:ac8:580d:0:b0:429:972d:8781 with SMTP id g13-20020ac8580d000000b00429972d8781mr316318qtg.38.1704846390186;
        Tue, 09 Jan 2024 16:26:30 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id ex16-20020a05622a519000b00427f47af434sm1325635qtb.61.2024.01.09.16.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 16:26:29 -0800 (PST)
Message-ID: <1ebf65a2-810b-482c-85f9-7ce02ec4970a@google.com>
Date: Tue, 9 Jan 2024 19:26:28 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-3-brho@google.com> <ZZa1668ft4Npd1DA@krava>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <ZZa1668ft4Npd1DA@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 08:43, Jiri Olsa wrote:
> I wonder we could use the existing RUN_TESTS macro and use tags
> in programs like we do for example in progs/test_global_func1.c:
> 
>    SEC("tc")
>    __failure __msg("combined stack size of 4 calls is 544")
>    int global_func1(struct __sk_buff *skb)

This worked, thanks.

The style of test I have right now is that each test is a separate 
program, with all programs in the same skeleton.  RUN_TESTS attempted to 
load the __failure programs, with the side-effect of loading all of the 
non-failures too.

Thanks,

Barret




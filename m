Return-Path: <bpf+bounces-19601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F384482ED81
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F46A1F23138
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C1B1B7F9;
	Tue, 16 Jan 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="eIa8Mqfn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8331B943
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e490c2115so48901025e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705403757; x=1706008557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1H5fg3qxE1UaJpNN5HcoL7Mi/hW7dGf8hmbTiQkpLjw=;
        b=eIa8Mqfn3dI8UlysShF4k5ZfweEXBAjoMMTGH7J6QiH2YTcEANWOan/dJ0CdN3NxGU
         ib0r9dF89Vn7ZYb5lgc1qQgtzTiTV3VgNrzv1juiPnRquXKDG7qh8Gu4MeaJCfPSIqWK
         WPARAoxmycITF4ColYgWKKz6DRhL7dfmqj1x+zMDyIZlv3Fi3q7b7gN7QBjQPI78zV1c
         pu6ZixnvM94TURGJvlINigtGEzMxPOP3eayK4SIsgcF2IWswnN1gCfj9Ors9oWe32xOS
         GvG3HIlSehlZUGmIwY/HO4v9fVZPJRvA+vOqFuLVIvKs5tWGHuCcFEe2+/ZmL779Cg5x
         CibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403757; x=1706008557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1H5fg3qxE1UaJpNN5HcoL7Mi/hW7dGf8hmbTiQkpLjw=;
        b=LK80PmN/+Xh2WC9LcvECRdTpZW/V2WTz8757CKgq333iLLQvtgjxWmqgUVKgQEjGI3
         CByw1fTvaMJF7yqYxpUXggNQC8hIyhOp4qhZ4Lj0cQFYQxUgeJe0nJWEthRtMVcb8MSx
         6hEuubuSn+vyGc1V7m1PtsMUyxS4upO7BVIx5pSfm/VY+bVvi5D4A0GNQTZh2vDEPb0V
         bUW2hjXNRGJf0jS4CEC+GkheGC0/fTOPjPqZNiMu+CxgP3w9J8iEeDadmH7J4OEqLcYZ
         Sn6NVzQysYKQnES8BZwuwxqy8ECQlumxoVrkauj/qVU4BYVYsgDhZPmAHYG7/tCXLOgT
         DQog==
X-Gm-Message-State: AOJu0YyT8XkTZ3Po2joUp/5W2Pa/7cZF3vW1ISo1YoM6HWjRZ4CxvxbI
	tjlxkU3HXRVoeD+rQW3GZHzTo6YMtNX/hv3ZOoMnbOUVMe/H2A==
X-Google-Smtp-Source: AGHT+IEve4DyvKwEDMYRLCp3u85D28V8f2NtPTS8NynZndR9e2f5xLAWBKp2rzXWSShFDp7Twdi3BA==
X-Received: by 2002:a7b:cc8f:0:b0:40e:8609:621e with SMTP id p15-20020a7bcc8f000000b0040e8609621emr296634wma.5.1705403757591;
        Tue, 16 Jan 2024 03:15:57 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:ef4f:70f3:fab9:b04e? ([2a02:8011:e80c:0:ef4f:70f3:fab9:b04e])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4562000000b00336471bc7ffsm14282096wrc.109.2024.01.16.03.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:15:57 -0800 (PST)
Message-ID: <ec813c26-696f-44c2-8681-6bf13ce6b5d8@isovalent.com>
Date: Tue, 16 Jan 2024 11:15:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] bpftool: Silence build warning about calloc()
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240116061920.31172-1-yangtiezhu@loongson.cn>
From: Quentin Monnet <quentin@isovalent.com>
Content-Language: en-GB
In-Reply-To: <20240116061920.31172-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-01-16 06:19 UTC+0000 ~ Tiezhu Yang <yangtiezhu@loongson.cn>
> There exists the following warning when building bpftool:
> 
>   CC      prog.o
> prog.c: In function ‘profile_open_perf_events’:
> prog.c:2301:24: warning: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>  2301 |                 sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
>       |                        ^~~
> prog.c:2301:24: note: earlier argument should specify number of elements, later size of each element
> 
> Tested with the latest upstream GCC which contains a new warning option
> -Wcalloc-transposed-args. The first argument to calloc is documented to
> be number of elements in array, while the second argument is size of each
> element, just switch the first and second arguments of calloc() to silence
> the build warning, compile tested only.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!


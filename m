Return-Path: <bpf+bounces-18862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025D822DF8
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85AA1F21AD0
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C301944B;
	Wed,  3 Jan 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KNBy+NhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312C199A0
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5f402571so70825975e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704287165; x=1704891965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujMEGiFp81zVSlg9Jq5fVCl7yycrYT831/sdeYXgFWw=;
        b=KNBy+NhGu+kn3nSjs3/4C8AAQ59Gu4+HCZk+iNdUfWC2VhsyaUwhFEK+9nZJGKr2s6
         z3i8vmGG7YyQmRtzIFNe367Tu1AJTYdKgbivrm1Ie/P9HcrnoT78eWbNy6cWh4+FOwSz
         SRLbuwMhlo3H7y1IaZ5Nk/J5+V0fnV9tCubBmE9Pd4DuRl8HHcPaMGhNdzX4yop5F2ie
         0j6N7fkmVrWX261LZjT1JgzDrMN+KAJrVvADQ42RS1VWYmfTvr+fsnXF4h6wboGK8Wnz
         Q/tZj4YXd+ilB5H6qxIS4YmHSNIIRmVGr73SwOGBNW6eWwaOxa+SXAQaiym+dvcd72ZQ
         QJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287165; x=1704891965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujMEGiFp81zVSlg9Jq5fVCl7yycrYT831/sdeYXgFWw=;
        b=rqJkG8jDqcJVQDfFUJCMlJsUqw2bMGGUFaJ9bXYBysaQyT8Utp1oS7cYTHtgNlPNHe
         smbZ+I1HGfH6wDvABcBH8ULLIcVoMHB+HWypGPot9R8Y1ScZyXLodssreuL6x/F1MOnV
         43bWpeDrM/iZA8LU/rDorW40qT3bK7G3mqOXda51SjIvxGWLhq44WkQqFgDvgr+YJ0xe
         5CvsStPhpfUbgHTtCtbeRPOf3eoJ3pDpbRGpmJjS2deBLM4pczDqVd47+uqyIxYJ5j4S
         TVfrEWTuUE240NFcrjQxgjbmNF7E6LBU5uek043USk0L7sJQX/0KTXTGmTD8bLFsZxu6
         YHFg==
X-Gm-Message-State: AOJu0Yw5tPL5I+WQkFXkPBtKwwT5uoGMo+Wy7wkk/Hbzuv5pB/wpjsde
	XAgbXyHEVNfJBJgJgSOXLuEk7MGt4PdmKg==
X-Google-Smtp-Source: AGHT+IE4J4DH84uD/l/S9BUKUI6GD8AO6UdO5kziD1IRCXt0m3+lKoGfkFOp9Nzte0AV9oxfjoUTlg==
X-Received: by 2002:a05:600c:4ec9:b0:40d:9208:ebbb with SMTP id g9-20020a05600c4ec900b0040d9208ebbbmr302630wmq.226.1704287164719;
        Wed, 03 Jan 2024 05:06:04 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:8ddc:2c24:4d50:1f0? ([2a02:8011:e80c:0:8ddc:2c24:4d50:1f0])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b003365fcc1846sm30654614wrb.52.2024.01.03.05.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:06:04 -0800 (PST)
Message-ID: <525d324d-bc06-469f-8533-33b2da35f3df@isovalent.com>
Date: Wed, 3 Jan 2024 13:06:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 0/3] use preserve_static_offset in bpf uapi headers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20231220133411.22978-1-eddyz87@gmail.com>
 <CAADnVQJKbtFAKDo6LGTmufXO-eDptud6pymDJLA-=o-qtk4Z4w@mail.gmail.com>
 <e912efb0f87d91037c8b33ad1821f17fd7b3ddde.camel@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <e912efb0f87d91037c8b33ad1821f17fd7b3ddde.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2023-12-20 20:19 UTC+0000 ~ Eduard Zingerman <eddyz87@gmail.com>
> On Wed, 2023-12-20 at 11:20 -0800, Alexei Starovoitov wrote:
>> On Wed, Dec 20, 2023 at 5:34 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>> This RFC does not handle type pt_regs used for kprobes/
>>> This type is defined in architecture specific headers like
>>> arch/x86/include/asm/ptrace.h and is hidden behind typedef
>>> bpf_user_pt_regs_t in include/uapi/asm-generic/bpf_perf_event.h.
>>> There are two ways to handle struct pt_regs:
>>> 1. Modify all architecture specific ptrace.h files to use __bpf_ctx;
>>> 2. Add annotated forward declaration for pt_regs in
>>>    include/uapi/asm-generic/bpf_perf_event.h, e.g. as follows:
>>>
>>>     #if __has_attribute(preserve_static_offset) && defined(__bpf__)
>>>     #define __bpf_ctx __attribute__((preserve_static_offset))
>>>     #else
>>>     #define __bpf_ctx
>>>     #endif
>>>
>>>     struct __bpf_ctx pt_regs;
>>>
>>>     #undef __bpf_ctx
>>>
>>>     #include <linux/ptrace.h>
>>>
>>>     /* Export kernel pt_regs structure */
>>>     typedef struct pt_regs bpf_user_pt_regs_t;
>>>
>>> Unfortunately, it might be the case that option (2) is not sufficient,
>>> as at-least BPF selftests access pt_regs either via vmlinux.h or by
>>> directly including ptrace.h.
>>>
>>> If option (1) is to be implemented, it feels unreasonable to continue
>>> copying definition of __bpf_ctx macro from file to file.
>>> Given absence of common uapi exported headers between bpf.h and
>>> bpf_perf_event.h/ptrace.h, it looks like a new uapi header would have
>>> to be added, e.g. include/uapi/bpf_compiler.h.
>>> For the moment this header would contain only the definition for
>>> __bpf_ctx, and would be included in bpf.h, nf_bpf_link.h and
>>> architecture specific ptrace.h.
>>>
>>> Please advise.
>>
>> I'm afraid option 1 is a non starter. bpf quirks cannot impose
>> such heavy tax on the kernel.
>>
>> Option 2 is equally hacky.
>>
>> I think we should do what v2 did and hard code pt_regs in bpftool.
> 
> I agree on (1).
> As for (2), I use the same hack in current patch for bpftool to avoid
> hacking main logic of BPF dump, it works and is allowed by C language
> standard (albeit in vague terms, but example is present).
> Unfortunately (2) does not propagate to vmlinux.h.
> 
> Quentin, Alan, what do you think about hard-coding only pt_regs?


It sounds like an acceptable compromise.

Quentin


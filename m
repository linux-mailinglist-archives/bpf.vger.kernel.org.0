Return-Path: <bpf+bounces-19390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA8F82B8A1
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52D81C245C8
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 00:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBF81C;
	Fri, 12 Jan 2024 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0IS/cYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C517F3
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f69383e653so63077047b3.1
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 16:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705019737; x=1705624537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwEhsaLGp5RP3gU3/Rxz5r8aRsCoTm8vlrIHioCW/W8=;
        b=X0IS/cYqHCj8lN88fzNiBa82CRIV66GCMZnIm/NVetgeWJBPa61H8g1TibkulesLNE
         qMOOpexK74IdWncQN35lGQXt6GuQbncvTQuVBjPLEPtZItlDVYeHH7cdPomAt1HSXRAh
         8ePiZ4lhJOm6/ndyhBIfywuTWZAiSgFhgmIU3ZHNN097rugWpOnLbG7f6TqogNapigT/
         X+t9h9bvXCWdHQBxiHnt1YG1a32GhwaDI96U06xNLm9zvT0ixJSe8JGrPNKl5AJJkw/N
         qI9WSpZpq0Ax3E+DqRQ+MfBnEFYrwxopMtmFmrq+viFh3wrAD1/3OfbG/bGWth2Y3GI5
         a93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705019737; x=1705624537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwEhsaLGp5RP3gU3/Rxz5r8aRsCoTm8vlrIHioCW/W8=;
        b=hSBFWCvXFiNB/t0a4uWzIHjqBNeE/0hX1FGcdDyWz/9dnVu9sADDCJnzFWDQYMogrK
         hOo3AMwrUTXo+Oo0ssGEvZrx0uxeU1rpjaQyTH8kM9eGCkSMzqyjwxGhbZn608HbBWw6
         3Qy6vUB9r6Wz1LJhJCayKqIDp8xbdsUwQvpbWquOMdfmcQVFZc7TSawx5cpQBRIV7j2P
         AGbbSsGVJ1bd7tEKwXgCuqMcwERXFx6rJqYrHgMhaPIelBlibonEczFArLjLfI4EzD63
         gzcZwnHTrfqEmiIy9cTJpjWPEwuuYr0HoHJLjSWf9QYui/Y8MeYQNNOZt60qrNYAZ7DP
         zJkg==
X-Gm-Message-State: AOJu0YxDBl/YF+qg8hyo70LZRcJ/e1eWPzBg1IkiPxvihzFmw54b+On+
	k6MGxQZjdOYfNUnnQHhRlBD0XE6gElg=
X-Google-Smtp-Source: AGHT+IFkxK4t7zwz9nwAJQQ2m0gHTjtT1PaVddFvyOwNko557hjdrZGQsgJJYcvMA9W8MesddIZ5YA==
X-Received: by 2002:a0d:db4f:0:b0:5e8:af59:c62e with SMTP id d76-20020a0ddb4f000000b005e8af59c62emr693208ywe.99.1705019737426;
        Thu, 11 Jan 2024 16:35:37 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:89de:528f:62e1:2dac? ([2600:1700:6cf8:1240:89de:528f:62e1:2dac])
        by smtp.gmail.com with ESMTPSA id s70-20020a819b49000000b005f8cb310ed3sm867870ywg.42.2024.01.11.16.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 16:35:37 -0800 (PST)
Message-ID: <07a003eb-ab6d-42a7-93fa-18d5307b2974@gmail.com>
Date: Thu, 11 Jan 2024 16:35:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com, Yonghong Song <yonghong.song@linux.dev>
References: <20240110221750.798813-1-thinker.li@gmail.com>
 <55ada30c-039d-4121-a4d2-efda578f600f@linux.dev>
 <0dd5949b-b6f8-4d88-88ba-cc079096ce32@gmail.com>
 <5d3f90bc-2758-43a4-bf13-45dc50301758@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5d3f90bc-2758-43a4-bf13-45dc50301758@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/11/24 11:08, Martin KaFai Lau wrote:
> On 1/10/24 5:50 PM, Kui-Feng Lee wrote:
>>
>>
>> On 1/10/24 15:44, Martin KaFai Lau wrote:
>>> On 1/10/24 2:17 PM, thinker.li@gmail.com wrote:
>>>> The proposed solution here is to add PTR_MAYBE_NULL annotations to
>>>> arguments
>>>
>>> [ ... ]
>>>
>>>> == Future Work ==
>>>>
>>>> We require an improved method for annotating arguments. Initially, we
>>>> anticipated annotating arguments by appending a suffix to argument 
>>>> names,
>>>> such as arg1__maybe_null. However, this approach does not function for
>>>> function pointers due to compiler limitations. Nevertheless, it does 
>>>> work
>>>> for functions. To resolve this, we need compiler support to enable the
>>>> inclusion of argument names in the DWARF for function pointer types.
>>>
>>> After reading the high level of the patch,
>>> while it needs compiler work to support decl tagging (or arg name) in 
>>> a struct_ops's func_proto, changing the info->reg_type of a 
>>> struct_ops's argument have been doable in the ".is_valid_access" 
>>> without new kernel code change in verifier/btf.c.
>>
>> btf_ctx_access() mentioned in the original message is a help function
>> called by the implementation of .is_valid_access. So, just like you
>> said, they definitely can be handled by .is_valid_access it-self.
>>
>> Do you prefer to let developers to handle it by themself instead of
>> handling by the helpers?
> 
> I would prefer one way to do the same thing. ".is_valid_access" should 
> be more flexible and straightforward. e.g. "bpf_tcp_ca_is_valid_access" 
> can promote all "struct sock" pointers to "struct tcp_sock" without 
> needing to specify them func by func.
> 
> It would be nice to eventually have both compilers support tagging in 
> the struct_ops's func_proto. I was trying to say ".is_valid_access" can 
> already add PTR_MAYBE_NULL now while waiting for the compiler support.

Got it! Let's wait for compiler supports.

> 
> If the sched_ext adds PTR_MAYBE_NULL in its ".is_valid_access", what 
> else is missing in the verifier.c and btf.c? I saw the patch has the 
> following changes in verifier.c. Is it needed?
> 
>  > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>  > index 60f08f468399..190735f3eaf5 100644
>  > --- a/kernel/bpf/verifier.c
>  > +++ b/kernel/bpf/verifier.c
>  > @@ -8200,6 +8200,7 @@ static int check_reg_type(struct 
> bpf_verifier_env *env, u32 regno,
>  >       case PTR_TO_BTF_ID | PTR_TRUSTED:
>  >       case PTR_TO_BTF_ID | MEM_RCU:
>  >       case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
>  > +    case PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_TRUSTED:
>  >       case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
>  >       {
>  >           /* For bpf_sk_release, it needs to match against first member
> 

This is not necessary. It can happen only if we add new helper functions
that accept trusted and maybe_null. But, we don't add helper functions
any more.



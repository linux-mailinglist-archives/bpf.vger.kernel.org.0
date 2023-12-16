Return-Path: <bpf+bounces-18084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF48157D5
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 06:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A256E1F2459D
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC311CAC;
	Sat, 16 Dec 2023 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMNFWP8g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610C134A0
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9e993d94dso1093473a34.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702705383; x=1703310183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZABzvnl3Tj5NpZaHDfVyLKhmD3eF6dhIzenWRLl2Alk=;
        b=SMNFWP8g5VhTWLXV9ad8olOiaFZ31zREmDOGloCPmUnMytIfZn4aQrDZIguySV0hTz
         XFMXIixPRKxU4U+a9JceHSuPlL0SbqlWyztKTYnq72pYamORyyZVfQObUhCFDp1gmM8L
         4qJ2Df7a2KekV1eIHNOfLUH4Dxt+W3V2gm/O171KYREPTm5MFqeIroJNEcFrEMLeGP+X
         7XdkA11J4tbqiZnJtOiPr356OKgLVsT3o06JVECaIfVmROWYm8FixI2LXnIYYZIiLT5M
         i2fTkBmTHDcyzngtSw0KAJpBb34y7pfllQjSniGNXTwL7TFRrAUEHj2oTPaTEKE8vs4k
         S3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702705383; x=1703310183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZABzvnl3Tj5NpZaHDfVyLKhmD3eF6dhIzenWRLl2Alk=;
        b=IJDXuTP6h7Wxka6Cy+u9p4/Y3lRXcGW6BqnGpMGGfieA9edfe8BZymzsvqMsriRMR4
         66ayhFIVQqUy2ijRk/nS1PsqerOkBn532jU45FcZbkUknANAlBRH//nHo1MJEgIujpri
         NcTfMvX1xi2/QmHvtBNx39WC5OFCeRgp0WxrImzjbzsVnUA7OkwNg8tZ1ABYILUIajk+
         2UPkXr7rsvdIQoWRcwuVxexRIpio+DX9vgj+CJu+JMZViFNl2WDE8QLSORhhxYFLrIg1
         nYrAH37OfBKlJoPDWaJLEIRrLdDvBeBhbNfiyz+SryqI9fK7059SJwxcTOZ4HVn9k2kT
         PDtw==
X-Gm-Message-State: AOJu0YxP0COLmnL9b0EmTSdMpzAXzUkob1oKNIVAM0Opc2BVEI/yo1RO
	qTNvdB3uQywfBHjEMXEsiEQ=
X-Google-Smtp-Source: AGHT+IH+zMda2/xQvZAqNQA2qEIZKo5WxhYWS4qYKVXhsnsCgpIe1rKDWLIvMUxU0Cj6qrLQIz3TpQ==
X-Received: by 2002:a05:6808:147:b0:3b8:b063:6679 with SMTP id h7-20020a056808014700b003b8b0636679mr11846548oie.112.1702705383142;
        Fri, 15 Dec 2023 21:43:03 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:d12f:74e4:d58f:4cec? ([2600:1700:6cf8:1240:d12f:74e4:d58f:4cec])
        by smtp.gmail.com with ESMTPSA id 67-20020a251546000000b00d9caecd5c86sm6012124ybv.62.2023.12.15.21.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 21:43:02 -0800 (PST)
Message-ID: <b85024f1-87bd-487e-bfa0-68dae52c9071@gmail.com>
Date: Fri, 15 Dec 2023 21:43:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-5-thinker.li@gmail.com>
 <466399be-c571-48af-8f48-8365689d4d20@linux.dev>
 <fc15849b-2f71-420e-aab4-7a20014cba49@gmail.com>
 <44dc6eb4-d524-4180-8970-4eef2a9b9f58@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <44dc6eb4-d524-4180-8970-4eef2a9b9f58@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/15/23 17:19, Martin KaFai Lau wrote:
> On 12/15/23 1:42 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/14/23 18:22, Martin KaFai Lau wrote:
>>> On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
>>>> +const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf 
>>>> *btf, u32 *ret_cnt)
>>>> +{
>>>> +    if (!btf)
>>>> +        return NULL;
>>>> +    if (!btf->struct_ops_tab)
>>>
>>>          *ret_cnt = 0;
>>>
>>> unless the later patch checks the return value NULL before using 
>>> *ret_cnt.
>>> Anyway, better to set *ret_cnt to 0 if the btf has no struct_ops.
>>>
>>> The same should go for the "!btf" case above but I suspect the above 
>>> !btf check is unnecessary also and the caller should have checked for 
>>> !btf itself instead of expecting a list of struct_ops from a NULL 
>>> btf. Lets continue the review on the later patches for now to confirm 
>>> where the above !btf case might happen.
>>
>> Checking callers, I didn't find anything that make btf here NULL so far.
> 
>> It is safe to remove !btf check. For the same reason as assigning
>> *ret_cnt for safe, this check should be fine here as well, right?
> 
> If for safety, why ref_cnt is not checked for NULL also? The userspace 
> passed-in btf should have been checked for NULL long time before 
> reaching here. There is no need to be over protective here. It would 
> really need a BUG_ON instead if btf was NULL here (don't add a BUG_ON 
> though).
> 
> afaict, no function in btf.c is checking the btf argument for NULL also.
> 
>>
>> I don't have strong opinion here. What I though is to keep the values
>> as it is without any side-effect if the function call fails and if
>> possible. And, the callers should not expect the callee to set some
>> specific values when a call fails.
> 
> For *ref_cnt stay uninit, there is a bug in patch 10 which exactly 
> assumes 0 is set in *ret_cnt when there is no struct_ops. It is a good 
> signal on how this function will be used.
> 
> I think it is arguable whether returning NULL here is failure. I would 
> argue getting a 0 struct_ops_desc array is not a failure. It is why the 
> !btf case confuses the return NULL case to mean a never would happen 
> error instead of meaning there is no struct_ops. Taking out the !btf 
> case, NULL means there is no struct_ops (instead of failure), so 0 cnt.
> 
> Anyhow, either assign 0 to *ret_cnt here, or fix patch 10 to init the 
> local cnt 0 and write a warning comment here in btf_get_struct_ops() 
> saying ret_cnt won't be set when there is no struct_ops in the btf.


I will fix at the patch 10 by setting local cnt 0.

> 
> When looking at it again, how about moving the bpf_struct_ops_find_*() 
> to btf.c. Then it will avoid the need of the new btf_get_struct_ops() 
> function. bpf_struct_ops_find_*() can directly use the btf->struct_ops_tab.
> 

I prefer to keep them in bpf_struct_ops.c if it is ok to you.
Fixing the initialization issue of bpf_struct_ops_find()
should be enough.

> 
>>
>>>
>>>> +        return NULL;
>>>> +
>>>> +    *ret_cnt = btf->struct_ops_tab->cnt;
>>>> +    return (const struct bpf_struct_ops_desc 
>>>> *)btf->struct_ops_tab->ops;
>>>> +}
>>>
> 


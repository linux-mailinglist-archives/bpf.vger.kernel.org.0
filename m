Return-Path: <bpf+bounces-17643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2601A810867
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 03:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AE8B20FC7
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 02:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33A17F4;
	Wed, 13 Dec 2023 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEANqD0A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED3998
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:50:00 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so4066348b3a.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702435799; x=1703040599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2fSxxmeQOUlGhNA/nGzzcE42fUlLQSVXAbxhrx2MoA=;
        b=CEANqD0AYVQcTDio5oMm20IDXxANdUKjFt5acWomENRZ+Jz7FpFXDphdFq2rptBdqc
         1nr0dvB0W2jroXl5XFkelAu4Q9FCdYPDvSHqMRXTjlUzRNUAmisCsCqHptIpVJCdXKSr
         UvxaRema0M5kyOmcDrFAXxGt8OrN8zrYVhSIcbZHvmfJNQfjUw1dDCvkh4mWPfA+fWWE
         8DZ90grGSjKYMze6PO0IK2TmwfS9nWLVJWkLtiYaxc5vC8CtEU//X4tZNRXSH6eMA5qD
         WkODrtJCCGL+0gvMO0FN/8Tguotat8kE9nEVqi9SZVw0UbxiuM4pe9t6c97BdF6ZJLF4
         0gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435799; x=1703040599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2fSxxmeQOUlGhNA/nGzzcE42fUlLQSVXAbxhrx2MoA=;
        b=BT2/Jyyyra2TKcjuGccLtfMp0IHA/8gIBrMTLBlL0Ib03mFGopHs6yuU334gBoAq8V
         R20XFE+YeWOD8R9nST4qcHjjwEsPQc8NcCZc1s8RipBgBxfWTQSLMZ/PvnShiJYG5oVw
         TyQfb/Q/ZSkVCCUpqAWJPCGelzPvZeOqX4FiaHSPq01D08PtudcZeNUIHiJUKmfFTPvA
         teC5tyuaAkmZvFdbaHaRuasgFyQlytKEZvh8I9wfSe6JGx1XzkXsaZFipcuuUqIr/6nT
         f2gOrcE4vTvSBm52aZJpJT500cKBjG5zxMmtMaoFGh1p70NBnUwVuri8TjtnXwp0va8Y
         +XFw==
X-Gm-Message-State: AOJu0YxPHUWZsGhkfxLZttbF8f44rx/8rBUxnZMGxwzR9ONtpLr/OHSj
	TUdjid+uat37QxlPAJZhxvA=
X-Google-Smtp-Source: AGHT+IG7cX3xMQteaJm9fXb/VroTbPeSK+nxl9XCu5DJBT0/7te1E/wIJ8n63vXEtyySG7VyvfssJQ==
X-Received: by 2002:a05:6a00:3a15:b0:6d0:8b0d:b8c2 with SMTP id fj21-20020a056a003a1500b006d08b0db8c2mr2994132pfb.38.1702435799474;
        Tue, 12 Dec 2023 18:49:59 -0800 (PST)
Received: from [10.22.68.68] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm8946554pgg.50.2023.12.12.18.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 18:49:59 -0800 (PST)
Message-ID: <a69b3faa-13a7-438b-94b2-3e85fde78a1c@gmail.com>
Date: Wed, 13 Dec 2023 10:49:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 3/4] bpf, x64: Load tail_call_cnt pointer
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-4-hffilwlqm@gmail.com> <ZXdPC1pH0tBY85B5@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZXdPC1pH0tBY85B5@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/23 02:03, Maciej Fijalkowski wrote:
> On Wed, Oct 11, 2023 at 11:27:24PM +0800, Leon Hwang wrote:
>> Rename RESTORE_TAIL_CALL_CNT() to LOAD_TAIL_CALL_CNT_PTR().
>>
>> With previous commit, rax is used to propagate tail_call_cnt pointer
>> instead of tail_call_cnt. So, LOAD_TAIL_CALL_CNT_PTR() is better.
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> 
> IMHO this is out of the scope for this set. We are going to target the bpf
> tree and this patch can be send to bpf-next in the future.
> 

LGTM.

Thanks,
Leon

>> ---
>>  arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>


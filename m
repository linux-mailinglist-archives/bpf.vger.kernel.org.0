Return-Path: <bpf+bounces-18056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061378154A5
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902781F25541
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCD3013E;
	Fri, 15 Dec 2023 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezS2oUQp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9018EAF
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e2b8f480b3so18897627b3.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702684328; x=1703289128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8oKpnzG4ldYMxh4I9P81k8LLwyGIV8aaV0xhl5bz7DY=;
        b=ezS2oUQpBSyKOrDXzKhtIkVgxuhhk7213GVtehnytgSHO+AHb6mnBqBydSCzZaZUQS
         sKeulPiC/M54sHdmeCKWcdN+rh5Amedi+sbHMKM9y2Kv+GH23C5YSni8DJW+yKoAU2yW
         Zz3Hiq2GcQbsihp7Y0ua/Eng0GiJHD7e8kaGrJg7Gs3x0jy1adXjuhho7Pfltrd/5Y0h
         ey0ZNWf1Twj5k93zh0asDk5X+Aubq7n4Asf3WZ/suNZSUn6s/UF6adrZqbbDBQqbOvh9
         FQnAa8EF+FhYLe48knMSZANDyFCzur+8KJ1Qjp05YLwtR9ZLl/AyhtnxT1nqieWl3oWY
         7c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684328; x=1703289128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oKpnzG4ldYMxh4I9P81k8LLwyGIV8aaV0xhl5bz7DY=;
        b=ZYGqfDDHDqye0Zle3snF0qkCBqWdwkjjCmgISd6OeDkAr5YFodAxrqyQpp5m3aXvAe
         uYhJIXQ1+0avaeFIJOZ+9ZcxtmmDvscA8uGyo3rNfBPAW+kTUVw9lDh86ne/Y0GeWwdj
         dyXbfWS7MT0IoDgssdOfkotDCz35Sm55Frwx4uydXmkgPrMedSx4xlk7oPl3RHxUmruV
         nWv5SGyp77KZKiRWixgvraJ22gRrUYVAbsMXL4XjmtPmUxwKwGNl+USWH1VHXN9eWEIh
         r1BFV4+iX6EuYZziUGjXVeihBVrgxd4Y7yY3k5YeFZ1VvoO1uDS3+2wZM4R/zveI3qB6
         jw1Q==
X-Gm-Message-State: AOJu0YyQvt/J2fMwuotSMMGAhBiuNhrgLqoq1R4Qf/Kf2YxkciCjU/Ze
	kEMDNG2+3tzkwtCZEkzaPy4=
X-Google-Smtp-Source: AGHT+IH2upY7Meo2a4H/I6iqTUwt+nWs3Cax/xlk8/yDEETtDIrXTnFTtmWu33EOMSJmPRH1ApRH5g==
X-Received: by 2002:a0d:d386:0:b0:5d7:1940:3f04 with SMTP id v128-20020a0dd386000000b005d719403f04mr8435344ywd.53.1702684327855;
        Fri, 15 Dec 2023 15:52:07 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:cff8:4904:6a61:98b6? ([2600:1700:6cf8:1240:cff8:4904:6a61:98b6])
        by smtp.gmail.com with ESMTPSA id b184-20020a0dc0c1000000b005d80a7711dasm6712153ywd.138.2023.12.15.15.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 15:52:07 -0800 (PST)
Message-ID: <db3ba342-265c-4823-ba3c-1e87dfb43c1c@gmail.com>
Date: Fri, 15 Dec 2023 15:52:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 09/14] bpf: validate value_type
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-10-thinker.li@gmail.com>
 <1448ac2f-8d5c-4cf4-9990-5e82029f7823@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <1448ac2f-8d5c-4cf4-9990-5e82029f7823@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 22:02, Martin KaFai Lau wrote:
> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index c5c7cc4552f5..7384806ee74e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3321,4 +3321,16 @@ static inline bool bpf_is_subprog(const struct 
>> bpf_prog *prog)
>>       return prog->aux->func_idx != 0;
>>   }
>> +enum bpf_struct_ops_state {
>> +    BPF_STRUCT_OPS_STATE_INIT,
>> +    BPF_STRUCT_OPS_STATE_INUSE,
>> +    BPF_STRUCT_OPS_STATE_TOBEFREE,
>> +    BPF_STRUCT_OPS_STATE_READY,
>> +};
>> +
>> +struct bpf_struct_ops_common_value {
>> +    refcount_t refcnt;
>> +    enum bpf_struct_ops_state state;
>> +};
> 
> nit. Move these up closer to the existing 'struct bpf_struct_ops' and 
> related functions. Probably under 'struct bpf_struct_ops'.
> 

Sure! I will move all following changes to the place closer to
struct bpf_struct_ops.


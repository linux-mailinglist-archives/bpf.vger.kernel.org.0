Return-Path: <bpf+bounces-13770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D67DD98B
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 01:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CEE281939
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A4637;
	Wed,  1 Nov 2023 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM4k6jHE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC77F;
	Wed,  1 Nov 2023 00:19:57 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8F1AA;
	Tue, 31 Oct 2023 17:19:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so5872778276.0;
        Tue, 31 Oct 2023 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698797995; x=1699402795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mbwX2rM0aJnGLITPARud4KCFW3QDrLVzqaFVSs3V8o=;
        b=PM4k6jHEjiTzNWZNZn1XUTlAhACVv3RXgyXYthVVlGPUhjXR11XNwrsIM/vH8m7rLZ
         A0tuXqeWG8azkcCorNgj4d70i9+KlCmBouxGigYMZLPaw4l65fQkztYaPh0a49zs6iO9
         LLkHmszk69zLYFVrLTqAYRVSj/l/TgHdV1jPKZSe8GaGzPygi1mnxYg9J1ylZZuqGHXM
         4OPaHHFKlfXDpOI9NJTY7KbibzdjKxCzMT5/tTmi35DujlCzH08kRbeU7U7IPV1t9iD0
         BQzq3hSsohCa08yjh8xtC7tw3pegt0ozywEnxHS4B8e60c1XBE4hQ1OlDwGGJshpai12
         WY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797995; x=1699402795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mbwX2rM0aJnGLITPARud4KCFW3QDrLVzqaFVSs3V8o=;
        b=a0ugXRCgapVgtnAz1R8PMF7100zAfOByVFT+PsRpyr25SLFbi6a3Sll86FCmos38Hd
         gdMl2biUBD0YU2Hd84hNiMVgO59YdCMuchLeI4yRsMD9xUysK9TnvOdREeRcjhBq/67x
         Tmq2lXf1kBQ8nVU3E94vZBCN60j2pcC86WZ4dzmrKB3DYHtUMt/FPZnbMWSrvmVlCznB
         Emyk97+QjiJzIL0as7lKHD67civUUlZXepv6odb+xPsCNQkMB8VaH6U31apGB9+eWgMi
         C5qXCx8mnuCJiMVJ+aPvFDQMuLHEUAujSeU98zjdLSJ8U9CAW+zurGZU1LyGjvIr/p2A
         4+Hw==
X-Gm-Message-State: AOJu0YwCka0oNZxlxuLXtYSRgttwJ/eBxVGqwI4qrcDOqf1DOa8EpIK6
	zW8aM1Tlwxhwc9KoFrUbN24=
X-Google-Smtp-Source: AGHT+IExUyLvXVZZoupJQRw8R1/PP6OwsB8l2y8UJE+Z497d98K65M7HdFArIZ7ja2LfiABa4UbEsw==
X-Received: by 2002:a25:f621:0:b0:d9a:5a04:bad with SMTP id t33-20020a25f621000000b00d9a5a040badmr12836126ybd.48.1698797995414;
        Tue, 31 Oct 2023 17:19:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id v134-20020a252f8c000000b00d9abce6acf2sm1427940ybv.59.2023.10.31.17.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:19:55 -0700 (PDT)
Message-ID: <51be2e5e-8def-45c5-8864-6b0dcc794300@gmail.com>
Date: Tue, 31 Oct 2023 17:19:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 07/10] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 thinker.li@gmail.com, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-8-thinker.li@gmail.com>
 <183fd964-8910-b7e6-436a-f5f82c2bafb0@linux.dev>
 <10f383a2-c83b-4a40-a1f9-bcf33c76c164@gmail.com>
 <5a8520dd-0dd6-4d51-9e4a-6eebcf7e792d@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5a8520dd-0dd6-4d51-9e4a-6eebcf7e792d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/31/23 17:02, Martin KaFai Lau wrote:
> On 10/31/23 4:34 PM, Kui-Feng Lee wrote:
>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>> index a8813605f2f6..954536431e0b 100644
>>>> --- a/include/linux/btf.h
>>>> +++ b/include/linux/btf.h
>>>> @@ -12,6 +12,8 @@
>>>>   #include <uapi/linux/bpf.h>
>>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);    \
>>>
>>> ((void)(struct type *)0); is new. Why is it needed?
>>
>> This is a trick of BTF to force compiler generate type info for
>> the given type. Without trick, compiler may skip these types if these
>> type are not used at all in the module.  For example, modules usually
>> don't use value types of struct_ops directly.
> It is not the value type and value type emit is understood. It is the 
> struct_ops type itself and it is new addition in this patchset afaict. 
> The value type emit is in the next line which was cut out from the 
> context here.
> 
I mean both of them are required.
In the case of a dummy implementation, struct_ops type itself properly 
never being used, only being declared by the module. Without this line,
the module developer will fail to load a struct_ops map of the dummy
type. This line is added to avoid this awful situation.



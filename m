Return-Path: <bpf+bounces-12791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1BF7D077F
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 07:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF1EB21472
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051E20F8;
	Fri, 20 Oct 2023 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL/MSXSz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D420E7
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 05:07:49 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6428B8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 22:07:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7ac4c3666so4155167b3.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697778465; x=1698383265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYKfodP2AqN/6g0MXB099qX/b+XSrJ/QI0YCcm/FCZs=;
        b=nL/MSXSzZ89ypHo8J4vpUyhHPWdfbJYlrANXMVf2qgV1P6aQgn+zUBMBd+iTkTbOPS
         cJTofHyAyL10uqH7iv+L454dPBPhifTuB8g3dLqViwyALW4jjw+dzomxpW+WudV/yHgo
         mn+FQGVxdfiffm9svlQ9+heawE88kChKbBlPZk4eSE2DFDgdgKc2dfS3hig2Ge7L8Xwg
         VqjcM+AsIo7oyncSAC6nE/emBtNLOHoKQBm+Qkx4t0ol66rthFBGSvAnzNnU0bXKpd2n
         E2VUO7axL9HeAPLQlVhYlig5O868+WzLrlkn0qr/XLkL02r7uZuArr6sqvjYmwX5Iaz2
         4NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697778465; x=1698383265;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYKfodP2AqN/6g0MXB099qX/b+XSrJ/QI0YCcm/FCZs=;
        b=rFHatiPwEhKj26czDnqSssZZzXJ/X0sjx0UCqTVDwWsYHGWRmvLoQ4RiQ2mbUeU4OM
         zbzTaYpbyuCZycCRTHGvQqhlv49t920E1j25fKniuYtxRyyszqpFbDJMh6sKNjXmfzzF
         Mr7C98OfrnkN8C1Ub4gKmyAZI60rs3kIVyqvBZlCHxXK3THj896oSTwFyJyNySsJpvK2
         7s/0/Rsr+XEBxkr5HCM9mLDETmu8SpmYq4RBCnAe+jrOAyq28dTOJNHnKgyLLj8vqdDk
         GqRDCNipSDimn26JZqal+WcMwyhJQedqG1o2Dkm+J4HZaaUAjt3qWDK2m3pW2QbEoHB/
         357w==
X-Gm-Message-State: AOJu0Yz9//PyXJFGe5YelE5EzwnXQ7wIjjV3ixHHQUzhWwngzX7l/SF+
	E4tIKgeB3gepk/lq25UH+mo=
X-Google-Smtp-Source: AGHT+IFSwFOYOv9g0Cs1VD/U26UEjdswTWlbTqhs9yKuwgZUp342CZNPAvtivTWQI2E7ZYOZmN9VSA==
X-Received: by 2002:a25:ae99:0:b0:d9b:9f35:d7e with SMTP id b25-20020a25ae99000000b00d9b9f350d7emr744425ybj.65.1697778464855;
        Thu, 19 Oct 2023 22:07:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f460:f504:31fe:e3a0? ([2600:1700:6cf8:1240:f460:f504:31fe:e3a0])
        by smtp.gmail.com with ESMTPSA id 16-20020a250910000000b00d749bc5b169sm311410ybj.43.2023.10.19.22.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 22:07:44 -0700 (PDT)
Message-ID: <02e2a704-4939-4f8c-b465-473c3a2eae1c@gmail.com>
Date: Thu, 19 Oct 2023 22:07:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/9] bpf: hold module for bpf_struct_ops_map.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-4-thinker.li@gmail.com>
 <a245d4c4-6eb0-ce54-41aa-4f8c8acf3051@linux.dev>
 <7ea8ebf7-3349-4461-b204-be106e3b547a@gmail.com>
In-Reply-To: <7ea8ebf7-3349-4461-b204-be106e3b547a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/19/23 09:29, Kui-Feng Lee wrote:
> 
> 
> On 10/18/23 17:36, Martin KaFai Lau wrote:
>> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
> 
>>
>>>   }
>>>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log 
>>> *log)
>>> @@ -215,7 +218,7 @@ void bpf_struct_ops_init(struct btf *btf, struct 
>>> bpf_verifier_log *log)
>>>       for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>>>           st_ops = bpf_struct_ops[i];
>>> -        bpf_struct_ops_init_one(st_ops, btf, log);
>>> +        bpf_struct_ops_init_one(st_ops, btf, NULL, log);
>>>       }
>>>   }
>>> @@ -630,6 +633,7 @@ static void __bpf_struct_ops_map_free(struct 
>>> bpf_map *map)
>>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>       }
>>>       bpf_map_area_free(st_map->uvalue);
>>> +    module_put(st_map->st_ops->owner);
>>>       bpf_map_area_free(st_map);
>>>   }
>>> @@ -676,9 +680,18 @@ static struct bpf_map 
>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>       if (!st_ops)
>>>           return ERR_PTR(-ENOTSUPP);
>>> +    /* If st_ops->owner is NULL, it means the struct_ops is
>>> +     * statically defined in the kernel.  We don't need to
>>> +     * take a refcount on it.
>>> +     */
>>> +    if (st_ops->owner && !btf_try_get_module(st_ops->btf))
>>
>> This just came to my mind. Is the module refcnt needed during map 
>> alloc/free or it could be done during the reg/unreg instead?
> 
> 
> Sure, I can move it to reg/unreg.

Just found that we relies type information in st_ops to update element 
and clean up maps.
We can not move get/put modules to reg/unreg except keeping a redundant 
copy in
st_map or somewhere. It make the code much more complicated by
introducing get/put module here and there.

I prefer to keep as it is now. WDYT?

>


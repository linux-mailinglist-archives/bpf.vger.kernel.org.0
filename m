Return-Path: <bpf+bounces-13734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F0F7DD4FA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B662B20F04
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE828208D5;
	Tue, 31 Oct 2023 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmFVox1T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F620B07
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:46:08 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23469F1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:46:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a8ee23f043so57295077b3.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698774364; x=1699379164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8K0DkHI3HcP+A+JynTn2/kFdnASPuvTWx4LJWoZFTQ=;
        b=AmFVox1T1zbYMm7wRGy818MK3RpBZqwjTMylMD1va6HK9LSh/ReHi74UHZW1gUkvbs
         WnXxoPo0iwZfu/hRqxHtIYQBt8GI+K9DmddbSMMw8Q2mCcpb5UXdBkGyAhGkktXdiYPF
         QziKe3Tg1jD89aSO+po1UPa0ooaqgBhpAtiwf31gICosohbBY2wzWXGonCIxwLqGdA3f
         buLvedbMVKWCjrrzwY7OMcLH0Mne4HrkiZ3/Hro1H3mDk6VgLeEEcmiswcjxa6dZzy8D
         n2HANbFDdBQoaBgp4ZyQPA5bCZtWUHSWmKXJmbDg+pu19WGarooc6/+63ck9/vWAzcmH
         utRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774364; x=1699379164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8K0DkHI3HcP+A+JynTn2/kFdnASPuvTWx4LJWoZFTQ=;
        b=NwKvVsrwigLRtGyxXxmhxPhV5iM9O06K9eobv3DDk3gBejsmy4ue1L+JjJ5rYAgl/J
         Tx8cxJ5yHpQjTRxhuZWqcaeKfRIPlZR+O4JL3OLg6pHhj8KGVvv7P/eA/CqW/hR6aJqt
         ufh2s7E+5TtS85Kg2MMT6pMJEdlP1DtAMJAk2ecYASDYAMb+5jqy9eW94ZQMdBOSXaBV
         K0gGJtzwtaO8Ttu5RoA2J7Rxr2mdNCh73w90wQKMz9lItRGv/xWqV/sD7I6L3RYKqVcp
         3i3iwfUzqA9xnuuuqpsusn8WCBMUdD7iu/UMbhZjPC/AGZ0YCwIt+fYhlqFBL4+WM7Tj
         9YSQ==
X-Gm-Message-State: AOJu0YwH669CmSQkl5TC49tBFjFWPjM2LdwCsM/ZugRLD07hvxXcn5g7
	CwFlF8nKFg3LXgM07WtNSaA=
X-Google-Smtp-Source: AGHT+IGbdZlfz2xqjjxeMbayBY9btRbfrUWYVDEYE7Co4VoWQZXWDQeIkwTg8vFqUq9g6NMCtswdVg==
X-Received: by 2002:a81:ad1a:0:b0:5a7:be29:19ac with SMTP id l26-20020a81ad1a000000b005a7be2919acmr15086065ywh.12.1698774364133;
        Tue, 31 Oct 2023 10:46:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id p127-20020a0dcd85000000b00583b144fe51sm950580ywd.118.2023.10.31.10.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:46:03 -0700 (PDT)
Message-ID: <d9e57272-f462-4c11-9b1a-b4257107e3ae@gmail.com>
Date: Tue, 31 Oct 2023 10:46:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 04/10] bpf: hold module for
 bpf_struct_ops_map.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-5-thinker.li@gmail.com>
 <ac35bad1-f978-6278-9619-c5e9ed3b76e5@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ac35bad1-f978-6278-9619-c5e9ed3b76e5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/23 18:21, Martin KaFai Lau wrote:
> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>> @@ -681,9 +697,17 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       if (!st_ops_desc)
>>           return ERR_PTR(-ENOTSUPP);
>> +    if (st_ops_desc->btf != btf_vmlinux) {
>> +        mod = btf_try_get_module(st_ops_desc->btf);
>> +        if (!mod)
>> +            return ERR_PTR(-EINVAL);
>> +    }
>> +
>>       vt = st_ops_desc->value_type;
>> -    if (attr->value_size != vt->size)
>> -        return ERR_PTR(-EINVAL);
>> +    if (attr->value_size != vt->size) {
>> +        ret = -EINVAL;
>> +        goto errout;
>> +    }
>>       t = st_ops_desc->type;
>> @@ -694,17 +718,17 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>           (vt->size - sizeof(struct bpf_struct_ops_value));
>>       st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>> -    if (!st_map)
>> -        return ERR_PTR(-ENOMEM);
>> +    if (!st_map) {
>> +        ret = -ENOMEM;
>> +        goto errout;
>> +    }
>>       st_map->st_ops_desc = st_ops_desc;
>>       map = &st_map->map;
>>       ret = bpf_jit_charge_modmem(PAGE_SIZE);
>> -    if (ret) {
>> -        __bpf_struct_ops_map_free(map);
>> -        return ERR_PTR(ret);
>> -    }
>> +    if (ret)
>> +        goto errout_free;
>>       st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
>>       if (!st_map->image) {
>> @@ -713,23 +737,32 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>            * here.
>>            */
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>> -        __bpf_struct_ops_map_free(map);
>> -        return ERR_PTR(-ENOMEM);
>> +        ret = -ENOMEM;
>> +        goto errout_free;
>>       }
>>       st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>>       st_map->links =
>>           bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct 
>> bpf_links *),
>>                      NUMA_NO_NODE);
>>       if (!st_map->uvalue || !st_map->links) {
>> -        __bpf_struct_ops_map_free(map);
>> -        return ERR_PTR(-ENOMEM);
>> +        ret = -ENOMEM;
>> +        goto errout_free;
>>       }
>>       mutex_init(&st_map->lock);
>>       set_vm_flush_reset_perms(st_map->image);
>>       bpf_map_init_from_attr(map, attr);
>> +    module_put(mod);
>> +
>>       return map;
>> +
>> +errout_free:
>> +    __bpf_struct_ops_map_free(map);
>> +    btf = NULL;        /* has been released */
> 
> btf is not defined. I don't think this patch compiles.
> Something from a latter patch?

Yes, it is defined in the next patch. I will fix it.

> 
>> +errout:
>> +    module_put(mod);
>> +    return ERR_PTR(ret);
>>   }
> 


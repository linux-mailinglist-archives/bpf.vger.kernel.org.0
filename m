Return-Path: <bpf+bounces-10820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6237AE28E
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 593A52816B6
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52630266AE;
	Mon, 25 Sep 2023 23:43:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FA262A0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:43:02 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFA10A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:43:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso8924553276.0
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695685379; x=1696290179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zzYefSaH1zbd8caOfCqKOGHzL7KIYrXLIh2GBygV2o=;
        b=hW93BueOT0H9ekAiwLhVVVSQZa4iqtoFV4y/zP2E9Uo/APEouCTxKAVbX3aAdOaCcK
         ritxYcGx0WkAl2aCaPIQs2Sm7mZ3BRl63FjcOl/rviZogF9YKBPDhLxtbR6uApv3plYz
         8uGCWqeaBVnOUPakcWq/E6Cdbg2UVSDyFl8joeBVY26C6AUYAnFqi6bB6gvwFUcq/5Vm
         XVKe1btEJycf+SD4orAq8z9t6dgS1k+/3OqVfHKVcyVbLgRtK2TKAXHBY3UVdSQRyvmf
         YC1CMihezOesIcEpVg7NxOMEhCxaK3nXxEVFzVk5WFMAiAEQ4P+X50JiCVnMrhJvzHox
         0aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695685379; x=1696290179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zzYefSaH1zbd8caOfCqKOGHzL7KIYrXLIh2GBygV2o=;
        b=VP4j/y3ky3bBlZdTOBpP3UiWJJdyWQmOUjILNE0w4RqGRNV5361VJz4w8ffHILmRhn
         jDNbb8xIb1bOpbpn0L0XEzvYUiZKdXG/GHMfcW6/bvt1vzQA/VzQK0HxAhwffeAMvi/m
         aytBv72bkDDYKgBPc5dIcEe904XR9JUEGSCiA1VI9PrgTqOgeREdAqf2kHyyDqPAxhqJ
         y0Ix3KpsDC2wjD1jqKvR+90Mu9ZsS04c5g8uTbkOzEQV+Bjrle0IhHK/Z5KCg+Pt0CnH
         8ytVlSnSIwJhzGAfq2xWsbqxGrnHqnrzIgEuyhSt8nQy4kQMrygqI6623eBx87BfDTuP
         4pEQ==
X-Gm-Message-State: AOJu0YwbDOVsXt7pnnMVr88QPFxjq96q/U9XDLS9YUTxStLiHIpcnLgX
	AQkVC1UmoG2vVwEJ7OlaTEQ=
X-Google-Smtp-Source: AGHT+IGOxDhU6a9ZxOHudob4o3yf9dSsOTJTIIubEVpRbB6au6hE7jsTT3uCGvulOq0h4LZoJvF02A==
X-Received: by 2002:a25:ab67:0:b0:d44:af:3cce with SMTP id u94-20020a25ab67000000b00d4400af3ccemr7307912ybi.27.1695685379450;
        Mon, 25 Sep 2023 16:42:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id m17-20020a258011000000b00d85abbdc93esm2347845ybk.12.2023.09.25.16.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 16:42:59 -0700 (PDT)
Message-ID: <437cd950-90ad-9cf4-8cb4-caa9538fef36@gmail.com>
Date: Mon, 25 Sep 2023 16:42:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 05/11] bpf: hold module for bpf_struct_ops_map.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-6-thinker.li@gmail.com>
 <8393a1f3-b4cf-9e4c-ce76-4b09a3f1622b@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <8393a1f3-b4cf-9e4c-ce76-4b09a3f1622b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 16:23, Martin KaFai Lau wrote:
> On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Ensure a module doesn't go away when a struct_ops object is still alive,
>> being a struct_ops type that is registered by the module.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         | 1 +
>>   kernel/bpf/bpf_struct_ops.c | 6 ++++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 0776cb584b3f..faaec20156f1 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1627,6 +1627,7 @@ struct bpf_struct_ops {
>>       int (*update)(void *kdata, void *old_kdata);
>>       int (*validate)(void *kdata);
>>       const struct btf *btf;
>> +    struct module *owner;
>>       const struct btf_type *type;
>>       const struct btf_type *value_type;
>>       const char *name;
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 7c2ef53687ef..ef8a1edec891 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -632,6 +632,8 @@ static void __bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>   static void bpf_struct_ops_map_free(struct bpf_map *map)
>>   {
>> +    struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +
>>       /* The struct_ops's function may switch to another struct_ops.
>>        *
>>        * For example, bpf_tcp_cc_x->init() may switch to
>> @@ -649,6 +651,7 @@ static void bpf_struct_ops_map_free(struct bpf_map 
>> *map)
>>        */
>>       synchronize_rcu_mult(call_rcu, call_rcu_tasks);
>> +    module_put(st_map->st_ops->owner);
>>       __bpf_struct_ops_map_free(map);
>>   }
>> @@ -673,6 +676,9 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       if (!st_ops)
>>           return ERR_PTR(-ENOTSUPP);
>> +    if (!try_module_get(st_ops->owner))
>> +        return ERR_PTR(-EINVAL);
> 
> The module can be gone at this point?
> I don't think try_module_get is safe. btf_try_get_module should be used 
> instead.

At this point, it holds btf, but not module. Module can go away while
some one still holding a refcount to the btf.

And, you are right, I should use btf_try_get_module().

> 
>> +
>>       vt = st_ops->value_type;
>>       if (attr->value_size != vt->size)
>>           return ERR_PTR(-EINVAL);
> 


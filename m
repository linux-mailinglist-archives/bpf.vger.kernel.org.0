Return-Path: <bpf+bounces-10325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4167A543B
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4521C20A4C
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032B450CE;
	Mon, 18 Sep 2023 20:40:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE605450C5
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 20:40:16 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BCB8F
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 13:40:15 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59c0d329a8bso31731057b3.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695069614; x=1695674414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XCYlJZThylO/wbg1eXpySrc4lP3JpK0dOXondHepn4=;
        b=HiKuY8nyIhbCQGlcyu0Rm6TRk5wRqm7z20afkrNFzKqjd0kcavyxAj3OjTIg3uCTeT
         4fOKj/0y+BQqxF8esAmruXikS6e3a4A7n4GyFv4jQCN0koxSU8PtzLUKs9n5mDP/WIgi
         L86Kj0jDTyjJ2PFvRGNGcIY1W82bO3FVyl/Xxr2cbuXcfRRmsR24+qX/GNpOQq00vW/L
         VhOGJEWLxgY9k/68+8ZS6uNGSNvX8PwM2F3WK9zw0veYpZ0B8Mik5JkXPZt4sP3v6kxG
         +aUJehYOQjwl6uMNV5N7E4X/mhm2ukwprZAyim06yUiBgdsSSnyQDV8HYB+sZbw5oexy
         r5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695069614; x=1695674414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XCYlJZThylO/wbg1eXpySrc4lP3JpK0dOXondHepn4=;
        b=pNHQdU9XYbloafe7BFmvGrNz2KVzDTI21quboaGo3RihKqFhUYbrZlnVSmSQx33YLo
         4zW1tdjY2angnrt7eBbzprnSZfQTbVrNg05OAcQe1d2QSFnShj+eepDYpjXYpULbYucN
         ibuGYBmcU28+6fET+TepU01UZKsYy5aMgzIxv2CkRKVjc54qS82F2RwMZDGoGhbTMc0v
         NzEt2jaBZRdw9gYCCpIB3ZRWiEBoi44TPnjiNvzu9Kn2H352oii2QKF9/V9nMfRJZOzm
         BSF3iqBZkBNJmrwcTq0l/e1a0onlK0dtNkZpL6Sshg1/dApMYs+DEtFrQ5S2BonQWL05
         e0jA==
X-Gm-Message-State: AOJu0YyL567G0SfmRfxsLAaJG8vQVcY8GZP5blxH4hHSCPd67Z3rzaD7
	dxAgB43J4z59qu/hK2OfFzI=
X-Google-Smtp-Source: AGHT+IFBoaTBPwCE8Q24s5rZilGh1QkRYto5LgwywFTqee4zAEF/yERzMAUVu6hUNwcf+bBJhKa5nA==
X-Received: by 2002:a81:a113:0:b0:59b:ee58:67fb with SMTP id y19-20020a81a113000000b0059bee5867fbmr10108940ywg.10.1695069614143;
        Mon, 18 Sep 2023 13:40:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:7c77:26bf:e557:d572? ([2600:1700:6cf8:1240:7c77:26bf:e557:d572])
        by smtp.gmail.com with ESMTPSA id g4-20020a815204000000b005897fd75c80sm2816251ywb.78.2023.09.18.13.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:40:13 -0700 (PDT)
Message-ID: <256287ce-660a-0e31-ab6f-ff484137a4cc@gmail.com>
Date: Mon, 18 Sep 2023 13:40:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v2 2/9] bpf: add register and unregister functions
 for struct_ops.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, thinker.li@gmail.com
References: <20230913061449.1918219-1-thinker.li@gmail.com>
 <20230913061449.1918219-3-thinker.li@gmail.com>
 <414e9f49-ad34-5282-6c05-882876440f34@linux.dev>
 <912b0d41-5959-74ff-a1a9-6277bf62aac2@gmail.com>
 <f16aeae6-cdf4-4836-5899-5c81e530936a@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f16aeae6-cdf4-4836-5899-5c81e530936a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/18/23 11:47, Martin KaFai Lau wrote:
> On 9/15/23 6:14 PM, Kui-Feng Lee wrote:
>>
>>
>> On 9/15/23 17:05, Martin KaFai Lau wrote:
>>> On 9/12/23 11:14 PM, thinker.li@gmail.com wrote:
>>>> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
>>>> +{
>>>> +    struct bpf_struct_ops *st_ops = mod->st_ops;
>>>> +    struct bpf_verifier_log *log;
>>>> +    struct btf *btf;
>>>> +    int err;
>>>> +
>>>> +    if (mod->st_ops == NULL ||
>>>> +        mod->owner == NULL)
>>>> +        return -EINVAL;
>>>> +
>>>> +    log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
>>>> +    if (!log) {
>>>> +        err = -ENOMEM;
>>>> +        goto errout;
>>>> +    }
>>>> +
>>>> +    log->level = BPF_LOG_KERNEL;
>>>> +
>>>> +    btf = btf_get_module_btf(mod->owner);
>>>
>>> Where is btf_put called?
>>>
>>> It is not stored anywhere in patch 2, so a bit confusing. I quickly 
>>> looked at the following patches but also don't see the bpf_put.
>>
>> It is my fault to use it without calling btf_put().
>> I miss-understood the API, thought it doesn't increase refcount by
>> mistake.
>>
>>>
>>>> +    if (!btf) {
>>>> +        err = -EINVAL;
>>>> +        goto errout;
>>>> +    }
>>>> +
>>>> +    bpf_struct_ops_init_one(st_ops, btf, log);
>>>> +    err = add_struct_ops(st_ops);
>>>> +
>>>> +errout:
>>>> +    kfree(log);
>>>> +
>>>> +    return err;
>>>> +}
>>>> +EXPORT_SYMBOL(register_bpf_struct_ops);
>>>> +
>>>> +int unregister_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
>>>
>>> It is not clear to me why the subsystem needs to explicitly call 
>>> unregister_bpf_struct_ops(). Can it be done similar to the module 
>>> kfunc support (the kfunc_set_tab goes away with the btf)?
>>
>> It could be. However, registering to module notifier
>> (register_module_notifier()) is more straight forward if we go
>> this way. What do you think?
> 
> Right, but not sure if struct_ops needs to create yet another notifier 
> considering there is already a btf_module_notify(). It is why the 
> earlier question on btf_put because I was trying to understand if the 
> struct_ops can go away together during btf_free. More on this next.

In short, it is not necessary to have another notifier.
The benefit with a separated notifier is loose coupling without touching
btf code. I don't have a strong opinion on this.


> 
>>
>>>
>>> Related to this, does it need to maintain a global struct_ops array 
>>> for all kernel module? Can the struct_ops be maintained under its 
>>> corresponding module btf itself?
>>
>> What is the purpose?
>> We have a global struct_ops array already, although it is not
>> per-module. For now, the number of struct_ops is pretty small.
>> We have only one so far, and it is unlikely to grow fast in
>> near future. It is probably a bit overkill to have
>> per-module ones if this is what you mean.
> 
> The array size is not the concern.
> 
> The global struct_ops array was created before btf supporting kernel 
> module. Since then, btf module and kfunc module support were added.
> 
> To maintain this global struct_ops array, it needs to register its own 
> module notifier, maintains its own mutex_lock (in patch 5), and also the 
> modified bpf_struct_ops_find*() is searching something under a specific 
> btf module.
> 
> afaict, the current btf kfunc support has the infrastructure to do all 
> these (for example, the global LIST_HEAD(btf_modules), btf_module_mutex, 
> btf_module_notify()...etc). Why struct_ops needs to be special and 
> reinvent something which looks very similar to btf kfunc? Did I missing 
> something that struct_ops needs special handling?


I don't think you missing anything.

> 
>>
>>>
>>>> +{
>>>> +    struct bpf_struct_ops *st_ops = mod->st_ops;
>>>> +    int err;
>>>> +
>>>> +    err = remove_struct_ops(st_ops);
>>>> +    if (!err && st_ops->uninit)
>>>> +        err = st_ops->uninit();
>>>> +
>>>> +    return err;
>>>> +}
>>>> +EXPORT_SYMBOL(unregister_bpf_struct_ops);
>>>
>>>
> 


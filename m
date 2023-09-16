Return-Path: <bpf+bounces-10195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F97A2CF0
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 03:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E61B2817E8
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA81C15;
	Sat, 16 Sep 2023 01:14:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9936E
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 01:14:53 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3AF7
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 18:14:52 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59bd2e19c95so29807787b3.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694826892; x=1695431692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyM8sxpPzsMYzcRNWUBDadvlesAnzMn+wrWqEvGQIyQ=;
        b=m0qocU1BrlM8bNesl0q8EsGf+sN89ZFbSeKPE5jRzIBmNkBwihYXHGBKkzOIdm88IO
         Sk60CNP1/d5kVKESu5rW+TwsPQjgq4ULiAckQrVORwcMpp2/AlmB9sVvDlhqSEuq1zlr
         qR1pv6O8Nx2VeQGk0IHRaQS9p32rClFAXWhB5xDDq1/ZMh8Qtxs97YliSXKtLhA0c9Ol
         UsgfDNPNLTUz5TWy6BoMT9ZGd/ErqKSZ/cH0XPLbeCvQMLKQeR7qDboHHuEtUQ441+DJ
         qc+a5Q/sCYaFh0LX+tTw3faqqxsFTNeEIMKrz/o8zuVv1CD3vIpTQqtfmaaWoZEItzlb
         67kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826892; x=1695431692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyM8sxpPzsMYzcRNWUBDadvlesAnzMn+wrWqEvGQIyQ=;
        b=cCA9QKY4M2dPtG2YPgUcqTE3obiMDCDt51pCxBAVOyuZUIgTa3R6Lajth/sEjGbyqo
         tNYfrzpSiQTgiEALGHRx0citgHIsJZrhpy9YXXUJRbD09BpFjLndza+BoyF4KBpP8jCX
         e9naqEJNWjn0qZm04JmUB28FDjG1I14TdnBOj7cXwVTukFJyvirDGxgkklq9PbUaMs4s
         bhQZ6Y6svQfVIpLp6dlnv1UtCr8kt7tuVVD0m8te6PCfPQCyKx1E5VKOijso4mGcVeId
         NG3KHhFSY2lqGBvowq+gkkPUGxjVjbriK/D2BXVPq74z5ewfxVPWgJfgKd+XFwAx5iAo
         cfeA==
X-Gm-Message-State: AOJu0YzJX8CKQ1QHyLzji03MhtZw1lQDcWJCWIRtXhNsFiu8xP0FCgo0
	tkENbA7onmeqY1E/PSvErGI=
X-Google-Smtp-Source: AGHT+IEHw18XhdlVZDEQIXZDdAcY7ZSWKkuIKT3YjCHycJwi+yVAEPgw1H5CrjcRvc8hprUV7lLj0Q==
X-Received: by 2002:a0d:f8c6:0:b0:573:a763:5876 with SMTP id i189-20020a0df8c6000000b00573a7635876mr2897641ywf.51.1694826891856;
        Fri, 15 Sep 2023 18:14:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8f1a:3ef8:5111:b2cd? ([2600:1700:6cf8:1240:8f1a:3ef8:5111:b2cd])
        by smtp.gmail.com with ESMTPSA id s68-20020a0dd047000000b0059bdac3fd08sm1158682ywd.48.2023.09.15.18.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 18:14:51 -0700 (PDT)
Message-ID: <912b0d41-5959-74ff-a1a9-6277bf62aac2@gmail.com>
Date: Fri, 15 Sep 2023 18:14:49 -0700
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
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230913061449.1918219-1-thinker.li@gmail.com>
 <20230913061449.1918219-3-thinker.li@gmail.com>
 <414e9f49-ad34-5282-6c05-882876440f34@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <414e9f49-ad34-5282-6c05-882876440f34@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/15/23 17:05, Martin KaFai Lau wrote:
> On 9/12/23 11:14 PM, thinker.li@gmail.com wrote:
>> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
>> +{
>> +    struct bpf_struct_ops *st_ops = mod->st_ops;
>> +    struct bpf_verifier_log *log;
>> +    struct btf *btf;
>> +    int err;
>> +
>> +    if (mod->st_ops == NULL ||
>> +        mod->owner == NULL)
>> +        return -EINVAL;
>> +
>> +    log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
>> +    if (!log) {
>> +        err = -ENOMEM;
>> +        goto errout;
>> +    }
>> +
>> +    log->level = BPF_LOG_KERNEL;
>> +
>> +    btf = btf_get_module_btf(mod->owner);
> 
> Where is btf_put called?
> 
> It is not stored anywhere in patch 2, so a bit confusing. I quickly 
> looked at the following patches but also don't see the bpf_put.

It is my fault to use it without calling btf_put().
I miss-understood the API, thought it doesn't increase refcount by
mistake.

> 
>> +    if (!btf) {
>> +        err = -EINVAL;
>> +        goto errout;
>> +    }
>> +
>> +    bpf_struct_ops_init_one(st_ops, btf, log);
>> +    err = add_struct_ops(st_ops);
>> +
>> +errout:
>> +    kfree(log);
>> +
>> +    return err;
>> +}
>> +EXPORT_SYMBOL(register_bpf_struct_ops);
>> +
>> +int unregister_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
> 
> It is not clear to me why the subsystem needs to explicitly call 
> unregister_bpf_struct_ops(). Can it be done similar to the module kfunc 
> support (the kfunc_set_tab goes away with the btf)?

It could be. However, registering to module notifier
(register_module_notifier()) is more straight forward if we go
this way. What do you think?

> 
> Related to this, does it need to maintain a global struct_ops array for 
> all kernel module? Can the struct_ops be maintained under its 
> corresponding module btf itself?

What is the purpose?
We have a global struct_ops array already, although it is not
per-module. For now, the number of struct_ops is pretty small.
We have only one so far, and it is unlikely to grow fast in
near future. It is probably a bit overkill to have
per-module ones if this is what you mean.

> 
>> +{
>> +    struct bpf_struct_ops *st_ops = mod->st_ops;
>> +    int err;
>> +
>> +    err = remove_struct_ops(st_ops);
>> +    if (!err && st_ops->uninit)
>> +        err = st_ops->uninit();
>> +
>> +    return err;
>> +}
>> +EXPORT_SYMBOL(unregister_bpf_struct_ops);
> 
> 


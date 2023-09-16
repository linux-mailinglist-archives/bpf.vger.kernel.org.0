Return-Path: <bpf+bounces-10196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60007A2D12
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 03:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49A61C21820
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF22109;
	Sat, 16 Sep 2023 01:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100D137C
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 01:35:24 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386DEE46
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 18:35:23 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d818d4230f6so2444013276.1
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694828122; x=1695432922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMPbATOBdbjelkzJk2o2gqMuVxx7gm+xSiN8lzyEAOo=;
        b=DYitVdDCzrcMfkKJ//hfk9b0gqf78ctcXUwVZqjekD/fdFHo5/gXje2efoqYe5s2zf
         g19P+JAVBrbrbW5ua7AoV7RtlhF6IrboxLp2GgwrY4pGU2TKLKY9c5B88M35YPnZck3W
         91pD6vFP3lohsvLoimUssY8+gVmFS9bAwLf/WyZ9zX3ACXFQlmXFBPlnnX5zph6BTkyo
         W6282KAmSvK9a+78Sa4NqREbZAU7HLSquFi34dmdgQXpgafsy/0mOhswbcxHs7Cm14LV
         /Nt7zuoF5rHZsKN7RYrPgdeUt3yk3OM7JKnMQkNkt+72CvtT/xiJpX0Aw3mt81vehXGq
         lQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828122; x=1695432922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMPbATOBdbjelkzJk2o2gqMuVxx7gm+xSiN8lzyEAOo=;
        b=dLa/oF0zvcTV+x9SfJbO1AaEZgQ7V+CI0sZf2fBtyeiCnRnT3Y34HAWEO7mu+twNKA
         RXe/HIjvrloXcv8ooW3Fs5tYnp4+Vo3uWmiS/RvttcCU0RW9Bt0e6BxgQ2rjhk8vbrZx
         JqcOoxfAPw4pepjk8HYo/QECvydxk1IlSfpCTwnJ4nVTGDSdH/CthecPMjpgjOSq66XK
         zCiDcAha5+IMkAJyQnOvVBF0iAZG2saYx74tQ9WMlWzZCP2Z5MRBtDAsblLynF0+wJFU
         wYyPmDClXAJttFILGlO8LyhcmjS4DQftSxIJze0CPUh+ySNwoFnnuH6NBdpbIk6sJp7Q
         Y/+Q==
X-Gm-Message-State: AOJu0YxsuorIqYkw1dFwumI6DTvjFLFcegGlIuA0FyOC2+4o4TmvHQQT
	Ngp3HGOoT2ZeQkbISVzfX6mQdcJWa8g=
X-Google-Smtp-Source: AGHT+IFl/vi0X10N52ZsHnz6sIHer/DMDOdceRSrh7762DUHrAzz/kl8xckGWbbNKJxGCusD162dxg==
X-Received: by 2002:a0d:c4c1:0:b0:59b:f8da:ffdb with SMTP id g184-20020a0dc4c1000000b0059bf8daffdbmr3568617ywd.29.1694828122338;
        Fri, 15 Sep 2023 18:35:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8f1a:3ef8:5111:b2cd? ([2600:1700:6cf8:1240:8f1a:3ef8:5111:b2cd])
        by smtp.gmail.com with ESMTPSA id x9-20020a0dd509000000b0059bc980b1eesm1168795ywd.6.2023.09.15.18.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 18:35:21 -0700 (PDT)
Message-ID: <b181b09e-9d41-1574-1f12-31f7466c6e4c@gmail.com>
Date: Fri, 15 Sep 2023 18:35:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v2 1/9] bpf: refactory struct_ops type
 initialization to a function.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230913061449.1918219-1-thinker.li@gmail.com>
 <20230913061449.1918219-2-thinker.li@gmail.com>
 <34a6af4f-ef3d-7e34-0c71-3c76d8f299e2@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <34a6af4f-ef3d-7e34-0c71-3c76d8f299e2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/15/23 15:43, Martin KaFai Lau wrote:
> On 9/12/23 11:14 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Move most of code to bpf_struct_ops_init_one() that can be use to
>> initialize new struct_ops types registered dynamically.
> 
> While in RFC, still better to have SOB so that it won't be overlooked in 
> the future.
> 
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 157 +++++++++++++++++++-----------------
>>   1 file changed, 83 insertions(+), 74 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index fdc3e8705a3c..1662875e0ebe 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -110,102 +110,111 @@ const struct bpf_prog_ops 
>> bpf_struct_ops_prog_ops = {
>>   static const struct btf_type *module_type;
>> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>> +static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>> +                    struct btf *btf,
>> +                    struct bpf_verifier_log *log)
>>   {
>> -    s32 type_id, value_id, module_id;
>>       const struct btf_member *member;
>> -    struct bpf_struct_ops *st_ops;
>>       const struct btf_type *t;
>> +    s32 type_id, value_id;
>>       char value_name[128];
>>       const char *mname;
>> -    u32 i, j;
>> +    int i;
>> -    /* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
>> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct 
>> bpf_struct_ops_##_name);
>> -#include "bpf_struct_ops_types.h"
>> -#undef BPF_STRUCT_OPS_TYPE
>> +    if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>> +        sizeof(value_name)) {
>> +        pr_warn("struct_ops name %s is too long\n",
>> +            st_ops->name);
>> +        return;
>> +    }
>> +    sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>> -    module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
>> -    if (module_id < 0) {
>> -        pr_warn("Cannot find struct module in btf_vmlinux\n");
>> +    value_id = btf_find_by_name_kind(btf, value_name,
>> +                     BTF_KIND_STRUCT);
> 
> It needs to do some sanity checks on the value_type since this won't be 
> statically enforced by bpf_struct_ops.c.

Do you mean to check if a value_type has refcnt, state and data field?

> 
> [ ... ]
> 
>> +void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>> +{
>> +    struct bpf_struct_ops *st_ops;
>> +    s32 module_id;
>> +    u32 i;
>> -            if (__btf_member_bitfield_size(t, member)) {
>> -                pr_warn("bit field member %s in struct %s is not 
>> supported\n",
>> -                    mname, st_ops->name);
>> -                break;
>> -            }
>> +    /* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
>> +#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct 
>> bpf_struct_ops_##_name);
>> +#include "bpf_struct_ops_types.h"
>> +#undef BPF_STRUCT_OPS_TYPE
> 
> Can this static way of defining struct_ops be removed? bpf_tcp_ca should 
> be able to use the register_bpf_struct_ops() introduced in patch 2.

It sounds good for me.

> 
> For the future subsystem supporting struct_ops, the subsystem could be 
> compiled as a kernel module or as a built-in. register_bpf_struct_ops() 
> should work for both.
> 


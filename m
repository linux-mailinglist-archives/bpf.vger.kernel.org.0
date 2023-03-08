Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016F46B15A0
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 23:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCHWvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 17:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCHWvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 17:51:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1488B442
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 14:51:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so375548pjp.2
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 14:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678315867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLIVEN2fbVRaYYbi2eQkaI1kXGRhpc8ALYP2bK4qlv8=;
        b=URAAePUgOp/9UpKT0ESzwKIQM5PIB8iY+6FomkKkfJY3w3Nk3Joi7f62YAkwNrX9Tc
         2UXjLr36RzVFdo6pgwIQlEjsl8VnaMUeOyfXXBguYQab+CKrSMtm6gXWnCuZKTbPlc1F
         oZNzK6oXUJjowPI9wVOki/UbP3wMp22cDIzUDtYOZ1UqpH94K8fKKqBU7vfNS7Mkk0Ra
         P16prcVw0aVOG3o5X/Als86+qx8iD4DrBZlDJ2SxJZEmpy6x+Uw8fjGlWfgNt+uv42jG
         DrvBLeoVfBTH9AQv2LKL/qNvGTIKIPn5xw6/B+OH4kbrXr9KeLN2Nwi4ys1H4BlC5QDT
         /XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLIVEN2fbVRaYYbi2eQkaI1kXGRhpc8ALYP2bK4qlv8=;
        b=XdsJozdHGi6cz29XeaGopNuKSiK+4bqHJmrQ6B4iJF99kDY8UmkjxVjNKmQLy3OowI
         rZHEAEEX0b8aQzp/yh1pvjEpsV5smzgEDKnVymgOVPVoeV7P4SMgQTjTJyQXDd6ErBuq
         ZBusvyQ0DeCtxbKCOnKkpHWvow1CkOb4BT/l3EifdZAw7wUJ7LVxyxfACI4Pn0dRH19u
         b+JmGFqDC4ofaW/MOOoMe62jaSjy7KFodhMbwdu26vQN3+0xCdHERHD7aHBoVZ0qI/bn
         u4z0Payoq6QNWZZ75yBf1Cek+4oQ0GjRHo8AGR1p0dUEbjNO53c6urXe14xA9Bi5dsjd
         sgxw==
X-Gm-Message-State: AO0yUKWdv9x34hm7SYjSbB1I4Z9y+fw2NPDELXVGkOtc3sjHjo8oKNir
        Zi/Y5PdVt3ut2F81hZq0+5g=
X-Google-Smtp-Source: AK7set+ORXpcwb5QI1ntw2XmwhoF0cBRGhIaTxm8xhx7eiR240vzyrqWxn8aFSdnXZ7oXCu0FFxGNw==
X-Received: by 2002:a17:902:e5ce:b0:199:25d1:e559 with SMTP id u14-20020a170902e5ce00b0019925d1e559mr24694776plf.0.1678315867257;
        Wed, 08 Mar 2023 14:51:07 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::1660? ([2620:10d:c090:400::5:78e2])
        by smtp.gmail.com with ESMTPSA id p6-20020a631e46000000b00502ecb91940sm9650345pgm.55.2023.03.08.14.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:51:06 -0800 (PST)
Message-ID: <94efe4cf-5eb6-7139-b997-270aa9f1c1f5@gmail.com>
Date:   Wed, 8 Mar 2023 14:51:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v5 2/8] net: Update an existing TCP congestion
 control algorithm.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-3-kuifeng@meta.com>
 <a3ec530d-af78-6ed1-4412-bb527aa7a148@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a3ec530d-af78-6ed1-4412-bb527aa7a148@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/8/23 10:59, Martin KaFai Lau wrote:
> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 50cfc2388cbc..00b6e1a2edaf 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1512,6 +1512,8 @@ struct bpf_struct_ops {
>>                  void *kdata, const void *udata);
>>       int (*reg)(void *kdata);
>>       void (*unreg)(void *kdata);
>> +    int (*update)(void *kdata, void *old_kdata);
>> +    int (*validate)(void *kdata);
>>       const struct btf_type *type;
>>       const struct btf_type *value_type;
>>       const char *name;
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index db9f828e9d1e..2abb755e6a3a 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1117,6 +1117,9 @@ struct tcp_congestion_ops {
>>   int tcp_register_congestion_control(struct tcp_congestion_ops *type);
>>   void tcp_unregister_congestion_control(struct tcp_congestion_ops 
>> *type);
>> +int tcp_update_congestion_control(struct tcp_congestion_ops *type,
>> +                  struct tcp_congestion_ops *old_type);
>> +int tcp_validate_congestion_control(struct tcp_congestion_ops *ca);
>>   void tcp_assign_congestion_control(struct sock *sk);
>>   void tcp_init_congestion_control(struct sock *sk);
>> diff --git a/net/bpf/bpf_dummy_struct_ops.c 
>> b/net/bpf/bpf_dummy_struct_ops.c
>> index ff4f89a2b02a..158f14e240d0 100644
>> --- a/net/bpf/bpf_dummy_struct_ops.c
>> +++ b/net/bpf/bpf_dummy_struct_ops.c
>> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>>   {
>>   }
>> +static int bpf_dummy_update(void *kdata, void *old_kdata)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>       .verifier_ops = &bpf_dummy_verifier_ops,
>>       .init = bpf_dummy_init,
>>       .check_member = bpf_dummy_ops_check_member,
>>       .init_member = bpf_dummy_init_member,
>>       .reg = bpf_dummy_reg,
>> +    .update = bpf_dummy_update,
>>       .unreg = bpf_dummy_unreg,
>>       .name = "bpf_dummy_ops",
>>   };
>> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
>> index 13fc0c185cd9..e8b27826283e 100644
>> --- a/net/ipv4/bpf_tcp_ca.c
>> +++ b/net/ipv4/bpf_tcp_ca.c
>> @@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct 
>> btf_type *t,
>>           if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
>>                        sizeof(tcp_ca->name)) <= 0)
>>               return -EINVAL;
>> -        if (tcp_ca_find(utcp_ca->name))
>> -            return -EEXIST;
> 
> This belongs to patch 3 where BPF_F_LINK needs this. move it closer to 
> where it is actually used.

Got it!

> 
>>           return 1;
>>       }
>> @@ -266,13 +264,25 @@ static void bpf_tcp_ca_unreg(void *kdata)
>>       tcp_unregister_congestion_control(kdata);
>>   }
>> +static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
>> +{
>> +    return tcp_update_congestion_control(kdata, old_kdata);
>> +}
>> +
>> +static int bpf_tcp_ca_validate(void *kdata)
>> +{
>> +    return tcp_validate_congestion_control(kdata);
>> +}
>> +
>>   struct bpf_struct_ops bpf_tcp_congestion_ops = {
>>       .verifier_ops = &bpf_tcp_ca_verifier_ops,
>>       .reg = bpf_tcp_ca_reg,
>>       .unreg = bpf_tcp_ca_unreg,
>> +    .update = bpf_tcp_ca_update,
>>       .check_member = bpf_tcp_ca_check_member,
>>       .init_member = bpf_tcp_ca_init_member,
>>       .init = bpf_tcp_ca_init,
>> +    .validate = bpf_tcp_ca_validate,
>>       .name = "tcp_congestion_ops",
>>   };
> 
> In general, please move "validate" related bpf changes to patch 3 and 
> "update" related changes to patch 5. They are bpf specific (including 
> the changes in bpf_tcp_ca.c) and closer to where it will be used.
> 
> Then patch 2 should only have changes in tcp_cong.c as the preparation 
> work for the later bpf needs. Please cc netdev for patch 2 in the next 
> re-spin.
> 
Sure

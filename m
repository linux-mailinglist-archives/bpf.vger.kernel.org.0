Return-Path: <bpf+bounces-13511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD787DA281
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344ADB214C7
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46C3FE3C;
	Fri, 27 Oct 2023 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ostexpqp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36763C09E;
	Fri, 27 Oct 2023 21:32:46 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D905129;
	Fri, 27 Oct 2023 14:32:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7c7262d5eso19543177b3.1;
        Fri, 27 Oct 2023 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698442364; x=1699047164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiiik1EmonwOYua9QFLpRTS3QjzlHjGr9bTw0z1B0Ok=;
        b=OstexpqpXSvgNTEOCcFJvm5GDxardN3wwdKVzIiJZOLEHmHNcStWV7DhyZS8tGOaIZ
         O70/n+KYhvyPLVBl7T5CXfuObIWG679lUr/8GQjRTVOJNQqsr/3+CC+I1H4m9OTaZGR2
         T6W8aFZ2DWe15kkYvDYG2dDxH/oWvWMli2okWelq9htdIHN7S7SGuFNlNfSzq2L8vDEE
         FpXb8xJYPhwkRvB4SO4z5Bulkp0q45tFMNZIISGvlOfaxr464axyP3yMO3qt3LY8hbla
         W8N4rBaySmmZeRdZss8vlR59XN4l2JJwZZwHobPzDBtNYZJeF3jKi1qO/djRORK36vHq
         C7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442364; x=1699047164;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiiik1EmonwOYua9QFLpRTS3QjzlHjGr9bTw0z1B0Ok=;
        b=wWsa4HVh0wldpLG/1Hm1i2uh1xUgkd2x2EcSpRJgfgA9600NE3YrpamoBTqNhs2gxu
         J7yMXQzHD92P38MSVDsxxVpzjVcNBe1qRTquXcj1mv9477LBAVIlJjew3JWNV3BWYg6m
         kKvq61vgGhE3Oc060chxvgqYyV/tVvjhNjEXedxqJ/04xyubyadA9v9y4lTwhqZP+CjA
         W49DBxxHVZ9zARP3EdLhkdPg8XOlmsyawTevLwnNkwqXxwmp184O3QNn3CkSubKzULTw
         +Jm1PkFh+vS7Y1kYLgF0Ui96CCsDfMMXsjSHYRWxYe7vGI6Lf4aGiLftggaBGmeHmJJf
         Tcvw==
X-Gm-Message-State: AOJu0YyHM19P75+ISDOqA5WVd1xQ5sSUMvZIR2J3BczRI54P8qqmG0/d
	aEH1L0roYaNN3aeQ464zD/U=
X-Google-Smtp-Source: AGHT+IEQsxX4f3S4c3d7q6nt59cy48K2P96Phjk/QzIGOdCcOSFZUjpjlcDtd1B2bgeYi7FkmxukyQ==
X-Received: by 2002:a81:ae09:0:b0:5a7:dad7:61dd with SMTP id m9-20020a81ae09000000b005a7dad761ddmr4039070ywh.20.1698442364344;
        Fri, 27 Oct 2023 14:32:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:41cd:a94b:292d:cd8? ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id y7-20020a818807000000b0059ae483b89dsm1113960ywf.50.2023.10.27.14.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 14:32:43 -0700 (PDT)
Message-ID: <df8f71ce-4e3b-4e65-a197-e2ce0ca494de@gmail.com>
Date: Fri, 27 Oct 2023 14:32:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 07/10] bpf, net: switch to dynamic
 registration
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org
References: <20231022050335.2579051-1-thinker.li@gmail.com>
 <20231022050335.2579051-8-thinker.li@gmail.com>
 <7b143dd306cdb3a94c995bf807596fb1f88a02f9.camel@gmail.com>
 <f2c33ec4-339d-464d-893e-4f5ba0b9c294@gmail.com>
In-Reply-To: <f2c33ec4-339d-464d-893e-4f5ba0b9c294@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/26/23 21:39, Kui-Feng Lee wrote:
> 
> 
> On 10/26/23 14:02, Eduard Zingerman wrote:
>> On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
[...]
>>> +
>>> +    btf = btf_get_module_btf(st_ops->owner);
>>> +    if (!btf)
>>> +        return -EINVAL;
>>> +
>>> +    log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
>>> +    if (!log) {
>>> +        err = -ENOMEM;
>>> +        goto errout;
>>> +    }
>>> +
>>> +    log->level = BPF_LOG_KERNEL;
>>
>> Nit: maybe use bpf_vlog_init() here to avoid breaking encapsulation?
> 
> Agree!
> 

I don't use bpf_vlog_init() eventually.

I found bpf_vlog_init() is not for BPF_LOG_KERNEL.
According to the comment next to BPF_LOG_KERNEL, it
is an internal log level.
According to the code of bpf_vlog_init(), the level passing to
bpf_vlog_init() should be covered by BPF_LOG_MASK. BPF_LOG_KERNEL is
defined as BPF_LOG_MASK + 1. So, it is intended not being used with
bpf_vlog_init().

>>
>>> +
>>> +    desc = btf_add_struct_ops(btf, st_ops);
>>> +    if (IS_ERR(desc)) {
>>> +        err = PTR_ERR(desc);
>>> +        goto errout;
>>> +    }
>>> +
>>> +    bpf_struct_ops_init(desc, btf, log);
>>
>> Nit: I think bpf_struct_ops_init() could be changed to return 'int',
>>       then register_bpf_struct_ops() could report to calling module if
>>       something went wrong on the last phase, wdyt?
> 
> 
> Agree!
> 
>>
>>> +
>>> +errout:
>>> +    kfree(log);
>>> +    btf_put(btf);
>>> +
>>> +    return err;
>>> +}
>>> +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
>>> diff --git a/net/bpf/bpf_dummy_struct_ops.c 
>>> b/net/bpf/bpf_dummy_struct_ops.c
>>> index ffa224053a6c..148a5851c4fa 100644
>>> --- a/net/bpf/bpf_dummy_struct_ops.c
>>> +++ b/net/bpf/bpf_dummy_struct_ops.c
>>> @@ -7,7 +7,7 @@
>>>   #include <linux/bpf.h>
>>>   #include <linux/btf.h>
>>> -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
>>> +static struct bpf_struct_ops bpf_bpf_dummy_ops;
>>>   /* A common type for test_N with return value in bpf_dummy_ops */
>>>   typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state 
>>> *state, ...);
>>> @@ -223,11 +223,13 @@ static int bpf_dummy_reg(void *kdata)
>>>       return -EOPNOTSUPP;
>>>   }
>>> +DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_dummy_ops);
>>> +
>>>   static void bpf_dummy_unreg(void *kdata)
>>>   {
>>>   }
>>> -struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>> +static struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>>       .verifier_ops = &bpf_dummy_verifier_ops,
>>>       .init = bpf_dummy_init,
>>>       .check_member = bpf_dummy_ops_check_member,
>>> @@ -235,4 +237,12 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>>       .reg = bpf_dummy_reg,
>>>       .unreg = bpf_dummy_unreg,
>>>       .name = "bpf_dummy_ops",
>>> +    .owner = THIS_MODULE,
>>>   };
>>> +
>>> +static int __init bpf_dummy_struct_ops_init(void)
>>> +{
>>> +    BTF_STRUCT_OPS_TYPE_EMIT(bpf_dummy_ops);
>>> +    return register_bpf_struct_ops(&bpf_bpf_dummy_ops);
>>> +}
>>> +late_initcall(bpf_dummy_struct_ops_init);
>>> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
>>> index 3c8b76578a2a..b36a19274e5b 100644
>>> --- a/net/ipv4/bpf_tcp_ca.c
>>> +++ b/net/ipv4/bpf_tcp_ca.c
>>> @@ -12,7 +12,7 @@
>>>   #include <net/bpf_sk_storage.h>
>>>   /* "extern" is to avoid sparse warning.  It is only used in 
>>> bpf_struct_ops.c. */
>>> -extern struct bpf_struct_ops bpf_tcp_congestion_ops;
>>> +static struct bpf_struct_ops bpf_tcp_congestion_ops;
>>>   static u32 unsupported_ops[] = {
>>>       offsetof(struct tcp_congestion_ops, get_info),
>>> @@ -277,7 +277,9 @@ static int bpf_tcp_ca_validate(void *kdata)
>>>       return tcp_validate_congestion_control(kdata);
>>>   }
>>> -struct bpf_struct_ops bpf_tcp_congestion_ops = {
>>> +DEFINE_STRUCT_OPS_VALUE_TYPE(tcp_congestion_ops);
>>> +
>>> +static struct bpf_struct_ops bpf_tcp_congestion_ops = {
>>>       .verifier_ops = &bpf_tcp_ca_verifier_ops,
>>>       .reg = bpf_tcp_ca_reg,
>>>       .unreg = bpf_tcp_ca_unreg,
>>> @@ -287,10 +289,18 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
>>>       .init = bpf_tcp_ca_init,
>>>       .validate = bpf_tcp_ca_validate,
>>>       .name = "tcp_congestion_ops",
>>> +    .owner = THIS_MODULE,
>>>   };
>>>   static int __init bpf_tcp_ca_kfunc_init(void)
>>>   {
>>> -    return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, 
>>> &bpf_tcp_ca_kfunc_set);
>>> +    int ret;
>>> +
>>> +    BTF_STRUCT_OPS_TYPE_EMIT(tcp_congestion_ops);
>>> +
>>> +    ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, 
>>> &bpf_tcp_ca_kfunc_set);
>>> +    ret = ret ?: register_bpf_struct_ops(&bpf_tcp_congestion_ops);
>>> +
>>> +    return ret;
>>>   }
>>>   late_initcall(bpf_tcp_ca_kfunc_init);
>>


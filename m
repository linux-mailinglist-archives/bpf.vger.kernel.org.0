Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388DF64B3A8
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLMLAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiLMK76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 05:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645C1165
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 02:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670929155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1bHxguVmA1xaQPAxrcNXZrXG6dQmCUvMZAJjfdbDT4=;
        b=eW6nKRPu5DSmEoTnbpF6CpeM2wEM65WngJaLCSGfJPMjHlnUu7TmZz5SXBF+0hyIghQ7ST
        KVG5A2GxnKXfhjVrXH2FJXj/Wxv2ARazQG7jNiNt5TvBKr8K2rdLbUoVwLdIWI7XpAcW7Z
        ZYpzogNxjJXEJIgBAPdowu429Zl49MU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-gHow40ldPqao0omo88kCMw-1; Tue, 13 Dec 2022 05:59:14 -0500
X-MC-Unique: gHow40ldPqao0omo88kCMw-1
Received: by mail-ej1-f71.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso9033758ejb.5
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 02:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1bHxguVmA1xaQPAxrcNXZrXG6dQmCUvMZAJjfdbDT4=;
        b=S9Gdv0o+X8ahjxs4rqpF4xv2cPsPFxcyh9rvN/P1GVMKFn8LvFMedNaRRbPuUSVKvh
         AAedJBzMy8IhHuteSC9TPMJWQHnEfiYRXeeyAjBiFn+MYO3Pc0Hs2lRNjRwdqudVkgCA
         FjylSNQ3d1XrqvvPSYpNH3tRlJ+J0OxXbJitEu70/OGIipnT+Chlw6p8uuH6nMbyiNAU
         JHPfXISjo2ja30XePNAcSBfmE68vXf/+aEoCuG9zmHJX357ZAB4ndnz3z1rR03tFaDl8
         YiVooTPHUa2nrN0jvsAuzQa5QbNCMA7o6H2j/HELHmF2FzNNzy/DisF2i0MPrBSjb7V+
         dtJw==
X-Gm-Message-State: ANoB5pkXsw+bCYxzK088OokT2X08cYo5h7ZYM8n4Z5UYEjWz73lglKut
        ieaR58YM9FMB1bgCUSKvBqz0dTDbH+6+Q9W9DZJ/fcm7lI8AmEwWnAzuuJ4GD78bRrfGa4JF7+H
        MLQgEZc1HHMY=
X-Received: by 2002:a17:907:8b87:b0:7c1:962e:cf23 with SMTP id tb7-20020a1709078b8700b007c1962ecf23mr473636ejc.37.1670929153395;
        Tue, 13 Dec 2022 02:59:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4bS5euprTAYygfaWtRQeXiGJzdCvlnaioxTeZrvJI2flv4TtHlP4cZM0FIVF0xvFiviijr/w==
X-Received: by 2002:a17:907:8b87:b0:7c1:962e:cf23 with SMTP id tb7-20020a1709078b8700b007c1962ecf23mr473629ejc.37.1670929153226;
        Tue, 13 Dec 2022 02:59:13 -0800 (PST)
Received: from [172.20.10.11] (78-80-28-214.customers.tmcz.cz. [78.80.28.214])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b007c09d37eac7sm4348069ejd.216.2022.12.13.02.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 02:59:12 -0800 (PST)
Message-ID: <d8464b4e-b514-7587-50eb-4b1391e87713@redhat.com>
Date:   Tue, 13 Dec 2022 11:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1670847888.git.vmalik@redhat.com>
 <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
 <b1698393-2bec-edb9-5adc-d076bfc2b188@meta.com>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <b1698393-2bec-edb9-5adc-d076bfc2b188@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/12/22 18:08, Yonghong Song wrote:
> 
> 
> On 12/12/22 4:59 AM, Viktor Malik wrote:
>> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
>> module without specifying the target program, the verifier tries to find
>> the address to attach to in kallsyms. This is always done by searching
>> the entire kallsyms, not respecting the module in which the function is
>> located.
>>
>> This approach causes an incorrect attachment address to be computed if
>> the function to attach to is shadowed by a function of the same name
>> located earlier in kallsyms.
>>
>> Since the attachment must contain the BTF of the program to attach to,
>> we may extract the module from it and search for the function address in
>> the module.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   kernel/bpf/verifier.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a5255a0dcbb6..d646c5263bc5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/bpf_lsm.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/poison.h>
>> +#include "../module/internal.h"
>>   #include "disasm.h"
>> @@ -16478,6 +16479,7 @@ int bpf_check_attach_target(struct 
>> bpf_verifier_log *log,
>>       const char *tname;
>>       struct btf *btf;
>>       long addr = 0;
>> +    struct module *mod;
>>       if (!btf_id) {
>>           bpf_log(log, "Tracing programs must provide btf_id\n");
>> @@ -16645,7 +16647,19 @@ int bpf_check_attach_target(struct 
>> bpf_verifier_log *log,
>>               else
>>                   addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>>           } else {
>> -            addr = kallsyms_lookup_name(tname);
>> +            if (btf_is_module(btf)) {
>> +                preempt_disable();
>> +                mod = btf_try_get_module(btf);
>> +                if (mod) {
>> +                    addr = find_kallsyms_symbol_value(mod, tname);
>> +                    module_put(mod);
>> +                } else {
>> +                    addr = 0;
>> +                }
>> +                preempt_enable();
> 
> What if module is unloaded right after preempt_enabled so 'addr' becomes 
> invalid? Is this a corner case we should consider?

IIUC, if 'addr' becomes invalid, the attachment will eventually fail.

So I'd say that there's no need to consider that case here, it's not
considered for kallsyms_lookup_name below (which may call
module_kallsyms_lookup_name) either.

> 
>> +            } else {
>> +                addr = kallsyms_lookup_name(tname);
>> +            }
>>               if (!addr) {
>>                   bpf_log(log,
>>                       "The address of function %s cannot be found\n",
> 


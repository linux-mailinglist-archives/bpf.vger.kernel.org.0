Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAD64544A
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 07:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLGG6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 01:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLGG6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 01:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFAA62DC
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 22:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670396255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ls0Fk/IWfBd7MVzuolcoot4VE78sTAh5F/PHFkTTMk4=;
        b=EZNo0vdTH5+lZzYGdKRwoeCyZGEQIEpviTudZdMiyIwdf4QdWm7f3qMbiRtxE3iWy3IHVh
        WLjtQXW/bOnkiIQDKYbi89KBa52MSZU+nyHtQtBRg7DdKX+DGWAh83E2DwGcoRLiAGyxSn
        Kl4ORmEfxZp37OZAbtAPrYcrk7XqgGA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-sUw682LxOE-KNNOxphv0cw-1; Wed, 07 Dec 2022 01:57:34 -0500
X-MC-Unique: sUw682LxOE-KNNOxphv0cw-1
Received: by mail-ej1-f70.google.com with SMTP id sb2-20020a1709076d8200b007bdea97e799so2867775ejc.22
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 22:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls0Fk/IWfBd7MVzuolcoot4VE78sTAh5F/PHFkTTMk4=;
        b=1d8DH1rkjPIlrNvCI5ziWyS/4eGfub6Wydmf21CoS8E4O2FqiU7ouaLIoTfZTmMOE5
         62B5zEWhpdJKTn3+TiaGkHAL1vt9KALZXN62iu/NhbM8Dvg4ZeTIzGp60iEnFytaYer0
         ZGGtSRigZHqPtdBj4MmRjwwf0AbLE12d+CEhVmEsrzxdBFcPfYKKeOyG8vvQMNbmRp0t
         MzCx0OX9pOH6mO5c1QrtY2DQI/8qTtgGrpBeeTaFX2AEpb4TyXm6TpszbMSk4vrCXpVg
         puyWbGPstW67O6J6u+N/xVtZIqQys3xgyOugNnj3SsgW8EVeNjqsXVEmmWATDTOgUxFu
         VYPw==
X-Gm-Message-State: ANoB5pkd4tWrU7wOsIGOf3AvQcTxKN6/mQfyp5PT9BLmwJN9mp2lMmsX
        KYdUS4PQNGCHhAiY4X9x6lLgAckyLZenx0SZaNv91ilb2ST4MxChax8lm3HBhw8QF93APO3tKWi
        b4RH5Pch7Uzc=
X-Received: by 2002:a17:906:30c3:b0:7ba:a674:22e4 with SMTP id b3-20020a17090630c300b007baa67422e4mr51326874ejb.279.1670396252377;
        Tue, 06 Dec 2022 22:57:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6uJmeZO9BdVALTjrOphD40g0EmlOix0xKd5UXp3aekqRvQBVFGMOw5derbskRs6XAsMh5I7A==
X-Received: by 2002:a17:906:30c3:b0:7ba:a674:22e4 with SMTP id b3-20020a17090630c300b007baa67422e4mr51326860ejb.279.1670396252130;
        Tue, 06 Dec 2022 22:57:32 -0800 (PST)
Received: from [192.168.0.111] (185-219-167-248-static.vivo.cz. [185.219.167.248])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b007c073be0127sm8087912ejf.202.2022.12.06.22.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 22:57:31 -0800 (PST)
Message-ID: <1aab1aaa-2012-b2d8-fa57-e63eb14ddf8e@redhat.com>
Date:   Wed, 7 Dec 2022 07:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1670249590.git.vmalik@redhat.com>
 <c4f71d66eff216097b63d8a73ac203cb689567b4.1670249590.git.vmalik@redhat.com>
 <Y4/Z9dq4EqH76ke5@macbook-pro-6.dhcp.thefacebook.com>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Y4/Z9dq4EqH76ke5@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 01:10, Alexei Starovoitov wrote:
> On Mon, Dec 05, 2022 at 04:26:05PM +0100, Viktor Malik wrote:
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
>> we may extract the module name from it (if the attach target is a
>> module) and search for the function address in the correct module.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Acked-by: Hao Luo <haoluo@google.com>
>> ---
>>   include/linux/btf.h   | 1 +
>>   kernel/bpf/btf.c      | 5 +++++
>>   kernel/bpf/verifier.c | 5 ++++-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index cbd6e4096f8c..b7b791d1f3d6 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -188,6 +188,7 @@ u32 btf_obj_id(const struct btf *btf);
>>   bool btf_is_kernel(const struct btf *btf);
>>   bool btf_is_module(const struct btf *btf);
>>   struct module *btf_try_get_module(const struct btf *btf);
>> +const char *btf_module_name(const struct btf *btf);
>>   u32 btf_nr_types(const struct btf *btf);
>>   bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>>   			   const struct btf_member *m,
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index c80bd8709e69..f78e8060efa6 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7208,6 +7208,11 @@ bool btf_is_module(const struct btf *btf)
>>   	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
>>   }
>>   
>> +const char *btf_module_name(const struct btf *btf)
>> +{
>> +	return btf->name;
>> +}
> 
> It feels that btf->name is leaking a bit of implementation detail.
> How about doing:
> 
> struct module *btf_find_module(const struct btf *btf)
> {
>          reutrn find_module(btf->name);
> }
> 
>> +
>>   enum {
>>   	BTF_MODULE_F_LIVE = (1 << 0),
>>   };
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1d51bd9596da..0c533db51f92 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16483,7 +16483,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			else
>>   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>>   		} else {
>> -			addr = kallsyms_lookup_name(tname);
>> +			if (btf_is_module(btf))
>> +				addr = kallsyms_lookup_name_in_module(btf_module_name(btf), tname);
> 
> and use find_kallsyms_symbol_value() here
> (with preempt_disable dance).
> There won't be a need for patch 1 too.
> 
> wdyt?

This makes sense to me maybe more than the current solution.
I'm not sure where it's best to do preempt_disable, though. Would you
rather do it here or inside find_kallsyms_symbol_value? Or should we
create a new wrapper for find_kallsyms_symbol_value, possibly outside of
kernel/module/internal.h?

Thanks!

> 
>> +			else
>> +				addr = kallsyms_lookup_name(tname);
>>   			if (!addr) {
>>   				bpf_log(log,
>>   					"The address of function %s cannot be found\n",
>> -- 
>> 2.38.1
>>
> 


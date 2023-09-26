Return-Path: <bpf+bounces-10831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5BD7AE32B
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ECFCF2815BF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892317E8;
	Tue, 26 Sep 2023 00:58:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80C637
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:58:12 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422BF196
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:58:10 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bbdb435bfso92400727b3.3
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695689889; x=1696294689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXGIa5dOBtEooP/0WUcGyEefXRa+bxYkIrYpuxH0hEE=;
        b=ZZL0S26XODjRWTUGY+HuM353oBwhoSh3yQECIBw5YhshWhsPgmpnAyAjgNpVFUaw/m
         FN4gwig/Ke+V+CWiY9De9x+3LmLB+fFv3gfDUFU/Jo3qBCumEMLwd9Y9eBGtJEB4ZQJV
         bFn3AmmHUbxP8Yy1rFY79x2eWkWG1tb+ZXQWZTvtucCbq9wrBxSuKnTUID43WhQfWItk
         Tfg5TkrDsUgdw0tVOZsLteRr5BXGXkSuWAMUhpGekuir01IdyEYq7grVmareF4Ux8ZXo
         IeiRfKKOa4W1JusTJGAbasBNt9uxqPxppXCS5AGN2VeuO1E7rX9ph4Qk+rb37TZ00btI
         oPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695689889; x=1696294689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXGIa5dOBtEooP/0WUcGyEefXRa+bxYkIrYpuxH0hEE=;
        b=sbeuRZqr7zaWrPtFY0sP+/sDstlmwJJ1wY4QWsz1OvOcHtw0BARNWPovbTUNWIqRjD
         FLUhvNSCX4f1FW/PcdqrSO4XB3NJlnhZIhqJGw8ldcMiXJJMi/IJaCTJaggi0iH+oQix
         6OcV/bLdgHBh7GA5uVpjWkNoMta0VZ2ffd8QIDIutC7H5h/o8jeAfc7olBqjNz4xQdpF
         IH82lHmPpUOL6Ud51h8YZIpc553xxIZKOj/3+yH/yh9VniK0jnnaiwVQvurDOmE6dlwp
         Av00NEijLXxF1lLwDkqktSXr/OgC73zKTIDvIV/2vdQc+LQTBnQv4sEuOyhKNNdDwvvL
         Smig==
X-Gm-Message-State: AOJu0YwPtEKd/GXKP/YfvupDQknqV3slHse/1G7gF1h2AaRoEJwOWemx
	MqPUjtdRtD3RZeiETYo4ISp2I67+qTA=
X-Google-Smtp-Source: AGHT+IGxC55llYUdHX8NOfmBhKMx6Y4OygBLJDRoCrsg/9j7KeIhD0vxEKW24kSQUSi1hFEmb76H6Q==
X-Received: by 2002:a81:7387:0:b0:592:ffc:c787 with SMTP id o129-20020a817387000000b005920ffcc787mr7978500ywc.30.1695689889205;
        Mon, 25 Sep 2023 17:58:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id u5-20020a817905000000b0059f4f30a32bsm1702043ywc.24.2023.09.25.17.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 17:58:08 -0700 (PDT)
Message-ID: <868a7144-e919-9458-9954-273988b0d43d@gmail.com>
Date: Mon, 25 Sep 2023 17:58:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 08/11] bpf: pass attached BTF to find correct
 type info of struct_ops progs.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-9-thinker.li@gmail.com>
 <fc8405d5-7e8c-5adf-2e66-edd3527d1db6@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <fc8405d5-7e8c-5adf-2e66-edd3527d1db6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 17:24, Martin KaFai Lau wrote:
> On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The type info of a struct_ops type may be in a module.  So, we need to 
>> know
>> which module BTF to look for type information.  The later patches will 
>> make
>> libbpf to attach module BTFs to programs. This patch passes attached BTF
>> from syscall to bpf_struct_ops subsystem to make sure attached BTF is
>> available when the bpf_struct_ops subsystem is ready to use it.
>>
>> bpf_prog has attach_btf in aux from attach_btf_obj_fd, that is pass along
>> with the bpf_attr loading the program. attach_btf is used to find the btf
>> type of attach_btf_id. attach_btf_id is used to identify the traced
>> function for a trace program.  For struct_ops programs, it is used to
>> identify the struct_ops type of the struct_ops object a program attached
>> to.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/bpf_struct_ops.c    | 12 +++++++++++-
>>   kernel/bpf/syscall.c           |  2 +-
>>   kernel/bpf/verifier.c          |  4 +++-
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   5 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 73b155e52204..178d6fa45fa0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1390,6 +1390,10 @@ union bpf_attr {
>>            * to using 5 hash functions).
>>            */
>>           __u64    map_extra;
>> +
>> +        __u32   mod_btf_fd;    /* fd pointing to a BTF type data
>> +                     * for btf_vmlinux_value_type_id.
>> +                     */
>>       };
>>       struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 8b5c859377e9..d5600d9ad302 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -765,9 +765,19 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       struct bpf_struct_ops_map *st_map;
>>       const struct btf_type *t, *vt;
>>       struct bpf_map *map;
>> +    struct btf *btf;
>>       int ret;
>> -    st_ops = 
>> bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
>> +    /* XXX: We need a module name or ID to find a BTF type. */
>> +    /* XXX: should use btf from attr->btf_fd */
>> +    if (attr->mod_btf_fd) {
>> +        btf = btf_get_by_fd(attr->mod_btf_fd);
> 
> The btf is leaked in all cases because it is not stored (and owned) in 
> st_map during map_alloc. This circle back to the earlier comment in 
> patch 4 about where btf is stored.

This has been fixed locally. Basically, map will hold the module instead
of btf.


> 
>> +        if (IS_ERR(btf))
>> +            return ERR_PTR(PTR_ERR(btf));
>> +    } else {
>> +        btf = btf_vmlinux;
>> +    }
>> +    st_ops = 
>> bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf);
>>       if (!st_ops)
>>           return ERR_PTR(-ENOTSUPP);
> 


Return-Path: <bpf+bounces-13752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E116D7DD718
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF82814AE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491620B3A;
	Tue, 31 Oct 2023 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrbYMnAB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E614225BA
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:32:00 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5620F3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:31:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7eef0b931so59398037b3.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698784318; x=1699389118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTQ2AbsugCXa0DLkel1CVDc3YSJ7bj7LdUGxdAINbIc=;
        b=lrbYMnABOwjCgmCf80cLTuDXmXVMYFEsdxblTGC14NYAymCNiLEyRu3/x4svRAyqJa
         dJjUOWnsyZ6rC0h/4dMWBjtcUPWkKtq1yuT9ese2fQnANjRpEQtBXi8TfvUbE6GtTtRR
         m2JU+4lxH4Y4/SQzUiE5Jbw1jzHYWPhemiIQVm3FL2sZ+56BsI3uKQYLfyUmZ8IeM9SR
         EfrVjCw5HANQo2Nv+KLAzDaGSOoBHtTI+5b+yZZjupE4mNMZpUHGuXevZjVM1MjWwQUo
         Se2FoP/i8W7P9t1724WclQPvtLRFJvaubxrOnDzJenPHI3A2ubL4Eu2n2m+TdBbfgCcR
         3ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698784318; x=1699389118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTQ2AbsugCXa0DLkel1CVDc3YSJ7bj7LdUGxdAINbIc=;
        b=vWqDHRzhN9hkxw4tKflO2lf73EPEL0KqbzWGqK4fjmX0RzMxG3kssFIn9HabTAENrN
         RW7Lt0BCmktJ+zNTFu08WS6XbAAIX3uPfO65b9GYxT8dcr0KkC5IEPVQK9uwcikIcd4X
         fgA+j/tGVJfN6mMPqIoAV4a9yw1EG1wgnEu19aHBSw+q3MrnbJDXyP1BUOgSR2FBI7IJ
         L4IWvhK/2zw2DAUzXLiTakeBXYRY3vGO+AAAvlUamRToqlzgBdp1WJF6bPbwUShzcFWc
         jGoRESET0p0N6Eds1TxNj9VRsVdZ+sA67gUW+b0kktx3pVQV4eFjLg4IR8H3iJ57s4f0
         vC6Q==
X-Gm-Message-State: AOJu0YzANRWHiiVm47HuxOSxdUXWSopZnvMU1ZC6xWuSeYJ5FAxY6fVj
	GnrpAKj09Aq0NtqFt8m1shc=
X-Google-Smtp-Source: AGHT+IFqyLlYwWplZddI6F/AGOR+UsLvVMPibz0HWBEbNV1u64FZhGRvI4nusSSl2lKZFaeftYYOcA==
X-Received: by 2002:a05:690c:dc6:b0:5a8:dd5f:dbf with SMTP id db6-20020a05690c0dc600b005a8dd5f0dbfmr17778674ywb.34.1698784318031;
        Tue, 31 Oct 2023 13:31:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id i127-20020a816d85000000b005a7fbac4ff0sm1290611ywc.110.2023.10.31.13.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 13:31:57 -0700 (PDT)
Message-ID: <33f97d63-2680-48b9-af2c-6b2948c95f43@gmail.com>
Date: Tue, 31 Oct 2023 13:31:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 06/10] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-7-thinker.li@gmail.com>
 <ff0e6978-adb5-db47-5968-5af4924aadba@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ff0e6978-adb5-db47-5968-5af4924aadba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/23 18:53, Martin KaFai Lau wrote:
> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Giving a BTF, the bpf_struct_ops knows the right place to look up type 
>> info
>> associated with a type ID. This enables a user space program to load a
>> struct_ops object linked to a struct_ops type defined by a module, by
>> providing the module BTF (fd).
> 
> This describes about the struct_ops map creation change (by adding 
> value_type_btf_obj_fd)? It could be described more clearly in the commit 
> message, like specify the value_type_btf_obj_fd addition and how it is 
> used in the struct_ops map creation.


I will rephrase this part as the following words.

Every kernel module has its BTF, comprising information on types defined
in the module. The BTF fd (attr->value_type_btf_obj_fd) passed from
userspace helps the bpf_struct_ops to lookup type information and
description of the struct_ops type, which is necessary for parsing the
layout of map element values and registering maps. The descriptions are
looked up by matching a type id (attr->btf_vmlinux_value_type_id)
against bpf_struct_ops_desc(s) defined in a BTF. If a struct_ops type
is defined in a module, the bpf_struct_ops needs to know the module BTF
to lookup the bpf_struct_ops_desc.

> 
>>
>> The bpf_prog includes attach_btf in aux which is passed along with the
>> bpf_attr when loading the program. The purpose of attach_btf is to
>> determine the btf type of attach_btf_id. The attach_btf_id is then 
>> used to
>> identify the traced function for a trace program. In the case of 
>> struct_ops
>> programs, it is used to identify the struct_ops type of the struct_ops
>> object that a program is attached to.
> 
> Does attach_btf_obj_fd also work?

aux->attach_btf is from attach_btf_obj_fd, being set by bpf_prog_load().
I will rephrase it to make it clear.

   The bpf_prog includes attach_btf in aux which is passed along with the
   bpf_attr (attr->attach_btf_obj_fd) when loading the program.

> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 256516aba632..db2bbba50e38 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -694,6 +694,7 @@ static void __bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>       }
>>       bpf_map_area_free(st_map->uvalue);
>> +    btf_put(st_map->st_ops_desc->btf);
>>       bpf_map_area_free(st_map);
>>   }
>> @@ -735,16 +736,31 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       const struct btf_type *t, *vt;
>>       struct module *mod = NULL;
>>       struct bpf_map *map;
>> +    struct btf *btf;
>>       int ret;
>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>> attr->btf_vmlinux_value_type_id);
>> -    if (!st_ops_desc)
>> -        return ERR_PTR(-ENOTSUPP);
>> +    if (attr->value_type_btf_obj_fd) {
>> +        /* The map holds btf for its whole life time. */
> 
> It took me a while to parse this comment and connect it with the 
> btf_put(st_map->st_ops_desc->btf) in the __bpf_struct_ops_map_free() above.
> 
> It is now like "btf" owns "struct_ops_desc" which also stores a pointer 
> pointing back to itself, like "btf->struct_ops_desc->btf". The 
> struct_ops_desc->btf was not initialized by st_map but st_map will 
> increment its refcount much later.
> 
> Can btf be directly stored in the st_map->btf instead and map_alloc 
> holds the refcnt of st_map->btf and btf_put(st_map->btf) in map_free?

This topic has been discussed several times.
I will add a pointer to btf in st_map to make
people happy :)

> 
> 
>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>> +        if (IS_ERR(btf))
>> +            return ERR_PTR(PTR_ERR(btf));
>> +
>> +        if (btf != btf_vmlinux) {
>> +            mod = btf_try_get_module(btf);
>> +            if (!mod) {
>> +                ret = -EINVAL;
>> +                goto errout;
>> +            }
>> +        }
>> +    } else {
>> +        btf = btf_vmlinux;
>> +        btf_get(btf);
>> +    }
>> -    if (st_ops_desc->btf != btf_vmlinux) {
>> -        mod = btf_try_get_module(st_ops_desc->btf);
>> -        if (!mod)
>> -            return ERR_PTR(-EINVAL);
>> +    st_ops_desc = bpf_struct_ops_find_value(btf, 
>> attr->btf_vmlinux_value_type_id);
>> +    if (!st_ops_desc) {
>> +        ret = -ENOTSUPP;
>> +        goto errout;
>>       }
>>       vt = st_ops_desc->value_type;
> 


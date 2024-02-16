Return-Path: <bpf+bounces-22126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39928573CF
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808CC286CBC
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FE3D27A;
	Fri, 16 Feb 2024 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgB5O6ga"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3172DF4E
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708050929; cv=none; b=i/um7NkOYq6DERLInmKTQbWN6K09f3T0x0eSlVGVDxib8cVJOcsqPgGTi8CZP/Ip4/1n6qhKOEFIM8FTasIDY6ssmk1Qyt398K1z6xzFSy8chQX3qd1TFGd0QVm/iZexFI7lhU5Q/4rLJU3wjzQkGKS0SJt8PaiYY1jlXPBWKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708050929; c=relaxed/simple;
	bh=iHgsYfhBshAqnQABsECOCOvYb9RPTrsruFTAuiwjdHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4UJ9Mvi4+8UAG663yNxOarh7GOiaHJuvsJFT6PA/IrdTVyd0LXI8FFAENOng/K566vTYGo+cbEN+Fi7xP8Ez2aiqAL+YzE8pBrL/1pSQyhUWArhqFkLgUm7Wf9IVSzeheQ7risHy3S2gidnEN6i4wq1NmtGNJbibqLY/v0PMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgB5O6ga; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607eefeea90so6194797b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708050927; x=1708655727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXZ4oVZq7JZhPsk2+MJiO3C+7WVH79XkCzhYfJQw00w=;
        b=cgB5O6gasQ11uGieBnMvaUDvsJaEbXdHx5fUKt00FQ8+WpNN2jZI4kuw+tBsNj4ynV
         qAWm8JvXIZpr/qgRPSzLSWkDOIvknE34L5bXkrIpsJFKT2t9S81Nsr4ACnWLR6Y07OyD
         8foJMCkTQvdPgv7Z+qKI9+mXb0x8Tz1fpEr+VexspyV2/mxCy/Uv3sAXcny7MuyRciBQ
         q0PDdigghkzajpwMrH4fnqN2DOKm76oMSuo+Pa8OHLB4kanMNJulyh9TKZyiplm1TEGc
         XDPZHrjkAwpqnPiMrW7V4Qs2iT1vI43qbuvGdn2TMsXQyb9SU8T3wqT7k13Z3xHb35gT
         goXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708050927; x=1708655727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXZ4oVZq7JZhPsk2+MJiO3C+7WVH79XkCzhYfJQw00w=;
        b=OIHHSThRMCu3jjr14B4S9HMfmzwgl1JPFivBas9D7NTIu0xUGzu0bsO8Bb6w37wmC/
         ccDTSueLuZrfqL1msYwrru2tfm6thUYlTqzVTxNCl0n2Pmm4B+Gzsg06J+3bZ7Shai+A
         BEp0ehhPioYppPd90v4apZRpenquM8nLC5OKOZVLxrAqP89d+Wjq4O5q/nw6ELrvdS1t
         1ZlZztW//j9XKl9MuPKf3v6vzttjM33EXJ2UVSY0PcMgBdvc/sdwraOSimrukTJ6DsPa
         8ciepJR25x9Z03ajP00HG6nsJ+nHOpc1eY1EsxlK1kFf0VENvocg9LfIvzH/hJvxrQKW
         v+Zg==
X-Gm-Message-State: AOJu0Yy1R18zLPSkftgkSx6THDvnoG1pJKzcWB/E+B2FB5I+ll01s/wn
	JnyKaBgBqf64AkqsmUN4RlBCuKAkYfdCjIl/K0P4dj9I4ghK+YAm
X-Google-Smtp-Source: AGHT+IGZMH5/NgBIYnF3Ad7V17U6mM/oezT/QeeY7zS/8pmWgJAJ4DKlndLfPLz+H9cUB4Xfosfyog==
X-Received: by 2002:a81:a0ce:0:b0:607:d4fe:a9d9 with SMTP id x197-20020a81a0ce000000b00607d4fea9d9mr2433504ywg.3.1708050926615;
        Thu, 15 Feb 2024 18:35:26 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77? ([2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77])
        by smtp.gmail.com with ESMTPSA id v11-20020a81a54b000000b00604198c3cafsm153313ywg.61.2024.02.15.18.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 18:35:26 -0800 (PST)
Message-ID: <da6aeb49-3d01-4729-8f01-8770ba69019f@gmail.com>
Date: Thu, 15 Feb 2024 18:35:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v2 1/3] libbpf: Create a shadow copy for each
 struct_ops map if necessary.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240214020836.1845354-1-thinker.li@gmail.com>
 <20240214020836.1845354-2-thinker.li@gmail.com>
 <CAEf4BzZBP=aV4j38+hqVgXoKa+DAZu5F-yeDVge+sLi5OBuRGw@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZBP=aV4j38+hqVgXoKa+DAZu5F-yeDVge+sLi5OBuRGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/15/24 15:55, Andrii Nakryiko wrote:
> On Tue, Feb 13, 2024 at 6:08 PM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> If the user has passed a shadow info for a struct_ops map along with struct
>> bpf_object_open_opts, a shadow copy will be created for the map and
>> returned from bpf_map__initial_value().
>>
>> The user can read and write shadow variables through the shadow copy, which
>> is placed in the struct pointed by skel->struct_ops.FOO, where FOO is the
>> map name.
>>
>> The value of a shadow variable will be used to update the value of the map
>> when loading the map to the kernel.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c          | 195 ++++++++++++++++++++++++++++++--
>>   tools/lib/bpf/libbpf.h          |  34 +++++-
>>   tools/lib/bpf/libbpf.map        |   1 +
>>   tools/lib/bpf/libbpf_internal.h |   1 +
>>   4 files changed, 220 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 01f407591a92..ce9c4cdb2dc5 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -487,6 +487,14 @@ struct bpf_struct_ops {
>>           * from "data".
>>           */
>>          void *kern_vdata;
>> +       /* Description of the layout that a shadow copy should look like.
>> +        */
>> +       const struct bpf_struct_ops_map_info *shadow_info;
>> +       /* A shadow copy of the struct_ops data created according to the
>> +        * layout described by shadow_info.
>> +        */
>> +       void *shadow_data;
>> +       __u32 shadow_data_size;
> 
> what I mentioned on cover letter, just a few lines above, before
> kern_vdata we have just `void *data` which initially contains whatever
> was set in ELF. Just expose that through bpf_map__initial_value() and
> teach bpftool to generate section with variables for that memory and
> that should be all we need, no?

I am not sure if read your question correctly.
Padding & alignments can vary in different platforms. BPF and
user space programs are supposed to be in different platforms.
So, I can not expect that the same struct has the same layout in
BPF/x86/and ARM, right?

> 
>>          __u32 type_id;
>>   };
>>
>> @@ -1027,7 +1035,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>>          struct module_btf *mod_btf;
>>          void *data, *kern_data;
>>          const char *tname;
>> -       int err;
>> +       int err, j;
>>
>>          st_ops = map->st_ops;
>>          type = st_ops->type;
> 
> [...]
> 
>>   void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
>>   {
>> +       if (bpf_map__is_struct_ops(map)) {
>> +               if (psize)
>> +                       *psize = map->st_ops->shadow_data_size;
>> +               return map->st_ops->shadow_data;
>> +       }
>> +
>>          if (!map->mmaped)
>>                  return NULL;
>>          *psize = map->def.value_size;
>> @@ -13462,3 +13632,8 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>>          free(s->progs);
>>          free(s);
>>   }
>> +
>> +__u32 bpf_map__struct_ops_type(const struct bpf_map *map)
>> +{
>> +       return map->st_ops->type_id;
>> +}
> 
> we can expose this st_ops->type_id as map->def.value_type_id so that
> existing bpf_map__btf_value_type_id() API can be used, no need to add
> more struct_ops-specific APIs

OK!

> 
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 5723cbbfcc41..b435cafefe7a 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -109,6 +109,27 @@ LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
>>   /* Hide internal to user */
>>   struct bpf_object;
>>
>> +/* Description of a member in the struct_ops type for a map. */
>> +struct bpf_struct_ops_member_info {
>> +       const char *name;
>> +       __u32 offset;
>> +       __u32 size;
>> +};
>> +
>> +/* Description of the layout of a shadow copy for a struct_ops map. */
>> +struct bpf_struct_ops_map_info {
>> +       /* The name of the struct_ops map */
>> +       const char *name;
>> +       const struct bpf_struct_ops_member_info *members;
>> +       __u32 cnt;
>> +       __u32 data_size;
>> +};
>> +
>> +struct bpf_struct_ops_shadow_info {
>> +       const struct bpf_struct_ops_map_info *maps;
>> +       __u32 cnt;
>> +};
>> +
>>   struct bpf_object_open_opts {
>>          /* size of this struct, for forward/backward compatibility */
>>          size_t sz;
>> @@ -197,9 +218,18 @@ struct bpf_object_open_opts {
>>           */
>>          const char *bpf_token_path;
>>
>> +       /* A list of shadow info for every struct_ops map.  A shadow info
>> +        * provides the information used by libbpf to map the offsets of
>> +        * struct members of a struct_ops type from BTF to the offsets of
>> +        * the corresponding members in the shadow copy in the user
>> +        * space. It ensures that the shadow copy provided by the libbpf
>> +        * can be accessed by the user space program correctly.
>> +        */
>> +       const struct bpf_struct_ops_shadow_info *struct_ops_shadow;
>> +
> 
> I still don't follow. bpftool will generate memory-layout compatible
> structure for user-space, they can just work directly with that
> memory. We shouldn't need all this extra info structs.
> 
> Libbpf can just check that fields that are supposed to be BPF prog
> references are correct `struct bpf_program *` pointers.

Check the explanation above.

> 
>>          size_t :0;
>>   };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field struct_ops_shadow
>>
>>   /**
>>    * @brief **bpf_object__open()** creates a bpf_object by opening
>> @@ -839,6 +869,8 @@ struct bpf_map;
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
>>   LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
>>
>> +LIBBPF_API __u32 bpf_map__struct_ops_type(const struct bpf_map *map);
>> +
>>   struct bpf_iter_attach_opts {
>>          size_t sz; /* size of this struct for forward/backward compatibility */
>>          union bpf_iter_link_info *link_info;
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 86804fd90dd1..e0efc85114df 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -413,4 +413,5 @@ LIBBPF_1.4.0 {
>>                  bpf_token_create;
>>                  btf__new_split;
>>                  btf_ext__raw_data;
>> +               bpf_map__struct_ops_type;
>>   } LIBBPF_1.3.0;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index ad936ac5e639..aec6d57fe5d1 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -234,6 +234,7 @@ struct btf_type;
>>   struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
>>   const char *btf_kind_str(const struct btf_type *t);
>>   const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
>> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
>>
>>   static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
>>   {
>> --
>> 2.34.1
>>


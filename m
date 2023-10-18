Return-Path: <bpf+bounces-12496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700977CD240
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 04:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9290F1C20902
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 02:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED146AE;
	Wed, 18 Oct 2023 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le2IZZ+v"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52794696
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 02:25:44 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33202FC
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 19:25:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a87ac9d245so35339247b3.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 19:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697595939; x=1698200739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7prIbaqd3exPN6qydcxIQcP7exTwdUtcMjgVFRHTr4=;
        b=Le2IZZ+vQSdB2Y8vG1DGbZBaz799YhdCjLIGIYu3ZnHEUie1w2Ofil2nsZDCIMp/g6
         hvNkPzGP3PljMB3eBlKONOzV0GNIsisDVjDs54v+iEd3jKameMdlEuV0saBVFQ0y/EOb
         6pj/kjzKHykEGpT50QpscQkT86VMOk/VSaI9o/oA94W+JcNMPEYmajp0f2zBLH4Yec8v
         AbIS97wCLCf/vRbTaqAliInWJL3J/pGuBHgAyDUp+7zZ6L5EbYQJi30p61hoEV+j5gTr
         xNVZeZK3fYeXrFOc93srHf1JXsgc1iwiuGVgUhf2/WpBZ403WbLJ+d8llkcE5ZPzboWm
         wzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697595939; x=1698200739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7prIbaqd3exPN6qydcxIQcP7exTwdUtcMjgVFRHTr4=;
        b=PW126V7dBwaeKj/3CiVK9fuD4zci7OuPSR82s6m9z2ibIWBOT440tIXfWkxh/1MdFs
         9ubGm/FX3U+3vHKBbWEv6zWg3DaEX8eapF4Q+eg1PI4KH0bMFDncKl063x9wBdPxNHFh
         RyHO1Vc0XiGzkAQGWCVBjS6wO0W6uz64Bo9L4kil0bRFu0l0pHVuRbPO9DvHHHWiMAKV
         oATALuffjtSQHDb/huM/e575Y7AksaRRn9Kd3R4PwEbPC2nMeRu6w/fk8x3E60u9911Q
         B74O1nTvDV+J8r9jDm7kjv/POtuyLAHUZUVY0WwlEuIS+CZNC+hHdZB5cZJAo1V4+UtT
         Q2aQ==
X-Gm-Message-State: AOJu0Yxj7ZiifoTaciNpea1zwL5i2zj1xF3i6/uvNOsOQDTabjhkTd9T
	Z3aHjcL8m8NFYoOfwcDsz5I=
X-Google-Smtp-Source: AGHT+IEqVUAo/YTqhlL98DVil/aKWJZ1aHaOwGf2h7GfScHwoRnacwUDi+OgbZpmpqJed7n92U4pwg==
X-Received: by 2002:a0d:ef04:0:b0:59b:c0a8:2882 with SMTP id y4-20020a0def04000000b0059bc0a82882mr4258199ywe.46.1697595939344;
        Tue, 17 Oct 2023 19:25:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:7566:72a0:e053:66fd? ([2600:1700:6cf8:1240:7566:72a0:e053:66fd])
        by smtp.gmail.com with ESMTPSA id k68-20020a0dc847000000b005a7d46770f2sm1116728ywd.83.2023.10.17.19.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 19:25:38 -0700 (PDT)
Message-ID: <4fabd00b-3b72-49cb-a00d-6507a74dff72@gmail.com>
Date: Tue, 17 Oct 2023 19:25:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] libbpf: Find correct module BTFs for
 struct_ops maps and progs.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, drosen@google.com,
 kuifeng@meta.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-8-thinker.li@gmail.com>
 <CAEf4BzY9jYfK4Z7bAhmX458mZcGi+SLgGe4VK3WQYz2toOgdOA@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzY9jYfK4Z7bAhmX458mZcGi+SLgGe4VK3WQYz2toOgdOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/17/23 14:49, Andrii Nakryiko wrote:
> On Tue, Oct 17, 2023 at 9:23 AM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Locate the module BTFs for struct_ops maps and progs and pass them to the
>> kernel. This ensures that the kernel correctly resolves type IDs from the
>> appropriate module BTFs.
>>
>> For the map of a struct_ops object, mod_btf is added to bpf_map to keep a
>> reference to the module BTF. The FD of the module BTF is passed to the
>> kernel as mod_btf_fd when the struct_ops object is loaded.
>>
>> For a bpf_struct_ops prog, attach_btf_obj_fd of bpf_prog is the FD of a
>> module BTF in the kernel.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/bpf.c    |  4 ++-
>>   tools/lib/bpf/bpf.h    |  5 +++-
>>   tools/lib/bpf/libbpf.c | 68 +++++++++++++++++++++++++++---------------
>>   3 files changed, 51 insertions(+), 26 deletions(-)
>>
> 
> I have a few nits, please accommodate them, and with that please add
> my ack on libbpf side of things
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>


Thanks for reviewing!

> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index b0f1913763a3..af46488e4ea9 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -169,7 +169,8 @@ int bpf_map_create(enum bpf_map_type map_type,
>>                     __u32 max_entries,
>>                     const struct bpf_map_create_opts *opts)
>>   {
>> -       const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
>> +       const size_t attr_sz = offsetofend(union bpf_attr,
>> +                                          value_type_btf_obj_fd);
>>          union bpf_attr attr;
>>          int fd;
>>
>> @@ -191,6 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>>          attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
>>          attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
>>          attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
>> +       attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, 0);
>>
>>          attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
>>          attr.map_flags = OPTS_GET(opts, map_flags, 0);
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 74c2887cfd24..1733cdc21241 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -51,8 +51,11 @@ struct bpf_map_create_opts {
>>
>>          __u32 numa_node;
>>          __u32 map_ifindex;
>> +
>> +       __u32 value_type_btf_obj_fd;
>> +       size_t:0;
>>   };
>> -#define bpf_map_create_opts__last_field map_ifindex
>> +#define bpf_map_create_opts__last_field value_type_btf_obj_fd
>>
>>   LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>>                                const char *map_name,
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 3a6108e3238b..d8a60fb52f5c 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -519,6 +519,7 @@ struct bpf_map {
>>          struct bpf_map_def def;
>>          __u32 numa_node;
>>          __u32 btf_var_idx;
>> +       int mod_btf_fd;
>>          __u32 btf_key_type_id;
>>          __u32 btf_value_type_id;
>>          __u32 btf_vmlinux_value_type_id;
>> @@ -893,6 +894,8 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>>          return 0;
>>   }
>>
>> +static int load_module_btfs(struct bpf_object *obj);
>> +
> 
> you don't need this forward declaration, do you?


I will remove it.

> 
>>   static const struct btf_member *
>>   find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>>   {
>> @@ -922,22 +925,29 @@ find_member_by_name(const struct btf *btf, const struct btf_type *t,
>>          return NULL;
>>   }
>>
> 
> [...]
> 
>>          if (obj->btf && btf__fd(obj->btf) >= 0) {
>>                  create_attr.btf_fd = btf__fd(obj->btf);
>> @@ -7700,9 +7718,9 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>>          return libbpf_kallsyms_parse(kallsyms_cb, obj);
>>   }
>>
>> -static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
>> -                           __u16 kind, struct btf **res_btf,
>> -                           struct module_btf **res_mod_btf)
>> +static int find_module_btf_id(struct bpf_object *obj, const char *kern_name,
>> +                             __u16 kind, struct btf **res_btf,
>> +                             struct module_btf **res_mod_btf)
> 
> I actually find "find_module" terminology confusing, because it might
> not be in the module after all, right? I think "find_ksym_btf_id" is a
> totally appropriate name, and it's just that in some cases that kernel
> symbol (ksym) will be found in the kernel module instead of in vmlinux
> image itself. Still, it's a kernel. Let's keep the name?

Agree!

> 
>>   {
>>          struct module_btf *mod_btf;
>>          struct btf *btf;
> 
> [...]


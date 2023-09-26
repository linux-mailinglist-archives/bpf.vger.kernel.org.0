Return-Path: <bpf+bounces-10824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589647AE2CF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0817EB20AAA
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FA627;
	Tue, 26 Sep 2023 00:12:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73F367
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:12:28 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A79211D
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:12:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59f6041395dso54543197b3.1
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695687145; x=1696291945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EN9cBPgDYfHcOI32nghcN5Mb5C9kBDsdZ+6spvBzBeM=;
        b=JzYvFdypz3eH5tdWyiZIZT7QzQ6FP4Y7tHHTd8fnfZcS3V2bWQLosno5Ho9JHFLc4u
         iU7pSSDqGCGyqztGlcVHVIZg/EUcIaqtO/bOCiwtecwt8U16SvvKkgEvXcn3xT4Fux5Q
         Mr40y7WPwBGZCVd0vZt4UpJ89rKstnBHsmr/HoMPv6lnwhaBglBz2O061gEEkyvoLi9M
         yPmClYmrpSRHoJaglDCgWCDFxpb0Jxxy4GCRB26MySUz7pER6DXsasu6Q3eCRroI5njC
         wU2Lc1NIR+s4wAp7DRQ62n7KVf/oyXOlsSh6nSjdPYhyUkBLvZGUi+0ngMeZ27g5WN/Y
         BLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695687145; x=1696291945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EN9cBPgDYfHcOI32nghcN5Mb5C9kBDsdZ+6spvBzBeM=;
        b=RUqHP1cv3n5wM8+UMDwTTSWUUA5nygsNSnKlB9gBS5kqZM9dA7tZ1XjClIy/V2udGv
         jGsQJYy12IIkYcPeyVjuBuzCMtGLrF2wUGXpajbPfeb5Y4vx9BcfDFdpdUJd0lBZTdv+
         mpPrhLM1XmEKfzjh7v2Feg98ffnAJVC6Bc3qPy0sGV17MYDOZL07mt5PC2A6RrvQyiWU
         Cz9pfkE8Rk1PkfRPJW3qJZghztfYy9KnkKfMkuUh7nA7N+eLE0xWAgAfjreS3vjkatsw
         NXY0byH4nuLlNo3H5KU6THY1h08GkoyFRgqJaalumEATFO+pXbRTmC0q4kM1KJYcj2t4
         weUg==
X-Gm-Message-State: AOJu0Yx5MqQ1zEtooWvQ5rK4wUzQpwoRGU9iCi7ALuad7wJikbGmNfJc
	2XPjMVpyC+W9n56pzJslm/TzRGgKtio=
X-Google-Smtp-Source: AGHT+IEk9gUfYFPcAYI3WSd/iKMg3/NqmUV9B2Ibqh9awYVArYM7K2+7TNIWilOoHzoOdxcGNSgHMw==
X-Received: by 2002:a81:4428:0:b0:59f:9c08:8f12 with SMTP id r40-20020a814428000000b0059f9c088f12mr3633976ywa.38.1695687145334;
        Mon, 25 Sep 2023 17:12:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id eh15-20020a05690c298f00b005773afca47bsm929227ywb.27.2023.09.25.17.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 17:12:24 -0700 (PDT)
Message-ID: <8d933fc9-20ae-18c3-8833-1018f3c6377e@gmail.com>
Date: Mon, 25 Sep 2023 17:12:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 09/11] libbpf: Find correct module BTFs for
 struct_ops maps and progs.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-10-thinker.li@gmail.com>
 <CAEf4BzZWXR9SFL_hrZMYynBC6ukH=n4Bp_S9FhJ4-hH34zTADg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZWXR9SFL_hrZMYynBC6ukH=n4Bp_S9FhJ4-hH34zTADg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 16:09, Andrii Nakryiko wrote:
> On Wed, Sep 20, 2023 at 9:00 AM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Find module BTFs for struct_ops maps and progs and pass them to the kernel.
>> It ensures the kernel resolve type IDs from correct module BTFs.
>>
>> For the map of a struct_ops object, mod_btf is added to bpf_map to keep a
>> reference to the module BTF. It's FD is passed to the kernel as mod_btf_fd
>> when it is created.
>>
>> For a prog attaching to a struct_ops object, attach_btf_obj_fd of bpf_prog
>> is the FD pointing to a module BTF in the kernel.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/bpf.c    |   3 +-
>>   tools/lib/bpf/bpf.h    |   4 +-
>>   tools/lib/bpf/libbpf.c | 121 ++++++++++++++++++++++++-----------------
>>   3 files changed, 75 insertions(+), 53 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index b0f1913763a3..df4b7570ad92 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>>                     __u32 max_entries,
>>                     const struct bpf_map_create_opts *opts)
>>   {
>> -       const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
>> +       const size_t attr_sz = offsetofend(union bpf_attr, mod_btf_fd);
>>          union bpf_attr attr;
>>          int fd;
>>
>> @@ -191,6 +191,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>>          attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
>>          attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
>>          attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
>> +       attr.mod_btf_fd = OPTS_GET(opts, mod_btf_fd, 0);
>>
>>          attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
>>          attr.map_flags = OPTS_GET(opts, map_flags, 0);
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 74c2887cfd24..d18f75b0ccc9 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -51,8 +51,10 @@ struct bpf_map_create_opts {
>>
>>          __u32 numa_node;
>>          __u32 map_ifindex;
>> +
>> +       __u32 mod_btf_fd;
> 
> please add `size_t :0;` at the end to avoid compiler leaving garbage
> in added padding at the end of opts struct

Ok!

> 
>>   };
>> -#define bpf_map_create_opts__last_field map_ifindex
>> +#define bpf_map_create_opts__last_field mod_btf_fd
>>
>>   LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>>                                const char *map_name,
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 3a6108e3238b..df6ba5494adb 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -519,6 +519,7 @@ struct bpf_map {
>>          struct bpf_map_def def;
>>          __u32 numa_node;
>>          __u32 btf_var_idx;
>> +       struct module_btf *mod_btf;
> 
> It would be simpler to just store btf_fd instead of entire struct
> module_btf pointer. You only need this to set btf_obj_fd on map
> creation and program loading, right?

Yes!

> 
>>          __u32 btf_key_type_id;
>>          __u32 btf_value_type_id;
>>          __u32 btf_vmlinux_value_type_id;
>> @@ -893,6 +894,42 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>>          return 0;
>>   }
>>
>> +static int load_module_btfs(struct bpf_object *obj);
>> +
>> +static int find_kern_btf_id(struct bpf_object *obj, const char *kern_name,
>> +                           __u16 kind, struct btf **res_btf,
>> +                           struct module_btf **res_mod_btf)
>> +{
>> +       struct module_btf *mod_btf;
>> +       struct btf *btf;
>> +       int i, id, err;
>> +
>> +       btf = obj->btf_vmlinux;
>> +       mod_btf = NULL;
>> +       id = btf__find_by_name_kind(btf, kern_name, kind);
>> +
>> +       if (id == -ENOENT) {
>> +               err = load_module_btfs(obj);
>> +               if (err)
>> +                       return err;
>> +
>> +               for (i = 0; i < obj->btf_module_cnt; i++) {
>> +                       /* we assume module_btf's BTF FD is always >0 */
>> +                       mod_btf = &obj->btf_modules[i];
>> +                       btf = mod_btf->btf;
>> +                       id = btf__find_by_name_kind_own(btf, kern_name, kind);
>> +                       if (id != -ENOENT)
>> +                               break;
>> +               }
>> +       }
>> +       if (id <= 0)
>> +               return -ESRCH;
>> +
>> +       *res_btf = btf;
>> +       *res_mod_btf = mod_btf;
>> +       return id;
>> +}
>> +
> 
> there is no need to move the entire function body here, just add a
> forward declaration. It will also make it easier to see what actually
> changed about the function (if at all)

Got it

> 
>>   static const struct btf_member *
>>   find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>>   {
>> @@ -927,17 +964,23 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
>>                                     const char *name, __u32 kind);
>>
>>   static int
>> -find_struct_ops_kern_types(const struct btf *btf, const char *tname,
>> +find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
>> +                          struct module_btf **mod_btf,
>>                             const struct btf_type **type, __u32 *type_id,
>>                             const struct btf_type **vtype, __u32 *vtype_id,
>>                             const struct btf_member **data_member)
>>   {
>>          const struct btf_type *kern_type, *kern_vtype;
>>          const struct btf_member *kern_data_member;
>> +       struct btf *btf;
>>          __s32 kern_vtype_id, kern_type_id;
>>          __u32 i;
>>
>> -       kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
>> +       /* XXX: should search module BTFs as well. We need module name here
>> +        * to locate a correct BTF type.
>> +        */
> 
> aren't we searching module BTFs? Is this comment still relevant?
> 
>> +       kern_type_id = find_kern_btf_id(obj, tname, BTF_KIND_STRUCT,
>> +                                       &btf, mod_btf);
>>          if (kern_type_id < 0) {
>>                  pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
>>                          tname);
>> @@ -992,13 +1035,15 @@ static bool bpf_map__is_struct_ops(const struct bpf_map *map)
>>
>>   /* Init the map's fields that depend on kern_btf */
>>   static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
>> -                                        const struct btf *btf,
>> -                                        const struct btf *kern_btf)
>> +                                        struct bpf_object *obj)
> 
> no need to pass obj separately, you can get it through `map->obj`

Good to know!

> 
>>   {
>>          const struct btf_member *member, *kern_member, *kern_data_member;
>>          const struct btf_type *type, *kern_type, *kern_vtype;
>>          __u32 i, kern_type_id, kern_vtype_id, kern_data_off;
>>          struct bpf_struct_ops *st_ops;
>> +       const struct btf *kern_btf;
>> +       struct module_btf *mod_btf;
>> +       const struct btf *btf = obj->btf;
>>          void *data, *kern_data;
>>          const char *tname;
>>          int err;
>> @@ -1006,16 +1051,19 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
>>          st_ops = map->st_ops;
>>          type = st_ops->type;
>>          tname = st_ops->tname;
>> -       err = find_struct_ops_kern_types(kern_btf, tname,
>> +       err = find_struct_ops_kern_types(obj, tname, &mod_btf,
>>                                           &kern_type, &kern_type_id,
>>                                           &kern_vtype, &kern_vtype_id,
>>                                           &kern_data_member);
>>          if (err)
>>                  return err;
>>
>> +       kern_btf = mod_btf ? mod_btf->btf : obj->btf_vmlinux;
>> +
>>          pr_debug("struct_ops init_kern %s: type_id:%u kern_type_id:%u kern_vtype_id:%u\n",
>>                   map->name, st_ops->type_id, kern_type_id, kern_vtype_id);
>>
>> +       map->mod_btf = mod_btf;
>>          map->def.value_size = kern_vtype->size;
>>          map->btf_vmlinux_value_type_id = kern_vtype_id;
>>
>> @@ -1091,6 +1139,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
>>                                  return -ENOTSUP;
>>                          }
>>
>> +                       /* XXX: attach_btf_obj_fd is needed as well */
> 
> seems like all these XXX comments are outdated and the code is already
> doing all that, is that right? If so, please remove them, they are
> confusing

Sure!

> 
>> +                       if (mod_btf)
>> +                               prog->attach_btf_obj_fd = mod_btf->fd;
>>                          prog->attach_btf_id = kern_type_id;
>>                          prog->expected_attach_type = kern_member_idx;
>>
>> @@ -1133,8 +1184,8 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
>>                  if (!bpf_map__is_struct_ops(map))
>>                          continue;
>>
>> -               err = bpf_map__init_kern_struct_ops(map, obj->btf,
>> -                                                   obj->btf_vmlinux);
>> +               /* XXX: should be a module btf if not vmlinux */
>> +               err = bpf_map__init_kern_struct_ops(map, obj);
>>                  if (err)
>>                          return err;
>>          }
> 
> [...]


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA83F6AFDD5
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 05:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCHEXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 23:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHEXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 23:23:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C632505
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 20:23:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p20so16494079plw.13
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678249391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=973BTH9aKc0U4Z5TbawtgXuLlerJ8sLNCZuvMPn2PZ8=;
        b=To8iAxt4wNJHpkc2sMuCBFRfjIjIo9N/+ljW+mVD7lhF3JekUTpqOdZnC77CIWok1T
         aT017PfleeLJADR3JwhA9VpAlvua96NY+Hhlem5kmSPQyT9sXzOcf9i1bSzUY7XRm+/6
         upv5Gh5kZVyYTW9HGcLqulydkvRHuPbHRkT7N31Ddw52WYk0ufc9S/cxLUBLskUWMMFS
         UY5kJQGmWkWo0PCmLIr478dv4tejntNGRI/KKAZhjmNCrQ0FqL9yT6JlMgiAPEXiogN6
         RtB+XmZX2pOwB7cCOaSfMNDZAQ51JpGgE7bIAS8dbbjApVbo7DP5Wn4HdnLKQdFLRy1/
         tf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678249391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=973BTH9aKc0U4Z5TbawtgXuLlerJ8sLNCZuvMPn2PZ8=;
        b=WwJKiZhpwXf8sJgun42DPsI9GhEg9k/+GkxZr00zK2AL0IXRgKQ1jlPXOyYgKKeax1
         LJpSMfYREgg4mQSu3izR8uB2k+Ifqcb5ECtsMFPyaNh6NLY+p/n90jcU7SCH9qHUlXnh
         c1cT2kj34s6Gelb4tpPZ1edfj4z67/5mLHRFRU+0rnsyi3V4HP/aZWNwAlu6Oe6EJR2g
         Ve1CKME9nhLvZightva6oqHfGFs/3plBAOgAhuDTBvMmRuY4eHa+H9Sp6GSKoOPMEqra
         v9KfTizcFrBfmbpiS7QleL+VDHUNwxiSYLHgtoggSi2aPhlLnu0s6I7XIF+5zZMLVKGN
         rWEw==
X-Gm-Message-State: AO0yUKWFI+yE6dwbfjoWhBz7aLQa/jFZ866+yWR9AKGv6LTj4PSpEA4h
        wepIZ4z3VsiPynhG93CPCgg=
X-Google-Smtp-Source: AK7set858AIXRm2Dbby9D44KNAyTn1w7E7aEmQMrx1wtI+GPJO9Pop+7Wt+YWnGAusqJRpuChRQSzQ==
X-Received: by 2002:a17:902:e88e:b0:19a:8636:9e2c with SMTP id w14-20020a170902e88e00b0019a86369e2cmr21576020plg.57.1678249391426;
        Tue, 07 Mar 2023 20:23:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::12b7? ([2620:10d:c090:400::5:e5a9])
        by smtp.gmail.com with ESMTPSA id lg14-20020a170902fb8e00b0019a7f493151sm9112745plb.212.2023.03.07.20.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 20:23:10 -0800 (PST)
Message-ID: <7425b219-4b47-c3f1-844d-61e27d03af03@gmail.com>
Date:   Tue, 7 Mar 2023 20:23:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 8/9] libbpf: Use .struct_ops.link section to
 indicate a struct_ops with a link.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-9-kuifeng@meta.com>
 <CAEf4BzaopfY5azUh4yi=Bx3h7x9W9r=XCA1OeVrTFSK_X3s7UQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzaopfY5azUh4yi=Bx3h7x9W9r=XCA1OeVrTFSK_X3s7UQ@mail.gmail.com>
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



On 3/7/23 17:07, Andrii Nakryiko wrote:
> On Tue, Mar 7, 2023 at 3:33 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Flags a struct_ops is to back a bpf_link by putting it to the
>> ".struct_ops.link" section.  Once it is flagged, the created
>> struct_ops can be used to create a bpf_link or update a bpf_link that
>> has been backed by another struct_ops.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 64 +++++++++++++++++++++++++++++++++---------
>>   1 file changed, 50 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 247de39d136f..d66acd2fdbaa 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -467,6 +467,7 @@ struct bpf_struct_ops {
>>   #define KCONFIG_SEC ".kconfig"
>>   #define KSYMS_SEC ".ksyms"
>>   #define STRUCT_OPS_SEC ".struct_ops"
>> +#define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>>
>>   enum libbpf_map_type {
>>          LIBBPF_MAP_UNSPEC,
>> @@ -596,6 +597,7 @@ struct elf_state {
>>          Elf64_Ehdr *ehdr;
>>          Elf_Data *symbols;
>>          Elf_Data *st_ops_data;
>> +       Elf_Data *st_ops_link_data;
>>          size_t shstrndx; /* section index for section name strings */
>>          size_t strtabidx;
>>          struct elf_sec_desc *secs;
>> @@ -605,6 +607,7 @@ struct elf_state {
>>          int text_shndx;
>>          int symbols_shndx;
>>          int st_ops_shndx;
>> +       int st_ops_link_shndx;
>>   };
>>
>>   struct usdt_manager;
>> @@ -1119,7 +1122,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
>>          return 0;
>>   }
>>
>> -static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>> +static int bpf_object__init_struct_ops_maps_link(struct bpf_object *obj, bool link)
> 
> let's shorten it and not use double underscores, as this is not a
> public bpf_object API, just "init_struct_ops_maps" probably is fine
> 
>>   {
>>          const struct btf_type *type, *datasec;
>>          const struct btf_var_secinfo *vsi;
>> @@ -1127,18 +1130,33 @@ static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>>          const char *tname, *var_name;
>>          __s32 type_id, datasec_id;
>>          const struct btf *btf;
>> +       const char *sec_name;
>>          struct bpf_map *map;
>> -       __u32 i;
>> +       __u32 i, map_flags;
>> +       Elf_Data *data;
>> +       int shndx;
>>
>> -       if (obj->efile.st_ops_shndx == -1)
>> +       if (link) {
>> +               sec_name = STRUCT_OPS_LINK_SEC;
>> +               shndx = obj->efile.st_ops_link_shndx;
>> +               data = obj->efile.st_ops_link_data;
>> +               map_flags = BPF_F_LINK;
>> +       } else {
>> +               sec_name = STRUCT_OPS_SEC;
>> +               shndx = obj->efile.st_ops_shndx;
>> +               data = obj->efile.st_ops_data;
>> +               map_flags = 0;
>> +       }
> 
> let's pass these as function arguments instead
> 
>> +
>> +       if (shndx == -1)
>>                  return 0;
>>
>>          btf = obj->btf;
>> -       datasec_id = btf__find_by_name_kind(btf, STRUCT_OPS_SEC,
>> +       datasec_id = btf__find_by_name_kind(btf, sec_name,
>>                                              BTF_KIND_DATASEC);
>>          if (datasec_id < 0) {
>>                  pr_warn("struct_ops init: DATASEC %s not found\n",
>> -                       STRUCT_OPS_SEC);
>> +                       sec_name);
>>                  return -EINVAL;
>>          }
>>
>> @@ -1151,7 +1169,7 @@ static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>>                  type_id = btf__resolve_type(obj->btf, vsi->type);
>>                  if (type_id < 0) {
>>                          pr_warn("struct_ops init: Cannot resolve var type_id %u in DATASEC %s\n",
>> -                               vsi->type, STRUCT_OPS_SEC);
>> +                               vsi->type, sec_name);
>>                          return -EINVAL;
>>                  }
>>
>> @@ -1170,7 +1188,7 @@ static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>>                  if (IS_ERR(map))
>>                          return PTR_ERR(map);
>>
>> -               map->sec_idx = obj->efile.st_ops_shndx;
>> +               map->sec_idx = shndx;
>>                  map->sec_offset = vsi->offset;
>>                  map->name = strdup(var_name);
>>                  if (!map->name)
>> @@ -1180,6 +1198,7 @@ static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>>                  map->def.key_size = sizeof(int);
>>                  map->def.value_size = type->size;
>>                  map->def.max_entries = 1;
>> +               map->def.map_flags = map_flags;
>>
>>                  map->st_ops = calloc(1, sizeof(*map->st_ops));
>>                  if (!map->st_ops)
>> @@ -1192,14 +1211,14 @@ static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>>                  if (!st_ops->data || !st_ops->progs || !st_ops->kern_func_off)
>>                          return -ENOMEM;
>>
>> -               if (vsi->offset + type->size > obj->efile.st_ops_data->d_size) {
>> +               if (vsi->offset + type->size > data->d_size) {
>>                          pr_warn("struct_ops init: var %s is beyond the end of DATASEC %s\n",
>> -                               var_name, STRUCT_OPS_SEC);
>> +                               var_name, sec_name);
>>                          return -EINVAL;
>>                  }
>>
>>                  memcpy(st_ops->data,
>> -                      obj->efile.st_ops_data->d_buf + vsi->offset,
>> +                      data->d_buf + vsi->offset,
>>                         type->size);
>>                  st_ops->tname = tname;
>>                  st_ops->type = type;
>> @@ -1212,6 +1231,15 @@ static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
>>          return 0;
>>   }
>>
>> +static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
> 
> let's name this bpf_object_init_struct_ops, no double underscores
> 
>> +{
>> +       int err;
>> +
>> +       err = bpf_object__init_struct_ops_maps_link(obj, false);
>> +       err = err ?: bpf_object__init_struct_ops_maps_link(obj, true);
>> +       return err;
>> +}
>> +
>>   static struct bpf_object *bpf_object__new(const char *path,
>>                                            const void *obj_buf,
>>                                            size_t obj_buf_sz,
>> @@ -1248,6 +1276,7 @@ static struct bpf_object *bpf_object__new(const char *path,
>>          obj->efile.obj_buf_sz = obj_buf_sz;
>>          obj->efile.btf_maps_shndx = -1;
>>          obj->efile.st_ops_shndx = -1;
>> +       obj->efile.st_ops_link_shndx = -1;
>>          obj->kconfig_map_idx = -1;
>>
>>          obj->kern_version = get_kernel_version();
>> @@ -1265,6 +1294,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
>>          obj->efile.elf = NULL;
>>          obj->efile.symbols = NULL;
>>          obj->efile.st_ops_data = NULL;
>> +       obj->efile.st_ops_link_data = NULL;
>>
>>          zfree(&obj->efile.secs);
>>          obj->efile.sec_cnt = 0;
>> @@ -2753,12 +2783,13 @@ static bool libbpf_needs_btf(const struct bpf_object *obj)
>>   {
>>          return obj->efile.btf_maps_shndx >= 0 ||
>>                 obj->efile.st_ops_shndx >= 0 ||
>> +              obj->efile.st_ops_link_shndx >= 0 ||
>>                 obj->nr_extern > 0;
>>   }
>>
>>   static bool kernel_needs_btf(const struct bpf_object *obj)
>>   {
>> -       return obj->efile.st_ops_shndx >= 0;
>> +       return obj->efile.st_ops_shndx >= 0 || obj->efile.st_ops_link_shndx >= 0;
>>   }
>>
>>   static int bpf_object__init_btf(struct bpf_object *obj,
>> @@ -3451,6 +3482,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>>                          } else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
>>                                  obj->efile.st_ops_data = data;
>>                                  obj->efile.st_ops_shndx = idx;
>> +                       } else if (strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
>> +                               obj->efile.st_ops_link_data = data;
>> +                               obj->efile.st_ops_link_shndx = idx;
>>                          } else {
>>                                  pr_info("elf: skipping unrecognized data section(%d) %s\n",
>>                                          idx, name);
>> @@ -3465,6 +3499,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>>                          /* Only do relo for section with exec instructions */
>>                          if (!section_have_execinstr(obj, targ_sec_idx) &&
>>                              strcmp(name, ".rel" STRUCT_OPS_SEC) &&
>> +                           strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
>>                              strcmp(name, ".rel" MAPS_ELF_SEC)) {
>>                                  pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
>>                                          idx, name, targ_sec_idx,
>> @@ -6611,7 +6646,7 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
>>                          return -LIBBPF_ERRNO__INTERNAL;
>>                  }
>>
>> -               if (idx == obj->efile.st_ops_shndx)
>> +               if (idx == obj->efile.st_ops_shndx || idx == obj->efile.st_ops_link_shndx)
>>                          err = bpf_object__collect_st_ops_relos(obj, shdr, data);
> 
> this function calls find_struct_ops_map_by_offset() which assumes we
> only have one struct_ops section. This won't work now, please double
> check all this, there should be no assumption about specific section
> index

Yes, I will check the section index of maps.

> 
>>                  else if (idx == obj->efile.btf_maps_shndx)
>>                          err = bpf_object__collect_map_relos(obj, shdr, data);
>> @@ -8954,8 +8989,9 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
>>                  }
>>
>>                  /* struct_ops BPF prog can be re-used between multiple
>> -                * .struct_ops as long as it's the same struct_ops struct
>> -                * definition and the same function pointer field
>> +                * .struct_ops & .struct_ops.link as long as it's the
>> +                * same struct_ops struct definition and the same
>> +                * function pointer field
>>                   */
>>                  if (prog->attach_btf_id != st_ops->type_id ||
>>                      prog->expected_attach_type != member_idx) {
>> --
>> 2.34.1
>>

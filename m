Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E516AFD6E
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 04:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCHDde (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 22:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCHDdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 22:33:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB782345
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 19:33:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i5so16487142pla.2
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 19:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678246397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b7C1d55bIvqvBq3Xs+cOkZtcfApjAlAJ60jgWxg/1o=;
        b=Z/pTSS0fvjjC96HeSlWsLLtREqlG2zc5jM9N29u9dP9g6gzdHDWcEpqfHc0KIURbW6
         o9k/zQV2N4OCOCIDnV1qWq0l5bzMnseB7LUM/Hxae2zqCI2wXQCCCx390bintwB000rT
         XHzad93s9i6jAuPNjHpJLLOgFvikDIKJcfYYPPTGb5l8z12Lr4GFYaNUfPTdjXv6XJbc
         kPynXximC+gJ5kbGEsHsjabfzHvQLZrF3fCUA1Za80W5s5o21KJNckEcF4Y8KQrihHPj
         fW/64qkYrbO6zplxqidLz1rx8/toM2aqnKXedIEeRt+JaAI5kBffhki5uVwtt5fEB0m/
         1vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6b7C1d55bIvqvBq3Xs+cOkZtcfApjAlAJ60jgWxg/1o=;
        b=l1rcG9RITbbXryiBDh6E5yJ7AV2+Uxz4/fgABjLIbAehkdiRaRChf3RhTYqhxdRh16
         dhKVwmztMo56QBtXwnVW+kppv5LXd67eVqx0kob4UKqfJsj8D+752NJqa3ud1PSJtXcE
         AktG0d+nTsauycXcT8ALRp6XgFC/J3N9gbxCP+JQ+lv1qBDCwL2xwjsCovFHZjqbvWeo
         ZA1Wn/Q3Qr9Wu5ehtDOz06z1jRC2vm5pYlEJ2z3ewrTBCWsgZmbD44B+pOeH4IxjqC5+
         gZA8IMqd4HNWxtXmEAZWrJoJpiyoq8i9LLdUinK88gC08IWLnOz37sWTxXujRlidzGgX
         EIkQ==
X-Gm-Message-State: AO0yUKUPYoQxrl0XeLcFFX6O8tVY1UVu4d5YQu+7JZWWDZb3lgwbbOjf
        Zu+GHqaQ0LELh39B9Kv8BFM=
X-Google-Smtp-Source: AK7set96CVbygpZljIMOxk+rjnksj7S3vE43j836jc/GG9l6s7ZvYFVzF667PmezWeFCizs5+0MHvA==
X-Received: by 2002:a05:6a20:431a:b0:cb:aacb:312c with SMTP id h26-20020a056a20431a00b000cbaacb312cmr17417824pzk.27.1678246397348;
        Tue, 07 Mar 2023 19:33:17 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::12b7? ([2620:10d:c090:400::5:e5a9])
        by smtp.gmail.com with ESMTPSA id a20-20020aa78654000000b00587fda4a260sm8551919pfo.9.2023.03.07.19.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 19:33:16 -0800 (PST)
Message-ID: <dcd40553-fc14-b2eb-a1c0-95cba73fee88@gmail.com>
Date:   Tue, 7 Mar 2023 19:33:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 5/9] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-6-kuifeng@meta.com>
 <CAEf4BzbKyDUh4wB+whL-DG0oV_YWvfDV2kWbY=9-vNWzhSwsUQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbKyDUh4wB+whL-DG0oV_YWvfDV2kWbY=9-vNWzhSwsUQ@mail.gmail.com>
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



On 3/7/23 16:46, Andrii Nakryiko wrote:
> On Tue, Mar 7, 2023 at 3:33 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
>> placeholder, but now it is constructing an authentic one by calling
>> bpf_link_create() if the map has the BPF_F_LINK flag.
>>
>> You can flag a struct_ops map with BPF_F_LINK by calling
>> bpf_map__set_map_flags().
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 84 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 62 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 35a698eb825d..a67efc3b3763 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
>>          [BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]    = "sk_reuseport_select_or_migrate",
>>          [BPF_PERF_EVENT]                = "perf_event",
>>          [BPF_TRACE_KPROBE_MULTI]        = "trace_kprobe_multi",
>> +       [BPF_STRUCT_OPS]                = "struct_ops",
>>   };
>>
>>   static const char * const link_type_name[] = {
>> @@ -7677,6 +7678,26 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
>>          return 0;
>>   }
>>
>> +static void bpf_map_prepare_vdata(const struct bpf_map *map)
>> +{
>> +       struct bpf_struct_ops *st_ops;
>> +       __u32 i;
>> +
>> +       st_ops = map->st_ops;
>> +       for (i = 0; i < btf_vlen(st_ops->type); i++) {
>> +               struct bpf_program *prog = st_ops->progs[i];
>> +               void *kern_data;
>> +               int prog_fd;
>> +
>> +               if (!prog)
>> +                       continue;
>> +
>> +               prog_fd = bpf_program__fd(prog);
>> +               kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
>> +               *(unsigned long *)kern_data = prog_fd;
>> +       }
>> +}
>> +
>>   static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
>>   {
>>          int err, i;
>> @@ -7728,6 +7749,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>>          btf__free(obj->btf_vmlinux);
>>          obj->btf_vmlinux = NULL;
>>
>> +       for (i = 0; i < obj->nr_maps; i++)
>> +               if (bpf_map__is_struct_ops(&obj->maps[i]))
>> +                       bpf_map_prepare_vdata(&obj->maps[i]);
> 
> This is similar in spirit to what bpf_object_init_prog_arrays() is
> doing, let's add this as a separate step.
> 
> How about bpf_object_prepare_struct_ops()?

Good!

> 
>> +
>>          obj->loaded = true; /* doesn't matter if successfully or not */
>>
>>          if (err)
>> @@ -11429,22 +11454,34 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
>>          return link;
>>   }
>>
>> +struct bpf_link_struct_ops {
>> +       struct bpf_link link;
>> +       int map_fd;
>> +};
>> +
>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>   {
>> +       struct bpf_link_struct_ops *st_link;
>>          __u32 zero = 0;
>>
>> -       if (bpf_map_delete_elem(link->fd, &zero))
>> -               return -errno;
>> +       st_link = container_of(link, struct bpf_link_struct_ops, link);
>>
>> -       return 0;
>> +       if (st_link->map_fd < 0) {
>> +               /* Fake bpf_link */
>> +               if (bpf_map_delete_elem(link->fd, &zero))
>> +                       return -errno;
>> +               return 0;
> 
> just `return bpf_map_delete_elem(...)`, it will return actual error
> (libbpf 1.0 simplification)

Got it!

> 
>> +       }
>> +
>> +       /* Doesn't support detaching. */
>> +       return -EOPNOTSUPP;
>>   }
>>
>>   struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>   {
>> -       struct bpf_struct_ops *st_ops;
>> -       struct bpf_link *link;
>> -       __u32 i, zero = 0;
>> -       int err;
>> +       struct bpf_link_struct_ops *link;
>> +       __u32 zero = 0;
>> +       int err, fd;
>>
>>          if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>>                  return libbpf_err_ptr(-EINVAL);
>> @@ -11453,31 +11490,34 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>          if (!link)
>>                  return libbpf_err_ptr(-EINVAL);
>>
>> -       st_ops = map->st_ops;
>> -       for (i = 0; i < btf_vlen(st_ops->type); i++) {
>> -               struct bpf_program *prog = st_ops->progs[i];
>> -               void *kern_data;
>> -               int prog_fd;
>> +       /* kern_vdata should be prepared during the loading phase. */
>> +       err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
>> +       if (err) {
>> +               err = -errno;
> 
> no need to deal with -errno, err is already the error you need

ok!

> 
>> +               free(link);
>> +               return libbpf_err_ptr(err);
>> +       }
>>
>> -               if (!prog)
>> -                       continue;
>>
>> -               prog_fd = bpf_program__fd(prog);
>> -               kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
>> -               *(unsigned long *)kern_data = prog_fd;
>> +       if (!(map->def.map_flags & BPF_F_LINK)) {
>> +               /* Fake bpf_link */
>> +               link->link.fd = map->fd;
>> +               link->map_fd = -1;
>> +               link->link.detach = bpf_link__detach_struct_ops;
>> +               return &link->link;
>>          }
>>
>> -       err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> -       if (err) {
>> +       fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);
>> +       if (fd < 0) {
>>                  err = -errno;
> 
> same, fd is an error, it's true for all low-level libbpf APIs

Good to know!


> 
>>                  free(link);
>>                  return libbpf_err_ptr(err);
>>          }
>>
>> -       link->detach = bpf_link__detach_struct_ops;
>> -       link->fd = map->fd;
>> +       link->link.fd = fd;
>> +       link->map_fd = map->fd;
>>
>> -       return link;
>> +       return &link->link;
>>   }
>>
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>> --
>> 2.34.1
>>

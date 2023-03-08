Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FAE6AFC82
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 02:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCHBpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 20:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCHBpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:45:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D928C0C9
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:45:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so738904pjg.4
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 17:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678239910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTkLOkqseK2iAa3KFJVWSxMOcHMS+Ra6sP+9Gk4TeIo=;
        b=UM1ppsxf+TjLNiVpa2Ck9iRx2O1PZEI99CZ7yS5M0lbMpNUvW3uEvACepPLR76zIXF
         iQxSKeBmCFqc7O4gNdqC6G6e+JW5k3+P3VUoFCvA0exuYhm4wrf/JQ90+ZI4gi2IZQEs
         RfE4nIQtu/JlMQyqLOMbOjXDH2zu0hJXtdkRGNE1DBohX4Tql0/digVvfo6DYZo6cPoa
         QZL/Sqc95qTm9BE3mgHlQ/Vy0g2+118ZFsVnTWo0vJrJhYMaNPgltqOWppnWG/8xSc1n
         hZkHfmDcr2UQeV+v7LVhNjFNP+wPfDGAh2+HSWqD1ssfe6g6FNDHK5HikJa/L4U83hkC
         K2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678239910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTkLOkqseK2iAa3KFJVWSxMOcHMS+Ra6sP+9Gk4TeIo=;
        b=DbpMUnkUWhEioJtCB3jcvw0HqhWiQQQVN6fSUlHG8RJjsyl39JMatPro28e71T9Db/
         w/A1dD5vABBeqrLCGbPxDc6/XGemmUwddKI+u41VzYDUTgluGzHVie6fktynXc7ZbR+p
         IevAa8TUIPXxGVaqDO8rJdLeAEYv/q9bhpvzsbDDA7KCPBOrRTYLbC5/F2LMN0DEXE8n
         fghKhTTEldhOKi0t75U6BNmT6bl8KDh49wMYzyM5nX3tCw5YjkIm3JkU+vdcOfN+THjC
         OB/qnObwBbvexMd9XwW8TyLiNKIq+Osv+Uc0S2mpi3V92ay2GV5uArCZCPE4D4CMzVkg
         TzjQ==
X-Gm-Message-State: AO0yUKX76J2TYK3mSxBZudJuJF+3dn3+4/Iv1eEeRfygKEBGUKe9aD4M
        GeRqnNp2j9wqPRymsMOi5C8=
X-Google-Smtp-Source: AK7set8Wna1rw6xx8TlePE62ShFfXyqlBU49bKar68XybB8I2nKzuU/8AsnkWRQEHN8QPNMs4u4DQw==
X-Received: by 2002:a17:90b:38cc:b0:237:bf05:40b with SMTP id nn12-20020a17090b38cc00b00237bf05040bmr18225941pjb.20.1678239910551;
        Tue, 07 Mar 2023 17:45:10 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1402? ([2620:10d:c090:400::5:173])
        by smtp.gmail.com with ESMTPSA id fv16-20020a17090b0e9000b00233790759cesm9835147pjb.47.2023.03.07.17.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 17:45:10 -0800 (PST)
Message-ID: <70f241c5-0f63-1e42-f502-55530478c998@gmail.com>
Date:   Tue, 7 Mar 2023 17:45:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 7/9] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-8-kuifeng@meta.com>
 <CAEf4BzYVcCRpdxzw1a__QqzrcwMFga5tRyvFGekZQxywr8Ue1w@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYVcCRpdxzw1a__QqzrcwMFga5tRyvFGekZQxywr8Ue1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/7/23 16:53, Andrii Nakryiko wrote:
> On Tue, Mar 7, 2023 at 3:33 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Introduce bpf_link__update_struct_ops(), which will allow you to
> 
> update_map, not update_struct_ops, please update
> 
>> effortlessly transition the struct_ops map of any given bpf_link into
>> an alternative.
> 
> This reads confusingly, tbh. Why not say "bpf_link__update_map()
> allows to atomically update underlying struct_ops implementation for
> given struct_ops BPF link" or something like this? Would it be
> accurate?
> 

Right, it should be better.

>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  1 +
>>   tools/lib/bpf/libbpf.map |  2 ++
>>   3 files changed, 39 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a67efc3b3763..247de39d136f 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11520,6 +11520,42 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>          return &link->link;
>>   }
>>
>> +/*
>> + * Swap the back struct_ops of a link with a new struct_ops map.
>> + */
>> +int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
>> +{
>> +       struct bpf_link_struct_ops *st_ops_link;
>> +       __u32 zero = 0;
>> +       int err, fd;
>> +
>> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> 
> let's not hard-code equality like this, < 0 is better

Ok!

> 
>> +               return -EINVAL;
>> +
>> +       st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
>> +       /* Ensure the type of a link is correct */
>> +       if (st_ops_link->map_fd < 0)
>> +               return -EINVAL;
>> +
>> +       err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
>> +       if (err && errno != EBUSY) {
> 
> don't use errno, err is perfectly fine to rely on

Ok!

> 
>> +               err = -errno;
>> +               free(link);
> 
> why freeing the link?...

Urg! It is a mistake.

> 
> 
>> +               return err;
>> +       }
>> +
>> +       fd = bpf_link_update(link->fd, map->fd, NULL);
>> +       if (fd < 0) {
>> +               err = -errno;
>> +               free(link);
> 
> same... please write tests that exercise both successful and
> unsuccessful scenarios

Got it!

> 
>> +               return err;
>> +       }
>> +
>> +       st_ops_link->map_fd = map->fd;
>> +
>> +       return 0;
>> +}
>> +
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>>                                                            void *private_data);
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 2efd80f6f7b9..5e62878d184c 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program *prog,
>>   struct bpf_map;
>>
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
>> +LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
>>
>>   struct bpf_iter_attach_opts {
>>          size_t sz; /* size of this struct for forward/backward compatibility */
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 11c36a3c1a9f..e83571b04c19 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -384,4 +384,6 @@ LIBBPF_1.1.0 {
>>   } LIBBPF_1.0.0;
>>
>>   LIBBPF_1.2.0 {
>> +       global:
>> +               bpf_link__update_map;
> 
> please always rebase before posting new versions of patch set,
> LIBBPF_1.2.0 is not empty anymore
> 
>>   } LIBBPF_1.1.0;
>> --
>> 2.34.1
>>

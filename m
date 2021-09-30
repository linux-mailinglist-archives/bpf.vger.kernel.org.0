Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7A41DE45
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbhI3QAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346800AbhI3QAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 12:00:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FBC06176C
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 08:58:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pg10so4079846pjb.5
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BpjdFjiEOov06Jl3ss/zgsxWZ7ryhVFykt+PMtW+OHE=;
        b=au03x01DqfMZqC8PW8EVxagGMZTuBEEbC5FVPp/syRMeWP9FrKr2zxu1ZWgKd1/F9w
         p2Ga0jQocglBmX60aicl869c875UYa/gEwoabw4k2UFH/8TV7yZJAjhnJ3ePpSERynkO
         JgFEIWzgHe/JiS4EN7V9hxh+266odQXGfMWNUuw4JSjsyE824IWdtV4n9AFT+5veGSjD
         AqNQAEZIPisDWvd89NyBhRmYO25ZBjtnYOjV8g8P0FEzMsYeRzHtlmGZcF8gzOW0JAxq
         8QjmYiXmQ0SSx/qkkUEK7ebVpCPKirdFxLiFD3/l4PEzE5aXb40wkk3JwI6Corjk9TZk
         PlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpjdFjiEOov06Jl3ss/zgsxWZ7ryhVFykt+PMtW+OHE=;
        b=hPoF+w0q/MViIzT32yVs4/EBo+v+2PER2WGTt1brMMZlvfLvzvmMn9zD/LvOhOh6dI
         jBmmZCwBo4jwisiaTT9Tj6Pe3YLbItou3/Wy+ZPD6myX6dxKnm58OvUc1EzwTBknADg4
         IEhGpVrcRBRcLd9w37gqsZiHcYsuV/obPj+/qLGRDE1ESCEnCdm4ZAK2ec5PFGJlTpgJ
         oR10lMMmq+sbULoUANLW/PO/Xj72eE5vjzjPBpwDuNw0+L+1HJY/ib1NLdGiDStprk/8
         qL9SX4CXm3HnZDc10FherwVAAZjzdHQEDnwND6lxlDUNozKBef9EAFb6fQW5qSPVJSZl
         UeZA==
X-Gm-Message-State: AOAM530JmZNWJkqufuWo0NZsy4nZf4jQHhVevhPQRo3an97kaK6ul7q+
        cFTwZksZZpO0R41cFBzDbahIlUn0SL8=
X-Google-Smtp-Source: ABdhPJw5Eg3p4sqPbocWFa2IbFMxHJNdfAq0IHlbbCsoLWESOwL2pfRdwRnRGa+dXlXrziMK7g1Vfw==
X-Received: by 2002:a17:90a:f98f:: with SMTP id cq15mr13923340pjb.74.1633017529490;
        Thu, 30 Sep 2021 08:58:49 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id z33sm3486226pga.20.2021.09.30.08.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 08:58:49 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] libbpf: Support uniform BTF-defined
 key/value specification across all BPF maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
References: <20210905100914.33007-1-hengqi.chen@gmail.com>
 <CAEf4BzYfOGi9YLTWWprDtRCHWNpx00kJWHWQ7WbczUaUZi8HRA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <8a738f87-d0ed-6edc-6fc7-ba61ca0616bf@gmail.com>
Date:   Thu, 30 Sep 2021 23:58:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYfOGi9YLTWWprDtRCHWNpx00kJWHWQ7WbczUaUZi8HRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 12:26 PM, Andrii Nakryiko wrote:
> On Sun, Sep 5, 2021 at 3:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> A bunch of BPF maps do not support specifying types for key and value.
> 
> s/types/BTF types/, it's a bit confusing otherwise
> 
>> This is non-uniform and inconvenient[0]. Currently, libbpf uses a retry
>> logic which removes BTF type IDs when BPF map creation failed. Instead
>> of retrying, this commit recognizes those specialized map and removes
> 
> s/map/maps/
> 
>> BTF type IDs when creating BPF map.
>>
>>   [0] Closes: https://github.com/libbpf/libbpf/issues/355
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> For patch sets consisting of two or more patches, we ask for a cover
> letter, so for the next revision please provide a cover letter with an
> overall description of what the series is about.
> 

Hello, Andrii



Sorry for the long delay. Will send a v2 for review.

>>  tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++---------------
>>  1 file changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 88d8825fc6f6..7068c4d07337 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -4613,6 +4613,26 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>                         create_attr.inner_map_fd = map->inner_map_fd;
>>         }
>>
>> +       if (def->type == BPF_MAP_TYPE_PERF_EVENT_ARRAY ||
>> +           def->type == BPF_MAP_TYPE_STACK_TRACE ||
>> +           def->type == BPF_MAP_TYPE_CGROUP_ARRAY ||
>> +           def->type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
>> +           def->type == BPF_MAP_TYPE_HASH_OF_MAPS ||
>> +           def->type == BPF_MAP_TYPE_DEVMAP ||
>> +           def->type == BPF_MAP_TYPE_SOCKMAP ||
>> +           def->type == BPF_MAP_TYPE_CPUMAP ||
>> +           def->type == BPF_MAP_TYPE_XSKMAP ||
>> +           def->type == BPF_MAP_TYPE_SOCKHASH ||
>> +           def->type == BPF_MAP_TYPE_QUEUE ||
>> +           def->type == BPF_MAP_TYPE_STACK ||
>> +           def->type == BPF_MAP_TYPE_DEVMAP_HASH) {
>> +               create_attr.btf_fd = 0;
>> +               create_attr.btf_key_type_id = 0;
>> +               create_attr.btf_value_type_id = 0;
>> +               map->btf_key_type_id = 0;
>> +               map->btf_value_type_id = 0;
>> +       }
> 
> Let's do this as a more succinct switch statement. Consider also
> slightly rearranging entries to keep "related" map types together:
>   - SOCKMAP + SOCKHASH
>   - DEVMAP + DEVMAP_HASH + CPUMAP + XSKMAP
> 
> Thanks!
>> 
>> +
>>         if (obj->gen_loader) {
>>                 bpf_gen__map_create(obj->gen_loader, &create_attr, is_inner ? -1 : map - obj->maps);
>>                 /* Pretend to have valid FD to pass various fd >= 0 checks.
>> @@ -4622,21 +4642,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>         } else {
>>                 map->fd = bpf_create_map_xattr(&create_attr);
>>         }
>> -       if (map->fd < 0 && (create_attr.btf_key_type_id ||
>> -                           create_attr.btf_value_type_id)) {
>> -               char *cp, errmsg[STRERR_BUFSIZE];
>> -
>> -               err = -errno;
>> -               cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
>> -               pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
>> -                       map->name, cp, err);
>> -               create_attr.btf_fd = 0;
>> -               create_attr.btf_key_type_id = 0;
>> -               create_attr.btf_value_type_id = 0;
>> -               map->btf_key_type_id = 0;
>> -               map->btf_value_type_id = 0;
>> -               map->fd = bpf_create_map_xattr(&create_attr);
>> -       }
>>
> 
> Please don't remove this fallback logic. There are multiple situations
> where libbpf might need to retry map creation without BTF.
> 
>>         err = map->fd < 0 ? -errno : 0;
>>
>> --
>> 2.25.1
>>

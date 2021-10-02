Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BB41FCF4
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhJBQI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhJBQI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 12:08:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5BDC0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 09:07:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h3so1722162pgb.7
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X90G+5EO5viE5eRMQbH06NGcII1+d/5gnWHT9B82vGU=;
        b=YuGl0qe1lsJWX8258ykNpTfbmGkkcNw0b3BB16YGqIMNkC9zobH9L3H4FKWLh7fdab
         VEkdqDt4j7a+VRoLP1vKzSGdhu4fdJVoJVZE0hCK508ZXEYoEDOgZ7a5HG0xmXP37Z5Q
         wqTwZoLi9CsbO5GUJyVJtCYnvgMx9lzlgBmwrK+mlKE3yYv2eIHP3cV4Eb8r3uwAZP6H
         8HwQM22UYX3lACaKNmGx15cZs6ZY4Zpbs9oR+FsCjfDNtKPUibh+JqsKPVn9bsXkxDqu
         UTv1FcLqmNnTztBFQBjM8xVZKG34f6zE68f4C38zR3TvQlPugNeZXCWRGD5cGd+Ktemn
         oqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X90G+5EO5viE5eRMQbH06NGcII1+d/5gnWHT9B82vGU=;
        b=UoAnSEumgYwMPeXAZqJOqJ2lIN+ahA5Hga0m9MF55b+PsalgSGFf/osqbAwV7e9vZi
         FGyHnP4wr6F0Sf0AMm+VkzJmm7bnPImF1KNrPibfblkH0pWArn3L7gOozlVShUT3aVed
         smuAvkTPS0L7QsSCqYb1+9gEZJyFhQK/EJvz/O4yGYZUrHfDunmlL9ytHrXG7o57XmyH
         qhOXN/fg3GxDhxygkvWSGKlJA2U2qRd5LLSyKuYP13ufAP9G+w8BZwIObC75jxNbAV/K
         qYkj96x5NWY738mdBQq7tq3uCHbw3JzGmB9JUbbsdBEk0OjXvd0k4BRZll19waa+r/mR
         5jRQ==
X-Gm-Message-State: AOAM532PTngST/miEqKKBtIngl54imt9Hl8ooMz/2Hf4zS/7XFFVemkW
        tAnNcvYZnqdhaTSI0ern86iSx9VvI9Um2A==
X-Google-Smtp-Source: ABdhPJxPHTSOowvUsroVgVVT3PYFwM6axmT63/kqhAZAcQXxdv6lXUjamvcw6+GovjGE+UfPIKSrdQ==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr3386195pga.394.1633190831559;
        Sat, 02 Oct 2021 09:07:11 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id k3sm9071103pfi.6.2021.10.02.09.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 09:07:11 -0700 (PDT)
Subject: Re: [PATCH bpf-next] libbpf: deprecate bpf_object__unload() API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
References: <20210908153544.749101-1-hengqi.chen@gmail.com>
 <CAEf4BzYhYcyVOJ84REys1nyF8eMaDa0JgAinjgwU_EMvMqOo-g@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <caac5c66-d1b8-bfd3-d321-6e8347d8b84c@gmail.com>
Date:   Sun, 3 Oct 2021 00:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYhYcyVOJ84REys1nyF8eMaDa0JgAinjgwU_EMvMqOo-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 12:38 PM, Andrii Nakryiko wrote:
> On Wed, Sep 8, 2021 at 8:35 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> BPF objects are not re-loadable after unload. User are expected to use
>> bpf_object__close() to unload and free up resources in one operation.
>> No need to expose bpf_object__unload() as a public API, deprecate it.[0]
>> Remove bpf_object__unload() inside bpf_object__load_xattr(), it is the
>> caller's responsibility to free up resources, otherwise, the following
>> code path will cause double-free problem when loading failed:
>>
>>     bpf_prog_load
>>         bpf_prog_load_xattr
>>             bpf_object__load
>>                 bpf_object__load_xattr
>>
> 
> Did you see this double-free ever happen? I'm looking at the code and
> not seeing it. Seems like bpf_object__unload() is idempotent, so no
> mater how many times we call it, it doesn't do any harm. Look at how
> zclose and zfree are implemented, they zero-out fields and also check
> for non-zero values before doing something. So unless I'm missing
> something, there is no problem.
> 
> 

Sorry, I made a stupid mistake. 

Did not realize zclose/zfree are implemented as macros. Will remove these changes.

>> Replace bpf_object__unload() inside bpf_object__close() with the necessary
>> cleanup operations to avoid compilation error.
>>
>>   [0] Closes: https://github.com/libbpf/libbpf/issues/290
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 8 +++++---
>>  tools/lib/bpf/libbpf.h | 3 ++-
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8f579c6666b2..c56b466c5461 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -6931,7 +6931,6 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>>                 if (obj->maps[i].pinned && !obj->maps[i].reused)
>>                         bpf_map__unpin(&obj->maps[i], NULL);
>>
>> -       bpf_object__unload(obj);
> 
> I think unloading already loaded bpf programs is bpf_object__load()'s
> responsibility, so please don't remove this.
> 
>>         pr_warn("failed to load object '%s'\n", obj->path);
>>         return libbpf_err(err);
>>  }
>> @@ -7540,12 +7539,15 @@ void bpf_object__close(struct bpf_object *obj)
>>
>>         bpf_gen__free(obj->gen_loader);
>>         bpf_object__elf_finish(obj);
>> -       bpf_object__unload(obj);
> 
> same, this is fine, don't remove it
> 

OK.

>>         btf__free(obj->btf);
>>         btf_ext__free(obj->btf_ext);
>>
>> -       for (i = 0; i < obj->nr_maps; i++)
>> +       for (i = 0; i < obj->nr_maps; i++) {
>> +               zclose(obj->maps[i].fd);
>> +               if (obj->maps[i].st_ops)
>> +                       zfree(&obj->maps[i].st_ops->kern_vdata);
>>                 bpf_map__destroy(&obj->maps[i]);
>> +       }
> 
> and no changes should be necessary here either
> 

Acked.

>>
>>         zfree(&obj->btf_custom_path);
>>         zfree(&obj->kconfig);
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 2f6f0e15d1e7..748f7dabe4c7 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -147,7 +147,8 @@ struct bpf_object_load_attr {
>>  /* Load/unload object into/from kernel */
>>  LIBBPF_API int bpf_object__load(struct bpf_object *obj);
>>  LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
>> -LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
>> +LIBBPF_API LIBBPF_DEPRECATED("bpf_object__unload() is deprecated, use bpf_object__close() instead")
>> +int bpf_object__unload(struct bpf_object *obj);
>>
> 
> This is the right change, but let's also keep original
> bpf_object__unload() logic. I'd recommend renaming
> bpf_object__unload() into bpf_object_unload() (so that's naming is
> more clearly showing it's an internal function) and make it static.
> Then have a small shim of bpf_object__unload() calling into
> bpf_object_unload() until we remove that in libbpf 1.0.
> 

OK, since LIBBPF_DEPRECATED_SINCE is landed, will use it instead.

>>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
>> --
>> 2.25.1
>>

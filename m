Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C94434CAF
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTNxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTNxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 09:53:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F839C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 06:51:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s136so19354377pgs.4
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTWZnyiLb/4dI72FK+4Y+VeWoFjClRlzJDwY7rZ6VqM=;
        b=YCTbDtgm4HtKNZeDQNIw6Fkz75QzKq9y8f106Wdtsdz63/sNcYtBsec4VlMvJMLsxR
         S9Nncwrr2SfnqXGiAKxIbQX/Mf4I62cryTW6U6eI0D9dUmeWlE8ySAmowuHcW4o2GSwE
         3mKw65ELGirQ+t/UjAzgA5B0xDBr9M+QmDC5DyWv7MjPSCD3R+GBvexp/n/ChS8rVuLk
         lGZ8yBm5DyXSx1NLiPC7swjmqk7B3T4on4BK4NH2+BvWe0pqTr9/3/vKfr2BJvGjJt4u
         z+zoQyM+Z4b5qxM+xXtUWTdVYS980cZ71FhsnKsA9Hm2gEbUzQmUWV4/WpL9svYgZ1QU
         TjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OTWZnyiLb/4dI72FK+4Y+VeWoFjClRlzJDwY7rZ6VqM=;
        b=GBiV7fgqhmV290CksRHABzK4F9G4hm/I1rGfNmAIlbVfR8AycK6yYIOZKaIvNYhipq
         1FAUJ0ZlHKpmYqf6JcEGM6bVrkjtUz7CBCmHHktBKXrnLrsqqGrl5dfFmkWcfTT+x7P6
         S6s9pPSQWHiqN2UU9nw5693eRNWsmi2ltXjLrpvBLq7KRQgUmIZpH+n8W/F8xsQU8lSI
         97SURx/NrSMbD3exZDvZujJpBNHXkUtJFIFnvoJ2D3p7SgGK15SrdokUsK4knk0/dmsG
         DJ8mbIxk7xq0ZoPYd6g3WMe4+JrToj+ajoor+zbOYBfqO9Jlia/XXFApd4VGCPA/ItuT
         Knkw==
X-Gm-Message-State: AOAM530m/jtZwingLT2GW7+0SzkzPxfAOeNalQN0htbXGWlIzZybiI1F
        vWVNoFQvKBCRXLTOYBg7ikU=
X-Google-Smtp-Source: ABdhPJynys6j2lSipPSQNkAG1ZLUavbC/pRNjZlIScZ1Cz7Xt0ZivqCEcfTn3DmgMm9uEM+0s2rcqg==
X-Received: by 2002:a63:731a:: with SMTP id o26mr112119pgc.248.1634737880614;
        Wed, 20 Oct 2021 06:51:20 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id k6sm3023650pfg.18.2021.10.20.06.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 06:51:20 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add btf__type_cnt() and
 btf__raw_data() APIs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
References: <20211009150029.1746383-1-hengqi.chen@gmail.com>
 <20211009150029.1746383-2-hengqi.chen@gmail.com>
 <CAEf4BzZyjoaRATpKHuYFFmZ1u5WnEh4nBdOOpSO+OZi7MH=cHg@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <fc764766-e4fd-dc0a-c042-5af92373a461@gmail.com>
Date:   Wed, 20 Oct 2021 21:51:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZyjoaRATpKHuYFFmZ1u5WnEh4nBdOOpSO+OZi7MH=cHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/10/20 1:48 AM, Andrii Nakryiko wrote:
> On Sat, Oct 9, 2021 at 8:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add btf__type_cnt() and btf__raw_data() APIs and deprecate
>> btf__get_nr_type() and btf__get_raw_data() since the old APIs
>> don't follow the libbpf naming convention for getters which
>> omit 'get' in the name.[0] btf__raw_data() is just an alias to
> 
> nit: this ".[0]" looks out of place, please use it as a reference in a
> sentence, e.g.,:
> 
> omit 'get' in the name (see [0]).
> 
> So that it reads naturally and fits the overall commit message.
> 
> 

Got it. Will do.

>> the existing btf__get_raw_data(). btf__type_cnt() now returns
>> the number of all types of the BTF object including 'void'.
>>
>>   [0] Closes: https://github.com/libbpf/libbpf/issues/279
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/lib/bpf/btf.c      | 36 ++++++++++++++++++++++--------------
>>  tools/lib/bpf/btf.h      |  4 ++++
>>  tools/lib/bpf/btf_dump.c |  8 ++++----
>>  tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++----------------
>>  tools/lib/bpf/libbpf.map |  2 ++
>>  tools/lib/bpf/linker.c   | 28 ++++++++++++++--------------
>>  6 files changed, 62 insertions(+), 48 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 864eb51753a1..49397a22d72b 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -131,7 +131,9 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
>>                                    const char *type_name);
>>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>>                                         const char *type_name, __u32 kind);
>> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__type_cnt() instead")
> 
> it has to be scheduled to 0.7 to have a release with new API
> (btf__type_cnt) before we deprecate btf__get_nr_types(). It's probably
> worth mentioning in the deprecation message that btf__type_cnt()
> return is +1 from btf__get_nr_types(). Maybe something like:
> 

I am a little confused about this scheduling. You mentioned that
we can deprecate old API on the development version (0.6). See [0].


> LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__type_cnt() instead; note that
> btf__get_nr_types() == btf__type_cnt() - 1")
> 

Will take this in v2.

>>  LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
>> +LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
>>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
>>  LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
>>                                                   __u32 id);
>> @@ -144,7 +146,9 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
>>  LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
>>  LIBBPF_API int btf__fd(const struct btf *btf);
>>  LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
>> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__raw_data() instead")
> 
> same, 0.7+
> 
>>  LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
>> +LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
>>  LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
>>  LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
>>  LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
> 
> [...]
> 

  [0] https://lore.kernel.org/all/CAEf4BzZ_JB1VLAF0=7gu=2M0M735aXava=nPL8m8ewQWdS3m8g@mail.gmail.com/

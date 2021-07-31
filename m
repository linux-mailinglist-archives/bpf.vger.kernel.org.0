Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA08E3DC51A
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 10:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhGaImy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Jul 2021 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaImx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Jul 2021 04:42:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E2C06175F
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 01:42:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso24263131pjq.2
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ya6qpBDBpPdbW/jalsSGQbO7/nqzaEsO0P+kfh35XMI=;
        b=AEx5qVET7/8IT6hHcUclcWPoPjCvkWuReYY/sED1fcs/UkbqSylPC0Bprkg44w+npm
         BhXs8exEQmqZVMm7JpDIbJ19UBHXqf42rRop4nlj+AmpQTsJHFoGLBGIlGU/821Zo3XX
         LZO+hWnEX5QXmvvmB6T5WexldCPl+6shPClZNK/xmoXuNG3CVu5STvNdUDyF9iQbHO9+
         JOhC1ejUPQHoMA46a6DtTFiE/RketLk+kVvK057RMgz9m058YZFB2As+8Aiu6gdosWHB
         roO5UXtrdeePQC8xwbaHZVsCNzSsVwTzSKkHKcDsICyiSBm4pKym+UUnsSqcgNDuxp2B
         wlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ya6qpBDBpPdbW/jalsSGQbO7/nqzaEsO0P+kfh35XMI=;
        b=OtCIfqQfGNvqmukb18K6sJz5obwiTVLR6VOdd2wfsyyKWEG2vGohvHK9Tpmk663ufl
         u2LiCSp9WRJaXF1OgQDabO6KeewQS0W2APZ9DeFv3XPs3dl+LDuyxsv1WimnrGfPyEkX
         sXVU2Sw/DSsx7GqDJ4je0EnPnM6n2/OBVKqnkRls8KZJA0nMFcDl+rRy61Ne2SH0ZLxm
         iStdKRQxtHjeDDwgIvOHTzmdk7gUv8Nc1lzcSs60C25NkKsG9sfpDUpDk/3JKnD4CP4d
         GNJbfnLFJlQUuSCdicguekMdM9b+nmqQ6B2/H5wvJueGmfiYVAcfcENN/daL9rFKN+Zu
         8w0g==
X-Gm-Message-State: AOAM533bO5VzFnO50uD1eMLvFKNqblUHHwzcWnNBpTQTNDK2LFnL+bVR
        YG7WUOO7aj5SxC2Di3H6ELk=
X-Google-Smtp-Source: ABdhPJyQiApjWTebFkY4H2ePf38iB/Ag2/b2jVcooyFiUCPpHKX8Zs5Y1QLPTSKkvmBX6CELo8UQmQ==
X-Received: by 2002:a17:90a:fa14:: with SMTP id cm20mr7325067pjb.67.1627720966645;
        Sat, 31 Jul 2021 01:42:46 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id y15sm5653691pga.34.2021.07.31.01.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 01:42:46 -0700 (PDT)
Subject: Re: [PATCH bpf-next v3] libbpf: add
 btf__load_vmlinux_btf/btf__load_module_btf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>
References: <20210730114012.494408-1-hengqi.chen@gmail.com>
 <CAEf4BzbtPFEbme_KZQA+n-gCgC+xp-v+270BBCi+89smi6pzkA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <b1da3641-81bf-8ffa-2210-c4fccd8e6e45@gmail.com>
Date:   Sat, 31 Jul 2021 16:42:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbtPFEbme_KZQA+n-gCgC+xp-v+270BBCi+89smi6pzkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/31/21 3:26 AM, Andrii Nakryiko wrote:
> On Fri, Jul 30, 2021 at 4:40 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add two new APIs: btf__load_vmlinux_btf and btf__load_module_btf.
>> btf__load_vmlinux_btf is just an alias to the existing API named
>> libbpf_find_kernel_btf, rename to be more precisely and consistent
>> with existing BTF APIs. btf__load_module_btf can be used to load
>> module BTF, add it for completeness. These two APIs are useful for
>> implementing tracing tools and introspection tools. This is part
>> of the effort towards libbpf 1.0. [1]
>>
>> [1] https://github.com/libbpf/libbpf/issues/280
> 
> I changed this to
> 
> [0] Closes: https://github.com/libbpf/libbpf/issues/280
> 
> which will close an associated Github issue when we sync sources to
> Github next time. Let's see how this works in practice.
> 
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> Thanks, applied to bpf-next. But please follow up with a selftest that
> would utilize this new module BTF API. It's good to have all APIs
> exercised regularly. Look at test_progs.
> 

Thanks, will do.

>>  tools/lib/bpf/btf.c      | 15 ++++++++++++++-
>>  tools/lib/bpf/btf.h      |  6 ++++--
>>  tools/lib/bpf/libbpf.c   |  4 ++--
>>  tools/lib/bpf/libbpf.map |  2 ++
>>  4 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index cafa4f6bd9b1..56e84583e283 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -4036,7 +4036,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>>                  */
>>                 if (d->hypot_adjust_canon)
>>                         continue;
>> -
>> +
>>                 if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
>>                         d->map[t_id] = c_id;
>>
>> @@ -4410,6 +4410,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
>>   * data out of it to use for target BTF.
>>   */
>>  struct btf *libbpf_find_kernel_btf(void)
> 
> I switched this to __attribute__((alias("btf__load_vmlinux_btf"))); to
> match what Quentin did recently. Also moved comment above to be next
> to btf__load_vmlinux_btf.
> 

OK, the alias attribute look nicer.

>> +{
>> +       return btf__load_vmlinux_btf();
>> +}
>> +
>> +struct btf *btf__load_vmlinux_btf(void)
>>  {
>>         struct {
>>                 const char *path_fmt;
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 5aca3686ca5e..a2f471950213 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -380,4 +380,6 @@ LIBBPF_0.5.0 {
>>                 btf__load_into_kernel;
>>                 btf_dump__dump_type_data;
>>                 libbpf_set_strict_mode;
>> +               btf__load_vmlinux_btf;
>> +               btf__load_module_btf;
> 
> This list needs to be alphabetically sorted. I'll fix it up while
> applying, but please remember it for the future.
> 

Yeah, will keep this in mind.

>>  } LIBBPF_0.4.0;
>> --
>> 2.25.1
>>

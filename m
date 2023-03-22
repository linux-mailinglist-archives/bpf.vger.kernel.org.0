Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8099C6C5AE4
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 00:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCVX67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 19:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVX66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 19:58:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304912F06
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:58:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u5so20762161plq.7
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679529537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmM8DyQqe3ETpIL5PvTOd08hPyOls8YJCfRyMohVkjQ=;
        b=e8sY/ELoCDhe6MEy5HKhCN/Rv7zMaDTZo3p0REsqnHHjsPPU9V8/5DQV7bk70Y0ZUu
         gxzufkJVrGQ5ZOyFMbcbtVFdndIDBCZiape+4kgg0Me/iUbI2pmq3OKTjsSRHlKnI0tO
         /ufaDoeCKsvmkztRiF9DseMhvA3M7hHKTRpI8ZPQhyz/SNtl2k3qhmMOPp+IF+14YGa+
         J5TwF/PYfPUz2pofo1FyGSRDMUb1G9FHhr3DqsJUZGEMBxehiEokalfOeeeLZtYIfVo+
         WFawbo6mJ1x/rV4KhIM5+pNPlKSPO1l5bCPh5KPdl/z3eqt4uaMAH5GXIcI23TXzPoa1
         53iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679529537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmM8DyQqe3ETpIL5PvTOd08hPyOls8YJCfRyMohVkjQ=;
        b=fqM/P4/lt5NdIuI9yMCLgJNQBOIISKSQsGaDuLRD1/tCaDBQzZx+BQo6+x4hhr2+iA
         3QiykpKW8EBWEUhptrijthMEO5Iim8jSHOH2Z0MtOWuI2LDbYzIjxsYVGQ3Ck6nzPQuH
         sa9kpl3CP8mVjIOeMG49fCkQa79kTEvyYZtp4HtC5Wscu+9dZ6xb33F3UbnZoCf98nf9
         LkXMyxbai1GVHp90HpGEBbuqbHORca+QuOIH9C3YRFpYGvrnQJBp7VJtNa13Hz4q+A8M
         NaRAskBrKI5j3yGmhh1/1ZRawcB1Pe0VdWa9kUGTTDwh++LxwEmr/C/OGXNQnQfww14+
         icgw==
X-Gm-Message-State: AO0yUKUbT1om1GuohY4xyjzsA6IMxcp+n+sX0J7LZpHC5a6T+OwY6X0n
        vwtyu1VIE0t6rI1+yDQ3Qfc=
X-Google-Smtp-Source: AK7set/oo517DlsgAChIHZKxQ+wxC9CFnH5lAGo1Th2Zmmrnp10J0Qn1Lzyc3iN9KcjCh1t8II1uMg==
X-Received: by 2002:a17:903:41ca:b0:19c:f232:21ca with SMTP id u10-20020a17090341ca00b0019cf23221camr5326346ple.3.1679529537178;
        Wed, 22 Mar 2023 16:58:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:3e80:6f9c:fb57:53e9? ([2620:10d:c090:500::4:9b8b])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001a19f3a661esm11044868plg.138.2023.03.22.16.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 16:58:56 -0700 (PDT)
Message-ID: <688a0318-58df-b1ae-a376-ada0364153a7@gmail.com>
Date:   Wed, 22 Mar 2023 16:58:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v10 6/8] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230321232813.3376064-1-kuifeng@meta.com>
 <20230321232813.3376064-7-kuifeng@meta.com>
 <CAEf4BzYSeXv=TVSenowUsY16twEULh7p0ZiqB=ZXQ=hDTofNQQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYSeXv=TVSenowUsY16twEULh7p0ZiqB=ZXQ=hDTofNQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/23 16:42, Andrii Nakryiko wrote:
> On Tue, Mar 21, 2023 at 4:28 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Introduce bpf_link__update_map(), which allows to atomically update
>> underlying struct_ops implementation for given struct_ops BPF link
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/bpf.h      |  5 ++++-
>>   tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  1 +
>>   tools/lib/bpf/libbpf.map |  1 +
>>   4 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index f0f786373238..4fae4e698a8e 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -335,7 +335,10 @@ LIBBPF_API int bpf_link_detach(int link_fd);
>>   struct bpf_link_update_opts {
>>          size_t sz; /* size of this struct for forward/backward compatibility */
>>          __u32 flags;       /* extra flags */
>> -       __u32 old_prog_fd; /* expected old program FD */
>> +       union {
>> +               __u32 old_prog_fd; /* expected old program FD */
>> +               __u32 old_map_fd;  /* expected old map FD */
>> +       };
> 
> so for these low-level wrappers in libbpf with OPTS we've been trying
> to avoid unnecessary unions. If you look at bpf_link_create and
> bpf_link_create_ops some fields that are in a union in kernel UAPI are
> actually listed as separate fields, and libbpf makes sure that both
> fields are not specified at the same time (like iter_info_len and
> target_btf_id, for instance).
> 
> So let's do the same here, instead of making a union, let's have
> 
> __u32 old_prog_fd;
> __u32 old_map_fd;
> 
> and then in bpf_link_update() implementation make sure that both can't
> be set at the same time.

Got it! Thanks!

> 
> The rest of the patch looks good to me, thanks....

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E737436378
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJUNzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhJUNze (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 09:55:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20174C061348
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:53:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so591217pjb.5
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dXfzwl5SrdfYLTNic5B7twESFB4MzvClROMLtrfTNd4=;
        b=FSmPX3HIz24FtpZbgrQ/h9lAUMOBHZ1Q4d6zI2UpIA2W0lSXFt8l6x6Br1eUTfW34m
         r6fs7B6j6KMGlc62MTE00rUjXwaHJuVyCX4VWNpFvPrs/h16g3GiJ6a/tI22tufb4UH2
         rqtgQ3nenkUqBvxRBvkX9R/wKWoa/5OibFo+aX/fPcx/Hq/9Dioy7uxf2owlLUxOC+q6
         xvJsFEEY1O+UMSFwxGTobCb5WAAePwFU9Bn9Pixhc95wXOd+35Rm39EXC85Di9bhH2Gh
         oOb7ZRb0Lg/Wf9mYng6wWf9MeoGUzPAMqjivTuBXEV+95Vt3firts5qArI2w1RSlVXif
         veSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dXfzwl5SrdfYLTNic5B7twESFB4MzvClROMLtrfTNd4=;
        b=OkRfHJ9bNuOhGTCD4bXfRILWggtm+33FFd326v+IvImS9EEj/Vy3kAnKGb7gnQTMB8
         FSGNtFEWmmv+flYzYRw9ZGnNIPQGs+28SfoEMpmMdT+9CnlLYZcw4h+fOKNs+JZZxomf
         FJXX1yXMVtgCAllqseI9Nnt0Y1+K+Kt2+vujWK7vmMx5aVc9hwpL7vRjd+vezS899MC6
         mYY/qTZQr2tActUOxsNmxWtxWIcAJTZlpWb0h5VBRaAz5FvyrTRvOjgTdXCX2PN3wzaG
         we1WLjeOQmbEmhKMzS8bGgYKv8qbWv9bF/ugww3MMU++S2Vyt7zYrG8+wEAA2UoupPkd
         7/pQ==
X-Gm-Message-State: AOAM532L7HkGgZRt9ZoB0jhmqkKOfoTyaErJ89j49cPR2H5sv08+08/W
        EoAlqRYvBrq7Br7fW/W33os=
X-Google-Smtp-Source: ABdhPJy+ADEnPK0qYidEjaTVdnHbkka4EmxBMMGyjA4clivj4rTnQG19TqMz/xDVL+jWDvrKkcDeWw==
X-Received: by 2002:a17:90a:c70d:: with SMTP id o13mr6846341pjt.143.1634824398616;
        Thu, 21 Oct 2021 06:53:18 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id p16sm7624150pfh.97.2021.10.21.06.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:53:18 -0700 (PDT)
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
 <fc764766-e4fd-dc0a-c042-5af92373a461@gmail.com>
 <CAEf4BzY9q1md3Q6Z6q5EJ=JEp9keq-cOa6S3jOoo8i+WRhJFxw@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <adfe1bf4-fd2a-784a-ff6a-b91ddc44ca1c@gmail.com>
Date:   Thu, 21 Oct 2021 21:53:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY9q1md3Q6Z6q5EJ=JEp9keq-cOa6S3jOoo8i+WRhJFxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/10/21 7:14 AM, Andrii Nakryiko wrote:
> On Wed, Oct 20, 2021 at 6:51 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>>
>>
>> On 2021/10/20 1:48 AM, Andrii Nakryiko wrote:
>>> On Sat, Oct 9, 2021 at 8:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>
>>>> Add btf__type_cnt() and btf__raw_data() APIs and deprecate
>>>> btf__get_nr_type() and btf__get_raw_data() since the old APIs
>>>> don't follow the libbpf naming convention for getters which
>>>> omit 'get' in the name.[0] btf__raw_data() is just an alias to
>>>
>>> nit: this ".[0]" looks out of place, please use it as a reference in a
>>> sentence, e.g.,:
>>>
>>> omit 'get' in the name (see [0]).
>>>
>>> So that it reads naturally and fits the overall commit message.
>>>
>>>
>>
>> Got it. Will do.
>>
>>>> the existing btf__get_raw_data(). btf__type_cnt() now returns
>>>> the number of all types of the BTF object including 'void'.
>>>>
>>>>   [0] Closes: https://github.com/libbpf/libbpf/issues/279
>>>>
>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>> ---
>>>>  tools/lib/bpf/btf.c      | 36 ++++++++++++++++++++++--------------
>>>>  tools/lib/bpf/btf.h      |  4 ++++
>>>>  tools/lib/bpf/btf_dump.c |  8 ++++----
>>>>  tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++----------------
>>>>  tools/lib/bpf/libbpf.map |  2 ++
>>>>  tools/lib/bpf/linker.c   | 28 ++++++++++++++--------------
>>>>  6 files changed, 62 insertions(+), 48 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>>>> index 864eb51753a1..49397a22d72b 100644
>>>> --- a/tools/lib/bpf/btf.h
>>>> +++ b/tools/lib/bpf/btf.h
>>>> @@ -131,7 +131,9 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
>>>>                                    const char *type_name);
>>>>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>>>>                                         const char *type_name, __u32 kind);
>>>> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__type_cnt() instead")
>>>
>>> it has to be scheduled to 0.7 to have a release with new API
>>> (btf__type_cnt) before we deprecate btf__get_nr_types(). It's probably
>>> worth mentioning in the deprecation message that btf__type_cnt()
>>> return is +1 from btf__get_nr_types(). Maybe something like:
>>>
>>
>> I am a little confused about this scheduling. You mentioned that
>> we can deprecate old API on the development version (0.6). See [0].
> 
> If we add some new API and deprecate old API (but recommend to use new
> API instead), we need to make sure that new API is there in at least
> one released libbpf version. Only then we can mark old API as
> deprecated in the next released libbpf version. In this case
> btf__type_cnt() has to go into v0.6 and btf__get_nr_types() can be
> deprecated in v0.7, not in v0.6.
> 
> Previous case in [0] was different, there was no new API we had to
> wait for, so we could deprecate the old API immediately.
> 

Thanks. That's clear.
Will do in next revision.

>>
>>
>>> LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__type_cnt() instead; note that
>>> btf__get_nr_types() == btf__type_cnt() - 1")
>>>
>>
>> Will take this in v2.
>>
>>>>  LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
>>>> +LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
>>>>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
>>>>  LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
>>>>                                                   __u32 id);
>>>> @@ -144,7 +146,9 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
>>>>  LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
>>>>  LIBBPF_API int btf__fd(const struct btf *btf);
>>>>  LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
>>>> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__raw_data() instead")
>>>
>>> same, 0.7+
>>>
>>>>  LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
>>>> +LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
>>>>  LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
>>>>  LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
>>>>  LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
>>>
>>> [...]
>>>
>>
>>   [0] https://lore.kernel.org/all/CAEf4BzZ_JB1VLAF0=7gu=2M0M735aXava=nPL8m8ewQWdS3m8g@mail.gmail.com/

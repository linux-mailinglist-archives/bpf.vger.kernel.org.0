Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAC91B7C65
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgDXRIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgDXRIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 13:08:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107ABC09B047
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 10:08:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so10475342wma.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VhclzsG/arXqYzZ/UteHN/VyynuBiAmNAER0y/y+b9U=;
        b=hodck+sd4npY7CYtQQAC/+fkD9sNKEywVtttCXKzuNa+MEgre2M4jlRfljI8urB6f1
         h26M0cyrXqDZkdrw7ab9icgrpzl11SPllBlNIUeX+GpXyffOjPVzYpnoHgEUM/CcDQuG
         /r1g2hoZAukZ8rZK4Ekt1lai+VNHtDePe3fRXoUstviW1EhIDQGz0BCVpY6UE1X560jd
         m5kaHlymKxKWYPFfQsPg7jSsf5AIyjYT70SBe2RZlfuBzRbcbN80X+7C6Dbp1bj7GAfK
         7HAgS90pHN4phLTtwTrA+AI3ZIjZG2Vg4mtmarGA5O8Ris8+kGo8yPvZuHpxrvibAIcr
         bCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhclzsG/arXqYzZ/UteHN/VyynuBiAmNAER0y/y+b9U=;
        b=X5ll/B0GZhXdQIMbhxMch1iwVd+etsOzURUVgfDfpeGLyVfr+/C1IIzNb/kzNkTPhn
         BBSABNX9rfmbWrRp69YnDh3XlcAg2eD9MuhDK0Fq/SiRoTRqpS4q8HKs0kEhb7x7ixv2
         TrowJrnZ0ZibhAudIwkVLdQR4GwpG9orbcbXgLLR5euoONd2ZFDm9jlmZy4GjPO1n9R3
         tch0Q8rQGzdK+jzYkBHiSJFzVoqhYQbqEGAunmXDTqN0HVsx9+gjHor5rVTxqkwgF19B
         goCMiJ07d4Bl7JAzN46ZoAf4Ip8gcSsJ2gjRRMuUpXiQeKpmHksSObZfGBTlvCYYy3IS
         FOnQ==
X-Gm-Message-State: AGi0PuaH0ukXnBfiuu/XEJwk5mDFvFDUa+b4DArrLqLrNgZTsMHD6Tke
        CNSt5XGH4eE353ovuvXwFZYvGQ==
X-Google-Smtp-Source: APiQypL/axxEL5NJDbgkiP82HezyVN+9YLYRN1v7hmakuvjoxgvCXTAAUHbvdAXdz755u8QW8dp9vQ==
X-Received: by 2002:a05:600c:295a:: with SMTP id n26mr12247473wmd.16.1587748098621;
        Fri, 24 Apr 2020 10:08:18 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.129])
        by smtp.gmail.com with ESMTPSA id k133sm3953733wma.0.2020.04.24.10.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:08:17 -0700 (PDT)
Subject: Re: [PATCH bpf-next 07/10] bpftool: expose attach_type-to-string
 array to non-cgroup code
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20200424053505.4111226-1-andriin@fb.com>
 <20200424053505.4111226-8-andriin@fb.com>
 <34110254-6384-153f-af39-d5f9f3a50acb@isovalent.com>
 <CAEf4BzY9tjQm1f8eTyjYjthTF9n6tZ59r1mpUsYWL4+bFuch2Q@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <5404b784-2173-210d-6319-fa5f0156701e@isovalent.com>
Date:   Fri, 24 Apr 2020 18:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY9tjQm1f8eTyjYjthTF9n6tZ59r1mpUsYWL4+bFuch2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-24 09:27 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, Apr 24, 2020 at 3:32 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2020-04-23 22:35 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
>>> Move attach_type_strings into main.h for access in non-cgroup code.
>>> bpf_attach_type is used for non-cgroup attach types quite widely now. So also
>>> complete missing string translations for non-cgroup attach types.
>>>
>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>> ---
>>>  tools/bpf/bpftool/cgroup.c | 28 +++-------------------------
>>>  tools/bpf/bpftool/main.h   | 32 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 35 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
>>> index 62c6a1d7cd18..d1fd9c9f2690 100644
>>> --- a/tools/bpf/bpftool/cgroup.c
>>> +++ b/tools/bpf/bpftool/cgroup.c
>>> @@ -31,35 +31,13 @@
>>>
>>>  static unsigned int query_flags;
>>>
>>> -static const char * const attach_type_strings[] = {
>>> -     [BPF_CGROUP_INET_INGRESS] = "ingress",
>>> -     [BPF_CGROUP_INET_EGRESS] = "egress",
>>> -     [BPF_CGROUP_INET_SOCK_CREATE] = "sock_create",
>>> -     [BPF_CGROUP_SOCK_OPS] = "sock_ops",
>>> -     [BPF_CGROUP_DEVICE] = "device",
>>> -     [BPF_CGROUP_INET4_BIND] = "bind4",
>>> -     [BPF_CGROUP_INET6_BIND] = "bind6",
>>> -     [BPF_CGROUP_INET4_CONNECT] = "connect4",
>>> -     [BPF_CGROUP_INET6_CONNECT] = "connect6",
>>> -     [BPF_CGROUP_INET4_POST_BIND] = "post_bind4",
>>> -     [BPF_CGROUP_INET6_POST_BIND] = "post_bind6",
>>> -     [BPF_CGROUP_UDP4_SENDMSG] = "sendmsg4",
>>> -     [BPF_CGROUP_UDP6_SENDMSG] = "sendmsg6",
>>> -     [BPF_CGROUP_SYSCTL] = "sysctl",
>>> -     [BPF_CGROUP_UDP4_RECVMSG] = "recvmsg4",
>>> -     [BPF_CGROUP_UDP6_RECVMSG] = "recvmsg6",
>>> -     [BPF_CGROUP_GETSOCKOPT] = "getsockopt",
>>> -     [BPF_CGROUP_SETSOCKOPT] = "setsockopt",
>>> -     [__MAX_BPF_ATTACH_TYPE] = NULL,
>>
>> So you removed the "[__MAX_BPF_ATTACH_TYPE] = NULL" from the new array,
>> if I understand correctly this is because all attach type enum members
>> are now in the new attach_type_name[] so we're safe by looping until we
>> reach __MAX_BPF_ATTACH_TYPE. Sounds good in theory but...
>>
> 
> Well, NULL is default value, so having [__MAX_BPF_ATTACH_TYPE] = NULL
> just increases ARRAY_SIZE(attach_type_names) by one. Which is
> generally not needed, because we do proper < ARRAY_SIZE() checks
> everywhere... except for one place. show_bpf_prog in cgroup.c looks up
> name directly and can pass NULL into jsonw_string_field which will
> crash.
> 
> I can fix that by setting [__MAX_BPF_ATTACH_TYPE] to "unknown" or
> adding extra check in show_bpf_prog() code? Any preferences?

Maybe add the extra check, so we remove this [__MAX_BPF_ATTACH_TYPE]
indeed. It will be more consistent with the array with program names,
and as you say, all other places loop on ARRAY_SIZE() just fine.

Maybe we could print the integer value for the type if we don't know the
name? Not sure if this is good for JSON though.

> 
>>> -};
>>> -
>>>  static enum bpf_attach_type parse_attach_type(const char *str)
>>>  {
>>>       enum bpf_attach_type type;
>>>
>>>       for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
>>> -             if (attach_type_strings[type] &&
>>> -                 is_prefix(str, attach_type_strings[type]))
>>> +             if (attach_type_name[type] &&
>>> +                 is_prefix(str, attach_type_name[type]))
>>>                       return type;
>>>       }
>>
>> ... I'm concerned the "attach_type_name[type]" here could segfault if we
>> add a new attach type to the kernel, but don't report it immediately to
>> bpftool's array.
> 
> I don't think so. Here we'll iterate over all possible bpf_attach_type
> (as far as our copy of UAPI header is concerned, of course). If some
> of the values don't have entries in attach_type_name array, we'll get
> back NULL (same as with explicit [__MAX_BPF_ATTACH_TYPE] = NULL, btw),
> which will get handled properly in the loop. And caller will get back
> __MAX_BPF_ATTACH_TYPE as bpf_attach_type value. So unless I'm still
> missing something, it seems to be working exactly the same as before?
> 
>>
>> Is there any drawback with keeping the "[__MAX_BPF_ATTACH_TYPE] = NULL"?
>> Or change here to loop on ARRAY_SIZE(), as you do in your own patch for
>> link?
> 
> ARRAY_SIZE() == __MAX_BPF_ATTACH_TYPE, isn't it? Previously ARRAY_SIZE
> was (__MAX_BPF_ATTACH_TYPE + 1), but I don't think it's necessary?

ARRAY_SIZE() /should/ be equal to __MAX_BPF_ATTACH_TYPE, the concern is
only if new attach types get added to UAPI header and we forget to add
them to the array. In that case, the assumption is not longer valid and
we risk reading out of the array in parse_attach_type(). That was not
the case before, because we knew that the array was always big enough.
There was no risk to read beyond index __MAX_BPF_ATTACH_TYPE, there is
one now to read beyond index BPF_LSM_MAC when new types are added. Or am
I the one missing something?

> 
> The only difference is show_bpf_prog() which now is going to do out of
> array reads, while previously it would get NULL. But both cases are
> bad and needs fixing.
> 

Right, nice catch, this needs a fix.

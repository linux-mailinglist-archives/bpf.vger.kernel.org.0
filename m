Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B9C3DC062
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhG3VrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhG3VrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 17:47:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447BC061765
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:47:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so7268908wmq.2
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=77NYw4tJFwAkaSUwKp+LA67qPSuC4OUccyvGLrXZCUg=;
        b=k+pVQ81mmm/Avg/w/+Hzu7CJgzYulWXYT3Jm4QedaSjTec4h1zD1ffdnlevncHOrKC
         tr5qL9PfYtebM1rpTRD4FHXpR9+pVz03ARjplZns+IUlTQAA2n2IJO177Ihe7rVzJp14
         k800YY3yor3T8MIOZvnKWJFMxLYngBYuduwZf5AFggmob47KeN42slyWl+bypJ+Oi+64
         p/2hk0bA7WZ/oLet678KKxWM+Ay3LFuntoJGS2RQ/+lhDioJILL3u/gwNWPbWkv5yxKR
         OoqTQdP6sGrGUa5nKR6M7t6AmGNtKqLZGkHYUaKyplEdx6BF1ZLDq3/bBB1bQQIO3k98
         XHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77NYw4tJFwAkaSUwKp+LA67qPSuC4OUccyvGLrXZCUg=;
        b=i0RUieTuYDywSfWJHMPkrAQjcr3PuFJ58BOBER7zclOlA6YHmEGfr6l6HFaZJ9+B5q
         tiTq4lr3nw8fORyc8+BPi7VdFadlyY6/mys+g3IeqguO58NRrYXI3W1T2+o3jJ7Y5VcZ
         fMiYFu41ItpyaI3hkhz1woRt2DyaGhruo0Z4vM1UiqG2FBZmmr+EOopv7/tykHJ3+u59
         Fomv49BnBU43apmXzXZEIzqJwMmjdDSeSoiGooya2ZaRQaSlvmpGIKCTslyRIjBny+In
         /L8F4INfqu4bb9hgYJVkU7GPOvLN/mWJD7nADuw0pqH7LAAP843djhgCn967QbIE0+r9
         O4RQ==
X-Gm-Message-State: AOAM533/SMrMdkecIwtWZ/TmmtdvgRsqOxWyVivsNuZYJ17v4Pljmr55
        zTNjYXluehItKx/UBdWl78lyeZ1az1LIXvZ8
X-Google-Smtp-Source: ABdhPJxo1jhGotCxTiG3I0Qu/fX3+o9LB1lwjOatwmOErn5kI3hvmAluzHkaBBClg7eWi37EJg8/mQ==
X-Received: by 2002:a05:600c:3509:: with SMTP id h9mr4982264wmq.81.1627681624520;
        Fri, 30 Jul 2021 14:47:04 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.68.125])
        by smtp.gmail.com with ESMTPSA id j4sm2092787wmi.4.2021.07.30.14.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 14:47:04 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/7] tools: bpftool: slightly ease bash
 completion updates
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210729162932.30365-1-quentin@isovalent.com>
 <20210729162932.30365-2-quentin@isovalent.com>
 <CAEf4BzadrpVDm6yAriDSXK2WOzbzeZJoGKxbRzH+KA4YUD7SEg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <b80ab3fb-dc70-5b7e-b86a-8b2b9bded54e@isovalent.com>
Date:   Fri, 30 Jul 2021 22:46:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzadrpVDm6yAriDSXK2WOzbzeZJoGKxbRzH+KA4YUD7SEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-30 11:45 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Jul 29, 2021 at 9:29 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> Bash completion for bpftool gets two minor improvements in this patch.
>>
>> Move the detection of attach types for "bpftool cgroup attach" outside
>> of the "case/esac" bloc, where we cannot reuse our variable holding the
>> list of supported attach types as a pattern list. After the change, we
>> have only one list of cgroup attach types to update when new types are
>> added, instead of the former two lists.
>>
>> Also rename the variables holding lists of names for program types, map
>> types, and attach types, to make them more unique. This can make it
>> slightly easier to point people to the relevant variables to update, but
>> the main objective here is to help run a script to check that bash
>> completion is up-to-date with bpftool's source code.
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>  tools/bpf/bpftool/bash-completion/bpftool | 57 +++++++++++++----------
>>  1 file changed, 32 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>> index cc33c5824a2f..b2e33a2d8524 100644
>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>> @@ -404,8 +404,10 @@ _bpftool()
>>                              return 0
>>                              ;;
>>                          5)
>> -                            COMPREPLY=( $( compgen -W 'msg_verdict stream_verdict \
>> -                                stream_parser flow_dissector' -- "$cur" ) )
>> +                            local BPFTOOL_PROG_ATTACH_TYPES='msg_verdict \
>> +                                stream_verdict stream_parser flow_dissector'
>> +                            COMPREPLY=( $( compgen -W \
>> +                                "$BPFTOOL_PROG_ATTACH_TYPES" -- "$cur" ) )
>>                              return 0
>>                              ;;
>>                          6)
>> @@ -464,7 +466,7 @@ _bpftool()
>>
>>                      case $prev in
>>                          type)
>> -                            COMPREPLY=( $( compgen -W "socket kprobe \
>> +                            local BPFTOOL_PROG_LOAD_TYPES='socket kprobe \
>>                                  kretprobe classifier flow_dissector \
>>                                  action tracepoint raw_tracepoint \
>>                                  xdp perf_event cgroup/skb cgroup/sock \
>> @@ -479,8 +481,9 @@ _bpftool()
>>                                  cgroup/post_bind4 cgroup/post_bind6 \
>>                                  cgroup/sysctl cgroup/getsockopt \
>>                                  cgroup/setsockopt cgroup/sock_release struct_ops \
>> -                                fentry fexit freplace sk_lookup" -- \
>> -                                                   "$cur" ) )
>> +                                fentry fexit freplace sk_lookup'
>> +                            COMPREPLY=( $( compgen -W \
>> +                                "$BPFTOOL_PROG_LOAD_TYPES" -- "$cur" ) )
> 
> nit: this and similar COMPREPLY assignments now can be on a single line now, no?

It will go over 80 characters, but OK, it will probably be more readable
on a single line. I'll change for v2.

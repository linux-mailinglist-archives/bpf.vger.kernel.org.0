Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC47F2AF
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2019 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfD3JV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Apr 2019 05:21:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52086 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfD3JV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Apr 2019 05:21:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so2955834wmf.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2019 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iaFDFnvVtS1iWSBFrIIKUe+7Fko1T4rJ0OHw8pGokPc=;
        b=SGZs7DUnbcoM2RcuSABcJ5nEoFb5Jh0yeaPcnF7PUPj+8pC9/WQCx9BoIHQSJleqz3
         N/9J58myQKiVQXvIx8lwvoC+4AC9LE0osAegiYd5wfE42z2H/ePs54RyDNrRSTAa2IXw
         7ByXxjQSOPkiK2LuY8u2671JH6lLW96Vv1MD5QJe62rqoc7RjuFVEEa0byaLidAP6+ss
         mJg+n7238TTgYfVBHgjWao3xUI8HqccPyvjGIsXVyTLswrqQWSqnLM/WCl2P2UDefbzq
         wY1iDaaKC5b4iIaEUCuRGx9TKrASiJp1IY0YURTny0z3gzpj5c7obFWhL8lZPD35gAo3
         RPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iaFDFnvVtS1iWSBFrIIKUe+7Fko1T4rJ0OHw8pGokPc=;
        b=UwgYLQKnA7hAmQ4hyCqdXSpTthPEhefm2ZoqVW9GenbkXUhCidayLEK/MqKPmrvdi7
         mr1/l4TZry8xKjtIWK7qnWeLNaqfTa9Fh7wwXIr5tdf9JGElKZaje9dPKJhVpUJ7VEOm
         wM04QzLF54GjUOHigoRYF8L5K4z7XdoP0fqxxnB+AScfcBrF5g1CKdkduEiql0DQ12Nq
         94pW9EqbiJJKkbTSFUarU+MeQdMtde38VLoJMWN0eKtNm6G3v5IX+AZHWHDxvhBdBhJx
         UJJzAeTghp4NgCjqvg9ehxeRIFTx5Rrpz/orMN2w4Uveh+KiMRRuWzO1chxXY5jBWYq4
         iv8w==
X-Gm-Message-State: APjAAAXfAwmgWTDARfCooosAmLfLP0+i88Y0QQGT7EjRtMsyfpQpXEc5
        GtRpN/uzZ10Qke9diC5UTI4bHq9FuN4=
X-Google-Smtp-Source: APXvYqx+yh3Iadp8l8x5yFZGysITBwlj+gNULdwM6jjBvepbMk7WQhnCC99IjaETLKFpNyD41sTd9w==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr2564880wmc.100.1556616114786;
        Tue, 30 Apr 2019 02:21:54 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.187.71])
        by smtp.gmail.com with ESMTPSA id r2sm9694774wrr.65.2019.04.30.02.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 02:21:54 -0700 (PDT)
Subject: Re: [PATCH] bpftool: exclude bash-completion/bpftool from .gitignore
 pattern
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Sirio Balmelli <sirio@b-ad.ch>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
References: <1556549259-16298-1-git-send-email-yamada.masahiro@socionext.com>
 <ec1d2c14-ae27-38c7-9b79-4e323161d6f5@netronome.com>
 <CAK7LNARBOtOMr-=FRh0K1nMFLijRjRCMHYb0L=NY7KZQGydVrQ@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <ca18f97d-0a16-0c2f-2849-841633ad09cb@netronome.com>
Date:   Tue, 30 Apr 2019 10:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARBOtOMr-=FRh0K1nMFLijRjRCMHYb0L=NY7KZQGydVrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-30 09:15 UTC+0900 ~ Masahiro Yamada <yamada.masahiro@socionext.com>
> Hi Quentin,
> 
> 
> On Tue, Apr 30, 2019 at 12:33 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> 2019-04-29 23:47 UTC+0900 ~ Masahiro Yamada <yamada.masahiro@socionext.com>
>>> tools/bpf/bpftool/.gitignore has the "bpftool" pattern, which is
>>> intended to ignore the following build artifact:
>>>
>>>    tools/bpf/bpftool/bpftool
>>>
>>> However, the .gitignore entry is effective not only for the current
>>> directory, but also for any sub-directories.
>>>
>>> So, the following file is also considered to be ignored:
>>>
>>>    tools/bpf/bpftool/bash-completion/bpftool
>>>
>>> It is obviously version-controlled, so should be excluded from the
>>> .gitignore pattern.
>>>
>>> You can fix it by prefixing the pattern with '/', which means it is
>>> only effective in the current directory.
>>>
>>> I prefixed the other patterns consistently. IMHO, '/' prefixing is
>>> safer when you intend to ignore specific files.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>
>> Hi,
>>
>> “Files already tracked by Git are not affected” by the .gitignore (says
>> the relevant man page), so bash completion file is not ignored. It would
>> be if we were to add the sources to the index of a new Git repo. But
>> sure, it does not cost much to make the .gitignore cleaner.
> 
> Right, git seems to be flexible enough.
> 
> 
> But, .gitignore is useful to identify
> build artifacts in general.
> In fact, other than git, some projects
> already parse this.
> 
> For example, tar(1) supports:
> 
>       --exclude-vcs-ignores
>             read exclude patterns from the VCS ignore files
> 
> 
> As of writing, this option works only to some extent,
> but I thought this would be useful to create a source
> package without relying on "git archive".
> 
> When I tried "tar --exclude-vcs-ignores", I noticed
> tools/bpf/bpftool/bash-completion/bpftool was not
> contained in the tarball.
> 
> That's why I sent this patch.

Ok, thanks for explaining! Makes sense to me now.

> 
> I can add more info in v2 to clarify
> my motivation though.

Sounds good, yes please.

> 
> 
>>>
>>>   tools/bpf/bpftool/.gitignore | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
>>> index 67167e4..19efcc8 100644
>>> --- a/tools/bpf/bpftool/.gitignore
>>> +++ b/tools/bpf/bpftool/.gitignore
>>> @@ -1,5 +1,5 @@
>>>   *.d
>>> -bpftool
>>> -bpftool*.8
>>> -bpf-helpers.*
>>> -FEATURE-DUMP.bpftool
>>> +/bpftool
>>> +/bpftool*.8
>>> +/bpf-helpers.*
>>
>> Careful when you add all those slashes, however. "bpftool*.8" and
>> "bpf-helpers.*" should match files under Documentation/, so you do NOT
>> want to prefix them with just a "/".
> 
> OK, I should not have touched what I was unsure about.
> Will fix in v2.

Thanks!
Quentin

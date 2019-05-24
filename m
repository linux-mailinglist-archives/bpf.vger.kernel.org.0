Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47BA29F41
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbfEXTms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 15:42:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39243 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391705AbfEXTms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 15:42:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so2318317wrv.6
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43IUfCnxpXpsnzuA8gSqc+pIGFunYFX2EuH6EOR5DLQ=;
        b=NJtupTcLaT2cW/vkrnei1/681c0m+GmI/3p9qDs0hdG3aXbdI99elEAZMhZfZrbEkA
         g2RVv90tYbPzAwi9QKq0YlD5LiJ6fj9JQOvWfT0uY9KcyAwuLd2Rmr+xPpinYLqwXRJp
         UuJF437fEnqeCkCMVjNS8T3NR8F1NkA2qZEGjPX9ightvngE59J8pL/iwep+56xdijDC
         TP+TSFCeTUU7886zHMVkNN0M+t7kcPlG2MnOVdBiXqKf+5vAUfZ2dVA75+w9svrtCizC
         wik/QWYAbiXbWcQDRv6PaQ6A5mpzxZ0PPOAITqEz4kGeN0UxAFC0AMYfM6NUnfnxEQkp
         OY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43IUfCnxpXpsnzuA8gSqc+pIGFunYFX2EuH6EOR5DLQ=;
        b=OeJk0+HFR8OckYEO92agw3amxdr8u6KWxrJxIPgkxQNK50RF6329f+GUMf9xeJU47I
         YmTBOLMQSgxK9+5kgGwJxs6lzUUkqwsuW7o7gZd7o3IJ4rwAbaBzdCYuec9w1f5+AYDx
         44JyTikIIS2y5DffRYzhwsokSgMReeqYZCYYdo9Uz5+5D32WhQBw2nxgGOkcig5xLfTB
         4sPcsE1CtwTAptgZ3U2fy1/mZ460WAjM+UaMf9iLNR/WeDDwSJt8NNYsgPaFDRQcbXMu
         8nhiCvxdSTssF1Hsv7xnYtKSV5Kg483LYaOzy0/dTg2vGhhMv1+Cp/MVBxbmAk1M9u3/
         6iTA==
X-Gm-Message-State: APjAAAUT0U0IgSk1kJtpq96lWQSb0x5Gh/CXDXLIMyTVNMJT5lu06YCm
        qwnncgugtqdFIsOGErIVnNGwig==
X-Google-Smtp-Source: APXvYqzpIlf2ofjF6SPl6+AL92+/tejFo0dZqFikY3iSVcvr65b8l5IwDFJICt69uGsMKvSqdJZdQg==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr98541wrv.329.1558726966226;
        Fri, 24 May 2019 12:42:46 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id g13sm4009077wrw.63.2019.05.24.12.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:42:45 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 12/12] bpftool: update bash-completion w/ new
 c option for btf dump
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20190523204222.3998365-1-andriin@fb.com>
 <20190523204222.3998365-13-andriin@fb.com>
 <bf418594-0442-fe89-c86b-11d7e5269047@netronome.com>
 <CAEf4BzbfvV6HQ-NZQEk0yxNL75JWKC6nHzofOk6BkfO7EPVStQ@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <e20a1013-31b1-558e-1b1e-657fcd16901b@netronome.com>
Date:   Fri, 24 May 2019 20:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbfvV6HQ-NZQEk0yxNL75JWKC6nHzofOk6BkfO7EPVStQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 11:10 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, May 24, 2019 at 2:15 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> 2019-05-23 13:42 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
>>> Add bash completion for new C btf dump option.
>>>
>>> Cc: Quentin Monnet <quentin.monnet@netronome.com>
>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>> ---
>>>  tools/bpf/bpftool/bash-completion/bpftool | 25 +++++++++++++++++++----
>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>>> index 50e402a5a9c8..5b65e0309d2a 100644
>>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>>> @@ -638,11 +638,28 @@ _bpftool()
>>>                              esac
>>>                              return 0
>>>                              ;;
>>> +                        format)
>>> +                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
>>> +                            ;;
>>>                          *)
>>> -                            if [[ $cword == 6 ]] && [[ ${words[3]} == "map" ]]; then
>>> -                                 COMPREPLY+=( $( compgen -W 'key value kv all' -- \
>>> -                                     "$cur" ) )
>>> -                            fi
>>> +                            # emit extra options
>>> +                            case ${words[3]} in
>>> +                                id|file)
>>> +                                    if [[ $cword > 4 ]]; then
>>
>> Not sure if this "if" is necessary. It seems to me that if $cword is 4
>> then we are just after "id" or "file" in the command line, in which case
>> we hit previous cases and never reach this point?
> 
> Yep, you are right, removed.
> 
>>
>> Also, reading the completion code I wonder, do we have completion for
>> BTF ids? It seems to me that we have nothing proposed to complete
>> "bpftool btf dump id <tab>". Any chance to get that in a follow-up patch?
> 
> We currently don't have a way to iterate all BTFs in a system (neither
> in bpftool, nor in libbpf, AFAICT), but I can do that based on btf_id
> field, dumped as part of `bpftool prog list` command. Would that work?
> I'll post that as a separate patch.

Yes, I suppose it would. Unless there is a plan to add a "bpftool btf
dump" soon, in which case it could wait? But otherwise parsing "bpftool
prog list --pretty" (better parse JSON output, more stable) should be fine.

Thanks!

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63529F3F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391676AbfEXTmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 15:42:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54765 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732061AbfEXTmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 15:42:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so10470949wml.4
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ZKt4HzYFcDf2yg0C4VsBGkjfbaFkQ+RxR3Cl/S0XJM=;
        b=ihHpz+z+2EcA1lvk37jbs8+ZrRj7t6Sse5ogGJnDSKSrAZvyvHRdR/p3klDA1nr1yy
         +eijUO+X0sT1b5Dk2RKvCub6IdzdUdp9XMmIqcwkrCDAvJ3rcVS4210Kg/KHASnvsNy/
         uNT9JxFwxPsj9COCHuRm5cvnmGZjzW9vFVRpzGgpNIrdMnEyiCdL3AhVPMuIqUV1Vlgm
         V9O45Mz1ogF8xexcSZXfCOUVOZ6pWrUusmu+f9ZXakESC5vjCigJqWQVcRNOSedCbD80
         xOrh/TAEywkPNyrQUuhpVYn525PMgmiq8+ZZxcNkanGSaGSUBhqA8W2FYSgb5BteYScv
         2N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ZKt4HzYFcDf2yg0C4VsBGkjfbaFkQ+RxR3Cl/S0XJM=;
        b=E3q0Wk0tC97FMyZugU3LB1wFVSVBzTkIcBf3pIEoQMOQf0MT9kraROv/GwhsDumCF8
         jpV+O8946MjzjVeAx7QdvZx4BZ4WdD+NlZc/FXA1wyR4ip/VKFCkPMCxzLtohb/bVax9
         mi5WtY3Ros0a+JjsOGF2Tac88yus3Yxh7NysPV+eoGMYZ8Qv6wS13DV3xGmuHtVH6nCJ
         3GiuT2l1lW1fheXQpXz4g3O0R8pFym1rMACQUVv1bQyOI6xtMb0Et0ujNyre7/XzDE5o
         XWtadLIJJvIlvIaz8GTp59pzh6k7fgpYD0f+OKjPDJE38bI1G0x3vjGGYSAX+6ILbmYi
         iNrQ==
X-Gm-Message-State: APjAAAVb4IiZXWXCYQ7A1SgFBFMMQ1wTtmCV1cXmB9/WX8T0sXvCnY8x
        bbvpsJZRWIutOYkubHV8AYMA6Q==
X-Google-Smtp-Source: APXvYqytqzpEeh9HMsa4eid45vx8maUunn69paHPzme9mNdlNdPLTfi8GSYg0HicmWsj1+XJ3cUoYA==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr17616241wmj.105.1558726952904;
        Fri, 24 May 2019 12:42:32 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id f10sm5086745wrg.24.2019.05.24.12.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:42:32 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 11/12] bpftool/docs: add description of btf
 dump C option
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20190523204222.3998365-1-andriin@fb.com>
 <20190523204222.3998365-12-andriin@fb.com>
 <062aa21a-f14a-faf7-adf1-cd2e5023fc90@netronome.com>
 <CAEf4BzZSLSDv-Hr47HrrboDAscW166JCERGs6eRPijkCqzzb7g@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <017b901f-f942-77dd-4d85-b8a7f9ee79a6@netronome.com>
Date:   Fri, 24 May 2019 20:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZSLSDv-Hr47HrrboDAscW166JCERGs6eRPijkCqzzb7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 10:25 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, May 24, 2019 at 2:14 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> 2019-05-23 13:42 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
>>> Document optional **c** option for btf dump subcommand.
>>>
>>> Cc: Quentin Monnet <quentin.monnet@netronome.com>
>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>> ---
>>>  tools/bpf/bpftool/Documentation/bpftool-btf.rst | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
>>> index 2dbc1413fabd..1aec7dc039e9 100644
>>> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
>>> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
>>> @@ -19,10 +19,11 @@ SYNOPSIS
>>>  BTF COMMANDS
>>>  =============
>>>
>>> -|    **bpftool** **btf dump** *BTF_SRC*
>>> +|    **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
>>>  |    **bpftool** **btf help**
>>>  |
>>>  |    *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
>>> +|       *FORMAT* := { **raw** | **c** }
>>
>> Nit: This line should use a tab for indent (Do not respin just for that,
>> though!).
> 
> Oh, I didn't notice that. My vim setup very aggressively refuses to
> insert tabs, so I had to literaly copy/paste pieces of tabulations :)
> Fixed it.

I can relate :). On my (vim) setup, I can usually hit Ctrl+V then <Tab>
to insert tabulations in that case.

> 
>>
>>>  |    *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
>>>  |    *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
>>>
>>> @@ -49,6 +50,10 @@ DESCRIPTION
>>>                    .BTF section with well-defined BTF binary format data,
>>>                    typically produced by clang or pahole.
>>>
>>> +                  **format** option can be used to override default (raw)
>>> +                  output format. Raw (**raw**) or C-syntax (**c**) output
>>> +                  formats are supported.
>>> +
>>
>> Other files use tabs here as well, but most of the description here
>> already uses spaces, so ok.
> 
> Yeah, thanks for pointing out, fixed everything to tabs + 2 spaces, as
> in other files (unclear why we have extra 2 spaces, but not going to
> change that).

Thanks!

> 
>>
>>>       **bpftool btf help**
>>>                 Print short help message.
>>>
>>>
>>


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F96DF732
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDLNa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDLNa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 09:30:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F729777
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 06:29:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so14120426wmb.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681306197; x=1683898197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RLH3cNNkgWH+LFhzC/1IC1LxduOToc5Jr5Y7ubniO8=;
        b=ZUrcHn5MVn4SkZsdduPKHzdhBR2CyCpmJbBBzf7ziFg2joAPVET6lPUYfvSfAddSmi
         F8MjJZ9OD1SV1fB2FUMzx0jUNBMPKAF+gsz4PJ3CWO55eECJR5j2rNg49jZhhwPO2E3D
         ifZD9y/+vyJ5WaQ3Y9PycYB0xwCFp6fZTYBo2GBKYDEfP8ZtMHhX4CKGN5K7/tQgrHS0
         0P+tacH7ZIkTgC7DG8clkoQ0GzfGwb/F4cDsYDNQxejrUJCPCEtNGiDw2JuO609CO/ea
         z/ce/pSpZu4jH9iMpr/RQgCO9HO2S9N8sEN1OfrFBKdru+Xqoy3SjOXZahzYs8mI0rO4
         us8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306197; x=1683898197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RLH3cNNkgWH+LFhzC/1IC1LxduOToc5Jr5Y7ubniO8=;
        b=LtA9CwkEhCetgEqiXXoVKvN+u2ugJ/B//qcN8khm/kZ6uBafpkjoQV8O94j959pP+x
         EQGr8YFQFcfJmAWb4Qwt8pv94ARqQHszBOxtqN9qjxuK7mJHZLthBxwuKAIgpIStRLc3
         cuSne31sK3q0ywRzoOUCQcU3hSqiWvxJxEX/+XEqQogGW+mBQH29CirbgPN74EkMMRVt
         hLFTvY653Y2CrbQIO/HvHFmYA+Z5Z13wkp5wK6K2m2ttoZgHPpDvwWd5UFdySzGE3WEi
         9+1ZLwbSJwQPuNZA0AE7OTnJUtSavHV25JRKQl8JZ/Lt21nJEFFZl0/XFq+0ujJBS95i
         EZcQ==
X-Gm-Message-State: AAQBX9eRshl7Imu7W0WZ29yw8r61S/3lbmL14n+j5P9lwZFyW5sdIX/F
        kXGHkObzT+X+zwfoU2DQueLwzA==
X-Google-Smtp-Source: AKy350YyP5/puNSrFijXT8q/UFD1BUDayswgpA13La5ADlCI+vRXWiFttTIg2nF9406VSK5lNscn9A==
X-Received: by 2002:a05:600c:c4:b0:3ed:f5d4:3bff with SMTP id u4-20020a05600c00c400b003edf5d43bffmr12634760wmm.38.1681306197675;
        Wed, 12 Apr 2023 06:29:57 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:53b:acfc:bce0:dc7d? ([2a02:8011:e80c:0:53b:acfc:bce0:dc7d])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003ef67848a21sm2516085wms.13.2023.04.12.06.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:29:56 -0700 (PDT)
Message-ID: <ce290fa8-9ff3-e53c-85ad-a742ca76e677@isovalent.com>
Date:   Wed, 12 Apr 2023 14:29:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v3 3/7] bpftool: Support inline annotations when
 dumping the CFG of a program
Content-Language: en-GB
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        linux-s390@vger.kernel.org
References: <20230405132120.59886-1-quentin@isovalent.com>
 <20230405132120.59886-4-quentin@isovalent.com>
 <yt9d8rexy6uj.fsf@linux.ibm.com>
 <15cd553a-a6c1-19c7-bab1-0212a856056f@isovalent.com>
 <yt9dttxlwal7.fsf@linux.ibm.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <yt9dttxlwal7.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-04-12 14:26 UTC+0200 ~ Sven Schnelle <svens@linux.ibm.com>
> Quentin Monnet <quentin@isovalent.com> writes:
> 
>> 2023-04-12 08:04 UTC+0200 ~ Sven Schnelle <svens@linux.ibm.com>
>>> Quentin Monnet <quentin@isovalent.com> writes:
>>>
>>>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
>>>> index e7f6ec3a8f35..583aa843df92 100644
>>>> --- a/tools/bpf/bpftool/btf_dumper.c
>>>> +++ b/tools/bpf/bpftool/btf_dumper.c
>>>> @@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
>>>>  					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>>>>  	}
>>>>  }
>>>> +
>>>> +static void dotlabel_puts(const char *s)
>>>> +{
>>>> +	for (; *s; ++s) {
>>>> +		switch (*s) {
>>>> +		case '\\':
>>>> +		case '"':
>>>> +		case '{':
>>>> +		case '}':
>>>> +		case '<':
>>>> +		case '>':
>>>> +		case '|':
>>>> +		case ' ':
>>>> +			putchar('\\');
>>>> +			__fallthrough;
>>>
>>> Is __fallthrough correct? I see the following compile error on s390 in
>>> linux-next (20230412):
>>>
>>>   CC      btf_dumper.o
>>> btf_dumper.c: In function ‘dotlabel_puts’:
>>> btf_dumper.c:838:25: error: ‘__fallthrough’ undeclared (first use in this function); did you mean ‘fallthrough’?
>>>   838 |                         __fallthrough;
>>>       |                         ^~~~~~~~~~~~~
>>>
>>> removing the two underscores fixes this.
>>
>> I thought so? Perf seems to use the double underscores as well. Just
>> "fallthrough" does not seem to be the right fix anyway, it gives me an
>> error similar to yours on x86_64 with "fallthrough" undeclared.
>>
>> The definition should be pulled from tools/include/linux/compiler.h (and
>> .../compiler-gcc.h). I thought this file would be at least included from
>> bpftool's main.h, in turn included in btf_dumper.c. Looking at the chain
>> of inclusions, on my system I get the following path:
>>
>>     $ CFLAGS=-H make btf_dumper.o
>>     [...]
>>     . /root/dev/linux/tools/include/linux/bitops.h
>>     [...]
>>     .. /root/dev/linux/tools/include/linux/bits.h
>>     [...]
>>     ... /root/dev/linux/tools/include/linux/build_bug.h
>>     .... /root/dev/linux/tools/include/linux/compiler.h
>>     ..... /root/dev/linux/tools/include/linux/compiler_types.h
>>     ...... /root/dev/linux/tools/include/linux/compiler-gcc.h
>>     [...]
>>
>> What do you get on your side?
>>
>> If you add "#include <linux/compiler.h>" to btf_dumper.c directly, does
>> it fix the issue?
> 
> This seems to clash with:
> 
> commit f7a858bffcddaaf70c71b6b656e7cc21b6107cec
> Author: Liam Howlett <liam.howlett@oracle.com>
> Date:   Fri Nov 25 15:50:16 2022 +0000
> 
>     tools: Rename __fallthrough to fallthrough
> 
>     Rename the fallthrough attribute to better align with the kernel
>     version.  Copy the definition from include/linux/compiler_attributes.h
>     including the #else clause.  Adding the #else clause allows the tools
>     compiler.h header to drop the check for a definition entirely and keeps
>     both definitions together.
> 
>     Change any __fallthrough statements to fallthrough anywhere it was used
>     within perf.
> 
>     This allows other tools to use the same key word as the kernel.
> 
> Which was also merged in linux-next.

Right, I was not aware of this commit. In that case, replacing with
"fallthrough" in linux-next makes sense indeed.

Thomas Richter just submitted that fix at
https://lore.kernel.org/all/20230412123636.2358949-1-tmricht@linux.ibm.com/.

Thanks!
Quentin

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73A56DF4A6
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDLMFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjDLMFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 08:05:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198D61B5
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 05:05:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id he13so11376142wmb.2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681301103; x=1683893103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qu+3Eavq+im76sF/3GBedLORPT2lKdASUzHwpmJBhSU=;
        b=dt1kX3HOp6B1tEBcX+BVh6cwDf7BNAawDd2Dy2wcM+4fprs3flFeRbNUpLrO5RaRj1
         R1CvMl89KY7smBw7DNZ+MoP00As9xRtowid+CDJnojXBiCyDesF7VDaA91WrwM53RnOm
         83TY26MUOdP/lftnkst06wsFA8HGfU5lkPQf3Qu2pciyI3lzlSHqY0UXE90sd3FPnwMz
         RMfh/FEMrAnDhMKCGP1Ea93rNYSMJbW0qi/ePWobQ27YyyHpcXJVBDa9TuCLQtiafrXC
         osv/A6f9sMpdu0Y1x9Ta1H9imF6Mxt2bLZbXtHq7BbyVtACMrbD2g20hRC3qYBbe2J7p
         fmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681301103; x=1683893103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qu+3Eavq+im76sF/3GBedLORPT2lKdASUzHwpmJBhSU=;
        b=H53f95z+Ef2O64okNoAQl4QEXLd4kRJxtUqLSpCbpflXhxGZh47JYtIqVDa7Zkznm/
         sBS1a3aBwO/Fx/S+kN6JnEAdYMMxgSFWeZ5e85897CX9viVi9HmvSx/nAQ/qVNAS4Xj9
         dCOYxbL4TaytBTiProFF6VAQr8rJsUqPwWmGcIP0OHsVKF/0BaCJW3PyDj/jH2btICjI
         QOO+oBatYmRCzTJOLJ0Gdwl+Zr6Fsi6V5LkvA6RNGkLh7La9wKDBphv5Mkw7TPekrFhm
         l16HUDuEfCqMgCcL8+HgfO6gPEinbbpQhED2MZngyyUa48b1J5kAOOpmTXJg3JGQezAt
         IDRg==
X-Gm-Message-State: AAQBX9dGBtqPya77hG7KpOAkCpIJf/YMNXD4WehDvGw1LZe7Vt8aRh82
        y0vFmrZOEr0Q8o8jJ9N8ZI75nQ==
X-Google-Smtp-Source: AKy350as6xSaC5VjVVblauda90x/WFKQsM48F5Aud2q7moLRrRn/Z02mIrohUZrKFeO6k299RQGGdA==
X-Received: by 2002:a7b:cd9a:0:b0:3ed:30cb:5569 with SMTP id y26-20020a7bcd9a000000b003ed30cb5569mr8852774wmj.20.1681301102759;
        Wed, 12 Apr 2023 05:05:02 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:53b:acfc:bce0:dc7d? ([2a02:8011:e80c:0:53b:acfc:bce0:dc7d])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c294800b003ee10fb56ebsm2194307wmd.9.2023.04.12.05.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:05:02 -0700 (PDT)
Message-ID: <15cd553a-a6c1-19c7-bab1-0212a856056f@isovalent.com>
Date:   Wed, 12 Apr 2023 13:05:01 +0100
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
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <yt9d8rexy6uj.fsf@linux.ibm.com>
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

2023-04-12 08:04 UTC+0200 ~ Sven Schnelle <svens@linux.ibm.com>
> Quentin Monnet <quentin@isovalent.com> writes:
> 
>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
>> index e7f6ec3a8f35..583aa843df92 100644
>> --- a/tools/bpf/bpftool/btf_dumper.c
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
>>  					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>>  	}
>>  }
>> +
>> +static void dotlabel_puts(const char *s)
>> +{
>> +	for (; *s; ++s) {
>> +		switch (*s) {
>> +		case '\\':
>> +		case '"':
>> +		case '{':
>> +		case '}':
>> +		case '<':
>> +		case '>':
>> +		case '|':
>> +		case ' ':
>> +			putchar('\\');
>> +			__fallthrough;
> 
> Is __fallthrough correct? I see the following compile error on s390 in
> linux-next (20230412):
> 
>   CC      btf_dumper.o
> btf_dumper.c: In function ‘dotlabel_puts’:
> btf_dumper.c:838:25: error: ‘__fallthrough’ undeclared (first use in this function); did you mean ‘fallthrough’?
>   838 |                         __fallthrough;
>       |                         ^~~~~~~~~~~~~
> 
> removing the two underscores fixes this.

I thought so? Perf seems to use the double underscores as well. Just
"fallthrough" does not seem to be the right fix anyway, it gives me an
error similar to yours on x86_64 with "fallthrough" undeclared.

The definition should be pulled from tools/include/linux/compiler.h (and
.../compiler-gcc.h). I thought this file would be at least included from
bpftool's main.h, in turn included in btf_dumper.c. Looking at the chain
of inclusions, on my system I get the following path:

    $ CFLAGS=-H make btf_dumper.o
    [...]
    . /root/dev/linux/tools/include/linux/bitops.h
    [...]
    .. /root/dev/linux/tools/include/linux/bits.h
    [...]
    ... /root/dev/linux/tools/include/linux/build_bug.h
    .... /root/dev/linux/tools/include/linux/compiler.h
    ..... /root/dev/linux/tools/include/linux/compiler_types.h
    ...... /root/dev/linux/tools/include/linux/compiler-gcc.h
    [...]

What do you get on your side?

If you add "#include <linux/compiler.h>" to btf_dumper.c directly, does
it fix the issue?

Quentin

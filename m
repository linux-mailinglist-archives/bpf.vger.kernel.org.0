Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1815665EA4
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAKPCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 10:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjAKPCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 10:02:19 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974E1C432;
        Wed, 11 Jan 2023 07:02:17 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id c133so12934458oif.1;
        Wed, 11 Jan 2023 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0egSRlD5ysAF1/1Mcrzc43lEP8kki52Q/tp1KL0aFq0=;
        b=JTRokcX3zaOOa5DZ0ocv+qAiNLHN7v+XuqXLh2ziEGBWUateS/D4TGVet0Zwm2i2A3
         EqWWhy5jwA3vxH3xmmrWHlmpHypTsUMkT/AuH/bR+YPy3NlEQNnMRTmsMrRy5oa1scgv
         nj22zJKb0qW5fzEasQIf2ykHCDGPKEdXGBtlgPkRGxy4bTY6+EoRZukOh1kdpVLToTWs
         dNSlde+evDr3RAcQJYdoCS9NzqCXpTw8dYKYRt6DHZK6AZCOOyb7fx6XY55rlJsukgGs
         N8yvTICMHBnPlrxUvtT0GzGPthYxWLBPzDGl+/caPJYUlHahaBcecxGf+WEamOPFbc6C
         FVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0egSRlD5ysAF1/1Mcrzc43lEP8kki52Q/tp1KL0aFq0=;
        b=ewRNeZKkfTKrR5fI5vcBLuXvv2KsMtp9H5MACMyhdjTvdRLqQZcr3kPNTXXPHmmGgj
         6vW2WcsFmEFdjnWnt88C6nDjj5l4HmwgNI6cC5/PIcyAr4rmrKE23blhddA1tjoOlz6l
         LfmKqeNuh4wxOtjDFUAjjuoINyPn1aotRwpNvYoCHAmvHWhegyq3Eje0RR5x6Wnmkjgl
         cYobAdXcCac9+E49qAIgbywJJ7cA/9/Ox1ZJqlw/xdJUNB8RHKQW5x7UUxWZWwVgczrP
         ZtFD8OMhZ6qFqJkv/9uhoyEe5UQJOPjEfFEFRHplkG0ifk6qUAWYD/qtJY5ZgrwnBXya
         8Qng==
X-Gm-Message-State: AFqh2kqtXRs293VaoWjVtqicAino4oZqAuZbYUzjyFKRLPGFPxcL5j8V
        HZ+DW3eOvtJMBTZ5rT6lTJI=
X-Google-Smtp-Source: AMrXdXsJ68tmNlldOty2WkVziBaah7VubXfqbSPrUVre3rpkZtb+MXnE0CNjRpQ5vpLhanXefNOLww==
X-Received: by 2002:a05:6808:28e:b0:35e:e530:a07b with SMTP id z14-20020a056808028e00b0035ee530a07bmr31314497oic.57.1673449337028;
        Wed, 11 Jan 2023 07:02:17 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id bi38-20020a05680818a600b00353fe4fb4casm6690322oib.48.2023.01.11.07.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:02:16 -0800 (PST)
Message-ID: <68c81196-5421-8731-52be-b9b620837eb5@gmail.com>
Date:   Wed, 11 Jan 2023 12:02:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] scripts: Exclude Rust CUs with pahole
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20230108021450.120791-1-yakoyoku@gmail.com>
 <CAOgh=Fzc3_bCLCKE+6KVzyMbBUOcQ_s9ef6Rw33amD5+yu-_WA@mail.gmail.com>
 <CAOgh=FxxXQ0UV_3PEGS-_575WNfR2SpKp+i78HtSVX4XO4eC0A@mail.gmail.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAOgh=FxxXQ0UV_3PEGS-_575WNfR2SpKp+i78HtSVX4XO4eC0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/8/23 16:19, Eric Curtin wrote:
> On Sun, 8 Jan 2023 at 15:18, Eric Curtin <ecurtin@redhat.com> wrote:
>>
>> On Sun, 8 Jan 2023 at 02:15, Martin Rodriguez Reboredo
>> <yakoyoku@gmail.com> wrote:
>>>
>>> [ ... ]
>>
>> If it was me, I would do things more like v1 of the patch (instead
>> just checking pahole version), because this is the only flag set in
>> scripts/Makefile.modfinal, which is a little confusing and
>> inconsistent. It's ok to set --lang_exclude=rust in all cases, as long
>> as pahole_ver is recent enough.
>>
>> +if [ "${pahole_ver}" -ge "124" ]; then
>> +       # see PAHOLE_HAS_LANG_EXCLUDE
>> +       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>> +fi
>>
>> But I'm not too opinionated either on this so...
>>
>> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
>>
>> can be reapplied. I'm gonna test this again to see if it works in a
>> Fedora Asahi rpm build.
> 
> After testing I probably have to retract my Reviewed-by tag,
> apologies, bpf and all that did not work with this patch when I built
> in the fedora way, but, the good news is when I alter v1 of the patch
> to just check pahole version like so (instead of the is_enabled
> check):
> 
> +if [ "${pahole_ver}" -ge "124" ]; then
> +        # see PAHOLE_HAS_LANG_EXCLUDE
> +        extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> +fi
> 
> it worked just fine, and that should satisfy the testbot and all the
> other ways we build too. Could we change to that @Martin Rodriguez
> Reboredo ?
> 

From my POV I don't like this way due to it being set regardless whether
or not you are building the kernel with Rust. Though, because it doesn't
affect non `CONFIG_RUST` builds, I _think_ it won't hurt if we use that
way for now. Gonna send v3.

>>
>>
>>> +
>>>         vmlinux_link ${1}
>>>
>>>         info "BTF" ${2}
>>> --
>>> 2.39.0
>>>
> 

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BC5B064E
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGOUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIGOUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 10:20:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5577332F
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 07:20:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 186-20020a1c02c3000000b003b26feb5c6bso811107wmc.5
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=efygqwxNvo9v+jOGudhVa8fyLoOuSMvJl9Lz6PO309M=;
        b=Yh2IOXoPSDFS5qQlxKicSC/gGU6TNhXGVDRf2eR67+aWbOgXvVBaTAf6iSlkdtG7km
         2yu80jofWx80fuTd/6zP7ZyNSmFXz//TP8QlB27h++zreVzS8IdPVh0CBrKGnZHN874p
         TDimH0XX+MP36v/nfMW7STg11epNjN07w88CfGsf9/Rm2uCJ8ps6GbIUYPsBT3C9LxlO
         IbwLXqLa9FNGcHHZ0nVX+vG7HJPO0TEB2Yn8Tt4sY0eQiZJ+QFO4VgYCQwm9V0eyCvMG
         cGlQBkK7Du88IkqA75Du8aBAFA0mRobkiPTeoBjOuEgeQ6d40Mytgw4fCBwZ2JOZEaCh
         F/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=efygqwxNvo9v+jOGudhVa8fyLoOuSMvJl9Lz6PO309M=;
        b=HxAhf0mh/scUb8qOlB8OllNC3eLkoZX2MPrYq0C87u8FQuyP+gu6HlNt3cgdT3WVtN
         46UET4HrdBQRuUn2t15bT5UYOhadSMq8GbrMpl+Ytze46VfDwJuA5jv3SQ25or0dtjGN
         Ujor19R82Y4puNOHe+j77tUuetAHvoPaHNWwZ4vx3ArR5WFp1hdZMqQNaLYP5sckuq1c
         ox7wprQs6XWctRyXnT1m2M+fXGEjo8XR6wAu1WIKEG/KbjWk/fNgF8ZaWJ5O4o+bVK5u
         2nNhBJnBhOLCre1XM2dLVdVgPWCy1yIkmduiP7gZ9Mmg/pL8IITZ/nSsL128xpPiWQR+
         Bp0g==
X-Gm-Message-State: ACgBeo0Wvj2l5qJlXlY8QUHxOttsw2VFiPXwtBtCKH7CtpiknuHMYaLU
        YweAjZJKezJcm8D5z2p8BMBJ1A==
X-Google-Smtp-Source: AA6agR7p+qdHTsQgvthox0mPTdo+T02UoZpV644zqpWkI/+SWQBwMyZ86t3C/brVRNHO/D7EiSF2Hw==
X-Received: by 2002:a05:600c:4e92:b0:3a5:fd90:24e3 with SMTP id f18-20020a05600c4e9200b003a5fd9024e3mr17334977wmq.59.1662560442612;
        Wed, 07 Sep 2022 07:20:42 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d6dcf000000b00225307f43fbsm18028658wrz.44.2022.09.07.07.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:20:42 -0700 (PDT)
Message-ID: <8b0de52e-84e8-c098-113d-5b5b9cdfd22e@isovalent.com>
Date:   Wed, 7 Sep 2022 15:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-GB
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
 <20220906133613.54928-7-quentin@isovalent.com>
 <CAPhsuW6iH0qFfJFxcWfGAnsD1FqOM_ThZLp5H+MARvkBxq8K7w@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAPhsuW6iH0qFfJFxcWfGAnsD1FqOM_ThZLp5H+MARvkBxq8K7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/09/2022 01:06, Song Liu wrote:
> On Tue, Sep 6, 2022 at 6:46 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
> [...]
>> +
>> +static int
>> +init_context(disasm_ctx_t *ctx, const char *arch,
>> +            __maybe_unused const char *disassembler_options,
>> +            __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
>> +{
>> +       char *triple;
>> +
>> +       if (arch) {
>> +               p_err("Architecture %s not supported", arch);
>> +               return -1;
>> +       }
> 
> Does this mean we stop supporting arch by default (prefer llvm
> over bfd)?

We do drop support in practice, because the "arch" is only used for nfp
(we only use this when the program is not using the host architecture,
so when it's offloaded - see ifindex_to_bfd_params() in common.c), and
LLVM has no support for nfp.

Although on second thought, it would probably be cleaner to set the arch
anyway in the snippet above, and to let LLVM return an error if it
doesn't know about it, so that we don't have to update bpftool in the
future if a new arch is used for BPF offload. I can update for the next
iteration.

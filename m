Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619805B0644
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIGOTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIGOTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 10:19:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580272B43
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 07:19:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e20so20599315wri.13
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sodpHj1nIP07vqsEaq2PzVXSStEprr5UpEkp1B56WCU=;
        b=ZdDGqGMhxoOiJn+zJqGqi73ZCWT4Qjipj08I2i4xUNBlwED/yQfy/B6ZDERRunZ7Sf
         mAThk37RvJlh+ypKOgQAnv6RdpX4k1yVol5E6ygTD9uwHnPAoOX+hT88qYcKFQX+YF7F
         BJ2siC4GwaTblZG0+dDDag/946v57/vahhrvJU0tcjTavFfvUEji6cb4D9dEUbLmZbpk
         uiH8/Bt/ba4UpzO+iQPH0v619Yhxc94b7VGhtaSIkekmso13Kjla3HgzK+X6hNnJEyYx
         bv36DoT6I1W2tQN2P9z7Hh+KJFt8JcNphyYM1PKVKhVzdjZvBBel8kGSqdi2HOm6VsxO
         agpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sodpHj1nIP07vqsEaq2PzVXSStEprr5UpEkp1B56WCU=;
        b=eICC6cGND8Rh+O4SCMIOElsnXcBf48v81FI+GgYT32tcU/RxecVW/VFJamTzOCv/re
         b1vR777psMaLXxqjIHa64HIxvYlyrb63a1zVj5zWwf7tkrDEzE9bOtVz/Uw8uP94FiWc
         0Awcg9qmcOwnTYGcQOh297y+HS8GkDNzT9TMkNhQ4N2HiexHsO4QtoL3bTLuVrRqme+2
         MOZ+cq52tsHbAoNUlQv2CaltghgS5s/fzaG3qZz9HQZK+cuavinnUbHOzrHS0kIWvVv3
         SVSx5eRoc7Ao3ffza5cNrVwIG67ICHlQJ8oekn+Sy5v54I6K/tLiVuM+CsLk3Zpl23yZ
         4yaQ==
X-Gm-Message-State: ACgBeo1SrBhpOepcqVdP4aQEBbgg7Ml9mlbDxJ5vdWriuljXdQLoqWm4
        iIvgr0xyBsl+EYK919lWgsVaJg==
X-Google-Smtp-Source: AA6agR520f7t4ca0c9TwSMQ9jQbpQzYrEot3cT0ehrz0XqHPpnpJrEMeVyFO0c3KMwJm13Wl+GTRIg==
X-Received: by 2002:a05:6000:1361:b0:228:dc47:8a49 with SMTP id q1-20020a056000136100b00228dc478a49mr2439096wrz.50.1662560342856;
        Wed, 07 Sep 2022 07:19:02 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d5-20020adfa345000000b00228610d8efcsm15412120wrb.35.2022.09.07.07.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:19:02 -0700 (PDT)
Message-ID: <65d37b4e-7261-6ea9-839a-5f8aa259139f@isovalent.com>
Date:   Wed, 7 Sep 2022 15:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH bpf-next 4/7] bpftool: Group libbfd defs in Makefile, only
 pass them if we use libbfd
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
 <20220906133613.54928-5-quentin@isovalent.com>
 <CAPhsuW6DXecC3OsjrL7na-OHM=B6KfhEx5P21en+-QRN-RU_UQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAPhsuW6DXecC3OsjrL7na-OHM=B6KfhEx5P21en+-QRN-RU_UQ@mail.gmail.com>
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

On 07/09/2022 00:31, Song Liu wrote:
> On Tue, Sep 6, 2022 at 6:44 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
> [...]
> 
>>
>> +# If one of the above feature combinations is set, we support libbfd
>>  ifneq ($(filter -lbfd,$(LIBS)),)
>> -CFLAGS += -DHAVE_LIBBFD_SUPPORT
>> -SRCS += $(BFD_SRCS)
>> +  CFLAGS += -DHAVE_LIBBFD_SUPPORT
>> +
>> +  # Libbfd interface changed over time, figure out what we need
>> +  ifeq ($(feature-disassembler-four-args), 1)
>> +    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
>> +  endif
>> +  ifeq ($(feature-disassembler-init-styled), 1)
>> +    CFLAGS += -DDISASM_INIT_STYLED
>> +  endif
>> +endif
> 
> 
>> +ifeq ($(filter -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
>> +  # No support for JIT disassembly
>> +  SRCS := $(filter-out jit_disasm.c,$(SRCS))
>>  endif
> 
> This part could just be an else clause for the ifneq above.
> Well, I guess the difference is minimal.

True for this patch, but please see patch 6 with the LLVM support: the
ifneq above gets embedded in an outer if/else block (we only run it if
LLVM is not found), whereas removing jit_disasm.c from the sources
occurs when none of the two libs is available.

Ideally we'd have "if LLVM ... else if libbfd ... else remove
jit_disasm.c", but the check on libbfd involved checking multiple
features so I didn't find a simple way to write that in Makefile syntax
and thought it more readable to have a separate block for jit_disasm.c.

> 
> Acked-by: Song Liu <song@kernel.org>

Thanks for the review!

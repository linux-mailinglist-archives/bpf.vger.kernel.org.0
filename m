Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587B24A7862
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 19:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiBBS6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 13:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiBBS6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 13:58:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB481C061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 10:58:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n10so556796edv.2
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 10:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rB8ZdVoGVZMC/cNrDG3bzW7SJfmUBxnNvvX26mlUlME=;
        b=R26QS7rvsDaMOAspbTbv7DJouKK1ZgWIXY7E1Q6FSiEU/EWHZ7xkwuUUxwbliUx0eL
         UfreNa/LA+NWOlqkw05VPsaWU9HkMXw1V1g0A+ZtjximR6CblL2jBeCjovPr4/lK1SOX
         DnMV++7VykVpC/hS+pnSnb7dOJI2Pa5i0IEB4NJ4dx0K/zuabw2QJ1vPn4FQBavifCIt
         OjhItmuAAXPraCwbMfXArYFZ5LVddRkm/i6VVfYgmAcUgiHL7D19HHXjXiUmiR6zZ+M7
         M8VZVkygUZWNLxt1jkI6dTf22LcCu7sKzpC7awfCdrBzl8Rzphr/3So+0NRQTRhM+zB9
         AGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rB8ZdVoGVZMC/cNrDG3bzW7SJfmUBxnNvvX26mlUlME=;
        b=3SHUqUSxEVLAE9A7cQIdLN7iWJ5ANJLgsVs1a+E51V7Hpyxd8ExTl9smjyWWxAH1K+
         RB+OEG5axeh9QHChyh/Tm+SQdpQC/xhk7EM9R1wQ5CoMObJ0j/Px1eFqAJvziRVBpgwD
         YTafUN2TZuhxIuyY4JsfTF01uLlnl2YieOgkAz0BCw/+O15FgHur6Ai3cDeNbDGgy5si
         E5F7F6/u0xxw8dnC7cikDreiCiDX306vsdhuIEJS4wVdmoYk2Tk5gfESDUSNDuSX79xH
         YSOdDwiqObtsLbMqMuJrEv9uApTH17TFP9eUqlfGBX6tTXiPrCvm4cqxpvAF7cm0p/Lb
         VPKg==
X-Gm-Message-State: AOAM532q3aZZaNBC+S6EAxYyfhf81+CPopugnVai4iPa0tk4t93KyBGg
        n0Gygt2PKotowhfjoEi4vzLjSA==
X-Google-Smtp-Source: ABdhPJy96jVtM3I08BObzdXWcWpMxPrDyrCq7ovJaLCH8/t2cNJWAZsYHxoHIHmJ57CIPJE+AWN3KQ==
X-Received: by 2002:a50:baa8:: with SMTP id x37mr10359751ede.450.1643828331237;
        Wed, 02 Feb 2022 10:58:51 -0800 (PST)
Received: from [192.168.1.8] ([149.86.76.131])
        by smtp.gmail.com with ESMTPSA id v10sm21187526edx.36.2022.02.02.10.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:58:49 -0800 (PST)
Message-ID: <3fa2268a-274c-1454-7f7d-1e1b55e38119@isovalent.com>
Date:   Wed, 2 Feb 2022 18:58:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next 2/3] bpftool: Add libbpf's version number to
 "bpftool version" output
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20220131211136.71010-1-quentin@isovalent.com>
 <20220131211136.71010-3-quentin@isovalent.com>
 <CAEf4BzbmXbJzwK1uCRmg+iwX+4TrENNac=WB_eCNSsYtMDALNw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzbmXbJzwK1uCRmg+iwX+4TrENNac=WB_eCNSsYtMDALNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-01 22:59 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Mon, Jan 31, 2022 at 1:11 PM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> To help users check what version of libbpf has been used to compile
>> bpftool, embed the version number and print it along with bpftool's own
>> version number.
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>  tools/bpf/bpftool/Documentation/common_options.rst | 3 ++-
>>  tools/bpf/bpftool/Makefile                         | 2 ++
>>  tools/bpf/bpftool/main.c                           | 3 +++
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
>> index 908487b9c2ad..24166733d3ae 100644
>> --- a/tools/bpf/bpftool/Documentation/common_options.rst
>> +++ b/tools/bpf/bpftool/Documentation/common_options.rst
>> @@ -4,7 +4,8 @@
>>           Print short help message (similar to **bpftool help**).
>>
>>  -V, --version
>> -         Print version number (similar to **bpftool version**), and optional
>> +         Print bpftool's version number (similar to **bpftool version**), the
>> +         version of libbpf that was used to compile the binary, and optional
>>           features that were included when bpftool was compiled. Optional
>>           features include linking against libbfd to provide the disassembler
>>           for JIT-ted programs (**bpftool prog dump jited**) and usage of BPF
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 83369f55df61..bd5a8cafac49 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -42,6 +42,7 @@ LIBBPF_BOOTSTRAP_INTERNAL_HDRS := $(addprefix $(LIBBPF_BOOTSTRAP_HDRS_DIR)/,hash
>>  ifeq ($(BPFTOOL_VERSION),)
>>  BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
>>  endif
>> +LIBBPF_VERSION := $(shell make -r --no-print-directory -sC $(BPF_DIR) libbpfversion)
>>
> 
> why can't you use libbpf_version_string() API instead?

I missed it somehow, thanks for the pointer. It seems to be a recent
addition to libbpf, and it was probably not present last time I checked
for such an API. I'll use it.

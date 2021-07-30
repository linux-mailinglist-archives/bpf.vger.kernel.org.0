Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2F3DC066
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhG3Vsq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhG3Vs2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 17:48:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE4C061765
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:48:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso3614352wms.1
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6YN1J9vmLUXCKWdwBvhu6EMYabwP3L6uMfluwtn0R3A=;
        b=c3mmn9++MAOPBsxBE4zfM9z3wJVdVzoag+AB1FYJ3QLZEZc2RWZVkgFbokBEe0sVWj
         yivSGt3NX4cmPokSjEkqAJYd3iOnN36L3hsg7ka9EKFzoMqlAlM9Pz+8FWb8hpEpJmQA
         j3j3ofsurRtgETgpa89z8dbuLbHJ7TixqHy6OvNp0SbANRgRVVrO6wriBPfr04nb9LK2
         qGoOCEizKukGqX6Jr02Ypya8RNjjrKiwKUKQRzqJuWgAIhF9lTBbsDuOwTxxd5woG9zw
         pvHQl8UqZ/+eAXpH8x2Fq5rm/D8BGRBduunhGcZptoduWOqhbrGpqMLecPQxiPP90p1S
         YReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6YN1J9vmLUXCKWdwBvhu6EMYabwP3L6uMfluwtn0R3A=;
        b=Sooz4Ba7oITVWPLmN5k6oGy6M9FIkD/UE7fGJeLp23vR9J1bF/nafKwdn3ksFRy1Ao
         7W7wz2EPOZQZDbWkK22dO0VC0cNojED2IQRq8dCVQK79uWzJSQ5VM1XJn45T8e1oiPTT
         DKPlJwS4O+3BiJHbp4uPyJ07YSlGj70uF6vCp5Kfc7dN1yulOFQ1UT02fxPGXKpiyJg3
         atxAFvyzSjv1b/nXs/egpMmG0xvjAT6fz5cVK7IMQkCLO2aWYrTP0YrL4QRzFmTOk3ot
         tSi+ZXpbQgd4mqhbOdmvfkQvj1CWh0zlFu/AyprzSiwvnlqKHUTJ0tgcuvsS5F1qFxI7
         67IQ==
X-Gm-Message-State: AOAM532hcWz9YWKCUVVOtgMUjlH5g4XaQ9Fs6/4RyBOcfFVfpbVFdPpW
        DG0NMzpoZrB1Y0/BcYfwR6McZILlwIPuTRjh
X-Google-Smtp-Source: ABdhPJwhpXwCZmWPCzIsEX0advg+wYnkEjnxSySmGcoqiAXT/eUhd4oS6Nmj+awvShpOH4qbKxE05w==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr307741wmq.45.1627681698708;
        Fri, 30 Jul 2021 14:48:18 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.68.125])
        by smtp.gmail.com with ESMTPSA id i7sm3113516wre.64.2021.07.30.14.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 14:48:18 -0700 (PDT)
Subject: Re: [PATCH bpf-next 6/7] tools: bpftool: document and add bash
 completion for -L, -B options
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210729162932.30365-1-quentin@isovalent.com>
 <20210729162932.30365-7-quentin@isovalent.com>
 <CAEf4Bzb+s0f6ybq+qARTpe1wa2dOD_gweBd0kQAYh3cyx=N5mQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <4ad2073f-d528-788e-3222-85cd2c0fe5f9@isovalent.com>
Date:   Fri, 30 Jul 2021 22:48:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzb+s0f6ybq+qARTpe1wa2dOD_gweBd0kQAYh3cyx=N5mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-30 11:59 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Jul 29, 2021 at 9:29 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> The -L|--use-loader option for using loader programs when loading, or
>> when generating a skeleton, did not have any documentation or bash
>> completion. Same thing goes for -B|--base-btf, used to pass a path to a
>> base BTF object for split BTF such as BTF for kernel modules.
>>
>> This patch documents and adds bash completion for those options.
>>
>> Fixes: 75fa1777694c ("tools/bpftool: Add bpftool support for split BTF")
>> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>> Note: The second example with base BTF in the BTF man page assumes that
>> dumping split BTF when objects are passed by id is supported. Support is
>> currently pending review in another PR.
>> ---
> 
> Not anymore :)
> 
> [...]
> 
>> @@ -73,6 +74,20 @@ OPTIONS
>>  =======
>>         .. include:: common_options.rst
>>
>> +       -B, --base-btf *FILE*
>> +                 Pass a base BTF object. Base BTF objects are typically used
>> +                 with BTF objects for kernel modules. To avoid duplicating
>> +                 all kernel symbols required by modules, BTF objects for
>> +                 modules are "split", they are built incrementally on top of
>> +                 the kernel (vmlinux) BTF object. So the base BTF reference
>> +                 should usually point to the kernel BTF.
>> +
>> +                 When the main BTF object to process (for example, the
>> +                 module BTF to dump) is passed as a *FILE*, bpftool attempts
>> +                 to autodetect the path for the base object, and passing
>> +                 this option is optional. When the main BTF object is passed
>> +                 through other handles, this option becomes necessary.
>> +
>>  EXAMPLES
>>  ========
>>  **# bpftool btf dump id 1226**
>> @@ -217,3 +232,34 @@ All the standard ways to specify map or program are supported:
>>  **# bpftool btf dump prog tag b88e0a09b1d9759d**
>>
>>  **# bpftool btf dump prog pinned /sys/fs/bpf/prog_name**
>> +
>> +|
>> +| **# bpftool btf dump file /sys/kernel/btf/i2c_smbus**
>> +| (or)
>> +| **# I2C_SMBUS_ID=$(bpftool btf show -p | jq '.[] | select(.name=="i2c_smbus").id')**
>> +| **# bpftool btf dump id ${I2C_SMBUS_ID} -B /sys/kernel/btf/vmlinux**
>> +
>> +::
>> +
>> +  [104848] STRUCT 'i2c_smbus_alert' size=40 vlen=2
>> +          'alert' type_id=393 bits_offset=0
>> +          'ara' type_id=56050 bits_offset=256
>> +  [104849] STRUCT 'alert_data' size=12 vlen=3
>> +          'addr' type_id=16 bits_offset=0
>> +          'type' type_id=56053 bits_offset=32
>> +          'data' type_id=7 bits_offset=64
>> +  [104850] PTR '(anon)' type_id=104848
>> +  [104851] PTR '(anon)' type_id=104849
>> +  [104852] FUNC 'i2c_register_spd' type_id=84745 linkage=static
>> +  [104853] FUNC 'smbalert_driver_init' type_id=1213 linkage=static
>> +  [104854] FUNC_PROTO '(anon)' ret_type_id=18 vlen=1
>> +          'ara' type_id=56050
>> +  [104855] FUNC 'i2c_handle_smbus_alert' type_id=104854 linkage=static
>> +  [104856] FUNC 'smbalert_remove' type_id=104854 linkage=static
>> +  [104857] FUNC_PROTO '(anon)' ret_type_id=18 vlen=2
>> +          'ara' type_id=56050
>> +          'id' type_id=56056
>> +  [104858] FUNC 'smbalert_probe' type_id=104857 linkage=static
>> +  [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
>> +  [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
>> +  [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
> 
> This reminded be that it would be awesome to support "format c"
> use-case for dumping split BTF in a more sane way. I.e., instead of
> dumping all types from base and split BTF, only dump necessary (used)
> forward declarations from base BTF, and then full C dump of only new
> types from the split (module) BTF. This will become more important as
> people will start using module BTF more. It's an interesting add-on to
> libbpf's btf_dumper functionality. Not sure how hard that would be,
> but I'd imagine it shouldn't require much changes.
> 
> Just in case anyone wanted to challenge themselves with some more
> algorithmic patch for libbpf (*wink wink*)...

If you're addressing this to me, I'm not particularly looking for such
challenge at the moment :). In fact I already noted a few things that I
would like to fix or improve for bpftool, I will append this one to the
list. I should maybe start thinking of a tracker of some sort to list
and share this.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F4530F1B
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiEWLsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiEWLs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 07:48:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4A4CD76
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 04:48:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h5so19845758wrb.11
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DFH70xh/LTu2CAtOR7K7lJUqqqik0qAvFkkDvndmrfM=;
        b=KZ4D+/cIULOFgTuzbdplyJHKLdXU3NU4Nl4OldL5U1vZ54Kr2mrrWh3BDfW8leq7NF
         BaYx6F5vTqjhf0f1s0fAjr1HLZXH1ywHK8ZsD5EfApQ61AlcDJ9B4K6ag7eL2xjUt8zk
         jd2iByWEgcMDYjjtuAlnKgFgRd0rMSqaCxiOJGTrIRejH4K/kAAEr2ELcon13Pc1/6wV
         C64iYTCGsDgBN5VDYTSCwyMAT9+hV5uEI7PL5J5FdGGdeIIT+3JKBxF/bdNL+5+wgSfY
         aujjnqh73WXmWRXnu1WFRVFZa1/dOosPnp8VGNPaRXGE8eSzmUaLsX+mLcQCoUDklIwQ
         NUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DFH70xh/LTu2CAtOR7K7lJUqqqik0qAvFkkDvndmrfM=;
        b=6N7BcfzAwwRVyWx3hMZMplUMg3jb9obewhfNS2X36kwpieTGxjhxEHOjZQ0cgWwWzC
         obzKa12sxiPIMXTZwvBHj8u0lxZnL0kkIs0zPbUErETmUF4ZVLLkPvvhk1CUfCEVqZYa
         vPO5YqBpHe+McEyttpepz8PBLygIYSVsV/Gi1UV51yWomOh6kr7vAQKgA0BnFItk4jfN
         qevxvOHij6YEIAXyuZCWvHOREeKR5gVQdazR0neNj03TIplNMffnYkssWLmkFlP9HZtM
         Q1oc//L7I4ttnt8TdDon4siEoJJnjOq/cc21qJGQi1T13vdgv4+0qJuNKbMN9d8PilKG
         ToiQ==
X-Gm-Message-State: AOAM531beKx4pCYOiIYsgTpN4xfTp95sTmchwPYn3Zn8p6eHc0Waee98
        ioREf5yqGAOCynpIAh8bYqW4ow==
X-Google-Smtp-Source: ABdhPJzbXGLCwyt3dHud4+zn3YbhhAhsDkVt/v+caGr053GjfyhTEC6yEHnOkLhdZQEy8xSatzwwlw==
X-Received: by 2002:a5d:6386:0:b0:20d:8315:f9c7 with SMTP id p6-20020a5d6386000000b0020d8315f9c7mr18729917wru.494.1653306507013;
        Mon, 23 May 2022 04:48:27 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d10-20020adfc80a000000b0020fded972c0sm3355296wrh.45.2022.05.23.04.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 04:48:26 -0700 (PDT)
Message-ID: <c12c094f-a8a1-1a38-1532-7a6df4773573@isovalent.com>
Date:   Mon, 23 May 2022 12:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v3 00/12] libbpf: Textual representation of enums
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
References: <20220519213001.729261-1-deso@posteo.net>
 <CAEf4BzYZ+XY+uhSw1tOC=2KZe19hPsgAuq8o6CRsqCDfbqr59Q@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYZ+XY+uhSw1tOC=2KZe19hPsgAuq8o6CRsqCDfbqr59Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-20 16:45 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, May 19, 2022 at 2:30 PM Daniel Müller <deso@posteo.net> wrote:
>>
>> This patch set introduces the means for querying a textual representation of
>> the following BPF related enum types:
>> - enum bpf_map_type
>> - enum bpf_prog_type
>> - enum bpf_attach_type
>> - enum bpf_link_type
>>
>> To make that possible, we introduce a new public function for each of the types:
>> libbpf_bpf_<type>_type_str.
>>
>> Having a way to query a textual representation has been asked for in the past
>> (by systemd, among others). Such representations can generally be useful in
>> tracing and logging contexts, among others. At this point, at least one client,
>> bpftool, maintains such a mapping manually, which is prone to get out of date as
>> new enum variants are introduced. libbpf is arguably best situated to keep this
>> list complete and up-to-date. This patch series adds BTF based tests to ensure
>> that exhaustiveness is upheld moving forward.
>>
>> The libbpf provided textual representation can be inferred from the
>> corresponding enum variant name by removing the prefix and lowercasing the
>> remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunately,
>> bpftool does not use such a programmatic approach for some of the
>> bpf_attach_type variants. We decided changing its behavior to work with libbpf
>> representations. However, for user inputs, specifically, we do keep support for
>> the traditionally used names around (please see patch "bpftool: Use
>> libbpf_bpf_attach_type_str").
>>
>> The patch series is structured as follows:
>> - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
>>   bpf_link_type}:
>>   - we first introduce the corresponding public libbpf API function
>>   - we then add BTF based self-tests
>>   - we lastly adjust bpftool to use the libbpf provided functionality
>>
>> Changelog:
>> v2 -> v3:
>> - use LIBBPF_1.0.0 section in libbpf.map for newly added exports
>>
>> v1 -> v2:
>> - adjusted bpftool to work with algorithmically determined attach types as
>>   libbpf now uses (just removed prefix from enum name and lowercased the rest)
>>   - adjusted tests, man page, and completion script to work with the new names
>>   - renamed bpf_attach_type_str -> bpf_attach_type_input_str
>>   - for input: added special cases that accept the traditionally used strings as
>>     well
>> - changed 'char const *' -> 'const char *'
>>
>> Signed-off-by: Daniel Müller <deso@posteo.net>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> Cc: Quentin Monnet <quentin@isovalent.com>
>>
> 
> So this looks good to me for libbpf and selftests/bpf changes. I'll
> wait for Quentin to give his acks at least for bpftool changes.
> Quention, please take a look when you get a chance.
> 
> Few small nits, please accommodate them in next version, if you happen
> to send another one. If not, I'll try to remember to fix it up when
> applying.
> 
> 1. Received Acked-by/Reviewed-by tags should be added to each
> individual patch, not cover letter.
> 
> 2. You are using /** ... */ comments, which are considered to be kdoc
> comments and they have some additional formatting, which some of the
> tooling run on patches in Patchworks complains about [0]. Please use
> just /* ... */ style everywhere where it's not actual kdoc (or libbpf
> API documentation).
> 
>   [0] https://patchwork.hopto.org/static/nipa/643335/12856068/kdoc/summary
> 

Apologies, didn't have time to go through the Python changes last week.
This looks all good for me as well! With a few additional nitpicks on
patch 9, see my reply for that one. For all other patches, please feel
free to add:

Acked-by: Quentin Monnet <quentin@isovalent.com>

Nice work, thanks a lot Daniel for diving into the Python script!

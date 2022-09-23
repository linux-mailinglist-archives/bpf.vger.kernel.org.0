Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0E5E7984
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIWLZE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIWLYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 07:24:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69578133CBC
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 04:24:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so3000025wmq.1
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=j/Hqwj2nPK6QsBY0Ce37rdC2XlEduwCyJvjWKuc+Wsk=;
        b=v4IaUK/XijBMitxeNTMA8Ov7mPRsQlwJ7R0LiX4/YW+ktuF96I5KmdFn3treJWTq+O
         Xj6TjZmP+rMlN1xUpuycgyAD+7k1MKl1uTNxA7+csaRT5WDsdpujCAq39TdAx197xa19
         /ke2LUw5EHaPnsUvKYFyop4R6fnljIhaK5iE+xoKmfwET0UwwY7GZgVlIiDjXr7DnGe0
         JySUWxsCYJibcw76Nk4slfUgDTTDs4TRmVguEiHNpt+bEXW6E1vgfMuMkvf/ixwj8j1z
         q6uKX+b67djIkw7lqlICJXOOdO77eGdffpFxEh3USEmF70orR6X7Icx7pLQ4lEcco8Bb
         thMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j/Hqwj2nPK6QsBY0Ce37rdC2XlEduwCyJvjWKuc+Wsk=;
        b=Jq5KChQxaoBabJq0Afjpl1NGlqIOEcmuDbo506IlF052T4vY6+rgv88Jksjxvbd/0p
         s8/HtVZ9e9ZH339Z1ilywZ9MoFluB6ayX8TfhNoceOm3WVAHKUaa3U7l6rhzqXoa3zR0
         8HiNc81TmKxjwkpEYt5fvdizU2q67JAcW2pH/KJ+Q3cdH634fXk6KFGyXF0q5hfv8hCX
         Fj/AZpDVaEti3r9bcC0Sf0wWFmxC+tmloAXFh+lr16kXcwF1LNYcuJv5NS0nFzxGHVtT
         g8/kvtcQCnCJ7B0fj+qFlVohbiCY2VcLlXJFmyYs/P2FYEdIT6t3ZILa3Q9MtKt7ZZNs
         /BlQ==
X-Gm-Message-State: ACrzQf1+KGK3yLFwxL4/Su3kSaNcFEkgBIh9aTH6e9pKeHfTJQMIk/6C
        //hvXd2TRXgG4oqX2ynWAjlvYw==
X-Google-Smtp-Source: AMsMyM7zBz4XZp/rDeIipmHA4iGu+n+usajk1C0bmqy9ogNqCHzbtHzJJofpkK1fRR5bgKCmM9+P9g==
X-Received: by 2002:a05:600c:4f01:b0:3b4:a8c8:2523 with SMTP id l1-20020a05600c4f0100b003b4a8c82523mr12363042wmq.199.1663932238562;
        Fri, 23 Sep 2022 04:23:58 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c1d8800b003a342933727sm2410716wms.3.2022.09.23.04.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 04:23:57 -0700 (PDT)
Message-ID: <c21ad55d-fdf4-c491-e684-1696a9d5c50b@isovalent.com>
Date:   Fri, 23 Sep 2022 12:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-GB
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
 <20220911201451.12368-7-quentin@isovalent.com>
 <00d4de2e-c7ac-7aa5-9d31-868d73af4fe2@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <00d4de2e-c7ac-7aa5-9d31-868d73af4fe2@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fri Sep 16 2022 22:09:54 GMT+0100 (British Summer Time) ~ Daniel
Borkmann <daniel@iogearbox.net>
> On 9/11/22 10:14 PM, Quentin Monnet wrote:
>> To disassemble instructions for JIT-ed programs, bpftool has relied on
>> the libbfd library. This has been problematic in the past: libbfd's
>> interface is not meant to be stable and has changed several times. For
>> building bpftool, we have to detect how the libbfd version on the system
>> behaves, which is why we have to handle features disassembler-four-args
>> and disassembler-init-styled in the Makefile. When it comes to shipping
>> bpftool, this has also caused issues with several distribution
>> maintainers unwilling to support the feature (see for example Debian's
>> page for binutils-dev, which ships libbfd: "Note that building Debian
>> packages which depend on the shared libbfd is Not Allowed." [0]).
>>
>> For these reasons, we add support for LLVM as an alternative to libbfd
>> for disassembling instructions of JIT-ed programs. Thanks to the
>> preparation work in the previous commits, it's easy to add the library
>> by passing the relevant compilation options in the Makefile, and by
>> adding the functions for setting up the LLVM disassembler in file
>> jit_disasm.c.
> 
> Could you add more context around the LLVM lib? The motivation is that
> libbfd's
> interface is not meant to be stable and has changed several times. How
> does this
> look on the LLVM's library side? Also, for the 2nd part, what is
> Debian's stance
> related to the LLVM lib? Would be good if both is explained in the
> commit message.
> Right now it mainly reads 'that libbfd has all these issues, so we're
> moving to
> something else', so would be good to provide more context to the ready
> why the
> 'something else' is better than current one.
Hi Daniel,

This was based on two things. First, there is a note in LLVM's Developer
Policy [0] stating that the stability for the C API is “best effort” and
not guaranteed, but at least there is some effort to keep compatibility
when possible (which hasn't really been the case for libbfd so far). I
am under the impression that there is little intent for libbfd to be
used outside of gdb/binutils. Second: the relevant .deb page does not
caution against linking to the lib, as binutils-dev page does.

I can add this info to the commit log for the next version.

[0] https://llvm.org/docs/DeveloperPolicy.html#c-api-changes

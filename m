Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80052A496
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348587AbiEQOSq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiEQOSp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 10:18:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FD344FA
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 07:18:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p189so10523113wmp.3
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xi7W9W3meI29brLFfZ3phBdQ6oF5D+2H11nos0PjFwY=;
        b=zGZWrLtSDwVBN78p9fMdOWU7XICfEg26fIpGkYdCt5a/mNXmHLracrgZIC2Dp+ZWyx
         fo9O1kjR5cDe9uxmn/qFYASy+lp9dDVfwEgFY0vMlxjnYTlYD+KSxN8HgR0zSnyP045s
         IQJE3i80aajUGMY/M1wBJcuxIVzB+/MrmxvnPFGIggMiSmLkFmIpaVhsChZvTIWxyQ3o
         yCkJr7uGPnFBQD9Ph7NrtK+WL38qNnlxp58jWNHpum3v8KBTI0jXTIVGTq4H926/kbdu
         CwF7CTtEssO4RheLcsdlYa8ThI4GSXKPW6EfclbjgjWrjnqAxENkHgP3Zuc1e4BNkf0w
         Saaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xi7W9W3meI29brLFfZ3phBdQ6oF5D+2H11nos0PjFwY=;
        b=j0E/GJqb4BtsolSMMh9r5R+Q2Pl6v+heVil/JkcMS6/wTdW8vVzBFi4g50pLQKtgHY
         08MGjG+dXRGjcOjRIrVWLuEXVYU6oje7Aag2qnFbwvw8xMZj90yNJwHxgrEGMCjZovpo
         O+wegQzdlxLKKeRLkTTHaF0yF/JIoLWN2hDzb8ojOvIOK5Cj+OQKziUk8kmEgKkDbi8f
         NPAeEus+WKUIRz4AkRL+unjzFl52f3FgmH/2GTgbdczAwqv1fmdeCNjSuN50+pWIQShc
         xUSokVxdd0EhhhkIfkt3P+pHCbnv/Upwp8sph6+Lbt/eEPobt9QiNwe//DySmkzM+CWB
         LRbw==
X-Gm-Message-State: AOAM530yFSJIdrzmj92es7EP61a5t+4p84pG+63D5mezlZ51ITI8TFuo
        PPpXlRbNd818cWxBFS6WhTPlWw==
X-Google-Smtp-Source: ABdhPJzo16mE53aJwEe/niPPPohnM78JT7UkG9O0Fld+WogrWKMzxbvhMB2xpYMRoQ/byQnHFaER+A==
X-Received: by 2002:a7b:cf02:0:b0:393:fbb0:7189 with SMTP id l2-20020a7bcf02000000b00393fbb07189mr21007450wmg.197.1652797122893;
        Tue, 17 May 2022 07:18:42 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b0039466988f6csm1983632wmc.31.2022.05.17.07.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:18:42 -0700 (PDT)
Message-ID: <a1a518b6-4006-7a65-178d-6100ada34a2d@isovalent.com>
Date:   Tue, 17 May 2022 15:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220516173540.3520665-1-deso@posteo.net>
 <20220516173540.3520665-10-deso@posteo.net>
 <CAEf4BzYXxSerQnw3U5SKU10HAbM1KrTj9z_DvX+tQqaq7+2CUQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYXxSerQnw3U5SKU10HAbM1KrTj9z_DvX+tQqaq7+2CUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-16 16:41 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Mon, May 16, 2022 at 10:36 AM Daniel Müller <deso@posteo.net> wrote:
>>
>> This change switches bpftool over to using the recently introduced
>> libbpf_bpf_attach_type_str function instead of maintaining its own
>> string representation for the bpf_attach_type enum.
>>
>> Note that contrary to other enum types, the variant names that bpftool
>> maps bpf_attach_type to do not follow a simple to follow rule. With
>> bpf_prog_type, for example, the textual representation can easily be
>> inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
>> remaining string. bpf_attach_type violates this rule for various
>> variants. In order to not brake compatibility (these textual
>> representations appear in JSON and are used to parse user input), we
>> introduce a program local bpf_attach_type_str that overrides the
>> variants in question.
>> We should consider removing this function and expect the libbpf string
>> representation with the next backwards compatibility breaking release,
>> if possible.
>>
>> Signed-off-by: Daniel Müller <deso@posteo.net>
>> ---
> 
> Quentin, any opinion on this approach? Should we fallback to libbpf's
> API for all the future cases or it's better to keep bpftool's own
> attach_type mapping?
Hi Andrii, Daniel,

Thanks for the ping! I'm unsure what's best, to be honest. Maybe we
should look at bpftool's inputs and outputs separately.

For attach types printed as part of the output:

Thinking about it, I'd say go for the libbpf API, and make the change
now. As much as we all dislike breaking things for user space, I believe
that on the long term, we would benefit from having a more consistent
naming scheme for those strings (prefix + lowercase attach type); and
more importantly, if querying the string from libbpf spreads to other
tools, these will be the reference strings for the attach types and it
will be a pain to convert bpftool's specific exceptions to "regular"
textual representations to interface with other tools.

And if we must break things, I'd as well have it synchronised with the
release of libbpf 1.0, so I'd say let's just change it now? Note that
we're now tagging bpftool releases on the GitHub mirror (I did 6.8.0
earlier today), so at least that's one place where we can have a
changelog and mention breaking changes.

Now for the attach types parsed as input parameters:

I wonder if it would be worth supporting the two values for attach types
where they differ, so that we would avoid breaking bpftool commands
themselves? It's a bit more code, but then the list would be relatively
short, and not expected to grow. We can update the documentation to
mention only the new names, and just keep the short compat list hidden.

Some additional notes on the patch:

There is also attach_type_strings[] in prog.c where strings for attach
types are re-defined, this time for when non cgroup-related programs are
attached (through "bpftool prog attach"). It's used for parsing the
input, so should be treated the same as the attach list in commons.c.

If changing the attach type names, we should also update the following:
- man pages: tools/bpf/bpftool/Documentation/bpftool-{cgroup,prog}.rst
- interactive help (cgroup.c:HELP_SPEC_ATTACH_TYPES + prog.c:do_help())
- bash completion: tools/bpf/bpftool/bash-completion/bpftool

Some of the tests in
tools/testing/selftests/bpf/test_bpftool_synctypes.py, related to
keeping those lists up-to-date, will also need to be modified to parse
the names from libbpf instead of bpftool sources. I can help with that
if necessary.

Quentin

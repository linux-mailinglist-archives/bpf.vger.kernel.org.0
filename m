Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FC6AC83D
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCFQhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 11:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCFQgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 11:36:48 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE63A869
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 08:36:23 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id k10so17248946edk.13
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 08:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678120551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpc2SHQAYlQo2ljDuUpky4ZewVhG7u3iQyiQSr0hcxM=;
        b=Wed/09Ae0y9Pr4rlRBnKC7u6gCONaipgjDkVCzgOM+rq7o4yHzZl5jxISqfm7bqFpO
         CfBDmfYf7nAI9R8K0W1PREPu3ZIuKCNVNU3f9Ld/wnExUevHnbGR5NHD+HJAvsv8nE5t
         TOiNlGohpOTK5f1KZXboTYCIjs8J0QsVciaH3MaQJkTInPs3BbzZXrBQJ+GGlpXzy5jf
         Rthw4bCIcOVoctuXqEbLjk6ewvSblscrttf42l4QxZSZPyIy472CGRCsySjr7dIBuN19
         Scird8jFNkxMiRvxyWgGkcxsN/OeDQhmpw7Bv5VeFtz0NQA65kbmsukU7u7akTAw4DkH
         Pk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678120551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpc2SHQAYlQo2ljDuUpky4ZewVhG7u3iQyiQSr0hcxM=;
        b=g1/obAcrelodvwqxepQNy1IhefFXOOAufABO7dH9QKcuKKryPLloyIzWVDYMYfDVr6
         tBY9+iL3QsOT3fn+XObzybYR4E2e9nHjnb+JY39OSJHYNTxXWZyrUOwWj7SBNApy2LI/
         IjJkLfz9AWpKHk6mfM9gn5JWJcX3G9RIVdNkPFgwoq8xyCDwDsGwzJn6oGciVSv5xn3g
         UNpYSycu6zy6F4esNHC+viX5Hvy3RTrXk8mg7Vb5cMCTvut6IPjMHOx3Q3tZgaiq1xDH
         /O0ZJPntx6da79y3j1gFJ7GZV4ZGgE8ZqzZZf1PSNex2E6bYsJPCrRct9m2/BcafnntZ
         Q2kA==
X-Gm-Message-State: AO0yUKVH5djacY02byTLwj6z9fyJR1sYmIW1RRZSz40aw9CTos1qsy+t
        661LIcL/0M9YUS0vp7Z6y40TUG6e6EkDjftf2KSHEl35uVM=
X-Google-Smtp-Source: AK7set/dvbHv5menUXrHMKguoR0p0WE5Zpel8rQxkTfyER1vD8MiTocFkc6kRVYTq76W2W0A5UYqgg==
X-Received: by 2002:a05:600c:524c:b0:3e2:24a0:ba26 with SMTP id fc12-20020a05600c524c00b003e224a0ba26mr10149035wmb.16.1678119470653;
        Mon, 06 Mar 2023 08:17:50 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:7881:f816:30a0:10b3? ([2a02:8011:e80c:0:7881:f816:30a0:10b3])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c468e00b003eb369abd92sm15965190wmo.2.2023.03.06.08.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:17:50 -0800 (PST)
Message-ID: <4e6fb50c-dead-9635-239f-2b4b0ca411ff@isovalent.com>
Date:   Mon, 6 Mar 2023 16:17:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] libbpf: Use text error for btf_custom_path
 failures
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
References: <20230228142531.439324-1-9erthalion6@gmail.com>
 <CAEf4BzYz5dmJBzTuEvihDqjYyWqUcQE6YLUH1WdC_RDifu7FpA@mail.gmail.com>
 <20230301210726.vqdea7dksathapej@erthalion.local>
 <CAEf4BzaFu_qFvwtE-=WLWM2YUirq5fKbbTGXVeNiqrARdLj+Vg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzaFu_qFvwtE-=WLWM2YUirq5fKbbTGXVeNiqrARdLj+Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-04 15:39 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, Mar 1, 2023 at 1:09 PM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
>>
>>> On Wed, Mar 01, 2023 at 11:02:25AM -0800, Andrii Nakryiko wrote:
>>>
>>>> Use libbpf_strerror_r to expand the error when failed to parse the btf
>>>> file at btf_custom_path. It does not change a lot locally, but since the
>>>> error will bubble up through a few layers, it may become quite
>>>> confusing otherwise. As an example here is what happens when the file
>>>> indicated via btf_custom_path does not exist and the caller uses
>>>> strerror as well:
>>>>
>>>>     libbpf: failed to parse target BTF: -2
>>>>     libbpf: failed to perform CO-RE relocations: -2
>>>>     libbpf: failed to load object 'bpf_probe'
>>>>     libbpf: failed to load BPF skeleton 'bpf_probe': -2
>>>>     [caller]: failed to load BPF object (errno: 2 | message: No such file or directory)
>>>>
>>>> In this context "No such file or directory" could be easily
>>>> misinterpreted as belonging to some other part of loading process, e.g.
>>>> the BPF object itself. With this change it would look a bit better:
>>>>
>>>>     libbpf: failed to parse target BTF: No such file or directory
>>>>     libbpf: failed to perform CO-RE relocations: -2
>>>>     libbpf: failed to load object 'bpf_probe'
>>>>     libbpf: failed to load BPF skeleton 'bpf_probe': -2
>>>>     [caller]: failed to load BPF object (errno: 2 | message: No such file or directory)
>>>
>>> I find these text-only error messages more harmful, actually. Very
>>> often their literal meaning is confusing, and instead the process is
>>> to guess what's -Exxx error they represent, and go from there.
>>>
>>> Recently me and Quentin discussed moving towards an approach where
>>> we'd log both symbolic error value (-EPERM instead of -1) and also
>>> human-readable text message. So I'd prefer us figuring out how to do
>>> this ergonomically in libbpf and bpftool code base, and start moving
>>> in that direction.
>>
>> Fair enough, thanks. I would love to try out any suggestions in this
>> area -- we were recently looking into error handling, and certain parts
>> were suboptimal.
>>
>> Talking about confusing text error messages, I'm curious about -ESRCH
>> usage. It's being used in libbpf and various subsystem as well to
>> indicate that something wasn't found, so I guess it's an established
>> practice. But then in case btf__load_vmlinux_btf can't find a proper
>> file and reports an error, the caller gets surprising "No such process"
>> out of strerror. Am I missing something, is it implemented like this on
>> purpose?
> 
> It's probably not 100% consistent throughout libbpf, but -ESRCH is
> used to denote "a process to determine/find something failed". -ENOENT
> is used when we are requested to find a specific entry, and it's not
> there (but otherwise there were no errors encountered). That's the
> distinction.
> 
> The problem with those text explanations of errors is that they are
> coming from Linux's usage of them in the context of process or file
> manipulations, and I don't see a way around that. I'd like to minimize
> the use of custom error codes.
> 
> But this is the reason I'd like to output `-ESRCH` instead of either
> -3 or "No such process". Something like "-ESRCH (No such process)" is
> a compromise, but better than nothing.
> 
> Or we could stick to just -ESRCH. That might be better than test
> descriptions, as we at least don't confuse them with irrelevant
> descriptions.
> 
> But Quentin might find it not very user-friendly for his bpftool use
> cases, probably.

Yes, even though the messages are sometimes confusing I find that there
are also occasions where they're actually useful to users not familiar
with the error names (not easy to figure out what "ESRCH" means if
you've never seen it before), so I'd avoid removing them entirely from
bpftool. Just as Andrii writes, we talked [0] on displaying both the
error name and the description through libbpf_strerror_r():

	Error: can't get next program: [-EPERM] Operation not permitted

So that users with more knowledge can skip the description and just look
at the error name.

I haven't started to work on this, though.

[0]
https://lore.kernel.org/all/CAEf4BzZMJGrRhNeQeWB0fRsuRYUv01aZGhvDeFV2o5zdpRbR-w@mail.gmail.com/

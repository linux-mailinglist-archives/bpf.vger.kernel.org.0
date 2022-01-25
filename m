Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E987C49A8BA
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316192AbiAYDL3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 22:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446129AbiAYCBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 21:01:51 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A2C045901
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 16:27:42 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q204so7163552iod.8
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 16:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kY/fjEHg6QwLjF5GHoi/ALfgfnKiY8+f+mvA9LZYH+U=;
        b=RnEx9y95w1t4+8MxOMw1BGhYY7Qt0aCikE4+CGUb71mfS5M6mDEJuTSxSYLuaDd0wV
         usqbw+BOQWwwxdhCOvgtERopOnY+I7C5UewRuGim2BgRgN+6eZ0VM4HVWKDoV+2HxZ8V
         VdoP6XUJA6+jso+R2sS5UPbTjs6Wj0FiwEAag8uW2KskFlhX42j9v5zF0ASyx2WsaeRE
         C05Z4WAob8tQND0Ql7Va/b/xnmlLBlTXJgRzgHNOGmLEQabH88kbA/CwfIBRmy5ByORI
         m57kJm9f403eoOZGemj+vOGiJk0B4kpZBYLJY9UaphwYrsdtDz+J9pSpuEq4kDfGi326
         kPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kY/fjEHg6QwLjF5GHoi/ALfgfnKiY8+f+mvA9LZYH+U=;
        b=oT7g4qUo2JaUcWNMnnOrKO3ilDI/+sfr/OmilJLAvf7J1PsD+6wov1VIP8/TRJASUz
         rkArSSu0RmjOB2nBWjNM1I/8hIy1fjnj59Tx7iHOb2/jEwaihRITVg1bkJ2ryVIlbnmy
         epYk6aFqbq3lvTlkeekaj+JY+r7RFZPmlRDNSuZbWAJA7D4F07YFIRsxy5y5aHXGkc2E
         YAoCCURBPUz9ppvSodEP+QSI3Ja/7p8IlK4gF4u7r3S2mbLD6Ed64Aktrs73Di1d9cIN
         8wCc9/oiPnK2lGNkNiVqWi7ILYhs7tjaDxG9Lk0+6KGLROt5OfQbN2jswndy2vP9rYCz
         zC1A==
X-Gm-Message-State: AOAM532QefttslB4whWnHTdsLebt3sxVRT8blz7nosENQaNcG+HzNliU
        UhwzNAGxtU9lgDVZ2p1s5Kw=
X-Google-Smtp-Source: ABdhPJxEXVC41IKgQ9mWxPm6/f401GKvKtuFkENKMExlVjxWGkoRPqtFfUfBnHgBLcFF+84gdNYePg==
X-Received: by 2002:a6b:c30e:: with SMTP id t14mr9541898iof.188.1643070461440;
        Mon, 24 Jan 2022 16:27:41 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.58])
        by smtp.googlemail.com with ESMTPSA id k8sm465885ilo.45.2022.01.24.16.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 16:27:40 -0800 (PST)
Message-ID: <ce6308e4-fb23-5cbb-f9b4-bed0bb5a4691@gmail.com>
Date:   Mon, 24 Jan 2022 17:27:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org> <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
 <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/22 9:15 AM, Andrii Nakryiko wrote:
> On Fri, Jan 21, 2022 at 12:43 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>>> On Thu, Jan 20, 2022 at 3:44 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>
>>>> Andrii Nakryiko <andrii@kernel.org> writes:
>>>>
>>>>> Enact deprecation of legacy BPF map definition in SEC("maps") ([0]). For
>>>>> the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS flag
>>>>> for libbpf strict mode. If it is set, error out on any struct
>>>>> bpf_map_def-based map definition. If not set, libbpf will print out
>>>>> a warning for each legacy BPF map to raise awareness that it goes
>>>>> away.
>>>>
>>>> We've touched upon this subject before, but I (still) don't think it's a
>>>> good idea to remove this support entirely: It makes it impossible to
>>>> write a loader that can handle both new and old BPF objects.
>>>>
>>>> So discourage the use of the old map definitions, sure, but please don't
>>>> make it completely impossible to load such objects.
>>>
>>> BTF-defined maps have been around for quite a long time now and only
>>> have benefits on top of the bpf_map_def way. The source code
>>> translation is also very straightforward. If someone didn't get around
>>> to update their BPF program in 2 years, I don't think we can do much
>>> about that.
>>>
>>> Maybe instead of trying to please everyone (especially those that
>>> refuse to do anything to their BPF programs), let's work together to
>>> nudge laggards to actually modernize their source code a little bit
>>> and gain some benefits from that along the way?
>>
>> I'm completely fine with nudging people towards the newer features, and
>> I think the compile-time deprecation warning when someone is using the
>> old-style map definitions in their BPF programs is an excellent way to
>> do that.
>>
>> I'm also fine with libbpf *by default* refusing to load programs that
>> use the old-style map definitions, but if the code is removed completely
>> it becomes impossible to write general-purpose loaders that can handle
>> both old and new programs. The obvious example of such a loader is
>> iproute2, the loader in xdp-tools is another.
> 
> This is because you want to deviate from underlying BPF loader's
> behavior and feature set and dictate your own extended feature set in
> xdp-tools/iproute2/etc. You can technically do that, but with a lot of
> added complexity and headaches. But demanding libbpf to maintain
> deprecated and discouraged features/APIs/practices for 10+ years and
> accumulate all the internal cruft and maintenance burden isn't a great
> solution either.
> 
> As of right now, recent 0.x libbpf versions do support "old and new
> programs", so there is always that option.
> 
>>
>>> It's the same thinking with stricter section names, and all the other
>>> backwards incompatible changes that libbpf 1.0 will do.
>>
>> If the plan is to refuse entirely to load programs that use the older
>> section names, then I obviously have the same objection to that idea :)
> 
> I understand, but I disagree about keeping them in libbpf
> indefinitely. That's why we have a major version bump at which point
> backwards compatibility isn't guaranteed. And we did a lot to make
> this transition smoother (all the libbpf_set_strict_mode()
> shenanigans) and prepare to it (it's been almost a year now (!), and
> we still have few more months).
> 
>>
>>> If you absolutely cannot afford to drop support for all the
>>> to-be-removed things from libbpf, you'll have to stick to 0.x libbpf
>>> version. I assume (it will be up to disto maintainers, I suppose)
>>> you'll have that option.
>>
>> As in, you expect distributions to package up the old libbpf in a
>> separate package? Really?
> 
> NixOS indicated that they are planning to do just that ([0]). Is it a
> problem to keep packaging libbpf.so.0 and libbpf.so.1 together?
> 
>   [0] https://github.com/libbpf/libbpf/issues/440#issuecomment-1016084088
> 
>>
>> But either way, that doesn't really help; it just makes it a choice
>> between supporting new or old programs. Can't very well link to two
>> versions of the same library...
> 
> Oh, you probably can with dynamic shared library loading, but yeah,
> big PITA for sure. But again, v0.x libbpf supports "new programs" for
> current definition of new, if you absolutely insist on supporting
> deprecated BPF object file features. I'd be happy if you could instead
> nudge your users to modernize their BPF game and prepare for libbpf
> 1.0 early, though. They can do that easily do to the extra work that
> we did for libbpf 1.0 transition period.
> 
>>
>> I really don't get why you're so insistent on removing that code either;
>> it's not like it's code that has a lot of churn (by definition), nor is
>> it very much code in the first place. But if it's a question of
> 
> There is enough and it is a maintenance burden. And will be forever if
> we don't take this chance to shed it and move everyone to better
> designed approaches (BTF-based maps), which, BTW, were around for
> about 2 years now. Hardly a novelty.
> 

And it does not work everywhere.

When support for libbpf was added to iproute2, my biggest concern was
the stability of the library -- that exported APIs and supported
features would be arbitrarily changed and that is exactly what you are
doing with this push to v1.0. iproute2 cares about forward and backward
compatibility. If a tc program loads and runs on kernel version X with
iproute2 version Y, it should continue to work with kernel version X+M
and iproute2 version Y+N. No change should be required to the program at
all.

In this specific example, you are not removing support for old map
definitions for security reasons or bug reasons; you want to remove it
because there is a new definition and removing support for the older
definition forces people to move to the new style. You are trying to
force people to use a feature they may not care about at all or even need.

Ubuntu 18.04 is an LTS and will be around for a long time. ebpf programs
build and work just fine but the OS does not support BTF. Deprecating
support for older maps means people using say 18.04 and 22.04 can not
use the same object files on both servers which means code bases have to
deal with differences in definitions and build rules. Not user friendly
at all.

glibc manages to retain support for old system calls even as new
variants are added. That is part of the burden a library takes on for
its users. Your forced deprecation in short time windows (and 2 years is
a very short time window for OS'es) is just going to cause headaches -
like splits where code bases have to jump through hoops to stay on pre-1.0.

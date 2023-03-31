Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671986D1CAA
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCaJkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 05:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjCaJj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 05:39:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C43584
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 02:39:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so21742823wrt.8
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline.eu; s=google; t=1680255590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaOCRPXnMg5CTiX9zflJosjgCll/zgr6xhGfpqGUMWE=;
        b=af8uYcmeYlG0DHIpvW59q6okIp4M/iY34MjYmT/G5NFlFG2UH86kLuV1MHWGRhlS/r
         YuUY1kHae81B/TMbp6oWb/SfHS/dLZ8l+KQaR7tFdzabjyH8pQR3gmygFjgdTAWYTEdQ
         YsU/21gRQSaBCUtg0eWy7zHkaurINvwfx4cr8sjDrlZEktWaX+gPfHJC+5woEW5Hvmox
         RRczOJT2u/77POa6ec7nhoq6qMOFzWdqFFY4jq2inb2rkXudJn1qdNXt5Clboq3ys2Qi
         gyCWnUcmPGIYA/v+3pq1zF5uZEvtJZtWsEPiQJYnuJmC57Oww0PqplwN6FOvVoU66xtc
         C9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaOCRPXnMg5CTiX9zflJosjgCll/zgr6xhGfpqGUMWE=;
        b=wtNN9LQAoUHmcfdXAvwvwy60lMvmmUEVsr7Ei/jm3WSevcLPamsKmrK5a2W5/nEgDP
         qVTvYDao68tXj0u8uqrvqobK6IcFRQeAodrcxShh0UaqYcWzzlWKB3tgOmZ5Nj+XuPrZ
         lhqJodtg+tP1EPDaQcTDkGprgQ8j1b7nLa95dLxrsUOwiveieWCmt9pzl/PHujjVqPLc
         hD73rgEtW48FDYVSX97TnVW+H4V4uQ6I6/oDVbspRIFMg/A2zxShFtI8QWcXuSd+bBhi
         kcroSDPrUiQQJPhkF2gdtp+gi+DFZe4M6iVvwyG+mOP+aUYj7UhzbgDG8i8CERUOxdxY
         wWhA==
X-Gm-Message-State: AAQBX9fGyY+/eFtG8e3cYBrhRv98habGZSaU6FceeLclMc6cnEund5Sx
        78SuDyzAo+FsC8AVcth0ovHtDw==
X-Google-Smtp-Source: AKy350ZJggeeu2U47gnmzjZMVPSnh4YANZBYCJQXmkZNjDL6jjAHwRPkhcoC4R95ojRJ3T3gVSC01g==
X-Received: by 2002:a5d:6092:0:b0:2cf:feac:1ba4 with SMTP id w18-20020a5d6092000000b002cffeac1ba4mr20381481wrt.52.1680255589970;
        Fri, 31 Mar 2023 02:39:49 -0700 (PDT)
Received: from ?IPV6:2a02:1811:50b:7ef2:4e94:ed78:f01:d1b0? (ptr-7tz51s4iwwkd61zkfcg.18120a2.ip6.access.telenet.be. [2a02:1811:50b:7ef2:4e94:ed78:f01:d1b0])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d4306000000b002c8476dde7asm1685642wrq.114.2023.03.31.02.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:39:49 -0700 (PDT)
Message-ID: <68b1465b-e970-15c3-37a6-f81a639bc71c@incline.eu>
Date:   Fri, 31 Mar 2023 11:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:111.0) Gecko/20100101
 Thunderbird/111.0
Subject: Re: [PATCH v2 bpf-next 4/6] libbpf: don't enforce verifier log levels
 on libbpf side
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        robin.goegge@isovalent.com, kernel-team@meta.com
References: <20230328235610.3159943-1-andrii@kernel.org>
 <20230328235610.3159943-5-andrii@kernel.org>
 <CAN+4W8h4QwvVcKkfTGOKAug2wnbZi5t5GyXXK0VWoobrNo1jpA@mail.gmail.com>
 <CAEf4BzbH7tB+zaK=DJtpR+SXqhNqwYMwiru9xpuAhGpaaFrJsg@mail.gmail.com>
From:   Timo Beckers <timo@incline.eu>
In-Reply-To: <CAEf4BzbH7tB+zaK=DJtpR+SXqhNqwYMwiru9xpuAhGpaaFrJsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 23:05, Andrii Nakryiko wrote:
> On Thu, Mar 30, 2023 at 10:13 AM Lorenz Bauer <lmb@isovalent.com> wrote:
>> On Wed, Mar 29, 2023 at 12:56 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>> This basically prevents any forward compatibility. And we either way
>>> just return -EINVAL, which would otherwise be returned from bpf()
>>> syscall anyways.
>> In your cover letter you make the argument that applications can opt
>> out of the behaviour, but I think shows that this isn't entirely true.
>> Apps linking old libbpf won't be able to fix their breakage without
>> updating libbpf. This is especially annoying when you have to support
>> multiple old versions where doing this isn't straightforward.
>>
> Ok, technically, you are correct. If you somehow managed to get a
> bleeding edge kernel, but outdated libbpf, you won't be able to
> specify log_level = 8. This is not the only place where too old libbpf
> would limit you from using bleeding edge kernel features, though, and
> we have to live with that (though try our best to avoid such
> dependencies, of course).
>
> But in practice you get the freshest libbpf way before your kernel
> becomes the freshest one, so I don't think this is a big deal in
> practice.
Hey Andrii,

In an ideal world, yes, but not how it works out in practice. Anything
that ships in a container obviously misses out on distro packages of the
underlying host that are tied to the running kernel. This looks like it's
quickly becoming a majority use case of bpf in the wild, barring of course
Android and systemd.

In practice, we get to deal with rather large version swings in both
directions; users may want to run the latest tools on 4.19, or last
year's stable tool release on 6.1, so the need for both backwards- and
forwards-compatibility is definitely there.

Fortunately, things don't break that often. :) The biggest papercut
we've had recently was the introduction of enum64, which just flat
out requires the latest userspace if kernel btf is needed.
>> Take this as another plea to make this opt in and instead work
>> together to make this a default on the lib side. :)
> Please, help me understand the arguments against making rotating mode
> a default, now that we return -ENOSPC on truncation. In which scenario
> this difference matters?
I think there may be a misunderstanding. As you mentioned, there's rarely
anything useful at the start of the log. I think the opt-in behaviour
under discussion here is the lack of ENOSPC when the buffer is undersized.
Userspace should set a flag if it supports receiving a partial log without
expecting ENOSPC.

I've lost track of the exact changes that are now on the table with your
second patch set floating around. The way I understand it, there are
multiple isolated behavioural changes, so let's discuss them separately:

- Log will include the tail instead of the head. This is a good change, no
   argument there, and personally I wouldn't bother with a flag until
   someone complains. Old userspace is (worst case) already used to retrying
   with bigger buffers until ENOSPC is gone, and (best case) gets a few 
pages
   of actually useful log if it doesn't retry.

- log_size_actual: if populated by the kernel, userspace can do a perfect
   retry with the correct buffer size. Userspace will naturally be able to
   pick this up when their bpf_attr gets updated. No opt-in/flags needed
   because not a breaking change.

- No more ENOSPC: this needs to be opt-in, as old userspace relies on ENOSPC
   to drive the retry loop. If the kernel no longer returns ENOSPC by 
default,
   userspace will think it received a full log and won't be able to detect
   truncation if it doesn't yet know about the log_size_actual field.
   From what I gather, we're also in agreement on this. Idea for a flag 
name:
   BPF_LOG_PARTIAL?

Hope this can move the discussion forward, it looked to me like we were just
talking past each other. Thanks for addressing our feedback so far!
> 1. If there is no truncation and the user provides a big enough buffer
> (which my second patch set makes it even easier to do for libraries),
> there is no difference, they get identical log contents and behavior.
>
> 2. If there was truncation, in both cases we get -ENOSPC. The contents
> will differ. In one case we get the beginning of a long log with no
> details about what actually caused the failure (useless in pretty much
> any circumstances) versus you get the last N bytes of log, all the way
> to actual error and some history leading towards it. Which is what we
> used to debug and understand verification issues.
>
> What is the situation where the beginning of the log is preferable? I
> had exactly one case where I actually wanted the beginning of the log,
> that was when I was debugging some bug in the verifier when
> implementing open-coded iterators. This bug was happening early and
> causing an infinite loop, so I wanted to see the first few pages of
> the output to catch how it all started. But that was a development bug
> of a tricky feature, definitely not something we expect for end users
> to deal with. And it was literally *once* that I needed this.
>
> Why are we fighting to preserve this much less useful behavior as a
> default, if there is no reduction of functionality for end-users?
> Library writers have full access to union bpf_attr and can opt-out
> easily (though again, why?). Normal end users will never have to ask
> for BPF_LOG_FIXED behavior. Maybe some advanced tool-building users
> will want BPF_LOG_FIXED (like veristat, for example), but then it's in
> their best interest to have fresh enough libbpf anyways.
>
> So instead of "I want X over Y", let's discuss "*why* X is better than Y"?
>
>> Apps linking old libbpf won't be able to fix their breakage without
>> updating libbpf. This is especially annoying when you have to support
> What sort of breakage would be there to fix?
>
> Also keep in mind that not all use cases use BPF library's high-level
> code that does all this fancy log buf manipulations. There are
> legitimate cases where tools/applications want direct access to
> log_buf, so needing to do extra feature detection to get rotating mode
> (but falling back without failing to fixed mode on the old kernel) is
> just an unnecessary nuisance.


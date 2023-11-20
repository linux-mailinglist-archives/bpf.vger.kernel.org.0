Return-Path: <bpf+bounces-15389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AA7F1C06
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3DD28228C
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB33032B;
	Mon, 20 Nov 2023 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N3F0VHT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0B92
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:10:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso6513477a12.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700503816; x=1701108616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Im3tYWVO+LRZrM7NFMlzk7H5GIoIMMlBQ7FkUz9ocr4=;
        b=N3F0VHT0/KXzVj3HaD+0YuJL3JeaqWRDLpst446ul4f23TtBtakP8kgVcrSgzgWTsc
         iCoPztox8xArWuazH9aGupoN4H9bgtMbcG4QakP1lXSNFXJgx9nEnRRwynlHt6hBXvNN
         JtlI825a4mk7XiU5TU9ImLhHjr+DYmbZPXIcQbcAf1V6Bpibk7aQfhLWA9qJ5/a39NQN
         kVdq46YFaXKargUGiNSCyCSq9JWaJ/fSptkZKGjBUjp57N1D3V43zIFQv6/yqx1X25uS
         tTg00TRQ9nIyTK2NjaKDw8ptGsq6m35TnMpo1Yes/FKgau4xZKEXibQUCSPNbUd37cd7
         9LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700503816; x=1701108616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im3tYWVO+LRZrM7NFMlzk7H5GIoIMMlBQ7FkUz9ocr4=;
        b=T3cWAGzRorHjywIKM1vutLWRpt0vmQ+Z9+gpkEW3PXBum8HEGpUaAsgqc7VlRJan/z
         IA3VSbxXDMUfFELTPibpqugejkkAYQb3cZjd5HydI4UfLPGFEha4Pmn3kOBAeGqXfxly
         du1lN5X+MZOmkFr5Ec6QEfXKI94WDGT9he9wHHYKsiRb+MSoQwjprX3F0+u1eN3af0CB
         fjX0XXS/wlvKv+xxD0ESyopAxvQVmNXnXiNIdUgW4h0gt/jxt5RrYKls/DJPSqcd+fWG
         awwM1g2VrOyhaPWOVnYNsG4hj8XWsE2mzQm2pWJH94h/78raxloRjQ9TpXsOiWMrvXuU
         yBhg==
X-Gm-Message-State: AOJu0YwxtAc1xa94Bjz5VKkQrBLsj5z1QN1ZwmLqvWaF3LNd40rP5XvN
	XZe+Lo8KDUrXR+TyGmGhycq2bg==
X-Google-Smtp-Source: AGHT+IHnPTI9nGiRC+OjgCLGh7ODbwTqhq4Tp2oQC5T7at+donh8y1CBZiGdF2MLwQ1Fean+N/kNYA==
X-Received: by 2002:aa7:cfd1:0:b0:540:37d6:c1f3 with SMTP id r17-20020aa7cfd1000000b0054037d6c1f3mr143374edy.11.1700503816255;
        Mon, 20 Nov 2023 10:10:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f2-20020a50ee82000000b00548c4c4b8d5sm1170061edr.13.2023.11.20.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 10:10:15 -0800 (PST)
Date: Mon, 20 Nov 2023 19:10:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	deb.chatterjee@intel.com, anjali.singhai@intel.com,
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com, dan.daly@intel.com,
	chris.sommers@keysight.com, john.andy.fingerhut@intel.com
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Message-ID: <ZVuhBlYRwi8eGiSF@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch>
 <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho>
 <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>

Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 20, 2023 at 4:39 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
>> >On Fri, Nov 17, 2023 at 1:37 PM John Fastabend <john.fastabend@gmail.com> wrote:
>> >>
>> >> Jamal Hadi Salim wrote:
>> >> > On Fri, Nov 17, 2023 at 1:27 AM John Fastabend <john.fastabend@gmail.com> wrote:
>> >> > >
>> >> > > Jamal Hadi Salim wrote:
>>
>> [...]
>>
>>
>> >>
>> >> I think I'm judging the technical work here. Bullet points.
>> >>
>> >> 1. p4c-tc implementation looks like it should be slower than a
>> >>    in terms of pkts/sec than a bpf implementation. Meaning
>> >>    I suspect pipeline and objects laid out like this will lose
>> >>    to a BPF program with an parser and single lookup. The p4c-ebpf
>> >>    compiler should look to create optimized EBPF code not some
>> >>    emulated switch topology.
>> >>
>> >
>> >The parser is ebpf based. The other objects which require control
>> >plane interaction are not - those interact via netlink.
>> >We published perf data a while back - presented at the P4 workshop
>> >back in April (was in the cover letter)
>> >https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4WorkshopP4TC.pdf
>> >But do note: the correct abstraction is the first priority.
>> >Optimization is something we can teach the compiler over time. But
>> >even with the minimalist code generation you can see that our approach
>> >always beats ebpf in LPM and ternary. The other ones I am pretty sure
>>
>> Any idea why? Perhaps the existing eBPF maps are not that suitable for
>> this kinds of lookups? I mean in theory, eBPF should be always faster.
>
>We didnt look closely; however, that is not the point - the point is
>the perf difference if there is one, is not big with the big win being
>proper P4 abstraction. For LPM for sure our algorithmic approach is
>better. For ternary the compute intensity in looping is better done in
>C. And for exact i believe that ebpf uses better hashing.
>Again, that is not the point we were trying to validate in those experiments..
>
>On your point of "maps are not that suitable" P4 tables tend to have
>very specific attributes (examples associated meters, counters,
>default hit and miss actions, etc).
>
>> >we can optimize over time.
>> >Your view of "single lookup" is true for simple programs but if you
>> >have 10 tables trying to model a 5G function then it doesnt make sense
>> >(and i think the data we published was clear that you gain no
>> >advantage using ebpf - as a matter of fact there was no perf
>> >difference between XDP and tc in such cases).
>> >
>> >> 2. p4c-tc control plan looks slower than a directly mmaped bpf
>> >>    map. Doing a simple update vs a netlink msg. The argument
>> >>    that BPF can't do CRUD (which we had offlist) seems incorrect
>> >>    to me. Correct me if I'm wrong with details about why.
>> >>
>> >
>> >So let me see....
>> >you want me to replace netlink and all its features and rewrite it
>> >using the ebpf system calls? Congestion control, event handling,
>> >arbitrary message crafting, etc and the years of work that went into
>> >netlink? NO to the HELL.
>>
>> Wait, I don't think John suggests anything like that. He just suggests
>> to have the tables as eBPF maps.
>
>What's the difference? Unless maps can do netlink.
>
>> Honestly, I don't understand the
>> fixation on netlink. Its socket messaging, memcpies, processing
>> overhead, etc can't keep up with mmaped memory access at scale. Measure
>> that and I bet you'll get drastically different results.
>>
>> I mean, netlink is good for a lot of things, but does not mean it is an
>> universal answer to userspace<->kernel data passing.
>
>Here's a small sample of our requirements that are satisfied by
>netlink for P4 object hierarchy[1]:
>1. Msg construction/parsing
>2. Multi-user request/response messaging

What is actually a usecase for having multiple users program p4 pipeline
in parallel?

>3. Multi-user event subscribe/publish messaging

Same here. What is the usecase for multiple users receiving p4 events?


>
>I dont think i need to provide an explanation on the differences here
>visavis what ebpf system calls provide vs what netlink provides and
>how netlink is a clear fit. If it is not clear i can give more

It is not :/


>breakdown. And of course there's more but above is a good sample.
>
>The part that is taken for granted is the control plane code and
>interaction which is an extremely important detail. P4 Abstraction
>requires hierarchies with different compiler generated encoded path
>ids etc. This ID mapping gets exacerbated by having multitudes of  P4

Why the actual eBFP mapping does not serve the same purpose as ID?
ID:mapping
1 :1
?


>programs which have different requirements. Netlink is a natural fit
>for this P4 abstraction. Not to mention the netlink/tc path (and in
>particular the ID mapping) provides a conduit for offload when that is
>needed.
>eBPF is just a tool - and the objects are intended to be generic - and
>i dont see how any of this could be achieved without retooling to make
>it more specific to P4.
>
>cheers,
>jamal
>
>
>
>>
>> >I should note: that there was an interesting talk at netdevconf 0x17
>> >where the speaker showed the challenges of dealing with ebpf on "day
>> >two" - slides or videos are not up yet, but link is:
>> >https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet-a-small-step-to-one-server-but-giant-leap-to-distributed-network.html
>> >The point the speaker was making is it's always easy to whip an ebpf
>> >program that can slice and dice packets and maybe even flush LEDs but
>> >the real work and challenge is in the control plane. I agree with the
>> >speaker based on my experiences. This discussion of replacing netlink
>> >with ebpf system calls is absolutely a non-starter. Let's just end the
>> >discussion and agree to disagree if you are going to keep insisting on
>> >that.
>>
>>
>> [...]


Return-Path: <bpf+bounces-15350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4D7F0F34
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F876281809
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7F11C95;
	Mon, 20 Nov 2023 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1zw85evA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B2E3
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 01:39:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso542207666b.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700473147; x=1701077947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMyBN7G2JC9JpvRUATAVzyBjob3kzlSJovwE2rxghuU=;
        b=1zw85evA4qYRJIKCg/oTn9Zhr2qYDSJAgV/QVUec5OO/fSWMYIXPLhgj8Zsx5Ux5Tl
         nUJ/bzv0tSAwo8vDJt9g2fYewPtvDIwd9bO0PhbXJpjnvyflMEZ/J1OlkOMeG2WpeGqZ
         VZxuhB0fnSRqQKVzJBWhFvWKfhteo6uLyJXE5BFklx1kxN9XQk7ZYaRw4kBWTu3ED9yO
         u/4ru44UnOda6OPGZQ2142j6Bk86l+MT2fUWBwzxB3QL3K+VH0vFqNIst2+565RYI2hk
         optjb0m+GjDEKjVSJlWl/bBMG75q5yZBQuaQ3uza/MwSFK/tsRt9EIGZ7O3cR9Smh/3Q
         0U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473147; x=1701077947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMyBN7G2JC9JpvRUATAVzyBjob3kzlSJovwE2rxghuU=;
        b=g/5JBPZBcZsdH6NqurkTYHOnesvpxL/AqlQl7PLUllllvPth3IAAABpx/jFNCwLg9z
         i0SxnIiBdeqOyt6JYYIBRGttSskASXPCK+4yb28V5GyLXCbppiS1TTcPWvMDrVHIG43n
         D2P/7tkFrmBFbrAaaF00R78VeE2KPVbPOLrCmS6sE59Wt6sTwBlIgz0Hz3Fdz5eJ1nw2
         t3qf+2PYulyy3gL3hDhS6gDRCw9/cEBadbCVJGbAa4sxPWrt1kxUdJ2D5mxJd/gjtTN9
         YCJl54RH/gu9A1TLUUmvA0Sj+8qa282ILzN1D4XS5XaDCPoYKCLcFg26a2hInxKWIibG
         d06w==
X-Gm-Message-State: AOJu0Yxrlb366XPXrRnrDE/mx0fvhwei+TxxUxxugHmjurvMCRBeD52u
	VvuE9QLphGcNVR8h13V4kpHqqQ==
X-Google-Smtp-Source: AGHT+IG8QGNe4idCGDJRUI61ExZ2IQfiUxxsxAf+Uw6jPQfsk6fjV99rNBrxjYSweEYjSmlggPcm6A==
X-Received: by 2002:a17:906:5ca:b0:9be:45b3:3116 with SMTP id t10-20020a17090605ca00b009be45b33116mr4912503ejt.71.1700473146955;
        Mon, 20 Nov 2023 01:39:06 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lh10-20020a170906f8ca00b009fd2028e62csm1388230ejb.71.2023.11.20.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 01:39:06 -0800 (PST)
Date: Mon, 20 Nov 2023 10:39:04 +0100
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
Message-ID: <ZVspOBmzrwm8isiD@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch>
 <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>

Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
>On Fri, Nov 17, 2023 at 1:37 PM John Fastabend <john.fastabend@gmail.com> wrote:
>>
>> Jamal Hadi Salim wrote:
>> > On Fri, Nov 17, 2023 at 1:27 AM John Fastabend <john.fastabend@gmail.com> wrote:
>> > >
>> > > Jamal Hadi Salim wrote:

[...]


>>
>> I think I'm judging the technical work here. Bullet points.
>>
>> 1. p4c-tc implementation looks like it should be slower than a
>>    in terms of pkts/sec than a bpf implementation. Meaning
>>    I suspect pipeline and objects laid out like this will lose
>>    to a BPF program with an parser and single lookup. The p4c-ebpf
>>    compiler should look to create optimized EBPF code not some
>>    emulated switch topology.
>>
>
>The parser is ebpf based. The other objects which require control
>plane interaction are not - those interact via netlink.
>We published perf data a while back - presented at the P4 workshop
>back in April (was in the cover letter)
>https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4WorkshopP4TC.pdf
>But do note: the correct abstraction is the first priority.
>Optimization is something we can teach the compiler over time. But
>even with the minimalist code generation you can see that our approach
>always beats ebpf in LPM and ternary. The other ones I am pretty sure

Any idea why? Perhaps the existing eBPF maps are not that suitable for
this kinds of lookups? I mean in theory, eBPF should be always faster.


>we can optimize over time.
>Your view of "single lookup" is true for simple programs but if you
>have 10 tables trying to model a 5G function then it doesnt make sense
>(and i think the data we published was clear that you gain no
>advantage using ebpf - as a matter of fact there was no perf
>difference between XDP and tc in such cases).
>
>> 2. p4c-tc control plan looks slower than a directly mmaped bpf
>>    map. Doing a simple update vs a netlink msg. The argument
>>    that BPF can't do CRUD (which we had offlist) seems incorrect
>>    to me. Correct me if I'm wrong with details about why.
>>
>
>So let me see....
>you want me to replace netlink and all its features and rewrite it
>using the ebpf system calls? Congestion control, event handling,
>arbitrary message crafting, etc and the years of work that went into
>netlink? NO to the HELL.

Wait, I don't think John suggests anything like that. He just suggests
to have the tables as eBPF maps. Honestly, I don't understand the
fixation on netlink. Its socket messaging, memcpies, processing
overhead, etc can't keep up with mmaped memory access at scale. Measure
that and I bet you'll get drastically different results.

I mean, netlink is good for a lot of things, but does not mean it is an
universal answer to userspace<->kernel data passing.


>I should note: that there was an interesting talk at netdevconf 0x17
>where the speaker showed the challenges of dealing with ebpf on "day
>two" - slides or videos are not up yet, but link is:
>https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet-a-small-step-to-one-server-but-giant-leap-to-distributed-network.html
>The point the speaker was making is it's always easy to whip an ebpf
>program that can slice and dice packets and maybe even flush LEDs but
>the real work and challenge is in the control plane. I agree with the
>speaker based on my experiences. This discussion of replacing netlink
>with ebpf system calls is absolutely a non-starter. Let's just end the
>discussion and agree to disagree if you are going to keep insisting on
>that.


[...]


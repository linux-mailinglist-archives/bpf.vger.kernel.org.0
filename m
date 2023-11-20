Return-Path: <bpf+bounces-15415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EEE7F1FBB
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93423B218E6
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606838FBF;
	Mon, 20 Nov 2023 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="AEVRh0y5"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B910E3;
	Mon, 20 Nov 2023 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6z00VmEELdZVjSRv0pGu+s9rPtt4Qa/zpGj3a4qO7PE=; b=AEVRh0y54FR7i9XZf6Hflb4zRy
	lkgdtFkZhOKTqhUQASMeUtsUtom8/yLhDYi3FtMbBkxprHNgtgUMi1HzYFG7bOYgkx3EhGfHmFTiM
	hGtURrXx5/Ny8kFmgGWyVQhCqLkpEhkscxKU62f/xb1Lktd3AoRbHR9wy9K0AD1vUBzag5nZCkw4H
	1fbKMlJ2hik58kYYYrjY5vbNK3n2D5CGu9N6jf336CyYr1OGzimw0MfjaEbXBfuXG+So0npPFR89+
	mPqhJwirW3Kf4XSMm/IoQULxCvUldJGMtLdtLKNLk0/dXH6dGeTboeHKLJjLX1cneNCHwl/M4AcbZ
	ZW2jFLlw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5C8P-0004RJ-Co; Mon, 20 Nov 2023 22:48:49 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5C8O-000O1s-DQ; Mon, 20 Nov 2023 22:48:48 +0100
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 deb.chatterjee@intel.com, anjali.singhai@intel.com, Vipin.Jain@amd.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com,
 dan.daly@intel.com, chris.sommers@keysight.com, john.andy.fingerhut@intel.com
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch>
 <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho>
 <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho>
 <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
Date: Mon, 20 Nov 2023 22:48:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27099/Mon Nov 20 09:39:02 2023)

On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> On Mon, Nov 20, 2023 at 1:10 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
>>> On Mon, Nov 20, 2023 at 4:39 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>> Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
>>>>> On Fri, Nov 17, 2023 at 1:37 PM John Fastabend <john.fastabend@gmail.com> wrote:
>>>>>> Jamal Hadi Salim wrote:
>>>>>>> On Fri, Nov 17, 2023 at 1:27 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>>>>>>> Jamal Hadi Salim wrote:
>>>>
>>>> [...]
>>>>
>>>>>> I think I'm judging the technical work here. Bullet points.
>>>>>>
>>>>>> 1. p4c-tc implementation looks like it should be slower than a
>>>>>>     in terms of pkts/sec than a bpf implementation. Meaning
>>>>>>     I suspect pipeline and objects laid out like this will lose
>>>>>>     to a BPF program with an parser and single lookup. The p4c-ebpf
>>>>>>     compiler should look to create optimized EBPF code not some
>>>>>>     emulated switch topology.
>>>>>
>>>>> The parser is ebpf based. The other objects which require control
>>>>> plane interaction are not - those interact via netlink.
>>>>> We published perf data a while back - presented at the P4 workshop
>>>>> back in April (was in the cover letter)
>>>>> https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4WorkshopP4TC.pdf
>>>>> But do note: the correct abstraction is the first priority.
>>>>> Optimization is something we can teach the compiler over time. But
>>>>> even with the minimalist code generation you can see that our approach
>>>>> always beats ebpf in LPM and ternary. The other ones I am pretty sure
>>>>
>>>> Any idea why? Perhaps the existing eBPF maps are not that suitable for
>>>> this kinds of lookups? I mean in theory, eBPF should be always faster.
>>>
>>> We didnt look closely; however, that is not the point - the point is
>>> the perf difference if there is one, is not big with the big win being
>>> proper P4 abstraction. For LPM for sure our algorithmic approach is
>>> better. For ternary the compute intensity in looping is better done in
>>> C. And for exact i believe that ebpf uses better hashing.
>>> Again, that is not the point we were trying to validate in those experiments..
>>>
>>> On your point of "maps are not that suitable" P4 tables tend to have
>>> very specific attributes (examples associated meters, counters,
>>> default hit and miss actions, etc).
>>>
>>>>> we can optimize over time.
>>>>> Your view of "single lookup" is true for simple programs but if you
>>>>> have 10 tables trying to model a 5G function then it doesnt make sense
>>>>> (and i think the data we published was clear that you gain no
>>>>> advantage using ebpf - as a matter of fact there was no perf
>>>>> difference between XDP and tc in such cases).
>>>>>
>>>>>> 2. p4c-tc control plan looks slower than a directly mmaped bpf
>>>>>>     map. Doing a simple update vs a netlink msg. The argument
>>>>>>     that BPF can't do CRUD (which we had offlist) seems incorrect
>>>>>>     to me. Correct me if I'm wrong with details about why.
>>>>>
>>>>> So let me see....
>>>>> you want me to replace netlink and all its features and rewrite it
>>>>> using the ebpf system calls? Congestion control, event handling,
>>>>> arbitrary message crafting, etc and the years of work that went into
>>>>> netlink? NO to the HELL.
>>>>
>>>> Wait, I don't think John suggests anything like that. He just suggests
>>>> to have the tables as eBPF maps.
>>>
>>> What's the difference? Unless maps can do netlink.
>>>
>>>> Honestly, I don't understand the
>>>> fixation on netlink. Its socket messaging, memcpies, processing
>>>> overhead, etc can't keep up with mmaped memory access at scale. Measure
>>>> that and I bet you'll get drastically different results.
>>>>
>>>> I mean, netlink is good for a lot of things, but does not mean it is an
>>>> universal answer to userspace<->kernel data passing.
>>>
>>> Here's a small sample of our requirements that are satisfied by
>>> netlink for P4 object hierarchy[1]:
>>> 1. Msg construction/parsing
>>> 2. Multi-user request/response messaging
>>
>> What is actually a usecase for having multiple users program p4 pipeline
>> in parallel?
> 
> First of all - this is Linux, multiple users is a way of life, you
> shouldnt have to ask that question unless you are trying to be
> socratic. Meaning multiple control plane apps can be allowed to
> program different parts and even different tables - think multi-tier
> pipeline.
> 
>>> 3. Multi-user event subscribe/publish messaging
>>
>> Same here. What is the usecase for multiple users receiving p4 events?
> 
> Same thing.
> Note: Events are really not part of P4 but we added them for
> flexibility - and as you well know they are useful.
> 
>>> I dont think i need to provide an explanation on the differences here
>>> visavis what ebpf system calls provide vs what netlink provides and
>>> how netlink is a clear fit. If it is not clear i can give more
>>
>> It is not :/
> 
> I thought it was obvious for someone like you, but fine - here goes for those 3:
> 
> 1. Msg construction/parsing: A lot of infra for sending attributes
> back and forth is already built into netlink. I would have to create
> mine from scratch for ebpf.  This will include not just the
> construction/parsing but all the detailed attribute content policy
> validations(even in the presence of hierarchies) that comes with it.
> And not to forget the state transform between kernel and user space.
> 
> 2. Multi-user request/response messaging
> If you can write all the code for #1 above then this should work fine for ebpf
> 
> 3. Event publish subscribe
> You would have to create mechanisms for ebpf which either are non
> trivial or non complete: Example 1: you can put surgeries in the ebpf
> code to look at map manipulations and then interface it to some event
> management scheme which checks for subscribed users. Example 2: It may
> also be feasible to create your own map for subscription vs something
> like perf ring for event publication(something i have done in the
> past), but that is also limited in many ways.

I still don't think this answers all the questions on why the netlink
shim layer. The kfuncs are essentially available to all of tc BPF and
I don't think there was a discussion why they cannot be done generic
in a way that they could benefit all tc/XDP BPF users. With the patch
14 you are more or less copying what is existing with {cls,act}_bpf
just that you also allow XDP loading from tc(?). We do have existing
interfaces for XDP program management.

tc BPF and XDP already have widely used infrastructure and can be developed
against libbpf or other user space libraries for a user space control plane.
With 'control plane' you refer here to the tc / netlink shim you've built,
but looking at the tc command line examples, this doesn't really provide a
good user experience (you call it p4 but people load bpf obj files). If the
expectation is that an operator should run tc commands, then neither it's
a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved over
to bpf_mprog and plan to also extend this for XDP to have a common look and
feel wrt networking for developers. Why can't this be reused?

I don't quite follow why not most of this could be implemented entirely in
user space without the detour of this and you would provide a developer
library which could then be integrated into a p4 runtime/frontend? This
way users never interface with ebpf parts nor tc given they also shouldn't
have to - it's an implementation detail. This is what John was also pointing
out earlier.

If you need notifications/subscribe mechanism for map updates, then this
could be extended.. same way like BPF internals got extended along with the
sched_ext work, making the core pieces more useful also outside of the latter.

The link to below slides are not public, so it's hard to see what is really
meant here, but I have also never seen an email from the speaker on the BPF
mailing list providing concrete feedback(?). People do build control planes
around BPF in the wild, I'm not sure where you take 'flush LEDs' from, to
me this all sounds rather hand-wavy and trying to brute-force the fixation
on netlink you went with that is raising questions. I don't think there was
objection on going with eBPF but rather all this infra for the former for
a SW-only extension.

[...]
>>>>> I should note: that there was an interesting talk at netdevconf 0x17
>>>>> where the speaker showed the challenges of dealing with ebpf on "day
>>>>> two" - slides or videos are not up yet, but link is:
>>>>> https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet-a-small-step-to-one-server-but-giant-leap-to-distributed-network.html
>>>>> The point the speaker was making is it's always easy to whip an ebpf
>>>>> program that can slice and dice packets and maybe even flush LEDs but
>>>>> the real work and challenge is in the control plane. I agree with the
>>>>> speaker based on my experiences. This discussion of replacing netlink
>>>>> with ebpf system calls is absolutely a non-starter. Let's just end the
>>>>> discussion and agree to disagree if you are going to keep insisting on
>>>>> that.


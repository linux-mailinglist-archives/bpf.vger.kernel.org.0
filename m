Return-Path: <bpf+bounces-15631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357287F4192
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ABE1F21B5F
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84C5102B;
	Wed, 22 Nov 2023 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uw/hsVrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF810E
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 01:26:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a0064353af8so126779266b.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 01:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700645159; x=1701249959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYB3xSqWL2utt7ZumJC6UZi+VB8TtxBhPBL+bW1Kwoo=;
        b=uw/hsVrvmYs4J2ZG8pH2GsO9CmyUXf2viqVxuvC19LkhnWIl0po1N3kpvVpiRNu/3Q
         lNe6UvL7oExFPcR/qoNDh9peBaoP6pc3VfxNmWeUdiD9c8V64gekYHxVYYkKi8KUBefS
         /9FsJzX4dYr/h3QVW7ifEghyKK/cnuQxUgtnhvkgv5sx6vQH0y82p7iCKyoLWO7ObG0h
         0qZnea74AXzWlrC7DtMNuv7Z4KZgBG42PdFHkWKj6hKdiVtWXGG2ZQDXvWQgyGyNO6XI
         ZTrbSQNyWE6vt9EIlOTkNpcrPZno/bHw4Q+RFD4fp9vYdoW+QRBHiPPrdMTw+NluZpoE
         i0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700645159; x=1701249959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYB3xSqWL2utt7ZumJC6UZi+VB8TtxBhPBL+bW1Kwoo=;
        b=b2RohFgBgxvVDH93GpcKSnKOdJVvwaUab2H69KSv5Dt5nRNJGqBv85/PF89OJJOavw
         phIbE8ED4L6zbaWznAfwTmEL0E824Vmnbsz/BPLlRchhC5Osh3wjYNPAz+D+4YErQCDw
         4u9U9qeCSROiHEbbKLBwmwBP9qJo/An7SpFGsLCURg1QlDKYG4PV6FAFWWNz58/XWOhz
         BHr8Zy1aUbE8fagFYbHeT8pNBa1WaeNXEB4039B2d2zGacl5un/MMrGhr4BRI6qw0n0n
         uODXITwN3qQG+hRTM9kC38BpUvyUYgPS2y8eOUG0HjDOaSt2i60+otjaAZCGv0zLs6sD
         Dsyw==
X-Gm-Message-State: AOJu0YxiDJD+cA/qFHzAcwC6uFqVFKPG7R9YS3cKMHodkdCg1PJa4CI9
	cR9lCSY3WXL6roZf7dN0wEeq9A==
X-Google-Smtp-Source: AGHT+IGNFVueSnWdYATQ/B9wl+GDeM5MJg1yKcKKQs1JISWDkdcs+kRqbIEdYpQZCOUsM/ak1pAwfw==
X-Received: by 2002:a17:906:210:b0:9ad:8a96:ad55 with SMTP id 16-20020a170906021000b009ad8a96ad55mr1367430ejd.14.1700645159097;
        Wed, 22 Nov 2023 01:25:59 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j19-20020a1709062a1300b00a0029289961sm2831427eje.190.2023.11.22.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:25:58 -0800 (PST)
Date: Wed, 22 Nov 2023 10:25:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	deb.chatterjee@intel.com, anjali.singhai@intel.com,
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com,
	mattyk@nvidia.com, dan.daly@intel.com, chris.sommers@keysight.com,
	john.andy.fingerhut@intel.com
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Message-ID: <ZV3JJQirPdZpbVIC@nanopsycho>
References: <ZVspOBmzrwm8isiD@nanopsycho>
 <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho>
 <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
 <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
 <ZVyrRFDrVqluD9k/@nanopsycho>
 <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
 <ZVy8cEjs9VK2OVxE@nanopsycho>
 <CAM0EoMmPnCeU2uLph=uwh3JxtE4RQnvcSA2WdZgORywzNFCO6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmPnCeU2uLph=uwh3JxtE4RQnvcSA2WdZgORywzNFCO6g@mail.gmail.com>

Tue, Nov 21, 2023 at 04:21:44PM CET, jhs@mojatatu.com wrote:
>On Tue, Nov 21, 2023 at 9:19 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com wrote:
>> >On Tue, Nov 21, 2023 at 8:06 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
>> >> >On Mon, Nov 20, 2023 at 4:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> >> >>
>> >> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
>> >> >> > On Mon, Nov 20, 2023 at 1:10 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
>> >>
>> >> [...]
>> >>
>> >> >
>> >> >> tc BPF and XDP already have widely used infrastructure and can be developed
>> >> >> against libbpf or other user space libraries for a user space control plane.
>> >> >> With 'control plane' you refer here to the tc / netlink shim you've built,
>> >> >> but looking at the tc command line examples, this doesn't really provide a
>> >> >> good user experience (you call it p4 but people load bpf obj files). If the
>> >> >> expectation is that an operator should run tc commands, then neither it's
>> >> >> a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved over
>> >> >> to bpf_mprog and plan to also extend this for XDP to have a common look and
>> >> >> feel wrt networking for developers. Why can't this be reused?
>> >> >
>> >> >The filter loading which loads the program is considered pipeline
>> >> >instantiation - consider it as "provisioning" more than "control"
>> >> >which runs at runtime. "control" is purely netlink based. The iproute2
>> >> >code we use links libbpf for example for the filter. If we can achieve
>> >> >the same with bpf_mprog then sure - we just dont want to loose
>> >> >functionality though.  off top of my head, some sample space:
>> >> >- we could have multiple pipelines with different priorities (which tc
>> >> >provides to us) - and each pipeline may have its own logic with many
>> >> >tables etc (and the choice to iterate the next one is essentially
>> >> >encoded in the tc action codes)
>> >> >- we use tc block to map groups of ports (which i dont think bpf has
>> >> >internal access of)
>> >> >
>> >> >In regards to usability: no i dont expect someone doing things at
>> >> >scale to use command line tc. The APIs are via netlink. But the tc cli
>> >> >is must for the rest of the masses per our traditions. Also i really
>> >>
>> >> I don't follow. You repeatedly mention "the must of the traditional tc
>> >> cli", but what of the existing traditional cli you use for p4tc?
>> >> If I look at the examples, pretty much everything looks new to me.
>> >> Example:
>> >>
>> >>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>> >>     action send_to_port param port eno1
>> >>
>> >> This is just TC/RTnetlink used as a channel to pass new things over. If
>> >> that is the case, what's traditional here?
>> >>
>> >
>> >
>> >What is not traditional about it?
>>
>> Okay, so in that case, the following example communitating with
>> userspace deamon using imaginary "p4ctrl" app is equally traditional:
>>   $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>>      action send_to_port param port eno1
>
>Huh? Thats just an application - classical tc which part of iproute2
>that is sending to the kernel, no different than "tc flower.."
>Where do you get the "userspace" daemon part? Yes, you can write a
>daemon but it will use the same APIs as tc.

Okay, so which part is the "tradition"?


>
>>
>> >
>> >>
>> >> >didnt even want to use ebpf at all for operator experience reasons -
>> >> >it requires a compilation of the code and an extra loading compared to
>> >> >what our original u32/pedit code offered.
>> >> >
>> >> >> I don't quite follow why not most of this could be implemented entirely in
>> >> >> user space without the detour of this and you would provide a developer
>> >> >> library which could then be integrated into a p4 runtime/frontend? This
>> >> >> way users never interface with ebpf parts nor tc given they also shouldn't
>> >> >> have to - it's an implementation detail. This is what John was also pointing
>> >> >> out earlier.
>> >> >>
>> >> >
>> >> >Netlink is the API. We will provide a library for object manipulation
>> >> >which abstracts away the need to know netlink. Someone who for their
>> >> >own reasons wants to use p4runtime or TDI could write on top of this.
>> >> >I would not design a kernel interface to just meet p4runtime (we
>> >> >already have TDI which came later which does things differently). So i
>> >> >expect us to support both those two. And if i was to do something on
>> >> >SDN that was more robust i would write my own that still uses these
>> >> >netlink interfaces.
>> >>
>> >> Actually, what Daniel says about the p4 library used as a backend to p4
>> >> frontend is pretty much aligned what I claimed on the p4 calls couple of
>> >> times. If you have this p4 userspace tooling, it is easy for offloads to
>> >> replace the backed by vendor-specific library which allows p4 offload
>> >> suitable for all vendors (your plan of p4tc offload does not work well
>> >> for our hw, as we repeatedly claimed).
>> >>
>> >
>> >That's you - NVIDIA. You have chosen a path away from the kernel
>> >towards DOCA. I understand NVIDIA's frustration with dealing with
>> >upstream process (which has been cited to me as a good reason for
>> >DOCA) but please dont impose these values and your politics on other
>> >vendors(Intel, AMD for example) who are more than willing to invest
>> >into making the kernel interfaces the path forward. Your choice.
>>
>> No, you are missing the point. This has nothing to do with DOCA.
>
>Right Jiri ;->
>
>> This
>> has to do with the simple limitation of your offload assuming there are
>> no runtime changes in the compiled pipeline. For Intel, maybe they
>> aren't, and it's a good fit for them. All I say is, that it is not the
>> good fit for everyone.
>
> a) it is not part of the P4 spec to dynamically make changes to the
>datapath pipeline after it is create and we are discussing a P4

Isn't this up to the implementation? I mean from the p4 perspective,
everything is static. Hw might need to reshuffle the pipeline internally
during rule insertion/remove in order to optimize the layout.


>implementation not an extension that would add more value b) We are
>more than happy to add extensions in the future to accomodate for
>features but first _P4 spec_ must be met c) we had longer discussions
>with Matty, Khalid and the Rice folks who wrote a paper on that topic
>which you probably didnt attend and everything that needs to be done
>can be from user space today for all those optimizations.
>
>Conclusion is: For what you need to do (which i dont believe is a
>limitation in your hardware rather a design decision on your part) run
>your user space daemon, do optimizations and update the datapath.
>Everybody is happy.

Should the userspace daemon listen on inserted rules to be offloade
over netlink?


>
>>
>> >Nobody is stopping you from offering your customers proprietary
>> >solutions which include a specific ebpf approach alongside DOCA. We
>> >believe that a singular interface regardless of the vendor is the
>> >right way forward. IMHO, this siloing that unfortunately is also added
>> >by eBPF being a double edged sword is not good for the community.
>> >
>> >> As I also said on the p4 call couple of times, I don't see the kernel
>> >> as the correct place to do the p4 abstractions. Why don't you do it in
>> >> userspace and give vendors possiblity to have p4 backends with compilers,
>> >> runtime optimizations etc in userspace, talking to the HW in the
>> >> vendor-suitable way too. Then the SW implementation could be easily eBPF
>> >> and the main reason (I believe) why you need to have this is TC
>> >> (offload) is then void.
>> >>
>> >> The "everyone wants to use TC/netlink" claim does not seem correct
>> >> to me. Why not to have one Linux p4 solution that fits everyones needs?
>> >
>> >You mean more fitting to the DOCA world? no, because iam a kernel
>>
>> Again, this has 0 relation to DOCA.
>>
>>
>> >first person and kernel interfaces are good for everyone.
>>
>> Yeah, not really. Not always the kernel is the right answer. Your/Intel
>> plan to handle the offload by:
>> 1) abuse devlink to flash p4 binary
>> 2) parse the binary in kernel to match to the table ids of rules coming
>>    from p4tc ndo_setup_tc
>> 3) abuse devlink to flash p4 binary for tc-flower
>> 4) parse the binary in kernel to match to the table ids of rules coming
>>    from tc-flower ndo_setup_tc
>> is really something that is making me a little bit nauseous.
>>
>> If you don't have a feasible plan to do the offload, p4tc does not make
>> sense to me to be honest.
>
>You mean if there's no plan to match your (NVIDIA?)  point of view.
>For #1 - how's this different from DDP? Wasnt that your suggestion to

I doubt that. Any flashing-blob-parsing-in-kernel is something I'm
opposed to from day 1.


>begin with? For #2 Nobody is proposing to do anything of the sort. The
>ndo is passed IDs for the objects and associated contents. For #3+#4

During offload, you need to parse the blob in driver to be able to match
the ids with blob entities. That was presented by you/Intel in the past
IIRC.


>tc flower thing has nothing to do with P4TC that was just some random
>proposal someone made seeing if they could ride on top of P4TC.

Yeah, it's not yet merged and already mentally used for abuse. I love
that :)


>
>Besides this nobody really has to satisfy your point of view - like i
>said earlier feel free to provide proprietary solutions. From a
>consumer perspective  I would not want to deal with 4 different
>vendors with 4 different proprietary approaches. The kernel is the
>unifying part. You seemed happier with tc flower just not with the

Yeah, that is my point, why the unifying part can't be a userspace
daemon/library with multiple backends (p4tc, bpf, vendorX, vendorY, ..)?

I just don't see the kernel as a good fit for abstraction here,
given the fact that the vendor compilers does not run in kernel.
That is breaking your model.


>kernel process - which is ironically the same thing we are going
>through here ;->
>
>cheers,
>jamal
>
>>
>> >
>> >cheers,
>> >jamal


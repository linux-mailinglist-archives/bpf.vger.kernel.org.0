Return-Path: <bpf+bounces-15752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09287F605D
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 14:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95090281E66
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC52511D;
	Thu, 23 Nov 2023 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BJTpZjPj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DDC1
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 05:34:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so1233632a12.0
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700746493; x=1701351293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nJ/hyxIACd2dhR3cJNgixFOyRd50JdHPRmu+MaB5SMM=;
        b=BJTpZjPj/b+67jXyARazyLi6tTO/R6xoR4NMzewiuPx6KjI/Hb1at9WI7Ob7X/4IPe
         PNG/li0Ftmt0mlarkwBmAwXUu4xnFqIRj5CGPuW3H8EdrBsfmqGHayZBOHrUtg1rTgwr
         TbVqQc6t+9j+6Y+SUTGdSTS3klnzQeztCcikLm+WOQwEO0AUXym0RMksOU4Da6YP8qsK
         GAozywAsZR6HmerQcBox9fBqykdNjLIIO8KtRSDZfU0ixE/SCo1z7f+j9ovRvrvmOaqK
         6IZqtxPeldixd4amytk6NsdO3uqbABazXjvDnZZcqE2oUFzlNNbIY/XsmSr1T/vKm7Lw
         JgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746493; x=1701351293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ/hyxIACd2dhR3cJNgixFOyRd50JdHPRmu+MaB5SMM=;
        b=PeVjfniHSjiVxEH/3GZxbLfqma3oKrZYhwglEN6WPHwDprDd7sYEa6Y1WPuFi6j5hM
         m1BkrAjlrjt4G7doesxJ5NAC93oUVcBxcLg5yZV9XRVMRHSC2dxF+uaHiX+A3c2zZLzF
         q6h/3rufFKsmBOxbCQ4VMQ8+/LG5nplHG38qv7zVBUp4QGwJIe26Pz9vzHzb0M0lndU6
         0cGA7xqYM0Uef7GW7AMUzT0mnqkMi5YNJgOjn9xFZzU4wOIixtqS6VC2vDn4QkZ6E+LW
         +j6S5Whx3Uz1xPTnoziGQK4dqDmZvw9FRIWsnIGoA85cNpZ2zV3ms3D9+bvp6160nuxo
         wkPw==
X-Gm-Message-State: AOJu0YzWgvfq+zai3M5/1UTfKdINVCgB4TJwBQBLoBnCAFNhMuAoHFPL
	/TI+NSh6/2l10BJaSiiEbID39Q==
X-Google-Smtp-Source: AGHT+IG7z/DyXsDa9lINPEf46gzaqaRf6Knc7NKOQBs2rsvjWAQ0lceKtkgoSE2BgPvlSALHYUfUrA==
X-Received: by 2002:aa7:d696:0:b0:540:346c:7b2f with SMTP id d22-20020aa7d696000000b00540346c7b2fmr3304858edr.40.1700746493263;
        Thu, 23 Nov 2023 05:34:53 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b0053dec545c8fsm664369edv.3.2023.11.23.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:34:52 -0800 (PST)
Date: Thu, 23 Nov 2023 14:34:51 +0100
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
Message-ID: <ZV9U+zsMM5YqL8Cx@nanopsycho>
References: <ZVyrRFDrVqluD9k/@nanopsycho>
 <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
 <ZVy8cEjs9VK2OVxE@nanopsycho>
 <CAM0EoMmPnCeU2uLph=uwh3JxtE4RQnvcSA2WdZgORywzNFCO6g@mail.gmail.com>
 <ZV3JJQirPdZpbVIC@nanopsycho>
 <CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
 <ZV5I/F+b5fu58Rlg@nanopsycho>
 <CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
 <ZV7y9JG0d4id8GeG@nanopsycho>
 <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>

Thu, Nov 23, 2023 at 02:22:11PM CET, jhs@mojatatu.com wrote:
>On Thu, Nov 23, 2023 at 1:36 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Nov 22, 2023 at 08:35:21PM CET, jhs@mojatatu.com wrote:
>> >On Wed, Nov 22, 2023 at 1:31 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Wed, Nov 22, 2023 at 04:14:02PM CET, jhs@mojatatu.com wrote:
>> >> >On Wed, Nov 22, 2023 at 4:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Tue, Nov 21, 2023 at 04:21:44PM CET, jhs@mojatatu.com wrote:
>> >> >> >On Tue, Nov 21, 2023 at 9:19 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >>
>> >> >> >> Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com wrote:
>> >> >> >> >On Tue, Nov 21, 2023 at 8:06 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >> >>
>> >> >> >> >> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
>> >> >> >> >> >On Mon, Nov 20, 2023 at 4:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> >> >> >> >> >>
>> >> >> >> >> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
>> >> >> >> >> >> > On Mon, Nov 20, 2023 at 1:10 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >> >> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
>> >> >> >> >>
>> >> >> >> >> [...]
>> >> >> >> >>
>> >> >> >> >> >
>> >> >> >> >> >> tc BPF and XDP already have widely used infrastructure and can be developed
>> >> >> >> >> >> against libbpf or other user space libraries for a user space control plane.
>> >> >> >> >> >> With 'control plane' you refer here to the tc / netlink shim you've built,
>> >> >> >> >> >> but looking at the tc command line examples, this doesn't really provide a
>> >> >> >> >> >> good user experience (you call it p4 but people load bpf obj files). If the
>> >> >> >> >> >> expectation is that an operator should run tc commands, then neither it's
>> >> >> >> >> >> a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved over
>> >> >> >> >> >> to bpf_mprog and plan to also extend this for XDP to have a common look and
>> >> >> >> >> >> feel wrt networking for developers. Why can't this be reused?
>> >> >> >> >> >
>> >> >> >> >> >The filter loading which loads the program is considered pipeline
>> >> >> >> >> >instantiation - consider it as "provisioning" more than "control"
>> >> >> >> >> >which runs at runtime. "control" is purely netlink based. The iproute2
>> >> >> >> >> >code we use links libbpf for example for the filter. If we can achieve
>> >> >> >> >> >the same with bpf_mprog then sure - we just dont want to loose
>> >> >> >> >> >functionality though.  off top of my head, some sample space:
>> >> >> >> >> >- we could have multiple pipelines with different priorities (which tc
>> >> >> >> >> >provides to us) - and each pipeline may have its own logic with many
>> >> >> >> >> >tables etc (and the choice to iterate the next one is essentially
>> >> >> >> >> >encoded in the tc action codes)
>> >> >> >> >> >- we use tc block to map groups of ports (which i dont think bpf has
>> >> >> >> >> >internal access of)
>> >> >> >> >> >
>> >> >> >> >> >In regards to usability: no i dont expect someone doing things at
>> >> >> >> >> >scale to use command line tc. The APIs are via netlink. But the tc cli
>> >> >> >> >> >is must for the rest of the masses per our traditions. Also i really
>> >> >> >> >>
>> >> >> >> >> I don't follow. You repeatedly mention "the must of the traditional tc
>> >> >> >> >> cli", but what of the existing traditional cli you use for p4tc?
>> >> >> >> >> If I look at the examples, pretty much everything looks new to me.
>> >> >> >> >> Example:
>> >> >> >> >>
>> >> >> >> >>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>> >> >> >> >>     action send_to_port param port eno1
>> >> >> >> >>
>> >> >> >> >> This is just TC/RTnetlink used as a channel to pass new things over. If
>> >> >> >> >> that is the case, what's traditional here?
>> >> >> >> >>
>> >> >> >> >
>> >> >> >> >
>> >> >> >> >What is not traditional about it?
>> >> >> >>
>> >> >> >> Okay, so in that case, the following example communitating with
>> >> >> >> userspace deamon using imaginary "p4ctrl" app is equally traditional:
>> >> >> >>   $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>> >> >> >>      action send_to_port param port eno1
>> >> >> >
>> >> >> >Huh? Thats just an application - classical tc which part of iproute2
>> >> >> >that is sending to the kernel, no different than "tc flower.."
>> >> >> >Where do you get the "userspace" daemon part? Yes, you can write a
>> >> >> >daemon but it will use the same APIs as tc.
>> >> >>
>> >> >> Okay, so which part is the "tradition"?
>> >> >>
>> >> >
>> >> >Provides tooling via tc cli that _everyone_ in the tc world is
>> >> >familiar with - which uses the same syntax as other tc extensions do,
>> >> >same expectations (eg events, request responses, familiar commands for
>> >> >dumping, flushing etc). Basically someone familiar with tc will pick
>> >> >this up and operate it very quickly and would have an easier time
>> >> >debugging it.
>> >> >There are caveats - as will be with all new classifiers - but those
>> >> >are within reason.
>> >>
>> >> Okay, so syntax familiarity wise, what's the difference between
>> >> following 2 approaches:
>> >> $ tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>> >>       action send_to_port param port eno1
>> >> $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>> >>       action send_to_port param port eno1
>> >> ?
>> >>
>> >>
>> >> >
>> >> >> >>
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> >didnt even want to use ebpf at all for operator experience reasons -
>> >> >> >> >> >it requires a compilation of the code and an extra loading compared to
>> >> >> >> >> >what our original u32/pedit code offered.
>> >> >> >> >> >
>> >> >> >> >> >> I don't quite follow why not most of this could be implemented entirely in
>> >> >> >> >> >> user space without the detour of this and you would provide a developer
>> >> >> >> >> >> library which could then be integrated into a p4 runtime/frontend? This
>> >> >> >> >> >> way users never interface with ebpf parts nor tc given they also shouldn't
>> >> >> >> >> >> have to - it's an implementation detail. This is what John was also pointing
>> >> >> >> >> >> out earlier.
>> >> >> >> >> >>
>> >> >> >> >> >
>> >> >> >> >> >Netlink is the API. We will provide a library for object manipulation
>> >> >> >> >> >which abstracts away the need to know netlink. Someone who for their
>> >> >> >> >> >own reasons wants to use p4runtime or TDI could write on top of this.
>> >> >> >> >> >I would not design a kernel interface to just meet p4runtime (we
>> >> >> >> >> >already have TDI which came later which does things differently). So i
>> >> >> >> >> >expect us to support both those two. And if i was to do something on
>> >> >> >> >> >SDN that was more robust i would write my own that still uses these
>> >> >> >> >> >netlink interfaces.
>> >> >> >> >>
>> >> >> >> >> Actually, what Daniel says about the p4 library used as a backend to p4
>> >> >> >> >> frontend is pretty much aligned what I claimed on the p4 calls couple of
>> >> >> >> >> times. If you have this p4 userspace tooling, it is easy for offloads to
>> >> >> >> >> replace the backed by vendor-specific library which allows p4 offload
>> >> >> >> >> suitable for all vendors (your plan of p4tc offload does not work well
>> >> >> >> >> for our hw, as we repeatedly claimed).
>> >> >> >> >>
>> >> >> >> >
>> >> >> >> >That's you - NVIDIA. You have chosen a path away from the kernel
>> >> >> >> >towards DOCA. I understand NVIDIA's frustration with dealing with
>> >> >> >> >upstream process (which has been cited to me as a good reason for
>> >> >> >> >DOCA) but please dont impose these values and your politics on other
>> >> >> >> >vendors(Intel, AMD for example) who are more than willing to invest
>> >> >> >> >into making the kernel interfaces the path forward. Your choice.
>> >> >> >>
>> >> >> >> No, you are missing the point. This has nothing to do with DOCA.
>> >> >> >
>> >> >> >Right Jiri ;->
>> >> >> >
>> >> >> >> This
>> >> >> >> has to do with the simple limitation of your offload assuming there are
>> >> >> >> no runtime changes in the compiled pipeline. For Intel, maybe they
>> >> >> >> aren't, and it's a good fit for them. All I say is, that it is not the
>> >> >> >> good fit for everyone.
>> >> >> >
>> >> >> > a) it is not part of the P4 spec to dynamically make changes to the
>> >> >> >datapath pipeline after it is create and we are discussing a P4
>> >> >>
>> >> >> Isn't this up to the implementation? I mean from the p4 perspective,
>> >> >> everything is static. Hw might need to reshuffle the pipeline internally
>> >> >> during rule insertion/remove in order to optimize the layout.
>> >> >>
>> >> >
>> >> >But do note: the focus here is on P4 (hence the name P4TC).
>> >> >
>> >> >> >implementation not an extension that would add more value b) We are
>> >> >> >more than happy to add extensions in the future to accomodate for
>> >> >> >features but first _P4 spec_ must be met c) we had longer discussions
>> >> >> >with Matty, Khalid and the Rice folks who wrote a paper on that topic
>> >> >> >which you probably didnt attend and everything that needs to be done
>> >> >> >can be from user space today for all those optimizations.
>> >> >> >
>> >> >> >Conclusion is: For what you need to do (which i dont believe is a
>> >> >> >limitation in your hardware rather a design decision on your part) run
>> >> >> >your user space daemon, do optimizations and update the datapath.
>> >> >> >Everybody is happy.
>> >> >>
>> >> >> Should the userspace daemon listen on inserted rules to be offloade
>> >> >> over netlink?
>> >> >>
>> >> >
>> >> >I mean you could if you wanted to given this is just traditional
>> >> >netlink which emits events (with some filtering when we integrate the
>> >> >filter approach). But why?
>> >>
>> >> Nevermind.
>> >>
>> >>
>> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> >Nobody is stopping you from offering your customers proprietary
>> >> >> >> >solutions which include a specific ebpf approach alongside DOCA. We
>> >> >> >> >believe that a singular interface regardless of the vendor is the
>> >> >> >> >right way forward. IMHO, this siloing that unfortunately is also added
>> >> >> >> >by eBPF being a double edged sword is not good for the community.
>> >> >> >> >
>> >> >> >> >> As I also said on the p4 call couple of times, I don't see the kernel
>> >> >> >> >> as the correct place to do the p4 abstractions. Why don't you do it in
>> >> >> >> >> userspace and give vendors possiblity to have p4 backends with compilers,
>> >> >> >> >> runtime optimizations etc in userspace, talking to the HW in the
>> >> >> >> >> vendor-suitable way too. Then the SW implementation could be easily eBPF
>> >> >> >> >> and the main reason (I believe) why you need to have this is TC
>> >> >> >> >> (offload) is then void.
>> >> >> >> >>
>> >> >> >> >> The "everyone wants to use TC/netlink" claim does not seem correct
>> >> >> >> >> to me. Why not to have one Linux p4 solution that fits everyones needs?
>> >> >> >> >
>> >> >> >> >You mean more fitting to the DOCA world? no, because iam a kernel
>> >> >> >>
>> >> >> >> Again, this has 0 relation to DOCA.
>> >> >> >>
>> >> >> >>
>> >> >> >> >first person and kernel interfaces are good for everyone.
>> >> >> >>
>> >> >> >> Yeah, not really. Not always the kernel is the right answer. Your/Intel
>> >> >> >> plan to handle the offload by:
>> >> >> >> 1) abuse devlink to flash p4 binary
>> >> >> >> 2) parse the binary in kernel to match to the table ids of rules coming
>> >> >> >>    from p4tc ndo_setup_tc
>> >> >> >> 3) abuse devlink to flash p4 binary for tc-flower
>> >> >> >> 4) parse the binary in kernel to match to the table ids of rules coming
>> >> >> >>    from tc-flower ndo_setup_tc
>> >> >> >> is really something that is making me a little bit nauseous.
>> >> >> >>
>> >> >> >> If you don't have a feasible plan to do the offload, p4tc does not make
>> >> >> >> sense to me to be honest.
>> >> >> >
>> >> >> >You mean if there's no plan to match your (NVIDIA?)  point of view.
>> >> >> >For #1 - how's this different from DDP? Wasnt that your suggestion to
>> >> >>
>> >> >> I doubt that. Any flashing-blob-parsing-in-kernel is something I'm
>> >> >> opposed to from day 1.
>> >> >>
>> >> >>
>> >> >
>> >> >Oh well - it is in the kernel and it works fine tbh.
>> >> >
>> >> >> >begin with? For #2 Nobody is proposing to do anything of the sort. The
>> >> >> >ndo is passed IDs for the objects and associated contents. For #3+#4
>> >> >>
>> >> >> During offload, you need to parse the blob in driver to be able to match
>> >> >> the ids with blob entities. That was presented by you/Intel in the past
>> >> >> IIRC.
>> >> >>
>> >> >
>> >> >You are correct - in case of offload the netlink IDs will have to be
>> >> >authenticated against what the hardware can accept, but the devlink
>> >> >flash use i believe was from you as a compromise.
>> >>
>> >> Definitelly not. I'm against devlink abuse for this from day 1.
>> >>
>> >>
>> >> >
>> >> >>
>> >> >> >tc flower thing has nothing to do with P4TC that was just some random
>> >> >> >proposal someone made seeing if they could ride on top of P4TC.
>> >> >>
>> >> >> Yeah, it's not yet merged and already mentally used for abuse. I love
>> >> >> that :)
>> >> >>
>> >> >> >
>> >> >> >Besides this nobody really has to satisfy your point of view - like i
>> >> >> >said earlier feel free to provide proprietary solutions. From a
>> >> >> >consumer perspective  I would not want to deal with 4 different
>> >> >> >vendors with 4 different proprietary approaches. The kernel is the
>> >> >> >unifying part. You seemed happier with tc flower just not with the
>> >> >>
>> >> >> Yeah, that is my point, why the unifying part can't be a userspace
>> >> >> daemon/library with multiple backends (p4tc, bpf, vendorX, vendorY, ..)?
>> >> >>
>> >> >> I just don't see the kernel as a good fit for abstraction here,
>> >> >> given the fact that the vendor compilers does not run in kernel.
>> >> >> That is breaking your model.
>> >> >>
>> >> >
>> >> >Jiri - we want to support P4, first. Like you said the P4 pipeline,
>> >> >once installed is static.
>> >> >P4 doesnt allow dynamic update of the pipeline. For example, once you
>> >> >say "here are my 14 tables and their associated actions and here's how
>> >> >the pipeline main control (on how to iterate the tables etc) is going
>> >> >to be" and after you instantiate/activate that pipeline, you dont go
>> >> >back 5 minutes later and say "sorry, please introduce table 15, which
>> >> >i want you to walk to after you visit table 3 if metadata foo is 5" or
>> >> >"shoot, let's change that table 5 to be exact instead of LPM". It's
>> >> >not anywhere in the spec.
>> >> >That doesnt mean it is not useful thing to have - but it is an
>> >> >invention that has _nothing to do with the P4 spec_; so saying a P4
>> >> >implementation must support it is a bit out of scope and there are
>> >> >vendors with hardware who support P4 today that dont need any of this.
>> >>
>> >> I'm not talking about the spec. I'm talking about the offload
>> >> implemetation, the offload compiler the offload runtime manager. You
>> >> don't have those in kernel. That is the issue. The runtime manager is
>> >> the one to decide and reshuffle the hw internals. Again, this has
>> >> nothing to do with p4 frontend. This is offload implementation.
>> >>
>> >> And that is why I believe your p4 kernel implementation is unoffloadable.
>> >> And if it is unoffloadable, do we really need it? IDK.
>> >>
>> >
>> >Say what?
>> >It's not offloadable in your hardware, you mean? Because i have beside
>> >me here an intel e2000 which offloads just fine (and the AMD folks
>> >seem fine too).
>>
>> Will Intel and AMD have compiler in kernel, so no blob transfer and
>> parsing it in kernel wound not be needed? No.
>
>By that definition anything that parses anything is a compiler.
>
>>
>> >If your view is that all these runtime optimization surmount to a
>> >compiler in the kernel/driver that is your, well, your view. In my
>> >view (and others have said this to you already) the P4C compiler is
>> >responsible for resource optimizations. The hardware supports P4, you
>> >give it constraints and it knows what to do. At runtime, anything a
>> >driver needs to do for resource optimization (resorting, reshuffling
>> >etc), that is not a P4 problem - sorry if you have issues in your
>> >architecture approach.
>>
>> Sure, it is the offload implementation problem. And for them, you need
>> to use userspace components. And that is the problem. This discussion
>> leads nowhere, I don't know how differently I should describe this.
>
>Jiri's - that's your view based on whatever design you have in your
>mind. This has nothing to do with P4.
>So let me repeat again:
>1) A vendor's backend for P4 when it compiles ensures that resource
>constraints are taken care of.
>2) The same program can run in s/w.
>3) It makes *ZERO* sense to mix vendor specific constraint
>optimization(what you described as resorting, reshuffling etc) as part
>of P4TC or P4. Absolutely nothing to do with either. Write a

I never suggested for it to be part of P4tc of P4. I don't know why you
think so.


>background task, specific to you,  if you feel you need to move things
>around at runtime.

Yeah, that backgroud task is in userspace.


>
>We agree on one thing at least: This discussion is going nowhere.

Correct.


>
>cheers,
>jamal
>
>
>
>> >
>> >> >In my opinion that is a feature that could be added later out of
>> >> >necessity (there is some good niche value in being able to add some
>> >> >"dynamicism" to any pipeline) and influence the P4 standards on why it
>> >> >is needed.
>> >> >It should be doable today in a brute force way (this is just one
>> >> >suggestion that came to me when Rice University/Nvidia presented[1]);
>> >> >i am sure there are other approaches and the idea is by no means
>> >> >proven.
>> >> >
>> >> >1) User space Creates/compiles/Adds/activate your program that has 14
>> >> >tables at tc prio X chain Y
>> >> >2) a) 5 minutes later user space decides it wants to change and add
>> >> >table 3 after table 15, visited when metadata foo=5
>> >> >    b) your compiler in user space compiles a brand new program which
>> >> >satisfies #2a (how this program was authored is out of scope of
>> >> >discussion)
>> >> >    c) user space adds the new program at tc prio X+1 chain Y or another chain Z
>> >> >    d) user space delete tc prio X chain Y (and make sure your packets
>> >> >entry point is whatever #c is)
>> >>
>> >> I never suggested anything like what you describe. I'm not sure why you
>> >> think so.
>> >
>> >It's the same class of problems - the paper i pointed to (coauthored
>> >by Matty and others) has runtime resource optimizations which are
>> >tantamount to changing the nature of the pipeline. We may need to
>> >profile in the kernel but all those optimizations can be derived in
>> >user space using the approach I described.
>> >
>> >cheers,
>> >jamal
>> >
>> >
>> >> >[1] https://www.cs.rice.edu/~eugeneng/papers/SIGCOMM23-Pipeleon.pdf
>> >> >
>> >> >>
>> >> >> >kernel process - which is ironically the same thing we are going
>> >> >> >through here ;->
>> >> >> >
>> >> >> >cheers,
>> >> >> >jamal
>> >> >> >
>> >> >> >>
>> >> >> >> >
>> >> >> >> >cheers,
>> >> >> >> >jamal


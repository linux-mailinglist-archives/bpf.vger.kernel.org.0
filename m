Return-Path: <bpf+bounces-15668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A07F4A04
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C97F28137F
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381BD4E63D;
	Wed, 22 Nov 2023 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TWIcnIW4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E33A3
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:14:15 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5c85e8fdd2dso54872667b3.2
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700666054; x=1701270854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9mLPXNJgRRXhsM90i4n/8aZieCG+Qt5G+my962NFvQ=;
        b=TWIcnIW4b3P5/bbdcOZf1eKDJh8hhRLyET6UInCcpcRgG8D13s9j2/R1CB1nvnIZTp
         NlfjjZ7KS5Rfk6yTQepJ21XDQ52sCJtalcpK4LeC0b6a3vOChJYWWJ2kHgAgrJ6u3F4K
         F6ZSJWaO3rsKpRzJ85mgrmxsI+caJEYR/2SGyDsOKrKPKAvpMIgSu/PjMuzWp7FedP/W
         ViFqQqgo9FSodEwIyleHV2YFQ04ZpNOoxOzfNozWLI7kqNaF8OubBDQ7y5dId3DLMVEO
         lvz/KE4+DtzWUky+2GcWQNXFLDdItfhIoA7+IS73fFC4z+2pO2S4IQDHW7Kdl6ulq2vC
         MU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666054; x=1701270854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9mLPXNJgRRXhsM90i4n/8aZieCG+Qt5G+my962NFvQ=;
        b=tQ4D6Z6dl2zYC0YtqYeaGlPthy61RkpZF2ZPtMEmYWolJxGLWdbDFckH0YOtwRv1Gw
         3UcsaIJ5yZS89tzM7neMnME4BDuILPxyRDNxXksKR6tDcHvsoyyB0u7Kk6s5JamLvlyb
         zr+8/f//IJKtTVfAaDrjrCt6K5rWsOJzD5xGCjVXoOu7G5k+DyTWHSc44ff4GQSbjQjm
         SOfCQpqTZitW6s8twUX4KgmaBqqR5argbm7fEc2e9GTVwUMW8hTqf3jHCME9tIyUchuk
         xkG0VWg3OLcWjZfIV9GX6sx/5JGMA4J5fMScSTmlZjy1JUj0r8csXtHLr2nOQntNQJK8
         23iw==
X-Gm-Message-State: AOJu0YwvjvFU5xwcOzVrh4j2VWqs0dEveh6djVqoLuwCcnfFSMKT6Ldy
	MmS6CN0BVB2j/UwoOPOrXq3cssDeFotMoSL8f6pPCw==
X-Google-Smtp-Source: AGHT+IH68DfSAZk32YNoKAhm18eH1345t/THpHXN2l1zBuOuEB7btZJ+nJW7i/dEsLVtEANTxZop+Dt1yNQDULqS0Tw=
X-Received: by 2002:a81:8945:0:b0:5a8:960d:e538 with SMTP id
 z66-20020a818945000000b005a8960de538mr2585689ywf.47.1700666054279; Wed, 22
 Nov 2023 07:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVspOBmzrwm8isiD@nanopsycho> <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho> <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net> <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
 <ZVyrRFDrVqluD9k/@nanopsycho> <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
 <ZVy8cEjs9VK2OVxE@nanopsycho> <CAM0EoMmPnCeU2uLph=uwh3JxtE4RQnvcSA2WdZgORywzNFCO6g@mail.gmail.com>
 <ZV3JJQirPdZpbVIC@nanopsycho>
In-Reply-To: <ZV3JJQirPdZpbVIC@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 Nov 2023 10:14:02 -0500
Message-ID: <CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, 
	dan.daly@intel.com, chris.sommers@keysight.com, john.andy.fingerhut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Nov 21, 2023 at 04:21:44PM CET, jhs@mojatatu.com wrote:
> >On Tue, Nov 21, 2023 at 9:19=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com wrote:
> >> >On Tue, Nov 21, 2023 at 8:06=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
> >> >> >On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Daniel Borkmann <daniel@io=
gearbox.net> wrote:
> >> >> >>
> >> >> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> >> >> >> > On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@resnu=
lli.us> wrote:
> >> >> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
> >> >>
> >> >> [...]
> >> >>
> >> >> >
> >> >> >> tc BPF and XDP already have widely used infrastructure and can b=
e developed
> >> >> >> against libbpf or other user space libraries for a user space co=
ntrol plane.
> >> >> >> With 'control plane' you refer here to the tc / netlink shim you=
've built,
> >> >> >> but looking at the tc command line examples, this doesn't really=
 provide a
> >> >> >> good user experience (you call it p4 but people load bpf obj fil=
es). If the
> >> >> >> expectation is that an operator should run tc commands, then nei=
ther it's
> >> >> >> a nice experience for p4 nor for BPF folks. From a BPF PoV, we m=
oved over
> >> >> >> to bpf_mprog and plan to also extend this for XDP to have a comm=
on look and
> >> >> >> feel wrt networking for developers. Why can't this be reused?
> >> >> >
> >> >> >The filter loading which loads the program is considered pipeline
> >> >> >instantiation - consider it as "provisioning" more than "control"
> >> >> >which runs at runtime. "control" is purely netlink based. The ipro=
ute2
> >> >> >code we use links libbpf for example for the filter. If we can ach=
ieve
> >> >> >the same with bpf_mprog then sure - we just dont want to loose
> >> >> >functionality though.  off top of my head, some sample space:
> >> >> >- we could have multiple pipelines with different priorities (whic=
h tc
> >> >> >provides to us) - and each pipeline may have its own logic with ma=
ny
> >> >> >tables etc (and the choice to iterate the next one is essentially
> >> >> >encoded in the tc action codes)
> >> >> >- we use tc block to map groups of ports (which i dont think bpf h=
as
> >> >> >internal access of)
> >> >> >
> >> >> >In regards to usability: no i dont expect someone doing things at
> >> >> >scale to use command line tc. The APIs are via netlink. But the tc=
 cli
> >> >> >is must for the rest of the masses per our traditions. Also i real=
ly
> >> >>
> >> >> I don't follow. You repeatedly mention "the must of the traditional=
 tc
> >> >> cli", but what of the existing traditional cli you use for p4tc?
> >> >> If I look at the examples, pretty much everything looks new to me.
> >> >> Example:
> >> >>
> >> >>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >> >>     action send_to_port param port eno1
> >> >>
> >> >> This is just TC/RTnetlink used as a channel to pass new things over=
. If
> >> >> that is the case, what's traditional here?
> >> >>
> >> >
> >> >
> >> >What is not traditional about it?
> >>
> >> Okay, so in that case, the following example communitating with
> >> userspace deamon using imaginary "p4ctrl" app is equally traditional:
> >>   $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >>      action send_to_port param port eno1
> >
> >Huh? Thats just an application - classical tc which part of iproute2
> >that is sending to the kernel, no different than "tc flower.."
> >Where do you get the "userspace" daemon part? Yes, you can write a
> >daemon but it will use the same APIs as tc.
>
> Okay, so which part is the "tradition"?
>

Provides tooling via tc cli that _everyone_ in the tc world is
familiar with - which uses the same syntax as other tc extensions do,
same expectations (eg events, request responses, familiar commands for
dumping, flushing etc). Basically someone familiar with tc will pick
this up and operate it very quickly and would have an easier time
debugging it.
There are caveats - as will be with all new classifiers - but those
are within reason.

> >>
> >> >
> >> >>
> >> >> >didnt even want to use ebpf at all for operator experience reasons=
 -
> >> >> >it requires a compilation of the code and an extra loading compare=
d to
> >> >> >what our original u32/pedit code offered.
> >> >> >
> >> >> >> I don't quite follow why not most of this could be implemented e=
ntirely in
> >> >> >> user space without the detour of this and you would provide a de=
veloper
> >> >> >> library which could then be integrated into a p4 runtime/fronten=
d? This
> >> >> >> way users never interface with ebpf parts nor tc given they also=
 shouldn't
> >> >> >> have to - it's an implementation detail. This is what John was a=
lso pointing
> >> >> >> out earlier.
> >> >> >>
> >> >> >
> >> >> >Netlink is the API. We will provide a library for object manipulat=
ion
> >> >> >which abstracts away the need to know netlink. Someone who for the=
ir
> >> >> >own reasons wants to use p4runtime or TDI could write on top of th=
is.
> >> >> >I would not design a kernel interface to just meet p4runtime (we
> >> >> >already have TDI which came later which does things differently). =
So i
> >> >> >expect us to support both those two. And if i was to do something =
on
> >> >> >SDN that was more robust i would write my own that still uses thes=
e
> >> >> >netlink interfaces.
> >> >>
> >> >> Actually, what Daniel says about the p4 library used as a backend t=
o p4
> >> >> frontend is pretty much aligned what I claimed on the p4 calls coup=
le of
> >> >> times. If you have this p4 userspace tooling, it is easy for offloa=
ds to
> >> >> replace the backed by vendor-specific library which allows p4 offlo=
ad
> >> >> suitable for all vendors (your plan of p4tc offload does not work w=
ell
> >> >> for our hw, as we repeatedly claimed).
> >> >>
> >> >
> >> >That's you - NVIDIA. You have chosen a path away from the kernel
> >> >towards DOCA. I understand NVIDIA's frustration with dealing with
> >> >upstream process (which has been cited to me as a good reason for
> >> >DOCA) but please dont impose these values and your politics on other
> >> >vendors(Intel, AMD for example) who are more than willing to invest
> >> >into making the kernel interfaces the path forward. Your choice.
> >>
> >> No, you are missing the point. This has nothing to do with DOCA.
> >
> >Right Jiri ;->
> >
> >> This
> >> has to do with the simple limitation of your offload assuming there ar=
e
> >> no runtime changes in the compiled pipeline. For Intel, maybe they
> >> aren't, and it's a good fit for them. All I say is, that it is not the
> >> good fit for everyone.
> >
> > a) it is not part of the P4 spec to dynamically make changes to the
> >datapath pipeline after it is create and we are discussing a P4
>
> Isn't this up to the implementation? I mean from the p4 perspective,
> everything is static. Hw might need to reshuffle the pipeline internally
> during rule insertion/remove in order to optimize the layout.
>

But do note: the focus here is on P4 (hence the name P4TC).

> >implementation not an extension that would add more value b) We are
> >more than happy to add extensions in the future to accomodate for
> >features but first _P4 spec_ must be met c) we had longer discussions
> >with Matty, Khalid and the Rice folks who wrote a paper on that topic
> >which you probably didnt attend and everything that needs to be done
> >can be from user space today for all those optimizations.
> >
> >Conclusion is: For what you need to do (which i dont believe is a
> >limitation in your hardware rather a design decision on your part) run
> >your user space daemon, do optimizations and update the datapath.
> >Everybody is happy.
>
> Should the userspace daemon listen on inserted rules to be offloade
> over netlink?
>

I mean you could if you wanted to given this is just traditional
netlink which emits events (with some filtering when we integrate the
filter approach). But why?

> >
> >>
> >> >Nobody is stopping you from offering your customers proprietary
> >> >solutions which include a specific ebpf approach alongside DOCA. We
> >> >believe that a singular interface regardless of the vendor is the
> >> >right way forward. IMHO, this siloing that unfortunately is also adde=
d
> >> >by eBPF being a double edged sword is not good for the community.
> >> >
> >> >> As I also said on the p4 call couple of times, I don't see the kern=
el
> >> >> as the correct place to do the p4 abstractions. Why don't you do it=
 in
> >> >> userspace and give vendors possiblity to have p4 backends with comp=
ilers,
> >> >> runtime optimizations etc in userspace, talking to the HW in the
> >> >> vendor-suitable way too. Then the SW implementation could be easily=
 eBPF
> >> >> and the main reason (I believe) why you need to have this is TC
> >> >> (offload) is then void.
> >> >>
> >> >> The "everyone wants to use TC/netlink" claim does not seem correct
> >> >> to me. Why not to have one Linux p4 solution that fits everyones ne=
eds?
> >> >
> >> >You mean more fitting to the DOCA world? no, because iam a kernel
> >>
> >> Again, this has 0 relation to DOCA.
> >>
> >>
> >> >first person and kernel interfaces are good for everyone.
> >>
> >> Yeah, not really. Not always the kernel is the right answer. Your/Inte=
l
> >> plan to handle the offload by:
> >> 1) abuse devlink to flash p4 binary
> >> 2) parse the binary in kernel to match to the table ids of rules comin=
g
> >>    from p4tc ndo_setup_tc
> >> 3) abuse devlink to flash p4 binary for tc-flower
> >> 4) parse the binary in kernel to match to the table ids of rules comin=
g
> >>    from tc-flower ndo_setup_tc
> >> is really something that is making me a little bit nauseous.
> >>
> >> If you don't have a feasible plan to do the offload, p4tc does not mak=
e
> >> sense to me to be honest.
> >
> >You mean if there's no plan to match your (NVIDIA?)  point of view.
> >For #1 - how's this different from DDP? Wasnt that your suggestion to
>
> I doubt that. Any flashing-blob-parsing-in-kernel is something I'm
> opposed to from day 1.
>
>

Oh well - it is in the kernel and it works fine tbh.

> >begin with? For #2 Nobody is proposing to do anything of the sort. The
> >ndo is passed IDs for the objects and associated contents. For #3+#4
>
> During offload, you need to parse the blob in driver to be able to match
> the ids with blob entities. That was presented by you/Intel in the past
> IIRC.
>

You are correct - in case of offload the netlink IDs will have to be
authenticated against what the hardware can accept, but the devlink
flash use i believe was from you as a compromise.

>
> >tc flower thing has nothing to do with P4TC that was just some random
> >proposal someone made seeing if they could ride on top of P4TC.
>
> Yeah, it's not yet merged and already mentally used for abuse. I love
> that :)
>
> >
> >Besides this nobody really has to satisfy your point of view - like i
> >said earlier feel free to provide proprietary solutions. From a
> >consumer perspective  I would not want to deal with 4 different
> >vendors with 4 different proprietary approaches. The kernel is the
> >unifying part. You seemed happier with tc flower just not with the
>
> Yeah, that is my point, why the unifying part can't be a userspace
> daemon/library with multiple backends (p4tc, bpf, vendorX, vendorY, ..)?
>
> I just don't see the kernel as a good fit for abstraction here,
> given the fact that the vendor compilers does not run in kernel.
> That is breaking your model.
>

Jiri - we want to support P4, first. Like you said the P4 pipeline,
once installed is static.
P4 doesnt allow dynamic update of the pipeline. For example, once you
say "here are my 14 tables and their associated actions and here's how
the pipeline main control (on how to iterate the tables etc) is going
to be" and after you instantiate/activate that pipeline, you dont go
back 5 minutes later and say "sorry, please introduce table 15, which
i want you to walk to after you visit table 3 if metadata foo is 5" or
"shoot, let's change that table 5 to be exact instead of LPM". It's
not anywhere in the spec.
That doesnt mean it is not useful thing to have - but it is an
invention that has _nothing to do with the P4 spec_; so saying a P4
implementation must support it is a bit out of scope and there are
vendors with hardware who support P4 today that dont need any of this.
In my opinion that is a feature that could be added later out of
necessity (there is some good niche value in being able to add some
"dynamicism" to any pipeline) and influence the P4 standards on why it
is needed.
It should be doable today in a brute force way (this is just one
suggestion that came to me when Rice University/Nvidia presented[1]);
i am sure there are other approaches and the idea is by no means
proven.

1) User space Creates/compiles/Adds/activate your program that has 14
tables at tc prio X chain Y
2) a) 5 minutes later user space decides it wants to change and add
table 3 after table 15, visited when metadata foo=3D5
    b) your compiler in user space compiles a brand new program which
satisfies #2a (how this program was authored is out of scope of
discussion)
    c) user space adds the new program at tc prio X+1 chain Y or another ch=
ain Z
    d) user space delete tc prio X chain Y (and make sure your packets
entry point is whatever #c is)

cheers,
jamal

[1] https://www.cs.rice.edu/~eugeneng/papers/SIGCOMM23-Pipeleon.pdf

>
> >kernel process - which is ironically the same thing we are going
> >through here ;->
> >
> >cheers,
> >jamal
> >
> >>
> >> >
> >> >cheers,
> >> >jamal


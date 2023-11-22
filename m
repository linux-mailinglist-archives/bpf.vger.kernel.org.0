Return-Path: <bpf+bounces-15695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967607F4FEA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB3328156E
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039DC56B92;
	Wed, 22 Nov 2023 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S44STlVH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4026692;
	Wed, 22 Nov 2023 10:50:50 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5be30d543c4so53753a12.2;
        Wed, 22 Nov 2023 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700679049; x=1701283849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUZytbgEXmtod88Wd86l6GNZ7J1wmjxMNpVD6r1g5tQ=;
        b=S44STlVH7xZgkmTBZBSsi5VuuCaX/OMTO6SJWGe3BGQ85wIvqg9RMklorwQv45nrab
         h8NIqM/TTwpzQQpoVMwIfRJkdGU6iG537ub19q9AKSMD6pSWSARASbMJVQgyKPwgBX6C
         YN/9dzSq8X7mu4VPu0t1aVFRpyPo6YaJYmTRhnRF6HTHK3SFf6tTukO5ePzP5Smvdqi1
         xXIGuzTISkeJVlld/JaRUFbriJJQMgkroiZLIiDgHUPDjDnOLaOl++qn3QTeyeSFnnT8
         g2c+b7tVKNoMJGF+A4/afdKLvOfXSLFTHWG7fCgWkH9ZPjm9NaTyXJtorj1JcjV4/7OO
         3VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679049; x=1701283849;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mUZytbgEXmtod88Wd86l6GNZ7J1wmjxMNpVD6r1g5tQ=;
        b=EUHlTaMoIK+kegm97NqT4wKFKmDDLFz5CytirTWvQRvDkUzwz94jS2HrCY5/ip3RXu
         RDfYCnir9oDm7pEmJnIih1vdNC+4uM84sOYIHlBGhUvuAUJFcyfwq6p8Icvq3X+R1q44
         gu0Pjnh+QJPEsdmM3x+9RwYKCgUzZ8mMnHVMGp8jLV/W+dr+q3HSYlrKfdqGfroJOY0w
         2x5WiGX5mrPR000KjZfNLlSwKoIxgHS/BEwMUnSth0sU5yMPAhYDpaGeZfgOzNpbMa5Y
         TY8qRzaLUJlHSS5wrWatzc/EHOK06pxSybJTmiUsxTLBNq3i9Ngt0ngkMofKgoRVtTrF
         hAIg==
X-Gm-Message-State: AOJu0YxkiU+saLglA08HGNwW7EXLhDXCLZh1o9XKtoLAnMvnHqkmCzGD
	SY1GnNk4I9dwQNy3IZoRl+o=
X-Google-Smtp-Source: AGHT+IE3XIVf6JZQodwH+CSJyQRQPBaSblY7u0WKDF1nc5uGjB8zKVQgQAAMrQ+jGXzZRkFObkXE9A==
X-Received: by 2002:a17:90a:1d9:b0:27d:24d6:7343 with SMTP id 25-20020a17090a01d900b0027d24d67343mr3285178pjd.19.1700679049386;
        Wed, 22 Nov 2023 10:50:49 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id 60-20020a17090a09c200b002852528f62bsm89638pjo.29.2023.11.22.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:50:48 -0800 (PST)
Date: Wed, 22 Nov 2023 10:50:47 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 netdev@vger.kernel.org, 
 deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 Vipin.Jain@amd.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 mattyk@nvidia.com, 
 dan.daly@intel.com, 
 chris.sommers@keysight.com, 
 john.andy.fingerhut@intel.com
Message-ID: <655e4d8760470_504d32084c@john.notmuch>
In-Reply-To: <ZV5I/F+b5fu58Rlg@nanopsycho>
References: <ZVuhBlYRwi8eGiSF@nanopsycho>
 <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
 <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
 <ZVyrRFDrVqluD9k/@nanopsycho>
 <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
 <ZVy8cEjs9VK2OVxE@nanopsycho>
 <CAM0EoMmPnCeU2uLph=uwh3JxtE4RQnvcSA2WdZgORywzNFCO6g@mail.gmail.com>
 <ZV3JJQirPdZpbVIC@nanopsycho>
 <CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
 <ZV5I/F+b5fu58Rlg@nanopsycho>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Pirko wrote:
> Wed, Nov 22, 2023 at 04:14:02PM CET, jhs@mojatatu.com wrote:
> >On Wed, Nov 22, 2023 at 4:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >>
> >> Tue, Nov 21, 2023 at 04:21:44PM CET, jhs@mojatatu.com wrote:
> >> >On Tue, Nov 21, 2023 at 9:19=E2=80=AFAM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> >> >>
> >> >> Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com wrote:
> >> >> >On Tue, Nov 21, 2023 at 8:06=E2=80=AFAM Jiri Pirko <jiri@resnull=
i.us> wrote:
> >> >> >>
> >> >> >> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
> >> >> >> >On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Daniel Borkmann <dani=
el@iogearbox.net> wrote:
> >> >> >> >>
> >> >> >> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> >> >> >> >> > On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@=
resnulli.us> wrote:
> >> >> >> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wr=
ote:
> >> >> >>
> >> >> >> [...]
> >> >> >>
> >> >> >> >
> >> >> >> >> tc BPF and XDP already have widely used infrastructure and =
can be developed
> >> >> >> >> against libbpf or other user space libraries for a user spa=
ce control plane.
> >> >> >> >> With 'control plane' you refer here to the tc / netlink shi=
m you've built,
> >> >> >> >> but looking at the tc command line examples, this doesn't r=
eally provide a
> >> >> >> >> good user experience (you call it p4 but people load bpf ob=
j files). If the
> >> >> >> >> expectation is that an operator should run tc commands, the=
n neither it's
> >> >> >> >> a nice experience for p4 nor for BPF folks. From a BPF PoV,=
 we moved over
> >> >> >> >> to bpf_mprog and plan to also extend this for XDP to have a=
 common look and
> >> >> >> >> feel wrt networking for developers. Why can't this be reuse=
d?
> >> >> >> >
> >> >> >> >The filter loading which loads the program is considered pipe=
line
> >> >> >> >instantiation - consider it as "provisioning" more than "cont=
rol"
> >> >> >> >which runs at runtime. "control" is purely netlink based. The=
 iproute2
> >> >> >> >code we use links libbpf for example for the filter. If we ca=
n achieve
> >> >> >> >the same with bpf_mprog then sure - we just dont want to loos=
e
> >> >> >> >functionality though.  off top of my head, some sample space:=

> >> >> >> >- we could have multiple pipelines with different priorities =
(which tc
> >> >> >> >provides to us) - and each pipeline may have its own logic wi=
th many
> >> >> >> >tables etc (and the choice to iterate the next one is essenti=
ally
> >> >> >> >encoded in the tc action codes)
> >> >> >> >- we use tc block to map groups of ports (which i dont think =
bpf has
> >> >> >> >internal access of)
> >> >> >> >
> >> >> >> >In regards to usability: no i dont expect someone doing thing=
s at
> >> >> >> >scale to use command line tc. The APIs are via netlink. But t=
he tc cli
> >> >> >> >is must for the rest of the masses per our traditions. Also i=
 really
> >> >> >>
> >> >> >> I don't follow. You repeatedly mention "the must of the tradit=
ional tc
> >> >> >> cli", but what of the existing traditional cli you use for p4t=
c?
> >> >> >> If I look at the examples, pretty much everything looks new to=
 me.
> >> >> >> Example:
> >> >> >>
> >> >> >>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >> >> >>     action send_to_port param port eno1
> >> >> >>
> >> >> >> This is just TC/RTnetlink used as a channel to pass new things=
 over. If
> >> >> >> that is the case, what's traditional here?
> >> >> >>
> >> >> >
> >> >> >
> >> >> >What is not traditional about it?
> >> >>
> >> >> Okay, so in that case, the following example communitating with
> >> >> userspace deamon using imaginary "p4ctrl" app is equally traditio=
nal:
> >> >>   $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >> >>      action send_to_port param port eno1
> >> >
> >> >Huh? Thats just an application - classical tc which part of iproute=
2
> >> >that is sending to the kernel, no different than "tc flower.."
> >> >Where do you get the "userspace" daemon part? Yes, you can write a
> >> >daemon but it will use the same APIs as tc.
> >>
> >> Okay, so which part is the "tradition"?
> >>
> >
> >Provides tooling via tc cli that _everyone_ in the tc world is
> >familiar with - which uses the same syntax as other tc extensions do,
> >same expectations (eg events, request responses, familiar commands for=

> >dumping, flushing etc). Basically someone familiar with tc will pick
> >this up and operate it very quickly and would have an easier time
> >debugging it.
> >There are caveats - as will be with all new classifiers - but those
> >are within reason.
> =

> Okay, so syntax familiarity wise, what's the difference between
> following 2 approaches:
> $ tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>       action send_to_port param port eno1
> $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>       action send_to_port param port eno1
> ?
> =

> =

> >
> >> >>
> >> >> >
> >> >> >>
> >> >> >> >didnt even want to use ebpf at all for operator experience re=
asons -
> >> >> >> >it requires a compilation of the code and an extra loading co=
mpared to
> >> >> >> >what our original u32/pedit code offered.
> >> >> >> >
> >> >> >> >> I don't quite follow why not most of this could be implemen=
ted entirely in
> >> >> >> >> user space without the detour of this and you would provide=
 a developer
> >> >> >> >> library which could then be integrated into a p4 runtime/fr=
ontend? This
> >> >> >> >> way users never interface with ebpf parts nor tc given they=
 also shouldn't
> >> >> >> >> have to - it's an implementation detail. This is what John =
was also pointing
> >> >> >> >> out earlier.
> >> >> >> >>
> >> >> >> >
> >> >> >> >Netlink is the API. We will provide a library for object mani=
pulation
> >> >> >> >which abstracts away the need to know netlink. Someone who fo=
r their
> >> >> >> >own reasons wants to use p4runtime or TDI could write on top =
of this.
> >> >> >> >I would not design a kernel interface to just meet p4runtime =
(we
> >> >> >> >already have TDI which came later which does things different=
ly). So i
> >> >> >> >expect us to support both those two. And if i was to do somet=
hing on
> >> >> >> >SDN that was more robust i would write my own that still uses=
 these
> >> >> >> >netlink interfaces.
> >> >> >>
> >> >> >> Actually, what Daniel says about the p4 library used as a back=
end to p4
> >> >> >> frontend is pretty much aligned what I claimed on the p4 calls=
 couple of
> >> >> >> times. If you have this p4 userspace tooling, it is easy for o=
ffloads to
> >> >> >> replace the backed by vendor-specific library which allows p4 =
offload
> >> >> >> suitable for all vendors (your plan of p4tc offload does not w=
ork well
> >> >> >> for our hw, as we repeatedly claimed).
> >> >> >>
> >> >> >
> >> >> >That's you - NVIDIA. You have chosen a path away from the kernel=

> >> >> >towards DOCA. I understand NVIDIA's frustration with dealing wit=
h
> >> >> >upstream process (which has been cited to me as a good reason fo=
r
> >> >> >DOCA) but please dont impose these values and your politics on o=
ther
> >> >> >vendors(Intel, AMD for example) who are more than willing to inv=
est
> >> >> >into making the kernel interfaces the path forward. Your choice.=

> >> >>
> >> >> No, you are missing the point. This has nothing to do with DOCA.
> >> >
> >> >Right Jiri ;->
> >> >
> >> >> This
> >> >> has to do with the simple limitation of your offload assuming the=
re are
> >> >> no runtime changes in the compiled pipeline. For Intel, maybe the=
y
> >> >> aren't, and it's a good fit for them. All I say is, that it is no=
t the
> >> >> good fit for everyone.
> >> >
> >> > a) it is not part of the P4 spec to dynamically make changes to th=
e
> >> >datapath pipeline after it is create and we are discussing a P4
> >>
> >> Isn't this up to the implementation? I mean from the p4 perspective,=

> >> everything is static. Hw might need to reshuffle the pipeline intern=
ally
> >> during rule insertion/remove in order to optimize the layout.
> >>
> >
> >But do note: the focus here is on P4 (hence the name P4TC).
> >
> >> >implementation not an extension that would add more value b) We are=

> >> >more than happy to add extensions in the future to accomodate for
> >> >features but first _P4 spec_ must be met c) we had longer discussio=
ns
> >> >with Matty, Khalid and the Rice folks who wrote a paper on that top=
ic
> >> >which you probably didnt attend and everything that needs to be don=
e
> >> >can be from user space today for all those optimizations.
> >> >
> >> >Conclusion is: For what you need to do (which i dont believe is a
> >> >limitation in your hardware rather a design decision on your part) =
run
> >> >your user space daemon, do optimizations and update the datapath.
> >> >Everybody is happy.
> >>
> >> Should the userspace daemon listen on inserted rules to be offloade
> >> over netlink?
> >>
> >
> >I mean you could if you wanted to given this is just traditional
> >netlink which emits events (with some filtering when we integrate the
> >filter approach). But why?
> =

> Nevermind.
> =

> =

> >
> >> >
> >> >>
> >> >> >Nobody is stopping you from offering your customers proprietary
> >> >> >solutions which include a specific ebpf approach alongside DOCA.=
 We
> >> >> >believe that a singular interface regardless of the vendor is th=
e
> >> >> >right way forward. IMHO, this siloing that unfortunately is also=
 added
> >> >> >by eBPF being a double edged sword is not good for the community=
.
> >> >> >
> >> >> >> As I also said on the p4 call couple of times, I don't see the=
 kernel
> >> >> >> as the correct place to do the p4 abstractions. Why don't you =
do it in
> >> >> >> userspace and give vendors possiblity to have p4 backends with=
 compilers,
> >> >> >> runtime optimizations etc in userspace, talking to the HW in t=
he
> >> >> >> vendor-suitable way too. Then the SW implementation could be e=
asily eBPF
> >> >> >> and the main reason (I believe) why you need to have this is T=
C
> >> >> >> (offload) is then void.
> >> >> >>
> >> >> >> The "everyone wants to use TC/netlink" claim does not seem cor=
rect
> >> >> >> to me. Why not to have one Linux p4 solution that fits everyon=
es needs?
> >> >> >
> >> >> >You mean more fitting to the DOCA world? no, because iam a kerne=
l
> >> >>
> >> >> Again, this has 0 relation to DOCA.
> >> >>
> >> >>
> >> >> >first person and kernel interfaces are good for everyone.
> >> >>
> >> >> Yeah, not really. Not always the kernel is the right answer. Your=
/Intel
> >> >> plan to handle the offload by:
> >> >> 1) abuse devlink to flash p4 binary
> >> >> 2) parse the binary in kernel to match to the table ids of rules =
coming
> >> >>    from p4tc ndo_setup_tc
> >> >> 3) abuse devlink to flash p4 binary for tc-flower
> >> >> 4) parse the binary in kernel to match to the table ids of rules =
coming
> >> >>    from tc-flower ndo_setup_tc
> >> >> is really something that is making me a little bit nauseous.
> >> >>
> >> >> If you don't have a feasible plan to do the offload, p4tc does no=
t make
> >> >> sense to me to be honest.
> >> >
> >> >You mean if there's no plan to match your (NVIDIA?)  point of view.=

> >> >For #1 - how's this different from DDP? Wasnt that your suggestion =
to
> >>
> >> I doubt that. Any flashing-blob-parsing-in-kernel is something I'm
> >> opposed to from day 1.
> >>
> >>
> >
> >Oh well - it is in the kernel and it works fine tbh.
> >
> >> >begin with? For #2 Nobody is proposing to do anything of the sort. =
The
> >> >ndo is passed IDs for the objects and associated contents. For #3+#=
4
> >>
> >> During offload, you need to parse the blob in driver to be able to m=
atch
> >> the ids with blob entities. That was presented by you/Intel in the p=
ast
> >> IIRC.
> >>
> >
> >You are correct - in case of offload the netlink IDs will have to be
> >authenticated against what the hardware can accept, but the devlink
> >flash use i believe was from you as a compromise.
> =

> Definitelly not. I'm against devlink abuse for this from day 1.
> =

> =

> >
> >>
> >> >tc flower thing has nothing to do with P4TC that was just some rand=
om
> >> >proposal someone made seeing if they could ride on top of P4TC.
> >>
> >> Yeah, it's not yet merged and already mentally used for abuse. I lov=
e
> >> that :)
> >>
> >> >
> >> >Besides this nobody really has to satisfy your point of view - like=
 i
> >> >said earlier feel free to provide proprietary solutions. From a
> >> >consumer perspective  I would not want to deal with 4 different
> >> >vendors with 4 different proprietary approaches. The kernel is the
> >> >unifying part. You seemed happier with tc flower just not with the
> >>
> >> Yeah, that is my point, why the unifying part can't be a userspace
> >> daemon/library with multiple backends (p4tc, bpf, vendorX, vendorY, =
..)?
> >>
> >> I just don't see the kernel as a good fit for abstraction here,
> >> given the fact that the vendor compilers does not run in kernel.
> >> That is breaking your model.
> >>
> >
> >Jiri - we want to support P4, first. Like you said the P4 pipeline,
> >once installed is static.
> >P4 doesnt allow dynamic update of the pipeline. For example, once you
> >say "here are my 14 tables and their associated actions and here's how=

> >the pipeline main control (on how to iterate the tables etc) is going
> >to be" and after you instantiate/activate that pipeline, you dont go
> >back 5 minutes later and say "sorry, please introduce table 15, which
> >i want you to walk to after you visit table 3 if metadata foo is 5" or=

> >"shoot, let's change that table 5 to be exact instead of LPM". It's
> >not anywhere in the spec.
> >That doesnt mean it is not useful thing to have - but it is an
> >invention that has _nothing to do with the P4 spec_; so saying a P4
> >implementation must support it is a bit out of scope and there are
> >vendors with hardware who support P4 today that dont need any of this.=

> =

> I'm not talking about the spec. I'm talking about the offload
> implemetation, the offload compiler the offload runtime manager. You
> don't have those in kernel. That is the issue. The runtime manager is
> the one to decide and reshuffle the hw internals. Again, this has
> nothing to do with p4 frontend. This is offload implementation.
> =

> And that is why I believe your p4 kernel implementation is unoffloadabl=
e.
> And if it is unoffloadable, do we really need it? IDK.

And my point is we already have a way to do software P4 implementation
in BPF so I don't see the need for yet another mechanism. And if
P4tc is not amenable to hardware offload then when we need a P4
hardware offload then what? We write another P4TC-HW?

My opinion if we push a DSL into the kernel (which I also sort of
think is not a great idea) then it should at least support offloads
from the start. I know P4 can be used for software, but really its
main value is hardware offlaod here. Even the name PNA, Portable NIC
Architecture, implies its about NICs. If it was software focused
portability wouldn't matter a general purpose CPU can emulate
almost any architecture you would like.

> =

> =

> >In my opinion that is a feature that could be added later out of
> >necessity (there is some good niche value in being able to add some
> >"dynamicism" to any pipeline) and influence the P4 standards on why it=

> >is needed.
> >It should be doable today in a brute force way (this is just one
> >suggestion that came to me when Rice University/Nvidia presented[1]);
> >i am sure there are other approaches and the idea is by no means
> >proven.
> >
> >1) User space Creates/compiles/Adds/activate your program that has 14
> >tables at tc prio X chain Y
> >2) a) 5 minutes later user space decides it wants to change and add
> >table 3 after table 15, visited when metadata foo=3D5
> >    b) your compiler in user space compiles a brand new program which
> >satisfies #2a (how this program was authored is out of scope of
> >discussion)
> >    c) user space adds the new program at tc prio X+1 chain Y or anoth=
er chain Z
> >    d) user space delete tc prio X chain Y (and make sure your packets=

> >entry point is whatever #c is)
> =

> I never suggested anything like what you describe. I'm not sure why you=

> think so.
> =

> =

> >
> >cheers,
> >jamal
> >
> >[1] https://www.cs.rice.edu/~eugeneng/papers/SIGCOMM23-Pipeleon.pdf
> >
> >>
> >> >kernel process - which is ironically the same thing we are going
> >> >through here ;->
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >>
> >> >> >
> >> >> >cheers,
> >> >> >jamal




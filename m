Return-Path: <bpf+bounces-15762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0067A7F63F5
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B17C1F20F03
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C03FB28;
	Thu, 23 Nov 2023 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3CXkpbGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A310C9
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 08:31:11 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cc642e4c69so10273107b3.0
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700757070; x=1701361870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLatdOc/sshvgvm0jcH2v+VMmVo5ZQ6EyS51x/UZrQg=;
        b=3CXkpbGJMNJLG0xGT/PqPp5h+JaSozE122w7lQSu80m45WKmRe/z7BlDb+Kl4trrfL
         yc+XxxEciqf1YlDuQ6ScEgNo/MeosLIYQvejuzalbxehRUTmDLrIde0zGd5gzC2nHIMQ
         dT12kdkiozt1WktxaCBLtv6WK9v6WHkahG0uIQI6NayZv1qsie1dJru2UBAQiyoM02Zn
         VVWdHPgoqDLt7sxf5sOPHYRx4HiqJWh+p61yrondcZybowfh7fTNvl8PWx2TwybBAnKn
         PP8ujNoWzgfO/22v14xjWG91q21AkrWZpHi+n3qycSM8lxrzbN14UaCS3SxjfOgWx7ty
         LvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757070; x=1701361870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLatdOc/sshvgvm0jcH2v+VMmVo5ZQ6EyS51x/UZrQg=;
        b=EyI1s9K2jWWQMstkqZzcLcy0hA/ACYHWnyw95SJaQUCMadt+hvB12xW75qPq/icTb7
         9AOpqtXVInHlyat+VUwK7xgxrKLkpGPfxhr3HB8IqwadcJmyCYM+7Z14IwZd9EJsU/HJ
         Z33c4dl9WhNPnWruiKL7WCGCDvPRXOtGQTSLuIID3zCfy2TFdSF7s4c2rifwCWsufO51
         9u2I7b0c/0gkyHAFUA/91Uy49ZZC408walFoWjYy3wQPQrcyWUKbjU6RfT4nbeY2EN+h
         t8o7hPaD1ZGtAJzYg/SKuEDyVzYgyeVxJlG5fc9pfGsfcS++pwZ+EJ1smmb3GMCjHqbH
         2VLg==
X-Gm-Message-State: AOJu0Yyh3+h4bGkCuBf40sKrhZj5TDQsUffAy5McHIB1u90URvNbZ7tg
	dYnL2FEBfSylzTOzkv//iF2/6ZjZk6oqRc/ufgsV2g==
X-Google-Smtp-Source: AGHT+IHtkKd3DaUGTV+4mcoARdnCRBhV0uf/69XKROv3s5sG+1QOnRrWKnpjdN6qbHQH/tNnVsVjmRjAyQwLj1FnQ6I=
X-Received: by 2002:a0d:e206:0:b0:5ca:275:a94d with SMTP id
 l6-20020a0de206000000b005ca0275a94dmr5912093ywe.12.1700757070503; Thu, 23 Nov
 2023 08:31:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV3JJQirPdZpbVIC@nanopsycho> <CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
 <ZV5I/F+b5fu58Rlg@nanopsycho> <CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
 <ZV7y9JG0d4id8GeG@nanopsycho> <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
 <ZV9U+zsMM5YqL8Cx@nanopsycho> <CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
 <ZV9csgFAurzm+j3/@nanopsycho> <CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
 <ZV9vfYy42G0Fk6m4@nanopsycho>
In-Reply-To: <ZV9vfYy42G0Fk6m4@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 23 Nov 2023 11:30:58 -0500
Message-ID: <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
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

On Thu, Nov 23, 2023 at 10:28=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Nov 23, 2023 at 03:28:07PM CET, jhs@mojatatu.com wrote:
> >On Thu, Nov 23, 2023 at 9:07=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Thu, Nov 23, 2023 at 02:45:50PM CET, jhs@mojatatu.com wrote:
> >> >On Thu, Nov 23, 2023 at 8:34=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Thu, Nov 23, 2023 at 02:22:11PM CET, jhs@mojatatu.com wrote:
> >> >> >On Thu, Nov 23, 2023 at 1:36=E2=80=AFAM Jiri Pirko <jiri@resnulli.=
us> wrote:
> >> >> >>
> >> >> >> Wed, Nov 22, 2023 at 08:35:21PM CET, jhs@mojatatu.com wrote:
> >> >> >> >On Wed, Nov 22, 2023 at 1:31=E2=80=AFPM Jiri Pirko <jiri@resnul=
li.us> wrote:
> >> >> >> >>
> >> >> >> >> Wed, Nov 22, 2023 at 04:14:02PM CET, jhs@mojatatu.com wrote:
> >> >> >> >> >On Wed, Nov 22, 2023 at 4:25=E2=80=AFAM Jiri Pirko <jiri@res=
nulli.us> wrote:
> >> >> >> >> >>
> >> >> >> >> >> Tue, Nov 21, 2023 at 04:21:44PM CET, jhs@mojatatu.com wrot=
e:
> >> >> >> >> >> >On Tue, Nov 21, 2023 at 9:19=E2=80=AFAM Jiri Pirko <jiri@=
resnulli.us> wrote:
> >> >> >> >> >> >>
> >> >> >> >> >> >> Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com w=
rote:
> >> >> >> >> >> >> >On Tue, Nov 21, 2023 at 8:06=E2=80=AFAM Jiri Pirko <ji=
ri@resnulli.us> wrote:
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.co=
m wrote:
> >> >> >> >> >> >> >> >On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Daniel Bork=
mann <daniel@iogearbox.net> wrote:
> >> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> >> >> >> >> >> >> >> >> > On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pi=
rko <jiri@resnulli.us> wrote:
> >> >> >> >> >> >> >> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojat=
atu.com wrote:
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> [...]
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> >> tc BPF and XDP already have widely used infrastru=
cture and can be developed
> >> >> >> >> >> >> >> >> against libbpf or other user space libraries for =
a user space control plane.
> >> >> >> >> >> >> >> >> With 'control plane' you refer here to the tc / n=
etlink shim you've built,
> >> >> >> >> >> >> >> >> but looking at the tc command line examples, this=
 doesn't really provide a
> >> >> >> >> >> >> >> >> good user experience (you call it p4 but people l=
oad bpf obj files). If the
> >> >> >> >> >> >> >> >> expectation is that an operator should run tc com=
mands, then neither it's
> >> >> >> >> >> >> >> >> a nice experience for p4 nor for BPF folks. From =
a BPF PoV, we moved over
> >> >> >> >> >> >> >> >> to bpf_mprog and plan to also extend this for XDP=
 to have a common look and
> >> >> >> >> >> >> >> >> feel wrt networking for developers. Why can't thi=
s be reused?
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> >The filter loading which loads the program is consi=
dered pipeline
> >> >> >> >> >> >> >> >instantiation - consider it as "provisioning" more =
than "control"
> >> >> >> >> >> >> >> >which runs at runtime. "control" is purely netlink =
based. The iproute2
> >> >> >> >> >> >> >> >code we use links libbpf for example for the filter=
. If we can achieve
> >> >> >> >> >> >> >> >the same with bpf_mprog then sure - we just dont wa=
nt to loose
> >> >> >> >> >> >> >> >functionality though.  off top of my head, some sam=
ple space:
> >> >> >> >> >> >> >> >- we could have multiple pipelines with different p=
riorities (which tc
> >> >> >> >> >> >> >> >provides to us) - and each pipeline may have its ow=
n logic with many
> >> >> >> >> >> >> >> >tables etc (and the choice to iterate the next one =
is essentially
> >> >> >> >> >> >> >> >encoded in the tc action codes)
> >> >> >> >> >> >> >> >- we use tc block to map groups of ports (which i d=
ont think bpf has
> >> >> >> >> >> >> >> >internal access of)
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> >In regards to usability: no i dont expect someone d=
oing things at
> >> >> >> >> >> >> >> >scale to use command line tc. The APIs are via netl=
ink. But the tc cli
> >> >> >> >> >> >> >> >is must for the rest of the masses per our traditio=
ns. Also i really
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> I don't follow. You repeatedly mention "the must of =
the traditional tc
> >> >> >> >> >> >> >> cli", but what of the existing traditional cli you u=
se for p4tc?
> >> >> >> >> >> >> >> If I look at the examples, pretty much everything lo=
oks new to me.
> >> >> >> >> >> >> >> Example:
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >>   tc p4ctrl create myprog/table/mytable dstAddr 10.0=
.1.2/32 \
> >> >> >> >> >> >> >>     action send_to_port param port eno1
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> This is just TC/RTnetlink used as a channel to pass =
new things over. If
> >> >> >> >> >> >> >> that is the case, what's traditional here?
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >What is not traditional about it?
> >> >> >> >> >> >>
> >> >> >> >> >> >> Okay, so in that case, the following example communitat=
ing with
> >> >> >> >> >> >> userspace deamon using imaginary "p4ctrl" app is equall=
y traditional:
> >> >> >> >> >> >>   $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2=
/32 \
> >> >> >> >> >> >>      action send_to_port param port eno1
> >> >> >> >> >> >
> >> >> >> >> >> >Huh? Thats just an application - classical tc which part =
of iproute2
> >> >> >> >> >> >that is sending to the kernel, no different than "tc flow=
er.."
> >> >> >> >> >> >Where do you get the "userspace" daemon part? Yes, you ca=
n write a
> >> >> >> >> >> >daemon but it will use the same APIs as tc.
> >> >> >> >> >>
> >> >> >> >> >> Okay, so which part is the "tradition"?
> >> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >Provides tooling via tc cli that _everyone_ in the tc world =
is
> >> >> >> >> >familiar with - which uses the same syntax as other tc exten=
sions do,
> >> >> >> >> >same expectations (eg events, request responses, familiar co=
mmands for
> >> >> >> >> >dumping, flushing etc). Basically someone familiar with tc w=
ill pick
> >> >> >> >> >this up and operate it very quickly and would have an easier=
 time
> >> >> >> >> >debugging it.
> >> >> >> >> >There are caveats - as will be with all new classifiers - bu=
t those
> >> >> >> >> >are within reason.
> >> >> >> >>
> >> >> >> >> Okay, so syntax familiarity wise, what's the difference betwe=
en
> >> >> >> >> following 2 approaches:
> >> >> >> >> $ tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >> >> >> >>       action send_to_port param port eno1
> >> >> >> >> $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >> >> >> >>       action send_to_port param port eno1
> >> >> >> >> ?
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >> >>
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> >didnt even want to use ebpf at all for operator exp=
erience reasons -
> >> >> >> >> >> >> >> >it requires a compilation of the code and an extra =
loading compared to
> >> >> >> >> >> >> >> >what our original u32/pedit code offered.
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> >> I don't quite follow why not most of this could b=
e implemented entirely in
> >> >> >> >> >> >> >> >> user space without the detour of this and you wou=
ld provide a developer
> >> >> >> >> >> >> >> >> library which could then be integrated into a p4 =
runtime/frontend? This
> >> >> >> >> >> >> >> >> way users never interface with ebpf parts nor tc =
given they also shouldn't
> >> >> >> >> >> >> >> >> have to - it's an implementation detail. This is =
what John was also pointing
> >> >> >> >> >> >> >> >> out earlier.
> >> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> >Netlink is the API. We will provide a library for o=
bject manipulation
> >> >> >> >> >> >> >> >which abstracts away the need to know netlink. Some=
one who for their
> >> >> >> >> >> >> >> >own reasons wants to use p4runtime or TDI could wri=
te on top of this.
> >> >> >> >> >> >> >> >I would not design a kernel interface to just meet =
p4runtime (we
> >> >> >> >> >> >> >> >already have TDI which came later which does things=
 differently). So i
> >> >> >> >> >> >> >> >expect us to support both those two. And if i was t=
o do something on
> >> >> >> >> >> >> >> >SDN that was more robust i would write my own that =
still uses these
> >> >> >> >> >> >> >> >netlink interfaces.
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> Actually, what Daniel says about the p4 library used=
 as a backend to p4
> >> >> >> >> >> >> >> frontend is pretty much aligned what I claimed on th=
e p4 calls couple of
> >> >> >> >> >> >> >> times. If you have this p4 userspace tooling, it is =
easy for offloads to
> >> >> >> >> >> >> >> replace the backed by vendor-specific library which =
allows p4 offload
> >> >> >> >> >> >> >> suitable for all vendors (your plan of p4tc offload =
does not work well
> >> >> >> >> >> >> >> for our hw, as we repeatedly claimed).
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >That's you - NVIDIA. You have chosen a path away from =
the kernel
> >> >> >> >> >> >> >towards DOCA. I understand NVIDIA's frustration with d=
ealing with
> >> >> >> >> >> >> >upstream process (which has been cited to me as a good=
 reason for
> >> >> >> >> >> >> >DOCA) but please dont impose these values and your pol=
itics on other
> >> >> >> >> >> >> >vendors(Intel, AMD for example) who are more than will=
ing to invest
> >> >> >> >> >> >> >into making the kernel interfaces the path forward. Yo=
ur choice.
> >> >> >> >> >> >>
> >> >> >> >> >> >> No, you are missing the point. This has nothing to do w=
ith DOCA.
> >> >> >> >> >> >
> >> >> >> >> >> >Right Jiri ;->
> >> >> >> >> >> >
> >> >> >> >> >> >> This
> >> >> >> >> >> >> has to do with the simple limitation of your offload as=
suming there are
> >> >> >> >> >> >> no runtime changes in the compiled pipeline. For Intel,=
 maybe they
> >> >> >> >> >> >> aren't, and it's a good fit for them. All I say is, tha=
t it is not the
> >> >> >> >> >> >> good fit for everyone.
> >> >> >> >> >> >
> >> >> >> >> >> > a) it is not part of the P4 spec to dynamically make cha=
nges to the
> >> >> >> >> >> >datapath pipeline after it is create and we are discussin=
g a P4
> >> >> >> >> >>
> >> >> >> >> >> Isn't this up to the implementation? I mean from the p4 pe=
rspective,
> >> >> >> >> >> everything is static. Hw might need to reshuffle the pipel=
ine internally
> >> >> >> >> >> during rule insertion/remove in order to optimize the layo=
ut.
> >> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >But do note: the focus here is on P4 (hence the name P4TC).
> >> >> >> >> >
> >> >> >> >> >> >implementation not an extension that would add more value=
 b) We are
> >> >> >> >> >> >more than happy to add extensions in the future to accomo=
date for
> >> >> >> >> >> >features but first _P4 spec_ must be met c) we had longer=
 discussions
> >> >> >> >> >> >with Matty, Khalid and the Rice folks who wrote a paper o=
n that topic
> >> >> >> >> >> >which you probably didnt attend and everything that needs=
 to be done
> >> >> >> >> >> >can be from user space today for all those optimizations.
> >> >> >> >> >> >
> >> >> >> >> >> >Conclusion is: For what you need to do (which i dont beli=
eve is a
> >> >> >> >> >> >limitation in your hardware rather a design decision on y=
our part) run
> >> >> >> >> >> >your user space daemon, do optimizations and update the d=
atapath.
> >> >> >> >> >> >Everybody is happy.
> >> >> >> >> >>
> >> >> >> >> >> Should the userspace daemon listen on inserted rules to be=
 offloade
> >> >> >> >> >> over netlink?
> >> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >I mean you could if you wanted to given this is just traditi=
onal
> >> >> >> >> >netlink which emits events (with some filtering when we inte=
grate the
> >> >> >> >> >filter approach). But why?
> >> >> >> >>
> >> >> >> >> Nevermind.
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >> >
> >> >> >> >> >> >>
> >> >> >> >> >> >> >Nobody is stopping you from offering your customers pr=
oprietary
> >> >> >> >> >> >> >solutions which include a specific ebpf approach along=
side DOCA. We
> >> >> >> >> >> >> >believe that a singular interface regardless of the ve=
ndor is the
> >> >> >> >> >> >> >right way forward. IMHO, this siloing that unfortunate=
ly is also added
> >> >> >> >> >> >> >by eBPF being a double edged sword is not good for the=
 community.
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> As I also said on the p4 call couple of times, I don=
't see the kernel
> >> >> >> >> >> >> >> as the correct place to do the p4 abstractions. Why =
don't you do it in
> >> >> >> >> >> >> >> userspace and give vendors possiblity to have p4 bac=
kends with compilers,
> >> >> >> >> >> >> >> runtime optimizations etc in userspace, talking to t=
he HW in the
> >> >> >> >> >> >> >> vendor-suitable way too. Then the SW implementation =
could be easily eBPF
> >> >> >> >> >> >> >> and the main reason (I believe) why you need to have=
 this is TC
> >> >> >> >> >> >> >> (offload) is then void.
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> The "everyone wants to use TC/netlink" claim does no=
t seem correct
> >> >> >> >> >> >> >> to me. Why not to have one Linux p4 solution that fi=
ts everyones needs?
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >You mean more fitting to the DOCA world? no, because i=
am a kernel
> >> >> >> >> >> >>
> >> >> >> >> >> >> Again, this has 0 relation to DOCA.
> >> >> >> >> >> >>
> >> >> >> >> >> >>
> >> >> >> >> >> >> >first person and kernel interfaces are good for everyo=
ne.
> >> >> >> >> >> >>
> >> >> >> >> >> >> Yeah, not really. Not always the kernel is the right an=
swer. Your/Intel
> >> >> >> >> >> >> plan to handle the offload by:
> >> >> >> >> >> >> 1) abuse devlink to flash p4 binary
> >> >> >> >> >> >> 2) parse the binary in kernel to match to the table ids=
 of rules coming
> >> >> >> >> >> >>    from p4tc ndo_setup_tc
> >> >> >> >> >> >> 3) abuse devlink to flash p4 binary for tc-flower
> >> >> >> >> >> >> 4) parse the binary in kernel to match to the table ids=
 of rules coming
> >> >> >> >> >> >>    from tc-flower ndo_setup_tc
> >> >> >> >> >> >> is really something that is making me a little bit naus=
eous.
> >> >> >> >> >> >>
> >> >> >> >> >> >> If you don't have a feasible plan to do the offload, p4=
tc does not make
> >> >> >> >> >> >> sense to me to be honest.
> >> >> >> >> >> >
> >> >> >> >> >> >You mean if there's no plan to match your (NVIDIA?)  poin=
t of view.
> >> >> >> >> >> >For #1 - how's this different from DDP? Wasnt that your s=
uggestion to
> >> >> >> >> >>
> >> >> >> >> >> I doubt that. Any flashing-blob-parsing-in-kernel is somet=
hing I'm
> >> >> >> >> >> opposed to from day 1.
> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >Oh well - it is in the kernel and it works fine tbh.
> >> >> >> >> >
> >> >> >> >> >> >begin with? For #2 Nobody is proposing to do anything of =
the sort. The
> >> >> >> >> >> >ndo is passed IDs for the objects and associated contents=
. For #3+#4
> >> >> >> >> >>
> >> >> >> >> >> During offload, you need to parse the blob in driver to be=
 able to match
> >> >> >> >> >> the ids with blob entities. That was presented by you/Inte=
l in the past
> >> >> >> >> >> IIRC.
> >> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >You are correct - in case of offload the netlink IDs will ha=
ve to be
> >> >> >> >> >authenticated against what the hardware can accept, but the =
devlink
> >> >> >> >> >flash use i believe was from you as a compromise.
> >> >> >> >>
> >> >> >> >> Definitelly not. I'm against devlink abuse for this from day =
1.
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >> >tc flower thing has nothing to do with P4TC that was just=
 some random
> >> >> >> >> >> >proposal someone made seeing if they could ride on top of=
 P4TC.
> >> >> >> >> >>
> >> >> >> >> >> Yeah, it's not yet merged and already mentally used for ab=
use. I love
> >> >> >> >> >> that :)
> >> >> >> >> >>
> >> >> >> >> >> >
> >> >> >> >> >> >Besides this nobody really has to satisfy your point of v=
iew - like i
> >> >> >> >> >> >said earlier feel free to provide proprietary solutions. =
From a
> >> >> >> >> >> >consumer perspective  I would not want to deal with 4 dif=
ferent
> >> >> >> >> >> >vendors with 4 different proprietary approaches. The kern=
el is the
> >> >> >> >> >> >unifying part. You seemed happier with tc flower just not=
 with the
> >> >> >> >> >>
> >> >> >> >> >> Yeah, that is my point, why the unifying part can't be a u=
serspace
> >> >> >> >> >> daemon/library with multiple backends (p4tc, bpf, vendorX,=
 vendorY, ..)?
> >> >> >> >> >>
> >> >> >> >> >> I just don't see the kernel as a good fit for abstraction =
here,
> >> >> >> >> >> given the fact that the vendor compilers does not run in k=
ernel.
> >> >> >> >> >> That is breaking your model.
> >> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >Jiri - we want to support P4, first. Like you said the P4 pi=
peline,
> >> >> >> >> >once installed is static.
> >> >> >> >> >P4 doesnt allow dynamic update of the pipeline. For example,=
 once you
> >> >> >> >> >say "here are my 14 tables and their associated actions and =
here's how
> >> >> >> >> >the pipeline main control (on how to iterate the tables etc)=
 is going
> >> >> >> >> >to be" and after you instantiate/activate that pipeline, you=
 dont go
> >> >> >> >> >back 5 minutes later and say "sorry, please introduce table =
15, which
> >> >> >> >> >i want you to walk to after you visit table 3 if metadata fo=
o is 5" or
> >> >> >> >> >"shoot, let's change that table 5 to be exact instead of LPM=
". It's
> >> >> >> >> >not anywhere in the spec.
> >> >> >> >> >That doesnt mean it is not useful thing to have - but it is =
an
> >> >> >> >> >invention that has _nothing to do with the P4 spec_; so sayi=
ng a P4
> >> >> >> >> >implementation must support it is a bit out of scope and the=
re are
> >> >> >> >> >vendors with hardware who support P4 today that dont need an=
y of this.
> >> >> >> >>
> >> >> >> >> I'm not talking about the spec. I'm talking about the offload
> >> >> >> >> implemetation, the offload compiler the offload runtime manag=
er. You
> >> >> >> >> don't have those in kernel. That is the issue. The runtime ma=
nager is
> >> >> >> >> the one to decide and reshuffle the hw internals. Again, this=
 has
> >> >> >> >> nothing to do with p4 frontend. This is offload implementatio=
n.
> >> >> >> >>
> >> >> >> >> And that is why I believe your p4 kernel implementation is un=
offloadable.
> >> >> >> >> And if it is unoffloadable, do we really need it? IDK.
> >> >> >> >>
> >> >> >> >
> >> >> >> >Say what?
> >> >> >> >It's not offloadable in your hardware, you mean? Because i have=
 beside
> >> >> >> >me here an intel e2000 which offloads just fine (and the AMD fo=
lks
> >> >> >> >seem fine too).
> >> >> >>
> >> >> >> Will Intel and AMD have compiler in kernel, so no blob transfer =
and
> >> >> >> parsing it in kernel wound not be needed? No.
> >> >> >
> >> >> >By that definition anything that parses anything is a compiler.
> >> >> >
> >> >> >>
> >> >> >> >If your view is that all these runtime optimization surmount to=
 a
> >> >> >> >compiler in the kernel/driver that is your, well, your view. In=
 my
> >> >> >> >view (and others have said this to you already) the P4C compile=
r is
> >> >> >> >responsible for resource optimizations. The hardware supports P=
4, you
> >> >> >> >give it constraints and it knows what to do. At runtime, anythi=
ng a
> >> >> >> >driver needs to do for resource optimization (resorting, reshuf=
fling
> >> >> >> >etc), that is not a P4 problem - sorry if you have issues in yo=
ur
> >> >> >> >architecture approach.
> >> >> >>
> >> >> >> Sure, it is the offload implementation problem. And for them, yo=
u need
> >> >> >> to use userspace components. And that is the problem. This discu=
ssion
> >> >> >> leads nowhere, I don't know how differently I should describe th=
is.
> >> >> >
> >> >> >Jiri's - that's your view based on whatever design you have in you=
r
> >> >> >mind. This has nothing to do with P4.
> >> >> >So let me repeat again:
> >> >> >1) A vendor's backend for P4 when it compiles ensures that resourc=
e
> >> >> >constraints are taken care of.
> >> >> >2) The same program can run in s/w.
> >> >> >3) It makes *ZERO* sense to mix vendor specific constraint
> >> >> >optimization(what you described as resorting, reshuffling etc) as =
part
> >> >> >of P4TC or P4. Absolutely nothing to do with either. Write a
> >> >>
> >> >> I never suggested for it to be part of P4tc of P4. I don't know why=
 you
> >> >> think so.
> >> >
> >> >I guess because this discussion is about P4/P4TC? I may have misread
> >> >what you are saying then because I saw the  "P4TC must be in
> >> >userspace" mantra tied to this specific optimization requirement.
> >>
> >> Yeah, and again, my point is, this is unoffloadable.
> >
> >Here we go again with this weird claim. I guess we need to give an
> >award to the other vendors for doing the "impossible"?
>
> By having the compiler in kernel, that would be awesome. Clear offload
> from kernel to device.
>
> That's not the case. Trampolines, binary blobs parsing in kernel doing
> the match with tc structures in drivers, abuse of devlink flash,
> tc-flower offload using this facility. All this was already seriously
> discussed before p4tc is even merged. Great, love that.
>

I was hoping not to say anything but my fingers couldnt help themselves:
So "unoffloadable" means there is a binary blob and this doesnt work
per your design idea of how it should work?
Not that it cant be implemented (clearly it has been implemented), it
is just not how _you_ would implement it? All along I thought this was
an issue with your hardware.
I know that when someone says devlink your answer is N.O - but that is
a different topic.

cheers,
jamal

>
> >
> >>Do we still  need it in kernel?
> >
> >Didnt you just say it has nothing to do with P4TC?
> >
> >You "It cant be offloaded".
> >Me "it can be offloaded, other vendors are doing it and it has nothing
> >to do with P4 or P4TC and here's why..."
> >You " i didnt say it has anything to do with P4 or P4TC"
> >Me "ok i misunderstood i thought you said P4 cant be offloaded via
> >P4TC and has to be done in user space"
> >You "It cant be offloaded"
>
> Let me do my own misinterpretation please.
>
>
>
> >
> >Circular non-ending discussion.
> >
> >Then there's John
> >John "ebpf, ebpf, ebpf"
> >Me "we gave you ebpf"
> >John "but you are not using ebpf system call"
> >Me " but it doesnt make sense for the following reasons..."
> >John "but someone has already implemented ebpf.."
> >Me "yes, but here's how ..."
> >John "ebpf, ebpf, ebpf"
> >
> >Another circular non-ending discussion.
> >
> >Let's just end this electron-wasting lawyering discussion.
> >
> >cheers,
> >jamal
> >
> >
> >
> >
> >
> >
> >Bizare. Unoffloadable according to you.
> >
> >>
> >> >
> >> >>
> >> >> >background task, specific to you,  if you feel you need to move th=
ings
> >> >> >around at runtime.
> >> >>
> >> >> Yeah, that backgroud task is in userspace.
> >> >>
> >> >
> >> >I don't have a horse in this race.
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >>
> >> >> >
> >> >> >We agree on one thing at least: This discussion is going nowhere.
> >> >>
> >> >> Correct.
> >> >>
> >> >> >
> >> >> >cheers,
> >> >> >jamal
> >> >> >
> >> >> >
> >> >> >
> >> >> >> >
> >> >> >> >> >In my opinion that is a feature that could be added later ou=
t of
> >> >> >> >> >necessity (there is some good niche value in being able to a=
dd some
> >> >> >> >> >"dynamicism" to any pipeline) and influence the P4 standards=
 on why it
> >> >> >> >> >is needed.
> >> >> >> >> >It should be doable today in a brute force way (this is just=
 one
> >> >> >> >> >suggestion that came to me when Rice University/Nvidia prese=
nted[1]);
> >> >> >> >> >i am sure there are other approaches and the idea is by no m=
eans
> >> >> >> >> >proven.
> >> >> >> >> >
> >> >> >> >> >1) User space Creates/compiles/Adds/activate your program th=
at has 14
> >> >> >> >> >tables at tc prio X chain Y
> >> >> >> >> >2) a) 5 minutes later user space decides it wants to change =
and add
> >> >> >> >> >table 3 after table 15, visited when metadata foo=3D5
> >> >> >> >> >    b) your compiler in user space compiles a brand new prog=
ram which
> >> >> >> >> >satisfies #2a (how this program was authored is out of scope=
 of
> >> >> >> >> >discussion)
> >> >> >> >> >    c) user space adds the new program at tc prio X+1 chain =
Y or another chain Z
> >> >> >> >> >    d) user space delete tc prio X chain Y (and make sure yo=
ur packets
> >> >> >> >> >entry point is whatever #c is)
> >> >> >> >>
> >> >> >> >> I never suggested anything like what you describe. I'm not su=
re why you
> >> >> >> >> think so.
> >> >> >> >
> >> >> >> >It's the same class of problems - the paper i pointed to (coaut=
hored
> >> >> >> >by Matty and others) has runtime resource optimizations which a=
re
> >> >> >> >tantamount to changing the nature of the pipeline. We may need =
to
> >> >> >> >profile in the kernel but all those optimizations can be derive=
d in
> >> >> >> >user space using the approach I described.
> >> >> >> >
> >> >> >> >cheers,
> >> >> >> >jamal
> >> >> >> >
> >> >> >> >
> >> >> >> >> >[1] https://www.cs.rice.edu/~eugeneng/papers/SIGCOMM23-Pipel=
eon.pdf
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >> >kernel process - which is ironically the same thing we ar=
e going
> >> >> >> >> >> >through here ;->
> >> >> >> >> >> >
> >> >> >> >> >> >cheers,
> >> >> >> >> >> >jamal
> >> >> >> >> >> >
> >> >> >> >> >> >>
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >cheers,
> >> >> >> >> >> >> >jamal


Return-Path: <bpf+bounces-15532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7B7F323D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB301C21B0F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73C5677A;
	Tue, 21 Nov 2023 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="c2WUgr5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31EED
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 07:21:57 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cb76e7f7daso10174897b3.3
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700580117; x=1701184917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMY4Uhh9Vom4vuQvswEdPF4Kpw3jWYoPNZBPTH1IkUY=;
        b=c2WUgr5U4o8OwTLJLED0xFZF2qyJQnzgMJRkliNmcIHEoe7ykG3CEG3dnoqqy6QSpy
         Y04YYiiFJkJhVGYJctwvc3U+E39GC4ROeb2GxN+qKbwOFzYh5J9FE9blgoxWUX5BMifW
         T6mqeYXVseyy36Gd6EDJXc0SxlcFPdFMyrnoPABWdb9lN9xdFIo5NyQfLzXlDGlAEQAn
         4EJAOXnr9hEc4a1WzTxHuTpdb0XMU0/4+1DksEKslQYGruMCrBq9YQxRBmqkaYuH+DCO
         duSTZsCF2Z/y0oZNWkBwnanYlacAU9V2YWg8bZdmxCFbG9TAK56eBRqyG91MeK1GY2SZ
         xDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700580117; x=1701184917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMY4Uhh9Vom4vuQvswEdPF4Kpw3jWYoPNZBPTH1IkUY=;
        b=P21pmWb0XwQfNb4MeUbJrQinBvjhP6ZxiqJ/EwRXTkp/mp1jAM6w1MeQ9f7Cm/zFqa
         1rKCrb9cUSt5z6lnJ1R2gJQWiLVz/nGHJjTfgT6hCqkx9yYjNxoZwGniyL3YWe66gVEq
         TwFZ9Hlj/0FE8VQUE8xcv323HjU2nyLdqF0zI2cFaRQl00GNJvq54iQTHiEBgOX/LlJa
         Ct3AGLc4bWbvTZ5ku2AdrDKHuA2ejZ6KhiILJVD1LnzX9+l3wc/ng3IN9tcJjnOKcU1C
         baDuznrRZNRxp9G56Zy3RLBP5ble5j+xDlmiq8vtWbs/gANmjMmc0vAE7c+SapuK9gao
         MJ4w==
X-Gm-Message-State: AOJu0YwqkWJkJ4Gk+SJAYTAhrVrEoCRDxgky1Hp0txbZMFo1+iEkHTql
	zl5wdWEHa3uDt1Zh+HY1pQkCvJDM3TdxPIrdlBxgKA==
X-Google-Smtp-Source: AGHT+IHVVwKYCkXLVFrT1X9hdWg/3oXEb5fHthAPfstWeBIbVYeFWvK0EBR7lAljsMgqMGq87uQnNFuxDKEqB+zPmG4=
X-Received: by 2002:a81:790a:0:b0:5ca:4b49:66d2 with SMTP id
 u10-20020a81790a000000b005ca4b4966d2mr6610452ywc.17.1700580116950; Tue, 21
 Nov 2023 07:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6557b2e5f3489_5ada920871@john.notmuch> <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho> <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho> <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net> <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
 <ZVyrRFDrVqluD9k/@nanopsycho> <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
 <ZVy8cEjs9VK2OVxE@nanopsycho>
In-Reply-To: <ZVy8cEjs9VK2OVxE@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 21 Nov 2023 10:21:44 -0500
Message-ID: <CAM0EoMmPnCeU2uLph=uwh3JxtE4RQnvcSA2WdZgORywzNFCO6g@mail.gmail.com>
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

On Tue, Nov 21, 2023 at 9:19=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com wrote:
> >On Tue, Nov 21, 2023 at 8:06=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
> >> >On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >> >>
> >> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> >> >> > On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@resnulli=
.us> wrote:
> >> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
> >>
> >> [...]
> >>
> >> >
> >> >> tc BPF and XDP already have widely used infrastructure and can be d=
eveloped
> >> >> against libbpf or other user space libraries for a user space contr=
ol plane.
> >> >> With 'control plane' you refer here to the tc / netlink shim you've=
 built,
> >> >> but looking at the tc command line examples, this doesn't really pr=
ovide a
> >> >> good user experience (you call it p4 but people load bpf obj files)=
. If the
> >> >> expectation is that an operator should run tc commands, then neithe=
r it's
> >> >> a nice experience for p4 nor for BPF folks. From a BPF PoV, we move=
d over
> >> >> to bpf_mprog and plan to also extend this for XDP to have a common =
look and
> >> >> feel wrt networking for developers. Why can't this be reused?
> >> >
> >> >The filter loading which loads the program is considered pipeline
> >> >instantiation - consider it as "provisioning" more than "control"
> >> >which runs at runtime. "control" is purely netlink based. The iproute=
2
> >> >code we use links libbpf for example for the filter. If we can achiev=
e
> >> >the same with bpf_mprog then sure - we just dont want to loose
> >> >functionality though.  off top of my head, some sample space:
> >> >- we could have multiple pipelines with different priorities (which t=
c
> >> >provides to us) - and each pipeline may have its own logic with many
> >> >tables etc (and the choice to iterate the next one is essentially
> >> >encoded in the tc action codes)
> >> >- we use tc block to map groups of ports (which i dont think bpf has
> >> >internal access of)
> >> >
> >> >In regards to usability: no i dont expect someone doing things at
> >> >scale to use command line tc. The APIs are via netlink. But the tc cl=
i
> >> >is must for the rest of the masses per our traditions. Also i really
> >>
> >> I don't follow. You repeatedly mention "the must of the traditional tc
> >> cli", but what of the existing traditional cli you use for p4tc?
> >> If I look at the examples, pretty much everything looks new to me.
> >> Example:
> >>
> >>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >>     action send_to_port param port eno1
> >>
> >> This is just TC/RTnetlink used as a channel to pass new things over. I=
f
> >> that is the case, what's traditional here?
> >>
> >
> >
> >What is not traditional about it?
>
> Okay, so in that case, the following example communitating with
> userspace deamon using imaginary "p4ctrl" app is equally traditional:
>   $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>      action send_to_port param port eno1

Huh? Thats just an application - classical tc which part of iproute2
that is sending to the kernel, no different than "tc flower.."
Where do you get the "userspace" daemon part? Yes, you can write a
daemon but it will use the same APIs as tc.

>
> >
> >>
> >> >didnt even want to use ebpf at all for operator experience reasons -
> >> >it requires a compilation of the code and an extra loading compared t=
o
> >> >what our original u32/pedit code offered.
> >> >
> >> >> I don't quite follow why not most of this could be implemented enti=
rely in
> >> >> user space without the detour of this and you would provide a devel=
oper
> >> >> library which could then be integrated into a p4 runtime/frontend? =
This
> >> >> way users never interface with ebpf parts nor tc given they also sh=
ouldn't
> >> >> have to - it's an implementation detail. This is what John was also=
 pointing
> >> >> out earlier.
> >> >>
> >> >
> >> >Netlink is the API. We will provide a library for object manipulation
> >> >which abstracts away the need to know netlink. Someone who for their
> >> >own reasons wants to use p4runtime or TDI could write on top of this.
> >> >I would not design a kernel interface to just meet p4runtime (we
> >> >already have TDI which came later which does things differently). So =
i
> >> >expect us to support both those two. And if i was to do something on
> >> >SDN that was more robust i would write my own that still uses these
> >> >netlink interfaces.
> >>
> >> Actually, what Daniel says about the p4 library used as a backend to p=
4
> >> frontend is pretty much aligned what I claimed on the p4 calls couple =
of
> >> times. If you have this p4 userspace tooling, it is easy for offloads =
to
> >> replace the backed by vendor-specific library which allows p4 offload
> >> suitable for all vendors (your plan of p4tc offload does not work well
> >> for our hw, as we repeatedly claimed).
> >>
> >
> >That's you - NVIDIA. You have chosen a path away from the kernel
> >towards DOCA. I understand NVIDIA's frustration with dealing with
> >upstream process (which has been cited to me as a good reason for
> >DOCA) but please dont impose these values and your politics on other
> >vendors(Intel, AMD for example) who are more than willing to invest
> >into making the kernel interfaces the path forward. Your choice.
>
> No, you are missing the point. This has nothing to do with DOCA.

Right Jiri ;->

> This
> has to do with the simple limitation of your offload assuming there are
> no runtime changes in the compiled pipeline. For Intel, maybe they
> aren't, and it's a good fit for them. All I say is, that it is not the
> good fit for everyone.

 a) it is not part of the P4 spec to dynamically make changes to the
datapath pipeline after it is create and we are discussing a P4
implementation not an extension that would add more value b) We are
more than happy to add extensions in the future to accomodate for
features but first _P4 spec_ must be met c) we had longer discussions
with Matty, Khalid and the Rice folks who wrote a paper on that topic
which you probably didnt attend and everything that needs to be done
can be from user space today for all those optimizations.

Conclusion is: For what you need to do (which i dont believe is a
limitation in your hardware rather a design decision on your part) run
your user space daemon, do optimizations and update the datapath.
Everybody is happy.

>
> >Nobody is stopping you from offering your customers proprietary
> >solutions which include a specific ebpf approach alongside DOCA. We
> >believe that a singular interface regardless of the vendor is the
> >right way forward. IMHO, this siloing that unfortunately is also added
> >by eBPF being a double edged sword is not good for the community.
> >
> >> As I also said on the p4 call couple of times, I don't see the kernel
> >> as the correct place to do the p4 abstractions. Why don't you do it in
> >> userspace and give vendors possiblity to have p4 backends with compile=
rs,
> >> runtime optimizations etc in userspace, talking to the HW in the
> >> vendor-suitable way too. Then the SW implementation could be easily eB=
PF
> >> and the main reason (I believe) why you need to have this is TC
> >> (offload) is then void.
> >>
> >> The "everyone wants to use TC/netlink" claim does not seem correct
> >> to me. Why not to have one Linux p4 solution that fits everyones needs=
?
> >
> >You mean more fitting to the DOCA world? no, because iam a kernel
>
> Again, this has 0 relation to DOCA.
>
>
> >first person and kernel interfaces are good for everyone.
>
> Yeah, not really. Not always the kernel is the right answer. Your/Intel
> plan to handle the offload by:
> 1) abuse devlink to flash p4 binary
> 2) parse the binary in kernel to match to the table ids of rules coming
>    from p4tc ndo_setup_tc
> 3) abuse devlink to flash p4 binary for tc-flower
> 4) parse the binary in kernel to match to the table ids of rules coming
>    from tc-flower ndo_setup_tc
> is really something that is making me a little bit nauseous.
>
> If you don't have a feasible plan to do the offload, p4tc does not make
> sense to me to be honest.

You mean if there's no plan to match your (NVIDIA?)  point of view.
For #1 - how's this different from DDP? Wasnt that your suggestion to
begin with? For #2 Nobody is proposing to do anything of the sort. The
ndo is passed IDs for the objects and associated contents. For #3+#4
tc flower thing has nothing to do with P4TC that was just some random
proposal someone made seeing if they could ride on top of P4TC.

Besides this nobody really has to satisfy your point of view - like i
said earlier feel free to provide proprietary solutions. From a
consumer perspective  I would not want to deal with 4 different
vendors with 4 different proprietary approaches. The kernel is the
unifying part. You seemed happier with tc flower just not with the
kernel process - which is ironically the same thing we are going
through here ;->

cheers,
jamal

>
> >
> >cheers,
> >jamal


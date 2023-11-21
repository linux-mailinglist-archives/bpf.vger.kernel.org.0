Return-Path: <bpf+bounces-15523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C57F2F2F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EAA281FDA
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C3537E5;
	Tue, 21 Nov 2023 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wcOidUfs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CB10C9
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 05:47:52 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cb96ef7ac6so6850367b3.3
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 05:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700574472; x=1701179272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VerNT8Gw12YAOZTvRS0cxBeag4LD9p5tqA+hOCXMkm4=;
        b=wcOidUfs38u8jnj2H8TVXVfvkQeN4xtQjMQnbZPfH9MnDLqLdS2pg1YKxrzZJunLeJ
         ng+LBwvRsPAhEtx43V5HyDYBmebwje5j39/cjHraDZP9RUQdhayIXSDwr6/0q16cLqM7
         gupQ1E3aqYGRn18qXBiWYsXUu63h0zYQuNmEGbfvA4p8h195CWC8JICbcsccXNuSCgVQ
         aMO9zdw3eSoIj1BC197uSw2WHFPSPl+ILUYWqDlZXssl5n8bs01MjD26pDGDlDSAaXHJ
         W/KGKOBoEm3oHW9KR1qzUFuSObnKh0YR49T//RVChCmwy6O9Cr6CxBQM0mveCMKsYwIT
         KEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574472; x=1701179272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VerNT8Gw12YAOZTvRS0cxBeag4LD9p5tqA+hOCXMkm4=;
        b=vyWuprz4V84D/h2U2ErbbWxVxM8YugyJOqqFWW+/toEWW8K+q83ieMVKoXpRiqtjC1
         y/NN4zUyh3F0SOEvGl1U1B169ClsTt0cn20l3tlahPKlqqctsdnWn4cgMQXgUgrcwzfJ
         ivVrC3+u59MpNjiCiL5Ym0IejLbZzUTWNbA1bt+fCTrB94asBkXF7mjKMMiPWCXWssn0
         QNFOSE1OGxedFigfU4Hhdgd2Sa+WWLYmVLKmIc3ss0Qec1JfZNmYxpkoQSsmPFEZF5kI
         YB6qRdxBamTu1ecYxkj1htKo13RFYN84Dfi/YqhIRCUpQsm1HfmoJKy2IVrri/xhStl5
         +31w==
X-Gm-Message-State: AOJu0Yzf1PVlE1RS9Rk05OCE3FRu6Afq4YwaM2JZMvvO+egJKkP7WlXJ
	hJlnskmh1VSsIU4IyfjXFI75XesBB7WnwLU4jrRlVJYFgkVUgsy1Yj8=
X-Google-Smtp-Source: AGHT+IGidjeQm7rHBiaDQFbjYGYX0jS7jFnwE7kpC9ngfb9OMd4RTZqw3Z/nFwGX0mNivieuXGn2zoO/akBE4N6zp0A=
X-Received: by 2002:a81:79cd:0:b0:5cb:c143:cd90 with SMTP id
 u196-20020a8179cd000000b005cbc143cd90mr1141125ywc.35.1700574472123; Tue, 21
 Nov 2023 05:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <655707db8d55e_55d7320812@john.notmuch> <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch> <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho> <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho> <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net> <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
 <ZVyrRFDrVqluD9k/@nanopsycho>
In-Reply-To: <ZVyrRFDrVqluD9k/@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 21 Nov 2023 08:47:40 -0500
Message-ID: <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
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

On Tue, Nov 21, 2023 at 8:06=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
> >On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >>
> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> >> > On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@resnulli.us=
> wrote:
> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
>
> [...]
>
> >
> >> tc BPF and XDP already have widely used infrastructure and can be deve=
loped
> >> against libbpf or other user space libraries for a user space control =
plane.
> >> With 'control plane' you refer here to the tc / netlink shim you've bu=
ilt,
> >> but looking at the tc command line examples, this doesn't really provi=
de a
> >> good user experience (you call it p4 but people load bpf obj files). I=
f the
> >> expectation is that an operator should run tc commands, then neither i=
t's
> >> a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved o=
ver
> >> to bpf_mprog and plan to also extend this for XDP to have a common loo=
k and
> >> feel wrt networking for developers. Why can't this be reused?
> >
> >The filter loading which loads the program is considered pipeline
> >instantiation - consider it as "provisioning" more than "control"
> >which runs at runtime. "control" is purely netlink based. The iproute2
> >code we use links libbpf for example for the filter. If we can achieve
> >the same with bpf_mprog then sure - we just dont want to loose
> >functionality though.  off top of my head, some sample space:
> >- we could have multiple pipelines with different priorities (which tc
> >provides to us) - and each pipeline may have its own logic with many
> >tables etc (and the choice to iterate the next one is essentially
> >encoded in the tc action codes)
> >- we use tc block to map groups of ports (which i dont think bpf has
> >internal access of)
> >
> >In regards to usability: no i dont expect someone doing things at
> >scale to use command line tc. The APIs are via netlink. But the tc cli
> >is must for the rest of the masses per our traditions. Also i really
>
> I don't follow. You repeatedly mention "the must of the traditional tc
> cli", but what of the existing traditional cli you use for p4tc?
> If I look at the examples, pretty much everything looks new to me.
> Example:
>
>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>     action send_to_port param port eno1
>
> This is just TC/RTnetlink used as a channel to pass new things over. If
> that is the case, what's traditional here?
>


What is not traditional about it?

>
> >didnt even want to use ebpf at all for operator experience reasons -
> >it requires a compilation of the code and an extra loading compared to
> >what our original u32/pedit code offered.
> >
> >> I don't quite follow why not most of this could be implemented entirel=
y in
> >> user space without the detour of this and you would provide a develope=
r
> >> library which could then be integrated into a p4 runtime/frontend? Thi=
s
> >> way users never interface with ebpf parts nor tc given they also shoul=
dn't
> >> have to - it's an implementation detail. This is what John was also po=
inting
> >> out earlier.
> >>
> >
> >Netlink is the API. We will provide a library for object manipulation
> >which abstracts away the need to know netlink. Someone who for their
> >own reasons wants to use p4runtime or TDI could write on top of this.
> >I would not design a kernel interface to just meet p4runtime (we
> >already have TDI which came later which does things differently). So i
> >expect us to support both those two. And if i was to do something on
> >SDN that was more robust i would write my own that still uses these
> >netlink interfaces.
>
> Actually, what Daniel says about the p4 library used as a backend to p4
> frontend is pretty much aligned what I claimed on the p4 calls couple of
> times. If you have this p4 userspace tooling, it is easy for offloads to
> replace the backed by vendor-specific library which allows p4 offload
> suitable for all vendors (your plan of p4tc offload does not work well
> for our hw, as we repeatedly claimed).
>

That's you - NVIDIA. You have chosen a path away from the kernel
towards DOCA. I understand NVIDIA's frustration with dealing with
upstream process (which has been cited to me as a good reason for
DOCA) but please dont impose these values and your politics on other
vendors(Intel, AMD for example) who are more than willing to invest
into making the kernel interfaces the path forward. Your choice.
Nobody is stopping you from offering your customers proprietary
solutions which include a specific ebpf approach alongside DOCA. We
believe that a singular interface regardless of the vendor is the
right way forward. IMHO, this siloing that unfortunately is also added
by eBPF being a double edged sword is not good for the community.

> As I also said on the p4 call couple of times, I don't see the kernel
> as the correct place to do the p4 abstractions. Why don't you do it in
> userspace and give vendors possiblity to have p4 backends with compilers,
> runtime optimizations etc in userspace, talking to the HW in the
> vendor-suitable way too. Then the SW implementation could be easily eBPF
> and the main reason (I believe) why you need to have this is TC
> (offload) is then void.
>
> The "everyone wants to use TC/netlink" claim does not seem correct
> to me. Why not to have one Linux p4 solution that fits everyones needs?

You mean more fitting to the DOCA world? no, because iam a kernel
first person and kernel interfaces are good for everyone.

cheers,
jamal


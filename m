Return-Path: <bpf+bounces-23240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631286EE3E
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 03:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9C8B21BE7
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29F748F;
	Sat,  2 Mar 2024 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OH5lXw0L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBE7E6
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709348374; cv=none; b=cBuGrBCiIbVYbhg7LqdRQGTrJ9V3rPPvrUyIRHIFIdVjwA/sCDAhXcnOgHcgAegnZ3b7Yhg3ItRkxjTxS7KVq33agdM+Toik/uLR6yyXMmJW5lmbvTNGfGmP8gnYBg+o6JzsungLAy8jvXzy3pYmrODwQQhKDAZgcxNo2n6eoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709348374; c=relaxed/simple;
	bh=PJojuRK2UQ2s1juHjnuAteI986hOH8f8iIypONHM95s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdP9L/1O5w55PkXP9tb3VHXwvYSClUGzbDeWPKJgbv7PS+w3G4S+ET4iBIEjJy+DVlYjoo9IU7dXPcwRih8rX7/0e9MW8DxbSG8Rde3TdHEeQq2LaZcuMqfl2W/3VcFGb4LMlvE0cHGNrKCGpfAMG1w2Z6FK7a2kSOFCyyAsARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OH5lXw0L; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6098ba9959aso8127277b3.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 18:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709348371; x=1709953171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U/Hzl/nP419sc3U29JHguCJujbZDse52KbGi5DVDrc=;
        b=OH5lXw0LWXkNEH/2rIyyru+ZGLgZkF8WpiA9NzxPNjrB8RPeEn/FcfoXOiyRy31Q7g
         ZWu6mpOc48uLm5UAC1WVWorRBAN+iIA+ttyldFeYYULESq3FjMVo8cLVyqUxncaBRNpm
         mdmvydzepjVCEtHQCha66akEW8D9tjfRqUbopiFg34AtEn87gmfDLFT2XSe46SY7uW4Q
         XmlKm7L7sII+cxnmdaUlxUxQP523baesXcM3KnUGV0De46Xen3KRSkfzcN97VntNgbG5
         h8AWa1FK2zx6OEvHa7ZUMKeexnUCs2jI62hNszNabur/D9UATHB+mK2QqEvpwhR+vyuO
         VHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709348371; x=1709953171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U/Hzl/nP419sc3U29JHguCJujbZDse52KbGi5DVDrc=;
        b=StU3lFTq4pt0hIjr3G3F6hereVtWrZ/Axq3n8m6u1fL58bCOJybxAjravEYc3b+pTA
         bO9M7rRucN63/HFlJsvmn+1t8vAgi11zalc9uKmx8mAWBNUH0OZbXW8PJDARxLO9lTiV
         EAhg/CGH60rt5aAOorqLsdI2NdgProKdFqnmYQpo813/GHdudreOhi97P4h0aIHX8rEZ
         q2cWOfKAD5lfOFbebxDgWWoBvvDheMVmOAcuWTtsm3rpzr7OAqST7XYdrQNtcVZN13Gg
         6GmpHhYXF0VlkCluy0ObLYFXuqNhdAeveYiQ6ZmJkG+kR+tfd5F3bSdrjezOegP9e1hn
         gi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbEkTh+UiZ+HIlcJhBaLsyNInmeYUuPNntKJPz+jc+ghw57FKgcG5XabK2GeP/oSmuOqxyHHrzrcC3EqoSPnUdWNBF
X-Gm-Message-State: AOJu0Yy4XLFUguUT5WWaNbrOa/2fuF/hW8Af9EyiOX7R0O5Ue/HAkIww
	ve9a/I1NquVd83ha46D38BVxg9URwFGi5KdwHd0bbC+ZeVX8usz/Paqnee3Zch3GB02z5WsHwjG
	ARhAJXUFAfFQOWiHa1XOTxSTujzOXjVT9C3Lo
X-Google-Smtp-Source: AGHT+IGNuTlZO1FU43f2kK2IQYwty1kYNM0qJOpZKVlBIoqgV07eXIe9AKuixCD/d7kWGfXWGSlEkPglT+LYutW4KxM=
X-Received: by 2002:a05:690c:398:b0:609:3c37:a624 with SMTP id
 bh24-20020a05690c039800b006093c37a624mr4151017ywb.35.1709348371514; Fri, 01
 Mar 2024 18:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org>
In-Reply-To: <20240301173214.3d95e22b@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 21:59:20 -0500
Message-ID: <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
Subject: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 8:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 1 Mar 2024 12:39:56 -0500 Jamal Hadi Salim wrote:
> > On Fri, Mar 1, 2024 at 12:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > > Pardon my ignorance, but doesn't P4 want to be compiled to a backen=
d
> > > > target? How does going through TC make this seamless?
> > >
> > > +1
> >
> > I should clarify what i meant by "seamless". It means the same control
> > API is used for s/w or h/w. This is a feature of tc, and is not being
> > introduced by P4TC. P4 control only deals with Match-action tables -
> > just as TC does.
>
> Right, and the compiled P4 pipeline is tacked onto that API.
> Loading that presumably implies a pipeline reset. There's
> no precedent for loading things into TC resulting a device
> datapath reset.

Ive changed the subject to reflect this discussion is about h/w
offload so we dont drift too much from the intent of the patches.

AFAIK, all these devices have some HA built in to do program
replacement. i.e. afaik, no device reset.
I believe the tofino switch in the earlier generations may have needed
resets which caused a few packet drops in a live environment update.
Granted there may be devices (not that i am aware) that may not be
able to do HA. All this needs to be considered for offloads.

> > > My intuition is that for offload the device would be programmed at
> > > start-of-day / probe. By loading the compiled P4 from /lib/firmware.
> > > Then the _device_ tells the kernel what tables and parser graph it's
> > > got.
> >
> > BTW: I just want to say that these patches are about s/w - not
> > offload. Someone asked about offload so as in normal discussions we
> > steered in that direction. The hardware piece will require additional
> > patchsets which still require discussions. I hope we dont steer off
> > too much, otherwise i can start a new thread just to discuss current
> > view of the h/w.
> >
> > Its not the device telling the kernel what it has. Its the other way ar=
ound.
>
> Yes, I'm describing how I'd have designed it :) If it was the same
> as what you've already implemented - why would I be typing it into
> an email.. ? :)
>

I think i misunderstood you and thought I needed to provide context.
The P4 pipelines are meant to be able to be re-programmed multiple
times in a live environment. IOW, I should be able to delete/create a
pipeline while another is running. Some hardware may require that the
parser is shared etc, but you can certainly replace the match action
tables or add an entirely new logic. In any case this is all still
under discussion and can be further refined.

> > From the P4 program you generate the s/w (the ebpf code and other
> > auxillary stuff) and h/w pieces using a compiler.
> > You compile ebpf, etc, then load.
>
> That part is fine.
>
> > The current point of discussion is the hw binary is to be "activated"
> > through the same tc filter that does the s/w. So one could say:
> >
> > tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3
> > \
> >    prog type hw filename "simple_l3.o" ... \
> >    action bpf obj $PARSER.o section p4tc/parser \
> >    action bpf obj $PROGNAME.o section p4tc/main
> >
> > And that would through tc driver callbacks signal to the driver to
> > find the binary possibly via  /lib/firmware
> > Some of the original discussion was to use devlink for loading the
> > binary - but that went nowhere.
>
> Back to the device reset, unless the load has no impact on inflight
> traffic the loading doesn't belong in TC, IMO. Plus you're going to
> run into (what IIRC was Jiri's complaint) that you're loading arbitrary
> binary blobs, opaque to the kernel.
>

And you said at that time binary blobs are already a way of life.
Let's take DDP as a use case:  They load the firmware (via ethtool)
and we were recently discussing whether they should use flower or u32
etc.  I would say this is in the same spirit. Doing ethtool may be a
bit disconnected. But that is up for discussion as well.
There has been concern that we need to have some authentication in
some of the discussions. Is that what you mean?

> > Once you have this in place then netlink with tc skip_sw/hw. This is
> > what i meant by "seamless"
> >
> > > Plus, if we're talking about offloads, aren't we getting back into
> > > the same controversies we had when merging OvS (not that I was around=
).
> > > The "standalone stack to the side" problem. Some of the tables in the
> > > pipeline may be for routing, not ACLs. Should they be fed from the
> > > routing stack? How is that integration going to work? The parsing
> > > graph feels a bit like global device configuration, not a piece of
> > > functionality that should sit under sub-sub-system in the corner.
> >
> > The current (maybe i should say initial) thought is the P4 program
> > does not touch the existing kernel infra such as fdb etc.
>
> It's off to the side thing. Ignoring the fact that *all*, networking
> devices already have parsers which would benefit from being accurately
> described.
>

I am not following this point.

> > Of course we can model the kernel datapath using P4 but you wont be
> > using "ip route add..." or "bridge fdb...".
> > In the future, P4 extern could be used to model existing infra and we
> > should be able to use the same tooling. That is a discussion that
> > comes on/off (i think it did in the last meeting).
>
> Maybe, IDK. I thought prevailing wisdom, at least for offloads,
> is to offload the existing networking stack, and fill in the gaps.
> Not build a completely new implementation from scratch, and "integrate
> later". Or at least "fill in the gaps" is how I like to think.
>
> I can't quite fit together in my head how this is okay, but OvS
> was not allowed to add their offload API. And what's supposed to
> be part of TC and what isn't, where you only expect to have one
> filter here, and create a whole new object universe inside TC.
>

I was there.
Ovs matched what tc already had functionally, 10 years after tc
existed, and they were busy rewriting what tc offered. So naturally we
pushed for them to use what TC had. You still need to write whatever
extensions needed into the kernel etc in order to support what the
hardware can offer.

I hope i am not stating the obvious: P4 provides a more malleable
approach. Assume a blank template in h/w and s/w and where you specify
what you need then both the s/w and hardware support it. Flower is
analogous to a "fixed pipeline" meaning you can extend flower by
changing the kernel and datapath. Often it is not covering all
potential hw match actions engines and often we see patches to do one
more thing requiring more kernel changes.  If you replace flower with
P4 you remove the need to update the kernel, user space etc for the
same features that flower needs to be extended for today. You just
tell the compiler what you need (within hardware capacity of course).
So i dont see P4 as "offload the existing kernel infra aka flower" but
rather remove the limitations that flower constrains us with today. As
far as other kernel infra (fdb etc), that can be added as i stated -
it is just not a starting point.

cheers,
jamal


> But that's just my opinions. The way things work we may wake up one
> day and find out that Dave has applied this :)


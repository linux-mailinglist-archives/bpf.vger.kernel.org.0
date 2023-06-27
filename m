Return-Path: <bpf+bounces-3606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBAA7406DA
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A194E1C20A93
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E31ACC6;
	Tue, 27 Jun 2023 23:33:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BD1ACBB;
	Tue, 27 Jun 2023 23:33:51 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323081BE8;
	Tue, 27 Jun 2023 16:33:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7e66ff65fso32271305ad.0;
        Tue, 27 Jun 2023 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687908828; x=1690500828;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCPfyo+h3/0yPCZ4onaVKfSgNKBM4pdtDSWe4g2J3XM=;
        b=XYDwMzHff87av3xIcVhV2xcY38iIOcV6AvNLWpr5eN+MmGFaFcL8TPlxWHk6frZbHc
         UDfUIaurpR1GhaVztdYUYZHlKgc7ESwIlbAxuG/uPKewIhL2pb0az0ZrszVDrABrP5S9
         AcQbzMb3Nfe+Euc/tCnplXLfbpL71X6kPcb6lKU3ZTDdlqpqcxe2CGCDOizjZtwfSxuk
         bLdiuyB0CBtlt2pwnbYaT+lLrhNFpnBLKVQ4FqtyeIyYrLtRsND+xAyn4o33Osi7T9QT
         5/dNGoUntYKd3zNO3AmSIQZGX5hB1BHgELxVgAs0DxAv+6eabEnbDeLwKpy+lHcckEvM
         pCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687908828; x=1690500828;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RCPfyo+h3/0yPCZ4onaVKfSgNKBM4pdtDSWe4g2J3XM=;
        b=ZdPnX+mntTE4CQng9wRvOQUSbQivZyuBMYLhA+v2f9YODmv+0h6FdU19g80OL9flze
         1CtpCxnLAQKLVNBKzdOzc3dwxUjfXL0oPmx3sSwGz83KYFYEoTX46X87LtjW/Ke3IqQC
         4Ld/0yP+e+/bAxiBN0LM/0BXb8dAi+j5eHG1Oklt+N22OtvDB/I3B2HaF1QyIEG9rKsz
         ZyOzXhRyUqvJ110FWOMoyzmRnP6Ak/npZ8j7IHoaNUCPwaMEr+SPJ0KFF399HttFzKpg
         dWZoHmY4oTiT61NL4NnmdI0R+i2bC+pHW2VHnVcfuFWlmjXm/ZurYDitOTXXmG9h3RoA
         URxA==
X-Gm-Message-State: AC+VfDw71kwibxE2I4L8RLh+kEzPQlhJNPKnf6u+ch0GORLvHwNJmVw+
	2NOoFbMOOYLD64Lhk7vnnd4=
X-Google-Smtp-Source: ACHHUZ6qG1idJ2O7UgoWyYbjpCSXBR45NxYin/Dn4+gmDyeMhQk73oR9G15oR/DOiExP05bys5duZA==
X-Received: by 2002:a17:902:c944:b0:1b0:6038:2982 with SMTP id i4-20020a170902c94400b001b060382982mr11556994pla.41.1687908828400;
        Tue, 27 Jun 2023 16:33:48 -0700 (PDT)
Received: from localhost ([98.97.117.85])
        by smtp.gmail.com with ESMTPSA id je4-20020a170903264400b001b679ec20f2sm6481935plb.31.2023.06.27.16.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:33:47 -0700 (PDT)
Date: Tue, 27 Jun 2023 16:33:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Network Development <netdev@vger.kernel.org>
Message-ID: <649b71daaa4fa_7afc420820@john.notmuch>
In-Reply-To: <ZJtpIpwRGhhRFk8P@google.com>
References: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com>
 <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org>
 <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com>
 <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
 <649b581ded8c1_75d8a208c@john.notmuch>
 <ZJtpIpwRGhhRFk8P@google.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stanislav Fomichev wrote:
> On 06/27, John Fastabend wrote:
> > Stanislav Fomichev wrote:
> > > On Mon, Jun 26, 2023 at 3:37=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Jun 26, 2023 at 2:36=E2=80=AFPM Stanislav Fomichev <sdf@g=
oogle.com> wrote:
> > > > >
> > > > > > >
> > > > > > > I'd think HW TX csum is actually simpler than dealing with =
time,
> > > > > > > will you change your mind if Stan posts Tx csum within a fe=
w days? :)
> > > >
> > > > Absolutely :) Happy to change my mind.
> > > >
> > > > > > > The set of offloads is barely changing, the lack of clarity=

> > > > > > > on what is needed seems overstated. IMHO AF_XDP is getting =
no use
> > > > > > > today, because everything remotely complex was stripped out=
 of
> > > > > > > the implementation to get it merged. Aren't we hand waving =
the
> > > > > > > complexity away simply because we don't want to deal with i=
t?
> > > > > > >
> > > > > > > These are the features today's devices support (rx/tx is a =
mirror):
> > > > > > >  - L4 csum
> > > > > > >  - segmentation
> > > > > > >  - time reporting
> > > > > > >
> > > > > > > Some may also support:
> > > > > > >  - forwarding md tagging
> > > > > > >  - Tx launch time
> > > > > > >  - no fcs
> > > > > > > Legacy / irrelevant:
> > > > > > >  - VLAN insertion
> > > > > >
> > > > > > Right, the goal of the series is to lay out the foundation to=
 support
> > > > > > AF_XDP offloads. I'm starting with tx timestamp because that'=
s more
> > > > > > pressing. But, as I mentioned in another thread, we do have o=
ther
> > > > > > users that want to adopt AF_XDP, but due to missing tx offloa=
ds, they
> > > > > > aren't able to.
> > > > > >
> > > > > > IMHO, with pre-tx/post-tx hooks, it's pretty easy to go from =
TX
> > > > > > timestamp to TX checksum offload, we don't need a lot:
> > > > > > - define another generic kfunc bpf_request_tx_csum(from, to)
> > > > > > - drivers implement it
> > > > > > - af_xdp users call this kfunc from devtx hook
> > > > > >
> > > > > > We seem to be arguing over start-with-my-specific-narrow-use-=
case vs
> > > > > > start-with-generic implementation, so maybe time for the offi=
ce hours?
> > > > > > I can try to present some cohesive plan of how we start with =
the framework
> > > > > > plus tx-timestamp and expand with tx-checksum/etc. There is a=
 lot of
> > > > > > commonality in these offloads, so I'm probably not communicat=
ing it
> > > > > > properly..
> > > > >
> > > > > Or, maybe a better suggestion: let me try to implement TX check=
sum
> > > > > kfunc in the v3 (to show how to build on top this series).
> > > > > Having code is better than doing slides :-D
> > > >
> > > > That would certainly help :)
> > > > What I got out of your lsfmmbpf talk is that timestamp is your
> > > > main and only use case. tx checksum for af_xdp is the other use c=
ase,
> > > > but it's not yours, so you sort-of use it as an extra justificati=
on
> > > > for timestamp. Hence my negative reaction to 'generality'.
> > > > I think we'll have better results in designing an api
> > > > when we look at these two use cases independently.
> > > > And implement them in patches solving specifically timestamp
> > > > with normal skb traffic and tx checksum for af_xdp as two indepen=
dent apis.
> > > > If it looks like we can extract a common framework out of them. G=
reat.
> > > > But trying to generalize before truly addressing both cases
> > > > is likely to cripple both apis.
> > > =

> > > I need timestamps for the af_xdp case and I don't really care about=
 skb :-(
> > > I brought skb into the picture mostly to cover John's cases.
> > > So maybe let's drop the skb case for now and focus on af_xdp?
> > > skb is convenient testing-wise though (with veth), but maybe I can
> > > somehow carve-out af_xdp skbs only out of it..
> > =

> > I'm ok if your drop my use case but I read above and I seem to have a=

> > slightly different opinion/approach in mind.
> > =

> > What I think would be the most straight-forward thing and most flexib=
le
> > is to create a <drvname>_devtx_submit_skb(<drivname>descriptor, sk_bu=
ff)
> > and <drvname>_devtx_submit_xdp(<drvname>descriptor, xdp_frame) and th=
en
> > corresponding calls for <drvname>_devtx_complete_{skb|xdp}() Then you=

> > don't spend any cycles building the metadata thing or have to even
> > worry about read kfuncs. The BPF program has read access to any
> > fields they need. And with the skb, xdp pointer we have the context
> > that created the descriptor and generate meaningful metrics.
> > =

> > I'm clearly sacrificing usability in some sense of a general user tha=
t
> > doesn't know about drivers, hardware and so on for performance,
> > flexibility and simplicity of implementation. In general I'm OK with
> > this. I have trouble understanding who the dev is that is coding at
> > this layer, but can't read kernel driver code or at least has a good
> > understanding of the hardware. We are deep in optimization and
> > performance world once we get to putting hooks in the driver we shoul=
d
> > expect a certain amount of understanding before we let folks just pla=
nt
> > hooks here. Its going to be very easy to cause all sort of damage
> > even if we go to the other extreme and make a unified interface and
> > push the complexity onto kernel devs to maintain. I really believe
> > folks writing AF_XDP code (for DPDK or otherwise) have a really good
> > handle on networking, hardware, and drivers. I also expect that
> > AF_XDP users will mostly be abstracted away from AF_XDP internals
> > by DPDK and other libs or applications. My $.02 is these will be
> > primarily middle box type application built for special purpose l2/l3=
/l4
> > firewalling, DDOS, etc and telco protocols. Rant off.
> > =

> > But I can admit <drvname>_devtx_submit_xdp(<drvname>descriptor, ...)
> > is a bit raw. For one its going to require an object file per
> > driver/hardware and maybe worse multiple objects per driver/hw to
> > deal with hw descriptor changes with features. My $.02 is we could
> > solve this with better attach time linking. Now you have to at
> > compile time know what you are going to attach to and how to parse
> > the descriptor. If we had attach time linking we could dynamically
> > link to the hardware specific code at link time. And then its up
> > to us here or others who really understand the hardware to write
> > a ice_read_ts, mlx_read_tx but that can all just be normal BPF code.
> > =

> > Also I hand waved through a step where at attach time we have
> > some way to say link the thing that is associated with the
> > driver I'm about to attach to. As a first step a loader could
> > do this.
> > =

> > Its maybe more core work and less wrangling drivers then and
> > it means kfuncs become just blocks of BPF that anyone can
> > write. The big win in my mind is I don't need to know now
> > what I want tomorrow because I should have access. Also we push
> > the complexity and maintenance out of driver/kernel and into
> > BPF libs and users. Then we don't have to touch BPF core just
> > to add new things.
> > =

> > Last bit that complicates things is I need a way to also write
> > allowed values into the descriptor. We don't have anything that
> > can do this now. So maybe kfuncs for the write tstamp flags and
> > friends?
> =

> And in this case, the kfuncs would be non-generic and look something
> like the following?
> =

>   bpf_devtx_<drvname>_request_timestamp(<drivname>descriptor, xdp_frame=
)

Yeah, for writing into the descriptor I couldn't think up anythign more
clever. Anyways we will want to JIT that into insns if we are touching
every pkt.

> =

> I feel like this can work, yeah. The interface is raw, but maybe
> you are both right in assuming that different nics will
> expose different capabilities and we shouldn't try to pretend
> there is some commonality. I'll try to explore that idea more with
> the tx-csum..

I think it should be handle at the next level up with BPF libraries
and at BPF community level by building abstractions on top of BPF
instead of trying to bury them into where they feel less natural
to me. A project like Tetragon, DPDK, ... would abstract these behind
their APIs and users writing a AF_XDP widget on top of these would
probably never need to know about it. Certainly we wont have end
users of Tetragon have to care about driver they are attaching to.

> =

> Worst case, userspace can do:
> =

> int bpf_devtx_request_timestamp(some-generic-prog-abstraction-to-pass-c=
tx)
> {
> #ifdef DEVICE_MLX5
>   return mlx5_request_timestamp(...);
> #elif DEVICE_VETH
>   return veth_request-timestamp(...);
> #else
>   ...
> #endif
> }

Yeah I think so and then carry a couple different object files
for the environment around. We do this already for some things.
Its not ideal but it works. I think a good end goal would be

 int bpf_devtx_request_timestamp(...)
 {
	set_ts =3D dlsym( dl_handle, request-timestamp);
	return set_ts(...) =

 }

Then we could at attach time take that dlsym and rewrite it.

> =

> One thing we should probably spend more time in this case is documentin=
g
> it all. Or maybe having some DEVTX_XXX macros for those kfunc definitio=
ns
> and hooks to make them discoverable.

More docs would be great for sure.

> =

> But yeah, I see the appeal. The only ugly part with this all is that
> my xdp_hw_metadata would not be portable at all :-/ But it might be
> a good place/reason to actually figure out how to do it :-)

Agree you lose portability at the low level BPF, but we could
get it back with BPF libs. I think its the basic tradeoff here
is I want to keep the interface raw as possible and push the
details into the BPF program/loader. So you lose the low level
portability, but I think we get a lot for it and can get it
back if a BPF community builds the libs and tooling to solve
the problem at the next layer up. My thinking is kernel dev
intuition is to solve it in the kernel, but we take on a lot
of complexity to do this when we could push it out to userspace
where its easier to manage versioning and the complexity.

> =

> > Anyways, my $.02.
> > =

> > =

> > =

> > > =

> > > Regarding timestamp vs checksum: timestamp is more pressing, but I =
do
> > =

> > One request would be to also include a driver that doesn't have
> > always on timestamps so some writer is needed. CSUM enabling
> > I'm interested to see what the signature looks like? On the
> > skb side we use the skb a fair amount to build the checksum
> > it seems so I guess AF_XDP needs to push down the csum_offset?
> > In the SKB case its less interesting I think becuase the
> > stack is already handling it.
> =

> I need access to your lab :-p

I can likely try to at least prototype for some nic.

> =

> Regarding the signature, csum_start + csum_offset maybe? As we have in
> skb?
> =

> Although, from a quick grepping, I see some of the drivers have only
> a fixed set of tx checksum configurations they support:
> =

> switch (skb->csum_offset) {
> case offsetof(struct tcphdr, check):
> 	tx_desc->flags |=3D DO_TCP_IP_TX_CSUM_AT_FIXED_OFFSET;
> 	break;
> default:
> 	/* sw fallback */
> }

Yeah because they might not want or no how to do other protocols.

> =

> So maybe that's another argument in favor of not doing a generic
> layer and just expose whatever HW has in a non-portable way...
> (otoh, still accepting csum_offset+start + doing that switch inside
> is probably an ok common interface)

That is what I was thinking.

> =

> > > have people around that want to use af_xdp but need multibuf + tx
> > > offloads, so I was hoping to at least have a path for more tx offlo=
ads
> > > after we're done with tx timestamp "offload"..
> > > =

> > > > It doesn't have to be only two use cases.
> > > > I completely agree with Kuba that:
> > > >  - L4 csum
> > > >  - segmentation
> > > >  - time reporting
> > > > are universal HW NIC features and we need to have an api
> > > > that exposes these features in programmable way to bpf progs in t=
he kernel
> > > > and through af_xdp to user space.
> > > > I mainly suggest addressing them one by one and look
> > > > for common code bits and api similarities later.
> > > =

> > > Ack, let me see if I can fit tx csum into the picture. I still feel=

> > > like we need these dev-bound tracing programs if we want to trigger=

> > > kfuncs safely, but maybe we can simplify further..
> > =

> > Its not clear to me how you get to a dev specific attach here
> > without complicating the hot path more. I think we need to
> > really be careful to not make hotpath more complex. Will
> > follow along for sure to see what gets created.
> =

> Agreed. I've yet to test it with some real HW (still in the process of
> trying to get back my lab configuration which was changed recently) :-(=


:( Another question would be is there a use case to have netdev
specific programs? That might drive the need to attach to a
specific netdev. I can't think of a use case off-hand I guess
Toke might have something in mind based on his reply earlier.=


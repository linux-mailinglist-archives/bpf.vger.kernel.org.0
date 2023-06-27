Return-Path: <bpf+bounces-3605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FD7406AF
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 00:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA41C1C20B5C
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 22:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F8019E48;
	Tue, 27 Jun 2023 22:56:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1792F24
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 22:56:39 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F626B6
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 15:56:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262cf62e9b4so3129844a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687906596; x=1690498596;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BppL4pIMzWeNGHHQE5K6cgnUj/DXAiBmZ2VECcdhSzc=;
        b=wvMLM9Lo2uxGk2neYzzM2/5ReZ+CDmN+sZOQqqRncTL5Hvh2bH/Mq3N5bg8nElHaUE
         jkaGPzQdDnMEiyWvnW5xzuLi1Xy2o0jip7uWzdjAUm6S5FF9wa5q5P8PPX87j6W7LLSt
         6/0+A5hD5t31hXwXePyrVhK5tMa4ZiO2zVKobVyHVn2GnBLk3TWpLUZVF2gzS4tZifR8
         FFlpJ7Ak31YNgJrvDUtbazfAAs3Y+Y6hggvix3MsFdG5DW6eeC7bakxVBoOiTMTq/YFJ
         EtXI1nFB4ZLA2ft5o9ApI15jmx4Dpc9Hpeget5PXpqYpE8STIcT5+cAut71Gaf7AoHk0
         Il4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687906596; x=1690498596;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BppL4pIMzWeNGHHQE5K6cgnUj/DXAiBmZ2VECcdhSzc=;
        b=cb/6YhgU/YSbkyIkSIB77GWNxJIRGrx4gQDdVFGztemkKisgf+Z5ugIdq2Hqu2gqMu
         3NFHHbNJ8NxfPuyvmQvZt12qyATXxteEg+wsAO1QDTFl0+weecGz5FUajNgPmwmxYQKj
         cnH5EVNHLlmp6lZPmrnfhpOSuNNVbGQjsr/MTYfjSExq/MruPHYSMZJy1+Kxde4FqxC+
         967uRJOhR5m3xNaAm8Q+k32eKekuR6Rg+s6EGx2SxqyuggTxKx4JijTmd29nQI35qfE0
         H49VYrGOGVkeM5nQZ8c2QsVua4TcxIXZiJHeA3nqIAwPgMH2deK8N5GgM4Mmx8KRIbGN
         8sJQ==
X-Gm-Message-State: AC+VfDy6h/gdYIkXASIADupNaDq42d+UHlQXnNXklzHOI+XFjzljxIdc
	WCWtY9EARhpLUHuZ/EXoauG/DUM=
X-Google-Smtp-Source: ACHHUZ6KNOaOQbyX4kd6/Ze6mcY8Sd9AHth7n239qiDEqC5j/OQQW9isTVPriZLAse36awNnY+E4Ns0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:ea92:b0:262:e5cb:6c12 with SMTP id
 h18-20020a17090aea9200b00262e5cb6c12mr1232513pjz.6.1687906596123; Tue, 27 Jun
 2023 15:56:36 -0700 (PDT)
Date: Tue, 27 Jun 2023 15:56:34 -0700
In-Reply-To: <649b581ded8c1_75d8a208c@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com> <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com> <649b581ded8c1_75d8a208c@john.notmuch>
Message-ID: <ZJtpIpwRGhhRFk8P@google.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
From: Stanislav Fomichev <sdf@google.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/27, John Fastabend wrote:
> Stanislav Fomichev wrote:
> > On Mon, Jun 26, 2023 at 3:37=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jun 26, 2023 at 2:36=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >
> > > > > >
> > > > > > I'd think HW TX csum is actually simpler than dealing with time=
,
> > > > > > will you change your mind if Stan posts Tx csum within a few da=
ys? :)
> > >
> > > Absolutely :) Happy to change my mind.
> > >
> > > > > > The set of offloads is barely changing, the lack of clarity
> > > > > > on what is needed seems overstated. IMHO AF_XDP is getting no u=
se
> > > > > > today, because everything remotely complex was stripped out of
> > > > > > the implementation to get it merged. Aren't we hand waving the
> > > > > > complexity away simply because we don't want to deal with it?
> > > > > >
> > > > > > These are the features today's devices support (rx/tx is a mirr=
or):
> > > > > >  - L4 csum
> > > > > >  - segmentation
> > > > > >  - time reporting
> > > > > >
> > > > > > Some may also support:
> > > > > >  - forwarding md tagging
> > > > > >  - Tx launch time
> > > > > >  - no fcs
> > > > > > Legacy / irrelevant:
> > > > > >  - VLAN insertion
> > > > >
> > > > > Right, the goal of the series is to lay out the foundation to sup=
port
> > > > > AF_XDP offloads. I'm starting with tx timestamp because that's mo=
re
> > > > > pressing. But, as I mentioned in another thread, we do have other
> > > > > users that want to adopt AF_XDP, but due to missing tx offloads, =
they
> > > > > aren't able to.
> > > > >
> > > > > IMHO, with pre-tx/post-tx hooks, it's pretty easy to go from TX
> > > > > timestamp to TX checksum offload, we don't need a lot:
> > > > > - define another generic kfunc bpf_request_tx_csum(from, to)
> > > > > - drivers implement it
> > > > > - af_xdp users call this kfunc from devtx hook
> > > > >
> > > > > We seem to be arguing over start-with-my-specific-narrow-use-case=
 vs
> > > > > start-with-generic implementation, so maybe time for the office h=
ours?
> > > > > I can try to present some cohesive plan of how we start with the =
framework
> > > > > plus tx-timestamp and expand with tx-checksum/etc. There is a lot=
 of
> > > > > commonality in these offloads, so I'm probably not communicating =
it
> > > > > properly..
> > > >
> > > > Or, maybe a better suggestion: let me try to implement TX checksum
> > > > kfunc in the v3 (to show how to build on top this series).
> > > > Having code is better than doing slides :-D
> > >
> > > That would certainly help :)
> > > What I got out of your lsfmmbpf talk is that timestamp is your
> > > main and only use case. tx checksum for af_xdp is the other use case,
> > > but it's not yours, so you sort-of use it as an extra justification
> > > for timestamp. Hence my negative reaction to 'generality'.
> > > I think we'll have better results in designing an api
> > > when we look at these two use cases independently.
> > > And implement them in patches solving specifically timestamp
> > > with normal skb traffic and tx checksum for af_xdp as two independent=
 apis.
> > > If it looks like we can extract a common framework out of them. Great=
.
> > > But trying to generalize before truly addressing both cases
> > > is likely to cripple both apis.
> >=20
> > I need timestamps for the af_xdp case and I don't really care about skb=
 :-(
> > I brought skb into the picture mostly to cover John's cases.
> > So maybe let's drop the skb case for now and focus on af_xdp?
> > skb is convenient testing-wise though (with veth), but maybe I can
> > somehow carve-out af_xdp skbs only out of it..
>=20
> I'm ok if your drop my use case but I read above and I seem to have a
> slightly different opinion/approach in mind.
>=20
> What I think would be the most straight-forward thing and most flexible
> is to create a <drvname>_devtx_submit_skb(<drivname>descriptor, sk_buff)
> and <drvname>_devtx_submit_xdp(<drvname>descriptor, xdp_frame) and then
> corresponding calls for <drvname>_devtx_complete_{skb|xdp}() Then you
> don't spend any cycles building the metadata thing or have to even
> worry about read kfuncs. The BPF program has read access to any
> fields they need. And with the skb, xdp pointer we have the context
> that created the descriptor and generate meaningful metrics.
>=20
> I'm clearly sacrificing usability in some sense of a general user that
> doesn't know about drivers, hardware and so on for performance,
> flexibility and simplicity of implementation. In general I'm OK with
> this. I have trouble understanding who the dev is that is coding at
> this layer, but can't read kernel driver code or at least has a good
> understanding of the hardware. We are deep in optimization and
> performance world once we get to putting hooks in the driver we should
> expect a certain amount of understanding before we let folks just plant
> hooks here. Its going to be very easy to cause all sort of damage
> even if we go to the other extreme and make a unified interface and
> push the complexity onto kernel devs to maintain. I really believe
> folks writing AF_XDP code (for DPDK or otherwise) have a really good
> handle on networking, hardware, and drivers. I also expect that
> AF_XDP users will mostly be abstracted away from AF_XDP internals
> by DPDK and other libs or applications. My $.02 is these will be
> primarily middle box type application built for special purpose l2/l3/l4
> firewalling, DDOS, etc and telco protocols. Rant off.
>=20
> But I can admit <drvname>_devtx_submit_xdp(<drvname>descriptor, ...)
> is a bit raw. For one its going to require an object file per
> driver/hardware and maybe worse multiple objects per driver/hw to
> deal with hw descriptor changes with features. My $.02 is we could
> solve this with better attach time linking. Now you have to at
> compile time know what you are going to attach to and how to parse
> the descriptor. If we had attach time linking we could dynamically
> link to the hardware specific code at link time. And then its up
> to us here or others who really understand the hardware to write
> a ice_read_ts, mlx_read_tx but that can all just be normal BPF code.
>=20
> Also I hand waved through a step where at attach time we have
> some way to say link the thing that is associated with the
> driver I'm about to attach to. As a first step a loader could
> do this.
>=20
> Its maybe more core work and less wrangling drivers then and
> it means kfuncs become just blocks of BPF that anyone can
> write. The big win in my mind is I don't need to know now
> what I want tomorrow because I should have access. Also we push
> the complexity and maintenance out of driver/kernel and into
> BPF libs and users. Then we don't have to touch BPF core just
> to add new things.
>=20
> Last bit that complicates things is I need a way to also write
> allowed values into the descriptor. We don't have anything that
> can do this now. So maybe kfuncs for the write tstamp flags and
> friends?

And in this case, the kfuncs would be non-generic and look something
like the following?

  bpf_devtx_<drvname>_request_timestamp(<drivname>descriptor, xdp_frame)

I feel like this can work, yeah. The interface is raw, but maybe
you are both right in assuming that different nics will
expose different capabilities and we shouldn't try to pretend
there is some commonality. I'll try to explore that idea more with
the tx-csum..

Worst case, userspace can do:

int bpf_devtx_request_timestamp(some-generic-prog-abstraction-to-pass-ctx)
{
#ifdef DEVICE_MLX5
  return mlx5_request_timestamp(...);
#elif DEVICE_VETH
  return veth_request-timestamp(...);
#else
  ...
#endif
}

One thing we should probably spend more time in this case is documenting
it all. Or maybe having some DEVTX_XXX macros for those kfunc definitions
and hooks to make them discoverable.

But yeah, I see the appeal. The only ugly part with this all is that
my xdp_hw_metadata would not be portable at all :-/ But it might be
a good place/reason to actually figure out how to do it :-)

> Anyways, my $.02.
>=20
>=20
>=20
> >=20
> > Regarding timestamp vs checksum: timestamp is more pressing, but I do
>=20
> One request would be to also include a driver that doesn't have
> always on timestamps so some writer is needed. CSUM enabling
> I'm interested to see what the signature looks like? On the
> skb side we use the skb a fair amount to build the checksum
> it seems so I guess AF_XDP needs to push down the csum_offset?
> In the SKB case its less interesting I think becuase the
> stack is already handling it.

I need access to your lab :-p

Regarding the signature, csum_start + csum_offset maybe? As we have in
skb?

Although, from a quick grepping, I see some of the drivers have only
a fixed set of tx checksum configurations they support:

switch (skb->csum_offset) {
case offsetof(struct tcphdr, check):
	tx_desc->flags |=3D DO_TCP_IP_TX_CSUM_AT_FIXED_OFFSET;
	break;
default:
	/* sw fallback */
}

So maybe that's another argument in favor of not doing a generic
layer and just expose whatever HW has in a non-portable way...
(otoh, still accepting csum_offset+start + doing that switch inside
is probably an ok common interface)

> > have people around that want to use af_xdp but need multibuf + tx
> > offloads, so I was hoping to at least have a path for more tx offloads
> > after we're done with tx timestamp "offload"..
> >=20
> > > It doesn't have to be only two use cases.
> > > I completely agree with Kuba that:
> > >  - L4 csum
> > >  - segmentation
> > >  - time reporting
> > > are universal HW NIC features and we need to have an api
> > > that exposes these features in programmable way to bpf progs in the k=
ernel
> > > and through af_xdp to user space.
> > > I mainly suggest addressing them one by one and look
> > > for common code bits and api similarities later.
> >=20
> > Ack, let me see if I can fit tx csum into the picture. I still feel
> > like we need these dev-bound tracing programs if we want to trigger
> > kfuncs safely, but maybe we can simplify further..
>=20
> Its not clear to me how you get to a dev specific attach here
> without complicating the hot path more. I think we need to
> really be careful to not make hotpath more complex. Will
> follow along for sure to see what gets created.

Agreed. I've yet to test it with some real HW (still in the process of
trying to get back my lab configuration which was changed recently) :-(


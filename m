Return-Path: <bpf+bounces-3028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4849673868F
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193751C20E73
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57118C08;
	Wed, 21 Jun 2023 14:15:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2717747;
	Wed, 21 Jun 2023 14:15:47 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7419B1;
	Wed, 21 Jun 2023 07:15:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39c76b2917bso640540b6e.0;
        Wed, 21 Jun 2023 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687356944; x=1689948944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4rDM3L3FEB7oBxxF85Oa85f5rmwrdYzMXTHUF4/rM=;
        b=PYSIKJibXrzYqNOp7wZ5Z8zZgaC8wrVly24klk5pXGjRYBxX0VShEiLWDHBO9/epyT
         nVXXPGpyj9gTtK3pRovVbjFTdAZaEWXm8v6Ui00J+xbkd63QX95NOekK71qQdXwmM4co
         3UuEcf1QDLHZIDZ5AaIIsRQIR/MmuLIbxwx557jP5aOsV3l95pA1yFWE/X4cbEyovuR3
         zzpPu00hHrvkx5rkFaXQMKrXt67c/wUAnDeRtbzq+A8faed5brJqg7P1bMAWyUrgJTvc
         PWAlKgcNmC2xuYg1zf0z71VUMivDW2a7JCHYFj/tO7w991kJF/pp64vaVAZpQlU5yG4V
         KbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356944; x=1689948944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX4rDM3L3FEB7oBxxF85Oa85f5rmwrdYzMXTHUF4/rM=;
        b=gGMdlW4FpSCV1Gd1sXA1xi9NwFc6+znmHeeMmQmCQgjCTnJKQNAHrleJK6RBJqgKT9
         Osm9GS6WF7ztFTabLD+wVrXw9/ClL8wthOw9q6QsoFgJzxfwi0hS/rL99EjPkP2a2Y0n
         HtpOqxz/Y07IASCtfkuAYsXZilevvjc2PW8vRzraLcRFScAgJ4EIq2TjQjsTw4Hvc3Ia
         TNaT/NBuCs4f4Lm2N7Je/05Bc5FkQjzlUnx5MxDFJ4weja/HIjBB3YPNoNg2pke2sfRT
         pjUefEtQ3qiTYVODzeehJ1dqY9DDepRRhB5DMq+YQkGmn0tl1hiv0hXnmOhgWjz+E/Ll
         go1Q==
X-Gm-Message-State: AC+VfDxMoHq3gc6AyesJQARiqmDhsy+h/Gc7VlrT1X3igSmmc4pXjFpE
	XI9t9R+tnlo/FtCtsdAv4JuxZIgsGx8tKAaJiG8=
X-Google-Smtp-Source: ACHHUZ7mrMrnNQ5GineJw6/LGw5qi24+/RNnuSOOb9IzI58z4CXvdWeWgu6Nhl+ZLSf6vix2WR8HCNHRAs3E0MS0Cpc=
X-Received: by 2002:aca:f208:0:b0:39c:8216:e648 with SMTP id
 q8-20020acaf208000000b0039c8216e648mr10049514oih.1.1687356943796; Wed, 21 Jun
 2023 07:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com> <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com> <87o7l9c58j.fsf@toke.dk>
In-Reply-To: <87o7l9c58j.fsf@toke.dk>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 21 Jun 2023 16:15:32 +0200
Message-ID: <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com, 
	simon.horman@corigine.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 21 Jun 2023 at 15:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>
> > On Tue, 20 Jun 2023 at 19:34, Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
> >>
> >> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> >>
> >> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >> >
> >> > Add AF_XDP multi-buffer support documentation including two
> >> > pseudo-code samples.
> >> >
> >> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> >> > ---
> >> >  Documentation/networking/af_xdp.rst | 177 +++++++++++++++++++++++++=
+++
> >> >  1 file changed, 177 insertions(+)
> >> >
> >> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/net=
working/af_xdp.rst
> >> > index 247c6c4127e9..2b583f58967b 100644
> >> > --- a/Documentation/networking/af_xdp.rst
> >> > +++ b/Documentation/networking/af_xdp.rst
> >> > @@ -453,6 +453,93 @@ XDP_OPTIONS getsockopt
> >> >  Gets options from an XDP socket. The only one supported so far is
> >> >  XDP_OPTIONS_ZEROCOPY which tells you if zero-copy is on or not.
> >> >
> >> > +Multi-Buffer Support
> >> > +--------------------
> >> > +
> >> > +With multi-buffer support, programs using AF_XDP sockets can receiv=
e
> >> > +and transmit packets consisting of multiple buffers both in copy an=
d
> >> > +zero-copy mode. For example, a packet can consist of two
> >> > +frames/buffers, one with the header and the other one with the data=
,
> >> > +or a 9K Ethernet jumbo frame can be constructed by chaining togethe=
r
> >> > +three 4K frames.
> >> > +
> >> > +Some definitions:
> >> > +
> >> > +* A packet consists of one or more frames
> >> > +
> >> > +* A descriptor in one of the AF_XDP rings always refers to a single
> >> > +  frame. In the case the packet consists of a single frame, the
> >> > +  descriptor refers to the whole packet.
> >> > +
> >> > +To enable multi-buffer support for an AF_XDP socket, use the new bi=
nd
> >> > +flag XDP_USE_SG. If this is not provided, all multi-buffer packets
> >> > +will be dropped just as before. Note that the XDP program loaded al=
so
> >> > +needs to be in multi-buffer mode. This can be accomplished by using
> >> > +"xdp.frags" as the section name of the XDP program used.
> >> > +
> >> > +To represent a packet consisting of multiple frames, a new flag cal=
led
> >> > +XDP_PKT_CONTD is introduced in the options field of the Rx and Tx
> >> > +descriptors. If it is true (1) the packet continues with the next
> >> > +descriptor and if it is false (0) it means this is the last descrip=
tor
> >> > +of the packet. Why the reverse logic of end-of-packet (eop) flag fo=
und
> >> > +in many NICs? Just to preserve compatibility with non-multi-buffer
> >> > +applications that have this bit set to false for all packets on Rx,
> >> > +and the apps set the options field to zero for Tx, as anything else
> >> > +will be treated as an invalid descriptor.
> >> > +
> >> > +These are the semantics for producing packets onto AF_XDP Tx ring
> >> > +consisting of multiple frames:
> >> > +
> >> > +* When an invalid descriptor is found, all the other
> >> > +  descriptors/frames of this packet are marked as invalid and not
> >> > +  completed. The next descriptor is treated as the start of a new
> >> > +  packet, even if this was not the intent (because we cannot guess
> >> > +  the intent). As before, if your program is producing invalid
> >> > +  descriptors you have a bug that must be fixed.
> >> > +
> >> > +* Zero length descriptors are treated as invalid descriptors.
> >> > +
> >> > +* For copy mode, the maximum supported number of frames in a packet=
 is
> >> > +  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
> >> > +  descriptors accumulated so far are dropped and treated as
> >> > +  invalid. To produce an application that will work on any system
> >> > +  regardless of this config setting, limit the number of frags to 1=
8,
> >> > +  as the minimum value of the config is 17.
> >> > +
> >> > +* For zero-copy mode, the limit is up to what the NIC HW
> >> > +  supports. Usually at least five on the NICs we have checked. We
> >> > +  consciously chose to not enforce a rigid limit (such as
> >> > +  CONFIG_MAX_SKB_FRAGS + 1) for zero-copy mode, as it would have
> >> > +  resulted in copy actions under the hood to fit into what limit
> >> > +  the NIC supports. Kind of defeats the purpose of zero-copy mode.
> >>
> >> How is an application supposed to discover the actual limit for a give=
n
> >> NIC/driver?
> >
> > Thanks for your comments Toke. I will add an example here of how to
> > discover this. Basically you can send a packet with N frags (N =3D 2 to
> > start with), check the error stats through the getsockopt. If no
> > invalid_tx_desc error, increase N with one and send this new packet.
> > If you get an error, then the max number of frags is N-1.
>
> Hmm, okay, that sounds pretty tedious :P

Indeed if you had to do it manually ;-). Do not think this max is
important though, see next answer.

> Also, it has side effects (you'll be putting frames on the wire while
> testing, right?), so I guess this is not something you'll do on every
> startup of your application? What are you expecting app developers to do
> here in practice? Run the test while developing and expect the value to
> stay constant for a given driver (does it?), or? Or will most people in
> practice only need a few frags to get up to 9k MTU?

I believe that the question that a developer wants to answer is not
"max number of frags" supported, but "is 3 or 5 frags" supported. This
corresponds to 4K and 2K chunks used to send a 9K MTU. My guess is
that any driver that reports that it supports XDP multibuffer will
support at least 5 frags too. (Just note that I have not checked
around if there are NICs that only support up to 3 frags which would
mean that 4K chunks would have to be used.) This value will not change
for a NIC and the question is if there are XDP MB enabled NIC drivers
that do not support 5 frags? If not, then 5 is the lower bound for the
max number of frags in zc mode, at least for the current set of XDP MB
enabled drivers.

If an application would like to try if 3 or 5 frags (or any other
value) is supported by a NIC when the app is launched, then we would
need to try to send something as you say. I wonder if there is a way
to transmit a frame that does not reach the wire? What happens if I
send a frame with all zeroes, MAC addresses and the like? Will it
reach the wire? Another option would be to just send something you
really would like to send and if it does not complete and/or you get
an error in the getsockopt() stats call, you know that this amount of
frags is not supported and you need to try it again with less frags or
fallback to copy mode.

I do think there will be applications that require more than 5 frags.
I just do not know what they are due to a lack of imagination on my
part. They could use the algorithm from above, or just try the number
of frags they need depending on the flexibility of the code. A
fallback to copy-mode is always possible when the supported number of
frags is not there in the NIC HW.

> >> > +* The ZC batch API guarantees that it will provide a batch of Tx
> >> > +  descriptors that ends with full packet at the end. If not, ZC
> >> > +  drivers would have to gather the full packet on their side. The
> >> > +  approach we picked makes ZC drivers' life much easier (at least o=
n
> >> > +  Tx side).
> >>
> >> This seems like it implies some constraint on how an application can u=
se
> >> the APIs, but it's not quite clear to me what those constraints are, n=
or
> >> what happens if an application does something different. This should
> >> probably be spelled out...
> >>
> >> > +On the Rx path in copy-mode, the xsk core copies the XDP data into
> >> > +multiple descriptors, if needed, and sets the XDP_PKT_CONTD flag as
> >> > +detailed before. Zero-copy mode works the same, though the data is =
not
> >> > +copied. When the application gets a descriptor with the XDP_PKT_CON=
TD
> >> > +flag set to one, it means that the packet consists of multiple buff=
ers
> >> > +and it continues with the next buffer in the following
> >> > +descriptor. When a descriptor with XDP_PKT_CONTD =3D=3D 0 is receiv=
ed, it
> >> > +means that this is the last buffer of the packet. AF_XDP guarantees
> >> > +that only a complete packet (all frames in the packet) is sent to t=
he
> >> > +application.
> >>
> >> In light of the comment on batch size below, I think it would be usefu=
l
> >> to spell out what this means exactly. IIUC correctly, it means that th=
e
> >> kernel will check the ringbuffer before starting to copy the data, and
> >> if there are not enough descriptors available, it will drop the packet
> >> instead of doing a partial copy, right? And this is the case for both =
ZC
> >> and copy mode?
> >
> > I will make this paragraph and the previous one clearer. And yes, copy
> > mode and zc mode have the same behaviour.
>
> Alright, great!
>
> -Toke
>


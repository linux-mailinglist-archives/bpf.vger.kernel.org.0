Return-Path: <bpf+bounces-3023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F76738575
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50B8281667
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B218004;
	Wed, 21 Jun 2023 13:31:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178D17ACE
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 13:31:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B8198D
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687354241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIp8iVbV+P5Dx+n5TxKVDlGyBK7fZsapXNE0EAOF2Qs=;
	b=Ne2Wm9AbQWSsULkrmu9JffbnBTvkZLL7RYR5ELxy0TGNzTH9Laktk+rP+0edl6y4Hc1Rn7
	VZYjFiCzB9na39nDEdIIw8mpHu0tisJ+wYuQLfGV2xRex+utrRIv+sELp3F5cWs9zHq0Og
	x5JhVx+YEpN+/N5WghzSzMekD98vEM4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-swGAtt6nPOaTXHZp3zsDrA-1; Wed, 21 Jun 2023 09:30:40 -0400
X-MC-Unique: swGAtt6nPOaTXHZp3zsDrA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b46e0e096aso32356161fa.1
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 06:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354238; x=1689946238;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIp8iVbV+P5Dx+n5TxKVDlGyBK7fZsapXNE0EAOF2Qs=;
        b=eVcopbEx7O40bxAeQHDsRUPze5ROi/tGOKPRNhUGbX5iFAEhKVvYdD8FrjQV8SNwKA
         0qESPotSR1b2ZYBwF+sFv6avdR/gIWqFMZUtIb/6nwOrYU8OKBOTwO7EUHGtFYYuzrK1
         rAkt7JYNX4P5O4LSeBuC6JKHyEUverGX7520v5J8il7A0s70G6iK33otogdbSKJ9yDC8
         KuJZRSNj6dV25XzkWYDZoRMUQrgpUQ3IuUD/u2tcC2xtILQTkNSvitSOEa8hy0PwT2dr
         ZXmlz6F7dwP1P34yxo27JqTb1OiVV/UvONhkojBwrXJpuRXVJ5WvYqsoF305Mk7DgNde
         BF8Q==
X-Gm-Message-State: AC+VfDx8akyprrv2JN3ZntZOm2oeV6EpfcS0bhGEJrlAMU+heJOmi7i2
	O/Y8rtc3VJP+qqxUaXLnhhm8FgaveOM+CPDW0tKi75IEtkG1r+zCx0stz/NqxbfxOcVtHyaKgAR
	YltUJTTOFXAtc
X-Received: by 2002:a2e:9217:0:b0:2b4:48de:b2cb with SMTP id k23-20020a2e9217000000b002b448deb2cbmr9355981ljg.50.1687354238059;
        Wed, 21 Jun 2023 06:30:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pDrW0Sog/gf+Q2hMpBSFt0vaGNQ9bb94RQpS0m7tMAHO9YrCXCKt6N5NdCqC389eEbUbOow==
X-Received: by 2002:a2e:9217:0:b0:2b4:48de:b2cb with SMTP id k23-20020a2e9217000000b002b448deb2cbmr9355964ljg.50.1687354237523;
        Wed, 21 Jun 2023 06:30:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hk12-20020a170906c9cc00b009659ad1072fsm3149754ejb.113.2023.06.21.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:30:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8371ABBF240; Wed, 21 Jun 2023 15:30:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 tirthendu.sarkar@intel.com, simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 21 Jun 2023 15:30:36 +0200
Message-ID: <87o7l9c58j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Tue, 20 Jun 2023 at 19:34, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>>
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>
>> > From: Magnus Karlsson <magnus.karlsson@intel.com>
>> >
>> > Add AF_XDP multi-buffer support documentation including two
>> > pseudo-code samples.
>> >
>> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>> > ---
>> >  Documentation/networking/af_xdp.rst | 177 ++++++++++++++++++++++++++++
>> >  1 file changed, 177 insertions(+)
>> >
>> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/netwo=
rking/af_xdp.rst
>> > index 247c6c4127e9..2b583f58967b 100644
>> > --- a/Documentation/networking/af_xdp.rst
>> > +++ b/Documentation/networking/af_xdp.rst
>> > @@ -453,6 +453,93 @@ XDP_OPTIONS getsockopt
>> >  Gets options from an XDP socket. The only one supported so far is
>> >  XDP_OPTIONS_ZEROCOPY which tells you if zero-copy is on or not.
>> >
>> > +Multi-Buffer Support
>> > +--------------------
>> > +
>> > +With multi-buffer support, programs using AF_XDP sockets can receive
>> > +and transmit packets consisting of multiple buffers both in copy and
>> > +zero-copy mode. For example, a packet can consist of two
>> > +frames/buffers, one with the header and the other one with the data,
>> > +or a 9K Ethernet jumbo frame can be constructed by chaining together
>> > +three 4K frames.
>> > +
>> > +Some definitions:
>> > +
>> > +* A packet consists of one or more frames
>> > +
>> > +* A descriptor in one of the AF_XDP rings always refers to a single
>> > +  frame. In the case the packet consists of a single frame, the
>> > +  descriptor refers to the whole packet.
>> > +
>> > +To enable multi-buffer support for an AF_XDP socket, use the new bind
>> > +flag XDP_USE_SG. If this is not provided, all multi-buffer packets
>> > +will be dropped just as before. Note that the XDP program loaded also
>> > +needs to be in multi-buffer mode. This can be accomplished by using
>> > +"xdp.frags" as the section name of the XDP program used.
>> > +
>> > +To represent a packet consisting of multiple frames, a new flag called
>> > +XDP_PKT_CONTD is introduced in the options field of the Rx and Tx
>> > +descriptors. If it is true (1) the packet continues with the next
>> > +descriptor and if it is false (0) it means this is the last descriptor
>> > +of the packet. Why the reverse logic of end-of-packet (eop) flag found
>> > +in many NICs? Just to preserve compatibility with non-multi-buffer
>> > +applications that have this bit set to false for all packets on Rx,
>> > +and the apps set the options field to zero for Tx, as anything else
>> > +will be treated as an invalid descriptor.
>> > +
>> > +These are the semantics for producing packets onto AF_XDP Tx ring
>> > +consisting of multiple frames:
>> > +
>> > +* When an invalid descriptor is found, all the other
>> > +  descriptors/frames of this packet are marked as invalid and not
>> > +  completed. The next descriptor is treated as the start of a new
>> > +  packet, even if this was not the intent (because we cannot guess
>> > +  the intent). As before, if your program is producing invalid
>> > +  descriptors you have a bug that must be fixed.
>> > +
>> > +* Zero length descriptors are treated as invalid descriptors.
>> > +
>> > +* For copy mode, the maximum supported number of frames in a packet is
>> > +  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
>> > +  descriptors accumulated so far are dropped and treated as
>> > +  invalid. To produce an application that will work on any system
>> > +  regardless of this config setting, limit the number of frags to 18,
>> > +  as the minimum value of the config is 17.
>> > +
>> > +* For zero-copy mode, the limit is up to what the NIC HW
>> > +  supports. Usually at least five on the NICs we have checked. We
>> > +  consciously chose to not enforce a rigid limit (such as
>> > +  CONFIG_MAX_SKB_FRAGS + 1) for zero-copy mode, as it would have
>> > +  resulted in copy actions under the hood to fit into what limit
>> > +  the NIC supports. Kind of defeats the purpose of zero-copy mode.
>>
>> How is an application supposed to discover the actual limit for a given
>> NIC/driver?
>
> Thanks for your comments Toke. I will add an example here of how to
> discover this. Basically you can send a packet with N frags (N =3D 2 to
> start with), check the error stats through the getsockopt. If no
> invalid_tx_desc error, increase N with one and send this new packet.
> If you get an error, then the max number of frags is N-1.

Hmm, okay, that sounds pretty tedious :P

Also, it has side effects (you'll be putting frames on the wire while
testing, right?), so I guess this is not something you'll do on every
startup of your application? What are you expecting app developers to do
here in practice? Run the test while developing and expect the value to
stay constant for a given driver (does it?), or? Or will most people in
practice only need a few frags to get up to 9k MTU?

>> > +* The ZC batch API guarantees that it will provide a batch of Tx
>> > +  descriptors that ends with full packet at the end. If not, ZC
>> > +  drivers would have to gather the full packet on their side. The
>> > +  approach we picked makes ZC drivers' life much easier (at least on
>> > +  Tx side).
>>
>> This seems like it implies some constraint on how an application can use
>> the APIs, but it's not quite clear to me what those constraints are, nor
>> what happens if an application does something different. This should
>> probably be spelled out...
>>
>> > +On the Rx path in copy-mode, the xsk core copies the XDP data into
>> > +multiple descriptors, if needed, and sets the XDP_PKT_CONTD flag as
>> > +detailed before. Zero-copy mode works the same, though the data is not
>> > +copied. When the application gets a descriptor with the XDP_PKT_CONTD
>> > +flag set to one, it means that the packet consists of multiple buffers
>> > +and it continues with the next buffer in the following
>> > +descriptor. When a descriptor with XDP_PKT_CONTD =3D=3D 0 is received=
, it
>> > +means that this is the last buffer of the packet. AF_XDP guarantees
>> > +that only a complete packet (all frames in the packet) is sent to the
>> > +application.
>>
>> In light of the comment on batch size below, I think it would be useful
>> to spell out what this means exactly. IIUC correctly, it means that the
>> kernel will check the ringbuffer before starting to copy the data, and
>> if there are not enough descriptors available, it will drop the packet
>> instead of doing a partial copy, right? And this is the case for both ZC
>> and copy mode?
>
> I will make this paragraph and the previous one clearer. And yes, copy
> mode and zc mode have the same behaviour.

Alright, great!

-Toke



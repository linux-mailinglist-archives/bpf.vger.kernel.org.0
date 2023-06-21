Return-Path: <bpf+bounces-2983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C43737CB1
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643E91C20D87
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9CC2EE;
	Wed, 21 Jun 2023 08:06:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF32AB55;
	Wed, 21 Jun 2023 08:06:21 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45519AF;
	Wed, 21 Jun 2023 01:06:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-62eeafc0c14so10522216d6.1;
        Wed, 21 Jun 2023 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687334771; x=1689926771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWd+0GOHlWdYgM6e9AF1bG/a1Ry3VWLc+87uu1Jeh9Y=;
        b=OJ3PG1VTeTH8n9nFuI7JdzxSo52SxIbQt+hZk84eudUoyyDzClj7ST+W5YZyku8ZtL
         tOver63AnhuuMRBpHVrzPKqjFicig5lFIFjgIU2fKWSc+Wp9nYoiK6y3sHw4BMtIGusM
         v7Q5eXVL6RE9XuB/zm9VGy6AACNKbj9jzUUSDnRXivuBV1d1znfJ5RCR4cwK/VqFdrn+
         L3R74TiKt6N73Tr6cgTPV9vjzAaj1ZeNcXgsd5jT3AqwO7mCWr0KQmUlJE9/Y68LNUce
         g4i2+LKBGiX0RxVBTb99pu2ocIp4F/Rpcvt5AsV8sJnSqAQs+Ynq+21VKRh07BHUGSOY
         yxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334771; x=1689926771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWd+0GOHlWdYgM6e9AF1bG/a1Ry3VWLc+87uu1Jeh9Y=;
        b=aPJVi+hZkRYR1zjTyXbgd+uVHkMGGcYvp3+Z62yaznJgvOzG/b1jGAdcmAwnCFz6j+
         9THwx+DBAYtzbrMFhCL/MMKDc9NdzXW/4ZlAURqmu3EtgwPe53WFpmP7GnnPVx8kdGYp
         zSabO0XeFXSNoMr9V4M/yInZIJ9p0QABkdyY2zuO78bmQYg6ea0K7WoXZiAoqHlmoI6+
         XDSGkrrmpUmxa93WwyMB6EIh+2dwupqTB+uZ5XqAEtHWKEa1jd4+4YYYSGjqU6CcZvxA
         Ygi4AsbWUIiI3tdyreyB3WgRmk1sUhBzbAg7PQHpM5C367qzzZB7/r+Fx2IqFr2dZpiI
         lkEA==
X-Gm-Message-State: AC+VfDy2G4wrTuc2RecXvj7cXzqsa5pi3AXOEfpHpu4yRjL8+4M78nIo
	SWdBqzLojFb2NZJ/b6M+OVjzJP/6de9lFdl0s60=
X-Google-Smtp-Source: ACHHUZ4B71qrF3sf2dnbRET9UFSJKnVQrujBq3fvDKkfgyj+vgMgzWexi9pbTzfAIyyPJxQZFjOwIoQOWxjllVU7VPU=
X-Received: by 2002:a05:6214:401a:b0:62b:5410:322d with SMTP id
 kd26-20020a056214401a00b0062b5410322dmr18790621qvb.6.1687334771540; Wed, 21
 Jun 2023 01:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com> <87zg4uca21.fsf@toke.dk>
In-Reply-To: <87zg4uca21.fsf@toke.dk>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 21 Jun 2023 10:06:00 +0200
Message-ID: <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
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

On Tue, 20 Jun 2023 at 19:34, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel=
.org> wrote:
>
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Add AF_XDP multi-buffer support documentation including two
> > pseudo-code samples.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  Documentation/networking/af_xdp.rst | 177 ++++++++++++++++++++++++++++
> >  1 file changed, 177 insertions(+)
> >
> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networ=
king/af_xdp.rst
> > index 247c6c4127e9..2b583f58967b 100644
> > --- a/Documentation/networking/af_xdp.rst
> > +++ b/Documentation/networking/af_xdp.rst
> > @@ -453,6 +453,93 @@ XDP_OPTIONS getsockopt
> >  Gets options from an XDP socket. The only one supported so far is
> >  XDP_OPTIONS_ZEROCOPY which tells you if zero-copy is on or not.
> >
> > +Multi-Buffer Support
> > +--------------------
> > +
> > +With multi-buffer support, programs using AF_XDP sockets can receive
> > +and transmit packets consisting of multiple buffers both in copy and
> > +zero-copy mode. For example, a packet can consist of two
> > +frames/buffers, one with the header and the other one with the data,
> > +or a 9K Ethernet jumbo frame can be constructed by chaining together
> > +three 4K frames.
> > +
> > +Some definitions:
> > +
> > +* A packet consists of one or more frames
> > +
> > +* A descriptor in one of the AF_XDP rings always refers to a single
> > +  frame. In the case the packet consists of a single frame, the
> > +  descriptor refers to the whole packet.
> > +
> > +To enable multi-buffer support for an AF_XDP socket, use the new bind
> > +flag XDP_USE_SG. If this is not provided, all multi-buffer packets
> > +will be dropped just as before. Note that the XDP program loaded also
> > +needs to be in multi-buffer mode. This can be accomplished by using
> > +"xdp.frags" as the section name of the XDP program used.
> > +
> > +To represent a packet consisting of multiple frames, a new flag called
> > +XDP_PKT_CONTD is introduced in the options field of the Rx and Tx
> > +descriptors. If it is true (1) the packet continues with the next
> > +descriptor and if it is false (0) it means this is the last descriptor
> > +of the packet. Why the reverse logic of end-of-packet (eop) flag found
> > +in many NICs? Just to preserve compatibility with non-multi-buffer
> > +applications that have this bit set to false for all packets on Rx,
> > +and the apps set the options field to zero for Tx, as anything else
> > +will be treated as an invalid descriptor.
> > +
> > +These are the semantics for producing packets onto AF_XDP Tx ring
> > +consisting of multiple frames:
> > +
> > +* When an invalid descriptor is found, all the other
> > +  descriptors/frames of this packet are marked as invalid and not
> > +  completed. The next descriptor is treated as the start of a new
> > +  packet, even if this was not the intent (because we cannot guess
> > +  the intent). As before, if your program is producing invalid
> > +  descriptors you have a bug that must be fixed.
> > +
> > +* Zero length descriptors are treated as invalid descriptors.
> > +
> > +* For copy mode, the maximum supported number of frames in a packet is
> > +  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
> > +  descriptors accumulated so far are dropped and treated as
> > +  invalid. To produce an application that will work on any system
> > +  regardless of this config setting, limit the number of frags to 18,
> > +  as the minimum value of the config is 17.
> > +
> > +* For zero-copy mode, the limit is up to what the NIC HW
> > +  supports. Usually at least five on the NICs we have checked. We
> > +  consciously chose to not enforce a rigid limit (such as
> > +  CONFIG_MAX_SKB_FRAGS + 1) for zero-copy mode, as it would have
> > +  resulted in copy actions under the hood to fit into what limit
> > +  the NIC supports. Kind of defeats the purpose of zero-copy mode.
>
> How is an application supposed to discover the actual limit for a given
> NIC/driver?

Thanks for your comments Toke. I will add an example here of how to
discover this. Basically you can send a packet with N frags (N =3D 2 to
start with), check the error stats through the getsockopt. If no
invalid_tx_desc error, increase N with one and send this new packet.
If you get an error, then the max number of frags is N-1.

> > +* The ZC batch API guarantees that it will provide a batch of Tx
> > +  descriptors that ends with full packet at the end. If not, ZC
> > +  drivers would have to gather the full packet on their side. The
> > +  approach we picked makes ZC drivers' life much easier (at least on
> > +  Tx side).
>
> This seems like it implies some constraint on how an application can use
> the APIs, but it's not quite clear to me what those constraints are, nor
> what happens if an application does something different. This should
> probably be spelled out...
>
> > +On the Rx path in copy-mode, the xsk core copies the XDP data into
> > +multiple descriptors, if needed, and sets the XDP_PKT_CONTD flag as
> > +detailed before. Zero-copy mode works the same, though the data is not
> > +copied. When the application gets a descriptor with the XDP_PKT_CONTD
> > +flag set to one, it means that the packet consists of multiple buffers
> > +and it continues with the next buffer in the following
> > +descriptor. When a descriptor with XDP_PKT_CONTD =3D=3D 0 is received,=
 it
> > +means that this is the last buffer of the packet. AF_XDP guarantees
> > +that only a complete packet (all frames in the packet) is sent to the
> > +application.
>
> In light of the comment on batch size below, I think it would be useful
> to spell out what this means exactly. IIUC correctly, it means that the
> kernel will check the ringbuffer before starting to copy the data, and
> if there are not enough descriptors available, it will drop the packet
> instead of doing a partial copy, right? And this is the case for both ZC
> and copy mode?

I will make this paragraph and the previous one clearer. And yes, copy
mode and zc mode have the same behaviour.

> > +If application reads a batch of descriptors, using for example the lib=
xdp
> > +interfaces, it is not guaranteed that the batch will end with a full
> > +packet. It might end in the middle of a packet and the rest of the
> > +buffers of that packet will arrive at the beginning of the next batch,
> > +since the libxdp interface does not read the whole ring (unless you
> > +have an enormous batch size or a very small ring size).
> > +
> > +An example program each for Rx and Tx multi-buffer support can be foun=
d
> > +later in this document.
> > +
> >  Usage
> >  =3D=3D=3D=3D=3D
> >
> > @@ -532,6 +619,96 @@ like this:
> >  But please use the libbpf functions as they are optimized and ready to
> >  use. Will make your life easier.
> >
> > +Usage Multi-Buffer Rx
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Here is a simple Rx path pseudo-code example (using libxdp interfaces
> > +for simplicity). Error paths have been excluded to keep it short:
> > +
> > +.. code-block:: c
> > +
> > +    void rx_packets(struct xsk_socket_info *xsk)
> > +    {
> > +        static bool new_packet =3D true;
> > +        u32 idx_rx =3D 0, idx_fq =3D 0;
> > +        static char *pkt;
> > +
> > +        int rcvd =3D xsk_ring_cons__peek(&xsk->rx, opt_batch_size, &id=
x_rx);
> > +
> > +        xsk_ring_prod__reserve(&xsk->umem->fq, rcvd, &idx_fq);
> > +
> > +        for (int i =3D 0; i < rcvd; i++) {
> > +            struct xdp_desc *desc =3D xsk_ring_cons__rx_desc(&xsk->rx,=
 idx_rx++);
> > +            char *frag =3D xsk_umem__get_data(xsk->umem->buffer, desc-=
>addr);
> > +            bool eop =3D !(desc->options & XDP_PKT_CONTD);
> > +
> > +        if (new_packet)
> > +            pkt =3D frag;
> > +        else
> > +            add_frag_to_pkt(pkt, frag);
> > +
> > +        if (eop)
> > +            process_pkt(pkt);
> > +
> > +        new_packet =3D eop;
> > +
> > +        *xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) =3D desc->=
addr;
>
> Indentation is off here...

Will fix.

>
> -Toke
>


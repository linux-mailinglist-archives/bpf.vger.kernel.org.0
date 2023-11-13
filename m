Return-Path: <bpf+bounces-15008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E87EA19D
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5381C208D6
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E11224C9;
	Mon, 13 Nov 2023 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvRTT1j5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C022334
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 17:02:57 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBE173F
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 09:02:51 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af53bde4so65971377b3.0
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 09:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699894970; x=1700499770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAJhDBnKSX8hMywTnbhs2D/NpNn8H7rbhedPkq9pcUg=;
        b=BvRTT1j5XCFMVASLP/RQAgdSITod8DqLjDYV9mm52u4rnVplYyNZVOdqpnDunLG45n
         bfyqzN50sS0rlqAObD1t9cduOcoZtzEbQk5YRkFLGgToFzycR8Wh+SztV2nGQCB9prUv
         Ha7zeTpPgp83tuG3Q5yVhkcpwP6S0CEncoGT6s08PmrwMyerd0fBMGlhd2o+kYLm4V6H
         3f7qPJujy4bzl/jVcBBtmyGB1Q9a2pJe3y9kasQrMjTWcCutEEmnZtar3zsRbjUTg30M
         69kwK9RZ+oUUVxI1YZmyRVRieTD0z4o7q46t9dXAMgxtOmsdVOLHXXvsM598lO+xzd43
         nLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894970; x=1700499770;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PAJhDBnKSX8hMywTnbhs2D/NpNn8H7rbhedPkq9pcUg=;
        b=cbhKCJKlEwl+HZFZPcW7CjNcDsjv9Un+jli6nLbFjoCod2EKTzVMDsPuUUwnWx3pBO
         NzgkYeE3wdYMZcK9mwR3N6VAQDORAuqHip5v+djDywwqkgUoxsycvwSvHsyQPuwJrH+o
         mVWDEH6QnD8dg7+XqWtRHO7t4v3zyWMxdqDwG8+gcb1PJagmBNEcJhy2530uRwvdLWm3
         OQaqlcEHrqQT6Uz9EWxwPclBrM6jw0dHZZhAfOnYDZR2uclKZqgwwkSuFyHjPiVn8hd+
         brVIv5atL/NfpWWTpK2MIg5Qx9I9UCUxaUZDbGDve0h8hp9ou/rf7ocrs0/wMkjb8BlB
         E0GA==
X-Gm-Message-State: AOJu0YycvvNiANBSjaPexvnQFz2uFEHx06S4Lgy9sdA0jlqWDXIx60Gf
	1cBK4bgzLkjNnlG4VhAG0iIydJc=
X-Google-Smtp-Source: AGHT+IFZlJzNBRz95LZBqclb+YjjBicOGP4YIjHzDU2LitrspIlAvgFGBM0RoSZXrWON7epmyCoFpU4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:a9d:b0:5c1:47e1:fb45 with SMTP id
 ci29-20020a05690c0a9d00b005c147e1fb45mr172083ywb.0.1699894970352; Mon, 13 Nov
 2023 09:02:50 -0800 (PST)
Date: Mon, 13 Nov 2023 09:02:48 -0800
In-Reply-To: <2ed17b27-f211-4f58-95b5-5a71914264f3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <20231102225837.1141915-3-sdf@google.com>
 <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org> <CAKH8qBtiv8ArtbbMW9+c75y+NfkX-Tk-rcPuHBVdKDMmmFdtdA@mail.gmail.com>
 <2ed17b27-f211-4f58-95b5-5a71914264f3@kernel.org>
Message-ID: <ZVJWuB4qtWfC-W_h@google.com>
Subject: Re: [PATCH bpf-next v5 02/13] xsk: Add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/13, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 11/13/23 15:10, Stanislav Fomichev wrote:
> > On Mon, Nov 13, 2023 at 5:16=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> > >=20
> > >=20
> > > On 11/2/23 23:58, Stanislav Fomichev wrote:
> > > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xd=
p.h
> > > > index 2ecf79282c26..b0ee7ad19b51 100644
> > > > --- a/include/uapi/linux/if_xdp.h
> > > > +++ b/include/uapi/linux/if_xdp.h
> > > > @@ -106,6 +106,41 @@ struct xdp_options {
> > > >    #define XSK_UNALIGNED_BUF_ADDR_MASK \
> > > >        ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> > > >=20
> > > > +/* Request transmit timestamp. Upon completion, put it into tx_tim=
estamp
> > > > + * field of struct xsk_tx_metadata.
> > > > + */
> > > > +#define XDP_TXMD_FLAGS_TIMESTAMP             (1 << 0)
> > > > +
> > > > +/* Request transmit checksum offload. Checksum start position and =
offset
> > > > + * are communicated via csum_start and csum_offset fields of struc=
t
> > > > + * xsk_tx_metadata.
> > > > + */
> > > > +#define XDP_TXMD_FLAGS_CHECKSUM                      (1 << 1)
> > > > +
> > > > +/* AF_XDP offloads request. 'request' union member is consumed by =
the driver
> > > > + * when the packet is being transmitted. 'completion' union member=
 is
> > > > + * filled by the driver when the transmit completion arrives.
> > > > + */
> > > > +struct xsk_tx_metadata {
> > > > +     union {
> > > > +             struct {
> > > > +                     __u32 flags;
> > > > +
> > > > +                     /* XDP_TXMD_FLAGS_CHECKSUM */
> > > > +
> > > > +                     /* Offset from desc->addr where checksumming =
should start. */
> > > > +                     __u16 csum_start;
> > > > +                     /* Offset from csum_start where checksum shou=
ld be stored. */
> > > > +                     __u16 csum_offset;
> > > > +             } request;
> > > > +
> > > > +             struct {
> > > > +                     /* XDP_TXMD_FLAGS_TIMESTAMP */
> > > > +                     __u64 tx_timestamp;
> > > > +             } completion;
> > > > +     };
> > > > +};
> > >=20
> > > This looks wrong to me. It looks like member @flags is not avail at
> > > completion time.  At completion time, I assume we also want to know i=
f
> > > someone requested to get the timestamp for this packet (else we could
> > > read garbage).
> >=20
> > I've moved the parts that are preserved across tx and tx completion
> > into xsk_tx_metadata_compl.
> > This is to address Magnus/Maciej feedback where userspace might race
> > with the kernel.
> > See: https://lore.kernel.org/bpf/ZNoJenzKXW5QSR3E@boxer/
> >=20
>=20
> Does this mean that every driver have to extend their TX-desc ring with
> sizeof(struct xsk_tx_metadata_compl)?
> Won't this affect the performance of this V5?

Yes, but it doesn't have to be a descriptor. Might be some internal
driver completion queue (as in the case of mlx5). And definitely does
affect performance :-( (see all the static branches to disable it)
=20
>  $ pahole -C xsk_tx_metadata_compl
> ./drivers/net/ethernet/stmicro/stmmac/stmmac.ko
>  struct xsk_tx_metadata_compl {
> 	__u64 *              tx_timestamp;         /*     0     8 */
>=20
> 	/* size: 8, cachelines: 1, members: 1 */
> 	/* last cacheline: 8 bytes */
>  };
>=20
> Guess, I must be misunderstanding, as I was expecting to see the @flags
> member being preserved across, as I get the race there.
>
> Looking at stmmac driver, it does look like this xsk_tx_metadata_compl
> is part of the TX-ring for completion (tx_skbuff_dma) and the
> tx_timestamp data is getting stored here.  How is userspace AF_XDP
> application getting access to the tx_timestamp data?
> I though this was suppose to get stored in metadata data area (umem)?
>
> Also looking at the code, the kernel would not have a "crash" race on
> the flags member (if we preserve in struct), because the code checks the
> driver HW-TS config-state + TX-descriptor for the availability of a
> HW-TS in the descriptor.

xsk_tx_metadata_compl stores a pointer to the completion timestamp
in the umem, so everything still arrives via the metadata area.

We want to make sure the flags are not changing across tx and tx completion=
.
Instead of saving the flags, we just use that xsk_tx_metadata_compl to
signal to the completion that "I know that I've requested the tx
completion timestamp, please put it at this address in umem".

I store the pointer instead of flags to avoid doing pointer math again
at completion. But it's an implementation detail and somewhat abstracted
from the drivers (besides the fact that it's probably has to fit in 8
bytes).

> > > Another thing (I've raised this before): It would be really practical=
 to
> > > store an u64 opaque value at TX and then read it at Completion time.
> > > One use-case is a forwarding application storing HW RX-time and
> > > comparing this to TX completion time to deduce the time spend process=
ing
> > > the packet.
> >=20
> > This can be another member, right? But note that extending
> > xsk_tx_metadata_compl might be a bit complicated because drivers have
> > to carry this info somewhere. So we have to balance the amount of
> > passed data between the tx and the completion.
>=20
> I don't think my opaque value proposal is subject to same race problem.
> I think this can be stores in metadata area and across tx and tx
> completion, because any race on a flags change is the userspace
> programmers problem, as it cannot cause any kernel crash (given kernel
> have no need to read this).

Thinking about it, I don't think this needs any special handing?
You can request sizeof(struct xsk_tx_metadata) + sizeof(opaque data)
as metadata. The kernel won't touch the 'opaque data' part. Or am I missing
something?


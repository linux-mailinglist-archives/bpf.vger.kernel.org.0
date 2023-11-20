Return-Path: <bpf+bounces-15399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097AC7F1E23
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307771C216CF
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A5208D0;
	Mon, 20 Nov 2023 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXU4Xf0i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37ACD8
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 12:45:02 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b7fb057153so6907759a12.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700513102; x=1701117902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0+j8fQL1sJz92+chsBB43nsB2MtdrD3vnFCGs59vhU=;
        b=IXU4Xf0iscpIH2PIGHbG8gkanThOZrAirMSJHN8XLqmCjUouAC//ikxcgIR/weQvXf
         LNuvTK2kHfOVhmvx5aH6/CO4dsSv7rmljODHkBShSxFiLxsOHcWil6fiWLOAu9SmkmSo
         GFAW3bzdsOWEM3xJOzKK1OA7BBoDOn8TOLhIhpf4otwS+AHY/CMbro2eEJ5uNXOHwL2M
         QJUPqzvfFLP/Cag7OMwaETZdsW3v8AskJ3uYcRZ/nx7RMZW2s2B8zMZqXBvmvdnbkJTt
         7RPfepxTToeYqTOCDzRebZ+bpWus4Uak8Tdp/WcgbUfBszA1Uc7sbZqBjw+tr8OZ10Sz
         d09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700513102; x=1701117902;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q0+j8fQL1sJz92+chsBB43nsB2MtdrD3vnFCGs59vhU=;
        b=EjFraTG/AXyGczFd4GNOBtCRzCTFRg0tIVk26VB0dmtGDpN+/BDZ3plnYFA4a3BWQZ
         mRkL8H403zbKKhMG19iYMH3UMhGwxiDDzRcO9EUhI++TDfhrsdotYdMHlrCuZRd7ugHE
         c4gBbEk+SYJxZRNyKKMroUNKSXhDh4rUwo9h3pU03YT4mH4UR2icRRtLJvkT/OsTAN8T
         lO5W1iVeYLefxE21bdyOZWLP7bjW3t8v++fvbAL8dcz6IunnA8hJiZbQPomsdUPpW2rw
         1I97uRL7MlonTmt3lsVs0lehaeQcmL2f2yEO1y0ur+iN8NkRz1Nv39e6xZXVlyVaVBLW
         Yqag==
X-Gm-Message-State: AOJu0YyG82BJy7vEVC7BjJVss2Gh2zzsz0G0mvdPe8ZE72L1xx7u+u6F
	zQXwGeUjx9cBQryyKVMgX1R/BlE=
X-Google-Smtp-Source: AGHT+IFf16w/HlmsFcKaSkyBb7ftE+eaSs3vM0zSXLvq2PgaNAM02ekw9Tn4BBTkGGulNt//3vU2tnQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:6586:b0:283:9a71:457a with SMTP id
 k6-20020a17090a658600b002839a71457amr2258267pjj.6.1700513102471; Mon, 20 Nov
 2023 12:45:02 -0800 (PST)
Date: Mon, 20 Nov 2023 12:45:00 -0800
In-Reply-To: <a0dc04da-eb36-4824-b774-fd16f3f65875@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <20231102225837.1141915-3-sdf@google.com>
 <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org> <CAKH8qBtiv8ArtbbMW9+c75y+NfkX-Tk-rcPuHBVdKDMmmFdtdA@mail.gmail.com>
 <2ed17b27-f211-4f58-95b5-5a71914264f3@kernel.org> <ZVJWuB4qtWfC-W_h@google.com>
 <be6186c1-52ee-42aa-b53c-39781af3a1ec@kernel.org> <ZVTJpLoSCaLoBa67@google.com>
 <a0dc04da-eb36-4824-b774-fd16f3f65875@kernel.org>
Message-ID: <ZVvFTFD1k-aRc3rY@google.com>
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

On 11/16, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 11/15/23 14:37, Stanislav Fomichev wrote:
> > On 11/15, Jesper Dangaard Brouer wrote:
> > >=20
> > >=20
> > > On 11/13/23 18:02, Stanislav Fomichev wrote:
> > > > On 11/13, Jesper Dangaard Brouer wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/13/23 15:10, Stanislav Fomichev wrote:
> > > > > > On Mon, Nov 13, 2023 at 5:16=E2=80=AFAM Jesper Dangaard Brouer =
<hawk@kernel.org> wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 11/2/23 23:58, Stanislav Fomichev wrote:
> > > > > > > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/lin=
ux/if_xdp.h
> > > > > > > > index 2ecf79282c26..b0ee7ad19b51 100644
> > > > > > > > --- a/include/uapi/linux/if_xdp.h
> > > > > > > > +++ b/include/uapi/linux/if_xdp.h
> > > > > > > > @@ -106,6 +106,41 @@ struct xdp_options {
> > > > > > > >      #define XSK_UNALIGNED_BUF_ADDR_MASK \
> > > > > > > >          ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> > > > > > > >=20
> > > > > > > > +/* Request transmit timestamp. Upon completion, put it int=
o tx_timestamp
> > > > > > > > + * field of struct xsk_tx_metadata.
> > > > > > > > + */
> > > > > > > > +#define XDP_TXMD_FLAGS_TIMESTAMP             (1 << 0)
> > > > > > > > +
> > > > > > > > +/* Request transmit checksum offload. Checksum start posit=
ion and offset
> > > > > > > > + * are communicated via csum_start and csum_offset fields =
of struct
> > > > > > > > + * xsk_tx_metadata.
> > > > > > > > + */
> > > > > > > > +#define XDP_TXMD_FLAGS_CHECKSUM                      (1 <<=
 1)
> > > > > > > > +
> > > > > > > > +/* AF_XDP offloads request. 'request' union member is cons=
umed by the driver
> > > > > > > > + * when the packet is being transmitted. 'completion' unio=
n member is
> > > > > > > > + * filled by the driver when the transmit completion arriv=
es.
> > > > > > > > + */
> > > > > > > > +struct xsk_tx_metadata {
> > > > > > > > +     union {
> > > > > > > > +             struct {
> > > > > > > > +                     __u32 flags;
> > > > > > > > +
> > > > > > > > +                     /* XDP_TXMD_FLAGS_CHECKSUM */
> > > > > > > > +
> > > > > > > > +                     /* Offset from desc->addr where check=
summing should start. */
> > > > > > > > +                     __u16 csum_start;
> > > > > > > > +                     /* Offset from csum_start where check=
sum should be stored. */
> > > > > > > > +                     __u16 csum_offset;
> > > > > > > > +             } request;
> > > > > > > > +
> > > > > > > > +             struct {
> > > > > > > > +                     /* XDP_TXMD_FLAGS_TIMESTAMP */
> > > > > > > > +                     __u64 tx_timestamp;
> > > > > > > > +             } completion;
> > > > > > > > +     };
> > > > > > > > +};
> > > > > > >=20
> > > > > > > This looks wrong to me. It looks like member @flags is not av=
ail at
> > > > > > > completion time.  At completion time, I assume we also want t=
o know if
> > > > > > > someone requested to get the timestamp for this packet (else =
we could
> > > > > > > read garbage).
> > > > > >=20
> > > > > > I've moved the parts that are preserved across tx and tx comple=
tion
> > > > > > into xsk_tx_metadata_compl.
> > > > > > This is to address Magnus/Maciej feedback where userspace might=
 race
> > > > > > with the kernel.
> > > > > > See: https://lore.kernel.org/bpf/ZNoJenzKXW5QSR3E@boxer/
> > > > > >=20
> > > > >=20
> > > > > Does this mean that every driver have to extend their TX-desc rin=
g with
> > > > > sizeof(struct xsk_tx_metadata_compl)?
> > > > > Won't this affect the performance of this V5?
> > > >=20
> > > > Yes, but it doesn't have to be a descriptor. Might be some internal
> > > > driver completion queue (as in the case of mlx5). And definitely do=
es
> > > > affect performance :-( (see all the static branches to disable it)
> > > > >    $ pahole -C xsk_tx_metadata_compl
> > > > > ./drivers/net/ethernet/stmicro/stmmac/stmmac.ko
> > > > >    struct xsk_tx_metadata_compl {
> > > > > 	__u64 *              tx_timestamp;         /*     0     8 */
> > > > >=20
> > > > > 	/* size: 8, cachelines: 1, members: 1 */
> > > > > 	/* last cacheline: 8 bytes */
> > > > >    };
> > > > >=20
> > > > > Guess, I must be misunderstanding, as I was expecting to see the =
@flags
> > > > > member being preserved across, as I get the race there.
> > > > >=20
> > > > > Looking at stmmac driver, it does look like this xsk_tx_metadata_=
compl
> > > > > is part of the TX-ring for completion (tx_skbuff_dma) and the
> > > > > tx_timestamp data is getting stored here.  How is userspace AF_XD=
P
> > > > > application getting access to the tx_timestamp data?
> > > > > I though this was suppose to get stored in metadata data area (um=
em)?
> > > > >=20
> > > > > Also looking at the code, the kernel would not have a "crash" rac=
e on
> > > > > the flags member (if we preserve in struct), because the code che=
cks the
> > > > > driver HW-TS config-state + TX-descriptor for the availability of=
 a
> > > > > HW-TS in the descriptor.
> > > >=20
> > > > xsk_tx_metadata_compl stores a pointer to the completion timestamp
> > > > in the umem, so everything still arrives via the metadata area.
> > > >=20
> > > > We want to make sure the flags are not changing across tx and tx co=
mpletion.
> > > > Instead of saving the flags, we just use that xsk_tx_metadata_compl=
 to
> > > > signal to the completion that "I know that I've requested the tx
> > > > completion timestamp, please put it at this address in umem".
> > > >=20
> > > > I store the pointer instead of flags to avoid doing pointer math ag=
ain
> > > > at completion. But it's an implementation detail and somewhat abstr=
acted
> > > > from the drivers (besides the fact that it's probably has to fit in=
 8
> > > > bytes).
> > >=20
> > > I see it now (what I missed). At TX time you are storing a pointer wh=
ere
> > > to (later) write the TS at completion time.  It just seems overkill t=
o
> > > store 8 byte (pointer) to signal (via NULL) if the HWTS was requested=
.
> > > Space in the drivers TX-ring is performance critical, and I think dri=
ver
> > > developers would prefer to find a bit to indicate HWTS requested.
> > >=20
> > > If HWTS was *NOT* requested, then the metadata area will not be updat=
ed
> > > (right, correct?). Then memory area is basically garbage that survive=
d.
> > > How does the AF_XDP application know this packet contains a HWTS or n=
ot?
> > >=20
> > >  From an UAPI PoV wouldn't it be easier to use (and extend) via keepi=
ng
> > > the @flags member (in struct xsk_tx_metadata), but (as you already do=
)
> > > not let kernel checks depend on it (to avoid the races).
> >=20
> > I was assuming the userspace can keep this signal out of band or use
> > the same idea as suggested with padding struct xsk_tx_metadata to keep
> > some data around. But I see your point, it might be convenient to
> > keep the original flags around during completion on the uapi side.
> >=20
> > I think I can just move flags from the request union member to the oute=
r
> > struct. So the struct xsk_tx_metadata would look like:
> >=20
> > struct xsk_tx_metadata {
> > 	__u32 flags; /* maybe can even make this u64? */
> >=20
>=20
> Yes to u64 for two reasons (1) this becomes UAPI and
> (2) better alignment for tx_timestamp.
> But I'm open to keeping it u32.
>=20
> > 	union {
> > 		__u16 csum_start;
> > 		__u16 csum_offset;
> > 	} request;
> >=20
> > 	union {
> > 		__u64 tx_timestamp;
> > 	} completion;
> >=20
> > 	__u32 padding; /* to drop this padding */
> > };
> >=20
> > But I'd also keep the existing xsk_tx_metadata_compl to carry the
> > pointer+signal around. As I mentioned previously, it's completely
> > opaque to the driver and we can change the internals in the future.
> >=20
>=20
> Sure, it is an implementation detail and my objections are mostly that I
> don't find it as a pretty code approach that can be hard to follow.
> Maybe driver developer will object and change this later if it cost too
> much to increase the element size in their TX-ring queues.

To make sure I understand, your preference is to save the flags, right?
A potential problem with that approach might be that we'd also have to
carry the pointer to the original umem chunk (blowing the overhead by extra
8 bytes) or pulling it of the tx completion descriptors in the drivers (ext=
ra
complexity). Pulling it out of the tx completion also might be
problematic because because we store iova/dma addresses in the
descriptors?


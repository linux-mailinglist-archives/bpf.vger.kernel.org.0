Return-Path: <bpf+bounces-15093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3607EC3DE
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 14:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590FD1C20B86
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5691C6B0;
	Wed, 15 Nov 2023 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmuV+qkq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D71A72A
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 13:37:44 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99312C
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 05:37:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da033914f7cso8558946276.0
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700055462; x=1700660262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6Y4JZqzeRPDX2aVbkBkG6coIBurA72j+ZY4YIDxfRE=;
        b=wmuV+qkqrdnFbmYX2kSpnk81iWkHqsK8nFxRcd3UKIUZvpZYBsbQ3aB6LFf2anBEXM
         vl8yagD+aJrMd69NQCo76xEA4jVUKNnqEYqL4X9Zjn6vggM2ub9nuFGue49qQwPmRefh
         Wk+H93rJu813EoeYq8DfebpCDIChnrmFewUIydHXJIFOn8cZ3iLw2t+t/alvi/MiX07+
         h0oQ+WnzrDUL0bwp9bjJPcOC4FjaDqY0SDa/984/R1uO2CtwSK+jWywv/cPmQRqaXW3a
         Vr9DaoIyj1UbqENbzMOOvum2DQYkPEMnfufOUITPfAd8PMT31ySEBkoFgAjVmwqQQarn
         P9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055462; x=1700660262;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d6Y4JZqzeRPDX2aVbkBkG6coIBurA72j+ZY4YIDxfRE=;
        b=sC3HOUFzuVGx5mO+HpAA+hSOi2o/444K51WIAwDSiW7c9Q1MXxjMFMiKesIlQHFSow
         lg7w5exY//HYjxEg/H6Xu3I4XfMUu/zy0Pjyx0FpuYUDK7i1IM46Gk3bBw4R4p7p5AVs
         +xXd5ssrVrvUbogEKFFe3fWaSsPCmEC8oMYPAZaPLhb5FHk18l8vB3PKcPRpXWXC8oOT
         XwPHZ9tfwCJ97YjOeVP3eJyeU++EenDsTFHJYI25bMOnZrhX97SDHRdB6LphAiuwR8MR
         zMCmcMiFE06tXSdKKbx5xuhWrTDQwZc/2KzqOSbPwIBihcnIHBYLoXDYklQFG/folxcO
         HwBg==
X-Gm-Message-State: AOJu0YyfMYvHF1jyTBaaq36+06A9Dfbh6kmCfz9ho4utjD6c9TBAtArt
	Vcep8N9BrOBrIMy6AtwpYA31o3k=
X-Google-Smtp-Source: AGHT+IHudoqLVI+ZRIzobBV2wzVqa7iNw3w1qgcY/yY8PMGboMHuHX0E+irz3yJhKzVAY4RZXtLi2KI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:8912:0:b0:d9a:fd29:4fe6 with SMTP id
 e18-20020a258912000000b00d9afd294fe6mr332664ybl.3.1700055462314; Wed, 15 Nov
 2023 05:37:42 -0800 (PST)
Date: Wed, 15 Nov 2023 05:37:40 -0800
In-Reply-To: <be6186c1-52ee-42aa-b53c-39781af3a1ec@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <20231102225837.1141915-3-sdf@google.com>
 <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org> <CAKH8qBtiv8ArtbbMW9+c75y+NfkX-Tk-rcPuHBVdKDMmmFdtdA@mail.gmail.com>
 <2ed17b27-f211-4f58-95b5-5a71914264f3@kernel.org> <ZVJWuB4qtWfC-W_h@google.com>
 <be6186c1-52ee-42aa-b53c-39781af3a1ec@kernel.org>
Message-ID: <ZVTJpLoSCaLoBa67@google.com>
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

On 11/15, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 11/13/23 18:02, Stanislav Fomichev wrote:
> > On 11/13, Jesper Dangaard Brouer wrote:
> > >=20
> > >=20
> > > On 11/13/23 15:10, Stanislav Fomichev wrote:
> > > > On Mon, Nov 13, 2023 at 5:16=E2=80=AFAM Jesper Dangaard Brouer <haw=
k@kernel.org> wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/2/23 23:58, Stanislav Fomichev wrote:
> > > > > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/i=
f_xdp.h
> > > > > > index 2ecf79282c26..b0ee7ad19b51 100644
> > > > > > --- a/include/uapi/linux/if_xdp.h
> > > > > > +++ b/include/uapi/linux/if_xdp.h
> > > > > > @@ -106,6 +106,41 @@ struct xdp_options {
> > > > > >     #define XSK_UNALIGNED_BUF_ADDR_MASK \
> > > > > >         ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> > > > > >=20
> > > > > > +/* Request transmit timestamp. Upon completion, put it into tx=
_timestamp
> > > > > > + * field of struct xsk_tx_metadata.
> > > > > > + */
> > > > > > +#define XDP_TXMD_FLAGS_TIMESTAMP             (1 << 0)
> > > > > > +
> > > > > > +/* Request transmit checksum offload. Checksum start position =
and offset
> > > > > > + * are communicated via csum_start and csum_offset fields of s=
truct
> > > > > > + * xsk_tx_metadata.
> > > > > > + */
> > > > > > +#define XDP_TXMD_FLAGS_CHECKSUM                      (1 << 1)
> > > > > > +
> > > > > > +/* AF_XDP offloads request. 'request' union member is consumed=
 by the driver
> > > > > > + * when the packet is being transmitted. 'completion' union me=
mber is
> > > > > > + * filled by the driver when the transmit completion arrives.
> > > > > > + */
> > > > > > +struct xsk_tx_metadata {
> > > > > > +     union {
> > > > > > +             struct {
> > > > > > +                     __u32 flags;
> > > > > > +
> > > > > > +                     /* XDP_TXMD_FLAGS_CHECKSUM */
> > > > > > +
> > > > > > +                     /* Offset from desc->addr where checksumm=
ing should start. */
> > > > > > +                     __u16 csum_start;
> > > > > > +                     /* Offset from csum_start where checksum =
should be stored. */
> > > > > > +                     __u16 csum_offset;
> > > > > > +             } request;
> > > > > > +
> > > > > > +             struct {
> > > > > > +                     /* XDP_TXMD_FLAGS_TIMESTAMP */
> > > > > > +                     __u64 tx_timestamp;
> > > > > > +             } completion;
> > > > > > +     };
> > > > > > +};
> > > > >=20
> > > > > This looks wrong to me. It looks like member @flags is not avail =
at
> > > > > completion time.  At completion time, I assume we also want to kn=
ow if
> > > > > someone requested to get the timestamp for this packet (else we c=
ould
> > > > > read garbage).
> > > >=20
> > > > I've moved the parts that are preserved across tx and tx completion
> > > > into xsk_tx_metadata_compl.
> > > > This is to address Magnus/Maciej feedback where userspace might rac=
e
> > > > with the kernel.
> > > > See: https://lore.kernel.org/bpf/ZNoJenzKXW5QSR3E@boxer/
> > > >=20
> > >=20
> > > Does this mean that every driver have to extend their TX-desc ring wi=
th
> > > sizeof(struct xsk_tx_metadata_compl)?
> > > Won't this affect the performance of this V5?
> >=20
> > Yes, but it doesn't have to be a descriptor. Might be some internal
> > driver completion queue (as in the case of mlx5). And definitely does
> > affect performance :-( (see all the static branches to disable it)
> > >   $ pahole -C xsk_tx_metadata_compl
> > > ./drivers/net/ethernet/stmicro/stmmac/stmmac.ko
> > >   struct xsk_tx_metadata_compl {
> > > 	__u64 *              tx_timestamp;         /*     0     8 */
> > >=20
> > > 	/* size: 8, cachelines: 1, members: 1 */
> > > 	/* last cacheline: 8 bytes */
> > >   };
> > >=20
> > > Guess, I must be misunderstanding, as I was expecting to see the @fla=
gs
> > > member being preserved across, as I get the race there.
> > >=20
> > > Looking at stmmac driver, it does look like this xsk_tx_metadata_comp=
l
> > > is part of the TX-ring for completion (tx_skbuff_dma) and the
> > > tx_timestamp data is getting stored here.  How is userspace AF_XDP
> > > application getting access to the tx_timestamp data?
> > > I though this was suppose to get stored in metadata data area (umem)?
> > >=20
> > > Also looking at the code, the kernel would not have a "crash" race on
> > > the flags member (if we preserve in struct), because the code checks =
the
> > > driver HW-TS config-state + TX-descriptor for the availability of a
> > > HW-TS in the descriptor.
> >=20
> > xsk_tx_metadata_compl stores a pointer to the completion timestamp
> > in the umem, so everything still arrives via the metadata area.
> >=20
> > We want to make sure the flags are not changing across tx and tx comple=
tion.
> > Instead of saving the flags, we just use that xsk_tx_metadata_compl to
> > signal to the completion that "I know that I've requested the tx
> > completion timestamp, please put it at this address in umem".
> >=20
> > I store the pointer instead of flags to avoid doing pointer math again
> > at completion. But it's an implementation detail and somewhat abstracte=
d
> > from the drivers (besides the fact that it's probably has to fit in 8
> > bytes).
>=20
> I see it now (what I missed). At TX time you are storing a pointer where
> to (later) write the TS at completion time.  It just seems overkill to
> store 8 byte (pointer) to signal (via NULL) if the HWTS was requested.
> Space in the drivers TX-ring is performance critical, and I think driver
> developers would prefer to find a bit to indicate HWTS requested.
>=20
> If HWTS was *NOT* requested, then the metadata area will not be updated
> (right, correct?). Then memory area is basically garbage that survived.
> How does the AF_XDP application know this packet contains a HWTS or not?
>=20
> From an UAPI PoV wouldn't it be easier to use (and extend) via keeping
> the @flags member (in struct xsk_tx_metadata), but (as you already do)
> not let kernel checks depend on it (to avoid the races).

I was assuming the userspace can keep this signal out of band or use
the same idea as suggested with padding struct xsk_tx_metadata to keep
some data around. But I see your point, it might be convenient to
keep the original flags around during completion on the uapi side.

I think I can just move flags from the request union member to the outer
struct. So the struct xsk_tx_metadata would look like:

struct xsk_tx_metadata {
	__u32 flags; /* maybe can even make this u64? */

	union {
		__u16 csum_start;
		__u16 csum_offset;
	} request;

	union {
		__u64 tx_timestamp;
	} completion;

	__u32 padding; /* to drop this padding */
};

But I'd also keep the existing xsk_tx_metadata_compl to carry the
pointer+signal around. As I mentioned previously, it's completely
opaque to the driver and we can change the internals in the future.

IOW, we won't override the flags from the kernel side and as long
as the userspace consumer doesn't mess them up it should receive
the original value at completion.

Would that work for you?


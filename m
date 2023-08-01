Return-Path: <bpf+bounces-6501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3E76A5EB
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6855F1C2094D
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9A7EF;
	Tue,  1 Aug 2023 01:03:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA67E;
	Tue,  1 Aug 2023 01:03:41 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753FCE67;
	Mon, 31 Jul 2023 18:03:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9bd59d465so76661941fa.3;
        Mon, 31 Jul 2023 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690851818; x=1691456618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N61DiLzqfWCfaoDxyjE2xBc7t2o0CIHZgALsIagDbeg=;
        b=c+eMFfCZPp7YAmdNEiE1kYDHVCDzzJckp+4WDHt8+0o/je4x7DISIuKrVtNkIY9fmI
         mixYW+wZL6+AJa3cB1GMVNpjUvFLt7R3RWsN5/Ey9zy97GsroIccVFwn1iU+CUTw4tAr
         dTaBiUCIH++bVKQO9r/Ln207pWlYmbFfZb2JQyWhbO4WpXA4Brmrm8BhP4mFZ+RFBEmC
         GvEpNTgsZi/V3z+wXS3+QvCxfXOg6YJpNz6RoZtps+pvJfQYMGpxP0pz9Fsu/3DjxJ+x
         duncf3vYqV14H41DSD1E9FtPyeY8iyESN3Z6imbfJNcuHa+wknD5gJqdJD/VFVNQXKhs
         ikeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690851818; x=1691456618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N61DiLzqfWCfaoDxyjE2xBc7t2o0CIHZgALsIagDbeg=;
        b=WQGpF2e4NUtrypKdHQ8nTFfnMEApud04cmTHLU2r7ks8jzMFkLKOgAeTdnwmfwG++f
         mV6ACr8wqANkmSCh1Mtqf3wEdSOFCUPPdXJDFDfuYJJLcqKkKoJctJqUNe93yZAiHl+5
         ZbMLZEIq5CiTym8JVT8Ziak+4tgrk+/H998G0YbS3QgjAmtNnfNGX592lVQOLCqgiYri
         DWababLLmUOfCHCxm6MwBxlhjviIGTN1Pvxr4tnbKIASqj3Ewzcvzaqx8s1Q1+75BrgS
         9qlK9ZKflM8MSVgHnhYI1exbAkm2vIRsWSeFn/RxHPOz77XkIuJOKnr46eVY9bFI0d4q
         /v0A==
X-Gm-Message-State: ABy/qLZlyY/ADtxv/eTT9wHnlgn9LVoeIvdASgP31zG+JX5imeaCkQrE
	0PR/IV8YRBOrsZ35SLXLtrXL6xlhbbo+hGKf3hEb3tbaV5E=
X-Google-Smtp-Source: APBJJlGYDu8MYvr1+1nrZ7WBvwBAvD2wijHjCSeHG3Zs9fikL7VCSMJbUS1UlvVTDj4vYpqhtVoQMXjLjvesrFI4t6Y=
X-Received: by 2002:a2e:8290:0:b0:2b9:f31e:51ff with SMTP id
 y16-20020a2e8290000000b002b9f31e51ffmr1030391ljg.37.1690851817525; Mon, 31
 Jul 2023 18:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com> <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch> <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch> <ZMeSUrOfhq9dWz6f@lincoln>
In-Reply-To: <ZMeSUrOfhq9dWz6f@lincoln>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 18:03:26 -0700
Message-ID: <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, Network Development <netdev@vger.kernel.org>, 
	Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 3:56=E2=80=AFAM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Sun, Jul 30, 2023 at 09:13:02AM -0400, Willem de Bruijn wrote:
> > Alexei Starovoitov wrote:
> > > On Sat, Jul 29, 2023 at 9:15=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Alexei Starovoitov wrote:
> > > > > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
> > > > > >
> > > > > > +union xdp_csum_info {
> > > > > > +   /* Checksum referred to by ``csum_start + csum_offset`` is =
considered
> > > > > > +    * valid, but was never calculated, TX device has to do thi=
s,
> > > > > > +    * starting from csum_start packet byte.
> > > > > > +    * Any preceding checksums are also considered valid.
> > > > > > +    * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > > > > > +    */
> > > > > > +   struct {
> > > > > > +           u16 csum_start;
> > > > > > +           u16 csum_offset;
> > > > > > +   };
> > > > > > +
> > > > >
> > > > > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in t=
he above.
> > > >
> > > > It can be observed on RX when packets are looped.
> > > >
> > > > This may be observed even in XDP on veth.
> > >
> > > veth and XDP is a broken combination. GSO packets coming out of conta=
iners
> > > cannot be parsed properly by XDP.
> > > It was added mainly for testing. Just like "generic XDP".
> > > bpf progs at skb layer is much better fit for veth.
> >
> > Ok. Still, seems forward looking and little cost to define the
> > constant?
> >
>
> +1
> CHECKSUM_PARTIAL is mostly for testing and removing/adding it doesn't cha=
nge
> anything from the perspective of the user that does not use it, so I thin=
k it is
> worth having.

"little cost to define the constant".
Not really. A constant in UAPI is a heavy burden.

> > > > > > +   /* Checksum, calculated over the whole packet.
> > > > > > +    * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > > > +    */
> > > > > > +   u32 checksum;
> > > > >
> > > > > imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32 che=
cksum
> > > > > or XDP_CHECKSUM_UNNECESSARY.
> > > > >
> > > > > > +};
> > > > > > +
> > > > > > +enum xdp_csum_status {
> > > > > > +   /* HW had parsed several transport headers and validated th=
eir
> > > > > > +    * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff=
``.
> > > > > > +    * 3 least significant bytes contain number of consecutive =
checksums,
> > > > > > +    * starting with the outermost, reported by hardware as val=
id.
> > > > > > +    * ``sk_buff`` checksum level (``csum_level``) notation is =
provided
> > > > > > +    * for driver developers.
> > > > > > +    */
> > > > > > +   XDP_CHECKSUM_VALID_LVL0         =3D 1,    /* 1 outermost ch=
ecksum */
> > > > > > +   XDP_CHECKSUM_VALID_LVL1         =3D 2,    /* 2 outermost ch=
ecksums */
> > > > > > +   XDP_CHECKSUM_VALID_LVL2         =3D 3,    /* 3 outermost ch=
ecksums */
> > > > > > +   XDP_CHECKSUM_VALID_LVL3         =3D 4,    /* 4 outermost ch=
ecksums */
> > > > > > +   XDP_CHECKSUM_VALID_NUM_MASK     =3D GENMASK(2, 0),
> > > > > > +   XDP_CHECKSUM_VALID              =3D XDP_CHECKSUM_VALID_NUM_=
MASK,
> > > > >
> > > > > I don't see what bpf prog suppose to do with these levels.
> > > > > The driver should pick between 3:
> > > > > XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM_NON=
E.
> > > > >
> > > > > No levels and no anything partial. please.
> > > >
> > > > This levels business is an unfortunate side effect of
> > > > CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, w=
hat
> > > > does the boolean actually mean? With these levels, at least that is
> > > > well defined: the first N checksum fields.
> > >
> > > If I understand this correctly this is intel specific feature that
> > > other NICs don't have. skb layer also doesn't have such concept.
>
> Please look into csum_level field in sk_buff. It is not the most used pro=
perty
> in the kernel networking code, but it is certainly 1. used by networking =
stack
> 2. set to non-zero value by many vendors.
>
> So you do not need to search yourself, I'll copy-paste the docs for
> CHECKSUM_UNNECESSARY here:
>
>  *   %CHECKSUM_UNNECESSARY is applicable to following protocols:
>  *
>  *     - TCP: IPv6 and IPv4.
>  *     - UDP: IPv4 and IPv6. A device may apply CHECKSUM_UNNECESSARY to a
>  *       zero UDP checksum for either IPv4 or IPv6, the networking stack
>  *       may perform further validation in this case.
>  *     - GRE: only if the checksum is present in the header.
>  *     - SCTP: indicates the CRC in SCTP header has been validated.
>  *     - FCOE: indicates the CRC in FC frame has been validated.
>  *
>
> Please, look at this:
>
>  *   &sk_buff.csum_level indicates the number of consecutive checksums fo=
und in
>  *   the packet minus one that have been verified as %CHECKSUM_UNNECESSAR=
Y.
>  *   For instance if a device receives an IPv6->UDP->GRE->IPv4->TCP packe=
t
>  *   and a device is able to verify the checksums for UDP (possibly zero)=
,
>  *   GRE (checksum flag is set) and TCP, &sk_buff.csum_level would be set=
 to
>  *   two. If the device were only able to verify the UDP checksum and not
>  *   GRE, either because it doesn't support GRE checksum or because GRE
>  *   checksum is bad, skb->csum_level would be set to zero (TCP checksum =
is
>  *   not considered in this case).
>
> From:
> https://elixir.bootlin.com/linux/v6.5-rc4/source/include/linux/skbuff.h#L=
115
>
> > > The driver should say CHECKSUM_UNNECESSARY when it's sure
> > > or don't pretend that it checks the checksum and just say NONE.
> >
>
> Well, in such case, most of the NICs that use CHECKSUM_UNNECESSARY would =
have to
> return CHECKSUM_NONE instead, because based on my quick search, they most=
ly
> return checksum level of 0 (no tunneling detected) or 1 (tunneling detect=
ed),
> so they only parse headers up to a certain depth, meaning it's not possib=
le
> to tell whether there isn't another CHECKSUM_UNNECESSARY-eligible header =
hiding
> in the payload, so those NIC cannot guarantee ALL the checksums present i=
n the
> packet are correct. So, by your logic, we should make e.g. AF_XDP user re=
-check
> already verified checksums themselves, because HW "doesn't pretend that i=
t
> checks the checksum and just says NONE".
>
> > I did not know how much this was used, but quick grep for non constant
> > csum_level shows devices from at least six vendors.
>
> Yes, there are several vendors that set the csum_level, including broadco=
m
> (bnxt) and mellanox (mlx4 and mlx5).
>
> Also, CHECKSUM_UNNECESSARY is found in 100+ drivers/net/ethernet files,
> while csum_level is in like 20, which means overwhelming majority of
> CHECKSUM_UNNECESSARY NICs actually stay with the default checksum level o=
f '0'
> (they check only the outermost checksum - anything else needs to be verif=
ied by
> the networking stack).

No. What I'm saying is that XDP_CHECKSUM_UNNECESSARY should be
equivalent to skb's CHECKSUM_UNNECESSARY with csum_level =3D 0.
I'm well aware that some drivers are trying to be smart and put csum_level=
=3D1.
There is no use case for it in XDP.
"But our HW supports it so XDP prog should read it" is the reason NOT
to expose it to bpf in generic api.

Either we're doing per-driver kfuncs and no common infra or common kfunc
that covers 99% of the drivers. Which is CHECKSUM_UNNECESSARY && csum_level=
 =3D 0

It's not acceptable to present a generic api to xdp prog with multi level
csum that only works on a specific HW. Next thing there will be new flags
and MAX_CSUM_LEVEL in XDP features.
Pretending to be generic while being HW specific is the worst interface.


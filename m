Return-Path: <bpf+bounces-6711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749276CE98
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98D31C2127E
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0049749D;
	Wed,  2 Aug 2023 13:27:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48A746C;
	Wed,  2 Aug 2023 13:27:32 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755F2703;
	Wed,  2 Aug 2023 06:27:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bca5c71a6aso2868722a34.3;
        Wed, 02 Aug 2023 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690982848; x=1691587648;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18UwW1utuNkSoHzmJMuSebGfODEhO3h+VlQi/i83GtQ=;
        b=QBHB50ZZY9uWbYiYv9cfESYNuHEparIb/B3qKl/Wgbds8A1R+kbDEeTJHYJnUdzFxb
         /qv/JsgmT1T0GWal4u7rNPTqzEpydysjUQVQOxCvXUkfNarl3tabfGrSS83rq5w++dK4
         BTBd1O6P0XbqYK5dCGb7P/Di99br5M+yxYaJsMN5Ix+L29pJscpZRFY8+Mb4GOjOx4kD
         z1RSLmUmmxaozLgjPbzsD8RkIqx2021xasu2+qVZnKG1gWhsafZa3Tz0g7RL7JygJDBm
         gILcwtofr1HeTxcFm2UQ1I2bSWnMaMX5RiQy6mAXAsvUZsUeL2tek3+3Ntaq0Q5uWImU
         L6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982848; x=1691587648;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=18UwW1utuNkSoHzmJMuSebGfODEhO3h+VlQi/i83GtQ=;
        b=PhZOmDbNM3cgNwRN2JtDkDzJcF72UGpfNDp4XrG5u0LfGFkZG0RXl3KfMfVlCt6fkC
         PUUGKDQSGmQ8j+//n9PkWA5HEOpToJPfOkQCDLAG/I4cGst4HfJgeCvspu3vHlyf7jZi
         2g3SuFAO4k4LM5xY4xO7L1ktCwImHKlmdxvycc60dWEy60Beeo+8zfZrT9PW69t0u6XB
         FY5fiyA3DVUjJFF6q3V3U9A1WTPGTAkjMvu+CHitde7CnnhYPlijvN9uDh/dxcSYfRQ1
         LmpJvrKY/DfRPp/qggoUfg9dd6UexKf9JtExwN234YBwBf0dg7fYNXYepZDDAMHwsPZG
         aTrQ==
X-Gm-Message-State: ABy/qLZyEr+vHRBH3qSDlU6zxMxyNRfgfolLSQjsIybf+N7kBJSqcRs4
	Ii47cFK2hHhHpOe75mrZA/4=
X-Google-Smtp-Source: APBJJlGXrxsoUEY85b11m2d2HEWtlpEksagOrkKx+pqr/8ovtQ3BWPA3oLZ/X2o+j9uMqxWgznmUsA==
X-Received: by 2002:a05:6830:20d6:b0:6b9:67e4:eba7 with SMTP id z22-20020a05683020d600b006b967e4eba7mr17813623otq.23.1690982848526;
        Wed, 02 Aug 2023 06:27:28 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id c24-20020ac86618000000b0040d6f2113efsm3354848qtp.58.2023.08.02.06.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:27:27 -0700 (PDT)
Date: Wed, 02 Aug 2023 09:27:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Alexander Lobakin <alexandr.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, 
 xdp-hints@xdp-project.net, 
 Network Development <netdev@vger.kernel.org>, 
 Simon Horman <simon.horman@corigine.com>
Message-ID: <64ca59bfbb1cd_294ce929467@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
 <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
 <ZMeSUrOfhq9dWz6f@lincoln>
 <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei Starovoitov wrote:
> On Mon, Jul 31, 2023 at 3:56=E2=80=AFAM Larysa Zaremba <larysa.zaremba@=
intel.com> wrote:
> >
> > On Sun, Jul 30, 2023 at 09:13:02AM -0400, Willem de Bruijn wrote:
> > > Alexei Starovoitov wrote:
> > > > On Sat, Jul 29, 2023 at 9:15=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Alexei Starovoitov wrote:
> > > > > > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrot=
e:
> > > > > > >
> > > > > > > +union xdp_csum_info {
> > > > > > > +   /* Checksum referred to by ``csum_start + csum_offset``=
 is considered
> > > > > > > +    * valid, but was never calculated, TX device has to do=
 this,
> > > > > > > +    * starting from csum_start packet byte.
> > > > > > > +    * Any preceding checksums are also considered valid.
> > > > > > > +    * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``=
.
> > > > > > > +    */
> > > > > > > +   struct {
> > > > > > > +           u16 csum_start;
> > > > > > > +           u16 csum_offset;
> > > > > > > +   };
> > > > > > > +
> > > > > >
> > > > > > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see =
in the above.
> > > > >
> > > > > It can be observed on RX when packets are looped.
> > > > >
> > > > > This may be observed even in XDP on veth.
> > > >
> > > > veth and XDP is a broken combination. GSO packets coming out of c=
ontainers
> > > > cannot be parsed properly by XDP.
> > > > It was added mainly for testing. Just like "generic XDP".
> > > > bpf progs at skb layer is much better fit for veth.
> > >
> > > Ok. Still, seems forward looking and little cost to define the
> > > constant?
> > >
> >
> > +1
> > CHECKSUM_PARTIAL is mostly for testing and removing/adding it doesn't=
 change
> > anything from the perspective of the user that does not use it, so I =
think it is
> > worth having.
> =

> "little cost to define the constant".
> Not really. A constant in UAPI is a heavy burden.
> =

> > > > > > > +   /* Checksum, calculated over the whole packet.
> > > > > > > +    * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > > > > +    */
> > > > > > > +   u32 checksum;
> > > > > >
> > > > > > imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32=
 checksum
> > > > > > or XDP_CHECKSUM_UNNECESSARY.
> > > > > >
> > > > > > > +};
> > > > > > > +
> > > > > > > +enum xdp_csum_status {
> > > > > > > +   /* HW had parsed several transport headers and validate=
d their
> > > > > > > +    * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_=
buff``.
> > > > > > > +    * 3 least significant bytes contain number of consecut=
ive checksums,
> > > > > > > +    * starting with the outermost, reported by hardware as=
 valid.
> > > > > > > +    * ``sk_buff`` checksum level (``csum_level``) notation=
 is provided
> > > > > > > +    * for driver developers.
> > > > > > > +    */
> > > > > > > +   XDP_CHECKSUM_VALID_LVL0         =3D 1,    /* 1 outermos=
t checksum */
> > > > > > > +   XDP_CHECKSUM_VALID_LVL1         =3D 2,    /* 2 outermos=
t checksums */
> > > > > > > +   XDP_CHECKSUM_VALID_LVL2         =3D 3,    /* 3 outermos=
t checksums */
> > > > > > > +   XDP_CHECKSUM_VALID_LVL3         =3D 4,    /* 4 outermos=
t checksums */
> > > > > > > +   XDP_CHECKSUM_VALID_NUM_MASK     =3D GENMASK(2, 0),
> > > > > > > +   XDP_CHECKSUM_VALID              =3D XDP_CHECKSUM_VALID_=
NUM_MASK,
> > > > > >
> > > > > > I don't see what bpf prog suppose to do with these levels.
> > > > > > The driver should pick between 3:
> > > > > > XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM=
_NONE.
> > > > > >
> > > > > > No levels and no anything partial. please.
> > > > >
> > > > > This levels business is an unfortunate side effect of
> > > > > CHECKSUM_UNNECESSARY. For a packet with multiple checksum field=
s, what
> > > > > does the boolean actually mean? With these levels, at least tha=
t is
> > > > > well defined: the first N checksum fields.
> > > >
> > > > If I understand this correctly this is intel specific feature tha=
t
> > > > other NICs don't have. skb layer also doesn't have such concept.
> >
> > Please look into csum_level field in sk_buff. It is not the most used=
 property
> > in the kernel networking code, but it is certainly 1. used by network=
ing stack
> > 2. set to non-zero value by many vendors.
> >
> > So you do not need to search yourself, I'll copy-paste the docs for
> > CHECKSUM_UNNECESSARY here:
> >
> >  *   %CHECKSUM_UNNECESSARY is applicable to following protocols:
> >  *
> >  *     - TCP: IPv6 and IPv4.
> >  *     - UDP: IPv4 and IPv6. A device may apply CHECKSUM_UNNECESSARY =
to a
> >  *       zero UDP checksum for either IPv4 or IPv6, the networking st=
ack
> >  *       may perform further validation in this case.
> >  *     - GRE: only if the checksum is present in the header.
> >  *     - SCTP: indicates the CRC in SCTP header has been validated.
> >  *     - FCOE: indicates the CRC in FC frame has been validated.
> >  *
> >
> > Please, look at this:
> >
> >  *   &sk_buff.csum_level indicates the number of consecutive checksum=
s found in
> >  *   the packet minus one that have been verified as %CHECKSUM_UNNECE=
SSARY.
> >  *   For instance if a device receives an IPv6->UDP->GRE->IPv4->TCP p=
acket
> >  *   and a device is able to verify the checksums for UDP (possibly z=
ero),
> >  *   GRE (checksum flag is set) and TCP, &sk_buff.csum_level would be=
 set to
> >  *   two. If the device were only able to verify the UDP checksum and=
 not
> >  *   GRE, either because it doesn't support GRE checksum or because G=
RE
> >  *   checksum is bad, skb->csum_level would be set to zero (TCP check=
sum is
> >  *   not considered in this case).
> >
> > From:
> > https://elixir.bootlin.com/linux/v6.5-rc4/source/include/linux/skbuff=
.h#L115
> >
> > > > The driver should say CHECKSUM_UNNECESSARY when it's sure
> > > > or don't pretend that it checks the checksum and just say NONE.
> > >
> >
> > Well, in such case, most of the NICs that use CHECKSUM_UNNECESSARY wo=
uld have to
> > return CHECKSUM_NONE instead, because based on my quick search, they =
mostly
> > return checksum level of 0 (no tunneling detected) or 1 (tunneling de=
tected),
> > so they only parse headers up to a certain depth, meaning it's not po=
ssible
> > to tell whether there isn't another CHECKSUM_UNNECESSARY-eligible hea=
der hiding
> > in the payload, so those NIC cannot guarantee ALL the checksums prese=
nt in the
> > packet are correct. So, by your logic, we should make e.g. AF_XDP use=
r re-check
> > already verified checksums themselves, because HW "doesn't pretend th=
at it
> > checks the checksum and just says NONE".
> >
> > > I did not know how much this was used, but quick grep for non const=
ant
> > > csum_level shows devices from at least six vendors.
> >
> > Yes, there are several vendors that set the csum_level, including bro=
adcom
> > (bnxt) and mellanox (mlx4 and mlx5).
> >
> > Also, CHECKSUM_UNNECESSARY is found in 100+ drivers/net/ethernet file=
s,
> > while csum_level is in like 20, which means overwhelming majority of
> > CHECKSUM_UNNECESSARY NICs actually stay with the default checksum lev=
el of '0'
> > (they check only the outermost checksum - anything else needs to be v=
erified by
> > the networking stack).
> =

> No. What I'm saying is that XDP_CHECKSUM_UNNECESSARY should be
> equivalent to skb's CHECKSUM_UNNECESSARY with csum_level =3D 0.
> I'm well aware that some drivers are trying to be smart and put csum_le=
vel=3D1.
> There is no use case for it in XDP.
> "But our HW supports it so XDP prog should read it" is the reason NOT
> to expose it to bpf in generic api.
> =

> Either we're doing per-driver kfuncs and no common infra or common kfun=
c
> that covers 99% of the drivers. Which is CHECKSUM_UNNECESSARY && csum_l=
evel =3D 0
> =

> It's not acceptable to present a generic api to xdp prog with multi lev=
el
> csum that only works on a specific HW. Next thing there will be new fla=
gs
> and MAX_CSUM_LEVEL in XDP features.
> Pretending to be generic while being HW specific is the worst interface=
.

Ok. Agreed that without it we still cover 99% of the use cases. Fine to d=
rop.


Return-Path: <bpf+bounces-4874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D87751204
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E406281597
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3408DF66;
	Wed, 12 Jul 2023 20:53:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA151DDCF
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 20:53:12 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7D171D
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 13:53:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704a25be9so18833127b3.1
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689195190; x=1691787190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9QPsCD/Sct5C3jY+g/VQEaVoM3H/JWnzXtkru8S9wA=;
        b=5wm0H1/TT8NM8HFmoANfbtFmPlmgiCOZMW7Zcj/bIpqeAKM0V4u9Vv2Xl91RzQY+Xp
         ZM0+SzECWdFuGZOXUQrzSbGYvtM5yJ60Nq5aXPZG5//K6b2EN+AF/H5iLcrbVmvYlmqn
         LXw7orLcivUBCmqH2ELAx5WLTw5Y1OIXcUZdaQ0g2n6iI4cXT7GH7Dwt3hWN0BZ0mZ+R
         G+8NySZPvuCK+2vwUQUJItaJIDPlbBQd7a1yypv0F2J5qnQOeG4z4YBsEdmuFi9NspCO
         RG2d9oA9zi8/Jjon/mPBrgHRdycPmMwqyTmgiM2sFSoRWgJx1yOmcLzqgEdq9PSRiyEU
         QRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689195190; x=1691787190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9QPsCD/Sct5C3jY+g/VQEaVoM3H/JWnzXtkru8S9wA=;
        b=YCTmUNR3JwbHfosG9/u+DiJLPsy7Z+UNgiIXn7heZX6QaKuX8GY7p0hA2dPw0dkdqe
         27RaB0lwig5df8RDzcpqV7bwaMbP+fxcab5x56+A6SZ7UX0N0T6AigL8eTdgMtGBytIg
         9TZB0i+JdhT1I3NOf2dvLEKv6s4p7FEDQvtDw3QnV/MBYmgxF1zYTWkHZsgZhEZXyd+0
         HsmcARQN0u3EvhSOlyk+ZpcXXsCmme3DNGO/sXSOjyGUJ5VJ4LlCvFFwzu30hn8WUN+Y
         L/yAnsveHj8sCF4CerqXVl9VcixhzR9KBkTo73SfGNGfd1Fybz8budYvhM02wL5VEQyD
         m1OQ==
X-Gm-Message-State: ABy/qLYWR587WHQ3RQcEle99edGyXPXZY5PV7YVURumNX9xRHXi968sH
	CpO58/jyzPANyBrh0/xqoZkTIHA=
X-Google-Smtp-Source: APBJJlGQhaseuP/DPTMeml4TZQGe8eKZparx5CG699nxDyYD1BJ5584Q8bIHIoYCOo7NUjbN7mlFNBM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:af18:0:b0:576:e268:903d with SMTP id
 n24-20020a81af18000000b00576e268903dmr39126ywh.2.1689195190559; Wed, 12 Jul
 2023 13:53:10 -0700 (PDT)
Date: Wed, 12 Jul 2023 13:53:09 -0700
In-Reply-To: <20230712130954.7c8dc5ef@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
 <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
 <ZK4eFox0DwbpyIJv@google.com> <CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
 <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
 <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
 <20230712190342.dlgwh6uka5bcjfkl@macbook-pro-8.dhcp.thefacebook.com>
 <CAF=yD-Kf6wSc1JkgpNHEBVbyRiJ1pHqbw7SkkuHGAHatyS+eVg@mail.gmail.com>
 <CAADnVQ+QGgjmqiV_uRzcrPOrH=GeDTtkAVs6t2n15WA9x3o3sw@mail.gmail.com> <20230712130954.7c8dc5ef@kernel.org>
Message-ID: <ZK8SqGZOYK5THiQL@google.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=" <toke@kernel.org>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	magnus.karlsson@intel.com, 
	"=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>, maciej.fijalkowski@intel.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/12, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 12:42:35 -0700 Alexei Starovoitov wrote:
> > > Basically, add to AF_XDP what we already have for its predecessor
> > > AF_PACKET: setsockopt PACKET_VNET_HDR?
> > >
> > > Possibly with a separate new struct, rather than virtio_net_hdr. As
> > > that has dependencies on other drivers, notably virtio and its
> > > specification process. =20
> >=20
> > yeah. Forgot about this one.
> > That's a perfect fit. I would reuse virtio_net_hdr as-is.
> > Why reinvent the wheel?
> > It would force uapi, but some might argue it's a good thing.
>=20
> I was gonna reply on the other leg of the thread but it sounds like
> we're in agreement now? =F0=9F=91=8F=EF=B8=8F  virtio_net_hdr is the kind=
 of generic
> descriptor I had in mind.
>=20
> I'd suggest breaking hdr_len into L2len, L3len and L4len, tho. How does
> virtio do IP length updates during TSO if it doesn't know where L3
> starts? HW will want to know, and it's easy to add them together in
> cases where it doesn't. Which is why I kept saying "packet geometry"
> rather than pointing at virtio_net_hdr.

Perfect, I'll drop the kfuncs and will switch to a more static way
of passing this info. We can discuss the particular layout once I have
something concrete to show :-)

Thanks, again, everyone for the comments!


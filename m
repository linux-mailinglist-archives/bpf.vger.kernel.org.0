Return-Path: <bpf+bounces-4873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3647511AC
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561AE1C2101D
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA02419C;
	Wed, 12 Jul 2023 20:09:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77524176;
	Wed, 12 Jul 2023 20:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339B2C433C7;
	Wed, 12 Jul 2023 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689192596;
	bh=0tjYlRq1YbzrHKoKvcbNWiR3wUPzfcuxoNmZjxC+l0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WoivpRErrsDBluPlX0jY/8PXOX9W2WlcAfkRrWPswNJ3agrzwqTdLAvC+zm8oeNHT
	 4pOE4jkvhsDTW+0UxRHaPFWt4K9s7KWvAfSuFDPel4vc7p8v357d35BdUJUL/93e0S
	 AALRkqGCohFV82lVKFvTdOf5a+WHG/v5BKjZLJ/fKDrW4v5tYYo7gAXqg+7LBCkAP8
	 07Gx7sLQsGZ4PHE8RlKaheARxZkLovxMf+dQuhj8CCkjCYlSPJiZtbPoJrAonx4xEa
	 /+J3ssCBRM2PeKnrDzeWHjQFNmrWZrZe6NuXqCN/D6BnX/TBceKkTqJ97bI4ODdKCM
	 m1ZHUB2koNP0w==
Date: Wed, 12 Jul 2023 13:09:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Stanislav Fomichev
 <sdf@google.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Network Development
 <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
Message-ID: <20230712130954.7c8dc5ef@kernel.org>
In-Reply-To: <CAADnVQ+QGgjmqiV_uRzcrPOrH=GeDTtkAVs6t2n15WA9x3o3sw@mail.gmail.com>
References: <20230707193006.1309662-10-sdf@google.com>
	<20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
	<CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
	<CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
	<CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
	<CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
	<ZK4eFox0DwbpyIJv@google.com>
	<CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
	<CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
	<CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
	<20230712190342.dlgwh6uka5bcjfkl@macbook-pro-8.dhcp.thefacebook.com>
	<CAF=yD-Kf6wSc1JkgpNHEBVbyRiJ1pHqbw7SkkuHGAHatyS+eVg@mail.gmail.com>
	<CAADnVQ+QGgjmqiV_uRzcrPOrH=GeDTtkAVs6t2n15WA9x3o3sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2023 12:42:35 -0700 Alexei Starovoitov wrote:
> > Basically, add to AF_XDP what we already have for its predecessor
> > AF_PACKET: setsockopt PACKET_VNET_HDR?
> >
> > Possibly with a separate new struct, rather than virtio_net_hdr. As
> > that has dependencies on other drivers, notably virtio and its
> > specification process. =20
>=20
> yeah. Forgot about this one.
> That's a perfect fit. I would reuse virtio_net_hdr as-is.
> Why reinvent the wheel?
> It would force uapi, but some might argue it's a good thing.

I was gonna reply on the other leg of the thread but it sounds like
we're in agreement now? =F0=9F=91=8F=EF=B8=8F  virtio_net_hdr is the kind o=
f generic
descriptor I had in mind.

I'd suggest breaking hdr_len into L2len, L3len and L4len, tho. How does
virtio do IP length updates during TSO if it doesn't know where L3
starts? HW will want to know, and it's easy to add them together in
cases where it doesn't. Which is why I kept saying "packet geometry"
rather than pointing at virtio_net_hdr.


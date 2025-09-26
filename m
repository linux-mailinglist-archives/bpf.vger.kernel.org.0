Return-Path: <bpf+bounces-69802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F31BA2307
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 04:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A7C178A2E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B26247DE1;
	Fri, 26 Sep 2025 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqzkEGnF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713A1534EC;
	Fri, 26 Sep 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852742; cv=none; b=DlJQOKjpgnptmptltT8hDi4cc4NU9SD1p+A92t4ZnFmOoURUFQ2Ujux4tEjxSXmj/GTMdQu2ae+yOlj2lKkIFne+DGLSdRX8Shjm37zlEMUFrZSpRfgdN9AXDTQ7g8304n8S+cZ+ylCX3x0yxiCV3HeW5+AVh8ZIcZzLzJTgwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852742; c=relaxed/simple;
	bh=axYxobLrEUeHYdl48BRAqpExYcCmC5GjLRrR6i9h/1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/Z1khUJqY98035Fy9Igf8AASHAdADo7HXcXqQ/T1OyDNFpKfv6GQjcADMy2tbnItWgHmc5SKBzdiYLcFFm/WwCZN1yadi1fkoYpg/51bYrF/1jIjumvlAegz1axEymw+13w3QALkFXcSYNDuyzOJlZE00nuUWBiT9eyKHxEoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqzkEGnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC002C4CEF0;
	Fri, 26 Sep 2025 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758852740;
	bh=axYxobLrEUeHYdl48BRAqpExYcCmC5GjLRrR6i9h/1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqzkEGnFf2sR1w1qOTD6Xldroqh3jwG/UbPm+TnsgJu2VWLGlYD9pvIj+Ikw5DC3w
	 1P/3YFar9vTliRrmDmhxaR5BWF0C2eaPxspqgapZtfJhaXOphtjZaCj8gwQVx+L6TR
	 aHWlHXHqXjsYeHShU5gP9/y08cK9L4Oq5WRBKWwwQD++2JNVVKy9UTjVtPC9gd8CgX
	 x5leQanvc1i9J4fn4E7YdS3q6CuXDZ6Mu3DLrBQOatY40zH2zUn3KpoHeJuPKDUdha
	 Yxfun13e2dqNcnQw27e/IkOEq7lMnAsZ5i4dlrgiOLZPbl8i9GKqbWhX4P0AKnF9eg
	 p4G3T1whB0o4g==
Date: Thu, 25 Sep 2025 19:12:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Octavian Purdila <tavip@google.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <ahmed.zaki@intel.com>,
 <aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Kuniyuki Iwashima
 <kuniyu@google.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
Message-ID: <20250925191219.13a29106@kernel.org>
In-Reply-To: <aNUObDuryXVFJ1T9@boxer>
References: <20250924060843.2280499-1-tavip@google.com>
	<20250924170914.20aac680@kernel.org>
	<CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
	<aNUObDuryXVFJ1T9@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sep 2025 11:42:04 +0200 Maciej Fijalkowski wrote:
> On Thu, Sep 25, 2025 at 12:53:53AM -0700, Octavian Purdila wrote:
> > On Wed, Sep 24, 2025 at 5:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote: =20
> > >
> > > On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote: =20
>  [...] =20
> > >
> > > This can also happen on veth, right? And veth re-stamps the Rx queues=
. =20
>=20
> What do you mean by 're-stamps' in this case?
>=20
> >=20
> > I am not sure if re-stamps will have ill effects.
> >=20
> > The allocation and deallocation for this issue happens while
> > processing the same packet (receive skb -> skb_pp_cow_data ->
> > page_pool alloc ... __bpf_prog_run ->  bpf_xdp_adjust_tail).
> >=20
> > IIUC, if the veth re-stamps the RX queue to MEM_TYPE_PAGE_POOL
> > skb_pp_cow_data will proceed to allocate from page_pool and
> > bpf_xdp_adjust_tail will correctly free from page_pool. =20
>=20
> netif_get_rxqueue() gives you a pointer the netstack queue, not the driver
> one. Then you take the xdp_rxq from there. Do we even register memory
> model for these queues? Or am I missing something here.
>=20
> We're in generic XDP hook where driver specifics should not matter here
> IMHO.

Well, IDK how helpful the flow below would be but:

veth_xdp_xmit() -> [ptr ring] -> veth_xdp_rcv() -> veth_xdp_rcv_one()=20
                                                               |
                            | xdp_convert_frame_to_buff()   <-'
    ( "re-stamps" ;) ->     | xdp->rxq =3D &rq->xdp_rxq;
  can eat frags but now rxq | bpf_prog_run_xdp()
         is veth's          |

I just glanced at the code so >50% changes I'm wrong, but that's what=20
I meant.


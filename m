Return-Path: <bpf+bounces-78479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD3D0DAB3
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 20:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57C0E300C358
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1662C08C8;
	Sat, 10 Jan 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+DwUM4f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398611487F6;
	Sat, 10 Jan 2026 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072255; cv=none; b=Rilk1YZtOvjkzVqCv0KBZ+Gd0P2fd8O59ZQUBGJJD9rvuk+3k29NLOniQCKGNdPTcc5mwL9t7CC7NqyksI57Htub3hGRNJtYPxvDIWoMloXxJvr/YyNnm4VFsW918t1W0z3smUBK08IVvne7+VfnJCRzIfstQVZfs2GXp8Rnm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072255; c=relaxed/simple;
	bh=jvMLd2+xDvBad73V5ovapoHgJnezT8Gg6P+92jsxlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o33kN2yKbGpeeJsmDZPxvoWZvm+NKAm9tm71Mb5/Q472cla/kehSmGHKdXgMp95ZBq2s6C5woFQfUKhfsAHsTcGQQLMGK3BCJ+O6Wqsxf0UxLPFID7FQ1AVgzRb4KyFupU+XNNtIMYzi76Ef2SaWpmH2vGl76bFLTSALe+cV/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+DwUM4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02699C4CEF1;
	Sat, 10 Jan 2026 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768072254;
	bh=jvMLd2+xDvBad73V5ovapoHgJnezT8Gg6P+92jsxlSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n+DwUM4f1AITcQurzF1cqOXPVv2NjjeVAX0Cw8QyFUWKb8JtZ7OVaBx3H59dpthk/
	 sas4D1Yf0MNTQx76TWwfV2/e0sdufWOVJsvVycXF7vqQAv4KCaANmwma2gg0qaxik+
	 NjUKodNrWgaPCC5MdMH8jS1ehkOjU0fiD3w6InIsRw0l2gKTbxTc4jMemDKN6PmKui
	 YxUkUmsz+oaHwStBIdBCBOj7GTlJjyGEB4DdT/kYHIyH7b9/+0aihrsW2g9E+lEkPu
	 u6iFdZZA8v0udq2FgOyO0CHewWmpWWyNC3XtA7TZeZUzk1CVviCO6tfTRJ8jLP1Hk2
	 8/7jP96bX90uA==
Date: Sat, 10 Jan 2026 11:10:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260110111053.08107da2@kernel.org>
In-Reply-To: <2542db74-0e72-421d-932a-b1667fb16e56@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
	<20260106150438.7425-2-minhquangbui99@gmail.com>
	<20260109181239.1c272f88@kernel.org>
	<2542db74-0e72-421d-932a-b1667fb16e56@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Jan 2026 15:23:36 +0700 Bui Quang Minh wrote:
> >> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
> >>  =20
> >>   	for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>   		if (i < vi->curr_queue_pairs)
> >> -			/* Make sure we have some buffers: if oom use wq. */
> >> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> >> -				schedule_delayed_work(&vi->refill, 0);
> >> +			/* Pre-fill rq agressively, to make sure we are ready to
> >> +			 * get packets immediately.
> >> +			 */
> >> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL); =20
> > We should enforce _some_ minimal fill level at the time of open().
> > If the ring is completely empty no traffic will ever flow, right?
> > Perhaps I missed scheduling the NAPI somewhere.. =20
>=20
> The NAPI is enabled and scheduled in virtnet_napi_enable(). The code=20
> path is like this
>=20
> virtnet_enable_queue_pair
> -> virtnet_napi_enable =20
>  =C2=A0 -> virtnet_napi_do_enable
>  =C2=A0 =C2=A0 -> virtqueue_napi_schedule
>=20
> The same happens in __virtnet_rx_resume().

I see. Alright, let me fix the nits while applying, no need to respin.
Kinda want this in the tree for a few days before shipping off to Linus.


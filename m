Return-Path: <bpf+bounces-59652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F04ACE28F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E97189C08A
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BD1EB1AA;
	Wed,  4 Jun 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="iXdqDuZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19891F3B87
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056121; cv=none; b=VpbWa0HXs2+yABl7mvrSk33h/N/vr/ZqNg4uGMOtulxkO/yjfs6R8+0XmYigrzQJo1sz0hMGKFHOnamwdM7juPGjFOUNa5i7zZDaimYVTxxzQrUZyY2SyI4Z5OEQF89o4Jv10D80blGZzc7w+R5ZpVg4qqVoQpv4DFd4rb6HPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056121; c=relaxed/simple;
	bh=AM+A6P9w2wkT0X0Ss8sfC+rK4sLbZj/SNTI2K8QsSFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZkzcWsE1l/e6fKzTDJlREq/arFkfIM6BHzE8dWLylZedYphIUphTDe5kG2Blaf6nVKZ+fQpGACBbiYiud+g8TTrUqQ8g2ZcHr4BWfPvSzAM2YL4fVq8QNaJS9Wg+B21CzunUUxtacQQkbLVSCOEIxpHAoz+sqOGjhhk6jEDzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=iXdqDuZl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3124f18c214so53900a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1749056119; x=1749660919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM+A6P9w2wkT0X0Ss8sfC+rK4sLbZj/SNTI2K8QsSFg=;
        b=iXdqDuZlBH4gDyQQxyUTHepKQrLj73ZDyIYN5fhnC0YHLzKnBYRsD+LyXnLyYHPjlO
         GPaiBxrQQ5epRK0oeJc4kP/t7aY7HhHVENHyLD03QmoSxF77odqBo2osHWJcmvtUhXAX
         hhBi4s3uRpKFvQcyfJtSGAHBEvVmPcyoxENhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056119; x=1749660919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM+A6P9w2wkT0X0Ss8sfC+rK4sLbZj/SNTI2K8QsSFg=;
        b=SMwsyBObz5bBx3Zc01EKS5pvnl3vheMKWEfMLereMbbaMXqWkvpi/r3W9EsjioCyfr
         ov3rtudLM4eMfGuP6xY4JpmbeGf1d1oSjPwwQANpZN1Z/2jBrTmz+DU/i0UiuMovum4b
         cMnQ3vja3/HEsAPZe7iR5DCvj5X6hBJnaHp2n1PdoIEU3zXdpondVj1NJHfDnKqI8mqg
         EQd77cDeWCKmf4CXPSqzVNZKGZM73bwlfKJxG6CuCaw1LzlfE+fLf8NdKbizyJMWwt+D
         oqhwM++hNa5rDytBW6YUGNBf2KdOEnsKm+AroKUcjj4/LqNwlqlK9yS2uY2e1wrd1052
         vcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvwVjp6489ndKPGqHp3Kl4rziRWcYmJisJ5whX7m0Zaw8tQiuTjB9DA6jHDh/8TrPfvpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxyjkSPrVAbRn860nsp1DD9RDort2iQYSyh06WXNB6a9PKehw
	O42hn3x5XIbKAmdaXgjNXE9JkipPB8UkjUlPMwWbBXggHDU6OgTvfttXJa5rkLBSPjoSXd5qgln
	peFk2ikOmRDZddF0EfDMjP1fJmmAdL1b0YFklniIL2Q==
X-Gm-Gg: ASbGnctMPae4lZgw+Nu16GqxUyl82WNjJOgDdXg5M03p+EERtjDhoLWYh6j2ShxNHSC
	l8943343MAn1P6QDVg/xAmV8So2727Vkus0hhf0R/3TQ1m8nULvZ7o+l3uKMckKn2CYM8YQT5Jz
	lFNgvwFLfcCt09oGvCzyxBXviwn6ROsweh
X-Google-Smtp-Source: AGHT+IHSFm7AlkobZVkgSc2uHdOWwSJZnf8VUDuCELETibH45kd+R/oYzSGq4wkai7atxPvVDpyDGYc+gyHX+9/SSX8=
X-Received: by 2002:a17:90b:3d02:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-3130cdad8e7mr5604061a91.28.1749056118925; Wed, 04 Jun 2025
 09:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 4 Jun 2025 09:55:06 -0700
X-Gm-Features: AX0GCFuTjwtD_LQoMjFITQPds6k3nNGJ-eA3Q34d-mo_X9J99JpFJ2MIxKJ-Rd8
Message-ID: <CAC1LvL0xTSv9sBRYnD-ykDqQr+Reg7yB0uwAR158-+aAm1J1Ew@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:09=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmail=
.com> wrote:
>
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.

Does it make more sense to return XDP_ABORTED? This seems like an unexpecte=
d
exception case to me, but I'm not familiar enough with virtio-net's multibu=
ffer
support.

>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> drivers/net/virtio_net.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(s=
truct net_device *dev, struct
> ret =3D XDP_PASS;
> rcu_read_lock();
> prog =3D rcu_dereference(rq->xdp_prog);
> - /* TODO: support multi buffer. */
> - if (prog && num_buf =3D=3D 1)
> - ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
> + if (prog) {
> + /* TODO: support multi buffer. */
> + if (num_buf =3D=3D 1)
> + ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
> + stats);
> + else
> + ret =3D XDP_DROP;
> + }
> rcu_read_unlock();
>
> switch (ret) {
> --
> 2.43.0
>
>


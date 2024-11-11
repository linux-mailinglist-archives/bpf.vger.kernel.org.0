Return-Path: <bpf+bounces-44493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C39C362A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 02:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1BBB2214B
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E528691;
	Mon, 11 Nov 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOn1gRcp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418F28EC
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288968; cv=none; b=aU79I+IQDGoa3u4bjros8SAEvGbrz1aLt8k2q5aoqfPxBpj/H39AuUb8w7vOa8OUXvyOf9LZvniId9ALqXa6Zs7KNaisGIyBETlklBW09Ny/NOH7U330OLnmQBLpLCZrC71x5c5F2l0WmUqXQZ+gz+DAxaP4hMt/c6KeAxhupLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288968; c=relaxed/simple;
	bh=XdGLyjxBtq7skX/bK0TG/Xfwr3W5VTrng1jSu08x37Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHIFk45BiPVdKZbAixhJhcU004Amyw+2ZaDi9Bmgx3mVNRVageboka4UQ1J1CkUNwgow3paCu/n6PkJDSvI8s8puSWahGlIEbc48x+p5Uw+tdibQ5blT+cQyfTZ/zWeiMVvTWELmx2SAY2iFMIxuhINPQtN+66hpjRVhJh4lC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOn1gRcp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/dbATLxL2+itDhzJeEzYBm61TCf+9wmLBdg3lhJg1U=;
	b=SOn1gRcpMwA/BIIhJFwxbxbu/dGsXG/aJMzOnBl3UmLcH7tVxS8UCcpHMuO2YMrJbsjX4x
	kHW+VFG4HfDlCPO5rgn3z02IBieO6sX7BTo/7aUm9yN9m6za4DoT/UbijBLXVwkFI/Xkkw
	86p5JCtHrT5SWwe4NGCtI+OiEtvYHHU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-QW2o6jBVNHq4WOov3341jw-1; Sun, 10 Nov 2024 20:36:04 -0500
X-MC-Unique: QW2o6jBVNHq4WOov3341jw-1
X-Mimecast-MFC-AGG-ID: QW2o6jBVNHq4WOov3341jw
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7ee3c2a2188so2835433a12.3
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 17:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288963; x=1731893763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/dbATLxL2+itDhzJeEzYBm61TCf+9wmLBdg3lhJg1U=;
        b=QUyd8fzyH2ie+eS3yA8u8av3xF9Jb4gc8+w2+/7ERL88KSdgoPOwUv/Ip+6kgfiWPZ
         BCt9hAldphgzUIx5TS2CJzWZ8fYJQDFa/pOj5E3U+52lY6UHhlyAaYLnlSxBu31XtwxC
         O1gek38sdZUpR7CC6BPW/eUyfdxGjpIYnjSwM7hVlRijcciFstJZc/KKfiO1DYnS7MyE
         LNJXjG5ewbudc5QcgrGTr9pRlpuRpDN6Ymt/JDUs0lYyuCXfp0QKqJQOYgpIjrNHVd+M
         lpNFHXmfphzs/sz/m4KhSb6mMFyzU632Ow2phT0MoCSEgh5AVc/SBEcTon3IpjOmmmQO
         MVnw==
X-Forwarded-Encrypted: i=1; AJvYcCWsoGrGQjAlckPHhpy9IW8o9A6fuKwU5DcHfZgp1UEHH5kkjTa+8zOaI4PY8QHZSM8HDag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8P5w7O4qxXqAfSrUsn3+Jx6vJKSed3+rdcWtHFhiUHw83ARd
	RxgU6P/zR8RHkpTfLa2j89GRHeg/D62feP98moksA5JzE6Rc9T3jfw8vUkq6oB6uIYtcPryqAuH
	EhX0kqL3Aw07itg7Fl1boE4Pxn/Bnc5ywSQpqDDkFjw0IHDruRQMr1xmnxex8ebHDczO+YZcfXT
	v6TMEjF4xUnGOa3+/d7vAlBIGe
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id 98e67ed59e1d1-2e9b172005emr16972815a91.16.1731288963661;
        Sun, 10 Nov 2024 17:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0I8ydXA+f/porptghF/VJNNnyFOwaz2qko4ky8Boj/2OSboEeDKrdt8AhMzcp4lG0pNeDvvUUDBSXToarMbI=
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id
 98e67ed59e1d1-2e9b172005emr16972792a91.16.1731288963254; Sun, 10 Nov 2024
 17:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:35:51 +0800
Message-ID: <CACGkMEvzJiTTxibwrbGgdfb9Vq1xtYvEcvR9Y2L9UdOCiy77ug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/13] virtio-net: rq submits premapped per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> virtio-net rq submits premapped per-buffer by setting sg page to NULL;
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4b27ded8fc16..862beacef5d7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -539,6 +539,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
>         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLA=
G);
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg_dma_address(sg) =3D addr;
> +       sg_dma_len(sg) =3D len;
> +}
> +

In the future, we need to consider hiding those in the core.

Anyhow

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



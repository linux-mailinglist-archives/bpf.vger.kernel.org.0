Return-Path: <bpf+bounces-33323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784491B509
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 04:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76D5283BEA
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F418059;
	Fri, 28 Jun 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjqWOZOt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68B1E532
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541204; cv=none; b=MiLqIAr08DFN89IqlPKcEPa/n/WiBQRWtRXYqiYk3EVDwBPiIDAeZzngppPAuqb3kW9QKUYoGdvMAskQnTR0dmNqw9/QgyvO9iZLVNy2df9LGpdENERo/b50gGUwBql2nv1klhL0YYLsIlf0tjdy3zxJBdOfE7vhceJyoZLEPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541204; c=relaxed/simple;
	bh=IyvcZwLvMH1LDIrvjEGIG+jYOCuuqUJNM1j/g07hCaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4xdJsZ8QcXlViXF/xGBUImuSpgwMg/kcZ8XTqIiJkjQjIC4pmeFD8mB5JPj8vGWWRRNKHs/BbdAHQAo7Sa+N+hhQwZhxGx7XgwXUZeJcunAPGjdDIYRP68X8lR74thJGDs1+SyGbpWb2N1w6gOE/DV4EiYf9u4O7QyawffSX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjqWOZOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z2hr7qByC2mTYMhLQUML7Ce0IuOwnECsuHmZqQa5HI=;
	b=bjqWOZOt/FlKgdM9/gF1Ege2TyPNltjbaHyY7zET2ziZktwQCxshDcys5eyLtl0hPRcNYQ
	ftlmEjusyGVaPYZ43k8COYjCcRFVWZZzw/FkIcdIyAPlKZJvuE8SFkjHBePSgoOradtdkP
	4i+nP9sqIAiXIhpv1CI/+GlOEsq4ces=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-lXdqNZCDOTu5rj7yx_wgmA-1; Thu, 27 Jun 2024 22:20:00 -0400
X-MC-Unique: lXdqNZCDOTu5rj7yx_wgmA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c8c1912a3bso193370a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 19:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541199; x=1720145999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z2hr7qByC2mTYMhLQUML7Ce0IuOwnECsuHmZqQa5HI=;
        b=ThDZ1flinQHXSAGGmahtE78fbafTltNYz6DZGYyLwmZ538ANbkrtdJZEcjrBUIOaYX
         9x4jbExmWoY9jQmfcsSuiKjw2kTo89EZvL7k9UG9dY9K+JUfdpy1oT1uj9VBHrBCKnSb
         tOHNfSK2/VBkFjdGe08wDOtJiE6GlpZHJq3nWnCnT43s/20UADsYqchpo+/BofFUxmh7
         f9rH6+8q21qtY7kAx7G91YsS48Pkaxl0JScj69umtgyuhXGvsq4OmvoKg2Zw/o8wq2n2
         DGO2WjM2WOtGA5WuqJ9fSwumQbQyGn+A500nq/DYu2b0BzbrnR6dh0R8HqbP6Lnyu6By
         LcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCRDEFl777sVMdEcABTzjzpQLTZ30pwUE2JDTz6Bs7ClYuidrFdBpGqvLmPWp3yJSKuL8AkSEhvDqdiy7A1N0fttV4
X-Gm-Message-State: AOJu0YyPaftrrn2YpJKfYcgca0tlerZSjoImAlWQEhpHe9iZXgKm273Q
	s6yiNzn46F0nwcb4s9cxAiFvYw4Q2Phe34YQjhGcXvkZC04SYepf+G/Deu5BC9BMYrfJeT7NI2r
	BC8PkhvLZEJt08XKaHwSu/17fSFQcEr89BXdhnmWXT8LPYRr5J68BP6UbVXZn1jn51PqXaFrS/5
	qkXLaQeagScojppvT+8LCSdSXJ
X-Received: by 2002:a17:90a:7c4e:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2c90b728a9bmr2003095a91.28.1719541199553;
        Thu, 27 Jun 2024 19:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5/zEyjOCLMk6F/yC+JpyRh5E74hlN6uELe5uVDpgwKaegpyWDK0mLVAiiXRu5uGm1nnyYoqu9TewCz5jroHY=
X-Received: by 2002:a17:90a:7c4e:b0:2c9:b72:7a1f with SMTP id
 98e67ed59e1d1-2c90b728a9bmr2003072a91.28.1719541199123; Thu, 27 Jun 2024
 19:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:47 +0800
Message-ID: <CACGkMEv619mv1mMWEU4W5vh+=TFMfHGj9r=mBZmm81VRxc8UcA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused
 xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Release the xsk buffer, when the queue is releasing or the queue is
> resizing.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cfa106aa8039..33695b86bd99 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtque=
ue *vq, void *buf)
>
>         rq =3D &vi->rq[i];
>
> +       if (rq->xsk.pool) {
> +               xsk_buff_free((struct xdp_buff *)buf);
> +               return;
> +       }

It seems it needs to be squashed into previous patches?

Thanks


> +
>         if (!vi->big_packets || vi->mergeable_rx_bufs)
>                 virtnet_rq_unmap(rq, buf, 0);
>
> --
> 2.32.0.3.g01195cf9f
>



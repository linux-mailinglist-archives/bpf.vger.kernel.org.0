Return-Path: <bpf+bounces-44008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A923F9BC458
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B6D1F22110
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FF1B0F18;
	Tue,  5 Nov 2024 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2N9/dQE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95469126BEE
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780971; cv=none; b=BDBHjVjKiDDpij32vQph5mnfF/g7NIue7TdQRj/7wDW1N7tBNfkd3jCrfCCHRgXVUBSjxGv3U2TlYrhA3V1aJqGQplPHrF/whIHr5gvEclElgjio6aZB6qD6FKkvg8L4fO3Zli5fzWzfEhwPJlk/T+sncSrEPyHd3/Ib7cCoGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780971; c=relaxed/simple;
	bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndUEZ4lCqmnsx4G5Y68m7APXNdEEFshDLcZ9skajY/0vGbThSKqV2PkEDeOlbCX/ZzgvZ6OeN1qCM1em7sgjH0GKONTATwLzPPV7YDT5oAwj7JyeiZVejOJej1DEv/aj+L5fYIRusGrTtIez1Gr9MKrUTJ4BLe1Aec8vttrPZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2N9/dQE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730780968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
	b=W2N9/dQER+kFyE9hKKAfKPmjUg7IbWFYwO+7e5fyYX/OiUgaTi2foynEUofUwFm2JvfZbk
	DEVte+aeSqO6ZNsm3bBokFtSdVKicSfN3PnHbXC13BFEAhyvhBh1uRwCPDcGXWg/8iudjq
	0KHu34ScMlfmuwgC62UgrfaBDOQqwr0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-oabM6cEbPLyh4PpzvRUrJw-1; Mon, 04 Nov 2024 23:29:27 -0500
X-MC-Unique: oabM6cEbPLyh4PpzvRUrJw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2a9577037so5191164a91.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 20:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780966; x=1731385766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
        b=Pk3vMDudlFzvnXM5786Cj3OW0BhTgvl4OSDHfZLIPS+Leb+mzZoNtMZ08ZjI6Lt13F
         UqLWLR6WoUOcgr5LWnqSIOOYaB7z9DTSOXvulXSLFIu53k7Nrl9/5gBN+QRW1NT50If8
         E9OSgq6BUUn5cx4Wuo58USm9H3u+IsggTAN2h8eiI1jdQNvtq2lHIWGJxX6AOo50E8dZ
         SAnqhuoijxlsaWZO/3bD6A1fC3OyYdQ6SA/UBVaiSls+kVLKCVjV5X0KtVsLyxHdb6kh
         8FnULErUHN0m4UejctXBrg1EyWdwvSLrq3hOmdqu5WnXtxY9cnaJHrmrOPsVKxt7ygVi
         VMxw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSdxtj6UnyLy4kpvsgbFcVMdzC4pdocz4ccbvrMYINFgRjLBX2Afqm+daOSiRvZIxS0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFn5XKV0wcLSt43zH7Icq8lPtNqFXeVjfBMi4M9Qc6mV6wm2J
	rxfkcauHTfZZ3ogKgbpXAlDToRiIIs4MJJCSNv/wS0CBorATi2yBePaqawCOVu6OKgqb4VsTJXs
	POeP+/tGfd/G1BI06KHw7Pufz1vY54rO5aXyi1OwRdVWztHOHTVW4bWqUftx/yt1dpRpgSkqMY2
	HHXdKbdcT9jp6utGRKs7fYPaxs
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id 98e67ed59e1d1-2e93c1a6cddmr26138143a91.23.1730780966379;
        Mon, 04 Nov 2024 20:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlfBcjEUwY0jgicXD/Etg/7eX+icEijhUmPf3OjO6dPGL41QsO7QKLssoh6xABfMz8aXhIphYCx3Xy3KfX3CY=
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id
 98e67ed59e1d1-2e93c1a6cddmr26138115a91.23.1730780965914; Mon, 04 Nov 2024
 20:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 12:29:14 +0800
Message-ID: <CACGkMEvh=tFAp2gXmtCgaTGn9ZTL2z6oiA47TNysqkro3etZgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/13] virtio_ring: remove API virtqueue_set_dma_premapped
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

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, this API is useless. remove it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



Return-Path: <bpf+bounces-44492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D049C3628
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 02:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432431C22E62
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6EF74C14;
	Mon, 11 Nov 2024 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AY8ICHz/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9E446A1
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288883; cv=none; b=KSesUIjBTbmhMclgmDdqYlgxkRNQLysb/ZcW1B+lfEMHZZwdbx+zWpkD/hnZPE0oBa1rasnRACYAjH/cpWyoayzFtzLxqRwxBpEmr+B5o9ayjyqHpAiDxhrL51US0xVa/Ge4N6ZpJRJ1/oAEbwtySBlHlyT7/C+gTPtdSdrdbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288883; c=relaxed/simple;
	bh=SwnYr0wQUUCUjeABHi0X22mCkb+XL7pmujqjUXf5TNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6993KmycYWeN38zvhRKIYTrVSN+UpSelGFWljVbxPDHU5aMLhFYwQPuFwdhFc8WumW39/uEx1u2mZz1VkXnux9RLDChufmO65jQLD6I+i/NkMCnAS94jR+28aNNW6LHiMuts0Ra4rKJWb6LRtVFkdpAd8pYJ0R4QgcnJzFi3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AY8ICHz/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5RPDPPvEC+nbrsIFTdBWydQ3ctDGSgyhAGrK+AzGtQ=;
	b=AY8ICHz/pdIGEds1gLob7+a98PDpyvm76bsT7WlBOHSIdY7ogiiI/MCPdX1niKvFeoEvM0
	MhQ0vMQklaRSbMXFK0j2klRzJTQ2qw2s8IWBXz7e2EaHDzSk9rIdh4SINtSGMq82oOaUBA
	YPkQHnT/gCcQ8STow4DAqsSye5LmaFU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-vFJIBiaGNGS--N_3McLlmg-1; Sun, 10 Nov 2024 20:34:39 -0500
X-MC-Unique: vFJIBiaGNGS--N_3McLlmg-1
X-Mimecast-MFC-AGG-ID: vFJIBiaGNGS--N_3McLlmg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2bb354e91so4002638a91.2
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 17:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288878; x=1731893678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5RPDPPvEC+nbrsIFTdBWydQ3ctDGSgyhAGrK+AzGtQ=;
        b=hhE2K2gOjOuFVgB83NJoZ2LN+MU4xslBPpejYcRcWs53+cHZ3Makg26CFrTdICHrPv
         xCp+e5j5wO1sAnF7Eke36pZ+K9hKDFs4snVonTgejqFl77M1xKHOtTwOzgopLc10jmGi
         37t7gbJZBJfn+UuS5ITaJsbkvzWQfEHEv368ZZdm5B5WIVulAC+oXEyJoZJihdKIS/ej
         7a/9xeav9auJ5SxOiOaymfNSTQZv9v3bQXmzwdy5q11Xcq3vSkpRwsE9qoMj1ecoEXcl
         PYqX5/qRR9XbUGeSfRJksGSkAAvMZcUU2WdQJxY3rMvfPRAkuLynZlpDUgMkfn77Rktj
         julA==
X-Forwarded-Encrypted: i=1; AJvYcCXzzdONvl8ijFp45tYlUjt38rGPAvCTADtXbiqdloHp4mpqXWyS12reNYvJEXqc7JjvJL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJBTpl3+yTMZUbu8lKi7E5IgwL1QbFruUSrTx180wszna8Ena
	kYXMf/GyVQCkcMBzWFclWg6QuH/mNB9tqchK9ZLu42QPbGKz+J0nFvfpUiW9iVkX85qFsEtgWT3
	OWmsQtfUsr1Omj92V5AbE9QfWQtW5uEnsp9rhQMXR8bEQRS1hEgZmTRgeOk/BuZEPPgvK3dAx97
	h0jqEmc1XmFQf/tLNMFa/Aiq1x
X-Received: by 2002:a17:90b:2e50:b0:2e0:74c9:ecf1 with SMTP id 98e67ed59e1d1-2e9b1680c50mr17180803a91.10.1731288878173;
        Sun, 10 Nov 2024 17:34:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKXVjG4ufYVtO/aRps9dNj08hlXOSoubtnDRnq04HNDaqa6AaAntNV6i56o/HhaPf03g09YFvoYfSVhfn/uuM=
X-Received: by 2002:a17:90b:2e50:b0:2e0:74c9:ecf1 with SMTP id
 98e67ed59e1d1-2e9b1680c50mr17180759a91.10.1731288877541; Sun, 10 Nov 2024
 17:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:34:26 +0800
Message-ID: <CACGkMEvwAte20vZjw-apRO_8+f+dy-Z070yoZjtzPD9SY=VPUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/13] virtio_ring: introduce add api for premapped
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
> Two APIs are introduced to submit premapped per-buffers.
>
> int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
>                                  struct scatterlist *sg, unsigned int num=
,
>                                  void *data,
>                                  void *ctx,
>                                  gfp_t gfp);
>
> int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
>                                   struct scatterlist *sg, unsigned int nu=
m,
>                                   void *data,
>                                   gfp_t gfp);
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



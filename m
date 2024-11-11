Return-Path: <bpf+bounces-44491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48E9C361E
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 02:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369D1B22323
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 01:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83384137776;
	Mon, 11 Nov 2024 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao75DeHy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7321364
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288710; cv=none; b=alN8QW40u6jRk9VP7zOduKT+yR5e+wbZo5fjg0Edx4z4dKzb2aBZdls+WcEyR1X7Z572h52OBO5qeuWHZQvskM/pWeiuw7oDnbtMAS5LMnd+ZfMYlH58KP6Crhl87xdE/Kux+SHdq6PLnKhONYyKdYYt2XG0GEucYycyWvkj/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288710; c=relaxed/simple;
	bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlNghMMewc7jlNCqaRx3R7AqB89MPxbfenjj4llnmd3SlnwBkhPk1F+KuspjMPn6wChAjVSs8VDSfbDCU9cH96Urr8RKZyfBjv4Za6lYQJFD3hXU0rj2eOhBpMWHv38RyU3T6L267mjPX4+ed541XTUZjzHG2NtjOP3kw5+mejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ao75DeHy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
	b=Ao75DeHyc7ewPSfhs2CzUNPmtawvolvKoI27Cqd1y34qSVOVMJ93cVTjgdHpo4ZyaWY2+M
	KP8P870i2GmOxBgfvpCxfxEn5YmhPorKjxVOsDpwcqLmgM0GS2D4b872KwU0Dfql1tZmPn
	9w2srZXgHVgWegbDLlspeCrcgvh5rgQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-I5iKKIxfPRCklphsKpsraQ-1; Sun, 10 Nov 2024 20:31:45 -0500
X-MC-Unique: I5iKKIxfPRCklphsKpsraQ-1
X-Mimecast-MFC-AGG-ID: I5iKKIxfPRCklphsKpsraQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2ebab7abfso4037397a91.0
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 17:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288704; x=1731893504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
        b=sQC8bBnAAiY1tBZGkGXGARHlrGF7k4XARVFZ2iVe7qOGOhKtOxmBtfN/Np+ZEL0H9Z
         T/c20fqmMEcRKbN8AC02ujz8TKlIoBoLg633Yw4WcWf9JxLO7clvo0JvZ54eKjpgxvWs
         oCBLjhlgYWFZJYXGeDENPhMKoTbRm8v6tj2wkA1e945CoR12O9A/lFxXYhWMYOg+CSCQ
         Mnl/yuZljsohiMmyHWZ4mhW5zAA2nBFJNIuqE9NE4MazFEtcR+TVB0qmTi3kgvLb8VQ8
         daDHrtaGPJlD5S1xheb0LSc5pGwLnPrS2PmkpjJTg2j9b/nta/EW1uR1vQfFX7igbAPW
         7igQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMAnoYm4SH+95NJJk/ZIrnaOKoZmqgZhoL/Dr5QZdjjF+4t4hG6kfiu+PeF4yKlNLDR/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YysBGLck/aee+xG6H/hpPeX9pDrqBoZ9REeCbgg1Bhxp2amdBBA
	S3e63seTXyGYKhbMLGyrAUEPVwmpxT0wEHOrbsvMH9DZNEMeSp7cZTHjhuskfYxuH6mp9Lov8ug
	aw869X93JgAqrGraUxEMmPS06jNXyk6FlD8lQUxX7uKIkmpMvaBRQCMKwEumF742y77Za/apSTj
	Q38JGAttZe9492nCea2IYw6vIT
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e9b1ec3ad9mr15212839a91.2.1731288704296;
        Sun, 10 Nov 2024 17:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ45A0a7VJ+rtoKCuZ3Xjxf3vbO+kpA+QpYKgLnefQ2pNNeyLQuJUHLmrx4bENZUF5kjBfviP3ZWmPxNU8h7c=
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id
 98e67ed59e1d1-2e9b1ec3ad9mr15212803a91.2.1731288703869; Sun, 10 Nov 2024
 17:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:31:32 +0800
Message-ID: <CACGkMEtj=D7OPL8hAxJumhVL8AwLS51tm42t0qCxzGhMa+psMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/13] virtio_ring: split: record extras for
 indirect buffers
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
> The subsequent commit needs to know whether every indirect buffer is
> premapped or not. So we need to introduce an extra struct for every
> indirect buffer to record this info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



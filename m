Return-Path: <bpf+bounces-61722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6815AEACED
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 04:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342537A4594
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698231993B7;
	Fri, 27 Jun 2025 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+OpDwJ8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6078F2E
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992217; cv=none; b=lLWcVS4ojGUjwDo0TLMz+9lo1BZ671ZQQUAqM+irZyfZkYQ5OGfFzWTDCgAmXa6tZedDLghiVu9P7TKvlI6Q8VOWnZE3x/31S/bKmTwRRuESAHSaSxKCegSvJqNDZdIr6WmD8TP1i3QeDg2jRtWuzmh64g8goW3o+rC2wALo+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992217; c=relaxed/simple;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYksmrn0Y5qUuovUGM3W/xAHbnYFXot0bhxDUv6k3yjzkEx7IAQC6VAYy8NJhS4sXWN2jzanEPu5y79vlRIqnu0JxWIJPnzcoX/NwBKIbkmMfAhoacX1y72IBEAwTDpRQW35d1DWnF7y23hxdgKt5PHSk1qbIOJl/TtW9y8AaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+OpDwJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750992215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	b=f+OpDwJ8InoOr8JvoeuHxbODQk0deDxL8X3f+/xEylGS2Lac9HO8f9BbGjU33L6z2e2caC
	xuJafinTLHXaeLRMu3UTElGML4az6V/ipbfDkmA7sd65FxjVMSKQp4jselapY2+2WG/YmX
	0Vp+fgbZ2FvOrpX9kuXYUrh5J1swJZ8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-44nhwcQ8PUiY-_woQdgygQ-1; Thu, 26 Jun 2025 22:43:33 -0400
X-MC-Unique: 44nhwcQ8PUiY-_woQdgygQ-1
X-Mimecast-MFC-AGG-ID: 44nhwcQ8PUiY-_woQdgygQ_1750992212
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so1633298a91.3
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 19:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750992212; x=1751597012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
        b=OV4I/QD5bvVSvKzbYckYRagKS2EmZ+JqN3ebCrZJRNdGU8C1mpsW8/WAfXhg/Q6bmA
         oLu2pXsd8nVuCsQaTgkn9Pfosnl2+KnO3xES/mEqnI29VtzDDm576mqm6zOHD/4Y+xmo
         oEi5twSLBQSqS9JUgop+VDGZ7vWUt//Wton5N0x97bx/F1ad/qZbTIOASQeOJxAfKNb6
         O21PWPaa7b1wGsuPd38VqrjS8oNN9LPrAaOphKUpzd1N4HNgh99JaJTjvuI8mHQq4gF9
         VvTrp4HfdWuizh8eowcvjyi8e1fGHSOMidGrLnJfc0EmhJuFRFwk7MGRmyHtIzsVBvhs
         KBXw==
X-Forwarded-Encrypted: i=1; AJvYcCWbgBQgjiDqxdClI3m6au0TmWFld+gB5v/qWG8r/kENewthSxXHXN9DJV6k/5WEdWRAj9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySsnelsaU7M+g+lRKfP+/KQURZjReS5GQLB4euj+0ilpA7LxXt
	nwVzmgfoWLLtFoKMTAO8glXylpxBcKCVcZ27EFMGeojAtFAS/ps4tsht/OGEaewmPR8MZPyiGx9
	h4jWRWMfYdFt85cd0i+Czqwm6FbPOnYw4lRn/UCxJwUpjgDhMrmEi41ppo4d42OLTNS0WW1o+no
	Ra9xOBSoxlxbFShLAEChbmkd77NJTd
X-Gm-Gg: ASbGncuKpySYQeMXVB/OaLCWi1YOqmOs/GJHLY/UfgQcxxyhViWG98ww2dFksoEwT0l
	iEeoue2NVHLGs5d7s5antOY76U/bLeKz8Uqkgd3LBtx8eWL6Ylo3F1ZI8L7NU6bUeLFqGTKMHzC
	Pg
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-318c9107a53mr2192664a91.2.1750992212424;
        Thu, 26 Jun 2025 19:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJM16rdnxRskTxwuXyeMZbSoBcs9q4++zM+ywcskISDMXjQ0J0UHxMNSH2KE2x3C2uBazsSFuOebCMbQTd6Tc=
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-318c9107a53mr2192640a91.2.1750992212056; Thu, 26 Jun 2025
 19:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-4-minhquangbui99@gmail.com> <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
 <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
In-Reply-To: <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Jun 2025 10:43:20 +0800
X-Gm-Features: Ac12FXyeaiRss6v-acFo0ljDViofeaY9eNXnTbOP2WE1qi3Xv2JlKX1swLORs6U
Message-ID: <CACGkMEvf18Dmo5Wzdq-GnJf-jOrzKMQ7epZA+ssWPzXvCnCXvw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:38=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 6/26/25 09:38, Jason Wang wrote:
> > On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> Currently, we have repeated code to check the received mergeable buffe=
r's
> >> length with allocated size. This commit creates a helper to do that an=
d
> >> converts current code to use it.
> >>
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > I think it would be better to introduce this as patch 1, so a
> > mergeable XDP path can use that directly.
> >
> > This will have a smaller changeset.
>
> I'm just concerned that it might make backporting the fix harder because
> the fix depends on this refactor and this refactor touches some function
> that may create conflict.

We can make it a single patch that contains:

1) new helper
2) fixes

as long as the changeset meets the requirement of -stable.

Thanks

>
> Thanks,
> Quang Minh.
>



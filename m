Return-Path: <bpf+bounces-61931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E961AEEC60
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A24189C151
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12B19F130;
	Tue,  1 Jul 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XitJT7rM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918B1917D0
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336410; cv=none; b=tuGzVzTHa1gf3FHX3Ais5AhmszWd6fD9hjjy62adg5ks1UYoEytYvgbvGx9asozT4YoS6uKDjyB8bH87u/8OkJ85Vx0P6QAWXikNzXHFKkBezG8TBR4XcKuE2G5ErlWOYDPuz2a1zYpJfx+rmtLUNqMEcZ0mVXFnQtbjo3h7u/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336410; c=relaxed/simple;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3LRxSpRjRUWv6qXGW/ITV0OMaGTELg6YDeuZXtePPMzsARdV6k9dSPuQoglwSNIg51CRNpiv74TyWS0/hVvO2m1nQ6jmU4P8/V+UxSW7tWMUCNqzH0k+M2Ic4SqlpJQJXo1oDiyqginTDCUgfcf2TdZwOgo4JpLDriHD2EQnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XitJT7rM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	b=XitJT7rMcVfVnvFvEtiTtsObSRPFK+a70L5scblewEeMF8TbMA+mhgVzETLB0tobE4VrZA
	mbEOHWZYl9pEa70KxAP314mQdty7ITBqKYq2cbRKGpJHzIlaokjTde4rr7YypwAxWMJRI+
	ffhw6htbZjLLQUaMAjYEafXX3btQSdE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-wGD1PnusPWS-0PhnNaIkkw-1; Mon, 30 Jun 2025 22:20:06 -0400
X-MC-Unique: wGD1PnusPWS-0PhnNaIkkw-1
X-Mimecast-MFC-AGG-ID: wGD1PnusPWS-0PhnNaIkkw_1751336406
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e6fa93343dso441971137.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336406; x=1751941206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
        b=haf3qRrf9NkB1QukmF6m2DKcVVEmCB09lRaQhiUacGq2tJwNmk0OxK0UlJwjJLQBgg
         OK3SxA0s8rHZ1qgmrnKiPvwJoeWmzqKsK3yhVKWbaGDFdROcEwHL1o1O4CZD9FZEZEwI
         fC8SPKREAVWXWbgU8nI8q020Cdk93yM/q5iYD0IJjFznF06xf+j35dRhEdbrx22Xgwcb
         82S70D3d/8OkFcIximLxLr99+yzDvUCn4H27aNqnIhrhnVUX+ji1QedA50Qjor/wX/1U
         VL9M9Gt9y6ByFM6U0SSkor4TakTRz5Z9zl8oF66LhKz2wqqd6pTGcPFL0hcvzBuesU5+
         7fyA==
X-Forwarded-Encrypted: i=1; AJvYcCVIKqZQ97vfa+NoG6qJoeWrIJ2zczKlAU2BB0e0WY6fTF/OB7m2FBfVerUNfeZnQtfySIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmeyRdH2K7qP11NwMQJ15/xIY27O/8zLXTpZwOwTGwq8ypERFq
	bhKa06rOYTkSCG2xM5gxaf52X6LCU71NXS8RnDSMx/36HlFPQ/tX/0Xl0k6LYg80NtbbldLHYze
	CvNoC/oM1mB9RfS9zNVsCjeAMAUgtkSbAwCk6T/Yg/5nYEjR8DpS5Lk1bvWNx8/2eCiqUcS1b4W
	FEVNECLBeYPqVkbZO0w6Q20CLn5j9t
X-Gm-Gg: ASbGncuC5aieS7Z26YnUhykMoSMmQIZ755SiioyNJRpoKUqGBL6kMykxKJQvhgxcNmd
	4ezn+aNApUsBKnLhsxdNJhgBbSx2sOcuqObvtI2X7PUFlb5wojk4ZGOGppasqp5WL91JFh7fPaI
	IX
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id ada2fe7eead31-4ee4f57b220mr9035436137.6.1751336405884;
        Mon, 30 Jun 2025 19:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfwt0IUN9XzbcPTMYkve3OC1WK/0fpTeOcXovTvrlwz1DP2O24mIjCZg0vVcRzjUe2M01DvNuq273bCwcQw/Y=
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id
 ada2fe7eead31-4ee4f57b220mr9035421137.6.1751336405513; Mon, 30 Jun 2025
 19:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-2-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:19:53 +0800
X-Gm-Features: Ac12FXwg9udMXpdfqk8skCNczA1b4cFLqKAJ_PlRVtyvo3Mi9xA6wAsp9nIVFQs
Message-ID: <CACGkMEuJk=PF2aGQj4FNhSv=VvOTzruK6PMpEykB9MVHwU4nDw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] virtio-net: ensure the received length does
 not exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:42=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



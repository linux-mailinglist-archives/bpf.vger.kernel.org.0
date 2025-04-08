Return-Path: <bpf+bounces-55442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110AA7F677
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088873B802D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196F2641C3;
	Tue,  8 Apr 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvZlmC67"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78126139C
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097691; cv=none; b=GopgAUcnqbKc57Z8IJ64HmWrvbPKB8AOBgtGXnnqNBA3g3pumux4rTKeyRPFhpNXyckkrlgXDBmCppFXJVoSIUP7TjOpu/cZoE0M/abLNrUK1Xql4UPMvVdYBYmXpxYeC7O3s+nbxG1MbtJngxjVJHiw+Evn6RftphrnTk2VDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097691; c=relaxed/simple;
	bh=Zw+nvfP4oH7YCpjyBFjQXUE7wWFGLtslccfPR5HCSeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfA3HpeBv7NB6lAnkwOFdOHvMV5kIE3eY9sPQ5CMGjh6+hl/wLjdkGLjOzXCXKh5qwxUMAp4DiU56zv1Aj+5WLVUNKCsu1KM6extbq2qgBPyOZMc0+IWOFqqa6A6f8Bn0pGGgj5cm7jrs7o8wMkO8/JIoL5xJx3ZqkRNKiT60gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvZlmC67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgX/95pHI72BHQsp4Gb1Pk041dCapFrrBn2uranICwk=;
	b=EvZlmC67CykixpE2Ell4fSedXehwJHGU1lwhsQt9fo6jflnpRKstIA1iNn9nJC0qmkViVw
	tYSVul3aMqRX6uRZ6Xkttd8SOlGzANZQo1SznS9BQIEl2I7H3kLbQIog/yqTkOQt22DXGl
	BRqhmSqRx27GRnYImLH6FgWh8jCzAOM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-iZOIhx8tPS-QrzGvLj6L6Q-1; Tue, 08 Apr 2025 03:34:47 -0400
X-MC-Unique: iZOIhx8tPS-QrzGvLj6L6Q-1
X-Mimecast-MFC-AGG-ID: iZOIhx8tPS-QrzGvLj6L6Q_1744097687
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736abba8c5cso6748710b3a.2
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097687; x=1744702487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgX/95pHI72BHQsp4Gb1Pk041dCapFrrBn2uranICwk=;
        b=KblN+o00qK0dQ823shTbSqlxmDE0a+PK+qCODgtNgvforgPmPVimeqd+xWsbs9j/5L
         eS0xC4ltoBkH9vVurMtA0IbHFdkZFDLllPe6Qv32fWnl7VqLARUz1jUSqWZwCSQevizM
         jD96CGshmH27HiU+ZwDYLFtjBaV1z8e4xq2FxzakTQ2DQf1/bw2GK+QtukYrjFThl2Eu
         H9Tm5pk1LJIFX3yXsyxSw/4QAB8Lb7u6Q5xzSTIMfvIrhBBLYQTWQsdJIKw8+7SWQssH
         PaF1KSl0TZhxvnA69kScRSpIBchi7Dn84aHYVtKV5LSnuoD9nrbZ73/BLSnTllD2F9dX
         p6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXzmZSmqZ/QwVr0oLGaQnyWiI+GJ7P28qzzOsnJnMX6y2R5wwQWXJIuaB4TSy6vxuPwxsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ua2FSYmka7b/x0hNqM4Vb0acKXlvhnnXvwExFimzX4DztKR8
	NehJxUzdeGlvx7gOqXi898JEzSm9BKTdsWeBmLGPFrOgLTPf2771JYkmy/Wqinq27FTlJsBUiVH
	zU82H96JOlLLSwKKASYZNrfAr1F2eg6zWVZHI/IkNWoiBVaTXtVNm6nklZvvPzj+hAGQxSAI4UR
	IdWtMnbij/dFkHfqoUTyLeApR7
X-Gm-Gg: ASbGnctJl8QGSSH+wAhWZBERzq48Iw2vqdVh5HEfJ17ioWoIiP0rlc2q11aaVI0XRIW
	1EGHRC0D4suQ3go/o+b1YlFQTu5AkGwFnbJM7DBS+r+4tuV+ORaVj5yiSnIwY1ZgDKl0QYO+P
X-Received: by 2002:a05:6a00:181d:b0:736:520a:58f9 with SMTP id d2e1a72fcca58-739e71136bemr15844024b3a.17.1744097686696;
        Tue, 08 Apr 2025 00:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEebzBktuzT34vutceE0Q+8ZimqM8gtaIQXLjH55vRIG5tqmEkA55owC0umuPvdKpOAEVEgy7rBakY9cJp/e3c=
X-Received: by 2002:a05:6a00:181d:b0:736:520a:58f9 with SMTP id
 d2e1a72fcca58-739e71136bemr15843995b3a.17.1744097686309; Tue, 08 Apr 2025
 00:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com> <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
In-Reply-To: <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 15:34:33 +0800
X-Gm-Features: ATxdqUHgOtXPv8x4ai3wnnr72S-UplgKPeU7AsldG5nqKrldqkZgJy1CXzhAwHI
Message-ID: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 10:27=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 4/7/25 08:03, Xuan Zhuo wrote:
> > On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
> >> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> >> napi_disable() on the receive queue's napi. In delayed refill_work, it
> >> also calls napi_disable() on the receive queue's napi. This can leads =
to
> >> deadlock when napi_disable() is called on an already disabled napi. Th=
is
> >> scenario can be reproducible by binding a XDP socket to virtio-net
> >> interface without setting up the fill ring. As a result, try_fill_recv
> >> will fail until the fill ring is set up and refill_work is scheduled.
> >
> > So, what is the problem? The refill_work is waiting? As I know, that th=
read
> > will sleep some time, so the cpu can do other work.
>
> When napi_disable is called on an already disabled napi, it will sleep
> in napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck altogeth=
er.

This needs to be added to the chagelog. And it looks like this is a fix for

commit 413f0271f3966e0c73d4937963f19335af19e628
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Jan 14 19:53:14 2025 -0800

    net: protect NAPI enablement with netdev_lock()

?

I wonder if it's simpler to just hold the netdev lock in resize or xsk
binding instead of this.

Thanks

>
> Thanks,
> Quang Minh.
>



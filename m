Return-Path: <bpf+bounces-56292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364DA94B51
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 05:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7B16D4DE
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F752571BC;
	Mon, 21 Apr 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwUxuK4h"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40232158524
	for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204637; cv=none; b=FmTv/TvB5WZjMtF6bHWDYunXpXFin3rKF5iJcvpAGbPAlhV3L8fVtbMIJEkpg1D+DNc9e6Tb3VNkv3W7v7TyUSYTCSNYoid+IsFmpOQxCjWGO2DdFxyRpljoudFWm4qsDCtLE2zAkn8REFVM9yP19mpaUTmBKle1uOTl9+uQPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204637; c=relaxed/simple;
	bh=Qr8aYaNg+4LPUFYtFSiJL8vs/bYQwNhv1687v1mNwC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq8CjvSkP4lJMVhZxyqH73uwrHLKgJHvRuKwWPX8V73lVoFvnmf+06Y1xSOhJsW3qnkGPqdmNYC67QuBP57G4iWtlkdvNuMqp+l5Z/XeSbL2WswKxkYMvGBYSyw3QA7Hrc/xWOggMGVCPWsCOCJrLGRzzahuU/lBpCODiBG6uaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwUxuK4h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745204634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLXDtRgA6ayDeCz1Y6vWEq0hT6V9yJ+AfUHP97mEHh4=;
	b=RwUxuK4hO3q11StluSzGTdt4eZPi8wAAtYWR1KW7jlDQHhgn/JqxzMS4O3XF1s4kBPXaJK
	QuCfbipW2xzk7xj5Bk/zdvWl8C6VvZ5wZoCbKeaZ7UpeulPGj38hKPTJBtxo40xxVFIhXd
	ikt34FCaey9RCJsI6uVenaZM6Ep3Hqk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-XtBq5vBQPHCwiNRM8WUAdQ-1; Sun, 20 Apr 2025 23:03:52 -0400
X-MC-Unique: XtBq5vBQPHCwiNRM8WUAdQ-1
X-Mimecast-MFC-AGG-ID: XtBq5vBQPHCwiNRM8WUAdQ_1745204632
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30872785c3cso4935716a91.1
        for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 20:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745204632; x=1745809432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLXDtRgA6ayDeCz1Y6vWEq0hT6V9yJ+AfUHP97mEHh4=;
        b=riIVIEh1M2uqXRLpenm/FLTOQOAMONhroBY6awFT6HEWmRII/qbNl6XOqnpHxugLQr
         PXiWGs458E9avVLJI9Oux7nxHTGgj8ctQNhjNIeHJ09O6on6/LKjXcxw7EspQZmX7EDU
         1LrnjKUv/NTlZ3UIk7D7MhEqvfWd3ijRk3eVHqJOnpTJWs1/eUGG4Te0dWPNPpZASGNT
         4MNBIoXqsur4T0CobNPBTT1Ac2rEwwqBtYILk4cld3LMeFxtEEjDEyuk1yFBW3PBYfBG
         I7u6VuyrYQdoQxeMwWD8lxqgeauTZ/qw1wQAw6ZsuuwZdsNJIoS0tGIcbiI8P3+TWeji
         1X7g==
X-Forwarded-Encrypted: i=1; AJvYcCUpDIdjwAoR81oFTMkZfClBLFdaJRO4Tl7haUK4T+6YAXkHNREUChxKQwWGbrW3vSDJjEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB85M97iZG/A8FU07J7AOoOTAIDNnum/IHrBId7RJIR8lcY2n5
	qD/kcyRQsiTq4N/LNYD3ASYOaa3iZ028zFufK6/yxWPmpV8h++Yuodr+cUts5BWVjXYeMTJfih7
	P1nJWBuEy3m0dl7VeHug+K6/2+B3f4udlWsFiulx6W5Dz9ExG9qex9KJBAIYZFzAzewjXDLG1mS
	QXqSJh1ln4Bs6RPpr7axJMd5vh
X-Gm-Gg: ASbGncvdT43xkim3qhwm8kkC/1gOBo+CVLQXoz/E7EWwuazY+gvrCnah/mAV9eHlzb7
	fJtTO8pmOLs8cDjMrXVVcqXF0rc6hb6QtTRHrY12BGSI9U6IHYMt0ho207/6Gw6gRXFg7Fg==
X-Received: by 2002:a17:90b:4b89:b0:308:65d4:9dda with SMTP id 98e67ed59e1d1-3087bb6e794mr16806369a91.16.1745204631872;
        Sun, 20 Apr 2025 20:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZtnoZd7x/9jpKNzZ+LTBMBCaS6scxdcgAj8rPFvVSJbcKlGfoHCLn1pYbSk8Af1Y6oKwZSBu3haMJ+dnfOJM=
X-Received: by 2002:a17:90b:4b89:b0:308:65d4:9dda with SMTP id
 98e67ed59e1d1-3087bb6e794mr16806325a91.16.1745204631397; Sun, 20 Apr 2025
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417072806.18660-1-minhquangbui99@gmail.com> <20250417072806.18660-2-minhquangbui99@gmail.com>
In-Reply-To: <20250417072806.18660-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:03:38 +0800
X-Gm-Features: ATxdqUGyEA9DUKHVB0iflKLulL2Ewuk2b0N8F7M-x7RCvH29fTxDE_M5T6xkicU
Message-ID: <CACGkMEt5=r_JbfHeU=dpk20F5uE6TJouTPdKUUScYtQGfAw1tg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] virtio-net: disable delayed refill when pausing rx
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi.  When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
>
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
>
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(In the future, we may consider switch to per virtqueue refill work instead=
)

Thanks



Return-Path: <bpf+bounces-44497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98C9C3748
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 05:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510261F21E31
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 04:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEB32C8E;
	Mon, 11 Nov 2024 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyRvFfv9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200F13B59E
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298313; cv=none; b=Wd0tEn2trZ5cXOv8IGDyDvfyVIPlOsyytICmUt0s1vpMsHFf1jbub+tWSY76e2jf1x0J1sfjGiAA3nN2fUCMrKr+TcNjXFTdIJEd4w5AgWuwYmACvvA37U3ja0rEZgPSdvBiD46Dm0w1Xf9QExSdB85a3n2fYzbdlvEjM2z9uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298313; c=relaxed/simple;
	bh=DLATnqdMGEF0WqdmHPcRRNdo+OHNczLANGm8ldMNdG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY7IOrkaBJTGcp9TRmfdpRjoWRhtTY/lAv5cn6xSSxxqmP5o8YNrXGBjczBeu2lMP1IhdNYh1OpIFLDBSV6jVlCKkLsAYy9dTGoLT0zFaGexOASTjRpPGqAZMckb8QxACGTw09mWjoMJeRNwnPmpxJi/We8TtwnQTOfTE8KVDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyRvFfv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731298310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2GV+7EwQ9ZLkRfoZhE0lui517nfX5U3dHrCpkmZzho=;
	b=WyRvFfv9q3JdzjVKWHigeNYv17lVooPtTn3eKh17NeRmWve2C/hV+T1kBqTwDoBWIkCVCQ
	hwJHzecelG0ndhWXfKTK6Lm9lBuFTPO73YaFjflhl0+z2PYtW+WjBF19CLmoSCWbi0/L4t
	dZJPwh6DnYxqmlHknpomXfGywCPrqWs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-u07_eKbQPUyDs73T-Ix0FQ-1; Sun, 10 Nov 2024 23:11:49 -0500
X-MC-Unique: u07_eKbQPUyDs73T-Ix0FQ-1
X-Mimecast-MFC-AGG-ID: u07_eKbQPUyDs73T-Ix0FQ
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7f3d8081c5cso3964287a12.0
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 20:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298308; x=1731903108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2GV+7EwQ9ZLkRfoZhE0lui517nfX5U3dHrCpkmZzho=;
        b=mCt6vElUkB5R3I0gSRZmbRdLiHrqHWwc2h6fhQNJCah8HgXWl5nNC0fF/56AdJqGk4
         AyQfKtvLY2iFeoGA+dreAT+SWPXnjhvTSpgcvBIB8iPa6dIZIcKe/IYPrZYSeMM00tk4
         cX6olrTAK10yrMA+QvLVvlJVaYRBuZwmwZYVDhmJR+n1KDEM7eXKburLcYaX7jMYWU8B
         cV8efXYztFPnoebf3cdwba5iBrJ90AHZxlyFfqzpTFDg3BDbxxEDf8AWRjkM0QPwUROb
         7x/l+hCiMGjGqujJYeYNoprA5sQu55bY3x1+S4ViFLSakDYyQSasNDIe2INaLDa/yXYR
         2+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWBWgwmzzDZjuVbyF014csLfoLFfytIjFKV4EjI1F35oXrW45BFvww0FknW95R6YblM2xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1ESQlg0Jx2DwQe0EdFqn5AN7NJ0z//41hqb4Vi84swBaOHqp
	n2H3CRi0YjpIsZBqUyKPhxMyOSRrdLBxr28zWxYM7ngt8r4TLTX3G4dzidMSRNwdSEcEQJB2LZC
	6IyYFmbS6Hub896IvmW6BdTNdL3hGySjKKkEtrXkPVj2HNwBZatNReKulhkwXjY6AZMXt8a7GPP
	0iL9yoUIoV1gsPSyFUTSoRrMO5
X-Received: by 2002:a17:90b:2d4e:b0:2e2:bdaa:baad with SMTP id 98e67ed59e1d1-2e9b1edc2e4mr17018416a91.7.1731298307832;
        Sun, 10 Nov 2024 20:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc7ZYwHnxrg0FC/Z799Zoc1i4Spe4Nhk9xnNGMzEBDcw/KeGeVkU4qh3S2hfEgAgRusgumV+PhOR6e3ykmQ5M=
X-Received: by 2002:a17:90b:2d4e:b0:2e2:bdaa:baad with SMTP id
 98e67ed59e1d1-2e9b1edc2e4mr17018376a91.7.1731298307416; Sun, 10 Nov 2024
 20:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
 <20241107085504.63131-4-xuanzhuo@linux.alibaba.com> <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 12:11:36 +0800
Message-ID: <CACGkMEt8wd=tq0Va=BwmZu20LFv59oegpAD2VzfLM8vaZJw+NA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/13] virtio_ring: packed: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:53=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu,  7 Nov 2024 16:54:54 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > The subsequent commit needs to know whether every indirect buffer is
> > premapped or not. So we need to introduce an extra struct for every
> > indirect buffer to record this info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> Hi, Jason
>
> This also needs a review.

Sorry, I miss this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



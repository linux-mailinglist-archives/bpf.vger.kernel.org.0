Return-Path: <bpf+bounces-39792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E298797774E
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9E71F25667
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B215539F;
	Fri, 13 Sep 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGanXMuZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52537126BFD
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197769; cv=none; b=FAF5UYq0T5F/GEOUvvdjUGxy/L5z9+eZSYoReWbCHqqRsf1UuhoK1ar1tmaSW8zpySfVgXq1Fdx7MUBFOrMo7ANr32Vz3x1hMz00gRqee1VsH+shQlYNBtMKQnz5S/VEsRey4SNX3h05Yh5nFQBamTQDdqHfXyGBMrxAdu1e5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197769; c=relaxed/simple;
	bh=JxfGljSjSQRs8vlX0n8r3Q3hgopbQWHf5oD6iS7Yruo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z86DEbch83ORtsIsBH4XewxPG7Ep60lww6DuhE5AOFIEcClb2bq2DuiLLuW4XYQipAnnv7YSQQe+ZKq9UoCVUn8IrxydDzYR313PZvQefd7iU1RY3iKMfxiMLmhQu+EhwQdNHaobFcT/VVu3INjySQZ/k7EadENyo/4chaLkpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGanXMuZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726197767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxfGljSjSQRs8vlX0n8r3Q3hgopbQWHf5oD6iS7Yruo=;
	b=eGanXMuZDkercP4/lq2vtV0FinKLNGdejdko9j+GUzcAwBkX67/65VnxcGRI1zjGJmpER0
	7LGkx/ZY77G4sb3VgaA3ih9Sq2NcrvQv/va3B5LIXZdyxR18VuaKpDSeTOw0R2YdVMWdog
	NIBvrewnVuRbJbJj4OzigPmIEjxu1Vg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-rHlxIyFNOtSuE_GzOXNyCA-1; Thu, 12 Sep 2024 23:22:45 -0400
X-MC-Unique: rHlxIyFNOtSuE_GzOXNyCA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2db24468f94so1704999a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 20:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197765; x=1726802565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxfGljSjSQRs8vlX0n8r3Q3hgopbQWHf5oD6iS7Yruo=;
        b=wa5z1oHRkxL2FUFmq33NalA/VI17KiNPDrh25GAR9sQtrv8Jrtw2DRvbOk5tEyEtmc
         9F5DKmOX3KqhsBpQhLapIJZcSaTpkOVQVxd09oBvPlWDzjD7YVpHkNvkyM8447pdBx0i
         DelFpc8eJI+H6uJ7foANLqlE5bx9uqT5pc8HDV3lAzczOOziVxczCvUxG9LwiemKPCeI
         k543US/ujdyNuFIXa3Yu+ItEu7FS1GmWnB8zdOVmb2WVwUul1sSfH/YAqCVc+zQitTY+
         AdM9CHTwmOESwWx84VqGD1a/3+KhcQOUCzHAkLL27ZHuHHaOpSJnYeeZ9TYBqoAYD24b
         JY7A==
X-Forwarded-Encrypted: i=1; AJvYcCXlOutq0eW1Zu9LsGHUMd0ZGoM0ftxm+m/V0wS0NJ12cb8Znxy6GPzFeuZASMBneW8/Rk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnqe/A9pQBAOG3djBHCC77PeioKHTF+XRwjLd1sbnimgPiWucQ
	l8URUUN+78Ssm6ruC8zhnwV+HGPL9r1WTYha1gt5mDkJ7IJxABW1ogR5os9n0RYRhodv52ep1H+
	HJTUOtUUg2V1QlZUTy0bbLPyaOWzS6K3Qteu+0M6eiuHLX/F0IJ/UoaJnI9Yg9qhYNFvBKrTsfJ
	tc2AHCHlzs4XZrtiswy/h52bFa
X-Received: by 2002:a17:90a:10c2:b0:2da:7b8b:ea0d with SMTP id 98e67ed59e1d1-2db9ff798edmr4938509a91.8.1726197764798;
        Thu, 12 Sep 2024 20:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDSyIn5VZqHXbLGqF9GP9md3dx0oN9Dsc2ZtabVyYIqEsNVyWe39BP20d7CIwnjjaiSDAzCq0nv5s0j4jTZmc=
X-Received: by 2002:a17:90a:10c2:b0:2da:7b8b:ea0d with SMTP id
 98e67ed59e1d1-2db9ff798edmr4938487a91.8.1726197764304; Thu, 12 Sep 2024
 20:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-8-xuanzhuo@linux.alibaba.com> <CACGkMEuDg800zy+-W7VRY5Ns4COsmvMP_kpHdzJ-ws8PuMoGhA@mail.gmail.com>
 <1726127409.3427224-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1726127409.3427224-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:22:31 +0800
Message-ID: <CACGkMEuK3WEDYgeS+WvW-pb9NU01AXt1rxPQT0QsPgW4qu7h6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 07/13] virtio_net: refactor the xmit type
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

On Thu, Sep 12, 2024 at 3:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 11 Sep 2024 12:04:16 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Because the af-xdp will introduce a new xmit type, so I refactor the
> > > xmit type mechanism first.
> > >
> > > We use the last two bits of the pointer to distinguish the xmit type,
> > > so we can distinguish four xmit types. Now we have three types: skb,
> > > orphan and xdp.
> >
> > And if I was not wrong, we do not anymore use bitmasks. If yes, let's
> > explain the reason here.
>
> In general, pointers are aligned to 4 or 8 bytes. If it is aligned to 4 b=
ytes,
> then only two bits are free for a pointer. So we can only use two bits.
>
> But there are 4 types here, so we can't use bits to distinguish them.
>
> b00 for skb
> b01 for SKB_ORPHAN
> b10 for XDP
> b11 for af-xdp tx

Let's add these in the changelog.

Thanks



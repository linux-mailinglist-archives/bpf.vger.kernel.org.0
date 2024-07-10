Return-Path: <bpf+bounces-34353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C592C965
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4034D1C22E47
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3453BBED;
	Wed, 10 Jul 2024 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPEvNW/c"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1171219E4
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583094; cv=none; b=NLxPr/gwfgnWMYGtvp9lnTnn7rvUi5i/imGB0sUwaM7He9wFHMMdHljxSyN/302y7wGv6Nk51ILGIBrUptmtQV20bc49Nf8t0YXkLIlk15uXeKYVpNT9AWv4idGv0P0cH8Ej8vXuTXO2jGOs8FGdptrtcJjH0AEjSpbIPv40w2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583094; c=relaxed/simple;
	bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwvMDo2KpBpnSqYbxhF2BhEhUqg5b1sf7aj72SCJavWESeTRmDpwwQOOaI7M3U4T+puKgc2zVlIPeCgmbdu6lDpiBBSKB5MnsyEAifRBor/kmkO8qkGlsf/8mY7jOEEJxTifgfeJX1yDLlQ8XlRapwnZQ2Ao/26rIvz98KNfC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPEvNW/c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720583092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
	b=RPEvNW/cZpFaOJLu7EwPlcD1fqvOFZq/QY7gndxZ0syqflRbpIgr7FY9FvuBGtN7ZBNGEm
	dNwNDypMkF++15tJc4Sa2YqWMWt4mG+8EDa/O2xGdE/VZI9PDMWET5jIjuuxq8zM+uGC62
	1YiIo4Fo49gAuUi7VmGS8T8plITOT7w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-JP0QK1IFNxaeD0vUG9alRg-1; Tue, 09 Jul 2024 23:44:50 -0400
X-MC-Unique: JP0QK1IFNxaeD0vUG9alRg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70af2ac7557so3722568b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 20:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583089; x=1721187889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
        b=lZlL/bs3v7szwuleYmO5BQDZCTuI6PM7ipFM7u+BtMx5zYUdOItuGUtY16eKUAJwdX
         9vCqZhahVGFknnJAFaO1qO+g60fS9H8nZ+KGNavYPvb2dx9tB1S5paA52AkbzlCI1zbg
         N/RPzBXD59Ctkadi2hoLoP2bCg5dexhFF+HbMwW376+0I8yQQ9W8SzcBLxhj6owmmyn9
         Uy56ql1Ljg2HO7ob2kEWov5GbKykSmc0kDzNpJfqzlR1n3CCuydXPDGCum+vxFLuhy45
         K5aRihfBwGeu/d7YAUrgMtWn/5DAZHGeENvQpC+oPs9NdLvgFUkQBKinXNvadm6c3kJT
         Hffw==
X-Forwarded-Encrypted: i=1; AJvYcCX5E5Uoq38wRF3T+D15ARKACezliLQWcqrnTpgy4OhL4A7pMoMb7mqxuIwCWlGnkHqj6nxI2y2jPT2BDx/NVks+tRNU
X-Gm-Message-State: AOJu0YzaDDr3IJ6WEpJQOrikCKQC0huDyGLwwBQDf4jaWTI/CrzIrFBY
	PHzLoRsc3C3OFdmh49Z9wbwC+n0DO0ylkUD2jmsbBflYdgL7HiEYjzinBgYrFctpnjV38q8LvMA
	Dp8Gy3lKJ0Mq7OHvoJcUTnjGNhHXU34Ic5tyI3w6JOSi6WSpvttlVXqRjURqeMEbkaC9HzRkzDh
	eEjDxuGLQUn1qptfM/f1w2cUt1
X-Received: by 2002:a05:6a00:1304:b0:70b:141d:4a9a with SMTP id d2e1a72fcca58-70b4363223cmr5525293b3a.34.1720583089389;
        Tue, 09 Jul 2024 20:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6DK5RquFuxm9UxpTrrMYhpGVKkxyGGgB00e7KDYNJvf+PSSaHyWY1Zlws4I2c/WC4UdEyl5u0hefWLqdOSq4=
X-Received: by 2002:a05:6a00:1304:b0:70b:141d:4a9a with SMTP id
 d2e1a72fcca58-70b4363223cmr5525274b3a.34.1720583088933; Tue, 09 Jul 2024
 20:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com> <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:44:37 +0800
Message-ID: <CACGkMEtfd7ndOZt4M3j7yNUVYtnu-c9n02He59Cq+1_ML9bEDw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/10] virtio_net: xsk: rx: support fill with
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

On Mon, Jul 8, 2024 at 7:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



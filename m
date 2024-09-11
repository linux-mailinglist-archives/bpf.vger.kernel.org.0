Return-Path: <bpf+bounces-39577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663C2974929
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 06:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D7AB243FF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 04:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE14D9FB;
	Wed, 11 Sep 2024 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAQeC71X"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757F18EB0
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029252; cv=none; b=E6tObfbah8yV9wdUeO2Z+X+AIRJMsqPfZ6XfZdKalZqMfv6G3Q+tBylya9VP+I38S3dZRQceKggyHk25o1vUFBoMcDz6MHM73yBC/hJRwSzfIzZDGW1NrlkJQq42zMHp7InePpfZ0LppFJ2tgC44g1zK3NBvdiUp/CA21zv+OF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029252; c=relaxed/simple;
	bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrCHxUaOCq4CAdIe30I8w1zj5t1S9rM0lJpXMzjxEJoeG2FJCy2A9MkVDJywhUF1rB2RVBHrNOAhnCrEQTKv4vBbE9QkB6l3X/W5roZfmp6P1EpXD3be3vcQmxMEYgmDjIJMZyEF1/lPraM9BF5IXvRGqsWUroFs3Yorm27n3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAQeC71X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726029250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
	b=KAQeC71XnSCFvL/j75J1UracQTYHK1rlqWh9InUWqIIhffgQgssrJwf0kvOCRrqaxKjQy2
	CXVzylT6cWtFLDJCAzCXjZLDpROd4Dw+7KX5RaHsgFddH90zqAXBmb9ja3+rKSFTahIY4y
	8b2Trx57fZFf1F2vZhK4VH3BMcy4jnE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-BTy0D5GJPr6H5qVpzcRRfg-1; Wed, 11 Sep 2024 00:34:09 -0400
X-MC-Unique: BTy0D5GJPr6H5qVpzcRRfg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8a1e91afaso6528895a91.1
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 21:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029248; x=1726634048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
        b=PhCtjtFMIsRmT3atxEcM6Euk4bXr3896VcRTsqe6aognxqN3UXcG+UtuhDpJsThhVK
         ariaUj/8WA3LVnxq4j5o1qmQJhBlM3VU20nKJ7IF+iQQOyYDqis/bMLfgJfDozUgQltK
         MkXTpkmuRNwdHwRUpLpGqZL8vLMJ1IcXWu8i1Tue7/MWg/9twJLfam3chhcNeS7GY+Q8
         NmApC1YHq9pvbAr+wBkuTMk7bbAp3t2vTPeTzCGImBBZygfabuo97dgmrCy8dta8nCi0
         muNVGnKBZ1wiNqBuSB100B+MOrK+vRcegdL8gNpVhG4fGW9SW6ajp+XoK3zv7Trn04pX
         Xosg==
X-Forwarded-Encrypted: i=1; AJvYcCWwGGWAtBoW3CifOgkekNxeXi0kGj0KCa0PJ20ERwiYMQ9F6FvOBEk9sUOgPlZOoOnmoVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyctRa5CBhlAS4bhBvRjuYiSPp1rKudCjHY0SCeoUEqS1vS2m
	XQJuVsZK2CXcSnQwCgg5zUusov14jDjtOKuHWpXNinlFoE5jIBliqrxIyFkw/FRhwrFJF9lTVcs
	9z35U714UUE7+rwWeWa9f5wOvMrkvLWPCdDZErBWvG96x0Bt9GRSNm0/aSeQomspxvj5kQhVFvq
	rz0OQ60Plv/a9eMgSa6zBxhuc9
X-Received: by 2002:a17:90a:bc9:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2dad4de1446mr20491870a91.1.1726029247892;
        Tue, 10 Sep 2024 21:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4dNpS061+8UBWJdfO4IW4pNByqIXVWRmPrQOcYihie9tMK3d9z/PWSXQpp8WDx1xdXMfMmMHr5f0E7S37Jk=
X-Received: by 2002:a17:90a:bc9:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2dad4de1446mr20491852a91.1.1726029247513; Tue, 10 Sep 2024
 21:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:33:56 +0800
Message-ID: <CACGkMEs44Xa2ZUbAr9Db2a1M6Q_EO=DeRnDdiTNg368mGu_zdg@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
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

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we supported AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to

Should be "support".

> xdp_features.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



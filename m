Return-Path: <bpf+bounces-44112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC69BDFA2
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 08:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19244285139
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B651D0E21;
	Wed,  6 Nov 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+hJUMs0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496481CCB2B
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878959; cv=none; b=P4nk+KQ6Gqj2mbmjaxxTKMdWq5YxKEmrHmcX+UDZT2xYb1UUB95DCj3vdH5KBLhePJEDFHh6aj0G/ltBKWUs8K99iBlmPDXUTzCZKQWAFKsOxBFfkUDbY+wuOWQxxp+9qVRqiaG52C3wN3sgBm/cxv/faGI8ZBofM1xX3Nc/rlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878959; c=relaxed/simple;
	bh=87naFhcpflzvVNi4oKK41OMWqAcB7NuYDDSruv3y9lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SikaDkVnBllH1SwVySjRknyUTws9/Tqef10v7UvSLBA8MkNtwFQfEGOPeOLPMkhyV7JAooNgKdn6WQfml1qyglZlxOxMGqLSylGyP3MZllpA/1Ol8zRUp4SqyMlHTr7VEhnq7+xWT0TY924TRd7B2YAyZlOFWKCLTudvOxeGmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+hJUMs0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWR9zcSGFhCX887b0B/GPsWncKD7+3L6Qhwgrepk+0M=;
	b=Y+hJUMs0/xVR377H1SWJapVAkNDqjYRutHl8a37QvpW+rKpB56Ca5VacJDOLIoeUF8kQ+4
	xJ+M8il/9Bm1bdgCUS7PIJPsBpDUjxyVJVdN3EzYmy3xFHfoqygVvLO5opEM3Ehx/Fhfhc
	8TdNc9QNerIH2U2BelTbGk/3cIp97xM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ex5ZIl6mMJ2AW2D0ZKI1DQ-1; Wed, 06 Nov 2024 02:42:36 -0500
X-MC-Unique: ex5ZIl6mMJ2AW2D0ZKI1DQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d537292d7so4312708f8f.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 23:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878955; x=1731483755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWR9zcSGFhCX887b0B/GPsWncKD7+3L6Qhwgrepk+0M=;
        b=F/DHMs61l6LSr/Mlgq1s5xlMd5Yt0xXF6akId6bBeNg4zppDH8GbNrNFAxfgwZXwAX
         /37YNYjDvu9N//jRljgPCElwyzFOCHYpGu0eGXGoPVu5WsTpZJZY9aThXgATV6yA4TJe
         hKoBiZ5lFGIv9MLVGkiYxbQYgOwGUDqHVXiGd6YIiwmERqGihmSEhi2MoZ62cwTWhFrW
         Foa/JYcoLx8KGPgpl6L6i775y9epKRSdsrYp5ENXlOrXf/Z1wytPjBTBfn7qvWz4M1Qe
         Tu1/ytPrQ7D2TFAaZ9e5l3hRJFifMwi5j8YGg36lEtksuFMS/W7ijJhLN3Sr/zFk4qH2
         0ujg==
X-Forwarded-Encrypted: i=1; AJvYcCV12qcawciSvHNqEz5eElpKtzkSsU6tCflIG0mwaf2ZNx97s8vOxcib2mt4yYj9LpL9e0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2IjoVsZ2OVy6zfzSJeZ4f8CRTDXmog7WhisOqnPFAYg9zS/5
	rJhiq3VFYgLptrlhkY7bQkNxdb1RdLqWllNZCUe1RmKlhsBQfA5O22/cw52xgN0gUM+ChxwbweN
	qVCGD8B6lZZIOCtluxlCJI1aqugKZ3f22UDiXFOFSIGcbaIHXYg==
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-381c7ac4120mr17584452f8f.43.1730878954809;
        Tue, 05 Nov 2024 23:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgNtqpF0tJni5pYGtoHDDU6pOi20AGMmYrQIEMtMqT7zuCSRaMIZpdZQj9fUZ5DU6Gb1R3xw==
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-381c7ac4120mr17584441f8f.43.1730878954464;
        Tue, 05 Nov 2024 23:42:34 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49dfsm18389413f8f.46.2024.11.05.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:42:33 -0800 (PST)
Date: Wed, 6 Nov 2024 02:42:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
Message-ID: <20241106024153-mutt-send-email-mst@kernel.org>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>

On Wed, Nov 06, 2024 at 09:44:39AM +0800, Jason Wang wrote:
> > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > -               vring_unmap_one_split(vq, i);
> > > > +               vring_unmap_one_split(vq, &extra[i]);
> > >
> > > Not sure if I've asked this before. But this part seems to deserve an
> > > independent fix for -stable.
> >
> > What fix?
> 
> I meant for hardening we need to check the flags stored in the extra
> instead of the descriptor itself as it could be mangled by the device.
> 
> Thanks

Good point. Jason, want to cook up a patch?

-- 
MST



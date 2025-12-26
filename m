Return-Path: <bpf+bounces-77449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35553CDE6E1
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 08:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDEE4300E026
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313E285CA8;
	Fri, 26 Dec 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbB7AuTM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnCgc+lX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAFF23D7FC
	for <bpf@vger.kernel.org>; Fri, 26 Dec 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766734670; cv=none; b=gJiXVpxJINjFG/JzF/LnQ/UuCa2WnQaFYj9LWICQekas/JjMQHxOPFDJvnosAKx9JarI2/24IS4tJIhVACjSjKnW4aTMmkA3Y2+oXHP+Cm/KC184ONB/ovdmts1/N1au+1h888bSjt7IXMSCqNjS/C93GAHvYF2VQ6G4/2rtQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766734670; c=relaxed/simple;
	bh=0rmvrB0jFA9AqaRU7FDxlBBzIIKJKv2DCijQxPr9ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgMRY631K5+8qpmqq8T+g8S1crog4Bs98n7DUIFYsT5NMjtMI9sky/wLkH8AESE9q3m0sh+EsbBxiBLf/qz2YrF6vnPtktO30FmysBlo1fhsVBI8pOTDBacEpM4fYWB6/Cdb3V1vaex15cCkIK/GNAA/VUbm8G7dSQ/GCaGPKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbB7AuTM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnCgc+lX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766734667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
	b=CbB7AuTMlsg6cj5qvAMo5StUAHfZuv2yHKqxN9BMgBT+AuMQXQacOBLSDVnH5vru9aycwg
	ULY6Uzxnr7Dp/yZu9XGqVe10kkUCz5haLZKoEakKxKYFd93POLROpB7VOUTKC+EDtghrTy
	55smT0tfcwgoU2UDNqGWQmYoEUtL+aw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-_LaOr3oYMVKB4zFLBc6uvQ-1; Fri, 26 Dec 2025 02:37:46 -0500
X-MC-Unique: _LaOr3oYMVKB4zFLBc6uvQ-1
X-Mimecast-MFC-AGG-ID: _LaOr3oYMVKB4zFLBc6uvQ_1766734665
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776079ada3so65284725e9.1
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 23:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766734665; x=1767339465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
        b=YnCgc+lXfH+0r+B2EAfv/hl36yrFbaf9AkldYe1iYNcfYhTD7DE3rYrMuZX5cUlNA0
         BrzTZw1tQmo1vhUi1dd9UFoXDgthxNEctISCYnfkPaJlKGZC+7uZGQUZEVBdlLMw0uG1
         6jZ5eezUCnu/CzCUZp7x6z8mHBUBz0qIsCQ5M3gJS8JBOh+Xb3xu/i4ZKR3gTGDNfAkl
         6Tg4bRbNxxD/Bn6inHm4bUedwMaZMI+HqcDGcNOZXeBsog68aC6FrtZ9SxeAymX+VN3h
         yMXtFIFM/693GQ7J9Wczx/GPuZAUTHA0ji1INh7fTSFTHjtCf9pSuYtU8od+ftsGsn4m
         l31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766734665; x=1767339465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
        b=bQvFHy3KwzJgZRWGGSdJ/QRBbEplreOmFO5VE3ET77+AQSG3/au7l0QeflfyedKUTJ
         Yh7xWrNN90YW1oqV48LatiLHllPcSt+Tgun3LwLFJDX0LjmFACp+D2ZZp/nGoaFP4MDH
         /yg5xjxKlCDTG8Ox9T2IwDZvqtKp81jIUGRUtRAtpZ9caEAL6VEuUk9V5orUjDwwQsD9
         nPcFp6NMyd0DtH1TlYKK87ThNuOexEfYotsT85Qa7PHYotovfOwpoak30ARq2K9ygudJ
         Q0Fo/BU0LZU6LrzNE/MzeQrhc04O8lkNpuToYOZnEAA3kxCvFRWokju7rexM/fD76pOV
         e3fA==
X-Forwarded-Encrypted: i=1; AJvYcCWURa5PiZy0dYNhrGzO5zzYHTbMSosY+0HFEJgcdBcFnwIbq9MkpvRGhTDUCmdZRY8IJ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvX19kNrdJat/mPBxnQ7PmdzbKTAHQ0rhtNg1cOssC9XgFuJ6e
	qzt0VVPC9uPkasmQSJ/1ffFJbS2jwDYkPSc4V+xqcDsPY5yjSDIhGd6+YpCIghMatCtfH/AXr5k
	Ll8eCFolEJRv7PWRy7WHNvKXeHWUy7FHuhlYwSaNFPhBuK0OvDo6e+A==
X-Gm-Gg: AY/fxX76H6SjxB+XIqGLgQrAjzCTv5xan/RFSlbhbOEyZHZeLqY5uPYhAEl0nYhWUSU
	evoVEAG+r/WQlMSDzeZm8R2GSEcO8ataquL/FjSqLxZa5xyx5ezi9wigXBsxBBTSdE0wVh0fF6D
	U4TeMaa3YOmAwnPZ0XGqOF5DeCmOqOnjMfay5nWNITIQ9ibN4ynUss/sDZfASw1XDU9pXNZKXoD
	bv9xi9xvhTYHQoOMWf6C8HOM0kw4imLZ4p8oRMmGZN9qAEUnG0ozEFqd4hcZfL9F1WaraAuyfjJ
	asNeOkTY07eoRkT3Z9mi6vv0Z/NOpcgF5SLT5uEmpPGOgmxnkOgEoQGY+Hxr+YTaIDqV1ZqUcbB
	qVWMWhDjuLJix45L1xQE1+SPUZN1G6q10zw==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr226258695e9.34.1766734664670;
        Thu, 25 Dec 2025 23:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpsFWjeude7gy71vuh6vSWasoySUpj/LvWEgjphgTCKyVNexu8UQ8V6vCGw/Jfq9ZpZj/RgA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr226258395e9.34.1766734664223;
        Thu, 25 Dec 2025 23:37:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm363228075e9.4.2025.12.25.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 23:37:43 -0800 (PST)
Date: Fri, 26 Dec 2025 02:37:40 -0500
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
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251226022727-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>

On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > > > the refill on its next run if the refill fails? That would seem much simpler.
> > > > > This refill work complicates maintenance and often introduces a lot of
> > > > > concurrency issues and races.
> > > > >
> > > > > Thanks.
> > > >
> > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > >
> > > > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> > >
> > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > mlx5e_napi_poll() did:
> > >
> > > busy |= INDIRECT_CALL_2(rq->post_wqes,
> > >                                 mlx5e_post_rx_mpwqes,
> > >                                 mlx5e_post_rx_wqes,
> > >
> > > ...
> > >
> > > if (busy) {
> > >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> > >                 work_done = budget;
> > >                 goto out;
> > > ...
> >
> >
> > is busy a GFP_ATOMIC allocation failure?
> 
> Yes, and I think the logic here is to fallback to ksoftirqd if the
> allocation fails too much.
> 
> Thanks


True. I just don't know if this works better or worse than the
current design, but it is certainly simpler and we never actually
worried about the performance of the current one.


So you know, let's roll with this approach.

I do however ask that some testing is done on the patch forcing these OOM
situations just to see if we are missing something obvious.


the beauty is the patch can be very small:
1. patch 1 do not schedule refill ever, just retrigger napi
2. remove all the now dead code

this way patch 1 will be small and backportable to stable.






> >
> > > >
> > > > Not saying refill work is a great hack, but that is the reason for it.
> > > > --
> > > > MST
> > > >
> > >
> > > Thanks
> >



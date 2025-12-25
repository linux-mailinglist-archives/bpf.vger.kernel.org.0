Return-Path: <bpf+bounces-77443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C8CDDED0
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE28300FFB0
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68B320CA6;
	Thu, 25 Dec 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViwvvIzH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PP772OAK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079B314B7C
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766680073; cv=none; b=uNwjRMLQHzZziYyS5qEwtWMCB+qT4ODlnQ0mYmjo+vIeTy1kSgUkeQMxDGGvafXo2cJqUoF/loih3tMn2nMhkJjen+xSt2p3jT8zmLZBZTY1tuHxH66wRs7wxnie9QcPJ5Wlopproz2bST+jGjKqU2aqJbaL5zzVO8aLeq5ZZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766680073; c=relaxed/simple;
	bh=pktztNj0673p74dCRRu3x40mLqPXkmk8e3Tl7TzacCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONoKRXJ73v7aS6iFPE+Tag/m1sHDNJyYprMXChazmWZb3uAZxX4UCq4YU4DNNGSuM3L7Wzm3MTcUlb4tKfmODUo2/bf/LqyoLZlh8rKwAXWziauX4jSFIT1+zqKZydOvrfODHcO1SaEOMbNNej1e5zFyGs8fCgq6rBRMgjYKNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViwvvIzH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PP772OAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766680070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
	b=ViwvvIzH4l9USK0MqwiZgj3p9yuaTbsDv0eGw5uPu8YIXETUVyFih42DEzvLCM9mIsIMGE
	WmQrew74vsfzjOlfFUqy/y0SxZ43DjBIbI4SsU0ZOGAr+R+58NjE8tNVPepbd2hdgD2hcg
	NK6Y3MJGa1+a541ck/RubenbxauRdKw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-u0WWzT9ZNjCcpSoPzNHzOw-1; Thu, 25 Dec 2025 11:27:49 -0500
X-MC-Unique: u0WWzT9ZNjCcpSoPzNHzOw-1
X-Mimecast-MFC-AGG-ID: u0WWzT9ZNjCcpSoPzNHzOw_1766680068
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so3308085f8f.3
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766680068; x=1767284868; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
        b=PP772OAKcOtmFibYki6IbInRu/s2BI5AcNS4l6G0TZ9zjPoKFBNy1OEwiR0d7FOSEi
         9mk2RlB9hl1X97ASRtLzHKf++6P8XVqMUBKqXkws1Vr/nkVfiGcLFYH7rSS/iPtPDp5t
         58ycmIg66zaWJdDvDZ2J4/WAaOZh4RNSu+6zVdnXTmdI0Lv6vr10uxxd6YWQCDBEI1xX
         BrNPEAP4sX8orcZhP9yzWSOZ5407Ywqe8BRm7J7lxOLO0eO+oc6HRQTpN1cPjExytOVl
         ihopMWNo8SnijyipNy5GIDuQiPlpngkgnwKRJFjm00GydKw0kCz942Csq8YAR4rMYGoP
         mNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766680068; x=1767284868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
        b=msysmVOKEGv912AX/ACeS4XwKe1tSp/V5W+c0Pzsh2UZojs1Zujz5UJs99U/j6IMY0
         0c9HehssgIcMXdvtMQ3NDpMmN1CxdMwOGhlVwYux734IgffbBHrkBHb8fFg8esug9b1N
         77dCEj2cvVtTLj7zF5PNB7GrAOkeWyM0o1uBlba7uz700rUAC/feFuJHrepu7BjjfReM
         PFouTJDE1ayQZ3/y6KDelWt6ubglJJ8E7qiRnpIDKMNeD8l7Urw0hsurbAjXhFeU4muG
         fvqYdD7hG3q1WEVHbltrnuOo0F8Lm5oSrvj22SvocllnkwnKvE2ID+jXPfMAtmQWAcwd
         GAqw==
X-Forwarded-Encrypted: i=1; AJvYcCUFSdXcn8ULlhNUz0hbsdU8E4fwzyx6avvtCsUaIZNYchTR/rUEHesSDBiDO6LgxhDbvfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywI+si4xIbDLhCauKEW23PYoJBO9gE/S2XvpzH/KJr4QC4eBgf
	2JA9O8UIKnqWuhzEgIOjpU2LPEW/IucBfUPaDipRdMlkoufLACQuii2RPim4ssGe0r5Uo76++qV
	6zwbg80vfEF5lV9xisIxm9PmeZ8EKdzehQmO6a/nf99FoOb8RKJJBUQ==
X-Gm-Gg: AY/fxX709CEMySZaIbrCsTluUyMCCCxOuDieKOGNYoKxj47j4zltBtP/v4YzVnb8XnL
	rHeciwXJlys5VtytG/gvSERnRhiYC9IfGOGgksSAMd33OUAuZ4s+IdjOA/RkRi6Vh1ZrchbdQhb
	OZqkk2OKuhEcnzTncKdpNwkX9QBUy3hm0vBrm9u/PRQpXvki1BZAbMU9FCHVr9vtD54/FuGZ5Oc
	4/e2v+cK/XY8dxLS5LxNnq3xmv40BB/7bpscrwQFlE7ZvKleHZ4Jh8z3fZNGCpnNWVmtBulf57i
	Mtbu1vZals0pr+bEKcOKFsb3zeWU0FX5tnhaBYJfL2JH6H90fHa9IIMsbi2DD/GYpKWTarOYaeF
	WslDOSFyTsdd1B634J4/qBpomyjnkf0MYXQ==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr25712985f8f.23.1766680068264;
        Thu, 25 Dec 2025 08:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0R7k5H0uEZzPtgL/lcx5+ScBj7pHtcQ6qqyBP2A8tSvsgvH85v5c3f94zJFXpkNhGRCz/xw==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr25712964f8f.23.1766680067805;
        Thu, 25 Dec 2025 08:27:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm42036674f8f.27.2025.12.25.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:27:46 -0800 (PST)
Date: Thu, 25 Dec 2025 11:27:43 -0500
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
Message-ID: <20251225112729-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>

On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > >
> > > Hi Jason,
> > >
> > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > the refill on its next run if the refill fails? That would seem much simpler.
> > > This refill work complicates maintenance and often introduces a lot of
> > > concurrency issues and races.
> > >
> > > Thanks.
> >
> > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> >
> > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> 
> Btw, I see some drivers are doing things as Xuan said. E.g
> mlx5e_napi_poll() did:
> 
> busy |= INDIRECT_CALL_2(rq->post_wqes,
>                                 mlx5e_post_rx_mpwqes,
>                                 mlx5e_post_rx_wqes,
> 
> ...
> 
> if (busy) {
>          if (likely(mlx5e_channel_no_affinity_change(c))) {
>                 work_done = budget;
>                 goto out;
> ...


is busy a GFP_ATOMIC allocation failure?

> >
> > Not saying refill work is a great hack, but that is the reason for it.
> > --
> > MST
> >
> 
> Thanks



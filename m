Return-Path: <bpf+bounces-77442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1154CCDDEC1
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F783300C0DC
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BA2D46B6;
	Thu, 25 Dec 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqP/7acZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="doxlv3Ix"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140E222565
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766680039; cv=none; b=WmnnSvrHwfv6x0Z/Vc+rfefCzP5i6bTJ/R9dLHPMbd3f0vEKBDYWIWte27dGuwCXswPyfdl4PEXfcd6AqI6vrzDE+eJIRWvghzP5+xLiWu4nRfMWlT7JpgiEjHaylG56vbEu7beziMfTR3KC7mhx6wth9WroK628Z6eDeNaeFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766680039; c=relaxed/simple;
	bh=vv1phZqix/ryOn4SSA6WVQ7/V1Efqn5k4N47N/zr0mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYXYr0HW4DBjcsUC2a67A4KcqD7bKsp+/wiS14uypqrsyjY71ifM7+8sHbdeICAc1omFasE6G3hcHEIFwC/ie9FeGqIPtNJXyXyKsPCtGm/ucNMiS309mpNuVQoEpg4F5d7CHh6eZahTq9KMugaQT8OFJGLThQrdI0GkTdsqWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqP/7acZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=doxlv3Ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766680036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
	b=iqP/7acZg30jVj8bTMgD0/tLPWsZHwnTzyg96/Jlcd9G9Q0Up/JOKtP+SsU+6om8Do+5vZ
	Upuum9o5LqB8o/+37cviC59gTk+Xp8dN808Nm3FtJbpzT98XQslp+4JRM9N3iBZAPx/Hv4
	RN/9rmIwKLjsu/dro9suCltDPv5h9rk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-PWFcgbk_M8K2sSmJVA0Ikg-1; Thu, 25 Dec 2025 11:27:15 -0500
X-MC-Unique: PWFcgbk_M8K2sSmJVA0Ikg-1
X-Mimecast-MFC-AGG-ID: PWFcgbk_M8K2sSmJVA0Ikg_1766680034
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso64295495e9.1
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766680034; x=1767284834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
        b=doxlv3IxD+YSw65CkQlO2uiqVUK50Vy/6c1UMuJGMzFGFjv7qVBzHk3iyjmxzUOdJa
         R3l0wbeVw68jIwMQAm8ZZjp7UdWwzebKXJB70O5O9r94bl3Z4OiZRg5y19ra192B1lTJ
         Fu2U//l6Yn5wFkw24MWrStY3YTz5vTRMT322jw16Mrtj8CZhyobZpdFOfpZPjjjWTUx1
         tLqjq0Foiimwfv689lMMrUJ9ZvETUT4N6d27eGiVlPzxlWDlpYifvjGPOGgHEpU1uFVU
         WWSLDTZvLSdJiraBP1KblY3vGI+ERl1i9XY81Bc411PmpJ8/r2ykwTnfGtsMTEqewwjV
         vISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766680034; x=1767284834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
        b=CzB9vp2NT4nXBm7Hk3GL9AXWZBltnckIQZyxSWLHQVYobL5VHvbe7KuuIwQgvW70po
         0R2R/Xc93p1qGCJ6/9gZrjVGxA3eWa+tHwh7t8IUOozADkdOOc7zSRwsW/ZZ9w0k+ykp
         M8qYtMc+30MwZMlhNHbulKqL5xXSNk5mJdh5PF8f4PRC0U1iMVSKdXk4AN0pwf9O4e4T
         kouaf1dxZUap0vxd0UBZhZFxrsI8GwN9fj2h0shNSVIt/yj7JgAoS7iwnn78myeCk/ON
         ys4mmlnXWPGaL8KQZxv1SjV9Z5g4qwhxgZhHBDZGTNKoAIvuuH7h9OwSbdVpfBauguXW
         hXmA==
X-Forwarded-Encrypted: i=1; AJvYcCXV4W+Ef8KO0iarHlEUn/ERlU0DTgUX9dbZNXEy1Y78s663Y2u7Y0pCpxYIy2Wen2jk/sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeKgmG7B6Emk+ZVx5aCMc9E0NZgRtHp4pnxVv2jJPMweWEPgb
	w/sallxtm8h2AdcHqHPwVoQTJz5k2D0tn0VGgD7tjxJzW4yrJqmRgfg1AModIjQtcvI6fpdjkjD
	NuCqOrnVbbf4H5h+uTcMa4uKmcKmp6YiPKeLCftQEIPkpmMaHgUoz+A==
X-Gm-Gg: AY/fxX5cLcmfMEloSNgbHE3Uaajt0pmv/dc9vy0c1HMBCvdMRAch8hgihidzsfYgURO
	5zoUYLsCZxqqyxH/Ps+UOrLny0REy7ANfc6K2CgVN5Mj16R1WLCUEi7KicCAOL/mmXdAznFukX6
	1nGXPh6uZgbGLLjmvOm36pbQFew2x4U0TQWMsNVJxd+E4bcgsqWy3Q4AgbB00LC59ZsSWhG+sU8
	66Bno9I7oyFzFBRzIjJnZOYHGffTuzKNVCU485Qcwe+dS+FR8OrMSAVmVwBJuliwxFDti9K+Cjc
	ThNFLP9A7NC02pBqkRdGoxzXoJdM2u646WIJyKhtogBbDENX0XUcEekBEhLu5rFmPMksr67Vzql
	5Qe9jScS+YO7gUpmIJd5wRU7iNtaEpQg+FA==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr209121225e9.0.1766680034040;
        Thu, 25 Dec 2025 08:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExHtOTrO6amFRMKKbbMC2la+j516gOLyPplDk/OSZh4gRdGY/ppOsxF00RFw07Xle4k8vO4Q==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr209120785e9.0.1766680033471;
        Thu, 25 Dec 2025 08:27:13 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19352306sm344339415e9.5.2025.12.25.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:27:12 -0800 (PST)
Date: Thu, 25 Dec 2025 11:27:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251225112636-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
 <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>

On Thu, Dec 25, 2025 at 10:55:36PM +0700, Bui Quang Minh wrote:
> On 12/24/25 23:49, Bui Quang Minh wrote:
> > On 12/24/25 08:47, Michael S. Tsirkin wrote:
> > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > Hi Jason,
> > > > 
> > > > I'm wondering why we even need this refill work. Why not simply
> > > > let NAPI retry
> > > > the refill on its next run if the refill fails? That would seem
> > > > much simpler.
> > > > This refill work complicates maintenance and often introduces a lot of
> > > > concurrency issues and races.
> > > > 
> > > > Thanks.
> > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > 
> > > And if GFP_ATOMIC failed, aggressively retrying might not be a great
> > > idea.
> > > 
> > > Not saying refill work is a great hack, but that is the reason for it.
> > 
> > In case no allocated received buffer and NAPI refill fails, the host
> > will not send any packets. If there is no busy polling loop either, the
> > RX will be stuck. That's also the reason why we need refill work. Is it
> > correct?
> 
> I've just looked at mlx5e_napi_poll which is mentioned by Jason. So if we
> want to retry refilling in the next NAPI, we can set a bool (e.g.
> retry_refill) in virtnet_receive, then in virtnet_poll, we don't call
> virtqueue_napi_complete. As a result, our napi poll is still in the
> softirq's poll list, so we don't need a new host packet to trigger
> virtqueue's callback which calls napi_schedule again.
> > 
> > Thanks,
> > Quang Minh.
> > 
>


yes yes.
but aggressively retrying GFP_ATOMIC until it works is not the thing to
do.

-- 
MST



Return-Path: <bpf+bounces-77734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496ACEFD4B
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 10:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36792300CF07
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B82F6181;
	Sat,  3 Jan 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWG7YkCF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nQv5l98g"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A223D7EA
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767431599; cv=none; b=jQ0o8zv9DiHmm1ITtU9Fa1zRKMBf8s+dTW1/M12TshPLQ4i30UjttpdGunPLIs1bjWuRPbsFdSejIwdT7OW5hj5i466g4IlpBEQOB1QnGBAT3KB13j5jIpqfqnI6bUsCO6vbcX/Oix6EDw01rPRHShDXnYOkWwy6K0ehFioeT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767431599; c=relaxed/simple;
	bh=D2JUwaLgQPVcFVxnKAJxg4vCYvDrhyAGsjt3mPC1zq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqOU1Jiarxk1/+fzDNPNv9KjzlqIUMhyNB8vPwiG9cp8rksnZxRp7WXZkOfaDOyN2Uf9I19rCGzJWTK/rJzbc87zA8dAn2FmX5IIQvlGjJOKtnTWZ9da0B/CR9QInXtJgLhqYX/nXrfSImVXcZ/MJtrSZ248P5I/6ofzQQlnnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWG7YkCF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nQv5l98g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767431596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
	b=PWG7YkCFXoMSJy7ghk1BH/BrbrhNfsQia/RyudIOFjSz2g9ua9Vr1yTp9exalFoAQr72t9
	motspI/nHiLpS0dBcRLDtxFhihWymbi/K2R8h5dgNdXaVZ/sR0xJItiZSDi2xCGSBmeLRZ
	i2WMvo3JHD5N/NJRgsSUPR7mHny+fM8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-YsdoDsMgM4-3F4Reg46SRQ-1; Sat, 03 Jan 2026 04:13:15 -0500
X-MC-Unique: YsdoDsMgM4-3F4Reg46SRQ-1
X-Mimecast-MFC-AGG-ID: YsdoDsMgM4-3F4Reg46SRQ_1767431594
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325aa61c6bso4790706f8f.0
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 01:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767431594; x=1768036394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
        b=nQv5l98gQ+cgHNo7yX4C326Q7WkrMYQ1j68rqYQVQkUHlhU0x1uSd7E7EJ4DMxmkGY
         X3WkX/VuETV2g6+DzlVFLtqdSkXTGqhmeyW7j6ej2axyu9upsywoNAOWyq1CNWOtZBRy
         KJHaSVXHd5gSJK+rAaOfcMAyOXabRpvOpw1RyCygJ5nzbGVBpnUTOAQO8XvCr9jWlUIw
         uKCw4VS56743CdVhhudSOM82CcolYJuwLKKhEWTgp9dNwQ4nlX4M5U9QCVmpVJ34Ag7+
         kepOfXvcl+9zWijc0dprS+7/DARBNvlOQI7x/xaHqbkw8AeFVmQJURNWNYPBcd6uU/Mk
         /tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767431594; x=1768036394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
        b=TdbuSdyrDg6Io7S7376zSz2xI9WYy6M5JcFaIEbSUMq1Q4o7ieN78ysRZ5obAxbIdC
         rFiy2aQ8AVJCqSk/pk0syT25ogXFFHhHzAMrRDWmmpuy7QztxPMmryuQ0gnUwQXx82QU
         z8Rew08MrNAdu5bh3pjwCx0Lv/jWzhCBay5Owt43i2wxp2UGFW/synh0l9IfJJ19+QR4
         mDleYV1VEOoHb0v1BhMjqD6Y7cfG9ZxV8BcAL6oZnaIQs9/uQEKBmqYA/RxhmT5I0nUK
         uRsymkhYBS8bX1DCz34ArKimJi1Zo+WW/bOK3bqk6R8kOVhnQKWr37zkKrgwFmmgsW7W
         juuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6B21XVjmdzBdHIqIMBNDZJoz9M9+LnvbQJBWGemm05wVcAYOczmQuIyCxt2iKTwJuXKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLYVbhNguWJEIdUiBTbWyXCzlG2ds4zwVXPdgbkDqmt7VmlYP
	SjRFiFoS88XEiLNuG1dG1g2DjsDx7s8xt0IWvg+NKWoTtg9J2kTvZjNgfyRi83EcHdcHC4JlvJG
	UoTe2ia54cVycEI/uar7+wT0I2RGYoHlmtkcfHwsc7G5XSwNeaKg7Fg==
X-Gm-Gg: AY/fxX5hFZjMdkjjM5BRgmo4+WAvlIUU+ABhyreq3JJbI3AZCIijU7vlxkPN0Y1QbnR
	l2v6vGT/z9jCI7o7UIB7GCBFm47F0XLcI59/DHJHzs2jCxWgVzcI+PpH6WYvFmNwYyaoyR9e6jU
	V+z4GCnbfueZq/eRW2+PuitLLB9djJAuTcGbZy8kMEt+J9iuuqB/lDksI3bdKdxPe5o32jdzRJh
	KRi5aQgRuPx/6QwAok2o6WSCnRyu7diDN2+NGveJWJxNl/XpjdnrnrgRSpXVs35Ha7q6CPxlYwL
	7Cy2sV4FHTds04jmrVotblYSZ9LA2/4TNk5zQlpF64iexbcDG7AYM+9ukMQLfVX0AoM/w/ZR3J0
	g3oeGAw==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id ffacd0b85a97d-4324e4cb94dmr57084914f8f.19.1767431593695;
        Sat, 03 Jan 2026 01:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE26GgQLEflvynAD5o7MsvyW4N7h1D9HT11b4Oml4DoyBao3uW+BjntwVayJEJqPx+C7BOcZA==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id ffacd0b85a97d-4324e4cb94dmr57084882f8f.19.1767431593183;
        Sat, 03 Jan 2026 01:13:13 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d7:4800:ba30:1c4a:380d:b509])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm80644627f8f.19.2026.01.03.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:13:12 -0800 (PST)
Date: Sat, 3 Jan 2026 04:13:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Subject: Re: [PATCH net v2 0/3] virtio-net: fix the deadlock when disabling
 rx NAPI
Message-ID: <20260103041213-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>

On Fri, Jan 02, 2026 at 10:20:20PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
> 
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
> 
> Due to the complexity of delayed refill worker, in this series, we remove
> it. When we fail to refill the receive buffer, we will retry in the next
> NAPI poll instead.
> - Patch 1: removes delayed refill worker schedule and retry refill in next
> NAPI
> - Patch 2, 3: removes and clean up unused delayed refill worker code
> 
> For testing, I've run the following tests with no issue so far
> - selftests/drivers/net/hw/xsk_reconfig.py which sets up the XDP zerocopy
> without providing any descriptors to the fill ring. As a result,
> try_fill_recv will always fail.
> - Send TCP packets from host to guest while guest is nearly OOM and some
> try_fill_recv calls fail.

Thanks, the patches look good to me.
Sent some nitpicking comments, with these addressed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Changes in v2:
> - Remove the delayed refill worker to simplify the logic instead of trying
> to fix it
> - Link to v1:
> https://lore.kernel.org/netdev/20251223152533.24364-1-minhquangbui99@gmail.com/
> 
> Link to the previous approach and discussion:
> https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (3):
>   virtio-net: don't schedule delayed refill worker
>   virtio-net: remove unused delayed refill worker
>   virtio-net: clean up __virtnet_rx_pause/resume
> 
>  drivers/net/virtio_net.c | 171 +++++++++------------------------------
>  1 file changed, 40 insertions(+), 131 deletions(-)
> 
> -- 
> 2.43.0



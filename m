Return-Path: <bpf+bounces-30921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9118D467C
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7F71C20B14
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D3144312;
	Thu, 30 May 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJHl6+dZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFF7407F
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055748; cv=none; b=eA2bLZOURTtFSVRfPfvAb88Kk82P3/60ZhsRMIY7/IWEpt9YRYp97wZUGkCVhRSC0hj+Jia4R/GdfCbOxsxazm89wSnaYlYvlWxQiVMkdY1p+3w23GBoW8Ltng+z+ePg14ri/oTmY6tLGInZq0HtB3EVcCxke9UjkrgrX/13ubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055748; c=relaxed/simple;
	bh=aTbMjVPTC8GXV/q5t+biiMKXiTweLG8tXz9RUUVAAC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzh2k+1mp3orZCyyoiDLuS/r8v3XGYcLdbfMFdp4Yk1zW1wux0R6a0E61BjPp3+0Bf4QkkN3L5paZILVS5+jbhFxeYYbu4FYVl278K+O81+l1AsgJse+WzCKeKpa2vdSZM1aPuuDajdCbsHBK2Ll35gDKd4by+kaYj7kmi80dsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJHl6+dZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717055745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeTb7oEj2cbUagJqckhiCADw6n46hzpmlEhiRtW4rVw=;
	b=MJHl6+dZzSHryDWJmTlG/8uPAi3tP1Ui+TH/RQ15kduj5Ar7T69uVG22cwIQGXLqIdJX2m
	Tt41wev0chMe82HrL9zxX5gs3wvLK4/A1caqWyXFMfamDrA4JMCvnxrN+/MEp6M7Frg/hv
	srfpXSaCoyZcgo02Ki/Ydp8yYfegmJQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-XRO7eaqgP8eaiqA5FxWUQA-1; Thu, 30 May 2024 03:55:43 -0400
X-MC-Unique: XRO7eaqgP8eaiqA5FxWUQA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4201f100188so5391975e9.0
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055742; x=1717660542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeTb7oEj2cbUagJqckhiCADw6n46hzpmlEhiRtW4rVw=;
        b=UPZtDe9PmKG3av1c2SL7V8Ov/cBhqTTyCAHdYi/Vcd30ketosIn+wtOor2KAgGICQV
         QqRdorQSygxhM3SmxszcL9DnJE4ikFJTRXju/XPMti+4SERy1R8Eh7SawXX6Rp81iaMy
         /mjJaBRd9tdtkkpbCGfZJvigRNQd9F8p8FllT5jx4zSl04B3oI806UOd+lfSHn5GfkQO
         zcrVGEbblUSVWzk8CKkAYodCrP2/VbN2Gm5B40dFuZENf64ZiRO50nZ6VCarI51k7pi4
         Wfay8jQQJHqJtiMNHIUaSgVCG1bW0C6qfNIuZbQHR/lryRpsAKAuOPCoYhhusAK9H2pt
         PkDA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ucn529wSk6acY9hynrPhYRQYPxC6XvfhL5uEsXY+EiJajDGAAx/Va/oMg9lxoGfJt4vqgWPVQPdnYTE8qS+V9wSr
X-Gm-Message-State: AOJu0YxAPxZ/6AvS8n7nZ/RPSc4DIPsvSQxIwDe1muOtjRUU+Hp0/nKh
	3fs46uUCW4AyOtm4utrcuBUMio2/0+E56U6Aob+VrCiXgHUdDWvWQYDPa0LCeEbzL9se9f9H/uq
	p8E0WRqTjBtQY8h2CcM+7JaNhvDDphOEI5PPKW8u8vW9HU2DX7A==
X-Received: by 2002:a05:600c:46d1:b0:41c:2313:da92 with SMTP id 5b1f17b1804b1-421278158aemr17009675e9.4.1717055742288;
        Thu, 30 May 2024 00:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8HukkuvxeZ/smNud2JY7Qr6ffHwWhMWtkGft9V4+i+ULhflQAWD/DnZ3kmA1eTSQA+wTj8w==
X-Received: by 2002:a05:600c:46d1:b0:41c:2313:da92 with SMTP id 5b1f17b1804b1-421278158aemr17009325e9.4.1717055741647;
        Thu, 30 May 2024 00:55:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127084ca2sm16602315e9.41.2024.05.30.00.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:55:40 -0700 (PDT)
Date: Thu, 30 May 2024 03:55:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/7] virtnet_net: prepare for af-xdp
Message-ID: <20240530034921-mutt-send-email-mst@kernel.org>
References: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>

On Thu, May 30, 2024 at 03:26:42PM +0800, Xuan Zhuo wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
> 
> #1-#3 add independent directory for virtio-net
> #4-#7 do some refactor, the sub-functions will be used by the subsequent commits
> 
> Thanks.
> 
> v1:
>     1. resend for the new net-next merge window

What I said at the time is

	I am fine adding xsk in a new file or just adding in same file working on a split later.

Given this was a year ago and all we keep seing is "prepare" patches,
I am inclined to say do it in the reverse order: add
af-xdp first then do the split when it's clear there is not
a lot of code sharing going on.


> 
> Xuan Zhuo (7):
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/net/Kconfig                           |   9 +-
>  drivers/net/Makefile                          |   2 +-
>  drivers/net/virtio/Kconfig                    |  12 +
>  drivers/net/virtio/Makefile                   |   8 +
>  drivers/net/virtio/virtnet.h                  | 248 ++++++++
>  .../{virtio_net.c => virtio/virtnet_main.c}   | 536 ++++++------------
>  7 files changed, 454 insertions(+), 363 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  create mode 100644 drivers/net/virtio/virtnet.h
>  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)
> 
> --
> 2.32.0.3.g01195cf9f



Return-Path: <bpf+bounces-77393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC7CDB14F
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 02:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194F830413D9
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB428314E;
	Wed, 24 Dec 2025 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdYH3I/9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jp3Y52fG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D55277011
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540107; cv=none; b=aqN4zCplWMLVtfyrfV0iFcYV9oXGAQWCbgsFkMMhAsHwscfc2b1E+QhQ47atxVn9fjAaDRrQOyPHmZ4r1VsBq176JNph0SlSlA3CbdTyz2eEmyQP/+znVXiqJftjWsDJ2zfGXRNR51Ks5LC5w1AVxX5WsModPd/hTw4FMucZuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540107; c=relaxed/simple;
	bh=VxgwS571p6d9ltRCxPlktCpRXiNoc5EoA/Yuj4mRh0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXB9TOwT9ALpfkhdR5vJ/BUT1VTvCxGTuzGdh9BmnEZsHse8cGdkSUYUCG+31XPDfiPEF+i/ENcuG16VQBh/O2Eu5G8Kflu/nPFVSa6M93Wjf2bNE3+sOvfyvsZEC8S1eC17h0zc2DgIzNVUtRQoT5Zevc3s5NGFMp8UCrLAJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdYH3I/9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jp3Y52fG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
	b=FdYH3I/9bNuhWigwB7Dgw0qTvH8fX3xRIJJwEhs2ieGr6Lm2c+MNhqRGJPb12H7qnCJOS+
	qVL/n+QRMWdtl+rUX4Heq1JMMErEbpy+fkmRFEHjxCzAbiI8svdhWR2z9gOjedyAtTe9M4
	KKiHCOYAqyNluX7nzvk/NOgluPgetfM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ceq1Y0O2OdywGxUUKuaqQA-1; Tue, 23 Dec 2025 20:35:01 -0500
X-MC-Unique: ceq1Y0O2OdywGxUUKuaqQA-1
X-Mimecast-MFC-AGG-ID: ceq1Y0O2OdywGxUUKuaqQA_1766540098
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso28990365e9.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 17:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766540098; x=1767144898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
        b=jp3Y52fGPO/B3hmxJtGq8GKulUZVsVmMrdLGuVjR8jXfaVZtVUrd1GpphDOt2d1dL9
         GdLz5m0JuIi6ia5qj33N/fbRK/DHrSQzh2XsR3S4ClIXOb7WkkgoQotucXmI8RFLiOn6
         z+sgl4gblqgcM5MOsG/gxu7N2ACVeulT8fg859MnKmEzeaaP1rUhXr8ak65YvOMTGbCN
         lUrshpgZJlP05fFhfVjx8KXaamOWMMfyYQxX2lkomJNKKv6OMBQCsnfvtZOSAX7BBEAr
         kz4jD6YpaJUl8xJYreAs5uCp3OM8a/WHrFrZrtVDUGEqBkm2pgfeNIr1RPDeC/cL65Oa
         WRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540098; x=1767144898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
        b=FaKC4UdbcGMWIMvIaqZXU3YYVIMmevHceslqzWfx20JZ3GcWeQ9Veb32a6dO0PGL3L
         +dD+PkBUtnECdgBPap0SZuPrhv32tXlnRibawpuWIg710UpORyViKXJOxOMgGhILZjvy
         zHWYOhYiO9nT1XoXd7UUuur3aUBnXNzWuk2Xs7T0UM7qai5CwoF5CPvPPZTh3XRezwhP
         zap4bx6EP+zlU0L7i2g6OBGtDKyij9ZhgDS/sxCnHojtjOnq+/mOmL/73fTLLay/11hs
         Gz9O86lA1glW71a1Pg0c9RSbVTKEmbI3ImaPD28RR4xHVB5D20+M/KtFjkYbkdo26Muk
         RvEw==
X-Forwarded-Encrypted: i=1; AJvYcCUej8YiV+VS7D1w/RoGNHlDHweMWnFEJFozRooe+zwJle8kbLq3hXHgkQ6V6+GD9ekUl4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBlXJi1X8mOZHcTMPMDqfpzyVTVdxWyufb0BwE259fjqhGDI3
	Kafwuxk6I4YHtj8Fxjg64CLPOUEmEaTTRO8ydQynpgaAcuCEp5EO7NntOiDd0lzzoISRUX6OXF8
	lnP+Obcpu2EUf7lW1t0lYEMeDu3Ml8N/vtLF4L0A100f4pxTAE5T2tw==
X-Gm-Gg: AY/fxX4Dq2L028j2ig0zWzB4++JXDwfpzkxMns5v701q3A9cfyfkmZFCRrNbMul2MfP
	XF37CBkIsUuE3wcDIvIXcligvP/RB0L9Losf69DZ41mjPfYl0y2yjHzm779iQvh8o7FBHH7uiZV
	eCAC5eC0M8MQ4tRuK1lkOUoY8xHBZVbG4XhBIfS+Cnmix761Ow7QyzpGi4sUU6mgWc1lwcEgBcv
	LQjh6nvl9LXV/EMamAoqeC3Gt+DQ66lA8vMnHphcwsrXLC0fClog0CU4npF1b7Ep+pg4C33bLko
	zYyKuGtK3FOyD5rrpNDo4QAMDWf8Hai9i8KB06QkfFx3RREKiZuYQ3bKexaMK+9EzOGqulu/EEU
	l
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr174135145e9.13.1766540098382;
        Tue, 23 Dec 2025 17:34:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS9I2SQh5r2tYHnvHjQVonS3jrba9soPU92JGUQFF6MGUaVBWeHJ/5ROPtwija6HgeR+BPrA==
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr174134935e9.13.1766540097822;
        Tue, 23 Dec 2025 17:34:57 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279d6d8sm319276165e9.10.2025.12.23.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:34:57 -0800 (PST)
Date: Tue, 23 Dec 2025 20:34:54 -0500
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
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251223203310-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>

>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> @@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	 * Make sure refill_work does not run concurrently to
>  	 * avoid napi_disable race which leads to deadlock.
>  	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> +	disable_delayed_refill(rq);
> +	cancel_delayed_work_sync(&rq->refill);
>  	__virtnet_rx_pause(vi, rq);
>  }
>  

disable_delayed_refill is always followed by cancel_delayed_work_sync.
Just put cancel into disable, and reduce code duplication.

-- 
MST



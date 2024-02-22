Return-Path: <bpf+bounces-22522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324D86031F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 20:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BC61C236E8
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFD6AF94;
	Thu, 22 Feb 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUkJXEdR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCB548E5
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631122; cv=none; b=Lqd3dgWzkATBpr3BCWA72dIm+6GBPZaMOP5wOokpMheCNzGFsoBoUwqGTM/vjis4d6hzcCQB6KNxWo4g01X4T6ETK4vVMPoZUoJmVjAz5hYFNtzgeJsqba2q2g/KvFNMEiYv8LAyG4QCG7AF7vIUWMoeXVzrEWcARShapPWTKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631122; c=relaxed/simple;
	bh=oLWpUQzEDg1YWW4cOetAqNAPnhZ9oahsEaWv5ozR+LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4ON1ac9wuDl2Rg/I6/JPhviJ2/IYOBoV/wTlCR1/n73/ujuzUalg+06W4dANj8xAtBkejLXCJAjb4DsuB+7oQ78NKQnhdBSscmA9Beh/q+jlrZdGWBg4wL//1Z5H/ysx9LYUeD63nSWFXIuMOY3bhrwKg3nqBHY+p57XxWxc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUkJXEdR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708631120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtS3rO3/k4CHxBCems7dZZwyABPFlcoiWlBHvKoMPuE=;
	b=DUkJXEdRs6sBn4RPr5yJv9Wwh02RZ1Vq3hq5JgRtQPgNgSbggbI1EYD0mTS/aTWkJdtJcP
	huht9TfFjwEFXrPIGWYGt8gSjiBckTx+ULttZcNkLXmeYbtL6J7ZHU0E403KC1a9F/kMwB
	pCmvlSAi7utyTZtPiR3D+okP4KtVdTs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-GhSXYrInMH-aBQC-V50clw-1; Thu, 22 Feb 2024 14:45:18 -0500
X-MC-Unique: GhSXYrInMH-aBQC-V50clw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-410e6b59df4so937985e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 11:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631117; x=1709235917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtS3rO3/k4CHxBCems7dZZwyABPFlcoiWlBHvKoMPuE=;
        b=f5eTdhuiXro+0jomaIk5WPA3ADaR6As9Kf/4gnivQkBS5rovrTDg8x27hbUwLVS5c6
         Q6iHdGq+irIkl9noLNROU4q2O0tzD6ZO2SeeG8ET7v4lMQNgIH+m+vonZbShEvRyWBBn
         tMNduuB+r1fnhU2ppsADlno2myoROSaEwqCWAzFgh8jNsSHB0m+ikuq70kwlBIXj5v3x
         k7iIGa5Qnl2M1aPrnjZGNQyIxNutDC7Er+BpMnMlzrRQQ8Rcm6KPbS0xAMksXk9ljnlO
         JVeKaZ5bNK8ZLCJLb+tnnW9Wt9OcFEx87TqizVMD9pyDg2HgaQaNJi7+/jVvP7MPEJ88
         PYjA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0nNGYubH6lo1YDhy90Hy9vSFx+SOMOkqwMmJX1kDW4mi51lBFE5dgnvJJChSk+ERINrnsiwVOnxRqs1c5bpozYzk
X-Gm-Message-State: AOJu0YwdBfYRLPRswfT58rbov0+37aOaAmo1INj2QWglpAUWQHGPWdZb
	O6YRj3gd5ruawlPmUHe1NRszOLT0nRM/BHbBZ9+rsDnuyItXHj1iY0hUAYcGwtdK95a07C82TAo
	Gu7wy/gTKsUyKzp9HXSiuUkVH21W6IM8iLnfffOd3MSIzp2/HNA==
X-Received: by 2002:a05:600c:502b:b0:412:9064:fd12 with SMTP id n43-20020a05600c502b00b004129064fd12mr133427wmr.26.1708631117009;
        Thu, 22 Feb 2024 11:45:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIRLu3qZVKJ5FnK2wvIF3qslAVzVoLbk3KPH5Qa9qhUzWeKOnysKrycrAsYRbxrz39i8PjAQ==
X-Received: by 2002:a05:600c:502b:b0:412:9064:fd12 with SMTP id n43-20020a05600c502b00b004129064fd12mr133422wmr.26.1708631116744;
        Thu, 22 Feb 2024 11:45:16 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b0041290cd9483sm137666wmf.28.2024.02.22.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:45:16 -0800 (PST)
Date: Thu, 22 Feb 2024 14:45:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Message-ID: <20240222144420-mutt-send-email-mst@kernel.org>
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>

On Tue, Jan 16, 2024 at 03:59:19PM +0800, Xuan Zhuo wrote:
> This is the second part of virtio-net support AF_XDP zero copy.

My understanding is, there's going to be another version of all
this work?

-- 
MST



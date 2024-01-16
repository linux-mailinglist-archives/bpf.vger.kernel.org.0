Return-Path: <bpf+bounces-19686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60282FC50
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C8F28F6F2
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D925A10F;
	Tue, 16 Jan 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptfqeuv6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABE250F3
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437970; cv=none; b=kmladlXIZaWwzxcIEXEDs2eQN5v4PawrcIsgc7iCEosgTNKW/wO/FVsThYW0u1m2cQnJpFteR7E8hGa0Qo4hLz1G+oDSFaQp3IWz+BlCyob2dqvLKT/u19ofKDtfg8zFbfEsPo0Wf7D8+X7pP+Es+Xv4TZ4gHo2DINKtJof+Y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437970; c=relaxed/simple;
	bh=8R04pV7NenTmY//Xvc4y+OGOzxSJ8Fvcj0st4h/W1DQ=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JwqlNO+KtA81veZO8gJMODRez/dVRyGrF3TSLAbzfvM6fbPXYKSqYHAHLs/yUFQraFA8aWz6sqmzniq5+J5HTIYxuddQAzeM6MrQkmB6lbyU9k8Jn38CwENXeITeYQD23soo6R/Gfy+Jw0bVjADnPQtu32p+ifgrROVgQYGpiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ptfqeuv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705437968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY992iAsJxysfraXAvAsx9+n1cX0TFNO2wFD5XkN5qw=;
	b=Ptfqeuv60pTOFBIy1QYtcpuzUzfS5SlDpd6QLiE65c04rzJ3rTTx3nPQ/FBqy57BiNUtHl
	F3aOotjMlIspRZbtmXzDsNVmNngr1FVS+dJwL3GQBRGhLz6rGU5VgDKFAghNbftXcM4Fpg
	JYOuujI4Xvg58f8Xx5DXDed5QJ/tC4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Xz2mTvlMPg20Xqhhyz9ieA-1; Tue, 16 Jan 2024 15:46:06 -0500
X-MC-Unique: Xz2mTvlMPg20Xqhhyz9ieA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-337bfd1ce50so263094f8f.3
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 12:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437965; x=1706042765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY992iAsJxysfraXAvAsx9+n1cX0TFNO2wFD5XkN5qw=;
        b=JfPEPtHMA4+nYs+J5gitWHFKr7JNgb6PVADrrw1DNXOlME5xBVI95dBY6q+EaKb0Gx
         B9WrJ6aTiw28nMVhEEQMVzxQ2WMxRI25Pgf/DFqy9lZKFpwCcTg2KWEoek7S+Lr41e47
         ZY/8v40ijLThITTeZl2oLXedO7KdmNB4EwXvKaTqt+zOZ1DqNfkfb8XVgmB2N0rAtx/p
         y88lQm7LQRaNa5guuQGB7pXqyjRTZ9e2qOlA/PQtptbG4pCFxAtx+0Onn2IALc7GWTQs
         vnroawGZb0tCO1MPjSTsN/hHtOgbkYNdKtOYYIQ2CBi/pGWYnfoDlSWhP1wkzhsLBItd
         8atw==
X-Gm-Message-State: AOJu0YzMgh09npq+VKghEIMQHvvj/AF1CJpUiXISj0loLyRWAX1JsEbH
	qjQjCVrnWxAV8kWosmPejW93CjCz/XSk0K2vyPJGzm1ffsRUiFiYoHOaf8IhC1NmrZZuCEwHzXy
	d5oHRrI8mgYR2Bua+hBvp
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr4037111wrb.70.1705437965516;
        Tue, 16 Jan 2024 12:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBEgVRcQZRbRtvwBMA0vTrZAaj3oTq/d687Or3SKsa4+VHQJTpU40PB+JsEyt6A8/iN0r5Ow==
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr4037099wrb.70.1705437965213;
        Tue, 16 Jan 2024 12:46:05 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id g17-20020a056000119100b003365951cef9sm18433wrx.55.2024.01.16.12.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:46:04 -0800 (PST)
Date: Tue, 16 Jan 2024 15:46:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Message-ID: <20240116154405-mutt-send-email-mst@kernel.org>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116070705.1cbfc042@kernel.org>

On Tue, Jan 16, 2024 at 07:07:05AM -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > For future submission it would be better if you split this series in
> > smaller chunks: the maximum size allowed is 15 patches.
> 
> Which does not mean you can split it up and post them all at the same
> time, FWIW.


Really it's just 17 I don't think it matters. Some patches could be
squashed easily but I think that would be artificial.



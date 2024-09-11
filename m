Return-Path: <bpf+bounces-39597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0929974FB6
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C421C22BD8
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57517DFE8;
	Wed, 11 Sep 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym7cFS2X"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C739AEB
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050663; cv=none; b=Oz+iqdHQZ1pA0UtF5bIiTxKOazkD+1aoSZXNE9ct98SJsixQGdzaY7sWPYEOFS8xFVvyKqYl93Y0wRu4Kr083QZ52KJ4E0cX0MGbwas7lF83NiTxrVVov5GFt+IpQQF0crV3M17eKXk/7awod3SH3otFQNewxOI8SBPNu2dld/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050663; c=relaxed/simple;
	bh=dyYYWaUkW7Qj38yfF+lT8+G1k5MTqJErF4gqgbsWBm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9pzGwpzoOQ1Ths4SBQhDx2Vj1ZmK/Wg+9CuJKNhASAX7i4cYHug6BwS3vI+5tw68nL/zpYb15Gpy87GlXzUSjULtG3ivtQbYGohaHuo+I9ZKQ95HC6SKvpO4Nha74Arza6FxEfyMF087O2EcLQzGuU6cJv5d3v5ndS7EMaH0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym7cFS2X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726050660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caUs0yOnF97biFjcb48s5HolFUOhjWq58ujl243U++E=;
	b=Ym7cFS2Xr7kQ5+uetw1bazTEVGtdoyODIO1Vi91NfrZ5mEawEg7GhR1khIOj0JrycoT9VE
	uj4phx7VLjdO3arwFQoWaeW4prtIew5xcYKaBerr/dgPNcw3KbQ+JTqkNJaJO4kjXECyHp
	NY3us9w4+9pET9f5dSdRTffV/yV2c6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-F3zQQBPhMU6G2TvskmcLvw-1; Wed, 11 Sep 2024 06:30:59 -0400
X-MC-Unique: F3zQQBPhMU6G2TvskmcLvw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c294d841so4815228f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 03:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050658; x=1726655458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caUs0yOnF97biFjcb48s5HolFUOhjWq58ujl243U++E=;
        b=ajGPSaNQnKYNsSLUKo0OKYu8AXEzjhQqIkMMGOgpUGZP40JWKVaqL+2NzeaPIPyxSP
         VyxxPI1AiJw3yJiMw3tKoZHTYX0ABNY40DFh8pzn+ZCl9MGUFgD6GYEhejW9ZZL7EE94
         Qwy1M6RQ026Ka/HxXCOOTshR2SKJaTWC/a1tXT4LziQw/HG2t8FN2+L1CrnMWFa7Y1uP
         lIxzKsMjcOxSBepkVwmWaofsFREHCw34HDaM96ajTl4MH4tX+MmVE4kep/Fpa4OSlops
         3YnGoLNZQVEkAqe7GGRKK7WAyBn1QfKpfMczjjiTcBghFkVxvGeJhrspaFRNADX9RO5m
         Y65w==
X-Forwarded-Encrypted: i=1; AJvYcCV66Cm+9qr3eHy2+kTvfArVF0nORx2QZeWg9m8zzRwYM6zWjNnPRXGR+A0LzJZXDMu6RKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOePzob1DlRUgVkWue4k2lHwkJ2ElIeoJmWAXTq4m0R8m1U4Y9
	qgY/ZlQJdicqADzGdPF6FsB+IkDfqX2FI+b0pfxQinmcWAOyVEH2rgr8tj5gMI9tak1jiqybi64
	9nz+nk9wwP1Q2hrISxdr7nLOl9W82AsDUx6hpZUQAPCb3BaW1Ew==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr11907022f8f.45.1726050658426;
        Wed, 11 Sep 2024 03:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtMggxMO/7B9PE3GYbAP3s7BqOmc7zlfd6FQ4MDGJx7VJlGmCoycy6iOpEGQqoU+TO08lKlg==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr11906984f8f.45.1726050657807;
        Wed, 11 Sep 2024 03:30:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced201sm593139666b.168.2024.09.11.03.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:30:57 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:30:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for
 indirect
Message-ID: <20240911063024-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>

On Wed, Sep 11, 2024 at 11:46:30AM +0800, Jason Wang wrote:
> On Tue, Aug 20, 2024 at 3:33 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > 1. this commit hardens dma unmap for indirect
> 
> I think we need to explain why we need such hardening.


yes pls be more specific. Recording same state in two
places is just a source of bugs, not hardening.



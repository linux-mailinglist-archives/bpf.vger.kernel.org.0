Return-Path: <bpf+bounces-39604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6399750CC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D441F2467C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D89187338;
	Wed, 11 Sep 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7VtAthN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23AC185606
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054127; cv=none; b=N6tn3ecbuqev2CPBFqUGsvnxc4l1qyOgkCvi5Trl+ehy6QEW7IgoWnz91/EMxPsJ4HrSMF8eT0Of0X/fGniL/QalWkinV/9XsWUaovpMLyvs2xRdRc452v2yK+4WxJ6JNYgtNrQJ++aBNodrtw2q/X0uSHeASuSBrZzmeXaMACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054127; c=relaxed/simple;
	bh=4qh5VK526gLJCKyAtpJ7CQCiCpZ0f2OJAqyu4PMcOqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEQ6Q94658M2HOMskAnVCXIkpoGuOTbwrTNsW2GUt7FYPghfCTCG+tO8rAOnSidEN1/xkVfIORzS4i3HQLvpRI+Tcc4TKzkd+AKwMW911TsYey/e+ZPHoA2i+tkRf554leFG64Do7SaK3yeqGQ6Za7wD0FDRwlf4JVOPBXpwEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7VtAthN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726054124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAmyKuMNqITkrSfy8qg6MUrMSNseX/neKbDPXn2drV8=;
	b=V7VtAthN2A8O8xNfvsAEfNryZ055gRwbYY0WCydaT3GVNLfvLFtO0AaSKR++YGbb6n1YGl
	twZ6DDeXzdtTp3N9VN3fnxHq9I9pit3zJq/fNTDpw2v0ORTYzWnkzmzo2KUJcRw0Ty9hhM
	4Y3RUT9E+96/iLNkMw7to/CcVF1PU6o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Pezm6WkaNTmQh7Hpj-SxNA-1; Wed, 11 Sep 2024 07:28:43 -0400
X-MC-Unique: Pezm6WkaNTmQh7Hpj-SxNA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f77be8ff40so7263061fa.0
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 04:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726054122; x=1726658922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAmyKuMNqITkrSfy8qg6MUrMSNseX/neKbDPXn2drV8=;
        b=wa75W6YsJnpIsY/O4yX0AXri5497fjKzhNql7eSESJ0jq/bST4FvReBe4wDOtKWEO0
         XeGlMN3Y+u8ieejD7hkoqyv3dsa71tItQ7asbAQqFVJX0c3fSDOzSlf/rIrSLKd1AfJ4
         TuIL022aIvFR9+LatDtavL7u1hfnNQ3cXHwioZHJvYfyY9FTC6vpqK7q+jJBV8Tqi9e7
         jAe0MOYcuO8DVTHyisPNWQUwHk7GaUe/XzNN/VM0OsecVf0kVh69AG1MaNVzwfYSvsvt
         vjktOpS0QD+pAJx/sARARv1EN2egbXJiVk+RoCjLvpy0MaEoeOSv4o3uHsbZaAAd1nRh
         mliQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK/pY2h5iSwWjo5upepl/G0xnhB1ACjxFucnhuLhLFKcswqWrBwjDOz9qRCJCr0X4jxuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQdpasLjzZSL/DoCDJg/TJWdjXotv1YJQSOBAFemD0DfEIHTT
	6gSJ9fKIgYjBw7C0E2FxSn9gPhuK7dEgkVAtSHlk16+CB9qiFj5vZr0OUqdQnQ62Mwv3PMEz8gg
	7DqOMWuSxyYZDZAPlg9hl+w6TRsO+lY2SkXNMzpQ1M1jbLzutyw==
X-Received: by 2002:a2e:b8c5:0:b0:2f7:603c:ef99 with SMTP id 38308e7fff4ca-2f7603cf586mr90361921fa.16.1726054121555;
        Wed, 11 Sep 2024 04:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIKTns3rMOAydZQgVabYfA2U4q50Qe0gkibAVCl1FWXltjSMrzgK/bbPrPG4mSYk55jQJFUg==
X-Received: by 2002:a2e:b8c5:0:b0:2f7:603c:ef99 with SMTP id 38308e7fff4ca-2f7603cf586mr90361621fa.16.1726054120483;
        Wed, 11 Sep 2024 04:28:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8c4c6sm5307012a12.86.2024.09.11.04.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 04:28:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:28:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/13] virtio_ring: packed: harden dma unmap for
 indirect
Message-ID: <20240911072537-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>

As gcc luckily noted:

On Tue, Aug 20, 2024 at 03:33:20PM +0800, Xuan Zhuo wrote:
> @@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>  
>  	if (vq->indirect) {
> +		struct vring_desc_extra *extra;
>  		u32 len;
>  
>  		/* Free the indirect table, if any, now that it's unmapped. */
> -		desc = state->indir_desc;
> -		if (!desc)

desc is no longer initialized here

> +		extra = state->indir;
> +		if (!extra)
>  			return;
>  
>  		if (vring_need_unmap_buffer(vq)) {
>  			len = vq->packed.desc_extra[id].len;
>  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
>  					i++)
> -				vring_unmap_desc_packed(vq, &desc[i]);
> +				vring_unmap_extra_packed(vq, &extra[i]);
>  		}
>  		kfree(desc);


but freed here

> -		state->indir_desc = NULL;
> +		state->indir = NULL;
>  	} else if (ctx) {
> -		*ctx = state->indir_desc;
> +		*ctx = state->indir;
>  	}
>  }


It seems unlikely this was always 0 on all paths with even
a small amount of stress, so now I question how this was tested.
Besides, do not ignore compiler warnings, and do not tweak code
to just make compiler shut up - they are your friend.

>  
> -- 
> 2.32.0.3.g01195cf9f



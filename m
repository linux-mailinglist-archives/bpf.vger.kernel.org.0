Return-Path: <bpf+bounces-48603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40383A09E57
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CD23A4960
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB1217F48;
	Fri, 10 Jan 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="ZfofuTOQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DC21CA09
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549327; cv=none; b=EXubK53vx0pUI1mvOAyYmr7cDqJzqV6elijPPWR/REwE1LAIpAeUFyVSoBIlTEM0WHyyfRNExRstlC4AsEUFz6xxnwmqdajwb+xqsTD7tGzKIlgYUhqdxvo5xe2HM6gtmQ+WFQpF718wJQ7ZdGi4o8UqgxWntE4h3eBiRr5DTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549327; c=relaxed/simple;
	bh=AWn3AuB7yHOLd4iesrrxgcRSmxPBHT0ef3tOlCuWqWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI5DuRN3PZCQUxcyktcs/FIrfOQIbMoM6MjzPrUP85uq3LdLSPScR1b7g5MOFWl3O2BwmNpYb7m0rgw98dBJOmGMoPgcqW7oc/dMzjIK+u+anxVfBdcLN6IA+NSYzzAjURLumHoct1G/MyRuyCLixcWV8+yiyqrHkr84fmqgw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=ZfofuTOQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so43454635ad.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549323; x=1737154123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzXivbWavWl+dN7CMkxVZypF4oLVVAvtUtJdUE5p7A0=;
        b=ZfofuTOQaH+V2FRiaPv/56FlYOSSqGW34iuKAPEAMGYGj0a9hjKWh6uXQ86MxCjVK7
         XzT/7DT3Z4Qt8nHTi79/FUlHg2Gg1aZj9YBkMZkQt4w50YwBfH8Nr+sXOwM99PCGqif1
         5e0tE2gy9BpOID+Mk4F/+vJM+gJjiuZGgjjrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549323; x=1737154123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzXivbWavWl+dN7CMkxVZypF4oLVVAvtUtJdUE5p7A0=;
        b=HQChqDIIlO9lPkd+66fwuUwJ14vXZL+tKwALFSjtegeGTSdIGM8Tw2dEdmvqZyCH4z
         2qoJWq4qKA6QHkuvz1XY82CjhUpUNyF/a+V0jyvwXBdPsIJ3iExOYTC3k74zNTVqBJ29
         vtauTVB3i9dYMHMAEfpFeCmrP64i0BlSiE/cTcfO32Qae4x2s4SbgVHgvHSN+e4T5VMa
         k46xOmKYbDWYRJS9HqstB7085GeUkLFzkDDO+wJa99DkPVjYk8JD2ULrefu1KfsJp5Cf
         RS2QB/0OJesh47YLKC5hoXTZu25H2rf3CXr3qASUmUUyq5yBbqnUB4pNodZfV8zLP4ir
         4uAA==
X-Forwarded-Encrypted: i=1; AJvYcCVDOuf0Kl43AV9YYlXf+ZfBZXe2vjq14Scx9tg5g4X5Dydk4oY7d9UK7mf2Jd5Uv5RGkNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizUr4wYJrus44XPi7j9GhZm8AOsZQFXBkaDJYdaO9Blp0gWty
	wnVDRgHllRUbArKZZT6ZgCKtJe33DW+7ooSUzy3ckvRYq0lZOnRSQ//7uU1bCrc=
X-Gm-Gg: ASbGncvuIotTCyM/bqBeeF2VjiAArFl2Uis0/ye6Ov55aLHtUCuG5nR+xfZVnH+nawo
	EWXSWUG0cJV5U2pDpCjbyE0DFcC2rZcFDI6uXY85WsHQ2o3aaLX3BDGqEQt/DO1/CPbKMAGt7eq
	dZVlFGaDRNTI2x1OsGopAT3otBEuvWr/SWNYtqRUHgqLOP1AgFSIq4WV5hFlagVcdJg/KPK8g5p
	6EkvOkDSd3kl+yr5uE/1c5lf5ik8bKkZWkSr5pqrYup0ZPGDJIsZsK5gCXNzbHke14RgA==
X-Google-Smtp-Source: AGHT+IFL3U05bezNqg95x2HmYQVnB18znOwGddscITDSjOdMEJTGA2bZLmFShcBBgvVENgRqTIzeYw==
X-Received: by 2002:a05:6a20:a10c:b0:1db:ec0f:5cf4 with SMTP id adf61e73a8af0-1e88d0d9c40mr20159487637.39.1736549323168;
        Fri, 10 Jan 2025 14:48:43 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4068178csm2065630b3a.148.2025.01.10.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:48:42 -0800 (PST)
Date: Fri, 10 Jan 2025 17:48:35 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net v2 3/5] vsock/virtio: cancel close work in the
 destructor
Message-ID: <Z4Gjw6QMqnUsQUIw@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-4-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:09AM +0100, Stefano Garzarella wrote:
> During virtio_transport_release() we can schedule a delayed work to
> perform the closing of the socket before destruction.
> 
> The destructor is called either when the socket is really destroyed
> (reference counter to zero), or it can also be called when we are
> de-assigning the transport.
> 
> In the former case, we are sure the delayed work has completed, because
> it holds a reference until it completes, so the destructor will
> definitely be called after the delayed work is finished.
> But in the latter case, the destructor is called by AF_VSOCK core, just
> after the release(), so there may still be delayed work scheduled.
> 
> Refactor the code, moving the code to delete the close work already in
> the do_close() to a new function. Invoke it during destruction to make
> sure we don't leave any pending work.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 51a494b69be8..7f7de6d88096 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -26,6 +26,9 @@
>  /* Threshold for detecting small packets to copy */
>  #define GOOD_COPY_LEN  128
>  
> +static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> +					       bool cancel_timeout);
> +
>  static const struct virtio_transport *
>  virtio_transport_get_ops(struct vsock_sock *vsk)
>  {
> @@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  
> +	virtio_transport_cancel_close_work(vsk, true);
> +
>  	kfree(vvs);
>  	vsk->trans = NULL;
>  }
> @@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
>  	}
>  }
>  
> -static void virtio_transport_do_close(struct vsock_sock *vsk,
> -				      bool cancel_timeout)
> +static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> +					       bool cancel_timeout)
>  {
>  	struct sock *sk = sk_vsock(vsk);
>  
> -	sock_set_flag(sk, SOCK_DONE);
> -	vsk->peer_shutdown = SHUTDOWN_MASK;
> -	if (vsock_stream_has_data(vsk) <= 0)
> -		sk->sk_state = TCP_CLOSING;
> -	sk->sk_state_change(sk);
> -
>  	if (vsk->close_work_scheduled &&
>  	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
>  		vsk->close_work_scheduled = false;
> @@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
>  	}
>  }
>  
> +static void virtio_transport_do_close(struct vsock_sock *vsk,
> +				      bool cancel_timeout)
> +{
> +	struct sock *sk = sk_vsock(vsk);
> +
> +	sock_set_flag(sk, SOCK_DONE);
> +	vsk->peer_shutdown = SHUTDOWN_MASK;
> +	if (vsock_stream_has_data(vsk) <= 0)
> +		sk->sk_state = TCP_CLOSING;
> +	sk->sk_state_change(sk);
> +
> +	virtio_transport_cancel_close_work(vsk, cancel_timeout);
> +}
> +
>  static void virtio_transport_close_timeout(struct work_struct *work)
>  {
>  	struct vsock_sock *vsk =
> -- 
> 2.47.1
> 

The two scenarios I presented have been resolved.

Tested-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim


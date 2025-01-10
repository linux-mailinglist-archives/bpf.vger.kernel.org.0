Return-Path: <bpf+bounces-48601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DEA09E4C
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E46516A799
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DDB21D58F;
	Fri, 10 Jan 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="X7LGfMu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D9215195
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549178; cv=none; b=L1ywqbK/3s9sPaNgEDFmZHBkhF5LjVMYIuDVfJs+nwEevN1jWD+2zHNcIN5Fwp0GE8VIx66BFi3+DZB7U1EfgdY5Mm9XLQHbKgI6iiuqDFL1C8MHgPCAZZp7emhtSUFtDndk6BZ0DnXGZEvWRza+HNZThXeylnuLO0rpN9anBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549178; c=relaxed/simple;
	bh=tPDB/C/Z9ks/FCQETqMvVx7wDQPCoCWowTG9L7TftAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8u2AJR8kOSBhnL2iqYbtRdYlEffPte9Es5UN4aYQnHFFu8vqfAzzMckUED/5zSge6a7PYUILj3UWnEidF/g92A+YHWIsvfHq8x0UiO5OSyUO1VhCxTLdsp+IPGFk0o1E7rfhm43kXgGTarWGr4rk0CDvQMEYDnpjfqF6xwvSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=X7LGfMu8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso31858365ad.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 14:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549175; x=1737153975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGseQnrTjR1YJElcRzxoONdDhsvu3Aao281T+3o5lsg=;
        b=X7LGfMu8Kx+XvtR27HCAb0cxK1VT+dQ4pSJyukKCDVVBTl6Mlw2rqxziMybbcM2W38
         SYjYZ4xr3bWOIwgmqs+EcmyVtfVWnjVWK2alYVZ7ctcpSzOGmSO7c85oRSF6qcc3vRxp
         VnJ5Fu1hwexv/JvlDxsxdbxlam7RW5UVdVewo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549175; x=1737153975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGseQnrTjR1YJElcRzxoONdDhsvu3Aao281T+3o5lsg=;
        b=UKTmGjwc5J0QOgXYxjH/HHNGs8vT30lWEnACmaXnSCi88X+G6nuSibEwrdxeEBKhDe
         wcKzbieG2BY5iPVaBBRBuW+I6mPRgqmuEjKe1zwMxHke/RDSCuf6qGApbWV9hJBRyGOZ
         hwx+q3sbZW+Db4vjD8P8LLt12BIiqUMBep1idkXdII4YHb7cS9GbxMg7REAH74borEE4
         vSSx9wi5jGI0l8DtZF3njNMXWooDWB4g1EFLeWWSYk34xl1mN/3VnnvV6elgWJQ91zr/
         vcc4T30y+meHd8E2m9k9Ah18LP8PUyQOAShgYPFli12ozOKfL+cXR9rzXgxme7HQOrAl
         MD5w==
X-Forwarded-Encrypted: i=1; AJvYcCVDlAFzTtM1tINlFsj0+9NyE7bMVCjimrn4VJWkc8g1CV0Hh5SiFlmFwsxcDDYvgdpPZag=@vger.kernel.org
X-Gm-Message-State: AOJu0YynG1HMHhSz4B2XsHtN4b/8VJ4r3x4PbbqAxyn888BEpoCXwvo/
	iHPsvHiRpwnbvKJCSgJqxLijhdOHZBdDQA60+VOuyFiTDapdPIO/B1C66+Y7k0Q=
X-Gm-Gg: ASbGncv9i2vt4OmGHVFGA33gev+UTk+Di9KuWWCcQyJh6eCeSYaqu9oFafdxOX6IV3L
	DxvuKU2xp20UsVfl/IrXobZQttlSlEiPcZkMfPXuYBNgXM9UYIoSRjIHSwFzqqFxKuLPWo+PQUS
	y2UpfXEzfDrbxXZ//uG0fnIDdJQfAHKaugaulPQgn7bVgu954tvudg03QK22xTvmrgINv/hbvFc
	AXkgPK96dmfj1qfaSw8hxlAS/dmT0d8Bq0KidPTirPKXz8TLlpXxaWf89Kobe7FX6TOiQ==
X-Google-Smtp-Source: AGHT+IHXtYgcYVXlKooOzNrhJ71XOZH467c4tXOeuau5BWKoSSQdakM62UMQxWiX7c5/TI2GCGQ73Q==
X-Received: by 2002:a05:6a21:788f:b0:1e1:a094:f20e with SMTP id adf61e73a8af0-1e88cfa706fmr19490910637.17.1736549175198;
        Fri, 10 Jan 2025 14:46:15 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a319a21afe5sm3279259a12.49.2025.01.10.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:46:14 -0800 (PST)
Date: Fri, 10 Jan 2025 17:46:06 -0500
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
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <Z4GjLqPWJBIRdqME@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-2-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:07AM +0100, Stefano Garzarella wrote:
> If the socket has been de-assigned or assigned to another transport,
> we must discard any packets received because they are not expected
> and would cause issues when we access vsk->transport.
> 
> A possible scenario is described by Hyunwoo Kim in the attached link,
> where after a first connect() interrupted by a signal, and a second
> connect() failed, we can find `vsk->transport` at NULL, leading to a
> NULL pointer dereference.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Reported-by: Wongi Lee <qwerty@theori.io>
> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9acc13ab3f82..51a494b69be8 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed before lock_sock */
> -	if (sock_flag(sk, SOCK_DONE)) {
> +	/* Check if sk has been closed or assigned to another transport before
> +	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	 */
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>  		(void)virtio_transport_reset_no_sock(t, skb);
>  		release_sock(sk);
>  		sock_put(sk);
> -- 
> 2.47.1
> 

Reviewed-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim


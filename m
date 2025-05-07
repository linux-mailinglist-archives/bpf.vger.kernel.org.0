Return-Path: <bpf+bounces-57712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B040AAED7D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C163D3A89ED
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD828FFC0;
	Wed,  7 May 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX4BaSXd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7120469E;
	Wed,  7 May 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651382; cv=none; b=j/aFe/RI71vYPCmU+PtcxY9oPNbdOeIbMlpA5uy/XUKLqgUwoiCBPFZ7++G7qplr06sU/rK2Go9s8qf/TgjD+fg9wPTeN6gkwLy3farBboiz/euEYvwoYTsM/eF2wdHWyfujbQGMSDaAFCDfapRFO8T9UEdDHs0iRCueQrIBX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651382; c=relaxed/simple;
	bh=aATQNiNXp+XTR8me3RrN1Ea00RjeRKkln7z1qZu1NSg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cgubEOpSQQICXJ7b25RaokdRvpdVLsDWyUqV56lS/hTiZGl78dJ5q+mnto5NVlQsA5/6ukdyNJj0M+ImLGHqtoabH8IFaXjpSFyaTAcLJzrIS13LqAullCEsEGjyyKXqbRznidc9Y+1gV53F45Kh0wdX9AddH3ApkfTnVlt9odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX4BaSXd; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500cf80so27863885a.1;
        Wed, 07 May 2025 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746651380; x=1747256180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X056WfmD4BdpGkuIiY+waO1LrO03BTEViDGdRU+E8S0=;
        b=bX4BaSXdHZ7QENSrMjHR209TsgAWQ1t+yfB4ttJ10xs+aFQ/za7aWFgbVnvN2CdBqM
         ACdmoKfS/VxHW8UIYmLg8YzNNPNx6O6CoErUobN4vE8MyZuk5LIlVErqKaqf3oB3gTUj
         SMfNbg4c6TGn5MDcTg8SaWz+s9REfT3n7q0GEK9sRNv1ISZUUYyYElSAzvHv55NDuCof
         3xt+B0X61/sGHMxYNFdSpCY3/TtMjYDKpvpO8VUwHJ9721mkbn+YCcc2dQvM6p8lxQTw
         TVjgFdOOa/s7RNaocLqbLeJhbmjfcWaUEm5BYoA01MwUJxE5hIr3xmUAsqQ7fw66v7Fr
         VK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746651380; x=1747256180;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X056WfmD4BdpGkuIiY+waO1LrO03BTEViDGdRU+E8S0=;
        b=XggsaOr/cF+Qy4L01itWT2aR/6xGsQsp6rqecKe7a691eIPLAV7o/oy8e+xNefXyYy
         vu71+Vkv7DM3uLm+mt+Y1IOMtLjcZ8QTUOy3QijHxWbXjDwZvXkZwaFq7fTygPGNysBZ
         aT9ncmHmN6vcZo5qJvriIm/TxcAdy+urB7QiosEGE+Pq5fljPqwDgkagMQ80uCjiIGty
         nwP8uFiCDO3HGKHuWKBQ+wEgpBOWdP7U68XMMVPkCPsWQG6vyas31S8bEg8zlxVpNYwA
         tLAjvAX3m/LC/MzQew3ypPrfk/BNyRQYELrSqslYDKTAsX4J+0oWV3U65d7xyclpfQBI
         mPHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKzwXBndBhvBr4lAp3lBNhO7XWmgyeTZU2oYUToosrI96BVERo250w0T13N3cgw7Lr2H+0zwKG1dbf7fV9@vger.kernel.org, AJvYcCUanFGB66ZcJpecoDcA6x27nhLf9JnLMi0n2ki9WnHIDpQ46zEYPlCpppLEFl+iblSE4j0=@vger.kernel.org, AJvYcCWz0fjEI9PY3BJkROzxJnsu9zZ/pO3ViZl0b06+l7b5w9p/vHTxtXinSI8Qhf8EkYLnQS4HTF7b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rBoiUiUE0NVXBXYMCNtCsmszTg5u24nCeMGJxhsAx4dAnw2P
	YwlaNjSF6mXaBfrbavQZi39eJWgOWoYSYS5MNTqMjCOpvSVb97FO
X-Gm-Gg: ASbGnctRWCS2swkBi0EICoIKtwudMcgFypEBqKluwJ+KPSP5YRbVWajt6wkRNu613n/
	wXYTMPtqVV95cLPC7rpOG1j03iSEwlJZas3vnP8/Ccli2GQrdHavhsShhNGyAmihKNJ65T/znL6
	KicMNJmVJJlpaoskQuXgHvhPutG7YAY9WBemk5Dz7yUfkwvQJTPKUqqEbXdzQrDTaymXG439z/E
	X9d44ENs6WdmZsk1djAOd90FvPBa8VBkPh9JH7OeBv2bb3an9FvoF4CqLZqSuLI21dD0Y0gjZ2T
	r2BSQSvk7Y8MMeHHiId5ywgJ9zTS9yOkIvtvEjZIsrUF+Fht9RFk21EEqkYUSAi7qfTv1rREJ8P
	7TujirbdSGF6QuxlOpPKT
X-Google-Smtp-Source: AGHT+IHwxXf2rsnqLoEUxHHKlGLyfl0YEL3qVNBGGTiecI/ahMWqeskO86K7jYc2HpgCv53H3FU24Q==
X-Received: by 2002:a05:620a:2a0f:b0:7cc:aedc:d0c1 with SMTP id af79cd13be357-7ccf9ddadcbmr126421785a.5.1746651380176;
        Wed, 07 May 2025 13:56:20 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf75b8736sm211224885a.81.2025.05.07.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:56:19 -0700 (PDT)
Date: Wed, 07 May 2025 16:56:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Message-ID: <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250507161912.3271227-1-jon@nutanix.com>
References: <20250507161912.3271227-1-jon@nutanix.com>
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Use xdp_get_frame_len helper to ensure xdp frame size is calculated
> correctly in both single buffer and multi buffer configurations.

Not necessarily opposed, but multi buffer is not actually possible
in this code path, right?

tun_put_user_xdp only copies xdp_frame->data, for one.

Else this would also be fix, not net-next material.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/net/tun.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 7babd1e9a378..1c879467e696 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1993,7 +1993,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>  				struct iov_iter *iter)
>  {
>  	int vnet_hdr_sz = 0;
> -	size_t size = xdp_frame->len;
> +	size_t size = xdp_get_frame_len(xdp_frame);
>  	ssize_t ret;
>  
>  	if (tun->flags & IFF_VNET_HDR) {
> @@ -2579,7 +2579,7 @@ static int tun_ptr_peek_len(void *ptr)
>  		if (tun_is_xdp_frame(ptr)) {
>  			struct xdp_frame *xdpf = tun_ptr_to_xdp(ptr);
>  
> -			return xdpf->len;
> +			return xdp_get_frame_len(xdpf);
>  		}
>  		return __skb_array_len_with_tag(ptr);
>  	} else {
> -- 
> 2.43.0
> 




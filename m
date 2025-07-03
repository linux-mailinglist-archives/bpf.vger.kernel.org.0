Return-Path: <bpf+bounces-62252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB1AF720B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E407D4A7432
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED42E3389;
	Thu,  3 Jul 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKWn5ARH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841C23B630
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541898; cv=none; b=dbkwIFKK0df2JB5LQzSp/rzsZpRr34pj1qVbw6pe59FGHxTtvjmMD5PDpihPf6eWMj4DtORDTISIJHAbE6xn01muDzs14zPUgZ63XDzhEvSTSjd8iFzPyKLMj3wOWn3AkrviT6oENo0ZbXAgc822kVYJ0uCnF7Gt9v5QHXgJc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541898; c=relaxed/simple;
	bh=BsV0eSUAnrB3wda6T9wzig3D/sNdr+8qBzppAP467XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuxWBd9Dzciou6qbGOsOHuj+wP2nCHiYRbEkVrl1fsX+OnpFhQa9dzkWSY4y4arMLcfXhhUqJjrJSVJTVVnaDUE2CgFTFqazDJrndRuQi1gAIsnM9tAmFHOSE38Wp4KO3A1EkZwooa9fhZEn+kSkc4GMlmW9gL7mxDDc59LLx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKWn5ARH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751541895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Ys+B0kKW0I1OmxDH3RChxDm9/AfOdFHpxEknTEX7s=;
	b=UKWn5ARHmQ9AO9G3hZRhtpm5gPe4z0r9vdj/UXxBusXHHd1vvjMrSlYhG+rO50pEzXhxPY
	drD2zf5lOcjmtwtzDvYPOOH05UODaKQs6XWf+rOauqNVcMxWbs/CvhZL17jCXHg3EooMPF
	f3B/QAye2EvYzPwFVVhqppGxYUHD/Q8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-fXnnoXMvOW-qw3yiJ2EcVA-1; Thu, 03 Jul 2025 07:24:54 -0400
X-MC-Unique: fXnnoXMvOW-qw3yiJ2EcVA-1
X-Mimecast-MFC-AGG-ID: fXnnoXMvOW-qw3yiJ2EcVA_1751541893
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4532ff43376so49273645e9.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 04:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541893; x=1752146693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Ys+B0kKW0I1OmxDH3RChxDm9/AfOdFHpxEknTEX7s=;
        b=nNj4xqxFiI9xqDLIOeukx4qqr4GA2QT3NMN9U64geb6hY0Nove+vD35S8fBr/8QU8M
         8BFk5cjm/AXaAT8aV8fijnP0WBq+il9wB/HssFKhnWgEXJm+IpmOaXeSc/ULvEXe9861
         WLK31xSoDFZZHH4vfT+LpnbCsGA3lUU3AZb52L4Jl86K/LwxzaY6AeYV2AnU6po1qTUc
         hFQ+1YUfGhmbHQvariX6x2GdIwsuAupqRC41bt6G5fcOpKnuMcCEd3Yk7d6fR+wXclF+
         +2GHoAxNpGHV0tq60LJo/0oEeizz8CX3CgsnvUDwshc9Nya6ZoVGhZLV/DE1KxwFSxdj
         gN5A==
X-Forwarded-Encrypted: i=1; AJvYcCWotELFRLMkmdLzQ2e6Hk9Hlb+te7Gpyt4unmbZ3KPm3XL2QrPO+/4SI4EeV5SXK1LIHEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz624vv5IjWLOLxwTWgo0Cu/+zBm1dhTQ4RvPiOs0NOLBIgp2D5
	hcGC+5F/1Nxj+1xM31vkXZ39dT8jRGAz1KArgaVBn71nX6TfttMTlwk1QoNB5WaLi4YLDhjNOfc
	2CmNLRZBOTWxwyvgiRWvFhw2UMX7g3ICroZhkeSDX3PCIeiDxZJKRFg==
X-Gm-Gg: ASbGncugsPRe8QEZLnu2QfDYo9z0eGWt9MypHPTQKw0D8BgmdDITC0uYK0lEgo7ETC0
	fiZuQXgBMCH8gF+L7kkQt9mZedQWF7eIhbaaP/Z19wrUr4AHnTipOXtyfLuK6jd3MH080yEx+kD
	nR2cuBCuqsJ6RMufwf6D3db+Qa75Ve5zOIcOXfuSY3+2FnB/SlqLOra5tZFjyBxUl+//ULJ8FSx
	NMS7ryzz1/dNcACZHBLhrCvWLEfFDpd6uS86GGAzPdPmvwfFSkzgWrbgxIV/BcWoV+Z8uf5rZFC
	cUgklsozC+/Q5X21
X-Received: by 2002:a05:600c:3b9f:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454a4311ca9mr61059115e9.29.1751541892615;
        Thu, 03 Jul 2025 04:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ4owisLty2PWAU9CFlsOOvJcG4PRg4iHjZY5ASRNKjngFo9l8E2RNGlgQIxnBwYpnCVU+kw==
X-Received: by 2002:a05:600c:3b9f:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454a4311ca9mr61058815e9.29.1751541892171;
        Thu, 03 Jul 2025 04:24:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9978c83sm24183675e9.13.2025.07.03.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:24:51 -0700 (PDT)
Date: Thu, 3 Jul 2025 07:24:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] vsock: fix `vsock_proto` declaration
Message-ID: <20250703072443-mutt-send-email-mst@kernel.org>
References: <20250703112329.28365-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703112329.28365-1-sgarzare@redhat.com>

On Thu, Jul 03, 2025 at 01:23:29PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> >From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
> vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
> used by vsock_bpf.c.
> 
> If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
>     $ make O=build C=2 W=1 net/vmw_vsock/
>       ...
>       CC [M]  net/vmw_vsock/af_vsock.o
>       CHECK   ../net/vmw_vsock/af_vsock.c
>     ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?
> 
> Declare `vsock_proto` regardless of CONFIG_BPF_SYSCALL, since it's defined
> in af_vsock.c, which is built regardless of CONFIG_BPF_SYSCALL.
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/net/af_vsock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index d56e6e135158..d40e978126e3 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -243,8 +243,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags);
>  
> -#ifdef CONFIG_BPF_SYSCALL
>  extern struct proto vsock_proto;
> +#ifdef CONFIG_BPF_SYSCALL
>  int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
>  void __init vsock_bpf_build_proto(void);
>  #else
> -- 
> 2.50.0



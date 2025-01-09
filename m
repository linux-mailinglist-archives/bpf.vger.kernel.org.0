Return-Path: <bpf+bounces-48374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44163A070E5
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BC93A7B6E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4821507E;
	Thu,  9 Jan 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fajQ1RT2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31103215176
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413637; cv=none; b=O8MzwemgVpjOfmAsQhNkULzV+oaZlisrrA1sz1es+A976nOvNvbRHMIfs7frJDYRdZpRbINxkMG9NeKoH6HoacKQVE2CEb8DgPMHOwL+sNqaZgyXaUFAI88KEVlN02HUX/bKBFLc+N966PzUcREsdKFuuYl1CzDXcMtFCNd7s2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413637; c=relaxed/simple;
	bh=HsTQiavqafw6fsPYuIFsCx4ppw/0+dyJq2Ei9ZnXIns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mne6h66yskYrAqtZwK3ufEZ5ZX2h95xyd48J08KJWqgeSpysssv9svvAVj7/Xd6OK9+z6t2vrbk/pZ2oFvNaCyiqgL1v7Wi1qYf0jqQxYNtGiVNUWM4IQ/YTWdJeQ5WUGcxnY0I66LTcUC3unk6Vu9rTzz+eyOrTzsM7N4o8oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fajQ1RT2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736413634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPmn2NONYx2YB/n7h2bXDX/3a64ALTC7JSKNR4FIJZA=;
	b=fajQ1RT2jS9DNxH6KMRJykvO7FCdiwZpQkANAfL5FGdiLkWOJwFQDAsrYv5OXpI+cDX9C9
	+1vtvcOEqM6HfHuxlHmaf9sN9ezD8THteF4C2dLUTvHEPIFG4ebZXkD/1SOJcqzZKbzy3k
	1qnAznYBQ/7oXQdwN/ow5Ss3bEuBh6Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wvQjhJFWOqmaGhiIu9KKng-1; Thu, 09 Jan 2025 04:07:12 -0500
X-MC-Unique: wvQjhJFWOqmaGhiIu9KKng-1
X-Mimecast-MFC-AGG-ID: wvQjhJFWOqmaGhiIu9KKng
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa67f18cb95so68151066b.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 01:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413631; x=1737018431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPmn2NONYx2YB/n7h2bXDX/3a64ALTC7JSKNR4FIJZA=;
        b=kuuqLH95defCocbZJObYmbx79hu+DlvVkhead9xLaUZgCYV8FIrr/IAaC1f11NOcGt
         jZmNi3HmZH/zwgoNz54qkX1G+mcbEGs9w7KUhtM+q1N2eWO6kfggBXSMWCt2tKMmJInY
         NQf3mftnNAsm2npBTOgRRunV9UOJicrJCvGiP/dd9EgU5RCEXqZ3SgBR9tjXRgn9O8Jv
         WZoBwSqE6qSWivlQgEPPwyZR6HhsR5uiDfX6eOnGvZADo6PiLzRmIB+uUiLn4wrYHnzD
         o5GJHdNLJsCj1NQvpqWcHyCVihjJoTXcjLumCOLp3Sj/ghoCGje3zSN5GAzb99684vD3
         SinA==
X-Forwarded-Encrypted: i=1; AJvYcCXQAORr7p6HSDE1BG2bBuNHEzUiilHKp07ltSlk39TZiBVc1EgYLwRjmAVeriLmTmK5POM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiyHpLzXynH/Tpiqlut5u4gPe1X6THCShBYvgznbLxQ8FqjF8o
	kFURz24N6qjFJFALdyaBi1vp8rSks7wRALT7R8X+wU15FoaRLAzBzcNqSB2kNU17JdDNk0niwtM
	BDFut7GR0XA8K4ZgjJ8gXU2rNIjH9x1o/6CgYWvUvWN0pM++Cpg==
X-Gm-Gg: ASbGncsrVOx4FA91jqQKYpNXxr4PMj3jXjtGZE2FEJSDHwGGKH9VcttAlvP0HIXjP3/
	2MvrpR+KjcC7UKDFVPMwF29qoEKens2xWx+3yVBtQXmi0eJdspsMSHiukitnlTjGNmlIuruLzsn
	epJ9ckXVDAlbbXwXH2qrH4o0ouE1moiIrPyRlIVVWAFLbRPWX9khJNno0K51IFN0jc4L+5VNXbX
	12GZ27eS8elqcGOqTcbFElUeaXfLUf5VUxMRqsjQXFfhXDVym8=
X-Received: by 2002:a17:906:d555:b0:aa6:7b34:c1a8 with SMTP id a640c23a62f3a-ab2ab70a5a8mr454045466b.55.1736413631093;
        Thu, 09 Jan 2025 01:07:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOH7lCleOA3s9UpH750ljDgjJhUOcglbcfKRJdkkDK27qUK57limO+sZa7nGGHTPfbFQQXdg==
X-Received: by 2002:a17:906:d555:b0:aa6:7b34:c1a8 with SMTP id a640c23a62f3a-ab2ab70a5a8mr454042766b.55.1736413630614;
        Thu, 09 Jan 2025 01:07:10 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af65dsm49782566b.140.2025.01.09.01.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:07:09 -0800 (PST)
Date: Thu, 9 Jan 2025 04:07:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>, kvm@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/bpf: return early if transport is not
 assigned
Message-ID: <20250109040628-mutt-send-email-mst@kernel.org>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108180617.154053-3-sgarzare@redhat.com>

On Wed, Jan 08, 2025 at 07:06:17PM +0100, Stefano Garzarella wrote:
> Some of the core functions can only be called if the transport
> has been assigned.
> 
> As Michal reported, a socket might have the transport at NULL,
> for example after a failed connect(), causing the following trace:
> 
>     BUG: kernel NULL pointer dereference, address: 00000000000000a0
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
>     Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
>     RIP: 0010:vsock_connectible_has_data+0x1f/0x40
>     Call Trace:
>      vsock_bpf_recvmsg+0xca/0x5e0
>      sock_recvmsg+0xb9/0xc0
>      __sys_recvfrom+0xb3/0x130
>      __x64_sys_recvfrom+0x20/0x30
>      do_syscall_64+0x93/0x180
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> So we need to check the `vsk->transport` in vsock_bpf_recvmsg(),
> especially for connected sockets (stream/seqpacket) as we already
> do in __vsock_connectible_recvmsg().
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Closes: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  net/vmw_vsock/vsock_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 4aa6e74ec295..f201d9eca1df 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -77,6 +77,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  			     size_t len, int flags, int *addr_len)
>  {
>  	struct sk_psock *psock;
> +	struct vsock_sock *vsk;
>  	int copied;
>  
>  	psock = sk_psock_get(sk);
> @@ -84,6 +85,13 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  		return __vsock_recvmsg(sk, msg, len, flags);
>  
>  	lock_sock(sk);
> +	vsk = vsock_sk(sk);
> +
> +	if (!vsk->transport) {
> +		copied = -ENODEV;
> +		goto out;
> +	}
> +
>  	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
>  		release_sock(sk);
>  		sk_psock_put(sk, psock);
> @@ -108,6 +116,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	}
>  
> +out:
>  	release_sock(sk);
>  	sk_psock_put(sk, psock);
>  
> -- 
> 2.47.1



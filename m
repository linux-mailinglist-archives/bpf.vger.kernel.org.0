Return-Path: <bpf+bounces-48293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF64A0657C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F253A705F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230EF2036FB;
	Wed,  8 Jan 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="PVk4KKtF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39176201262
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365085; cv=none; b=rsvRIwJBwmLHhBqfam3MKC5LdNXeh4z9x26/cQ4KAd1tH9Ug97OHUObV6v18HWNzt/L8ihetD634ygxvJLCspHiikvxhS6JZkMA7ZJgy4bd1JUUU3FNK5DyWDeRotQXg9cObnrZYjCrJ8I8U4aawRGp/aFwSMa53u8bt+MiqCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365085; c=relaxed/simple;
	bh=TkDjLYrvFP4NOwyE1riU2Pn0PTqQ0huroqDV7gYV8F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpXqeUXjkCJJzdpajo3cnycauS3YTgkPgYIKt9q+ljo1aZnPwlfy2ZovJN2pKLA/dSvseAYK9JQMrNF+Py/zWek+omXtoj6vk9TxuIUb+QPo0SIYTks02L0CvJIe2X5DdPL9O6/bBeTx6tGDtYWBKMHnQ8tMWtolMNtwTZy3e5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=PVk4KKtF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so283937a91.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736365083; x=1736969883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0bUS8Q56VQu+k4FgEf+CVIurLS+XfSNtyOspvh+PYM=;
        b=PVk4KKtFXjAJ49RCv/OtLG2zDEr5KfQXCOxCLwGc8HyhEIUZkMr67CNMOglSmCGtAQ
         sAc1UsjQHGvWdVW8fsUDGNZ13sJTleYVvC02O7DwzlQHioNTpZc+ufH3i+rLMshYkZcb
         /gLhSqvEfEnUPi01knyG1MMNFfemY2V0S80/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736365083; x=1736969883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0bUS8Q56VQu+k4FgEf+CVIurLS+XfSNtyOspvh+PYM=;
        b=unmF9s0CHC3GbQmgW8k6hV7r5QLm06Z4c2rhtF3j33kyMF1xzjheSBLQQmyx9cBaTg
         S+BCBzaW+3Dzc+ZA9EI3HA/Pqn0fvNGwS6p6yDE8LrykX+klL0j9o6BCc8/vO2zLXwwi
         2RogrmKFwIs757PsOl/F+sehtapbeS1y7JbuEbmwS0ihmXsSxJOHC8lsu7vTej4TkQoa
         Jhmn7XOqLbBkqF0sg2OI649HT4B1pVjK+5WHlCS5PBRMqezE98WZEiYF1rWxO8pnW8vl
         dBFy8r6dWja0nPnWogkQCDLgYLgEVbU5/VdroeXps6QpwgUHkNV78Wc6+HkBm46gNral
         jjgA==
X-Forwarded-Encrypted: i=1; AJvYcCX/NSXU8SBdGy4JKNRKK7ac7fZH99uXPBtmNKATI+UuUDYojxwM80has+cW+zWNQ1T5zK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFYHe9TKCNK+ZlMQ3ICgYLh+vmCAtFnBd3sk4oHJGdI9cmOj+
	mB69H8Ka4aTtoLaHTT/fh4RWaOScMNcXbwsSRyhTMDdqDwTBrx6muxZtI+IOMIMRQywwsbQlBIM
	a
X-Gm-Gg: ASbGncuxViwhCjjrEMXAtKpOx1Je9UMOMU+8i+koVPUfnD+Llmu4YZN52Cx/AVjIKga
	M+AbxlSRQtJSPAKzGklLRkQ/+iVsF6Az0PaUJZ/IHmw7qmB2HiWNoYTwHAunhycPxdbN3w67vgL
	BpDY4d5blXDhMaY5bFS6eToIp3aW53wOd5JMaUGE0Q8RcCxtsaG2xGy3OT1W6nnkM3i5FtuGC/a
	6ft2oV74bYZi3/7BaAs5DRq8/9vW8+Xm+MgVktPFtSBg1o+zGiu5/6n67bLFBW24338hA==
X-Google-Smtp-Source: AGHT+IHl+1LPadgc/i7lkTvjE2CfNzpvljiLkJJSgQloH84BYhz9+osKoceYZDM+dwTOSZKMzh86qg==
X-Received: by 2002:a17:90b:3904:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2f548f64240mr5502673a91.19.1736365083357;
        Wed, 08 Jan 2025 11:38:03 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2872a3sm1963200a91.16.2025.01.08.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:38:03 -0800 (PST)
Date: Wed, 8 Jan 2025 14:37:55 -0500
From: Hyunwoo Kim <v4bel@theori.io>
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
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org, v4bel@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH net 2/2] vsock/bpf: return early if transport is not
 assigned
Message-ID: <Z37UE0Kv3iWobO/9@v4bel-B760M-AORUS-ELITE-AX>
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
> 

Looks good to me.

Reviewed-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim


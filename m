Return-Path: <bpf+bounces-48378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3857A07169
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB141885A7A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00F215787;
	Thu,  9 Jan 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPpnh0xd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92F2153F8
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414680; cv=none; b=nV2BrQkpsU9g6bPw1DZygFesY4Q6grn80OHa9b+l1V+60IM9ZbMfialfEk83h60N7kclP/bFd6qAdLV2cHhB3foX1lrssCR1hTW02vkk3e8uncY1zzGBg7qEKi2rhfhTzzT4Dww4tN87RKEi5IKfiIi88rHiHHQ5oQitnR2SLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414680; c=relaxed/simple;
	bh=jlK8j4aB/doijMgWbUxTmxGTZMXqwrbD1dH/0gqbpUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwZhbRe9394ZtkACdmRutojezMF0PWDq/gcUqNHo19qSDxtCkMaO0maESExyQMEFBIdj6vcsCkWLM5bipOz6KR64UR6MZx7PZiaKn8EvEGOy79tRn2lP08CtHgzZY4U7Ws6YC4nrTjyx+YNT86Lg6IfucEcyKUFNvN80Y45xC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPpnh0xd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736414676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQouyoUVw3UF/y4WVQgr7kFf7syR/XKsLwR+hpvWeXU=;
	b=DPpnh0xdQs/XiE+OQlteE6nPL5uVrY/A+YvnwpL6X09hslvSIryf3moZ5Gd4M4VwqlFcE7
	G5gaGA9R7VrOqqqOP7IWxfVy0bI/e4S/o6bif4M25JjrQ/8oGCB6OgiJQM4jbInAHzXxII
	m047D6CRzV1mfAS+omtDExR7SzIihQo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-UHFqv_kHME6lBSoKH0RgUQ-1; Thu, 09 Jan 2025 04:24:34 -0500
X-MC-Unique: UHFqv_kHME6lBSoKH0RgUQ-1
X-Mimecast-MFC-AGG-ID: UHFqv_kHME6lBSoKH0RgUQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43619b135bcso3481725e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 01:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736414673; x=1737019473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQouyoUVw3UF/y4WVQgr7kFf7syR/XKsLwR+hpvWeXU=;
        b=XQ4elvt1pzcUXyu1C2Byb44P42oO8lJT+DJYPrHxIbEMiLYPE5E/FIex6sSyDxqefE
         TZ0u7B8N0slRF1imyBD2TnxUdFJMOVGPgfB7CR58BCW/gj/Du3llFw7KGHCxrRlY/+8S
         E9pHKgM0jp+vdt/1WzF5PgF++VovpzPl9iucsT3pgjf3Jax3i5pi2g+pDhzvHBwHuQ1b
         Zv/ShBTh6BEAA35rwpDW9OSJI+jxFNHaxuvGTnSDYSRbyn80pGrzU5cg8hjprnOW7LPL
         8DBi2i4T3oYJpUx00uGBEkWf7pgef2QCGj3G7hwi02WQSHk7xfx/JP9lrGIiW/lYdqfa
         pDAw==
X-Forwarded-Encrypted: i=1; AJvYcCVV/6Crj46ImWXSIe7VtwYAnuk3mdCFpxcWtWLjqdPA2xQX/c3GiNNQg7KUQb/cGNNMGBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKNTUwCNKwVdnIgZcVH9OdsZqny8gIq8W6a5mrO+Lg1Nz9Ydu
	YCmxE1XM7ObYIxIbGzuKMElugGDC4oxudvr/oq4zTZTtpWt3QGroesJa1j7l4FesBzGrcFFDZPt
	TRqclWRJj1YjCsccksMoZZ7y7iCFdHrYgYaDqtOyuJ2zdOdXNww==
X-Gm-Gg: ASbGnctvaE6s32+uvnuFno2T23Qn2jgMjPXW+TtCcbljs+ajBmGcWRJuFBcDXgHyDms
	x1SSGZFZhfk2MZ56FOPGNZ9Lje2HOqgAyi9l5ee/6rYfkjSVpUCe2yamOJ6WzmCBDR8R293pDLK
	xfH9HfRdfXr5+UTaMg72r7ZOuO57IHG6NtiryJyJwj0t0DdDMV4XEGoyjdZPCvDva/BchcL0LWw
	rEcvlg4RW0wjdI80VZzbC5QLYEeFxcK/slX01PENSCZRBxPFsdmoi7ujhrc
X-Received: by 2002:a05:600c:8706:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-436e2677356mr48292095e9.3.1736414673534;
        Thu, 09 Jan 2025 01:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF9yOFWG608kMqPxd4403ULCrAWAOMeA3kgACaIOLpshtLvQXF4xTWy4dUUWcivL4hxRInjA==
X-Received: by 2002:a05:600c:8706:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-436e2677356mr48291885e9.3.1736414673125;
        Thu, 09 Jan 2025 01:24:33 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd013sm49297785e9.24.2025.01.09.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:24:32 -0800 (PST)
Date: Thu, 9 Jan 2025 10:24:30 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, Michal Luczaj <mhal@rbox.co>, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/bpf: return early if transport is not
 assigned
Message-ID: <sho5ird455tiirzbsgjug6owi2leknai4xu45ddnesynb632oz@owq5b56n3f6h>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250108180617.154053-3-sgarzare@redhat.com>

On Wed, Jan 08, 2025 at 07:06:17PM +0100, Stefano Garzarella wrote:
>Some of the core functions can only be called if the transport
>has been assigned.
>
>As Michal reported, a socket might have the transport at NULL,
>for example after a failed connect(), causing the following trace:
>
>    BUG: kernel NULL pointer dereference, address: 00000000000000a0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
>    Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
>    RIP: 0010:vsock_connectible_has_data+0x1f/0x40
>    Call Trace:
>     vsock_bpf_recvmsg+0xca/0x5e0
>     sock_recvmsg+0xb9/0xc0
>     __sys_recvfrom+0xb3/0x130
>     __x64_sys_recvfrom+0x20/0x30
>     do_syscall_64+0x93/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>So we need to check the `vsk->transport` in vsock_bpf_recvmsg(),
>especially for connected sockets (stream/seqpacket) as we already
>do in __vsock_connectible_recvmsg().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Reported-by: Michal Luczaj <mhal@rbox.co>
>Closes: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/vsock_bpf.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 4aa6e74ec295..f201d9eca1df 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -77,6 +77,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 			     size_t len, int flags, int *addr_len)
> {
> 	struct sk_psock *psock;
>+	struct vsock_sock *vsk;
> 	int copied;
>
> 	psock = sk_psock_get(sk);
>@@ -84,6 +85,13 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
> 	lock_sock(sk);
>+	vsk = vsock_sk(sk);
>+
>+	if (!vsk->transport) {
>+		copied = -ENODEV;
>+		goto out;
>+	}
>+
> 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
> 		release_sock(sk);
> 		sk_psock_put(sk, psock);
>@@ -108,6 +116,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> 	}
>
>+out:
> 	release_sock(sk);
> 	sk_psock_put(sk, psock);
>
>-- 
>2.47.1
>
LGTM!

Reviewed-By: Luigi Leonardi <leonardi@redhat.com>



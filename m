Return-Path: <bpf+bounces-48547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD8A08EA6
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91E13A9DBD
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639220B218;
	Fri, 10 Jan 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/4irTWI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5620B21D
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506597; cv=none; b=CWHsMP7CmvqKwYOwNPNfV1SjTFoo6kvPB4NlbnVTpuLMK+6lYlf966k1cS568czdg0rNDKDuYd85cp3j9aktQ/CEByyz4laq3EhMLq3q7Qgo8letcAi190Gvlk6X7tDvRko8B0z+2uNyIM9Hnhn96PLbtdqKUILCxCFxe95g1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506597; c=relaxed/simple;
	bh=VpaS8bAQyw3p7i5yPlKdG6wr5isGrSmLsdJlLMostJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4EpwyAQCGGjywaZN3zutJwgLWWi7rzd5BwuRNk6R62s5sgPw7oe0XGcfzE+lCZHY/k+WEN7ymUEctGn7IIfEZ7COjiYC15STVyQnPKtTLu2dj4zGSfgH+yPRXQSjZEt9B5h6qzw5DBrzhg9kwxR3FLGjKt8DdtYPl6bP6Xpdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/4irTWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736506594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wp2/Dl1jDgRS4MRZ7ZCAJJFdKOiZ0bWzlPWkS/TsPH8=;
	b=d/4irTWIVSPvAVByje1jQ7AfLj4XVcgCocZPZpCRKXcZTiqea2K9CadMryRTaxgYrZ+iX9
	1/kYjiHwwjPrc0vWD6V9jY2JKMFwiLPWn2PpKeptbj4pTxRZBt0s+OS/Z7zuUyuCg9tmSO
	9cuhr+3hV/lkV05WFTG9CnnDv9ZDxng=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-SWIcxnhuMDiQew3qQf9GQg-1; Fri, 10 Jan 2025 05:56:33 -0500
X-MC-Unique: SWIcxnhuMDiQew3qQf9GQg-1
X-Mimecast-MFC-AGG-ID: SWIcxnhuMDiQew3qQf9GQg
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3f0411814so1758133a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 02:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506592; x=1737111392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp2/Dl1jDgRS4MRZ7ZCAJJFdKOiZ0bWzlPWkS/TsPH8=;
        b=OVfWW2keqGb3exybjZ/eJ+c3WXJjWcGOukpvlLsVUEfJR5LT4EAVmhOziN98apfVdk
         HgmkUtZzk8TcYLK3j0hQEdwKokjuxDsCoLz0flnjqDzX35PlTfvfmYeFqJXLlaN2x5gG
         c7bjtEWOgh1wOS1qR1P+A3e0tH+wfc8D6kBWbyCEefx3eheMD2Ks7R2VVXVgJJkEOp5b
         bHqaFCNezSBGVXNyc966j6iPmoWVHGygaIYzqRfXec5TpFzHBvSp/UkQ8byohngpE8CZ
         vzGzCiwNnDNBPirGGrTw0FDzr08sGRJ2M/G3qngrPgSXy8tnONQKwl1YRqBQcwDAJSgk
         Ncow==
X-Forwarded-Encrypted: i=1; AJvYcCVrCOWEYiNATgE+FI4cQZywKX3Xup54HP4HdJVJP9f8GFFHXxgY77s25vjeYHUP/Q+Qhr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+oovMYffKtfY9YqbUoT+QntUBON2W4uGb4YofxYQTpTJn5oS
	UbOBaaGc+jkcfmA1Aa1+SL+dzXtRR0K2XDQ7FK6/DpmBpGd8IPxBhZF5J2v+3izABNF4j8AorN0
	7jef3rxO6RR8y6aKumu215DkjSgeyI6RvmqakWuUkDMVyySNQww==
X-Gm-Gg: ASbGnctuqXOVOglxeXMzm6x2lzwZWzJqeOob/Uj0+hlyn1dSTq6qY748Vh0LdDqfkl1
	ESuRJfNRYFahXZY5fA55VJYInL6WmZDjOmJUiwUDkyArhyy8pBq/zt5COxrFdVif9xiWJeJbLnQ
	4x5aamu2J/+862Jic4HD+J6T1BIZI+CaMO9711BnJvCaQji1rGRBLp2/MIyZLm/UO7b9g5XNk7k
	J7J14ZERz2kJQc4pc6KXDrdTk3UIfDzn7KP++Z6KR8orhRlwaILnmkN7uh+
X-Received: by 2002:a17:906:c153:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab2ab6a64fcmr802391466b.14.1736506591801;
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3RAnhLiLE0Ufj7mjhyCOMtKbT/PK9cbWY0n89eBu/2UqooguiKKCOcaocF+kmmlz9Ef1oVA==
X-Received: by 2002:a17:906:c153:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab2ab6a64fcmr802388666b.14.1736506591351;
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm156141666b.93.2025.01.10.02.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
Date: Fri, 10 Jan 2025 11:56:28 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 4/5] vsock: reset socket state when de-assigning
 the transport
Message-ID: <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-5-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:10AM +0100, Stefano Garzarella wrote:
>Transport's release() and destruct() are called when de-assigning the
>vsock transport. These callbacks can touch some socket state like
>sock flags, sk_state, and peer_shutdown.
>
>Since we are reassigning the socket to a new transport during
>vsock_connect(), let's reset these fields to have a clean state with
>the new transport.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5cf8109f672a..74d35a871644 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		 */
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
>+
>+		/* transport's release() and destruct() can touch some socket
>+		 * state, since we are reassigning the socket to a new transport
>+		 * during vsock_connect(), let's reset these fields to have a
>+		 * clean state.
>+		 */
>+		sock_reset_flag(sk, SOCK_DONE);
>+		sk->sk_state = TCP_CLOSE;
>+		vsk->peer_shutdown = 0;
> 	}
>
> 	/* We increase the module refcnt to prevent the transport unloading
>-- 
>2.47.1
>

Hi Stefano,
I spent some time investigating what would happen if the scheduled work
ran before `virtio_transport_cancel_close_work`. IIUC that should do no 
harm and all the fields are reset correctly.

Thank you,
Luigi

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


